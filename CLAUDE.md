# Reflect Skill Plugin

セッション間で学習を持続させる自己改善スキルシステム。

## クイックスタート

1. `/reflect-skill:init` でプロジェクトを初期化
2. 作業中に修正・指示があったら `/reflect-skill:reflect` を実行
3. 提案された学習内容を確認し承認
4. 次回セッションから自動適用

## 知識ベース

`.reflect/knowledge/` を活用。詳細は `/reflect-skill:status` 参照。

- `high/`: 常に読む知識
- `medium/`: 関連時に検索して読む
- `low/`: アーカイブ

## コマンド

| コマンド | 説明 |
|----------|------|
| `/reflect-skill:init` | プロジェクト初期化 |
| `/reflect-skill:reflect` | セッションから学習を抽出（重複検出あり） |
| `/reflect-skill:status` | 状態・使用状況・鮮度アラートを表示 |
| `/reflect-skill:review` | 知識を定期レビュー・整理 |
| `/reflect-skill:export` | 知識をエクスポート |
| `/reflect-skill:import` | 知識をインポート |
| `/reflect-skill:on` | リマインダーを有効化 |
| `/reflect-skill:off` | リマインダーを無効化 |
| `/reflect-skill:split` | 200行超えファイルを分割 |
