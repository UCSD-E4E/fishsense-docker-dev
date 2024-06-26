FROM ubuntu:noble

RUN apt-get update
RUN apt-get install -y build-essential \
                            git \
                            libssl-dev \
                            zlib1g-dev \
                            libbz2-dev \
                            libreadline-dev \
                            libsqlite3-dev \
                            wget \
                            curl \
                            llvm \
                            libncurses5-dev \
                            libncursesw5-dev \
                            xz-utils \
                            tk-dev \
                            libffi-dev \
                            liblzma-dev \
                            python3-openssl \
                            libopencv-dev \
                            clang \
                            libclang-dev
                            # git-annex \
                            # pipx

USER ubuntu

ENV HOME="/home/ubuntu"
RUN mkdir -p ${HOME}
WORKDIR ${HOME}
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

RUN pyenv install 3.11
RUN pyenv global 3.11
RUN pip install --upgrade pip
RUN pip install poetry

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

# RUN pipx install git+https://github.com/UCSD-E4E/git-annex-remote-synology.git