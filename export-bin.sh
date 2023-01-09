#!/bin/bash
for trg in $((read -r)); do
    distrobox-export --bin $(which $trg) --export-path /home/usuario/.local/bin/archpath
done
