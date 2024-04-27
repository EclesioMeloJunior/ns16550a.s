FROM ubuntu:latest

ARG VERSION="1.21.4"
ARG ARCH="amd64"

RUN apt-get update && \
    apt-get install -y sudo wget curl git-core autoconf automake \
    autotools-dev curl python3 python3-pip libmpc-dev \
    libmpfr-dev libgmp-dev gawk build-essential bison \
    flex texinfo gperf libtool patchutils bc zlib1g-dev \
    libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev \
    device-tree-compiler qemu-system

RUN git clone https://github.com/riscv/riscv-gnu-toolchain && \
    cd riscv-gnu-toolchain && ./configure --prefix=/opt/riscv && make linux

RUN wget -L "https://golang.org/dl/go${VERSION}.linux-${ARCH}.tar.gz"
RUN tar -xf "go${VERSION}.linux-${ARCH}.tar.gz" && \
    sudo chown -R root:root ./go && sudo mv -v go /usr/local
RUN sudo echo "export GOPATH=$HOME/go" >> ~/.bashrc
RUN sudo echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:/opt/riscv/bin/" >> ~/.bashrc

