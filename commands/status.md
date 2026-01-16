---
description: リフレクション状態と知識ファイル概要を表示
---

# /reflect-skill:status

## 表示内容

1. **設定状態**
   - autoReflect: ON/OFF
   - 最終リフレクション日時

2. **知識ファイル概要**
   ```
   .reflect/knowledge/
   ├── high/     [N files, M lines]
   ├── medium/   [N files, M lines]
   └── low/      [N files, M lines]
   ```

## 知識の読み方
- high/: セッション開始時に全読み
- medium/: _index.md でキーワード検索
- low/: 明示的要求時のみ
