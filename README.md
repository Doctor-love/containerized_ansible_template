<!--
SPDX-FileCopyrightText: 2022 Joel Rangsmo <joel@rangsmo.se>
SPDX-License-Identifier: CC0-1.0
-->

# containerized_ansible_template

## Introduction
We've containerised most complex software out there, so why not Ansible? The purpose of this
template repository is to help users/teams consistently run the Ansible command-line tools by
installing and executing the software in a container image. The user's ssh-agent is forwarded into
the container, which enables authentication against target hosts.


## Prerequisites
- GNU Make
- Docker (Podman should probably also work)
- Running instance of ssh-agent


## Usage
Populate "requirements.txt" and "galaxy_dependencies.yml" with any dependencies your Ansible
roles/playbooks may need. Fill "inventory.yml" with hosts and "site.yml" with a playbook. If you so
desire, add additional Makefile targets in "pre_deploy.mk" and "post_deploy.mk" to hook trigger
local actions before/after the playbook has been executed.  
  
Take a peek inside "Makefile" to see what the targets do. Execute "make" and observe the glory!


## License
All the template files are licensed under
[CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/) - feel free to use them however you
want!
