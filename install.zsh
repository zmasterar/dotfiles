set -x

# Makes a symbolic link in for every file in base_dot_files directory
for file in $(find ./base_dot_files -type f -printf "%f\n"); do 
  ln -f -s $HOME/dotfiles/base_dot_files/$file $HOME/.$file
done

# Script aliases.zsh sources all files inside aliases directory
ln -f -s $HOME/dotfiles/aliases/aliases.zsh $ZSH_CUSTOM/aliases.zsh

# Makes a symbolic link for every file in zsh_custom directory
ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
for file in $(find ./zsh_custom -maxdepth 1 -type f -printf "%f\n"); do 
  ln -f -s $HOME/dotfiles/zsh_custom/$file $ZSH_CUSTOM/$file
done

# Install colorls gem and color theme
if ! gem list colorls -i --silent; then
  gem install colorls -N
fi
ln -f -s $HOME/dotfiles/other_scripts/dark_colors.yaml $HOME/.config/colorls