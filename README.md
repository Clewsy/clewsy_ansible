# clewsy_ansible

Basic automation playbooks and roles for deploying machines on my home network.  Super handy when nuking/paving, but originally this project just started as a means of learning [ansible][link_web_ansible].

A playbook and variables file exists for each host machine.  When run, the host-specific playbook will configure the host with the specified roles described below.  Prior to running the host-specific playbooks, some minimum requirements must be met:
1. Operating system installed .
2. User exists as defined in host variables file (*host_vars/hostname.yml*).
	* User must have sudo access.
	* Sudo password must be as defined by the host-specific *setup-password* variabe.
3. Static IP must be assigned to the MAC address of the machine's network interface.  A hosts file on my dhcp server is used so all these machines are identified by hostname, not ip address.

## Roles

|Role/Link					|Desctiption|
|-----------------------------------------------|-----------|
|[clews.pro][link_repo_clews.pro] 		|Will configure a box as a containerised web server, clone the [clews.pro][link_gitlab_clewsy_clews.pro] repo, and spin up the containers defined in the docker-compose.yml file. |
|[common][link_repo_common]			|Configurations common to all hosts - hostname, timezone, ssh keys/configs, apt upgrades, common packages, vim, git, host-specific packages, motd, .bashrc, aliases, cron jobs, mounts/fstab, common scripts ([bu][link_gitlab_clewsy_scripts_bu], [stuff][link_gitlab_clewsy_scripts_stuff], [wami][link_gitlab_clewsy_scripts_wami]). |
|[desktop][link_repo_desktop]			|Configurations for systems with a desktop - fonts, [conky][link_web_conky], [terbling][link_gitlab_clewsy_scripts_terbling], [terminator][link_web_terminator], [guake][link_web_guake], gnome settings. |
|[docker][link_repo_docker]			|Install [docker][link_web_docker] and [docker-compose][link_web_docker-compose].  Start the docker service and create a standard docker-compose staging directory.  Also create alias dc='docker-compose'. |
|[homeassistant][link_repo_homeassistant]	|First configure docker role as a pre-requisite.  Then install/remove certain packages as required by the [home assistant supervised installer script][link_web_home_assistant_supervised_installer].  Finally download and run the installer script that will install [home assistant supervised][link_web_home_assistant] |
|[motion][link_repo_motion]			|Turn a raspberry pi into a web-cam.  Install configure and enable [motion][link_web_motion] for streaming over the lan. |
|[mpd][link_repo_mpd]				|Use on boxes that will be used for streaming audio or playing mp3s.  Install the required and useful packages ([mpd][link_web_mpd], [mpc][link_web_mpc], [ncmpc][link_web_ncmpc]) then configure and run the mpd daemon. |
|[node][link_repo_node]				|Set up some common packages and scripts on key boxes that are used for maintaining other boxes.  Install networking packages ([netdiscover][link_web_netdiscover], [nmap][link_web_nmap]), install [ansible][link_web_ansible], clone this repository and install some custom scripts ([apt_all][link_gitlab_clewsy_scripts_apt_all], [ball][link_gitlab_clewsy_scripts_ball], [pong][link_gitlab_clewsy_scripts_pong], [whodis][link_gitlab_clewsy_scripts_whodis]). |
|[p0wer][link_repo_p0wer]			|Configure a raspberry pi with gpio connected to an rf remote control used to switch on or off mains-connected devices from scripts or a webui.  Clone [p0wer repo][link_gitlab_clewsy_p0wer], compile executable, install webserver packages and copy htmp/php files. |
|[polly][link_repo_polly]			|Configue a box to control a [thingm blink1][link_web_blink1] device, then install [polly][link_gitlab_clewsy_scripts_polly] script which polls [clews.pro][link_clews], logs the result and uses the blink1 to indicate the site status. |
|[qbittorrent][link_repo_qbittorrent]		|Install and configure [qbittorrent][link_web_qbittorrent] client.  This is installed as a docker container so forst the docker role is run, then a docker-compose.yml file is copied and used to pull and run the [qbittorrent container][link_dockerhub_qbittorrent]. |
|[rad10][link_repo_rad10]			|Configure a raspberry pi as an internet radio/music streamer with hardware control and a webui.  First run the mpd role, then clone [rad10d repo][link_gitlab_clewsy_rad10d], compile the daemon and configure a unit-file for auto-starting.  Will also install web server packages and copy the html/php files for the rad10 webui. |
|[secure][link_repo_secure]			|Configure some basic settings for ssh security and enable/configure a firewall (using [ufw][link_web_ufw]). |
|[vpn][link_repo_vpn]				|Install openvpn and copy some custom vpn configuration files.  Also copy and configure a custom [vpn][link_gitlab_clewsy_scripts_vpn] initialisation script. |
|[wireguard][link_repo_wireguard]		|Install [wireguard][link_web_wireguard] and create custom "client" connection configurations.  Also create some aliases for quickly bringing wireguard up/down from the command line. |
|[wireguard_server][link_repo_wireguard_server]	|Configure a box as a [wireguard][link_web_wireguard] "server" endpoint. |


## Hosts

|Hostname	|Base OS					|Description																							|Roles|
|---------------|-----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----|
|b4t-cam	|[raspbian][link_web_raspbian]			|An old raspberry pi 2 with a wifi dongle and an old usb webcam.<br />Configured as an ip cam.													|<ul><li>common</li><li>motion</li></ul> |
|b4t.site	|[ubuntu][link_web_ubuntu]			|Off-site box (VPS) used as a wireguard endpoint and backup storage.																|<ul><li>common</li><li>docker</li><li>secure</li><li>wireguard_server</li><li>vpn</li></ul> |
|calculon	|[ubuntu][link_web_ubuntu]			|Home automation stuff.<br />A raspberry pi 4 with containerised [home assistant][link_web_home_assistant] (supervised) on top of an ubuntu base.						|<ul><li>common</li><li>homeassistant</li></ul> |
|farnsworth	|[ubuntu][link_web_ubuntu]			|My main desktop machine.																					|<ul><li>clews.pro</li><li>common</li><li>desktop</li><li>docker</li><li>mpd</li><li>node</li><li>secure</li><li>vpn</li></ul> |
|hypnotoad	|[osmc][link_web_osmc]				|Media server installed on a raspberry pi 3 connected to a tv.<br />Serves media stored on zapp using nfs shares.<br />Refer to the [clews.pro][link_clews_projects_media_center] project page.	|<ul><li>common</li></ul> |
|nibbler	|[pop_os][link_web_pop_os]			|My laptop.																							|<ul><li>common</li><li>desktop</li><li>mpd</li><li>node</li><li>secure</li><li>vpn</li><li>wireguard</li></ul> |
|p0wer		|[raspbian][link_web_raspbian]			|A raspberry pi zero W with additional hardware connected to the gpio.<br />Refer to the [p0wer][link_clews_projects_p0wer] project page or [gitlab repo][link_gitlab_clewsy_p0wer].		|<ul><li>common</li><li>p0wer</li></ul> |
|pazuzu		|[raspbian][link_web_raspbian]			|Raspberry pi zero W connected to a raspberry pi cam.<br />Configured as an ip cam.														|<ul><li>common</li><li>motion</li></ul> |
|rad10		|[raspbian][link_web_raspbian]			|A raspberry pi 3 with additional hardware connected to the gpio.<br />Refer to the [rad10][link_clews_projects_rad10] project page or [gitlab repo][link_gitlab_clewsy_rad10].			|<ul><li>common</li><li>mpd</li><li>rad10</li></ul> |
|seymour	|[debian][link_web_debian] 			|Beaglebone black SBC connected to the LAN via ethernet.<br />Always-on box that serves as a network admin node and runs some custom script cron jobs.						|<ul><li>common</li><li>docker</li><li>node</li><li>polly</li><li>secure</li></ul> |
|zapp		|[openmediavault][link_web_openmediavault]	|File-server and backup storage.<br />Shares bulk media over nfs and acts as the on-site backup storage.<br />Also runs a torrent client.							|<ul><li>common</li><li>docker</li><li>qbittorrent</li><li>vpn</li></ul> |
|zoidberg	|[ubuntu][link_web_ubuntu]			|Web server machine.<br />Serves various web sites and web apps.<br />Refer to the [clews.pro][link_clews_projects_clews] project page or [gitlab repo][link_gitlab_clewsy_clews.pro].		|<ul><li>clews.pro</li><li>common</li><li>docker</li><li>polly</li><li>secure</li></ul> |


[link_web_ansible]:https://docs.ansible.com/
[link_web_conky]:https://github.com/brndnmtthws/conky
[link_web_terminator]:https://github.com/software-jessies-org/jessies/wiki/Terminator
[link_web_guake]:http://guake-project.org/
[link_web_docker]:https://www.docker.com/
[link_web_docker-compose]:https://docs.docker.com/compose/
[link_web_home_assistant_supervised_installer]:https://github.com/home-assistant/supervised-installer
[link_web_home_assistant]:https://www.home-assistant.io/
[link_web_motion]:https://motion-project.github.io/
[link_web_mpd]:https://www.musicpd.org/
[link_web_mpc]:https://www.musicpd.org/clients/mpc/
[link_web_ncmpc]:https://rybczak.net/ncmpcpp/
[link_web_netdiscover]:https://github.com/netdiscover-scanner/netdiscover
[link_web_nmap]:https://nmap.org/
[link_web_blink1]:https://blink1.thingm.com/
[link_web_qbittorrent]:https://www.qbittorrent.org/
[link_web_wireguard]:https://www.wireguard.com/
[link_web_raspbian]:https://www.raspbian.org/
[link_web_ubuntu]:https://ubuntu.com/
[link_web_osmc]:https://osmc.tv/
[link_web_pop_os]:https://pop.system76.com/
[link_web_debian]:https://www.debian.org/
[link_web_openmediavault]:https://www.openmediavault.org/
[link_web_ufw]:https://launchpad.net/ufw

[link_dockerhub_qbittorrent]:https://hub.docker.com/r/linuxserver/qbittorrent

[link_gitlab_clewsy_clews.pro]:https://gitlab.com/clewsy/clews.pro
[link_gitlab_clewsy_scripts_bu]:https://gitlab.com/clewsy/scripts/-/blob/master/bu.sh
[link_gitlab_clewsy_scripts_stuff]:https://gitlab.com/clewsy/scripts/-/blob/master/stuff.sh
[link_gitlab_clewsy_scripts_wami]:https://gitlab.com/clewsy/scripts/-/blob/master/wami.sh
[link_gitlab_clewsy_scripts_terbling]:https://gitlab.com/clewsy/scripts/-/blob/master/terbling.sh
[link_gitlab_clewsy_scripts_apt_all]:https://gitlab.com/clewsy/scripts/-/blob/master/apt_all.sh
[link_gitlab_clewsy_scripts_ball]:https://gitlab.com/clewsy/scripts/-/blob/master/ball.sh
[link_gitlab_clewsy_scripts_pong]:https://gitlab.com/clewsy/scripts/-/blob/master/pong.sh
[link_gitlab_clewsy_scripts_whodis]:https://gitlab.com/clewsy/scripts/-/blob/master/whodis.sh
[link_gitlab_clewsy_p0wer]:https://gitlab.com/clewsy/p0wer
[link_gitlab_clewsy_scripts_polly]:https://gitlab.com/clewsy/scripts/-/blob/master/polly.sh
[link_gitlab_clewsy_rad10d]:https://gitlab.com/clewsy/rad10d
[link_gitlab_clewsy_scripts_vpn]:https://gitlab.com/clewsy/scripts/-/blob/master/vpn.sh

[link_repo_clews.pro]:roles/clews.pro
[link_repo_common]:roles/common
[link_repo_desktop]:roles/desktop
[link_repo_docker]:roles/docker
[link_repo_homeassistant]:roles/homeassistant
[link_repo_motion]:roles/motion
[link_repo_mpd]:roles/mpd
[link_repo_node]:roles/node
[link_repo_p0wer]:roles/p0wer
[link_repo_polly]:roles/polly
[link_repo_qbittorrent]:roles/qbittorrent
[link_repo_rad10]:roles/rad10
[link_repo_secure]:roles/secure
[link_repo_vpn]:roles/vpn
[link_repo_wireguard]:roles/wireguard
[link_repo_wireguard_server]:roles/wireguard_server

[link_clews]:https://clews.pro
[link_clews_projects_media_center]:https://clews.pro/projects/media_center.php
[link_clews_projects_p0wer]:https://clews.pro/projects/p0wer.php
[link_clews_projects_rad10]:https://clews.pro/projects/rad10.php
[link_clews_projects_clews]:https://clews.pro/projects/clews.php
