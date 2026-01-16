---
description: 蓄積した知識を定期的にレビュー・整理
---

# /reflect-skill:review

蓄積した知識を対話形式でレビューし、整理・最適化する。

## 用途

- 定期的な知識の棚卸し
- 不要な知識の削除
- 信頼度の再評価
- 重複の統合

## 実行フロー

### Step 1: 知識の分析
```
📊 知識ベース分析結果

総知識数: 25件
├── high/: 5件 (120行)
├── medium/: 15件 (450行)
└── low/: 5件 (80行)

⚠️ 要確認項目
├── 長期未使用 (90日+): 3件
├── 矛盾の可能性: 1件
└── 重複の可能性: 2件
```

### Step 2: 項目別レビュー

#### 長期未使用の知識
```
🕐 90日以上未使用

[1] medium/old-api.md
    最終使用: 2023-10-15
    内容: 旧API呼び出し規約
    → (K)eep / (A)rchive / (D)elete?

[2] low/legacy-patterns.md
    最終使用: 2023-09-01
    内容: レガシーパターン集
    → (K)eep / (A)rchive / (D)elete?
```

#### 矛盾する知識
```
⚡ 矛盾の検出

[1] エラー処理
    high/main.md: "Result型を使う"
    medium/api.md: "try-catchを使う"
    → (1)を優先 / (2)を優先 / (M)erge / (S)kip?
```

#### 重複する知識
```
📋 重複の検出

[1] 命名規則
    high/main.md: "camelCase使用"
    medium/naming.md: "camelCaseを徹底"
    → (M)erge into high / (D)elete medium / (S)kip?
```

### Step 3: 信頼度の再評価
```
📈 信頼度の昇格候補

[1] medium/button-style.md
    理由: 5回以上参照、修正なし
    → High に昇格? (Y/N)

📉 信頼度の降格候補

[1] high/old-rule.md
    理由: 30日以上未使用
    → Medium に降格? (Y/N)
```

### Step 4: 適用
1. 選択した変更を適用
2. `_index.md` を更新
3. `config.json` の統計を更新
4. Git commit

## オプション

| オプション | 説明 |
|-----------|------|
| `--auto` | 推奨アクションを自動適用 |
| `--stale-only` | 古い知識のみレビュー |
| `--conflicts-only` | 競合のみレビュー |
| `--dry-run` | 変更をプレビューのみ |

## 推奨頻度

- **週次**: アクティブなプロジェクト
- **月次**: 安定したプロジェクト
- **随時**: 大きな変更後

## 自動レビュー設定

`config.json` に追加:

```json
{
  "review": {
    "autoRemind": true,
    "remindAfterDays": 30
  }
}
```
