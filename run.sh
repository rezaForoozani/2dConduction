#!/bin/bash

# Define the Fortran source file and the output executable name
SOURCE_FILE="conduction.f90"
OUTPUT_FILE="conduction"
PLOT_SCRIPT="plot.py"
RESULT_FILE="RESULT.dat"

# Compile the main program
gfortran -o "$OUTPUT_FILE" "$SOURCE_FILE"
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running the program..."
    ./"$OUTPUT_FILE"
else
    echo "Compilation failed."
    exit 1
fi

# Run the Python plotting script if it exists
if [ -f "$PLOT_SCRIPT" ]; then
    echo "Running the plotting script..."
    python3 "$PLOT_SCRIPT"
else
    echo "Plotting script not found."
    exit 1
fi

# Clean up object files and other generated files
echo "Cleaning up..."
rm -f "$OUTPUT_FILE"
rm -f "$RESULT_FILE"  # Remove RESULT.dat

echo "Done."

