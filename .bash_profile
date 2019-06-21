alias g="git"
alias co="git checkout"
alias commit="git commit"
alias push="git push"
alias gs="git status"
alias gb="git branch"
alias pull="git pull"
alias docs="cd /Users/dpreston/documents"
alias starry="cd /Users/dpreston/documents/starry"
alias start-mongo="docker run -d -p 27017:27017 mongo=3.4.9"
alias test="npm test"

export NVM_DIR="/Users/dpreston/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

function parse_git_branch {
  NUM_OF_CHANGES=$( git status -s 2> /dev/null | wc -l )

  if [ $NUM_OF_CHANGES -gt 0 ]
  then
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)* /'
  else
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
  fi
}

export PS1="\w \[$(tput sgr0)\]\[\033[0;32m\]\$(parse_git_branch)\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[1;31m\]❯$(tput sgr0) "
export GPG_TTY=$(tty)

# set terminal title
function repo_name {
  git remote -v 2> /dev/null | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//'
}

export PROMPT_COMMAND='echo -ne "\033]0;$(repo_name)\007"'

export PATH="$HOME/.cargo/bin:$PATH"
