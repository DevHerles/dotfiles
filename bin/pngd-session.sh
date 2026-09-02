#!/bin/bash

# Define the session name
SESSION_NAME="PNGD"

# Define the list of remote servers
SERVERS=("admin@10.4.0.21" "root@10.9.9.23")

# Check if we're already inside a TMUX session
if [ -n "$TMUX" ]; then
    echo "You are already inside a TMUX session. Please detach before running this script."
    exit 1
fi

# Check if the session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
    # Session already exists, attach to it
    tmux attach -t $SESSION_NAME
else
    # Start a new TMUX session
    tmux new-session -d -s $SESSION_NAME

    # Create windows and connect to each server
    for i in "${!SERVERS[@]}"; do
        SERVER=${SERVERS[$i]}
        if [ $i -eq 0 ]; then
            # Rename the first window to the first server
            tmux rename-window -t $SESSION_NAME:0 "BASTION"
            tmux send-keys -t $SESSION_NAME:0 "ssh $SERVER" C-m
        else
            # Create a new window for each additional server
            tmux new-window -t $SESSION_NAME -n "Server$((i+1))"
            tmux send-keys -t $SESSION_NAME:$((i+1)) "ssh $SERVER" C-m
        fi
    done

    # Attach to the session
    tmux attach -t $SESSION_NAME
fi

