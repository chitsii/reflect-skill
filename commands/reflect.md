---
description: セッションから学習を抽出して知識ファイルに記録
---

# /reflect-skill:reflect

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

## 注意
- 設計判断は書かない（→ DESIGN.md）
- 不変のルールは書かない（→ CLAUDE.md）
- 200行以内を維持
