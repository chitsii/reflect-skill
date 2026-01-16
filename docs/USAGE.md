# 知識ファイル活用ガイド

## 概要

Reflect Skillは、セッション中の修正・指示を知識ファイルに記録し、次回セッションから自動適用する。

---

## 1. フォルダ構造

```
.reflect/knowledge/
├── high/      # 常に読む（セッション開始時）
├── medium/    # 関連時に読む（検索で発見）
└── low/       # アーカイブ（明示的に参照時のみ）
```

### 読み込みルール

| フォルダ | 読み込み | 用途 |
|----------|----------|------|
| `high/` | セッション開始時に全ファイル | 重要な知識 |
| `medium/` | 作業内容に応じて検索・読み込み | 参考情報 |
| `low/` | 明示的に求められた時のみ | アーカイブ |

---

## 2. 活用フロー

```
セッション開始
    ↓
CLAUDE.md を読む → 知識ベースの存在を認識
    ↓
high/ を全て読む（常に）
    ↓
タスク受領 → キーワード抽出
    ↓
medium/_index.md を検索（関連キーワードあれば）
    ↓
作業実行
    ↓
修正あれば /reflect → 知識更新 → Git commit & push
```

---

## 3. ファイルフォーマット

**制約: 1ファイル200行以内、簡潔に記述**

```markdown
# 命名規則
<!-- confidence: high | updated: 2024-01-20 -->

## 変数・関数
- camelCase使用
- 動詞+名詞: `getUserById`, `validateInput`
- bool: is/has/can接頭辞

## 禁止
- 略語禁止: ×`usr` ○`user`

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

### 簡潔化ルール

| ルール | 説明 |
|--------|------|
| 200行制限 | 1ファイル200行以内 |
| 箇条書き優先 | 文章より箇条書き |
| 例は最小限 | Good/Bad各1つまで |
| メタデータ1行 | コメント形式で1行 |

---

## 4. 分割ルール

### 初期構造

```
.reflect/knowledge/
├── high/
│   └── main.md       # 常に全読み
├── medium/
│   ├── _index.md     # 検索用（常に存在）
│   └── main.md
└── low/
    ├── _index.md     # 検索用（常に存在）
    └── main.md
```

### 分割タイミング

| 条件 | アクション |
|------|-----------|
| 200行以下 | 1ファイルのまま |
| 200行超え | カテゴリで分割 |
| 分割後も200行超え | さらに細分化 |

### 分割後の構造

```
.reflect/knowledge/
├── high/
│   ├── _index.md  # 分割時に追加
│   ├── ui.md
│   └── naming.md
├── medium/
│   ├── _index.md
│   └── main.md
└── low/
    ├── _index.md
    └── main.md
```

### _index.md の形式

```markdown
# Index
Button, shadcn → ui.md
camelCase, 命名 → naming.md
API, Result → api.md
```

---

## 5. 知識の分類基準

| 信頼度 | 条件 | 扱い |
|--------|------|------|
| **High** | ユーザーが明示的に指示 / 複数回確認済み | 常に適用 |
| **Medium** | 1回の修正で学習 / 成功パターンから抽出 | 状況に応じて適用 |
| **Low** | 観察・推測に基づく | 提案時に確認を求める |

---

## 6. CLAUDE.md との連携

CLAUDE.mdには最小限（1行）の記載で十分:

```markdown
知識ベース: `.reflect/knowledge/` を活用。詳細は `/reflect-skill:status` 参照。
```

**理由:**
- Reflectスキルが読み方の詳細を知っている
- CLAUDE.mdの肥大化を防ぐ
- 知識管理はスキル側で完結
