Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA15885
	for <pstadt@stud.fh-heilbronn.de>; Tue, 27 Jul 1999 01:20:17 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA12338; Mon, 26 Jul 1999 16:14:35 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA45984
	for linux-list;
	Mon, 26 Jul 1999 16:08:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA23962
	for <linux@engr.sgi.com>;
	Mon, 26 Jul 1999 16:08:23 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07729
	for <linux@engr.sgi.com>; Mon, 26 Jul 1999 16:08:19 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-4.uni-koblenz.de [141.26.131.4])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA29754
	for <linux@engr.sgi.com>; Tue, 27 Jul 1999 01:03:11 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA04798;
	Mon, 26 Jul 1999 23:49:26 +0200
Date: Mon, 26 Jul 1999 23:49:26 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: RH 6.0 port
Message-ID: <19990726234926.A4793@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Quick status of the RH 6.0 report, the packages listed below compile; some
of them even have been tested ;-)  All in all that's 373mb of binaries.
A few packages below have been resurrected from RH 5.2.  Some of the
rpms have the letter combination ``lm'' trailing the release number.  That
indicates that I've modified the package from the original.

acm-4.7-8.src.rpm adjtimex-1.3-6.src.rpm AfterStep-1.7.90-3.src.rpm
AfterStep-APPS-990329-2lm.src.rpm aktion-0.3.3-1.src.rpm
am-utils-6.0-3lm.src.rpm anonftp-2.8-1lm.src.rpm AnotherLevel-0.9-1.src.rpm
apache-1.3.6-7.src.rpm ash-0.2-17.src.rpm at-3.1.7-8.src.rpm
audiofile-0.1.6-5.src.rpm aumix-1.18.2-2.src.rpm autoconf-2.13-5.src.rpm
autofs-3.1.3-2.src.rpm automake-1.4-4.src.rpm basesystem-6.0-4.src.rpm
bash-1.14.7-16.src.rpm bash2-2.03-4.src.rpm bc-1.05a-4.src.rpm
bdflush-1.5-10.src.rpm bind-8.2-6lm.src.rpm binutils-2.8.1-4lm.src.rpm
bison-1.27-3.src.rpm blt-2.4g-4.src.rpm bootp-2.4.3-7.src.rpm
bootparamd-0.10-22.src.rpm bootpc-061-8.src.rpm byacc-1.9-11.src.rpm
bzip2-0.9.0c-1.src.rpm caching-nameserver-6.0-2.src.rpm cdecl-2.5-9.src.rpm
cdp-0.33-12.src.rpm chkfontpath-1.4.1-1.src.rpm cleanfeed-0.95.7b-3.src.rpm
comanche-990405-2.src.rpm comsat-0.10-22.src.rpm
console-tools-19990302-13.src.rpm control-center-1.0.5-20.src.rpm
control-panel-3.11-2.src.rpm cpio-2.4.2-12.src.rpm cproto-4.6-2.src.rpm
cracklib-2.7-5.src.rpm crontabs-1.7-6.src.rpm ctags-3.2-1.src.rpm
cvs-1.10.5-2.src.rpm cxhextris-1.0-15.src.rpm
desktop-backgrounds-1.0.0-6.src.rpm dev-2.7.7-1lm.src.rpm
dhcp-2.0b1pl6-6.src.rpm dhcpcd-1.3.17pl2-1.src.rpm dialog-0.6-14.src.rpm
diffstat-1.25-7.src.rpm diffutils-2.7-16.src.rpm dump-0.4b4-7.src.rpm
e2fsprogs-1.14-4.src.rpm ed-0.2-12.src.rpm ee-0.3.8-7.src.rpm
efax-0.8a-11.src.rpm egcs-1.0.3a-10lm.src.rpm eject-2.0.2-3.src.rpm
ElectricFence-2.1-1.src.rpm elm-2.5.0-0.2pre8.src.rpm
emacs-20.3-15lm.src.rpm enlightenment-0.15.5-32.src.rpm
enscript-1.6.1-8.src.rpm esound-0.2.12-4.src.rpm etcskel-2.0-1.src.rpm
exmh-2.0.2-7.src.rpm faq-6.0-1.src.rpm fbset-2.0.19990118-2.src.rpm
fetchmail-5.0.0-1.src.rpm file-3.26-6.src.rpm filesystem-1.3.4-4.src.rpm
fileutils-4.0-1.src.rpm findutils-4.1-31.src.rpm finger-0.10-24.src.rpm
flex-2.5.4a-6.src.rpm fnlib-0.4-8.src.rpm fortune-mod-1.0-9.src.rpm
freetype-1.2-6.src.rpm ftp-0.10-22.src.rpm fvwm-1.24r-17.src.rpm
fvwm2-2.2-5.src.rpm fwhois-1.00-11.src.rpm gated-3.5.10-9.src.rpm
gawk-3.0.3-7.src.rpm gd-1.3-5.src.rpm gdbm-1.7.3-19.src.rpm
gdm-1.0.0-35.src.rpm gedit-0.5.1-3.src.rpm genromfs-0.3-4.src.rpm
getty_ps-2.0.7j-7.src.rpm gftp-1.13-4.src.rpm ghostscript-5.10-7.src.rpm
ghostscript-fonts-5.10-3.src.rpm giftrans-1.12.2-4.src.rpm
gimp-1.0.4-3.src.rpm gimp-data-extras-1.0.0-4.src.rpm
gimp-manual-1.0.0-5.src.rpm git-4.3.17-5.src.rpm glib-1.2.1-2.src.rpm
glibc-2.0.6-3lm.src.rpm gmp-2.0.2-8.src.rpm gnome-audio-1.0.0-6.src.rpm
gnome-core-1.0.4-34.src.rpm gnome-games-1.0.2-10.src.rpm
gnome-libs-1.0.8-8lm.src.rpm gnome-linuxconf-0.22-1.src.rpm
gnome-media-1.0.1-3.src.rpm gnome-objc-1.0.2-4.src.rpm
gnome-pim-1.0.7-2.src.rpm gnome-python-1.0.1-2.src.rpm
gnome-users-guide-1.0.5-4rh.src.rpm gnome-utils-1.0.1-6.src.rpm
gnorpm-0.8-5.src.rpm gnotepad+-1.1.3-2.src.rpm gnuchess-4.0.pl79-3.src.rpm
gnumeric-0.23-2.src.rpm gnuplot-3.7-2.src.rpm gperf-2.7-5.src.rpm
gpm-1.17.5-3.src.rpm gqview-0.6.0-3.src.rpm grep-2.3-2.src.rpm
groff-1.11a-9.src.rpm gsl-0.3f-2.src.rpm gtk+-1.2.1-10.src.rpm
gtk+10-1.0.6-5.src.rpm gtk-engines-0.5-16.src.rpm gtop-1.0.1-3.src.rpm
guavac-1.2-4.src.rpm guile-1.3-6.src.rpm gv-3.5.8-7.src.rpm
GXedit-1.23-2.src.rpm gzip-1.2.4-14.src.rpm hdparm-3.3-5.src.rpm
helptool-2.4-7.src.rpm howto-6.0-4.src.rpm ical-2.2-9.src.rpm
ImageMagick-4.2.2-4lm.src.rpm imap-4.5-3.src.rpm imlib-1.9.5-4.src.rpm
indent-1.9.1-11.src.rpm indexhtml-6.0-1.src.rpm initscripts-4.16-1.src.rpm
install-guide-3.2-3.src.rpm intimed-1.10-9.src.rpm ipchains-1.3.8-3.src.rpm
ircii-4.4-7.src.rpm isicom-1.0-1.src.rpm ispell-3.1.20-15.src.rpm
jed-0.98.7-2.src.rpm joe-2.8-18.src.rpm joe-2.8-18lm.src.rpm
kaffe-1.0.b4-2.src.rpm kdeadmin-1.1.1pre2-1.src.rpm
kdebase-1.1.1pre2-2.src.rpm kdegames-1.1.1pre2-2.src.rpm
kdegraphics-1.1.1pre2-1.src.rpm kdelibs-1.1.1pre2-2.src.rpm
kdemultimedia-1.1.1pre2-1.src.rpm kdenetwork-1.1.1pre2-1.src.rpm
kdesupport-1.1.1pre2-1.src.rpm kdeutils-1.1.1pre2-1.src.rpm
kernelcfg-0.5-5.src.rpm knfsd-1.2.2-4.src.rpm korganizer-1.1.1pre2-1.src.rpm
kpilot-3.1b8_pgb-1.src.rpm kpppload-1.04-4.src.rpm kterm-6.2.0-8lm.src.rpm
ldconfig-1.9.5-15.src.rpm less-332-6.src.rpm lha-1.00-11.src.rpm
libelf-0.6.4-4.src.rpm libghttp-1.0.2-3.src.rpm libgr-2.0.13-17.src.rpm
libgtop-1.0.1-3.src.rpm libjpeg-6b-9.src.rpm libjpeg6a-6a-4.src.rpm
libpng-1.0.3-2.src.rpm libPropList-0.8.3-2.src.rpm
libtermcap-2.0.8-13.src.rpm libtiff-3.4-6.src.rpm libtool-1.2f-3.src.rpm
libungif-4.1.0-2.src.rpm libxml-1.0.0-2.src.rpm linuxconf-1.14r4-4lm.src.rpm
logrotate-3.2-1.src.rpm lout-3.08-7.src.rpm lpg-0.4-4.src.rpm
lpr-0.35-1.src.rpm lrzsz-0.12.20-2.src.rpm lslk-1.19-5.src.rpm
lsof-4.42-1.src.rpm lynx-2.8.1-11.src.rpm m4-1.4-12.src.rpm
macutils-2.0b3-12.src.rpm mailcap-2.0.1-1.src.rpm mailx-8.1.1-8.src.rpm
make-3.77-6.src.rpm MAKEDEV-2.5-1.src.rpm man-1.5g-2.src.rpm
man-pages-1.23-3.src.rpm mars-nwe-0.99pl15-3.src.rpm mawk-1.2.2-11.src.rpm
mc-4.5.30-12.src.rpm metamail-2.7-20.src.rpm mgetty-1.1.14-8.src.rpm
mikmod-3.1.5-5.src.rpm mingetty-0.9.4-10.src.rpm minicom-1.82-5.src.rpm
mkdosfs-ygg-0.3b-11.src.rpm mkisofs-1.12b5-2.src.rpm
mkkickstart-1.2-1.src.rpm mktemp-1.5-1.src.rpm mkxauth-1.7-11.src.rpm
modemtool-1.21-6.src.rpm modutils-2.1.121-12lm.src.rpm
mod_php-2.0.1-9.src.rpm mod_php3-3.0.7-4.src.rpm mount-2.9o-1.src.rpm
mpage-2.4-7.src.rpm mtools-3.9.1-5.src.rpm mutt-0.95.4us-4.src.rpm
mxp-1.0-11.src.rpm nag-1.0-4.src.rpm nc-1.10-4.src.rpm
ncftp-3.0beta18-3.src.rpm ncompress-4.2.4-14lm.src.rpm
ncpfs-2.2.0.12-5.src.rpm ncurses-4.2-18.src.rpm ncurses3-1.9.9e-9.src.rpm
net-tools-1.51-3.src.rpm netcfg-2.20-2.src.rpm netkit-base-0.10-29.src.rpm
newt-0.40-9.src.rpm nmh-0.27-8.src.rpm open-1.4-6.src.rpm
ORBit-0.4.3-2.src.rpm p2c-1.22-3.src.rpm pam-0.66-18.src.rpm
passwd-0.58-1.src.rpm patch-2.5-8.src.rpm pciutils-1.99.5-1.src.rpm
pdksh-5.2.13-3.src.rpm perl-5.00503-2.src.rpm perl-MD5-1.7-6.src.rpm
pidentd-2.8.5-3.src.rpm pilot-link-0.9.0-8.src.rpm pine-4.10-2.src.rpm
playmidi-2.4-7.src.rpm pmake-2.1.33-5lm.src.rpm popt-1.3-1.src.rpm
portmap-4.0-15.src.rpm ppp-2.3.7-2.src.rpm printtool-3.40-3.src.rpm
procinfo-16-3.src.rpm procmail-3.13.1-2.src.rpm procps-2.0.2-2.src.rpm
psacct-6.3-10.src.rpm psmisc-18-2.src.rpm pump-0.6.4-1.src.rpm
pwdb-0.58-3.src.rpm pythonlib-1.22-5.src.rpm qt-1.44-6.src.rpm
quota-1.66-6.src.rpm raidtools-0.90-3.src.rpm rcs-5.7-10.src.rpm
rdate-0.960923-8.src.rpm rdist-6.1.5-7.src.rpm readline-2.2.1-5.src.rpm
redhat-logos-1.0.5-1.src.rpm redhat-release-6.0-1.src.rpm
rhl-alpha-install-addend-en-6.0-1.src.rpm
rhl-getting-started-guide-en-6.0-2.src.rpm
rhl-install-guide-en-6.0-2.src.rpm rhmask-1.0-6.src.rpm
rhs-printfilters-1.51-2.src.rpm rhsound-1.8-1.src.rpm
rootfiles-5.2-5.src.rpm routed-0.10-14.src.rpm rpm-3.0-6.0lm.src.rpm
rsh-0.10-25.src.rpm rsync-2.3.1-1.src.rpm rusers-0.10-23.src.rpm
rwall-0.10-22.src.rpm rwho-0.10-23.src.rpm sag-0.6-3.src.rpm
samba-2.0.3-8.src.rpm sash-2.1-4.src.rpm screen-3.7.6-6lm.src.rpm
sed-3.02-4.src.rpm sendmail-8.9.3-10.src.rpm setconsole-1.0-8.src.rpm
setserial-2.15-2.src.rpm setup-2.0.2-1.src.rpm sgml-tools-1.0.9-2.src.rpm
sh-utils-1.16-23.src.rpm shadow-utils-980403-12.src.rpm
sharutils-4.2-12.src.rpm slang-1.2.2-4.src.rpm sliplogin-2.1.1-5.src.rpm
slocate-1.4-7.src.rpm slrn-0.9.5.4-5.src.rpm sox-12.15-5.src.rpm
specspo-6.0-0.9.9.src.rpm squid-2.2.STABLE1-1.src.rpm stat-1.5-11.src.rpm
statserial-1.1-13.src.rpm swatch-2.2-7.src.rpm switchdesk-1.7.0-1.src.rpm
symlinks-1.2-5.src.rpm sysklogd-1.3.31-6.src.rpm SysVinit-2.74-11.src.rpm
talk-0.11-1.src.rpm taper-6.9-6.src.rpm tar-1.12-9.src.rpm
tcltk-8.0.4-29.src.rpm tcpdump-3.4-10.src.rpm tcp_wrappers-7.6-7.src.rpm
tcsh-6.08.00-5.src.rpm telnet-0.10-27.src.rpm termcap-9.12.6-15.src.rpm
tetex-0.9-17.src.rpm texinfo-3.12f-4.src.rpm textutils-1.22-9.src.rpm
tftp-0.10-23.src.rpm time-1.7-9.src.rpm timeconfig-2.7-1.src.rpm
timed-0.10-23.src.rpm timetool-2.5-5.src.rpm tin-1.4_990216-3.src.rpm
tksysv-1.0-6.src.rpm tmpwatch-1.7-1.src.rpm traceroute-1.4a5-14.src.rpm
transfig-3.2.1-3.src.rpm tree-1.2-6.src.rpm trn-3.6-16.src.rpm
trojka-1.1-13.src.rpm ttcp-1.4-1.src.rpm tunelp-1.3-10.src.rpm
ucd-snmp-3.6.1-4.src.rpm umb-scheme-3.2-9.src.rpm unarj-2.41a-9.src.rpm
units-1.0-12.src.rpm unzip-5.31-5.src.rpm urlview-0.7-3.src.rpm
urw-fonts-1.1-8.src.rpm usermode-1.9-1.src.rpm usernet-1.0.9-2.src.rpm
util-linux-2.9o-13lm.src.rpm uucp-1.06.1-19.src.rpm
vixie-cron-3.0.1-33.src.rpm vlock-1.3-2.src.rpm w3c-libwww-5.2.8-3.src.rpm
wget-1.5.3-4.src.rpm which-1.0-11.src.rpm WindowMaker-0.52.0-2.src.rpm
wmakerconf-1.99.1-1.src.rpm wmconfig-0.9.5-1.src.rpm words-2-12.src.rpm
x11amp-0.9_alpha3-6.src.rpm X11R6-contrib-3.3.2-6.src.rpm
x3270-3.1.1.6-7.src.rpm Xaw3d-1.3-21.src.rpm xbanner-1.31-7.src.rpm
xbill-2.0-6.src.rpm xboard-4.0.0-3.src.rpm xboing-2.4-7.src.rpm
xchat-0.9.4-3.src.rpm xcpustate-2.5-5.src.rpm xdaliclock-2.14-3.src.rpm
xearth-1.0-12.src.rpm xfishtank-2.0-14.src.rpm xfm-1.3.2-13.src.rpm
XFree86-3.3.3.1-49lm.src.rpm XFree86-ISO8859-2-1.0-8.src.rpm
XFree86-ISO8859-9-2.1.2-9.src.rpm xgammon-0.98-14.src.rpm
xinitrc-2.3-1.src.rpm xjewel-1.6-11.src.rpm xlispstat-3.52.9-2.src.rpm
xloadimage-4.1-12.src.rpm xlockmore-4.13-2.src.rpm xmailbox-2.5-7.src.rpm
xmorph-1996.07.12-7.src.rpm xntp3-5.93-12.src.rpm xosview-1.7.1-2lm.src.rpm
xpaint-2.4.9-8.src.rpm xpat2-1.04-10.src.rpm xpdf-0.80-4.src.rpm
xpilot-3.6.2-6lm.src.rpm xpm-3.4j-5.src.rpm xpuzzles-5.4.1-7.src.rpm
xrn-9.01-3.src.rpm xscreensaver-3.09-3.src.rpm xsysinfo-1.6-5.src.rpm
xtoolwait-1.2-2.src.rpm xtrojka-1.2.3-6.src.rpm xwpick-2.20-11.src.rpm
xxgdb-1.12-10.src.rpm yp-tools-2.2-1.src.rpm ypbind-3.3-20.src.rpm
ypserv-1.3.6.91-1.src.rpm ytalk-3.1-3.src.rpm zip-2.1-8.src.rpm
zlib-1.1.3-5.src.rpm zsh-3.0.5-10.src.rpm

  Ralf
