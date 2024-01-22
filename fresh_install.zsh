set -x

# Ensure sudo
sudo true

mkdir -p $HOME/.ssh
chmod  0700 $HOME/.ssh
# For reference, private keys must have 0600 permissions

sudo apt update && sudo apt install -y zsh curl tmux wireguard jq
sudo snap install bw

sudo chsh -s $(which zsh) $(whoami)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Makes a symbolic link in for every file in base_dot_files directory
for file in $(find ./base_dot_files -type f -printf "%f\n"); do 
  ln -f -s $HOME/dotfiles/base_dot_files/$file $HOME/.$file
done

ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
# Script aliases.zsh sources all files inside aliases directory
ln -f -s $HOME/dotfiles/aliases/aliases.zsh $ZSH_CUSTOM/aliases.zsh

# Makes a symbolic link for every file in zsh_custom directory
for file in $(find ./zsh_custom -maxdepth 1 -type f -printf "%f\n"); do 
  ln -f -s $HOME/dotfiles/zsh_custom/$file $ZSH_CUSTOM/$file
done

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
sudo apt install -y autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
# Install latest Stable Ruby
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)

# Install colorls gem and color theme
if ! gem list colorls -i --silent; then
  gem install colorls -N
fi

mkdir $HOME/.config
ln -f -s $HOME/dotfiles/other_scripts/dark_colors.yaml $HOME/.config/colorls


git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
git clone https://github.com/bobthecow/git-flow-completion $ZSH_CUSTOM/plugins/git-flow-completion
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
