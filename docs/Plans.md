# Self-Improving Skills - 実装計画

## 概要
Claude Codeにおける自己改善スキルシステムの実装。セッション間で学習を持続させる。

## 設計決定事項
- **配置**: プロジェクトローカル（`.claude/skills/`）+ エクスポート/インポート
- **Git**: 自動コミット＋自動プッシュ
- **デフォルト**: 自動リフレクションはOFF
- **統合**: claude-code-harnessとは独立

---

## Phase 1: 基盤構築

### 1.1 ディレクトリ構造の作成 `cc:TODO`
```
.claude/
├── commands/
│   ├── reflect.md          # /reflect コマンド
│   ├── reflect-on.md       # /reflect-on コマンド
│   ├── reflect-off.md      # /reflect-off コマンド
│   └── reflect-status.md   # /reflect-status コマンド
├── skills/
│   └── (学習されたスキルが蓄積)
├── state/
│   └── reflect-config.json # リフレクション設定
└── scripts/
    └── reflect-hook.sh     # Stop Hook用スクリプト
```

### 1.2 Reflect スキル本体の作成 `cc:TODO`
- 会話履歴をスキャンしてシグナルを抽出
- 信頼度（High/Medium/Low）で分類
- スキルファイルへの更新提案を生成
- ユーザー確認後に適用

### 1.3 シグナル抽出ロジック `cc:TODO`
- **High**: 明示的指示（「必ず〜」「絶対に〜するな」）
- **Medium**: 修正後に承認されたパターン
- **Low**: 傾向・観察事項

---

## Phase 2: トグル機能

### 2.1 reflect-on コマンド `cc:TODO`
- 自動リフレクションを有効化
- `reflect-config.json` を更新

### 2.2 reflect-off コマンド `cc:TODO`
- 自動リフレクションを無効化
- `reflect-config.json` を更新

### 2.3 reflect-status コマンド `cc:TODO`
- 現在の状態を表示
- 直近の学習履歴サマリー

---

## Phase 3: 自動化（Stop Hook）

### 3.1 reflect-hook.sh の作成 `cc:TODO`
- Stop Hook から呼び出されるスクリプト
- 自動リフレクションが有効な場合のみ実行

### 3.2 settings.json テンプレート `cc:TODO`
- Hook 設定のサンプル提供

---

## Phase 4: Git 連携

### 4.1 自動コミット `cc:TODO`
- スキル更新時に自動コミット
- 意味のあるコミットメッセージ生成

### 4.2 自動プッシュ `cc:TODO`
- コミット後に自動プッシュ
- リモートが設定されている場合のみ

### 4.3 履歴表示 `cc:TODO`
- スキルの変更履歴を表示

---

## Phase 5: エクスポート/インポート

### 5.1 エクスポート機能 `cc:TODO`
- スキルを他プロジェクトで使用可能な形式で出力

### 5.2 インポート機能 `cc:TODO`
- 外部スキルをプロジェクトに取り込む
- マージ/上書き戦略の選択

---

## 現在の進捗

| Phase | 状態 | 備考 |
|-------|------|------|
| Phase 1 | `cc:DONE` | 基盤構築完了 |
| Phase 2 | `cc:DONE` | トグルコマンド完了 |
| Phase 3 | `cc:DONE` | Stop Hook完了 |
| Phase 4 | `cc:DONE` | Git連携（コマンド内で説明） |
| Phase 5 | `cc:TODO` | エクスポート/インポート（将来対応） |
