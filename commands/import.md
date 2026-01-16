---
description: 知識をインポート（別プロジェクトからの移植）
---

# /reflect-skill:import

エクスポートされた知識ファイルを現在のプロジェクトに取り込む。

## 使い方

### 基本（マージモード）
```
/reflect-skill:import ./reflect-knowledge-export.zip
```

### プレビューのみ
```
/reflect-skill:import ./export.zip --preview
```

### 上書きモード
```
/reflect-skill:import ./export.zip --overwrite
```

## 実行内容

1. ZIPファイルを展開
2. `manifest.json` を検証
3. 既存知識との競合をチェック
4. ユーザー確認
5. 知識ファイルをマージ/上書き
6. `_index.md` を更新

## マージ戦略

| 戦略 | 説明 | オプション |
|------|------|-----------|
| **merge** | 既存と新規をマージ、競合時は確認 | デフォルト |
| **overwrite** | 新規で完全上書き | `--overwrite` |
| **skip** | 競合をスキップ | `--skip-conflicts` |

## 競合時の動作

```
⚠️ 競合検出

[1] high/main.md
    既存: Button → shadcn
    新規: Button → MUI
    → (M)erge / (O)verwrite / (S)kip?

[2] medium/api.md
    既存: なし
    新規: REST API規約
    → 自動追加
```

## オプション

| オプション | 説明 |
|-----------|------|
| `--preview` | 変更をプレビューのみ（実行しない） |
| `--overwrite` | 全て上書き |
| `--skip-conflicts` | 競合をスキップ |
| `--high-only` | high/ のみインポート |

## 注意

- インポート前に現在の知識をバックアップ推奨
- `--preview` で事前確認推奨
