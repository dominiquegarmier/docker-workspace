FROM ubuntu

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=Europe/Zurich

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
    ripgrep \
    snapd \
    software-properties-common \
    sudo \
    tmux \
    tree \
    tzdata \ 
    unzip \
    wget \
    xclip \
    zip \
    zsh \
    && :

# python related deps
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    black \
    flake8 \
    isort \
    python3-venv \
    python3-pip \
    python3-virtualenv \
    python3.9 \
    python3.10 \ 
    python3.11 \
    python3.12 \
    python3.13 \
    && :

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install
RUN rm -rf /root/TMP

ADD https://github.com/dominiquegarmier/.config-nvim.git /root/.config/nvim
RUN npm install -g pyright 

ENV ZSH_CUSTOM=/root/.oh-my-zsh/custom
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
RUN git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

COPY config/.bashrc /root/.bashrc
COPY config/.gitconfig /root/.gitconfig
COPY config/.zshrc /root/.zshrc
COPY config/.gitconfig /root/.gitconfig
COPY config/.gitignore /root/.gitignore
COPY config/.p10k.zsh /root/.p10k.zsh

WORKDIR /workspace

ENTRYPOINT ["/bin/zsh"]
