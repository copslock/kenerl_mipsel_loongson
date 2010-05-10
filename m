Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2010 23:36:07 +0200 (CEST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:60861 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492523Ab0EJVgC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 May 2010 23:36:02 +0200
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAG0Y6EtAZnwN/2dsb2JhbACeI3GjD5lRglAFgj8Eg0E
X-IronPort-AV: E=Sophos;i="4.53,202,1272844800"; 
   d="scan'208";a="109810254"
Received: from rtp-core-2.cisco.com ([64.102.124.13])
  by rtp-iport-1.cisco.com with ESMTP; 10 May 2010 21:35:53 +0000
Received: from xbh-rcd-102.cisco.com (xbh-rcd-102.cisco.com [72.163.62.139])
        by rtp-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id o4ALZqDK010393;
        Mon, 10 May 2010 21:35:53 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-102.cisco.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 10 May 2010 16:35:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH 2/2] The Device Tree Patch for MIPS
Date:   Mon, 10 May 2010 16:35:51 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400DC6413A@XMB-RCD-208.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 2/2] The Device Tree Patch for MIPS
Thread-Index: AcrwiE2Kxdp67lxkSEmhUR3BghfpGAAAE6KA
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     <linux-mips@linux-mips.org>
Cc:     "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        "Tony Colclough (colclot)" <colclot@cisco.com>,
        "Grant Likely" <grant.likely@secretlab.ca>
X-OriginalArrivalTime: 10 May 2010 21:35:53.0169 (UTC) FILETIME=[C437CC10:01CAF088]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

It is the machine-dependent code.

---
 arch/mips/configs/powertv_defconfig        |  174 +++++++++++++++------
 arch/mips/include/asm/mach-powertv/asic.h  |    8 +-
 arch/mips/include/asm/mach-powertv/mdesc.h |   51 ++++++
 arch/mips/powertv/Makefile                 |    2 +-
 arch/mips/powertv/asic/asic_devices.c      |   22 ---
 arch/mips/powertv/mdesc.c                  |  224
+++++++++++++++++++++++++
 arch/mips/powertv/memory.c                 |  242
+++++++++++++++++-----------
 7 files changed, 555 insertions(+), 168 deletions(-)  create mode
100644 arch/mips/include/asm/mach-powertv/mdesc.h
 create mode 100644 arch/mips/powertv/mdesc.c

diff --git a/arch/mips/configs/powertv_defconfig
b/arch/mips/configs/powertv_defconfig
index 7291633..b737432 100644
--- a/arch/mips/configs/powertv_defconfig
+++ b/arch/mips/configs/powertv_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit -# Linux kernel
version: 2.6.31-rc5 -# Fri Aug 28 14:49:33 2009
+# Linux kernel version: 2.6.34-rc3
+# Thu May  6 18:17:35 2010
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
 # CONFIG_MIN_RUNTIME_RESOURCES is not set  # CONFIG_BOOTLOADER_DRIVER
is not set  CONFIG_BOOTLOADER_FAMILY="R2"
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
@@ -79,7 +79,8 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5  #  # CPU selection  # -#
CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 CONFIG_CPU_MIPS32_R2=y
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -122,7 +123,7 @@ CONFIG_CPU_HAS_PREFETCH=y  CONFIG_MIPS_MT_DISABLED=y
# CONFIG_MIPS_MT_SMP is not set  # CONFIG_MIPS_MT_SMTC is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
 CONFIG_CPU_MIPSR2_IRQ_VI=y
 CONFIG_CPU_MIPSR2_IRQ_EI=y
 CONFIG_CPU_HAS_SYNC=y
@@ -144,8 +145,7 @@ CONFIG_SPLIT_PTLOCK_CPUS=4  #
CONFIG_PHYS_ADDR_T_64BIT is not set  CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y -CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
@@ -165,6 +165,9 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT=y
 # CONFIG_KEXEC is not set
 # CONFIG_SECCOMP is not set
+CONFIG_OF=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_ARCH_HAS_DEVTREE_MEM=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -190,19 +193,15 @@ CONFIG_SYSVIPC_SYSCTL=y  #  # RCU Subsystem  #
-CONFIG_CLASSIC_RCU=y -# CONFIG_TREE_RCU is not set -#
CONFIG_PREEMPT_RCU is not set
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
 # CONFIG_SYSFS_DEPRECATED_V2 is not set  CONFIG_RELAY=y  #
CONFIG_NAMESPACES is not set @@ -211,6 +210,7 @@
CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set  CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y @@ -234,18 +234,16 @@ CONFIG_SHMEM=y  CONFIG_AIO=y
 
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
@@ -253,7 +251,7 @@ CONFIG_HAVE_OPROFILE=y  #  # CONFIG_GCOV_KERNEL is
not set  # CONFIG_SLOW_WORK is not set -#
CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
@@ -271,15 +269,41 @@ CONFIG_LBDAF=y
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
+# CONFIG_INLINE_SPIN_TRYLOCK is not set # CONFIG_INLINE_SPIN_TRYLOCK_BH

+is not set # CONFIG_INLINE_SPIN_LOCK is not set # 
+CONFIG_INLINE_SPIN_LOCK_BH is not set # CONFIG_INLINE_SPIN_LOCK_IRQ is 
+not set # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set # 
+CONFIG_INLINE_SPIN_UNLOCK is not set # CONFIG_INLINE_SPIN_UNLOCK_BH is 
+not set # CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set # 
+CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set # 
+CONFIG_INLINE_READ_TRYLOCK is not set # CONFIG_INLINE_READ_LOCK is not 
+set # CONFIG_INLINE_READ_LOCK_BH is not set # 
+CONFIG_INLINE_READ_LOCK_IRQ is not set # 
+CONFIG_INLINE_READ_LOCK_IRQSAVE is not set # CONFIG_INLINE_READ_UNLOCK 
+is not set # CONFIG_INLINE_READ_UNLOCK_BH is not set # 
+CONFIG_INLINE_READ_UNLOCK_IRQ is not set # 
+CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set # 
+CONFIG_INLINE_WRITE_TRYLOCK is not set # CONFIG_INLINE_WRITE_LOCK is 
+not set # CONFIG_INLINE_WRITE_LOCK_BH is not set # 
+CONFIG_INLINE_WRITE_LOCK_IRQ is not set # 
+CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set # 
+CONFIG_INLINE_WRITE_UNLOCK is not set # CONFIG_INLINE_WRITE_UNLOCK_BH 
+is not set # CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set # 
+CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set # 
+CONFIG_MUTEX_SPIN_ON_OWNER is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -289,7 +313,6 @@ CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCI_STUB is not set
 # CONFIG_PCI_IOV is not set
@@ -318,7 +341,6 @@ CONFIG_NET=y
 # Networking options
 #
 CONFIG_PACKET=y
-CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
@@ -465,10 +487,12 @@ CONFIG_IP6_NF_FILTER=y  # CONFIG_IP6_NF_RAW is not
set  # CONFIG_IP_DCCP is not set  # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 CONFIG_STP=y
 CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
@@ -526,7 +550,13 @@ CONFIG_NET_SCH_FIFO=y  # CONFIG_IRDA is not set  #
CONFIG_BT is not set  # CONFIG_AF_RXRPC is not set -# CONFIG_WIRELESS is
not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211 #
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
@@ -539,6 +569,7 @@ CONFIG_NET_SCH_FIFO=y  # Generic Driver Options  #
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -550,9 +581,9 @@ CONFIG_EXTRA_FIRMWARE=""
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
@@ -632,6 +663,11 @@ CONFIG_MTD_NAND_IDS=y  # UBI - Unsorted block
images  #  # CONFIG_MTD_UBI is not set
+CONFIG_OF_FLATTREE=y
+CONFIG_OF_ADDRESS=y
+CONFIG_OF_IRQ=y
+CONFIG_OF_DEVICE=y
+# CONFIG_OF_DEVICE_CLAIM_RESOURCES is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
@@ -641,6 +677,10 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected #
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_UB is not set
@@ -658,6 +698,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -693,6 +734,7 @@ CONFIG_SCSI_WAIT_SCAN=m  # CONFIG_SCSI_OSD_INITIATOR
is not set  CONFIG_ATA=y  # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
 # CONFIG_SATA_AHCI is not set
 # CONFIG_SATA_SIL24 is not set
@@ -714,6 +756,7 @@ CONFIG_ATA_SFF=y
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_ATIIXP is not set
 # CONFIG_PATA_CMD640_PCI is not set
 # CONFIG_PATA_CMD64X is not set
@@ -729,6 +772,7 @@ CONFIG_ATA_SFF=y
 # CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_IT8213 is not set
 # CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_LEGACY is not set
 # CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
 # CONFIG_PATA_MPIIX is not set
@@ -739,14 +783,16 @@ CONFIG_ATA_SFF=y
 # CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_PDC_OLD is not set
 # CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RDC is not set
 # CONFIG_PATA_RZ1000 is not set
 # CONFIG_PATA_SC1200 is not set
 # CONFIG_PATA_SERVERWORKS is not set
-# CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
+# CONFIG_PATA_TOSHIBA is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
@@ -763,7 +809,7 @@ CONFIG_ATA_SFF=y
 #
 
 #
-# See the help texts for more information.
+# The newer stack is recommended.
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
@@ -787,6 +833,7 @@ CONFIG_MII=y
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
 # CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
 # CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
@@ -800,6 +847,7 @@ CONFIG_MII=y
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
 # CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 # CONFIG_ATL2 is not set
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
@@ -841,16 +889,16 @@ CONFIG_CHELSIO_T3_DEPENDS=y  # CONFIG_MLX4_CORE is
not set  # CONFIG_TEHUTI is not set  # CONFIG_BNX2X is not set
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
+CONFIG_WLAN=y
+# CONFIG_ATMEL is not set
+# CONFIG_PRISM54 is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_HOSTAP is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers @@ -873,6
+921,7 @@ CONFIG_USB_RTL8150=y  # CONFIG_NETCONSOLE is not set  #
CONFIG_NETPOLL is not set  # CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
 # CONFIG_PHONE is not set
 
@@ -882,6 +931,7 @@ CONFIG_USB_RTL8150=y  CONFIG_INPUT=y  #
CONFIG_INPUT_FF_MEMLESS is not set  # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -924,6 +974,8 @@ CONFIG_INPUT_EVDEV=y  # Non-8250 serial port support
#  # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set  # CONFIG_LEGACY_PTYS is
not set @@ -945,7 +997,6 @@ CONFIG_DEVPORT=y  # CONFIG_POWER_SUPPLY is
not set  # CONFIG_HWMON is not set  # CONFIG_THERMAL is not set -#
CONFIG_THERMAL_HWMON is not set  # CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
 
@@ -961,12 +1012,15 @@ CONFIG_SSB_POSSIBLE=y  # CONFIG_MFD_SM501 is not
set  # CONFIG_HTC_PASIC3 is not set  # CONFIG_MFD_TMIO is not set
+# CONFIG_LPC_SCH is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+CONFIG_VGA_ARB=y
+CONFIG_VGA_ARB_MAX_GPUS=16
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set @@ -980,7 +1034,6 @@
CONFIG_SSB_POSSIBLE=y  # CONFIG_SOUND is not set  CONFIG_HID_SUPPORT=y
CONFIG_HID=y -# CONFIG_HID_DEBUG is not set  # CONFIG_HIDRAW is not set
 
 #
@@ -993,6 +1046,7 @@ CONFIG_USB_HIDDEV=y  #  # Special HID drivers  #
+# CONFIG_HID_3M_PCT is not set
 # CONFIG_HID_A4TECH is not set
 # CONFIG_HID_APPLE is not set
 # CONFIG_HID_BELKIN is not set
@@ -1003,15 +1057,20 @@ CONFIG_USB_HIDDEV=y  # CONFIG_HID_EZKEY is not
set  # CONFIG_HID_KYE is not set  # CONFIG_HID_GYRATION is not set
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
+# CONFIG_HID_QUANTA is not set
 # CONFIG_HID_SAMSUNG is not set
 # CONFIG_HID_SONY is not set
+# CONFIG_HID_STANTUM is not set
 # CONFIG_HID_SUNPLUS is not set
 # CONFIG_HID_GREENASIA is not set
 # CONFIG_HID_SMARTJOYPLUS is not set
@@ -1050,6 +1109,7 @@ CONFIG_USB_EHCI_HCD=y  # CONFIG_USB_OXU210HP_HCD
is not set  # CONFIG_USB_ISP116X_HCD is not set  #
CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set  #
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set @@ -1133,6 +1193,7 @@
CONFIG_USB_SERIAL_CP210X=y  # CONFIG_USB_SERIAL_NAVMAN is not set  #
CONFIG_USB_SERIAL_PL2303 is not set  # CONFIG_USB_SERIAL_OTI6858 is not
set
+# CONFIG_USB_SERIAL_QCAUX is not set
 # CONFIG_USB_SERIAL_QUALCOMM is not set  # CONFIG_USB_SERIAL_SPCP8X5 is
not set  # CONFIG_USB_SERIAL_HP4X is not set @@ -1146,6 +1207,7 @@
CONFIG_USB_SERIAL_CP210X=y  # CONFIG_USB_SERIAL_OPTION is not set  #
CONFIG_USB_SERIAL_OMNINET is not set  # CONFIG_USB_SERIAL_OPTICON is not
set
+# CONFIG_USB_SERIAL_VIVOPAY_SERIAL is not set
 # CONFIG_USB_SERIAL_DEBUG is not set
 
 #
@@ -1158,7 +1220,6 @@ CONFIG_USB_SERIAL_CP210X=y  # CONFIG_USB_RIO500 is
not set  # CONFIG_USB_LEGOTOWER is not set  # CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set  # CONFIG_USB_LED is not set  #
CONFIG_USB_CYPRESS_CY7C63 is not set  # CONFIG_USB_CYTHERM is not set @@
-1171,7 +1232,6 @@ CONFIG_USB_SERIAL_CP210X=y  # CONFIG_USB_IOWARRIOR is
not set  # CONFIG_USB_TEST is not set  # CONFIG_USB_ISIGHTFW is not set
-# CONFIG_USB_VST is not set  # CONFIG_USB_GADGET is not set
 
 #
@@ -1214,6 +1274,7 @@ CONFIG_JBD=y
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
@@ -1274,6 +1335,7 @@ CONFIG_JFFS2_ZLIB=y  # CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y  # CONFIG_JFFS2_RUBIN is not set
+# CONFIG_LOGFS is not set
 CONFIG_CRAMFS=y
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1284,7 +1346,6 @@ CONFIG_CRAMFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -1299,6 +1360,7 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1360,6 +1422,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
@@ -1393,15 +1456,25 @@ CONFIG_DEBUG_INFO=y  # CONFIG_DEBUG_LIST is not
set  # CONFIG_DEBUG_SG is not set  # CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set  #
CONFIG_BACKTRACE_SELF_TEST is not set  # CONFIG_DEBUG_BLOCK_EXT_DEVT is
not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set # CONFIG_LKDTM is not set
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
@@ -1410,6 +1483,7 @@ CONFIG_FTRACE=y
 CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set  #
CONFIG_PROFILE_ALL_BRANCHES is not set
+# CONFIG_STACK_TRACER is not set
 # CONFIG_KMEMTRACE is not set
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -1417,12 +1491,13 @@ CONFIG_BRANCH_PROFILE_NONE=y  # CONFIG_SAMPLES
is not set  CONFIG_HAVE_ARCH_KGDB=y  # CONFIG_KGDB is not set -#
CONFIG_KMEMCHECK is not set
+# CONFIG_EARLY_PRINTK is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="rw dhash_entries=1024 ihash_entries=1024
ip=10.0.1.3:10.0.1.1:10.0.1.1:255.255.255.0:zeus:eth0: root=/dev/nfs
nfsroot=/nfsroot/cramfs,wsize=512,rsize=512,tcp nokgdb
console=ttyUSB0,115200 memsize=252M"
 # CONFIG_CMDLINE_OVERRIDE is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_RUNTIME_DEBUG is not set
+# CONFIG_SPINLOCK_TEST is not set
 
 #
 # Security options
@@ -1430,13 +1505,16 @@ CONFIG_CMDLINE="rw dhash_entries=1024
ihash_entries=1024 ip=10.0.1.3:10.0.1.1:10  # CONFIG_KEYS is not set  #
CONFIG_SECURITY is not set  # CONFIG_SECURITYFS is not set -#
CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set # 
+CONFIG_DEFAULT_SECURITY_SMACK is not set # 
+CONFIG_DEFAULT_SECURITY_TOMOYO is not set CONFIG_DEFAULT_SECURITY_DAC=y

+CONFIG_DEFAULT_SECURITY=""
 CONFIG_CRYPTO=y
 
 #
 # Crypto core or helper
 #
-# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_ALGAPI2=y
 CONFIG_CRYPTO_AEAD=y
@@ -1479,11 +1557,13 @@ CONFIG_CRYPTO_CBC=y  #  CONFIG_CRYPTO_HMAC=y  #
CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
diff --git a/arch/mips/include/asm/mach-powertv/asic.h
b/arch/mips/include/asm/mach-powertv/asic.h
index bcad43a..42f02da 100644
--- a/arch/mips/include/asm/mach-powertv/asic.h
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -1,5 +1,9 @@
 /*
- * Copyright (C) 2009  Cisco Systems, Inc.
+ * asic.h
+ *
+ * ASIC and resource specific information
+ *
+ * Copyright (C) 2009, Cisco Systems, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -20,7 +24,9 @@  #define _ASM_MACH_POWERTV_ASIC_H
 
 #include <linux/ioport.h>
+
 #include <asm/mach-powertv/asic_regs.h>
+#include <asm/mach-powertv/mdesc.h>
 
 #define DVR_CAPABLE     (1<<0)
 #define PCIE_CAPABLE    (1<<1)
diff --git a/arch/mips/include/asm/mach-powertv/mdesc.h
b/arch/mips/include/asm/mach-powertv/mdesc.h
new file mode 100644
index 0000000..d7dda02
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/mdesc.h
@@ -0,0 +1,51 @@
+/*
+ * mdesc.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
02110-1301  USA
+ */
+
+#ifndef _ASM_MACH_POWERTV_MDESC_H
+#define _ASM_MACH_POWERTV_MDESC_H
+
+#define MEM_EXTENT_MAX		8
+
+enum Memory_Type {
+	MEM_EXTENT_OTHER,
+	MEM_EXTENT_LOW,
+	MEM_EXTENT_HIGH
+};
+
+struct mem_desc {
+	int nr_extent;
+	unsigned long mem_size;
+	struct mem_extent {
+		unsigned long phys_base;
+		unsigned long bus_base;
+		unsigned long size;
+		enum Memory_Type type;
+	} extent[MEM_EXTENT_MAX];
+};
+
+extern struct mem_desc mdesc;
+
+extern bool is_bus_low(unsigned long addr);
+
+extern int mem_desc_add(unsigned long phys_base, unsigned long
bus_base,
+		unsigned long size, enum Memory_Type type); extern void 
+mem_desc_init(void);
+
+#endif /* _ASM_MACH_POWERTV_MDESC_H */
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
index 0a0d73c..b1fce78 100644
--- a/arch/mips/powertv/Makefile
+++ b/arch/mips/powertv/Makefile
@@ -23,6 +23,6 @@
 # under Linux.
 #
 
-obj-y += init.o memory.o reset.o time.o powertv_setup.o asic/ pci/
+obj-y += init.o memory.o reset.o time.o powertv_setup.o mdesc.o asic/
pci/
 
 EXTRA_CFLAGS += -Wall -Werror
diff --git a/arch/mips/powertv/asic/asic_devices.c
b/arch/mips/powertv/asic/asic_devices.c
index 2174242..6b5f1e1 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -528,28 +528,6 @@ void __init configure_platform(void)
 		pr_crit("Platform:  UNKNOWN PLATFORM\n");
 		break;
 	}
-
-	switch (asic) {
-	case ASIC_ZEUS:
-		phys_to_bus_offset = 0x30000000;
-		break;
-	case ASIC_CALLIOPE:
-		phys_to_bus_offset = 0x10000000;
-		break;
-	case ASIC_CRONUSLITE:
-		/* Fall through */
-	case ASIC_CRONUS:
-		/*
-		 * TODO: We suppose 0x10000000 aliases into 0x20000000-
-		 * 0x2XXXXXXX. If 0x10000000 aliases into 0x60000000-
-		 * 0x6XXXXXXX, the offset should be 0x50000000, not
0x10000000.
-		 */
-		phys_to_bus_offset = 0x10000000;
-		break;
-	default:
-		phys_to_bus_offset = 0x00000000;
-		break;
-	}
 }
 
 /**
diff --git a/arch/mips/powertv/mdesc.c b/arch/mips/powertv/mdesc.c new
file mode 100644 index 0000000..7646292
--- /dev/null
+++ b/arch/mips/powertv/mdesc.c
@@ -0,0 +1,224 @@
+/*
+ * Copyright (C) 2010 Cisco Systems Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.
+ */
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+#include <asm/prom.h>
+#include <asm/mach-powertv/mdesc.h>
+
+struct mem_desc mdesc;
+
+/*
+ * Determine whether the given bus address is in a low bank or not.
+ * Params:  addr    the bus address to check
+ * Returns: true if the bus address is in low, false if it isn't.
+ */
+bool is_bus_low(unsigned long addr)
+{
+	int i;
+
+	for (i = 0; i < mdesc.nr_extent; i++) {
+		if ((mdesc.extent[i].type == MEM_EXTENT_LOW) &&
+			((addr >= mdesc.extent[i].bus_base) &&
+			 (addr < (mdesc.extent[i].bus_base +
+					  mdesc.extent[i].size))))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(is_bus_low);
+
+int __init mem_desc_add(unsigned long phys_base, unsigned long
bus_base,
+		unsigned long size, enum Memory_Type type) {
+	if (mdesc.nr_extent >= MEM_EXTENT_MAX) {
+		pr_err("mem_desc_add: The number of extents is too
big!!!\n");
+		return -1;
+	}
+
+	if (size == 0) {
+		pr_err("mem_desc_add: Wrong memory size...\n");
+		return -1;
+	}
+
+	switch (type) {
+	case MEM_EXTENT_OTHER:
+		break;
+	case MEM_EXTENT_LOW:
+		mdesc.mem_size += size;
+		break;
+	case MEM_EXTENT_HIGH:
+#ifdef CONFIG_HIGHMEM
+		mdesc.mem_size += size;
+#endif
+		break;
+	default:
+		pr_err("mem_desc_add: Wrong memory type...\n");
+		return -1;
+	}
+
+	mdesc.extent[mdesc.nr_extent].phys_base = phys_base;
+	mdesc.extent[mdesc.nr_extent].bus_base = bus_base;
+	mdesc.extent[mdesc.nr_extent].size = size;
+	mdesc.extent[mdesc.nr_extent].type = type;
+
+	mdesc.nr_extent++;
+
+	return 0;
+}
+
+void __init mem_desc_init(void)
+{
+	memset(&mdesc, 0, sizeof(mdesc));
+}
+
+#ifdef CONFIG_ARCH_HAS_DEVTREE_MEM
+typedef u32 cell_t;
+
+static int num_addr_cells;
+static int num_size_cells;
+
+static int num_extent;
+
+static inline int log10_extent(int nb)
+{
+	if (nb / 100)
+		return 3;
+	if (nb / 10)
+		return 2;
+	return 1;
+}
+
+static int __init early_init_dt_scan_extent(unsigned long node,
+		const char *uname, int depth, void *data) {
+	char buf[8 + log10_extent(MEM_EXTENT_MAX)];
+	unsigned long l;
+	char *memory_type;
+	enum Memory_Type type;
+	cell_t *reg, *endp;
+	unsigned long phys_base, bus_base;
+	unsigned long size;
+
+	snprintf(buf, sizeof(buf), "memory@%d", num_extent);
+
+	if (strcmp(uname, buf) != 0)
+		return 0;
+
+	memory_type = of_get_flat_dt_prop(node, "memory_type", &l);
+	if (memory_type == NULL || l <= 0)
+		return 0;
+
+	if (strcmp(memory_type, "low") == 0)
+		type = MEM_EXTENT_LOW;
+	else if (strcmp(memory_type, "high") == 0)
+		type = MEM_EXTENT_HIGH;
+	else
+		type = MEM_EXTENT_OTHER;
+
+	reg = (cell_t *)of_get_flat_dt_prop(node, "reg", &l);
+	if (reg == NULL)
+		return 0;
+
+	endp = reg + (l / sizeof(cell_t));
+
+	pr_info("memory scan node %s, reg size %ld, data: %x %x %x \n",
+			uname, l, reg[0], reg[1], reg[2]);
+
+	while ((endp - reg) >= (num_addr_cells + num_size_cells)) {
+		phys_base = dt_mem_next_cell(1, &reg);
+		bus_base = dt_mem_next_cell(1, &reg);
+		size = dt_mem_next_cell(1, &reg);
+		if (size == 0)
+			continue;
+		mem_desc_add(phys_base, bus_base, size, type);
+	}
+
+	return 1;
+}
+
+int __init early_init_dt_scan_memory_arch(unsigned long node,
+		const char *uname, int depth, void *data) {
+	u32 *prop;
+
+	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
+	num_addr_cells = (prop == NULL) ? 2 : *prop;
+
+	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
+	num_size_cells = (prop == NULL) ? 1 : *prop;
+
+	do {
+		if (!of_scan_flat_dt(early_init_dt_scan_extent, NULL))
+			break;
+		num_extent++;
+	} while (num_extent < MEM_EXTENT_MAX);
+
+	return 0;
+}
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size) { }
+
+/*
+ * The memory used by device tree blob may not be in the low system
memory.
+ * If it is, the area of memory should be reserved by bootmem allocator
in
+ * our platform; if not, i.e. the area of memory is in the bootloader
area,
+ * no reservation is needed.
+ */
+int __init reserve_mem_mach(unsigned long addr, unsigned long size) {
+	int i;
+
+	for (i = 0; i < mdesc.nr_extent; i++) {
+		if ((mdesc.extent[i].type == MEM_EXTENT_LOW) &&
+			((addr >= mdesc.extent[i].phys_base) &&
+			 (addr < (mdesc.extent[i].phys_base +
+					  mdesc.extent[i].size)))) {
+			return reserve_bootmem(addr, size,
BOOTMEM_DEFAULT);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * The same thing happens in freeing memory, please refer to comments
in
+ * arch_reserve_mem.
+ */
+void __init free_mem_mach(unsigned long addr, unsigned long size) {
+	int i;
+
+	for (i = 0; i < mdesc.nr_extent; i++) {
+		if ((mdesc.extent[i].type == MEM_EXTENT_LOW) &&
+			((addr >= mdesc.extent[i].phys_base) &&
+			 (addr < (mdesc.extent[i].phys_base +
+					  mdesc.extent[i].size)))) {
+			free_bootmem(addr, size);
+			break;
+		}
+	}
+}
+#endif
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index f49eb3d..de89772 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -24,12 +24,16 @@
 #include <linux/bootmem.h>
 #include <linux/pfn.h>
 #include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/prom.h>
 
 #include <asm/mips-boards/prom.h>
+#include <asm/mach-powertv/asic.h>
 
 #include "init.h"
 
@@ -46,36 +50,59 @@ char __initdata cmdline[COMMAND_LINE_SIZE];
 
 void __init prom_meminit(void)
 {
-	char *memsize_str;
-	unsigned long memsize = 0;
-	unsigned int physend;
 	char *ptr;
+	unsigned long memsize = 0;
+	char *memsize_str;
 	int low_mem;
-	int high_mem;
+	int i;
+
+	/* Initialize the memory description */
+	mem_desc_init();
 
-	/* Check the command line first for a memsize directive */
-	strcpy(cmdline, arcs_cmdline);
-	ptr = strstr(cmdline, "memsize=");
-	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
-		ptr = strstr(ptr, " memsize=");
+	/* Check the command line first for a devicetree directive */
+	strncpy(cmdline, arcs_cmdline, COMMAND_LINE_SIZE - 1);
 
+#ifdef CONFIG_OF
+	ptr = strstr(cmdline, "devicetree=");
+ 	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+		ptr = strstr(ptr, " devicetree=");
 	if (ptr) {
-		memsize = memparse(ptr + 8, &ptr);
-	} else {
-		/* otherwise look in the environment */
-		memsize_str = prom_getenv("memsize");
-
-		if (memsize_str != NULL) {
-			pr_info("prom memsize = %s\n", memsize_str);
-			memsize = simple_strtol(memsize_str, NULL, 0);
-		}
+		char buf[11];
+		unsigned long devtree;
+		memcpy(buf, ptr + 11, 10);
+		buf[10] = '\0';
+		strict_strtoul(buf, 16, &devtree);
+		early_init_devtree((void *)devtree);
+		memsize = mdesc.mem_size;
+	}
+#endif
 
-		if (memsize == 0) {
-			if (_prom_memsize != 0) {
+	/*
+	 * For backward compatibility (the device tree is not
+	 * supported), we still check the command line for a
+	 * memsize directive.
+	 */
+	if (0 == memsize) {
+		ptr = strstr(cmdline, "memsize=");
+		if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+			ptr = strstr(ptr, " memsize=");
+
+		if (ptr) {
+			memsize = memparse(ptr + 8, &ptr);
+		} else {
+			/* otherwise look in the environment */
+			memsize_str = prom_getenv("memsize");
+
+			if (memsize_str != NULL) {
+				pr_info("prom memsize = %s\n",
memsize_str);
+				strict_strtol(memsize_str, 10,
&memsize);
+			} else if (_prom_memsize != 0) {
 				memsize = _prom_memsize;
 				pr_info("_prom_memsize = 0x%lx\n",
memsize);
-				/* add in memory that the bootloader
doesn't
-				 * report */
+				/*
+				 * add in memory that the bootloader
+				 * doesn't report
+				 */
 				memsize += BOOT_MEM_SIZE;
 			} else {
 				memsize = DEFAULT_MEMSIZE;
@@ -83,86 +110,107 @@ void __init prom_meminit(void)
 					"defaulting to 0x%lx\n",
memsize);
 			}
 		}
-	}
 
-	physend = PFN_ALIGN(&_end) - 0x80000000;
-	if (memsize > LOW_MEM_MAX) {
-		low_mem = LOW_MEM_MAX;
-		high_mem = memsize - low_mem;
-	} else {
-		low_mem = memsize;
-		high_mem = 0;
+		if (memsize > LOW_MEM_MAX)
+			low_mem = LOW_MEM_MAX;
+		else
+			low_mem = memsize;
+
+		switch (platform_get_family()) {
+		case FAMILY_1500:
+		case FAMILY_1500VZE:
+		case FAMILY_1500VZF:
+			/* generally used by the kernel in low. */
+			mem_desc_add(PHYS_MEM_START,
+					0x20000000,
+					low_mem,
+					MEM_EXTENT_LOW);
+			/* reserved for reset vector. */
+			mem_desc_add(0x1fc00000,
+					0x07fcffff,
+					MEBIBYTE(4),
+					MEM_EXTENT_OTHER);
+			break;
+		case FAMILY_4500:
+		case FAMILY_8500:
+		case FAMILY_8500RNG:
+			/* generally used by the kernel in low. */
+			mem_desc_add(PHYS_MEM_START,
+					0x40000000,
+					low_mem,
+					MEM_EXTENT_LOW);
+			/* reserved for reset vector. */
+			mem_desc_add(0x1fc00000,
+					0x07fcffff,
+					MEBIBYTE(4),
+					MEM_EXTENT_OTHER);
+			break;
+		case FAMILY_4600:
+		case FAMILY_4600VZA:
+		case FAMILY_8600:
+		case FAMILY_8600VZB:
+			/* generally used by the kernel in low. */
+			mem_desc_add(PHYS_MEM_START,
+					0x20000000,
+					low_mem,
+					MEM_EXTENT_LOW);
+			/* reserved for reset vector. */
+			mem_desc_add(0x1fc00000,
+					0x07fcffff,
+					MEBIBYTE(4),
+					MEM_EXTENT_OTHER);
+#ifdef CONFIG_HIGHMEM
+			/* generally used by the kernel in high. */
+			mem_desc_add(0x60000000,
+					0x60000000,
+					MEBIBYTE(128),
+					MEM_EXTENT_HIGH);
+#endif
+			break;
+		default:
+			/* generally used by the kernel in low. */
+			mem_desc_add(PHYS_MEM_START,
+					0x20000000,
+					MEBIBYTE(128),
+					MEM_EXTENT_LOW);
+			break;
+		}
 	}
 
-/*
- * TODO: We will use the hard code for memory configuration until
- * the bootloader releases their device tree to us.
- */
-	/*
-	 * Add the memory reserved for use by the bootloader to the
-	 * memory map.
-	 */
-	add_memory_region(PHYS_MEM_START, RES_BOOTLDR_MEMSIZE,
-		BOOT_MEM_RESERVED);
-#ifdef CONFIG_HIGHMEM_256_128
-	/*
-	 * Add memory in low for general use by the kernel and its
friends
-	 * (like drivers, applications, etc).
-	 */
-	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
-		LOW_MEM_MAX - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
-	/*
-	 * Add the memory reserved for reset vector.
-	 */
-	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
-	/*
-	 * Add the memory reserved.
-	 */
-	add_memory_region(0x20000000, MEBIBYTE(1024 + 75),
BOOT_MEM_RESERVED);
-	/*
-	 * Add memory in high for general use by the kernel and its
friends
-	 * (like drivers, applications, etc).
-	 *
-	 * 75MB is reserved for devices which are using the memory in
high.
-	 */
-	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
-		BOOT_MEM_RAM);
-#elif defined CONFIG_HIGHMEM_128_128
-	/*
-	 * Add memory in low for general use by the kernel and its
friends
-	 * (like drivers, applications, etc).
-	 */
-	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
-		MEBIBYTE(128) - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
-	/*
-	 * Add the memory reserved.
-	 */
-	add_memory_region(PHYS_MEM_START + MEBIBYTE(128),
-		MEBIBYTE(128 + 1024 + 75), BOOT_MEM_RESERVED);
-	/*
-	 * Add memory in high for general use by the kernel and its
friends
-	 * (like drivers, applications, etc).
-	 *
-	 * 75MB is reserved for devices which are using the memory in
high.
-	 */
-	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
-		BOOT_MEM_RAM);
+	/* Initialize the Boot Memory Map */
+	for (i = 0; i < mdesc.nr_extent; i++) {
+		unsigned long start = mdesc.extent[i].phys_base;
+		unsigned long size = mdesc.extent[i].size;
+		long type;
+		switch (mdesc.extent[i].type) {
+		case MEM_EXTENT_LOW:
+			phys_to_bus_offset = mdesc.extent[i].bus_base -
start;
+			/* reserved for bootloader. */
+			add_memory_region(start,
+					BOOT_MEM_SIZE,
+					BOOT_MEM_RESERVED);
+			/*
+			 * adjust the number of low memory after the
+			 * space is reserved for bootloader.
+			 */
+			start += BOOT_MEM_SIZE;
+			size -= BOOT_MEM_SIZE;
+			type = BOOT_MEM_RAM;
+			break;
+		case MEM_EXTENT_HIGH:
+#ifdef CONFIG_HIGHMEM
+			type = BOOT_MEM_RAM;
 #else
-	/* Add low memory regions for either:
-	 *   - no-highmemory configuration case -OR-
-	 *   - highmemory "HIGHMEM_LOWBANK_ONLY" case
-	 */
-	/*
-	 * Add memory for general use by the kernel and its friends
-	 * (like drivers, applications, etc).
-	 */
-	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
-		low_mem - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
-	/*
-	 * Add the memory reserved for reset vector.
-	 */
-	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
+			type = BOOT_MEM_RESERVED;
 #endif
+			break;
+		case MEM_EXTENT_OTHER:
+		default:
+			type = BOOT_MEM_RESERVED;
+			break;
+		}
+		add_memory_region(start, size, type);
+	}
 }
 
 void __init prom_free_prom_memory(void)
--
1.6.0.6
