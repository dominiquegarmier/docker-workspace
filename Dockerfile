FROM ubuntu

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    automake \
    build-essential \
    cmake \
    curl \
    fd-find \
    fzf \
    gettext \
    git \
    g++ \
    jq \
    libtool \
    libtool-bin \
    luarocks \
    ninja-build \
    nodejs \
    npm \
    python3.12 \
    python3-pip \
    ripgrep \
    snapd \
    sudo \
    tree \
    tzdata \ 
    unzip \
    wget \
    xclip \
    zip \
    && :

RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install
RUN rm -rf /root/TMP

WORKDIR /root
ADD https://github.com/dominiquegarmier/.config-nvim.git /root/.config/nvim
RUN npm install -g pyright 

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

