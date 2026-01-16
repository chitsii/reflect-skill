#!/bin/bash
# reflect-skill Stop Hook
# セッション終了時に自動リフレクションをトリガー

REFLECT_DIR=".reflect"
CONFIG_FILE="$REFLECT_DIR/config.json"

# .reflect が存在しない場合は何もしない
if [ ! -d "$REFLECT_DIR" ]; then
  exit 0
fi

# config.json を読み込み、autoReflect を確認
if [ -f "$CONFIG_FILE" ]; then
  AUTO_REFLECT=$(grep -o '"autoReflect":\s*true' "$CONFIG_FILE")

  if [ -n "$AUTO_REFLECT" ]; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🔄 [reflect-skill] 自動リフレクション"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "セッションを分析し、ユーザーによる「修正」を検出してください。"
    echo ""
    echo "知識の定義: ユーザーがClaudeの出力を修正した内容"
    echo "- ✅ 「〜に変えて」「〜しないで」「〜を使って」"
    echo "- ❌ 「OK」「いいね」（単なる承認は知識ではない）"
    echo ""
    echo "検出した修正を .reflect/knowledge/ に記録してください。"
    echo "記録後: node scripts/update-meta.js --config && git add .reflect && git commit -m 'reflect: update knowledge' && git push"
    echo ""
  fi
fi
