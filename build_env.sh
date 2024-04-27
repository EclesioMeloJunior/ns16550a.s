docker build --rm -f Dockerfile -t ubuntu:uart-driver .
docker run --rm -it --network host -v `pwd`:/developer ubuntu:uart-driver
