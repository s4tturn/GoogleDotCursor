#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SRC_DIR="$SCRIPT_DIR/SVGs/Static"
DST_DIR="$SCRIPT_DIR/PNGs"

# Ensure destination directory exists
mkdir -p "$DST_DIR"

# Define only the 10x scaling factor and its pixel dimensions
SIZES=(
 "10 320 320"
)

# Loop through every .svg file in the source directory
for svg_path in "$SRC_DIR"/*.svg; do
 # Get just the filename (e.g., "Arrow.svg")
 filename=$(basename "$svg_path")
 # Remove the .svg extension to get the base name (e.g., "Arrow")
 base="${filename%.svg}"

 # Generate each size variant
 for size_info in "${SIZES[@]}"; do
 # Parse factor, width, height
 factor=$(echo "$size_info" | cut -d' ' -f1)
 width=$(echo "$size_info" | cut -d' ' -f2)
 height=$(echo "$size_info" | cut -d' ' -f3)

 # Construct output filename: {base}@10x.png
 out_path="${DST_DIR}/${base}@${factor}x.png"

 echo "Converting: $svg_path -> $out_path (${width}x${height})"
 sips --resampleHeightWidth "$width" "$height" -s format png "$svg_path" -o "$out_path"
 done
done

echo "Done!"
