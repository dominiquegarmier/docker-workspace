FROM ubuntu

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    fd-find \
    fzf \
    gettext \
    git \
    jq \
    luarocks \
    ninja-build \
    python3.12 \
    ripgrep \
    snapd \
    sudo \
    unzip \
    wget \
    && :

# install neovim
WORKDIR /tmp/neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
RUN tar xzf nvim-linux-x86_64.tar.gz
RUN chmod +x nvim-linux-x86_64/bin/nvim
RUN mv nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
ADD https://github.com/dominiquegarmier/.config-nvim.git /root/.config/nvim

RUN curl -LsSf https://astral.sh/uv/install.sh | sh



WORKDIR /workspace
