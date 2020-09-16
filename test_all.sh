#!/bin/bash

ansible-playbook playbooks/b4t-cam.yml		&&
ansible-playbook playbooks/b4t.site.yml		&&
ansible-playbook playbooks/calculon.yml		&&
ansible-playbook playbooks/farnsworth.yml	&&
#ansible-playbook playbooks/flexo.yml		&&
ansible-playbook playbooks/hypnotoad.yml	&&
#ansible-playbook playbooks/nibbler.yml		&&
ansible-playbook playbooks/p0wer.yml		&&
ansible-playbook playbooks/pazuzu.yml		&&
ansible-playbook playbooks/rad10.yml		&&
ansible-playbook playbooks/seymour.yml		&&
ansible-playbook playbooks/zapp.yml		&&
ansible-playbook playbooks/zoidberg.yml
