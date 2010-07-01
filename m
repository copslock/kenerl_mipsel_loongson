Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2010 22:38:10 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:17440 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491129Ab0GAUiA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jul 2010 22:38:00 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAIeZLEyrR7H+/2dsb2JhbACfb3GlN5o6hSUEg3E
X-IronPort-AV: E=Sophos;i="4.53,522,1272844800"; 
   d="scan'208";a="152728275"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-4.cisco.com with ESMTP; 01 Jul 2010 20:37:51 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id o61Kbpfr020377;
        Thu, 1 Jul 2010 20:37:51 GMT
Date:   Thu, 1 Jul 2010 13:37:52 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] Configuration changes to go along with simplified command
        line manipulation
Message-ID: <20100701203751.GA870@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Additional changes to Youichi Yuasa's command line simplication code

The PowerTV platform uses a non-standard way to get the kernel command
line--we insert a built-in command line into arcs_cmdline and to
get additional command line information from the bootloader via a
pointer in the a1 register. It is necessary to insert a space between
to the two strings or the last argument from arcs_cmdline and the first
argument from the bootloader may be inadvertantly combined.

It is also necessary to set CONFIG_CMDLINE_BOOL to "y" and to set the
default command line to an empty string to get the simplified code to
work properly in the PowerTV environment.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
diff --git a/arch/mips/configs/powertv_defconfig b/arch/mips/configs/powertv_defconfig
index 7291633..af0ab73 100644
--- a/arch/mips/configs/powertv_defconfig
+++ b/arch/mips/configs/powertv_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31-rc5
-# Fri Aug 28 14:49:33 2009
+# Linux kernel version: 2.6.35-rc3
+# Thu Jul  1 11:03:28 2010
 #
 CONFIG_MIPS=y
 
@@ -11,11 +11,12 @@ CONFIG_MIPS=y
 # CONFIG_MACH_ALCHEMY is not set
 # CONFIG_AR7 is not set
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
@@ -50,7 +51,6 @@ CONFIG_POWERTV=y
 # CONFIG_MIN_RUNTIME_RESOURCES is not set
 # CONFIG_BOOTLOADER_DRIVER is not set
 CONFIG_BOOTLOADER_FAMILY="R2"
-CONFIG_CSRC_POWERTV=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -65,9 +65,9 @@ CONFIG_SCHED_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_CEVT_R4K_LIB=y
 CONFIG_CEVT_R4K=y
+CONFIG_CSRC_POWERTV=y
 CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-# CONFIG_EARLY_PRINTK is not set
+CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
 # CONFIG_NO_IOPORT is not set
 CONFIG_CPU_BIG_ENDIAN=y
@@ -79,7 +79,8 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
-# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 CONFIG_CPU_MIPS32_R2=y
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -122,7 +123,7 @@ CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
 CONFIG_CPU_MIPSR2_IRQ_VI=y
 CONFIG_CPU_MIPSR2_IRQ_EI=y
 CONFIG_CPU_HAS_SYNC=y
@@ -144,8 +145,7 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
@@ -177,6 +177,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE="mips-linux-"
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
@@ -190,19 +191,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_GROUP_SCHED=y
-CONFIG_FAIR_GROUP_SCHED=y
-# CONFIG_RT_GROUP_SCHED is not set
-CONFIG_USER_SCHED=y
-# CONFIG_CGROUP_SCHED is not set
-# CONFIG_CGROUPS is not set
 # CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
 # CONFIG_NAMESPACES is not set
@@ -211,6 +208,7 @@ CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_ANON_INODES=y
@@ -234,18 +232,16 @@ CONFIG_SHMEM=y
 CONFIG_AIO=y
 
 #
-# Performance Counters
+# Kernel Performance Events And Counters
 #
 # CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_PCI_QUIRKS=y
 # CONFIG_SLUB_DEBUG is not set
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_COMPAT_BRK=y
 # CONFIG_SLAB is not set
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 
 #
@@ -253,7 +249,7 @@ CONFIG_HAVE_OPROFILE=y
 #
 # CONFIG_GCOV_KERNEL is not set
 # CONFIG_SLOW_WORK is not set
-# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
@@ -271,15 +267,41 @@ CONFIG_LBDAF=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-# CONFIG_DEFAULT_AS is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
 CONFIG_DEFAULT_NOOP=y
 CONFIG_DEFAULT_IOSCHED="noop"
-# CONFIG_PROBE_INITRD_HEADER is not set
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_SPIN_UNLOCK is not set
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_READ_UNLOCK is not set
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_WRITE_UNLOCK is not set
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -289,7 +311,6 @@ CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCI_STUB is not set
 # CONFIG_PCI_IOV is not set
@@ -318,7 +339,6 @@ CONFIG_NET=y
 # Networking options
 #
 CONFIG_PACKET=y
-CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
@@ -390,12 +410,26 @@ CONFIG_NETFILTER_ADVANCED=y
 # CONFIG_NETFILTER_NETLINK_LOG is not set
 # CONFIG_NF_CONNTRACK is not set
 CONFIG_NETFILTER_XTABLES=y
+
+#
+# Xtables combined modules
+#
+# CONFIG_NETFILTER_XT_MARK is not set
+
+#
+# Xtables targets
+#
 # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
 # CONFIG_NETFILTER_XT_TARGET_MARK is not set
 # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
 # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
 # CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
+# CONFIG_NETFILTER_XT_TARGET_TEE is not set
 # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
+
+#
+# Xtables matches
+#
 # CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
 # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
 # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
@@ -465,10 +499,13 @@ CONFIG_IP6_NF_FILTER=y
 # CONFIG_IP6_NF_RAW is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 CONFIG_STP=y
 CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
@@ -526,10 +563,21 @@ CONFIG_NET_SCH_FIFO=y
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_WIRELESS is not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -539,6 +587,7 @@ CONFIG_NET_SCH_FIFO=y
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -550,9 +599,9 @@ CONFIG_EXTRA_FIRMWARE=""
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
@@ -568,6 +617,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -611,11 +661,16 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND_ECC=y
+# CONFIG_MTD_NAND_ECC_SMC is not set
 CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
-# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_SM_COMMON is not set
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_DENALI is not set
+CONFIG_MTD_NAND_DENALI_SCRATCH_REG_ADDR=0xFF108018
 CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_RICOH is not set
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_CAFE is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
@@ -641,6 +696,10 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_UB is not set
@@ -658,6 +717,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -693,64 +753,95 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_OSD_INITIATOR is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
 # CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_AHCI_PLATFORM is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_SATA_SIL24 is not set
 CONFIG_ATA_SFF=y
-# CONFIG_SATA_SVW is not set
+
+#
+# SFF controllers with custom DMA interface
+#
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
 # CONFIG_SATA_NV is not set
-# CONFIG_PDC_ADMA is not set
-# CONFIG_SATA_QSTOR is not set
 # CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
 # CONFIG_SATA_SIS is not set
+# CONFIG_SATA_SVW is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
-# CONFIG_SATA_INIC162X is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
 # CONFIG_PATA_ATIIXP is not set
-# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
 # CONFIG_PATA_CYPRESS is not set
 # CONFIG_PATA_EFAR is not set
-# CONFIG_ATA_GENERIC is not set
 # CONFIG_PATA_HPT366 is not set
 # CONFIG_PATA_HPT37X is not set
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
-# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
-# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
-# CONFIG_PATA_MPIIX is not set
-# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_NINJA32 is not set
-# CONFIG_PATA_NS87410 is not set
 # CONFIG_PATA_NS87415 is not set
-# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_PDC_OLD is not set
 # CONFIG_PATA_RADISYS is not set
-# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_RDC is not set
 # CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_PATA_SERVERWORKS is not set
-# CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
+# CONFIG_PATA_TOSHIBA is not set
+# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
+
+#
+# PIO-only SFF controllers
+#
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_PLATFORM is not set
-# CONFIG_PATA_SCH is not set
+# CONFIG_PATA_RZ1000 is not set
+
+#
+# Generic fallback / legacy drivers
+#
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_LEGACY is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -763,7 +854,7 @@ CONFIG_ATA_SFF=y
 #
 
 #
-# See the help texts for more information.
+# The newer stack is recommended.
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
@@ -787,6 +878,7 @@ CONFIG_MII=y
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
 # CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
 # CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
@@ -800,6 +892,7 @@ CONFIG_MII=y
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
 # CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 # CONFIG_ATL2 is not set
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
@@ -829,6 +922,8 @@ CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_CHELSIO_T3 is not set
+CONFIG_CHELSIO_T4_DEPENDS=y
+# CONFIG_CHELSIO_T4 is not set
 # CONFIG_ENIC is not set
 # CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
@@ -841,16 +936,12 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_MLX4_CORE is not set
 # CONFIG_TEHUTI is not set
 # CONFIG_BNX2X is not set
+# CONFIG_QLCNIC is not set
 # CONFIG_QLGE is not set
 # CONFIG_SFC is not set
 # CONFIG_BE2NET is not set
 # CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
+# CONFIG_WLAN is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -864,6 +955,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_USB_PEGASUS is not set
 CONFIG_USB_RTL8150=y
 # CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -873,6 +965,7 @@ CONFIG_USB_RTL8150=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
 # CONFIG_PHONE is not set
 
@@ -882,6 +975,7 @@ CONFIG_USB_RTL8150=y
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -913,6 +1007,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_VT is not set
 # CONFIG_DEVKMEM is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 # CONFIG_NOZOMI is not set
 
 #
@@ -924,6 +1019,9 @@ CONFIG_INPUT_EVDEV=y
 # Non-8250 serial port support
 #
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -934,6 +1032,7 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
+# CONFIG_RAMOOPS is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
 
@@ -945,7 +1044,6 @@ CONFIG_DEVPORT=y
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
@@ -953,20 +1051,14 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
-# CONFIG_MFD_CORE is not set
-# CONFIG_MFD_SM501 is not set
-# CONFIG_HTC_PASIC3 is not set
-# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_SUPPORT is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+# CONFIG_VGA_ARB is not set
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
@@ -980,7 +1072,6 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_SOUND is not set
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
 # CONFIG_HIDRAW is not set
 
 #
@@ -993,31 +1084,43 @@ CONFIG_USB_HIDDEV=y
 #
 # Special HID drivers
 #
+# CONFIG_HID_3M_PCT is not set
 # CONFIG_HID_A4TECH is not set
 # CONFIG_HID_APPLE is not set
 # CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CANDO is not set
 # CONFIG_HID_CHERRY is not set
 # CONFIG_HID_CHICONY is not set
 # CONFIG_HID_CYPRESS is not set
 # CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EGALAX is not set
 # CONFIG_HID_EZKEY is not set
 # CONFIG_HID_KYE is not set
 # CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
 # CONFIG_HID_KENSINGTON is not set
 # CONFIG_HID_LOGITECH is not set
 # CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MOSART is not set
 # CONFIG_HID_MONTEREY is not set
 # CONFIG_HID_NTRIG is not set
+# CONFIG_HID_ORTEK is not set
 # CONFIG_HID_PANTHERLORD is not set
 # CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_PICOLCD is not set
+# CONFIG_HID_QUANTA is not set
+# CONFIG_HID_ROCCAT is not set
+# CONFIG_HID_ROCCAT_KONE is not set
 # CONFIG_HID_SAMSUNG is not set
 # CONFIG_HID_SONY is not set
+# CONFIG_HID_STANTUM is not set
 # CONFIG_HID_SUNPLUS is not set
 # CONFIG_HID_GREENASIA is not set
 # CONFIG_HID_SMARTJOYPLUS is not set
 # CONFIG_HID_TOPSEED is not set
 # CONFIG_HID_THRUSTMASTER is not set
 # CONFIG_HID_ZEROPLUS is not set
+# CONFIG_HID_ZYDACRON is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1032,7 +1135,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 # CONFIG_USB_MON is not set
@@ -1050,6 +1152,7 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
@@ -1133,6 +1236,7 @@ CONFIG_USB_SERIAL_CP210X=y
 # CONFIG_USB_SERIAL_NAVMAN is not set
 # CONFIG_USB_SERIAL_PL2303 is not set
 # CONFIG_USB_SERIAL_OTI6858 is not set
+# CONFIG_USB_SERIAL_QCAUX is not set
 # CONFIG_USB_SERIAL_QUALCOMM is not set
 # CONFIG_USB_SERIAL_SPCP8X5 is not set
 # CONFIG_USB_SERIAL_HP4X is not set
@@ -1146,6 +1250,8 @@ CONFIG_USB_SERIAL_CP210X=y
 # CONFIG_USB_SERIAL_OPTION is not set
 # CONFIG_USB_SERIAL_OMNINET is not set
 # CONFIG_USB_SERIAL_OPTICON is not set
+# CONFIG_USB_SERIAL_VIVOPAY_SERIAL is not set
+# CONFIG_USB_SERIAL_ZIO is not set
 # CONFIG_USB_SERIAL_DEBUG is not set
 
 #
@@ -1158,7 +1264,6 @@ CONFIG_USB_SERIAL_CP210X=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -1171,7 +1276,6 @@ CONFIG_USB_SERIAL_CP210X=y
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_ISIGHTFW is not set
-# CONFIG_USB_VST is not set
 # CONFIG_USB_GADGET is not set
 
 #
@@ -1189,10 +1293,6 @@ CONFIG_RTC_LIB=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1214,6 +1314,7 @@ CONFIG_JBD=y
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
@@ -1274,6 +1375,7 @@ CONFIG_JFFS2_ZLIB=y
 # CONFIG_JFFS2_LZO is not set
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
+# CONFIG_LOGFS is not set
 CONFIG_CRAMFS=y
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1284,7 +1386,6 @@ CONFIG_CRAMFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -1299,6 +1400,7 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1360,6 +1462,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
@@ -1393,15 +1496,25 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_LKDTM is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
 # CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
 CONFIG_FTRACE=y
+# CONFIG_FUNCTION_TRACER is not set
 # CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
@@ -1410,19 +1523,22 @@ CONFIG_FTRACE=y
 CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
 # CONFIG_PROFILE_ALL_BRANCHES is not set
+# CONFIG_STACK_TRACER is not set
 # CONFIG_KMEMTRACE is not set
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_DYNAMIC_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
-# CONFIG_KMEMCHECK is not set
+# CONFIG_EARLY_PRINTK is not set
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="rw dhash_entries=1024 ihash_entries=1024 ip=10.0.1.3:10.0.1.1:10.0.1.1:255.255.255.0:zeus:eth0: root=/dev/nfs nfsroot=/nfsroot/cramfs,wsize=512,rsize=512,tcp nokgdb console=ttyUSB0,115200 memsize=252M"
+CONFIG_CMDLINE=""
 # CONFIG_CMDLINE_OVERRIDE is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_RUNTIME_DEBUG is not set
+# CONFIG_SPINLOCK_TEST is not set
 
 #
 # Security options
@@ -1430,13 +1546,16 @@ CONFIG_CMDLINE="rw dhash_entries=1024 ihash_entries=1024 ip=10.0.1.3:10.0.1.1:10
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
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_ALGAPI2=y
 CONFIG_CRYPTO_AEAD=y
@@ -1479,11 +1598,13 @@ CONFIG_CRYPTO_CBC=y
 #
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index e18d25c..0aac039 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -117,8 +117,10 @@ void __init prom_init(void)
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-	if (prom_argc == 1)
+	if (prom_argc == 1) {
+		strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
 		strlcat(arcs_cmdline, prom_argv, COMMAND_LINE_SIZE);
+	}
 
 	configure_platform();
 	prom_meminit();
