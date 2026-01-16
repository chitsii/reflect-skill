# Reflect Skill - Self-Improving Skills for Claude Code

Claude Codeでセッション間の学習を持続させる自己改善スキルシステム。

## 問題

LLMはセッションごとに記憶がリセットされる。同じ修正を何度も繰り返す必要がある。

## 解決策

セッション中の修正・指示を知識ファイルに記録し、次回セッションから自動適用。

## インストール

### GitHubからインストール

```bash
# settings.json に追加
claude settings set plugins.reflect-skill.source "github:chitsii/reflect-skill"
```

または `~/.claude/settings.json` を直接編集:
```json
{
  "plugins": {
    "reflect-skill": {
      "source": "github:chitsii/reflect-skill"
    }
  }
}
```

### ローカルからインストール（開発用）

```bash
# リポジトリをクローン
git clone https://github.com/chitsii/reflect-skill.git

# settings.json に追加
claude settings set plugins.reflect-skill.source "/path/to/reflect-skill"
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
| `/reflect-skill:status` | 状態を表示 |
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
- 詳細: [docs/TEAM_OPERATION.md](docs/TEAM_OPERATION.md)

## ドキュメント

- [docs/DESIGN.md](docs/DESIGN.md) - 詳細設計
- [docs/USAGE.md](docs/USAGE.md) - 知識ファイルの使い方
- [docs/TEAM_GUIDE.md](docs/TEAM_GUIDE.md) - チーム運用ガイド
