Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 13:39:04 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.28.14.163]:58378 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492735AbZKKMi5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 13:38:57 +0100
Received: from localhost.localdomain (p2107-ipad208funabasi.chiba.ocn.ne.jp [60.43.103.107])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0C85274FA; Wed, 11 Nov 2009 21:38:50 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: update rbtx49xx_defconfig
Date:	Wed, 11 Nov 2009 21:38:46 +0900
Message-Id: <1257943126-26776-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Enable following features:
* MTD (RBTX4939, NAND_TXX9NDFMC)
* HW_RANDOM (HW_RANDOM_TX4939)
* SOUND (SND_SOC_TXX9ACLC)
* DMADEVICE (TXX9_DMAC)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/configs/rbtx49xx_defconfig |  252 ++++++++++++++++++++++++++--------
 1 files changed, 192 insertions(+), 60 deletions(-)

diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index c69813b..6c6a19a 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc7
-# Wed Mar  4 23:08:06 2009
+# Linux kernel version: 2.6.32-rc6
+# Sun Nov  8 22:59:47 2009
 #
 CONFIG_MIPS=y
 
@@ -9,16 +9,18 @@ CONFIG_MIPS=y
 # Machine selection
 #
 # CONFIG_MACH_ALCHEMY is not set
+# CONFIG_AR7 is not set
 # CONFIG_BASLER_EXCITE is not set
 # CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
 # CONFIG_LASAT is not set
-# CONFIG_LEMOTE_FULONG is not set
+# CONFIG_MACH_LOONGSON is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MACH_EMMA is not set
+# CONFIG_NEC_MARKEINS is not set
 # CONFIG_MACH_VR41XX is not set
 # CONFIG_NXP_STB220 is not set
 # CONFIG_NXP_STB225 is not set
@@ -45,6 +47,7 @@ CONFIG_MACH_TX49XX=y
 # CONFIG_WR_PPMC is not set
 # CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
 # CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
 CONFIG_MACH_TXX9=y
 CONFIG_TOSHIBA_RBTX4927=y
 CONFIG_TOSHIBA_RBTX4938=y
@@ -86,7 +89,6 @@ CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
-# CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
 CONFIG_CPU_BIG_ENDIAN=y
@@ -101,7 +103,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
-# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_LOONGSON2E is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -137,6 +139,7 @@ CONFIG_32BIT=y
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
@@ -154,7 +157,10 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -175,6 +181,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -194,11 +201,12 @@ CONFIG_SYSVIPC_SYSCTL=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -209,8 +217,12 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
@@ -220,25 +232,35 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 # CONFIG_PCSPKR_PLATFORM is not set
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
-# CONFIG_FUTEX is not set
-CONFIG_ANON_INODES=y
+CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_PCI_QUIRKS=y
+CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
 CONFIG_HAVE_OPROFILE=y
-# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 # CONFIG_MODULE_FORCE_LOAD is not set
@@ -246,8 +268,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
@@ -274,6 +296,7 @@ CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
 
 #
@@ -288,6 +311,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 CONFIG_NET=y
@@ -295,7 +319,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -311,6 +334,7 @@ CONFIG_IP_PNP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -336,6 +360,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
+# CONFIG_PHONET is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -347,7 +372,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_PHONET is not set
 # CONFIG_WIRELESS is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
@@ -365,9 +389,9 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
-# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 CONFIG_MTD_CMDLINE_PARTS=y
 # CONFIG_MTD_AR7_PARTS is not set
@@ -376,9 +400,9 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
-# CONFIG_MTD_BLKDEVS is not set
-# CONFIG_MTD_BLOCK is not set
-# CONFIG_MTD_BLOCK_RO is not set
+CONFIG_MTD_BLKDEVS=m
+CONFIG_MTD_BLOCK=m
+CONFIG_MTD_BLOCK_RO=m
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
@@ -414,16 +438,20 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # Mapping drivers for chip access
 #
-# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 # CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_PCI is not set
+# CONFIG_MTD_GPIO_ADDR is not set
 # CONFIG_MTD_INTEL_VR_NOR is not set
+CONFIG_MTD_RBTX4939=y
 # CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
 #
 # CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SST25L is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -435,7 +463,15 @@ CONFIG_MTD_PHYSMAP=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-# CONFIG_MTD_NAND is not set
+CONFIG_MTD_NAND=m
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=m
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+CONFIG_MTD_NAND_TXX9NDFMC=m
 # CONFIG_MTD_ONENAND is not set
 
 #
@@ -471,6 +507,7 @@ CONFIG_IDE=y
 #
 # Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
+CONFIG_IDE_XFER_MODE=y
 CONFIG_IDE_TIMINGS=y
 # CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_IDE_GD=y
@@ -534,8 +571,13 @@ CONFIG_BLK_DEV_IDEDMA=y
 #
 
 #
-# A new alternative FireWire stack is available with EXPERIMENTAL=y
+# You can enable one or both FireWire driver stacks.
 #
+
+#
+# See the help texts for more information.
+#
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
@@ -574,6 +616,8 @@ CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_NE2000=y
@@ -602,18 +646,15 @@ CONFIG_TC35815=y
 # CONFIG_SMSC9420 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
+# CONFIG_KS8851_MLL is not set
 # CONFIG_VIA_RHINE is not set
 # CONFIG_ATL2 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
+# CONFIG_WLAN is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -653,6 +694,7 @@ CONFIG_DEVKMEM=y
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_TXX9=y
@@ -666,7 +708,9 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=m
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
+CONFIG_HW_RANDOM_TX4939=m
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -686,6 +730,10 @@ CONFIG_SPI_TXX9=y
 # SPI Protocol Masters
 #
 # CONFIG_SPI_TLE62X0 is not set
+
+#
+# PPS support
+#
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 
@@ -701,17 +749,22 @@ CONFIG_GPIOLIB=y
 # PCI GPIO expanders:
 #
 # CONFIG_GPIO_BT8XX is not set
+# CONFIG_GPIO_LANGWELL is not set
 
 #
 # SPI GPIO expanders:
 #
 # CONFIG_GPIO_MAX7301 is not set
 # CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
+
+#
+# AC97 GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
 
@@ -740,28 +793,17 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_UCB1400_CORE is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_EZX_PCAP is not set
 # CONFIG_REGULATOR is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-# CONFIG_DAB is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+# CONFIG_VGA_ARB is not set
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
@@ -772,7 +814,42 @@ CONFIG_SSB_POSSIBLE=y
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_SOUND is not set
+CONFIG_SOUND=m
+# CONFIG_SOUND_OSS_CORE is not set
+CONFIG_SND=m
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+# CONFIG_SND_HRTIMER is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+CONFIG_SND_VMASTER=y
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
+CONFIG_SND_AC97_CODEC=m
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_PCI is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_MIPS is not set
+CONFIG_SND_SOC=m
+CONFIG_SND_SOC_AC97_BUS=y
+CONFIG_SND_SOC_TXX9ACLC=m
+CONFIG_HAS_TXX9_ACLC=y
+CONFIG_SND_SOC_TXX9ACLC_AC97=m
+CONFIG_SND_SOC_TXX9ACLC_GENERIC=m
+CONFIG_SND_SOC_I2C_AND_SPI=m
+# CONFIG_SND_SOC_ALL_CODECS is not set
+CONFIG_SND_SOC_AC97_CODEC=m
+# CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=m
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
@@ -783,6 +860,8 @@ CONFIG_LEDS_CLASS=y
 # LED drivers
 #
 CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_GPIO_PLATFORM=y
+# CONFIG_LEDS_DAC124S085 is not set
 
 #
 # LED Triggers
@@ -792,7 +871,12 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_IDE_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_GPIO is not set
 # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
@@ -820,6 +904,7 @@ CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 # CONFIG_RTC_DRV_R9701 is not set
 CONFIG_RTC_DRV_RS5C348=y
 # CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
 
 #
 # Platform RTC drivers
@@ -840,8 +925,26 @@ CONFIG_RTC_DRV_DS1742=y
 # on-CPU RTC drivers
 #
 CONFIG_RTC_DRV_TX4939=y
-# CONFIG_DMADEVICES is not set
+CONFIG_DMADEVICES=y
+
+#
+# DMA Devices
+#
+CONFIG_TXX9_DMAC=m
+CONFIG_DMA_ENGINE=y
+
+#
+# DMA Clients
+#
+# CONFIG_NET_DMA is not set
+# CONFIG_ASYNC_TX_DMA is not set
+# CONFIG_DMATEST is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -853,9 +956,10 @@ CONFIG_RTC_DRV_TX4939=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -866,6 +970,10 @@ CONFIG_INOTIFY_USER=y
 CONFIG_GENERIC_ACL=y
 
 #
+# Caches
+#
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -890,7 +998,27 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
-# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_HFSPLUS_FS is not set
+CONFIG_JFFS2_FS=m
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -922,6 +1050,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
@@ -929,11 +1058,9 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
-
-#
-# Tracers
-#
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_CMDLINE=""
@@ -946,6 +1073,7 @@ CONFIG_CMDLINE=""
 # CONFIG_SECURITYFS is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
@@ -959,6 +1087,10 @@ CONFIG_GENERIC_FIND_LAST_BIT=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=m
+CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
-- 
1.5.6.5
