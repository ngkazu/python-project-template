from __future__ import annotations

import pytest

from core import greet


def test_greet_returns_expected_message() -> None:
    assert greet("Python") == "Hello, Python!"


def test_greet_raises_on_empty_name() -> None:
    with pytest.raises(ValueError):
        greet("")
