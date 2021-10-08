#!/usr/bin/env python3
import sys

try:
    int(sys.argv[1])
    print("Is a number")
except Exception as E:
    print("Not a numbner")
    pass
