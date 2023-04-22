Jenkins installation on Ubuntu - https://pkg.origin.jenkins.io/debian/
Sonar	Qube + PostgresSQL - https://www.fosstechnix.com/how-to-install-sonarqube-on-ubuntu-22-04-lts/ & https://www.digitalocean.com/community/tutorials/opening-a-port-on-linux
https://www.commandprompt.com/education/how-to-uninstall-postgresql-from-ubuntu/
https://www.liquidweb.com/kb/how-to-uninstall-software-in-ubuntu/

Docker https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository

Trivy https://aquasecurity.github.io/trivy/v0.40/getting-started/installation/

Hashicorp https://www.cyberithub.com/how-to-install-hashicorp-vault-on-ubuntu-20-04-lts/

To find if any broken packages are there:

 sudo dpkg -l | grep "^iU"
To remove broken packages any of two commands will help:

 sudo apt-get -f install
 sudo apt-get remove --purge $(dpkg -l | grep "^iU" | awk '{print $2}')
To find the residual packages following command will help:

 sudo dpkg -l | grep "^rc"
Note: if any package is installed without any error, the first column starts with ii but for residual package it starts with rc, and for broken it starts with iU. For more information about package state letters, see this answer.

To remove all residual packages:

 sudo apt-get remove --purge $(dpkg -l | awk '/^rc/{print $2}')