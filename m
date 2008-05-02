Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 00:49:16 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:55293 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28801513AbYEBXtN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 00:49:13 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m42Nn4Sg015763;
	Sat, 3 May 2008 01:49:04 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m42Nmkbo015759;
	Sat, 3 May 2008 00:48:47 +0100
Date:	Sat, 3 May 2008 00:48:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: [PATCH] Bring the SWARM defconfig up to date
Message-ID: <Pine.LNX.4.55.0805030008280.12296@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The SWARM defconfig file has not been regenerated for over a year now.
Here is a patch to bring the file up to date.  Additionally some important
and sometimes confusing changes happened meanwhile.  Here is the list of 
notable corresponding updates to the configuration:

1. CPU_SB1_PASS_2_2 is now selected rather than CPU_SB1_PASS_1.  The
   latter requires a non-standard -msb1-pass1-workarounds option to be
   supported by GCC and I am told is quite rare anyway.

2. PHYLIB and BROADCOM_PHY are both built in and NETDEV_1000 enabled as 
   required by SB1250_MAC.

3. USB and USB_OHCI_HCD are enabled as there is an OHCI chip onboard.

4. TMPFS is enabled, because I use it. ;-)

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Anybody please let me know if there is something notable that should be 
changed.

 The configuration builds successfully; it even boots on my box. :-)  
Ralf, please apply.

  Maciej

patch-mips-2.6.25-20080422-swarm-defconfig-3
diff -up --recursive --new-file linux-mips-2.6.25-20080422.macro/arch/mips/configs/sb1250-swarm_defconfig linux-mips-2.6.25-20080422/arch/mips/configs/sb1250-swarm_defconfig
--- linux-mips-2.6.25-20080422.macro/arch/mips/configs/sb1250-swarm_defconfig	2008-02-05 05:55:18.000000000 +0000
+++ linux-mips-2.6.25-20080422/arch/mips/configs/sb1250-swarm_defconfig	2008-05-02 23:38:11.000000000 +0000
@@ -1,67 +1,58 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:40 2007
+# Linux kernel version: 2.6.25
+# Sat May  3 00:38:11 2008
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
+# CONFIG_BCM47XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SEAD is not set
-# CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
-# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
-# CONFIG_MACH_VR41XX is not set
+# CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
-# CONFIG_MARKEINS is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_BIGSUR is not set
-CONFIG_SIBYTE_SWARM=y
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
 # CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
 # CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
+CONFIG_SIBYTE_SWARM=y
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
 # CONFIG_TOSHIBA_JMR3927 is not set
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_WR_PPMC is not set
 CONFIG_SIBYTE_SB1250=y
 CONFIG_SIBYTE_SB1xxx_SOC=y
-CONFIG_CPU_SB1_PASS_1=y
+# CONFIG_CPU_SB1_PASS_1 is not set
 # CONFIG_CPU_SB1_PASS_2_1250 is not set
-# CONFIG_CPU_SB1_PASS_2_2 is not set
+CONFIG_CPU_SB1_PASS_2_2=y
 # CONFIG_CPU_SB1_PASS_4 is not set
 # CONFIG_CPU_SB1_PASS_2_112x is not set
 # CONFIG_CPU_SB1_PASS_3 is not set
 CONFIG_SIBYTE_HAS_LDT=y
+CONFIG_SIBYTE_ENABLE_LDT_IF_PCI=y
 # CONFIG_SIMULATION is not set
 # CONFIG_SB1_CEX_ALWAYS_FATAL is not set
 # CONFIG_SB1_CERR_STALL is not set
@@ -69,20 +60,32 @@ CONFIG_SIBYTE_CFE=y
 # CONFIG_SIBYTE_CFE_CONSOLE is not set
 # CONFIG_SIBYTE_BUS_WATCHER is not set
 # CONFIG_SIBYTE_TBPROF is not set
+CONFIG_SIBYTE_HAS_ZBUS_PROFILING=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CMOS_UPDATE=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 # CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_CEVT_SB1250=y
+CONFIG_CSRC_SB1250=y
+CONFIG_CFE=y
 CONFIG_DMA_COHERENT=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_HOTPLUG_CPU is not set
+# CONFIG_NO_IOPORT is not set
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_BOOT_ELF32=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
@@ -90,6 +93,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -130,8 +134,7 @@ CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
-CONFIG_SB1_PASS_1_WORKAROUNDS=y
+CONFIG_SB1_PASS_2_WORKAROUNDS=y
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -140,6 +143,7 @@ CONFIG_IRQ_PER_CPU=y
 CONFIG_CPU_SUPPORTS_HIGHMEM=y
 CONFIG_SYS_SUPPORTS_HIGHMEM=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -147,13 +151,19 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
 CONFIG_SMP=y
 CONFIG_SYS_SUPPORTS_SMP=y
 CONFIG_NR_CPUS_DEFAULT_2=y
 CONFIG_NR_CPUS=2
+CONFIG_TICK_ONESHOT=y
+# CONFIG_NO_HZ is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -166,38 +176,49 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_PREEMPT_BKL=y
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
 CONFIG_LOCK_KERNEL=y
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
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
+# CONFIG_CGROUP_DEBUG is not set
+# CONFIG_CGROUP_NS is not set
 CONFIG_CPUSETS=y
-CONFIG_SYSFS_DEPRECATED=y
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+CONFIG_CGROUP_CPUACCT=y
+# CONFIG_RESOURCE_COUNTERS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_PROC_PID_CPUSET is not set
 CONFIG_RELAY=y
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -209,20 +230,29 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_COMPAT_BRK is not set
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
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
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
 # CONFIG_MODULE_FORCE_UNLOAD is not set
@@ -230,12 +260,10 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_BLK_DEV_BSG=y
+CONFIG_BLOCK_COMPAT=y
 
 #
 # IO Schedulers
@@ -249,22 +277,19 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCI_LEGACY is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+CONFIG_ZONE_DMA32=y
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 
 #
@@ -272,7 +297,6 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
@@ -286,7 +310,6 @@ CONFIG_BINFMT_ELF32=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
 
 #
 # Networking
@@ -296,7 +319,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -304,6 +326,7 @@ CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
 # CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_XFRM_MIGRATE=y
+# CONFIG_XFRM_STATISTICS is not set
 CONFIG_NET_KEY=y
 CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
@@ -326,6 +349,7 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
+CONFIG_INET_LRO=m
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -333,24 +357,15 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_TCP_MD5SIG=y
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
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
@@ -363,26 +378,52 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
+CONFIG_NET_SCH_FIFO=y
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+CONFIG_CFG80211=m
+CONFIG_NL80211=y
+CONFIG_WIRELESS_EXT=y
+CONFIG_MAC80211=m
+
+#
+# Rate control algorithm selection
+#
+CONFIG_MAC80211_RC_DEFAULT_PID=y
+# CONFIG_MAC80211_RC_DEFAULT_NONE is not set
+
+#
+# Selecting 'y' for an algorithm will
+#
+
+#
+# build the algorithm into mac80211.
+#
+CONFIG_MAC80211_RC_DEFAULT="pid"
+CONFIG_MAC80211_RC_PID=y
+# CONFIG_MAC80211_MESH is not set
+# CONFIG_MAC80211_DEBUG_PACKET_ALIGNMENT is not set
+# CONFIG_MAC80211_DEBUG is not set
 CONFIG_IEEE80211=m
 # CONFIG_IEEE80211_DEBUG is not set
 CONFIG_IEEE80211_CRYPT_WEP=m
 CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+CONFIG_IEEE80211_CRYPT_TKIP=m
+CONFIG_RFKILL=m
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -391,34 +432,15 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
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
@@ -427,49 +449,77 @@ CONFIG_CONNECTOR=m
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=9220
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BLK_DEV_XIP is not set
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_BUFFERS=8
 # CONFIG_CDROM_PKTCDVD_WCACHE is not set
 CONFIG_ATA_OVER_ETH=m
-
-#
-# Misc devices
-#
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
 CONFIG_SGI_IOC4=m
 # CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
 CONFIG_IDE=y
 CONFIG_IDE_MAX_HWIFS=4
 CONFIG_BLK_DEV_IDE=y
 
 #
-# Please see Documentation/ide.txt for help/info on IDE drives
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
 # CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
 CONFIG_BLK_DEV_IDETAPE=y
 CONFIG_BLK_DEV_IDEFLOPPY=y
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
-# CONFIG_BLK_DEV_IDEPCI is not set
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+
+#
+# PCI IDE chipsets support
+#
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
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
 CONFIG_BLK_DEV_IDE_SWARM=y
-# CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD_ONLY is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -477,89 +527,68 @@ CONFIG_BLK_DEV_IDE_SWARM=y
 #
 CONFIG_RAID_ATTRS=m
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
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
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
+CONFIG_NETDEVICES_MULTIQUEUE=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+CONFIG_MACVLAN=m
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
-CONFIG_PHYLIB=m
+CONFIG_PHYLIB=y
 
 #
 # MII PHY device drivers
 #
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
-# CONFIG_BROADCOM_PHY is not set
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+CONFIG_BROADCOM_PHY=y
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
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
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -568,53 +597,70 @@ CONFIG_SB1250_MAC=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
+# CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
+CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
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
+CONFIG_WLAN_80211=y
+# CONFIG_IPW2100 is not set
+# CONFIG_IPW2200 is not set
+# CONFIG_LIBERTAS is not set
+# CONFIG_HERMES is not set
+# CONFIG_ATMEL is not set
+# CONFIG_PRISM54 is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_USB_NET_RNDIS_WLAN is not set
+# CONFIG_RTL8180 is not set
+# CONFIG_RTL8187 is not set
+# CONFIG_ADM8211 is not set
+# CONFIG_P54_COMMON is not set
+# CONFIG_ATH5K is not set
+# CONFIG_IWLCORE is not set
+# CONFIG_IWLWIFI_LEDS is not set
+# CONFIG_IWL4965 is not set
+# CONFIG_IWL3945 is not set
+# CONFIG_HOSTAP is not set
+# CONFIG_B43 is not set
+# CONFIG_B43LEGACY is not set
+# CONFIG_ZD1211RW is not set
+# CONFIG_RT2X00 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
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
@@ -637,24 +683,8 @@ CONFIG_SERIO_RAW=m
 # Character devices
 #
 # CONFIG_VT is not set
-CONFIG_SERIAL_NONSTANDARD=y
-# CONFIG_COMPUTONE is not set
-# CONFIG_ROCKETPORT is not set
-# CONFIG_CYCLADES is not set
-# CONFIG_DIGIEPCA is not set
-# CONFIG_MOXA_INTELLIO is not set
-# CONFIG_MOXA_SMARTIO is not set
-CONFIG_MOXA_SMARTIO_NEW=m
-# CONFIG_ISI is not set
-# CONFIG_SYNCLINKMP is not set
-# CONFIG_SYNCLINK_GT is not set
-# CONFIG_N_HDLC is not set
-# CONFIG_SPECIALIX is not set
-# CONFIG_SX is not set
-# CONFIG_RIO is not set
-# CONFIG_STALDRV is not set
-CONFIG_SERIAL_SB1250_DUART=y
-CONFIG_SERIAL_SB1250_DUART_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -664,37 +694,22 @@ CONFIG_SERIAL_SB1250_DUART_CONSOLE=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_SB1250_DUART=y
+CONFIG_SERIAL_SB1250_DUART_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
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
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
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
@@ -702,109 +717,139 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
 
 #
-# Dallas's 1-wire bus
+# Sonics Silicon Backplane
 #
-# CONFIG_W1 is not set
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
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
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
+# Display device support
 #
-# CONFIG_SOUND is not set
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
-# USB support
+# Sound
 #
+# CONFIG_SOUND is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-#
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# USB Gadget Support
+# Miscellaneous USB options
 #
-# CONFIG_USB_GADGET is not set
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_PERSIST is not set
+# CONFIG_USB_OTG is not set
 
 #
-# MMC/SD Card support
+# USB Host Controller Drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 
 #
-# LED devices
+# USB Device Class drivers
 #
-# CONFIG_NEW_LEDS is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
-# LED drivers
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# LED Triggers
+# may also be needed; see USB_STORAGE Help for more information
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# InfiniBand support
+# USB Imaging devices
 #
-# CONFIG_INFINIBAND is not set
+# CONFIG_USB_MDC800 is not set
+CONFIG_USB_MON=y
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+# USB port drivers
 #
+# CONFIG_USB_SERIAL is not set
 
 #
-# Real Time Clock
+# USB Miscellaneous drivers
 #
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
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
+CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
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
@@ -823,15 +868,14 @@ CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 CONFIG_FUSE_FS=m
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -853,9 +897,9 @@ CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 CONFIG_CONFIGFS_FS=m
 
 #
@@ -871,14 +915,13 @@ CONFIG_CONFIGFS_FS=m
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
@@ -890,6 +933,7 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -897,45 +941,29 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
 # CONFIG_DLM_DEBUG is not set
 
 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=15
-CONFIG_CROSSCOMPILE=y
+# CONFIG_SAMPLES is not set
 CONFIG_CMDLINE=""
 CONFIG_SYS_SUPPORTS_KGDB=y
 # CONFIG_SB1XXX_CORELIS is not set
@@ -946,13 +974,12 @@ CONFIG_SYS_SUPPORTS_KGDB=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=m
 CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
@@ -970,6 +997,11 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_XTS=m
+CONFIG_CRYPTO_CTR=m
+CONFIG_CRYPTO_GCM=m
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -983,15 +1015,16 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_SEED=m
+CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRYPTO_CAMELLIA=m
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_AUTHENC=m
+CONFIG_CRYPTO_LZO=m
+# CONFIG_CRYPTO_HW is not set
 
 #
 # Library routines
@@ -999,10 +1032,15 @@ CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 CONFIG_CRC16=m
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
+CONFIG_LZO_COMPRESS=m
+CONFIG_LZO_DECOMPRESS=m
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
