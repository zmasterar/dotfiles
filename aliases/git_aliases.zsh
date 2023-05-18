gla() {
  export GIT_SSH_COMMAND="ssh -i $HOME/.ssh/deploy"

  cd $HOME
  find . -type d -name .git -exec bash -c "echo {} && git --git-dir={} --work-tree=$PWD/{}/.. fetch --all && echo" \;
  cd -
}
