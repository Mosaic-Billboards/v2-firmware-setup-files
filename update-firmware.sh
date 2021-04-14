# cron job with runs python script every 10 minutes

# python script
# request api to get current firmware version
# open firmware-version.txt file and read contents
# compare versions and if different, run update-setup shell script

# update-firmware shell script
cd /
cd /home/v2-firmware
sudo rm update-process.sh
sudo wget LINK_TO_UPDATE_PROCESS shell
sudo chmod +x update-process.sh
sudo bash update-process.sh

# update-process
cd /
cd /home/v2-firmware
sudo systemctl stop v2.service
sudo rm v2.py
sudo wget LINK_TO_FIRMWARE_SOURCE
sudo chmod +x v2.py
sleep 2
sudo reboot