Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 15:26:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:63715 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030628AbYGKO0X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 15:26:23 +0100
Received: from localhost (p1011-ipad211funabasi.chiba.ocn.ne.jp [58.91.157.11])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 00306AC01; Fri, 11 Jul 2008 23:26:17 +0900 (JST)
Date:	Fri, 11 Jul 2008 23:28:04 +0900 (JST)
Message-Id: <20080711.232804.75184425.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/2] txx9: update and merge defconfigs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Merge rbhma4200(RBTX4927/37) and rbhma4500(RBTX4938) defconfig into
single rbtx49xx defconfig.  And jmr3927 defconfig is also updated.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/configs/jmr3927_defconfig   |   10 +-
 arch/mips/configs/rbhma4200_defconfig |  698 ------------------------------
 arch/mips/configs/rbhma4500_defconfig |  763 --------------------------------
 arch/mips/configs/rbtx49xx_defconfig  |  767 +++++++++++++++++++++++++++++++++
 4 files changed, 772 insertions(+), 1466 deletions(-)

diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index ab16e67..9d5bd2a 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.26-rc9
-# Fri Jul 11 00:25:19 2008
+# Fri Jul 11 23:01:36 2008
 #
 CONFIG_MIPS=y
 
@@ -37,10 +37,11 @@ CONFIG_MIPS=y
 # CONFIG_SIBYTE_SENTOSA is not set
 # CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
-CONFIG_TOSHIBA_JMR3927=y
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
+CONFIG_MACH_TX39XX=y
+# CONFIG_MACH_TX49XX is not set
 # CONFIG_WR_PPMC is not set
+CONFIG_TOSHIBA_JMR3927=y
+CONFIG_SOC_TX3927=y
 # CONFIG_TOSHIBA_FPCIB0 is not set
 CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
@@ -67,7 +68,6 @@ CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_IRQ_TXX9=y
-CONFIG_MIPS_TX3927=y
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
diff --git a/arch/mips/configs/rbhma4200_defconfig b/arch/mips/configs/rbhma4200_defconfig
deleted file mode 100644
index e0af6a9..0000000
--- a/arch/mips/configs/rbhma4200_defconfig
+++ /dev/null
@@ -1,698 +0,0 @@
-#
-# Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc9
-# Thu Jul 10 23:52:40 2008
-#
-CONFIG_MIPS=y
-
-#
-# Machine selection
-#
-# CONFIG_MACH_ALCHEMY is not set
-# CONFIG_BASLER_EXCITE is not set
-# CONFIG_BCM47XX is not set
-# CONFIG_MIPS_COBALT is not set
-# CONFIG_MACH_DECSTATION is not set
-# CONFIG_MACH_JAZZ is not set
-# CONFIG_LASAT is not set
-# CONFIG_LEMOTE_FULONG is not set
-# CONFIG_MIPS_MALTA is not set
-# CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
-# CONFIG_MACH_VR41XX is not set
-# CONFIG_PNX8550_JBS is not set
-# CONFIG_PNX8550_STB810 is not set
-# CONFIG_PMC_MSP is not set
-# CONFIG_PMC_YOSEMITE is not set
-# CONFIG_SGI_IP22 is not set
-# CONFIG_SGI_IP27 is not set
-# CONFIG_SGI_IP28 is not set
-# CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_CRHINE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_CRHONE is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_SWARM is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_BIGSUR is not set
-# CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-CONFIG_TOSHIBA_RBTX4927=y
-# CONFIG_TOSHIBA_RBTX4938 is not set
-# CONFIG_WR_PPMC is not set
-# CONFIG_TOSHIBA_FPCIB0 is not set
-CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
-CONFIG_PCI_TX4927=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
-CONFIG_GENERIC_FIND_NEXT_BIT=y
-CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_GENERIC_CLOCKEVENTS=y
-CONFIG_GENERIC_TIME=y
-CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
-CONFIG_CEVT_R4K=y
-CONFIG_CEVT_TXX9=y
-CONFIG_CSRC_R4K=y
-CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-# CONFIG_HOTPLUG_CPU is not set
-# CONFIG_NO_IOPORT is not set
-CONFIG_CPU_BIG_ENDIAN=y
-# CONFIG_CPU_LITTLE_ENDIAN is not set
-CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
-CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_IRQ_CPU=y
-CONFIG_IRQ_TXX9=y
-CONFIG_SWAP_IO_SPACE=y
-CONFIG_MIPS_L1_CACHE_SHIFT=5
-
-#
-# CPU selection
-#
-# CONFIG_CPU_LOONGSON2 is not set
-# CONFIG_CPU_MIPS32_R1 is not set
-# CONFIG_CPU_MIPS32_R2 is not set
-# CONFIG_CPU_MIPS64_R1 is not set
-# CONFIG_CPU_MIPS64_R2 is not set
-# CONFIG_CPU_R3000 is not set
-# CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
-# CONFIG_CPU_R4300 is not set
-# CONFIG_CPU_R4X00 is not set
-CONFIG_CPU_TX49XX=y
-# CONFIG_CPU_R5000 is not set
-# CONFIG_CPU_R5432 is not set
-# CONFIG_CPU_R6000 is not set
-# CONFIG_CPU_NEVADA is not set
-# CONFIG_CPU_R8000 is not set
-# CONFIG_CPU_R10000 is not set
-# CONFIG_CPU_RM7000 is not set
-# CONFIG_CPU_RM9000 is not set
-# CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_TX49XX=y
-CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
-
-#
-# Kernel type
-#
-CONFIG_32BIT=y
-# CONFIG_64BIT is not set
-CONFIG_PAGE_SIZE_4KB=y
-# CONFIG_PAGE_SIZE_8KB is not set
-# CONFIG_PAGE_SIZE_16KB is not set
-# CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMP is not set
-# CONFIG_MIPS_MT_SMTC is not set
-CONFIG_CPU_HAS_LLSC=y
-CONFIG_CPU_HAS_SYNC=y
-CONFIG_GENERIC_HARDIRQS=y
-CONFIG_GENERIC_IRQ_PROBE=y
-CONFIG_ARCH_FLATMEM_ENABLE=y
-CONFIG_ARCH_POPULATES_NODE_MAP=y
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
-CONFIG_PAGEFLAGS_EXTENDED=y
-CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=0
-CONFIG_VIRT_TO_BUS=y
-CONFIG_TICK_ONESHOT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
-# CONFIG_HZ_48 is not set
-# CONFIG_HZ_100 is not set
-# CONFIG_HZ_128 is not set
-CONFIG_HZ_250=y
-# CONFIG_HZ_256 is not set
-# CONFIG_HZ_1000 is not set
-# CONFIG_HZ_1024 is not set
-CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=250
-CONFIG_PREEMPT_NONE=y
-# CONFIG_PREEMPT_VOLUNTARY is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_SECCOMP is not set
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_STACKTRACE_SUPPORT=y
-CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
-
-#
-# General setup
-#
-# CONFIG_EXPERIMENTAL is not set
-CONFIG_BROKEN_ON_SMP=y
-CONFIG_INIT_ENV_ARG_LIMIT=32
-CONFIG_LOCALVERSION=""
-CONFIG_LOCALVERSION_AUTO=y
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-# CONFIG_TASKSTATS is not set
-# CONFIG_AUDIT is not set
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
-# CONFIG_RELAY is not set
-# CONFIG_NAMESPACES is not set
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_SYSCTL=y
-CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_PRINTK=y
-CONFIG_BUG=y
-CONFIG_ELF_CORE=y
-# CONFIG_PCSPKR_PLATFORM is not set
-CONFIG_COMPAT_BRK=y
-CONFIG_BASE_FULL=y
-# CONFIG_FUTEX is not set
-CONFIG_ANON_INODES=y
-# CONFIG_EPOLL is not set
-CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
-CONFIG_EVENTFD=y
-CONFIG_SHMEM=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
-# CONFIG_SLOB is not set
-# CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
-CONFIG_HAVE_OPROFILE=y
-# CONFIG_HAVE_KPROBES is not set
-# CONFIG_HAVE_KRETPROBES is not set
-# CONFIG_HAVE_DMA_ATTRS is not set
-CONFIG_PROC_PAGE_MONITOR=y
-CONFIG_SLABINFO=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
-CONFIG_MODULES=y
-# CONFIG_MODULE_FORCE_LOAD is not set
-# CONFIG_MODULE_UNLOAD is not set
-# CONFIG_MODVERSIONS is not set
-# CONFIG_MODULE_SRCVERSION_ALL is not set
-CONFIG_KMOD=y
-CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
-# CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
-
-#
-# Bus options (PCI, PCMCIA, EISA, ISA, TC)
-#
-CONFIG_HW_HAS_PCI=y
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
-# CONFIG_ARCH_SUPPORTS_MSI is not set
-# CONFIG_PCI_LEGACY is not set
-CONFIG_MMU=y
-
-#
-# Executable file formats
-#
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
-CONFIG_TRAD_SIGNALS=y
-
-#
-# Power management options
-#
-CONFIG_ARCH_SUSPEND_POSSIBLE=y
-# CONFIG_PM is not set
-
-#
-# Networking
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_FIB_HASH=y
-CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-# CONFIG_IP_PNP_BOOTP is not set
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_XFRM_TUNNEL is not set
-# CONFIG_INET_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_CUBIC=y
-CONFIG_DEFAULT_TCP_CONG="cubic"
-# CONFIG_IPV6 is not set
-# CONFIG_NETWORK_SECMARK is not set
-# CONFIG_NETFILTER is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_NET_SCHED is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_CAN is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-
-#
-# Wireless
-#
-# CONFIG_CFG80211 is not set
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
-# CONFIG_RFKILL is not set
-
-#
-# Device Drivers
-#
-
-#
-# Generic Driver Options
-#
-CONFIG_STANDALONE=y
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_SYS_HYPERVISOR is not set
-# CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
-# CONFIG_PARPORT is not set
-CONFIG_BLK_DEV=y
-# CONFIG_BLK_CPQ_DA is not set
-# CONFIG_BLK_CPQ_CISS_DA is not set
-# CONFIG_BLK_DEV_DAC960 is not set
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_SX8 is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_BLK_DEV_XIP is not set
-# CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
-# CONFIG_MISC_DEVICES is not set
-CONFIG_HAVE_IDE=y
-# CONFIG_IDE is not set
-
-#
-# SCSI device support
-#
-# CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
-# CONFIG_SCSI_DMA is not set
-# CONFIG_SCSI_NETLINK is not set
-# CONFIG_ATA is not set
-# CONFIG_MD is not set
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# A new alternative FireWire stack is available with EXPERIMENTAL=y
-#
-# CONFIG_IEEE1394 is not set
-# CONFIG_I2O is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-# CONFIG_VETH is not set
-# CONFIG_ARCNET is not set
-# CONFIG_PHYLIB is not set
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_AX88796 is not set
-# CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNGEM is not set
-# CONFIG_CASSINI is not set
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_DM9000 is not set
-# CONFIG_NET_TULIP is not set
-# CONFIG_HP100 is not set
-CONFIG_NE2000=y
-# CONFIG_IBM_NEW_EMAC_ZMII is not set
-# CONFIG_IBM_NEW_EMAC_RGMII is not set
-# CONFIG_IBM_NEW_EMAC_TAH is not set
-# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
-# CONFIG_NET_PCI is not set
-# CONFIG_B44 is not set
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
-# CONFIG_WAN is not set
-# CONFIG_FDDI is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_ISDN is not set
-# CONFIG_PHONE is not set
-
-#
-# Input device support
-#
-# CONFIG_INPUT is not set
-
-#
-# Hardware I/O ports
-#
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_SERIO_RAW is not set
-# CONFIG_GAMEPORT is not set
-
-#
-# Character devices
-#
-# CONFIG_VT is not set
-CONFIG_DEVKMEM=y
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-# CONFIG_SERIAL_8250 is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_SERIAL_TXX9=y
-CONFIG_HAS_TXX9_SERIAL=y
-CONFIG_SERIAL_TXX9_NR_UARTS=6
-CONFIG_SERIAL_TXX9_CONSOLE=y
-CONFIG_SERIAL_TXX9_STDSERIAL=y
-# CONFIG_SERIAL_JSM is not set
-CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_IPMI_HANDLER is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
-# CONFIG_RAW_DRIVER is not set
-CONFIG_DEVPORT=y
-# CONFIG_I2C is not set
-# CONFIG_SPI is not set
-# CONFIG_W1 is not set
-# CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
-# CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-CONFIG_TXX9_WDT=y
-
-#
-# PCI-based Watchdog Cards
-#
-# CONFIG_PCIPCWATCHDOG is not set
-# CONFIG_WDTPCI is not set
-
-#
-# Sonics Silicon Backplane
-#
-CONFIG_SSB_POSSIBLE=y
-# CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
-# CONFIG_MFD_SM501 is not set
-# CONFIG_HTC_PASIC3 is not set
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
-
-#
-# Graphics support
-#
-# CONFIG_DRM is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Display device support
-#
-# CONFIG_DISPLAY_SUPPORT is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
-# CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
-# CONFIG_ACCESSIBILITY is not set
-# CONFIG_INFINIBAND is not set
-CONFIG_RTC_LIB=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_HCTOSYS=y
-CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
-# CONFIG_RTC_DEBUG is not set
-
-#
-# RTC interfaces
-#
-CONFIG_RTC_INTF_SYSFS=y
-CONFIG_RTC_INTF_PROC=y
-CONFIG_RTC_INTF_DEV=y
-# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
-# CONFIG_RTC_DRV_TEST is not set
-
-#
-# SPI RTC drivers
-#
-
-#
-# Platform RTC drivers
-#
-# CONFIG_RTC_DRV_CMOS is not set
-# CONFIG_RTC_DRV_DS1511 is not set
-# CONFIG_RTC_DRV_DS1553 is not set
-CONFIG_RTC_DRV_DS1742=y
-# CONFIG_RTC_DRV_STK17TA8 is not set
-# CONFIG_RTC_DRV_M48T86 is not set
-# CONFIG_RTC_DRV_M48T59 is not set
-# CONFIG_RTC_DRV_V3020 is not set
-
-#
-# on-CPU RTC drivers
-#
-# CONFIG_UIO is not set
-
-#
-# File systems
-#
-# CONFIG_EXT2_FS is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
-# CONFIG_XFS_FS is not set
-# CONFIG_OCFS2_FS is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY=y
-CONFIG_INOTIFY_USER=y
-# CONFIG_QUOTA is not set
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-# CONFIG_FUSE_FS is not set
-CONFIG_GENERIC_ACL=y
-
-#
-# CD-ROM/DVD Filesystems
-#
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-# CONFIG_PROC_KCORE is not set
-CONFIG_PROC_SYSCTL=y
-CONFIG_SYSFS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-# CONFIG_HUGETLB_PAGE is not set
-# CONFIG_CONFIGFS_FS is not set
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
-CONFIG_NETWORK_FILESYSTEMS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-# CONFIG_NFS_V3_ACL is not set
-# CONFIG_NFSD is not set
-CONFIG_ROOT_NFS=y
-CONFIG_LOCKD=y
-CONFIG_LOCKD_V4=y
-CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=y
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-
-#
-# Partition Types
-#
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
-# CONFIG_NLS is not set
-
-#
-# Kernel hacking
-#
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-# CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_WARN_DEPRECATED=y
-CONFIG_ENABLE_MUST_CHECK=y
-CONFIG_FRAME_WARN=1024
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
-# CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_SAMPLES is not set
-CONFIG_CMDLINE=""
-CONFIG_SYS_SUPPORTS_KGDB=y
-
-#
-# Security options
-#
-# CONFIG_KEYS is not set
-# CONFIG_SECURITY is not set
-# CONFIG_CRYPTO is not set
-
-#
-# Library routines
-#
-CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
-# CONFIG_CRC_CCITT is not set
-# CONFIG_CRC16 is not set
-# CONFIG_CRC_ITU_T is not set
-CONFIG_CRC32=y
-# CONFIG_CRC7 is not set
-# CONFIG_LIBCRC32C is not set
-CONFIG_HAS_IOMEM=y
-CONFIG_HAS_IOPORT=y
-CONFIG_HAS_DMA=y
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
deleted file mode 100644
index 50aa1b6..0000000
--- a/arch/mips/configs/rbhma4500_defconfig
+++ /dev/null
@@ -1,763 +0,0 @@
-#
-# Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc9
-# Thu Jul 10 23:53:27 2008
-#
-CONFIG_MIPS=y
-
-#
-# Machine selection
-#
-# CONFIG_MACH_ALCHEMY is not set
-# CONFIG_BASLER_EXCITE is not set
-# CONFIG_BCM47XX is not set
-# CONFIG_MIPS_COBALT is not set
-# CONFIG_MACH_DECSTATION is not set
-# CONFIG_MACH_JAZZ is not set
-# CONFIG_LASAT is not set
-# CONFIG_LEMOTE_FULONG is not set
-# CONFIG_MIPS_MALTA is not set
-# CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
-# CONFIG_MACH_VR41XX is not set
-# CONFIG_PNX8550_JBS is not set
-# CONFIG_PNX8550_STB810 is not set
-# CONFIG_PMC_MSP is not set
-# CONFIG_PMC_YOSEMITE is not set
-# CONFIG_SGI_IP22 is not set
-# CONFIG_SGI_IP27 is not set
-# CONFIG_SGI_IP28 is not set
-# CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_CRHINE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_CRHONE is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_SWARM is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_BIGSUR is not set
-# CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-CONFIG_TOSHIBA_RBTX4938=y
-# CONFIG_WR_PPMC is not set
-# CONFIG_TOSHIBA_FPCIB0 is not set
-CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
-
-#
-# Multiplex Pin Select
-#
-CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61=y
-# CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND is not set
-# CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA is not set
-CONFIG_PCI_TX4927=y
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_ARCH_SUPPORTS_OPROFILE=y
-CONFIG_GENERIC_FIND_NEXT_BIT=y
-CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_GENERIC_CLOCKEVENTS=y
-CONFIG_GENERIC_TIME=y
-CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
-CONFIG_CEVT_R4K=y
-CONFIG_CEVT_TXX9=y
-CONFIG_CSRC_R4K=y
-CONFIG_GPIO_TXX9=y
-CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-# CONFIG_HOTPLUG_CPU is not set
-# CONFIG_NO_IOPORT is not set
-CONFIG_GENERIC_GPIO=y
-CONFIG_CPU_BIG_ENDIAN=y
-# CONFIG_CPU_LITTLE_ENDIAN is not set
-CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
-CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_IRQ_CPU=y
-CONFIG_IRQ_TXX9=y
-CONFIG_SWAP_IO_SPACE=y
-CONFIG_MIPS_L1_CACHE_SHIFT=5
-
-#
-# CPU selection
-#
-# CONFIG_CPU_LOONGSON2 is not set
-# CONFIG_CPU_MIPS32_R1 is not set
-# CONFIG_CPU_MIPS32_R2 is not set
-# CONFIG_CPU_MIPS64_R1 is not set
-# CONFIG_CPU_MIPS64_R2 is not set
-# CONFIG_CPU_R3000 is not set
-# CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
-# CONFIG_CPU_R4300 is not set
-# CONFIG_CPU_R4X00 is not set
-CONFIG_CPU_TX49XX=y
-# CONFIG_CPU_R5000 is not set
-# CONFIG_CPU_R5432 is not set
-# CONFIG_CPU_R6000 is not set
-# CONFIG_CPU_NEVADA is not set
-# CONFIG_CPU_R8000 is not set
-# CONFIG_CPU_R10000 is not set
-# CONFIG_CPU_RM7000 is not set
-# CONFIG_CPU_RM9000 is not set
-# CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_TX49XX=y
-CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
-
-#
-# Kernel type
-#
-CONFIG_32BIT=y
-# CONFIG_64BIT is not set
-CONFIG_PAGE_SIZE_4KB=y
-# CONFIG_PAGE_SIZE_8KB is not set
-# CONFIG_PAGE_SIZE_16KB is not set
-# CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_CPU_HAS_PREFETCH=y
-CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMP is not set
-# CONFIG_MIPS_MT_SMTC is not set
-CONFIG_CPU_HAS_LLSC=y
-CONFIG_CPU_HAS_SYNC=y
-CONFIG_GENERIC_HARDIRQS=y
-CONFIG_GENERIC_IRQ_PROBE=y
-CONFIG_ARCH_FLATMEM_ENABLE=y
-CONFIG_ARCH_POPULATES_NODE_MAP=y
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
-CONFIG_PAGEFLAGS_EXTENDED=y
-CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=0
-CONFIG_VIRT_TO_BUS=y
-CONFIG_TICK_ONESHOT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
-# CONFIG_HZ_48 is not set
-# CONFIG_HZ_100 is not set
-# CONFIG_HZ_128 is not set
-CONFIG_HZ_250=y
-# CONFIG_HZ_256 is not set
-# CONFIG_HZ_1000 is not set
-# CONFIG_HZ_1024 is not set
-CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=250
-CONFIG_PREEMPT_NONE=y
-# CONFIG_PREEMPT_VOLUNTARY is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_SECCOMP is not set
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_STACKTRACE_SUPPORT=y
-CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
-
-#
-# General setup
-#
-# CONFIG_EXPERIMENTAL is not set
-CONFIG_BROKEN_ON_SMP=y
-CONFIG_INIT_ENV_ARG_LIMIT=32
-CONFIG_LOCALVERSION=""
-CONFIG_LOCALVERSION_AUTO=y
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_BSD_PROCESS_ACCT is not set
-# CONFIG_TASKSTATS is not set
-# CONFIG_AUDIT is not set
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
-# CONFIG_RELAY is not set
-# CONFIG_NAMESPACES is not set
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_SYSCTL=y
-CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_PRINTK=y
-CONFIG_BUG=y
-CONFIG_ELF_CORE=y
-# CONFIG_PCSPKR_PLATFORM is not set
-CONFIG_COMPAT_BRK=y
-CONFIG_BASE_FULL=y
-# CONFIG_FUTEX is not set
-CONFIG_ANON_INODES=y
-# CONFIG_EPOLL is not set
-CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
-CONFIG_EVENTFD=y
-CONFIG_SHMEM=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
-# CONFIG_SLOB is not set
-# CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
-CONFIG_HAVE_OPROFILE=y
-# CONFIG_HAVE_KPROBES is not set
-# CONFIG_HAVE_KRETPROBES is not set
-# CONFIG_HAVE_DMA_ATTRS is not set
-CONFIG_PROC_PAGE_MONITOR=y
-CONFIG_SLABINFO=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
-CONFIG_MODULES=y
-# CONFIG_MODULE_FORCE_LOAD is not set
-# CONFIG_MODULE_UNLOAD is not set
-# CONFIG_MODVERSIONS is not set
-# CONFIG_MODULE_SRCVERSION_ALL is not set
-CONFIG_KMOD=y
-CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
-# CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
-
-#
-# Bus options (PCI, PCMCIA, EISA, ISA, TC)
-#
-CONFIG_HW_HAS_PCI=y
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
-# CONFIG_ARCH_SUPPORTS_MSI is not set
-# CONFIG_PCI_LEGACY is not set
-CONFIG_MMU=y
-
-#
-# Executable file formats
-#
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
-CONFIG_TRAD_SIGNALS=y
-
-#
-# Power management options
-#
-CONFIG_ARCH_SUSPEND_POSSIBLE=y
-# CONFIG_PM is not set
-
-#
-# Networking
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_FIB_HASH=y
-CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-# CONFIG_IP_PNP_BOOTP is not set
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_XFRM_TUNNEL is not set
-# CONFIG_INET_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_CUBIC=y
-CONFIG_DEFAULT_TCP_CONG="cubic"
-# CONFIG_IPV6 is not set
-# CONFIG_NETWORK_SECMARK is not set
-# CONFIG_NETFILTER is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_NET_SCHED is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_CAN is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-
-#
-# Wireless
-#
-# CONFIG_CFG80211 is not set
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
-# CONFIG_RFKILL is not set
-
-#
-# Device Drivers
-#
-
-#
-# Generic Driver Options
-#
-CONFIG_STANDALONE=y
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_SYS_HYPERVISOR is not set
-# CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
-# CONFIG_PARPORT is not set
-CONFIG_BLK_DEV=y
-# CONFIG_BLK_CPQ_DA is not set
-# CONFIG_BLK_CPQ_CISS_DA is not set
-# CONFIG_BLK_DEV_DAC960 is not set
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_SX8 is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_BLK_DEV_XIP is not set
-# CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
-# CONFIG_MISC_DEVICES is not set
-CONFIG_HAVE_IDE=y
-# CONFIG_IDE is not set
-
-#
-# SCSI device support
-#
-# CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
-# CONFIG_SCSI_DMA is not set
-# CONFIG_SCSI_NETLINK is not set
-# CONFIG_ATA is not set
-# CONFIG_MD is not set
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# A new alternative FireWire stack is available with EXPERIMENTAL=y
-#
-# CONFIG_IEEE1394 is not set
-# CONFIG_I2O is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-# CONFIG_VETH is not set
-# CONFIG_ARCNET is not set
-CONFIG_PHYLIB=y
-
-#
-# MII PHY device drivers
-#
-# CONFIG_MARVELL_PHY is not set
-# CONFIG_DAVICOM_PHY is not set
-# CONFIG_QSEMI_PHY is not set
-# CONFIG_LXT_PHY is not set
-# CONFIG_CICADA_PHY is not set
-# CONFIG_VITESSE_PHY is not set
-# CONFIG_SMSC_PHY is not set
-# CONFIG_BROADCOM_PHY is not set
-# CONFIG_ICPLUS_PHY is not set
-# CONFIG_REALTEK_PHY is not set
-# CONFIG_FIXED_PHY is not set
-# CONFIG_MDIO_BITBANG is not set
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_AX88796 is not set
-# CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNGEM is not set
-# CONFIG_CASSINI is not set
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_DM9000 is not set
-# CONFIG_NET_TULIP is not set
-# CONFIG_HP100 is not set
-CONFIG_NE2000=y
-# CONFIG_IBM_NEW_EMAC_ZMII is not set
-# CONFIG_IBM_NEW_EMAC_RGMII is not set
-# CONFIG_IBM_NEW_EMAC_TAH is not set
-# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
-CONFIG_NET_PCI=y
-# CONFIG_PCNET32 is not set
-# CONFIG_AMD8111_ETH is not set
-# CONFIG_ADAPTEC_STARFIRE is not set
-# CONFIG_B44 is not set
-# CONFIG_FORCEDETH is not set
-CONFIG_TC35815=y
-# CONFIG_EEPRO100 is not set
-# CONFIG_E100 is not set
-# CONFIG_FEALNX is not set
-# CONFIG_NATSEMI is not set
-# CONFIG_NE2K_PCI is not set
-# CONFIG_8139TOO is not set
-# CONFIG_R6040 is not set
-# CONFIG_SIS900 is not set
-# CONFIG_EPIC100 is not set
-# CONFIG_SUNDANCE is not set
-# CONFIG_TLAN is not set
-# CONFIG_VIA_RHINE is not set
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
-# CONFIG_WAN is not set
-# CONFIG_FDDI is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_ISDN is not set
-# CONFIG_PHONE is not set
-
-#
-# Input device support
-#
-# CONFIG_INPUT is not set
-
-#
-# Hardware I/O ports
-#
-# CONFIG_SERIO is not set
-# CONFIG_GAMEPORT is not set
-
-#
-# Character devices
-#
-# CONFIG_VT is not set
-CONFIG_DEVKMEM=y
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-# CONFIG_SERIAL_8250 is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_CORE=y
-CONFIG_SERIAL_CORE_CONSOLE=y
-CONFIG_SERIAL_TXX9=y
-CONFIG_HAS_TXX9_SERIAL=y
-CONFIG_SERIAL_TXX9_NR_UARTS=6
-CONFIG_SERIAL_TXX9_CONSOLE=y
-CONFIG_SERIAL_TXX9_STDSERIAL=y
-# CONFIG_SERIAL_JSM is not set
-CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_IPMI_HANDLER is not set
-# CONFIG_HW_RANDOM is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
-# CONFIG_RAW_DRIVER is not set
-CONFIG_DEVPORT=y
-# CONFIG_I2C is not set
-CONFIG_SPI=y
-CONFIG_SPI_MASTER=y
-
-#
-# SPI Master Controller Drivers
-#
-CONFIG_SPI_TXX9=y
-
-#
-# SPI Protocol Masters
-#
-CONFIG_SPI_AT25=y
-# CONFIG_SPI_TLE62X0 is not set
-CONFIG_HAVE_GPIO_LIB=y
-
-#
-# GPIO Support
-#
-
-#
-# I2C GPIO expanders:
-#
-
-#
-# SPI GPIO expanders:
-#
-# CONFIG_GPIO_MCP23S08 is not set
-# CONFIG_W1 is not set
-# CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
-# CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-CONFIG_TXX9_WDT=m
-
-#
-# PCI-based Watchdog Cards
-#
-# CONFIG_PCIPCWATCHDOG is not set
-# CONFIG_WDTPCI is not set
-
-#
-# Sonics Silicon Backplane
-#
-CONFIG_SSB_POSSIBLE=y
-# CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
-# CONFIG_MFD_SM501 is not set
-# CONFIG_HTC_PASIC3 is not set
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
-
-#
-# Graphics support
-#
-# CONFIG_DRM is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Display device support
-#
-# CONFIG_DISPLAY_SUPPORT is not set
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_MMC is not set
-# CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
-# CONFIG_ACCESSIBILITY is not set
-# CONFIG_INFINIBAND is not set
-CONFIG_RTC_LIB=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_HCTOSYS=y
-CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
-# CONFIG_RTC_DEBUG is not set
-
-#
-# RTC interfaces
-#
-CONFIG_RTC_INTF_SYSFS=y
-CONFIG_RTC_INTF_PROC=y
-CONFIG_RTC_INTF_DEV=y
-CONFIG_RTC_INTF_DEV_UIE_EMUL=y
-# CONFIG_RTC_DRV_TEST is not set
-
-#
-# SPI RTC drivers
-#
-# CONFIG_RTC_DRV_MAX6902 is not set
-# CONFIG_RTC_DRV_R9701 is not set
-CONFIG_RTC_DRV_RS5C348=y
-
-#
-# Platform RTC drivers
-#
-# CONFIG_RTC_DRV_CMOS is not set
-# CONFIG_RTC_DRV_DS1511 is not set
-# CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_DS1742 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
-# CONFIG_RTC_DRV_M48T86 is not set
-# CONFIG_RTC_DRV_M48T59 is not set
-# CONFIG_RTC_DRV_V3020 is not set
-
-#
-# on-CPU RTC drivers
-#
-# CONFIG_UIO is not set
-
-#
-# File systems
-#
-# CONFIG_EXT2_FS is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
-# CONFIG_XFS_FS is not set
-# CONFIG_OCFS2_FS is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY=y
-CONFIG_INOTIFY_USER=y
-# CONFIG_QUOTA is not set
-# CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
-# CONFIG_FUSE_FS is not set
-CONFIG_GENERIC_ACL=y
-
-#
-# CD-ROM/DVD Filesystems
-#
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-# CONFIG_PROC_KCORE is not set
-CONFIG_PROC_SYSCTL=y
-CONFIG_SYSFS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-# CONFIG_HUGETLB_PAGE is not set
-# CONFIG_CONFIGFS_FS is not set
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
-CONFIG_NETWORK_FILESYSTEMS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-# CONFIG_NFS_V3_ACL is not set
-# CONFIG_NFSD is not set
-CONFIG_ROOT_NFS=y
-CONFIG_LOCKD=y
-CONFIG_LOCKD_V4=y
-CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=y
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-
-#
-# Partition Types
-#
-# CONFIG_PARTITION_ADVANCED is not set
-CONFIG_MSDOS_PARTITION=y
-# CONFIG_NLS is not set
-
-#
-# Kernel hacking
-#
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-# CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_WARN_DEPRECATED=y
-CONFIG_ENABLE_MUST_CHECK=y
-CONFIG_FRAME_WARN=1024
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_UNUSED_SYMBOLS is not set
-CONFIG_DEBUG_FS=y
-# CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_SAMPLES is not set
-CONFIG_CMDLINE=""
-CONFIG_SYS_SUPPORTS_KGDB=y
-
-#
-# Security options
-#
-# CONFIG_KEYS is not set
-# CONFIG_SECURITY is not set
-# CONFIG_CRYPTO is not set
-
-#
-# Library routines
-#
-CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
-# CONFIG_CRC_CCITT is not set
-# CONFIG_CRC16 is not set
-# CONFIG_CRC_ITU_T is not set
-CONFIG_CRC32=y
-# CONFIG_CRC7 is not set
-# CONFIG_LIBCRC32C is not set
-CONFIG_HAS_IOMEM=y
-CONFIG_HAS_IOPORT=y
-CONFIG_HAS_DMA=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
new file mode 100644
index 0000000..e42aed5
--- /dev/null
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -0,0 +1,767 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.26-rc9
+# Fri Jul 11 23:03:21 2008
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+# CONFIG_MACH_ALCHEMY is not set
+# CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_LEMOTE_FULONG is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SIM is not set
+# CONFIG_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_PNX8550_JBS is not set
+# CONFIG_PNX8550_STB810 is not set
+# CONFIG_PMC_MSP is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_BIGSUR is not set
+# CONFIG_SNI_RM is not set
+# CONFIG_MACH_TX39XX is not set
+CONFIG_MACH_TX49XX=y
+# CONFIG_WR_PPMC is not set
+CONFIG_TOSHIBA_RBTX4927=y
+CONFIG_TOSHIBA_RBTX4938=y
+CONFIG_SOC_TX4927=y
+CONFIG_SOC_TX4938=y
+# CONFIG_TOSHIBA_FPCIB0 is not set
+CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
+
+#
+# Multiplex Pin Select
+#
+CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61=y
+# CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND is not set
+# CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA is not set
+CONFIG_PCI_TX4927=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K=y
+CONFIG_CEVT_TXX9=y
+CONFIG_CSRC_R4K=y
+CONFIG_GPIO_TXX9=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
+CONFIG_CPU_BIG_ENDIAN=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_IRQ_TXX9=y
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_MIPS32_R1 is not set
+# CONFIG_CPU_MIPS32_R2 is not set
+# CONFIG_CPU_MIPS64_R1 is not set
+# CONFIG_CPU_MIPS64_R2 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+CONFIG_CPU_TX49XX=y
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_TX49XX=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
+
+#
+# Kernel type
+#
+CONFIG_32BIT=y
+# CONFIG_64BIT is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_MIPS_MT_DISABLED=y
+# CONFIG_MIPS_MT_SMP is not set
+# CONFIG_MIPS_MT_SMTC is not set
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_SECCOMP is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
+CONFIG_BASE_FULL=y
+# CONFIG_FUTEX is not set
+CONFIG_ANON_INODES=y
+# CONFIG_EPOLL is not set
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+# CONFIG_MODULE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCI_LEGACY is not set
+CONFIG_MMU=y
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Power management options
+#
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_PM is not set
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+# CONFIG_MTD is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# A new alternative FireWire stack is available with EXPERIMENTAL=y
+#
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_AX88796 is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_DM9000 is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NE2000=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+CONFIG_TC35815=y
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139TOO is not set
+# CONFIG_R6040 is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_TXX9=y
+CONFIG_HAS_TXX9_SERIAL=y
+CONFIG_SERIAL_TXX9_NR_UARTS=6
+CONFIG_SERIAL_TXX9_CONSOLE=y
+CONFIG_SERIAL_TXX9_STDSERIAL=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+CONFIG_DEVPORT=y
+# CONFIG_I2C is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_TXX9=y
+
+#
+# SPI Protocol Masters
+#
+CONFIG_SPI_AT25=y
+# CONFIG_SPI_TLE62X0 is not set
+CONFIG_HAVE_GPIO_LIB=y
+
+#
+# GPIO Support
+#
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_TXX9_WDT=m
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+
+#
+# Multimedia devices
+#
+
+#
+# Multimedia core support
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+CONFIG_RTC_DRV_RS5C348=y
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+CONFIG_RTC_DRV_DS1742=y
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_NLS is not set
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SAMPLES is not set
+CONFIG_CMDLINE=""
+CONFIG_SYS_SUPPORTS_KGDB=y
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
