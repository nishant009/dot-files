export PATH="/usr/local/bin/python:$PATH"

# include .bashrc if it exists
if [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi

# Load in the git branch prompt script.
source ~/Scripts/.git-prompt.sh

# Pretty prompt for git
red=$(tput setaf 1) # \e[31m
yellow=$(tput setaf 3) # \e[33m
reset=$(tput setaf 2) # \e[32m
PS1="[\u@\h]\[$red\]\w\[$yellow\]\$(__git_ps1)\[$reset\]\$ "

# unix aliases
alias ls='ls -lshG'
alias lsh='ls -lsahG'
alias tmux_list='tmux ls'
alias tmux_att='tmux att -t'
alias tmux_new='tmux new -s'

# git aliases
alias logl='git log'
alias gst='git status'
alias co='git checkout'
alias coa='git checkout .'
alias br='git branch'
alias br_del='git branch -D'
alias br_loc='git branch -v'
alias br_remote='git branch -r'
alias stash='git stash'
alias show='git stash show'
alias drop='git stash drop'
alias pop='git stash pop'
alias rebc='git rebase --continue'
alias rebi='git rebase -i'
alias add='git add -i'
alias adda='git add -A'
alias amend='git commit --amend'
alias amenda='git commit -a --amend'
alias commit='git commit'
alias commita='git commit -a'
alias log='git log --oneline'
alias fetch='git fetch -p'
alias check='git diff --check'
alias push='git push origin HEAD'
alias pushf='git push -f origin HEAD'
alias pull_master='git fetch origin && git checkout master && git pull --ff-only origin master'
alias merge='git merge --no-ff --no-commit'
alias clean='git clean -f'

# utility aliases
alias bckup='~/Scripts/backup.sh ~/Backup filenames'
alias rm_bckup='rm -rf ~/Backup/*'
alias list_bckup='ls ~/Backup'
alias restore='~/Scripts/restore.sh ~/Backup filenames'

# ruby aliases
alias be='bundle exec'
alias console='bundle exec rails console'
alias sandbox='bundle exec rails console -s'
alias server='bundle exec rails s'
alias migrate='bundle exec rails g migration'

# node aliases
alias ninst='npm install'
alias nst='npm run start'
alias ntst='npm run test'
alias nlnt='npm run lint'

# docker commands
alias dhost="bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
alias dm='docker-machine ip'
alias dimg='docker images'
alias dps='docker ps -a'
alias dstop='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dbuild='docker build -t'
alias druni='docker run --rm -t -i'
alias drund='docker run -d'
alias dexec='docker exec -t -i'
alias dlog='docker logs'
alias dcps='docker-compose ps'
alias dcstop='docker-compose down'
alias dcrm='docker-compose rm'
alias dcbuild='docker-compose build'
alias dcrun='docker-compose up'
alias dcrund='docker-compose up -d'

