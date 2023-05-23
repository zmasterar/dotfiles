#!/bin/bash

# crontab
# @reboot XDG_RUNTIME_DIR=/run/user/$(id -u) $HOME/git_pull_all.sh
# 5 7 * * 1-5 XDG_RUNTIME_DIR=/run/user/$(id -u) $HOME/git_pull_all.sh

export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/deploy"
path="$HOME"

/usr/bin/notify-send "git pull all" "Executed git pull all! \n $(date "+%d/%b/%Y %H:%M:%S")"
echo $(date "+%Y-%m-%d %H:%M:%S") > $HOME/git_pull_all.log 2>&1
cd $path
find . -type d -name .git -exec bash -c "echo {} && git --git-dir={} --work-tree=$PWD/{}/.. fetch --all && echo" \; >> $HOME/git_pull_all.log 2>&1

