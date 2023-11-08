#!/bin/bash

# Check if the input PDF file is provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <input_pdf> <number1> <number2> <number3> ..."
    exit 1
fi

# The first parameter is the input PDF file
input_pdf="$1"
shift

# Loop through the remaining parameters (numbers)
for current_item in "$@"; do
    # Generate the pdftk command with the current item
    pdftk "$input_pdf" output "6- Credenciales - ${current_item}.pdf" owner_pw xyz user_pw "$current_item"
    
    # Display the generated command (optional)
    echo "Generated command: pdftk $input_pdf output secure-file-${current_item}.pdf owner_pw xyz user_pw $current_item"
done

