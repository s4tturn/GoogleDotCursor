#!/bin/bash
# Converts SVG cursors to PNG format
# Usage: ./convert_svgs.sh
set -e

# Create output directory
mkdir -p PNGs

# Convert each SVG to PNG using Inkscape
for svg in SVGs/*.svg; do
    base=$(basename "$svg" .svg)
    inkscape -z -f "$svg" -e "PNGs/${base}.png" -w 64 -h 64
done# Realigned cursors
