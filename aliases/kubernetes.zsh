#alias kubectl="kubecolor" # doesnt work with autocompletion 
#alias oc="env KUBECTL_COMMAND=oc kubecolor"
setk () {
  usage () {
    echo "Usage: setkube <kubeconfig>\n"
  }
  list_kubeconfigs () {
    echo "Available kubeconfigs:"
    bash -c "ls -1 $HOME/pjt/kubeconfigs | sed 's/^/ * /'"
  }
  if [ $# -ne 1 ]; then
    usage
    list_kubeconfigs
    return 1
  fi

  # check if the kubeconfig file exists
  if [ ! -f $HOME/pjt/kubeconfigs/$1 ]; then
    echo "Kubeconfig file $HOME/pjt/kubeconfigs/$1 does not exist\n"
    list_kubeconfigs
    return 1
  fi
  
  rm -f $HOME/pjt/kubeconfig && cp $HOME/pjt/kubeconfigs/$1 $HOME/pjt/kubeconfig

  echo "Kubeconfig set"
  echo "file:    $HOME/pjt/kubeconfigs/$1"
  echo "Server:  $(yq '.clusters[0].name' $HOME/pjt/kubeconfigs/$1)"
  echo "Address: $(yq '.clusters[0].cluster.server' $HOME/pjt/kubeconfigs/$1)"
}

getk () {
  if [ -f $KUBECONFIG ]; then
    echo "kubeconfig is in $KUBECONFIG:\n"
    cat $KUBECONFIG
    return 0
  else
    echo "No kubeconfig file found in $KUBECONFIG"
    return 1
  fi
}