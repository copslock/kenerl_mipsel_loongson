Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2005 07:28:29 +0100 (BST)
Received: from smtp.netsity.com ([IPv6:::ffff:61.246.47.138]:9228 "EHLO
	mail.netsity.com") by linux-mips.org with ESMTP id <S8225576AbVHDG2N>;
	Thu, 4 Aug 2005 07:28:13 +0100
Received: from INPREET ([192.168.103.60]) by mail.netsity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id P9F564GY; Thu, 4 Aug 2005 12:01:40 +0530
Message-ID: <011b01c598be$2c373170$3c67a8c0@netsity.com>
From:	"inpreet" <singh.inpreet@netsity.com>
To:	<linux-mips@linux-mips.org>
Subject: Ramdisk image at boot time
Date:	Thu, 4 Aug 2005 12:01:40 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0117_01C598EC.45D2E4C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Return-Path: <singh.inpreet@netsity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: singh.inpreet@netsity.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0117_01C598EC.45D2E4C0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0118_01C598EC.45D2E4C0"


------=_NextPart_001_0118_01C598EC.45D2E4C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I got your id from forum site and I know you are the one who can guide =
me thru this problem. I hope that you won't mind doing that.
I am tring to unable bootsplash image at boot time on embedded device =
which runs on MIPS processor and use YAMON as bootloader. I am attaching =
a build script which detects initrd.tar.gz and embedded it to ramdisk. =
But now when I am booting kernel ramdisk is unable to detect initrd =
image. I am saving initrd.splash, which is bootup image in /boot =
directory and making its initrd.tar.gz. While booting I am giving kernel =
parameters
kernel : go be000000 root=3D/dev/ram0 rw init=3D/linuxrc console=3Dtty1 =
video=3Dau1100fb:panel:640x480_crt initrd=3D/boot/initrd.splash
I also save this initrd.tar.gz as ramdisk.gz at arch/mips/ramdisk/ =
directory.
What step I am missing to let kernel detect splash image at boot time?

Regards
Inpreet Singh

------=_NextPart_001_0118_01C598EC.45D2E4C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3700.6699" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DVerdana size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>I got your id from forum site and I =
know you are=20
the one who can guide me thru this problem. I hope that you won't mind =
doing=20
that.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>I am tring to unable bootsplash image =
at boot=20
time on embedded device which runs on MIPS processor and use YAMON as=20
bootloader. I am attaching a build script which detects initrd.tar.gz =
and=20
embedded it to ramdisk. But now when I am booting kernel ramdisk is =
unable to=20
detect initrd image. I am saving initrd.splash, which is bootup image in =
/boot=20
directory and making its initrd.tar.gz. While booting I am giving kernel =

parameters</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2><STRONG>kernel : </STRONG>go be000000 =

root=3D/dev/ram0 rw init=3D/linuxrc console=3Dtty1 =
video=3Dau1100fb:panel:640x480_crt=20
initrd=3D/boot/initrd.splash</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>I also save this initrd.tar.gz as =
ramdisk.gz at=20
arch/mips/ramdisk/ directory.</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2>What step I am missing to let kernel =
detect=20
splash image at boot time?</FONT></DIV>
<DIV><FONT face=3DVerdana size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DVerdana size=3D2>Regards<BR>Inpreet=20
Singh</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_001_0118_01C598EC.45D2E4C0--

------=_NextPart_000_0117_01C598EC.45D2E4C0
Content-Type: application/octet-stream;
	name="build.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="build.sh"

#!/bin/sh=0A=
=0A=
# ###################################################################=0A=
#=0A=
# build.sh=0A=
#=0A=
# Script to build the Linux Launchpad for Aurora AA1100 development=0A=
# board.=0A=
#=0A=
# *** THIS SCRIPT MUST BE RUN FROM ITS INSTALLED LOCATION	***=0A=
#=0A=
# It creates 2 environments under the 'images' directory in sub-=0A=
# directories 'nfs-mount' and 'flash-mount'.  The first is for=0A=
# development purposes and is intended for its kernel to be downloaded=0A=
# from the host machine and also for the root filesystem to be mounted=0A=
# remotely via nfs from the remote machine.=0A=
#=0A=
# The second environment is intended to be loaded onto the target=0A=
# hardware as a final customer image.  The kernel should be downloaded=0A=
# once to the on-board flash and the 'start' variable in YAMON set to=0A=
# boot from flash. The filesystem is intended to be loaded onto the=0A=
# PCMCIA CF card and includes a script to check if any particular boot=0A=
# is the first and if networking has been enabled etc.=0A=
#=0A=
# This script can create both environments or either one independently.=0A=
# It accepts options of ALL [-a], NFS [-n] or FLASH [-f]. ALL is default.=0A=
# ./build.sh -h for usage instructions.=0A=
#=0A=
# ###################################################################=0A=
=0A=
PASSWD_FILE=3D/tmp/$$=0A=
=0A=
CWD=3D`pwd`=0A=
CURR_PATH=3D`echo $PATH`=0A=
=0A=
NFS_IMAGE_DIR=3D${CWD}/images/nfs-mount=0A=
NFS_FS=3D${NFS_IMAGE_DIR}/filesystem=0A=
=0A=
FLASH_IMAGE_DIR=3D${CWD}/images/flash-mount=0A=
FLASH_FS=3D${FLASH_IMAGE_DIR}/filesystem=0A=
FLASH_FS_IMG=3D${FLASH_IMAGE_DIR}/rootfs.img=0A=
=0A=
INITRD_FS=3D${FLASH_IMAGE_DIR}/initrdfs=0A=
INITRD_IMG=3D/tmp/initrd=0A=
TMP_MNT=3D/tmp/mnt=0A=
=0A=
PREBUILT_BINARIES=3D$CWD/prebuilt-binaries=0A=
CONFIG=3D${CWD}/config-files=0A=
LINUX=3D${CWD}/linux-2.4.21=0A=
BUSYBOX=3D${CWD}/busybox/busybox-1.00-pre4=0A=
=0A=
trap 'cleanup' 0 1 9 15=0A=
=0A=
# ###################################################################=0A=
# cleanup	Unmounts & deletes temporary files / directories=0A=
# ###################################################################=0A=
function cleanup () {=0A=
	MOUNT=3D`mount | grep ${TMP_MNT}`=0A=
	if [ "$MOUNT" !=3D "" ];	then=0A=
		sudo -S umount ${TMP_MNT} < ${PASSWD_FILE};=0A=
	fi=0A=
	rm -rf ${PASSWD_FILE} ${INITRD_IMG}.gz ${INITRD_IMG}=0A=
	if [ -d ${TMP_MNT} ]; then=0A=
		rmdir ${TMP_MNT}=0A=
	fi=0A=
}=0A=
=0A=
# ###################################################################=0A=
# usage		Prints usage information=0A=
# ###################################################################=0A=
function usage () {=0A=
	echo=0A=
	echo=0A=
	echo "This script automates the build of the Linux Launchpad software"=0A=
	echo "It will output two environments to the directories:"=0A=
	echo "${NFS_IMAGE_DIR}"=0A=
	echo "and"=0A=
	echo "${FLASH_IMAGE_DIR}."=0A=
	echo "The first directory will contain an environment suitable for =
development"=0A=
	echo "purposes where the kernel is downloaded to the onboard RAM via =
tftp and the"=0A=
	echo "filesystem can be mounted remotely using nfs."=0A=
	echo=0A=
	echo "The second directory will contain an environment suitable for =
storing"=0A=
	echo "on the target board PCMCIA CF card. The kernel will be configured"=0A=
	echo "for storing on the on-board flash (remember to erase it via YAMON"=0A=
	echo "before downloading the kernel).  This environment will also =
contain a file"=0A=
	echo "called rootfs.img.  This is a 30 MB root file system image that =
can be"=0A=
	echo "written directly to the PCMCIA CF."=0A=
	echo=0A=
	echo "Usage: build.sh 	[-a] Build both environments [DEFAULT]"=0A=
	echo "			[-n] Build the NFS environment only"=0A=
	echo "			[-f] Build the FLASH environment only"=0A=
	echo=0A=
	exit 0=0A=
}=0A=
=0A=
# ###################################################################=0A=
# get_passwd		Retrieves the user's password=0A=
# PARAMS		NONE=0A=
# ###################################################################=0A=
function get_passwd () {=0A=
	echo=0A=
	echo "Some parts of this build script need root privileges to install =
correct permissions."=0A=
	echo "The script uses the sudo command at the appropriate points in the =
installation."=0A=
	echo "In order for sudo to operate correctly you must enter your user =
password at the prompt."=0A=
	echo "You also need to ensure that sudo 'knows' about your user name by =
having a valid"=0A=
	echo "entry in your 'sudoers' file."=0A=
	echo "For a brief howto see sudo-howto.txt in the doc directory, or see =
'man visudo' for"=0A=
	echo "further details."=0A=
	echo=0A=
	echo -n "Please enter your password or <CR> to exit: "=0A=
	read -s PASS=0A=
	echo=0A=
=0A=
	if [ "$PASS" =3D "" ]; then=0A=
	        echo Script exiting=0A=
	        exit 1=0A=
	fi=0A=
=0A=
	echo $PASS > $PASSWD_FILE=0A=
	chmod 600 $PASSWD_FILE=0A=
}=0A=
=0A=
# ###################################################################=0A=
# build_kernel	Builds the kernel!=0A=
# PARAMS	$1 The location of a .config file=0A=
#		$2 String specifying the type of kernel [NFS | FLASH]=0A=
# ###################################################################=0A=
function build_kernel () {=0A=
=0A=
	if [ "$2" =3D "NFS" ]; then=0A=
		IMG=3DzImage=0A=
	else=0A=
		IMG=3DzImage.flash=0A=
	fi=0A=
=0A=
	cd ${LINUX}=0A=
	make mrproper=0A=
	cp $1 .config=0A=
	if ! make oldconfig=0A=
	then=0A=
		echo "Error configuring $2 kernel"=0A=
		exit 1=0A=
	fi=0A=
	if ! make dep=0A=
	then=0A=
		echo "Error creating dependancies for $2 kernel"=0A=
		exit 1=0A=
	fi=0A=
	if ! make $IMG=0A=
	then=0A=
		echo "Error compiling $2 kernel"=0A=
		exit 1=0A=
	fi=0A=
=0A=
	if ! make modules=0A=
	then=0A=
		echo "Error making $2 kernel modules"=0A=
		exit 1=0A=
	fi=0A=
=0A=
	cd ${CWD}=0A=
}=0A=
=0A=
# ###################################################################=0A=
# make_modules	Use this to create kernel modules without building the=0A=
#		entire kernel.=0A=
# PARAMS	$1 The location of a kernel .config file=0A=
# ###################################################################=0A=
function make_modules () {=0A=
	cd ${LINUX}=0A=
	make mrproper=0A=
	cp $1 .config=0A=
	if ! make oldconfig=0A=
	then=0A=
		echo "Error configuring $2 kernel modules"=0A=
		exit 1=0A=
	fi=0A=
	if ! make modules=0A=
	then=0A=
		echo "Error making $2 kernel modules"=0A=
		exit 1=0A=
	fi=0A=
	cd ${CWD}=0A=
}=0A=
=0A=
# ###################################################################=0A=
# install_modules	Installs kernel modules to the specified dir=0A=
# PARAMS		$1 The root install directory=0A=
# ###################################################################=0A=
function install_modules () {=0A=
	INSTALL_PATH=3D$1=0A=
=0A=
	export INSTALL_MOD_PATH=3D${INSTALL_PATH}=0A=
	cd ${LINUX}=0A=
	if ! sudo -S make modules_install < ${PASSWD_FILE}=0A=
	then=0A=
		echo "Error installing the kernel modules to ${INSTALL_PATH}"=0A=
		exit 1=0A=
	fi=0A=
	cd ${CWD}=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_devices	Creates the required device nodes for a root=0A=
#			filesystem.=0A=
# PARAMS		$1 The root of the filesystem=0A=
# ###################################################################=0A=
function create_devices () {=0A=
	DST=3D$1=0A=
=0A=
	sudo -S mknod ${DST}/dev/mem     c 1  1 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/kmem    c 1  2 < ${PASSWD_FILE}=0A=
	sudo -S mknod -m 666 ${DST}/dev/null    c 1  3 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/port    c 1  4 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/zero    c 1  5 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/full    c 1  7 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/random  c 1  8 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/urandom c 1  9 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/aio     c 1  10 < ${PASSWD_FILE}=0A=
=0A=
	sudo -S mknod ${DST}/dev/ram0    b 1  0 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/ram1    b 1  1 < ${PASSWD_FILE}=0A=
=0A=
	sudo -S mknod ${DST}/dev/tty0    c 4  0 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/tty1    c 4  1 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/tty2    c 4  2 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/tty3    c 4  3 < ${PASSWD_FILE}=0A=
=0A=
	sudo -S mknod ${DST}/dev/tty     c 5  0 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/console c 5  1 < ${PASSWD_FILE}=0A=
=0A=
	sudo -S mknod ${DST}/dev/ptmx    c 5  2 < ${PASSWD_FILE}=0A=
	sudo -S mkdir ${DST}/dev/pts < ${PASSWD_FILE}=0A=
=0A=
	sudo -S mknod ${DST}/dev/ttyS0   c 4 64 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/ttyS1   c 4 65 < ${PASSWD_FILE}=0A=
	sudo -S mknod ${DST}/dev/ttyS2   c 4 66 < ${PASSWD_FILE}=0A=
=0A=
	# Frame Buffer device=0A=
	sudo -S mknod ${DST}/dev/fb0 c 29 0 < ${PASSWD_FILE}=0A=
=0A=
	# A - D device nodes=0A=
	for i in 0 1 2 3=0A=
	do=0A=
		sudo -S mknod ${DST}/dev/ad$i c 60 $i < ${PASSWD_FILE}=0A=
	done=0A=
=0A=
	# IDE hda=0A=
	sudo -S mknod -m 640 ${DST}/dev/hda b 3 0 < ${PASSWD_FILE}=0A=
	for i in 1 2 3=0A=
	do=0A=
		sudo -S mknod ${DST}/dev/hda$i b 3 $i < ${PASSWD_FILE}=0A=
	done=0A=
}=0A=
=0A=
# ###################################################################=0A=
# build_busybox		Builds and installs busybox=0A=
# PARAMS		$1 Location of a busybox .config file=0A=
# 			$2 The install directory=0A=
#			$3 String specifying the type of build [NFS | FLASH]=0A=
# ###################################################################=0A=
function build_busybox () {=0A=
=0A=
	export PATH=3D/opt/toolchains/uclibc-crosstools-1.0.0/bin:$PATH=0A=
	cd ${BUSYBOX}=0A=
	make distclean=0A=
	cp $1 .config=0A=
	if ! make oldconfig=0A=
	then=0A=
		echo "Error configuring $3 BUSYBOX"=0A=
		exit 1=0A=
	fi=0A=
=0A=
	if ! make=0A=
	then=0A=
		echo "Error building $3 BUSYBOX"=0A=
		exit 1=0A=
	fi=0A=
=0A=
	if ! make install=0A=
	then=0A=
		echo "Error installing $3 BUSYBOX"=0A=
		exit 1=0A=
	fi=0A=
	sudo -S cp -Rd _install/* $2 < ${PASSWD_FILE}=0A=
	sudo -S chmod u+s ${2}/bin/busybox < ${PASSWD_FILE}=0A=
=0A=
	export PATH=3D${CURR_PATH}=0A=
	cd ${CWD}=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_root_filesystem	Create a root filesystem=0A=
# PARAMS			$1 Where to create the filesystem=0A=
# ###################################################################=0A=
function create_root_filesystem () {=0A=
	DST=3D$1=0A=
=0A=
	mkdir -p ${DST}=0A=
=0A=
	# Create some required empty directories=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/skeleton.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Create the root etc directory=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/etc-root.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	#Create the http daemon root directory=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/www.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Create the /lib symlink & libraries=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/lib.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Copy the pcmcia card services binaries=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/pcmcia.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Copy the gdbserver binary=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/gdb.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Copy the ftpd binary=0A=
	(cd ${DST}; sudo -S tar xzvpf $PREBUILT_BINARIES/ftpd.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Create some device nodes=0A=
	create_devices ${DST}=0A=
=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_initrd_filesystem	Creates a trim filesystem for the ramdisk=0A=
# PARAMS			NONE=0A=
# ###################################################################=0A=
function create_initrd_filesystem () {=0A=
=0A=
	mkdir -p ${INITRD_FS}=0A=
=0A=
	# Create some required empty directories=0A=
	(cd ${INITRD_FS}; sudo -S tar xzvpf $PREBUILT_BINARIES/skeleton.tar.gz =
< $PASSWD_FILE)=0A=
=0A=
	# We need to have compiled the kernel modules first to install them into=0A=
	# the initrd image, which is then compiled into the kernel ...=0A=
	make_modules ${CONFIG}/kernel.config.initrd FLASH=0A=
	install_modules ${INITRD_FS}=0A=
=0A=
	# Copy the pcmcia card services binaries=0A=
	(cd ${INITRD_FS}; sudo -S tar xzvpf $PREBUILT_BINARIES/pcmcia.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Copy the initrd specific files=0A=
	(cd ${INITRD_FS}; sudo -S tar xzvpf $PREBUILT_BINARIES/initrd.tar.gz < =
$PASSWD_FILE)=0A=
=0A=
	# Create required device nodes=0A=
	sudo -S mknod ${INITRD_FS}/dev/console c 5 1 < $PASSWD_FILE=0A=
	sudo -S mknod ${INITRD_FS}/dev/hda b 3 0 < $PASSWD_FILE=0A=
	for index in 1 2=0A=
	do=0A=
		sudo -S mknod ${INITRD_FS}/dev/hda$index b 3 $index < $PASSWD_FILE=0A=
	done=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_initrd_img	Creates an image of the ramdisk filesystem=0A=
# 			The image is stored in /tmp/${INITRD_IMG}.gz=0A=
#			It must be built before the FLASH kernel as=0A=
#			the kernel build will expect it to be there.=0A=
# PARAMS		NONE=0A=
# ###################################################################=0A=
function create_initrd_img () {=0A=
=0A=
	if [ ! -d ${INITRD_FS} ]; then=0A=
		echo "No initrd filesystem [directory filesystem]"=0A=
		return=0A=
	fi=0A=
=0A=
	sudo -S rm -f ${INITRD_IMG}.gz ${INITRD_IMG} < ${PASSWD_FILE}=0A=
	dd if=3D/dev/zero of=3D${INITRD_IMG} bs=3D1k count=3D4096=0A=
	/sbin/mke2fs -F -m0 -b 1024 ${INITRD_IMG}=0A=
	/sbin/tune2fs -c 0 -i 0 ${INITRD_IMG}=0A=
=0A=
	mkdir -p ${TMP_MNT}=0A=
	sudo -S mount -t ext2 ${INITRD_IMG} ${TMP_MNT} -o loop < ${PASSWD_FILE}=0A=
	(cd ${INITRD_FS}; sudo -S sh -c "find . -print | cpio -p ${TMP_MNT}/" < =
${PASSWD_FILE})=0A=
=0A=
	sudo -S umount ${TMP_MNT} < ${PASSWD_FILE}=0A=
	gzip -v9 ${INITRD_IMG}=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_rootfs_img	Creates an image of the root FLASH filesystem=0A=
#			30MB in size. The image can then be written=0A=
#			directly to the PCMCIA CF card.=0A=
# PARAMS		NONE=0A=
# ###################################################################=0A=
function create_rootfs_img () {=0A=
	# Create and format a new image=0A=
	rm -f ${FLASH_FS_IMG}=0A=
	touch ${FLASH_FS_IMG}=0A=
	dd if=3D/dev/zero of=3D${FLASH_FS_IMG} bs=3D1k count=3D30720=0A=
	/sbin/mke2fs -F ${FLASH_FS_IMG}=0A=
	/sbin/tune2fs -c 0 -i 0 ${FLASH_FS_IMG}=0A=
=0A=
	# Ensure the temp mount point is available=0A=
	mkdir -p ${TMP_MNT}=0A=
=0A=
	sudo -S mount -t ext2 ${FLASH_FS_IMG} ${TMP_MNT} -o loop < =
${PASSWD_FILE}=0A=
	(cd ${FLASH_FS}; sudo -S sh -c "find . -print | cpio -p ${TMP_MNT}/" < =
${PASSWD_FILE})=0A=
=0A=
	sudo -S umount ${TMP_MNT} < ${PASSWD_FILE}=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_nfs_readme	Creates an explanatory README file in the NFS=0A=
#			image directory=0A=
# ###################################################################=0A=
function create_nfs_readme () {=0A=
	cat > ${NFS_IMAGE_DIR}/README <<-EOF=0A=
=0A=
		This file descibes the contents of the nfs image directory.=0A=
		=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
		This environment enables the kernel to be downloaded & booted via tftp =
on=0A=
		each re-boot and to mount the filesystem remotely via nfs and is =
provided=0A=
		mainly as an aid to development.=0A=
=0A=
		aa1100.srec -=0A=
		An srec version of the kernel, suitable for loading into the target =
board=0A=
		memory using YAMON.=0A=
		I.E. at the YAMON prompt:=0A=
		setenv bootfile aa1100.srec=0A=
		load -r=0A=
=0A=
		./filesystem -=0A=
		The root filesystem to be mounted via nfs.  This should be copied to =
the=0A=
		nfs export directory on the host machine (i.e. /exports/rootimg).=0A=
=0A=
		A sample bootstring for YAMON to run this kernel:=0A=
		go . root=3D/dev/nfs rw nfsroot=3D192.150.92.119:/exports/rootimg \\=0A=
		ip=3D192.150.92.239:::255.255.255.0:guest19::off =
console=3DttyS0,115200 \\=0A=
		video=3Dau1100fb:panel:640x480_CRT=0A=
=0A=
		See bootstring.txt for more examples.=0A=
=0A=
	EOF=0A=
}=0A=
=0A=
# ###################################################################=0A=
# create_flash_readme	Creates an explanatory README in the flash=0A=
#			image directory=0A=
# ###################################################################=0A=
function create_flash_readme () {=0A=
	cat > ${FLASH_IMAGE_DIR}/README <<-EOF=0A=
=0A=
		This file descibes the contents of the flash image directory.=0A=
		=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
		This environment is suitable for loading onto customers' boards.=0A=
=0A=
		aa1100.flash.srec -=0A=
		An srec version of the kernel, suitable for loading into the on-board =
flash=0A=
		memory (not PCMCIA CF) using YAMON.=0A=
		I.E. At the YAMON prompt:=0A=
		Erase 6MB at the start of the operating system partition:=0A=
		erase 1e000000 600000=0A=
=0A=
		Download the kernel image to the on-board flash:=0A=
		setenv bootfile aa1100.flash.srec=0A=
		load -r=0A=
=0A=
		./filesystem -=0A=
		The root filesystem to be copied to the PCMCIA CF card.=0A=
		This can be achieved in two ways either by using the filesystem image=0A=
		(see rootfs.img below) or by using a CF reader.  When using a CF reader=0A=
		on your host machine execute the following commands as root to create a=0A=
		filesystem on the CF card and copy the contents of ./filesystem to it:=0A=
=0A=
		(Assuming your CF reader is at /dev/sd1)=0A=
		mke2fs /dev/sd1=0A=
		cd ./filesystem=0A=
		mount -t ext2 /dev/sd1 /mnt/usb=0A=
		find . -print | cpio -p /mnt/usb=0A=
		umount /mnt/usb=0A=
=0A=
		./initrdfs -=0A=
		The initrd filesystem. This is provided only for reference as a =
compressed=0A=
		image of this filesystem is built into the kernel image.=0A=
=0A=
		rootfs.img -=0A=
		An image of the root filesystem in sub-directory 'filesystem'.=0A=
		This image can be written directly to the PCMCIA CF either from the =
host=0A=
		system (eg. via a USB CF reader) or from the target board itself (eg. =
running=0A=
		an nfs mounted filesystem):=0A=
		From the host -		dd if=3Drootfs.img of=3D/dev/sda1 bs=3D1k=0A=
		From the target -	dd if=3Drootfs.img of=3D/dev/hda1 bs=3D1k=0A=
		** Make sure you get the output device correct or you run the risk of =
destroying=0A=
		** your current installation of Linux.=0A=
=0A=
		To run this kernel version directly from the on-board flash the 'start'=0A=
		variable in YAMON must be set to a suitable bootstring.=0A=
		I.E. At the YAMON prompt:=0A=
		Set the environment variable=0A=
		setenv start "go be000000 root=3D/dev/ram0 init=3D/linuxrc rw \\=0A=
		console=3Dtty \\=0A=
		video=3Dau1100fb:panel:640x480_CRT"=0A=
=0A=
		See bootstring.txt for more examples.=0A=
=0A=
	EOF=0A=
}=0A=
=0A=
=0A=
#########################################################################=
########=0A=
#										#=0A=
#			MAIN SCRIPT STARTS HERE					#=0A=
#										#=0A=
#########################################################################=
########=0A=
=0A=
# Default option is ALL=0A=
OPT=3D"ALL"=0A=
=0A=
while getopts ":afnh" opt; do=0A=
	case $opt in=0A=
		a ) OPT=3D"ALL" ;;=0A=
		f ) OPT=3D"FLASH" ;;=0A=
		n ) OPT=3D"NFS" ;;=0A=
		h ) usage ;;=0A=
		\?) echo "Unknown option: -h for usage"; exit 1 ;;=0A=
	esac=0A=
done=0A=
=0A=
# Get the user's password=0A=
#=0A=
get_passwd=0A=
=0A=
# ############=0A=
# NFS image=0A=
# ############=0A=
=0A=
if [ "$OPT" =3D "ALL" ] || [ "$OPT" =3D "NFS" ]; then=0A=
=0A=
	sudo -S rm -rf ${NFS_IMAGE_DIR} < ${PASSWD_FILE}=0A=
	mkdir -p ${NFS_IMAGE_DIR}=0A=
=0A=
	# Create the kernel suitable for nfs download=0A=
	#=0A=
	build_kernel ${CONFIG}/kernel.config.nfs NFS=0A=
	cp ${LINUX}/arch/mips/zboot/images/aa1100.srec ${NFS_IMAGE_DIR}/=0A=
=0A=
	# Creating the NFS file system=0A=
	#=0A=
	create_root_filesystem ${NFS_FS}=0A=
=0A=
	# Install the kernel modules=0A=
	install_modules ${NFS_FS}=0A=
=0A=
	# Create the /etc nfs specific files.=0A=
	(cd ${NFS_FS}; sudo -S tar xzvpf $PREBUILT_BINARIES/etc-nfsroot.tar.gz =
< $PASSWD_FILE)=0A=
=0A=
	# Build busybox=0A=
	build_busybox ${CONFIG}/busybox.config.root ${NFS_FS} ROOT=0A=
=0A=
	create_nfs_readme=0A=
fi=0A=
=0A=
# ############=0A=
# CF image=0A=
# ############=0A=
=0A=
if [ "$OPT" =3D "ALL" ] || [ "$OPT" =3D "FLASH" ]; then=0A=
=0A=
	sudo -S rm -rf ${FLASH_IMAGE_DIR} < ${PASSWD_FILE}=0A=
	mkdir -p ${FLASH_IMAGE_DIR}=0A=
=0A=
	# Create the root filesystem for the pcmcia CF card.=0A=
	#=0A=
	create_root_filesystem ${FLASH_FS}=0A=
=0A=
	if [ "$OPT" =3D "ALL" ]; then=0A=
		# The busybox install is identical for the nfs root and the compact =
flash root=0A=
		# filesystems so we do not have to build it again just install it =
elsewhere=0A=
		sudo -S cp -Rd ${BUSYBOX}/_install/* ${FLASH_FS} < ${PASSWD_FILE}=0A=
		sudo -S chmod u+s ${FLASH_FS}/bin/busybox < ${PASSWD_FILE}=0A=
	else=0A=
		# Build busybox=0A=
		build_busybox ${CONFIG}/busybox.config.root ${FLASH_FS} FLASH_ROOT=0A=
	fi=0A=
=0A=
	# Create the /etc flash root specific files=0A=
	(cd ${FLASH_FS}; sudo -S tar xzvf =
$PREBUILT_BINARIES/etc-flashroot.tar.gz < $PASSWD_FILE)=0A=
=0A=
	# Create the ramdisk filesystem=0A=
	create_initrd_filesystem=0A=
=0A=
	# Build the trimmed busybox initrd version=0A=
	build_busybox ${CONFIG}/busybox.config.initrd ${INITRD_FS} INITRD=0A=
=0A=
	# Create the ramdisk image=0A=
	create_initrd_img=0A=
=0A=
	# Create the kernel containing a ram disk image=0A=
	#=0A=
	build_kernel ${CONFIG}/kernel.config.initrd FLASH=0A=
	cp ${LINUX}/arch/mips/zboot/images/aa1100.flash.srec ${FLASH_IMAGE_DIR}/=0A=
=0A=
	# Install the modules to the root filesystem=0A=
	install_modules ${FLASH_FS}=0A=
=0A=
	# Create an image of the root filesystem suitable for 'dd'ing onto the =
CF card=0A=
	create_rootfs_img=0A=
=0A=
	create_flash_readme=0A=
fi=0A=
=0A=
echo=0A=
echo "Linux Launchpad for Aurora AA1100 build complete."=0A=
echo=0A=
=0A=
=0A=
=0A=
=0A=

------=_NextPart_000_0117_01C598EC.45D2E4C0--
