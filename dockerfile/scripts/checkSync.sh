#!/bin/bash


for d in $(find /opengrok/src -name "*.git" -exec dirname {} \; -prune)
do
    printf -- '-%.0s' {1..20}; echo "$d"
    git -C $d fetch
    echo "$(git -C $d rev-parse HEAD)"
    echo "$(git -C $d rev-parse @{u})"
    if [ $(git -C $d rev-parse HEAD) != $(git -C $d rev-parse @{u}) ]; then
            #echo "$(git -C $d rev-parse --show-toplevel) in sync"
    #else
            echo "$(git -C $d fetch)"
            echo "$(git -C $d rev-parse --show-toplevel) not in sync"
            echo "$(git -C $d reset --hard HEAD)"
            echo "$(git -C $d pull)"
    fi
done
