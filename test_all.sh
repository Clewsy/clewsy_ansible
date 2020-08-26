#!/bin/bash

ansible-playbook b4t-cam.yml	&&
ansible-playbook b4t.site.yml	&&
ansible-playbook calculon.yml	&&
ansible-playbook farnsworth.yml	&&
#ansible-playbook flexo.yml	&&
ansible-playbook hypnotoad.yml	&&
#ansible-playbook nibbler.yml	&&
ansible-playbook p0wer.yml	&&
ansible-playbook pazuzu.yml	&&
ansible-playbook rad10.yml	&&
ansible-playbook seymour.yml	&&
ansible-playbook zapp.yml	&&
ansible-playbook zoidberg.yml
