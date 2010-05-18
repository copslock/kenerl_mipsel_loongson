Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2010 11:09:33 +0200 (CEST)
Received: from kuber.nabble.com ([216.139.236.158]:50263 "EHLO
        kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491148Ab0ERJJZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 May 2010 11:09:25 +0200
Received: from isper.nabble.com ([192.168.236.156])
        by kuber.nabble.com with esmtp (Exim 4.63)
        (envelope-from <lists@nabble.com>)
        id 1OEInh-0005kq-F6
        for linux-mips@linux-mips.org; Tue, 18 May 2010 02:09:21 -0700
Message-ID: <28593348.post@talk.nabble.com>
Date:   Tue, 18 May 2010 02:09:21 -0700 (PDT)
From:   soumyasr <Soumya.R@kpitcummins.com>
To:     linux-mips@linux-mips.org
Subject: How to start with OpenEmbedded for MiPS32 Au1300
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: Soumya.R@kpitcummins.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Soumya.R@kpitcummins.com
Precedence: bulk
X-list: linux-mips


Hi All,
    I am new to open embedded build.. 
I followed the steps which is given in
http://wiki.openembedded.net/index.php/Getting_started

$ mkdir -p /home/soumya/project/oe/build/conf
$ cd /home/soumya/project/oe/ 

Getting the working bitbake
wget http://download.berlios.de/bitbake/bitbake-1.8.18.tar.gz

To obtain openembedded 
install git
$ git clone http://repo.or.cz/r/openembedded.git
 
updating OpenEmbedded using git pull

Create local configuration file
$ cd /home/soumya/project/oe/
$ cp openembedded/conf/local.conf.sample build/conf/local.conf
$ vi build/conf/local.conf

i edited in local.conf 
BBFILES = "/home/soumya/project/oe/openembedded/recipes/*/*.bb"
DISTRO = "avn01"
MACHINE = "au1300"

I created new distribution and machine as shown below

/*****************au1300.conf*************************/
# Alchemy au1300

TARGET_ARCH = "mipsel"

PREFERRED_PROVIDERS += "
virtual/${TARGET_PREFIX}depmod:module-init-tools-cross"

PREFERRED_PROVIDER_virtual/kernel = "linux"
KERNEL_IMAGETYPE = "vmlinux.srec"

SERIAL_CONSOLE="/dev/ttyS0 115200 vt100"
USE_VT="0"

TARGET_CC_ARCH="-march=mips32"

FLASH_OFFSET="0xBC000000"
# The NAND has an eraseblock of 0x4000 (16kB) and NOR with 0x20000 (128kB)
ERASEBLOCK_SIZE = "0x20000"
EXTRA_IMAGECMD_jffs2 = "--little-endian --no-cleanmarkers
--eraseblock=${ERASEBLOCK_SIZE}"

MACHINE_FEATURES = "kernel26 pcmcia usbhost"

/*********************************End of
au1300.conf***********************************/
/************************************avn01*****************************************************/
DISTRO

#@TYPE: Distribution
#@NAME: MIPSEL Linux
#@DESCRIPTION: Distribution configuration for the MIPS Linux

DISTRO_NAME = "AVN01"
DISTRO_VERSION = "0.1-alpha"

TARGET_OS = "linux"


PREFERRED_PROVIDERS +=
"virtual/${TARGET_PREFIX}gcc-initial:gcc-cross-initial"
PREFERRED_PROVIDERS +=
"virtual/${TARGET_PREFIX}gcc-intermediate:gcc-cross-intermediate"
PREFERRED_PROVIDERS += "virtual/${TARGET_PREFIX}gcc:gcc-cross"
PREFERRED_PROVIDERS += "virtual/${TARGET_PREFIX}g++:gcc-cross"


PREFERRED_PROVIDER_dbus-glib = "dbus-glib"
PREFERRED_PROVIDER_virtual/libsdl       ?= "libsdl-x11"
PREFERRED_PROVIDER_virtual/libxine      ?= "libxine-x11"
PREFERRED_PROVIDER_esound 		?= "pulseaudio"


# glibc:
PREFERRED_PROVIDER_virtual/libiconv ?= "glibc"
PREFERRED_PROVIDER_virtual/libintl ?= "glibc"
PREFERRED_PROVIDER_virtual/libc ?= "glibc"


PREFERRED_PROVIDER_virtual/${TARGET_PREFIX}libc-for-gcc = "glibc"
PREFERRED_PROVIDER_virtual/arm-oplinux-linux-gnueabi-libc-for-gcc = "glibc"
PREFERRED_PROVIDER_virtual/armeb-oplinux-linux-gnueabi-libc-for-gcc =
"glibc"
PREFERRED_PROVIDER_virtual/arm-linux-libc-for-gcc = "glibc"
PREFERRED_PROVIDER_virtual/armeb-linux-libc-for-gcc = "glibc"
PREFERRED_PROVIDER_virtual/powerpc-oplinux-linux-libc-for-gcc = "glibc"
PREFERRED_PROVIDER_virtual/mipsel-oplinux-linux-libc-for-gcc = "glibc"
PREFERRED_PROVIDER_virtual/sparc-oplinux-linux-libc-for-gcc = "glibc"



# Virtuals:
PREFERRED_PROVIDER_virtual/db ?= "db"
PREFERRED_PROVIDER_virtual/db-native ?= "db-native"
PREFERRED_PROVIDER_virtual/xserver ?= "xserver-kdrive"

# Others:
PREFERRED_PROVIDER_virtual/libx11 ?= "diet-x11"
PREFERRED_PROVIDER_gconf ?= "gconf-dbus"
PREFERRED_PROVIDER_gnome-vfs ?= "gnome-vfs"
PREFERRED_PROVIDER_gnome-vfs-plugin-file ?= "gnome-vfs"
PREFERRED_PROVIDER_tslib ?= "tslib"
PREFERRED_PROVIDER_tslib-conf ?= "tslib"
PREFERRED_PROVIDER_libgpewidget ?= "libgpewidget"
PREFERRED_PROVIDER_ntp = "ntp"
PREFERRED_PROVIDER_hotplug = "udev"
PREFERRED_PROVIDER_libxss = "libxss"


PREFERRED_VERSION_gcc ?= "4.1.1"
PREFERRED_VERSION_gcc-cross ?= "4.1.1"
PREFERRED_VERSION_gcc-cross-sdk ?= "4.1.1"
PREFERRED_VERSION_gcc-cross-initial ?= "4.1.1"
PREFERRED_VERSION_gcc-cross-intermediate ?= "4.1.1"

PREFERRED_VERSION_binutils ?= "2.17.50.0.5"
PREFERRED_VERSION_binutils-cross ?= "2.17.50.0.5"
PREFERRED_VERSION_binutils-cross-sdk ?= "2.17.50.0.5"

PREFERRED_VERSION_linux-libc-headers_i486 ?= "2.6.18"
PREFERRED_VERSION_linux-libc-headers_i586 ?= "2.6.18"
PREFERRED_VERSION_linux-libc-headers_i686 ?= "2.6.18"
PREFERRED_VERSION_linux-libc-headers_powerpc ?= "2.6.18"
PREFERRED_VERSION_linux-libc-headers ?= "2.6.18"

PREFERRED_VERSION_glibc-initial ?= "2.5"
PREFERRED_VERSION_glibc ?= "2.5"

PCMCIA_MANAGER = "pcmciautils"
PREFERRED_VERSION_dbus ?= "1.0.2"
PREFERRED_VERSION_dbus-glib ?= "0.71"


#
# Kernel
#
KERNEL = "kernel26"
MACHINE_KERNEL_VERSION = "2.6"



#Other packages we need
#try to keep it minimal :)
DISTRO_EXTRA_RDEPENDS += "\
                         nano pciutils"


FEED_URIS += " \
                no-arch##${OPLINUX_URI}/unstable/feed/all \
                base##${OPLINUX_URI}/unstable/feed/${FEED_ARCH}/base \
                perl##${OPLINUX_URI}/unstable/feed/${FEED_ARCH}/perl \
                python##${OPLINUX_URI}/unstable/feed/${FEED_ARCH}/python \
                debug##${OPLINUX_URI}/unstable/feed/${FEED_ARCH}/debug \
               
${MACHINE}##${OPLINUX_URI}/unstable/feed/${FEED_ARCH}/machine/${MACHINE}"
/**************************************END OF
avn01(DISTRO)*************************************************************/

Then i set the environment variable
$ export BBPATH=/home/soumya/project/oe/build:/stuff/openembedded
$ export PATH=/home/soumya/project/oe/bitbake/bin:$PATH

To start building i just typed bitbake in the command prompt
cd /build
$ bitbake
ERROR:  Openembedded's config sanity checker detected a potential
misconfiguration.
	Either fix the cause of this error or at your own risk disable the checker
(see sanity.conf).
	Following is the list of potential problems / advisories:

	Please install following missing utilities: help2man,texi2html
Error, TMPDIR has changed ABI (4 to 2) and you need to either rebuild,
revert or adjust it at your own risk.
Error, DISTRO_PR has changed (.5 to ) which means all packages need to
rebuild. Please remove your TMPDIR so this can happen. For autobuilder
setups you can avoid this by using a TMPDIR that include DISTRO_PR in the
path.

    Anybody can help me out to resolve this error..
If I am doing anything wrong in by build please suggest me.
Thanks in advance :-)


Regards,
Soumya













-- 
View this message in context: http://old.nabble.com/How-to-start-with-OpenEmbedded-for-MiPS32-Au1300-tp28593348p28593348.html
Sent from the linux-mips main mailing list archive at Nabble.com.
