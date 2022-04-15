##############################################################################
# Env Vars
##############################################################################
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export ZSH="$HOME/.oh-my-zsh"
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/bin/go:$GOPATH/bin
export PATH="/usr/local/opt/llvm/bin:$PATH"
export ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# tanium
export PATH=$PATH:$HOME/bin
export VPN_USER=des.preston
eval "$(direnv hook zsh)"
export TANIUM_COMPOSE_PATH=~/dev/tanium/compose
source $HOME/dev/tanium/vpn/vpn.zsh

###############################################################################
# Functions
###############################################################################
function repo_name {
  git remote -v 2> /dev/null | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//'
}

function deployoperator {
  echo 'Stopping Operator...' && ssh -t des-pi 'sudo service operator stop' && \
  echo 'Transferring...' && scp bin/operator des-pi:/home/operator/operator && \
  echo 'Starting Operator...' && ssh -t des-pi 'sudo service operator start'
}

# Show aws logs using awslogs
function showlogs() {
  awslogs get /aws/lambda/$1 ALL --watch
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

###############################################################################
# Misc
###############################################################################
ZSH_THEME="robbyrussell"

# disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source $HOME/.fzf.zsh

##############################################################################
# Aliases
##############################################################################
alias dev="cd $HOME/dev"
alias zshconfig="$EDITOR ~/.zshrc"
alias nvimconfig="$EDITOR ~/.config/nvim/init.lua"
alias vw='vim -c VimwikiIndex'
alias gs='git status'
alias ls='ls -alG'
alias tanium='dev && cd tanium'
alias vim='nvim'
alias dotfiles='cd ~/dotfiles'

# start tmux w/ correct TERM
alias tmux="TERM=xterm-256color-italic tmux"

# tmux: split-window vertically, resize right pane to 80
alias tdev="tmux splitw -h -l 80\; send-keys -t 0 'vim .' Enter"

# tmux: vim wiki, operator logs, horchdienst logs
alias tdash="tmux \
  renamew dash \; \
  splitw -h \; \
  splitw -v \; \
  send-keys -t 0 C-z 'vw' Enter \; \
  send-keys -t 1 C-z 'ssh des-pi journalctl -u operator.service -f' Enter \; \
  send-keys -t 2 C-z 'showlogs horchdienst' Enter
"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
