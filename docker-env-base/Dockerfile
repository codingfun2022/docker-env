FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ARG APT_MIRROR=http://repo.huaweicloud.com/
RUN sed -i -e "s@http://.*\(archive\|security\).ubuntu.com/@${APT_MIRROR}@g" /etc/apt/sources.list && \
    apt-get update &&                                                                                 \
    apt-get upgrade -y &&                                                                             \
    apt-get install -y apt-utils &&                                                                   \
    apt-get install -y software-properties-common

ARG LOCALE_GEN=en_US.UTF-8
RUN apt-get install -y locales &&                         \
    sed -i -e "/en_US.UTF-8/s@^# @@" /etc/locale.gen &&   \
    sed -i -e "/${LOCALE_GEN}/s@^# @@" /etc/locale.gen && \
    locale-gen
ARG LANG LANGUAGE LC_ALL
ENV LANG=${LANG:-en_US.UTF-8} LANGUAGE=${LANGUAGE:-en_US:en} LC_ALL=${LC_ALL:-en_US.UTF-8}

ARG LOCALTIME=Asia/Shanghai
RUN ln -svf /usr/share/zoneinfo/${LOCALTIME} /etc/localtime && \
    apt-get install -y tzdata
ARG TZ
ENV TZ=${TZ:-${LOCALTIME}}
