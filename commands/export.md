---
description: 知識をエクスポート（別プロジェクトへの移植用）
---

# /reflect-skill:export

知識ファイルをエクスポートして、別プロジェクトで再利用可能にする。

## 使い方

### 全知識をエクスポート
```
/reflect-skill:export
```

### 特定階層のみ
```
/reflect-skill:export high
/reflect-skill:export medium
```

### 出力先を指定
```
/reflect-skill:export --output ./my-knowledge.zip
```

## 実行内容

1. `.reflect/knowledge/` 内のファイルを収集
2. メタデータを含む `manifest.json` を生成
3. ZIP形式でアーカイブ

## 出力形式

```
reflect-knowledge-export-YYYYMMDD.zip
├── manifest.json
│   {
│     "exportedAt": "2024-01-20T12:00:00Z",
│     "sourceProject": "my-project",
│     "version": "1.1.0",
│     "files": [...]
│   }
├── high/
│   └── main.md
├── medium/
│   ├── _index.md
│   └── main.md
└── low/
    ├── _index.md
    └── main.md
```

## オプション

| オプション | 説明 |
|-----------|------|
| `--output <path>` | 出力先パスを指定 |
| `--no-low` | low/ を除外 |
| `--high-only` | high/ のみ |

## 注意

- 個人的な好みが含まれる場合、チーム共有時は確認推奨
- パスワード等の機密情報が含まれていないか確認
