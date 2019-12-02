#!/bin/bash

# Variables
# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Default
DefaultColor='\e[39m'   # Default foreground color

b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
spath="$( cd "$( dirname $0 )" && pwd )"
######################################1ST PART###################################################

#Install script if not installed
function installzarch {
if [ ! -e "/usr/bin/Zarch" ];then
	echo -en "\e[32m[-] : Script is not installed. Do you want to install it ? (Y/N) !\e[0m"
	read install
	if [[ $install = Y || $install = y ]] ; then
		wget  -O /usr/bin/zarch
		chmod +777 /usr/bin/zarch
		echo "Script should now be installed. Launching it !"
		sleep 1
    echo "You can run the script anytime by typing 'zarch' on the Terminal"
    sleep 2
		exit 1
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
else
	echo "Script is installed"
	sleep 1
fi
}

#Cheking Os Architecture
function archicheck {
if [[ $(uname -m ) = x86_64 ]]; then
  sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf  
else
  echo -e "\e[32m[-] multilab is already Enabled !\e[0m"
	#sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf 
fi


}

# Zarch Logo
function showlogo {
  clear
echo ""
sleep 0.1
echo -e $Cyan   "    +${Yellow}-------------------------------------------------------------------${Cyan}+"
sleep 0.1
echo -e $Yellow   "    |                                                                  $Yellow |"
sleep 0.1
echo -e "     |$Red             ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗             $Yellow |"
sleep 0.1
echo -e "     |$Red             ╚══███╔╝██╔══██╗██╔══██╗██╔════╝██║  ██║             $Yellow |"   
sleep 0.1
echo -e "     |$BRed               ███╔╝ ███████║██████╔╝██║     ███████║             $Yellow |"  
sleep 0.1
echo -e "     |$BRed              ███╔╝  ██╔══██║██╔══██╗██║     ██╔══██║             $Yellow |" 
sleep 0.1
echo -e "     |$Red             ███████╗██║  ██║██║  ██║╚██████╗██║  ██║             $Yellow |" 
sleep 0.1
echo -e "     |$Red             ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝             $Yellow |"  
sleep 0.1
echo -e "     |$Red              \e[1;37m  Buy Me A Coffe: patreon.com/zatiel                $Yellow |"
sleep 0.1
echo -e $Cyan   "    +${Yellow}-------------------------------------------------------------------${Cyan}+${Yellow}"
sleep 0.1
echo -e "               \e[101m\e[1;37m::    Follow me on: twitter.com/CallMeZatiel   ::\e[0m\n"
echo -e "           \e[101m\e[1;37m| [!]  | The Ultimate Script For Arch Linux | Ver.1.0  |\e[0m\n"               
}
#}}}
  users_list=(`cat /etc/passwd | grep "/home" | cut -d: -f1`);
  PS3="$prompt1"
  if [[ $(( ${#users_list[@]} )) -gt 0 ]]; then
    echo ""
  fi
#CONFIGURE SUDO {{{
configure_sudo(){
  if ! is_package_installed "sudo" ; then
    print_title "SUDO - https://wiki.archlinux.org/index.php/Sudo"
    package_install "sudo"
  fi
  #CONFIGURE SUDOERS {{{
  if [[ ! -f  /etc/sudoers.aui ]]; then
    cp -v /etc/sudoers /etc/sudoers.aui
    ## Uncomment to allow members of group wheel to execute any command
    sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
    ## Same thing without a password (not secure)
    #sed -i '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^#//' /etc/sudoers

    #This config is especially helpful for those using terminal multiplexers like screen, tmux, or ratpoison, and those using sudo from scripts/cronjobs:
    echo "" >> /etc/sudoers
    echo 'Defaults !requiretty, !tty_tickets, !umask' >> /etc/sudoers
    echo 'Defaults visiblepw, path_info, insults, lecture=always' >> /etc/sudoers
    echo 'Defaults loglinelen=0, logfile =/var/log/sudo.log, log_year, log_host, syslog=auth' >> /etc/sudoers
    echo 'Defaults passwd_tries=3, passwd_timeout=1' >> /etc/sudoers
    echo 'Defaults env_reset, always_set_home, set_home, set_logname' >> /etc/sudoers
    echo 'Defaults !env_editor, editor="/usr/bin/vim:/usr/bin/vi:/usr/bin/nano"' >> /etc/sudoers
    echo 'Defaults timestamp_timeout=15' >> /etc/sudoers
    echo 'Defaults passprompt="[sudo] password for %u: "' >> /etc/sudoers
    echo 'Defaults lecture=never' >> /etc/sudoers
  fi
  #}}}
}

# Initial yay -Syu
function inityayupd {
  echo ""
  echo; echo -e "\033[1m Updating ..... \e[0m\E[31m| Please stop any install process before updating\e[0m"; 
  echo
  yay -Syu --noconfirm; 
  echo "Update Completed"; 
  sleep 1;
}

# Requirements Check 

function checkyay {
  which yay > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[Yay]: installation found!;
else

echo [x]::[warning]:this script require Yay ;
echo ""
echo [!]::[please wait]: Installing Yay ..  ;
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si 
echo ""
fi
sleep 1
}

function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[Git]: installation found!;
else

echo [x]::[warning]:this script require Git ;
echo ""
echo [!]::[please wait]: Installing Git ..  ;
pacman -S git --noconfirm
echo ""
fi
sleep 1
}

function checkwget {
	which wget > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[wget]: installation found!;
else

echo [x]::[warning]:this script require wget ;
echo ""
echo [!]::[please wait]: Installing Wget ;
pacman -S wget --noconfirm
echosleep 2
echo ""
fi
sleep 1

}

# Script Initiation
#checkroot && sleep 1
checkwget && checkyay && checkgit 
showlogo
archicheck && inityayupd && clear && sleep 1
#################################################################################################
#######################################2ND PART##################################################
######### Programs Installations : START :  ##########################

# Install Okular
function installokular {
  echo
  echo -e " Currently Installing ${b}Okular${enda}"
  echo -e " ${bu}Okular is a universal document viewer 
  developed by KDE. 
 Read more about it here: ${b}https://okular.kde.org/${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Okular${enda}"
  sudo pacman -S --noconfirm okular
  echo -e " ${b}Okular${enda} Was Successfully Installed"
  echo && echo -e " Run Okular From The ${b}Office${enda} Menu "
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}

# Install Gparted
function installgparted {
  echo
  echo -e " Currently Installing ${b}GParted${enda}"
  echo -e " ${bu}GParted is a free partition editor for 
  graphically managing your disk partitions.
 Read more about it here: ${b}https://gparted.org/${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}GParted${enda}"
  sudo pacman -S --noconfirm gparted
  echo -e " ${b}Gparted${enda} Was Successfully Installed"
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}


# Install Clementine
function installclementine {
  echo
  echo -e " Currently Installing ${b}Clementine${enda}"
  echo -e " ${bu}Clementine is a free and open-source audio player. 
  It is a port of Amarok 1.4 to the Qt 4 framework and the GStreamer
  multimedia framework
 Read more about it here: ${b}https://www.clementine-player.org/${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Clementine${enda}"
  sudo pacman -S --noconfirm clementine
  echo -e " ${b}Clementine${enda} Was Successfully Installed"
  echo && echo " Run Clementine From ${b}Multimedia${endc}"
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}


####################################### ZARCH FTP ##################################################

# Install FileZilla
function installfilez {
  showlogo
  echo -e " Preparing To Install ${b}FileZilla${enda}" && echo
  echo -e " ${bu}FileZilla Client is a free, open source FTP client. It supports
 FTP, SFTP, and FTPS (FTP over SSL/TLS). The client is
 available under many platforms, binaries for Windows, Linux
 and Mac OS X are provided.
 Read more about it here: ${b}https://goo.gl/HkWTQD${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}FileZilla${enda}"
   sudo pacman -S --noconfirm filezilla
  echo -e " ${b}FileZilla${enda} Was Successfully Installed"
  echo && echo -e " Run FileZilla From The ${b}Internet${endc} Menu"
  echo && echo -en " ${y}Press  Enter To Return To Menu${endc}" && echo
  read input
}

# Install gFTP
function installgftp {
  showlogo
  echo -e " Preparing To Install ${b}gFTP${enda}" && echo
  echo -e " ${bu}gFTP is a free/open source multithreaded FTP client. It is
 most used on Unix-like systems, such as Linux, Mac OS X and
 Sony PlayStation 3. There is support for the FTP, FTPS (control
 connection only), HTTP, HTTPS, SFTP and FSP protocols, as well
 as FTP and HTTP proxy server support and FXP file transfers
 (transferring files between 2 remote servers via FTP).
 Read more about it here: ${b}https://goo.gl/nDaZbC${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}gFTP${enda}"
   sudo pacman -S --noconfirm gftp
  echo -e " ${b}gFTP${enda} Was Successfully Installed"
  echo && echo -e " Run gFTP From The ${b}Internet${endc} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install Transmission
function installtransmission {
  showlogo
  echo -e " Preparing To Install ${b}Transmission${enda}" && echo
  echo -e " ${bu}Transmission is designed for easy, powerful use. We've set the
 defaults to Just Work and it only takes a few clicks to
 configure advanced features like watch directories,
 bad peer blocklists, and the web interface.
 Read more about it here: ${b}https://goo.gl/NX5imd${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Transmission${endc}"
   sudo pacman --noconfirm transmission-qt
  echo -e " ${b}Transmission${enda} Was Successfully Installed"
  echo && echo -e " Run Transmission From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

####################################### ZARCH IMAGE EDITORS ##################################################

# Install Pinta
function installpinta {
  showlogo
  echo -e " Preparing To Install ${b}Pinta${enda}" && echo
  echo -e " ${bu}Pinta is a free, open source drawing/editing program
 modeled after Paint.NET. Its goal is to provide users
 with a simple yet powerful way to draw and manipulate
 images on Linux, Mac, and Windows.
 Read more about it here: ${b}https://goo.gl/i2Jk1j${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Pinta${enda}"
  sudo pacman -S --noconfirm pinta
  echo -e " ${b}Pinta${enda} Was Successfully Installed"
  echo && echo -e " Run Pinta From The ${b}Graphics${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install GIMP
function installgimp {
  showlogo
  echo -e " Preparing To Install ${b}GIMP${enda}" && echo
  echo -e " ${bu}GIMP is the GNU Image Manipulation Program. It is a freely
 distributed piece of software for such tasks as photo
 retouching, image composition and image authoring. It
 works on many operating systems, in many languages.
 Read more about it here: ${b}https://goo.gl/th8MKc${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}GIMP${enda}"
  sudo pacman -S --noconfirm gimp
  echo -e " ${b}GIMP${enda} Was Successfully Installed"
  echo && echo -e " Run GIMP From The ${b}Graphics${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Inkscape
function installinkscape {
  showlogo
  echo -e " Preparing To Install ${b}Inkscape${enda}" && echo
  echo -e " ${bu}An Open Source vector graphics editor, with capabilities
 similar to Illustrator, CorelDraw, or Xara X, using the
 W3C standard Scalable Vector Graphics (SVG) file format.
 Inkscape supports many advanced SVG features (markers,
 clones, alpha blending, etc.) and great care is taken in
 designing a streamlined interface. It is very easy to edit
 nodes, perform complex path operations, trace bitmaps and
 much more.
 Read more about it here: ${b}https://goo.gl/mGpNGp${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Inkscape${enda}"
   sudo pacman -S --noconfirm inkscape
  echo -e " ${b}Inkscape${enda} Was Successfully Installed"
  echo && echo -e " Run Inkscape From The ${b}Graphics${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH ##################################################

# Install Ark
function installark {
  showlogo
  echo -e " Preparing To Install ${b}Ark${enda}" && echo
  echo -e " ${bu}Ark is a program for managing various archive formats
 (RAR, ZIP, ...) within the KDE environment. Archives can
 be viewed, extracted, created and modified from within Ark. The
 program can handle various formats such as tar, gzip, bzip2,
 zip, rar and lha (if appropriate command-line programs are
 installed). Ark can work closely with Konqueror in the  KDE
 environment to handle archives, if you install the Konqueror
 Integration plugin available in the kdeaddons package.
 Read more about it here: ${b}https://goo.gl/yiCdCq${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Ark${enda}"
   sudo pacman -S --noconfirm ark
  echo -e " ${b}Ark${enda} Was Successfully Installed"
  echo && echo -e " Run Ark From The Terminal: ${b}ark${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install fileroller
function installfileroller {
  showlogo
  echo -e " Preparing To Install ${b}File-Roller${enda}" && echo
  echo -e " ${bu}File Roller is the archive manager of the GNOME desktop
 environment.
 Read more about it here: ${b}https://goo.gl/qFKRYh${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}File-Roller${enda}"
   sudo pacman -S --noconfirm file-roller
  echo -e " ${b}File-Roller${enda} Was Successfully Installed"
  echo && echo -e " Run File-Roller From The ${b}Accessories${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Zip/Unzip
function installzipunzip {
  showlogo
  echo -e " Preparing To Install ${b}Zip/Unzip${enda}" && echo
  echo -e " ${bu}unzip will list, test, create, or extract files from/to
 a ZIP archive, commonly found on MS-DOS systems. both
 programs are compatible with archives created by PKWARE's
 PKZIP and PKUNZIP for MS-DOS, but in many cases the program
 options or default behaviors differ.
 Read more about Zip: ${b}https://goo.gl/hqUnqT${enda}
 ${bu}Read more about Unzip: ${b}https://goo.gl/EogNij${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Zip/Unzip${enda}"
   sudo pacman -S --noconfirm zip unzip
  echo -e " ${b}Zip/Unzip${enda} Was Successfully Installed"
  echo && echo -e " Run Zip/Unzip From The Terminal: ${b}zip${enda} or ${b}unzip${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Rar/Unrar
function installrarunrar {
  showlogo
  echo -e " Preparing To Install ${b}Rar/Unrar${enda}" && echo
  echo -e " ${bu}Rar and Unrar commands allows you to compress or uncompress
 one or more files on the Terminal.
 Read more about Rar/Unrar: ${b}https://goo.gl/fM8QGB${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Rar/Unrar${enda}"
   sudo pacman -S --noconfirm rar unrar
  echo -e " ${b}Rar/Unrar${enda} Was Successfully Installed"
  echo && echo -e " Run Rar/Unrar From The Terminal: ${b}rar${enda} or ${b}unrar${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH AUDIO ##################################################

# Install Audacious
function installaudacious {
  showlogo
  echo -e " Preparing To Install ${b}Audacious${enda}" && echo
  echo -e " ${bu}Audacious is an open source audio player. A descendant of XMMS,
 Audacious plays your music how you want it, without
 stealing away your computer’s resources from other
 tasks. Drag and drop folders and individual song files,
 search for artists and albums in your entire music library,
 or create and edit your own custom playlists. Listen to CD’s
 or stream music from the Internet. Tweak the sound with the
 graphical equalizer or experiment with LADSPA effects. Enjoy
 the modern GTK-themed interface or change things up with
 Winamp Classic skins. Use the plugins included with Audacious
 to fetch lyrics for your music, to set an alarm in the morning, and more.
 Read more about it here: ${b}https://goo.gl/naDSNn${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Audacious${enda}"
   sudo pacman -S --noconfirm audacious
  echo -e " ${b}Audacious${enda} Was Successfully Installed"
  echo && echo -e " Run Audacious From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Amarok
function installamarok {
  showlogo
  echo -e " Preparing To Install ${b}Amarok${enda}" && echo
  echo -e " ${bu}Amarok is a powerful music player for Linux, Unix and
 Windows with an intuitive interface. It makes playing
 the music you love and discovering new music easier than
 ever before - and it looks good doing it.
 Read more about it here: ${b}https://goo.gl/AyvhUZ${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Amarok${enda}"
   sudo pacman -S --noconfirm amarok
  echo -e " ${b}Amarok${enda} Was Successfully Installed"
  echo && echo -e " Run Amarok From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Banshee
function installbanshee {
  showlogo
  echo -e " Preparing To Install ${b}Banshee${enda}" && echo
  echo -e " ${bu}Banshee is maintained by Aaron Bockover, Andres G. Aragoneses,
 Alexander Kojevnikov, Bertrand Lorentz, and Gabriel Burt.
 Over 155 developers, 130 translators, 6 artists, and
 countless users and volunteers have contributed to Banshee.
 Read more about it here: ${b}https://goo.gl/XHaFXW${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Banshee${enda}"
   sudo pacman -S --noconfirm banshee
  echo -e " ${b}Banshee${enda} Was Successfully Installed"
  echo && echo -e " Run Banshee From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Sonata
function installsonata {
  showlogo
  echo -e " Preparing To Install ${b}Sonata${enda}" && echo
  echo -e " ${bu}Sonata is an elegant GTK+ music client for the Music Player
 Daemon (MPD).
 Read more about it here: ${b}https://goo.gl/rFdXhr${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Sonata${enda}"
   sudo pacman -S --noconfirm sonata
  echo -e " ${b}Sonata${enda} Was Successfully Installed"
  echo && echo -e " Run Sonata From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Audacity
function installaudacity {
  showlogo
  echo -e " Preparing To Install ${b}Audacity${enda}" && echo
  echo -e " ${bu}Audacity is a free, easy-to-use, multi-track audio editor
 and recorder for Windows, Mac OS X, GNU/Linux and other
 operating systems. The interface is translated into many
 languages. And much more..
 Read more about it here: ${b}https://goo.gl/8XWu9b${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Audacity${enda}"
   sudo pacman -S --noconfirm audacity
  echo -e " ${b}Audacity${enda} Was Successfully Installed"
  echo && echo -e " Run Audacity From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Ardour
function installardour {
  showlogo
  echo -e " Preparing To Install ${b}Ardour${enda}" && echo
  echo -e " ${bu}Ardour is a hard disk recorder and digital audio workstation
 application. It runs on Linux, OS X and FreeBSD. Its
 primary author is Paul Davis, who is also responsible
 for the JACK Audio Connection Kit. Ardour's intention
 is to provide digital audio workstation software suitable
 for professional use.
 Read more about it here: ${b}https://goo.gl/XeXUDY${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Ardour${enda}"
   sudo pacman -S --noconfirm ardour
  echo -e " ${b}Ardour${enda} Was Successfully Installed"
  echo && echo -e " Run Ardour From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Sweep
function installsweep {
  showlogo
  echo -e " Preparing To Install ${b}Sweep${enda}" && echo
  echo -e " ${bu}Sweep is a digital audio editor and live playback tool for
 Linux, BSD and compatible systems. It is able to handle
 many sound formats, including MP3, WAV, AIFF, Ogg Vorbis,
 Speex and Vorbis. Originally developed with the support
 of Pixar, the most notable feature of Sweep is its stylus-like
 cursor tool called Scrubby.
 Read more about it here: ${b}https://goo.gl/JeXTQH${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Sweep${enda}"
   sudo pacman -S --noconfirm sweep
  echo -e " ${b}Sweep${enda} Was Successfully Installed"
  echo && echo -e " Run Sweep From The ${b}Multimedia${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH BROWSERS ##################################################


# Install Breaker Browser
function installBreakerb {
  showlogo
  echo -e " Preparing To Install ${b}Breaker${enda}" && echo
  echo -e " ${bu}Beaker is an experimental browser for exploring and 
  building the peer-to-peer Web.Turning the browser into a supercharged 
  tool for sharing websites, files, apps, and more.
  Read more about it here: ${b}https://beakerbrowser.com${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Breaker Browser${enda}"
   yay -S --noconfirm beaker-browser-bin
  echo -e " ${b}Breaker Browser${enda} Was Successfully Installed"
  echo && echo -e " Run Breaker Browser From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}


# Install Brave Browser
function installBrave {
  showlogo
  echo -e " Preparing To Install ${b}Brave Browser${enda}" && echo
  echo -e " ${bu}The Brave browser is a fast, private and secure web 
  browser for PC and mobile. It blocks ads and trackers
  Read more about it here: ${b}https://brave.com/BLO342${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Brave Browser${enda}"
   yay -S --noconfirm brave-bin
  echo -e " ${b}Brave Browser${enda} Was Successfully Installed"
  echo && echo -e " Run Brave Browser From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}



# Install Chromium
function installchromium {
  showlogo
  echo -e " Preparing To Install ${b}Chromium${enda}" && echo
  echo -e " ${bu}Chromium is an open-source browser project that aims to build
 a safer, faster, and more stable way for all Internet
 users to experience the web. This site contains design
 documents, architecture overviews, testing information,
 and more to help you learn to build and work with the
 Chromium source code.
 Read more about it here: ${b}https://goo.gl/JgLWwx${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Chromium${enda}"
   sudo pacman -S --noconfirm chromium
  echo -e " ${b}Chromium${enda} Was Successfully Installed"
  echo && echo -e " Run Chromium From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Google Chrome
function installchrome {
  showlogo
  echo -e " Preparing To Install ${b}Chrome${enda}" && echo
  echo -e " ${bu}Google Chrome is a freeware web browser developed by Google.
 It used the WebKit layout engine until version 27 and,
 with the exception of its iOS releases, from version 28
 and beyond uses the WebKit fork Blink.
 Read more about it here: ${b}https://goo.gl/eo9G5F${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Chrome${enda}"
    yay -S --noconfirm google-chrome
  echo -e " ${b}Chrome${enda} Was Successfully Installed"
  echo && echo -e " Run Chrome From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Youtube Downloader
function installytbdwn {
  showlogo
  echo -e " Preparing To Install ${b}Youtube Downloader${enda}" && echo
  echo -e " ${bu}Simple Youtube Video Downloader, used from Terminal on
 any Linux distribution. Frequently updated.
 Read more about it here: ${b}https://goo.gl/tzVwbD${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
   sudo pacman -S --noconfirm youtube-dl
  echo -e " All ${b}Youtube Downloader${enda} Files Were Flaged For Execute Successfully"
  echo && echo -e " Run Youtube Downloader From The Terminal: ${b}youtube-dl \"http://youtube.com/watch?v=XXXXXXX${enda}\" "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Connman
function installconnman {
  showlogo
  echo -e " Preparing To Install ${b}Connman${enda}" && echo
  echo -e " ${bu}Connman is a daemon for managing internet connections within embedded
  devices running the Linux operating system. Comes with a command-line
  client, plus Enlightenment, ncurses, GTK and Dmenu clients are available.
  Read more about it here: ${b}https://goo.gl/W7VRFy${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
   sudo pacman -S --noconfirm connman
  echo -e " All ${b}Connman${enda} Files Were Flaged For Execute Successfully"
  echo && echo -e " Run Connman From The Terminal"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Skype
function installskype {
  showlogo
  echo -e " Preparing To Install ${b}Skype${enda}" && echo
  echo -e " ${bu}Skype is a freemium voice-over-IP service and
 instant messaging client that is currently developed
 by the Microsoft Skype Division. The name originally
 derived from \"sky\" and \"peer\".
 Read more about it here: ${b}https://goo.gl/kFHLh2${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Skype${enda}"
  yay -S --noconfirm skype
  echo -e " ${b}Skype${enda} Was Successfully Installed"
  echo && echo -e " Run Skype From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Teamviewer
function installteamviewer {
  showlogo
  echo -e " Preparing To Install ${b}Teamviewer${enda}" && echo
  echo -e " ${bu}TeamViewer is a proprietary computer software package for
 remote control, desktop sharing, online meetings, web
 conferencing and file transfer between computers. The
 software operates with the Microsoft Windows, OS X, Linux,
 iOS, Android, Windows RT and Windows Phone operating
 systems. It is also possible to access a machine running
 TeamViewer with a web browser. While the main focus of
 the application is remote control of computers, collaboration
 and presentation features are included.
 Read more about it here: ${b}https://goo.gl/ipVwtn${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Teamviewer${enda}"
   yay -S --noconfirm teamviewer 
  echo -e " ${b}Teamviewer${enda} Was Successfully Installed"
  echo && echo -e " Run Teamviewer From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# install Opera
function installopera {
  showlogo
  echo -e " Preparing To Install ${b}Opera Browser${enda}" && echo
  echo -e "Opera is a web browser developed by Opera Software.
  The latest version is available for Microsoft Windows, OS X, and Linux
  operating systems, and uses the Blink layout engine. An earlier version
  using the Presto layout engine is still available, and additionally runs
  on FreeBSD systems.${bu}
 Read more about it here: ${b}https://goo.gl/NACi8W${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Opera${enda}"
   sudo pacman -S --noconfirm opera
  echo -e " ${b}Opera ${enda} Was Successfully installed"
 echo && echo -e " Run Opera Browser From The : ${b}Internet${endc} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Adobe Flash Player
function installflashplugin {
  showlogo
  echo -e " Preparing To In Install ${b}Adobe Flash Player${enda}" && echo
  echo -e " ${b}${r}ATTENTION:${enda} ${bu}You Need To Close All Your Browsers
  Before Installing."
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Adobe Flash Player${enda}"
  pacman -S --noconfirm flashplugin
  echo -e " ${b}Adobe Flash Player${enda} Was Successfully Installed"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Tilix
function installtilix {
  showlogo
  echo -e " Preparing To Install ${b}Tilix${enda}" && echo
  echo -e " ${bu}Tilix is an advanced GTK3 tiling terminal emulator that
   follows the Gnome Human Interface Guidelines.
 Read more about it here: $https://gnunn1.github.io/tilix-web/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Tilix${enda}"
   sudo pacman -S --noconfirm tilix
  echo -e " ${b}Tilix${enda} Was Successfully Installed"
  echo && echo -e " Run Tilix From The ${b}Accessories${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Gnome Tweak Tool
function installgnometweaktool {
  showlogo
  echo -e " Preparing To Install ${b}Gnome Tweak Tool${enda}" && echo
  echo -e " ${bu}A tool to customize advanced GNOME 3 options.
 Read more about it here: ${b}https://goo.gl/f3ZGu8${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Gnome Tweak Tool${enda}"
   sudo pacman -S --noconfirm gnome-tweak-tool
  echo -e " ${b}Gnome Tweak Tool${enda} Was Successfully Installed"
  echo && echo -e " Run Gnome Tweak Tool From The Terminal: ${b}gnome-tweak-tool${enda} or From ${b}System${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install netctl
function installnetctlr {
  showlogo
  echo -e " Preparing To Install ${b}netctl${enda}" && echo
  echo -e " ${bu}Simple and robust tool to manage network
  connections via profiles. Intended for use with systemd {https://goo.gl/k4qHuW}
  Read more about it here: ${b}https://goo.gl/KQRTHt${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}netctl${enda}"
   sudo pacman -S --noconfirm netctl
  echo -e " ${b}Skype${enda} Was Successfully Installed"
  echo && echo -e " Run netctl From The ${b}Terminal${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

 # Install NetworkManager
function installNetworkManager {
  showlogo
  echo -e " Preparing To Install ${b}NetworkManager${enda}" && echo
  echo -e " ${bu}anager that provides wired, wireless, mobile broadband and
  OpenVPN detection with configuration and automatic connection.
  Read more about it here: ${b}https://goo.gl/HsZyQS${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}NetworkManager${enda}"
   sudo pacman -S --noconfirm networkmanager
  echo -e " ${b}NetworkManager${enda} Was Successfully Installed"
  echo && echo -e " Run networkmanager From The ${b}Terminal${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install systemd-networkd
function installsystemnet {
  showlogo
  echo -e " Preparing To Install ${b}systemd-networkd${enda}" && echo
  echo -e " ${bu}Native systemd daemon that manages network configuration.
  It includes support for basic network configuration through udev.
  Read more about it here: ${b}https://goo.gl/hGjd1H${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}systemd-networkd${enda}"
   sudo pacman -S --noconfirm systemd
  echo -e " ${b}systemd-networkd${enda} Was Successfully Installed"
  echo && echo -e " Run systemd-networkd From The ${b}Terminal${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Wicd
function installWicd {
  showlogo
  echo -e " Preparing To Install ${b}Wicd${enda}" && echo
  echo -e " ${bu}Wireless and wired connection manager with few dependencies.
  Comes with an ncurses interface,and a GTK interface wicd-gtk is available.
  Read more about it here: ${b}https://goo.gl/kNgPhE${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Wicd${enda}"
   sudo pacman -S --noconfirm wicd
  echo -e " ${b}Wicd${enda} Was Successfully Installed"
  echo && echo -e " Run wicd From The ${b}Terminal${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install OpenConnect
function installopenconnect {
  showlogo
  echo -e " Preparing To Install ${b}OpenConnect${enda}" && echo
  echo -e " ${bu}OpenConnect is a client for Cisco's AnyConnect SSL VPN, which is supported by
  the ASA5500 Series, by IOS 12.4(9)T or later on Cisco SR500, 870,
  880, 1800, 2800, 3800, 7200 Series and Cisco 7301 Routers, and probably others.
  Read more about it here: ${b}https://goo.gl/sAffAW${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}OpenConnect${enda}"
   sudo pacman -S --noconfirm openconnect
  echo -e " ${b}OpenConnect${enda} Was Successfully Installed"
  echo && echo -e " Run openconnect From The ${b}Terminal${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install PPTP Client
function installpptpclient  {
  showlogo
  echo -e " Preparing To Install ${b}PPTP Client${enda}" && echo
  echo -e " ${bu}pptpclient is a program implementing the Microsoft PPTP protocol.
  As such, it can be used to connect to a Microsoft VPN network
  (or any PPTP-based VPN) provided by a school or workplace.
  Read more about it here: ${b}https://goo.gl/ZesX6d${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}PPTP Client${enda}"
   sudo pacman -S --noconfirm pptpclient
  echo -e " ${b}PPTP Client${enda} Was Successfully Installed"
  echo && echo -e " Run pptpclient From The ${b}Terminal${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Firefox Devoleper Edition
function installfirefoxDev  {
  showlogo
  echo -e " Preparing To Install ${b}Firefox Devoleper Edition ${enda}" && echo
  echo -e " ${bu}Firefox is a free and open-source web browser developed
  by the Mozilla Foundation and its subsidiary, the Mozilla Corporation.
  Firefox is available for Windows, OS X and Linux operating systems,
  with its mobile versions available for Android, and Firefox OS;
  where all of these versions use the Gecko layout engine to render
  web pages.
  Read more about it here: ${b}https://goo.gl/KiiRPg${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Firefox${enda}"
   sudo pacman -S --noconfirm firefox-developer-edition
  echo -e " ${b}Firefox${enda} Was Successfully Installed"
  echo && echo -e " Run Firefox From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Firefox
function installfirefox  {
  showlogo
  echo -e " Preparing To Install ${b}Firefox${enda}" && echo
  echo -e " ${bu}Firefox is a free and open-source web browser developed
  by the Mozilla Foundation and its subsidiary, the Mozilla Corporation.
  Firefox is available for Windows, OS X and Linux operating systems,
  with its mobile versions available for Android, and Firefox OS;
  where all of these versions use the Gecko layout engine to render
  web pages.
  Read more about it here: ${b}https://goo.gl/KiiRPg${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Firefox${enda}"
   sudo pacman -S --noconfirm firefox
  echo -e " ${b}Firefox${enda} Was Successfully Installed"
  echo && echo -e " Run Firefox From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}



# Install Youtube Downloader Gui
function installytgui  {
  showlogo
  echo -e " Preparing To Install ${b}Youtube Downloader (Gui)${enda}" && echo
  echo -e " ${bu}A cross platform front-end GUI
  of the popular youtube-dl written in wxPython.
  Read more about it here: ${b}https://goo.gl/twJ5Gm${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Youtube Downloader (Gui)${enda}"
   yay -S --noconfirm youtube-dl-gui-git 
  echo -e " ${b}Youtube Downloader (Gui)${enda} Was Successfully Installed"
  echo && echo -e " Run Youtube Downloader (Gui) From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install iceweasel
function installice  {
  showlogo
  echo -e " Preparing To Install ${b}GNU IceCat (Iceweasel)${enda}" && echo
  echo -e " ${bu}IceWeasel,is a free software rebranding of the Mozilla Firefox
  web browser distributed by the GNU Project.
  It is compatible with Linux, Windows, Android and OS X.
  Read more about it here: ${b}https://goo.gl/m8koYc${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}GNU IceCat (Iceweasel)${enda}"
   yay -S --noconfirm iceweasel 
  echo -e " ${b}GNU IceCat (Iceweasel)${enda} Was Successfully Installed"
  echo && echo -e " Run GNU IceCat (Iceweasel) From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install VLC
function installvlc  {
  showlogo
  echo -e " Preparing To Install ${b}VLC${enda}" && echo
  echo -e " ${bu}VLC is a free and open source cross-platform multimedia player
  and framework that plays most multimedia files, and various streaming protocols.
  Read more about it here: ${b}https://goo.gl/HzVh5v${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}VLC${enda}"
   sudo pacman -S --noconfirm vlc
  echo -e " ${b}VLC${enda} Was Successfully Installed"
  echo && echo -e " Run VLC From The ${b}Multimedia${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install PulseAudio
function installpulse  {
  showlogo
  echo -e " Preparing To Install ${b}PulseAudio${enda}" && echo
  echo -e " ${bu}serves as a proxy to sound applications using existing
  kernel sound components like ALSA or OSS. Since ALSA is included in
  Arch Linux by default,
  the most common deployment scenarios include PulseAudio with ALSA.
  Read more about it here: ${b}https://goo.gl/fjPX6d${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}PulseAudio${enda}"
   sudo pacman -S --noconfirm pulseaudio pulseaudio-alsa pulseaudio-equalizer
  echo -e " ${b}PulseAudio${enda} Was Successfully Installed"
  echo && echo -e " Run PulseAudio From The ${b}multimedia${enda} Menu or from Terminal ${b}pulseaudio${enda} "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install vivaldi
function installvivaldi  {
  showlogo
  echo -e " Preparing To Install ${b}vivaldi${enda}" && echo
  echo -e " ${bu}Vivaldi is a free web browser  developed by
  Vivaldi Technologies.
  Read more about it here: ${b}https://goo.gl/cQud1m${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}vivaldi${enda}"
  yay -S --noconfirm vivaldi 
  echo -e " ${b}vivaldi${enda} Was Successfully Installed"
  echo && echo -e " Run vivaldi From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Wifi-Menu + Dependencies
function installwifimenu  {
  showlogo
  echo -e " Preparing To Install ${b}wifi-menu${enda}" && echo
  echo -e " ${bu}wifi-menu is a service for connecting to the wifi points
  using wpa_supplicant."
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}wifi-menu${enda}"
   sudo pacman -S --noconfirm wifi-menu dialog wpa_supplicant
  echo -e " ${b}wifi-menu${enda} Was Successfully Installed"
  echo && echo -e " Run wifi-menu From The ${b}Terminal${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Gwget
function installgwget  {
  showlogo
  echo -e " Preparing To Install ${b}Gwget${enda}" && echo
  echo -e " ${bu}Gwget it's a download manager for the Gnome Desktop
  Read more about it here: ${b}https://goo.gl/2B9Ygo${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Gwget${enda}"
   sudo pacman -S --noconfirm gwget
  echo -e " ${b}Gwget${enda} Was Successfully Installed"
  echo && echo -e " Run Gwget From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install KGet
function installkget  {
  showlogo
  echo -e " Preparing To Install ${b}KGet${enda}" && echo
  echo -e " ${bu}KGet is a free download manager for KDE, and is part of
  the KDE Network package. By default it is the download manager used for
  Konqueror, but can also be used with Mozilla Firefox and rekonq.
  KGet was featured by Tux Magazineand Free Software Magazine
  Read more about it here: ${b}https://goo.gl/44Yxq2${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}KGet${enda}"
   sudo pacman -S --noconfirm kdenetwork-kget
  echo -e " ${b}KGet${enda} Was Successfully Installed"
  echo && echo -e " Run KGet From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Uget
function installuget  {
  showlogo
  echo -e " Preparing To Install ${b}Uget${enda}" && echo
  echo -e " ${bu}uGet is a Powerful download manager application
  with a large inventory of features but is still very light-weight
  and low on resources.
  Read more about it here: ${b}https://goo.gl/3RmTCz${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Uget${enda}"
   sudo pacman -S --noconfirm uget
  echo -e " ${b}Uget${enda} Was Successfully Installed"
  echo && echo -e " Run Uget From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install curlftpfs
function installcurlftpfs  {
  showlogo
  echo -e " Preparing To Install ${b}Curl ftpfs${enda}" && echo
  echo -e " ${bu}CurlFtpFS is a filesystem for accessing FTP hosts
  based on FUSE and libcurl.
  Read more about it here: ${b}https://goo.gl/8492Uf${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Curl ftpfs${enda}"
   sudo pacman -S --noconfirm curlftpfs
  echo -e " ${b}Curl ftpfs${enda} Was Successfully Installed"
  echo && echo -e " Run curlftpfs From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install qBittorrent
function installqbittorrent  {
  showlogo
  echo -e " Preparing To Install ${b}qBittorrent${enda}" && echo
  echo -e " ${bu}qBittorrent is a cross-platform client for the
  BitTorrent protocol. It is open-source software released
  under the GNU General Public License version 2 (GPLv2).
  Read more about it here: ${b}https://goo.gl/ymzcCS${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}qBittorrent${enda}"
   sudo pacman -S --noconfirm qbittorrent qbittorrent-nox
  echo -e " ${b}qBittorrent${enda} Was Successfully Installed"
  echo && echo -e " Run qBittorrent From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Kmail
function installkmail  {
  showlogo
  echo -e " Preparing To Install ${b}Kmail${enda}" && echo
  echo -e " ${bu}Kmail supports folders, filtering, viewing HTML mail,
  and international character sets. It can handle IMAP, IMAP IDLE, dIMAP,
  POP3, and local mailboxes for incoming mail. It can send mail via SMTP
  or sendmail protocols. It can forward HTML mail as an attachment but
  it cannot forward mail inline.
  Read more about it here: ${b}https://goo.gl/vzJMFA${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Kmail${enda}"
   sudo pacman -S --noconfirm kmail
  echo -e " ${b}Kmail${enda} Was Successfully Installed"
  echo && echo -e " Run Kmail From The ${b}Internet${enda} menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Claws Mail
function installclawsmail  {
  showlogo
  echo -e " Preparing To Install ${b}Claws Mail${enda}" && echo
  echo -e " ${bu}Claws Mail is a free and open source, GTK+-based email
  and news client. It offers easy configuration and an abundance of features.
  It stores mail in the MH mailbox format and also the Mbox mailbox format
  via a plugin.
  Claws Mail runs on both Windows and Unix-like systems such as Linux, BSD and
  Solaris.
  Read more about it here: ${b}https://goo.gl/gmuxra${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Claws Mail${enda}"
   sudo pacman -S --noconfirm claws-mail
  echo -e " ${b}Claws Mail${enda} Was Successfully Installed"
  echo && echo -e " Run Claws Mail From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install HexChat
function installhexchat  {
  showlogo
  echo -e " Preparing To Install ${b}HexChat${enda}" && echo
  echo -e " ${bu}HexChat is an IRC client based on XChat,but unlike XChat
  it’s completely free for both Windows and Unix-like systems.
  Since XChat is open source, it’s perfectly legal.
  Read more about it here: ${b}https://goo.gl/BY1Lgj${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}HexChat${enda}"
   sudo pacman -S --noconfirm hexchat
  echo -e " ${b}HexChat${enda} Was Successfully Installed"
  echo && echo -e " Run HexChat From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Dino
function installdino  {
  showlogo
  echo -e " Preparing To Install ${b}Dino${enda}" && echo
  echo -e " ${bu}Dino is a modern open-source chat client for the 
  desktop. It focuses on providing a clean and reliable Jabber/XMPP 
  experience while having your privacy in mind.
  Read more about it here: ${b}https://dino.im${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Dino${enda}"
   yay -S --noconfirm dino-git
  echo -e " ${b}Dino${enda} Was Successfully Installed"
  echo && echo -e " Run XMPP Chat Client From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Open Broadcaster Softwar Studio (OBS)
function installobs  {
  showlogo
  echo -e " Preparing To Install ${b}Open Broadcaster Softwar Studio (OBS)${enda}" && echo
  echo -e " ${bu}What is OBS?
  Open Broadcaster Software is free and open source software for video
  recording and live streaming. Supported features include:
  +Encoding using H264 (x264) and AAC.
  +Support for Intel Quick Sync Video (QSV) and NVENC.
  +Unlimited number of scenes and sources.
  +Live RTMP streaming to Twitch, YouTube, DailyMotion, Hitbox and more.
  +File output to MP4 or FLV.
  +GPU-based game capture for high performance game streaming.
  +DirectShow capture device support (webcams, capture cards, etc).
  +Bilinear or lanczos3 resampling.
  Read more about it here: ${b}https://goo.gl/UDmndA${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Open Broadcaster Softwar Studio (OBS)${enda}"
   sudo pacman -S --noconfirm obs-studio
  echo -e " ${b}Open Broadcaster Softwar Studio (OBS)${enda} Was Successfully Installed"
  echo && echo -e " Run Open Broadcaster Softwar Studio (OBS) From The ${b}Multimedia${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Quassel
function installquassel  {
  showlogo
  echo -e " Preparing To Install ${b}Quassel${enda}" && echo
  echo -e " ${bu}Quassel (sometimes referred to as Quassel IRC) is a
  cross-platform IRC client introduced in 2008. It is dual-licensed
  under GPLv2 and GPLv3, while most graphical data is licensed under
  the LGPL and provided by the Oxygen Team. The client part of Quassel
  uses the Qt framework for its user interface.
  Read more about it here: ${b}https://goo.gl/Bk93XD${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Quassel${enda}"
   sudo pacman -S --noconfirm quassel-core quassel-client quassel-monolithic
  echo -e " ${b}Quassel${enda} Was Successfully Installed"
  echo && echo -e " Run Quassel From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Armory
function installarmory  {
  showlogo
  echo -e " Preparing To Install ${b}Armory${enda}" && echo
  echo -e " ${bu}Armory is a full-featured Bitcoin client, offering a dozen
  innovative features not found in any other client software! Manage multiple
  wallets (deterministic and watching-only), print paper backups that work forever,
  import or sweep private keys, and keep your savings in a computer that never touches
  the internet.
  Read more about it here: ${b}https://goo.gl/UQDMTD${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Armory${enda}"
   yay -S --noconfirm armory-bin
  echo -e " ${b}Armory${enda} Was Successfully Installed"
  echo && echo -e " Run Armory From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Bitcoin
function installbtc  {
  showlogo
  echo -e " Preparing To Install ${b}Bitcoin ${enda}" && echo
  echo -e " ${bu}Bitcoin is a decentralized P2P electronic cash system without a
  central server or trusted parties. Users hold the cryptographic keys to
  their own money and make transactions directly with each other, with the help
  of the network to check for double-spending. Bitcoins, usually denoted by BTC.
  Read more about it here: ${b}https://goo.gl/k6hpRC${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Bitcoin ${enda}"
   sudo pacman -S --noconfirm bitcoin-daemon bitcoin-qt
  echo -e " ${b}Bitcoin ${enda} Was Successfully Installed"
  echo && echo -e " Run Bitcoin From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}


# Install Avidemux
function installavidemux  {
  showlogo
  echo -e " Preparing To Install ${b}Avidemux${enda}" && echo
  echo -e " ${bu}Free video editor designed for simple cutting,
  filtering and encoding tasks.
  Read more about it here: ${b}https://goo.gl/VXdtcP${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Avidemux${enda}"
   sudo pacman -S --noconfirm avidemux-cli avidemux-qt
  echo -e " ${b}Avidemux${enda} Was Successfully Installed"
  echo && echo -e " Run Avidemux From The ${b}Multimedia${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install FFmpeg
function installffmpeg   {
  showlogo
  echo -e " Preparing To Install ${b}FFmpeg ${enda}" && echo
  echo -e " ${bu}Complete, cross-platform solution to record,
  convert and stream audio and video.
  Read more about it here: ${b}https://goo.gl/Bi7imE${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}FFmpeg ${enda}"
   sudo pacman -S --noconfirm ffmpeg
  echo -e " ${b}FFmpeg ${enda} Was Successfully Installed"
  echo && echo -e " Run FFmpeg  From The ${b}Multimedia${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Kdenlive
function installkdenlive   {
  showlogo
  echo -e " Preparing To Install ${b}Kdenlive ${enda}" && echo
  echo -e " ${bu}Kdenlive is an intuitive and powerful multi-track
  video editor, including most recent video technologies, released
  as a free software (GPL). Using Kdenlive is investing in a community
  driven project, which aims to establish relationships between people
  in order to built the best video tools.
  Read more about it here: ${b}https://goo.gl/JRVnzY${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Kdenlive ${enda}"
   sudo pacman -S --noconfirm kdenlive
  echo -e " ${b}Kdenlive ${enda} Was Successfully Installed"
  echo && echo -e " Run Kdenlive  From The ${b}Multimedia${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}


# Install Liferea
function installlifearea  {
  showlogo
  echo -e " Preparing To Install ${b}Liferea${enda}" && echo
  echo -e " ${bu}Liferea is an abbreviation for Linux Feed Reader,
    a news aggregator for online news feeds. It supports the major feed
    formats including RSS/RDF and Atom and can import and export
    subscription lists in OPML format. Liferea is intended to be
    a fast, easy to use, and easy to install news aggregator for GTK+
    that can be used with the GNOME desktop.Liferea features a script
    manager.
  Read more about it here: ${b}https://goo.gl/mt3cGV${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Liferea${enda}"
   sudo pacman -S --noconfirm liferea
  echo -e " ${b}Liferea${enda} Was Successfully Installed"
  echo && echo -e " Run Liferea From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Krita
function installkrita  {
  showlogo
  echo -e " Preparing To Install ${b}Krita${enda}" && echo
  echo -e " ${bu}Krita is a FREE sketching and painting program.
  It was created with the following types of art in mind :
  concept art
  texture or matte painting
  illustrations and comics
  Read more about it here: ${b}https://goo.gl/Jiiu2y${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Krita${enda}"
   sudo pacman -S --noconfirm krita
  echo -e " ${b}Krita${enda} Was Successfully Installed"
  echo && echo -e " Run Krita From The ${b}Graphics${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH EDITORS ##################################################
# Install Geany
function installgeary {
  echo
  echo -e " Currently Installing ${b}Geary${enda}"
  echo -e " ${bu}Geary is a free and open-source email client 
  written in Vala and based on WebKitGTK. Although since adopted
  by the GNOME project.
 Read more about it here: ${b}https://wiki.gnome.org/Apps/Geary${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Geany${enda}"
  yay -S --noconfirm geany
  echo -e " ${b}Geany${enda} Was Successfully Installed"
  echo && echo " Run geany From ${b}Internet${endc}"
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}


# Install Emacs
function installemacs {
  echo
  echo -e " Currently Installing ${b}Emacs${enda}"
  echo -e " ${bu}GNU Emacs is an extensible, customizable text editor—and
 more. At its core is an interpreter for Emacs Lisp,
 a dialect of the Lisp Development language with
 extensions to support text editing.
 Read more about it here: ${b}https://goo.gl/2aEvFi${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Emacs${enda}"
   sudo pacman -S --noconfirm emacs
  echo -e " ${b}Emacs${enda} Was Successfully Installed"
  echo && echo " Run Emacs From ${b}Development${endc}"
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}

# Install GEdit
function installgedit {
  showlogo
  echo -e " ${y}Preparing To Install GEdit${endc}" && echo
  echo -e " ${bu}GEdit is a text editor for the GNOME desktop environment,
 Mac OS X and Microsoft Windows. Designed as a general purpose
 text editor, GEdit emphasizes simplicity and ease of use.
 It includes tools for editing source code and structured
 text such as markup languages.
 Read more about it here: ${b}https://goo.gl/PsfkTc${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}GEdit${enda}"
   sudo pacman -S --noconfirm gedit
  echo -e " ${b}GEdit${enda} Was Successfully Installed"
  echo && echo -e "Run GEdit From The ${b}Accessories${endc} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install Geany
function installgeany {
  showlogo
  echo -e " ${y}Preparing To Install Geany${endc}" && echo
  echo -e " ${bu}Geany is a text editor using the GTK2 toolkit with
 basic features of an integrated development environment.
 It was developed to provide a small and fast IDE, which has
 only a few dependencies from other packages. It supports
 many filetypes and has some nice features.
 Read more about it here: ${b}https://goo.gl/m8Kqqq${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Geany${enda}"
   sudo pacman -S --noconfirm geany
  echo -e " ${b}Geany${enda} Was Successfully Installed"
  echo && echo -e " Run Geany From The ${b}Development${endc} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}



# Install VIM
function installvim  {
  showlogo
  echo -e " Preparing To Install ${b}VIM${enda}" && echo
  echo -e " ${bu}Vi Improved, a highly configurable, improved version
  of the vi text editor (with advanced features, such as a GUI)
  Read more about it here: ${b}https://goo.gl/gRd3Ej${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}VIM${enda}"
   sudo pacman -S --noconfirm gvim
  echo -e " ${b}VIM${enda} Was Successfully Installed"
  echo && echo -e " Run VIM From The ${b}Accessories${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Kate
function installkate  {
  showlogo
  echo -e " Preparing To Install ${b}Kate${enda}" && echo
  echo -e " ${bu}Kate (short for KDE Advanced Text Editor) is a
  text editor developed by KDE. It has been a part of KDE Software
  Compilation since version 2.2, which was first released in 2001.
  Geared towards software developers, it features syntax highlighting,
  code folding, customizable layouts, regular expression support, and
  extensibility.
  Read more about it here: ${b}https://goo.gl/B9GAEe${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Kate${enda}"
   sudo pacman -S --noconfirm kate
  echo -e " ${b}Kate${enda} Was Successfully Installed"
  echo && echo -e " Run Kate From The ${b}Accessories${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH DEVOLEPER ##################################################

# Install Atom
function installatom  {
  showlogo
  echo -e " Preparing To Install ${b}Atom${enda}" && echo
  echo -e " ${bu}Atom is an open-source text editor developed by
  GitHub that is licensed under the MIT License.
  It is written predominantly in CoffeeScript and JavaScript and uses
  Node.js as its runtime environment. It is extensively extensible via
  use of over 4,000 available packages and 1,000 themes. It uses its own
  package manager for managing these packages and themes
  Read more about it here: ${b}https://goo.gl/Hwsk1E${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Atom${enda}"
  yay -S --noconfirm atom
  echo -e " ${b}Atom${enda} Was Successfully Installed"
  echo && echo -e " Run Atom From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Arduino
function installarduino {
  showlogo
  echo -e " Preparing To Install ${b}Arduino${enda}" && echo
  echo -e " ${bu}Arduino is an open-source electronics platform based on 
  easy-to-use hardware and software. It's intended for anyone making interactive projects.
  Read more about it here: ${b}https://www.arduino.cc${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Arduino${enda}"
   sudo pacman -S --noconfirm arduino arduino-avr-core arduino-builder arduino-cli arduino-cli
  echo -e " ${b}Anjuta${enda} Was Successfully Installed"
  echo && echo -e " Run Arduino From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Android Studio
function installaptana  {
  showlogo
  echo -e " Preparing To Install ${b}Aptana Studio${enda}" && echo
  echo -e " ${bu}IDE based on Eclipse, but geared towards web development,
  with support for HTML, CSS, Javascript, Ruby on Rails, PHP, Adobe AIR and
  others.
  Read more about it here: ${b}https://goo.gl/mEAcxe${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Aptana Studio${enda}"
   yay -S --noconfirm aptana-studio 
  echo -e " ${b}Aptana Studio${enda} Was Successfully Installed"
  echo && echo -e " Run Aptana Studio From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Bluefish
function installbluefish  {
  showlogo
  echo -e " Preparing To Install ${b}Bluefish${enda}" && echo
  echo -e " ${bu}GTK+ editor/IDE with an MDI interface, syntax
  highlighting and support for Python plugins.
  Read more about it here: ${b}https://goo.gl/b4c2XH${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Bluefish${enda}"
   sudo pacman -S --noconfirm bluefish
  echo -e " ${b}Bluefish${enda} Was Successfully Installed"
  echo && echo -e " Run Bluefish From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Bluej
function installbluej  {
  showlogo
  echo -e " Preparing To Install ${b}Bluej${enda}" && echo
  echo -e " ${bu}Fully featured Java IDE used mainly for educational
  and beginner purposes.
  Read more about it here: ${b}https://goo.gl/axihPM${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Bluej${enda}"
   yay -S --noconfirm bluej
  echo -e " ${b}Bluej${enda} Was Successfully Installed"
  echo && echo -e " Run Bluej From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Brackets
function installbrackets  {
  showlogo
  echo -e " Preparing To Install ${b}Brackets${enda}" && echo
  echo -e " ${bu}A free open-source editor written in HTML, CSS,
  and Javascript with a primary focus on Web Development.
  It was created by Adobe Systems, licensed under the MIT License,
  and is currently maintained on GitHub.
  Read more about it here: ${b}https://goo.gl/DvcBxW${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Brackets${enda}"
  yay -S --noconfirm brackets 
  echo -e " ${b}Brackets${enda} Was Successfully Installed"
  echo && echo -e " Run Brackets From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Code::Blocks
function installcodeblocks {
  showlogo
  echo -e " Preparing To Install ${b}Code::Blocks${enda}" && echo
  echo -e " ${bu}Code::Blocks is a free, open-source cross-platform IDE
  that supports multiple compilers including GCC, Clang and Visual C++.
  It is developed in C++ using wxWidgets as the GUI toolkit.
  Using a plugin architecture, its capabilities and features are defined
  by the provided plugins. Currently, Code::Blocks is oriented towards C,
  C++, and Fortran. It has a custom build system and optional Make support.
  Read more about it here: ${b}https://goo.gl/ZbD6iN${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Code::Blocks${enda}"
   sudo pacman -S --noconfirm codeblocks
  echo -e " ${b}Code::Blocks${enda} Was Successfully Installed"
  echo && echo -e " Run Code::Blocks From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Cloud9
function installcloud9 {
  showlogo
  echo -e " Preparing To Install ${b}Cloud9${enda}" && echo
  echo -e " ${bu}State-of-the-art IDE that runs in your browser
  and lives in the cloud, allowing you to run, debug and deploy
  applications from anywhere, anytime.
  Read more about it here: ${b}https://goo.gl/iMy8m1${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Cloud9${enda}"
   yay -S --noconfirm c9.core 
  echo -e " ${b}Cloud9${enda} Was Successfully Installed"
  echo && echo -e " Run Cloud9 From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Eclipse
function installeclipse {
  showlogo
  echo -e " Preparing To Install ${b}Eclipse (Java)${enda}" && echo
  echo -e " ${bu}Open source community project, which aims
  to provide a universal development platform.
  Read more about it here: ${b}https://goo.gl/fiawqM${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Eclipse (Java)${enda}"
   sudo pacman -S --noconfirm eclipse-java
  echo -e " ${b}Eclipse (Java PHP Rust)${enda} Was Successfully Installed"
  echo && echo -e " Run Eclipse (Java) From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Editra
function installeditra {
  showlogo
  echo -e " Preparing To Install ${b}Editra${enda}" && echo
  echo -e " ${bu}Multi-platform text editor with an implementation that
  focuses on creating an easy to use interface and features that aid in
  code development.
  Read more about it here: ${b}https://goo.gl/6Kf4H5${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Editra${enda}"
   yay -S --noconfirm editra 
  echo -e " ${b}Editra${enda} Was Successfully Installed"
  echo && echo -e " Run Editra From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install GitKraken
function installkraken {
  showlogo
  echo -e " Preparing To Install ${b}GitKraken${enda}" && echo
  echo -e " ${bu}The legendary Git Client + Glo Boards for issue tracking
  Read more about it here: ${b}https://www.gitkraken.com${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Editra${enda}"
   yay -S --noconfirm gitkraken
  echo -e " ${b}Editra${enda} Was Successfully Installed"
  echo && echo -e " Run GitKraken From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}



# Install IntelliJIDEA
function installintellij {
  showlogo
  echo -e " Preparing To Install ${b}IntelliJ IDEA${enda}" && echo
  echo -e " ${bu}IDE for Java, Groovy and other programming languages
  with advanced refactoring features.
  Read more about it here: ${b}https://www.jetbrains.com/idea/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}IntelliJ IDEA${enda}"
   sudo pacman -S --noconfirm intellij-idea-community-edition
  echo -e " ${b}IntelliJ IDEA${enda} Was Successfully Installed"
  echo && echo -e " Run IntelliJ IDEA From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install IntelliJIDEA
function installintelliju {
  showlogo
  echo -e " Preparing To Install ${b}IntelliJ IDEA Ultimate${enda}" && echo
  echo -e " ${bu}IDE for Java, Groovy and other programming languages
  with advanced refactoring features.
  Read more about it here: ${b}https://www.jetbrains.com/idea/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}IntelliJ IDEA${enda}"
   yay -S --noconfirm intellij-idea-ultimate-edition
  echo -e " ${b}IntelliJ IDEA${enda} Was Successfully Installed"
  echo && echo -e " Run IntelliJ IDEA From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install MonoDevelop
function installmonodev {
  showlogo
  echo -e " Preparing To Install ${b}MonoDevelop${enda}" && echo
  echo -e " ${bu} Cross-platform IDE targeted for the Mono and
  .NET frameworks.
  Read more about it here: ${b}https://goo.gl/ZuyDoY${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}MonoDevelop${enda}"
   sudo pacman -S --noconfirm monodevelop
  echo -e " ${b}MonoDevelop${enda} Was Successfully Installed"
  echo && echo -e " Run MonoDevelop From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Netbeans
function installnetbeans {
  showlogo
  echo -e " Preparing To Install ${b}Netbeans${enda}" && echo
  echo -e " ${bu}Integrated development environment (IDE) for developing with
  Java, JavaScript, PHP, Python, Ruby,Groovy, C, C++, Scala, Clojure,
  and other languages.
  Read more about it here: ${b}https://goo.gl/BtS225${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Netbeans${enda}"
   sudo pacman -S --noconfirm netbeans
  echo -e " ${b}Netbeans${enda} Was Successfully Installed"
  echo && echo -e " Run Netbeans From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Ninja-IDE
function installninja {
  showlogo
  echo -e " Preparing To Install ${b}Ninja-IDE${enda}" && echo
  echo -e " ${bu}\"Ninja-IDE Is Not Just Another IDE\", is a cross-platform
  integrated development environment (IDE); runs on Linux/X11,
  Mac OS X and Windows OSs. Used, for example, for Python development
  Read more about it here: ${b}https://goo.gl/x8bCZa${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Ninja-IDE${enda}"
   sudo pacman -S --noconfirm ninja-ide
  echo -e " ${b}Ninja-IDE${enda} Was Successfully Installed"
  echo && echo -e " Run Ninja-IDE From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install PHPStorm
function installphpstorm {
  showlogo
  echo -e " Preparing To Install ${b}PHPStorm${enda}" && echo
  echo -e " ${bu}JetBrains PhpStorm is a commercial, cross-platform IDE
  for PHP built on JetBrains' IntelliJ IDEA platform, providing an editor
  for PHP, HTML and JavaScript with on-the-fly code analysis,
  error prevention and automated refactorings for PHP and JavaScript code.
  Read more about it here: ${b}https://goo.gl/RgiwTk${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}PHPStorm${enda}"
   yay -S --noconfirm phpstorm 
  echo -e " ${b}PHPStorm${enda} Was Successfully Installed"
  echo && echo -e " Run PHPStorm From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Sublime Text
function installsublime {
  showlogo
  echo -e " Preparing To Install ${b}Sublime Text 2${enda}" && echo
  echo -e " ${bu}Closed-source C++ and Python-based editor with many
  advanced features and plugins while staying lightweight and pretty.
  Read more about it here: ${b}https://goo.gl/JaX2XU${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Sublime Text${enda}"
   sudo pacman -S --noconfirm sublime-text sublime-text-dev
  echo -e " ${b}Sublime Text ${enda} Was Successfully Installed"
  echo && echo -e " Run Sublime Text From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Visual Studio Code
function installvistudiocode {
  showlogo
  echo -e " Preparing To Install ${b}Visual Studio Code${enda}" && echo
  echo -e " ${bu}Editor for building and debugging modern web and
  cloud applications.
  Read more about it here: ${b}https://goo.gl/paXkbK${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Visual Studio Code${enda}"
   sudo pacman -S --noconfirm visual-studio-code-bin
  echo -e " ${b}Visual Studio Code${enda} Was Successfully Installed"
  echo && echo -e " Run Visual Studio Code From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Docky
function installdocky {
  showlogo
  echo -e " Preparing To Install ${b}Docky${enda}" && echo
  echo -e " ${bu}Docky is an advanced shortcut bar that sits at the edges
  of your screen.
  It provides easy access to some of the files, folders and applications
  on your computer, displays which applications are currently running,
  holds windows in their minimized state and more.
  Read more about it here: ${b}https://goo.gl/b2jBnx${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Docky${enda}"
   sudo pacman -S --noconfirm docky
  echo -e " ${b}Docky${enda} Was Successfully Installed"
  echo && echo -e " Run Docky From The ${b}Accessories${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install XFburn
function installxfburn {
  showlogo
  echo -e " Preparing To Install ${b}XFburn${enda}" && echo
  echo -e " ${bu}A CD/DVD burning program. Starting with the 4.12 release of Xfce,
  Xfburn is also able to burn Blu-ray discs.
  Read more about it here: ${b}https://goo.gl/gMrfwk${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}XFburn${enda}"
   sudo pacman -S --noconfirm xfburn
  echo -e " ${b}XFburn${enda} Was Successfully Installed"
  echo && echo -e " Run XFburn From The ${b}Accessories${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Foxit Reader
function installfoxread {
  showlogo
  echo -e " Preparing To Install ${b}Foxit Reader${enda}" && echo
  echo -e " ${bu}PDF file reader with lot of features.
  Read more about it here: ${b}https://goo.gl/NHiF44${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Foxit Reader${enda}"
   yay -S --noconfirm foxitreader
  echo -e " ${b}Foxit Reader${enda} Was Successfully Installed"
  echo && echo -e " Run Foxit Reader From The ${b}Office${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install HTTrack (httracqt)
function installhttrack  {
  showlogo
  echo -e " Preparing To Install ${b}HTTrack (httracqt)${enda}" && echo
  echo -e " ${bu}HTTraQt - graphical user interface (GUI) for HTTrack
  library, developed in C++ and based on multiplatform Qt library
  Read more about it here: ${b}https://goo.gl/8GLVbB${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}HTTrack (httracqt)${enda}"
   yay -S --noconfirm httraqt 
  echo -e " ${b}HTTrack (httracqt)${enda} Was Successfully Installed"
  echo && echo -e " Run HTTrack (httracqt) From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Libre Office
function installlibreoffi  {
  showlogo
  echo -e " Preparing To Install ${b}Libre Office${enda}" && echo
  echo -e " ${bu}LibreOffice is Free and Open Source Software.
  Development is open to new talent and new ideas, and our software
  is tested and used daily by a large and devoted user community
  Read more about it here: ${b}https://goo.gl/dVky6B${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Libre Office${enda}"
   sudo pacman -S --noconfirm libreoffice-fresh 
  echo -e " ${b}Libre Office${enda} Was Successfully Installed"
  echo && echo -e " Run Libre Office From The ${b}Office${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install HardInfo
function installhrdinfo  {
  showlogo
  echo -e " Preparing To Install ${b}HardInfo${enda}" && echo
  echo -e " ${bu}information about your system hardware.
  Read more about it here: ${b}https://goo.gl/PGCRm7V${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}HardInfo${enda}"
   sudo pacman -S --noconfirm hardinfo
  echo -e " ${b}HardInfo${enda} Was Successfully Installed"
  echo && echo -e " Run HardInfo From The ${b}System${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}


# Install Android Studio
function installandrostu  {
  showlogo
  echo -e " Preparing To Install ${b}Android Studio${enda}" && echo
  echo -e " ${bu}Android Studio is the official Integrated Development
  Environment (IDE) for Android app development, based on IntelliJ IDEA .
  On top of IntelliJ's powerful code editor and developer tools,
  Android Studio offers even more features that enhance your productivity
  when building Android apps
  Read more about it here: ${b}https://goo.gl/F6UySp${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Android Studio${enda}"
   yay -S --noconfirm android-studio 
  echo -e " ${b}Android Studio${enda} Was Successfully Installed"
  echo && echo -e " Run Android Studio From The ${b}Development${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH SYSTEM APPS ##################################################
# Install VM Ware-Workstation
function vmware  {
  showlogo
  echo -e " Preparing To Install ${b}VM Ware-Workstarion${enda}" && echo
  echo -e " ${bu}VMware Workstation Pro is the industry standard for running multiple operating 
  systems on a single Linux or Windows PC. Workstation 15 Pro improves on the leading
  desktop with an updated high-DPI user interface, a new REST API, support for the 
  latest Windows and Linux operating systems, and more…
  Read more: ${b}https://www.vmware.com${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}VM Ware-Workstarion${enda}"
   yay -S --noanswerdiff vmware-workstation
  echo -e " ${b}VM Ware-Workstarion${enda} Was Successfully Installed"
  echo && echo -e " Run VM Ware-Workstarion From The ${b}System Tools Apps${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Virtual Box
function installvirtualbox  {
  showlogo
  echo -e " Preparing To Install ${b}Virtual Box${enda}" && echo
  echo -e " ${bu}VirtualBox is a free and open-source hypervisor for
  x86 computers from Oracle Corporation. Developed initially by Innotek GmbH,
  it was acquired by Sun Microsystems in 2008 which was in turn acquired
  by Oracle in 2010.
  Read more about it here: ${b}https://goo.gl/wkvNLU${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Virtual Box${enda}"
   sudo pacman -S --noconfirm virtualbox virtualbox-host-dkms virtualbox-guest-iso linux-headers
   yay -S --noconfirm virtualbox-ext-oracle
   add_user_to_group ${username} vboxusers
   modprobe vboxdrv vboxnetflt
  echo -e " ${b}Virtual Box${enda} Was Successfully Installed"
  echo && echo -e " Run Virtual Box From The ${b}System${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH GAMING ##################################################
# Install Steam
function installsteam {
  showlogo
  echo -e " Preparing To Install ${b}Steam${enda}" && echo
  echo -e " ${bu}Steam is a digital distribution platform developed by
  Valve Corporation offering digital rights management (DRM),
  multiplayer gaming and social networking services
  Read more about it here: ${b}https://goo.gl/ottTq9${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Steam${enda}"
  pacman -S --noconfirm steam
  echo -e " ${b}Steam${enda} Was Successfully Installed"
  echo && echo -e " Run Steam From The ${b}Accessories${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Lutris
function installlutris {
  showlogo
  echo -e " Preparing To Install ${b}Lutris${enda}" && echo
  echo -e " ${bu}Lutris is an Open Source gaming platform for Linux. 
  It installs and launches games so you can start playing without the 
  hassle of setting up your games. Get your games from GOG, Steam, 
  Battle.net, Origin, Uplay and many other sources running on any Linux 
  powered gaming machine.
  Read more about it here: ${b}https://lutris.net${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Lutris${enda}"
   sudo pacman -S --noconfirm lutris
  echo -e " ${b}Lutris${enda} Was Successfully Installed"
  echo && echo -e " Run Steam From The ${b}Accessories${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Dirscord
function installdiscord  {
  showlogo
  echo -e " Preparing To Install ${b}Discord${enda}" && echo
  echo -e " ${bu}All-in-one voice and text chat for gamers that's free, secure,
	and works on both your desktop and phone. Stop paying for TeamSpeak servers
	and hassling with Skype. Simplify your life.
  Read more about it here: ${b}https://discordapp.com${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Discord${enda}"
  yay -S --noconfirm discord
  echo -e " ${b}Discord${enda} Was Successfully Installed"
  echo && echo -e " Run Discord From The ${b}Internet${enda} Menu "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

####################################### ZARCH BLACK ARCH ##################################################
# Install Black Arch Tools
function installblack {
  showlogo
  echo -e " Preparing To Install ${b}Black Arch Tools${enda}" && echo
  echo -e " ${bu}BlackArch Linux is an Arch Linux-based penetration 
  testing distribution for penetration testers and security researchers.
  The repository contains 2325 tools. 
  Read more about it here: ${b}https://blackarch.org${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Black Arch Repository${enda}"
  sudo curl -O https://blackarch.org/strap.sh
  chmod +x strap.sh
  sudo ./strap.sh
  echo -e " ${b}Black Arch Repository${enda} Was Successfully Installed"
  echo && echo -e " # After install repository use
  
  # To list all of the available tools, run
  ${b}$ sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u
   
  # To see the blackarch categories, run
  ${b}$ sudo pacman -Sg | grep blackarch
  
  # To install a category of tools, run
  ${b}$ sudo pacman -S blackarch-<category>
  
  # To install all of the tools, run
  ${b}$ sudo pacman -S blackarch"
  echo && echo -en " ${y}Press Enter To Return To Zarch Menu${endc}"
  read input
}

######### Programs Installations : END : ##########################
#################################################################################################
#######################################3RD PART##################################################
# Menu Download managers
function downmanage {
  showlogo
  echo -e " ${b}[ Download managers ]${enda}"
  echo -e "Make A Choice
        1)    Gwget
        2)    KGet
        3)    uGet
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installgwget  ;;
  2) installkget ;;
  3) installuget ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; downmanage ;;
  esac
}

# Menu VPN clients
function showvpn {
  showlogo
  echo -e " ${b}[ VPN clients ]${enda}"
  echo -e "Make A Choice
        1)    OpenConnect
        2)    PPTP Client
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installopenconnect ;;
  2) installpptpclient ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showvpn ;;
  esac
}

# Menu FTP/Torrent Applications
function showftptorr {
  showlogo
  echo -e " ${b}[ FTP/TORRENT APPLICATIONS ]${enda}"
  echo -e "Make A Choice
        1)    FileZilla (FTP Client)
        2)    gFTP
        3)    Curl ftpfs
        4)    Qbittorrent
        5)    Transmission (Torrent Client)
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installfilez ;;
  2) installgftp ;;
  3) installcurlftpfs  ;;
  4) installqbittorrent ;;
  5) installtransmission ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showftptorr ;;
  esac
}

# Menu Chat Applications
function showchat {
  showlogo
  echo -e " ${b}[ CHAT APPLICATIONS ]${enda}"
  echo -e "Make A Choice
        1)    Claws Mail
        2)    Kmail
        3)    HexChat
        4)    Quassel
        5)    Geany Mail 
        6)    Dino (XMPP Chat)
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installclawsmail ;;
  2) installkmail ;;
  3) installhexchat ;;
  4) installquassel ;;
  5) installgeary ;;
  6) installdino ;;
  
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showchat ;;
  esac
}

# Menu Image Editors
function showimg {
  showlogo
  echo -e " ${b}[ IMAGE EDITORS ]${enda}"
  echo -e "Make A Choice
        1)    Pinta
        2)    GIMP
        3)    Inkscape
        4)    Krita
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installpinta ;;
  2) installgimp ;;
  3) installinkscape ;;
  4) installkrita ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showimg ;;
  esac
}

# Menu Archive Handlers
function showarch {
  showlogo
  echo -e " ${b}[ ARCHIVE HANDLERS ]${enda}"
  echo -e "Make A Choice
        1)    Ark (For KDE)
        2)    File-Roller (For GNOME)
        3)    Zip/Unzip
        4)    Rar/Unrar
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installark ;;
  2) installfileroller ;;
  3) installzipunzip ;;
  4) installrarunrar ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showarch ;;
  esac
}

# Text Editors Menu
function showtext {
  showlogo
  echo -e " ${b}[ TEXT EDITORS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}""
        1)    GEdit
        2)    Geany
        3)    Emacs
        4)    VIM
        5)    Kate
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installgedit ;;
  2) installgeany ;;
  3) installemacs ;;
  4) installvim ;;
  5) installkate ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showtext ;;
  esac
}

# Menu Audio Applications
function showaudio {
  showlogo
  echo -e " ${b}[ AUDIO APPLICATIONS ]${enda}"
  echo -e "Make A Choice
        1)    Audacious (Player)
        2)    Amarok (Player - For KDE)
        3)    Banshee (Player - For Gnome)
        4)    Sonata (Player - Very Tiny)
        5)    Audacity (Recorder)
        6)    Ardour (Recorder)
        7)    Sweep (Recorder & Live Playback)
        8)    VLC
        9)    Pulse Audio
        10)   Clementine (Player)
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installaudacious ;;
  2) installamarok ;;
  3) installbanshee ;;
  4) installsonata ;;
  5) installaudacity ;;
  6) installardour ;;
  7) installsweep ;;
  8) installvlc ;;
  9) installpulse ;;
  10) installclementine ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showaudio ;;
  esac
}

# Menu Web Applications
function showwebapps {
  showlogo
  echo -e " ${b}[ WEB APPLICATIONS ]${enda}"
  echo -e "Make A Choice
        1)    Chromium
        2)    Google Chrome
        3)    Firefox Browser
        4)    Youtube Downloader (Terminal)
        5)    Youtube Downloader (GUI)
        6)    Opera Browser
        7)    Iceweasel Browser
        8)    Vivaldi Browser
        9)    Adobe Flash Player
        10)   Firefox Devoleper Edition
        11)   Breaker Browser (P2P)
        12)   Brave Browser
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installchromium ;;
  2) installchrome ;;
  3) installfirefox ;;
  4) installytbdwn ;;
  5) installytgui ;;
  6) installopera ;;
  7) installice ;;
  8) installvivaldi ;;
  9) installflashplugin ;;
  10) installfirefoxDev ;;
  11) installBreakerb ;;
  12) installBrave ;;

  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showwebapps ;;
  esac
}

# Menu Development Environments
function showdevapps {
  showlogo
  echo -e " ${b}[ Development Environments ]${enda}"
  echo -e "Make A Choice
        1)    Arduino
        2)    Android Studio
        3)    Bluefish
        4)    Bluej
        5)    Brackets
        6)    Code::Blocks
        7)    Cloud9
        8)    Eclipse (Java)
        9)    Editra
        10)   IntelliJ IDEA Community Edition
        11)   MonoDevelop
        12)   Netbeans
        13)   Ninja-IDE
        14)   PHPStorm
        15)   Sublime Text
        16)   Visual Studio Code
        17)   Atom Editor
        18)   InteliJ IDEA Ultimate Edition
        19)   Gitkraken
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installarduino ;;
  2) installaptana ;;
  3) installbluefish ;;
  4) installbluej ;;
  5) installbrackets ;;
  6) installcodeblocks ;;
  7) installcloud9 ;;
  8) installeclipse ;;
  9) installeditra ;;
  10) installintellij ;;
  11) installmonodev ;;
  12) installnetbeans ;;
  13) installninja ;;
  14) installphpstorm ;;
  15) installsublime ;;
  16) installvistudiocode ;;
  17) installatom ;;
  18) installintelliju ;;
  19) installkraken ;;
  
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showdevapps ;;
  esac
}

# Menu System Tools
function systemtools {
  showlogo
  echo -e " ${b}[ SYSTEM TOOLS APPS ]${enda}"
  echo -e "Make A Choice
        1)    VMware Workstation
  
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) vmware ;;

  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showwebapps ;;
  esac
}

# Menu Gamer
function showgamer {
  showlogo
  echo -e " ${b}[ Gamer APPS ]${enda}"
  echo -e "Make A Choice
        1) Steam
        2) Lutris
        3) Discord
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installsteam ;;
  2) installlutris ;;
  3) installdiscord ;;

  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showgamer ;;
  esac
}

# Menu Black Arch Tools
function showblack {
  showlogo
  echo -e " ${b}[ Enable Black Arch Tools ]${enda}"
  echo -e "Make A Choice
        1)    Install Black Arch
  
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installblack ;;

  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showwebapps ;;
  esac
}

# Support Zatiel
function supportzatiel {
  showlogo
  echo -e " ${b}${enda}"
  echo -e " Support In Patreon: ${bu}https://www.paypal.me/zatiel${endc}"
  echo -e " Donate in Paypal: ${bu}https://www.patreon.com/zatiel${endc}"



  read input
}


#Menu Other Applications
function showothapps {
  showlogo
  echo -e " ${b}[ OTHER APPLICATIONS ]${enda}"
  echo -e "Make A Choice
        1)    Skype
        2)    TeamViewer
        3)    Gnome Tweak Tool
        4)    Tilix (The best Terminal)
        5)    Hentai
        6)    Lifearea
        7)    Armory
        8)    Bitcoin
        9)    Docky
        10)   XFburn
        11)   Steam
        12)   Foxit Reader
        13)   HTTrack (Httraqt)
        14)   LibreOffice
        15)   HardInfo (system information tool)
        16)   Virtual Box
        17)   GParted
        18)   Okular (Reader)
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installskype ;;
  2) installteamviewer ;;
  3) installgnometweaktool ;;
  4) installtilix ;;
  5) installdiscord ;;
  6) installlifearea ;;
  7) installarmory ;;
  8) installbtc ;;
  9) installdocky ;;
  10) installxfburn ;;
  11) installsteam ;;
  12) installfoxread ;;
  13) installhttrack ;;
  14) installlibreoffi ;;
  15) installhrdinfo ;;
  16) installvirtualbox ;;
  17) installgparted ;;
  18) installokular ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showothapps ;;
  esac
}


# Menu Network Managers
function netmanage {
  showlogo
  echo -e " ${b}[ NETWORK MANAGERS ]${enda}"
  echo -e "Make A Choice
        1)    Connman
        2)    netctl
        3)    NetworkManager
        4)    Wifi-Menu
        5)    systemd-networkd
        6)    Wicd
       ---------------------------
        q)    Return To R00T MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installconnman  ;;
  2) installnetctlr ;;
  3) installNetworkManager ;;
  4) installwifimenu ;;
  5) installsystemnet ;;
  6) installWicd ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; netmanage ;;
  esac
}

# Menu Video Editors/Record
function showvid {
  showlogo
  echo -e " ${b}[ Video editors/Record ]${enda}"
  echo -e "Make A Choice
        1)    Avidemux
        2)    FFmpeg
        3)    Kdenlive
        4)    OBS (Open Broadcaster Software)
       ---------------------------
        q)    Return To ZARCH MENU"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installavidemux ;;
  2) installffmpeg ;;
  3) installkdenlive ;;
  4) installobs ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showvid ;;
  esac
}

# Infinite Loop To Show Menu Untill Exit
while :
do
showlogo
echo -e "                                ${BCyan}[ ZARCH MENU ]${enda}"
echo -e "                               GIVE ME A TARGET

 [1]   Text Editors                 [11]   Other Apps
 [2]   FTP / Torrent Apps           [12]   Full Stack Tools
 [3]   Download Managers            [13]   Browsers And Plugins
 [4]   Network Conection Apps       [14]   System Tools Apps
 [5]   VPN Clients                  [15]   Gamer Apps             [21]   Hentai
 [6]   Office                       [16]   Black Arch             [???]  Danger Zone
 [7]   Image Editors                [17]   Security Aps
 [8]   Video Editors / Record       [18]   Custom Kernels
 [9]   Utilities                    [19]   Icons And Themes
 [10]  Multimedia Apps              [20]   New Stores 
          
    a)    About Zarch Script       s)    Support Zarch Project        q)    Quit Zarch Script"   
        
        
        
echo
echo -en " Select Option: "
read option
case $option in
1) showtext ;;
2) showftptorr ;;
3) downmanage ;;
4) netmanage ;;
5) showvpn ;;
6) showchat ;;
7) showimg ;;
8) showvid ;;
9) showarch ;;
10) showaudio ;;
11) showothapps ;;
12) showdevapps ;;
13) showwebapps ;;
14) systemtools ;;
15) showgamer ;;
16) showblack ;;

s) supportzatiel;;
a) showabout ;;
q) zarchexit ;;
*) echo " \"$option\" Is Not A Valid Option"; sleep 1 ;;

esac

# Show About
function showabout {
  clear
  showlogo && echo -en "
     +-------------------------------------------------------------------+
     |                            Zarch Script                           |
     |          Arch Applications Automatic Installation Script          |  
     +-------------------------------------------------------------------+
     |         Op-System         :       Arch Linux                      |  
     |         Version           :       v1.0 12/01/2019                 |  
     |         Developer / Autor :       Zatiel                          |  
     |         [+] Special Thanks:       D35tr0y3r K3rn3l                |  
     +-------------------------------------------------------------------+

   ${Cyan}Description${enda}
   This Script Is Meant To Help Users Install Their Favourite 
   Applications On A Fresh Install Of ArchLinux , Saving Time To Use It.
   On This Script I Added All The Softwares From The Full List Of 
   Archlinux Applications The Script Have Exactly ( v1.0 ) 
   
   ${Red}Ps: Special thanks to all the users of my group: 
   "Riasu OS" for their incredible support ${endc}
    "
  echo && echo -en " ${Cyan}Press Enter To Return To ZARCH MENU${endc}"
  read input
}

# Exit Zarch
function zarchexit {
  showlogo && echo -e " Thank You For Using ${b} Zarch Script ${enda}
 For More Information please feel free to tweet me @CallMeZatiel :
 ${b}==>> ${bu}Twitter.com/CallMeZatiel${enda}"
  echo
  sleep 1
  exit
}

done
#Zatiel <3 
# End
