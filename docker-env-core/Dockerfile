FROM docker-env-base-2022-10-12-8d382be:latest

RUN apt-get install -y sudo &&                                                   \
    sed -i -e 's@env_reset@env_keep = "http_proxy https_proxy"@' /etc/sudoers && \
    sed -i -e 's@^root.*$@root ALL=(ALL) NOPASSWD: ALL@' /etc/sudoers

RUN sudo apt-get install -y curl wget git vim tmux cron tar zip unzip
RUN sudo apt-get install -y build-essential gdb pkg-config flex bison
RUN sudo apt-get install -y jq rlwrap libreadline-dev

ARG PIP_MIRROR="https://repo.huaweicloud.com/repository/pypi/simple/"
ARG PIP_EXTRA_MIRRORS="https://pypi.tuna.tsinghua.edu.cn/simple/ https://mirrors.aliyun.com/pypi/simple/"
RUN sudo apt-get install -y python3 python3-venv python3-pip python-is-python3 &&                                         \
    sudo python -m pip config set global.index-url "${PIP_MIRROR}" &&                                                     \
    sudo python -m pip config set global.extra-index-url "${PIP_MIRROR} ${PIP_EXTRA_MIRRORS} https://pypi.org/simple/" && \
    sudo python -m pip install awscli==1.22.76 awscli-plugin-endpoint~=0.4

ARG LAUNCHPAD_MIRROR=https://launchpad.proxy.ustclug.org
RUN sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test &&                         \
    sudo sed -i -e "s@http://ppa.launchpad.net@${LAUNCHPAD_MIRROR}@"                  \
         /etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-focal.list &&         \
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EA8CACC073C3DB2A && \
    sudo apt-get update &&                                                            \
    sudo apt-get upgrade -y &&                                                        \
    sudo apt-get install -y gcc-11 g++-11 &&                                          \
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90             \
         --slave /usr/bin/g++ g++ /usr/bin/g++-9                                      \
         --slave /usr/bin/gcov gcov /usr/bin/gcov-9                                   \
         --slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-9                             \
         --slave /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-9 &&              \
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 110           \
         --slave /usr/bin/g++ g++ /usr/bin/g++-11                                     \
         --slave /usr/bin/gcov gcov /usr/bin/gcov-11                                  \
         --slave /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-11                            \
         --slave /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-11

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2> /dev/null |         \
         gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg > /dev/null &&        \
    sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && \
    sudo apt-get update &&                                                                   \
    sudo apt-get upgrade -y &&                                                               \
    sudo apt-get install -y cmake &&                                                         \
    sudo apt-get install -y ninja-build

ARG LLVM_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/llvm-apt
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - &&               \
    sudo add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-14 main" &&   \
    sudo sed -i -e "s@http://apt.llvm.org@${LLVM_MIRROR}@" /etc/apt/sources.list &&            \
    sudo apt-get update &&                                                                     \
    sudo apt-get upgrade -y &&                                                                 \
    sudo apt-get install -y clang-14 libc++-14-dev libc++abi-14-dev lldb-14 python3-lldb-14 && \
    sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 140              \
         --slave /usr/bin/clang++ clang++ /usr/bin/clang++-14                                  \
         --slave /usr/bin/llc llc /usr/bin/llc-14                                              \
         --slave /usr/bin/lli lli /usr/bin/lli-14                                              \
         --slave /usr/bin/lldb lldb /usr/bin/lldb-14 &&                                        \
    echo 'alias lldb="PYTHONPATH=/usr/lib/llvm-14/lib/python3.8/site-packages lldb"' |         \
    sudo tee /etc/profile.d/lldb-alias.sh > /dev/null

RUN sudo apt-get install -y default-jdk

ARG DOTNET_VERSION=6.0
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb &&                                                                           \
    rm packages-microsoft-prod.deb &&                                                                                     \
    sudo apt-get update &&                                                                                                \
    sudo apt-get install -y dotnet-sdk-${DOTNET_VERSION}

ARG GO_VERSION=1.19.2
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    sudo tar -xf go${GO_VERSION}.linux-amd64.tar.gz -C /usr/local && \
    rm go${GO_VERSION}.linux-amd64.tar.gz &&                         \
    echo 'export PATH=/usr/local/go/bin:${PATH}' |                   \
    sudo tee /etc/profile.d/go-bin-path.sh > /dev/null

ARG RUST_VERSION=1.64.0
RUN wget https://static.rust-lang.org/dist/rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xf rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz &&                                \
    sudo ./rust-${RUST_VERSION}-x86_64-unknown-linux-gnu/install.sh --prefix=/usr/local/rust &&    \
    rm -rf rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz &&                                 \
    rm -rf rust-${RUST_VERSION}-x86_64-unknown-linux-gnu &&                                        \
    echo 'export PATH=/usr/local/rust/bin:${PATH}' |                                               \
    sudo tee /etc/profile.d/rust-bin-path.sh > /dev/null
