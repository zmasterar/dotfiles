drl () {
  port=""; environment=""; port_argument=""; env_filename=".env.develop"; container_name=${PWD##*/}

  while getopts p:e: flag; do
    case "${flag}" in
        p) port=${OPTARG};;
        e) environment=${OPTARG};;
    esac
  done

  if [ "$port" != "" ]; then
    port_argument="-p $port:$port"
  fi

  if [ "$environment" != "" ]; then
    env_filename=".env.$environment"
  fi

  command="docker build --no-cache -t $container_name -f docker/Dockerfile --build-arg \"ENV_FILENAME=$env_filename\" . && docker run $port_argument --rm --name $container_name $container_name && docker rmi $container_name"
  echo "Command: $command\n"
  eval $command
}
