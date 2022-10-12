FROM docker-env-core-2022-10-12-164697d:latest

ARG USERNAME=john.doe USERUID=1000 USERGID=1000
RUN sudo groupadd --gid ${USERGID} ${USERNAME} &&                                \
    sudo useradd --create-home ${USERNAME} --uid ${USERUID} --gid ${USERGID} &&  \
    FILENAME="/etc/sudoers.d/$(echo ${USERNAME} | tr . _)" &&                    \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" |                                 \
    sudo tee ${FILENAME} > /dev/null &&                                          \
    sudo chmod 440 ${FILENAME}
SHELL ["/bin/bash", "-c"]
USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN sed -i -e 's@#umask 022@umask 022@' /home/${USERNAME}/.profile && \
    sed -i -e '/^alias ll=/s@-alF@-lF@' /home/${USERNAME}/.bashrc &&  \
    echo "alias cls=clear" > /home/${USERNAME}/.bash_aliases

RUN git clone https://github.com/Microsoft/vcpkg.git ~/.vcpkg &&                                     \
    echo 'set(VCPKG_C_FLAGS "-D_GLIBCXX_USE_CXX11_ABI=0")'   >> ~/.vcpkg/triplets/x64-linux.cmake && \
    echo 'set(VCPKG_CXX_FLAGS "-D_GLIBCXX_USE_CXX11_ABI=0")' >> ~/.vcpkg/triplets/x64-linux.cmake && \
    echo 'set(VCPKG_BUILD_TYPE release)'                     >> ~/.vcpkg/triplets/x64-linux.cmake && \
    ~/.vcpkg/bootstrap-vcpkg.sh -disableMetrics

ARG PIP_MIRROR="https://repo.huaweicloud.com/repository/pypi/simple/"
ARG PIP_EXTRA_MIRRORS="https://pypi.tuna.tsinghua.edu.cn/simple/ https://mirrors.aliyun.com/pypi/simple/"
RUN python -m pip config set global.index-url "${PIP_MIRROR}" &&                                                  \
    python -m pip config set global.extra-index-url "${PIP_MIRROR} ${PIP_EXTRA_MIRRORS} https://pypi.org/simple/"

COPY .gitconfig /home/${USERNAME}/.gitconfig.in
COPY .vimrc /home/${USERNAME}/.vimrc
COPY .tmux.conf /home/${USERNAME}/.tmux.conf
COPY .local/bin/tmux /home/${USERNAME}/.local/bin/tmux

ARG GIT_USER_NAME=john GIT_USER_EMAIL=john.doe@example.com
RUN git config --global user.name ${GIT_USER_NAME} &&   \
    git config --global user.email ${GIT_USER_EMAIL} && \
    cat ~/.gitconfig.in >> ~/.gitconfig &&              \
    sudo rm ~/.gitconfig.in &&                          \
    sudo chown ${USERNAME}:${USERNAME} ~/.vimrc &&      \
    sudo chown ${USERNAME}:${USERNAME} ~/.tmux.conf &&  \
    sudo chown -R ${USERNAME}:${USERNAME} ~/.local
