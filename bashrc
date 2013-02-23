# Set the terminal color
export TERM=xterm-256color

# Disable CTRL-S and CTRL-Q inside terminal
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef
