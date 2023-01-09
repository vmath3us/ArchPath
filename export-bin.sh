#!/bin/bash
while read -r trg; do
    distrobox-export --bin $(which $trg) --export-path /home/usuario/.local/bin/archpath
done
