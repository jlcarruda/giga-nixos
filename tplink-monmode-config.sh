# Links to download linux headers when make command fails
# https://http.kali.org/kali/pool/main/l/linux/    (linux-headers and common)
# https://kali.download/kali/pool/main/l/linux/    (linux kbuild)

# Credits: https://www.hackster.io/thatiotguy/enable-monitor-mode-in-tp-link-tl-wn722n-v2-v3-128fc6
# Tested on Kali Linux 2022.3
# Commands used to Setup the Adapter from aircrack repository
apt update
apt install bc -y
rmmod r8188eu.ko
git clone https://github.com/aircrack-ng/rtl8188eus
cd rtl8188eus
sudo -i
echo "blacklist r8188eu" > "/etc/modprobe.d/realtek.conf"
exit
make
make install
modprobe 8188eu

# Commands to enable monitor mode after setting up
ifconfig wlan0 down
airmon-ng check kill
iwconfig wlan0 mode monitor
ifconfig wlan0 up
iwconfig

# Play with airodump-ng to test :)
airodump-ng wlan0