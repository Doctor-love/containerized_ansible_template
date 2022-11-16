# SPDX-FileCopyrightText: 2022 Joel Rangsmo <joel@rangsmo.se>
# SPDX-License-Identifier: CC0-1.0

IMAGE_NAME := ansible_cm-$(shell basename ${PWD}):latest
# Use image inspect to ensure that specified image exist locally
RUN_BASE_PREFIX := docker image inspect ${IMAGE_NAME} 1> /dev/null && \
		   docker run \
		   --rm -i -t -v ${PWD}:/data \
		   -v ${HOME}/.ssh/known_hosts:/etc/ssh/ssh_known_hosts:ro \
		   -v ${SSH_AUTH_SOCK}:/agent.ssh -e SSH_AUTH_SOCK=/agent.ssh \
		   ${IMAGE_NAME}

.PHONY: build lint ping pre_deploy deploy post_deploy shell clean
all: build lint pre_deploy deploy post_deploy

build:
	docker build -t ${IMAGE_NAME} -f Containerfile --build-arg SHELL_PREFIX=${IMAGE_NAME} .

lint:
	${RUN_BASE_PREFIX} ansible-lint

ping:
	${RUN_BASE_PREFIX} ansible -i inventory.yml all -m ping

include pre_deploy.mk

deploy:
	${RUN_BASE_PREFIX} ansible-playbook -vv -i inventory.yml site.yml

include post_deploy.mk

shell:
	${RUN_BASE_PREFIX} bash

clean:
	docker image rm ${IMAGE_NAME}
