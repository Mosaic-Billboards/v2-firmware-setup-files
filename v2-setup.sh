
# set consoleblank=n in /boot/cmdline.txt
cd boot/
sudo rm cmdline.txt
sudo wget https://raw.githubusercontent.com/Mosaic-Billboards/v2-firmware-setup-files/master/cmdline.txt
cd ..

# remove cursor
cd etc/lightdm/
sudo rm lightdm.conf
sudo wget 