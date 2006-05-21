Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2006 12:53:52 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:12292 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133356AbWEUKxV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 May 2006 12:53:21 +0200
Received: from diimka-laptop.dev.rtsoft.ru ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k4LAr9s13002;
	Sun, 21 May 2006 15:53:10 +0500
Subject: [PATCH] NEC EMMA2RH support, revisited
From:	dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: montavista
Date:	Sun, 21 May 2006 14:53:06 +0400
Message-Id: <1148208787.6884.9.camel@diimka-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Return-Path: <dpervushin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpervushin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf, 

The patch below is to support NEC EMMA2RH Mark-eins board (R5500-based)
Thanks for helping and valuable comments:
 	the whole linux-mips comminuty
	Ralf Baechle
	Martin Michlmayr
	Thiemo Seufer

Signed-off-by: dmitry pervushin  <dpervushin@ru.mvista.com>
 arch/mips/Kconfig                         |   22 
 arch/mips/Makefile                        |    9 
 arch/mips/configs/emma2rh_defconfig       | 1126 ++++++++++++++++++++++++++++++
 arch/mips/emma2rh/common/Makefile         |   13 
 arch/mips/emma2rh/common/irq.c            |  108 ++
 arch/mips/emma2rh/common/irq_emma2rh.c    |  135 +++
 arch/mips/emma2rh/common/prom.c           |   77 ++
 arch/mips/emma2rh/markeins/Makefile       |   13 
 arch/mips/emma2rh/markeins/irq.c          |  136 +++
 arch/mips/emma2rh/markeins/irq_markeins.c |  198 +++++
 arch/mips/emma2rh/markeins/led.c          |   60 +
 arch/mips/emma2rh/markeins/platform.c     |  170 ++++
 arch/mips/emma2rh/markeins/setup.c        |  195 +++++
 arch/mips/pci/Makefile                    |    1 
 arch/mips/pci/fixup-emma2rh.c             |  102 ++
 arch/mips/pci/ops-emma2rh.c               |  186 ++++
 arch/mips/pci/pci-emma2rh.c               |   90 ++
 include/asm-mips/bootinfo.h               |    6 
 include/asm-mips/emma2rh/emma2rh.h        |  332 ++++++++
 include/asm-mips/emma2rh/markeins.h       |   76 ++
 include/asm-mips/mach-emma2rh/irq.h       |   13 
 21 files changed, 3068 insertions(+)

Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -543,6 +543,23 @@ config QEMU
 	  simulate actual MIPS hardware platforms.  More information on Qemu
 	  can be found at http://www.linux-mips.org/wiki/Qemu.
 
+config MARKEINS
+	bool "Support for NEC EMMA2RH Mark-eins"
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_CPU_R5000
+	help
+	  This enables support for the R5432-based NEC Mark-eins
+	  boards with R5500 CPU.
+
+	  Features: kernel debugging, serial terminal, NFS root fs, on-board
+	  ether port USB, PCI, etc.
+
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
 	select ARC
@@ -976,6 +993,11 @@ config SOC_PNX8550
 config SWAP_IO_SPACE
 	bool
 
+config EMMA2RH
+	bool
+	depends on MARKEINS
+	default y
+
 #
 # Unfortunately not all GT64120 systems run the chip at the same clock.
 # As the user for the clock rate and try to minimize the available options.
Index: linux/arch/mips/configs/emma2rh_defconfig
===================================================================
--- /dev/null
+++ linux/arch/mips/configs/emma2rh_defconfig
@@ -0,0 +1,1126 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10_mvl401
+# Tue May 16 15:39:03 2006
+#
+CONFIG_MIPS=y
+# CONFIG_MIPS64 is not set
+# CONFIG_64BIT is not set
+CONFIG_MIPS32=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+# CONFIG_CLEAN_COMPILE is not set
+CONFIG_BROKEN=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SEMMNI=128
+CONFIG_SYSVIPC_SEMMSL=250
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_LTT_MAX_HANDLES=128
+# CONFIG_BOOT_FLIGHT_RECORDER is not set
+CONFIG_LOCKLESS=y
+CONFIG_BOOT_FLIGHT_BUFFERS=4
+CONFIG_BOOT_FLIGHT_SIZE=524288
+CONFIG_FLIGHT_PROC_BUFFERS=8
+CONFIG_FLIGHT_PROC_SIZE=8192
+CONFIG_NEWEV=y
+CONFIG_CSTM=y
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_MIPS_BRCM is not set
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_LASAT is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_MOMENCO_OCELOT_C is not set
+# CONFIG_MOMENCO_OCELOT_3 is not set
+# CONFIG_PNX8550_V2PCI is not set
+# CONFIG_PNX8550_JBS is not set
+# CONFIG_PNX8550_STB810 is not set
+# CONFIG_MOMENCO_JAGUAR_ATX is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+# CONFIG_VR5701_SG2 is not set
+# CONFIG_NEC_OSPREY is not set
+CONFIG_MARKEINS=y
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SOC_AU1X00 is not set
+# CONFIG_SIBYTE_SB1xxx_SOC is not set
+# CONFIG_SNI_RM200_PCI is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_TOSHIBA_RBTX4939 is not set
+# CONFIG_CAVIUM_OCTEON_EBT3000 is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT_DESKTOP=y
+# CONFIG_PREEMPT_RT is not set
+CONFIG_PREEMPT=y
+# CONFIG_PREEMPT_SOFTIRQS is not set
+# CONFIG_PREEMPT_HARDIRQS is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_SPINLOCK_BKL is not set
+CONFIG_PREEMPT_BKL=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ASM_SEMAPHORES=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_DMA_NONCOHERENT=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_IRQ_CPU=y
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_EMMA2RH=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+CONFIG_CPU_MIPS32=y
+# CONFIG_CPU_MIPS64 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+# CONFIG_VTAG_ICACHE is not set
+# CONFIG_64BIT_PHYS_ADDR is not set
+# CONFIG_CPU_ADVANCED is not set
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HIGH_RES_RESOLUTION=10000
+CONFIG_CPU_TIMER=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_LEGACY_PROC is not set
+CONFIG_PCI_NAMES=y
+CONFIG_MMU=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
+# CONFIG_BINFMT_IRIX is not set
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
+# CONFIG_FW_LOADER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
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
+CONFIG_MTD_CFI_AMDSTD_RETRY=0
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+# CONFIG_MTD_XIP is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x1e000000
+CONFIG_MTD_PHYSMAP_LEN=0x02000000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+# CONFIG_MTD_MULTI_PHYSMAP is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_RAMTD is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_CRYPTOLOOP=m
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_LBD=y
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=m
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+CONFIG_CHR_DEV_SG=m
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_ADP94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_CPQFCTS is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_PCI2000 is not set
+# CONFIG_SCSI_PCI2220I is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=m
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA6322 is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_USE_POLICY_FWD=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+# CONFIG_IP_ROUTE_FWMARK is not set
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_IP_TCPDIAG is not set
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_ADVANCED_ROUTER is not set
+# CONFIG_IPV6_MIP6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
+# CONFIG_IP_NF_COMPAT_IPFWADM is not set
+
+#
+# IPv6: Netfilter Configuration
+#
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
+# CONFIG_IP6_NF_CONNTRACK is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_ENHANCEMENT is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_SCTP=m
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=m
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_SMC91X is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+
+#
+# Broadcom network devices
+#
+# CONFIG_HND is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+CONFIG_NATSEMI=y
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PPP=m
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPPOE is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_TSLIBDEV is not set
+CONFIG_INPUT_EVDEV=m
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+# CONFIG_SERIO_I8042 is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_RTC=m
+# CONFIG_RTC_HISTOGRAM is not set
+# CONFIG_BLOCKER is not set
+CONFIG_GEN_RTC=m
+CONFIG_GEN_RTC_X=y
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+# CONFIG_I2C_ALGO_SGI is not set
+# CONFIG_I2C_ALGO_EMMA2RH is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+# CONFIG_I2C_OMAP is not set
+# CONFIG_I2C_EMMA2RH is not set
+
+#
+# Hardware Sensors Chip support
+#
+# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_TPS65010 is not set
+CONFIG_I2C_DEBUG_CORE=y
+# CONFIG_I2C_DEBUG_ALGO is not set
+CONFIG_I2C_DEBUG_BUS=y
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+
+#
+# Enable Host or Gadget support to see Inventra options
+#
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# Synchronous Serial Interfaces (SSI)
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+CONFIG_XFS_FS=m
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_SECURITY is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=m
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
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_NTFS_FS=m
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS_XATTR=y
+CONFIG_DEVPTS_FS_SECURITY=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_TMPFS_SECURITY=y
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+CONFIG_CRAMFS=y
+# CONFIG_CRAMFS_LINEAR is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_YAFFS_FS is not set
+# CONFIG_YAFFS1_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_DIRECTIO=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+CONFIG_NFSD_TCP=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT=""
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=m
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=m
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_WAKEUP_TIMING is not set
+# CONFIG_CRITICAL_PREEMPT_TIMING is not set
+# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
+CONFIG_CROSSCOMPILE=y
+CONFIG_CMDLINE="console=ttyS0,115200 mem=192m ip=bootp root=/dev/nfs rw"
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+
+#
+# Fast Real-Time Domain
+#
+# CONFIG_FRD is not set
+
+#
+# Fast Real-Time Domain Advanced Options
+#
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
Index: linux/arch/mips/emma2rh/common/Makefile
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/common/Makefile
@@ -0,0 +1,13 @@
+#
+#  arch/mips/emma2rh/common/Makefile
+#       Makefile for the common code of NEC EMMA2RH based board.
+#
+#  Copyright (C) NEC Electronics Corporation 2005-2006
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+
+obj-$(CONFIG_MARKEINS)	+= irq.o irq_emma2rh.o prom.o
Index: linux/arch/mips/emma2rh/common/irq.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/common/irq.c
@@ -0,0 +1,108 @@
+/*
+ *  arch/mips/emma2rh/common/irq.c
+ *      This file is common irq dispatcher.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2005-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+
+#include <asm/i8259.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/debug.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+/*
+ * the first level int-handler will jump here if it is a emma2rh irq
+ */
+asmlinkage void emma2rh_irq_dispatch(struct pt_regs *regs)
+{
+	u32 intStatus;
+	u32 bitmask;
+	u32 i;
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_0)
+	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_0);
+
+#ifdef EMMA2RH_SW_CASCADE
+	if (intStatus &
+	    (1 << ((EMMA2RH_SW_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
+		u32 swIntStatus;
+		swIntStatus = emma2rh_in32(EMMA2RH_BHIF_SW_INT)
+		    & emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
+		for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
+			if (swIntStatus & bitmask) {
+				do_IRQ(EMMA2RH_SW_IRQ_BASE + i, regs);
+				return;
+			}
+		}
+	}
+#endif
+
+	for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i, regs);
+			return;
+		}
+	}
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_1)
+	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_1);
+
+#ifdef EMMA2RH_GPIO_CASCADE
+	if (intStatus &
+	    (1 << ((EMMA2RH_GPIO_CASCADE - EMMA2RH_IRQ_INT0) & (32 - 1)))) {
+		u32 gpioIntStatus;
+		gpioIntStatus = emma2rh_in32(EMMA2RH_GPIO_INT_ST)
+		    & emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+		for (i = 0, bitmask = 1; i < 32; i++, bitmask <<= 1) {
+			if (gpioIntStatus & bitmask) {
+				do_IRQ(EMMA2RH_GPIO_IRQ_BASE + i, regs);
+				return;
+			}
+		}
+	}
+#endif
+
+	for (i = 32, bitmask = 1; i < 64; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i, regs);
+			return;
+		}
+	}
+
+	intStatus = emma2rh_in32(EMMA2RH_BHIF_INT_ST_2)
+	    & emma2rh_in32(EMMA2RH_BHIF_INT_EN_2);
+
+	for (i = 64, bitmask = 1; i < 96; i++, bitmask <<= 1) {
+		if (intStatus & bitmask) {
+			do_IRQ(EMMA2RH_IRQ_BASE + i, regs);
+			return;
+		}
+	}
+}
Index: linux/arch/mips/emma2rh/common/irq_emma2rh.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/common/irq_emma2rh.c
@@ -0,0 +1,135 @@
+/*
+ *  arch/mips/emma2rh/common/irq_emma2rh.c
+ *      This file defines the irq handler for EMMA2RH.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2005-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq_5477.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * EMMA2RH defines 64 IRQs.
+ *
+ * This file exports one function:
+ *	emma2rh_irq_init(u32 irq_base);
+ */
+
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+/* number of total irqs supported by EMMA2RH */
+#define	NUM_EMMA2RH_IRQ		96
+
+static int emma2rh_irq_base = -1;
+
+void ll_emma2rh_irq_enable(int);
+void ll_emma2rh_irq_disable(int);
+
+static void emma2rh_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_irq_enable(irq - emma2rh_irq_base);
+}
+
+static void emma2rh_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
+}
+
+static unsigned int emma2rh_irq_startup(unsigned int irq)
+{
+	emma2rh_irq_enable(irq);
+	return 0;
+}
+
+#define	emma2rh_irq_shutdown	emma2rh_irq_disable
+
+static void emma2rh_irq_ack(unsigned int irq)
+{
+	/* disable interrupt - some handler will re-enable the irq
+	 * and if the interrupt is leveled, we will have infinite loop
+	 */
+	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
+}
+
+static void emma2rh_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		ll_emma2rh_irq_enable(irq - emma2rh_irq_base);
+}
+
+hw_irq_controller emma2rh_irq_controller = {
+	.typename = "emma2rh_irq",
+	.startup = emma2rh_irq_startup,
+	.shutdown = emma2rh_irq_shutdown,
+	.enable = emma2rh_irq_enable,
+	.disable = emma2rh_irq_disable,
+	.ack = emma2rh_irq_ack,
+	.end = emma2rh_irq_end,
+	.set_affinity = NULL	/* no affinity stuff for UP */
+};
+
+void emma2rh_irq_init(u32 irq_base)
+{
+	extern irq_desc_t irq_desc[];
+	u32 i;
+
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = NULL;
+		irq_desc[i].depth = 1;
+		irq_desc[i].handler = &emma2rh_irq_controller;
+	}
+
+	emma2rh_irq_base = irq_base;
+}
+
+void ll_emma2rh_irq_enable(int emma2rh_irq)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	reg_index = EMMA2RH_BHIF_INT_EN_0
+	    + (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0)
+	    * (emma2rh_irq / 32);
+	reg_value = emma2rh_in32(reg_index);
+	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	db_assert((reg_value & reg_bitmask) == 0);
+	emma2rh_out32(reg_index, reg_value | reg_bitmask);
+}
+
+void ll_emma2rh_irq_disable(int emma2rh_irq)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	reg_index = EMMA2RH_BHIF_INT_EN_0
+	    + (EMMA2RH_BHIF_INT_EN_1 - EMMA2RH_BHIF_INT_EN_0)
+	    * (emma2rh_irq / 32);
+	reg_value = emma2rh_in32(reg_index);
+	reg_bitmask = 0x1 << (emma2rh_irq % 32);
+	db_assert((reg_value & reg_bitmask) != 0);
+	emma2rh_out32(reg_index, reg_value & ~reg_bitmask);
+}
Index: linux/arch/mips/emma2rh/common/prom.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/common/prom.c
@@ -0,0 +1,77 @@
+/*
+ *  arch/mips/emma2rh/common/prom.c
+ *      This file is prom file.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/common/prom.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/emma2rh/emma2rh.h>
+#include <asm/debug.h>
+
+const char *get_system_type(void)
+{
+	switch (mips_machtype) {
+	case MACH_NEC_MARKEINS:
+		return "NEC EMMA2RH Mark-eins";
+	default:
+		return "Unknown NEC board";
+	}
+}
+
+/* [jsun@junsun.net] PMON passes arguments in C main() style */
+void __init prom_init(void)
+{
+	int argc = fw_arg0;
+	char **arg = (char **)fw_arg1;
+	int i;
+
+	/* if user passes kernel args, ignore the default one */
+	if (argc > 1)
+		arcs_cmdline[0] = '\0';
+
+	/* arg[0] is "g", the rest is boot parameters */
+	for (i = 1; i < argc; i++) {
+		if (strlen(arcs_cmdline) + strlen(arg[i] + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, arg[i]);
+		strcat(arcs_cmdline, " ");
+	}
+
+	mips_machgroup = MACH_GROUP_NEC_EMMA2RH;
+
+#if defined(CONFIG_MARKEINS)
+	mips_machtype = MACH_NEC_MARKEINS;
+	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
+#endif
+
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
Index: linux/arch/mips/emma2rh/markeins/Makefile
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/markeins/Makefile
@@ -0,0 +1,13 @@
+#
+#  arch/mips/emma2rh/markeins/Makefile
+#       Makefile for the common code of NEC EMMA2RH based board.
+#
+#  Copyright (C) NEC Electronics Corporation 2005-2006
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+
+obj-$(CONFIG_MARKEINS) += irq.o irq_markeins.o setup.o led.o platform.o
Index: linux/arch/mips/emma2rh/markeins/irq.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/markeins/irq.c
@@ -0,0 +1,136 @@
+/*
+ *  arch/mips/emma2rh/markeins/irq.c
+ *      This file defines the irq handler for EMMA2RH.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/delay.h>
+
+#include <asm/i8259.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/debug.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+/*
+ * IRQ mapping
+ *
+ *  0-7: 8 CPU interrupts
+ *	0 -	software interrupt 0
+ *	1 - 	software interrupt 1
+ *	2 - 	most Vrc5477 interrupts are routed to this pin
+ *	3 - 	(optional) some other interrupts routed to this pin for debugg
+ *	4 - 	not used
+ *	5 - 	not used
+ *	6 - 	not used
+ *	7 - 	cpu timer (used by default)
+ *
+ */
+
+extern void emma2rh_sw_irq_init(u32 base);
+extern void emma2rh_gpio_irq_init(u32 base);
+extern void emma2rh_irq_init(u32 base);
+extern void mips_cpu_irq_init(u32 base);
+extern asmlinkage void emma2rh_handle_int(void);
+extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
+extern asmlinkage void emma2rh_irq_dispatch(struct pt_regs *regs);
+
+static struct irqaction irq_cascade = {
+	   .handler = no_action,
+	   .flags = 0,
+	   .mask = CPU_MASK_NONE,
+	   .name = "cascade",
+	   .dev_id = NULL,
+	   .next = NULL,
+};
+
+void __init arch_init_irq(void)
+{
+	u32 reg;
+
+	db_run(printk("markeins_irq_setup invoked.\n"));
+
+	/* by default, interrupts are disabled. */
+	emma2rh_out32(EMMA2RH_BHIF_INT_EN_0, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT_EN_1, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT_EN_2, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_0, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_1, 0);
+	emma2rh_out32(EMMA2RH_BHIF_INT1_EN_2, 0);
+	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, 0);
+
+	clear_c0_status(0xff00);
+	set_c0_status(0x0400);
+
+#define GPIO_PCI (0xf<<15)
+	/* setup GPIO interrupt for PCI interface */
+	/* direction input */
+	reg = emma2rh_in32(EMMA2RH_GPIO_DIR);
+	emma2rh_out32(EMMA2RH_GPIO_DIR, reg & ~GPIO_PCI);
+	/* disable interrupt */
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg & ~GPIO_PCI);
+	/* level triggerd */
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MODE);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MODE, reg | GPIO_PCI);
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_CND_A);
+	emma2rh_out32(EMMA2RH_GPIO_INT_CND_A, reg & (~GPIO_PCI));
+	/* interrupt clear */
+	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~GPIO_PCI);
+
+	/* init all controllers */
+	emma2rh_irq_init(EMMA2RH_IRQ_BASE);
+	emma2rh_sw_irq_init(EMMA2RH_SW_IRQ_BASE);
+	emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE);
+	mips_cpu_irq_init(CPU_IRQ_BASE);
+
+	/* setup cascade interrupts */
+	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_SW_CASCADE, &irq_cascade);
+	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_GPIO_CASCADE, &irq_cascade);
+	setup_irq(CPU_IRQ_BASE + CPU_EMMA2RH_CASCADE, &irq_cascade);
+}
+
+asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
+{
+        unsigned int pending = read_c0_status() & read_c0_cause();
+
+	if (pending & STATUSF_IP7)
+		do_IRQ(CPU_IRQ_BASE + 7, regs);
+	else if (pending & STATUSF_IP2)
+		emma2rh_irq_dispatch(regs);
+	else if (pending & STATUSF_IP1)
+		do_IRQ(CPU_IRQ_BASE + 1, regs);
+	else if (pending & STATUSF_IP0)
+		do_IRQ(CPU_IRQ_BASE + 0, regs);
+	else
+		spurious_interrupt(regs);
+}
+
+
Index: linux/arch/mips/emma2rh/markeins/irq_markeins.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/markeins/irq_markeins.c
@@ -0,0 +1,198 @@
+/*
+ *  arch/mips/emma2rh/markeins/irq_markeins.c
+ *      This file defines the irq handler for Mark-eins.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/irq_5477.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+#include <asm/debug.h>
+#include <asm/emma2rh/emma2rh.h>
+
+static int emma2rh_sw_irq_base = -1;
+static int emma2rh_gpio_irq_base = -1;
+
+void ll_emma2rh_sw_irq_enable(int reg);
+void ll_emma2rh_sw_irq_disable(int reg);
+void ll_emma2rh_gpio_irq_enable(int reg);
+void ll_emma2rh_gpio_irq_disable(int reg);
+
+static void emma2rh_sw_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_enable(irq - emma2rh_sw_irq_base);
+}
+
+static void emma2rh_sw_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
+}
+
+static unsigned int emma2rh_sw_irq_startup(unsigned int irq)
+{
+	emma2rh_sw_irq_enable(irq);
+	return 0;
+}
+
+#define emma2rh_sw_irq_shutdown emma2rh_sw_irq_disable
+
+static void emma2rh_sw_irq_ack(unsigned int irq)
+{
+	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
+}
+
+static void emma2rh_sw_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		ll_emma2rh_sw_irq_enable(irq - emma2rh_sw_irq_base);
+}
+
+hw_irq_controller emma2rh_sw_irq_controller = {
+	.typename = "emma2rh_sw_irq",
+	.startup = emma2rh_sw_irq_startup,
+	.shutdown = emma2rh_sw_irq_shutdown,
+	.enable = emma2rh_sw_irq_enable,
+	.disable = emma2rh_sw_irq_disable,
+	.ack = emma2rh_sw_irq_ack,
+	.end = emma2rh_sw_irq_end,
+	.set_affinity = NULL,
+};
+
+void emma2rh_sw_irq_init(u32 irq_base)
+{
+	extern irq_desc_t irq_desc[];
+	u32 i;
+
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = NULL;
+		irq_desc[i].depth = 2;
+		irq_desc[i].handler = &emma2rh_sw_irq_controller;
+	}
+
+	emma2rh_sw_irq_base = irq_base;
+}
+
+void ll_emma2rh_sw_irq_enable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < NUM_EMMA2RH_IRQ_SW);
+
+	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
+	reg |= 1 << irq;
+	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
+}
+
+void ll_emma2rh_sw_irq_disable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < 32);
+
+	reg = emma2rh_in32(EMMA2RH_BHIF_SW_INT_EN);
+	reg &= ~(1 << irq);
+	emma2rh_out32(EMMA2RH_BHIF_SW_INT_EN, reg);
+}
+
+static void emma2rh_gpio_irq_enable(unsigned int irq)
+{
+	ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
+}
+
+static void emma2rh_gpio_irq_disable(unsigned int irq)
+{
+	ll_emma2rh_gpio_irq_disable(irq - emma2rh_gpio_irq_base);
+}
+
+static unsigned int emma2rh_gpio_irq_startup(unsigned int irq)
+{
+	emma2rh_gpio_irq_enable(irq);
+	return 0;
+}
+
+#define emma2rh_gpio_irq_shutdown emma2rh_gpio_irq_disable
+
+static void emma2rh_gpio_irq_ack(unsigned int irq)
+{
+	irq -= emma2rh_gpio_irq_base;
+	emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
+	ll_emma2rh_gpio_irq_disable(irq);
+}
+
+static void emma2rh_gpio_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base);
+}
+
+hw_irq_controller emma2rh_gpio_irq_controller = {
+	.typename = "emma2rh_gpio_irq",
+	.startup = emma2rh_gpio_irq_startup,
+	.shutdown = emma2rh_gpio_irq_shutdown,
+	.enable = emma2rh_gpio_irq_enable,
+	.disable = emma2rh_gpio_irq_disable,
+	.ack = emma2rh_gpio_irq_ack,
+	.end = emma2rh_gpio_irq_end,
+	.set_affinity = NULL,
+};
+
+void emma2rh_gpio_irq_init(u32 irq_base)
+{
+	extern irq_desc_t irq_desc[];
+	u32 i;
+
+	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = NULL;
+		irq_desc[i].depth = 2;
+		irq_desc[i].handler = &emma2rh_gpio_irq_controller;
+	}
+
+	emma2rh_gpio_irq_base = irq_base;
+}
+
+void ll_emma2rh_gpio_irq_enable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
+
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	reg |= 1 << irq;
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
+}
+
+void ll_emma2rh_gpio_irq_disable(int irq)
+{
+	u32 reg;
+
+	db_assert(irq >= 0);
+	db_assert(irq < NUM_EMMA2RH_IRQ_GPIO);
+
+	reg = emma2rh_in32(EMMA2RH_GPIO_INT_MASK);
+	reg &= ~(1 << irq);
+	emma2rh_out32(EMMA2RH_GPIO_INT_MASK, reg);
+}
Index: linux/arch/mips/emma2rh/markeins/led.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/markeins/led.c
@@ -0,0 +1,60 @@
+/*
+ *  arch/mips/emma2rh/markeins/led.c
+ *      This file defines the led display for Mark-eins.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/emma2rh/emma2rh.h>
+
+const unsigned long clear = 0x20202020;
+
+#define LED_BASE 0xb1400038
+
+void markeins_led_clear(void)
+{
+	emma2rh_out32(LED_BASE, clear);
+	emma2rh_out32(LED_BASE + 4, clear);
+}
+
+void markeins_led(const char *str)
+{
+	int i;
+	int len = strlen(str);
+
+	markeins_led_clear();
+	if (len > 8)
+		len = 8;
+
+	if (emma2rh_in32(0xb0000800) & (0x1 << 18))
+		for (i = 0; i < len; i++)
+			emma2rh_out8(LED_BASE + i, str[i]);
+	else
+		for (i = 0; i < len; i++)
+			emma2rh_out8(LED_BASE + (i & 4) + (3 - (i & 3)),
+				     str[i]);
+}
+
+void markeins_led_hex(u32 val)
+{
+	char str[10];
+
+	sprintf(str, "%08x", val);
+	markeins_led(str);
+}
Index: linux/arch/mips/emma2rh/markeins/platform.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/markeins/platform.c
@@ -0,0 +1,170 @@
+/*
+ *  arch/mips/emma2rh/markeins/platofrm.c
+ *      This file sets up platform devices for EMMA2RH Mark-eins.
+ *
+ *  Copyright(C) MontaVista Software Inc, 2006
+ *
+ *  Author: dmitry pervushin <dpervushin@ru.mvista.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/serial_8250.h>
+#include <linux/mtd/physmap.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+#include <asm/time.h>
+#include <asm/bcache.h>
+#include <asm/irq.h>
+#include <asm/reboot.h>
+#include <asm/gdb-stub.h>
+#include <asm/traps.h>
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+
+#define I2C_EMMA2RH "emma2rh-iic" /* must be in sync with IIC driver */
+
+static struct resource i2c_emma_resources_0[] = {
+	{ NULL, EMMA2RH_IRQ_PIIC0, EMMA2RH_IRQ_PIIC0, IORESOURCE_IRQ },
+	{ NULL, KSEG1ADDR(EMMA2RH_PIIC0_BASE), KSEG1ADDR(EMMA2RH_PIIC0_BASE + 0x1000), 0 },
+};
+
+struct resource i2c_emma_resources_1[] = {
+	{ NULL, EMMA2RH_IRQ_PIIC1, EMMA2RH_IRQ_PIIC1, IORESOURCE_IRQ },
+	{ NULL, KSEG1ADDR(EMMA2RH_PIIC1_BASE), KSEG1ADDR(EMMA2RH_PIIC1_BASE + 0x1000), 0 },
+};
+
+struct resource i2c_emma_resources_2[] = {
+	{ NULL, EMMA2RH_IRQ_PIIC2, EMMA2RH_IRQ_PIIC2, IORESOURCE_IRQ },
+	{ NULL, KSEG1ADDR(EMMA2RH_PIIC2_BASE), KSEG1ADDR(EMMA2RH_PIIC2_BASE + 0x1000), 0 },
+};
+
+struct platform_device i2c_emma_devices[] = {
+	[0] = {
+		.name = I2C_EMMA2RH,
+		.id = 0,
+		.resource = i2c_emma_resources_0,
+		.num_resources = ARRAY_SIZE(i2c_emma_resources_0),
+	},
+	[1] = {
+		.name = I2C_EMMA2RH,
+		.id = 1,
+		.resource = i2c_emma_resources_1,
+		.num_resources = ARRAY_SIZE(i2c_emma_resources_1),
+	},
+	[2] = {
+		.name = I2C_EMMA2RH,
+		.id = 2,
+		.resource = i2c_emma_resources_2,
+		.num_resources = ARRAY_SIZE(i2c_emma_resources_2),
+	},
+};
+
+#define EMMA2RH_SERIAL_CLOCK 18544000
+#define EMMA2RH_SERIAL_FLAGS UPF_BOOT_AUTOCONF | UPF_SKIP_TEST
+
+static struct  plat_serial8250_port platform_serial_ports[] = {
+       [0] = {
+         .membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3),
+         .irq = EMMA2RH_IRQ_PFUR0,
+         .uartclk = EMMA2RH_SERIAL_CLOCK,
+         .regshift = 4,
+         .iotype = UPIO_MEM,
+         .flags = EMMA2RH_SERIAL_FLAGS,
+       },
+       [1] = {
+         .membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3),
+         .irq = EMMA2RH_IRQ_PFUR1,
+         .uartclk = EMMA2RH_SERIAL_CLOCK,
+         .regshift = 4,
+         .iotype = UPIO_MEM,
+         .flags = EMMA2RH_SERIAL_FLAGS,
+       },
+       [2] = {
+         .membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR2_BASE + 3),
+         .irq = EMMA2RH_IRQ_PFUR2,
+         .uartclk = EMMA2RH_SERIAL_CLOCK,
+         .regshift = 4,
+         .iotype = UPIO_MEM,
+         .flags = EMMA2RH_SERIAL_FLAGS,
+       },
+       [3] = {
+	 .flags = 0,
+       },
+};
+
+static struct  platform_device serial_emma = {
+	.name = "serial8250",
+	.dev = {
+		.platform_data = &platform_serial_ports,
+	},
+};
+
+static struct platform_device *devices[] = {
+	&i2c_emma_devices[0],
+	&i2c_emma_devices[1],
+	&i2c_emma_devices[2],
+	&serial_emma,
+};
+
+static struct mtd_partition markeins_parts[] = {
+	[0] = {
+		.name = "RootFS",
+		.offset = 0x00000000,
+		.size = 0x00c00000,
+	},
+	[1] = {
+		.name = "boot code area",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00100000,
+	},
+	[2] = {
+		.name = "kernel image",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00300000,
+	},
+	[3] = {
+		.name = "RootFS2",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00c00000,
+	},
+	[4] = {
+		.name = "boot code area2",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 0x00100000,
+	},
+	[5] = {
+		.name = "kernel image2",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+	},
+};
+
+static int __init platform_devices_setup(void)
+{
+	physmap_set_partitions(markeins_parts, ARRAY_SIZE(markeins_parts));
+	return platform_add_devices(devices, ARRAY_SIZE(devices));
+}
+
+arch_initcall(platform_devices_setup);
+
Index: linux/arch/mips/emma2rh/markeins/setup.c
===================================================================
--- /dev/null
+++ linux/arch/mips/emma2rh/markeins/setup.c
@@ -0,0 +1,195 @@
+/*
+ *  arch/mips/emma2rh/markeins/setup.c
+ *      This file is setup for EMMA2RH Mark-eins.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/setup.c.
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+#include <linux/param.h>	/* for HZ */
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+#include <asm/time.h>
+#include <asm/bcache.h>
+#include <asm/irq.h>
+#include <asm/reboot.h>
+#include <asm/gdb-stub.h>
+#include <asm/traps.h>
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+#define	USE_CPU_COUNTER_TIMER	/* whether we use cpu counter */
+
+extern void markeins_led(const char *);
+
+static int bus_frequency = 0;
+
+static void markeins_machine_restart(char *command)
+{
+	static void (*back_to_prom) (void) = (void (*)(void))0xbfc00000;
+
+	printk("cannot EMMA2RH Mark-eins restart.\n");
+	markeins_led("restart.");
+	back_to_prom();
+}
+
+static void markeins_machine_halt(void)
+{
+	printk("EMMA2RH Mark-eins halted.\n");
+	markeins_led("halted.");
+	while (1) ;
+}
+
+static void markeins_machine_power_off(void)
+{
+	printk("EMMA2RH Mark-eins halted. Please turn off the power.\n");
+	markeins_led("poweroff.");
+	while (1) ;
+}
+
+static unsigned long clock[4] = { 166500000, 187312500, 199800000, 210600000 };
+
+static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
+{
+	u32 reg;
+
+	/* detect from boot strap */
+	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
+	reg = (reg >> 4) & 0x3;
+	return clock[reg];
+}
+
+static void __init emma2rh_time_init(void)
+{
+	u32 reg;
+	if (bus_frequency == 0)
+		bus_frequency = detect_bus_frequency(0);
+
+	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
+	if ((reg & 0x3) == 0)
+		reg = (reg >> 6) & 0x3;
+	else {
+		reg = emma2rh_in32(EMMA2RH_BHIF_MAIN_CTRL);
+		reg = (reg >> 4) & 0x3;
+	}
+	mips_hpt_frequency = (bus_frequency * (4 + reg)) / 4 / 2;
+}
+
+extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
+
+static void __init emma2rh_timer_setup(struct irqaction *irq)
+{
+	/* we are using the cpu counter for timer interrupts */
+	setup_irq(CPU_IRQ_BASE + 7, irq);
+}
+
+static void markeins_board_init(void);
+extern void markeins_irq_setup(void);
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+extern unsigned long __rd_start, __rd_end, initrd_start, initrd_end;
+#endif
+
+static void inline __init markeins_sio_setup(void)
+{
+#ifdef CONFIG_KGDB_8250
+	struct uart_port emma_port;
+
+	memset(&emma_port, 0, sizeof(emma_port));
+
+	emma_port.flags =
+	    UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	emma_port.iotype = UPIO_MEM;
+	emma_port.regshift = 4;	/* I/O addresses are every 8 bytes */
+	emma_port.uartclk = 18544000;	/* Clock rate of the chip */
+
+	emma_port.line = 0;
+	emma_port.mapbase = KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3);
+	emma_port.membase = (u8*)emma_port.mapbase;
+	early_serial_setup(&emma_port);
+
+	emma_port.line = 1;
+	emma_port.mapbase = KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3);
+	emma_port.membase = (u8*)emma_port.mapbase;
+	early_serial_setup(&emma_port);
+
+	emma_port.irq = EMMA2RH_IRQ_PFUR1;
+	kgdb8250_add_port(1, &emma_port);
+#endif
+}
+
+int __init plat_setup(void)
+{
+	extern int panic_timeout;
+
+	/* initialize board - we don't trust the loader */
+	markeins_board_init();
+
+	set_io_port_base(KSEG1ADDR(EMMA2RH_PCI_IO_BASE));
+
+	board_time_init = emma2rh_time_init;
+	board_timer_setup = emma2rh_timer_setup;
+
+	_machine_restart = markeins_machine_restart;
+	_machine_halt = markeins_machine_halt;
+	pm_power_off = markeins_machine_power_off;
+
+	/* setup resource limits */
+	ioport_resource.start = EMMA2RH_PCI_IO_BASE;
+	ioport_resource.end = EMMA2RH_PCI_IO_BASE + EMMA2RH_PCI_IO_SIZE - 1;
+	iomem_resource.start = EMMA2RH_IO_BASE;
+	iomem_resource.end = EMMA2RH_ROM_BASE - 1;
+
+	/* Reboot on panic */
+	panic_timeout = 180;
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	initrd_start = (unsigned long)&__rd_start;
+	initrd_end = (unsigned long)&__rd_end;
+#endif
+	markeins_sio_setup();
+
+	return 0;
+}
+
+static void __init markeins_board_init(void)
+{
+	u32 val;
+
+	val = emma2rh_in32(EMMA2RH_PBRD_INT_EN);	/* open serial interrupts. */
+	emma2rh_out32(EMMA2RH_PBRD_INT_EN, val | 0xaa);
+	val = emma2rh_in32(EMMA2RH_PBRD_CLKSEL);	/* set serial clocks. */
+	emma2rh_out32(EMMA2RH_PBRD_CLKSEL, val | 0x5);	/* 18MHz */
+	emma2rh_out32(EMMA2RH_PCI_CONTROL, 0);
+
+	markeins_led("MVL E2RH");
+}
+
Index: linux/arch/mips/pci/Makefile
===================================================================
--- linux.orig/arch/mips/pci/Makefile
+++ linux/arch/mips/pci/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
 obj-$(CONFIG_MIPS_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 obj-$(CONFIG_NEC_CMBVR4133)	+= fixup-vr4133.o
+obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
Index: linux/arch/mips/pci/fixup-emma2rh.c
===================================================================
--- /dev/null
+++ linux/arch/mips/pci/fixup-emma2rh.c
@@ -0,0 +1,102 @@
+/*
+ *  arch/mips/pci/fixup-emma2rh.c
+ *      This file defines the PCI configration.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/pci.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#include <asm/bootinfo.h>
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+#define EMMA2RH_PCI_HOST_SLOT 0x09
+#define EMMA2RH_USB_SLOT 0x03
+#define PCI_DEVICE_ID_NEC_EMMA2RH      0x014b /* EMMA2RH PCI Host */
+
+/*
+ * we fix up irqs based on the slot number.
+ * The first entry is at AD:11.
+ * Fortunately this works because, although we have two pci buses,
+ * they all have different slot numbers (except for rockhopper slot 20
+ * which is handled below).
+ *
+ */
+
+#define	MAX_SLOT_NUM 10
+static unsigned char irq_map[][5] __initdata = {
+	[3] = {0, MARKEINS_PCI_IRQ_INTB, MARKEINS_PCI_IRQ_INTC,
+	       MARKEINS_PCI_IRQ_INTD, 0,},
+	[4] = {0, MARKEINS_PCI_IRQ_INTA, 0, 0, 0,},
+	[5] = {0, 0, 0, 0, 0,},
+	[6] = {0, MARKEINS_PCI_IRQ_INTC, MARKEINS_PCI_IRQ_INTD,
+	       MARKEINS_PCI_IRQ_INTA, MARKEINS_PCI_IRQ_INTB,},
+};
+
+static void __devinit nec_usb_controller_fixup(struct pci_dev *dev)
+{
+	if (PCI_SLOT(dev->devfn) == EMMA2RH_USB_SLOT)
+		/* on board USB controller configuration */
+		pci_write_config_dword(dev, 0xe4, 1 << 5);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+			nec_usb_controller_fixup);
+
+/*
+ * Prevent the PCI layer from seeing the resources allocated to this device
+ * if it is the host bridge by marking it as such.  These resources are of
+ * no consequence to the PCI layer (they are handled elsewhere).
+ */
+static void __devinit emma2rh_pci_host_fixup(struct pci_dev *dev)
+{
+	int i;
+
+	if (PCI_SLOT(dev->devfn) == EMMA2RH_PCI_HOST_SLOT) {
+		dev->class &= 0xff;
+		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			dev->resource[i].start = 0;
+			dev->resource[i].end = 0;
+			dev->resource[i].flags = 0;
+		}
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_EMMA2RH,
+			 emma2rh_pci_host_fixup);
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return irq_map[slot][pin];
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
Index: linux/arch/mips/pci/ops-emma2rh.c
===================================================================
--- /dev/null
+++ linux/arch/mips/pci/ops-emma2rh.c
@@ -0,0 +1,186 @@
+/*
+ *  arch/mips/pci/ops-emma2rh.c
+ *      This file defines the PCI operation for EMMA2RH.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/pci/ops-vr41xx.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/addrspace.h>
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+#define RTABORT (0x1<<9)
+#define RMABORT (0x1<<10)
+#define EMMA2RH_PCI_SLOT_NUM 9	/* 0000:09.0 is final PCI device */
+
+/*
+ * access config space
+ */
+
+static int check_args(struct pci_bus *bus, u32 devfn, u32 * bus_num)
+{
+	/* check if the bus is top-level */
+	if (bus->parent != NULL) {
+		*bus_num = bus->number;
+		db_assert(bus_num != 0);
+	} else
+		*bus_num = 0;
+
+	if (*bus_num == 0) {
+		/* Type 0 */
+		if (PCI_SLOT(devfn) >= 10)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	} else {
+		/* Type 1 */
+		if ((*bus_num >= 64) || (PCI_SLOT(devfn) >= 16))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return 0;
+}
+
+static inline int set_pci_configuration_address(unsigned char bus_num,
+						unsigned int devfn, int where)
+{
+	u32 config_win0;
+
+	emma2rh_out32(EMMA2RH_PCI_INT, ~RMABORT);
+	if (bus_num == 0)
+		/*
+		 * Type 0 configuration
+		 */
+		config_win0 = (1 << (22 + PCI_SLOT(devfn))) | (5 << 9);
+	else
+		/*
+		 * Type 1 configuration
+		 */
+		config_win0 = (bus_num << 26) | (PCI_SLOT(devfn) << 22) |
+		    (1 << 15) | (5 << 9);
+
+	emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, config_win0);
+
+	return 0;
+}
+
+static int pci_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+			   int size, uint32_t * val)
+{
+	u32 bus_num;
+	u32 base = KSEG1ADDR(EMMA2RH_PCI_CONFIG_BASE);
+	u32 backup_win0;
+	u32 data;
+
+	*val = 0xffffffffU;
+
+	if (check_args(bus, devfn, &bus_num) == PCIBIOS_DEVICE_NOT_FOUND)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	backup_win0 = emma2rh_in32(EMMA2RH_PCI_IWIN0_CTR);
+
+	if (set_pci_configuration_address(bus_num, devfn, where) < 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	data =
+	    *(volatile u32 *)(base + (PCI_FUNC(devfn) << 8) +
+			      (where & 0xfffffffc));
+
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xffU;
+		break;
+	case 2:
+		*val = (data >> ((where & 2) << 3)) & 0xffffU;
+		break;
+	case 4:
+		*val = data;
+		break;
+	default:
+		emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
+
+	if (emma2rh_in32(EMMA2RH_PCI_INT) & RMABORT)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, u32 val)
+{
+	u32 bus_num;
+	u32 base = KSEG1ADDR(EMMA2RH_PCI_CONFIG_BASE);
+	u32 backup_win0;
+	u32 data;
+	int shift;
+
+	if (check_args(bus, devfn, &bus_num) == PCIBIOS_DEVICE_NOT_FOUND)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	backup_win0 = emma2rh_in32(EMMA2RH_PCI_IWIN0_CTR);
+
+	if (set_pci_configuration_address(bus_num, devfn, where) < 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* read modify write */
+	data =
+	    *(volatile u32 *)(base + (PCI_FUNC(devfn) << 8) +
+			      (where & 0xfffffffc));
+
+	switch (size) {
+	case 1:
+		shift = (where & 3) << 3;
+		data &= ~(0xffU << shift);
+		data |= ((val & 0xffU) << shift);
+		break;
+	case 2:
+		shift = (where & 2) << 3;
+		data &= ~(0xffffU << shift);
+		data |= ((val & 0xffffU) << shift);
+		break;
+	case 4:
+		data = val;
+		break;
+	default:
+		emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+	*(volatile u32 *)(base + (PCI_FUNC(devfn) << 8) +
+			  (where & 0xfffffffc)) = data;
+
+	emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
+	if (emma2rh_in32(EMMA2RH_PCI_INT) & RMABORT)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops emma2rh_pci_ops = {
+	.read = pci_config_read,
+	.write = pci_config_write,
+};
Index: linux/arch/mips/pci/pci-emma2rh.c
===================================================================
--- /dev/null
+++ linux/arch/mips/pci/pci-emma2rh.c
@@ -0,0 +1,90 @@
+/*
+ *  arch/mips/pci/pci-emma2rh.c
+ *      This file defines the PCI configration.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2004-2006
+ *
+ *  This file is based on the arch/mips/ddb5xxx/ddb5477/pci.c
+ *
+ *	Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#include <asm/bootinfo.h>
+#include <asm/debug.h>
+
+#include <asm/emma2rh/emma2rh.h>
+
+static struct resource pci_io_resource = {
+	.name = "pci IO space",
+	.start = EMMA2RH_PCI_IO_BASE,
+	.end = EMMA2RH_PCI_IO_BASE + EMMA2RH_PCI_IO_SIZE - 1,
+	.flags = IORESOURCE_IO,
+};
+
+static struct resource pci_mem_resource = {
+	.name = "pci memory space",
+	.start = EMMA2RH_PCI_MEM_BASE,
+	.end = EMMA2RH_PCI_MEM_BASE + EMMA2RH_PCI_MEM_SIZE - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+extern struct pci_ops emma2rh_pci_ops;
+
+static struct pci_controller emma2rh_pci_controller = {
+	.pci_ops = &emma2rh_pci_ops,
+	.mem_resource = &pci_mem_resource,
+	.io_resource = &pci_io_resource,
+	.mem_offset = -0x04000000,
+	.io_offset = 0,
+};
+
+static void __init emma2rh_pci_init(void)
+{
+	/* setup PCI interface */
+	emma2rh_out32(EMMA2RH_PCI_ARBIT_CTR, 0x70f);
+
+	emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, 0x80000a18);
+	emma2rh_out32(EMMA2RH_PCI_CONFIG_BASE + PCI_COMMAND,
+		      PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_CAP_LIST |
+		      PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+	emma2rh_out32(EMMA2RH_PCI_CONFIG_BASE + PCI_BASE_ADDRESS_0, 0x10000000);
+	emma2rh_out32(EMMA2RH_PCI_CONFIG_BASE + PCI_BASE_ADDRESS_1, 0x00000000);
+
+	emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, 0x12000000 | 0x218);
+	emma2rh_out32(EMMA2RH_PCI_IWIN1_CTR, 0x18000000 | 0x600);
+	emma2rh_out32(EMMA2RH_PCI_INIT_ESWP, 0x00000200);
+
+	emma2rh_out32(EMMA2RH_PCI_TWIN_CTR, 0x00009200);
+	emma2rh_out32(EMMA2RH_PCI_TWIN_BADR, 0x00000000);
+	emma2rh_out32(EMMA2RH_PCI_TWIN0_DADR, 0x00000000);
+	emma2rh_out32(EMMA2RH_PCI_TWIN1_DADR, 0x00000000);
+}
+
+static int __init emma2rh_pci_setup(void)
+{
+	emma2rh_pci_init();
+	register_pci_controller(&emma2rh_pci_controller);
+	return 0;
+}
+
+arch_initcall(emma2rh_pci_setup);
Index: linux/include/asm-mips/bootinfo.h
===================================================================
--- linux.orig/include/asm-mips/bootinfo.h
+++ linux/include/asm-mips/bootinfo.h
@@ -218,6 +218,12 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
+/*
+ * Valid machtype for group NEC EMMA2RH
+ */
+#define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
+#define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
Index: linux/include/asm-mips/emma2rh/emma2rh.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/emma2rh/emma2rh.h
@@ -0,0 +1,332 @@
+/*
+ *  include/asm-mips/emma2rh/emma2rh.h
+ *      This file is EMMA2RH common header.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2005-2006
+ *
+ *  This file based on include/asm-mips/ddb5xxx/ddb5xxx.h
+ *          Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __ASM_EMMA2RH_EMMA2RH_H
+#define __ASM_EMMA2RH_EMMA2RH_H
+
+/*
+ * EMMA2RH registers
+ */
+#define REGBASE 0x10000000
+
+#define EMMA2RH_BHIF_STRAP_0	(0x000010+REGBASE)
+#define EMMA2RH_BHIF_INT_ST_0	(0x000030+REGBASE)
+#define EMMA2RH_BHIF_INT_ST_1	(0x000034+REGBASE)
+#define EMMA2RH_BHIF_INT_ST_2	(0x000038+REGBASE)
+#define EMMA2RH_BHIF_INT_EN_0	(0x000040+REGBASE)
+#define EMMA2RH_BHIF_INT_EN_1	(0x000044+REGBASE)
+#define EMMA2RH_BHIF_INT_EN_2	(0x000048+REGBASE)
+#define EMMA2RH_BHIF_INT1_EN_0	(0x000050+REGBASE)
+#define EMMA2RH_BHIF_INT1_EN_1	(0x000054+REGBASE)
+#define EMMA2RH_BHIF_INT1_EN_2	(0x000058+REGBASE)
+#define EMMA2RH_BHIF_SW_INT	(0x000070+REGBASE)
+#define EMMA2RH_BHIF_SW_INT_EN	(0x000080+REGBASE)
+#define EMMA2RH_BHIF_SW_INT_CLR	(0x000090+REGBASE)
+#define EMMA2RH_BHIF_MAIN_CTRL	(0x0000b4+REGBASE)
+#define EMMA2RH_BHIF_EXCEPT_VECT_BASE_ADDRESS	(0x0000c0+REGBASE)
+#define EMMA2RH_GPIO_DIR	(0x110d20+REGBASE)
+#define EMMA2RH_GPIO_INT_ST	(0x110d30+REGBASE)
+#define EMMA2RH_GPIO_INT_MASK	(0x110d3c+REGBASE)
+#define EMMA2RH_GPIO_INT_MODE	(0x110d48+REGBASE)
+#define EMMA2RH_GPIO_INT_CND_A	(0x110d54+REGBASE)
+#define EMMA2RH_GPIO_INT_CND_B	(0x110d60+REGBASE)
+#define EMMA2RH_PBRD_INT_EN	(0x100010+REGBASE)
+#define EMMA2RH_PBRD_CLKSEL	(0x100028+REGBASE)
+#define EMMA2RH_PFUR0_BASE	(0x101000+REGBASE)
+#define EMMA2RH_PFUR1_BASE	(0x102000+REGBASE)
+#define EMMA2RH_PFUR2_BASE	(0x103000+REGBASE)
+#define EMMA2RH_PIIC0_BASE	(0x107000+REGBASE)
+#define EMMA2RH_PIIC1_BASE	(0x108000+REGBASE)
+#define EMMA2RH_PIIC2_BASE	(0x109000+REGBASE)
+#define EMMA2RH_PCI_CONTROL	(0x200000+REGBASE)
+#define EMMA2RH_PCI_ARBIT_CTR	(0x200004+REGBASE)
+#define EMMA2RH_PCI_IWIN0_CTR	(0x200010+REGBASE)
+#define EMMA2RH_PCI_IWIN1_CTR	(0x200014+REGBASE)
+#define EMMA2RH_PCI_INIT_ESWP	(0x200018+REGBASE)
+#define EMMA2RH_PCI_INT		(0x200020+REGBASE)
+#define EMMA2RH_PCI_INT_EN	(0x200024+REGBASE)
+#define EMMA2RH_PCI_TWIN_CTR	(0x200030+REGBASE)
+#define EMMA2RH_PCI_TWIN_BADR	(0x200034+REGBASE)
+#define EMMA2RH_PCI_TWIN0_DADR	(0x200038+REGBASE)
+#define EMMA2RH_PCI_TWIN1_DADR	(0x20003c+REGBASE)
+
+/*
+ *  Memory map (physical address)
+ *
+ *  Note most of the following address must be properly aligned by the
+ *  corresponding size.  For example, if PCI_IO_SIZE is 16MB, then
+ *  PCI_IO_BASE must be aligned along 16MB boundary.
+ */
+
+/* the actual ram size is detected at run-time */
+#define EMMA2RH_RAM_BASE	0x00000000
+#define EMMA2RH_RAM_SIZE	0x10000000	/* less than 256MB */
+
+#define EMMA2RH_IO_BASE		0x10000000
+#define EMMA2RH_IO_SIZE		0x01000000	/* 16 MB */
+
+#define EMMA2RH_GENERALIO_BASE	0x11000000
+#define EMMA2RH_GENERALIO_SIZE	0x01000000	/* 16 MB */
+
+#define EMMA2RH_PCI_IO_BASE	0x12000000
+#define EMMA2RH_PCI_IO_SIZE	0x02000000	/* 32 MB */
+
+#define EMMA2RH_PCI_MEM_BASE	0x14000000
+#define EMMA2RH_PCI_MEM_SIZE	0x08000000	/* 128 MB */
+
+#define EMMA2RH_ROM_BASE	0x1c000000
+#define EMMA2RH_ROM_SIZE	0x04000000	/* 64 MB */
+
+#define EMMA2RH_PCI_CONFIG_BASE	EMMA2RH_PCI_IO_BASE
+#define EMMA2RH_PCI_CONFIG_SIZE	EMMA2RH_PCI_IO_SIZE
+
+#define NUM_CPU_IRQ		8
+#define NUM_EMMA2RH_IRQ		96
+
+#define CPU_EMMA2RH_CASCADE	2
+#define EMMA2RH_IRQ_BASE	0
+
+/*
+ * emma2rh irq defs
+ */
+
+#define EMMA2RH_IRQ_INT0	(0 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT1	(1 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT2	(2 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT3	(3 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT4	(4 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT5	(5 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT6	(6 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT7	(7 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT8	(8 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT9	(9 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT10	(10 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT11	(11 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT12	(12 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT13	(13 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT14	(14 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT15	(15 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT16	(16 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT17	(17 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT18	(18 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT19	(19 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT20	(20 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT21	(21 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT22	(22 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT23	(23 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT24	(24 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT25	(25 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT26	(26 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT27	(27 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT28	(28 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT29	(29 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT30	(30 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT31	(31 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT32	(32 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT33	(33 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT34	(34 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT35	(35 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT36	(36 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT37	(37 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT38	(38 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT39	(39 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT40	(40 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT41	(41 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT42	(42 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT43	(43 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT44	(44 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT45	(45 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT46	(46 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT47	(47 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT48	(48 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT49	(49 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT50	(50 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT51	(51 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT52	(52 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT53	(53 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT54	(54 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT55	(55 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT56	(56 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT57	(57 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT58	(58 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT59	(59 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT60	(60 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT61	(61 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT62	(62 + EMMA2RH_IRQ_BASE)
+#define EMMA2RH_IRQ_INT63	(63 + EMMA2RH_IRQ_BASE)
+
+#define EMMA2RH_IRQ_PFUR0	EMMA2RH_IRQ_INT49
+#define EMMA2RH_IRQ_PFUR1	EMMA2RH_IRQ_INT50
+#define EMMA2RH_IRQ_PFUR2	EMMA2RH_IRQ_INT51
+#define EMMA2RH_IRQ_PIIC0	EMMA2RH_IRQ_INT56
+#define EMMA2RH_IRQ_PIIC1	EMMA2RH_IRQ_INT57
+#define EMMA2RH_IRQ_PIIC2	EMMA2RH_IRQ_INT58
+
+/*
+ *  EMMA2RH Register Access
+ */
+
+#define EMMA2RH_BASE (0xa0000000)
+
+#ifndef __ASSEMBLY__
+static inline void emma2rh_sync(void)
+{
+	volatile u32 *p = (volatile u32 *)0xbfc00000;
+	(void)(*p);
+}
+
+static inline void emma2rh_out32(u32 offset, u32 val)
+{
+	*(volatile u32 *)(EMMA2RH_BASE | offset) = val;
+	emma2rh_sync();
+}
+
+static inline u32 emma2rh_in32(u32 offset)
+{
+	u32 val = *(volatile u32 *)(EMMA2RH_BASE | offset);
+	emma2rh_sync();
+	return val;
+}
+
+static inline void emma2rh_out16(u32 offset, u16 val)
+{
+	*(volatile u16 *)(EMMA2RH_BASE | offset) = val;
+	emma2rh_sync();
+}
+
+static inline u16 emma2rh_in16(u32 offset)
+{
+	u16 val = *(volatile u16 *)(EMMA2RH_BASE | offset);
+	emma2rh_sync();
+	return val;
+}
+
+static inline void emma2rh_out8(u32 offset, u8 val)
+{
+	*(volatile u8 *)(EMMA2RH_BASE | offset) = val;
+	emma2rh_sync();
+}
+
+static inline u8 emma2rh_in8(u32 offset)
+{
+	u8 val = *(volatile u8 *)(EMMA2RH_BASE | offset);
+	emma2rh_sync();
+	return val;
+}
+#endif
+
+/**
+ * IIC registers map
+ **/
+
+/*---------------------------------------------------------------------------*/
+/* CNT - Control register (00H R/W)                                          */
+/*---------------------------------------------------------------------------*/
+#define SPT         0x00000001
+#define STT         0x00000002
+#define ACKE        0x00000004
+#define WTIM        0x00000008
+#define SPIE        0x00000010
+#define WREL        0x00000020
+#define LREL        0x00000040
+#define IICE        0x00000080
+#define CNT_RESERVED    0x000000ff	/* reserved bit 0 */
+
+#define I2C_EMMA_START      (IICE | STT)
+#define I2C_EMMA_STOP       (IICE | SPT)
+#define I2C_EMMA_REPSTART   I2C_EMMA_START
+
+/*---------------------------------------------------------------------------*/
+/* STA - Status register (10H Read)                                          */
+/*---------------------------------------------------------------------------*/
+#define MSTS        0x00000080
+#define ALD         0x00000040
+#define EXC         0x00000020
+#define COI         0x00000010
+#define TRC         0x00000008
+#define ACKD        0x00000004
+#define STD         0x00000002
+#define SPD         0x00000001
+
+/*---------------------------------------------------------------------------*/
+/* CSEL - Clock select register (20H R/W)                                    */
+/*---------------------------------------------------------------------------*/
+#define FCL         0x00000080
+#define ND50        0x00000040
+#define CLD         0x00000020
+#define DAD         0x00000010
+#define SMC         0x00000008
+#define DFC         0x00000004
+#define CL          0x00000003
+#define CSEL_RESERVED   0x000000ff	/* reserved bit 0 */
+
+#define FAST397     0x0000008b
+#define FAST297     0x0000008a
+#define FAST347     0x0000000b
+#define FAST260     0x0000000a
+#define FAST130     0x00000008
+#define STANDARD108 0x00000083
+#define STANDARD83  0x00000082
+#define STANDARD95  0x00000003
+#define STANDARD73  0x00000002
+#define STANDARD36  0x00000001
+#define STANDARD71  0x00000000
+
+/*---------------------------------------------------------------------------*/
+/* SVA - Slave address register (30H R/W)                                    */
+/*---------------------------------------------------------------------------*/
+#define SVA         0x000000fe
+
+/*---------------------------------------------------------------------------*/
+/* SHR - Shift register (40H R/W)                                            */
+/*---------------------------------------------------------------------------*/
+#define SR          0x000000ff
+
+/*---------------------------------------------------------------------------*/
+/* INT - Interrupt register (50H R/W)                                        */
+/* INTM - Interrupt mask register (60H R/W)                                  */
+/*---------------------------------------------------------------------------*/
+#define INTE0       0x00000001
+
+/***********************************************************************
+ * I2C registers
+ ***********************************************************************
+ */
+#define I2C_EMMA_CNT            0x00
+#define I2C_EMMA_STA            0x10
+#define I2C_EMMA_CSEL           0x20
+#define I2C_EMMA_SVA            0x30
+#define I2C_EMMA_SHR            0x40
+#define I2C_EMMA_INT            0x50
+#define I2C_EMMA_INTM           0x60
+
+/*
+ * include the board dependent part
+ */
+#if defined(CONFIG_MARKEINS)
+#include <asm/emma2rh/markeins.h>
+#else
+#error "Unknown EMMA2RH board!"
+#endif
+
+#endif /* __ASM_EMMA2RH_EMMA2RH_H */
Index: linux/include/asm-mips/emma2rh/markeins.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/emma2rh/markeins.h
@@ -0,0 +1,76 @@
+/*
+ *  include/asm-mips/emma2rh/markeins.h
+ *      This file is EMMA2RH board depended header.
+ *
+ *  Copyright (C) NEC Electronics Corporation 2005-2006
+ *
+ *  This file based on include/asm-mips/ddb5xxx/ddb5xxx.h
+ *          Copyright 2001 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef MARKEINS_H
+#define MARKEINS_H
+
+#define NUM_EMMA2RH_IRQ_SW	32
+#define NUM_EMMA2RH_IRQ_GPIO	32
+
+#define EMMA2RH_SW_CASCADE	(EMMA2RH_IRQ_INT7 - EMMA2RH_IRQ_INT0)
+#define EMMA2RH_GPIO_CASCADE	(EMMA2RH_IRQ_INT46 - EMMA2RH_IRQ_INT0)
+
+#define EMMA2RH_SW_IRQ_BASE	(EMMA2RH_IRQ_BASE + NUM_EMMA2RH_IRQ)
+#define EMMA2RH_GPIO_IRQ_BASE	(EMMA2RH_SW_IRQ_BASE + NUM_EMMA2RH_IRQ_SW)
+#define CPU_IRQ_BASE		(EMMA2RH_GPIO_IRQ_BASE + NUM_EMMA2RH_IRQ_GPIO)
+
+#define EMMA2RH_SW_IRQ_INT0	(0+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT1	(1+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT2	(2+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT3	(3+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT4	(4+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT5	(5+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT6	(6+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT7	(7+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT8	(8+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT9	(9+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT10	(10+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT11	(11+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT12	(12+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT13	(13+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT14	(14+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT15	(15+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT16	(16+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT17	(17+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT18	(18+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT19	(19+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT20	(20+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT21	(21+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT22	(22+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT23	(23+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT24	(24+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT25	(25+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT26	(26+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT27	(27+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT28	(28+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT29	(29+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT30	(30+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT31	(31+EMMA2RH_SW_IRQ_BASE)
+
+#define MARKEINS_PCI_IRQ_INTA	EMMA2RH_GPIO_IRQ_BASE+15
+#define MARKEINS_PCI_IRQ_INTB	EMMA2RH_GPIO_IRQ_BASE+16
+#define MARKEINS_PCI_IRQ_INTC	EMMA2RH_GPIO_IRQ_BASE+17
+#define MARKEINS_PCI_IRQ_INTD	EMMA2RH_GPIO_IRQ_BASE+18
+
+#endif /* CONFIG_MARKEINS */
Index: linux/include/asm-mips/mach-emma2rh/irq.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/mach-emma2rh/irq.h
@@ -0,0 +1,13 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 by Ralf Baechle
+ */
+#ifndef __ASM_MACH_EMMA2RH_IRQ_H
+#define __ASM_MACH_EMMA2RH_IRQ_H
+
+#define NR_IRQS	256
+
+#endif /* __ASM_MACH_EMMA2RH_IRQ_H */
Index: linux/arch/mips/Makefile
===================================================================
--- linux.orig/arch/mips/Makefile
+++ linux/arch/mips/Makefile
@@ -469,6 +469,15 @@ libs-$(CONFIG_PNX8550_JBS)	+= arch/mips/
 #cflags-$(CONFIG_PNX8550_JBS)	+= -Iinclude/asm-mips/mach-pnx8550
 load-$(CONFIG_PNX8550_JBS)	+= 0xffffffff80060000
 
+# NEC EMMA2RH boards
+#
+core-$(CONFIG_EMMA2RH)          += arch/mips/emma2rh/common/
+cflags-$(CONFIG_EMMA2RH)        += -Iinclude/asm-mips/mach-emma2rh
+
+# NEC EMMA2RH Mark-eins
+core-$(CONFIG_MARKEINS)         += arch/mips/emma2rh/markeins/
+load-$(CONFIG_MARKEINS)         += 0xffffffff88100000
+
 #
 # SGI IP22 (Indy/Indigo2)
 #
