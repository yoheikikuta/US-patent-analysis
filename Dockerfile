# Start with cuDNN base image
FROM ubuntu:16.04
MAINTAINER Yohei Kikuta <yohei-kikuta@cookpad.com>

# Install git, wget, bc and dependencies
RUN apt-get update && apt-get install -y \
  git \
  iproute2 \
  wget \
  python3.5 \
  python3-pip \
  python3-dev

# Install tensorflow and basics
ADD requirements.txt .
RUN pip3 install -r requirements.txt

# golang setup
RUN wget https://storage.googleapis.com/golang/go1.11.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.11.linux-amd64.tar.gz

# Add user of the name docker
RUN useradd docker -u 1000 -s /bin/bash -m
USER docker

# Set alias for python3.5
RUN echo "alias python=python3" >> $HOME/.bashrc && \
    echo "alias pip=pip3" >> $HOME/.bashrc

# Set environments and paths of golang
RUN mkdir -p ~/go/bin
RUN mkdir -p ~/bin
RUN echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
RUN echo 'export PATH=$PATH:$HOME/bin:$GOPATH/bin:/usr/local/go/bin' >> $HOME/.bashrc

# Set working directory
WORKDIR /work

ENTRYPOINT ["/bin/bash"]
