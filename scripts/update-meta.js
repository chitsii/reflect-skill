#!/usr/bin/env node
/**
 * reflect-skill メタデータ更新ツール
 *
 * 使用方法:
 *   node scripts/update-meta.js --config          # config.json の lastReflect を更新
 *   node scripts/update-meta.js --touch <file>    # ファイルの lastUsed を更新
 *   node scripts/update-meta.js --increment <file> # ファイルの usageCount をインクリメント
 *   node scripts/update-meta.js --stats           # stats.knowledgeCount を再計算
 */

const fs = require('fs');
const path = require('path');

const REFLECT_DIR = '.reflect';
const CONFIG_FILE = path.join(REFLECT_DIR, 'config.json');
const KNOWLEDGE_DIR = path.join(REFLECT_DIR, 'knowledge');

function getToday() {
  return new Date().toISOString().split('T')[0];
}

function getNow() {
  return new Date().toISOString();
}

// config.json を読み込み
function loadConfig() {
  if (!fs.existsSync(CONFIG_FILE)) {
    console.error('Error: .reflect/config.json not found. Run /reflect-skill:init first.');
    process.exit(1);
  }
  return JSON.parse(fs.readFileSync(CONFIG_FILE, 'utf8'));
}

// config.json を保存
function saveConfig(config) {
  fs.writeFileSync(CONFIG_FILE, JSON.stringify(config, null, 2) + '\n');
}

// mdファイルのメタデータを更新
function updateMdMeta(filePath, updates) {
  if (!fs.existsSync(filePath)) {
    console.error(`Error: File not found: ${filePath}`);
    process.exit(1);
  }

  let content = fs.readFileSync(filePath, 'utf8');
  const metaRegex = /<!--\s*(updated:\s*[\d-]+)\s*\|\s*(lastUsed:\s*[\d-]+)\s*\|\s*(usageCount:\s*\d+)\s*-->/;

  const match = content.match(metaRegex);
  if (!match) {
    console.error(`Error: No metadata found in ${filePath}`);
    process.exit(1);
  }

  let updated = match[1].split(':')[1].trim();
  let lastUsed = match[2].split(':')[1].trim();
  let usageCount = parseInt(match[3].split(':')[1].trim());

  if (updates.updated) updated = updates.updated;
  if (updates.lastUsed) lastUsed = updates.lastUsed;
  if (updates.incrementUsage) usageCount += 1;
  if (updates.usageCount !== undefined) usageCount = updates.usageCount;

  const newMeta = `<!-- updated: ${updated} | lastUsed: ${lastUsed} | usageCount: ${usageCount} -->`;
  content = content.replace(metaRegex, newMeta);

  fs.writeFileSync(filePath, content);
  console.log(`Updated: ${filePath}`);
  console.log(`  updated: ${updated}, lastUsed: ${lastUsed}, usageCount: ${usageCount}`);
}

// knowledge ディレクトリ内のファイル数をカウント
function countKnowledge() {
  const counts = { high: 0, medium: 0, low: 0 };

  for (const priority of ['high', 'medium', 'low']) {
    const dir = path.join(KNOWLEDGE_DIR, priority);
    if (fs.existsSync(dir)) {
      const files = fs.readdirSync(dir).filter(f =>
        f.endsWith('.md') && !f.startsWith('_')
      );
      counts[priority] = files.length;
    }
  }

  return counts;
}

// メイン処理
function main() {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    console.log('Usage:');
    console.log('  node scripts/update-meta.js --config');
    console.log('  node scripts/update-meta.js --touch <file>');
    console.log('  node scripts/update-meta.js --increment <file>');
    console.log('  node scripts/update-meta.js --stats');
    process.exit(0);
  }

  const command = args[0];

  switch (command) {
    case '--config': {
      const config = loadConfig();
      config.lastReflect = getNow();
      config.stats.totalReflections += 1;
      saveConfig(config);
      console.log('Updated config.json:');
      console.log(`  lastReflect: ${config.lastReflect}`);
      console.log(`  totalReflections: ${config.stats.totalReflections}`);
      break;
    }

    case '--touch': {
      const filePath = args[1];
      if (!filePath) {
        console.error('Error: File path required');
        process.exit(1);
      }
      updateMdMeta(filePath, { lastUsed: getToday() });
      break;
    }

    case '--increment': {
      const filePath = args[1];
      if (!filePath) {
        console.error('Error: File path required');
        process.exit(1);
      }
      updateMdMeta(filePath, { lastUsed: getToday(), incrementUsage: true });
      break;
    }

    case '--stats': {
      const config = loadConfig();
      config.stats.knowledgeCount = countKnowledge();
      saveConfig(config);
      console.log('Updated stats:');
      console.log(`  high: ${config.stats.knowledgeCount.high}`);
      console.log(`  medium: ${config.stats.knowledgeCount.medium}`);
      console.log(`  low: ${config.stats.knowledgeCount.low}`);
      break;
    }

    default:
      console.error(`Unknown command: ${command}`);
      process.exit(1);
  }
}

main();
