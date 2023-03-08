# ln -s ~/dotfiles/zsh_custom/aliases/aliases.zsh $ZSH_CUSTOM/aliases.zsh
search_dir=~/dotfiles/zsh_custom/aliases
for file in "$search_dir"/* 
do 
  filename=$(basename -- "$file")
  if [[ "$filename" = "aliases.zsh" ]]; then
    continue
  fi
  source $file
done