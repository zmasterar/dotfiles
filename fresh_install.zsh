set -x

# Ensure sudo
sudo true

mkdir -p $HOME/.ssh
chmod  0700 $HOME/.ssh
# For reference, private keys must have 0600 permissions

mkdir -p $HOME/.local/bin

sudo add-apt-repository -y ppa:mattrose/terminator
sudo apt update && sudo apt install -y terminator zsh git curl tmux wireguard jq vim

if [ ! -d $HOME/dotfiles ]; then
  git clone https://github.com/zmasterar/dotfiles.git $HOME/dotfiles
fi

#Ruby, Node and Python build dependencies
sudo apt install -y autoconf build-essential libbz2-dev libdb-dev libffi-dev libgdbm-dev libgdbm6 libgmp-dev liblzma-dev libncurses5-dev libncursesw5-dev libreadline-dev libreadline6-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev libyaml-dev patch rustc tk-dev uuid-dev xz-utils zlib1g-dev dirmngr gpg gawk libpq-dev

sudo chsh -s $(which zsh) $(whoami)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Makes a symbolic link in for every file in base_dot_files directory
for file in $(find $HOME/dotfiles/base_dot_files -type f -printf "%f\n"); do 
  ln -f -s $HOME/dotfiles/base_dot_files/$file $HOME/.$file
done

ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
# Script aliases.zsh sources all files inside aliases directory
ln -f -s $HOME/dotfiles/aliases/aliases.zsh $ZSH_CUSTOM/aliases.zsh

# Makes a symbolic link for every file in zsh_custom directory
for file in $(find $HOME/dotfiles/zsh_custom -maxdepth 1 -type f -printf "%f\n"); do 
  ln -f -s $HOME/dotfiles/zsh_custom/$file $ZSH_CUSTOM/$file
done

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim -es +PluginInstall +qall

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install kubecolor

# mise
curl https://mise.run | sh
eval "$(~/.local/bin/mise activate zsh)"
mise install ruby@latest node@latest python@latest
mise use --global ruby@latest node@latest python@latest

mise exec -- npm -g install yarn

mise exec -- gem update --system

mise exec -- gem install rails
mise exec -- gem install foreman

# Install colorls gem and color theme
if ! mise exec -- gem list colorls -i --silent; then
  mise exec -- gem install colorls -N
fi

mkdir -p $HOME/.config/colorls
ln -f -s $HOME/dotfiles/other_scripts/dark_colors.yaml $HOME/.config/colorls/dark_colors.yaml
mkdir -p $HOME/.config/terminator
ln -f -s $HOME/dotfiles/other_scripts/terminator.config $HOME/.config/terminator/config


git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
git clone https://github.com/bobthecow/git-flow-completion $ZSH_CUSTOM/plugins/git-flow-completion
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/jimeh/tmux-themepack.git $HOME/.tmux-themepack

mkdir $HOME/.fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mv *.ttf $HOME/.fonts

