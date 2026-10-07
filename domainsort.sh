#!/usr/bin/env bash
awk '{
    split($0, hp, ":"); host=hp[1]; port=hp[2]
    n = split(host, p, ".")
    key = ""
    for (i = n; i >= 1; i--) key = key (key == "" ? "" : ".") p[i]
    print key ":" port "\t" $0
}' | sort -uV | cut -f 2

