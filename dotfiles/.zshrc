export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

plugins=(git node docker)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:/home/jlcarruda/tools/nvim-linux64/bin:/home/jlcarruda/.local/bin"

# ======== ALIASES ========
## --- Docker ---
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcr="docker compose run"
alias dob="docker build"
alias dcprune="docker container prune"
alias diprune="docker image prune"
alias dcls="docker container list -a"
alias dils="docker images -a"
alias drit="docker run --it"
## --- Terraform ---
alias tf="terraform"
## --- Utilities ---
alias killPicom="kill $(ps -aux | grep picom | head -1 | awk '{print $2}')"
alias qtileReload="qtile cmd-obj -o cmd -f reload_config"
alias shell="nix-shell -p"
alias xoutputs="echo $(xrandr | grep -E " connected" | awk '{print $1}')"

## --- Nix-Shell Wrapped commands  ---
alias nyoom="shell python39 rnix-lsp -p 'python39.withPackages(ps: with ps; [ pynvim ])' --run nvim" # Run nyoom with python 3.9, rnix-lsp and pynvim installed

## WIP
#alias pacu="shell python38 -p 'python38.withPackages(ps: with ps; [ pacu ])' --run pacu" # Run pacu with python 3.8 (No Pacu found. Need an overlay?)

MAIN_TMUX_SESSION="$(tmux ls | awk '{print substr($1, 1, length($1)-1)}')"
if [[ -z $MAIN_TMUX_SESSION ]] then
  /usr/bin/tmux new-session -s main;
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Settings for kb 60% US to be able to type cedilla and accentuation
setxkbmap -model abnt2 -layout us -variant intl