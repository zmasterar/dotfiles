#!/bin/zsh

set -e

copy_data () {
  local id=$1
  local login=$2
  local sessionkey=$3
  local totp

  echo "Name: $(jq -r ".name" <<< $login)"

  # Copy the username to the clipboard
  echo "> Copying Username"
  jq -r ".login.username" <<< $login | xclip -selection clipboard

  # Wait for user input before coping the password
  echo "> Press any key to copy password..."
  read

  # Copy the password to the clipboard
  echo "> Copying Password"
  jq -r ".login.password" <<< $login | xclip -selection clipboard

  # Copy a TOTP Token if available
  totp=$(jq -r ".login.totp" <<< $login)

  if [[ $totp != "null" ]]; then
    # Wait for user input before coping the totp token
    echo "> Press any key to copy TOTP Token..."
    read
    echo "> Copying TOTP Token"
    bw get totp $id --session $sessionkey | xclip -selection clipboard
  fi
}

main() {
  local searchterm=$1
  local sessionkey logins login id

  #Unlock the vault an store the session key
  sessionkey=$(bw unlock --raw)

  # Search for passwords using the search term
  logins=$(bw list items --search $searchterm --session $sessionkey)

  id=$(jq -r '.[] | "\(.name)\t\(.login.username)\t\(.id)"' <<< $logins \
    | fzf --reverse --with-nth=1,2 --delimiter="\t" --select-1 --exit-0 \
    | awk -F"\t" '{print $3}'
  )

  if [[ -n $id ]]; then
    login="$(jq ".[] | select(.id == \"$id\")" <<< $logins)"
    copy_data $id $login $sessionkey
  fi
}

main "$@"