---
description: Reflect Skill を現在のプロジェクトに初期化
---

# /reflect-skill:init

プロジェクトに `.reflect/` ディレクトリを作成し、知識ファイルを初期化する。

## 実行内容

1. `.reflect/knowledge/high/main.md` を作成
2. `.reflect/knowledge/medium/_index.md`, `main.md` を作成
3. `.reflect/knowledge/low/_index.md`, `main.md` を作成
4. `.reflect/config.json` を作成
5. `.gitignore` に `.reflect/` を追加（存在しない場合は作成）
6. CLAUDE.md に知識ベース参照を追記（任意）

## 作成されるファイル

```
.reflect/
├── knowledge/
│   ├── high/main.md      # 常に読む知識
│   ├── medium/
│   │   ├── _index.md     # キーワード検索用
│   │   └── main.md
│   └── low/
│       ├── _index.md
│       └── main.md
└── config.json           # 設定
```

## 初期化後

### .gitignore への追加（自動）
```
# Reflect Skill - Personal knowledge (not shared)
.reflect/
```

### CLAUDE.md への追加（任意）
```
知識ベース: `.reflect/knowledge/` を活用。詳細は `/reflect-skill:status` 参照。
```
