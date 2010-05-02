Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 May 2010 11:39:17 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:49912 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491868Ab0EBJjI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 May 2010 11:39:08 +0200
Received: by wyg36 with SMTP id 36so777545wyg.36
        for <multiple recipients>; Sun, 02 May 2010 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-length:x-uid:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=O6hjGn9w0EZywxEOF7G43cshwE8Z3dYDy93JzNPp6Dk=;
        b=rTxd8Bov7Fa4pi77R7wp8nNreEUZRgBknbIvB5aOtFlF0Hn/0RaimfPKqWQMklu2Am
         /2/5SrFAucdmfgYciKiJRJt5rcVqP0PhQ8k9CJocNJ2VNj5AntJfny3OMC6FaElHKSD5
         f2wm4Btv5eb2OdFygqfLLhWidlabm+gmeShS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-length:x-uid:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=TadEC8PCbtA1t/Y0xqtngrELhaRSw12iko9zNp5RnZFv71zWNklRqigSkxeoAH1MAW
         9VRn5ApvWPywG3ywmYmSqn3yoKvUdAIZ++52MTeLjJZThzUr/kcE4kScMzU7++cITOaP
         8R1jqSOs74UXPlSTPJ1OCiE/NMwZG6l31Yyg8=
Received: by 10.216.89.193 with SMTP id c43mr6075765wef.151.1272793141274;
        Sun, 02 May 2010 02:39:01 -0700 (PDT)
Received: from lenovo.localnet (208.59.76-86.rev.gaoland.net [86.76.59.208])
        by mx.google.com with ESMTPS id z33sm10094467wbd.1.2010.05.02.02.38.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 02:39:00 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 2 May 2010 11:38:57 +0200
Subject: [PATCH 1/4] AR7: update defconfig
MIME-Version: 1.0
X-Length: 15929
X-UID:  190
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201005021138.58177.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Update Texas Instruments AR7 defconfig with:
- tiny RCU
- LEDs GPIO
- disable SSB
- enable zboot support
- enable GPIO sysfs support

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index 5a5b6ba..e700095 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30
-# Wed Jun 24 14:08:59 2009
+# Linux kernel version: 2.6.34-rc6
+# Sat May  1 11:35:01 2010
 #
 CONFIG_MIPS=y
 
@@ -11,11 +11,12 @@ CONFIG_MIPS=y
 # CONFIG_MACH_ALCHEMY is not set
 CONFIG_AR7=y
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
 # CONFIG_NEC_MARKEINS is not set
@@ -26,6 +27,7 @@ CONFIG_AR7=y
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
+# CONFIG_POWERTV is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP28 is not set
@@ -46,6 +48,7 @@ CONFIG_AR7=y
 # CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
 # CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
 # CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -63,10 +66,8 @@ CONFIG_CEVT_R4K=y
 CONFIG_CSRC_R4K_LIB=y
 CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_EARLY_PRINTK=y
+CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
-# CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
@@ -81,7 +82,8 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
-# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -103,6 +105,8 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
 # CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
+CONFIG_SYS_SUPPORTS_ZBOOT_UART16550=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
@@ -124,6 +128,7 @@ CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -141,8 +146,7 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 # CONFIG_NO_HZ is not set
@@ -165,6 +169,7 @@ CONFIG_KEXEC=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -174,6 +179,14 @@ CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_BZIP2=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_HAVE_KERNEL_LZO=y
+# CONFIG_KERNEL_GZIP is not set
+# CONFIG_KERNEL_BZIP2 is not set
+CONFIG_KERNEL_LZMA=y
+# CONFIG_KERNEL_LZO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
@@ -186,14 +199,12 @@ CONFIG_BSD_PROCESS_ACCT=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
 # CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
@@ -204,6 +215,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_GZIP=y
 # CONFIG_RD_BZIP2 is not set
 CONFIG_RD_LZMA=y
+# CONFIG_RD_LZO is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_ANON_INODES=y
@@ -225,19 +237,22 @@ CONFIG_SHMEM=y
 CONFIG_AIO=y
 
 #
-# Performance Counters
+# Kernel Performance Events And Counters
 #
 # CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
 # CONFIG_SLOW_WORK is not set
-# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
@@ -248,7 +263,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -256,14 +271,41 @@ CONFIG_BLOCK=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
 # CONFIG_IOSCHED_CFQ is not set
-# CONFIG_DEFAULT_AS is not set
 CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+CONFIG_INLINE_READ_UNLOCK=y
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+CONFIG_INLINE_WRITE_UNLOCK=y
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -293,7 +335,6 @@ CONFIG_NET=y
 # Networking options
 #
 CONFIG_PACKET=y
-CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -377,6 +418,7 @@ CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XTABLES=m
 # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
 # CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
+# CONFIG_NETFILTER_XT_TARGET_CT is not set
 # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
 # CONFIG_NETFILTER_XT_TARGET_HL is not set
 # CONFIG_NETFILTER_XT_TARGET_LED is not set
@@ -458,6 +500,7 @@ CONFIG_IP_NF_RAW=m
 # CONFIG_IP_NF_ARPTABLES is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 CONFIG_ATM=m
 # CONFIG_ATM_CLIP is not set
@@ -466,6 +509,7 @@ CONFIG_ATM_BR2684=m
 CONFIG_ATM_BR2684_IPFILTER=y
 CONFIG_STP=y
 CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
 # CONFIG_NET_DSA is not set
 CONFIG_VLAN_8021Q=y
 # CONFIG_VLAN_8021Q_GVRP is not set
@@ -541,20 +585,19 @@ CONFIG_HAMRADIO=y
 # CONFIG_AF_RXRPC is not set
 CONFIG_FIB_RULES=y
 CONFIG_WIRELESS=y
+CONFIG_WEXT_CORE=y
+CONFIG_WEXT_PROC=y
 CONFIG_CFG80211=m
+# CONFIG_NL80211_TESTMODE is not set
+# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
 # CONFIG_CFG80211_REG_DEBUG is not set
+CONFIG_CFG80211_DEFAULT_PS=y
 # CONFIG_CFG80211_DEBUGFS is not set
-# CONFIG_WIRELESS_OLD_REGULATORY is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_CFG80211_INTERNAL_REGDB is not set
+CONFIG_CFG80211_WEXT=y
 CONFIG_WIRELESS_EXT_SYSFS=y
 # CONFIG_LIB80211 is not set
 CONFIG_MAC80211=m
-CONFIG_MAC80211_DEFAULT_PS=y
-CONFIG_MAC80211_DEFAULT_PS_VALUE=1
-
-#
-# Rate control algorithm selection
-#
 CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_MINSTREL=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
@@ -576,6 +619,7 @@ CONFIG_MAC80211_RC_DEFAULT="pid"
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -585,9 +629,9 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
-# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 # CONFIG_MTD_AR7_PARTS is not set
@@ -636,6 +680,7 @@ CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 # CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_GPIO_ADDR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -668,6 +713,10 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
@@ -687,6 +736,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 # CONFIG_SCSI_DMA is not set
@@ -727,6 +777,7 @@ CONFIG_MII=y
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
 # CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
 # CONFIG_DNET is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
@@ -737,23 +788,21 @@ CONFIG_MII=y
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_B44 is not set
 # CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 CONFIG_CPMAC=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-CONFIG_WLAN_80211=y
-# CONFIG_LIBERTAS is not set
+CONFIG_WLAN=y
 # CONFIG_LIBERTAS_THINFIRM is not set
 # CONFIG_MAC80211_HWSIM is not set
-# CONFIG_P54_COMMON is not set
-# CONFIG_HOSTAP is not set
+# CONFIG_ATH_COMMON is not set
 # CONFIG_B43 is not set
 # CONFIG_B43LEGACY is not set
+# CONFIG_HOSTAP is not set
+# CONFIG_LIBERTAS is not set
+# CONFIG_P54_COMMON is not set
 # CONFIG_RT2X00 is not set
+# CONFIG_WL12XX is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -813,6 +862,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_TIMBERDALE is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -824,11 +874,39 @@ CONFIG_HW_RANDOM=y
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+
+#
+# Memory mapped GPIO expanders:
+#
+# CONFIG_GPIO_IT8761E is not set
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
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
 
@@ -842,13 +920,7 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB=y
-# CONFIG_SSB_SILENT is not set
-# CONFIG_SSB_DEBUG is not set
-CONFIG_SSB_SERIAL=y
-CONFIG_SSB_DRIVER_MIPS=y
-CONFIG_SSB_EMBEDDED=y
-CONFIG_SSB_DRIVER_EXTIF=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -882,15 +954,18 @@ CONFIG_LEDS_CLASS=y
 #
 # LED drivers
 #
-# CONFIG_LEDS_GPIO is not set
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_GPIO_PLATFORM=y
+# CONFIG_LEDS_LT3593 is not set
+CONFIG_LEDS_TRIGGERS=y
 
 #
 # LED Triggers
 #
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_GPIO is not set
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 
 #
@@ -921,6 +996,7 @@ CONFIG_VLYNQ=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
@@ -984,6 +1060,7 @@ CONFIG_JFFS2_RTIME=y
 CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_JFFS2_CMODE_SIZE is not set
 # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_LOGFS is not set
 # CONFIG_CRAMFS is not set
 CONFIG_SQUASHFS=y
 # CONFIG_SQUASHFS_EMBEDDED is not set
@@ -996,11 +1073,11 @@ CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1039,21 +1116,29 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_MEMORY_INIT is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_LKDTM is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
 # CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
+CONFIG_EARLY_PRINTK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="rootfstype=squashfs,jffs2"
 # CONFIG_CMDLINE_OVERRIDE is not set
+# CONFIG_SPINLOCK_TEST is not set
 
 #
 # Security options
@@ -1061,13 +1146,16 @@ CONFIG_CMDLINE="rootfstype=squashfs,jffs2"
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITYFS is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 CONFIG_CRYPTO=y
 
 #
 # Crypto core or helper
 #
-# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=m
 CONFIG_CRYPTO_ALGAPI2=m
 CONFIG_CRYPTO_AEAD2=m
@@ -1108,11 +1196,13 @@ CONFIG_CRYPTO_ECB=m
 #
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
