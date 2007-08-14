Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 12:39:14 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:19989 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022404AbXHNLhl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2007 12:37:41 +0100
Received: by mo.po.2iij.net (mo31) id l7EBbcD4099839; Tue, 14 Aug 2007 20:37:38 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l7EBbaJb014831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Aug 2007 20:37:36 +0900
Date:	Tue, 14 Aug 2007 20:34:52 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update workpad_defconfig
Message-Id: <20070814203452.0a3cacaf.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Update workpad_defconfig

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/workpad_defconfig mips/arch/mips/configs/workpad_defconfig
--- mips-orig/arch/mips/configs/workpad_defconfig	2007-08-09 10:04:28.278961000 +0900
+++ mips/arch/mips/configs/workpad_defconfig	2007-08-09 14:34:04.654444000 +0900
@@ -1,60 +1,47 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:42 2007
+# Linux kernel version: 2.6.23-rc2
+# Thu Aug  9 14:33:57 2007
 #
 CONFIG_MIPS=y
 
 #
 # Machine selection
 #
-CONFIG_ZONE_DMA=y
-# CONFIG_MIPS_MTX1 is not set
-# CONFIG_MIPS_BOSPORUS is not set
-# CONFIG_MIPS_PB1000 is not set
-# CONFIG_MIPS_PB1100 is not set
-# CONFIG_MIPS_PB1500 is not set
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SEAD is not set
-# CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
-# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_MARKEINS is not set
+CONFIG_MACH_VR41XX=y
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
-CONFIG_MACH_VR41XX=y
+# CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_QEMU is not set
-# CONFIG_MARKEINS is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_BIGSUR is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
 # CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
 # CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_CARMEL is not set
 # CONFIG_SIBYTE_PTSWARM is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
-# CONFIG_SIBYTE_CRHINE is not set
-# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
 # CONFIG_TOSHIBA_JMR3927 is not set
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_WR_PPMC is not set
 # CONFIG_CASIO_E55 is not set
 CONFIG_IBM_WORKPAD=y
 # CONFIG_NEC_CMBVR4133 is not set
@@ -72,6 +59,8 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
+# CONFIG_NO_IOPORT is not set
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
@@ -81,6 +70,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -102,7 +92,6 @@ CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_SB1 is not set
 CONFIG_SYS_HAS_CPU_VR41XX=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
@@ -118,7 +107,6 @@ CONFIG_PAGE_SIZE_4KB=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -132,48 +120,47 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
-# CONFIG_HZ_250 is not set
+CONFIG_HZ_250=y
 # CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
+# CONFIG_HZ_1000 is not set
 # CONFIG_HZ_1024 is not set
 CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
+CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_KEXEC is not set
+CONFIG_SECCOMP=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
@@ -186,32 +173,30 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -229,6 +214,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_ISA=y
 CONFIG_MMU=y
 
@@ -250,10 +236,6 @@ CONFIG_PCMCIA_PROBE=y
 CONFIG_PCMCIA_VRC4171=y
 
 #
-# PCI Hotplug Support
-#
-
-#
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
@@ -263,10 +245,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_PM is not set
 
 #
 # Networking
@@ -276,7 +255,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -301,34 +279,25 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 CONFIG_NETWORK_SECMARK=y
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+# CONFIG_SCTP_HMAC_MD5 is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -354,8 +323,17 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
 CONFIG_WIRELESS_EXT=y
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -368,31 +346,11 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
 # CONFIG_PNP is not set
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -400,17 +358,9 @@ CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_MISC_DEVICES is not set
 CONFIG_IDE=y
 CONFIG_IDE_MAX_HWIFS=4
 CONFIG_BLK_DEV_IDE=y
@@ -426,15 +376,16 @@ CONFIG_BLK_DEV_IDECS=m
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_IDE_ARM is not set
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -442,135 +393,38 @@ CONFIG_IDE_GENERIC=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 # CONFIG_ATA is not set
-
-#
-# Old CD-ROM drivers (not SCSI, not IDE)
-#
-# CONFIG_CD_NO_IDESCSI is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
-CONFIG_PHYLIB=m
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-# CONFIG_BROADCOM_PHY is not set
-# CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
+# CONFIG_NET_ETHERNET is not set
 CONFIG_MII=m
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_SMC is not set
-# CONFIG_DM9000 is not set
-# CONFIG_NET_VENDOR_RACAL is not set
-# CONFIG_AT1700 is not set
-# CONFIG_DEPCA is not set
-# CONFIG_HP100 is not set
-# CONFIG_NET_ISA is not set
-# CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-CONFIG_NET_RADIO=y
-# CONFIG_NET_WIRELESS_RTNETLINK is not set
-
-#
-# Obsolete Wireless cards support (pre-802.11)
-#
-# CONFIG_STRIP is not set
-# CONFIG_ARLAN is not set
-# CONFIG_WAVELAN is not set
-# CONFIG_PCMCIA_WAVELAN is not set
-# CONFIG_PCMCIA_NETWAVE is not set
-
-#
-# Wireless 802.11 Frequency Hopping cards support
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+CONFIG_WLAN_80211=y
 # CONFIG_PCMCIA_RAYCS is not set
-
-#
-# Wireless 802.11b ISA/PCI cards support
-#
+# CONFIG_LIBERTAS is not set
 CONFIG_HERMES=m
 # CONFIG_ATMEL is not set
-
-#
-# Wireless 802.11b Pcmcia/Cardbus cards support
-#
 CONFIG_PCMCIA_HERMES=m
 # CONFIG_PCMCIA_SPECTRUM is not set
 # CONFIG_AIRO_CS is not set
 # CONFIG_PCMCIA_WL3501 is not set
 # CONFIG_HOSTAP is not set
-CONFIG_NET_WIRELESS=y
-
-#
-# PCMCIA network device support
-#
 CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_3C589=m
 CONFIG_PCMCIA_3C574=m
@@ -580,10 +434,6 @@ CONFIG_PCMCIA_NMCLAN=m
 CONFIG_PCMCIA_SMC91C92=m
 CONFIG_PCMCIA_XIRC2PS=m
 CONFIG_PCMCIA_AXNET=m
-
-#
-# Wan interfaces
-#
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -591,15 +441,7 @@ CONFIG_PCMCIA_AXNET=m
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -607,6 +449,7 @@ CONFIG_PCMCIA_AXNET=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -623,6 +466,7 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -656,19 +500,10 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
@@ -678,17 +513,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
-# CONFIG_GPIO_VR41XX is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -696,32 +524,33 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
 
 #
-# Hardware Monitoring support
+# Multifunction device drivers
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_MFD_SM501 is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 
 #
@@ -730,65 +559,51 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
-
-#
-# USB support
-#
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-#
-
-#
-# USB Gadget Support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
+# CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
 
 #
-# LED drivers
-#
-
-#
-# LED Triggers
+# RTC interfaces
 #
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
 
 #
-# InfiniBand support
+# SPI RTC drivers
 #
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+# Platform RTC drivers
 #
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Real Time Clock
+# on-CPU RTC drivers
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_DRV_VR41XX=y
 
 #
 # DMA Engine support
@@ -804,23 +619,25 @@ CONFIG_HID=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
+# Userspace I/O
 #
+# CONFIG_UIO is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
 # CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -836,7 +653,7 @@ CONFIG_INOTIFY_USER=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
-CONFIG_FUSE_FS=m
+# CONFIG_FUSE_FS is not set
 CONFIG_GENERIC_ACL=y
 
 #
@@ -863,7 +680,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -885,17 +702,22 @@ CONFIG_CONFIGFS_FS=m
 #
 # Network File Systems
 #
-CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_FS=m
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=y
-# CONFIG_NFSD_V3 is not set
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+# CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
-CONFIG_LOCKD=y
-CONFIG_EXPORTFS=y
+CONFIG_LOCKD=m
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
 CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=y
+CONFIG_SUNRPC=m
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -903,7 +725,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -919,10 +740,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Distributed Lock Manager
 #
-CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
+# CONFIG_DLM is not set
 
 #
 # Profiling support
@@ -940,7 +758,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x170,0x376,49 mem=16M"
 
@@ -949,52 +766,7 @@ CONFIG_CMDLINE="console=ttyVR0,19200 ide
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=m
-CONFIG_CRYPTO_MANAGER=m
-CONFIG_CRYPTO_HMAC=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_TWOFISH_COMMON=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-CONFIG_CRYPTO_CAMELLIA=m
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+# CONFIG_CRYPTO is not set
 
 #
 # Library routines
@@ -1002,10 +774,11 @@ CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
