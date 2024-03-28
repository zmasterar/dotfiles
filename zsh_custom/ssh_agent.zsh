# ln -s ~/dotfiles/zsh_custom/ssh_agent.zsh $ZSH_CUSTOM/ssh_agent.zsh
#Full instructions in https://stackoverflow.com/a/45562886/2505759

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  # echo "Initializing new SSH agent..."
  touch $SSH_ENV
  chmod 600 "${SSH_ENV}"
  eval '/usr/bin/ssh-agent' | sed 's/^echo/#echo/' >> "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  # /usr/bin/ssh-add
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  kill -0 $SSH_AGENT_PID 2>/dev/null || {
  start_agent
}
else
  start_agent
fi