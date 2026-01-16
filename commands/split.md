---
description: 200行を超えた知識ファイルをカテゴリごとに分割
---

# /reflect-skill:split

## 使用例
```
/reflect-skill:split high
```

## 処理
1. main.md の見出し（##）を分析
2. 分割案を提案
3. 承認後、カテゴリごとにファイル作成
4. _index.md を更新（キーワードマッピング）

## 分割後の構造
```
.reflect/knowledge/high/
├── _index.md     # キーワード → ファイル
├── ui.md
├── naming.md
└── api.md
```
