# install.ps1 - Reflect Skill インストーラー (Windows)
# 使用方法: irm [URL]/install.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "🔄 Reflect Skill をインストールしています..." -ForegroundColor Cyan

# ディレクトリ作成
# コマンドは .claude/commands/ （Claude Codeが認識）
# 知識・設定は .reflect/ （独自管理、セッションファイルと混在しない）
$dirs = @(
    ".claude/commands",
    ".reflect/knowledge/high",
    ".reflect/knowledge/medium",
    ".reflect/knowledge/low",
    ".reflect/scripts"
)
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

# =============================================================================
# コマンドファイル（.claude/commands/）
# =============================================================================

@"
# /reflect - セッションから学習を抽出

## 概要
セッションを分析し、修正パターン・成功パターンを ``.reflect/knowledge/`` に記録。

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
1. ``.reflect/knowledge/`` 内のファイルを更新
2. _index.md を更新（medium/low）
3. Git commit & push（リモートがあれば）

## 知識ファイルの場所
- ``.reflect/knowledge/high/`` - 常に読む
- ``.reflect/knowledge/medium/`` - 関連時に検索
- ``.reflect/knowledge/low/`` - アーカイブ
"@ | Set-Content ".claude/commands/reflect.md" -Encoding UTF8

@"
# /reflect-on - 自動リフレクションを有効化

``.reflect/config.json`` の ``autoReflect`` を ``true`` に設定。
セッション終了時に自動で /reflect 相当の処理を実行。
"@ | Set-Content ".claude/commands/reflect-on.md" -Encoding UTF8

@"
# /reflect-off - 自動リフレクションを無効化

``.reflect/config.json`` の ``autoReflect`` を ``false`` に設定。
手動 /reflect のみ有効。
"@ | Set-Content ".claude/commands/reflect-off.md" -Encoding UTF8

@"
# /reflect-status - 状態表示

## 表示内容
1. 設定状態（autoReflect: ON/OFF）
2. 知識ファイル概要（ファイル数、行数）

## 知識ファイルの場所
``.reflect/knowledge/``
- high/: 常に読む
- medium/: _index.md でキーワード検索
- low/: 明示的要求時のみ
"@ | Set-Content ".claude/commands/reflect-status.md" -Encoding UTF8

@"
# /reflect-split - 知識ファイルを分割

200行を超えた知識ファイルをカテゴリごとに分割。

## 使用例
``````
/reflect-split high
``````

## 処理
1. main.md の見出し（##）を分析
2. 分割案を提案
3. 承認後、カテゴリごとにファイル作成
4. _index.md を更新
"@ | Set-Content ".claude/commands/reflect-split.md" -Encoding UTF8

# =============================================================================
# 知識ファイル（.reflect/knowledge/）
# =============================================================================

$date = Get-Date -Format "yyyy-MM-dd"

@"
# High Priority Knowledge
<!-- updated: $date -->

<!-- 常に読む知識をここに記載 -->
<!-- 200行を超えたら /reflect-split で分割 -->
"@ | Set-Content ".reflect/knowledge/high/main.md" -Encoding UTF8

@"
# Index
<!-- キーワード → ファイル のマッピング -->
<!-- 例: Button, shadcn → ui.md -->
"@ | Set-Content ".reflect/knowledge/medium/_index.md" -Encoding UTF8

@"
# Medium Priority Knowledge
<!-- 関連時に参照する知識 -->
"@ | Set-Content ".reflect/knowledge/medium/main.md" -Encoding UTF8

@"
# Index
<!-- キーワード → ファイル -->
"@ | Set-Content ".reflect/knowledge/low/_index.md" -Encoding UTF8

@"
# Low Priority Knowledge
<!-- アーカイブ -->
"@ | Set-Content ".reflect/knowledge/low/main.md" -Encoding UTF8

# =============================================================================
# 設定ファイル（.reflect/）
# =============================================================================

@"
{
  "autoReflect": false,
  "lastReflect": null,
  "version": "1.0.0"
}
"@ | Set-Content ".reflect/config.json" -Encoding UTF8

# =============================================================================
# 完了メッセージ
# =============================================================================

Write-Host "✅ インストール完了！" -ForegroundColor Green
Write-Host ""
Write-Host "ファイル構成:"
Write-Host "  .claude/commands/  - スラッシュコマンド"
Write-Host "  .reflect/          - 知識・設定（セッションファイルと分離）"
Write-Host ""
Write-Host "使い方:"
Write-Host "  /reflect        - セッションから学習を抽出"
Write-Host "  /reflect-status - 状態を確認"
Write-Host ""
Write-Host "CLAUDE.md に以下を追加してください:"
Write-Host '  知識ベース: `.reflect/knowledge/` を活用。詳細は `/reflect-status` 参照。'
