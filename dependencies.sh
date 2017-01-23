printf "Hello, I will install some dependencies for you.\n"
printf "Choose your distro:\n(1) Debian based\n(2) Red Hat based\n(3) Other\n"
read choice

case "$choice" in
	"1") sudo apt-get install python-pip
	;;
	"2") sudo dnf install python-pip
	;;
	"3") continue
	;;
esac

sudo pip install selenium
sudo pip install bs4
