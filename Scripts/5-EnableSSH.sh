#Get packages
sudo apt update

#install ssh
sudo apt install openssh-server

#Status
sudo systemctl status ssh

#enable login with password
sudo ufw allow ssh