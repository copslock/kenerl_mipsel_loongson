Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id VAA16373 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Oct 1997 21:55:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA07523 for linux-list; Wed, 15 Oct 1997 21:54:25 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA07507 for <linux@cthulhu.engr.sgi.com>; Wed, 15 Oct 1997 21:54:15 -0700
Received: from tbird.cobaltmicro.com ([209.19.61.36]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA23409
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Oct 1997 21:54:12 -0700
	env-from (ralf@tbird.cobaltmicro.com)
Received: (from ralf@localhost)
	by tbird.cobaltmicro.com (8.8.5/8.8.5) id VAA13781;
	Wed, 15 Oct 1997 21:48:27 -0700
Message-ID: <19971015214825.01081@tbird.cobaltmicro.com>
Date: Wed, 15 Oct 1997 21:48:25 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Miguel de Icaza <miguel@nuclecu.unam.mx>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: More Linux/SGI status
References: <199710072241.RAA01259@athena.nuclecu.unam.mx> <m0xIqbs-0005FiC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.81e
In-Reply-To: <m0xIqbs-0005FiC@lightning.swansea.linux.org.uk>; from Alan Cox on Wed, Oct 08, 1997 at 08:32:43AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Oct 08, 1997 at 08:32:43AM +0100, Alan Cox wrote:
> > 	4. A nice, easy-to use install program.  Taking the existing
> > 	   Red Hat/Mustand install program and port it should be
> > 	   pretty easy. 
> 
> The big install problem is repartitioning an EFS system without damaging
> the EFS. There seem to be tools to do it via tape from reading the CD's.
> 
> Once my SGI appears cranking out a distribution set is still my first goal

I asked Ariel, your box is on it's way.  I hope the transport guys
hurry as I'm getting pretty close to a useable distribution.  Appended
is a list of the RPMs which I'm currently using.  They're mostly from
the RedHat 4.9 aka Mustang distribution.  There are just a few things
left to fix to build the entire distribution:

 - rpm just returns to the shell prompt after short time for some packages.
   Haven't yet tried to figure out what's the problem.
 - some packages containing shared libraries link them against libc.  While
   this is the right thing to do it will break with the binutils 2.7 we're
   still using.  Fix: finally upgrade to binutils 2.7.
 - some other packages depend on the presence of X11 for at least building.
   Among them for example tcsh.  Should be fixed rsn as Miguel had some
   X clients up.
 - A couple of other packages contain real bugs, usually pretty trivial
   things.
 - yet other package don't build because they depend on other packages that
   don't build, need to be ported to MIPS (Kaffee, eg.) or that are just
   useless on a MIPS box like for example Lilo.

I'll start to upload the SRPM packages listed below plus little endian
binaries.  All in all that's over 150mb, so don't hold the breath.

  Ralf

MAKEDEV-2.2-10.src.rpm SysVinit-2.71-3.src.rpm TheNextLevel-1.1-3.src.rpm
adduser-1.7-2.src.rpm amd-920824upl102-8.src.rpm apache-1.1.3-4.src.rpm
ash-0.2-9.src.rpm at-2.9b-3.src.rpm autoconf-2.12-2.src.rpm
automake-1.2-1.src.rpm bash-1.14.7-2.src.rpm bc-1.03-6.src.rpm
bc-1.04-1.src.rpm bdflush-1.5-6.src.rpm biff-0.10-1.src.rpm
bind-4.9.5p1-3.src.rpm bison-1.25-1.src.rpm bison-1.25-2.src.rpm
bm2font-3.0-6.src.rpm bm2font-3.0-7.src.rpm bootp-2.4.3-3.src.rpm
bootparamd-0.10-1.src.rpm bootpc-061-3.src.rpm byacc-1.9-4.src.rpm
byacc-1.9-5.src.rpm caching-nameserver-1.1-1.src.rpm cdecl-2.5-4.src.rpm
cdp-0.33-7.src.rpm christminster-3-3.src.rpm colour-yahtzee-1.0-4.src.rpm
control-panel-2.6-1.src.rpm cpio-2.4.2-5.src.rpm cproto-4.4-5.src.rpm
cracklib-2.5-2.src.rpm crontabs-1.5-1.src.rpm ctags-1.5-2.src.rpm
cvs-1.9-2.src.rpm dev-2.5.2-1.src.rpm dhcpcd-0.65-1.src.rpm
dialog-0.6-8.src.rpm diffstat-1.25-2.src.rpm diffutils-2.7-7.src.rpm
e2fsprogs-1.10-0.src.rpm ed-0.2-6.src.rpm efax-0.8a-4.src.rpm
eject-1.4-4.src.rpm etcskel-1.3-2.src.rpm ext2ed-0.1-9.src.rpm
f2c-19960205-9.src.rpm faq-4.0-1.src.rpm fetchmail-2.2-3.src.rpm
file-3.22-6.src.rpm filesystem-1.3-1.src.rpm fileutils-3.16-3.src.rpm
findutils-4.1-13.src.rpm finger-0.10-2.src.rpm flex-2.5.4-2.src.rpm
fort77-1.14a-2.src.rpm fortune-mod-1.0-4.src.rpm fstool-2.5-1.src.rpm
ftp-0.10-1.src.rpm fwhois-1.00-6.src.rpm gawk-3.0.2-2.src.rpm
gencat-022591-4.src.rpm gettext-0.10-2.src.rpm gettext-0.10-5.src.rpm
getty_ps-2.0.7h-5.src.rpm giftrans-1.11.1-5.src.rpm git-4.3.16-2.src.rpm
gnuchess-4.0.pl77-2.src.rpm grail-0.3b2-1.src.rpm grep-2.0-6.src.rpm
groff-1.10-9.src.rpm gzip-1.2.4-9.src.rpm hdparm-3.1-3.src.rpm
helptool-2.3-1.src.rpm howto-4.2-3.src.rpm imap-4.1.BETA-6.src.rpm
indent-1.9.1-6.src.rpm indexhtml-4.2-1.src.rpm initscripts-3.16-1.src.rpm
intimed-1.10-3.src.rpm intimed-1.10-4.src.rpm ircii-2.8.2-7.src.rpm
ircii-2.8.2-8.src.rpm jdk-1.0.2.2-3.src.rpm joe-2.8-8.src.rpm
kbd-0.91-10.src.rpm ldp-4.2-1.src.rpm less-321-4.src.rpm
lha-1.00-5.src.rpm linuxdoc-sgml-1.5-7.src.rpm logrotate-2.3-4.src.rpm
lout-3.08-1.src.rpm lout-3.08-2.src.rpm lpr-0.19-1.src.rpm
lrzsz-0.12.14-2.src.rpm lynx-2.6-3.src.rpm m4-1.4-7.src.rpm
macutils-2.0b3-5.src.rpm mailcap-1.0-3.src.rpm mailx-5.5.kw-7.src.rpm
make-3.75-2.src.rpm man-1.4j-2.src.rpm man-pages-1.15-1.src.rpm
mb-5.0-7.src.rpm mgetty-1.1.5-3.src.rpm mingetty-0.9.4-4.src.rpm
minicom-1.75-3.src.rpm mkdosfs-ygg-0.3b-5.src.rpm mkisofs-1.10rel-1.src.rpm
mkisofs-1.10rel-2.src.rpm mktemp-1.4-2.src.rpm modemtool-1.1-2.src.rpm
modutils-2.1.55-1.src.rpm mount-2.6h-1.src.rpm mpage-2.4-2.src.rpm
mt-st-0.4-3.src.rpm mtools-3.6-2.src.rpm mtools-3.6-3.src.rpm
mutt-0.81e-3.src.rpm mysterious-1.0-2.src.rpm ncftp-2.3.0-6.src.rpm
ncompress-4.2.4-7.src.rpm ncurses-1.9.9e-4.src.rpm nenscript-1.13++-9.src.rpm
net-tools-1.32.alpha-2.src.rpm netkit-base-0.10-2.src.rpm nls-1.0-2.src.rpm
ntalk-0.10-1.src.rpm open-1.3-5.src.rpm open-1.3-6.src.rpm
p2c-1.20-8.src.rpm pam-0.57-3.src.rpm pamconfig-0.51-2.src.rpm
pamconfig-0.51-3.src.rpm passwd-0.50-8.src.rpm patch-2.1-5.src.rpm
pdksh-5.2.12-2.src.rpm perl-5.003-9.src.rpm pidentd-2.5.1-6.src.rpm
pine-3.96-1.src.rpm pinfocom-3.0-4.src.rpm pmake-1.0-5.src.rpm
popt-1.0-1.src.rpm portmap-4.0-4.src.rpm ppp-2.2.0f-4.src.rpm
procinfo-0.9-2.src.rpm procmail-3.10-11.src.rpm psacct-6.2-2.src.rpm
psmisc-11-5.src.rpm pwdb-0.54-5.src.rpm rcs-5.7-5.src.rpm
rdate-0.960923-2.src.rpm rdist-1.0-6.src.rpm readline-2.1-1.src.rpm
redhat-release-4.8-1.src.rpm rhmask-1.0-2.src.rpm rootfiles-1.5-1.src.rpm
routed-0.10-1.src.rpm rpm-2.4.7-1glibc.src.rpm rsh-0.10-1.src.rpm
rusers-0.10-1.src.rpm rwall-0.10-1.src.rpm rwho-0.10-1.src.rpm
samba-1.9.16p11-4rh.src.rpm scottfree-1.14-3.src.rpm screen-3.7.2-3.src.rpm
sed-2.05-7.src.rpm setconsole-1.0-1.src.rpm sh-utils-1.16-6.src.rpm
shadow-utils-970616-4.src.rpm sharutils-4.2-7.src.rpm slang-0.99.37-2.src.rpm
slang-0.99.38-1.src.rpm sliplogin-2.1.0-7.src.rpm slrn-0.9.3.2-2.src.rpm
sox-11g-5.src.rpm stat-1.5-6.src.rpm statnet-2.00-4.src.rpm
statserial-1.1-8.src.rpm symlinks-1.0-6.src.rpm sysklogd-1.3-16.src.rpm
taper-6.7.4-3.src.rpm tcp_wrappers-7.5-2.src.rpm tcpdump-3.3-2.src.rpm
telnet-0.10-1.src.rpm tetex-0.4pl8-5.src.rpm textutils-1.22-2.src.rpm
tftp-0.10-2.src.rpm time-1.7-2.src.rpm timed-0.10-1.src.rpm
timetool-2.3-1.src.rpm tin-1.22-7.src.rpm tmpwatch-1.2-2.src.rpm
traceroute-1.4a5-2.src.rpm tracker-4.3-5.src.rpm tree-1.0-4.src.rpm
trojka-1.1-8.src.rpm ttcp-1.4-1.src.rpm tunelp-1.3-6.src.rpm
umb-scheme-3.2-3.src.rpm unarj-2.41a-4.src.rpm units-1.0-6.src.rpm
unzip-5.12-6.src.rpm uucp-1.06.1-11.src.rpm vixie-cron-3.0.1-15.src.rpm
vlock-1.0-6.src.rpm which-1.0-6.src.rpm words-2-3.src.rpm
wu-ftpd-2.4.2b15-2.src.rpm ypbind-3.0-2.src.rpm yppasswd-0.9-1.src.rpm
zip-2.1-2.src.rpm zlib-1.0.4-1.src.rpm zsh-3.0.2-2.src.rpm
