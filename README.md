# Reflect Skill - Self-Improving Skills for Claude Code

Claude Codeでセッション間の学習を持続させる自己改善スキルシステム。

## 問題

LLMはセッションごとに記憶がリセットされる。同じ修正を何度も繰り返す必要がある。

## 解決策

セッション中の修正・指示を知識ファイルに記録し、次回セッションから自動適用。

## インストール

> **要件**: Claude Code 1.0.33以降が必要です（`claude --version` で確認）

### ローカルからインストール

```bash
# リポジトリをクローン
git clone https://github.com/chitsii/reflect-skill.git

# セッション起動時にプラグインディレクトリを指定
claude --plugin-dir /path/to/reflect-skill
```

### GitHubからインストール（公開後）

リポジトリがGitHubに公開されている場合:

```bash
# 1. マーケットプレイスとして追加
/plugin marketplace add chitsii/reflect-skill

# 2. プラグインをインストール
/plugin install reflect-skill@chitsii-reflect-skill
```

### プロジェクト設定での自動有効化（公開後）

`.claude/settings.json` に追加すると、プロジェクトで自動的に有効化されます:

```json
{
  "extraKnownMarketplaces": [
    "chitsii/reflect-skill"
  ],
  "enabledPlugins": {
    "reflect-skill@chitsii-reflect-skill": true
  }
}
```

### プロジェクトの初期化

インストール後、プロジェクトで初期化:
```
/reflect-skill:init
```

## コマンド

| コマンド | 説明 |
|----------|------|
| `/reflect-skill:init` | プロジェクトに知識ファイルを初期化 |
| `/reflect-skill:reflect` | セッションから学習を抽出 |
| `/reflect-skill:search` | タスクに関連する知識を検索（Task tool経由） |
| `/reflect-skill:status` | 状態を表示（使用状況・鮮度アラート含む） |
| `/reflect-skill:review` | 蓄積した知識を定期レビュー・整理 |
| `/reflect-skill:export` | 知識をエクスポート（別プロジェクトへ移植） |
| `/reflect-skill:import` | 知識をインポート（別プロジェクトから） |
| `/reflect-skill:on` | 自動リフレクション有効化 |
| `/reflect-skill:off` | 自動リフレクション無効化 |
| `/reflect-skill:split` | 200行超えファイルを分割 |

## ファイル構造

### プラグイン（このリポジトリ）
```
reflect-skill/
├── .claude-plugin/
│   └── plugin.json       # プラグインマニフェスト
├── commands/             # スラッシュコマンド
├── templates/            # 知識ファイルテンプレート
└── docs/                 # 設計ドキュメント
```

### 初期化後のプロジェクト
```
target-project/
└── .reflect/             # 知識・設定（個人用、.gitignore推奨）
    ├── knowledge/
    │   ├── high/         # 常に読む知識
    │   ├── medium/       # 関連時に検索
    │   └── low/          # アーカイブ
    └── config.json
```

## チーム運用

- `.reflect/` は `.gitignore` に追加（個人用）
- チームルールに昇格する場合は CLAUDE.md に追記
- 詳細: [docs/TEAM.md](docs/TEAM.md)

## ドキュメント

- [docs/DESIGN.md](docs/DESIGN.md) - 詳細設計
- [docs/USAGE.md](docs/USAGE.md) - 知識ファイルの使い方
- [docs/TEAM.md](docs/TEAM.md) - チーム運用ガイド
- [docs/HOOKS.md](docs/HOOKS.md) - Hook連携（オプション）
