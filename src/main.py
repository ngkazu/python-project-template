"""CLI エントリポイント。`python src/main.py` で実行する。"""

from __future__ import annotations

import argparse
import sys

from core import greet


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="main")
    parser.add_argument("name", nargs="?", default="World", help="挨拶する相手の名前")
    args = parser.parse_args(argv)

    print(greet(args.name))
    return 0


if __name__ == "__main__":
    sys.exit(main())
