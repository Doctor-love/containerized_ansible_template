# SPDX-FileCopyrightText: 2022 Joel Rangsmo <joel@rangsmo.se>
# SPDX-License-Identifier: CC0-1.0
FROM python:3.9.15

ARG SHELL_PREFIX=ansible_cm
RUN echo PS1=\"${SHELL_PREFIX} \\w: \" >> /etc/bash.bashrc

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY galaxy_dependencies.yml .
RUN ansible-galaxy install -r galaxy_dependencies.yml

RUN useradd -d /tmp cm
USER cm
WORKDIR /data
