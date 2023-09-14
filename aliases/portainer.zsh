portainer() {
    usage () {
    echo "Usage:"
    echo "portainer start # Starts portainer"
    echo "portainer stop # Stops portainer"
  }
  start_portainer () {
    set -x
    docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name=portainer --restart=always --network=nginx-proxy-manager_npm -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest
  }

  stop_portainer () {
    set -x
    docker stop portainer
    docker rm portainer
    docker pull portainer/portainer-ee:latest
    start_portainer
  }

  if [ $# -ne 1 ]; then
      usage
      return
  fi

  case "$1" in
    -h | --help ) usage; return;;
    start ) start_portainer; return;;
    stop ) stop_portainer; return;;
    * ) usage; return;;
  esac



}