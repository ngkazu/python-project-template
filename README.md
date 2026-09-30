# python-project-template

一般的な Python プロジェクト（スクリプト実行型）のひな型です。pip パッケージとしての配布は前提とせず、
`src/` を直接実行・テストする軽量な構成にしています。

## 構成

```
python-project-template/
  docs/                 # インストール手順・設計書など
  memos/                 # やることリスト・アイデアメモ
  data/                  # テスト・動作確認用データ
  references/            # コード生成時に参照するドキュメント・サンプルコード
  src/
    main.py              # エントリポイント
    core/                # helper など共通関数
      __init__.py
      core.py
  tests/
    conftest.py          # src/ を import できるよう sys.path に追加
    test_core.py
  requirements.txt       # 実行時依存パッケージ
  requirements-dev.txt   # 開発用依存パッケージ（pytest / ruff / mypy）
  pyproject.toml         # ruff / mypy / pytest のツール設定のみ
  .gitignore
  LICENSE
```

## Python バージョンについて

このひな型は特定の Python バージョンに依存しない構成にしています
（`pyproject.toml` に `target-version` / `requires-python` は指定していません）。
プロジェクトごとに使用する Python バージョンを決めたら、以下のいずれかで明示することを推奨します。

- `pyproject.toml` の `[tool.ruff]` に `target-version = "pyXY"` を追加する
- 必要であれば `.python-version` ファイルを追加する（pyenv / uv 等で自動選択される）

## セットアップ

```powershell
# 複数バージョンがインストールされている環境では `python` が意図しない実行体
# （Windows Store のスタブ等）を指すことがあるため、`py -3.12` のように
# バージョンを明示して venv を作成するのが確実。
py -3.12 -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements-dev.txt
```

## 使い方

```powershell
python src\main.py YourName
```

## 開発コマンド

```powershell
ruff check .          # Lint
ruff format .         # コード整形
mypy                  # 型チェック
pytest                # テスト実行
```
