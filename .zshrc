##############################################################################
# Env Vars
##############################################################################
export EDITOR=vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/bin/go:$GOPATH/bin

export ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"

###############################################################################
# Functions
###############################################################################
# set terminal title
function repo_name {
  git remote -v 2> /dev/null | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//'
}

function precmd {
  echo -ne "\033]0;$(repo_name)\007"
}

function deployoperator {
  ssh des-pi 'sudo service operator stop' && scp bin/operator des-pi:operator && ssh des-pi 'sudo service operator start'
}

# Show aws logs using awslogs
showlogs() {
  awslogs get /aws/lambda/$1 ALL --watch
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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

##############################################################################
# Aliases
##############################################################################
alias dev="cd $HOME/dev"
alias starry="cd $HOME/dev/starry"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias admin="starry && cd admin-api-v2"
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias vw='vim -c VimwikiIndex'
alias gs='git status'

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
