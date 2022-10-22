# ln -s ~/dotfiles/zsh_custom/aliases/aliases.zsh $ZSH_CUSTOM/aliases.zsh
search_dir=~/dotfiles/zsh_custom/aliases
for file in "$search_dir"/*
do
  if [[ "$file" = '/home/zmaster/dotfiles/zsh_custom/aliases/aliases.zsh' ]]; then
    continue
  fi
  source "$file"
done