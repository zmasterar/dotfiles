alias wgstart='sudo systemctl start wg-quick@wg0.service'
alias wgup='wgstart'
alias wgstop='sudo systemctl stop wg-quick@wg0.service'
alias wgdown='wgstop'
alias wgenable='sudo systemctl enable wg-quick@wg0.service'
alias wgdisable='sudo systemctl disable wg-quick@wg0.service'
alias wgstatus='sudo systemctl status wg-quick@wg0.service'

def setvpn() {
  if [[ $# -ne 1 ]]; then 
    echo "Must have one argument"
    echo "Use example:"
    echo "setvnp profilename"
    return
  fi

  profile=$1
  wireguard_path="/etc/wireguard"
  profile_path=$wireguard_path/$profile.conf
  wireguard_conf=$wireguard_path/wg0.conf
  wireguard_conf_backup=$wireguard_path/wg0.conf.bak


  if [[ ! -f "$profile_path" ]]; then
    echo "Profile file $profile_path does not exist."
    return
  fi

  if sudo test -L $wireguard_conf ; then
    echo "Wireguard has a symbolic link for config. Replacing old config with a symbolic link for $profile."
    sudo rm $wireguard_conf
  elif sudo test -f $wireguard_conf ; then
    echo "Wireguard config is not a symbolic link. A backup of the original file will be saved in $wireguard_conf_backup."
    sudo mv $wireguard_conf $wireguard_conf_backup
  else
    echo "No default Wireguard config. Creating symbolic link for $profile."
  fi
  
  sudo ln -s $profile_path $wireguard_conf
}