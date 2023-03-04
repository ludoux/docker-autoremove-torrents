FROM python:3.8.5-slim

ARG GIT_REPO='https://gitee.com/ludoux/autoremove-torrents.git'
ARG BRANCH='master'

WORKDIR /app

RUN sed -i s/deb.debian.org/mirrors.bfsu.edu.cn/g /etc/apt/sources.list && sed -i s/security.debian.org/mirrors.bfsu.edu.cn/g /etc/apt/sources.list && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

RUN apt-get update \
&& apt-get install git gcc cron -y -q \
&& python -m pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple -U pip \
&& pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
&& pip config set install.trusted-host mirrors.bfsu.edu.cn \
&& git clone $GIT_REPO && cd autoremove-torrents && git checkout $BRANCH && python3 setup.py install \
&& rm -rf .cache/pip \
&& apt-get purge gcc git -y \
&& apt-get clean

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

COPY config.example.yml config.yml

ENV OPTS '-c /app/config.yml'
ENV CRON '*/5 * * * *'
ENV TZ Asia/Shanghai

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
