# Hook連携ガイド

Reflect Skillは Claude Code のHook機能と**オプションで**連携できます。
hookなしでも基本機能は動作します。

## 概要

| Hook | 用途 |
|------|------|
| `Stop` | セッション終了時にリマインダー表示 |

---

## 設計方針

**「通知のみ」の原則:**
- hookは「`/reflect-skill:reflect` を実行してください」と通知するだけ
- 実際の知識抽出・保存は常にユーザーが手動で実行
- これにより予測可能で安全な動作を保証

---

## 設定方法

### プロジェクト設定 (`.claude/settings.json`)

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo '[reflect-skill] Session ending. Consider running /reflect-skill:reflect to capture learnings.'"
          }
        ]
      }
    ]
  }
}
```

### 注意事項

- `type: "command"` を使用（`type: "prompt"` は使わない）
- commandの出力はClaude自身には渡されず、ユーザーへの通知のみ
- hookがなくても `/reflect-skill:reflect` は手動で実行可能

---

## hookなしの運用（推奨）

hookを使わずに運用することも可能です：

1. 作業中に修正・指示があったら覚えておく
2. セッション終了前に `/reflect-skill:reflect` を実行
3. 提案された学習内容を確認し承認

**hookを使わない利点:**
- 設定がシンプル
- 環境依存の問題なし
- ユーザーが完全にコントロール

---

## トラブルシューティング

### Hookが発火しない

- `.claude/settings.json` の構文エラーを確認
- `claude --version` で 1.0.33 以降か確認

### hookを使わない場合

hookの設定は不要です。手動で `/reflect-skill:reflect` を実行してください。
