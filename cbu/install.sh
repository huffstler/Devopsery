#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
    echo "This script needs to be run as root! Use sudo."
    exit 1
fi

if [[ -f "/usr/local/bin/cbu" ]]; then
    echo "Removing older version ($(cbu -V)) of cbu."
    rm /usr/local/bin/cbu
fi

cp cbu /usr/local/bin

echo "CBU version: $(cbu -V) was installed."

