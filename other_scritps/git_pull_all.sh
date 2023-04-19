#!/bin/bash
path="$HOME/pjt"

/usr/bin/notify-send "git pull all" "Executed git pull all! \n $(date "+%d/%b/%Y %H:%M:%S")"
echo $(date "+%Y-%m-%d %H:%M:%S") > $HOME/pjt/git_pull_all.log 2>&1
eval `ssh-agent -s` && ssh-add "$HOME/.ssh/deploy" && ssh-add -l
cd $path && find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \; >> $HOME/pjt/git_pull_all.log 2>&1