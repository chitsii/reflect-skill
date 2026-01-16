---
description: リフレクション状態と知識ファイル概要を表示
---

# /reflect-skill:status

## 表示内容

### 1. 設定状態
```
🔧 設定
├── autoReflect: ON/OFF
├── 最終リフレクション: YYYY-MM-DD HH:MM
└── 総リフレクション回数: N回
```

### 2. 知識ファイル概要
```
📚 知識ベース (.reflect/knowledge/)
├── high/     [N files, M lines] ← 常に読む
├── medium/   [N files, M lines] ← 検索時
└── low/      [N files, M lines] ← アーカイブ
```

### 3. 今セッションで使われた知識
```
✅ 使用された知識
├── high/main.md (全体)
└── medium/api.md (API関連タスクで参照)

❌ 未使用の知識
└── medium/logging.md
```

### 4. 鮮度アラート
```
⚠️ 鮮度アラート
├── 30日以上未使用: medium/old-patterns.md
└── 90日以上未使用: low/legacy.md → アーカイブ推奨
```

### 5. 統計
```
📊 統計
├── 総知識数: N件 (High: X, Medium: Y, Low: Z)
├── 今月の追加: N件
├── 最も参照された知識: high/main.md (XX回)
└── 未参照の知識: N件
```

## 知識の読み方
- `high/`: セッション開始時に全読み
- `medium/`: `_index.md` でキーワード検索
- `low/`: 明示的要求時のみ

## 実行時の動作
1. `.reflect/config.json` を読み込み
2. 各知識ファイルのメタデータを解析
3. 鮮度チェック（lastUsed vs 現在日時）
4. 統計情報を集計
5. レポートを表示

## オプション
- `--verbose`: 全知識ファイルの詳細を表示
- `--stale`: 古い知識のみ表示
- `--unused`: 未使用の知識のみ表示
