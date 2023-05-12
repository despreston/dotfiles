##############################################################################
# Env Vars
##############################################################################
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="/opt/homebrew/opt/go@1.18/bin"
export PATH=$PATH:/usr/local/bin/go:$GOPATH
export PATH="/usr/local/opt/llvm/bin:$PATH"
export GPG_TTY=$(tty)
export DOTFILES="$HOME/dotfiles"

###############################################################################
# Functions
###############################################################################
function repo_name {
  git remote -v 2> /dev/null | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//'
}

function deployoperator {
  echo 'Stopping Operator...' && ssh -t root@des-pi 'systemctl stop operator.service' && \
  echo 'Transferring...' && scp bin/operator root@des-pi:/home/operator/operator && \
  echo 'Starting Operator...' && ssh -t root@des-pi 'systemctl start operator.service'
}

function keychain-environment-variable() {
  security find-generic-password -w -a "${USER}" -D ENV -s "${1}"
}

function set-keychain-environment-variable() {
  [[ -z "$1" ]] && return 1
  read -r -s "?Enter Value for ${1}: " secret
  [[ -z "$secret" ]] && return 1
  security add-generic-password -U -a "${USER}" -D ENV -s "${1}" -w "${secret}"
}

function gdiff() {
  git log --oneline | fzf --preview 'git diff {1}..{1}~1 --color=always'
}

###############################################################################
# Misc
###############################################################################
ZSH_THEME="robbyrussell"

# disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source $HOME/.fzf.zsh

PROMPT='%{$fg[blue]%}$(whoami)@$(hostname -s)%{$reset_color%}'
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

##############################################################################
# Aliases
##############################################################################
alias dev="cd $HOME/dev"
alias zshconfig="$EDITOR $DOTFILES/.zshrc"
alias nvimconfig="$EDITOR $DOTFILES/.config/nvim/init.lua"
alias gs='git status'
alias ls='ls -alG'
alias vim='nvim'
alias dotfiles='cd ~/dotfiles'
alias ssh='TERM=$TERM ssh'
alias sam='cd ~/co/backend/go/src/samsaradev.io'

# tmux: split-window vertically, resize right pane to 80
alias tdev="tmux splitw -h -l 80\; send-keys -t 0 'vim .' Enter"

# tmux: vim wiki, operator logs, horchdienst logs
alias tdash="tmux \
  renamew dash \; \
  splitw -h \; \
  splitw -v \; \
  send-keys -t 0 C-z 'vw' Enter \; \
  send-keys -t 1 C-z 'ssh des-pi journalctl -u operator.service -f' Enter \; \
"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(direnv hook zsh)"
