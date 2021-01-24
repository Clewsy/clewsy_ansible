# clewsy_ansible

Basic automation playbooks and roles for deploying machines on my home network.  Super handy when nuking/paving, but originally this project just started as a means of learning [ansible][link_web_ansible].  Additional information at [clews.pro][link_clews_projects_clewsy_ansible]

A playbook and variables file exists for each host machine.  When run, the host-specific playbook will configure the host with the specified roles described below.  Prior to running the host-specific playbooks, some minimum requirements must be met:
1. Operating system installed.
2. User exists as defined in host variables file (*host_vars/hostname.yml*).
	* User must have sudo access.
	* Sudo password must be as defined by the host-specific *setup-password* variabe.
3. Static IP must be assigned to the MAC address of the machine's network interface.  A hosts file on my dhcp server is used so all these machines are identified by hostname, not ip address.

The [flexo.yml][link_repo_playbooks_flexo] playbook is a special case.  It will configure my smartphone via [Termux][link_web_termux] and as such, has some additional pre-requisites:
1. Termux must be installed.
2. Within termux, a couple of packages need to be manually installed:
	* python
	* openssh
3. Termux ssh sessions don't really have a "user" in the traditional sense, but a password must be configured.
4. sshd must be executed from Termux.  By default, the ssh daemon will serve on port 8022.


## Roles

|Role/Link						|Desctiption|
|-------------------------------------------------------|-----------|
|[clews.pro][link_repo_roles_clews.pro] 		|Will configure a box as a containerised web server, clone the [clews.pro][link_gitlab_clewsy_clews.pro] repo, and spin up the containers defined in the [docker-compose.yml][link_gitlab_clewsy_clews.pro_docker-compose] file. |
|[common][link_repo_roles_common]			|Configurations common to all hosts - hostname, timezone, ssh keys/configs, apt upgrades, common packages, [vim][link_web_vim], [git][link_web_git], host-specific packages, motd, .bashrc, aliases, cron jobs, mounts/fstab, common scripts ([bu][link_gitlab_clewsy_scripts_bu], [stuff][link_gitlab_clewsy_scripts_stuff], [wami][link_gitlab_clewsy_scripts_wami]). |
|[cups][link_repo_roles_cups]				|Installs [cups][link_web_cups] and configures printers.  Currently also installs printer-driver-brlaser for compatability with a specific laser printer. |
|[desktop][link_repo_roles_desktop]			|Configurations for systems with a desktop - fonts, [conky][link_web_conky], [terbling][link_gitlab_clewsy_scripts_terbling], [terminator][link_web_terminator], [guake][link_web_guake], [gnome][link_web_gnome] settings. |
|[develop][link_repo_roles_develop]			|Install packages I use for development - [VSCode][link_web_vscode], [avrdude][link_web_avrdude] (and dependencies) and other miscellaneous tools. |
|[docker][link_repo_roles_docker]			|Install [docker][link_web_docker] and [docker-compose][link_web_docker-compose].  Start the docker service and create a standard docker-compose staging directory.  Also create alias dc='docker-compose'. |
|[droid][link_repo_roles_droid]				|A special role created to configure an android smartphone running [Termux][link_web_termux].  This role has tasks similar to *common* that had to be implemented dfferently (configure ssh, install packages, install scripts).  It also installs some termux "shortcuts" which are basically scripts that can be run from a widget.  |
|[file_server][link_repo_roles_file_server]		|Mounts a number of disks and configures specified disks or directories as [nfs][link_web_nfs] shares for access over the local network. |
|[headless][link_repo_roles_headless]			|Install and configure some [ncurses][link_web_ncurses] apps useful for headless systems and systems that are often accessed remotely.  Includes [htop][link_web_htop], [iftop][link_web_iftop], [ncdu][link_web_ncdu], [tmux][link_web_tmux] and [Midnight Commander][link_web_mc]. |  
|[homeassistant][link_repo_roles_homeassistant]		|First configure docker role as a pre-requisite.  Then install/remove certain packages as required by the [home assistant supervised installer script][link_web_home_assistant_supervised_installer].  Finally download and run the installer script that will install [home assistant supervised][link_web_home_assistant] |
|[motion][link_repo_roles_motion]			|Turn a [raspberry pi][link_web_raspberry_pi] into a web-cam.  Install, configure and enable [motion][link_web_motion] for streaming over the lan. |
|[mpd][link_repo_roles_mpd]				|Use on boxes that will be used for streaming audio or playing mp3s.  Install the required and useful packages ([mpd][link_web_mpd], [mpc][link_web_mpc], [ncmpc][link_web_ncmpc]) then configure and run the mpd daemon. |
|[node][link_repo_roles_node]				|Set up some common packages and scripts on key boxes that are used for maintaining other boxes.  Install networking packages ([netdiscover][link_web_netdiscover], [nmap][link_web_nmap]), install [ansible][link_web_ansible], clone this repository and install some custom scripts ([apt_all][link_gitlab_clewsy_scripts_apt_all], [ball][link_gitlab_clewsy_scripts_ball], [pong][link_gitlab_clewsy_scripts_pong], [whodis][link_gitlab_clewsy_scripts_whodis]). |
|[p0wer][link_repo_roles_p0wer]				|Configure a [raspberry pi][link_web_raspberry_pi] with gpio connected to an RF remote control used to switch on or off mains-connected devices from scripts or a webui.  Clone [p0wer repo][link_gitlab_clewsy_p0wer], compile executable, install webserver packages ([Apache][link_web_apache]) and copy html/php files. |
|[polly][link_repo_roles_polly]				|Configue a box to control a [thingm blink1][link_web_blink1] device, then install [polly][link_gitlab_clewsy_scripts_polly] script which polls [clews.pro][link_clews], logs the result and uses the blink1 to indicate the site status. |
|[qbittorrent][link_repo_roles_qbittorrent]		|Install and configure [qbittorrent][link_web_qbittorrent] client.  This is installed as a [docker][link_web_docker] container, so first the docker role is run, then a docker-compose.yml file is copied and used to pull and run the [qbittorrent container][link_dockerhub_qbittorrent]. |
|[rad10][link_repo_roles_rad10]				|Configure a [raspberry pi][link_web_raspberry_pi] as an internet radio/music streamer with hardware control and a webui.  First run the mpd role, then clone [rad10d repo][link_gitlab_clewsy_rad10d], compile the daemon and configure a unit-file for auto-starting.  Will also install web server packages ([Apache][link_web_apache]) and copy the html/php files for the rad10 webui. |
|[rsync_server][link_repo_roles_rsync_server]		|Creates a series of [cron][link_web_cron] jobs that use [rsync][link_web_rsync] to create specified local and remote backups to/from various machines. |
|[secure][link_repo_roles_secure]			|Configure some basic settings for ssh security and enable/configure a firewall (using [ufw][link_web_ufw]). |
|[vpn][link_repo_roles_vpn]				|Install [openvpn][link_web_openvpn] and copy some custom vpn configuration files.  Also copy and configure a custom [vpn][link_gitlab_clewsy_scripts_vpn] initialisation script. |
|[wireguard][link_repo_roles_wireguard]			|Install [wireguard][link_web_wireguard] and create custom "client" connection configurations.  Also create some aliases for quickly bringing wireguard up/down from the command line. |
|[wireguard_server][link_repo_roles_wireguard_server]	|Configure a box as a [wireguard][link_web_wireguard] "server" endpoint. |


## Hosts

|Hostname					|Base OS					|Description																																	|Roles|
|-----------------------------------------------|-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----|
|[b4t-cam][link_repo_playbooks_b4t-cam]		|[raspberry pi os][link_web_raspios]	|An old raspberry pi 2 with a wifi dongle and an old usb webcam.<br />Configured as an ip cam and accessed via a [motioneye][link_web_motioneye] server.																	|<ul><li>common</li><li>motion</li></ul> |
|[b4t.site][link_repo_playbooks_b4t.site]	|[ubuntu][link_web_ubuntu]		|Off-site box (VPS) used as a [wireguard][link_web_wireguard] endpoint and backup storage.																									|<ul><li>common</li><li>docker</li><li>headless</li><li>rsync_server</li><li>secure</li><li>wireguard_server</li></ul> |
|[calculon][link_repo_playbooks_calculon]	|[ubuntu][link_web_ubuntu]		|Home automation stuff.<br />A raspberry pi 4 with containerised [home assistant][link_web_home_assistant] (supervised) on top of an ubuntu base.																		|<ul><li>common</li><li>homeassistant</li></ul> |
|[farnsworth][link_repo_playbooks_farnsworth]	|[ubuntu][link_web_ubuntu]		|My main desktop machine.																																	|<ul><li>clews.pro</li><li>common</li><li>desktop</li><li>develop</li><li>docker</li><li>headless</li><li>mpd</li><li>node</li><li>secure</li><li>vpn</li></ul> |
|[flexo][link_repo_playbooks_flexo]		|[lineageOS][link_web_lineageos]	|My smartphone.																																			|<ul><li>droid</li></ul> |
|[hermes][link_repo_playbooks_hermes]		|[raspberry pi os][link_web_raspios]	|Old raspberry pi 2 now serving as a network printer thanks to [cups][link_web_cups] and a USB-connected laser printer.																						|<ul><li>common</li><li>cups</li></ul> |
|[hypnotoad][link_repo_playbooks_hypnotoad]	|[osmc][link_web_osmc]			|Media server installed on a pi connected to a tv.<br />Serves media stored on zapp using nfs shares.<br />Refer to the [media_center][link_clews_projects_media_center] project page.														|<ul><li>common</li></ul> |
|[nibbler][link_repo_playbooks_nibbler]		|[pop_os][link_web_pop_os]		|My laptop.																																			|<ul><li>common</li><li>desktop</li><li>develop</li><li>mpd</li><li>node</li><li>secure</li><li>vpn</li><li>wireguard</li></ul> |
|[p0wer][link_repo_playbooks_p0wer]		|[raspberry pi os][link_web_raspios]	|A raspberry pi zero W with additional hardware connected to the gpio.  Used to control gpio outlets over wifi.<br />Refer to the [p0wer][link_clews_projects_p0wer] project page or [gitlab repo][link_gitlab_clewsy_p0wer].									|<ul><li>common</li><li>p0wer</li></ul> |
|[pazuzu][link_repo_playbooks_pazuzu]		|[raspberry pi os][link_web_raspios]	|Raspberry pi zero W connected to a raspberry pi cam.<br />Configured as an ip cam and accessed via a [motioneye][link_web_motioneye] server.																			|<ul><li>common</li><li>motion</li></ul> |
|[rad10][link_repo_playbooks_rad10]		|[raspberry pi os][link_web_raspios]	|A raspberry pi 3 with additional hardware connected to the gpio plus a small amplifier and speaker.  Effectively a custom internet radio.<br />Refer to the [rad10][link_clews_projects_rad10] project page or [gitlab repo][link_gitlab_clewsy_rad10d].					|<ul><li>common</li><li>mpd</li><li>rad10</li></ul> |
|[seymour][link_repo_playbooks_seymour]		|[debian][link_web_debian] 		|[Beaglebone Black][link_web_beaglebone_black] SBC connected to the LAN via ethernet.<br />Always-on box that serves as a network admin node and runs some custom scripts and cron jobs.													|<ul><li>common</li><li>headless</li><li>node</li><li>polly</li><li>secure</li></ul> |
|[zapp][link_repo_playbooks_zapp]		|[ubuntu][link_web_ubuntu]		|File-server and backup storage.<br />Contains network shares and acts as an rsync server for local and remote backups.<br />Also runs a torrent client.<br />Formerly I used [openmediavault][link_web_openmediavault], but since chose to manually configure a minimal ubuntu installation.	|<ul><li>common</li><li>docker</li><li>file_server</li><li>headless</li><li>qbittorrent</li><li>rsync_server</li><li>vpn</li></ul> |
|[zoidberg][link_repo_playbooks_zoidberg]	|[ubuntu][link_web_ubuntu]		|Web server machine.<br />Serves various web sites and web apps.<br />Refer to the [clews.pro][link_clews_projects_clews] project page or [gitlab repo][link_gitlab_clewsy_clews.pro].														|<ul><li>clews.pro</li><li>common</li><li>docker</li><li>headless</li><li>polly</li><li>secure</li></ul> |

[link_clews]:https://clews.pro
[link_clews_projects_clews]:https://clews.pro/projects/clews.php
[link_clews_projects_clewsy_ansible]:https://clews.pro/projects/clewsy_ansible.php
[link_clews_projects_media_center]:https://clews.pro/projects/media_center.php
[link_clews_projects_p0wer]:https://clews.pro/projects/p0wer.php
[link_clews_projects_rad10]:https://clews.pro/projects/rad10.php

[link_dockerhub_qbittorrent]:https://hub.docker.com/r/linuxserver/qbittorrent

[link_gitlab_clewsy_clews.pro]:https://gitlab.com/clewsy/clews.pro
[link_gitlab_clewsy_clews.pro_docker-compose]:https://gitlab.com/clewsy/clews.pro/-/blob/master/docker-compose.yml
[link_gitlab_clewsy_p0wer]:https://gitlab.com/clewsy/p0wer
[link_gitlab_clewsy_rad10d]:https://gitlab.com/clewsy/rad10d
[link_gitlab_clewsy_scripts_apt_all]:https://gitlab.com/clewsy/scripts/-/blob/master/apt_all
[link_gitlab_clewsy_scripts_ball]:https://gitlab.com/clewsy/scripts/-/blob/master/ball
[link_gitlab_clewsy_scripts_bu]:https://gitlab.com/clewsy/scripts/-/blob/master/bu
[link_gitlab_clewsy_scripts_polly]:https://gitlab.com/clewsy/scripts/-/blob/master/polly
[link_gitlab_clewsy_scripts_pong]:https://gitlab.com/clewsy/scripts/-/blob/master/pong
[link_gitlab_clewsy_scripts_stuff]:https://gitlab.com/clewsy/scripts/-/blob/master/stuff
[link_gitlab_clewsy_scripts_terbling]:https://gitlab.com/clewsy/scripts/-/blob/master/terbling
[link_gitlab_clewsy_scripts_wami]:https://gitlab.com/clewsy/scripts/-/blob/master/wami
[link_gitlab_clewsy_scripts_whodis]:https://gitlab.com/clewsy/scripts/-/blob/master/whodis
[link_gitlab_clewsy_scripts_vpn]:https://gitlab.com/clewsy/scripts/-/blob/master/vpn

[link_repo_playbooks_b4t-cam]:playbooks/b4t-cam.yml
[link_repo_playbooks_b4t.site]:playbooks/b4t.site.yml
[link_repo_playbooks_calculon]:playbooks/calculon.yml
[link_repo_playbooks_farnsworth]:playbooks/farnsworth.yml
[link_repo_playbooks_flexo]:playbooks/flexo.yml
[link_repo_playbooks_hermes]:playbooks/hermes.yml
[link_repo_playbooks_hypnotoad]:playbooks/hypnotoad.yml
[link_repo_playbooks_nibbler]:playbooks/nibbler.yml
[link_repo_playbooks_p0wer]:playbooks/p0wer.yml
[link_repo_playbooks_pazuzu]:playbooks/pazuzu.yml
[link_repo_playbooks_rad10]:playbooks/rad10.yml
[link_repo_playbooks_seymour]:playbooks/seymour.yml
[link_repo_playbooks_zapp]:playbooks/zapp.yml
[link_repo_playbooks_zoidberg]:playbooks/zoidberg.yml
[link_repo_roles_clews.pro]:roles/clews.pro
[link_repo_roles_common]:roles/common
[link_repo_roles_cups]:roles/cups
[link_repo_roles_desktop]:roles/desktop
[link_repo_roles_develop]:roles/develop
[link_repo_roles_docker]:roles/docker
[link_repo_roles_droid]:roles/droid
[link_repo_roles_file_server]:roles/file_server
[link_repo_roles_headless]:roles/headless
[link_repo_roles_homeassistant]:roles/homeassistant
[link_repo_roles_motion]:roles/motion
[link_repo_roles_mpd]:roles/mpd
[link_repo_roles_node]:roles/node
[link_repo_roles_p0wer]:roles/p0wer
[link_repo_roles_polly]:roles/polly
[link_repo_roles_qbittorrent]:roles/qbittorrent
[link_repo_roles_rad10]:roles/rad10
[link_repo_roles_rsync_server]:/roles/rsync_server
[link_repo_roles_secure]:roles/secure
[link_repo_roles_vpn]:roles/vpn
[link_repo_roles_wireguard]:roles/wireguard
[link_repo_roles_wireguard_server]:roles/wireguard_server

[link_web_apache]:https://httpd.apache.org/
[link_web_avrdude]:https://www.nongnu.org/avrdude/
[link_web_ansible]:https://docs.ansible.com/
[link_web_beaglebone_black]:https://beagleboard.org/black/
[link_web_blink1]:https://blink1.thingm.com/
[link_web_conky]:https://github.com/brndnmtthws/conky
[link_web_cron]:https://en.wikipedia.org/wiki/Cron
[link_web_cups]:https://www.cups.org/
[link_web_debian]:https://www.debian.org/
[link_web_docker]:https://www.docker.com/
[link_web_docker-compose]:https://docs.docker.com/compose/
[link_web_git]:https://git-scm.com/
[link_web_gnome]:https://www.gnome.org
[link_web_guake]:http://guake-project.org/
[link_web_home_assistant]:https://www.home-assistant.io/
[link_web_home_assistant_supervised_installer]:https://github.com/home-assistant/supervised-installer
[link_web_htop]:https://hisham.hm/htop/
[link_web_iftop]:http://www.ex-parrot.com/pdw/iftop/
[link_web_lineageos]:https://lineageos.org/
[link_web_mc]:https://midnight-commander.org/
[link_web_mpc]:https://www.musicpd.org/clients/mpc/
[link_web_mpd]:https://www.musicpd.org/
[link_web_motion]:https://motion-project.github.io/
[link_web_motioneye]:https://github.com/ccrisan/motioneye
[link_web_ncdu]:https://dev.yorhel.nl/ncdu
[link_web_ncmpc]:https://rybczak.net/ncmpcpp/
[link_web_ncurses]:https://invisible-island.net/ncurses/announce.html#h2-overview
[link_web_nfs]:https://en.wikipedia.org/wiki/Network_File_System_(protocol)
[link_web_netdiscover]:https://github.com/netdiscover-scanner/netdiscover
[link_web_nmap]:https://nmap.org/
[link_web_openmediavault]:https://www.openmediavault.org/
[link_web_openvpn]:https://openvpn.net/
[link_web_osmc]:https://osmc.tv/
[link_web_pop_os]:https://pop.system76.com/
[link_web_qbittorrent]:https://www.qbittorrent.org/
[link_web_raspberry_pi]:https://www.raspberrypi.org/
[link_web_raspios]:https://www.raspberrypi.org/software/
[link_web_rsync]:https://rsync.samba.org/
[link_web_terminator]:https://github.com/software-jessies-org/jessies/wiki/Terminator
[link_web_termux]:https://termux.com/
[link_web_tmux]:https://github.com/tmux/tmux/wiki
[link_web_ubuntu]:https://ubuntu.com/
[link_web_ufw]:https://launchpad.net/ufw
[link_web_vim]:https://www.vim.org/
[link_web_vscode]:https://code.visualstudio.com/
[link_web_wireguard]:https://www.wireguard.com/
