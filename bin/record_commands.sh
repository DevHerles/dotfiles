#!/bin/bash

if [ $# -ne 1 ] || [[ ! "$1" =~ \.md$ ]]; then
  echo "Usage: $0 <output_file>.md"
  exit 1
fi

output_file="$1"
history_file="${HOME}/.zsh_history"

echo "Enter your command (or 'exit' to quit)"

while true; do
    read -p "❯❯ " cmd

    if [ "$cmd" = "exit" ]; then
        break
    fi

    echo "#### \`❯ $cmd\`" >> "$output_file"
    echo ""
    echo "\`\`\`bash" >> "$output_file"
    eval "$cmd" | tee -a "$output_file" 2>&1
    echo "\`\`\`" >> "$output_file"
    echo "" >> "$output_file"
    echo ""

    # Save the command to the shell's history
    echo "$cmd" >> "$history_file"

done
