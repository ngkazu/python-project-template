"""サンプルのヘルパー関数。実際のプロジェクトではここを差し替える。"""

from __future__ import annotations


def greet(name: str) -> str:
    """指定した名前へ挨拶文を返す。"""
    if not name:
        raise ValueError("name must not be empty")
    return f"Hello, {name}!"
