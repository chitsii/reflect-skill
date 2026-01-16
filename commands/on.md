---
description: リフレクション・リマインダーを有効化
---

# /reflect-skill:on

`.reflect/config.json` の `reminder` を `true` に設定。

## 効果

- セッション終了時にリマインダーを表示（hookが設定されている場合）
- 実際のリフレクションは `/reflect-skill:reflect` で手動実行

## 注意

- リマインダーは通知のみ、自動で知識を書き込まない
- 知識の追加は常にユーザー確認を経る
