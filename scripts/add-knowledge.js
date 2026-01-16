#!/usr/bin/env node
/**
 * reflect-skill 知識追加ツール
 *
 * 使用方法:
 *   node scripts/add-knowledge.js --priority high --title "タイトル" --content "内容"
 *   node scripts/add-knowledge.js -p medium -t "タイトル" -c "内容"
 *   echo "内容" | node scripts/add-knowledge.js -p high -t "タイトル" --stdin
 */

const fs = require('fs');
const path = require('path');

const REFLECT_DIR = '.reflect';
const CONFIG_FILE = path.join(REFLECT_DIR, 'config.json');
const KNOWLEDGE_DIR = path.join(REFLECT_DIR, 'knowledge');

function getToday() {
  return new Date().toISOString().split('T')[0];
}

function loadConfig() {
  if (!fs.existsSync(CONFIG_FILE)) {
    console.error('Error: .reflect/config.json not found. Run /reflect-skill:init first.');
    process.exit(1);
  }
  return JSON.parse(fs.readFileSync(CONFIG_FILE, 'utf8'));
}

function saveConfig(config) {
  fs.writeFileSync(CONFIG_FILE, JSON.stringify(config, null, 2) + '\n');
}

function parseArgs(args) {
  const result = { priority: 'medium', title: '', content: '', stdin: false };

  for (let i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '-p':
      case '--priority':
        result.priority = args[++i];
        break;
      case '-t':
      case '--title':
        result.title = args[++i];
        break;
      case '-c':
      case '--content':
        result.content = args[++i];
        break;
      case '--stdin':
        result.stdin = true;
        break;
    }
  }

  return result;
}

function addKnowledge(priority, title, content) {
  const validPriorities = ['high', 'medium', 'low'];
  if (!validPriorities.includes(priority)) {
    console.error(`Error: Invalid priority. Must be one of: ${validPriorities.join(', ')}`);
    process.exit(1);
  }

  const filePath = path.join(KNOWLEDGE_DIR, priority, 'main.md');

  if (!fs.existsSync(filePath)) {
    console.error(`Error: File not found: ${filePath}`);
    process.exit(1);
  }

  let fileContent = fs.readFileSync(filePath, 'utf8');

  // メタデータを更新
  const metaRegex = /<!--\s*(updated:\s*[\d-]+)\s*\|\s*(lastUsed:\s*[\d-]+)\s*\|\s*(usageCount:\s*\d+)\s*-->/;
  const today = getToday();

  fileContent = fileContent.replace(metaRegex, (match, updated, lastUsed, usageCount) => {
    const count = parseInt(usageCount.split(':')[1].trim());
    return `<!-- updated: ${today} | lastUsed: ${today} | usageCount: ${count} -->`;
  });

  // 知識を追加
  const newSection = `\n## ${title}\n\n${content}\n`;
  fileContent = fileContent.trimEnd() + newSection;

  fs.writeFileSync(filePath, fileContent);

  // config.json の stats を更新
  const config = loadConfig();
  config.stats.knowledgeCount[priority] = (config.stats.knowledgeCount[priority] || 0) + 1;
  saveConfig(config);

  console.log(`Added knowledge to ${priority}/main.md:`);
  console.log(`  Title: ${title}`);
  console.log(`  Stats updated: ${priority} = ${config.stats.knowledgeCount[priority]}`);
}

async function main() {
  const args = process.argv.slice(2);

  if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
    console.log('Usage:');
    console.log('  node scripts/add-knowledge.js -p <priority> -t <title> -c <content>');
    console.log('  echo "content" | node scripts/add-knowledge.js -p <priority> -t <title> --stdin');
    console.log('');
    console.log('Options:');
    console.log('  -p, --priority  Priority level: high, medium, low (default: medium)');
    console.log('  -t, --title     Section title');
    console.log('  -c, --content   Knowledge content');
    console.log('  --stdin         Read content from stdin');
    process.exit(0);
  }

  const opts = parseArgs(args);

  if (!opts.title) {
    console.error('Error: Title required (-t or --title)');
    process.exit(1);
  }

  let content = opts.content;

  if (opts.stdin) {
    const chunks = [];
    for await (const chunk of process.stdin) {
      chunks.push(chunk);
    }
    content = Buffer.concat(chunks).toString('utf8').trim();
  }

  if (!content) {
    console.error('Error: Content required (-c, --content, or --stdin)');
    process.exit(1);
  }

  addKnowledge(opts.priority, opts.title, content);
}

main();
