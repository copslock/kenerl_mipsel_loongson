Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 06:45:54 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:63471 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225223AbTBDGpx>;
	Tue, 4 Feb 2003 06:45:53 +0000
Received: from pudding.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h146jkN01960;
	Tue, 4 Feb 2003 15:45:47 +0900 (JST)
Date: Tue, 4 Feb 2003 15:40:25 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: [patch] TANBAC TB0226(NEC VR4131)
Message-Id: <20030204154025.340fdf40.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__4_Feb_2003_15:40:25_+0900_08258ab8"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Tue__4_Feb_2003_15:40:25_+0900_08258ab8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I added support of TANBAC TB0226 to vr41xx directory.

This patch is based on linux_2_4 tag cvs tree on ftp.linux-mips.org
Would you apply this patch to CVS on ftp.linux-mips.org?

Best Regards,

Yoichi

--Multipart_Tue__4_Feb_2003_15:40:25_+0900_08258ab8
Content-Type: text/plain;
 name="tanbac-tb0226.diff"
Content-Disposition: attachment;
 filename="tanbac-tb0226.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Fri Jan 24 10:25:54 2003
+++ linux/arch/mips/Makefile	Tue Feb  4 15:24:28 2003
@@ -429,6 +429,17 @@
 endif
 
 #
+# TANBAC TB0226 Mbase (VR4131)
+#
+ifdef CONFIG_TANBAC_TB0226
+SUBDIRS		+= arch/mips/vr41xx/common \
+		   arch/mips/vr41xx/tanbac-tb0226
+LIBS		+= arch/mips/vr41xx/common/vr41xx.o \
+		   arch/mips/vr41xx/tanbac-tb0226/tb0226.o
+LOADADDR	:= 0x80000000
+endif
+
+#
 # Philips Nino
 #
 ifdef CONFIG_NINO
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux.orig/arch/mips/config-shared.in	Mon Jan 27 11:06:23 2003
+++ linux/arch/mips/config-shared.in	Tue Feb  4 15:24:28 2003
@@ -191,6 +191,7 @@
    fi
 fi
 bool 'Support for SNI RM200 PCI' CONFIG_SNI_RM200_PCI
+bool 'Support for TANBAC TB0226 (Mbase)' CONFIG_TANBAC_TB0226
 dep_bool 'Support for Toshiba JMR-TX3927 board' CONFIG_TOSHIBA_JMR3927 $CONFIG_MIPS32
 bool 'Support for Victor MP-C303/304' CONFIG_VICTOR_MPC30X
 if [ "$CONFIG_VICTOR_MPC30X" = "y" ]; then
@@ -534,6 +535,19 @@
    define_bool CONFIG_OLD_TIME_C y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_PCI y
+fi
+if [ "$CONFIG_TANBAC_TB0226" = "y" ]; then
+   define_bool CONFIG_CPU_VR41XX y
+   define_bool CONFIG_IRQ_CPU y
+   define_bool CONFIG_NEW_TIME_C y
+   define_bool CONFIG_VR41XX_TIME_C y
+   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_ISA n
+   define_bool CONFIG_PCI y
+   define_bool CONFIG_NEW_PCI y
+   define_bool CONFIG_PCI_AUTO y
+   define_bool CONFIG_DUMMY_KEYB y
+   define_bool CONFIG_SERIAL_MANY_PORTS y
 fi
 if [ "$CONFIG_TOSHIBA_JMR3927" = "y" ]; then
    define_bool CONFIG_TOSHIBA_BOARDS y
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/defconfig-tb0226 linux/arch/mips/defconfig-tb0226
--- linux.orig/arch/mips/defconfig-tb0226	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/defconfig-tb0226	Tue Feb  4 15:24:28 2003
@@ -0,0 +1,773 @@
+#
+# Automatically generated make config: don't edit
+#
+CONFIG_MIPS=y
+CONFIG_MIPS32=y
+# CONFIG_MIPS64 is not set
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_ACER_PICA_61 is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_BAGET_MIPS is not set
+# CONFIG_CASIO_E55 is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_HP_LASERJET is not set
+# CONFIG_IBM_WORKPAD is not set
+# CONFIG_LASAT is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MAGNUM_4000 is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+# CONFIG_NEC_OSPREY is not set
+# CONFIG_NEC_EAGLE is not set
+# CONFIG_OLIVETTI_M700 is not set
+# CONFIG_NINO is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_SB1xxx_SOC is not set
+# CONFIG_SNI_RM200_PCI is not set
+CONFIG_TANBAC_TB0226=y
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_VICTOR_MPC30X is not set
+# CONFIG_ZAO_CAPCELLA is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_CPU_VR41XX=y
+CONFIG_IRQ_CPU=y
+CONFIG_NEW_TIME_C=y
+CONFIG_VR41XX_TIME_C=y
+CONFIG_NONCOHERENT_IO=y
+# CONFIG_ISA is not set
+CONFIG_PCI=y
+CONFIG_NEW_PCI=y
+CONFIG_PCI_AUTO=y
+CONFIG_DUMMY_KEYB=y
+CONFIG_SERIAL_MANY_PORTS=y
+# CONFIG_MIPS_AU1000 is not set
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32 is not set
+# CONFIG_CPU_MIPS64 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+CONFIG_CPU_VR41XX=y
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_ADVANCED is not set
+# CONFIG_CPU_HAS_LLSC is not set
+# CONFIG_CPU_HAS_LLDSCD is not set
+# CONFIG_CPU_HAS_WB is not set
+CONFIG_CPU_HAS_SYNC=y
+
+#
+# General setup
+#
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_NET=y
+# CONFIG_PCI_NAMES is not set
+# CONFIG_ISA is not set
+# CONFIG_EISA is not set
+# CONFIG_TC is not set
+# CONFIG_MCA is not set
+# CONFIG_SBUS is not set
+# CONFIG_HOTPLUG is not set
+# CONFIG_PCMCIA is not set
+# CONFIG_HOTPLUG_PCI is not set
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+CONFIG_KCORE_ELF=y
+# CONFIG_KCORE_AOUT is not set
+# CONFIG_BINFMT_AOUT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_MIPS32_COMPAT is not set
+# CONFIG_MIPS32_O32 is not set
+# CONFIG_MIPS32_N32 is not set
+# CONFIG_BINFMT_ELF32 is not set
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_PM is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play configuration
+#
+# CONFIG_PNP is not set
+# CONFIG_ISAPNP is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_XD is not set
+# CONFIG_PARIDE is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_CISS_SCSI_TAPE is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_BLK_STATS is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+# CONFIG_BLK_DEV_MD is not set
+# CONFIG_MD_LINEAR is not set
+# CONFIG_MD_RAID0 is not set
+# CONFIG_MD_RAID1 is not set
+# CONFIG_MD_RAID5 is not set
+# CONFIG_MD_MULTIPATH is not set
+# CONFIG_BLK_DEV_LVM is not set
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_NETLINK_DEV=y
+# CONFIG_NETFILTER is not set
+# CONFIG_FILTER is not set
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_INET_ECN is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_IPV6 is not set
+# CONFIG_KHTTPD is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+
+#
+#  
+#
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+
+#
+# Appletalk devices
+#
+# CONFIG_DEV_APPLETALK is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_LLC is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+# CONFIG_PHONE_IXJ is not set
+# CONFIG_PHONE_IXJ_PCMCIA is not set
+
+#
+# ATA/IDE/MFM/RLL support
+#
+# CONFIG_IDE is not set
+# CONFIG_BLK_DEV_IDE_MODES is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI support
+#
+CONFIG_SCSI=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_SD_EXTRA_DEVS=40
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_SR_EXTRA_DEVS=2
+# CONFIG_CHR_DEV_SG is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_DEBUG_QUEUES is not set
+# CONFIG_SCSI_MULTI_LUN is not set
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_7000FASST is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AHA152X is not set
+# CONFIG_SCSI_AHA1542 is not set
+# CONFIG_SCSI_AHA1740 is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_IN2000 is not set
+# CONFIG_SCSI_AM53C974 is not set
+# CONFIG_SCSI_MEGARAID is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_CPQFCTS is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_DTC3280 is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_DMA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_GENERIC_NCR5380 is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_NCR53C406A is not set
+# CONFIG_SCSI_NCR53C7xx is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_NCR53C8XX is not set
+# CONFIG_SCSI_SYM53C8XX is not set
+# CONFIG_SCSI_PAS16 is not set
+# CONFIG_SCSI_PCI2000 is not set
+# CONFIG_SCSI_PCI2220I is not set
+# CONFIG_SCSI_PSI240I is not set
+# CONFIG_SCSI_QLOGIC_FAS is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_SIM710 is not set
+# CONFIG_SCSI_SYM53C416 is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_T128 is not set
+# CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+# CONFIG_I2O_PCI is not set
+# CONFIG_I2O_BLOCK is not set
+# CONFIG_I2O_LAN is not set
+# CONFIG_I2O_SCSI is not set
+# CONFIG_I2O_PROC is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_SUNLANCE is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNBMAC is not set
+# CONFIG_SUNQE is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_LANCE is not set
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_ISA is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_APRICOT is not set
+# CONFIG_CS89x0 is not set
+# CONFIG_TULIP is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_DGRS is not set
+# CONFIG_DM9102 is not set
+CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
+# CONFIG_LNE390 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_NE3210 is not set
+# CONFIG_ES3210 is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_8139TOO_PIO is not set
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_TC35815 is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_VIA_RHINE_MMIO is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_LAN_SAA9730 is not set
+# CONFIG_NET_POCKET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_MYRI_SBUS is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PLIP is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+# CONFIG_NET_FC is not set
+# CONFIG_RCPCI is not set
+# CONFIG_SHAPER is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# Amateur Radio support
+#
+# CONFIG_HAMRADIO is not set
+
+#
+# IrDA (infrared) support
+#
+# CONFIG_IRDA is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input core support
+#
+# CONFIG_INPUT is not set
+# CONFIG_INPUT_KEYBDEV is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+# CONFIG_VT_CONSOLE is not set
+CONFIG_SERIAL=y
+CONFIG_SERIAL_CONSOLE=y
+# CONFIG_SERIAL_EXTENDED is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_UNIX98_PTY_COUNT=256
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Mice
+#
+# CONFIG_BUSMOUSE is not set
+# CONFIG_MOUSE is not set
+
+#
+# Joysticks
+#
+# CONFIG_INPUT_GAMEPORT is not set
+
+#
+# Input core support is needed for gameports
+#
+
+#
+# Input core support is needed for joysticks
+#
+# CONFIG_QIC02_TAPE is not set
+
+#
+# Watchdog Cards
+#
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+# CONFIG_ACQUIRE_WDT is not set
+# CONFIG_ADVANTECH_WDT is not set
+# CONFIG_ALIM7101_WDT is not set
+# CONFIG_SC520_WDT is not set
+# CONFIG_PCWATCHDOG is not set
+# CONFIG_EUROTECH_WDT is not set
+# CONFIG_IB700_WDT is not set
+# CONFIG_WAFER_WDT is not set
+# CONFIG_I810_TCO is not set
+# CONFIG_MIXCOMWD is not set
+# CONFIG_60XX_WDT is not set
+# CONFIG_SC1200_WDT is not set
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_W83877F_WDT is not set
+# CONFIG_WDT is not set
+# CONFIG_WDTPCI is not set
+# CONFIG_MACHZ_WDT is not set
+# CONFIG_INDYDOG is not set
+# CONFIG_AMD7XX_TCO is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# File systems
+#
+# CONFIG_QUOTA is not set
+CONFIG_AUTOFS_FS=y
+CONFIG_AUTOFS4_FS=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_ADFS_FS_RW is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BEFS_DEBUG is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_JBD_DEBUG is not set
+# CONFIG_FAT_FS is not set
+# CONFIG_MSDOS_FS is not set
+# CONFIG_UMSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_TMPFS is not set
+CONFIG_RAMFS=y
+# CONFIG_ISO9660_FS is not set
+# CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_NTFS_FS is not set
+# CONFIG_NTFS_RW is not set
+# CONFIG_HPFS_FS is not set
+CONFIG_PROC_FS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVFS_MOUNT is not set
+# CONFIG_DEVFS_DEBUG is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX4FS_RW is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_EXT2_FS=y
+# CONFIG_SYSV_FS is not set
+# CONFIG_UDF_FS is not set
+# CONFIG_UDF_RW is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_UFS_FS_WRITE is not set
+
+#
+# Network File Systems
+#
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+# CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_SUNRPC=y
+CONFIG_LOCKD=y
+# CONFIG_SMB_FS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_NCPFS_PACKET_SIGNING is not set
+# CONFIG_NCPFS_IOCTL_LOCKING is not set
+# CONFIG_NCPFS_STRONG is not set
+# CONFIG_NCPFS_NFS_NS is not set
+# CONFIG_NCPFS_OS2_NS is not set
+# CONFIG_NCPFS_SMALLDOS is not set
+# CONFIG_NCPFS_NLS is not set
+# CONFIG_NCPFS_EXTRAS is not set
+# CONFIG_ZISOFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+CONFIG_SGI_PARTITION=y
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SMB_NLS is not set
+# CONFIG_NLS is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Console drivers
+#
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_MDA_CONSOLE is not set
+
+#
+# Frame-buffer support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_BANDWIDTH=y
+CONFIG_USB_LONG_TIMEOUT=y
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_UHCI is not set
+# CONFIG_USB_UHCI_ALT is not set
+CONFIG_USB_OHCI=y
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_AUDIO is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_BLUETOOTH is not set
+# CONFIG_USB_MIDI is not set
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_HP8200e is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# USB Human Interface Devices (HID)
+#
+# CONFIG_USB_HID is not set
+
+#
+#     Input core support is needed for USB HID input layer or HIDBP support
+#
+# CONFIG_USB_HIDINPUT is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_DC2XX is not set
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_SCANNER is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_HPUSBSCSI is not set
+
+#
+# USB Multimedia devices
+#
+
+#
+#   Video4Linux support is needed for USB Multimedia device support
+#
+
+#
+# USB Network adaptors
+#
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_CDCETHER is not set
+# CONFIG_USB_USBNET is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_USS720 is not set
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_TIGL is not set
+# CONFIG_USB_BRLVGER is not set
+# CONFIG_USB_LCD is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BLUEZ is not set
+
+#
+# Kernel hacking
+#
+CONFIG_CROSSCOMPILE=y
+# CONFIG_DEBUG is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_MIPS_UNCACHED is not set
+
+#
+# Library routines
+#
+# CONFIG_ZLIB_INFLATE is not set
+# CONFIG_ZLIB_DEFLATE is not set
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux.orig/arch/mips/kernel/setup.c	Fri Jan 24 10:25:54 2003
+++ linux/arch/mips/kernel/setup.c	Tue Feb  4 15:24:28 2003
@@ -490,6 +490,7 @@
 	void victor_mpc30x_setup(void);
 	void ibm_workpad_setup(void);
 	void casio_e55_setup(void);
+	void tanbac_tb0226_setup(void);
 	void jmr3927_setup(void);
  	void it8172_setup(void);
 	void swarm_setup(void);
@@ -614,6 +615,11 @@
 #ifdef CONFIG_CASIO_E55
 		case MACH_CASIO_E55:
 			casio_e55_setup();
+			break;
+#endif
+#ifdef CONFIG_TANBAC_TB0226
+		case MACH_TANBAC_TB0226:
+			tanbac_tb0226_setup();
 			break;
 #endif
 		}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/Makefile linux/arch/mips/vr41xx/tanbac-tb0226/Makefile
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/Makefile	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/Makefile	Tue Feb  4 15:24:28 2003
@@ -0,0 +1,19 @@
+#
+# Makefile for the TANBAC TB0226 specific parts of the kernel
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+
+USE_STANDARD_AS_RULE := true
+
+O_TARGET := tb0226.o
+
+all: tb0226.o
+
+obj-y	:= init.o setup.o
+
+obj-$(CONFIG_PCI)	+= pci_fixup.o
+
+include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/init.c linux/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/init.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/init.c	Tue Feb  4 15:24:28 2003
@@ -0,0 +1,68 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0226/init.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Initialisation code for the TANBAC TB0226.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/vr41xx/vr41xx.h>
+
+char arcs_cmdline[CL_SIZE];
+
+const char *get_system_type(void)
+{
+	return "TANBAC TB0226";
+}
+
+void __init bus_error_init(void)
+{
+}
+
+void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
+{
+	u32 config;
+	int i;
+
+	/*
+	 * collect args and prepare cmd_line
+	 */
+	for (i = 1; i < argc; i++) {
+		strcat(arcs_cmdline, argv[i]);
+		if (i < (argc - 1))
+			strcat(arcs_cmdline, " ");
+	}
+
+	mips_machgroup = MACH_GROUP_NEC_VR41XX;
+	mips_machtype = MACH_TANBAC_TB0226;
+
+	switch (mips_cpu.processor_id) {
+	case PRID_VR4131_REV1_2:
+		config = read_c0_config();
+		config &= ~0x00000030UL;
+		config |= 0x00410000UL;
+		write_c0_config(config);
+		break;
+	default:
+		break;
+	}
+}
+
+void __init prom_free_prom_memory (void)
+{
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c linux/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c	Tue Feb  4 15:24:28 2003
@@ -0,0 +1,87 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	The TANBAC TB0226 specific PCI fixups.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/vr41xx/tb0226.h>
+
+void __init pcibios_fixup_resources(struct pci_dev *dev)
+{
+}
+
+void __init pcibios_fixup(void)
+{
+}
+
+void __init pcibios_fixup_irqs(void)
+{
+	struct pci_dev *dev;
+	u8 slot, pin;
+
+	pci_for_each_dev(dev) {
+		slot = PCI_SLOT(dev->devfn);
+		dev->irq = 0;
+
+		switch (slot) {
+		case 12:
+			vr41xx_set_irq_trigger(GD82559_1_PIN, TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(GD82559_1_PIN, LEVEL_LOW);
+			dev->irq = GD82559_1_IRQ;
+			break;
+		case 13:
+			vr41xx_set_irq_trigger(GD82559_2_PIN, TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(GD82559_2_PIN, LEVEL_LOW);
+			dev->irq = GD82559_2_IRQ;
+			break;
+		case 14:
+			pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+			switch (pin) {
+			case 1:
+				vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
+				                       TRIGGER_LEVEL,
+				                       SIGNAL_THROUGH);
+				vr41xx_set_irq_level(UPD720100_INTA_PIN, LEVEL_LOW);
+				dev->irq = UPD720100_INTA_IRQ;
+				break;
+			case 2:
+				vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
+				                       TRIGGER_LEVEL,
+				                       SIGNAL_THROUGH);
+				vr41xx_set_irq_level(UPD720100_INTB_PIN, LEVEL_LOW);
+				dev->irq = UPD720100_INTB_IRQ;
+				break;
+			case 3:
+				vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
+				                       TRIGGER_LEVEL,
+				                       SIGNAL_THROUGH);
+				vr41xx_set_irq_level(UPD720100_INTC_PIN, LEVEL_LOW);
+				dev->irq = UPD720100_INTC_IRQ;
+				break;
+			}
+			break;
+		}
+
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+}
+
+unsigned int pcibios_assign_all_busses(void)
+{
+	return 0;
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Tue Feb  4 15:24:28 2003
@@ -0,0 +1,113 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0226/setup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Setup for the TANBAC TB0226.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+
+#include <asm/pci_channel.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/vr41xx/tb0226.h>
+
+#ifdef CONFIG_BLK_DEV_INITRD
+extern unsigned long initrd_start, initrd_end;
+extern void * __rd_start, * __rd_end;
+#endif
+
+#ifdef CONFIG_PCI
+static struct resource vr41xx_pci_io_resource = {
+	"PCI I/O space",
+	VR41XX_PCI_IO_START,
+	VR41XX_PCI_IO_END,
+	IORESOURCE_IO
+};
+
+static struct resource vr41xx_pci_mem_resource = {
+	"PCI memory space",
+	VR41XX_PCI_MEM_START,
+	VR41XX_PCI_MEM_END,
+	IORESOURCE_MEM
+};
+
+extern struct pci_ops vr41xx_pci_ops;
+
+struct pci_channel mips_pci_channels[] = {
+	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
+	{NULL, NULL, NULL, 0, 0}
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
+	VR41XX_PCI_MEM1_BASE,
+	VR41XX_PCI_MEM1_MASK,
+	IO_MEM1_RESOURCE_START
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
+	VR41XX_PCI_MEM2_BASE,
+	VR41XX_PCI_MEM2_MASK,
+	IO_MEM2_RESOURCE_START
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_io = {
+	VR41XX_PCI_IO_BASE,
+	VR41XX_PCI_IO_MASK,
+	IO_PORT_RESOURCE_START
+};
+
+static struct vr41xx_pci_address_map pci_address_map = {
+	&vr41xx_pci_mem1,
+	&vr41xx_pci_mem2,
+	&vr41xx_pci_io
+};
+#endif
+
+void __init tanbac_tb0226_setup(void)
+{
+	set_io_port_base(IO_PORT_BASE);
+	ioport_resource.start = IO_PORT_RESOURCE_START;
+	ioport_resource.end = IO_PORT_RESOURCE_END;
+	iomem_resource.start = IO_MEM1_RESOURCE_START;
+	iomem_resource.end = IO_MEM2_RESOURCE_END;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	initrd_start = (unsigned long)&__rd_start;
+	initrd_end = (unsigned long)&__rd_end;
+#endif
+
+	_machine_restart = vr41xx_restart;
+	_machine_halt = vr41xx_halt;
+	_machine_power_off = vr41xx_power_off;
+
+	board_time_init = vr41xx_time_init;
+	board_timer_setup = vr41xx_timer_setup;
+
+#ifdef CONFIG_FB
+	conswitchp = &dummy_con;
+#endif
+
+	vr41xx_bcu_init();
+
+	vr41xx_cmu_init(0);
+
+	vr41xx_siu_init(SIU_RS232C, 0);
+
+#ifdef CONFIG_PCI
+	vr41xx_pciu_init(&pci_address_map);
+#endif
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux.orig/include/asm-mips/bootinfo.h	Wed Jan 29 10:29:12 2003
+++ linux/include/asm-mips/bootinfo.h	Tue Feb  4 15:24:28 2003
@@ -179,6 +179,7 @@
 #define MACH_VICTOR_MPC30X	3	/* Victor MP-C303/304 */
 #define MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
 #define MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
+#define MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (MBASE) */
 
 #define CL_SIZE			(256)
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/tb0226.h linux/include/asm-mips/vr41xx/tb0226.h
--- linux.orig/include/asm-mips/vr41xx/tb0226.h	Thu Jan  1 09:00:00 1970
+++ linux/include/asm-mips/vr41xx/tb0226.h	Tue Feb  4 15:24:28 2003
@@ -0,0 +1,69 @@
+/*
+ * FILE NAME
+ *	include/asm-mips/vr41xx/tb0226.h
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Include file for TANBAC TB0226.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#ifndef __TANBAC_TB0226_H
+#define __TANBAC_TB0226_H
+
+#include <asm/addrspace.h>
+#include <asm/vr41xx/vr41xx.h>
+
+/*
+ * Board specific address mapping
+ */
+#define VR41XX_PCI_MEM1_BASE		0x10000000
+#define VR41XX_PCI_MEM1_SIZE		0x04000000
+#define VR41XX_PCI_MEM1_MASK		0x7c000000
+
+#define VR41XX_PCI_MEM2_BASE		0x14000000
+#define VR41XX_PCI_MEM2_SIZE		0x02000000
+#define VR41XX_PCI_MEM2_MASK		0x7e000000
+
+#define VR41XX_PCI_IO_BASE		0x16000000
+#define VR41XX_PCI_IO_SIZE		0x02000000
+#define VR41XX_PCI_IO_MASK		0x7e000000
+
+#define VR41XX_PCI_IO_START		0x01000000
+#define VR41XX_PCI_IO_END		0x01ffffff
+
+#define VR41XX_PCI_MEM_START		0x12000000
+#define VR41XX_PCI_MEM_END		0x15ffffff
+
+#define IO_PORT_BASE			KSEG1ADDR(VR41XX_PCI_IO_BASE)
+#define IO_PORT_RESOURCE_START		0
+#define IO_PORT_RESOURCE_END		VR41XX_PCI_IO_SIZE
+#define IO_MEM1_RESOURCE_START		VR41XX_PCI_MEM1_BASE
+#define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
+#define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
+#define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
+
+/*
+ * General-Purpose I/O Pin Number
+ */
+#define GD82559_1_PIN			2
+#define GD82559_2_PIN			3
+#define UPD720100_INTA_PIN		4
+#define UPD720100_INTB_PIN		8
+#define UPD720100_INTC_PIN		13
+
+/*
+ * Interrupt Number
+ */
+#define GD82559_1_IRQ			GIU_IRQ(GD82559_1_PIN)
+#define GD82559_2_IRQ			GIU_IRQ(GD82559_2_PIN)
+#define UPD720100_INTA_IRQ		GIU_IRQ(UPD720100_INTA_PIN)
+#define UPD720100_INTB_IRQ		GIU_IRQ(UPD720100_INTB_PIN)
+#define UPD720100_INTC_IRQ		GIU_IRQ(UPD720100_INTC_PIN)
+
+#endif /* __TANBAC_TB0226_H */

--Multipart_Tue__4_Feb_2003_15:40:25_+0900_08258ab8--
