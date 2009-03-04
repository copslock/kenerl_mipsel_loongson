Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 14:45:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:24567 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365443AbZCDOpw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2009 14:45:52 +0000
Received: from localhost.localdomain (p2109-ipad305funabasi.chiba.ocn.ne.jp [123.217.164.109])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 57693AB56; Wed,  4 Mar 2009 23:45:44 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: update defconfigs
Date:	Wed,  4 Mar 2009 23:45:44 +0900
Message-Id: <1236177944-24243-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Enable following features:
* MTD (PHYSMAP)
* LED (LEDS_GPIO)
* RBTX4939
* 7SEGLED
* IDE (IDE_TX4938, IDE_TX4939)
* SMC91X
* RTC_DRV_TX4939

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/configs/jmr3927_defconfig  |  265 ++++++++++++++++++++--------
 arch/mips/configs/rbtx49xx_defconfig |  319 +++++++++++++++++++++++++++-------
 2 files changed, 447 insertions(+), 137 deletions(-)

diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 9d5bd2a..5380f1f 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc9
-# Fri Jul 11 23:01:36 2008
+# Linux kernel version: 2.6.29-rc7
+# Wed Mar  4 23:07:16 2009
 #
 CONFIG_MIPS=y
 
@@ -18,8 +18,10 @@ CONFIG_MIPS=y
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
+# CONFIG_MACH_EMMA is not set
 # CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
@@ -39,7 +41,11 @@ CONFIG_MIPS=y
 # CONFIG_SNI_RM is not set
 CONFIG_MACH_TX39XX=y
 # CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
 # CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+CONFIG_MACH_TXX9=y
 CONFIG_TOSHIBA_JMR3927=y
 CONFIG_SOC_TX3927=y
 # CONFIG_TOSHIBA_FPCIB0 is not set
@@ -54,12 +60,14 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_CEVT_TXX9=y
 CONFIG_GPIO_TXX9=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
 # CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
@@ -87,6 +95,7 @@ CONFIG_CPU_TX39XX=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -94,6 +103,7 @@ CONFIG_CPU_TX39XX=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
 CONFIG_SYS_HAS_CPU_TX39XX=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
@@ -117,14 +127,12 @@ CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-# CONFIG_TICK_ONESHOT is not set
+CONFIG_UNEVICTABLE_LRU=y
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
@@ -159,6 +167,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
@@ -171,7 +188,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 # CONFIG_HOTPLUG is not set
@@ -188,26 +204,23 @@ CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
+CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
-# CONFIG_HAVE_KPROBES is not set
-# CONFIG_HAVE_KRETPROBES is not set
-# CONFIG_HAVE_DMA_ATTRS is not set
-CONFIG_PROC_PAGE_MONITOR=y
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_MODULES is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
@@ -221,7 +234,7 @@ CONFIG_IOSCHED_CFQ=y
 CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
-CONFIG_CLASSIC_RCU=y
+# CONFIG_FREEZER is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -231,12 +244,15 @@ CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_STUB is not set
 CONFIG_MMU=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
@@ -245,15 +261,12 @@ CONFIG_TRAD_SIGNALS=y
 #
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
 # Networking options
 #
+CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -293,6 +306,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 # CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
 
 #
 # Network testing
@@ -302,14 +316,9 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-
-#
-# Wireless
-#
-# CONFIG_CFG80211 is not set
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_PHONET is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 
 #
@@ -323,7 +332,89 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLKDEVS is not set
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
@@ -336,6 +427,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -361,7 +453,6 @@ CONFIG_HAVE_IDE=y
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
@@ -383,6 +474,9 @@ CONFIG_PHYLIB=y
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
 # CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -392,6 +486,7 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
@@ -399,6 +494,9 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
@@ -406,7 +504,6 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 CONFIG_TC35815=y
-# CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -415,9 +512,11 @@ CONFIG_TC35815=y
 # CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
+# CONFIG_SMSC9420 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
+# CONFIG_ATL2 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
@@ -428,6 +527,10 @@ CONFIG_TC35815=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_IWLWIFI_LEDS is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
@@ -440,27 +543,7 @@ CONFIG_TC35815=y
 #
 # Input device support
 #
-CONFIG_INPUT=y
-# CONFIG_INPUT_FF_MEMLESS is not set
-# CONFIG_INPUT_POLLDEV is not set
-
-#
-# Userland interfaces
-#
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input Device Drivers
-#
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+# CONFIG_INPUT is not set
 
 #
 # Hardware I/O ports
@@ -517,10 +600,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
-CONFIG_HAVE_GPIO_LIB=y
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
 
 #
-# GPIO Support
+# Memory mapped GPIO expanders:
 #
 
 #
@@ -528,6 +612,11 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 
 #
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_BT8XX is not set
+
+#
 # SPI GPIO expanders:
 #
 # CONFIG_W1 is not set
@@ -542,6 +631,7 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_ALIM7101_WDT is not set
 CONFIG_TXX9_WDT=y
 
 #
@@ -549,18 +639,21 @@ CONFIG_TXX9_WDT=y
 #
 # CONFIG_PCIPCWATCHDOG is not set
 # CONFIG_WDTPCI is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
 #
+# CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
@@ -591,16 +684,26 @@ CONFIG_SSB_POSSIBLE=y
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-
-#
-# Sound
-#
 # CONFIG_SOUND is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_GPIO=y
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
@@ -626,27 +729,34 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
 # CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
 CONFIG_RTC_DRV_DS1742=y
 # CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
 # on-CPU RTC drivers
 #
+# CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
 #
 # CONFIG_EXT2_FS is not set
 # CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
@@ -676,28 +786,17 @@ CONFIG_INOTIFY_USER=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
-# CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
@@ -726,7 +825,16 @@ CONFIG_FRAME_WARN=1024
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+
+#
+# Tracers
+#
+# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
 # CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_CMDLINE=""
 
 #
@@ -734,15 +842,18 @@ CONFIG_CMDLINE=""
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index 83d5c58..1efe977 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc9
-# Fri Jul 11 23:03:21 2008
+# Linux kernel version: 2.6.29-rc7
+# Wed Mar  4 23:08:06 2009
 #
 CONFIG_MIPS=y
 
@@ -18,8 +18,10 @@ CONFIG_MIPS=y
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
+# CONFIG_MACH_EMMA is not set
 # CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
@@ -39,20 +41,28 @@ CONFIG_MIPS=y
 # CONFIG_SNI_RM is not set
 # CONFIG_MACH_TX39XX is not set
 CONFIG_MACH_TX49XX=y
+# CONFIG_MIKROTIK_RB532 is not set
 # CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+CONFIG_MACH_TXX9=y
 CONFIG_TOSHIBA_RBTX4927=y
 CONFIG_TOSHIBA_RBTX4938=y
+CONFIG_TOSHIBA_RBTX4939=y
 CONFIG_SOC_TX4927=y
 CONFIG_SOC_TX4938=y
+CONFIG_SOC_TX4939=y
+CONFIG_TXX9_7SEGLED=y
 # CONFIG_TOSHIBA_FPCIB0 is not set
 CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
 
 #
 # Multiplex Pin Select
 #
-CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61=y
+# CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61 is not set
 # CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND is not set
 # CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA is not set
+CONFIG_TOSHIBA_RBTX4938_MPLEX_KEEP=y
 CONFIG_PCI_TX4927=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
@@ -64,14 +74,18 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
 CONFIG_CEVT_R4K=y
 CONFIG_CEVT_TXX9=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_CSRC_R4K=y
 CONFIG_GPIO_TXX9=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
 # CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
@@ -100,6 +114,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 CONFIG_CPU_TX49XX=y
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -107,6 +122,7 @@ CONFIG_CPU_TX49XX=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
 CONFIG_SYS_HAS_CPU_TX49XX=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
@@ -134,13 +150,12 @@ CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -176,6 +191,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -190,7 +214,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 # CONFIG_HOTPLUG is not set
@@ -207,30 +230,26 @@ CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
+CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
-# CONFIG_HAVE_KPROBES is not set
-# CONFIG_HAVE_KRETPROBES is not set
-# CONFIG_HAVE_DMA_ATTRS is not set
-CONFIG_PROC_PAGE_MONITOR=y
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 # CONFIG_MODULE_FORCE_LOAD is not set
-# CONFIG_MODULE_UNLOAD is not set
+CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
-CONFIG_KMOD=y
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
@@ -244,7 +263,8 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
+# CONFIG_PROBE_INITRD_HEADER is not set
+# CONFIG_FREEZER is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -254,12 +274,15 @@ CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCI_LEGACY is not set
+# CONFIG_PCI_STUB is not set
 CONFIG_MMU=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
@@ -268,15 +291,12 @@ CONFIG_TRAD_SIGNALS=y
 #
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
 # Networking options
 #
+CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -318,6 +338,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 # CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
 
 #
 # Network testing
@@ -327,14 +348,9 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-
-#
-# Wireless
-#
-# CONFIG_CFG80211 is not set
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_PHONET is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 
 #
@@ -348,7 +364,90 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLKDEVS is not set
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
@@ -365,9 +464,60 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
-# CONFIG_IDE is not set
+CONFIG_IDE=y
+
+#
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
+#
+CONFIG_IDE_TIMINGS=y
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+CONFIG_BLK_DEV_IDEDMA_SFF=y
+
+#
+# PCI IDE chipsets support
+#
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT8172 is not set
+# CONFIG_BLK_DEV_IT8213 is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_BLK_DEV_TC86C001 is not set
+CONFIG_BLK_DEV_IDE_TX4938=y
+CONFIG_BLK_DEV_IDE_TX4939=y
+CONFIG_BLK_DEV_IDEDMA=y
 
 #
 # SCSI device support
@@ -390,7 +540,6 @@ CONFIG_HAVE_IDE=y
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
@@ -412,15 +561,19 @@ CONFIG_PHYLIB=y
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
 # CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
 # CONFIG_AX88796 is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
+CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
@@ -429,6 +582,9 @@ CONFIG_NE2000=y
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
@@ -436,7 +592,6 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 CONFIG_TC35815=y
-# CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -445,9 +600,11 @@ CONFIG_TC35815=y
 # CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
+# CONFIG_SMSC9420 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
+# CONFIG_ATL2 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
@@ -458,6 +615,10 @@ CONFIG_TC35815=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_IWLWIFI_LEDS is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
@@ -502,6 +663,7 @@ CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_TXX9_STDSERIAL=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
@@ -517,17 +679,19 @@ CONFIG_SPI_MASTER=y
 #
 # SPI Master Controller Drivers
 #
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
 CONFIG_SPI_TXX9=y
 
 #
 # SPI Protocol Masters
 #
-CONFIG_EEPROM_AT25=y
 # CONFIG_SPI_TLE62X0 is not set
-CONFIG_HAVE_GPIO_LIB=y
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
 
 #
-# GPIO Support
+# Memory mapped GPIO expanders:
 #
 
 #
@@ -535,8 +699,14 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 
 #
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_BT8XX is not set
+
+#
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MAX7301 is not set
 # CONFIG_GPIO_MCP23S08 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
@@ -550,6 +720,7 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_ALIM7101_WDT is not set
 CONFIG_TXX9_WDT=m
 
 #
@@ -557,18 +728,21 @@ CONFIG_TXX9_WDT=m
 #
 # CONFIG_PCIPCWATCHDOG is not set
 # CONFIG_WDTPCI is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
 #
+# CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
@@ -599,15 +773,27 @@ CONFIG_SSB_POSSIBLE=y
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-
-#
-# Sound
-#
 # CONFIG_SOUND is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_GPIO=y
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
@@ -628,35 +814,47 @@ CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 #
 # SPI RTC drivers
 #
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
 # CONFIG_RTC_DRV_MAX6902 is not set
 # CONFIG_RTC_DRV_R9701 is not set
 CONFIG_RTC_DRV_RS5C348=y
+# CONFIG_RTC_DRV_DS3234 is not set
 
 #
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
 # CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
 CONFIG_RTC_DRV_DS1742=y
 # CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
 # on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_TX4939=y
+# CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
 #
 # CONFIG_EXT2_FS is not set
 # CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
+CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_DNOTIFY is not set
@@ -687,30 +885,19 @@ CONFIG_GENERIC_ACL=y
 CONFIG_PROC_FS=y
 # CONFIG_PROC_KCORE is not set
 CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
-# CONFIG_SYSV_FS is not set
-# CONFIG_UFS_FS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
-# CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
@@ -740,7 +927,16 @@ CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+
+#
+# Tracers
+#
+# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
 # CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_CMDLINE=""
 
 #
@@ -748,15 +944,18 @@ CONFIG_CMDLINE=""
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
-- 
1.5.6.3
