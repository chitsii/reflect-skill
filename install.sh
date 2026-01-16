#!/bin/bash
# install.sh - Reflect Skill インストーラー
# 使用方法: curl -fsSL [URL]/install.sh | bash

set -e

echo "🔄 Reflect Skill をインストールしています..."

# ディレクトリ作成
# コマンドは .claude/commands/ （Claude Codeが認識）
# 知識・設定は .reflect/ （独自管理、セッションファイルと混在しない）
mkdir -p .claude/commands
mkdir -p .reflect/knowledge/high
mkdir -p .reflect/knowledge/medium
mkdir -p .reflect/knowledge/low
mkdir -p .reflect/scripts

# =============================================================================
# コマンドファイル（.claude/commands/）
# =============================================================================

cat > .claude/commands/reflect.md << 'EOF'
# /reflect - セッションから学習を抽出

## 概要
セッションを分析し、修正パターン・成功パターンを `.reflect/knowledge/` に記録。

## 実行手順

### Step 1: セッション分析
会話履歴をスキャンし、シグナルを検出:

**High:** 「必ず」「絶対に」「常に」などの明示的指示
**Medium:** 修正後に承認されたパターン
**Low:** 傾向・好みの観察

### Step 2: 更新提案
検出シグナルを元に、更新内容を提案。

### Step 3: ユーザー確認
- Y: 適用
- 自然言語: 修正指示
- N: キャンセル

### Step 4: 適用
1. `.reflect/knowledge/` 内のファイルを更新
2. _index.md を更新（medium/low）
3. Git commit & push（リモートがあれば）

## 知識ファイルの場所
- `.reflect/knowledge/high/` - 常に読む
- `.reflect/knowledge/medium/` - 関連時に検索
- `.reflect/knowledge/low/` - アーカイブ
EOF

cat > .claude/commands/reflect-on.md << 'EOF'
# /reflect-on - 自動リフレクションを有効化

`.reflect/config.json` の `autoReflect` を `true` に設定。
セッション終了時に自動で /reflect 相当の処理を実行。
EOF

cat > .claude/commands/reflect-off.md << 'EOF'
# /reflect-off - 自動リフレクションを無効化

`.reflect/config.json` の `autoReflect` を `false` に設定。
手動 /reflect のみ有効。
EOF

cat > .claude/commands/reflect-status.md << 'EOF'
# /reflect-status - 状態表示

## 表示内容
1. 設定状態（autoReflect: ON/OFF）
2. 知識ファイル概要（ファイル数、行数）

## 知識ファイルの場所
`.reflect/knowledge/`
- high/: 常に読む
- medium/: _index.md でキーワード検索
- low/: 明示的要求時のみ
EOF

cat > .claude/commands/reflect-split.md << 'EOF'
# /reflect-split - 知識ファイルを分割

200行を超えた知識ファイルをカテゴリごとに分割。

## 使用例
```
/reflect-split high
```

## 処理
1. main.md の見出し（##）を分析
2. 分割案を提案
3. 承認後、カテゴリごとにファイル作成
4. _index.md を更新
EOF

# =============================================================================
# 知識ファイル（.reflect/knowledge/）
# =============================================================================

cat > .reflect/knowledge/high/main.md << 'EOF'
# High Priority Knowledge
<!-- updated: $(date +%Y-%m-%d) -->

<!-- 常に読む知識をここに記載 -->
<!-- 200行を超えたら /reflect-split で分割 -->
EOF

cat > .reflect/knowledge/medium/_index.md << 'EOF'
# Index
<!-- キーワード → ファイル のマッピング -->
<!-- 例: Button, shadcn → ui.md -->
EOF

cat > .reflect/knowledge/medium/main.md << 'EOF'
# Medium Priority Knowledge
<!-- 関連時に参照する知識 -->
EOF

cat > .reflect/knowledge/low/_index.md << 'EOF'
# Index
<!-- キーワード → ファイル -->
EOF

cat > .reflect/knowledge/low/main.md << 'EOF'
# Low Priority Knowledge
<!-- アーカイブ -->
EOF

# =============================================================================
# 設定ファイル（.reflect/）
# =============================================================================

cat > .reflect/config.json << 'EOF'
{
  "autoReflect": false,
  "lastReflect": null,
  "version": "1.0.0"
}
EOF

# =============================================================================
# 完了メッセージ
# =============================================================================

echo "✅ インストール完了！"
echo ""
echo "ファイル構成:"
echo "  .claude/commands/  - スラッシュコマンド"
echo "  .reflect/          - 知識・設定（セッションファイルと分離）"
echo ""
echo "使い方:"
echo "  /reflect        - セッションから学習を抽出"
echo "  /reflect-status - 状態を確認"
echo ""
echo "CLAUDE.md に以下を追加してください:"
echo '  知識ベース: `.reflect/knowledge/` を活用。詳細は `/reflect-status` 参照。'
