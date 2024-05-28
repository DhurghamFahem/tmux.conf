#!/bin/bash

# Define session and window names
SESSION="my_session"
WINDOW="main"

# Define commands to run in each pane
CMD1="htop"
CMD2="tail -f /var/log/syslog"
CMD3="vim"
CMD4="ping google.com"

# Start a new tmux session, detached
tmux new-session -d -s $SESSION -n $WINDOW

# Send the first command to the initial pane
tmux send-keys -t $SESSION:0.0 "$CMD1" C-m

# Split the window into panes and send commands
tmux split-window -h -t $SESSION:0    # Split pane 0 horizontally
tmux send-keys -t $SESSION:0.1 "$CMD2" C-m

tmux split-window -v -t $SESSION:0.1  # Split pane 1 vertically
tmux send-keys -t $SESSION:0.2 "$CMD3" C-m

tmux split-window -v -t $SESSION:0.0  # Split pane 0 vertically
tmux send-keys -t $SESSION:0.3 "$CMD4" C-m

# Resize panes
tmux resize-pane -t $SESSION:0.0 -x 80 -y 20   # Set pane 0 size
tmux resize-pane -t $SESSION:0.1 -x 80 -y 20   # Set pane 1 size
tmux resize-pane -t $SESSION:0.2 -x 80 -y 20   # Set pane 2 size
tmux resize-pane -t $SESSION:0.3 -x 80 -y 20   # Set pane 3 size

# Select the first pane
tmux select-pane -t $SESSION:0.0

# Attach to the tmux session
tmux attach-session -t $SESSION
