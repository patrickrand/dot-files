dropmic() {
    docker rm -f $(docker ps -a -q)
    docker rmi -f $(docker images -q)
    docker rmi -f $(docker images -q --filter "dangling=true")
    docker volume rm $(docker volume ls -q)
}
