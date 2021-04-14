BILLBOARD_ID="v2m1_001"
WINDOW_WIDTH=1200
WINDOW_HEIGHT=1920

cd /
echo "Running v2 Setup..."
sleep 1

# set BILLBOARD_ID as environment variable
echo "BILLBOARD_ID="$BILLBOARD_ID"" >> /etc/environment
echo "WINDOW_WIDTH="$WINDOW_WIDTH"" >> /etc/environment
echo "WINDOW_HEIGHT="$WINDOW_HEIGHT"" >> /etc/environment

# raspi-config settings
sudo raspi-config nonint do_hostname "$BILLBOARD_ID"
sudo raspi-config nonint do_blanking 0
echo "Set hostname and turned off screen blanking..."

# set consoleblank=n
cd boot/
sudo rm cmdline.txt
sudo wget https://raw.githubusercontent.com/Mosaic-Billboards/v2-firmware-setup-files/master/cmdline.txt
echo "Updated /boot/cmdline.txt..."

# add X graphics command to remove cursor
cd /
cd etc/lightdm/
sudo rm lightdm.conf
sudo wget https://raw.githubusercontent.com/Mosaic-Billboards/v2-firmware-setup-files/master/lightdm.conf
echo "Removed cursor..."

cd /
sudo rm /etc/xdg/autostart/piwiz.desktop
echo "Removed startup wizard..."

# removing built in Raspian packages we don't need
echo "Removing unnecessary packages..."
sudo wget https://raw.githubusercontent.com/Mosaic-Billboards/v2-firmware-setup-files/master/remove_packages.sh
sudo chmod +x remove_packages.sh
sudo bash remove_packages.sh
echo "Packages removed..."

# installing needed packages for firmware
echo "Installing packages for v2-firmware"
sudo pip3 install pyrebase
sudo pip3 install pillow --upgrade

# install firmware
cd home/
sudo git clone https://github.com/Mosaic-Billboards/v2-firmware

echo "Installed firmware and dependencies..."

# setup systemd service to run firmware on boot
echo "Setting up systemd service..."
cd /
cd /lib/systemd/system/
sudo wget https://raw.githubusercontent.com/Mosaic-Billboards/v2-firmware-setup-files/master/v2.service
sudo systemctl daemon-reload
sudo systemctl enable v2.service
cd /
echo "Systemd service enabled..."
sleep 1

# install wicd-curses to manage wifi reconnection
echo "Installing wicd-curses for WiFi reconnection..."
sudo apt-get install wicd-curses
sudo systemctl disable dhcpcd
sudo /etc/init.d/dhcpcd stop
echo "Installed..."
sleep 2

echo "Rebooting..."
sudo reboot

# then use sudo wicd-curses to re-setup wifi