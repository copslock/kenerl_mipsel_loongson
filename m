Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2003 14:42:06 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:61921 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225196AbTETNmC>;
	Tue, 20 May 2003 14:42:02 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id WAA09379;
	Tue, 20 May 2003 22:41:56 +0900 (JST)
Received: 4UMDO00 id h4KDfur13567; Tue, 20 May 2003 22:41:56 +0900 (JST)
Received: 4UMRO00 id h4KDfse13155; Tue, 20 May 2003 22:41:55 +0900 (JST)
	from stratos.frog (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 20 May 2003 22:41:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, matsu@megasolution.jp,
	linux-mips@linux-mips.org
Subject: [patch] TANBAC TB0229(NEC VR4131)
Message-Id: <20030520224145.1b2bdcc1.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__20_May_2003_22:41:45_+0900_08458450"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Tue__20_May_2003_22:41:45_+0900_08458450
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

We made TANBAC TB0229(not TB0226) patches for v2.4 and v2.5.

Would you apply these patch to CVS on ftp.linux-mips.org?

Best Regards,

Yoichi


--Multipart_Tue__20_May_2003_22:41:45_+0900_08458450
Content-Type: text/plain;
 name="tanbac-tb0229-v24.diff"
Content-Disposition: attachment;
 filename="tanbac-tb0229-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Tue May 20 14:35:19 2003
+++ linux/arch/mips/Makefile	Tue May 20 15:39:05 2003
@@ -448,6 +448,17 @@
 endif
 
 #
+# TANBAC TB0229 (VR4131DIMM)
+#
+ifdef CONFIG_TANBAC_TB0229
+SUBDIRS		+= arch/mips/vr41xx/common \
+		   arch/mips/vr41xx/tanbac-tb0229
+CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
+		   arch/mips/vr41xx/tanbac-tb0229/tb0229.o
+LOADADDR	:= 0x80000000
+endif
+
+#
 # Philips Nino
 #
 ifdef CONFIG_NINO
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux.orig/arch/mips/config-shared.in	Tue May 20 14:35:19 2003
+++ linux/arch/mips/config-shared.in	Tue May 20 15:39:05 2003
@@ -195,6 +195,11 @@
 fi
 bool 'Support for SNI RM200 PCI' CONFIG_SNI_RM200_PCI
 bool 'Support for TANBAC TB0226 (Mbase)' CONFIG_TANBAC_TB0226
+bool 'Support for TANBAC TB0229 (VR4131DIMM)' CONFIG_TANBAC_TB0229
+if [ "$CONFIG_TANBAC_TB0229" = "y" ]; then
+   bool '  Add TANBAC TB0219 Base board support' CONFIG_TANBAC_TB0219
+fi
+
 dep_bool 'Support for Toshiba JMR-TX3927 board' CONFIG_TOSHIBA_JMR3927 $CONFIG_MIPS32
 bool 'Support for Toshiba RBTX49[23]7 Reference Board' CONFIG_TOSHIBA_RBTX4927
 bool 'Support for Victor MP-C303/304' CONFIG_VICTOR_MPC30X
@@ -555,6 +560,19 @@
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SERIAL_MANY_PORTS y
+fi
+if [ "$CONFIG_TANBAC_TB0229" = "y" ]; then
+    define_bool CONFIG_CPU_VR41XX y
+    define_bool CONFIG_IRQ_CPU y
+    define_bool CONFIG_NEW_TIME_C y
+    define_bool CONFIG_VR41XX_TIME_C y
+    define_bool CONFIG_NONCOHERENT_IO y
+    define_bool CONFIG_ISA n
+    define_bool CONFIG_PCI y
+    define_bool CONFIG_NEW_PCI y
+    define_bool CONFIG_PCI_AUTO y
+    define_bool CONFIG_DUMMY_KEYB y
+    define_bool CONFIG_SERIAL_MANY_PORTS y
 fi
 if [ "$CONFIG_TOSHIBA_JMR3927" = "y" ]; then
    define_bool CONFIG_TOSHIBA_BOARDS y
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/defconfig-tb0229 linux/arch/mips/defconfig-tb0229
--- linux.orig/arch/mips/defconfig-tb0229	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/defconfig-tb0229	Tue May 20 15:39:05 2003
@@ -0,0 +1,632 @@
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
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1500 is not set
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
+# CONFIG_TANBAC_TB0226 is not set
+CONFIG_TANBAC_TB0229=y
+CONFIG_TANBAC_TB0219=y
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
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
+# CONFIG_SCSI is not set
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
+CONFIG_NET_VENDOR_3COM=y
+# CONFIG_EL1 is not set
+# CONFIG_EL2 is not set
+# CONFIG_ELPLUS is not set
+# CONFIG_EL16 is not set
+# CONFIG_ELMC is not set
+# CONFIG_ELMC_II is not set
+CONFIG_VORTEX=y
+# CONFIG_LANCE is not set
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_ISA is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
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
+CONFIG_8139CP=y
+CONFIG_8139TOO=y
+# CONFIG_8139TOO_PIO is not set
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_SUNDANCE_MMIO is not set
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
+# CONFIG_R8169 is not set
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
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_IPMI_PANIC_EVENT is not set
+# CONFIG_IPMI_DEVICE_INTERFACE is not set
+# CONFIG_IPMI_KCS is not set
+# CONFIG_IPMI_WATCHDOG is not set
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
+# CONFIG_SCx200_WDT is not set
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_W83877F_WDT is not set
+# CONFIG_WDT is not set
+# CONFIG_WDTPCI is not set
+# CONFIG_MACHZ_WDT is not set
+# CONFIG_INDYDOG is not set
+# CONFIG_AMD7XX_TCO is not set
+# CONFIG_SCx200_GPIO is not set
+# CONFIG_AMD_PM768 is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_MIPS_RTC is not set
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
+# CONFIG_SGI_PARTITION is not set
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
+# CONFIG_USB is not set
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
+# CONFIG_RUNTIME_DEBUG is not set
+# CONFIG_KGDB is not set
+# CONFIG_GDB_CONSOLE is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_MIPS_UNCACHED is not set
+
+#
+# Library routines
+#
+# CONFIG_ZLIB_INFLATE is not set
+# CONFIG_ZLIB_DEFLATE is not set
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux.orig/arch/mips/kernel/setup.c	Wed May  7 12:06:45 2003
+++ linux/arch/mips/kernel/setup.c	Tue May 20 15:39:05 2003
@@ -622,6 +622,11 @@
 			tanbac_tb0226_setup();
 			break;
 #endif
+#ifdef CONFIG_TANBAC_TB0229
+		case MACH_TANBAC_TB0229:
+			tanbac_tb0229_setup();
+			break;
+#endif
 		}
 		break;
 #endif
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	Tue May 20 15:39:05 2003
@@ -0,0 +1,19 @@
+#
+# Makefile for the TANBAC TB0229(VR4131DIMM) specific parts of the kernel
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+
+USE_STANDARD_AS_RULE := true
+
+O_TARGET := tb0229.o
+
+all: tb0229.o
+
+obj-y	:= init.o setup.o reboot.o
+
+obj-$(CONFIG_PCI)	+= pci_fixup.o
+
+include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/init.c linux/arch/mips/vr41xx/tanbac-tb0229/init.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/init.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/init.c	Tue May 20 21:52:52 2003
@@ -0,0 +1,69 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/init.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Initialisation code for the TANBAC TB0229(VR4131DIMM)
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ * Modified for TANBAC TB0229:
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
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
+	return "TANBAC TB0229";
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
+	mips_machtype = MACH_TANBAC_TB0229;
+
+	switch (current_cpu_data.processor_id) {
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
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c linux/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c	Tue May 20 15:39:05 2003
@@ -0,0 +1,71 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	The TANBAC TB0229(VR4131DIMM) specific PCI fixups.
+ *
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
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
+#include <asm/vr41xx/tb0229.h>
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
+#ifdef CONFIG_TANBAC_TB0219
+	struct pci_dev *dev;
+	u8 slot;
+
+	pci_for_each_dev(dev) {
+		slot = PCI_SLOT(dev->devfn);
+		dev->irq = 0;
+
+		switch (slot) {
+		case 12:
+			vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN , TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN, LEVEL_LOW);
+			dev->irq = TB0219_PCI_SLOT1_IRQ;
+			break;
+		case 13:
+			vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN , TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN, LEVEL_LOW);
+			dev->irq = TB0219_PCI_SLOT2_IRQ;
+			break;
+		case 14:
+			vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN , TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, LEVEL_LOW);
+			dev->irq = TB0219_PCI_SLOT3_IRQ;
+			break;
+		default:
+			break;
+		}
+
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+#endif
+}
+
+unsigned int pcibios_assign_all_busses(void)
+{
+	return 0;
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Tue May 20 15:39:05 2003
@@ -0,0 +1,30 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/reboot.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Depending on TANBAC TB0229(VR4131DIMM) of reboot system call.
+ *
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <asm/io.h>
+#include <asm/vr41xx/tb0229.h>
+
+#define tb0229_hard_reset()	writew(0, TB0219_RESET_REGS)
+
+void tanbac_tb0229_restart(char *command)
+{
+#ifdef CONFIG_TANBAC_TB0219
+	local_irq_disable();
+	tb0229_hard_reset();
+	while (1);
+#else
+	vr41xx_restart(command);
+#endif
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Tue May 20 17:38:32 2003
@@ -0,0 +1,126 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/setup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Setup for the TANBAC TB0229 (VR4131DIMM)
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ * Modified for TANBAC TB0229:
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/blk.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+
+#include <asm/pci_channel.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/vr41xx/tb0229.h>
+
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void * __rd_start, * __rd_end;
+#endif
+
+#ifdef CONFIG_PCI
+static struct resource vr41xx_pci_io_resource = {
+	.name	= "PCI I/O space",
+	.start	= VR41XX_PCI_IO_START,
+	.end	= VR41XX_PCI_IO_END,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct resource vr41xx_pci_mem_resource = {
+	.name	= "PCI memory space",
+	.start	= VR41XX_PCI_MEM_START,
+	.end	= VR41XX_PCI_MEM_END,
+	.flags	= IORESOURCE_MEM,
+};
+
+extern struct pci_ops vr41xx_pci_ops;
+
+struct pci_channel mips_pci_channels[] = {
+	{	.pci_ops	= &vr41xx_pci_ops,
+		.io_resource	= &vr41xx_pci_io_resource,
+		.mem_resource	= &vr41xx_pci_mem_resource,
+		.first_devfn	= 0,
+		.last_devfn	= 256,	},
+	{	.pci_ops	= NULL,
+		.io_resource	= NULL,
+		.mem_resource	= NULL,
+		.first_devfn	= 0,
+		.last_devfn	= 0,	}
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
+	.internal_base	= VR41XX_PCI_MEM1_BASE,
+	.address_mask	= VR41XX_PCI_MEM1_MASK,
+	.pci_base	= IO_MEM1_RESOURCE_START,
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
+	.internal_base	= VR41XX_PCI_MEM2_BASE,
+	.address_mask	= VR41XX_PCI_MEM2_MASK,
+	.pci_base	= IO_MEM2_RESOURCE_START,
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_io = {
+	.internal_base	= VR41XX_PCI_IO_BASE,
+	.address_mask	= VR41XX_PCI_IO_MASK,
+	.pci_base	= IO_PORT_RESOURCE_START,
+};
+
+static struct vr41xx_pci_address_map pci_address_map = {
+	.mem1	= &vr41xx_pci_mem1,
+	.mem2	= &vr41xx_pci_mem2,
+	.io	= &vr41xx_pci_io,
+};
+#endif
+
+void __init tanbac_tb0229_setup(void)
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
+	_machine_restart = tanbac_tb0229_restart;
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
+	vr41xx_dsiu_init();
+
+#ifdef CONFIG_PCI
+	vr41xx_pciu_init(&pci_address_map);
+#endif
+}
+
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux.orig/include/asm-mips/bootinfo.h	Mon Apr 14 10:47:07 2003
+++ linux/include/asm-mips/bootinfo.h	Tue May 20 17:48:14 2003
@@ -184,6 +184,7 @@
 #define MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
 #define MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
 #define MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (MBASE) */
+#define MACH_TANBAC_TB0229	7	/* TANBAC TB0229 (VR4131DIMM) */
 
 #define CL_SIZE			(256)
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/tb0229.h linux/include/asm-mips/vr41xx/tb0229.h
--- linux.orig/include/asm-mips/vr41xx/tb0229.h	Thu Jan  1 09:00:00 1970
+++ linux/include/asm-mips/vr41xx/tb0229.h	Tue May 20 17:48:32 2003
@@ -0,0 +1,73 @@
+/*
+ * FILE NAME
+ *	include/asm-mips/vr41xx/tb0229.h
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Include file for TANBAC TB0229 and TB0219.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ * Modified for TANBAC TB0229:
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#ifndef __TANBAC_TB0229_H
+#define __TANBAC_TB0229_H
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
+#define TB0219_PCI_SLOT1_PIN		2
+#define TB0219_PCI_SLOT2_PIN		3
+#define TB0219_PCI_SLOT3_PIN		4
+
+/*
+ * Interrupt Number
+ */
+#define TB0219_PCI_SLOT1_IRQ		GIU_IRQ(TB0219_PCI_SLOT1_PIN)
+#define TB0219_PCI_SLOT2_IRQ		GIU_IRQ(TB0219_PCI_SLOT2_PIN)
+#define TB0219_PCI_SLOT3_IRQ		GIU_IRQ(TB0219_PCI_SLOT3_PIN)
+
+#define TB0219_RESET_REGS		KSEG1ADDR(0x0a00000e)
+
+extern void tanbac_tb0229_restart(char *command);
+
+#endif /* __TANBAC_TB0229_H */


--Multipart_Tue__20_May_2003_22:41:45_+0900_08458450
Content-Type: text/plain;
 name="tanbac-tb0229-v25.diff"
Content-Disposition: attachment;
 filename="tanbac-tb0229-v25.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Kconfig-shared linux/arch/mips/Kconfig-shared
--- linux.orig/arch/mips/Kconfig-shared	Wed May  7 12:09:12 2003
+++ linux/arch/mips/Kconfig-shared	Tue May 20 16:01:11 2003
@@ -16,7 +16,7 @@
 
 config PCI_AUTO
 	bool "Support for PCI AUTO Config" if MIPS_PB1000
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || TANBAC_TB0226
+	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || TANBAC_TB0226 || TANBAC_TB0229
 
 
 config BAGET_MIPS
@@ -453,7 +453,7 @@
 
 config PCI
 	bool "Support for PCI controller" if SIBYTE_SB1xxx_SOC && SIBYTE_SB1250
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP27 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_MALTA || MIPS_ATLAS || LASAT || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226
+	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP27 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_MALTA || MIPS_ATLAS || LASAT || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226 || TANBAC_TB0229
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -483,6 +483,12 @@
 	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by TANBAC.
 	  Please refer to <http://www.tanbac.co.jp/> about Mbase.
 
+config TANBAC_TB0229
+	bool "Support for TANBAC TB0229 (VR4131DIMM)"
+	help
+	  The TANBAC TB0229 (VR4131DIMM) is a MIPS-based platform manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about VR4131DIMM.
+
 config TOSHIBA_JMR3927
 	bool "Support for Toshiba JMR-TX3927 board"
 	depends on MIPS32
@@ -540,8 +546,8 @@
 
 config NONCOHERENT_IO
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226 || TANBAC_TB0229
+	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NINO || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226 || TANBAC_TB0229
 	default n if (SIBYTE_SB1250 || SGI_IP27)
 
 config CPU_LITTLE_ENDIAN
@@ -555,22 +561,22 @@
 
 config IRQ_CPU
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SGI_IP22 || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || IBM_WORKPAD || HP_LASERJET || DECSTATION || CASIO_E55 || TANBAC_TB0226
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SGI_IP22 || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || IBM_WORKPAD || HP_LASERJET || DECSTATION || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
 config VR41XX_TIME_C
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || NEC_EAGLE || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || NEC_EAGLE || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
 config DUMMY_KEYB
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1250 || NEC_EAGLE || NEC_OSPREY || DDB5477 || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1250 || NEC_EAGLE || NEC_OSPREY || DDB5477 || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
 config VR41XX_COMMON
 	bool
-	depends on NEC_EAGLE || ZAO_CAPCELLA || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226
+	depends on NEC_EAGLE || ZAO_CAPCELLA || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
 config VRC4173
@@ -594,7 +600,7 @@
 
 config NEW_PCI
 	bool
-	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226
+	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || NEC_EAGLE || DDB5477 || DDB5476 || DDB5074 || MIPS_ITE8172 || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
 config SWAP_IO_SPACE
@@ -746,6 +752,11 @@
 	bool
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
 	default y
+
+config TANBAC_TB0219
+	bool "Added TANBAC TB0219 Base board support"
+	depends on TANBAC_TB0229
+
 endmenu
 
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Wed May  7 12:09:12 2003
+++ linux/arch/mips/Makefile	Tue May 20 16:01:11 2003
@@ -272,6 +272,12 @@
 load-$(CONFIG_TANBAC_TB0226)	+= 0x80000000
 
 #
+# TANBAC TB0229 VR4131DIMM (VR4131)
+#
+core-$(CONFIG_TANBAC_TB0229)	+= arch/mips/vr41xx/tanbac-tb0229/
+load-$(CONFIG_TANBAC_TB0229)	+= 0x80000000
+
+#
 # Philips Nino
 #
 core-$(CONFIG_NINO)		+= arch/mips/philips/nino/
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/defconfig-tb0229 linux/arch/mips/defconfig-tb0229
--- linux.orig/arch/mips/defconfig-tb0229	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/defconfig-tb0229	Tue May 20 16:51:13 2003
@@ -0,0 +1,624 @@
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
+# General setup
+#
+CONFIG_NET=y
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_ACER_PICA_61 is not set
+CONFIG_PCI_AUTO=y
+# CONFIG_BAGET_MIPS is not set
+# CONFIG_CASIO_E55 is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_LASAT is not set
+# CONFIG_HP_LASERJET is not set
+# CONFIG_IBM_WORKPAD is not set
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
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SOC_AU1X00 is not set
+# CONFIG_SIBYTE_SB1xxx_SOC is not set
+CONFIG_PCI=y
+# CONFIG_SNI_RM200_PCI is not set
+# CONFIG_TANBAC_TB0226 is not set
+CONFIG_TANBAC_TB0229=y
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+# CONFIG_VICTOR_MPC30X is not set
+# CONFIG_ZAO_CAPCELLA is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_NONCOHERENT_IO=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_VR41XX_TIME_C=y
+CONFIG_DUMMY_KEYB=y
+CONFIG_VR41XX_COMMON=y
+CONFIG_NEW_PCI=y
+# CONFIG_FB is not set
+CONFIG_TANBAC_TB0219=y
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
+CONFIG_CPU_HAS_SYNC=y
+# CONFIG_PREEMPT is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_PCI_NAMES=y
+CONFIG_MMU=y
+CONFIG_SWAP=y
+# CONFIG_HOTPLUG is not set
+
+#
+# Executable file formats
+#
+CONFIG_KCORE_ELF=y
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
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
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_NETLINK_DEV=m
+# CONFIG_NETFILTER is not set
+CONFIG_FILTER=y
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_NAT=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_TOS=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_ROUTE_LARGE_TABLES=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+CONFIG_NET_IPIP=m
+CONFIG_NET_IPGRE=m
+# CONFIG_NET_IPGRE_BROADCAST is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_INET_ECN is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_IPV6 is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IPV6_SCTP__=y
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_LLC is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
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
+# Network device support
+#
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+CONFIG_DUMMY=m
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_ETHERTAP is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+CONFIG_NET_VENDOR_3COM=y
+CONFIG_VORTEX=y
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_TC35815 is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+CONFIG_8139CP=y
+CONFIG_8139TOO=y
+# CONFIG_8139TOO_PIO is not set
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
+# CONFIG_NET_POCKET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+CONFIG_ACENIC=m
+# CONFIG_ACENIC_OMIT_TIGON_I is not set
+CONFIG_DL2K=m
+CONFIG_E1000=m
+# CONFIG_E1000_NAPI is not set
+CONFIG_NS83820=m
+CONFIG_HAMACHI=m
+CONFIG_YELLOWFIN=m
+CONFIG_SK98LIN=m
+CONFIG_TIGON3=m
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPPOE=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLIP_SMART=y
+CONFIG_SLIP_MODE_SLIP6=y
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
+# CONFIG_ISDN_BOOL is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=m
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+# CONFIG_VT_CONSOLE is not set
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
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
+# CONFIG_QIC02_TAPE is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
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
+# CONFIG_RAW_DRIVER is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# File systems
+#
+# CONFIG_QUOTA is not set
+CONFIG_QUOTACTL=y
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+# CONFIG_EFS_FS is not set
+CONFIG_CRAMFS=m
+CONFIG_TMPFS=y
+CONFIG_RAMFS=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_JFS_FS=m
+# CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_NTFS_FS is not set
+# CONFIG_HPFS_FS is not set
+CONFIG_PROC_FS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_QNX4FS_FS is not set
+CONFIG_ROMFS_FS=m
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UDF_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_XFS_FS=y
+# CONFIG_XFS_RT is not set
+CONFIG_XFS_QUOTA=y
+CONFIG_XFS_POSIX_ACL=y
+
+#
+# Network File Systems
+#
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+CONFIG_NFSD_TCP=y
+CONFIG_SUNRPC=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+# CONFIG_CIFS is not set
+CONFIG_SMB_FS=m
+CONFIG_SMB_NLS_DEFAULT=y
+CONFIG_SMB_NLS_REMOTE="cp932"
+# CONFIG_NCP_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_ZISOFS_FS=y
+CONFIG_FS_MBCACHE=y
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_SMB_NLS=y
+CONFIG_NLS=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+CONFIG_NLS_CODEPAGE_932=m
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
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
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BT is not set
+
+#
+# Kernel hacking
+#
+CONFIG_CROSSCOMPILE=y
+# CONFIG_DEBUG_KERNEL is not set
+
+#
+# Security options
+#
+CONFIG_SECURITY_CAPABILITIES=y
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC32 is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=m
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux.orig/arch/mips/kernel/setup.c	Wed May  7 12:09:14 2003
+++ linux/arch/mips/kernel/setup.c	Tue May 20 16:01:11 2003
@@ -611,6 +611,11 @@
 			casio_e55_setup();
 			break;
 #endif
+#ifdef CONFIG_TANBAC_TB0229
+		case MACH_TANBAC_TB0229:
+			tanbac_tb0229_setup();
+			break;
+#endif
 		}
 		break;
 #endif
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	Tue May 20 16:01:11 2003
@@ -0,0 +1,7 @@
+#
+# Makefile for the TANBAC TB0229(VR4131DIMM) specific parts of the kernel
+#
+
+obj-y	:= init.o reboot.o setup.o
+
+obj-$(CONFIG_PCI)	+= pci_fixup.o
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/init.c linux/arch/mips/vr41xx/tanbac-tb0229/init.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/init.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/init.c	Tue May 20 21:52:11 2003
@@ -0,0 +1,69 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/init.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Initialisation code for the TANBAC TB0229(VR4131DIMM)
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ * Modified for TANBAC TB0229:
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
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
+	return "TANBAC TB0229";
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
+	mips_machtype = MACH_TANBAC_TB0229;
+
+	switch (current_cpu_data.processor_id) {
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
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c linux/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c	Tue May 20 16:01:11 2003
@@ -0,0 +1,71 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	The TANBAC TB0229(VR4131DIMM) specific PCI fixups.
+ *
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
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
+#include <asm/vr41xx/tb0229.h>
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
+#ifdef CONFIG_TANBAC_TB0219
+	struct pci_dev *dev;
+	u8 slot;
+
+	pci_for_each_dev(dev) {
+		slot = PCI_SLOT(dev->devfn);
+		dev->irq = 0;
+
+		switch (slot) {
+		case 12:
+			vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN , TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN, LEVEL_LOW);
+			dev->irq = TB0219_PCI_SLOT1_IRQ;
+			break;
+		case 13:
+			vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN , TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN, LEVEL_LOW);
+			dev->irq = TB0219_PCI_SLOT2_IRQ;
+			break;
+		case 14:
+			vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN , TRIGGER_LEVEL,
+			                       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, LEVEL_LOW);
+			dev->irq = TB0219_PCI_SLOT3_IRQ;
+			break;
+		default:
+			break;
+		}
+
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+#endif
+}
+
+unsigned int pcibios_assign_all_busses(void)
+{
+	return 0;
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Tue May 20 16:01:11 2003
@@ -0,0 +1,30 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/reboot.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Depending on TANBAC TB0229(VR4131DIMM) of reboot system call.
+ *
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <asm/io.h>
+#include <asm/vr41xx/tb0229.h>
+
+#define tb0229_hard_reset()	writew(0, TB0219_RESET_REGS)
+
+void tanbac_tb0229_restart(char *command)
+{
+#ifdef CONFIG_TANBAC_TB0219
+	local_irq_disable();
+	tb0229_hard_reset();
+	while (1);
+#else
+	vr41xx_restart(command);
+#endif
+}
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Tue May 20 17:32:44 2003
@@ -0,0 +1,127 @@
+/*
+ * FILE NAME
+ *	arch/mips/vr41xx/tanbac-tb0229/setup.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Setup for the TANBAC TB0229 (VR4131DIMM)
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ * Modified for TANBAC TB0229:
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/blk.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/root_dev.h>
+
+#include <asm/pci_channel.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/vr41xx/tb0229.h>
+
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void * __rd_start, * __rd_end;
+#endif
+
+#ifdef CONFIG_PCI
+static struct resource vr41xx_pci_io_resource = {
+	.name	= "PCI I/O space",
+	.start	= VR41XX_PCI_IO_START,
+	.end	= VR41XX_PCI_IO_END,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct resource vr41xx_pci_mem_resource = {
+	.name	= "PCI memory space",
+	.start	= VR41XX_PCI_MEM_START,
+	.end	= VR41XX_PCI_MEM_END,
+	.flags	= IORESOURCE_MEM,
+};
+
+extern struct pci_ops vr41xx_pci_ops;
+
+struct pci_channel mips_pci_channels[] = {
+	{	.pci_ops	= &vr41xx_pci_ops,
+		.io_resource	= &vr41xx_pci_io_resource,
+		.mem_resource	= &vr41xx_pci_mem_resource,
+		.first_devfn	= 0,
+		.last_devfn	= 256,	},
+	{	.pci_ops	= NULL,
+		.io_resource	= NULL,
+		.mem_resource	= NULL,
+		.first_devfn	= 0,
+		.last_devfn	= 0,	}
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
+	.internal_base	= VR41XX_PCI_MEM1_BASE,
+	.address_mask	= VR41XX_PCI_MEM1_MASK,
+	.pci_base	= IO_MEM1_RESOURCE_START,
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
+	.internal_base	= VR41XX_PCI_MEM2_BASE,
+	.address_mask	= VR41XX_PCI_MEM2_MASK,
+	.pci_base	= IO_MEM2_RESOURCE_START,
+};
+
+struct vr41xx_pci_address_space vr41xx_pci_io = {
+	.internal_base	= VR41XX_PCI_IO_BASE,
+	.address_mask	= VR41XX_PCI_IO_MASK,
+	.pci_base	= IO_PORT_RESOURCE_START
+};
+
+static struct vr41xx_pci_address_map pci_address_map = {
+	.mem1	= &vr41xx_pci_mem1,
+	.mem2	= &vr41xx_pci_mem2,
+	.io	= &vr41xx_pci_io,
+};
+#endif
+
+void __init tanbac_tb0229_setup(void)
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
+	_machine_restart = tanbac_tb0229_restart;
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
+	vr41xx_dsiu_init();
+
+#ifdef CONFIG_PCI
+	vr41xx_pciu_init(&pci_address_map);
+#endif
+}
+
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux.orig/include/asm-mips/bootinfo.h	Wed May  7 12:09:15 2003
+++ linux/include/asm-mips/bootinfo.h	Tue May 20 16:01:11 2003
@@ -184,6 +184,7 @@
 #define MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
 #define MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
 #define MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (Mbase) */
+#define MACH_TANBAC_TB0229	7	/* TANBAC TB0229 (VR4131DIMM) */
 
 #define CL_SIZE			(256)
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/tb0229.h linux/include/asm-mips/vr41xx/tb0229.h
--- linux.orig/include/asm-mips/vr41xx/tb0229.h	Thu Jan  1 09:00:00 1970
+++ linux/include/asm-mips/vr41xx/tb0229.h	Tue May 20 16:01:11 2003
@@ -0,0 +1,73 @@
+/*
+ * FILE NAME
+ *	include/asm-mips/vr41xx/tb0229.h
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Include file for TANBAC TB0229 and TB0219.
+ *
+ * Copyright 2002,2003 Yoichi Yuasa
+ *                yuasa@hh.iij4u.or.jp
+ *
+ * Modified for TANBAC TB0229:
+ * Copyright 2003 Megasolution Inc.
+ *                matsu@megasolution.jp
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+#ifndef __TANBAC_TB0229_H
+#define __TANBAC_TB0229_H
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
+#define TB0219_PCI_SLOT1_PIN		2
+#define TB0219_PCI_SLOT2_PIN		3
+#define TB0219_PCI_SLOT3_PIN		4
+
+/*
+ * Interrupt Number
+ */
+#define TB0219_PCI_SLOT1_IRQ		GIU_IRQ(TB0219_PCI_SLOT1_PIN)
+#define TB0219_PCI_SLOT2_IRQ		GIU_IRQ(TB0219_PCI_SLOT2_PIN)
+#define TB0219_PCI_SLOT3_IRQ		GIU_IRQ(TB0219_PCI_SLOT3_PIN)
+
+#define TB0219_RESET_REGS		KSEG1ADDR(0x0a00000e)
+
+extern void tanbac_tb0229_restart(char *command);
+
+#endif /* __TANBAC_TB0229_H */


--Multipart_Tue__20_May_2003_22:41:45_+0900_08458450--
