
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias vi=nvim
alias vim=nvim

# Fix the bug with Ctrl+h on neovim <https://github.com/neovim/neovim/issues/2048>
export TERMINFO="$HOME/.terminfo"

ssh-add ~/.ssh/id_rsa
