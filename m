Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 12:40:42 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:33594 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022478AbXHNLj1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2007 12:39:27 +0100
Received: by mo.po.2iij.net (mo30) id l7EBbVVQ098942; Tue, 14 Aug 2007 20:37:31 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l7EBbSlP014735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Aug 2007 20:37:29 +0900
Date:	Tue, 14 Aug 2007 20:27:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update capcella_defconfig
Message-Id: <20070814202747.067324bc.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Update capcella_defconfig

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/capcella_defconfig mips/arch/mips/configs/capcella_defconfig
--- mips-orig/arch/mips/configs/capcella_defconfig	2007-08-08 09:53:50.642944250 +0900
+++ mips/arch/mips/configs/capcella_defconfig	2007-08-08 10:23:25.309100500 +0900
@@ -1,60 +1,47 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:22 2007
+# Linux kernel version: 2.6.23-rc2
+# Wed Aug  8 10:23:16 2007
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
 # CONFIG_IBM_WORKPAD is not set
 # CONFIG_NEC_CMBVR4133 is not set
@@ -73,6 +60,8 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
+# CONFIG_NO_IOPORT is not set
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
@@ -82,6 +71,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -103,7 +93,6 @@ CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_SB1 is not set
 CONFIG_SYS_HAS_CPU_VR41XX=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
@@ -119,7 +108,6 @@ CONFIG_PAGE_SIZE_4KB=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -133,48 +121,47 @@ CONFIG_FLAT_NODE_MEM_MAP=y
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
@@ -187,32 +174,30 @@ CONFIG_BUG=y
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
@@ -232,16 +217,13 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 
 #
@@ -254,10 +236,7 @@ CONFIG_TRAD_SIGNALS=y
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
@@ -267,7 +246,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -309,20 +287,13 @@ CONFIG_TCP_MD5SIG=y
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
-# CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
+CONFIG_IP_SCTP=m
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -348,7 +319,17 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -361,30 +342,10 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
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
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -397,19 +358,9 @@ CONFIG_BLK_DEV_RAM=y
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
-CONFIG_SGI_IOC4=m
-# CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_MISC_DEVICES is not set
 CONFIG_IDE=y
 CONFIG_IDE_MAX_HWIFS=4
 CONFIG_BLK_DEV_IDE=y
@@ -424,15 +375,16 @@ CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -440,16 +392,9 @@ CONFIG_IDE_GENERIC=y
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
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
 
 #
@@ -460,30 +405,17 @@ CONFIG_IDE_GENERIC=y
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
-
-#
-# I2O device support
-#
 # CONFIG_I2O is not set
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
 CONFIG_PHYLIB=m
 
 #
@@ -497,22 +429,16 @@ CONFIG_CICADA_PHY=m
 CONFIG_VITESSE_PHY=m
 CONFIG_SMSC_PHY=m
 # CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_DM9000 is not set
-
-#
-# Tulip family network device support
-#
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_NET_PCI=y
@@ -521,6 +447,7 @@ CONFIG_NET_PCI=y
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
+# CONFIG_TC35815 is not set
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
@@ -539,50 +466,15 @@ CONFIG_8139TOO_PIO=y
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
 # CONFIG_SC92031 is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
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
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -592,15 +484,7 @@ CONFIG_NETXEN_NIC=m
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
@@ -608,6 +492,7 @@ CONFIG_NETXEN_NIC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -624,6 +509,7 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -658,34 +544,17 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
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
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_DRM is not set
 CONFIG_GPIO_VR41XX=y
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
@@ -693,32 +562,33 @@ CONFIG_GPIO_VR41XX=y
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
@@ -726,65 +596,16 @@ CONFIG_GPIO_VR41XX=y
 #
 # CONFIG_VGA_CONSOLE is not set
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
-# CONFIG_HID is not set
-
-#
-# USB support
-#
-CONFIG_USB_ARCH_HAS_HCD=y
-CONFIG_USB_ARCH_HAS_OHCI=y
-CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
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
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
 # CONFIG_INFINIBAND is not set
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -798,18 +619,29 @@ CONFIG_RTC_INTF_SYSFS=y
 CONFIG_RTC_INTF_PROC=y
 CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# SPI RTC drivers
+#
 
 #
-# RTC drivers
+# Platform RTC drivers
 #
+# CONFIG_RTC_DRV_CMOS is not set
 # CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
-CONFIG_RTC_DRV_VR41XX=y
-# CONFIG_RTC_DRV_TEST is not set
+# CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_VR41XX=y
+
+#
 # DMA Engine support
 #
 # CONFIG_DMA_ENGINE is not set
@@ -823,12 +655,9 @@ CONFIG_RTC_DRV_VR41XX=y
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
@@ -836,8 +665,14 @@ CONFIG_RTC_DRV_VR41XX=y
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
@@ -852,7 +687,7 @@ CONFIG_INOTIFY_USER=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
-CONFIG_FUSE_FS=m
+# CONFIG_FUSE_FS is not set
 CONFIG_GENERIC_ACL=y
 
 #
@@ -879,7 +714,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -905,14 +740,12 @@ CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=y
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
+# CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -920,7 +753,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -936,10 +768,7 @@ CONFIG_MSDOS_PARTITION=y
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
@@ -957,7 +786,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
 
@@ -966,10 +794,6 @@ CONFIG_CMDLINE="mem=32M console=ttyVR0,3
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=m
@@ -990,6 +814,7 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_LRW=m
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -1008,10 +833,7 @@ CONFIG_CRYPTO_MICHAEL_MIC=m
 # CONFIG_CRYPTO_CRC32C is not set
 CONFIG_CRYPTO_CAMELLIA=m
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+# CONFIG_CRYPTO_HW is not set
 
 #
 # Library routines
@@ -1019,10 +841,13 @@ CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
