#!/bin/bash



echo "Tools for Bug Bounty Enumeration and Others\n"
echo "Ensure you are root prior to using the automation tool\n"






apt-get -y update
apt-get -y upgrade




#Go installation
echo "Most of these tools require GO\n"

if [[ -z "$GOPATH" ]]; then
	echo "The language GO is not found within the box, Want to install it? - Please note that this script will use apt and will require the latest golang in the repo, ensure it is updated \n"
	OPTION="Select an option: \n"
	choices=("yes" "no")
	select choice in "${choices[@]}";do
		case $choice in
			yes)
				echo "We are now installing Golang"
				apt install golang
				mv go /usr/local
				export GOPATH=$HOME/go
				export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
				echo "export GOPATH=$HOME/go" >> ~/.bashrc
				echo "export $GOPATH=/bin:GOROOT/bin:$PATH" >> ~/.bashrc
				source ~/.bashrc
				sleep 1
				break
				;;

			no)
				echo "Ensure that Golang is installed"
				echo "Aborting the script functions and installations"
				exit 1
				;;
		esac
done
fi
			

if [[ -d "$tools" ]]; then
	echo "Directory Exists"
else
	echo "Directory do not exist. We will now proceed on creating the directory"
	mkdir ~/tools
	cd ~/tools
	sleep 1

fi



echo "Installing AssetFinder"
go install -u github.com/tomnomnom/assetfinder
echo "done"


echo " Installing anew by tomnomnom " 
go install -v github.com/tomnomnom/anew@latest
echo "done"


echo "Install Subfinder"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo "done"


echo "installing waybackurls"
go install github.com/tomnomnom/waybackurls@latest
echo "done"


echo "Install Hackrawler"
go install github.com/hakluke/hakrawler@latest
echo "done"


echo "Install HTTPROBE"
go install github.com/tomnomnom/httprobe@latest
echo "done"


echo "Install Haktrails"
go install -v github.com/hakluke/haktrails@latest
echo "done"


#install aquatone
echo "Installing Aquatone"
go install github.com/michenriksen/aquatone
echo "done"


echo "Install HttpX"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "done!"


echo "Install FFF"
go install github.com/tomnomnom/fff
"done"


echo "Install ffuf"
go install github.com/ffuf/ffuf/v2@latest
echo "done"

echo "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

