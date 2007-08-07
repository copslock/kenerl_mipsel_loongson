Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 15:21:46 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:63243 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024257AbXHGOVn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 15:21:43 +0100
Received: by mo.po.2iij.net (mo30) id l77EKOBo047967; Tue, 7 Aug 2007 23:20:24 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox300) id l77EKLJt017227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Aug 2007 23:20:22 +0900
Date:	Tue, 7 Aug 2007 23:20:21 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS] update Cobalt defconfig
Message-Id: <20070807232021.2c3b9329.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070807120701.GA22096@linux-mips.org>
References: <20070807120701.GA22096@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Update Cobalt defconfig

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/cobalt_defconfig mips/arch/mips/configs/cobalt_defconfig
--- mips-orig/arch/mips/configs/cobalt_defconfig	2007-08-07 20:52:36.167685000 +0900
+++ mips/arch/mips/configs/cobalt_defconfig	2007-08-07 22:13:35.306426500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc2
-# Fri May 25 11:17:29 2007
+# Linux kernel version: 2.6.23-rc2
+# Tue Aug  7 22:12:54 2007
 #
 CONFIG_MIPS=y
 
@@ -13,33 +13,35 @@ CONFIG_MIPS=y
 CONFIG_MIPS_COBALT=y
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SEAD is not set
-# CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
+# CONFIG_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
-# CONFIG_MACH_VR41XX is not set
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
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -54,6 +56,7 @@ CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
 CONFIG_I8259=y
+# CONFIG_NO_IOPORT is not set
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
@@ -64,6 +67,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -101,7 +105,6 @@ CONFIG_PAGE_SIZE_4KB=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -117,43 +120,40 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
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
 CONFIG_LOG_BUF_SHIFT=14
@@ -185,19 +185,17 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
-# CONFIG_MODULES is not set
-
-#
-# Block layer
-#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -236,10 +234,7 @@ CONFIG_TRAD_SIGNALS=y
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
@@ -286,20 +281,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
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
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -335,6 +318,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -347,12 +331,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=y
-CONFIG_PROC_EVENTS=y
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 # CONFIG_MTD_CONCAT is not set
@@ -430,20 +409,8 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=0
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
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
@@ -453,17 +420,11 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-# CONFIG_PHANTOM is not set
-# CONFIG_SGI_IOC4 is not set
-# CONFIG_TIFM_CORE is not set
-# CONFIG_BLINK is not set
+# CONFIG_MISC_DEVICES is not set
 # CONFIG_IDE is not set
 
 #
@@ -471,6 +432,7 @@ CONFIG_BLK_DEV_LOOP=y
 #
 CONFIG_RAID_ATTRS=y
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
@@ -492,6 +454,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -499,45 +462,8 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
-# CONFIG_SCSI_3W_9XXX is not set
-# CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AACRAID is not set
-# CONFIG_SCSI_AIC7XXX is not set
-# CONFIG_SCSI_AIC7XXX_OLD is not set
-# CONFIG_SCSI_AIC79XX is not set
-# CONFIG_SCSI_AIC94XX is not set
-# CONFIG_SCSI_DPT_I2O is not set
-# CONFIG_SCSI_ARCMSR is not set
-# CONFIG_MEGARAID_NEWGEN is not set
-# CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_DMX3191D is not set
-# CONFIG_SCSI_FUTURE_DOMAIN is not set
-# CONFIG_SCSI_IPS is not set
-# CONFIG_SCSI_INITIO is not set
-# CONFIG_SCSI_INIA100 is not set
-# CONFIG_SCSI_STEX is not set
-# CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_1280 is not set
-# CONFIG_SCSI_QLA_FC is not set
-# CONFIG_SCSI_QLA_ISCSI is not set
-# CONFIG_SCSI_LPFC is not set
-# CONFIG_SCSI_DC395x is not set
-# CONFIG_SCSI_DC390T is not set
-# CONFIG_SCSI_NSP32 is not set
-# CONFIG_SCSI_DEBUG is not set
-# CONFIG_SCSI_ESP_CORE is not set
-# CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
@@ -593,10 +519,6 @@ CONFIG_ATA=y
 CONFIG_PATA_VIA=y
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
 
 #
@@ -612,41 +534,24 @@ CONFIG_PATA_VIA=y
 #
 # CONFIG_FIREWIRE is not set
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
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 # CONFIG_MII is not set
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
 CONFIG_NET_TULIP=y
 CONFIG_DE2104X=y
 CONFIG_TULIP=y
@@ -661,10 +566,6 @@ CONFIG_TULIP=y
 # CONFIG_NET_PCI is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
-
-#
-# Token Ring devices
-#
 # CONFIG_TR is not set
 
 #
@@ -672,6 +573,16 @@ CONFIG_TULIP=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -682,15 +593,7 @@ CONFIG_TULIP=y
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
@@ -698,6 +601,7 @@ CONFIG_TULIP=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+CONFIG_INPUT_POLLDEV=y
 
 #
 # Userland interfaces
@@ -705,7 +609,7 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
@@ -725,7 +629,6 @@ CONFIG_INPUT_COBALT_BTNS=y
 # CONFIG_INPUT_POWERMATE is not set
 # CONFIG_INPUT_YEALINK is not set
 # CONFIG_INPUT_UINPUT is not set
-CONFIG_INPUT_POLLDEV=y
 
 #
 # Hardware I/O ports
@@ -761,24 +664,15 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
 CONFIG_COBALT_LCD=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
@@ -788,11 +682,8 @@ CONFIG_DEVPORT=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 
 #
@@ -817,6 +708,7 @@ CONFIG_DEVPORT=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 
 #
@@ -829,55 +721,131 @@ CONFIG_DUMMY_CONSOLE=y
 # Sound
 #
 # CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=m
+# CONFIG_HID_DEBUG is not set
 
 #
-# HID Devices
+# USB Input Devices
 #
-# CONFIG_HID is not set
+CONFIG_USB_HID=m
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
 
 #
-# USB support
+# USB HID Boot Protocol drivers
 #
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=m
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=m
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# USB Gadget Support
+# may also be needed; see USB_STORAGE Help for more information
 #
-# CONFIG_USB_GADGET is not set
-# CONFIG_MMC is not set
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED devices
+# USB Imaging devices
 #
-# CONFIG_NEW_LEDS is not set
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+CONFIG_USB_MON=y
 
 #
-# LED drivers
+# USB port drivers
 #
 
 #
-# LED Triggers
+# USB Serial Converter support
 #
+# CONFIG_USB_SERIAL is not set
 
 #
-# InfiniBand support
+# USB Miscellaneous drivers
 #
-# CONFIG_INFINIBAND is not set
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+# USB DSL modem support
 #
 
 #
-# Real Time Clock
+# USB Gadget Support
 #
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -894,10 +862,6 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_TEST is not set
 
 #
-# I2C RTC drivers
-#
-
-#
 # SPI RTC drivers
 #
 
@@ -906,8 +870,10 @@ CONFIG_RTC_INTF_DEV=y
 #
 CONFIG_RTC_DRV_CMOS=y
 # CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -928,6 +894,11 @@ CONFIG_RTC_DRV_CMOS=y
 #
 
 #
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1032,7 +1003,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1074,10 +1044,6 @@ CONFIG_CMDLINE=""
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
@@ -1088,6 +1054,7 @@ CONFIG_BITREVERSE=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
