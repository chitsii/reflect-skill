# Reflect スキル配布・知識管理戦略

## 1. 概要

Reflectスキルを各プロジェクトに配布し、プロジェクト固有の知識を蓄積・活用するための戦略を定義する。

---

## 2. ドキュメント棲み分けルール

### 2.1 三層構造

```
┌─────────────────────────────────────────────────────────────┐
│  DESIGN.md / 設計ドキュメント                    [人間向け]  │
│  - アーキテクチャ決定                                        │
│  - 機能仕様                                                  │
│  - 技術選定理由                                              │
│  ※ 正式な設計情報源（SSOT）                                 │
└─────────────────────────────────────────────────────────────┘
                              ↓ 参照
┌─────────────────────────────────────────────────────────────┐
│  CLAUDE.md                               [静的・プロジェクト] │
│  - プロジェクト概要                                          │
│  - 不変のルール（コーディング規約等）                        │
│  - ディレクトリ構造                                          │
│  ※ セッション開始時に必ず読む                               │
└─────────────────────────────────────────────────────────────┘
                              ↓ 補完
┌─────────────────────────────────────────────────────────────┐
│  .claude/knowledge/                      [動的・学習による]  │
│  - ユーザーの好み・修正パターン                              │
│  - 方法論・Tips                                              │
│  - プロジェクト固有のショートカット                          │
│  ※ 開発の潤滑性を上げる情報                                 │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 何をどこに書くか

| 情報の種類 | 書く場所 | 例 |
|------------|----------|-----|
| アーキテクチャ | DESIGN.md | コンポーネント構成、データフロー |
| 技術選定 | DESIGN.md | なぜReactを選んだか |
| コーディング規約 | CLAUDE.md | 命名規則、フォーマット |
| ディレクトリ構造 | CLAUDE.md | src/の説明 |
| **好みの修正** | knowledge/ | 「Buttonは必ずshadcnから」 |
| **方法論** | knowledge/ | 「テストは先に書く」 |
| **ショートカット** | knowledge/ | 「このAPIはこう呼ぶ」 |
| **失敗パターン** | knowledge/ | 「この書き方はエラーになる」 |

### 2.3 知識ファイルに書かないもの

- 設計判断（→ DESIGN.md）
- 不変のルール（→ CLAUDE.md）
- コードの説明（→ コード内コメント）
- 一時的なメモ（→ 書かない）

---

## 3. Reflectスキルの配布戦略

### 3.1 配布モデル

```
┌─────────────────────────────────────────────────────────────┐
│                    Reflect Skill Repository                  │
│                   (GitHub: user/reflect-skill)               │
├─────────────────────────────────────────────────────────────┤
│  ├── commands/           # スラッシュコマンド定義            │
│  │   ├── reflect.md                                         │
│  │   ├── reflect-on.md                                      │
│  │   ├── reflect-off.md                                     │
│  │   └── reflect-status.md                                  │
│  ├── scripts/            # Hook用スクリプト                  │
│  │   └── reflect-hook.sh                                    │
│  ├── templates/          # 知識ファイルテンプレート          │
│  │   └── knowledge-template.md                              │
│  ├── install.sh          # インストールスクリプト            │
│  └── VERSION             # バージョン情報                    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼ インストール
┌─────────────────────────────────────────────────────────────┐
│                      Project A                               │
│  .claude/                                                    │
│  ├── commands/reflect*.md    ← コピー                       │
│  ├── knowledge/              ← 新規作成（プロジェクト固有）  │
│  ├── scripts/                ← コピー                       │
│  └── state/reflect-config.json                              │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 インストール方法

#### Option A: ワンライナーインストール（推奨）
```bash
# GitHubから直接インストール
curl -fsSL https://raw.githubusercontent.com/user/reflect-skill/main/install.sh | bash

# または bunx/npx スタイル
bunx reflect-skill init
```

#### Option B: Git Clone + シンボリックリンク
```bash
# グローバルにクローン
git clone https://github.com/user/reflect-skill ~/.reflect-skill

# プロジェクトにリンク
~/.reflect-skill/install.sh --link
```

#### Option C: 手動コピー
```bash
# 必要なファイルを手動でコピー
cp -r ~/.reflect-skill/commands .claude/
cp -r ~/.reflect-skill/scripts .claude/
```

### 3.3 アップデート戦略

| 方式 | 説明 | 適用場面 |
|------|------|----------|
| **Pull** | 手動で最新版を取得 | 安定運用時 |
| **Check** | 新バージョン通知のみ | 慎重な更新が必要な時 |
| **Auto** | セッション開始時に自動更新 | 常に最新を維持したい時 |

```bash
# バージョン確認
/reflect-status --version

# アップデート
/reflect-update
```

---

## 4. プロジェクト固有の知識蓄積戦略

### 4.1 知識の階層構造

**初期構造:**
```
.claude/knowledge/
├── high/
│   └── main.md      # 常に全読み
├── medium/
│   ├── _index.md    # キーワード検索用（常に存在）
│   └── main.md
└── low/
    ├── _index.md    # キーワード検索用（常に存在）
    └── main.md
```

**分割後（200行超え時）:**
```
.claude/knowledge/
├── high/
│   ├── _index.md    # 分割時のみ追加
│   ├── ui.md
│   └── naming.md
├── medium/
│   ├── _index.md
│   └── main.md
└── low/
    ├── _index.md
    └── main.md
```

**ルール:**
- high/: 全読みなので_index.mdは分割時のみ
- medium/, low/: 検索用に_index.mdを常に配置

### 4.2 知識ファイルのフォーマット

**制約: 1ファイル200行以内、簡潔に記述**

```markdown
# 命名規則
<!-- confidence: high | updated: 2024-01-20 -->

## 変数・関数
- camelCase使用
- 動詞+名詞: `getUserById`, `validateInput`
- bool: is/has/can接頭辞

## コンポーネント
- PascalCase: `UserProfile`, `ButtonPrimary`
- ファイル名=コンポーネント名

## 禁止
- 略語禁止: ×`usr` ○`user`
- 連番禁止: ×`data1`, `data2`

## 例
```ts
// ○
const isActive = true;
function fetchUserData() {}

// ×
const active = true;
function fud() {}
```
```

**ポイント:**
- メタデータは1行コメントで
- 箇条書き中心
- 例は最小限（Good/Badを1つずつ）
- 説明文は省略可能なら省略

### 4.3 簡潔化ルール

| ルール | 説明 |
|--------|------|
| **200行制限** | 1ファイル200行以内 |
| **箇条書き優先** | 文章より箇条書き |
| **例は最小限** | Good/Bad各1つまで |
| **説明省略** | 自明なら説明不要 |
| **略語OK** | 文脈で明確なら略語可 |
| **メタデータ1行** | コメント形式で1行 |

**NG例:**
```markdown
## 概要
この知識ファイルは命名規則について説明しています。
命名規則はコードの可読性を高めるために重要です。
```

**OK例:**
```markdown
# 命名規則
<!-- confidence: high | updated: 2024-01-20 -->
```

### 4.4 知識の分類基準

| 信頼度 | 条件 | 扱い |
|--------|------|------|
| **High** | ユーザーが明示的に指示 / 複数回確認済み | 常に適用 |
| **Medium** | 1回の修正で学習 / 成功パターンから抽出 | 状況に応じて適用 |
| **Low** | 観察・推測に基づく | 提案時に確認を求める |

---

## 5. 知識の活用戦略

### 5.1 CLAUDE.md との連携

**CLAUDE.mdへの記載（最小限・1行）:**
```markdown
知識ベース: `.claude/knowledge/` を活用。詳細は `/reflect-status` 参照。
```

**これだけで十分な理由:**
- Reflectスキルが読み方の詳細を知っている
- CLAUDE.mdの肥大化を防ぐ
- 知識管理はスキル側で完結

### 5.2 知識読み込みフロー

```
セッション開始
    ↓
CLAUDE.md を読む → 知識ベースの存在を認識
    ↓
high.md を読む（常に）
    ↓
タスク受領 → キーワード抽出
    ↓
medium.md を検索（関連キーワードあれば）
    ↓
作業実行
    ↓
修正あれば /reflect → 知識更新 → Git commit & push
```

### 5.3 _index.md（分割時のみ）

**1ファイル時**: _index.md 不要

**分割後**: キーワードマッピングのみ
```markdown
# Index
Button, shadcn → ui.md
camelCase, 命名 → naming.md
API, Result → api.md
```

---

## 6. 知識の移植・共有戦略

### 6.1 エクスポート

```bash
# 特定カテゴリをエクスポート
/reflect-export coding --output ./exported-coding-rules.zip

# 全知識をエクスポート
/reflect-export --all --output ./project-knowledge.zip
```

**エクスポート形式:**
```
exported-coding-rules.zip
├── manifest.json          # メタデータ
├── coding/
│   ├── naming.md
│   └── patterns.md
└── README.md              # 使用方法
```

### 6.2 インポート

```bash
# 知識をインポート（マージモード）
/reflect-import ./exported-coding-rules.zip --merge

# 知識をインポート（上書きモード）
/reflect-import ./exported-coding-rules.zip --overwrite

# プレビューのみ
/reflect-import ./exported-coding-rules.zip --preview
```

### 6.3 マージ戦略

| 戦略 | 説明 | 適用場面 |
|------|------|----------|
| **merge** | 既存と新規をマージ、競合時は確認 | 通常のインポート |
| **overwrite** | 新規で完全上書き | クリーンインストール時 |
| **newer** | 更新日が新しい方を採用 | 同期目的 |
| **higher-confidence** | 信頼度が高い方を採用 | 品質重視 |

---

## 7. 知識の品質管理

### 7.1 自動クリーンアップ

```markdown
## 古い知識の処理

- 90日以上参照されていない Low 信頼度の知識 → アーカイブ提案
- 矛盾する知識の検出 → ユーザーに確認
- 重複知識の統合提案
```

### 7.2 知識の昇格・降格

```
Low → Medium: 同じパターンが3回以上成功
Medium → High: ユーザーが明示的に承認
High → Medium: 例外ケースが発見された
Medium → Low: 長期間使用されていない
```

### 7.3 バージョン管理

```bash
# 知識の変更履歴を表示
/reflect-history coding/naming.md

# 特定バージョンに戻す
/reflect-rollback coding/naming.md --to v3

# 差分を表示
/reflect-diff coding/naming.md --from v2 --to v5
```

---

## 8. 実装優先度

| 優先度 | 機能 | 理由 |
|--------|------|------|
| **P0** | 基本的な知識蓄積・参照 | コア機能 |
| **P0** | CLAUDE.md連携 | 知識活用の入口 |
| **P1** | インストールスクリプト | 配布に必須 |
| **P1** | Git自動コミット | 履歴管理 |
| **P2** | エクスポート/インポート | 知識共有 |
| **P2** | 知識インデックス自動生成 | 利便性向上 |
| **P3** | 自動クリーンアップ | 長期運用 |
| **P3** | バージョン管理UI | 高度な操作 |

---

## 9. 次のアクション

1. **install.sh** スクリプトの作成
2. **knowledge/** ディレクトリ構造とテンプレートの作成
3. **/reflect** コマンドの実装（知識ファイル更新対応）
4. **CLAUDE.md** テンプレートの作成（知識参照を含む）
