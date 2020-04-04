FROM quay.io/openshift/origin-jenkins-agent-base:4.2

EXPOSE 8080

ENV PYTHON_VERSION=3.6 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PIP_NO_CACHE_DIR=off \
    GECKO_VERSION=v0.26.0

ADD contrib/bin/ubi.repo /etc/yum.repos.d/ubi.repo
ADD contrib/bin/epel.repo /etc/yum.repos.d/epel.repo
ADD contrib/bin/epel-testing.repo /etc/yum.repos.d/epel-testing.repo
ADD contrib/bin/getpagespeed-extras.repo /etc/yum.repos.d/epel-testing.repo
ADD contrib/bin/scl_enable /usr/share/container-scripts/

RUN chmod +x scripts/bootstrap.sh && scripts/bootstrap.sh

ENV BASH_ENV=/usr/share/container-scripts/scl_enable \
    ENV=/usr/share/container-scripts/scl_enable \
    PROMPT_COMMAND=". /usr/share/container-scripts/scl_enable"

RUN chown -R 1001:0 $HOME && \
  chomod -R g+rw $HOME

USER 1001
