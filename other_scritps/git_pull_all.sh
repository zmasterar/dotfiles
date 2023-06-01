#!/bin/bash

# crontab
# @reboot XDG_RUNTIME_DIR=/run/user/$(id -u) $HOME/git_pull_all.sh
# 5 7 * * 1-5 XDG_RUNTIME_DIR=/run/user/$(id -u) $HOME/git_pull_all.sh

export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/deploy"
path="$HOME/pjt"

handle_dismiss () {
  true
}

open_log () {
  code $HOME/git_pull_all.log &
}

echo $(date "+%Y-%m-%d %H:%M:%S") > $HOME/git_pull_all.log 2>&1
cd $path
find . -type d -name .git -exec bash -c "echo {} && git --git-dir={} --work-tree=$PWD/{}/.. fetch --all && echo" \; >> $HOME/git_pull_all.log 2>&1

ACTION=$(/usr/bin/dunstify --action="default,Open Log" --action="open_log,Open Log" -h string:x-dunst-stack-tag:gpl "git pull all" "Executed git pull all! \n $(date "+%d/%b/%Y %H:%M:%S")")
case "$ACTION" in
"default")
    open_log
    ;;
"open_log")
    open_log
    ;;
"2")
    handle_dismiss
    ;;
esac

