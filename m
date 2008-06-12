Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 13:29:55 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.230]:51950 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28578597AbYFLM3u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 13:29:50 +0100
Received: by wr-out-0506.google.com with SMTP id 58so2061100wri.8
        for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 05:29:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:x-google-sender-auth;
        bh=d7O6ltFeaaP4nH4abOzuVDwctAWvlftPoZCbd9c0fgw=;
        b=M31x4X8EmbgnIzgq6bVOS1j3ehUxV9qJa5Gjn7AdkZxQRljjudVkyidmJvRk8+N/oB
         OSXihVGuiswcavpjo+79RHHNo2jmUL4zLjL6BWOrxzxQEImg/8tktyK5HyRrpI5B5m7s
         iUmB18hCPwSui2gOgGDVXv5gSefZ473KMRmzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :x-google-sender-auth;
        b=aq3QqkJcEqldg7ZkIGDgiapB3ct9WQbJXSmTK3q357/KoF75DZfACuxlozj1MgEkrk
         d+v41g9KGEuSo+g3PWJuN6ZvuAY2pFyfya//YTZvTtwqJnaBKMhqtCxM/bNQFgdVx9zT
         qdaKRevoFGBiet29tCewq1xWe9eQduu8PFPrw=
Received: by 10.90.31.6 with SMTP id e6mr575545age.43.1213273787424;
        Thu, 12 Jun 2008 05:29:47 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Thu, 12 Jun 2008 05:29:47 -0700 (PDT)
Message-ID: <64660ef00806120529l5c5979a0j6eb81c0dfc36fabb@mail.gmail.com>
Date:	Thu, 12 Jun 2008 13:29:47 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: =?WINDOWS-1256?Q?[PATCH]_:_Add_support_for_NXP_PNX833x_?= =?WINDOWS-1256?Q?(STB222/5)_into_linux_kernel=FE_(UPDATE)?=
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40178_9324120.1213273787394"
X-Google-Sender-Auth: 2576dc4542b7453c
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

------=_Part_40178_9324120.1213273787394
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following patch add support for the NXP PNX833x SOC.  More
specifically it adds support for the STB222/5 variant.

 arch/mips/Kconfig                           |   33
 arch/mips/Makefile                          |    8
 arch/mips/configs/pnx8335-stb225_defconfig  | 1150 ++++++++++++++++++++++++++++
 arch/mips/nxp/pnx833x/common/Makefile       |    1
 arch/mips/nxp/pnx833x/common/gdb_hook.c     |  134 +++
 arch/mips/nxp/pnx833x/common/interrupts.c   |  365 ++++++++
 arch/mips/nxp/pnx833x/common/platform.c     |  306 +++++++
 arch/mips/nxp/pnx833x/common/prom.c         |   70 +
 arch/mips/nxp/pnx833x/common/reset.c        |   45 +
 arch/mips/nxp/pnx833x/common/setup.c        |   64 +
 arch/mips/nxp/pnx833x/stb22x/Makefile       |    1
 arch/mips/nxp/pnx833x/stb22x/board.c        |  133 +++
 include/asm-mips/mach-pnx833x/gpio.h        |  172 ++++
 include/asm-mips/mach-pnx833x/irq-mapping.h |  126 +++
 include/asm-mips/mach-pnx833x/irq.h         |   53 +
 include/asm-mips/mach-pnx833x/pnx833x.h     |  202 ++++
 include/asm-mips/mach-pnx833x/war.h         |   25
 17 files changed, 2888 insertions(+)

Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig
linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig
--- linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig	2008-06-04
15:58:03.000000000 +0100
@@ -0,0 +1,1150 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.26-rc4
+# Wed Jun  4 15:57:17 2008
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
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MIPS_SIM is not set
+# CONFIG_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+CONFIG_NXP_STB225=y
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
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_WR_PPMC is not set
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
+CONFIG_CSRC_R4K=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_HOTPLUG_CPU is not set
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_SOC_PNX833X=y
+CONFIG_SOC_PNX8335=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_MIPS32_R1 is not set
+CONFIG_CPU_MIPS32_R2=y
+# CONFIG_CPU_MIPS64_R1 is not set
+# CONFIG_CPU_MIPS64_R2 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_MIPS32_R2=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR2=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
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
+CONFIG_CPU_MIPSR2_IRQ_VI=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
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
+CONFIG_HZ_128=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=128
+# CONFIG_PREEMPT_NONE is not set
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_PREEMPT is not set
+# CONFIG_KEXEC is not set
+# CONFIG_SECCOMP is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_PCSPKR_PLATFORM=y
+CONFIG_COMPAT_BRK=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
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
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_CLASSIC_RCU=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_MMU=y
+# CONFIG_PCCARD is not set
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
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
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
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+CONFIG_INET_AH=y
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
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
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
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
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
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
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+# CONFIG_MTD_CFI_NOSWAP is not set
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_LE_BYTE_SWAP=y
+CONFIG_MTD_CFI_GEOMETRY=y
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
+# CONFIG_MTD_OTP is not set
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
+CONFIG_MTD_PHYSMAP_START=0x18000000
+CONFIG_MTD_PHYSMAP_LEN=0x04000000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
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
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
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
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_MV is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_DM9000 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+# CONFIG_IP3902 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=m
+CONFIG_INPUT_EVBUG=m
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+# CONFIG_VT_CONSOLE is not set
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
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
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_ALGOPCA=y
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+CONFIG_I2C_PNX0105=y
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
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
+CONFIG_DVB_CORE=y
+CONFIG_VIDEO_MEDIA=y
+
+#
+# Multimedia drivers
+#
+# CONFIG_MEDIA_ATTACH is not set
+CONFIG_MEDIA_TUNER=y
+# CONFIG_MEDIA_TUNER_CUSTOMIZE is not set
+CONFIG_MEDIA_TUNER_SIMPLE=y
+CONFIG_MEDIA_TUNER_TDA8290=y
+CONFIG_MEDIA_TUNER_TDA9887=y
+CONFIG_MEDIA_TUNER_TEA5761=y
+CONFIG_MEDIA_TUNER_TEA5767=y
+CONFIG_MEDIA_TUNER_MT20XX=y
+CONFIG_MEDIA_TUNER_XC2028=y
+CONFIG_MEDIA_TUNER_XC5000=y
+CONFIG_DVB_CAPTURE_DRIVERS=y
+# CONFIG_TTPCI_EEPROM is not set
+# CONFIG_DVB_B2C2_FLEXCOP is not set
+
+#
+# Supported DVB Frontends
+#
+
+#
+# Customise DVB Frontends
+#
+# CONFIG_DVB_FE_CUSTOMISE is not set
+
+#
+# DVB-S (satellite) frontends
+#
+# CONFIG_DVB_CX24110 is not set
+# CONFIG_DVB_CX24123 is not set
+# CONFIG_DVB_MT312 is not set
+# CONFIG_DVB_S5H1420 is not set
+# CONFIG_DVB_STV0299 is not set
+# CONFIG_DVB_TDA8083 is not set
+# CONFIG_DVB_TDA10086 is not set
+# CONFIG_DVB_VES1X93 is not set
+# CONFIG_DVB_TUNER_ITD1000 is not set
+# CONFIG_DVB_TDA826X is not set
+# CONFIG_DVB_TUA6100 is not set
+
+#
+# DVB-T (terrestrial) frontends
+#
+# CONFIG_DVB_SP8870 is not set
+# CONFIG_DVB_SP887X is not set
+# CONFIG_DVB_CX22700 is not set
+# CONFIG_DVB_CX22702 is not set
+# CONFIG_DVB_L64781 is not set
+CONFIG_DVB_TDA1004X=y
+# CONFIG_DVB_NXT6000 is not set
+# CONFIG_DVB_MT352 is not set
+# CONFIG_DVB_ZL10353 is not set
+# CONFIG_DVB_DIB3000MB is not set
+# CONFIG_DVB_DIB3000MC is not set
+# CONFIG_DVB_DIB7000M is not set
+# CONFIG_DVB_DIB7000P is not set
+# CONFIG_DVB_TDA10048 is not set
+
+#
+# DVB-C (cable) frontends
+#
+# CONFIG_DVB_VES1820 is not set
+# CONFIG_DVB_TDA10021 is not set
+# CONFIG_DVB_TDA10023 is not set
+# CONFIG_DVB_STV0297 is not set
+
+#
+# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
+#
+# CONFIG_DVB_NXT200X is not set
+# CONFIG_DVB_OR51211 is not set
+# CONFIG_DVB_OR51132 is not set
+# CONFIG_DVB_BCM3510 is not set
+# CONFIG_DVB_LGDT330X is not set
+# CONFIG_DVB_S5H1409 is not set
+# CONFIG_DVB_AU8522 is not set
+# CONFIG_DVB_S5H1411 is not set
+
+#
+# Digital terrestrial only tuners/PLL
+#
+# CONFIG_DVB_PLL is not set
+# CONFIG_DVB_TUNER_DIB0070 is not set
+
+#
+# SEC control devices for DVB-S
+#
+# CONFIG_DVB_LNBP21 is not set
+# CONFIG_DVB_ISL6405 is not set
+# CONFIG_DVB_ISL6421 is not set
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+# CONFIG_LOGO is not set
+
+#
+# Sound
+#
+CONFIG_SOUND=m
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=m
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
+CONFIG_SND_SEQUENCER=m
+# CONFIG_SND_SEQ_DUMMY is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=m
+CONFIG_SND_PCM_OSS=m
+CONFIG_SND_PCM_OSS_PLUGINS=y
+CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+CONFIG_SND_VERBOSE_PRINTK=y
+CONFIG_SND_DEBUG=y
+CONFIG_SND_DEBUG_DETECT=y
+# CONFIG_SND_PCM_XRUN_DEBUG is not set
+
+#
+# Generic devices
+#
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_VIRMIDI is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# ALSA MIPS devices
+#
+
+#
+# System on Chip audio support
+#
+# CONFIG_SND_SOC is not set
+
+#
+# ALSA SoC audio for Freescale SOCs
+#
+
+#
+# SoC Audio for the Texas Instruments OMAP
+#
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+CONFIG_USB_SUPPORT=y
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=m
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
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
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
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
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
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
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+CONFIG_CRAMFS=y
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
+# CONFIG_NFS_V4 is not set
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+# CONFIG_NFSD_V4 is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
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
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=m
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
+CONFIG_NLS_CODEPAGE_932=m
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
+CONFIG_NLS_ISO8859_15=m
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=m
+# CONFIG_DLM is not set
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
+# CONFIG_DEBUG_FS is not set
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
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+CONFIG_CRYPTO_SHA1=y
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y
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
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
diff -urN --exclude=.svn linux-2.6.26-rc4.orig/arch/mips/Kconfig
linux-2.6.26-rc4/arch/mips/Kconfig
--- linux-2.6.26-rc4.orig/arch/mips/Kconfig	2008-06-03 10:56:51.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/Kconfig	2008-06-03 17:12:19.000000000 +0100
@@ -311,6 +311,19 @@
 	select SYS_HAS_CPU_VR41XX
 	select GENERIC_HARDIRQS_NO__DO_IRQ

+config NXP_STB220
+	bool "NXP STB220 board"
+	select SOC_PNX833X
+	help
+	 Support for NXP Semiconductors STB220 Development Board.
+
+config NXP_STB225
+	bool "NXP 225 board"
+	select SOC_PNX833X
+	select SOC_PNX8335
+	help
+	 Support for NXP Semiconductors STB225 Development Board.
+
 config PNX8550_JBS
 	bool "NXP PNX8550 based JBS board"
 	select PNX8550
@@ -947,6 +960,26 @@
 	bool
 	select SERIAL_RM9000

+config SOC_PNX833X
+	bool
+	select CEVT_R4K
+	select CSRC_R4K
+	select IRQ_CPU
+	select DMA_NONCOHERENT
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select SYS_SUPPORTS_KGDB
+	select GENERIC_GPIO
+	select CPU_MIPSR2_IRQ_VI
+
+config SOC_PNX8335
+	bool
+	select SOC_PNX833X
+
 config PNX8550
 	bool
 	select SOC_PNX8550
diff -urN --exclude=.svn linux-2.6.26-rc4.orig/arch/mips/Makefile
linux-2.6.26-rc4/arch/mips/Makefile
--- linux-2.6.26-rc4.orig/arch/mips/Makefile	2008-06-03 10:56:51.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/Makefile	2008-06-03 17:13:03.000000000 +0100
@@ -409,6 +409,14 @@
 #
 load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000

+# NXP STB225
+core-$(CONFIG_SOC_PNX833X)		+= arch/mips/nxp/pnx833x/common/
+cflags-$(CONFIG_SOC_PNX833X)	+= -Iinclude/asm-mips/mach-pnx833x
+libs-$(CONFIG_NXP_STB220)		+= arch/mips/nxp/pnx833x/stb22x/
+load-$(CONFIG_NXP_STB220)		+= 0xffffffff80001000
+libs-$(CONFIG_NXP_STB225)		+= arch/mips/nxp/pnx833x/stb22x/
+load-$(CONFIG_NXP_STB225)		+= 0xffffffff80001000
+
 #
 # Common NXP PNX8550
 #
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/gdb_hook.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/gdb_hook.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/gdb_hook.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/gdb_hook.c	2008-06-06
11:29:01.000000000 +0100
@@ -0,0 +1,134 @@
+/*
+ *  gdb_hook.c: gdb hook for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Based on PNX8550.
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/serial_pnx8xxx.h>
+#include <asm/mach-pnx833x/pnx833x.h>
+
+#define UART0 (unsigned char *)PNX833X_UART0_PORTS_START
+#define UART1 (unsigned char *)PNX833X_UART1_PORTS_START
+
+static unsigned char *kgdb_uart    = UART1;
+static unsigned char *console_uart = UART0;
+static volatile int delay_count;
+
+static unsigned int serial_in(unsigned char *base_address, int offset)
+{
+	return *((unsigned int volatile *)(base_address + offset));
+}
+
+static void serial_out(unsigned char *base_address, int offset, int value)
+{
+	*((unsigned int volatile *)(base_address + offset)) = value;
+}
+
+static void do_delay(void)
+{
+	int i;
+	for (i = 0; i < 10000; i++)
+		delay_count++;
+}
+
+static int put_char(unsigned char *base_address, char c)
+{
+	/* Wait for TX to be ready */
+	while (((serial_in(base_address, PNX8XXX_FIFO) &
PNX8XXX_UART_FIFO_TXFIFO) >> 16) > 15)
+		do_delay();
+
+	/* Send the next character */
+	serial_out(base_address, PNX8XXX_FIFO, c);
+	serial_out(base_address, PNX8XXX_ICLR, PNX8XXX_UART_INT_TX);
+
+	return 1;
+}
+
+static char get_char(unsigned char *base_address)
+{
+	char output;
+
+	/* Wait for RX to be ready */
+	while ((serial_in(base_address, PNX8XXX_FIFO) &
PNX8XXX_UART_FIFO_RXFIFO) == 0)
+		do_delay();
+
+	/* Get the character */
+	output = serial_in(base_address, PNX8XXX_FIFO) & 0xFF;
+
+	/* Move onto the next character in the buffer */
+	serial_out(base_address, PNX8XXX_LCR, serial_in(base_address,
PNX8XXX_LCR) | PNX8XXX_UART_LCR_RX_NEXT);
+	serial_out(base_address, PNX8XXX_ICLR, PNX8XXX_UART_INT_RX);
+
+	return output;
+}
+
+static void serial_init(unsigned char *base_address)
+{
+	serial_out(base_address, PNX8XXX_LCR, PNX8XXX_UART_LCR_8BIT |
PNX8XXX_UART_LCR_TX_RST | PNX8XXX_UART_LCR_RX_RST);
+	serial_out(base_address, PNX8XXX_MCR, PNX8XXX_UART_MCR_DTR |
PNX8XXX_UART_MCR_RTS);
+	serial_out(base_address, PNX8XXX_BAUD, 1); /* 115200 Baud */
+	serial_out(base_address, PNX8XXX_CFG, 0x00060030);
+	serial_out(base_address, PNX8XXX_ICLR, -1);
+	serial_out(base_address, PNX8XXX_IEN, 0);
+}
+
+static void setup_serial_output(void)
+{
+	static bool initialised;
+	if (!initialised) {
+		serial_init(kgdb_uart);
+		serial_init(console_uart);
+		initialised = true;
+	}
+}
+
+int rs_kgdb_hook(int tty_no, int speed)
+{
+	kgdb_uart    = tty_no ? UART1 : UART0;
+	console_uart = tty_no ? UART0 : UART1;
+
+	setup_serial_output();
+
+	return speed;
+}
+
+int prom_putchar(char c)
+{
+	setup_serial_output();
+	return put_char(console_uart, c);
+}
+
+char prom_getchar(void)
+{
+	setup_serial_output();
+	return get_char(console_uart);
+}
+
+int put_debug_char(char c)
+{
+	setup_serial_output();
+	return put_char(kgdb_uart, c);
+}
+
+char get_debug_char(void)
+{
+	setup_serial_output();
+	return get_char(kgdb_uart);
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/interrupts.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/interrupts.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c	2008-06-12
12:56:11.000000000 +0100
@@ -0,0 +1,365 @@
+/*
+ *  interrupts.c: Interrupt mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+#include <linux/interrupt.h>
+#include <asm/mipsregs.h>
+#include <asm/irq_cpu.h>
+#include <irq.h>
+#include <irq-mapping.h>
+#include <gpio.h>
+
+static const unsigned int irq_prio[PNX833X_PIC_NUM_IRQ] =
+{
+    0, /* unused */
+    4, /* PNX833X_PIC_I2C0_INT                 1 */
+    4, /* PNX833X_PIC_I2C1_INT                 2 */
+    1, /* PNX833X_PIC_UART0_INT                3 */
+    1, /* PNX833X_PIC_UART1_INT                4 */
+    6, /* PNX833X_PIC_TS_IN0_DV_INT            5 */
+    6, /* PNX833X_PIC_TS_IN0_DMA_INT           6 */
+    7, /* PNX833X_PIC_GPIO_INT                 7 */
+    4, /* PNX833X_PIC_AUDIO_DEC_INT            8 */
+    5, /* PNX833X_PIC_VIDEO_DEC_INT            9 */
+    4, /* PNX833X_PIC_CONFIG_INT              10 */
+    4, /* PNX833X_PIC_AOI_INT                 11 */
+    9, /* PNX833X_PIC_SYNC_INT                12 */
+    9, /* PNX8335_PIC_SATA_INT                13 */
+    4, /* PNX833X_PIC_OSD_INT                 14 */
+    9, /* PNX833X_PIC_DISP1_INT               15 */
+    4, /* PNX833X_PIC_DEINTERLACER_INT        16 */
+    9, /* PNX833X_PIC_DISPLAY2_INT            17 */
+    4, /* PNX833X_PIC_VC_INT                  18 */
+    4, /* PNX833X_PIC_SC_INT                  19 */
+    9, /* PNX833X_PIC_IDE_INT                 20 */
+    9, /* PNX833X_PIC_IDE_DMA_INT             21 */
+    6, /* PNX833X_PIC_TS_IN1_DV_INT           22 */
+    6, /* PNX833X_PIC_TS_IN1_DMA_INT          23 */
+    4, /* PNX833X_PIC_SGDX_DMA_INT            24 */
+    4, /* PNX833X_PIC_TS_OUT_INT              25 */
+    4, /* PNX833X_PIC_IR_INT                  26 */
+    3, /* PNX833X_PIC_VMSP1_INT               27 */
+    3, /* PNX833X_PIC_VMSP2_INT               28 */
+    4, /* PNX833X_PIC_PIBC_INT                29 */
+    4, /* PNX833X_PIC_TS_IN0_TRD_INT          30 */
+    4, /* PNX833X_PIC_SGDX_TPD_INT            31 */
+    5, /* PNX833X_PIC_USB_INT                 32 */
+    4, /* PNX833X_PIC_TS_IN1_TRD_INT          33 */
+    4, /* PNX833X_PIC_CLOCK_INT               34 */
+    4, /* PNX833X_PIC_SGDX_PARSER_INT         35 */
+    4, /* PNX833X_PIC_VMSP_DMA_INT            36 */
+#if defined(CONFIG_SOC_PNX8335)
+    4, /* PNX8335_PIC_MIU_INT                 37 */
+    4, /* PNX8335_PIC_AVCHIP_IRQ_INT          38 */
+    9, /* PNX8335_PIC_SYNC_HD_INT             39 */
+    9, /* PNX8335_PIC_DISP_HD_INT             40 */
+    9, /* PNX8335_PIC_DISP_SCALER_INT         41 */
+    4, /* PNX8335_PIC_OSD_HD1_INT             42 */
+    4, /* PNX8335_PIC_DTL_WRITER_Y_INT        43 */
+    4, /* PNX8335_PIC_DTL_WRITER_C_INT        44 */
+    4, /* PNX8335_PIC_DTL_EMULATOR_Y_IR_INT   45 */
+    4, /* PNX8335_PIC_DTL_EMULATOR_C_IR_INT   46 */
+    4, /* PNX8335_PIC_DENC_TTX_INT            47 */
+    4, /* PNX8335_PIC_MMI_SIF0_INT            48 */
+    4, /* PNX8335_PIC_MMI_SIF1_INT            49 */
+    4, /* PNX8335_PIC_MMI_CDMMU_INT           50 */
+    4, /* PNX8335_PIC_PIBCS_INT               51 */
+   12, /* PNX8335_PIC_ETHERNET_INT            52 */
+    3, /* PNX8335_PIC_VMSP1_0_INT             53 */
+    3, /* PNX8335_PIC_VMSP1_1_INT             54 */
+    4, /* PNX8335_PIC_VMSP1_DMA_INT           55 */
+    4, /* PNX8335_PIC_TDGR_DE_INT             56 */
+    4, /* PNX8335_PIC_IR1_IRQ_INT             57 */
+#endif
+};
+
+static void pic_dispatch(void)
+{
+	unsigned int irq = PNX833X_REGFIELD(PIC_INT_SRC, INT_SRC);
+
+	if ((irq >= 1) && (irq < (PNX833X_PIC_NUM_IRQ))) {
+		unsigned long priority = PNX833X_PIC_INT_PRIORITY;
+		PNX833X_PIC_INT_PRIORITY = irq_prio[irq];
+
+		if (irq == PNX833X_PIC_GPIO_INT) {
+			unsigned long mask = PNX833X_PIO_INT_STATUS & PNX833X_PIO_INT_ENABLE;
+			int pin;
+			while ((pin = ffs(mask & 0xffff))) {
+				pin -= 1;
+				do_IRQ(PNX833X_GPIO_IRQ_BASE + pin);
+				mask &= ~(1 << pin);
+			}
+		} else {
+			do_IRQ(irq + PNX833X_PIC_IRQ_BASE);
+		}
+
+		PNX833X_PIC_INT_PRIORITY = priority;
+	} else {
+		printk(KERN_ERR "plat_irq_dispatch: unexpected irq %u\n", irq);
+	}
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause();
+
+	if (pending & STATUSF_IP4)
+		pic_dispatch();
+	else if (pending & STATUSF_IP7)
+		do_IRQ(PNX833X_TIMER_IRQ);
+	else
+		spurious_interrupt();
+}
+
+static inline void pnx833x_hard_enable_pic_irq(unsigned int irq)
+{
+	/* Currently we do this by setting IRQ priority to 1.
+	   If priority support is being implemented, 1 should be repalced
+		by a better value. */
+	PNX833X_PIC_INT_REG(irq) = irq_prio[irq];
+}
+
+static inline void pnx833x_hard_disable_pic_irq(unsigned int irq)
+{
+	/* Disable IRQ by writing setting it's priority to 0 */
+	PNX833X_PIC_INT_REG(irq) = 0;
+}
+
+static int irqflags[PNX833X_PIC_NUM_IRQ];	/* initialized by zeroes */
+#define IRQFLAG_STARTED		1
+#define IRQFLAG_DISABLED	2
+
+static DEFINE_SPINLOCK(pnx833x_irq_lock);
+
+static unsigned int pnx833x_startup_pic_irq(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+	spin_lock_irqsave(&pnx833x_irq_lock, flags);
+
+	irqflags[pic_irq] = IRQFLAG_STARTED;	/* started, not disabled */
+	pnx833x_hard_enable_pic_irq(pic_irq);
+
+	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
+	return 0;
+}
+
+static void pnx833x_shutdown_pic_irq(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+	spin_lock_irqsave(&pnx833x_irq_lock, flags);
+
+	irqflags[pic_irq] = 0;			/* not started */
+	pnx833x_hard_disable_pic_irq(pic_irq);
+
+	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
+}
+
+static void pnx833x_enable_pic_irq(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+	spin_lock_irqsave(&pnx833x_irq_lock, flags);
+
+	irqflags[pic_irq] &= ~IRQFLAG_DISABLED;
+	if (irqflags[pic_irq] == IRQFLAG_STARTED)
+		pnx833x_hard_enable_pic_irq(pic_irq);
+
+	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
+}
+
+static void pnx833x_disable_pic_irq(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+	spin_lock_irqsave(&pnx833x_irq_lock, flags);
+
+	irqflags[pic_irq] |= IRQFLAG_DISABLED;
+	pnx833x_hard_disable_pic_irq(pic_irq);
+
+	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
+}
+
+static void pnx833x_ack_pic_irq(unsigned int irq)
+{
+}
+
+static void pnx833x_end_pic_irq(unsigned int irq)
+{
+}
+
+static DEFINE_SPINLOCK(pnx833x_gpio_pnx833x_irq_lock);
+
+static unsigned int pnx833x_startup_gpio_irq(unsigned int irq)
+{
+	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	unsigned long flags;
+	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
+	pnx833x_gpio_enable_irq(pin);
+	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
+	return 0;
+}
+
+static void pnx833x_enable_gpio_irq(unsigned int irq)
+{
+	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	unsigned long flags;
+	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
+	pnx833x_gpio_enable_irq(pin);
+	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
+}
+
+static void pnx833x_disable_gpio_irq(unsigned int irq)
+{
+	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	unsigned long flags;
+	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
+	pnx833x_gpio_disable_irq(pin);
+	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
+}
+
+static void pnx833x_ack_gpio_irq(unsigned int irq)
+{
+}
+
+static void pnx833x_end_gpio_irq(unsigned int irq)
+{
+	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	unsigned long flags;
+	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
+	pnx833x_gpio_clear_irq(pin);
+	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
+}
+
+static int pnx833x_set_type_gpio_irq(unsigned int irq, unsigned int flow_type)
+{
+	int pin = irq - PNX833X_GPIO_IRQ_BASE;
+	int gpio_mode;
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		gpio_mode = GPIO_INT_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		gpio_mode = GPIO_INT_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		gpio_mode = GPIO_INT_EDGE_BOTH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		gpio_mode = GPIO_INT_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		gpio_mode = GPIO_INT_LEVEL_LOW;
+		break;
+	default:
+		gpio_mode = GPIO_INT_NONE;
+		break;
+	}
+
+	pnx833x_gpio_setup_irq(gpio_mode, pin);
+
+	return 0;
+}
+
+static struct irq_chip pnx833x_pic_irq_type = {
+	.typename = "PNX-PIC",
+	.startup = pnx833x_startup_pic_irq,
+	.shutdown = pnx833x_shutdown_pic_irq,
+	.enable = pnx833x_enable_pic_irq,
+	.disable = pnx833x_disable_pic_irq,
+	.ack = pnx833x_ack_pic_irq,
+	.end = pnx833x_end_pic_irq
+};
+
+static struct irq_chip pnx833x_gpio_irq_type = {
+	.typename = "PNX-GPIO",
+	.startup = pnx833x_startup_gpio_irq,
+	.shutdown = pnx833x_disable_gpio_irq,
+	.enable = pnx833x_enable_gpio_irq,
+	.disable = pnx833x_disable_gpio_irq,
+	.ack = pnx833x_ack_gpio_irq,
+	.end = pnx833x_end_gpio_irq,
+	.set_type = pnx833x_set_type_gpio_irq
+};
+
+void __init arch_init_irq(void)
+{
+	unsigned int irq;
+
+	/* setup standard internal cpu irqs */
+	mips_cpu_irq_init();
+
+	/* Set IRQ information in irq_desc */
+	for (irq = PNX833X_PIC_IRQ_BASE; irq < (PNX833X_PIC_IRQ_BASE +
PNX833X_PIC_NUM_IRQ); irq++) {
+		pnx833x_hard_disable_pic_irq(irq);
+		set_irq_chip_and_handler(irq, &pnx833x_pic_irq_type, handle_simple_irq);
+	}
+
+	for (irq = PNX833X_GPIO_IRQ_BASE; irq < (PNX833X_GPIO_IRQ_BASE +
PNX833X_GPIO_NUM_IRQ); irq++)
+		set_irq_chip_and_handler(irq, &pnx833x_gpio_irq_type, handle_simple_irq);
+
+	/* Set PIC priority limiter register to 0 */
+	PNX833X_PIC_INT_PRIORITY = 0;
+
+	/* Setup GPIO IRQ dispatching */
+	pnx833x_startup_pic_irq(PNX833X_PIC_GPIO_INT);
+
+	/* Enable PIC IRQs (HWIRQ2) */
+	if (cpu_has_vint)
+		set_vi_handler(4, pic_dispatch);
+
+	write_c0_status(read_c0_status() | IE_IRQ2);
+}
+
+
+void __init plat_time_init(void)
+{
+	/* calculate mips_hpt_frequency based on PNX833X_CLOCK_CPUCP_CTL reg */
+
+	extern unsigned long mips_hpt_frequency;
+	unsigned long reg = PNX833X_CLOCK_CPUCP_CTL;
+
+	if (!(PNX833X_BIT(reg, CLOCK_CPUCP_CTL, EXIT_RESET))) {
+		/* Functional clock is disabled so use crystal frequency */
+		mips_hpt_frequency = 25;
+	} else {
+#if defined(CONFIG_SOC_PNX8335)
+		/* Functional clock is enabled, so get clock multiplier */
+		mips_hpt_frequency = 90 + (10 * PNX8335_REGFIELD(CLOCK_PLL_CPU_CTL, FREQ));
+#else
+		static const unsigned long int freq[4] = {240, 160, 120, 80};
+		mips_hpt_frequency = freq[PNX833X_FIELD(reg, CLOCK_CPUCP_CTL, DIV_CLOCK)];
+#endif
+	}
+
+	printk(KERN_INFO "CPU clock is %ld MHz\n", mips_hpt_frequency);
+
+	mips_hpt_frequency *= 500000;
+}
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/Makefile
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/Makefile
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/Makefile	2008-03-03
13:09:30.000000000 +0000
@@ -0,0 +1 @@
+obj-y := interrupts.o platform.o prom.o setup.o reset.o gdb_hook.o
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/platform.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/platform.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/platform.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/platform.c	2008-06-12
13:08:07.000000000 +0100
@@ -0,0 +1,306 @@
+/*
+ *  platform.c: platform support for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Based on software written by:
+ *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/serial.h>
+#include <linux/serial_pnx8xxx.h>
+#include <linux/i2c-pnx0105.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+#include <irq.h>
+#include <irq-mapping.h>
+#include <pnx833x.h>
+
+static u64 uart_dmamask     = ~(u32)0;
+
+static struct resource pnx833x_uart_resources[] = {
+	[0] = {
+		.start		= PNX833X_UART0_PORTS_START,
+		.end		= PNX833X_UART0_PORTS_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= PNX833X_PIC_UART0_INT,
+		.end		= PNX833X_PIC_UART0_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= PNX833X_UART1_PORTS_START,
+		.end		= PNX833X_UART1_PORTS_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	[3] = {
+		.start		= PNX833X_PIC_UART1_INT,
+		.end		= PNX833X_PIC_UART1_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+struct pnx8xxx_port pnx8xxx_ports[] = {
+	[0] = {
+		.port   = {
+			.type		= PORT_PNX8XXX,
+			.iotype		= UPIO_MEM,
+			.membase	= (void __iomem *)PNX833X_UART0_PORTS_START,
+			.mapbase	= PNX833X_UART0_PORTS_START,
+			.irq		= PNX833X_PIC_UART0_INT,
+			.uartclk	= 3692300,
+			.fifosize	= 16,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 0,
+		},
+	},
+	[1] = {
+		.port   = {
+			.type		= PORT_PNX8XXX,
+			.iotype		= UPIO_MEM,
+			.membase	= (void __iomem *)PNX833X_UART1_PORTS_START,
+			.mapbase	= PNX833X_UART1_PORTS_START,
+			.irq		= PNX833X_PIC_UART1_INT,
+			.uartclk	= 3692300,
+			.fifosize	= 16,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 1,
+		},
+	},
+};
+
+static struct platform_device pnx833x_uart_device = {
+	.name		= "pnx8xxx-uart",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &uart_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= pnx8xxx_ports,
+	},
+	.num_resources	= ARRAY_SIZE(pnx833x_uart_resources),
+	.resource	= pnx833x_uart_resources,
+};
+
+static u64 ehci_dmamask     = ~(u32)0;
+
+static struct resource pnx833x_usb_ehci_resources[] = {
+	[0] = {
+		.start		= PNX833X_USB_PORTS_START,
+		.end		= PNX833X_USB_PORTS_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= PNX833X_PIC_USB_INT,
+		.end		= PNX833X_PIC_USB_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pnx833x_usb_ehci_device = {
+	.name		= "pnx833x-ehci",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(pnx833x_usb_ehci_resources),
+	.resource	= pnx833x_usb_ehci_resources,
+};
+
+static struct resource pnx833x_i2c0_resources[] = {
+	{
+		.start		= PNX833X_I2C0_PORTS_START,
+		.end		= PNX833X_I2C0_PORTS_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= PNX833X_PIC_I2C0_INT,
+		.end		= PNX833X_PIC_I2C0_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource pnx833x_i2c1_resources[] = {
+	{
+		.start		= PNX833X_I2C1_PORTS_START,
+		.end		= PNX833X_I2C1_PORTS_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= PNX833X_PIC_I2C1_INT,
+		.end		= PNX833X_PIC_I2C1_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct i2c_pnx0105_dev pnx833x_i2c_dev[] = {
+	{
+		.base = PNX833X_I2C0_PORTS_START,
+		.irq = -1, /* should be PNX833X_PIC_I2C0_INT but polling is faster */
+		.clock = 6,	/* 0 == 400 kHz, 4 == 100 kHz(Maximum HDMI), 6 =
50kHz(Prefered HDCP) */
+		.bus_addr = 0,	/* no slave support */
+	},
+	{
+		.base = PNX833X_I2C1_PORTS_START,
+		.irq = -1,	/* on high freq, polling is faster */
+		/*.irq = PNX833X_PIC_I2C1_INT,*/
+		.clock = 4,	/* 0 == 400 kHz, 4 == 100 kHz. 100 kHz seems a safe
default for now */
+		.bus_addr = 0,	/* no slave support */
+	},
+};
+
+static struct platform_device pnx833x_i2c0_device = {
+	.name		= "i2c-pnx0105",
+	.id		= 0,
+	.dev = {
+		.platform_data = &pnx833x_i2c_dev[0],
+	},
+	.num_resources  = ARRAY_SIZE(pnx833x_i2c0_resources),
+	.resource	= pnx833x_i2c0_resources,
+};
+
+static struct platform_device pnx833x_i2c1_device = {
+	.name		= "i2c-pnx0105",
+	.id		= 1,
+	.dev = {
+		.platform_data = &pnx833x_i2c_dev[1],
+	},
+	.num_resources  = ARRAY_SIZE(pnx833x_i2c1_resources),
+	.resource	= pnx833x_i2c1_resources,
+};
+
+static u64 ethernet_dmamask = ~(u32)0;
+
+static struct resource pnx833x_ethernet_resources[] = {
+	[0] = {
+		.start = PNX8335_IP3902_PORTS_START,
+		.end   = PNX8335_IP3902_PORTS_END,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = PNX8335_PIC_ETHERNET_INT,
+		.end   = PNX8335_PIC_ETHERNET_INT,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pnx833x_ethernet_device = {
+	.name = "ip3902-eth",
+	.id   = -1,
+	.dev  = {
+		.dma_mask          = &ethernet_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+	.num_resources = ARRAY_SIZE(pnx833x_ethernet_resources),
+	.resource      = pnx833x_ethernet_resources,
+};
+
+static struct resource pnx833x_sata_resources[] = {
+	[0] = {
+		.start = PNX8335_SATA_PORTS_START,
+		.end   = PNX8335_SATA_PORTS_END,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = PNX8335_PIC_SATA_INT,
+		.end   = PNX8335_PIC_SATA_INT,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pnx833x_sata_device = {
+	.name          = "pnx833x-sata",
+	.id            = -1,
+	.num_resources = ARRAY_SIZE(pnx833x_sata_resources),
+	.resource      = pnx833x_sata_resources,
+};
+
+static const char *part_probes[] = { "cmdlinepart", 0 };
+
+static void
+pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	if (ctrl & NAND_CLE)
+		writeb(cmd, (void __iomem *)(nandaddr + PNX8335_NAND_CLE_MASK));
+	else
+		writeb(cmd, (void __iomem *) (nandaddr + PNX8335_NAND_ALE_MASK));
+}
+
+static struct platform_nand_data pnx833x_flash_nand_data = {
+	.chip = {
+		.chip_delay		= 25,
+		.part_probe_types 	= part_probes,
+	},
+	.ctrl = {
+		.cmd_ctrl 		= pnx833x_flash_nand_cmd_ctrl
+	}
+};
+
+/*
+ * Set start to be the correct address (PNX8335_NAND_BASE with no 0xb!!),
+ * 12 bytes more seems to be the standard that allows for NAND access.
+ */
+static struct resource pnx833x_flash_nand_resource = {
+	.start 	= PNX8335_NAND_BASE,
+	.end 	= PNX8335_NAND_BASE + 12,
+	.flags 	= IORESOURCE_MEM,
+};
+
+static struct platform_device pnx833x_flash_nand = {
+	.name	        = "gen_nand",
+	.id		        = -1,
+	.num_resources	= 1,
+	.resource	    = &pnx833x_flash_nand_resource,
+	.dev            = {
+		.platform_data = &pnx833x_flash_nand_data,
+	},
+};
+
+static struct platform_device *pnx833x_platform_devices[] __initdata = {
+	&pnx833x_uart_device,
+	&pnx833x_usb_ehci_device,
+	&pnx833x_i2c0_device,
+	&pnx833x_i2c1_device,
+	&pnx833x_ethernet_device,
+	&pnx833x_sata_device,
+	&pnx833x_flash_nand,
+};
+
+static int __init pnx833x_platform_init(void)
+{
+	int res;
+
+	res = platform_add_devices(pnx833x_platform_devices,
+							   ARRAY_SIZE(pnx833x_platform_devices));
+	return res;
+}
+
+arch_initcall(pnx833x_platform_init);
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/prom.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/prom.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/prom.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/prom.c	2008-06-06
11:29:55.000000000 +0100
@@ -0,0 +1,70 @@
+/*
+ *  prom.c:
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Based on software written by:
+ *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <asm/bootinfo.h>
+#include <linux/string.h>
+
+void __init prom_init_cmdline(void)
+{
+	int argc = fw_arg0;
+	char **argv = (char **)fw_arg1;
+	char *c = &(arcs_cmdline[0]);
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		strcpy(c, argv[i]);
+		c += strlen(argv[i]);
+		if (i < argc-1)
+			*c++ = ' ';
+	}
+	*c = 0;
+}
+
+char __init *prom_getenv(char *envname)
+{
+	extern char **prom_envp;
+	char **env = prom_envp;
+	int i;
+
+	i = strlen(envname);
+
+	while (*env) {
+		if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
+			return *env + i + 1;
+		env++;
+	}
+
+	return 0;
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+char * __init prom_getcmdline(void)
+{
+	return arcs_cmdline;
+}
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/reset.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/reset.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/reset.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/reset.c	2008-06-12
12:01:23.000000000 +0100
@@ -0,0 +1,45 @@
+/*
+ *  reset.c: reset support for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Based on software written by:
+ *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/slab.h>
+#include <linux/reboot.h>
+#include <pnx833x.h>
+
+void pnx833x_machine_restart(char *command)
+{
+	PNX833X_RESET_CONTROL_2 = 0;
+	PNX833X_RESET_CONTROL = 0;
+}
+
+void pnx833x_machine_halt(void)
+{
+	while (1)
+		__asm__ __volatile__ ("wait");
+
+}
+
+void pnx833x_machine_power_off(void)
+{
+	pnx833x_machine_halt();
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/setup.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/setup.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/setup.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/setup.c	2008-06-06
11:30:16.000000000 +0100
@@ -0,0 +1,64 @@
+/*
+ *  setup.c: Setup PNX833X Soc.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Based on software written by:
+ *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <asm/reboot.h>
+#include <pnx833x.h>
+#include <gpio.h>
+
+extern void pnx833x_board_setup(void);
+extern void pnx833x_machine_restart(char *);
+extern void pnx833x_machine_halt(void);
+extern void pnx833x_machine_power_off(void);
+
+int __init plat_mem_setup(void)
+{
+	/* fake pci bus to avoid bounce buffers */
+	PCI_DMA_BUS_IS_PHYS = 1;
+
+	/* set mips clock to 320MHz */
+#if defined(CONFIG_SOC_PNX8335)
+	PNX8335_WRITEFIELD(0x17, CLOCK_PLL_CPU_CTL, FREQ);
+#endif
+	pnx833x_gpio_init();	/* so it will be ready in board_setup() */
+
+	pnx833x_board_setup();
+
+	_machine_restart = pnx833x_machine_restart;
+	_machine_halt = pnx833x_machine_halt;
+	pm_power_off = pnx833x_machine_power_off;
+
+	/* IO/MEM resources. */
+	set_io_port_base(KSEG1);
+	ioport_resource.start = 0;
+	ioport_resource.end = ~0;
+	iomem_resource.start = 0;
+	iomem_resource.end = ~0;
+
+	return 0;
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/board.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/board.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/board.c	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/board.c	2008-06-06
11:28:50.000000000 +0100
@@ -0,0 +1,133 @@
+/*
+ *  board.c: STB225 board support.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Based on software written by:
+ *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <asm/bootinfo.h>
+#include <linux/mm.h>
+#include <pnx833x.h>
+#include <gpio.h>
+
+/* endianess twiddlers */
+#define PNX8335_DEBUG0 0x4400
+#define PNX8335_DEBUG1 0x4404
+#define PNX8335_DEBUG2 0x4408
+#define PNX8335_DEBUG3 0x440c
+#define PNX8335_DEBUG4 0x4410
+#define PNX8335_DEBUG5 0x4414
+#define PNX8335_DEBUG6 0x4418
+#define PNX8335_DEBUG7 0x441c
+
+int prom_argc;
+char **prom_argv = 0, **prom_envp = 0;
+
+extern void prom_init_cmdline(void);
+extern char *prom_getenv(char *envname);
+
+const char *get_system_type(void)
+{
+	return "NXP STB22x";
+}
+
+static inline unsigned long env_or_default(char *env, unsigned long dfl)
+{
+	char *str = prom_getenv(env);
+	return str ? simple_strtol(str, 0, 0) : dfl;
+}
+
+void __init prom_init(void)
+{
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize = env_or_default("memsize", 0x02000000);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
+void __init pnx833x_board_setup(void)
+{
+	pnx833x_gpio_select_function_alt(4);
+	pnx833x_gpio_select_output(4);
+	pnx833x_gpio_select_function_alt(5);
+	pnx833x_gpio_select_input(5);
+	pnx833x_gpio_select_function_alt(6);
+	pnx833x_gpio_select_input(6);
+	pnx833x_gpio_select_function_alt(7);
+	pnx833x_gpio_select_output(7);
+
+	pnx833x_gpio_select_function_alt(25);
+	pnx833x_gpio_select_function_alt(26);
+
+	pnx833x_gpio_select_function_alt(27);
+	pnx833x_gpio_select_function_alt(28);
+	pnx833x_gpio_select_function_alt(29);
+	pnx833x_gpio_select_function_alt(30);
+	pnx833x_gpio_select_function_alt(31);
+	pnx833x_gpio_select_function_alt(32);
+	pnx833x_gpio_select_function_alt(33);
+
+#if defined(CONFIG_MTD_NAND_PLATFORM) ||
defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+	/* Setup MIU for NAND access on CS0...
+	 *
+	 * (it seems that we must also configure CS1 for reliable operation,
+	 * otherwise the first read ID command will fail if it's read as 4 bytes
+	 * but pass if it's read as 1 word.)
+	 */
+
+	/* Setup MIU CS0 & CS1 timing */
+	PNX833X_MIU_SEL0 = 0;
+	PNX833X_MIU_SEL1 = 0;
+	PNX833X_MIU_SEL0_TIMING = 0x50003081;
+	PNX833X_MIU_SEL1_TIMING = 0x50003081;
+
+	/* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does
not need this) */
+	pnx833x_gpio_select_function_alt(0);
+
+	/* Setup GPIO 04 to input NAND read/busy signal */
+	pnx833x_gpio_select_function_io(4);
+	pnx833x_gpio_select_input(4);
+
+	/* Setup GPIO 05 to disable NAND write protect */
+	pnx833x_gpio_select_function_io(5);
+	pnx833x_gpio_select_output(5);
+	pnx833x_gpio_write(1, 5);
+
+#elif defined(CONFIG_MTD_CFI) || defined(CONFIG_MTD_CFI_MODULE)
+
+	/* Set up MIU for 16-bit NOR access on CS0 and CS1... */
+
+	/* Setup MIU CS0 & CS1 timing */
+	PNX833X_MIU_SEL0 = 1;
+	PNX833X_MIU_SEL1 = 1;
+	PNX833X_MIU_SEL0_TIMING = 0x6A08D082;
+	PNX833X_MIU_SEL1_TIMING = 0x6A08D082;
+
+	/* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does
not need this) */
+	pnx833x_gpio_select_function_alt(0);
+#endif
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/Makefile
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/Makefile
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/Makefile	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/Makefile	2008-03-03
13:09:30.000000000 +0000
@@ -0,0 +1 @@
+lib-y := board.o
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h	2008-06-06
11:29:09.000000000 +0100
@@ -0,0 +1,172 @@
+/*
+ *  gpio.h: GPIO Support for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_MIPS_MACH_PNX833X_GPIO_H
+#define __ASM_MIPS_MACH_PNX833X_GPIO_H
+
+/* BIG FAT WARNING: races danger!
+   No protections exist here. Current users are only early init code,
+   when locking is not needed because no cuncurency yet exists there,
+   and GPIO IRQ dispatcher, which does locking.
+   However, if many uses will ever happen, proper locking will be needed
+   - including locking between different uses
+*/
+
+#include "pnx833x.h"
+
+#define SET_REG_BIT(reg, bit)		reg |= (1 << (bit))
+#define CLEAR_REG_BIT(reg, bit)		reg &= ~(1 << (bit))
+
+/* Initialize GPIO to a known state */
+static inline void pnx833x_gpio_init(void)
+{
+	PNX833X_PIO_DIR = 0;
+	PNX833X_PIO_DIR2 = 0;
+	PNX833X_PIO_SEL = 0;
+	PNX833X_PIO_SEL2 = 0;
+	PNX833X_PIO_INT_EDGE = 0;
+	PNX833X_PIO_INT_HI = 0;
+	PNX833X_PIO_INT_LO = 0;
+
+	/* clear any GPIO interrupt requests */
+	PNX833X_PIO_INT_CLEAR = 0xffff;
+	PNX833X_PIO_INT_CLEAR = 0;
+	PNX833X_PIO_INT_ENABLE = 0;
+}
+
+/* Select GPIO direction for a pin */
+static inline void pnx833x_gpio_select_input(unsigned int pin)
+{
+	if (pin < 32)
+		CLEAR_REG_BIT(PNX833X_PIO_DIR, pin);
+	else
+		CLEAR_REG_BIT(PNX833X_PIO_DIR2, pin & 31);
+}
+static inline void pnx833x_gpio_select_output(unsigned int pin)
+{
+	if (pin < 32)
+		SET_REG_BIT(PNX833X_PIO_DIR, pin);
+	else
+		SET_REG_BIT(PNX833X_PIO_DIR2, pin & 31);
+}
+
+/* Select GPIO or alternate function for a pin */
+static inline void pnx833x_gpio_select_function_io(unsigned int pin)
+{
+	if (pin < 32)
+		CLEAR_REG_BIT(PNX833X_PIO_SEL, pin);
+	else
+		CLEAR_REG_BIT(PNX833X_PIO_SEL2, pin & 31);
+}
+static inline void pnx833x_gpio_select_function_alt(unsigned int pin)
+{
+	if (pin < 32)
+		SET_REG_BIT(PNX833X_PIO_SEL, pin);
+	else
+		SET_REG_BIT(PNX833X_PIO_SEL2, pin & 31);
+}
+
+/* Read GPIO pin */
+static inline int pnx833x_gpio_read(unsigned int pin)
+{
+	if (pin < 32)
+		return(PNX833X_PIO_IN >> pin) & 1;
+	else
+		return(PNX833X_PIO_IN2 >> (pin & 31)) & 1;
+}
+
+/* Write GPIO pin */
+static inline void pnx833x_gpio_write(unsigned int val, unsigned int pin)
+{
+	if (pin < 32) {
+		if (val)
+			SET_REG_BIT(PNX833X_PIO_OUT, pin);
+		else
+			CLEAR_REG_BIT(PNX833X_PIO_OUT, pin);
+	} else {
+		if (val)
+			SET_REG_BIT(PNX833X_PIO_OUT2, pin & 31);
+		else
+			CLEAR_REG_BIT(PNX833X_PIO_OUT2, pin & 31);
+	}
+}
+
+/* Configure GPIO interrupt */
+#define GPIO_INT_NONE		0
+#define GPIO_INT_LEVEL_LOW	1
+#define GPIO_INT_LEVEL_HIGH	2
+#define GPIO_INT_EDGE_RISING	3
+#define GPIO_INT_EDGE_FALLING	4
+#define GPIO_INT_EDGE_BOTH	5
+static inline void pnx833x_gpio_setup_irq(int when, unsigned int pin)
+{
+	switch (when) {
+	case GPIO_INT_LEVEL_LOW:
+		CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+		CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
+		SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
+		break;
+	case GPIO_INT_LEVEL_HIGH:
+		CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+		SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
+		CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
+		break;
+	case GPIO_INT_EDGE_RISING:
+		SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+		SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
+		CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
+		break;
+	case GPIO_INT_EDGE_FALLING:
+		SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+		CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
+		SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
+		break;
+	case GPIO_INT_EDGE_BOTH:
+		SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+		SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
+		SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
+		break;
+	default:
+		CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+		CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
+		CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
+		break;
+	}
+}
+
+/* Enable/disable GPIO interrupt */
+static inline void pnx833x_gpio_enable_irq(unsigned int pin)
+{
+	SET_REG_BIT(PNX833X_PIO_INT_ENABLE, pin);
+}
+static inline void pnx833x_gpio_disable_irq(unsigned int pin)
+{
+	CLEAR_REG_BIT(PNX833X_PIO_INT_ENABLE, pin);
+}
+
+/* Clear GPIO interrupt request */
+static inline void pnx833x_gpio_clear_irq(unsigned int pin)
+{
+	SET_REG_BIT(PNX833X_PIO_INT_CLEAR, pin);
+	CLEAR_REG_BIT(PNX833X_PIO_INT_CLEAR, pin);
+}
+
+#endif
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq.h	2008-06-12
13:05:31.000000000 +0100
@@ -0,0 +1,53 @@
+/*
+ *  irq.h: IRQ mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_MIPS_MACH_PNX833X_IRQ_H
+#define __ASM_MIPS_MACH_PNX833X_IRQ_H
+/*
+ * The "IRQ numbers" are completely virtual.
+ *
+ * In PNX8330/1, we have 48 interrupt lines, numbered from 1 to 48.
+ * Let's use numbers 1..48 for PIC interrupts, number 0 for timer interrupt,
+ * numbers 49..64 for (virtual) GPIO interrupts.
+ *
+ * In PNX8335, we have 57 interrupt lines, numbered from 1 to 57,
+ * connected to PIC, which uses core hardware interrupt 2, and also
+ * a timer interrupt through hardware interrupt 5.
+ * Let's use numbers 1..64 for PIC interrupts, number 0 for timer interrupt,
+ * numbers 65..80 for (virtual) GPIO interrupts.
+ *
+ */
+#if defined(CONFIG_SOC_PNX8335)
+	#define PNX833X_PIC_NUM_IRQ			58
+#else
+	#define PNX833X_PIC_NUM_IRQ			37
+#endif
+
+#define MIPS_CPU_NUM_IRQ				8
+#define PNX833X_GPIO_NUM_IRQ			16
+
+#define MIPS_CPU_IRQ_BASE				0
+#define PNX833X_PIC_IRQ_BASE			(MIPS_CPU_IRQ_BASE + MIPS_CPU_NUM_IRQ)
+#define PNX833X_GPIO_IRQ_BASE			(PNX833X_PIC_IRQ_BASE + PNX833X_PIC_NUM_IRQ)
+#define NR_IRQS							(MIPS_CPU_NUM_IRQ + PNX833X_PIC_NUM_IRQ +
PNX833X_GPIO_NUM_IRQ)
+
+#endif
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq-mapping.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq-mapping.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq-mapping.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq-mapping.h	2008-06-12
13:07:19.000000000 +0100
@@ -0,0 +1,126 @@
+
+/*
+ *  irq.h: IRQ mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_MIPS_MACH_PNX833X_IRQ_MAPPING_H
+#define __ASM_MIPS_MACH_PNX833X_IRQ_MAPPING_H
+/*
+ * The "IRQ numbers" are completely virtual.
+ *
+ * In PNX8330/1, we have 48 interrupt lines, numbered from 1 to 48.
+ * Let's use numbers 1..48 for PIC interrupts, number 0 for timer interrupt,
+ * numbers 49..64 for (virtual) GPIO interrupts.
+ *
+ * In PNX8335, we have 57 interrupt lines, numbered from 1 to 57,
+ * connected to PIC, which uses core hardware interrupt 2, and also
+ * a timer interrupt through hardware interrupt 5.
+ * Let's use numbers 1..64 for PIC interrupts, number 0 for timer interrupt,
+ * numbers 65..80 for (virtual) GPIO interrupts.
+ *
+ */
+#include <irq.h>
+
+#define PNX833X_TIMER_IRQ				(MIPS_CPU_IRQ_BASE + 7)
+
+/* Interrupts supported by PIC */
+#define PNX833X_PIC_I2C0_INT			(PNX833X_PIC_IRQ_BASE +  1)
+#define PNX833X_PIC_I2C1_INT			(PNX833X_PIC_IRQ_BASE +  2)
+#define PNX833X_PIC_UART0_INT			(PNX833X_PIC_IRQ_BASE +  3)
+#define PNX833X_PIC_UART1_INT			(PNX833X_PIC_IRQ_BASE +  4)
+#define PNX833X_PIC_TS_IN0_DV_INT		(PNX833X_PIC_IRQ_BASE +  5)
+#define PNX833X_PIC_TS_IN0_DMA_INT		(PNX833X_PIC_IRQ_BASE +  6)
+#define PNX833X_PIC_GPIO_INT			(PNX833X_PIC_IRQ_BASE +  7)
+#define PNX833X_PIC_AUDIO_DEC_INT		(PNX833X_PIC_IRQ_BASE +  8)
+#define PNX833X_PIC_VIDEO_DEC_INT		(PNX833X_PIC_IRQ_BASE +  9)
+#define PNX833X_PIC_CONFIG_INT			(PNX833X_PIC_IRQ_BASE + 10)
+#define PNX833X_PIC_AOI_INT				(PNX833X_PIC_IRQ_BASE + 11)
+#define PNX833X_PIC_SYNC_INT			(PNX833X_PIC_IRQ_BASE + 12)
+#define PNX8330_PIC_SPU_INT				(PNX833X_PIC_IRQ_BASE + 13)
+#define PNX8335_PIC_SATA_INT			(PNX833X_PIC_IRQ_BASE + 13)
+#define PNX833X_PIC_OSD_INT				(PNX833X_PIC_IRQ_BASE + 14)
+#define PNX833X_PIC_DISP1_INT			(PNX833X_PIC_IRQ_BASE + 15)
+#define PNX833X_PIC_DEINTERLACER_INT	(PNX833X_PIC_IRQ_BASE + 16)
+#define PNX833X_PIC_DISPLAY2_INT		(PNX833X_PIC_IRQ_BASE + 17)
+#define PNX833X_PIC_VC_INT				(PNX833X_PIC_IRQ_BASE + 18)
+#define PNX833X_PIC_SC_INT				(PNX833X_PIC_IRQ_BASE + 19)
+#define PNX833X_PIC_IDE_INT				(PNX833X_PIC_IRQ_BASE + 20)
+#define PNX833X_PIC_IDE_DMA_INT			(PNX833X_PIC_IRQ_BASE + 21)
+#define PNX833X_PIC_TS_IN1_DV_INT		(PNX833X_PIC_IRQ_BASE + 22)
+#define PNX833X_PIC_TS_IN1_DMA_INT		(PNX833X_PIC_IRQ_BASE + 23)
+#define PNX833X_PIC_SGDX_DMA_INT		(PNX833X_PIC_IRQ_BASE + 24)
+#define PNX833X_PIC_TS_OUT_INT			(PNX833X_PIC_IRQ_BASE + 25)
+#define PNX833X_PIC_IR_INT				(PNX833X_PIC_IRQ_BASE + 26)
+#define PNX833X_PIC_VMSP1_INT			(PNX833X_PIC_IRQ_BASE + 27)
+#define PNX833X_PIC_VMSP2_INT			(PNX833X_PIC_IRQ_BASE + 28)
+#define PNX833X_PIC_PIBC_INT			(PNX833X_PIC_IRQ_BASE + 29)
+#define PNX833X_PIC_TS_IN0_TRD_INT		(PNX833X_PIC_IRQ_BASE + 30)
+#define PNX833X_PIC_SGDX_TPD_INT		(PNX833X_PIC_IRQ_BASE + 31)
+#define PNX833X_PIC_USB_INT				(PNX833X_PIC_IRQ_BASE + 32)
+#define PNX833X_PIC_TS_IN1_TRD_INT		(PNX833X_PIC_IRQ_BASE + 33)
+#define PNX833X_PIC_CLOCK_INT			(PNX833X_PIC_IRQ_BASE + 34)
+#define PNX833X_PIC_SGDX_PARSER_INT		(PNX833X_PIC_IRQ_BASE + 35)
+#define PNX833X_PIC_VMSP_DMA_INT		(PNX833X_PIC_IRQ_BASE + 36)
+
+#if defined(CONFIG_SOC_PNX8335)
+#define PNX8335_PIC_MIU_INT					(PNX833X_PIC_IRQ_BASE + 37)
+#define PNX8335_PIC_AVCHIP_IRQ_INT			(PNX833X_PIC_IRQ_BASE + 38)
+#define PNX8335_PIC_SYNC_HD_INT				(PNX833X_PIC_IRQ_BASE + 39)
+#define PNX8335_PIC_DISP_HD_INT				(PNX833X_PIC_IRQ_BASE + 40)
+#define PNX8335_PIC_DISP_SCALER_INT			(PNX833X_PIC_IRQ_BASE + 41)
+#define PNX8335_PIC_OSD_HD1_INT				(PNX833X_PIC_IRQ_BASE + 42)
+#define PNX8335_PIC_DTL_WRITER_Y_INT		(PNX833X_PIC_IRQ_BASE + 43)
+#define PNX8335_PIC_DTL_WRITER_C_INT		(PNX833X_PIC_IRQ_BASE + 44)
+#define PNX8335_PIC_DTL_EMULATOR_Y_IR_INT	(PNX833X_PIC_IRQ_BASE + 45)
+#define PNX8335_PIC_DTL_EMULATOR_C_IR_INT	(PNX833X_PIC_IRQ_BASE + 46)
+#define PNX8335_PIC_DENC_TTX_INT			(PNX833X_PIC_IRQ_BASE + 47)
+#define PNX8335_PIC_MMI_SIF0_INT			(PNX833X_PIC_IRQ_BASE + 48)
+#define PNX8335_PIC_MMI_SIF1_INT			(PNX833X_PIC_IRQ_BASE + 49)
+#define PNX8335_PIC_MMI_CDMMU_INT			(PNX833X_PIC_IRQ_BASE + 50)
+#define PNX8335_PIC_PIBCS_INT				(PNX833X_PIC_IRQ_BASE + 51)
+#define PNX8335_PIC_ETHERNET_INT			(PNX833X_PIC_IRQ_BASE + 52)
+#define PNX8335_PIC_VMSP1_0_INT				(PNX833X_PIC_IRQ_BASE + 53)
+#define PNX8335_PIC_VMSP1_1_INT				(PNX833X_PIC_IRQ_BASE + 54)
+#define PNX8335_PIC_VMSP1_DMA_INT			(PNX833X_PIC_IRQ_BASE + 55)
+#define PNX8335_PIC_TDGR_DE_INT				(PNX833X_PIC_IRQ_BASE + 56)
+#define PNX8335_PIC_IR1_IRQ_INT				(PNX833X_PIC_IRQ_BASE + 57)
+#endif
+
+/* GPIO interrupts */
+#define PNX833X_GPIO_0_INT			(PNX833X_GPIO_IRQ_BASE +  0)
+#define PNX833X_GPIO_1_INT			(PNX833X_GPIO_IRQ_BASE +  1)
+#define PNX833X_GPIO_2_INT			(PNX833X_GPIO_IRQ_BASE +  2)
+#define PNX833X_GPIO_3_INT			(PNX833X_GPIO_IRQ_BASE +  3)
+#define PNX833X_GPIO_4_INT			(PNX833X_GPIO_IRQ_BASE +  4)
+#define PNX833X_GPIO_5_INT			(PNX833X_GPIO_IRQ_BASE +  5)
+#define PNX833X_GPIO_6_INT			(PNX833X_GPIO_IRQ_BASE +  6)
+#define PNX833X_GPIO_7_INT			(PNX833X_GPIO_IRQ_BASE +  7)
+#define PNX833X_GPIO_8_INT			(PNX833X_GPIO_IRQ_BASE +  8)
+#define PNX833X_GPIO_9_INT			(PNX833X_GPIO_IRQ_BASE +  9)
+#define PNX833X_GPIO_10_INT			(PNX833X_GPIO_IRQ_BASE + 10)
+#define PNX833X_GPIO_11_INT			(PNX833X_GPIO_IRQ_BASE + 11)
+#define PNX833X_GPIO_12_INT			(PNX833X_GPIO_IRQ_BASE + 12)
+#define PNX833X_GPIO_13_INT			(PNX833X_GPIO_IRQ_BASE + 13)
+#define PNX833X_GPIO_14_INT			(PNX833X_GPIO_IRQ_BASE + 14)
+#define PNX833X_GPIO_15_INT			(PNX833X_GPIO_IRQ_BASE + 15)
+
+#endif
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/pnx833x.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/pnx833x.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/pnx833x.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/pnx833x.h	2008-06-06
11:29:43.000000000 +0100
@@ -0,0 +1,202 @@
+/*
+ *  pnx833x.h: Register mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *	  Chris Steel <chris.steel@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
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
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_MIPS_MACH_PNX833X_PNX833X_H
+#define __ASM_MIPS_MACH_PNX833X_PNX833X_H
+
+/* All regs are accessed in KSEG1 */
+#define PNX833X_BASE		(0xa0000000ul + 0x17E00000ul)
+
+#define PNX833X_REG(offs)	*((volatile unsigned long *)(PNX833X_BASE + offs))
+
+/* Registers are named exactly as in PNX833X docs, just with PNX833X_ prefix */
+
+/* Read access to multibit fields */
+#define PNX833X_BIT(val, reg, field)	((val) & PNX833X_##reg##_##field)
+#define PNX833X_REGBIT(reg, field)	PNX833X_BIT(PNX833X_##reg, reg, field)
+
+/* Use PNX833X_FIELD to extract a field from val */
+#define PNX_FIELD(cpu, val, reg, field) \
+		(((val) & PNX##cpu##_##reg##_##field##_MASK) >> \
+			PNX##cpu##_##reg##_##field##_SHIFT)
+#define PNX833X_FIELD(val, reg, field)	PNX_FIELD(833X, val, reg, field)
+#define PNX8330_FIELD(val, reg, field)	PNX_FIELD(8330, val, reg, field)
+#define PNX8335_FIELD(val, reg, field)	PNX_FIELD(8335, val, reg, field)
+
+/* Use PNX833X_REGFIELD to extract a field from a register */
+#define PNX833X_REGFIELD(reg, field)	PNX833X_FIELD(PNX833X_##reg, reg, field)
+#define PNX8330_REGFIELD(reg, field)	PNX8330_FIELD(PNX8330_##reg, reg, field)
+#define PNX8335_REGFIELD(reg, field)	PNX8335_FIELD(PNX8335_##reg, reg, field)
+
+
+#define PNX_WRITEFIELD(cpu, val, reg, field) \
+	PNX##cpu##_##reg = (PNX##cpu##_##reg &
~(PNX##cpu##_##reg##_##field##_MASK)) | \
+						((val) << PNX##cpu##_##reg##_##field##_SHIFT)
+#define PNX833X_WRITEFIELD(val, reg, field) \
+					PNX_WRITEFIELD(833X, val, reg, field)
+#define PNX8330_WRITEFIELD(val, reg, field) \
+					PNX_WRITEFIELD(8330, val, reg, field)
+#define PNX8335_WRITEFIELD(val, reg, field) \
+					PNX_WRITEFIELD(8335, val, reg, field)
+
+
+/* Macros to detect CPU type */
+
+#define PNX833X_CONFIG_MODULE_ID		PNX833X_REG(0x7FFC)
+#define PNX833X_CONFIG_MODULE_ID_MAJREV_MASK	0x0000f000
+#define PNX833X_CONFIG_MODULE_ID_MAJREV_SHIFT	12
+#define PNX8330_CONFIG_MODULE_MAJREV		4
+#define PNX8335_CONFIG_MODULE_MAJREV		5
+#define CPU_IS_PNX8330	(PNX833X_REGFIELD(CONFIG_MODULE_ID, MAJREV) == \
+					PNX8330_CONFIG_MODULE_MAJREV)
+#define CPU_IS_PNX8335	(PNX833X_REGFIELD(CONFIG_MODULE_ID, MAJREV) == \
+					PNX8335_CONFIG_MODULE_MAJREV)
+
+
+
+#define PNX833X_RESET_CONTROL		PNX833X_REG(0x8004)
+#define PNX833X_RESET_CONTROL_2 	PNX833X_REG(0x8014)
+
+#define PNX833X_PIC_REG(offs)		PNX833X_REG(0x01000 + (offs))
+#define PNX833X_PIC_INT_PRIORITY	PNX833X_PIC_REG(0x0)
+#define PNX833X_PIC_INT_SRC		PNX833X_PIC_REG(0x4)
+#define PNX833X_PIC_INT_SRC_INT_SRC_MASK	0x00000FF8ul	/* bits 11:3 */
+#define PNX833X_PIC_INT_SRC_INT_SRC_SHIFT	3
+#define PNX833X_PIC_INT_REG(irq)	PNX833X_PIC_REG(0x10 + 4*(irq))
+
+#define PNX833X_CLOCK_CPUCP_CTL	PNX833X_REG(0x9228)
+#define PNX833X_CLOCK_CPUCP_CTL_EXIT_RESET	0x00000002ul	/* bit 1 */
+#define PNX833X_CLOCK_CPUCP_CTL_DIV_CLOCK_MASK	0x00000018ul	/* bits 4:3 */
+#define PNX833X_CLOCK_CPUCP_CTL_DIV_CLOCK_SHIFT	3
+
+#define PNX8335_CLOCK_PLL_CPU_CTL		PNX833X_REG(0x9020)
+#define PNX8335_CLOCK_PLL_CPU_CTL_FREQ_MASK	0x1f
+#define PNX8335_CLOCK_PLL_CPU_CTL_FREQ_SHIFT	0
+
+#define PNX833X_CONFIG_MUX		PNX833X_REG(0x7004)
+#define PNX833X_CONFIG_MUX_IDE_MUX	0x00000080		/* bit 7 */
+
+#define PNX8330_CONFIG_POLYFUSE_7	PNX833X_REG(0x7040)
+#define PNX8330_CONFIG_POLYFUSE_7_BOOT_MODE_MASK	0x00180000
+#define PNX8330_CONFIG_POLYFUSE_7_BOOT_MODE_SHIFT	19
+
+#define PNX833X_PIO_IN		PNX833X_REG(0xF000)
+#define PNX833X_PIO_OUT		PNX833X_REG(0xF004)
+#define PNX833X_PIO_DIR		PNX833X_REG(0xF008)
+#define PNX833X_PIO_SEL		PNX833X_REG(0xF014)
+#define PNX833X_PIO_INT_EDGE	PNX833X_REG(0xF020)
+#define PNX833X_PIO_INT_HI	PNX833X_REG(0xF024)
+#define PNX833X_PIO_INT_LO	PNX833X_REG(0xF028)
+#define PNX833X_PIO_INT_STATUS	PNX833X_REG(0xFFE0)
+#define PNX833X_PIO_INT_ENABLE	PNX833X_REG(0xFFE4)
+#define PNX833X_PIO_INT_CLEAR	PNX833X_REG(0xFFE8)
+#define PNX833X_PIO_IN2		PNX833X_REG(0xF05C)
+#define PNX833X_PIO_OUT2	PNX833X_REG(0xF060)
+#define PNX833X_PIO_DIR2	PNX833X_REG(0xF064)
+#define PNX833X_PIO_SEL2	PNX833X_REG(0xF068)
+
+#define PNX833X_UART0_PORTS_START	(PNX833X_BASE + 0xB000)
+#define PNX833X_UART0_PORTS_END		(PNX833X_BASE + 0xBFFF)
+#define PNX833X_UART1_PORTS_START	(PNX833X_BASE + 0xC000)
+#define PNX833X_UART1_PORTS_END		(PNX833X_BASE + 0xCFFF)
+
+#define PNX833X_USB_PORTS_START		(PNX833X_BASE + 0x19000)
+#define PNX833X_USB_PORTS_END		(PNX833X_BASE + 0x19FFF)
+
+#define PNX833X_CONFIG_USB		PNX833X_REG(0x7008)
+
+#define PNX833X_I2C0_PORTS_START	(PNX833X_BASE + 0xD000)
+#define PNX833X_I2C0_PORTS_END		(PNX833X_BASE + 0xDFFF)
+#define PNX833X_I2C1_PORTS_START	(PNX833X_BASE + 0xE000)
+#define PNX833X_I2C1_PORTS_END		(PNX833X_BASE + 0xEFFF)
+
+#define PNX833X_IDE_PORTS_START		(PNX833X_BASE + 0x1A000)
+#define PNX833X_IDE_PORTS_END		(PNX833X_BASE + 0x1AFFF)
+#define PNX833X_IDE_MODULE_ID		PNX833X_REG(0x1AFFC)
+
+#define PNX833X_IDE_MODULE_ID_MODULE_ID_MASK	0xFFFF0000
+#define PNX833X_IDE_MODULE_ID_MODULE_ID_SHIFT	16
+#define PNX833X_IDE_MODULE_ID_VALUE		0xA009
+
+
+#define PNX833X_MIU_SEL0			PNX833X_REG(0x2004)
+#define PNX833X_MIU_SEL0_TIMING		PNX833X_REG(0x2008)
+#define PNX833X_MIU_SEL1			PNX833X_REG(0x200C)
+#define PNX833X_MIU_SEL1_TIMING		PNX833X_REG(0x2010)
+#define PNX833X_MIU_SEL2			PNX833X_REG(0x2014)
+#define PNX833X_MIU_SEL2_TIMING		PNX833X_REG(0x2018)
+#define PNX833X_MIU_SEL3			PNX833X_REG(0x201C)
+#define PNX833X_MIU_SEL3_TIMING		PNX833X_REG(0x2020)
+
+#define PNX833X_MIU_SEL0_SPI_MODE_ENABLE_MASK	(1 << 14)
+#define PNX833X_MIU_SEL0_SPI_MODE_ENABLE_SHIFT	14
+
+#define PNX833X_MIU_SEL0_BURST_MODE_ENABLE_MASK	(1 << 7)
+#define PNX833X_MIU_SEL0_BURST_MODE_ENABLE_SHIFT	7
+
+#define PNX833X_MIU_SEL0_BURST_PAGE_LEN_MASK	(0xF << 9)
+#define PNX833X_MIU_SEL0_BURST_PAGE_LEN_SHIFT	9
+
+#define PNX833X_MIU_CONFIG_SPI		PNX833X_REG(0x2000)
+
+#define PNX833X_MIU_CONFIG_SPI_OPCODE_MASK	(0xFF << 3)
+#define PNX833X_MIU_CONFIG_SPI_OPCODE_SHIFT	3
+
+#define PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_MASK	(1 << 2)
+#define PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_SHIFT	2
+
+#define PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_MASK	(1 << 1)
+#define PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_SHIFT	1
+
+#define PNX833X_MIU_CONFIG_SPI_SYNC_MASK	(1 << 0)
+#define PNX833X_MIU_CONFIG_SPI_SYNC_SHIFT	0
+
+#define PNX833X_WRITE_CONFIG_SPI(opcode, data_enable, addr_enable, sync) \
+   PNX833X_MIU_CONFIG_SPI = \
+   ((opcode) << PNX833X_MIU_CONFIG_SPI_OPCODE_SHIFT) | \
+   ((data_enable) << PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_SHIFT) | \
+   ((addr_enable) << PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_SHIFT) | \
+   ((sync) << PNX833X_MIU_CONFIG_SPI_SYNC_SHIFT)
+
+#define PNX8335_IP3902_PORTS_START		(PNX833X_BASE + 0x2F000)
+#define PNX8335_IP3902_PORTS_END		(PNX833X_BASE + 0x2FFFF)
+#define PNX8335_IP3902_MODULE_ID		PNX833X_REG(0x2FFFC)
+
+#define PNX8335_IP3902_MODULE_ID_MODULE_ID_MASK		0xFFFF0000
+#define PNX8335_IP3902_MODULE_ID_MODULE_ID_SHIFT	16
+#define PNX8335_IP3902_MODULE_ID_VALUE			0x3902
+
+ /* I/O location(gets remapped)*/
+#define PNX8335_NAND_BASE	    0x18000000
+/* I/O location with CLE high */
+#define PNX8335_NAND_CLE_MASK	0x00100000
+/* I/O location with ALE high */
+#define PNX8335_NAND_ALE_MASK	0x00010000
+
+#define PNX8335_SATA_PORTS_START	(PNX833X_BASE + 0x2E000)
+#define PNX8335_SATA_PORTS_END		(PNX833X_BASE + 0x2EFFF)
+#define PNX8335_SATA_MODULE_ID		PNX833X_REG(0x2EFFC)
+
+#define PNX8335_SATA_MODULE_ID_MODULE_ID_MASK	0xFFFF0000
+#define PNX8335_SATA_MODULE_ID_MODULE_ID_SHIFT	16
+#define PNX8335_SATA_MODULE_ID_VALUE		0xA099
+
+#endif
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/war.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/war.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/war.h	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/war.h	2008-06-05
09:34:22.000000000 +0100
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_PNX833X_WAR_H
+#define __ASM_MIPS_MACH_PNX833X_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_PNX8550_WAR_H */

------=_Part_40178_9324120.1213273787394
Content-Type: application/octet-stream;
 name=nxp_pnx833x_stb225_support_update.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhdbuszj0
Content-Disposition: attachment;
 filename=nxp_pnx833x_stb225_support_update.patch

VGhlIGZvbGxvd2luZyBwYXRjaCBhZGQgc3VwcG9ydCBmb3IgdGhlIE5YUCBQTlg4MzN4IFNPQy4g
IE1vcmUKc3BlY2lmaWNhbGx5IGl0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFNUQjIyMi81IHZhcmlh
bnQuCgogYXJjaC9taXBzL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMzMg
CiBhcmNoL21pcHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgOCAKIGFy
Y2gvbWlwcy9jb25maWdzL3BueDgzMzUtc3RiMjI1X2RlZmNvbmZpZyAgfCAxMTUwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGFyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vTWFrZWZp
bGUgICAgICAgfCAgICAxIAogYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5j
ICAgICB8ICAxMzQgKysrCiBhcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL2ludGVycnVwdHMu
YyAgIHwgIDM2NSArKysrKysrKwogYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9wbGF0Zm9y
bS5jICAgICB8ICAzMDYgKysrKysrKwogYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9wcm9t
LmMgICAgICAgICB8ICAgNzAgKwogYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9yZXNldC5j
ICAgICAgICB8ICAgNDUgKwogYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9zZXR1cC5jICAg
ICAgICB8ICAgNjQgKwogYXJjaC9taXBzL254cC9wbng4MzN4L3N0YjIyeC9NYWtlZmlsZSAgICAg
ICB8ICAgIDEgCiBhcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4L2JvYXJkLmMgICAgICAgIHwg
IDEzMyArKysKIGluY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2dwaW8uaCAgICAgICAgfCAg
MTcyICsrKysKIGluY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2lycS1tYXBwaW5nLmggfCAg
MTI2ICsrKwogaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvaXJxLmggICAgICAgICB8ICAg
NTMgKwogaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvcG54ODMzeC5oICAgICB8ICAyMDIg
KysrKwogaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvd2FyLmggICAgICAgICB8ICAgMjUg
CiAxNyBmaWxlcyBjaGFuZ2VkLCAyODg4IGluc2VydGlvbnMoKykKClNpZ25lZC1vZmYtYnk6IGRh
bmllbC5qLmxhaXJkIDxkYW5pZWwuai5sYWlyZEBueHAuY29tPgoKZGlmZiAtdXJOIC0tZXhjbHVk
ZT0uc3ZuIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvY29uZmlncy9wbng4MzM1LXN0
YjIyNV9kZWZjb25maWcgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvY29uZmlncy9wbng4MzM1
LXN0YjIyNV9kZWZjb25maWcKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvY29u
Zmlncy9wbng4MzM1LXN0YjIyNV9kZWZjb25maWcJMTk3MC0wMS0wMSAwMTowMDowMC4wMDAwMDAw
MDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL2NvbmZpZ3MvcG54ODMzNS1z
dGIyMjVfZGVmY29uZmlnCTIwMDgtMDYtMDQgMTU6NTg6MDMuMDAwMDAwMDAwICswMTAwCkBAIC0w
LDAgKzEsMTE1MCBAQAorIworIyBBdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBtYWtlIGNvbmZpZzog
ZG9uJ3QgZWRpdAorIyBMaW51eCBrZXJuZWwgdmVyc2lvbjogMi42LjI2LXJjNAorIyBXZWQgSnVu
ICA0IDE1OjU3OjE3IDIwMDgKKyMKK0NPTkZJR19NSVBTPXkKKworIworIyBNYWNoaW5lIHNlbGVj
dGlvbgorIworIyBDT05GSUdfTUFDSF9BTENIRU1ZIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JBU0xF
Ul9FWENJVEUgaXMgbm90IHNldAorIyBDT05GSUdfQkNNNDdYWCBpcyBub3Qgc2V0CisjIENPTkZJ
R19NSVBTX0NPQkFMVCBpcyBub3Qgc2V0CisjIENPTkZJR19NQUNIX0RFQ1NUQVRJT04gaXMgbm90
IHNldAorIyBDT05GSUdfTUFDSF9KQVpaIGlzIG5vdCBzZXQKKyMgQ09ORklHX0xBU0FUIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0xFTU9URV9GVUxPTkcgaXMgbm90IHNldAorIyBDT05GSUdfTUlQU19B
VExBUyBpcyBub3Qgc2V0CisjIENPTkZJR19NSVBTX01BTFRBIGlzIG5vdCBzZXQKKyMgQ09ORklH
X01JUFNfU0VBRCBpcyBub3Qgc2V0CisjIENPTkZJR19NSVBTX1NJTSBpcyBub3Qgc2V0CisjIENP
TkZJR19NQVJLRUlOUyBpcyBub3Qgc2V0CisjIENPTkZJR19NQUNIX1ZSNDFYWCBpcyBub3Qgc2V0
CisjIENPTkZJR19OWFBfU1RCMjIwIGlzIG5vdCBzZXQKK0NPTkZJR19OWFBfU1RCMjI1PXkKKyMg
Q09ORklHX1BOWDg1NTBfSkJTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1BOWDg1NTBfU1RCODEwIGlz
IG5vdCBzZXQKKyMgQ09ORklHX1BNQ19NU1AgaXMgbm90IHNldAorIyBDT05GSUdfUE1DX1lPU0VN
SVRFIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NHSV9JUDIyIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NH
SV9JUDI3IGlzIG5vdCBzZXQKKyMgQ09ORklHX1NHSV9JUDI4IGlzIG5vdCBzZXQKKyMgQ09ORklH
X1NHSV9JUDMyIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NJQllURV9DUkhJTkUgaXMgbm90IHNldAor
IyBDT05GSUdfU0lCWVRFX0NBUk1FTCBpcyBub3Qgc2V0CisjIENPTkZJR19TSUJZVEVfQ1JIT05F
IGlzIG5vdCBzZXQKKyMgQ09ORklHX1NJQllURV9SSE9ORSBpcyBub3Qgc2V0CisjIENPTkZJR19T
SUJZVEVfU1dBUk0gaXMgbm90IHNldAorIyBDT05GSUdfU0lCWVRFX0xJVFRMRVNVUiBpcyBub3Qg
c2V0CisjIENPTkZJR19TSUJZVEVfU0VOVE9TQSBpcyBub3Qgc2V0CisjIENPTkZJR19TSUJZVEVf
QklHU1VSIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NOSV9STSBpcyBub3Qgc2V0CisjIENPTkZJR19U
T1NISUJBX0pNUjM5MjcgaXMgbm90IHNldAorIyBDT05GSUdfVE9TSElCQV9SQlRYNDkyNyBpcyBu
b3Qgc2V0CisjIENPTkZJR19UT1NISUJBX1JCVFg0OTM4IGlzIG5vdCBzZXQKKyMgQ09ORklHX1dS
X1BQTUMgaXMgbm90IHNldAorQ09ORklHX1JXU0VNX0dFTkVSSUNfU1BJTkxPQ0s9eQorIyBDT05G
SUdfQVJDSF9IQVNfSUxPRzJfVTMyIGlzIG5vdCBzZXQKKyMgQ09ORklHX0FSQ0hfSEFTX0lMT0cy
X1U2NCBpcyBub3Qgc2V0CitDT05GSUdfQVJDSF9TVVBQT1JUU19PUFJPRklMRT15CitDT05GSUdf
R0VORVJJQ19GSU5EX05FWFRfQklUPXkKK0NPTkZJR19HRU5FUklDX0hXRUlHSFQ9eQorQ09ORklH
X0dFTkVSSUNfQ0FMSUJSQVRFX0RFTEFZPXkKK0NPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTPXkK
K0NPTkZJR19HRU5FUklDX1RJTUU9eQorQ09ORklHX0dFTkVSSUNfQ01PU19VUERBVEU9eQorQ09O
RklHX1NDSEVEX05PX05PX09NSVRfRlJBTUVfUE9JTlRFUj15CitDT05GSUdfR0VORVJJQ19IQVJE
SVJRU19OT19fRE9fSVJRPXkKK0NPTkZJR19DRVZUX1I0Sz15CitDT05GSUdfQ1NSQ19SNEs9eQor
Q09ORklHX0RNQV9OT05DT0hFUkVOVD15CitDT05GSUdfRE1BX05FRURfUENJX01BUF9TVEFURT15
CitDT05GSUdfRUFSTFlfUFJJTlRLPXkKK0NPTkZJR19TWVNfSEFTX0VBUkxZX1BSSU5USz15Cisj
IENPTkZJR19IT1RQTFVHX0NQVSBpcyBub3Qgc2V0CisjIENPTkZJR19OT19JT1BPUlQgaXMgbm90
IHNldAorQ09ORklHX0dFTkVSSUNfR1BJTz15CisjIENPTkZJR19DUFVfQklHX0VORElBTiBpcyBu
b3Qgc2V0CitDT05GSUdfQ1BVX0xJVFRMRV9FTkRJQU49eQorQ09ORklHX1NZU19TVVBQT1JUU19C
SUdfRU5ESUFOPXkKK0NPTkZJR19TWVNfU1VQUE9SVFNfTElUVExFX0VORElBTj15CitDT05GSUdf
SVJRX0NQVT15CitDT05GSUdfU09DX1BOWDgzM1g9eQorQ09ORklHX1NPQ19QTlg4MzM1PXkKK0NP
TkZJR19NSVBTX0wxX0NBQ0hFX1NISUZUPTUKKworIworIyBDUFUgc2VsZWN0aW9uCisjCisjIENP
TkZJR19DUFVfTE9PTkdTT04yIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NQVV9NSVBTMzJfUjEgaXMg
bm90IHNldAorQ09ORklHX0NQVV9NSVBTMzJfUjI9eQorIyBDT05GSUdfQ1BVX01JUFM2NF9SMSBp
cyBub3Qgc2V0CisjIENPTkZJR19DUFVfTUlQUzY0X1IyIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NQ
VV9SMzAwMCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfVFgzOVhYIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0NQVV9WUjQxWFggaXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1I0MzAwIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0NQVV9SNFgwMCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfVFg0OVhYIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0NQVV9SNTAwMCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfUjU0MzIg
aXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1I2MDAwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NQVV9O
RVZBREEgaXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1I4MDAwIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0NQVV9SMTAwMDAgaXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1JNNzAwMCBpcyBub3Qgc2V0Cisj
IENPTkZJR19DUFVfUk05MDAwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NQVV9TQjEgaXMgbm90IHNl
dAorQ09ORklHX1NZU19IQVNfQ1BVX01JUFMzMl9SMj15CitDT05GSUdfQ1BVX01JUFMzMj15CitD
T05GSUdfQ1BVX01JUFNSMj15CitDT05GSUdfU1lTX1NVUFBPUlRTXzMyQklUX0tFUk5FTD15CitD
T05GSUdfQ1BVX1NVUFBPUlRTXzMyQklUX0tFUk5FTD15CisKKyMKKyMgS2VybmVsIHR5cGUKKyMK
K0NPTkZJR18zMkJJVD15CisjIENPTkZJR182NEJJVCBpcyBub3Qgc2V0CitDT05GSUdfUEFHRV9T
SVpFXzRLQj15CisjIENPTkZJR19QQUdFX1NJWkVfOEtCIGlzIG5vdCBzZXQKKyMgQ09ORklHX1BB
R0VfU0laRV8xNktCIGlzIG5vdCBzZXQKKyMgQ09ORklHX1BBR0VfU0laRV82NEtCIGlzIG5vdCBz
ZXQKK0NPTkZJR19DUFVfSEFTX1BSRUZFVENIPXkKK0NPTkZJR19NSVBTX01UX0RJU0FCTEVEPXkK
KyMgQ09ORklHX01JUFNfTVRfU01QIGlzIG5vdCBzZXQKKyMgQ09ORklHX01JUFNfTVRfU01UQyBp
cyBub3Qgc2V0CitDT05GSUdfQ1BVX0hBU19MTFNDPXkKK0NPTkZJR19DUFVfTUlQU1IyX0lSUV9W
ST15CitDT05GSUdfQ1BVX0hBU19TWU5DPXkKK0NPTkZJR19HRU5FUklDX0hBUkRJUlFTPXkKK0NP
TkZJR19HRU5FUklDX0lSUV9QUk9CRT15CitDT05GSUdfQ1BVX1NVUFBPUlRTX0hJR0hNRU09eQor
Q09ORklHX0FSQ0hfRkxBVE1FTV9FTkFCTEU9eQorQ09ORklHX0FSQ0hfUE9QVUxBVEVTX05PREVf
TUFQPXkKK0NPTkZJR19TRUxFQ1RfTUVNT1JZX01PREVMPXkKK0NPTkZJR19GTEFUTUVNX01BTlVB
TD15CisjIENPTkZJR19ESVNDT05USUdNRU1fTUFOVUFMIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NQ
QVJTRU1FTV9NQU5VQUwgaXMgbm90IHNldAorQ09ORklHX0ZMQVRNRU09eQorQ09ORklHX0ZMQVRf
Tk9ERV9NRU1fTUFQPXkKKyMgQ09ORklHX1NQQVJTRU1FTV9TVEFUSUMgaXMgbm90IHNldAorIyBD
T05GSUdfU1BBUlNFTUVNX1ZNRU1NQVBfRU5BQkxFIGlzIG5vdCBzZXQKK0NPTkZJR19QQUdFRkxB
R1NfRVhURU5ERUQ9eQorQ09ORklHX1NQTElUX1BUTE9DS19DUFVTPTQKKyMgQ09ORklHX1JFU09V
UkNFU182NEJJVCBpcyBub3Qgc2V0CitDT05GSUdfWk9ORV9ETUFfRkxBRz0wCitDT05GSUdfVklS
VF9UT19CVVM9eQorQ09ORklHX1RJQ0tfT05FU0hPVD15CitDT05GSUdfTk9fSFo9eQorQ09ORklH
X0hJR0hfUkVTX1RJTUVSUz15CitDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UU19CVUlMRD15Cisj
IENPTkZJR19IWl80OCBpcyBub3Qgc2V0CisjIENPTkZJR19IWl8xMDAgaXMgbm90IHNldAorQ09O
RklHX0haXzEyOD15CisjIENPTkZJR19IWl8yNTAgaXMgbm90IHNldAorIyBDT05GSUdfSFpfMjU2
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0haXzEwMDAgaXMgbm90IHNldAorIyBDT05GSUdfSFpfMTAy
NCBpcyBub3Qgc2V0CitDT05GSUdfU1lTX1NVUFBPUlRTX0FSQklUX0haPXkKK0NPTkZJR19IWj0x
MjgKKyMgQ09ORklHX1BSRUVNUFRfTk9ORSBpcyBub3Qgc2V0CitDT05GSUdfUFJFRU1QVF9WT0xV
TlRBUlk9eQorIyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0CisjIENPTkZJR19LRVhFQyBpcyBu
b3Qgc2V0CisjIENPTkZJR19TRUNDT01QIGlzIG5vdCBzZXQKK0NPTkZJR19MT0NLREVQX1NVUFBP
UlQ9eQorQ09ORklHX1NUQUNLVFJBQ0VfU1VQUE9SVD15CitDT05GSUdfREVGQ09ORklHX0xJU1Q9
Ii9saWIvbW9kdWxlcy8kVU5BTUVfUkVMRUFTRS8uY29uZmlnIgorCisjCisjIEdlbmVyYWwgc2V0
dXAKKyMKK0NPTkZJR19FWFBFUklNRU5UQUw9eQorQ09ORklHX0JST0tFTl9PTl9TTVA9eQorQ09O
RklHX0lOSVRfRU5WX0FSR19MSU1JVD0zMgorQ09ORklHX0xPQ0FMVkVSU0lPTj0iIgorIyBDT05G
SUdfTE9DQUxWRVJTSU9OX0FVVE8gaXMgbm90IHNldAorIyBDT05GSUdfU1dBUCBpcyBub3Qgc2V0
CitDT05GSUdfU1lTVklQQz15CitDT05GSUdfU1lTVklQQ19TWVNDVEw9eQorIyBDT05GSUdfUE9T
SVhfTVFVRVVFIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1QgaXMgbm90IHNl
dAorIyBDT05GSUdfVEFTS1NUQVRTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0FVRElUIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX0lLQ09ORklHIGlzIG5vdCBzZXQKK0NPTkZJR19MT0dfQlVGX1NISUZUPTE0
CisjIENPTkZJR19DR1JPVVBTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0dST1VQX1NDSEVEIGlzIG5v
dCBzZXQKK0NPTkZJR19TWVNGU19ERVBSRUNBVEVEPXkKK0NPTkZJR19TWVNGU19ERVBSRUNBVEVE
X1YyPXkKKyMgQ09ORklHX1JFTEFZIGlzIG5vdCBzZXQKKyMgQ09ORklHX05BTUVTUEFDRVMgaXMg
bm90IHNldAorIyBDT05GSUdfQkxLX0RFVl9JTklUUkQgaXMgbm90IHNldAorQ09ORklHX0NDX09Q
VElNSVpFX0ZPUl9TSVpFPXkKK0NPTkZJR19TWVNDVEw9eQorQ09ORklHX0VNQkVEREVEPXkKK0NP
TkZJR19TWVNDVExfU1lTQ0FMTD15CitDT05GSUdfU1lTQ1RMX1NZU0NBTExfQ0hFQ0s9eQorQ09O
RklHX0tBTExTWU1TPXkKKyMgQ09ORklHX0tBTExTWU1TX0VYVFJBX1BBU1MgaXMgbm90IHNldAor
Q09ORklHX0hPVFBMVUc9eQorQ09ORklHX1BSSU5USz15CitDT05GSUdfQlVHPXkKK0NPTkZJR19F
TEZfQ09SRT15CitDT05GSUdfUENTUEtSX1BMQVRGT1JNPXkKK0NPTkZJR19DT01QQVRfQlJLPXkK
K0NPTkZJR19CQVNFX0ZVTEw9eQorQ09ORklHX0ZVVEVYPXkKK0NPTkZJR19BTk9OX0lOT0RFUz15
CitDT05GSUdfRVBPTEw9eQorQ09ORklHX1NJR05BTEZEPXkKK0NPTkZJR19USU1FUkZEPXkKK0NP
TkZJR19FVkVOVEZEPXkKK0NPTkZJR19TSE1FTT15CitDT05GSUdfVk1fRVZFTlRfQ09VTlRFUlM9
eQorQ09ORklHX1NMQUI9eQorIyBDT05GSUdfU0xVQiBpcyBub3Qgc2V0CisjIENPTkZJR19TTE9C
IGlzIG5vdCBzZXQKKyMgQ09ORklHX1BST0ZJTElORyBpcyBub3Qgc2V0CisjIENPTkZJR19NQVJL
RVJTIGlzIG5vdCBzZXQKK0NPTkZJR19IQVZFX09QUk9GSUxFPXkKKyMgQ09ORklHX0hBVkVfS1BS
T0JFUyBpcyBub3Qgc2V0CisjIENPTkZJR19IQVZFX0tSRVRQUk9CRVMgaXMgbm90IHNldAorIyBD
T05GSUdfSEFWRV9ETUFfQVRUUlMgaXMgbm90IHNldAorQ09ORklHX1BST0NfUEFHRV9NT05JVE9S
PXkKK0NPTkZJR19TTEFCSU5GTz15CitDT05GSUdfUlRfTVVURVhFUz15CisjIENPTkZJR19USU5Z
X1NITUVNIGlzIG5vdCBzZXQKK0NPTkZJR19CQVNFX1NNQUxMPTAKK0NPTkZJR19NT0RVTEVTPXkK
KyMgQ09ORklHX01PRFVMRV9GT1JDRV9MT0FEIGlzIG5vdCBzZXQKK0NPTkZJR19NT0RVTEVfVU5M
T0FEPXkKKyMgQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQgaXMgbm90IHNldAorIyBDT05GSUdf
TU9EVkVSU0lPTlMgaXMgbm90IHNldAorIyBDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJT05fQUxMIGlz
IG5vdCBzZXQKK0NPTkZJR19LTU9EPXkKK0NPTkZJR19CTE9DSz15CisjIENPTkZJR19MQkQgaXMg
bm90IHNldAorIyBDT05GSUdfQkxLX0RFVl9JT19UUkFDRSBpcyBub3Qgc2V0CisjIENPTkZJR19M
U0YgaXMgbm90IHNldAorIyBDT05GSUdfQkxLX0RFVl9CU0cgaXMgbm90IHNldAorCisjCisjIElP
IFNjaGVkdWxlcnMKKyMKK0NPTkZJR19JT1NDSEVEX05PT1A9eQorIyBDT05GSUdfSU9TQ0hFRF9B
UyBpcyBub3Qgc2V0CisjIENPTkZJR19JT1NDSEVEX0RFQURMSU5FIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0lPU0NIRURfQ0ZRIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RFRkFVTFRfQVMgaXMgbm90IHNl
dAorIyBDT05GSUdfREVGQVVMVF9ERUFETElORSBpcyBub3Qgc2V0CisjIENPTkZJR19ERUZBVUxU
X0NGUSBpcyBub3Qgc2V0CitDT05GSUdfREVGQVVMVF9OT09QPXkKK0NPTkZJR19ERUZBVUxUX0lP
U0NIRUQ9Im5vb3AiCitDT05GSUdfQ0xBU1NJQ19SQ1U9eQorCisjCisjIEJ1cyBvcHRpb25zIChQ
Q0ksIFBDTUNJQSwgRUlTQSwgSVNBLCBUQykKKyMKKyMgQ09ORklHX0FSQ0hfU1VQUE9SVFNfTVNJ
IGlzIG5vdCBzZXQKK0NPTkZJR19NTVU9eQorIyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKKwor
IworIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cworIworQ09ORklHX0JJTkZNVF9FTEY9eQorIyBD
T05GSUdfQklORk1UX01JU0MgaXMgbm90IHNldAorQ09ORklHX1RSQURfU0lHTkFMUz15CisKKyMK
KyMgUG93ZXIgbWFuYWdlbWVudCBvcHRpb25zCisjCitDT05GSUdfQVJDSF9TVVNQRU5EX1BPU1NJ
QkxFPXkKK0NPTkZJR19QTT15CisjIENPTkZJR19QTV9ERUJVRyBpcyBub3Qgc2V0CitDT05GSUdf
UE1fU0xFRVA9eQorQ09ORklHX1NVU1BFTkQ9eQorQ09ORklHX1NVU1BFTkRfRlJFRVpFUj15CisK
KyMKKyMgTmV0d29ya2luZworIworQ09ORklHX05FVD15CisKKyMKKyMgTmV0d29ya2luZyBvcHRp
b25zCisjCitDT05GSUdfUEFDS0VUPXkKKyMgQ09ORklHX1BBQ0tFVF9NTUFQIGlzIG5vdCBzZXQK
K0NPTkZJR19VTklYPXkKK0NPTkZJR19YRlJNPXkKKyMgQ09ORklHX1hGUk1fVVNFUiBpcyBub3Qg
c2V0CisjIENPTkZJR19YRlJNX1NVQl9QT0xJQ1kgaXMgbm90IHNldAorIyBDT05GSUdfWEZSTV9N
SUdSQVRFIGlzIG5vdCBzZXQKKyMgQ09ORklHX1hGUk1fU1RBVElTVElDUyBpcyBub3Qgc2V0Cisj
IENPTkZJR19ORVRfS0VZIGlzIG5vdCBzZXQKK0NPTkZJR19JTkVUPXkKK0NPTkZJR19JUF9NVUxU
SUNBU1Q9eQorIyBDT05GSUdfSVBfQURWQU5DRURfUk9VVEVSIGlzIG5vdCBzZXQKK0NPTkZJR19J
UF9GSUJfSEFTSD15CitDT05GSUdfSVBfUE5QPXkKK0NPTkZJR19JUF9QTlBfREhDUD15CisjIENP
TkZJR19JUF9QTlBfQk9PVFAgaXMgbm90IHNldAorIyBDT05GSUdfSVBfUE5QX1JBUlAgaXMgbm90
IHNldAorIyBDT05GSUdfTkVUX0lQSVAgaXMgbm90IHNldAorIyBDT05GSUdfTkVUX0lQR1JFIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0lQX01ST1VURSBpcyBub3Qgc2V0CisjIENPTkZJR19BUlBEIGlz
IG5vdCBzZXQKKyMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKK0NPTkZJR19JTkVUX0FI
PXkKKyMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lORVRfSVBDT01QIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0lORVRfWEZSTV9UVU5ORUwgaXMgbm90IHNldAorIyBDT05GSUdf
SU5FVF9UVU5ORUwgaXMgbm90IHNldAorQ09ORklHX0lORVRfWEZSTV9NT0RFX1RSQU5TUE9SVD15
CitDT05GSUdfSU5FVF9YRlJNX01PREVfVFVOTkVMPXkKK0NPTkZJR19JTkVUX1hGUk1fTU9ERV9C
RUVUPXkKKyMgQ09ORklHX0lORVRfTFJPIGlzIG5vdCBzZXQKK0NPTkZJR19JTkVUX0RJQUc9eQor
Q09ORklHX0lORVRfVENQX0RJQUc9eQorIyBDT05GSUdfVENQX0NPTkdfQURWQU5DRUQgaXMgbm90
IHNldAorQ09ORklHX1RDUF9DT05HX0NVQklDPXkKK0NPTkZJR19ERUZBVUxUX1RDUF9DT05HPSJj
dWJpYyIKKyMgQ09ORklHX1RDUF9NRDVTSUcgaXMgbm90IHNldAorIyBDT05GSUdfSVBWNiBpcyBu
b3Qgc2V0CisjIENPTkZJR19ORVRXT1JLX1NFQ01BUksgaXMgbm90IHNldAorIyBDT05GSUdfTkVU
RklMVEVSIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lQX0RDQ1AgaXMgbm90IHNldAorIyBDT05GSUdf
SVBfU0NUUCBpcyBub3Qgc2V0CisjIENPTkZJR19USVBDIGlzIG5vdCBzZXQKKyMgQ09ORklHX0FU
TSBpcyBub3Qgc2V0CisjIENPTkZJR19CUklER0UgaXMgbm90IHNldAorIyBDT05GSUdfVkxBTl84
MDIxUSBpcyBub3Qgc2V0CisjIENPTkZJR19ERUNORVQgaXMgbm90IHNldAorIyBDT05GSUdfTExD
MiBpcyBub3Qgc2V0CisjIENPTkZJR19JUFggaXMgbm90IHNldAorIyBDT05GSUdfQVRBTEsgaXMg
bm90IHNldAorIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKKyMgQ09ORklHX0xBUEIgaXMgbm90IHNl
dAorIyBDT05GSUdfRUNPTkVUIGlzIG5vdCBzZXQKKyMgQ09ORklHX1dBTl9ST1VURVIgaXMgbm90
IHNldAorIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKKworIworIyBOZXR3b3JrIHRlc3Rp
bmcKKyMKKyMgQ09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAorIyBDT05GSUdfSEFNUkFESU8g
aXMgbm90IHNldAorIyBDT05GSUdfQ0FOIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lSREEgaXMgbm90
IHNldAorIyBDT05GSUdfQlQgaXMgbm90IHNldAorIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNl
dAorCisjCisjIFdpcmVsZXNzCisjCisjIENPTkZJR19DRkc4MDIxMSBpcyBub3Qgc2V0CisjIENP
TkZJR19XSVJFTEVTU19FWFQgaXMgbm90IHNldAorIyBDT05GSUdfTUFDODAyMTEgaXMgbm90IHNl
dAorIyBDT05GSUdfSUVFRTgwMjExIGlzIG5vdCBzZXQKKyMgQ09ORklHX1JGS0lMTCBpcyBub3Qg
c2V0CisjIENPTkZJR19ORVRfOVAgaXMgbm90IHNldAorCisjCisjIERldmljZSBEcml2ZXJzCisj
CisKKyMKKyMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucworIworQ09ORklHX1VFVkVOVF9IRUxQRVJf
UEFUSD0iL3NiaW4vaG90cGx1ZyIKK0NPTkZJR19TVEFOREFMT05FPXkKK0NPTkZJR19QUkVWRU5U
X0ZJUk1XQVJFX0JVSUxEPXkKK0NPTkZJR19GV19MT0FERVI9eQorIyBDT05GSUdfU1lTX0hZUEVS
VklTT1IgaXMgbm90IHNldAorIyBDT05GSUdfQ09OTkVDVE9SIGlzIG5vdCBzZXQKK0NPTkZJR19N
VEQ9eQorIyBDT05GSUdfTVREX0RFQlVHIGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9DT05DQVQg
aXMgbm90IHNldAorQ09ORklHX01URF9QQVJUSVRJT05TPXkKKyMgQ09ORklHX01URF9SRURCT09U
X1BBUlRTIGlzIG5vdCBzZXQKK0NPTkZJR19NVERfQ01ETElORV9QQVJUUz15CisjIENPTkZJR19N
VERfQVI3X1BBUlRTIGlzIG5vdCBzZXQKKworIworIyBVc2VyIE1vZHVsZXMgQW5kIFRyYW5zbGF0
aW9uIExheWVycworIworQ09ORklHX01URF9DSEFSPXkKK0NPTkZJR19NVERfQkxLREVWUz15CitD
T05GSUdfTVREX0JMT0NLPXkKKyMgQ09ORklHX0ZUTCBpcyBub3Qgc2V0CisjIENPTkZJR19ORlRM
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0lORlRMIGlzIG5vdCBzZXQKKyMgQ09ORklHX1JGRF9GVEwg
aXMgbm90IHNldAorIyBDT05GSUdfU1NGREMgaXMgbm90IHNldAorIyBDT05GSUdfTVREX09PUFMg
aXMgbm90IHNldAorCisjCisjIFJBTS9ST00vRmxhc2ggY2hpcCBkcml2ZXJzCisjCitDT05GSUdf
TVREX0NGST15CisjIENPTkZJR19NVERfSkVERUNQUk9CRSBpcyBub3Qgc2V0CitDT05GSUdfTVRE
X0dFTl9QUk9CRT15CitDT05GSUdfTVREX0NGSV9BRFZfT1BUSU9OUz15CisjIENPTkZJR19NVERf
Q0ZJX05PU1dBUCBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfQ0ZJX0JFX0JZVEVfU1dBUCBpcyBu
b3Qgc2V0CitDT05GSUdfTVREX0NGSV9MRV9CWVRFX1NXQVA9eQorQ09ORklHX01URF9DRklfR0VP
TUVUUlk9eQorQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8xPXkKK0NPTkZJR19NVERfTUFQX0JB
TktfV0lEVEhfMj15CitDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzQ9eQorIyBDT05GSUdfTVRE
X01BUF9CQU5LX1dJRFRIXzggaXMgbm90IHNldAorIyBDT05GSUdfTVREX01BUF9CQU5LX1dJRFRI
XzE2IGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8zMiBpcyBub3Qgc2V0
CitDT05GSUdfTVREX0NGSV9JMT15CitDT05GSUdfTVREX0NGSV9JMj15CisjIENPTkZJR19NVERf
Q0ZJX0k0IGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9DRklfSTggaXMgbm90IHNldAorIyBDT05G
SUdfTVREX09UUCBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfQ0ZJX0lOVEVMRVhUIGlzIG5vdCBz
ZXQKK0NPTkZJR19NVERfQ0ZJX0FNRFNURD15CisjIENPTkZJR19NVERfQ0ZJX1NUQUEgaXMgbm90
IHNldAorQ09ORklHX01URF9DRklfVVRJTD15CisjIENPTkZJR19NVERfUkFNIGlzIG5vdCBzZXQK
KyMgQ09ORklHX01URF9ST00gaXMgbm90IHNldAorIyBDT05GSUdfTVREX0FCU0VOVCBpcyBub3Qg
c2V0CisKKyMKKyMgTWFwcGluZyBkcml2ZXJzIGZvciBjaGlwIGFjY2VzcworIworIyBDT05GSUdf
TVREX0NPTVBMRVhfTUFQUElOR1MgaXMgbm90IHNldAorQ09ORklHX01URF9QSFlTTUFQPXkKK0NP
TkZJR19NVERfUEhZU01BUF9TVEFSVD0weDE4MDAwMDAwCitDT05GSUdfTVREX1BIWVNNQVBfTEVO
PTB4MDQwMDAwMDAKK0NPTkZJR19NVERfUEhZU01BUF9CQU5LV0lEVEg9MgorIyBDT05GSUdfTVRE
X1BMQVRSQU0gaXMgbm90IHNldAorCisjCisjIFNlbGYtY29udGFpbmVkIE1URCBkZXZpY2UgZHJp
dmVycworIworIyBDT05GSUdfTVREX1NMUkFNIGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9QSFJB
TSBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfTVREUkFNIGlzIG5vdCBzZXQKKyMgQ09ORklHX01U
RF9CTE9DSzJNVEQgaXMgbm90IHNldAorCisjCisjIERpc2stT24tQ2hpcCBEZXZpY2UgRHJpdmVy
cworIworIyBDT05GSUdfTVREX0RPQzIwMDAgaXMgbm90IHNldAorIyBDT05GSUdfTVREX0RPQzIw
MDEgaXMgbm90IHNldAorIyBDT05GSUdfTVREX0RPQzIwMDFQTFVTIGlzIG5vdCBzZXQKKyMgQ09O
RklHX01URF9OQU5EIGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9PTkVOQU5EIGlzIG5vdCBzZXQK
KworIworIyBVQkkgLSBVbnNvcnRlZCBibG9jayBpbWFnZXMKKyMKKyMgQ09ORklHX01URF9VQkkg
aXMgbm90IHNldAorIyBDT05GSUdfUEFSUE9SVCBpcyBub3Qgc2V0CitDT05GSUdfQkxLX0RFVj15
CisjIENPTkZJR19CTEtfREVWX0NPV19DT01NT04gaXMgbm90IHNldAorQ09ORklHX0JMS19ERVZf
TE9PUD15CisjIENPTkZJR19CTEtfREVWX0NSWVBUT0xPT1AgaXMgbm90IHNldAorIyBDT05GSUdf
QkxLX0RFVl9OQkQgaXMgbm90IHNldAorIyBDT05GSUdfQkxLX0RFVl9SQU0gaXMgbm90IHNldAor
IyBDT05GSUdfQ0RST01fUEtUQ0RWRCBpcyBub3Qgc2V0CisjIENPTkZJR19BVEFfT1ZFUl9FVEgg
aXMgbm90IHNldAorIyBDT05GSUdfTUlTQ19ERVZJQ0VTIGlzIG5vdCBzZXQKK0NPTkZJR19IQVZF
X0lERT15CisjIENPTkZJR19JREUgaXMgbm90IHNldAorCisjCisjIFNDU0kgZGV2aWNlIHN1cHBv
cnQKKyMKKyMgQ09ORklHX1JBSURfQVRUUlMgaXMgbm90IHNldAorQ09ORklHX1NDU0k9eQorQ09O
RklHX1NDU0lfRE1BPXkKKyMgQ09ORklHX1NDU0lfVEdUIGlzIG5vdCBzZXQKKyMgQ09ORklHX1ND
U0lfTkVUTElOSyBpcyBub3Qgc2V0CitDT05GSUdfU0NTSV9QUk9DX0ZTPXkKKworIworIyBTQ1NJ
IHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQorIworQ09ORklHX0JMS19ERVZfU0Q9
eQorIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CisjIENPTkZJR19DSFJfREVWX09TU1Qg
aXMgbm90IHNldAorIyBDT05GSUdfQkxLX0RFVl9TUiBpcyBub3Qgc2V0CisjIENPTkZJR19DSFJf
REVWX1NHIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NIUl9ERVZfU0NIIGlzIG5vdCBzZXQKKworIwor
IyBTb21lIFNDU0kgZGV2aWNlcyAoZS5nLiBDRCBqdWtlYm94KSBzdXBwb3J0IG11bHRpcGxlIExV
TnMKKyMKKyMgQ09ORklHX1NDU0lfTVVMVElfTFVOIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NDU0lf
Q09OU1RBTlRTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0Cisj
IENPTkZJR19TQ1NJX1NDQU5fQVNZTkMgaXMgbm90IHNldAorQ09ORklHX1NDU0lfV0FJVF9TQ0FO
PW0KKworIworIyBTQ1NJIFRyYW5zcG9ydHMKKyMKKyMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlz
IG5vdCBzZXQKKyMgQ09ORklHX1NDU0lfRkNfQVRUUlMgaXMgbm90IHNldAorIyBDT05GSUdfU0NT
SV9JU0NTSV9BVFRSUyBpcyBub3Qgc2V0CisjIENPTkZJR19TQ1NJX1NBU19MSUJTQVMgaXMgbm90
IHNldAorIyBDT05GSUdfU0NTSV9TUlBfQVRUUlMgaXMgbm90IHNldAorIyBDT05GSUdfU0NTSV9M
T1dMRVZFTCBpcyBub3Qgc2V0CitDT05GSUdfQVRBPXkKKyMgQ09ORklHX0FUQV9OT05TVEFOREFS
RCBpcyBub3Qgc2V0CitDT05GSUdfU0FUQV9QTVA9eQorQ09ORklHX0FUQV9TRkY9eQorIyBDT05G
SUdfU0FUQV9NViBpcyBub3Qgc2V0CisjIENPTkZJR19QQVRBX1BMQVRGT1JNIGlzIG5vdCBzZXQK
KyMgQ09ORklHX01EIGlzIG5vdCBzZXQKK0NPTkZJR19ORVRERVZJQ0VTPXkKKyMgQ09ORklHX05F
VERFVklDRVNfTVVMVElRVUVVRSBpcyBub3Qgc2V0CisjIENPTkZJR19EVU1NWSBpcyBub3Qgc2V0
CisjIENPTkZJR19CT05ESU5HIGlzIG5vdCBzZXQKKyMgQ09ORklHX01BQ1ZMQU4gaXMgbm90IHNl
dAorIyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQKKyMgQ09ORklHX1RVTiBpcyBub3Qgc2V0
CisjIENPTkZJR19WRVRIIGlzIG5vdCBzZXQKKyMgQ09ORklHX1BIWUxJQiBpcyBub3Qgc2V0CitD
T05GSUdfTkVUX0VUSEVSTkVUPXkKK0NPTkZJR19NSUk9eQorIyBDT05GSUdfQVg4ODc5NiBpcyBu
b3Qgc2V0CisjIENPTkZJR19ETTkwMDAgaXMgbm90IHNldAorIyBDT05GSUdfSUJNX05FV19FTUFD
X1pNSUkgaXMgbm90IHNldAorIyBDT05GSUdfSUJNX05FV19FTUFDX1JHTUlJIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0lCTV9ORVdfRU1BQ19UQUggaXMgbm90IHNldAorIyBDT05GSUdfSUJNX05FV19F
TUFDX0VNQUM0IGlzIG5vdCBzZXQKKyMgQ09ORklHX0I0NCBpcyBub3Qgc2V0CisjIENPTkZJR19J
UDM5MDIgaXMgbm90IHNldAorIyBDT05GSUdfTkVUREVWXzEwMDAgaXMgbm90IHNldAorIyBDT05G
SUdfTkVUREVWXzEwMDAwIGlzIG5vdCBzZXQKKworIworIyBXaXJlbGVzcyBMQU4KKyMKKyMgQ09O
RklHX1dMQU5fUFJFODAyMTEgaXMgbm90IHNldAorIyBDT05GSUdfV0xBTl84MDIxMSBpcyBub3Qg
c2V0CisjIENPTkZJR19JV0xXSUZJX0xFRFMgaXMgbm90IHNldAorIyBDT05GSUdfV0FOIGlzIG5v
dCBzZXQKKyMgQ09ORklHX1BQUCBpcyBub3Qgc2V0CisjIENPTkZJR19TTElQIGlzIG5vdCBzZXQK
KyMgQ09ORklHX05FVENPTlNPTEUgaXMgbm90IHNldAorIyBDT05GSUdfTkVUUE9MTCBpcyBub3Qg
c2V0CisjIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lT
RE4gaXMgbm90IHNldAorIyBDT05GSUdfUEhPTkUgaXMgbm90IHNldAorCisjCisjIElucHV0IGRl
dmljZSBzdXBwb3J0CisjCitDT05GSUdfSU5QVVQ9eQorIyBDT05GSUdfSU5QVVRfRkZfTUVNTEVT
UyBpcyBub3Qgc2V0CisjIENPTkZJR19JTlBVVF9QT0xMREVWIGlzIG5vdCBzZXQKKworIworIyBV
c2VybGFuZCBpbnRlcmZhY2VzCisjCisjIENPTkZJR19JTlBVVF9NT1VTRURFViBpcyBub3Qgc2V0
CisjIENPTkZJR19JTlBVVF9KT1lERVYgaXMgbm90IHNldAorQ09ORklHX0lOUFVUX0VWREVWPW0K
K0NPTkZJR19JTlBVVF9FVkJVRz1tCisKKyMKKyMgSW5wdXQgRGV2aWNlIERyaXZlcnMKKyMKKyMg
Q09ORklHX0lOUFVUX0tFWUJPQVJEIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lOUFVUX01PVVNFIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0lOUFVUX0pPWVNUSUNLIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lO
UFVUX1RBQkxFVCBpcyBub3Qgc2V0CisjIENPTkZJR19JTlBVVF9UT1VDSFNDUkVFTiBpcyBub3Qg
c2V0CisjIENPTkZJR19JTlBVVF9NSVNDIGlzIG5vdCBzZXQKKworIworIyBIYXJkd2FyZSBJL08g
cG9ydHMKKyMKK0NPTkZJR19TRVJJTz15CisjIENPTkZJR19TRVJJT19JODA0MiBpcyBub3Qgc2V0
CitDT05GSUdfU0VSSU9fU0VSUE9SVD15CisjIENPTkZJR19TRVJJT19MSUJQUzIgaXMgbm90IHNl
dAorIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKKyMgQ09ORklHX0dBTUVQT1JUIGlzIG5v
dCBzZXQKKworIworIyBDaGFyYWN0ZXIgZGV2aWNlcworIworQ09ORklHX1ZUPXkKKyMgQ09ORklH
X1ZUX0NPTlNPTEUgaXMgbm90IHNldAorQ09ORklHX0hXX0NPTlNPTEU9eQorIyBDT05GSUdfVlRf
SFdfQ09OU09MRV9CSU5ESU5HIGlzIG5vdCBzZXQKK0NPTkZJR19ERVZLTUVNPXkKKyMgQ09ORklH
X1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CisKKyMKKyMgU2VyaWFsIGRyaXZlcnMKKyMK
KyMgQ09ORklHX1NFUklBTF84MjUwIGlzIG5vdCBzZXQKKworIworIyBOb24tODI1MCBzZXJpYWwg
cG9ydCBzdXBwb3J0CisjCitDT05GSUdfVU5JWDk4X1BUWVM9eQorIyBDT05GSUdfTEVHQUNZX1BU
WVMgaXMgbm90IHNldAorIyBDT05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKK0NPTkZJR19I
V19SQU5ET009eQorIyBDT05GSUdfUjM5NjQgaXMgbm90IHNldAorIyBDT05GSUdfUkFXX0RSSVZF
UiBpcyBub3Qgc2V0CisjIENPTkZJR19UQ0dfVFBNIGlzIG5vdCBzZXQKK0NPTkZJR19JMkM9eQor
Q09ORklHX0kyQ19CT0FSRElORk89eQorQ09ORklHX0kyQ19DSEFSREVWPXkKK0NPTkZJR19JMkNf
QUxHT1BDQT15CisKKyMKKyMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CisjCisjIENPTkZJR19J
MkNfR1BJTyBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfT0NPUkVTIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0kyQ19QQVJQT1JUX0xJR0hUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19TSU1URUMgaXMg
bm90IHNldAorIyBDT05GSUdfSTJDX1RBT1NfRVZNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19T
VFVCIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAorQ09O
RklHX0kyQ19QTlgwMTA1PXkKKworIworIyBNaXNjZWxsYW5lb3VzIEkyQyBDaGlwIHN1cHBvcnQK
KyMKKyMgQ09ORklHX0RTMTY4MiBpcyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX0VFUFJPTSBp
cyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX1BDRjg1NzQgaXMgbm90IHNldAorIyBDT05GSUdf
UENGODU3NSBpcyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNldAor
IyBDT05GSUdfU0VOU09SU19NQVg2ODc1IGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFTlNPUlNfVFNM
MjU1MCBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfREVCVUdfQ09SRSBpcyBub3Qgc2V0CisjIENP
TkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfREVCVUdfQlVTIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0kyQ19ERUJVR19DSElQIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NQ
SSBpcyBub3Qgc2V0CisjIENPTkZJR19XMSBpcyBub3Qgc2V0CisjIENPTkZJR19QT1dFUl9TVVBQ
TFkgaXMgbm90IHNldAorIyBDT05GSUdfSFdNT04gaXMgbm90IHNldAorIyBDT05GSUdfVEhFUk1B
TCBpcyBub3Qgc2V0CisjIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CisKKyMKKyMgU29uaWNz
IFNpbGljb24gQmFja3BsYW5lCisjCitDT05GSUdfU1NCX1BPU1NJQkxFPXkKKyMgQ09ORklHX1NT
QiBpcyBub3Qgc2V0CisKKyMKKyMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycworIworIyBD
T05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKKyMgQ09ORklHX0hUQ19QQVNJQzMgaXMgbm90IHNl
dAorCisjCisjIE11bHRpbWVkaWEgZGV2aWNlcworIworCisjCisjIE11bHRpbWVkaWEgY29yZSBz
dXBwb3J0CisjCisjIENPTkZJR19WSURFT19ERVYgaXMgbm90IHNldAorQ09ORklHX0RWQl9DT1JF
PXkKK0NPTkZJR19WSURFT19NRURJQT15CisKKyMKKyMgTXVsdGltZWRpYSBkcml2ZXJzCisjCisj
IENPTkZJR19NRURJQV9BVFRBQ0ggaXMgbm90IHNldAorQ09ORklHX01FRElBX1RVTkVSPXkKKyMg
Q09ORklHX01FRElBX1RVTkVSX0NVU1RPTUlaRSBpcyBub3Qgc2V0CitDT05GSUdfTUVESUFfVFVO
RVJfU0lNUExFPXkKK0NPTkZJR19NRURJQV9UVU5FUl9UREE4MjkwPXkKK0NPTkZJR19NRURJQV9U
VU5FUl9UREE5ODg3PXkKK0NPTkZJR19NRURJQV9UVU5FUl9URUE1NzYxPXkKK0NPTkZJR19NRURJ
QV9UVU5FUl9URUE1NzY3PXkKK0NPTkZJR19NRURJQV9UVU5FUl9NVDIwWFg9eQorQ09ORklHX01F
RElBX1RVTkVSX1hDMjAyOD15CitDT05GSUdfTUVESUFfVFVORVJfWEM1MDAwPXkKK0NPTkZJR19E
VkJfQ0FQVFVSRV9EUklWRVJTPXkKKyMgQ09ORklHX1RUUENJX0VFUFJPTSBpcyBub3Qgc2V0Cisj
IENPTkZJR19EVkJfQjJDMl9GTEVYQ09QIGlzIG5vdCBzZXQKKworIworIyBTdXBwb3J0ZWQgRFZC
IEZyb250ZW5kcworIworCisjCisjIEN1c3RvbWlzZSBEVkIgRnJvbnRlbmRzCisjCisjIENPTkZJ
R19EVkJfRkVfQ1VTVE9NSVNFIGlzIG5vdCBzZXQKKworIworIyBEVkItUyAoc2F0ZWxsaXRlKSBm
cm9udGVuZHMKKyMKKyMgQ09ORklHX0RWQl9DWDI0MTEwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RW
Ql9DWDI0MTIzIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9NVDMxMiBpcyBub3Qgc2V0CisjIENP
TkZJR19EVkJfUzVIMTQyMCBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfU1RWMDI5OSBpcyBub3Qg
c2V0CisjIENPTkZJR19EVkJfVERBODA4MyBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfVERBMTAw
ODYgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX1ZFUzFYOTMgaXMgbm90IHNldAorIyBDT05GSUdf
RFZCX1RVTkVSX0lURDEwMDAgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX1REQTgyNlggaXMgbm90
IHNldAorIyBDT05GSUdfRFZCX1RVQTYxMDAgaXMgbm90IHNldAorCisjCisjIERWQi1UICh0ZXJy
ZXN0cmlhbCkgZnJvbnRlbmRzCisjCisjIENPTkZJR19EVkJfU1A4ODcwIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0RWQl9TUDg4N1ggaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0NYMjI3MDAgaXMgbm90
IHNldAorIyBDT05GSUdfRFZCX0NYMjI3MDIgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0w2NDc4
MSBpcyBub3Qgc2V0CitDT05GSUdfRFZCX1REQTEwMDRYPXkKKyMgQ09ORklHX0RWQl9OWFQ2MDAw
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9NVDM1MiBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJf
WkwxMDM1MyBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfRElCMzAwME1CIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0RWQl9ESUIzMDAwTUMgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0RJQjcwMDBNIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0RWQl9ESUI3MDAwUCBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJf
VERBMTAwNDggaXMgbm90IHNldAorCisjCisjIERWQi1DIChjYWJsZSkgZnJvbnRlbmRzCisjCisj
IENPTkZJR19EVkJfVkVTMTgyMCBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfVERBMTAwMjEgaXMg
bm90IHNldAorIyBDT05GSUdfRFZCX1REQTEwMDIzIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9T
VFYwMjk3IGlzIG5vdCBzZXQKKworIworIyBBVFNDIChOb3J0aCBBbWVyaWNhbi9Lb3JlYW4gVGVy
cmVzdHJpYWwvQ2FibGUgRFRWKSBmcm9udGVuZHMKKyMKKyMgQ09ORklHX0RWQl9OWFQyMDBYIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0RWQl9PUjUxMjExIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9P
UjUxMTMyIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9CQ00zNTEwIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0RWQl9MR0RUMzMwWCBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfUzVIMTQwOSBpcyBub3Qg
c2V0CisjIENPTkZJR19EVkJfQVU4NTIyIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9TNUgxNDEx
IGlzIG5vdCBzZXQKKworIworIyBEaWdpdGFsIHRlcnJlc3RyaWFsIG9ubHkgdHVuZXJzL1BMTAor
IworIyBDT05GSUdfRFZCX1BMTCBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfVFVORVJfRElCMDA3
MCBpcyBub3Qgc2V0CisKKyMKKyMgU0VDIGNvbnRyb2wgZGV2aWNlcyBmb3IgRFZCLVMKKyMKKyMg
Q09ORklHX0RWQl9MTkJQMjEgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0lTTDY0MDUgaXMgbm90
IHNldAorIyBDT05GSUdfRFZCX0lTTDY0MjEgaXMgbm90IHNldAorIyBDT05GSUdfREFCIGlzIG5v
dCBzZXQKKworIworIyBHcmFwaGljcyBzdXBwb3J0CisjCisjIENPTkZJR19WR0FTVEFURSBpcyBu
b3Qgc2V0CisjIENPTkZJR19WSURFT19PVVRQVVRfQ09OVFJPTCBpcyBub3Qgc2V0CitDT05GSUdf
RkI9eQorIyBDT05GSUdfRklSTVdBUkVfRURJRCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9EREMg
aXMgbm90IHNldAorIyBDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0ZCX0NGQl9DT1BZQVJFQSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9DRkJfSU1BR0VCTElUIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0ZCX0NGQl9SRVZfUElYRUxTX0lOX0JZVEUgaXMgbm90IHNldAor
IyBDT05GSUdfRkJfU1lTX0ZJTExSRUNUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NZU19DT1BZ
QVJFQSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9TWVNfSU1BR0VCTElUIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0ZCX0ZPUkVJR05fRU5ESUFOIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NZU19GT1BT
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NWR0FMSUIgaXMgbm90IHNldAorIyBDT05GSUdfRkJf
TUFDTU9ERVMgaXMgbm90IHNldAorIyBDT05GSUdfRkJfQkFDS0xJR0hUIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0ZCX01PREVfSEVMUEVSUyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9USUxFQkxJVFRJ
TkcgaXMgbm90IHNldAorCisjCisjIEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2ZXJzCisjCisj
IENPTkZJR19GQl9TMUQxM1hYWCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9WSVJUVUFMIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBub3Qgc2V0CisKKyMKKyMg
RGlzcGxheSBkZXZpY2Ugc3VwcG9ydAorIworIyBDT05GSUdfRElTUExBWV9TVVBQT1JUIGlzIG5v
dCBzZXQKKworIworIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKKyMKKyMgQ09ORklH
X1ZHQV9DT05TT0xFIGlzIG5vdCBzZXQKK0NPTkZJR19EVU1NWV9DT05TT0xFPXkKKyMgQ09ORklH
X0ZSQU1FQlVGRkVSX0NPTlNPTEUgaXMgbm90IHNldAorIyBDT05GSUdfTE9HTyBpcyBub3Qgc2V0
CisKKyMKKyMgU291bmQKKyMKK0NPTkZJR19TT1VORD1tCisKKyMKKyMgQWR2YW5jZWQgTGludXgg
U291bmQgQXJjaGl0ZWN0dXJlCisjCitDT05GSUdfU05EPW0KK0NPTkZJR19TTkRfVElNRVI9bQor
Q09ORklHX1NORF9QQ009bQorQ09ORklHX1NORF9TRVFVRU5DRVI9bQorIyBDT05GSUdfU05EX1NF
UV9EVU1NWSBpcyBub3Qgc2V0CitDT05GSUdfU05EX09TU0VNVUw9eQorQ09ORklHX1NORF9NSVhF
Ul9PU1M9bQorQ09ORklHX1NORF9QQ01fT1NTPW0KK0NPTkZJR19TTkRfUENNX09TU19QTFVHSU5T
PXkKK0NPTkZJR19TTkRfU0VRVUVOQ0VSX09TUz15CisjIENPTkZJR19TTkRfRFlOQU1JQ19NSU5P
UlMgaXMgbm90IHNldAorQ09ORklHX1NORF9TVVBQT1JUX09MRF9BUEk9eQorQ09ORklHX1NORF9W
RVJCT1NFX1BST0NGUz15CitDT05GSUdfU05EX1ZFUkJPU0VfUFJJTlRLPXkKK0NPTkZJR19TTkRf
REVCVUc9eQorQ09ORklHX1NORF9ERUJVR19ERVRFQ1Q9eQorIyBDT05GSUdfU05EX1BDTV9YUlVO
X0RFQlVHIGlzIG5vdCBzZXQKKworIworIyBHZW5lcmljIGRldmljZXMKKyMKKyMgQ09ORklHX1NO
RF9EVU1NWSBpcyBub3Qgc2V0CisjIENPTkZJR19TTkRfVklSTUlESSBpcyBub3Qgc2V0CisjIENP
TkZJR19TTkRfTVRQQVYgaXMgbm90IHNldAorIyBDT05GSUdfU05EX1NFUklBTF9VMTY1NTAgaXMg
bm90IHNldAorIyBDT05GSUdfU05EX01QVTQwMSBpcyBub3Qgc2V0CisKKyMKKyMgQUxTQSBNSVBT
IGRldmljZXMKKyMKKworIworIyBTeXN0ZW0gb24gQ2hpcCBhdWRpbyBzdXBwb3J0CisjCisjIENP
TkZJR19TTkRfU09DIGlzIG5vdCBzZXQKKworIworIyBBTFNBIFNvQyBhdWRpbyBmb3IgRnJlZXNj
YWxlIFNPQ3MKKyMKKworIworIyBTb0MgQXVkaW8gZm9yIHRoZSBUZXhhcyBJbnN0cnVtZW50cyBP
TUFQCisjCisKKyMKKyMgT3BlbiBTb3VuZCBTeXN0ZW0KKyMKKyMgQ09ORklHX1NPVU5EX1BSSU1F
IGlzIG5vdCBzZXQKK0NPTkZJR19ISURfU1VQUE9SVD15CitDT05GSUdfSElEPXkKKyMgQ09ORklH
X0hJRF9ERUJVRyBpcyBub3Qgc2V0CisjIENPTkZJR19ISURSQVcgaXMgbm90IHNldAorQ09ORklH
X1VTQl9TVVBQT1JUPXkKKyMgQ09ORklHX1VTQl9BUkNIX0hBU19IQ0QgaXMgbm90IHNldAorIyBD
T05GSUdfVVNCX0FSQ0hfSEFTX09IQ0kgaXMgbm90IHNldAorIyBDT05GSUdfVVNCX0FSQ0hfSEFT
X0VIQ0kgaXMgbm90IHNldAorIyBDT05GSUdfVVNCX09UR19XSElURUxJU1QgaXMgbm90IHNldAor
IyBDT05GSUdfVVNCX09UR19CTEFDS0xJU1RfSFVCIGlzIG5vdCBzZXQKKworIworIyBOT1RFOiBV
U0JfU1RPUkFHRSBlbmFibGVzIFNDU0ksIGFuZCAnU0NTSSBkaXNrIHN1cHBvcnQnCisjCisjIENP
TkZJR19VU0JfR0FER0VUIGlzIG5vdCBzZXQKKyMgQ09ORklHX01NQyBpcyBub3Qgc2V0CisjIENP
TkZJR19NRU1TVElDSyBpcyBub3Qgc2V0CisjIENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0Cisj
IENPTkZJR19BQ0NFU1NJQklMSVRZIGlzIG5vdCBzZXQKK0NPTkZJR19SVENfTElCPXkKKyMgQ09O
RklHX1JUQ19DTEFTUyBpcyBub3Qgc2V0CisjIENPTkZJR19VSU8gaXMgbm90IHNldAorCisjCisj
IEZpbGUgc3lzdGVtcworIworQ09ORklHX0VYVDJfRlM9bQorIyBDT05GSUdfRVhUMl9GU19YQVRU
UiBpcyBub3Qgc2V0CisjIENPTkZJR19FWFQyX0ZTX1hJUCBpcyBub3Qgc2V0CisjIENPTkZJR19F
WFQzX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0VYVDRERVZfRlMgaXMgbm90IHNldAorIyBDT05G
SUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CisjIENPTkZJR19YRlNfRlMgaXMgbm90IHNl
dAorIyBDT05GSUdfT0NGUzJfRlMgaXMgbm90IHNldAorIyBDT05GSUdfRE5PVElGWSBpcyBub3Qg
c2V0CitDT05GSUdfSU5PVElGWT15CitDT05GSUdfSU5PVElGWV9VU0VSPXkKKyMgQ09ORklHX1FV
T1RBIGlzIG5vdCBzZXQKKyMgQ09ORklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CisjIENPTkZJR19B
VVRPRlM0X0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAorCisjCisj
IENELVJPTS9EVkQgRmlsZXN5c3RlbXMKKyMKKyMgQ09ORklHX0lTTzk2NjBfRlMgaXMgbm90IHNl
dAorIyBDT05GSUdfVURGX0ZTIGlzIG5vdCBzZXQKKworIworIyBET1MvRkFUL05UIEZpbGVzeXN0
ZW1zCisjCitDT05GSUdfRkFUX0ZTPW0KK0NPTkZJR19NU0RPU19GUz1tCitDT05GSUdfVkZBVF9G
Uz1tCitDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBBR0U9NDM3CitDT05GSUdfRkFUX0RFRkFVTFRf
SU9DSEFSU0VUPSJpc284ODU5LTEiCisjIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKKworIwor
IyBQc2V1ZG8gZmlsZXN5c3RlbXMKKyMKK0NPTkZJR19QUk9DX0ZTPXkKKyMgQ09ORklHX1BST0Nf
S0NPUkUgaXMgbm90IHNldAorQ09ORklHX1BST0NfU1lTQ1RMPXkKK0NPTkZJR19TWVNGUz15CitD
T05GSUdfVE1QRlM9eQorIyBDT05GSUdfVE1QRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0hVR0VUTEJfUEFHRSBpcyBub3Qgc2V0CisjIENPTkZJR19DT05GSUdGU19GUyBpcyBub3Qg
c2V0CisKKyMKKyMgTWlzY2VsbGFuZW91cyBmaWxlc3lzdGVtcworIworIyBDT05GSUdfQURGU19G
UyBpcyBub3Qgc2V0CisjIENPTkZJR19BRkZTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0hGU19G
UyBpcyBub3Qgc2V0CisjIENPTkZJR19IRlNQTFVTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JF
RlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0VG
U19GUyBpcyBub3Qgc2V0CitDT05GSUdfSkZGUzJfRlM9eQorQ09ORklHX0pGRlMyX0ZTX0RFQlVH
PTAKK0NPTkZJR19KRkZTMl9GU19XUklURUJVRkZFUj15CisjIENPTkZJR19KRkZTMl9GU19XQlVG
X1ZFUklGWSBpcyBub3Qgc2V0CisjIENPTkZJR19KRkZTMl9TVU1NQVJZIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0pGRlMyX0ZTX1hBVFRSIGlzIG5vdCBzZXQKKyMgQ09ORklHX0pGRlMyX0NPTVBSRVNT
SU9OX09QVElPTlMgaXMgbm90IHNldAorQ09ORklHX0pGRlMyX1pMSUI9eQorIyBDT05GSUdfSkZG
UzJfTFpPIGlzIG5vdCBzZXQKK0NPTkZJR19KRkZTMl9SVElNRT15CisjIENPTkZJR19KRkZTMl9S
VUJJTiBpcyBub3Qgc2V0CitDT05GSUdfQ1JBTUZTPXkKKyMgQ09ORklHX1ZYRlNfRlMgaXMgbm90
IHNldAorIyBDT05GSUdfTUlOSVhfRlMgaXMgbm90IHNldAorIyBDT05GSUdfSFBGU19GUyBpcyBu
b3Qgc2V0CisjIENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdfUk9NRlNfRlMg
aXMgbm90IHNldAorIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CisjIENPTkZJR19VRlNfRlMg
aXMgbm90IHNldAorQ09ORklHX05FVFdPUktfRklMRVNZU1RFTVM9eQorQ09ORklHX05GU19GUz15
CitDT05GSUdfTkZTX1YzPXkKKyMgQ09ORklHX05GU19WM19BQ0wgaXMgbm90IHNldAorIyBDT05G
SUdfTkZTX1Y0IGlzIG5vdCBzZXQKK0NPTkZJR19ORlNEPW0KK0NPTkZJR19ORlNEX1YzPXkKKyMg
Q09ORklHX05GU0RfVjNfQUNMIGlzIG5vdCBzZXQKKyMgQ09ORklHX05GU0RfVjQgaXMgbm90IHNl
dAorQ09ORklHX1JPT1RfTkZTPXkKK0NPTkZJR19MT0NLRD15CitDT05GSUdfTE9DS0RfVjQ9eQor
Q09ORklHX0VYUE9SVEZTPW0KK0NPTkZJR19ORlNfQ09NTU9OPXkKK0NPTkZJR19TVU5SUEM9eQor
IyBDT05GSUdfU1VOUlBDX0JJTkQzNCBpcyBub3Qgc2V0CisjIENPTkZJR19SUENTRUNfR1NTX0tS
QjUgaXMgbm90IHNldAorIyBDT05GSUdfUlBDU0VDX0dTU19TUEtNMyBpcyBub3Qgc2V0CisjIENP
TkZJR19TTUJfRlMgaXMgbm90IHNldAorIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CisjIENPTkZJ
R19OQ1BfRlMgaXMgbm90IHNldAorIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CisjIENPTkZJ
R19BRlNfRlMgaXMgbm90IHNldAorCisjCisjIFBhcnRpdGlvbiBUeXBlcworIworIyBDT05GSUdf
UEFSVElUSU9OX0FEVkFOQ0VEIGlzIG5vdCBzZXQKK0NPTkZJR19NU0RPU19QQVJUSVRJT049eQor
Q09ORklHX05MUz15CitDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKK0NPTkZJR19OTFNf
Q09ERVBBR0VfNDM3PW0KKyMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNldAorIyBD
T05GSUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CitDT05GSUdfTkxTX0NPREVQQUdFXzg1
MD1tCisjIENPTkZJR19OTFNfQ09ERVBBR0VfODUyIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19D
T0RFUEFHRV84NTUgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qg
c2V0CisjIENPTkZJR19OTFNfQ09ERVBBR0VfODYwIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19D
T0RFUEFHRV84NjEgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qg
c2V0CisjIENPTkZJR19OTFNfQ09ERVBBR0VfODYzIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19D
T0RFUEFHRV84NjQgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qg
c2V0CisjIENPTkZJR19OTFNfQ09ERVBBR0VfODY2IGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19D
T0RFUEFHRV84NjkgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qg
c2V0CisjIENPTkZJR19OTFNfQ09ERVBBR0VfOTUwIGlzIG5vdCBzZXQKK0NPTkZJR19OTFNfQ09E
RVBBR0VfOTMyPW0KKyMgQ09ORklHX05MU19DT0RFUEFHRV85NDkgaXMgbm90IHNldAorIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV84IGlz
IG5vdCBzZXQKKyMgQ09ORklHX05MU19DT0RFUEFHRV8xMjUwIGlzIG5vdCBzZXQKKyMgQ09ORklH
X05MU19DT0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKK0NPTkZJR19OTFNfQVNDSUk9bQorQ09ORklH
X05MU19JU084ODU5XzE9bQorIyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CisjIENP
TkZJR19OTFNfSVNPODg1OV8zIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19JU084ODU5XzQgaXMg
bm90IHNldAorIyBDT05GSUdfTkxTX0lTTzg4NTlfNSBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNf
SVNPODg1OV82IGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90IHNldAor
IyBDT05GSUdfTkxTX0lTTzg4NTlfOSBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV8x
MyBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CitDT05GSUdf
TkxTX0lTTzg4NTlfMTU9bQorIyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CisjIENPTkZJ
R19OTFNfS09JOF9VIGlzIG5vdCBzZXQKK0NPTkZJR19OTFNfVVRGOD1tCisjIENPTkZJR19ETE0g
aXMgbm90IHNldAorCisjCisjIEtlcm5lbCBoYWNraW5nCisjCitDT05GSUdfVFJBQ0VfSVJRRkxB
R1NfU1VQUE9SVD15CisjIENPTkZJR19QUklOVEtfVElNRSBpcyBub3Qgc2V0CitDT05GSUdfRU5B
QkxFX1dBUk5fREVQUkVDQVRFRD15CitDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9eQorQ09ORklH
X0ZSQU1FX1dBUk49MTAyNAorIyBDT05GSUdfTUFHSUNfU1lTUlEgaXMgbm90IHNldAorIyBDT05G
SUdfVU5VU0VEX1NZTUJPTFMgaXMgbm90IHNldAorIyBDT05GSUdfREVCVUdfRlMgaXMgbm90IHNl
dAorIyBDT05GSUdfSEVBREVSU19DSEVDSyBpcyBub3Qgc2V0CisjIENPTkZJR19ERUJVR19LRVJO
RUwgaXMgbm90IHNldAorIyBDT05GSUdfU0FNUExFUyBpcyBub3Qgc2V0CitDT05GSUdfQ01ETElO
RT0iIgorQ09ORklHX1NZU19TVVBQT1JUU19LR0RCPXkKKworIworIyBTZWN1cml0eSBvcHRpb25z
CisjCisjIENPTkZJR19LRVlTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX1NFQ1VSSVRZX0ZJTEVfQ0FQQUJJTElUSUVTIGlzIG5vdCBzZXQKK0NPTkZJ
R19DUllQVE89eQorCisjCisjIENyeXB0byBjb3JlIG9yIGhlbHBlcgorIworQ09ORklHX0NSWVBU
T19BTEdBUEk9eQorQ09ORklHX0NSWVBUT19IQVNIPXkKK0NPTkZJR19DUllQVE9fTUFOQUdFUj15
CisjIENPTkZJR19DUllQVE9fR0YxMjhNVUwgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX05V
TEwgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX0NSWVBURCBpcyBub3Qgc2V0CisjIENPTkZJ
R19DUllQVE9fQVVUSEVOQyBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fVEVTVCBpcyBub3Qg
c2V0CisKKyMKKyMgQXV0aGVudGljYXRlZCBFbmNyeXB0aW9uIHdpdGggQXNzb2NpYXRlZCBEYXRh
CisjCisjIENPTkZJR19DUllQVE9fQ0NNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19HQ00g
aXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX1NFUUlWIGlzIG5vdCBzZXQKKworIworIyBCbG9j
ayBtb2RlcworIworIyBDT05GSUdfQ1JZUFRPX0NCQyBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQ
VE9fQ1RSIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19DVFMgaXMgbm90IHNldAorIyBDT05G
SUdfQ1JZUFRPX0VDQiBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0NSWVBUT19QQ0JDIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19YVFMgaXMg
bm90IHNldAorCisjCisjIEhhc2ggbW9kZXMKKyMKK0NPTkZJR19DUllQVE9fSE1BQz15CisjIENP
TkZJR19DUllQVE9fWENCQyBpcyBub3Qgc2V0CisKKyMKKyMgRGlnZXN0CisjCisjIENPTkZJR19D
UllQVE9fQ1JDMzJDIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19NRDQgaXMgbm90IHNldAor
Q09ORklHX0NSWVBUT19NRDU9eQorIyBDT05GSUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5vdCBz
ZXQKK0NPTkZJR19DUllQVE9fU0hBMT15CisjIENPTkZJR19DUllQVE9fU0hBMjU2IGlzIG5vdCBz
ZXQKKyMgQ09ORklHX0NSWVBUT19TSEE1MTIgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX1RH
UjE5MiBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fV1A1MTIgaXMgbm90IHNldAorCisjCisj
IENpcGhlcnMKKyMKKyMgQ09ORklHX0NSWVBUT19BRVMgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZ
UFRPX0FOVUJJUyBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fQVJDNCBpcyBub3Qgc2V0Cisj
IENPTkZJR19DUllQVE9fQkxPV0ZJU0ggaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX0NBTUVM
TElBIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CisjIENPTkZJ
R19DUllQVE9fQ0FTVDYgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX0RFUyBpcyBub3Qgc2V0
CisjIENPTkZJR19DUllQVE9fRkNSWVBUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19LSEFa
QUQgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX1NBTFNBMjAgaXMgbm90IHNldAorIyBDT05G
SUdfQ1JZUFRPX1NFRUQgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlQgaXMgbm90
IHNldAorIyBDT05GSUdfQ1JZUFRPX1RFQSBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fVFdP
RklTSCBpcyBub3Qgc2V0CisKKyMKKyMgQ29tcHJlc3Npb24KKyMKKyMgQ09ORklHX0NSWVBUT19E
RUZMQVRFIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19MWk8gaXMgbm90IHNldAorQ09ORklH
X0NSWVBUT19IVz15CisKKyMKKyMgTGlicmFyeSByb3V0aW5lcworIworQ09ORklHX0JJVFJFVkVS
U0U9eQorIyBDT05GSUdfR0VORVJJQ19GSU5EX0ZJUlNUX0JJVCBpcyBub3Qgc2V0CisjIENPTkZJ
R19DUkNfQ0NJVFQgaXMgbm90IHNldAorIyBDT05GSUdfQ1JDMTYgaXMgbm90IHNldAorIyBDT05G
SUdfQ1JDX0lUVV9UIGlzIG5vdCBzZXQKK0NPTkZJR19DUkMzMj15CisjIENPTkZJR19DUkM3IGlz
IG5vdCBzZXQKKyMgQ09ORklHX0xJQkNSQzMyQyBpcyBub3Qgc2V0CitDT05GSUdfWkxJQl9JTkZM
QVRFPXkKK0NPTkZJR19aTElCX0RFRkxBVEU9eQorQ09ORklHX1BMSVNUPXkKK0NPTkZJR19IQVNf
SU9NRU09eQorQ09ORklHX0hBU19JT1BPUlQ9eQorQ09ORklHX0hBU19ETUE9eQpkaWZmIC11ck4g
LS1leGNsdWRlPS5zdm4gbGludXgtMi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9LY29uZmlnIGxp
bnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL0tjb25maWcKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3Jp
Zy9hcmNoL21pcHMvS2NvbmZpZwkyMDA4LTA2LTAzIDEwOjU2OjUxLjAwMDAwMDAwMCArMDEwMAor
KysgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvS2NvbmZpZwkyMDA4LTA2LTAzIDE3OjEyOjE5
LjAwMDAwMDAwMCArMDEwMApAQCAtMzExLDYgKzMxMSwxOSBAQAogCXNlbGVjdCBTWVNfSEFTX0NQ
VV9WUjQxWFgKIAlzZWxlY3QgR0VORVJJQ19IQVJESVJRU19OT19fRE9fSVJRCiAKK2NvbmZpZyBO
WFBfU1RCMjIwCisJYm9vbCAiTlhQIFNUQjIyMCBib2FyZCIKKwlzZWxlY3QgU09DX1BOWDgzM1gK
KwloZWxwCisJIFN1cHBvcnQgZm9yIE5YUCBTZW1pY29uZHVjdG9ycyBTVEIyMjAgRGV2ZWxvcG1l
bnQgQm9hcmQuCisKK2NvbmZpZyBOWFBfU1RCMjI1CisJYm9vbCAiTlhQIDIyNSBib2FyZCIKKwlz
ZWxlY3QgU09DX1BOWDgzM1gKKwlzZWxlY3QgU09DX1BOWDgzMzUKKwloZWxwCisJIFN1cHBvcnQg
Zm9yIE5YUCBTZW1pY29uZHVjdG9ycyBTVEIyMjUgRGV2ZWxvcG1lbnQgQm9hcmQuCisKIGNvbmZp
ZyBQTlg4NTUwX0pCUwogCWJvb2wgIk5YUCBQTlg4NTUwIGJhc2VkIEpCUyBib2FyZCIKIAlzZWxl
Y3QgUE5YODU1MApAQCAtOTQ3LDYgKzk2MCwyNiBAQAogCWJvb2wKIAlzZWxlY3QgU0VSSUFMX1JN
OTAwMAogCitjb25maWcgU09DX1BOWDgzM1gKKwlib29sCisJc2VsZWN0IENFVlRfUjRLCisJc2Vs
ZWN0IENTUkNfUjRLCisJc2VsZWN0IElSUV9DUFUKKwlzZWxlY3QgRE1BX05PTkNPSEVSRU5UCisJ
c2VsZWN0IFNZU19IQVNfRUFSTFlfUFJJTlRLCisJc2VsZWN0IFNZU19IQVNfQ1BVX01JUFMzMl9S
MgorCXNlbGVjdCBTWVNfU1VQUE9SVFNfMzJCSVRfS0VSTkVMCisJc2VsZWN0IFNZU19TVVBQT1JU
U19MSVRUTEVfRU5ESUFOCisJc2VsZWN0IFNZU19TVVBQT1JUU19CSUdfRU5ESUFOCisJc2VsZWN0
IEdFTkVSSUNfSEFSRElSUVNfTk9fX0RPX0lSUQorCXNlbGVjdCBTWVNfU1VQUE9SVFNfS0dEQgor
CXNlbGVjdCBHRU5FUklDX0dQSU8KKwlzZWxlY3QgQ1BVX01JUFNSMl9JUlFfVkkKKworY29uZmln
IFNPQ19QTlg4MzM1CisJYm9vbAorCXNlbGVjdCBTT0NfUE5YODMzWAorCiBjb25maWcgUE5YODU1
MAogCWJvb2wKIAlzZWxlY3QgU09DX1BOWDg1NTAKZGlmZiAtdXJOIC0tZXhjbHVkZT0uc3ZuIGxp
bnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvTWFrZWZpbGUgbGludXgtMi42LjI2LXJjNC9h
cmNoL21pcHMvTWFrZWZpbGUKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvTWFr
ZWZpbGUJMjAwOC0wNi0wMyAxMDo1Njo1MS4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4y
Ni1yYzQvYXJjaC9taXBzL01ha2VmaWxlCTIwMDgtMDYtMDMgMTc6MTM6MDMuMDAwMDAwMDAwICsw
MTAwCkBAIC00MDksNiArNDA5LDE0IEBACiAjCiBsb2FkLSQoQ09ORklHX1RBTkJBQ19UQjAyMlgp
CSs9IDB4ZmZmZmZmZmY4MDAwMDAwMAogCisjIE5YUCBTVEIyMjUKK2NvcmUtJChDT05GSUdfU09D
X1BOWDgzM1gpCQkrPSBhcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uLworY2ZsYWdzLSQoQ09O
RklHX1NPQ19QTlg4MzNYKQkrPSAtSWluY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4CitsaWJz
LSQoQ09ORklHX05YUF9TVEIyMjApCQkrPSBhcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4Lwor
bG9hZC0kKENPTkZJR19OWFBfU1RCMjIwKQkJKz0gMHhmZmZmZmZmZjgwMDAxMDAwCitsaWJzLSQo
Q09ORklHX05YUF9TVEIyMjUpCQkrPSBhcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4LworbG9h
ZC0kKENPTkZJR19OWFBfU1RCMjI1KQkJKz0gMHhmZmZmZmZmZjgwMDAxMDAwCisKICMKICMgQ29t
bW9uIE5YUCBQTlg4NTUwCiAjCmRpZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYt
cmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5jIGxpbnV4LTIu
Ni4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5jCi0tLSBsaW51
eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5j
CTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0
L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vZ2RiX2hvb2suYwkyMDA4LTA2LTA2IDExOjI5
OjAxLjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDEzNCBAQAorLyoKKyAqICBnZGJfaG9vay5j
OiBnZGIgaG9vayBmb3IgUE5YODMzWC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWlj
b25kdWN0b3JzCisgKgkgIENocmlzIFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgorICogICAg
RGFuaWVsIExhaXJkIDxkYW5pZWwuai5sYWlyZEBueHAuY29tPgorICoKKyAqICBCYXNlZCBvbiBQ
Tlg4NTUwLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlz
IHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1
bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGll
ZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBw
cm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiAgRm91bmRhdGlv
biwgSW5jLiwgNjc1IE1hc3MgQXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKyNp
bmNsdWRlIDxsaW51eC9zZXJpYWxfcG54OHh4eC5oPgorI2luY2x1ZGUgPGFzbS9tYWNoLXBueDgz
M3gvcG54ODMzeC5oPgorCisjZGVmaW5lIFVBUlQwICh1bnNpZ25lZCBjaGFyICopUE5YODMzWF9V
QVJUMF9QT1JUU19TVEFSVAorI2RlZmluZSBVQVJUMSAodW5zaWduZWQgY2hhciAqKVBOWDgzM1hf
VUFSVDFfUE9SVFNfU1RBUlQKKworc3RhdGljIHVuc2lnbmVkIGNoYXIgKmtnZGJfdWFydCAgICA9
IFVBUlQxOworc3RhdGljIHVuc2lnbmVkIGNoYXIgKmNvbnNvbGVfdWFydCA9IFVBUlQwOworc3Rh
dGljIHZvbGF0aWxlIGludCBkZWxheV9jb3VudDsKKworc3RhdGljIHVuc2lnbmVkIGludCBzZXJp
YWxfaW4odW5zaWduZWQgY2hhciAqYmFzZV9hZGRyZXNzLCBpbnQgb2Zmc2V0KQoreworCXJldHVy
biAqKCh1bnNpZ25lZCBpbnQgdm9sYXRpbGUgKikoYmFzZV9hZGRyZXNzICsgb2Zmc2V0KSk7Cit9
CisKK3N0YXRpYyB2b2lkIHNlcmlhbF9vdXQodW5zaWduZWQgY2hhciAqYmFzZV9hZGRyZXNzLCBp
bnQgb2Zmc2V0LCBpbnQgdmFsdWUpCit7CisJKigodW5zaWduZWQgaW50IHZvbGF0aWxlICopKGJh
c2VfYWRkcmVzcyArIG9mZnNldCkpID0gdmFsdWU7Cit9CisKK3N0YXRpYyB2b2lkIGRvX2RlbGF5
KHZvaWQpCit7CisJaW50IGk7CisJZm9yIChpID0gMDsgaSA8IDEwMDAwOyBpKyspCisJCWRlbGF5
X2NvdW50Kys7Cit9CisKK3N0YXRpYyBpbnQgcHV0X2NoYXIodW5zaWduZWQgY2hhciAqYmFzZV9h
ZGRyZXNzLCBjaGFyIGMpCit7CisJLyogV2FpdCBmb3IgVFggdG8gYmUgcmVhZHkgKi8KKwl3aGls
ZSAoKChzZXJpYWxfaW4oYmFzZV9hZGRyZXNzLCBQTlg4WFhYX0ZJRk8pICYgUE5YOFhYWF9VQVJU
X0ZJRk9fVFhGSUZPKSA+PiAxNikgPiAxNSkKKwkJZG9fZGVsYXkoKTsKKworCS8qIFNlbmQgdGhl
IG5leHQgY2hhcmFjdGVyICovCisJc2VyaWFsX291dChiYXNlX2FkZHJlc3MsIFBOWDhYWFhfRklG
TywgYyk7CisJc2VyaWFsX291dChiYXNlX2FkZHJlc3MsIFBOWDhYWFhfSUNMUiwgUE5YOFhYWF9V
QVJUX0lOVF9UWCk7CisKKwlyZXR1cm4gMTsKK30KKworc3RhdGljIGNoYXIgZ2V0X2NoYXIodW5z
aWduZWQgY2hhciAqYmFzZV9hZGRyZXNzKQoreworCWNoYXIgb3V0cHV0OworCisJLyogV2FpdCBm
b3IgUlggdG8gYmUgcmVhZHkgKi8KKwl3aGlsZSAoKHNlcmlhbF9pbihiYXNlX2FkZHJlc3MsIFBO
WDhYWFhfRklGTykgJiBQTlg4WFhYX1VBUlRfRklGT19SWEZJRk8pID09IDApCisJCWRvX2RlbGF5
KCk7CisKKwkvKiBHZXQgdGhlIGNoYXJhY3RlciAqLworCW91dHB1dCA9IHNlcmlhbF9pbihiYXNl
X2FkZHJlc3MsIFBOWDhYWFhfRklGTykgJiAweEZGOworCisJLyogTW92ZSBvbnRvIHRoZSBuZXh0
IGNoYXJhY3RlciBpbiB0aGUgYnVmZmVyICovCisJc2VyaWFsX291dChiYXNlX2FkZHJlc3MsIFBO
WDhYWFhfTENSLCBzZXJpYWxfaW4oYmFzZV9hZGRyZXNzLCBQTlg4WFhYX0xDUikgfCBQTlg4WFhY
X1VBUlRfTENSX1JYX05FWFQpOworCXNlcmlhbF9vdXQoYmFzZV9hZGRyZXNzLCBQTlg4WFhYX0lD
TFIsIFBOWDhYWFhfVUFSVF9JTlRfUlgpOworCisJcmV0dXJuIG91dHB1dDsKK30KKworc3RhdGlj
IHZvaWQgc2VyaWFsX2luaXQodW5zaWduZWQgY2hhciAqYmFzZV9hZGRyZXNzKQoreworCXNlcmlh
bF9vdXQoYmFzZV9hZGRyZXNzLCBQTlg4WFhYX0xDUiwgUE5YOFhYWF9VQVJUX0xDUl84QklUIHwg
UE5YOFhYWF9VQVJUX0xDUl9UWF9SU1QgfCBQTlg4WFhYX1VBUlRfTENSX1JYX1JTVCk7CisJc2Vy
aWFsX291dChiYXNlX2FkZHJlc3MsIFBOWDhYWFhfTUNSLCBQTlg4WFhYX1VBUlRfTUNSX0RUUiB8
IFBOWDhYWFhfVUFSVF9NQ1JfUlRTKTsKKwlzZXJpYWxfb3V0KGJhc2VfYWRkcmVzcywgUE5YOFhY
WF9CQVVELCAxKTsgLyogMTE1MjAwIEJhdWQgKi8KKwlzZXJpYWxfb3V0KGJhc2VfYWRkcmVzcywg
UE5YOFhYWF9DRkcsIDB4MDAwNjAwMzApOworCXNlcmlhbF9vdXQoYmFzZV9hZGRyZXNzLCBQTlg4
WFhYX0lDTFIsIC0xKTsKKwlzZXJpYWxfb3V0KGJhc2VfYWRkcmVzcywgUE5YOFhYWF9JRU4sIDAp
OworfQorCitzdGF0aWMgdm9pZCBzZXR1cF9zZXJpYWxfb3V0cHV0KHZvaWQpCit7CisJc3RhdGlj
IGJvb2wgaW5pdGlhbGlzZWQ7CisJaWYgKCFpbml0aWFsaXNlZCkgeworCQlzZXJpYWxfaW5pdChr
Z2RiX3VhcnQpOworCQlzZXJpYWxfaW5pdChjb25zb2xlX3VhcnQpOworCQlpbml0aWFsaXNlZCA9
IHRydWU7CisJfQorfQorCitpbnQgcnNfa2dkYl9ob29rKGludCB0dHlfbm8sIGludCBzcGVlZCkK
K3sKKwlrZ2RiX3VhcnQgICAgPSB0dHlfbm8gPyBVQVJUMSA6IFVBUlQwOworCWNvbnNvbGVfdWFy
dCA9IHR0eV9ubyA/IFVBUlQwIDogVUFSVDE7CisKKwlzZXR1cF9zZXJpYWxfb3V0cHV0KCk7CisK
KwlyZXR1cm4gc3BlZWQ7Cit9CisKK2ludCBwcm9tX3B1dGNoYXIoY2hhciBjKQoreworCXNldHVw
X3NlcmlhbF9vdXRwdXQoKTsKKwlyZXR1cm4gcHV0X2NoYXIoY29uc29sZV91YXJ0LCBjKTsKK30K
KworY2hhciBwcm9tX2dldGNoYXIodm9pZCkKK3sKKwlzZXR1cF9zZXJpYWxfb3V0cHV0KCk7CisJ
cmV0dXJuIGdldF9jaGFyKGNvbnNvbGVfdWFydCk7Cit9CisKK2ludCBwdXRfZGVidWdfY2hhcihj
aGFyIGMpCit7CisJc2V0dXBfc2VyaWFsX291dHB1dCgpOworCXJldHVybiBwdXRfY2hhcihrZ2Ri
X3VhcnQsIGMpOworfQorCitjaGFyIGdldF9kZWJ1Z19jaGFyKHZvaWQpCit7CisJc2V0dXBfc2Vy
aWFsX291dHB1dCgpOworCXJldHVybiBnZXRfY2hhcihrZ2RiX3VhcnQpOworfQpkaWZmIC11ck4g
LS1leGNsdWRlPS5zdm4gbGludXgtMi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMz
eC9jb21tb24vaW50ZXJydXB0cy5jIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4
MzN4L2NvbW1vbi9pbnRlcnJ1cHRzLmMKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21p
cHMvbnhwL3BueDgzM3gvY29tbW9uL2ludGVycnVwdHMuYwkxOTcwLTAxLTAxIDAxOjAwOjAwLjAw
MDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgzM3gv
Y29tbW9uL2ludGVycnVwdHMuYwkyMDA4LTA2LTEyIDEyOjU2OjExLjAwMDAwMDAwMCArMDEwMApA
QCAtMCwwICsxLDM2NSBAQAorLyoKKyAqICBpbnRlcnJ1cHRzLmM6IEludGVycnVwdCBtYXBwaW5n
cyBmb3IgUE5YODMzWC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3Jz
CisgKgkgIENocmlzIFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExh
aXJkIDxkYW5pZWwuai5sYWlyZEBueHAuY29tPgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVi
bGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNp
b24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2
ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQor
ICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNv
ZnR3YXJlCisgKiAgRm91bmRhdGlvbiwgSW5jLiwgNjc1IE1hc3MgQXZlLCBDYW1icmlkZ2UsIE1B
IDAyMTM5LCBVU0EuCisgKi8KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxs
aW51eC9pcnEuaD4KKyNpbmNsdWRlIDxsaW51eC9oYXJkaXJxLmg+CisjaW5jbHVkZSA8bGludXgv
aW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8YXNtL21pcHNyZWdzLmg+CisjaW5jbHVkZSA8YXNtL2ly
cV9jcHUuaD4KKyNpbmNsdWRlIDxpcnEuaD4KKyNpbmNsdWRlIDxpcnEtbWFwcGluZy5oPgorI2lu
Y2x1ZGUgPGdwaW8uaD4KKworc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBpcnFfcHJpb1tQTlg4
MzNYX1BJQ19OVU1fSVJRXSA9Cit7CisgICAgMCwgLyogdW51c2VkICovCisgICAgNCwgLyogUE5Y
ODMzWF9QSUNfSTJDMF9JTlQgICAgICAgICAgICAgICAgIDEgKi8KKyAgICA0LCAvKiBQTlg4MzNY
X1BJQ19JMkMxX0lOVCAgICAgICAgICAgICAgICAgMiAqLworICAgIDEsIC8qIFBOWDgzM1hfUElD
X1VBUlQwX0lOVCAgICAgICAgICAgICAgICAzICovCisgICAgMSwgLyogUE5YODMzWF9QSUNfVUFS
VDFfSU5UICAgICAgICAgICAgICAgIDQgKi8KKyAgICA2LCAvKiBQTlg4MzNYX1BJQ19UU19JTjBf
RFZfSU5UICAgICAgICAgICAgNSAqLworICAgIDYsIC8qIFBOWDgzM1hfUElDX1RTX0lOMF9ETUFf
SU5UICAgICAgICAgICA2ICovCisgICAgNywgLyogUE5YODMzWF9QSUNfR1BJT19JTlQgICAgICAg
ICAgICAgICAgIDcgKi8KKyAgICA0LCAvKiBQTlg4MzNYX1BJQ19BVURJT19ERUNfSU5UICAgICAg
ICAgICAgOCAqLworICAgIDUsIC8qIFBOWDgzM1hfUElDX1ZJREVPX0RFQ19JTlQgICAgICAgICAg
ICA5ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfQ09ORklHX0lOVCAgICAgICAgICAgICAgMTAg
Ki8KKyAgICA0LCAvKiBQTlg4MzNYX1BJQ19BT0lfSU5UICAgICAgICAgICAgICAgICAxMSAqLwor
ICAgIDksIC8qIFBOWDgzM1hfUElDX1NZTkNfSU5UICAgICAgICAgICAgICAgIDEyICovCisgICAg
OSwgLyogUE5YODMzNV9QSUNfU0FUQV9JTlQgICAgICAgICAgICAgICAgMTMgKi8KKyAgICA0LCAv
KiBQTlg4MzNYX1BJQ19PU0RfSU5UICAgICAgICAgICAgICAgICAxNCAqLworICAgIDksIC8qIFBO
WDgzM1hfUElDX0RJU1AxX0lOVCAgICAgICAgICAgICAgIDE1ICovCisgICAgNCwgLyogUE5YODMz
WF9QSUNfREVJTlRFUkxBQ0VSX0lOVCAgICAgICAgMTYgKi8KKyAgICA5LCAvKiBQTlg4MzNYX1BJ
Q19ESVNQTEFZMl9JTlQgICAgICAgICAgICAxNyAqLworICAgIDQsIC8qIFBOWDgzM1hfUElDX1ZD
X0lOVCAgICAgICAgICAgICAgICAgIDE4ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfU0NfSU5U
ICAgICAgICAgICAgICAgICAgMTkgKi8KKyAgICA5LCAvKiBQTlg4MzNYX1BJQ19JREVfSU5UICAg
ICAgICAgICAgICAgICAyMCAqLworICAgIDksIC8qIFBOWDgzM1hfUElDX0lERV9ETUFfSU5UICAg
ICAgICAgICAgIDIxICovCisgICAgNiwgLyogUE5YODMzWF9QSUNfVFNfSU4xX0RWX0lOVCAgICAg
ICAgICAgMjIgKi8KKyAgICA2LCAvKiBQTlg4MzNYX1BJQ19UU19JTjFfRE1BX0lOVCAgICAgICAg
ICAyMyAqLworICAgIDQsIC8qIFBOWDgzM1hfUElDX1NHRFhfRE1BX0lOVCAgICAgICAgICAgIDI0
ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfVFNfT1VUX0lOVCAgICAgICAgICAgICAgMjUgKi8K
KyAgICA0LCAvKiBQTlg4MzNYX1BJQ19JUl9JTlQgICAgICAgICAgICAgICAgICAyNiAqLworICAg
IDMsIC8qIFBOWDgzM1hfUElDX1ZNU1AxX0lOVCAgICAgICAgICAgICAgIDI3ICovCisgICAgMywg
LyogUE5YODMzWF9QSUNfVk1TUDJfSU5UICAgICAgICAgICAgICAgMjggKi8KKyAgICA0LCAvKiBQ
Tlg4MzNYX1BJQ19QSUJDX0lOVCAgICAgICAgICAgICAgICAyOSAqLworICAgIDQsIC8qIFBOWDgz
M1hfUElDX1RTX0lOMF9UUkRfSU5UICAgICAgICAgIDMwICovCisgICAgNCwgLyogUE5YODMzWF9Q
SUNfU0dEWF9UUERfSU5UICAgICAgICAgICAgMzEgKi8KKyAgICA1LCAvKiBQTlg4MzNYX1BJQ19V
U0JfSU5UICAgICAgICAgICAgICAgICAzMiAqLworICAgIDQsIC8qIFBOWDgzM1hfUElDX1RTX0lO
MV9UUkRfSU5UICAgICAgICAgIDMzICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfQ0xPQ0tfSU5U
ICAgICAgICAgICAgICAgMzQgKi8KKyAgICA0LCAvKiBQTlg4MzNYX1BJQ19TR0RYX1BBUlNFUl9J
TlQgICAgICAgICAzNSAqLworICAgIDQsIC8qIFBOWDgzM1hfUElDX1ZNU1BfRE1BX0lOVCAgICAg
ICAgICAgIDM2ICovCisjaWYgZGVmaW5lZChDT05GSUdfU09DX1BOWDgzMzUpCisgICAgNCwgLyog
UE5YODMzNV9QSUNfTUlVX0lOVCAgICAgICAgICAgICAgICAgMzcgKi8KKyAgICA0LCAvKiBQTlg4
MzM1X1BJQ19BVkNISVBfSVJRX0lOVCAgICAgICAgICAzOCAqLworICAgIDksIC8qIFBOWDgzMzVf
UElDX1NZTkNfSERfSU5UICAgICAgICAgICAgIDM5ICovCisgICAgOSwgLyogUE5YODMzNV9QSUNf
RElTUF9IRF9JTlQgICAgICAgICAgICAgNDAgKi8KKyAgICA5LCAvKiBQTlg4MzM1X1BJQ19ESVNQ
X1NDQUxFUl9JTlQgICAgICAgICA0MSAqLworICAgIDQsIC8qIFBOWDgzMzVfUElDX09TRF9IRDFf
SU5UICAgICAgICAgICAgIDQyICovCisgICAgNCwgLyogUE5YODMzNV9QSUNfRFRMX1dSSVRFUl9Z
X0lOVCAgICAgICAgNDMgKi8KKyAgICA0LCAvKiBQTlg4MzM1X1BJQ19EVExfV1JJVEVSX0NfSU5U
ICAgICAgICA0NCAqLworICAgIDQsIC8qIFBOWDgzMzVfUElDX0RUTF9FTVVMQVRPUl9ZX0lSX0lO
VCAgIDQ1ICovCisgICAgNCwgLyogUE5YODMzNV9QSUNfRFRMX0VNVUxBVE9SX0NfSVJfSU5UICAg
NDYgKi8KKyAgICA0LCAvKiBQTlg4MzM1X1BJQ19ERU5DX1RUWF9JTlQgICAgICAgICAgICA0NyAq
LworICAgIDQsIC8qIFBOWDgzMzVfUElDX01NSV9TSUYwX0lOVCAgICAgICAgICAgIDQ4ICovCisg
ICAgNCwgLyogUE5YODMzNV9QSUNfTU1JX1NJRjFfSU5UICAgICAgICAgICAgNDkgKi8KKyAgICA0
LCAvKiBQTlg4MzM1X1BJQ19NTUlfQ0RNTVVfSU5UICAgICAgICAgICA1MCAqLworICAgIDQsIC8q
IFBOWDgzMzVfUElDX1BJQkNTX0lOVCAgICAgICAgICAgICAgIDUxICovCisgICAxMiwgLyogUE5Y
ODMzNV9QSUNfRVRIRVJORVRfSU5UICAgICAgICAgICAgNTIgKi8KKyAgICAzLCAvKiBQTlg4MzM1
X1BJQ19WTVNQMV8wX0lOVCAgICAgICAgICAgICA1MyAqLworICAgIDMsIC8qIFBOWDgzMzVfUElD
X1ZNU1AxXzFfSU5UICAgICAgICAgICAgIDU0ICovCisgICAgNCwgLyogUE5YODMzNV9QSUNfVk1T
UDFfRE1BX0lOVCAgICAgICAgICAgNTUgKi8KKyAgICA0LCAvKiBQTlg4MzM1X1BJQ19UREdSX0RF
X0lOVCAgICAgICAgICAgICA1NiAqLworICAgIDQsIC8qIFBOWDgzMzVfUElDX0lSMV9JUlFfSU5U
ICAgICAgICAgICAgIDU3ICovCisjZW5kaWYKK307CisKK3N0YXRpYyB2b2lkIHBpY19kaXNwYXRj
aCh2b2lkKQoreworCXVuc2lnbmVkIGludCBpcnEgPSBQTlg4MzNYX1JFR0ZJRUxEKFBJQ19JTlRf
U1JDLCBJTlRfU1JDKTsKKworCWlmICgoaXJxID49IDEpICYmIChpcnEgPCAoUE5YODMzWF9QSUNf
TlVNX0lSUSkpKSB7CisJCXVuc2lnbmVkIGxvbmcgcHJpb3JpdHkgPSBQTlg4MzNYX1BJQ19JTlRf
UFJJT1JJVFk7CisJCVBOWDgzM1hfUElDX0lOVF9QUklPUklUWSA9IGlycV9wcmlvW2lycV07CisK
KwkJaWYgKGlycSA9PSBQTlg4MzNYX1BJQ19HUElPX0lOVCkgeworCQkJdW5zaWduZWQgbG9uZyBt
YXNrID0gUE5YODMzWF9QSU9fSU5UX1NUQVRVUyAmIFBOWDgzM1hfUElPX0lOVF9FTkFCTEU7CisJ
CQlpbnQgcGluOworCQkJd2hpbGUgKChwaW4gPSBmZnMobWFzayAmIDB4ZmZmZikpKSB7CisJCQkJ
cGluIC09IDE7CisJCQkJZG9fSVJRKFBOWDgzM1hfR1BJT19JUlFfQkFTRSArIHBpbik7CisJCQkJ
bWFzayAmPSB+KDEgPDwgcGluKTsKKwkJCX0KKwkJfSBlbHNlIHsKKwkJCWRvX0lSUShpcnEgKyBQ
Tlg4MzNYX1BJQ19JUlFfQkFTRSk7CisJCX0KKworCQlQTlg4MzNYX1BJQ19JTlRfUFJJT1JJVFkg
PSBwcmlvcml0eTsKKwl9IGVsc2UgeworCQlwcmludGsoS0VSTl9FUlIgInBsYXRfaXJxX2Rpc3Bh
dGNoOiB1bmV4cGVjdGVkIGlycSAldVxuIiwgaXJxKTsKKwl9Cit9CisKK2FzbWxpbmthZ2Ugdm9p
ZCBwbGF0X2lycV9kaXNwYXRjaCh2b2lkKQoreworCXVuc2lnbmVkIGludCBwZW5kaW5nID0gcmVh
ZF9jMF9zdGF0dXMoKSAmIHJlYWRfYzBfY2F1c2UoKTsKKworCWlmIChwZW5kaW5nICYgU1RBVFVT
Rl9JUDQpCisJCXBpY19kaXNwYXRjaCgpOworCWVsc2UgaWYgKHBlbmRpbmcgJiBTVEFUVVNGX0lQ
NykKKwkJZG9fSVJRKFBOWDgzM1hfVElNRVJfSVJRKTsKKwllbHNlCisJCXNwdXJpb3VzX2ludGVy
cnVwdCgpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcG54ODMzeF9oYXJkX2VuYWJsZV9waWNf
aXJxKHVuc2lnbmVkIGludCBpcnEpCit7CisJLyogQ3VycmVudGx5IHdlIGRvIHRoaXMgYnkgc2V0
dGluZyBJUlEgcHJpb3JpdHkgdG8gMS4KKwkgICBJZiBwcmlvcml0eSBzdXBwb3J0IGlzIGJlaW5n
IGltcGxlbWVudGVkLCAxIHNob3VsZCBiZSByZXBhbGNlZAorCQlieSBhIGJldHRlciB2YWx1ZS4g
Ki8KKwlQTlg4MzNYX1BJQ19JTlRfUkVHKGlycSkgPSBpcnFfcHJpb1tpcnFdOworfQorCitzdGF0
aWMgaW5saW5lIHZvaWQgcG54ODMzeF9oYXJkX2Rpc2FibGVfcGljX2lycSh1bnNpZ25lZCBpbnQg
aXJxKQoreworCS8qIERpc2FibGUgSVJRIGJ5IHdyaXRpbmcgc2V0dGluZyBpdCdzIHByaW9yaXR5
IHRvIDAgKi8KKwlQTlg4MzNYX1BJQ19JTlRfUkVHKGlycSkgPSAwOworfQorCitzdGF0aWMgaW50
IGlycWZsYWdzW1BOWDgzM1hfUElDX05VTV9JUlFdOwkvKiBpbml0aWFsaXplZCBieSB6ZXJvZXMg
Ki8KKyNkZWZpbmUgSVJRRkxBR19TVEFSVEVECQkxCisjZGVmaW5lIElSUUZMQUdfRElTQUJMRUQJ
MgorCitzdGF0aWMgREVGSU5FX1NQSU5MT0NLKHBueDgzM3hfaXJxX2xvY2spOworCitzdGF0aWMg
dW5zaWduZWQgaW50IHBueDgzM3hfc3RhcnR1cF9waWNfaXJxKHVuc2lnbmVkIGludCBpcnEpCit7
CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKwl1bnNpZ25lZCBpbnQgcGljX2lycSA9IGlycSAtIFBO
WDgzM1hfUElDX0lSUV9CQVNFOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJnBueDgzM3hfaXJxX2xv
Y2ssIGZsYWdzKTsKKworCWlycWZsYWdzW3BpY19pcnFdID0gSVJRRkxBR19TVEFSVEVEOwkvKiBz
dGFydGVkLCBub3QgZGlzYWJsZWQgKi8KKwlwbng4MzN4X2hhcmRfZW5hYmxlX3BpY19pcnEocGlj
X2lycSk7CisKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwbng4MzN4X2lycV9sb2NrLCBmbGFn
cyk7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB2b2lkIHBueDgzM3hfc2h1dGRvd25fcGljX2ly
cSh1bnNpZ25lZCBpbnQgaXJxKQoreworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJdW5zaWduZWQg
aW50IHBpY19pcnEgPSBpcnEgLSBQTlg4MzNYX1BJQ19JUlFfQkFTRTsKKworCXNwaW5fbG9ja19p
cnFzYXZlKCZwbng4MzN4X2lycV9sb2NrLCBmbGFncyk7CisKKwlpcnFmbGFnc1twaWNfaXJxXSA9
IDA7CQkJLyogbm90IHN0YXJ0ZWQgKi8KKwlwbng4MzN4X2hhcmRfZGlzYWJsZV9waWNfaXJxKHBp
Y19pcnEpOworCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG54ODMzeF9pcnFfbG9jaywgZmxh
Z3MpOworfQorCitzdGF0aWMgdm9pZCBwbng4MzN4X2VuYWJsZV9waWNfaXJxKHVuc2lnbmVkIGlu
dCBpcnEpCit7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKwl1bnNpZ25lZCBpbnQgcGljX2lycSA9
IGlycSAtIFBOWDgzM1hfUElDX0lSUV9CQVNFOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJnBueDgz
M3hfaXJxX2xvY2ssIGZsYWdzKTsKKworCWlycWZsYWdzW3BpY19pcnFdICY9IH5JUlFGTEFHX0RJ
U0FCTEVEOworCWlmIChpcnFmbGFnc1twaWNfaXJxXSA9PSBJUlFGTEFHX1NUQVJURUQpCisJCXBu
eDgzM3hfaGFyZF9lbmFibGVfcGljX2lycShwaWNfaXJxKTsKKworCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnBueDgzM3hfaXJxX2xvY2ssIGZsYWdzKTsKK30KKworc3RhdGljIHZvaWQgcG54ODMz
eF9kaXNhYmxlX3BpY19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwl1bnNpZ25lZCBsb25nIGZs
YWdzOworCXVuc2lnbmVkIGludCBwaWNfaXJxID0gaXJxIC0gUE5YODMzWF9QSUNfSVJRX0JBU0U7
CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmcG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworCisJaXJx
ZmxhZ3NbcGljX2lycV0gfD0gSVJRRkxBR19ESVNBQkxFRDsKKwlwbng4MzN4X2hhcmRfZGlzYWJs
ZV9waWNfaXJxKHBpY19pcnEpOworCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG54ODMzeF9p
cnFfbG9jaywgZmxhZ3MpOworfQorCitzdGF0aWMgdm9pZCBwbng4MzN4X2Fja19waWNfaXJxKHVu
c2lnbmVkIGludCBpcnEpCit7Cit9CisKK3N0YXRpYyB2b2lkIHBueDgzM3hfZW5kX3BpY19pcnEo
dW5zaWduZWQgaW50IGlycSkKK3sKK30KKworc3RhdGljIERFRklORV9TUElOTE9DSyhwbng4MzN4
X2dwaW9fcG54ODMzeF9pcnFfbG9jayk7CisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgcG54ODMzeF9z
dGFydHVwX2dwaW9faXJxKHVuc2lnbmVkIGludCBpcnEpCit7CisJaW50IHBpbiA9IGlycSAtIFBO
WDgzM1hfR1BJT19JUlFfQkFTRTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCXNwaW5fbG9ja19p
cnFzYXZlKCZwbng4MzN4X2dwaW9fcG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworCXBueDgzM3hf
Z3Bpb19lbmFibGVfaXJxKHBpbik7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG54ODMzeF9n
cGlvX3BueDgzM3hfaXJxX2xvY2ssIGZsYWdzKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZv
aWQgcG54ODMzeF9lbmFibGVfZ3Bpb19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwlpbnQgcGlu
ID0gaXJxIC0gUE5YODMzWF9HUElPX0lSUV9CQVNFOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJ
c3Bpbl9sb2NrX2lycXNhdmUoJnBueDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7
CisJcG54ODMzeF9ncGlvX2VuYWJsZV9pcnEocGluKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZwbng4MzN4X2dwaW9fcG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworfQorCitzdGF0aWMgdm9p
ZCBwbng4MzN4X2Rpc2FibGVfZ3Bpb19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwlpbnQgcGlu
ID0gaXJxIC0gUE5YODMzWF9HUElPX0lSUV9CQVNFOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJ
c3Bpbl9sb2NrX2lycXNhdmUoJnBueDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7
CisJcG54ODMzeF9ncGlvX2Rpc2FibGVfaXJxKHBpbik7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmcG54ODMzeF9ncGlvX3BueDgzM3hfaXJxX2xvY2ssIGZsYWdzKTsKK30KKworc3RhdGljIHZv
aWQgcG54ODMzeF9hY2tfZ3Bpb19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKK30KKworc3RhdGlj
IHZvaWQgcG54ODMzeF9lbmRfZ3Bpb19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwlpbnQgcGlu
ID0gaXJxIC0gUE5YODMzWF9HUElPX0lSUV9CQVNFOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJ
c3Bpbl9sb2NrX2lycXNhdmUoJnBueDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7
CisJcG54ODMzeF9ncGlvX2NsZWFyX2lycShwaW4pOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnBueDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7Cit9CisKK3N0YXRpYyBpbnQg
cG54ODMzeF9zZXRfdHlwZV9ncGlvX2lycSh1bnNpZ25lZCBpbnQgaXJxLCB1bnNpZ25lZCBpbnQg
Zmxvd190eXBlKQoreworCWludCBwaW4gPSBpcnEgLSBQTlg4MzNYX0dQSU9fSVJRX0JBU0U7CisJ
aW50IGdwaW9fbW9kZTsKKworCXN3aXRjaCAoZmxvd190eXBlKSB7CisJY2FzZSBJUlFfVFlQRV9F
REdFX1JJU0lORzoKKwkJZ3Bpb19tb2RlID0gR1BJT19JTlRfRURHRV9SSVNJTkc7CisJCWJyZWFr
OworCWNhc2UgSVJRX1RZUEVfRURHRV9GQUxMSU5HOgorCQlncGlvX21vZGUgPSBHUElPX0lOVF9F
REdFX0ZBTExJTkc7CisJCWJyZWFrOworCWNhc2UgSVJRX1RZUEVfRURHRV9CT1RIOgorCQlncGlv
X21vZGUgPSBHUElPX0lOVF9FREdFX0JPVEg7CisJCWJyZWFrOworCWNhc2UgSVJRX1RZUEVfTEVW
RUxfSElHSDoKKwkJZ3Bpb19tb2RlID0gR1BJT19JTlRfTEVWRUxfSElHSDsKKwkJYnJlYWs7CisJ
Y2FzZSBJUlFfVFlQRV9MRVZFTF9MT1c6CisJCWdwaW9fbW9kZSA9IEdQSU9fSU5UX0xFVkVMX0xP
VzsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJZ3Bpb19tb2RlID0gR1BJT19JTlRfTk9ORTsKKwkJ
YnJlYWs7CisJfQorCisJcG54ODMzeF9ncGlvX3NldHVwX2lycShncGlvX21vZGUsIHBpbik7CisK
KwlyZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBwbng4MzN4X3BpY19pcnFf
dHlwZSA9IHsKKwkudHlwZW5hbWUgPSAiUE5YLVBJQyIsCisJLnN0YXJ0dXAgPSBwbng4MzN4X3N0
YXJ0dXBfcGljX2lycSwKKwkuc2h1dGRvd24gPSBwbng4MzN4X3NodXRkb3duX3BpY19pcnEsCisJ
LmVuYWJsZSA9IHBueDgzM3hfZW5hYmxlX3BpY19pcnEsCisJLmRpc2FibGUgPSBwbng4MzN4X2Rp
c2FibGVfcGljX2lycSwKKwkuYWNrID0gcG54ODMzeF9hY2tfcGljX2lycSwKKwkuZW5kID0gcG54
ODMzeF9lbmRfcGljX2lycQorfTsKKworc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBwbng4MzN4X2dw
aW9faXJxX3R5cGUgPSB7CisJLnR5cGVuYW1lID0gIlBOWC1HUElPIiwKKwkuc3RhcnR1cCA9IHBu
eDgzM3hfc3RhcnR1cF9ncGlvX2lycSwKKwkuc2h1dGRvd24gPSBwbng4MzN4X2Rpc2FibGVfZ3Bp
b19pcnEsCisJLmVuYWJsZSA9IHBueDgzM3hfZW5hYmxlX2dwaW9faXJxLAorCS5kaXNhYmxlID0g
cG54ODMzeF9kaXNhYmxlX2dwaW9faXJxLAorCS5hY2sgPSBwbng4MzN4X2Fja19ncGlvX2lycSwK
KwkuZW5kID0gcG54ODMzeF9lbmRfZ3Bpb19pcnEsCisJLnNldF90eXBlID0gcG54ODMzeF9zZXRf
dHlwZV9ncGlvX2lycQorfTsKKwordm9pZCBfX2luaXQgYXJjaF9pbml0X2lycSh2b2lkKQorewor
CXVuc2lnbmVkIGludCBpcnE7CisKKwkvKiBzZXR1cCBzdGFuZGFyZCBpbnRlcm5hbCBjcHUgaXJx
cyAqLworCW1pcHNfY3B1X2lycV9pbml0KCk7CisKKwkvKiBTZXQgSVJRIGluZm9ybWF0aW9uIGlu
IGlycV9kZXNjICovCisJZm9yIChpcnEgPSBQTlg4MzNYX1BJQ19JUlFfQkFTRTsgaXJxIDwgKFBO
WDgzM1hfUElDX0lSUV9CQVNFICsgUE5YODMzWF9QSUNfTlVNX0lSUSk7IGlycSsrKSB7CisJCXBu
eDgzM3hfaGFyZF9kaXNhYmxlX3BpY19pcnEoaXJxKTsKKwkJc2V0X2lycV9jaGlwX2FuZF9oYW5k
bGVyKGlycSwgJnBueDgzM3hfcGljX2lycV90eXBlLCBoYW5kbGVfc2ltcGxlX2lycSk7CisJfQor
CisJZm9yIChpcnEgPSBQTlg4MzNYX0dQSU9fSVJRX0JBU0U7IGlycSA8IChQTlg4MzNYX0dQSU9f
SVJRX0JBU0UgKyBQTlg4MzNYX0dQSU9fTlVNX0lSUSk7IGlycSsrKQorCQlzZXRfaXJxX2NoaXBf
YW5kX2hhbmRsZXIoaXJxLCAmcG54ODMzeF9ncGlvX2lycV90eXBlLCBoYW5kbGVfc2ltcGxlX2ly
cSk7CisKKwkvKiBTZXQgUElDIHByaW9yaXR5IGxpbWl0ZXIgcmVnaXN0ZXIgdG8gMCAqLworCVBO
WDgzM1hfUElDX0lOVF9QUklPUklUWSA9IDA7CisKKwkvKiBTZXR1cCBHUElPIElSUSBkaXNwYXRj
aGluZyAqLworCXBueDgzM3hfc3RhcnR1cF9waWNfaXJxKFBOWDgzM1hfUElDX0dQSU9fSU5UKTsK
KworCS8qIEVuYWJsZSBQSUMgSVJRcyAoSFdJUlEyKSAqLworCWlmIChjcHVfaGFzX3ZpbnQpCisJ
CXNldF92aV9oYW5kbGVyKDQsIHBpY19kaXNwYXRjaCk7CisKKwl3cml0ZV9jMF9zdGF0dXMocmVh
ZF9jMF9zdGF0dXMoKSB8IElFX0lSUTIpOworfQorCisKK3ZvaWQgX19pbml0IHBsYXRfdGltZV9p
bml0KHZvaWQpCit7CisJLyogY2FsY3VsYXRlIG1pcHNfaHB0X2ZyZXF1ZW5jeSBiYXNlZCBvbiBQ
Tlg4MzNYX0NMT0NLX0NQVUNQX0NUTCByZWcgKi8KKworCWV4dGVybiB1bnNpZ25lZCBsb25nIG1p
cHNfaHB0X2ZyZXF1ZW5jeTsKKwl1bnNpZ25lZCBsb25nIHJlZyA9IFBOWDgzM1hfQ0xPQ0tfQ1BV
Q1BfQ1RMOworCisJaWYgKCEoUE5YODMzWF9CSVQocmVnLCBDTE9DS19DUFVDUF9DVEwsIEVYSVRf
UkVTRVQpKSkgeworCQkvKiBGdW5jdGlvbmFsIGNsb2NrIGlzIGRpc2FibGVkIHNvIHVzZSBjcnlz
dGFsIGZyZXF1ZW5jeSAqLworCQltaXBzX2hwdF9mcmVxdWVuY3kgPSAyNTsKKwl9IGVsc2Ugewor
I2lmIGRlZmluZWQoQ09ORklHX1NPQ19QTlg4MzM1KQorCQkvKiBGdW5jdGlvbmFsIGNsb2NrIGlz
IGVuYWJsZWQsIHNvIGdldCBjbG9jayBtdWx0aXBsaWVyICovCisJCW1pcHNfaHB0X2ZyZXF1ZW5j
eSA9IDkwICsgKDEwICogUE5YODMzNV9SRUdGSUVMRChDTE9DS19QTExfQ1BVX0NUTCwgRlJFUSkp
OworI2Vsc2UKKwkJc3RhdGljIGNvbnN0IHVuc2lnbmVkIGxvbmcgaW50IGZyZXFbNF0gPSB7MjQw
LCAxNjAsIDEyMCwgODB9OworCQltaXBzX2hwdF9mcmVxdWVuY3kgPSBmcmVxW1BOWDgzM1hfRklF
TEQocmVnLCBDTE9DS19DUFVDUF9DVEwsIERJVl9DTE9DSyldOworI2VuZGlmCisJfQorCisJcHJp
bnRrKEtFUk5fSU5GTyAiQ1BVIGNsb2NrIGlzICVsZCBNSHpcbiIsIG1pcHNfaHB0X2ZyZXF1ZW5j
eSk7CisKKwltaXBzX2hwdF9mcmVxdWVuY3kgKj0gNTAwMDAwOworfQorCmRpZmYgLXVyTiAtLWV4
Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L2Nv
bW1vbi9NYWtlZmlsZSBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21t
b24vTWFrZWZpbGUKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgz
M3gvY29tbW9uL01ha2VmaWxlCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisr
KyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vTWFrZWZpbGUJ
MjAwOC0wMy0wMyAxMzowOTozMC4wMDAwMDAwMDAgKzAwMDAKQEAgLTAsMCArMSBAQAorb2JqLXkg
Oj0gaW50ZXJydXB0cy5vIHBsYXRmb3JtLm8gcHJvbS5vIHNldHVwLm8gcmVzZXQubyBnZGJfaG9v
ay5vCmRpZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9t
aXBzL254cC9wbng4MzN4L2NvbW1vbi9wbGF0Zm9ybS5jIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9t
aXBzL254cC9wbng4MzN4L2NvbW1vbi9wbGF0Zm9ybS5jCi0tLSBsaW51eC0yLjYuMjYtcmM0Lm9y
aWcvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9wbGF0Zm9ybS5jCTE5NzAtMDEtMDEgMDE6
MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAv
cG54ODMzeC9jb21tb24vcGxhdGZvcm0uYwkyMDA4LTA2LTEyIDEzOjA4OjA3LjAwMDAwMDAwMCAr
MDEwMApAQCAtMCwwICsxLDMwNiBAQAorLyoKKyAqICBwbGF0Zm9ybS5jOiBwbGF0Zm9ybSBzdXBw
b3J0IGZvciBQTlg4MzNYLgorICoKKyAqICBDb3B5cmlnaHQgMjAwOCBOWFAgU2VtaWNvbmR1Y3Rv
cnMKKyAqCSAgQ2hyaXMgU3RlZWwgPGNocmlzLnN0ZWVsQG54cC5jb20+CisgKiAgICBEYW5pZWwg
TGFpcmQgPGRhbmllbC5qLmxhaXJkQG54cC5jb20+CisgKgorICogIEJhc2VkIG9uIHNvZnR3YXJl
IHdyaXR0ZW4gYnk6CisgKiAgICAgIE5pa2l0YSBZb3VzaGNoZW5rbyA8eW91c2hAZGViaWFuLm9y
Zz4sIGJhc2VkIG9uIFBOWDg1NTAgY29kZS4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9u
IDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVy
c2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAq
ICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0
d2FyZQorICogIEZvdW5kYXRpb24sIEluYy4sIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAw
MjEzOSwgVVNBLgorICovCisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVk
ZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L3Jlc291cmNlLmg+CisjaW5jbHVkZSA8
bGludXgvc2VyaWFsLmg+CisjaW5jbHVkZSA8bGludXgvc2VyaWFsX3BueDh4eHguaD4KKyNpbmNs
dWRlIDxsaW51eC9pMmMtcG54MDEwNS5oPgorI2luY2x1ZGUgPGxpbnV4L210ZC9uYW5kLmg+Cisj
aW5jbHVkZSA8bGludXgvbXRkL3BhcnRpdGlvbnMuaD4KKworI2luY2x1ZGUgPGlycS5oPgorI2lu
Y2x1ZGUgPGlycS1tYXBwaW5nLmg+CisjaW5jbHVkZSA8cG54ODMzeC5oPgorCitzdGF0aWMgdTY0
IHVhcnRfZG1hbWFzayAgICAgPSB+KHUzMikwOworCitzdGF0aWMgc3RydWN0IHJlc291cmNlIHBu
eDgzM3hfdWFydF9yZXNvdXJjZXNbXSA9IHsKKwlbMF0gPSB7CisJCS5zdGFydAkJPSBQTlg4MzNY
X1VBUlQwX1BPUlRTX1NUQVJULAorCQkuZW5kCQk9IFBOWDgzM1hfVUFSVDBfUE9SVFNfRU5ELAor
CQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9NRU0sCisJfSwKKwlbMV0gPSB7CisJCS5zdGFydAkJPSBQ
Tlg4MzNYX1BJQ19VQVJUMF9JTlQsCisJCS5lbmQJCT0gUE5YODMzWF9QSUNfVUFSVDBfSU5ULAor
CQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCisJfSwKKwlbMl0gPSB7CisJCS5zdGFydAkJPSBQ
Tlg4MzNYX1VBUlQxX1BPUlRTX1NUQVJULAorCQkuZW5kCQk9IFBOWDgzM1hfVUFSVDFfUE9SVFNf
RU5ELAorCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9NRU0sCisJfSwKKwlbM10gPSB7CisJCS5zdGFy
dAkJPSBQTlg4MzNYX1BJQ19VQVJUMV9JTlQsCisJCS5lbmQJCT0gUE5YODMzWF9QSUNfVUFSVDFf
SU5ULAorCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisKK3N0cnVjdCBwbng4
eHh4X3BvcnQgcG54OHh4eF9wb3J0c1tdID0geworCVswXSA9IHsKKwkJLnBvcnQgICA9IHsKKwkJ
CS50eXBlCQk9IFBPUlRfUE5YOFhYWCwKKwkJCS5pb3R5cGUJCT0gVVBJT19NRU0sCisJCQkubWVt
YmFzZQk9ICh2b2lkIF9faW9tZW0gKilQTlg4MzNYX1VBUlQwX1BPUlRTX1NUQVJULAorCQkJLm1h
cGJhc2UJPSBQTlg4MzNYX1VBUlQwX1BPUlRTX1NUQVJULAorCQkJLmlycQkJPSBQTlg4MzNYX1BJ
Q19VQVJUMF9JTlQsCisJCQkudWFydGNsawk9IDM2OTIzMDAsCisJCQkuZmlmb3NpemUJPSAxNiwK
KwkJCS5mbGFncwkJPSBVUEZfQk9PVF9BVVRPQ09ORiwKKwkJCS5saW5lCQk9IDAsCisJCX0sCisJ
fSwKKwlbMV0gPSB7CisJCS5wb3J0ICAgPSB7CisJCQkudHlwZQkJPSBQT1JUX1BOWDhYWFgsCisJ
CQkuaW90eXBlCQk9IFVQSU9fTUVNLAorCQkJLm1lbWJhc2UJPSAodm9pZCBfX2lvbWVtICopUE5Y
ODMzWF9VQVJUMV9QT1JUU19TVEFSVCwKKwkJCS5tYXBiYXNlCT0gUE5YODMzWF9VQVJUMV9QT1JU
U19TVEFSVCwKKwkJCS5pcnEJCT0gUE5YODMzWF9QSUNfVUFSVDFfSU5ULAorCQkJLnVhcnRjbGsJ
PSAzNjkyMzAwLAorCQkJLmZpZm9zaXplCT0gMTYsCisJCQkuZmxhZ3MJCT0gVVBGX0JPT1RfQVVU
T0NPTkYsCisJCQkubGluZQkJPSAxLAorCQl9LAorCX0sCit9OworCitzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RldmljZSBwbng4MzN4X3VhcnRfZGV2aWNlID0geworCS5uYW1lCQk9ICJwbng4eHh4
LXVhcnQiLAorCS5pZAkJPSAtMSwKKwkuZGV2ID0geworCQkuZG1hX21hc2sJCT0gJnVhcnRfZG1h
bWFzaywKKwkJLmNvaGVyZW50X2RtYV9tYXNrCT0gMHhmZmZmZmZmZiwKKwkJLnBsYXRmb3JtX2Rh
dGEJCT0gcG54OHh4eF9wb3J0cywKKwl9LAorCS5udW1fcmVzb3VyY2VzCT0gQVJSQVlfU0laRShw
bng4MzN4X3VhcnRfcmVzb3VyY2VzKSwKKwkucmVzb3VyY2UJPSBwbng4MzN4X3VhcnRfcmVzb3Vy
Y2VzLAorfTsKKworc3RhdGljIHU2NCBlaGNpX2RtYW1hc2sgICAgID0gfih1MzIpMDsKKworc3Rh
dGljIHN0cnVjdCByZXNvdXJjZSBwbng4MzN4X3VzYl9laGNpX3Jlc291cmNlc1tdID0geworCVsw
XSA9IHsKKwkJLnN0YXJ0CQk9IFBOWDgzM1hfVVNCX1BPUlRTX1NUQVJULAorCQkuZW5kCQk9IFBO
WDgzM1hfVVNCX1BPUlRTX0VORCwKKwkJLmZsYWdzCQk9IElPUkVTT1VSQ0VfTUVNLAorCX0sCisJ
WzFdID0geworCQkuc3RhcnQJCT0gUE5YODMzWF9QSUNfVVNCX0lOVCwKKwkJLmVuZAkJPSBQTlg4
MzNYX1BJQ19VU0JfSU5ULAorCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisK
K3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIHBueDgzM3hfdXNiX2VoY2lfZGV2aWNlID0g
eworCS5uYW1lCQk9ICJwbng4MzN4LWVoY2kiLAorCS5pZAkJPSAtMSwKKwkuZGV2ID0geworCQku
ZG1hX21hc2sJCT0gJmVoY2lfZG1hbWFzaywKKwkJLmNvaGVyZW50X2RtYV9tYXNrCT0gMHhmZmZm
ZmZmZiwKKwl9LAorCS5udW1fcmVzb3VyY2VzCT0gQVJSQVlfU0laRShwbng4MzN4X3VzYl9laGNp
X3Jlc291cmNlcyksCisJLnJlc291cmNlCT0gcG54ODMzeF91c2JfZWhjaV9yZXNvdXJjZXMsCit9
OworCitzdGF0aWMgc3RydWN0IHJlc291cmNlIHBueDgzM3hfaTJjMF9yZXNvdXJjZXNbXSA9IHsK
Kwl7CisJCS5zdGFydAkJPSBQTlg4MzNYX0kyQzBfUE9SVFNfU1RBUlQsCisJCS5lbmQJCT0gUE5Y
ODMzWF9JMkMwX1BPUlRTX0VORCwKKwkJLmZsYWdzCQk9IElPUkVTT1VSQ0VfTUVNLAorCX0sCisJ
eworCQkuc3RhcnQJCT0gUE5YODMzWF9QSUNfSTJDMF9JTlQsCisJCS5lbmQJCT0gUE5YODMzWF9Q
SUNfSTJDMF9JTlQsCisJCS5mbGFncwkJPSBJT1JFU09VUkNFX0lSUSwKKwl9LAorfTsKKworc3Rh
dGljIHN0cnVjdCByZXNvdXJjZSBwbng4MzN4X2kyYzFfcmVzb3VyY2VzW10gPSB7CisJeworCQku
c3RhcnQJCT0gUE5YODMzWF9JMkMxX1BPUlRTX1NUQVJULAorCQkuZW5kCQk9IFBOWDgzM1hfSTJD
MV9QT1JUU19FTkQsCisJCS5mbGFncwkJPSBJT1JFU09VUkNFX01FTSwKKwl9LAorCXsKKwkJLnN0
YXJ0CQk9IFBOWDgzM1hfUElDX0kyQzFfSU5ULAorCQkuZW5kCQk9IFBOWDgzM1hfUElDX0kyQzFf
SU5ULAorCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisKK3N0YXRpYyBzdHJ1
Y3QgaTJjX3BueDAxMDVfZGV2IHBueDgzM3hfaTJjX2RldltdID0geworCXsKKwkJLmJhc2UgPSBQ
Tlg4MzNYX0kyQzBfUE9SVFNfU1RBUlQsCisJCS5pcnEgPSAtMSwgLyogc2hvdWxkIGJlIFBOWDgz
M1hfUElDX0kyQzBfSU5UIGJ1dCBwb2xsaW5nIGlzIGZhc3RlciAqLworCQkuY2xvY2sgPSA2LAkv
KiAwID09IDQwMCBrSHosIDQgPT0gMTAwIGtIeihNYXhpbXVtIEhETUkpLCA2ID0gNTBrSHooUHJl
ZmVyZWQgSERDUCkgKi8KKwkJLmJ1c19hZGRyID0gMCwJLyogbm8gc2xhdmUgc3VwcG9ydCAqLwor
CX0sCisJeworCQkuYmFzZSA9IFBOWDgzM1hfSTJDMV9QT1JUU19TVEFSVCwKKwkJLmlycSA9IC0x
LAkvKiBvbiBoaWdoIGZyZXEsIHBvbGxpbmcgaXMgZmFzdGVyICovCisJCS8qLmlycSA9IFBOWDgz
M1hfUElDX0kyQzFfSU5ULCovCisJCS5jbG9jayA9IDQsCS8qIDAgPT0gNDAwIGtIeiwgNCA9PSAx
MDAga0h6LiAxMDAga0h6IHNlZW1zIGEgc2FmZSBkZWZhdWx0IGZvciBub3cgKi8KKwkJLmJ1c19h
ZGRyID0gMCwJLyogbm8gc2xhdmUgc3VwcG9ydCAqLworCX0sCit9OworCitzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RldmljZSBwbng4MzN4X2kyYzBfZGV2aWNlID0geworCS5uYW1lCQk9ICJpMmMt
cG54MDEwNSIsCisJLmlkCQk9IDAsCisJLmRldiA9IHsKKwkJLnBsYXRmb3JtX2RhdGEgPSAmcG54
ODMzeF9pMmNfZGV2WzBdLAorCX0sCisJLm51bV9yZXNvdXJjZXMgID0gQVJSQVlfU0laRShwbng4
MzN4X2kyYzBfcmVzb3VyY2VzKSwKKwkucmVzb3VyY2UJPSBwbng4MzN4X2kyYzBfcmVzb3VyY2Vz
LAorfTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgcG54ODMzeF9pMmMxX2Rldmlj
ZSA9IHsKKwkubmFtZQkJPSAiaTJjLXBueDAxMDUiLAorCS5pZAkJPSAxLAorCS5kZXYgPSB7CisJ
CS5wbGF0Zm9ybV9kYXRhID0gJnBueDgzM3hfaTJjX2RldlsxXSwKKwl9LAorCS5udW1fcmVzb3Vy
Y2VzICA9IEFSUkFZX1NJWkUocG54ODMzeF9pMmMxX3Jlc291cmNlcyksCisJLnJlc291cmNlCT0g
cG54ODMzeF9pMmMxX3Jlc291cmNlcywKK307CisKK3N0YXRpYyB1NjQgZXRoZXJuZXRfZG1hbWFz
ayA9IH4odTMyKTA7CisKK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgcG54ODMzeF9ldGhlcm5ldF9y
ZXNvdXJjZXNbXSA9IHsKKwlbMF0gPSB7CisJCS5zdGFydCA9IFBOWDgzMzVfSVAzOTAyX1BPUlRT
X1NUQVJULAorCQkuZW5kICAgPSBQTlg4MzM1X0lQMzkwMl9QT1JUU19FTkQsCisJCS5mbGFncyA9
IElPUkVTT1VSQ0VfTUVNLAorCX0sCisJWzFdID0geworCQkuc3RhcnQgPSBQTlg4MzM1X1BJQ19F
VEhFUk5FVF9JTlQsCisJCS5lbmQgICA9IFBOWDgzMzVfUElDX0VUSEVSTkVUX0lOVCwKKwkJLmZs
YWdzID0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlIHBueDgzM3hfZXRoZXJuZXRfZGV2aWNlID0geworCS5uYW1lID0gImlwMzkwMi1ldGgi
LAorCS5pZCAgID0gLTEsCisJLmRldiAgPSB7CisJCS5kbWFfbWFzayAgICAgICAgICA9ICZldGhl
cm5ldF9kbWFtYXNrLAorCQkuY29oZXJlbnRfZG1hX21hc2sgPSAweGZmZmZmZmZmLAorCX0sCisJ
Lm51bV9yZXNvdXJjZXMgPSBBUlJBWV9TSVpFKHBueDgzM3hfZXRoZXJuZXRfcmVzb3VyY2VzKSwK
KwkucmVzb3VyY2UgICAgICA9IHBueDgzM3hfZXRoZXJuZXRfcmVzb3VyY2VzLAorfTsKKworc3Rh
dGljIHN0cnVjdCByZXNvdXJjZSBwbng4MzN4X3NhdGFfcmVzb3VyY2VzW10gPSB7CisJWzBdID0g
eworCQkuc3RhcnQgPSBQTlg4MzM1X1NBVEFfUE9SVFNfU1RBUlQsCisJCS5lbmQgICA9IFBOWDgz
MzVfU0FUQV9QT1JUU19FTkQsCisJCS5mbGFncyA9IElPUkVTT1VSQ0VfTUVNLAorCX0sCisJWzFd
ID0geworCQkuc3RhcnQgPSBQTlg4MzM1X1BJQ19TQVRBX0lOVCwKKwkJLmVuZCAgID0gUE5YODMz
NV9QSUNfU0FUQV9JTlQsCisJCS5mbGFncyA9IElPUkVTT1VSQ0VfSVJRLAorCX0sCit9OworCitz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBwbng4MzN4X3NhdGFfZGV2aWNlID0geworCS5u
YW1lICAgICAgICAgID0gInBueDgzM3gtc2F0YSIsCisJLmlkICAgICAgICAgICAgPSAtMSwKKwku
bnVtX3Jlc291cmNlcyA9IEFSUkFZX1NJWkUocG54ODMzeF9zYXRhX3Jlc291cmNlcyksCisJLnJl
c291cmNlICAgICAgPSBwbng4MzN4X3NhdGFfcmVzb3VyY2VzLAorfTsKKworc3RhdGljIGNvbnN0
IGNoYXIgKnBhcnRfcHJvYmVzW10gPSB7ICJjbWRsaW5lcGFydCIsIDAgfTsKKworc3RhdGljIHZv
aWQKK3BueDgzM3hfZmxhc2hfbmFuZF9jbWRfY3RybChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50
IGNtZCwgdW5zaWduZWQgaW50IGN0cmwpCit7CisJc3RydWN0IG5hbmRfY2hpcCAqdGhpcyA9IG10
ZC0+cHJpdjsKKwl1bnNpZ25lZCBsb25nIG5hbmRhZGRyID0gKHVuc2lnbmVkIGxvbmcpdGhpcy0+
SU9fQUREUl9XOworCisJaWYgKGNtZCA9PSBOQU5EX0NNRF9OT05FKQorCQlyZXR1cm47CisKKwlp
ZiAoY3RybCAmIE5BTkRfQ0xFKQorCQl3cml0ZWIoY21kLCAodm9pZCBfX2lvbWVtICopKG5hbmRh
ZGRyICsgUE5YODMzNV9OQU5EX0NMRV9NQVNLKSk7CisJZWxzZQorCQl3cml0ZWIoY21kLCAodm9p
ZCBfX2lvbWVtICopIChuYW5kYWRkciArIFBOWDgzMzVfTkFORF9BTEVfTUFTSykpOworfQorCitz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX25hbmRfZGF0YSBwbng4MzN4X2ZsYXNoX25hbmRfZGF0YSA9
IHsKKwkuY2hpcCA9IHsKKwkJLmNoaXBfZGVsYXkJCT0gMjUsCisJCS5wYXJ0X3Byb2JlX3R5cGVz
IAk9IHBhcnRfcHJvYmVzLAorCX0sCisJLmN0cmwgPSB7CisJCS5jbWRfY3RybCAJCT0gcG54ODMz
eF9mbGFzaF9uYW5kX2NtZF9jdHJsCisJfQorfTsKKworLyoKKyAqIFNldCBzdGFydCB0byBiZSB0
aGUgY29ycmVjdCBhZGRyZXNzIChQTlg4MzM1X05BTkRfQkFTRSB3aXRoIG5vIDB4YiEhKSwKKyAq
IDEyIGJ5dGVzIG1vcmUgc2VlbXMgdG8gYmUgdGhlIHN0YW5kYXJkIHRoYXQgYWxsb3dzIGZvciBO
QU5EIGFjY2Vzcy4KKyAqLworc3RhdGljIHN0cnVjdCByZXNvdXJjZSBwbng4MzN4X2ZsYXNoX25h
bmRfcmVzb3VyY2UgPSB7CisJLnN0YXJ0IAk9IFBOWDgzMzVfTkFORF9CQVNFLAorCS5lbmQgCT0g
UE5YODMzNV9OQU5EX0JBU0UgKyAxMiwKKwkuZmxhZ3MgCT0gSU9SRVNPVVJDRV9NRU0sCit9Owor
CitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBwbng4MzN4X2ZsYXNoX25hbmQgPSB7CisJ
Lm5hbWUJICAgICAgICA9ICJnZW5fbmFuZCIsCisJLmlkCQkgICAgICAgID0gLTEsCisJLm51bV9y
ZXNvdXJjZXMJPSAxLAorCS5yZXNvdXJjZQkgICAgPSAmcG54ODMzeF9mbGFzaF9uYW5kX3Jlc291
cmNlLAorCS5kZXYgICAgICAgICAgICA9IHsKKwkJLnBsYXRmb3JtX2RhdGEgPSAmcG54ODMzeF9m
bGFzaF9uYW5kX2RhdGEsCisJfSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwbng4MzN4X3BsYXRmb3JtX2RldmljZXNbXSBfX2luaXRkYXRhID0geworCSZwbng4MzN4X3Vh
cnRfZGV2aWNlLAorCSZwbng4MzN4X3VzYl9laGNpX2RldmljZSwKKwkmcG54ODMzeF9pMmMwX2Rl
dmljZSwKKwkmcG54ODMzeF9pMmMxX2RldmljZSwKKwkmcG54ODMzeF9ldGhlcm5ldF9kZXZpY2Us
CisJJnBueDgzM3hfc2F0YV9kZXZpY2UsCisJJnBueDgzM3hfZmxhc2hfbmFuZCwKK307CisKK3N0
YXRpYyBpbnQgX19pbml0IHBueDgzM3hfcGxhdGZvcm1faW5pdCh2b2lkKQoreworCWludCByZXM7
CisKKwlyZXMgPSBwbGF0Zm9ybV9hZGRfZGV2aWNlcyhwbng4MzN4X3BsYXRmb3JtX2RldmljZXMs
CisJCQkJCQkJICAgQVJSQVlfU0laRShwbng4MzN4X3BsYXRmb3JtX2RldmljZXMpKTsKKwlyZXR1
cm4gcmVzOworfQorCithcmNoX2luaXRjYWxsKHBueDgzM3hfcGxhdGZvcm1faW5pdCk7CmRpZmYg
LXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9w
bng4MzN4L2NvbW1vbi9wcm9tLmMgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgz
M3gvY29tbW9uL3Byb20uYwotLS0gbGludXgtMi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAv
cG54ODMzeC9jb21tb24vcHJvbS5jCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAw
CisrKyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vcHJvbS5j
CTIwMDgtMDYtMDYgMTE6Mjk6NTUuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsNzAgQEAKKy8q
CisgKiAgcHJvbS5jOgorICoKKyAqICBDb3B5cmlnaHQgMjAwOCBOWFAgU2VtaWNvbmR1Y3RvcnMK
KyAqCSAgQ2hyaXMgU3RlZWwgPGNocmlzLnN0ZWVsQG54cC5jb20+CisgKiAgICBEYW5pZWwgTGFp
cmQgPGRhbmllbC5qLmxhaXJkQG54cC5jb20+CisgKgorICogIEJhc2VkIG9uIHNvZnR3YXJlIHdy
aXR0ZW4gYnk6CisgKiAgICAgIE5pa2l0YSBZb3VzaGNoZW5rbyA8eW91c2hAZGViaWFuLm9yZz4s
IGJhc2VkIG9uIFBOWDg1NTAgY29kZS4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIg
b2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lv
bi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQg
aXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0
IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklU
TkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZl
IHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBh
bG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2Fy
ZQorICogIEZvdW5kYXRpb24sIEluYy4sIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEz
OSwgVVNBLgorICovCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGFzbS9ib290
aW5mby5oPgorI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPgorCit2b2lkIF9faW5pdCBwcm9tX2lu
aXRfY21kbGluZSh2b2lkKQoreworCWludCBhcmdjID0gZndfYXJnMDsKKwljaGFyICoqYXJndiA9
IChjaGFyICoqKWZ3X2FyZzE7CisJY2hhciAqYyA9ICYoYXJjc19jbWRsaW5lWzBdKTsKKwlpbnQg
aTsKKworCWZvciAoaSA9IDE7IGkgPCBhcmdjOyBpKyspIHsKKwkJc3RyY3B5KGMsIGFyZ3ZbaV0p
OworCQljICs9IHN0cmxlbihhcmd2W2ldKTsKKwkJaWYgKGkgPCBhcmdjLTEpCisJCQkqYysrID0g
JyAnOworCX0KKwkqYyA9IDA7Cit9CisKK2NoYXIgX19pbml0ICpwcm9tX2dldGVudihjaGFyICpl
bnZuYW1lKQoreworCWV4dGVybiBjaGFyICoqcHJvbV9lbnZwOworCWNoYXIgKiplbnYgPSBwcm9t
X2VudnA7CisJaW50IGk7CisKKwlpID0gc3RybGVuKGVudm5hbWUpOworCisJd2hpbGUgKCplbnYp
IHsKKwkJaWYgKHN0cm5jbXAoZW52bmFtZSwgKmVudiwgaSkgPT0gMCAmJiAqKCplbnYraSkgPT0g
Jz0nKQorCQkJcmV0dXJuICplbnYgKyBpICsgMTsKKwkJZW52Kys7CisJfQorCisJcmV0dXJuIDA7
Cit9CisKK3ZvaWQgX19pbml0IHByb21fZnJlZV9wcm9tX21lbW9yeSh2b2lkKQoreworfQorCitj
aGFyICogX19pbml0IHByb21fZ2V0Y21kbGluZSh2b2lkKQoreworCXJldHVybiBhcmNzX2NtZGxp
bmU7Cit9CisKZGlmZiAtdXJOIC0tZXhjbHVkZT0uc3ZuIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9h
cmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL3Jlc2V0LmMgbGludXgtMi42LjI2LXJjNC9hcmNo
L21pcHMvbnhwL3BueDgzM3gvY29tbW9uL3Jlc2V0LmMKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3Jp
Zy9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL3Jlc2V0LmMJMTk3MC0wMS0wMSAwMTowMDow
MC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4
MzN4L2NvbW1vbi9yZXNldC5jCTIwMDgtMDYtMTIgMTI6MDE6MjMuMDAwMDAwMDAwICswMTAwCkBA
IC0wLDAgKzEsNDUgQEAKKy8qCisgKiAgcmVzZXQuYzogcmVzZXQgc3VwcG9ydCBmb3IgUE5YODMz
WC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENocmlz
IFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwu
ai5sYWlyZEBueHAuY29tPgorICoKKyAqICBCYXNlZCBvbiBzb2Z0d2FyZSB3cml0dGVuIGJ5Ogor
ICogICAgICBOaWtpdGEgWW91c2hjaGVua28gPHlvdXNoQGRlYmlhbi5vcmc+LCBiYXNlZCBvbiBQ
Tlg4NTUwIGNvZGUuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICog
IFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBh
IGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0
aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqICBGb3Vu
ZGF0aW9uLCBJbmMuLCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4KKyAq
LworI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4KKyNp
bmNsdWRlIDxwbng4MzN4Lmg+CisKK3ZvaWQgcG54ODMzeF9tYWNoaW5lX3Jlc3RhcnQoY2hhciAq
Y29tbWFuZCkKK3sKKwlQTlg4MzNYX1JFU0VUX0NPTlRST0xfMiA9IDA7CisJUE5YODMzWF9SRVNF
VF9DT05UUk9MID0gMDsKK30KKwordm9pZCBwbng4MzN4X21hY2hpbmVfaGFsdCh2b2lkKQorewor
CXdoaWxlICgxKQorCQlfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIndhaXQiKTsKKworfQorCit2b2lk
IHBueDgzM3hfbWFjaGluZV9wb3dlcl9vZmYodm9pZCkKK3sKKwlwbng4MzN4X21hY2hpbmVfaGFs
dCgpOworfQpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGludXgtMi42LjI2LXJjNC5vcmlnL2Fy
Y2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vc2V0dXAuYyBsaW51eC0yLjYuMjYtcmM0L2FyY2gv
bWlwcy9ueHAvcG54ODMzeC9jb21tb24vc2V0dXAuYwotLS0gbGludXgtMi42LjI2LXJjNC5vcmln
L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vc2V0dXAuYwkxOTcwLTAxLTAxIDAxOjAwOjAw
LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgz
M3gvY29tbW9uL3NldHVwLmMJMjAwOC0wNi0wNiAxMTozMDoxNi4wMDAwMDAwMDAgKzAxMDAKQEAg
LTAsMCArMSw2NCBAQAorLyoKKyAqICBzZXR1cC5jOiBTZXR1cCBQTlg4MzNYIFNvYy4KKyAqCisg
KiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENocmlzIFN0ZWVsIDxj
aHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwuai5sYWlyZEBu
eHAuY29tPgorICoKKyAqICBCYXNlZCBvbiBzb2Z0d2FyZSB3cml0dGVuIGJ5OgorICogICAgICBO
aWtpdGEgWW91c2hjaGVua28gPHlvdXNoQGRlYmlhbi5vcmc+LCBiYXNlZCBvbiBQTlg4NTUwIGNv
ZGUuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgor
ICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAor
ICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dy
YW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqICBGb3VuZGF0aW9uLCBJ
bmMuLCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4KKyAqLworI2luY2x1
ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KKyNpbmNsdWRl
IDxsaW51eC9pb3BvcnQuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorI2luY2x1ZGUgPGxpbnV4
L3BjaS5oPgorI2luY2x1ZGUgPGFzbS9yZWJvb3QuaD4KKyNpbmNsdWRlIDxwbng4MzN4Lmg+Cisj
aW5jbHVkZSA8Z3Bpby5oPgorCitleHRlcm4gdm9pZCBwbng4MzN4X2JvYXJkX3NldHVwKHZvaWQp
OworZXh0ZXJuIHZvaWQgcG54ODMzeF9tYWNoaW5lX3Jlc3RhcnQoY2hhciAqKTsKK2V4dGVybiB2
b2lkIHBueDgzM3hfbWFjaGluZV9oYWx0KHZvaWQpOworZXh0ZXJuIHZvaWQgcG54ODMzeF9tYWNo
aW5lX3Bvd2VyX29mZih2b2lkKTsKKworaW50IF9faW5pdCBwbGF0X21lbV9zZXR1cCh2b2lkKQor
eworCS8qIGZha2UgcGNpIGJ1cyB0byBhdm9pZCBib3VuY2UgYnVmZmVycyAqLworCVBDSV9ETUFf
QlVTX0lTX1BIWVMgPSAxOworCisJLyogc2V0IG1pcHMgY2xvY2sgdG8gMzIwTUh6ICovCisjaWYg
ZGVmaW5lZChDT05GSUdfU09DX1BOWDgzMzUpCisJUE5YODMzNV9XUklURUZJRUxEKDB4MTcsIENM
T0NLX1BMTF9DUFVfQ1RMLCBGUkVRKTsKKyNlbmRpZgorCXBueDgzM3hfZ3Bpb19pbml0KCk7CS8q
IHNvIGl0IHdpbGwgYmUgcmVhZHkgaW4gYm9hcmRfc2V0dXAoKSAqLworCisJcG54ODMzeF9ib2Fy
ZF9zZXR1cCgpOworCisJX21hY2hpbmVfcmVzdGFydCA9IHBueDgzM3hfbWFjaGluZV9yZXN0YXJ0
OworCV9tYWNoaW5lX2hhbHQgPSBwbng4MzN4X21hY2hpbmVfaGFsdDsKKwlwbV9wb3dlcl9vZmYg
PSBwbng4MzN4X21hY2hpbmVfcG93ZXJfb2ZmOworCisJLyogSU8vTUVNIHJlc291cmNlcy4gKi8K
KwlzZXRfaW9fcG9ydF9iYXNlKEtTRUcxKTsKKwlpb3BvcnRfcmVzb3VyY2Uuc3RhcnQgPSAwOwor
CWlvcG9ydF9yZXNvdXJjZS5lbmQgPSB+MDsKKwlpb21lbV9yZXNvdXJjZS5zdGFydCA9IDA7CisJ
aW9tZW1fcmVzb3VyY2UuZW5kID0gfjA7CisKKwlyZXR1cm4gMDsKK30KZGlmZiAtdXJOIC0tZXhj
bHVkZT0uc3ZuIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgzM3gvc3Ri
MjJ4L2JvYXJkLmMgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4
L2JvYXJkLmMKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgzM3gv
c3RiMjJ4L2JvYXJkLmMJMTk3MC0wMS0wMSAwMTowMDowMC4wMDAwMDAwMDAgKzAxMDAKKysrIGxp
bnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L3N0YjIyeC9ib2FyZC5jCTIwMDgt
MDYtMDYgMTE6Mjg6NTAuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsMTMzIEBACisvKgorICog
IGJvYXJkLmM6IFNUQjIyNSBib2FyZCBzdXBwb3J0LgorICoKKyAqICBDb3B5cmlnaHQgMjAwOCBO
WFAgU2VtaWNvbmR1Y3RvcnMKKyAqCSAgQ2hyaXMgU3RlZWwgPGNocmlzLnN0ZWVsQG54cC5jb20+
CisgKiAgICBEYW5pZWwgTGFpcmQgPGRhbmllbC5qLmxhaXJkQG54cC5jb20+CisgKgorICogIEJh
c2VkIG9uIHNvZnR3YXJlIHdyaXR0ZW4gYnk6CisgKiAgICAgIE5pa2l0YSBZb3VzaGNoZW5rbyA8
eW91c2hAZGViaWFuLm9yZz4sIGJhc2VkIG9uIFBOWDg1NTAgY29kZS4KKyAqCisgKiAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247
IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
CisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisg
KiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0
byB0aGUgRnJlZSBTb2Z0d2FyZQorICogIEZvdW5kYXRpb24sIEluYy4sIDY3NSBNYXNzIEF2ZSwg
Q2FtYnJpZGdlLCBNQSAwMjEzOSwgVVNBLgorICovCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgor
I2luY2x1ZGUgPGFzbS9ib290aW5mby5oPgorI2luY2x1ZGUgPGxpbnV4L21tLmg+CisjaW5jbHVk
ZSA8cG54ODMzeC5oPgorI2luY2x1ZGUgPGdwaW8uaD4KKworLyogZW5kaWFuZXNzIHR3aWRkbGVy
cyAqLworI2RlZmluZSBQTlg4MzM1X0RFQlVHMCAweDQ0MDAKKyNkZWZpbmUgUE5YODMzNV9ERUJV
RzEgMHg0NDA0CisjZGVmaW5lIFBOWDgzMzVfREVCVUcyIDB4NDQwOAorI2RlZmluZSBQTlg4MzM1
X0RFQlVHMyAweDQ0MGMKKyNkZWZpbmUgUE5YODMzNV9ERUJVRzQgMHg0NDEwCisjZGVmaW5lIFBO
WDgzMzVfREVCVUc1IDB4NDQxNAorI2RlZmluZSBQTlg4MzM1X0RFQlVHNiAweDQ0MTgKKyNkZWZp
bmUgUE5YODMzNV9ERUJVRzcgMHg0NDFjCisKK2ludCBwcm9tX2FyZ2M7CitjaGFyICoqcHJvbV9h
cmd2ID0gMCwgKipwcm9tX2VudnAgPSAwOworCitleHRlcm4gdm9pZCBwcm9tX2luaXRfY21kbGlu
ZSh2b2lkKTsKK2V4dGVybiBjaGFyICpwcm9tX2dldGVudihjaGFyICplbnZuYW1lKTsKKworY29u
c3QgY2hhciAqZ2V0X3N5c3RlbV90eXBlKHZvaWQpCit7CisJcmV0dXJuICJOWFAgU1RCMjJ4IjsK
K30KKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGVudl9vcl9kZWZhdWx0KGNoYXIgKmVu
diwgdW5zaWduZWQgbG9uZyBkZmwpCit7CisJY2hhciAqc3RyID0gcHJvbV9nZXRlbnYoZW52KTsK
KwlyZXR1cm4gc3RyID8gc2ltcGxlX3N0cnRvbChzdHIsIDAsIDApIDogZGZsOworfQorCit2b2lk
IF9faW5pdCBwcm9tX2luaXQodm9pZCkKK3sKKwl1bnNpZ25lZCBsb25nIG1lbXNpemU7CisKKwlw
cm9tX2FyZ2MgPSBmd19hcmcwOworCXByb21fYXJndiA9IChjaGFyICoqKWZ3X2FyZzE7CisJcHJv
bV9lbnZwID0gKGNoYXIgKiopZndfYXJnMjsKKworCXByb21faW5pdF9jbWRsaW5lKCk7CisKKwlt
ZW1zaXplID0gZW52X29yX2RlZmF1bHQoIm1lbXNpemUiLCAweDAyMDAwMDAwKTsKKwlhZGRfbWVt
b3J5X3JlZ2lvbigwLCBtZW1zaXplLCBCT09UX01FTV9SQU0pOworfQorCit2b2lkIF9faW5pdCBw
bng4MzN4X2JvYXJkX3NldHVwKHZvaWQpCit7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlv
bl9hbHQoNCk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9vdXRwdXQoNCk7CisJcG54ODMzeF9ncGlv
X3NlbGVjdF9mdW5jdGlvbl9hbHQoNSk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9pbnB1dCg1KTsK
Kwlwbng4MzN4X2dwaW9fc2VsZWN0X2Z1bmN0aW9uX2FsdCg2KTsKKwlwbng4MzN4X2dwaW9fc2Vs
ZWN0X2lucHV0KDYpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDcpOworCXBu
eDgzM3hfZ3Bpb19zZWxlY3Rfb3V0cHV0KDcpOworCisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5j
dGlvbl9hbHQoMjUpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDI2KTsKKwor
CXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDI3KTsKKwlwbng4MzN4X2dwaW9fc2Vs
ZWN0X2Z1bmN0aW9uX2FsdCgyOCk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9hbHQo
MjkpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDMwKTsKKwlwbng4MzN4X2dw
aW9fc2VsZWN0X2Z1bmN0aW9uX2FsdCgzMSk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlv
bl9hbHQoMzIpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDMzKTsKKworI2lm
IGRlZmluZWQoQ09ORklHX01URF9OQU5EX1BMQVRGT1JNKSB8fCBkZWZpbmVkKENPTkZJR19NVERf
TkFORF9QTEFURk9STV9NT0RVTEUpCisJLyogU2V0dXAgTUlVIGZvciBOQU5EIGFjY2VzcyBvbiBD
UzAuLi4KKwkgKgorCSAqIChpdCBzZWVtcyB0aGF0IHdlIG11c3QgYWxzbyBjb25maWd1cmUgQ1Mx
IGZvciByZWxpYWJsZSBvcGVyYXRpb24sCisJICogb3RoZXJ3aXNlIHRoZSBmaXJzdCByZWFkIElE
IGNvbW1hbmQgd2lsbCBmYWlsIGlmIGl0J3MgcmVhZCBhcyA0IGJ5dGVzCisJICogYnV0IHBhc3Mg
aWYgaXQncyByZWFkIGFzIDEgd29yZC4pCisJICovCisKKwkvKiBTZXR1cCBNSVUgQ1MwICYgQ1Mx
IHRpbWluZyAqLworCVBOWDgzM1hfTUlVX1NFTDAgPSAwOworCVBOWDgzM1hfTUlVX1NFTDEgPSAw
OworCVBOWDgzM1hfTUlVX1NFTDBfVElNSU5HID0gMHg1MDAwMzA4MTsKKwlQTlg4MzNYX01JVV9T
RUwxX1RJTUlORyA9IDB4NTAwMDMwODE7CisKKwkvKiBTZXR1cCBHUElPIDAwIGZvciB1c2UgYXMg
TUlVIENTMSAoQ1MwIGlzIG5vdCBtdWx0aXBsZXhlZCwgc28gZG9lcyBub3QgbmVlZCB0aGlzKSAq
LworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDApOworCisJLyogU2V0dXAgR1BJ
TyAwNCB0byBpbnB1dCBOQU5EIHJlYWQvYnVzeSBzaWduYWwgKi8KKwlwbng4MzN4X2dwaW9fc2Vs
ZWN0X2Z1bmN0aW9uX2lvKDQpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfaW5wdXQoNCk7CisKKwkv
KiBTZXR1cCBHUElPIDA1IHRvIGRpc2FibGUgTkFORCB3cml0ZSBwcm90ZWN0ICovCisJcG54ODMz
eF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9pbyg1KTsKKwlwbng4MzN4X2dwaW9fc2VsZWN0X291dHB1
dCg1KTsKKwlwbng4MzN4X2dwaW9fd3JpdGUoMSwgNSk7CisKKyNlbGlmIGRlZmluZWQoQ09ORklH
X01URF9DRkkpIHx8IGRlZmluZWQoQ09ORklHX01URF9DRklfTU9EVUxFKQorCisJLyogU2V0IHVw
IE1JVSBmb3IgMTYtYml0IE5PUiBhY2Nlc3Mgb24gQ1MwIGFuZCBDUzEuLi4gKi8KKworCS8qIFNl
dHVwIE1JVSBDUzAgJiBDUzEgdGltaW5nICovCisJUE5YODMzWF9NSVVfU0VMMCA9IDE7CisJUE5Y
ODMzWF9NSVVfU0VMMSA9IDE7CisJUE5YODMzWF9NSVVfU0VMMF9USU1JTkcgPSAweDZBMDhEMDgy
OworCVBOWDgzM1hfTUlVX1NFTDFfVElNSU5HID0gMHg2QTA4RDA4MjsKKworCS8qIFNldHVwIEdQ
SU8gMDAgZm9yIHVzZSBhcyBNSVUgQ1MxIChDUzAgaXMgbm90IG11bHRpcGxleGVkLCBzbyBkb2Vz
IG5vdCBuZWVkIHRoaXMpICovCisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9hbHQoMCk7
CisjZW5kaWYKK30KZGlmZiAtdXJOIC0tZXhjbHVkZT0uc3ZuIGxpbnV4LTIuNi4yNi1yYzQub3Jp
Zy9hcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4L01ha2VmaWxlIGxpbnV4LTIuNi4yNi1yYzQv
YXJjaC9taXBzL254cC9wbng4MzN4L3N0YjIyeC9NYWtlZmlsZQotLS0gbGludXgtMi42LjI2LXJj
NC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMzeC9zdGIyMngvTWFrZWZpbGUJMTk3MC0wMS0wMSAw
MTowMDowMC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254
cC9wbng4MzN4L3N0YjIyeC9NYWtlZmlsZQkyMDA4LTAzLTAzIDEzOjA5OjMwLjAwMDAwMDAwMCAr
MDAwMApAQCAtMCwwICsxIEBACitsaWIteSA6PSBib2FyZC5vCmRpZmYgLXVyTiAtLWV4Y2x1ZGU9
LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gv
Z3Bpby5oIGxpbnV4LTIuNi4yNi1yYzQvaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvZ3Bp
by5oCi0tLSBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgz
M3gvZ3Bpby5oCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0y
LjYuMjYtcmM0L2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2dwaW8uaAkyMDA4LTA2LTA2
IDExOjI5OjA5LjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDE3MiBAQAorLyoKKyAqICBncGlv
Lmg6IEdQSU8gU3VwcG9ydCBmb3IgUE5YODMzWC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQ
IFNlbWljb25kdWN0b3JzCisgKgkgIENocmlzIFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgor
ICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwuai5sYWlyZEBueHAuY29tPgorICoKKyAqICBUaGlz
IHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29y
IG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0
ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBB
TlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1F
UkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0
aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoK
KyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRl
IHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiAgRm91bmRhdGlvbiwgSW5jLiwgNjc1IE1hc3MgQXZl
LCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKyNpZm5kZWYgX19BU01fTUlQU19NQUNI
X1BOWDgzM1hfR1BJT19ICisjZGVmaW5lIF9fQVNNX01JUFNfTUFDSF9QTlg4MzNYX0dQSU9fSAor
CisvKiBCSUcgRkFUIFdBUk5JTkc6IHJhY2VzIGRhbmdlciEKKyAgIE5vIHByb3RlY3Rpb25zIGV4
aXN0IGhlcmUuIEN1cnJlbnQgdXNlcnMgYXJlIG9ubHkgZWFybHkgaW5pdCBjb2RlLAorICAgd2hl
biBsb2NraW5nIGlzIG5vdCBuZWVkZWQgYmVjYXVzZSBubyBjdW5jdXJlbmN5IHlldCBleGlzdHMg
dGhlcmUsCisgICBhbmQgR1BJTyBJUlEgZGlzcGF0Y2hlciwgd2hpY2ggZG9lcyBsb2NraW5nLgor
ICAgSG93ZXZlciwgaWYgbWFueSB1c2VzIHdpbGwgZXZlciBoYXBwZW4sIHByb3BlciBsb2NraW5n
IHdpbGwgYmUgbmVlZGVkCisgICAtIGluY2x1ZGluZyBsb2NraW5nIGJldHdlZW4gZGlmZmVyZW50
IHVzZXMKKyovCisKKyNpbmNsdWRlICJwbng4MzN4LmgiCisKKyNkZWZpbmUgU0VUX1JFR19CSVQo
cmVnLCBiaXQpCQlyZWcgfD0gKDEgPDwgKGJpdCkpCisjZGVmaW5lIENMRUFSX1JFR19CSVQocmVn
LCBiaXQpCQlyZWcgJj0gfigxIDw8IChiaXQpKQorCisvKiBJbml0aWFsaXplIEdQSU8gdG8gYSBr
bm93biBzdGF0ZSAqLworc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bpb19pbml0KHZvaWQp
Cit7CisJUE5YODMzWF9QSU9fRElSID0gMDsKKwlQTlg4MzNYX1BJT19ESVIyID0gMDsKKwlQTlg4
MzNYX1BJT19TRUwgPSAwOworCVBOWDgzM1hfUElPX1NFTDIgPSAwOworCVBOWDgzM1hfUElPX0lO
VF9FREdFID0gMDsKKwlQTlg4MzNYX1BJT19JTlRfSEkgPSAwOworCVBOWDgzM1hfUElPX0lOVF9M
TyA9IDA7CisKKwkvKiBjbGVhciBhbnkgR1BJTyBpbnRlcnJ1cHQgcmVxdWVzdHMgKi8KKwlQTlg4
MzNYX1BJT19JTlRfQ0xFQVIgPSAweGZmZmY7CisJUE5YODMzWF9QSU9fSU5UX0NMRUFSID0gMDsK
KwlQTlg4MzNYX1BJT19JTlRfRU5BQkxFID0gMDsKK30KKworLyogU2VsZWN0IEdQSU8gZGlyZWN0
aW9uIGZvciBhIHBpbiAqLworc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bpb19zZWxlY3Rf
aW5wdXQodW5zaWduZWQgaW50IHBpbikKK3sKKwlpZiAocGluIDwgMzIpCisJCUNMRUFSX1JFR19C
SVQoUE5YODMzWF9QSU9fRElSLCBwaW4pOworCWVsc2UKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNY
X1BJT19ESVIyLCBwaW4gJiAzMSk7Cit9CitzdGF0aWMgaW5saW5lIHZvaWQgcG54ODMzeF9ncGlv
X3NlbGVjdF9vdXRwdXQodW5zaWduZWQgaW50IHBpbikKK3sKKwlpZiAocGluIDwgMzIpCisJCVNF
VF9SRUdfQklUKFBOWDgzM1hfUElPX0RJUiwgcGluKTsKKwllbHNlCisJCVNFVF9SRUdfQklUKFBO
WDgzM1hfUElPX0RJUjIsIHBpbiAmIDMxKTsKK30KKworLyogU2VsZWN0IEdQSU8gb3IgYWx0ZXJu
YXRlIGZ1bmN0aW9uIGZvciBhIHBpbiAqLworc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bp
b19zZWxlY3RfZnVuY3Rpb25faW8odW5zaWduZWQgaW50IHBpbikKK3sKKwlpZiAocGluIDwgMzIp
CisJCUNMRUFSX1JFR19CSVQoUE5YODMzWF9QSU9fU0VMLCBwaW4pOworCWVsc2UKKwkJQ0xFQVJf
UkVHX0JJVChQTlg4MzNYX1BJT19TRUwyLCBwaW4gJiAzMSk7Cit9CitzdGF0aWMgaW5saW5lIHZv
aWQgcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9hbHQodW5zaWduZWQgaW50IHBpbikKK3sK
KwlpZiAocGluIDwgMzIpCisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX1NFTCwgcGluKTsKKwll
bHNlCisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX1NFTDIsIHBpbiAmIDMxKTsKK30KKworLyog
UmVhZCBHUElPIHBpbiAqLworc3RhdGljIGlubGluZSBpbnQgcG54ODMzeF9ncGlvX3JlYWQodW5z
aWduZWQgaW50IHBpbikKK3sKKwlpZiAocGluIDwgMzIpCisJCXJldHVybihQTlg4MzNYX1BJT19J
TiA+PiBwaW4pICYgMTsKKwllbHNlCisJCXJldHVybihQTlg4MzNYX1BJT19JTjIgPj4gKHBpbiAm
IDMxKSkgJiAxOworfQorCisvKiBXcml0ZSBHUElPIHBpbiAqLworc3RhdGljIGlubGluZSB2b2lk
IHBueDgzM3hfZ3Bpb193cml0ZSh1bnNpZ25lZCBpbnQgdmFsLCB1bnNpZ25lZCBpbnQgcGluKQor
eworCWlmIChwaW4gPCAzMikgeworCQlpZiAodmFsKQorCQkJU0VUX1JFR19CSVQoUE5YODMzWF9Q
SU9fT1VULCBwaW4pOworCQllbHNlCisJCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX09VVCwg
cGluKTsKKwl9IGVsc2UgeworCQlpZiAodmFsKQorCQkJU0VUX1JFR19CSVQoUE5YODMzWF9QSU9f
T1VUMiwgcGluICYgMzEpOworCQllbHNlCisJCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX09V
VDIsIHBpbiAmIDMxKTsKKwl9Cit9CisKKy8qIENvbmZpZ3VyZSBHUElPIGludGVycnVwdCAqLwor
I2RlZmluZSBHUElPX0lOVF9OT05FCQkwCisjZGVmaW5lIEdQSU9fSU5UX0xFVkVMX0xPVwkxCisj
ZGVmaW5lIEdQSU9fSU5UX0xFVkVMX0hJR0gJMgorI2RlZmluZSBHUElPX0lOVF9FREdFX1JJU0lO
RwkzCisjZGVmaW5lIEdQSU9fSU5UX0VER0VfRkFMTElORwk0CisjZGVmaW5lIEdQSU9fSU5UX0VE
R0VfQk9USAk1CitzdGF0aWMgaW5saW5lIHZvaWQgcG54ODMzeF9ncGlvX3NldHVwX2lycShpbnQg
d2hlbiwgdW5zaWduZWQgaW50IHBpbikKK3sKKwlzd2l0Y2ggKHdoZW4pIHsKKwljYXNlIEdQSU9f
SU5UX0xFVkVMX0xPVzoKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfRURHRSwgcGlu
KTsKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfSEksIHBpbik7CisJCVNFVF9SRUdf
QklUKFBOWDgzM1hfUElPX0lOVF9MTywgcGluKTsKKwkJYnJlYWs7CisJY2FzZSBHUElPX0lOVF9M
RVZFTF9ISUdIOgorCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9FREdFLCBwaW4pOwor
CQlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfSEksIHBpbik7CisJCUNMRUFSX1JFR19CSVQo
UE5YODMzWF9QSU9fSU5UX0xPLCBwaW4pOworCQlicmVhazsKKwljYXNlIEdQSU9fSU5UX0VER0Vf
UklTSU5HOgorCQlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfRURHRSwgcGluKTsKKwkJU0VU
X1JFR19CSVQoUE5YODMzWF9QSU9fSU5UX0hJLCBwaW4pOworCQlDTEVBUl9SRUdfQklUKFBOWDgz
M1hfUElPX0lOVF9MTywgcGluKTsKKwkJYnJlYWs7CisJY2FzZSBHUElPX0lOVF9FREdFX0ZBTExJ
Tkc6CisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9FREdFLCBwaW4pOworCQlDTEVBUl9S
RUdfQklUKFBOWDgzM1hfUElPX0lOVF9ISSwgcGluKTsKKwkJU0VUX1JFR19CSVQoUE5YODMzWF9Q
SU9fSU5UX0xPLCBwaW4pOworCQlicmVhazsKKwljYXNlIEdQSU9fSU5UX0VER0VfQk9USDoKKwkJ
U0VUX1JFR19CSVQoUE5YODMzWF9QSU9fSU5UX0VER0UsIHBpbik7CisJCVNFVF9SRUdfQklUKFBO
WDgzM1hfUElPX0lOVF9ISSwgcGluKTsKKwkJU0VUX1JFR19CSVQoUE5YODMzWF9QSU9fSU5UX0xP
LCBwaW4pOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElP
X0lOVF9FREdFLCBwaW4pOworCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9ISSwgcGlu
KTsKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfTE8sIHBpbik7CisJCWJyZWFrOwor
CX0KK30KKworLyogRW5hYmxlL2Rpc2FibGUgR1BJTyBpbnRlcnJ1cHQgKi8KK3N0YXRpYyBpbmxp
bmUgdm9pZCBwbng4MzN4X2dwaW9fZW5hYmxlX2lycSh1bnNpZ25lZCBpbnQgcGluKQoreworCVNF
VF9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9FTkFCTEUsIHBpbik7Cit9CitzdGF0aWMgaW5saW5l
IHZvaWQgcG54ODMzeF9ncGlvX2Rpc2FibGVfaXJxKHVuc2lnbmVkIGludCBwaW4pCit7CisJQ0xF
QVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfRU5BQkxFLCBwaW4pOworfQorCisvKiBDbGVhciBH
UElPIGludGVycnVwdCByZXF1ZXN0ICovCitzdGF0aWMgaW5saW5lIHZvaWQgcG54ODMzeF9ncGlv
X2NsZWFyX2lycSh1bnNpZ25lZCBpbnQgcGluKQoreworCVNFVF9SRUdfQklUKFBOWDgzM1hfUElP
X0lOVF9DTEVBUiwgcGluKTsKKwlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9DTEVBUiwg
cGluKTsKK30KKworI2VuZGlmCmRpZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYt
cmM0Lm9yaWcvaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvaXJxLmggbGludXgtMi42LjI2
LXJjNC9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9pcnEuaAotLS0gbGludXgtMi42LjI2
LXJjNC5vcmlnL2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2lycS5oCTE5NzAtMDEtMDEg
MDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0L2luY2x1ZGUvYXNt
LW1pcHMvbWFjaC1wbng4MzN4L2lycS5oCTIwMDgtMDYtMTIgMTM6MDU6MzEuMDAwMDAwMDAwICsw
MTAwCkBAIC0wLDAgKzEsNTMgQEAKKy8qCisgKiAgaXJxLmg6IElSUSBtYXBwaW5ncyBmb3IgUE5Y
ODMzWC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENo
cmlzIFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5p
ZWwuai5sYWlyZEBueHAuY29tPgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5
CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0
aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgor
ICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3
aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25n
IHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisg
KiAgRm91bmRhdGlvbiwgSW5jLiwgNjc1IE1hc3MgQXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBV
U0EuCisgKi8KKworI2lmbmRlZiBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9JUlFfSAorI2RlZmlu
ZSBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9JUlFfSAorLyoKKyAqIFRoZSAiSVJRIG51bWJlcnMi
IGFyZSBjb21wbGV0ZWx5IHZpcnR1YWwuCisgKgorICogSW4gUE5YODMzMC8xLCB3ZSBoYXZlIDQ4
IGludGVycnVwdCBsaW5lcywgbnVtYmVyZWQgZnJvbSAxIHRvIDQ4LgorICogTGV0J3MgdXNlIG51
bWJlcnMgMS4uNDggZm9yIFBJQyBpbnRlcnJ1cHRzLCBudW1iZXIgMCBmb3IgdGltZXIgaW50ZXJy
dXB0LAorICogbnVtYmVycyA0OS4uNjQgZm9yICh2aXJ0dWFsKSBHUElPIGludGVycnVwdHMuCisg
KgorICogSW4gUE5YODMzNSwgd2UgaGF2ZSA1NyBpbnRlcnJ1cHQgbGluZXMsIG51bWJlcmVkIGZy
b20gMSB0byA1NywKKyAqIGNvbm5lY3RlZCB0byBQSUMsIHdoaWNoIHVzZXMgY29yZSBoYXJkd2Fy
ZSBpbnRlcnJ1cHQgMiwgYW5kIGFsc28KKyAqIGEgdGltZXIgaW50ZXJydXB0IHRocm91Z2ggaGFy
ZHdhcmUgaW50ZXJydXB0IDUuCisgKiBMZXQncyB1c2UgbnVtYmVycyAxLi42NCBmb3IgUElDIGlu
dGVycnVwdHMsIG51bWJlciAwIGZvciB0aW1lciBpbnRlcnJ1cHQsCisgKiBudW1iZXJzIDY1Li44
MCBmb3IgKHZpcnR1YWwpIEdQSU8gaW50ZXJydXB0cy4KKyAqCisgKi8KKyNpZiBkZWZpbmVkKENP
TkZJR19TT0NfUE5YODMzNSkKKwkjZGVmaW5lIFBOWDgzM1hfUElDX05VTV9JUlEJCQk1OAorI2Vs
c2UKKwkjZGVmaW5lIFBOWDgzM1hfUElDX05VTV9JUlEJCQkzNworI2VuZGlmCisKKyNkZWZpbmUg
TUlQU19DUFVfTlVNX0lSUQkJCQk4CisjZGVmaW5lIFBOWDgzM1hfR1BJT19OVU1fSVJRCQkJMTYK
KworI2RlZmluZSBNSVBTX0NQVV9JUlFfQkFTRQkJCQkwCisjZGVmaW5lIFBOWDgzM1hfUElDX0lS
UV9CQVNFCQkJKE1JUFNfQ1BVX0lSUV9CQVNFICsgTUlQU19DUFVfTlVNX0lSUSkKKyNkZWZpbmUg
UE5YODMzWF9HUElPX0lSUV9CQVNFCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgUE5YODMzWF9Q
SUNfTlVNX0lSUSkKKyNkZWZpbmUgTlJfSVJRUwkJCQkJCQkoTUlQU19DUFVfTlVNX0lSUSArIFBO
WDgzM1hfUElDX05VTV9JUlEgKyBQTlg4MzNYX0dQSU9fTlVNX0lSUSkKKworI2VuZGlmCmRpZmYg
LXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5jbHVkZS9hc20tbWlw
cy9tYWNoLXBueDgzM3gvaXJxLW1hcHBpbmcuaCBsaW51eC0yLjYuMjYtcmM0L2luY2x1ZGUvYXNt
LW1pcHMvbWFjaC1wbng4MzN4L2lycS1tYXBwaW5nLmgKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3Jp
Zy9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9pcnEtbWFwcGluZy5oCTE5NzAtMDEtMDEg
MDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0L2luY2x1ZGUvYXNt
LW1pcHMvbWFjaC1wbng4MzN4L2lycS1tYXBwaW5nLmgJMjAwOC0wNi0xMiAxMzowNzoxOS4wMDAw
MDAwMDAgKzAxMDAKQEAgLTAsMCArMSwxMjYgQEAKKworLyoKKyAqICBpcnEuaDogSVJRIG1hcHBp
bmdzIGZvciBQTlg4MzNYLgorICoKKyAqICBDb3B5cmlnaHQgMjAwOCBOWFAgU2VtaWNvbmR1Y3Rv
cnMKKyAqCSAgQ2hyaXMgU3RlZWwgPGNocmlzLnN0ZWVsQG54cC5jb20+CisgKiAgICBEYW5pZWwg
TGFpcmQgPGRhbmllbC5qLmxhaXJkQG54cC5jb20+CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAg
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBw
dWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVy
c2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVy
IHZlcnNpb24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9w
ZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsg
d2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91
bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
CisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUg
U29mdHdhcmUKKyAqICBGb3VuZGF0aW9uLCBJbmMuLCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwg
TUEgMDIxMzksIFVTQS4KKyAqLworCisjaWZuZGVmIF9fQVNNX01JUFNfTUFDSF9QTlg4MzNYX0lS
UV9NQVBQSU5HX0gKKyNkZWZpbmUgX19BU01fTUlQU19NQUNIX1BOWDgzM1hfSVJRX01BUFBJTkdf
SAorLyoKKyAqIFRoZSAiSVJRIG51bWJlcnMiIGFyZSBjb21wbGV0ZWx5IHZpcnR1YWwuCisgKgor
ICogSW4gUE5YODMzMC8xLCB3ZSBoYXZlIDQ4IGludGVycnVwdCBsaW5lcywgbnVtYmVyZWQgZnJv
bSAxIHRvIDQ4LgorICogTGV0J3MgdXNlIG51bWJlcnMgMS4uNDggZm9yIFBJQyBpbnRlcnJ1cHRz
LCBudW1iZXIgMCBmb3IgdGltZXIgaW50ZXJydXB0LAorICogbnVtYmVycyA0OS4uNjQgZm9yICh2
aXJ0dWFsKSBHUElPIGludGVycnVwdHMuCisgKgorICogSW4gUE5YODMzNSwgd2UgaGF2ZSA1NyBp
bnRlcnJ1cHQgbGluZXMsIG51bWJlcmVkIGZyb20gMSB0byA1NywKKyAqIGNvbm5lY3RlZCB0byBQ
SUMsIHdoaWNoIHVzZXMgY29yZSBoYXJkd2FyZSBpbnRlcnJ1cHQgMiwgYW5kIGFsc28KKyAqIGEg
dGltZXIgaW50ZXJydXB0IHRocm91Z2ggaGFyZHdhcmUgaW50ZXJydXB0IDUuCisgKiBMZXQncyB1
c2UgbnVtYmVycyAxLi42NCBmb3IgUElDIGludGVycnVwdHMsIG51bWJlciAwIGZvciB0aW1lciBp
bnRlcnJ1cHQsCisgKiBudW1iZXJzIDY1Li44MCBmb3IgKHZpcnR1YWwpIEdQSU8gaW50ZXJydXB0
cy4KKyAqCisgKi8KKyNpbmNsdWRlIDxpcnEuaD4KKworI2RlZmluZSBQTlg4MzNYX1RJTUVSX0lS
UQkJCQkoTUlQU19DUFVfSVJRX0JBU0UgKyA3KQorCisvKiBJbnRlcnJ1cHRzIHN1cHBvcnRlZCBi
eSBQSUMgKi8KKyNkZWZpbmUgUE5YODMzWF9QSUNfSTJDMF9JTlQJCQkoUE5YODMzWF9QSUNfSVJR
X0JBU0UgKyAgMSkKKyNkZWZpbmUgUE5YODMzWF9QSUNfSTJDMV9JTlQJCQkoUE5YODMzWF9QSUNf
SVJRX0JBU0UgKyAgMikKKyNkZWZpbmUgUE5YODMzWF9QSUNfVUFSVDBfSU5UCQkJKFBOWDgzM1hf
UElDX0lSUV9CQVNFICsgIDMpCisjZGVmaW5lIFBOWDgzM1hfUElDX1VBUlQxX0lOVAkJCShQTlg4
MzNYX1BJQ19JUlFfQkFTRSArICA0KQorI2RlZmluZSBQTlg4MzNYX1BJQ19UU19JTjBfRFZfSU5U
CQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAgNSkKKyNkZWZpbmUgUE5YODMzWF9QSUNfVFNfSU4w
X0RNQV9JTlQJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArICA2KQorI2RlZmluZSBQTlg4MzNYX1BJ
Q19HUElPX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArICA3KQorI2RlZmluZSBQTlg4MzNY
X1BJQ19BVURJT19ERUNfSU5UCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAgOCkKKyNkZWZpbmUg
UE5YODMzWF9QSUNfVklERU9fREVDX0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgIDkpCisj
ZGVmaW5lIFBOWDgzM1hfUElDX0NPTkZJR19JTlQJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAx
MCkKKyNkZWZpbmUgUE5YODMzWF9QSUNfQU9JX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0Ug
KyAxMSkKKyNkZWZpbmUgUE5YODMzWF9QSUNfU1lOQ19JTlQJCQkoUE5YODMzWF9QSUNfSVJRX0JB
U0UgKyAxMikKKyNkZWZpbmUgUE5YODMzMF9QSUNfU1BVX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJR
X0JBU0UgKyAxMykKKyNkZWZpbmUgUE5YODMzNV9QSUNfU0FUQV9JTlQJCQkoUE5YODMzWF9QSUNf
SVJRX0JBU0UgKyAxMykKKyNkZWZpbmUgUE5YODMzWF9QSUNfT1NEX0lOVAkJCQkoUE5YODMzWF9Q
SUNfSVJRX0JBU0UgKyAxNCkKKyNkZWZpbmUgUE5YODMzWF9QSUNfRElTUDFfSU5UCQkJKFBOWDgz
M1hfUElDX0lSUV9CQVNFICsgMTUpCisjZGVmaW5lIFBOWDgzM1hfUElDX0RFSU5URVJMQUNFUl9J
TlQJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTYpCisjZGVmaW5lIFBOWDgzM1hfUElDX0RJU1BM
QVkyX0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTcpCisjZGVmaW5lIFBOWDgzM1hfUElD
X1ZDX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAxOCkKKyNkZWZpbmUgUE5YODMzWF9Q
SUNfU0NfSU5UCQkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDE5KQorI2RlZmluZSBQTlg4MzNY
X1BJQ19JREVfSU5UCQkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDIwKQorI2RlZmluZSBQTlg4
MzNYX1BJQ19JREVfRE1BX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDIxKQorI2RlZmlu
ZSBQTlg4MzNYX1BJQ19UU19JTjFfRFZfSU5UCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAyMikK
KyNkZWZpbmUgUE5YODMzWF9QSUNfVFNfSU4xX0RNQV9JTlQJCShQTlg4MzNYX1BJQ19JUlFfQkFT
RSArIDIzKQorI2RlZmluZSBQTlg4MzNYX1BJQ19TR0RYX0RNQV9JTlQJCShQTlg4MzNYX1BJQ19J
UlFfQkFTRSArIDI0KQorI2RlZmluZSBQTlg4MzNYX1BJQ19UU19PVVRfSU5UCQkJKFBOWDgzM1hf
UElDX0lSUV9CQVNFICsgMjUpCisjZGVmaW5lIFBOWDgzM1hfUElDX0lSX0lOVAkJCQkoUE5YODMz
WF9QSUNfSVJRX0JBU0UgKyAyNikKKyNkZWZpbmUgUE5YODMzWF9QSUNfVk1TUDFfSU5UCQkJKFBO
WDgzM1hfUElDX0lSUV9CQVNFICsgMjcpCisjZGVmaW5lIFBOWDgzM1hfUElDX1ZNU1AyX0lOVAkJ
CShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDI4KQorI2RlZmluZSBQTlg4MzNYX1BJQ19QSUJDX0lO
VAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDI5KQorI2RlZmluZSBQTlg4MzNYX1BJQ19UU19J
TjBfVFJEX0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMzApCisjZGVmaW5lIFBOWDgzM1hf
UElDX1NHRFhfVFBEX0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMzEpCisjZGVmaW5lIFBO
WDgzM1hfUElDX1VTQl9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMzIpCisjZGVmaW5l
IFBOWDgzM1hfUElDX1RTX0lOMV9UUkRfSU5UCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAzMykK
KyNkZWZpbmUgUE5YODMzWF9QSUNfQ0xPQ0tfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsg
MzQpCisjZGVmaW5lIFBOWDgzM1hfUElDX1NHRFhfUEFSU0VSX0lOVAkJKFBOWDgzM1hfUElDX0lS
UV9CQVNFICsgMzUpCisjZGVmaW5lIFBOWDgzM1hfUElDX1ZNU1BfRE1BX0lOVAkJKFBOWDgzM1hf
UElDX0lSUV9CQVNFICsgMzYpCisKKyNpZiBkZWZpbmVkKENPTkZJR19TT0NfUE5YODMzNSkKKyNk
ZWZpbmUgUE5YODMzNV9QSUNfTUlVX0lOVAkJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMzcp
CisjZGVmaW5lIFBOWDgzMzVfUElDX0FWQ0hJUF9JUlFfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9C
QVNFICsgMzgpCisjZGVmaW5lIFBOWDgzMzVfUElDX1NZTkNfSERfSU5UCQkJCShQTlg4MzNYX1BJ
Q19JUlFfQkFTRSArIDM5KQorI2RlZmluZSBQTlg4MzM1X1BJQ19ESVNQX0hEX0lOVAkJCQkoUE5Y
ODMzWF9QSUNfSVJRX0JBU0UgKyA0MCkKKyNkZWZpbmUgUE5YODMzNV9QSUNfRElTUF9TQ0FMRVJf
SU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNDEpCisjZGVmaW5lIFBOWDgzMzVfUElDX09T
RF9IRDFfSU5UCQkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDQyKQorI2RlZmluZSBQTlg4MzM1
X1BJQ19EVExfV1JJVEVSX1lfSU5UCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyA0MykKKyNkZWZp
bmUgUE5YODMzNV9QSUNfRFRMX1dSSVRFUl9DX0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsg
NDQpCisjZGVmaW5lIFBOWDgzMzVfUElDX0RUTF9FTVVMQVRPUl9ZX0lSX0lOVAkoUE5YODMzWF9Q
SUNfSVJRX0JBU0UgKyA0NSkKKyNkZWZpbmUgUE5YODMzNV9QSUNfRFRMX0VNVUxBVE9SX0NfSVJf
SU5UCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDQ2KQorI2RlZmluZSBQTlg4MzM1X1BJQ19ERU5D
X1RUWF9JTlQJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyA0NykKKyNkZWZpbmUgUE5YODMzNV9Q
SUNfTU1JX1NJRjBfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNDgpCisjZGVmaW5lIFBO
WDgzMzVfUElDX01NSV9TSUYxX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDQ5KQorI2Rl
ZmluZSBQTlg4MzM1X1BJQ19NTUlfQ0RNTVVfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsg
NTApCisjZGVmaW5lIFBOWDgzMzVfUElDX1BJQkNTX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJRX0JB
U0UgKyA1MSkKKyNkZWZpbmUgUE5YODMzNV9QSUNfRVRIRVJORVRfSU5UCQkJKFBOWDgzM1hfUElD
X0lSUV9CQVNFICsgNTIpCisjZGVmaW5lIFBOWDgzMzVfUElDX1ZNU1AxXzBfSU5UCQkJCShQTlg4
MzNYX1BJQ19JUlFfQkFTRSArIDUzKQorI2RlZmluZSBQTlg4MzM1X1BJQ19WTVNQMV8xX0lOVAkJ
CQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyA1NCkKKyNkZWZpbmUgUE5YODMzNV9QSUNfVk1TUDFf
RE1BX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDU1KQorI2RlZmluZSBQTlg4MzM1X1BJ
Q19UREdSX0RFX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyA1NikKKyNkZWZpbmUgUE5Y
ODMzNV9QSUNfSVIxX0lSUV9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNTcpCisjZW5k
aWYKKworLyogR1BJTyBpbnRlcnJ1cHRzICovCisjZGVmaW5lIFBOWDgzM1hfR1BJT18wX0lOVAkJ
CShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAgMCkKKyNkZWZpbmUgUE5YODMzWF9HUElPXzFfSU5U
CQkJKFBOWDgzM1hfR1BJT19JUlFfQkFTRSArICAxKQorI2RlZmluZSBQTlg4MzNYX0dQSU9fMl9J
TlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgIDIpCisjZGVmaW5lIFBOWDgzM1hfR1BJT18z
X0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAgMykKKyNkZWZpbmUgUE5YODMzWF9HUElP
XzRfSU5UCQkJKFBOWDgzM1hfR1BJT19JUlFfQkFTRSArICA0KQorI2RlZmluZSBQTlg4MzNYX0dQ
SU9fNV9JTlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgIDUpCisjZGVmaW5lIFBOWDgzM1hf
R1BJT182X0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAgNikKKyNkZWZpbmUgUE5YODMz
WF9HUElPXzdfSU5UCQkJKFBOWDgzM1hfR1BJT19JUlFfQkFTRSArICA3KQorI2RlZmluZSBQTlg4
MzNYX0dQSU9fOF9JTlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgIDgpCisjZGVmaW5lIFBO
WDgzM1hfR1BJT185X0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAgOSkKKyNkZWZpbmUg
UE5YODMzWF9HUElPXzEwX0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAxMCkKKyNkZWZp
bmUgUE5YODMzWF9HUElPXzExX0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAxMSkKKyNk
ZWZpbmUgUE5YODMzWF9HUElPXzEyX0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAxMikK
KyNkZWZpbmUgUE5YODMzWF9HUElPXzEzX0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyAx
MykKKyNkZWZpbmUgUE5YODMzWF9HUElPXzE0X0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JBU0Ug
KyAxNCkKKyNkZWZpbmUgUE5YODMzWF9HUElPXzE1X0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JB
U0UgKyAxNSkKKworI2VuZGlmCisKZGlmZiAtdXJOIC0tZXhjbHVkZT0uc3ZuIGxpbnV4LTIuNi4y
Ni1yYzQub3JpZy9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9wbng4MzN4LmggbGludXgt
Mi42LjI2LXJjNC9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9wbng4MzN4LmgKLS0tIGxp
bnV4LTIuNi4yNi1yYzQub3JpZy9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9wbng4MzN4
LmgJMTk3MC0wMS0wMSAwMTowMDowMC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yNi1y
YzQvaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvcG54ODMzeC5oCTIwMDgtMDYtMDYgMTE6
Mjk6NDMuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsMjAyIEBACisvKgorICogIHBueDgzM3gu
aDogUmVnaXN0ZXIgbWFwcGluZ3MgZm9yIFBOWDgzM1guCisgKgorICogIENvcHlyaWdodCAyMDA4
IE5YUCBTZW1pY29uZHVjdG9ycworICoJICBDaHJpcyBTdGVlbCA8Y2hyaXMuc3RlZWxAbnhwLmNv
bT4KKyAqICAgIERhbmllbCBMYWlyZCA8ZGFuaWVsLmoubGFpcmRAbnhwLmNvbT4KKyAqCisgKiAg
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFu
ZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIg
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3Ry
aWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhP
VVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAq
ICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBT
ZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4K
KyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3
cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogIEZvdW5kYXRpb24sIEluYy4sIDY3NSBNYXNz
IEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEzOSwgVVNBLgorICovCisjaWZuZGVmIF9fQVNNX01JUFNf
TUFDSF9QTlg4MzNYX1BOWDgzM1hfSAorI2RlZmluZSBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9Q
Tlg4MzNYX0gKKworLyogQWxsIHJlZ3MgYXJlIGFjY2Vzc2VkIGluIEtTRUcxICovCisjZGVmaW5l
IFBOWDgzM1hfQkFTRQkJKDB4YTAwMDAwMDB1bCArIDB4MTdFMDAwMDB1bCkKKworI2RlZmluZSBQ
Tlg4MzNYX1JFRyhvZmZzKQkqKCh2b2xhdGlsZSB1bnNpZ25lZCBsb25nICopKFBOWDgzM1hfQkFT
RSArIG9mZnMpKQorCisvKiBSZWdpc3RlcnMgYXJlIG5hbWVkIGV4YWN0bHkgYXMgaW4gUE5YODMz
WCBkb2NzLCBqdXN0IHdpdGggUE5YODMzWF8gcHJlZml4ICovCisKKy8qIFJlYWQgYWNjZXNzIHRv
IG11bHRpYml0IGZpZWxkcyAqLworI2RlZmluZSBQTlg4MzNYX0JJVCh2YWwsIHJlZywgZmllbGQp
CSgodmFsKSAmIFBOWDgzM1hfIyNyZWcjI18jI2ZpZWxkKQorI2RlZmluZSBQTlg4MzNYX1JFR0JJ
VChyZWcsIGZpZWxkKQlQTlg4MzNYX0JJVChQTlg4MzNYXyMjcmVnLCByZWcsIGZpZWxkKQorCisv
KiBVc2UgUE5YODMzWF9GSUVMRCB0byBleHRyYWN0IGEgZmllbGQgZnJvbSB2YWwgKi8KKyNkZWZp
bmUgUE5YX0ZJRUxEKGNwdSwgdmFsLCByZWcsIGZpZWxkKSBcCisJCSgoKHZhbCkgJiBQTlgjI2Nw
dSMjXyMjcmVnIyNfIyNmaWVsZCMjX01BU0spID4+IFwKKwkJCVBOWCMjY3B1IyNfIyNyZWcjI18j
I2ZpZWxkIyNfU0hJRlQpCisjZGVmaW5lIFBOWDgzM1hfRklFTEQodmFsLCByZWcsIGZpZWxkKQlQ
TlhfRklFTEQoODMzWCwgdmFsLCByZWcsIGZpZWxkKQorI2RlZmluZSBQTlg4MzMwX0ZJRUxEKHZh
bCwgcmVnLCBmaWVsZCkJUE5YX0ZJRUxEKDgzMzAsIHZhbCwgcmVnLCBmaWVsZCkKKyNkZWZpbmUg
UE5YODMzNV9GSUVMRCh2YWwsIHJlZywgZmllbGQpCVBOWF9GSUVMRCg4MzM1LCB2YWwsIHJlZywg
ZmllbGQpCisKKy8qIFVzZSBQTlg4MzNYX1JFR0ZJRUxEIHRvIGV4dHJhY3QgYSBmaWVsZCBmcm9t
IGEgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgUE5YODMzWF9SRUdGSUVMRChyZWcsIGZpZWxkKQlQTlg4
MzNYX0ZJRUxEKFBOWDgzM1hfIyNyZWcsIHJlZywgZmllbGQpCisjZGVmaW5lIFBOWDgzMzBfUkVH
RklFTEQocmVnLCBmaWVsZCkJUE5YODMzMF9GSUVMRChQTlg4MzMwXyMjcmVnLCByZWcsIGZpZWxk
KQorI2RlZmluZSBQTlg4MzM1X1JFR0ZJRUxEKHJlZywgZmllbGQpCVBOWDgzMzVfRklFTEQoUE5Y
ODMzNV8jI3JlZywgcmVnLCBmaWVsZCkKKworCisjZGVmaW5lIFBOWF9XUklURUZJRUxEKGNwdSwg
dmFsLCByZWcsIGZpZWxkKSBcCisJUE5YIyNjcHUjI18jI3JlZyA9IChQTlgjI2NwdSMjXyMjcmVn
ICYgfihQTlgjI2NwdSMjXyMjcmVnIyNfIyNmaWVsZCMjX01BU0spKSB8IFwKKwkJCQkJCSgodmFs
KSA8PCBQTlgjI2NwdSMjXyMjcmVnIyNfIyNmaWVsZCMjX1NISUZUKQorI2RlZmluZSBQTlg4MzNY
X1dSSVRFRklFTEQodmFsLCByZWcsIGZpZWxkKSBcCisJCQkJCVBOWF9XUklURUZJRUxEKDgzM1gs
IHZhbCwgcmVnLCBmaWVsZCkKKyNkZWZpbmUgUE5YODMzMF9XUklURUZJRUxEKHZhbCwgcmVnLCBm
aWVsZCkgXAorCQkJCQlQTlhfV1JJVEVGSUVMRCg4MzMwLCB2YWwsIHJlZywgZmllbGQpCisjZGVm
aW5lIFBOWDgzMzVfV1JJVEVGSUVMRCh2YWwsIHJlZywgZmllbGQpIFwKKwkJCQkJUE5YX1dSSVRF
RklFTEQoODMzNSwgdmFsLCByZWcsIGZpZWxkKQorCisKKy8qIE1hY3JvcyB0byBkZXRlY3QgQ1BV
IHR5cGUgKi8KKworI2RlZmluZSBQTlg4MzNYX0NPTkZJR19NT0RVTEVfSUQJCVBOWDgzM1hfUkVH
KDB4N0ZGQykKKyNkZWZpbmUgUE5YODMzWF9DT05GSUdfTU9EVUxFX0lEX01BSlJFVl9NQVNLCTB4
MDAwMGYwMDAKKyNkZWZpbmUgUE5YODMzWF9DT05GSUdfTU9EVUxFX0lEX01BSlJFVl9TSElGVAkx
MgorI2RlZmluZSBQTlg4MzMwX0NPTkZJR19NT0RVTEVfTUFKUkVWCQk0CisjZGVmaW5lIFBOWDgz
MzVfQ09ORklHX01PRFVMRV9NQUpSRVYJCTUKKyNkZWZpbmUgQ1BVX0lTX1BOWDgzMzAJKFBOWDgz
M1hfUkVHRklFTEQoQ09ORklHX01PRFVMRV9JRCwgTUFKUkVWKSA9PSBcCisJCQkJCVBOWDgzMzBf
Q09ORklHX01PRFVMRV9NQUpSRVYpCisjZGVmaW5lIENQVV9JU19QTlg4MzM1CShQTlg4MzNYX1JF
R0ZJRUxEKENPTkZJR19NT0RVTEVfSUQsIE1BSlJFVikgPT0gXAorCQkJCQlQTlg4MzM1X0NPTkZJ
R19NT0RVTEVfTUFKUkVWKQorCisKKworI2RlZmluZSBQTlg4MzNYX1JFU0VUX0NPTlRST0wJCVBO
WDgzM1hfUkVHKDB4ODAwNCkKKyNkZWZpbmUgUE5YODMzWF9SRVNFVF9DT05UUk9MXzIgCVBOWDgz
M1hfUkVHKDB4ODAxNCkKKworI2RlZmluZSBQTlg4MzNYX1BJQ19SRUcob2ZmcykJCVBOWDgzM1hf
UkVHKDB4MDEwMDAgKyAob2ZmcykpCisjZGVmaW5lIFBOWDgzM1hfUElDX0lOVF9QUklPUklUWQlQ
Tlg4MzNYX1BJQ19SRUcoMHgwKQorI2RlZmluZSBQTlg4MzNYX1BJQ19JTlRfU1JDCQlQTlg4MzNY
X1BJQ19SRUcoMHg0KQorI2RlZmluZSBQTlg4MzNYX1BJQ19JTlRfU1JDX0lOVF9TUkNfTUFTSwkw
eDAwMDAwRkY4dWwJLyogYml0cyAxMTozICovCisjZGVmaW5lIFBOWDgzM1hfUElDX0lOVF9TUkNf
SU5UX1NSQ19TSElGVAkzCisjZGVmaW5lIFBOWDgzM1hfUElDX0lOVF9SRUcoaXJxKQlQTlg4MzNY
X1BJQ19SRUcoMHgxMCArIDQqKGlycSkpCisKKyNkZWZpbmUgUE5YODMzWF9DTE9DS19DUFVDUF9D
VEwJUE5YODMzWF9SRUcoMHg5MjI4KQorI2RlZmluZSBQTlg4MzNYX0NMT0NLX0NQVUNQX0NUTF9F
WElUX1JFU0VUCTB4MDAwMDAwMDJ1bAkvKiBiaXQgMSAqLworI2RlZmluZSBQTlg4MzNYX0NMT0NL
X0NQVUNQX0NUTF9ESVZfQ0xPQ0tfTUFTSwkweDAwMDAwMDE4dWwJLyogYml0cyA0OjMgKi8KKyNk
ZWZpbmUgUE5YODMzWF9DTE9DS19DUFVDUF9DVExfRElWX0NMT0NLX1NISUZUCTMKKworI2RlZmlu
ZSBQTlg4MzM1X0NMT0NLX1BMTF9DUFVfQ1RMCQlQTlg4MzNYX1JFRygweDkwMjApCisjZGVmaW5l
IFBOWDgzMzVfQ0xPQ0tfUExMX0NQVV9DVExfRlJFUV9NQVNLCTB4MWYKKyNkZWZpbmUgUE5YODMz
NV9DTE9DS19QTExfQ1BVX0NUTF9GUkVRX1NISUZUCTAKKworI2RlZmluZSBQTlg4MzNYX0NPTkZJ
R19NVVgJCVBOWDgzM1hfUkVHKDB4NzAwNCkKKyNkZWZpbmUgUE5YODMzWF9DT05GSUdfTVVYX0lE
RV9NVVgJMHgwMDAwMDA4MAkJLyogYml0IDcgKi8KKworI2RlZmluZSBQTlg4MzMwX0NPTkZJR19Q
T0xZRlVTRV83CVBOWDgzM1hfUkVHKDB4NzA0MCkKKyNkZWZpbmUgUE5YODMzMF9DT05GSUdfUE9M
WUZVU0VfN19CT09UX01PREVfTUFTSwkweDAwMTgwMDAwCisjZGVmaW5lIFBOWDgzMzBfQ09ORklH
X1BPTFlGVVNFXzdfQk9PVF9NT0RFX1NISUZUCTE5CisKKyNkZWZpbmUgUE5YODMzWF9QSU9fSU4J
CVBOWDgzM1hfUkVHKDB4RjAwMCkKKyNkZWZpbmUgUE5YODMzWF9QSU9fT1VUCQlQTlg4MzNYX1JF
RygweEYwMDQpCisjZGVmaW5lIFBOWDgzM1hfUElPX0RJUgkJUE5YODMzWF9SRUcoMHhGMDA4KQor
I2RlZmluZSBQTlg4MzNYX1BJT19TRUwJCVBOWDgzM1hfUkVHKDB4RjAxNCkKKyNkZWZpbmUgUE5Y
ODMzWF9QSU9fSU5UX0VER0UJUE5YODMzWF9SRUcoMHhGMDIwKQorI2RlZmluZSBQTlg4MzNYX1BJ
T19JTlRfSEkJUE5YODMzWF9SRUcoMHhGMDI0KQorI2RlZmluZSBQTlg4MzNYX1BJT19JTlRfTE8J
UE5YODMzWF9SRUcoMHhGMDI4KQorI2RlZmluZSBQTlg4MzNYX1BJT19JTlRfU1RBVFVTCVBOWDgz
M1hfUkVHKDB4RkZFMCkKKyNkZWZpbmUgUE5YODMzWF9QSU9fSU5UX0VOQUJMRQlQTlg4MzNYX1JF
RygweEZGRTQpCisjZGVmaW5lIFBOWDgzM1hfUElPX0lOVF9DTEVBUglQTlg4MzNYX1JFRygweEZG
RTgpCisjZGVmaW5lIFBOWDgzM1hfUElPX0lOMgkJUE5YODMzWF9SRUcoMHhGMDVDKQorI2RlZmlu
ZSBQTlg4MzNYX1BJT19PVVQyCVBOWDgzM1hfUkVHKDB4RjA2MCkKKyNkZWZpbmUgUE5YODMzWF9Q
SU9fRElSMglQTlg4MzNYX1JFRygweEYwNjQpCisjZGVmaW5lIFBOWDgzM1hfUElPX1NFTDIJUE5Y
ODMzWF9SRUcoMHhGMDY4KQorCisjZGVmaW5lIFBOWDgzM1hfVUFSVDBfUE9SVFNfU1RBUlQJKFBO
WDgzM1hfQkFTRSArIDB4QjAwMCkKKyNkZWZpbmUgUE5YODMzWF9VQVJUMF9QT1JUU19FTkQJCShQ
Tlg4MzNYX0JBU0UgKyAweEJGRkYpCisjZGVmaW5lIFBOWDgzM1hfVUFSVDFfUE9SVFNfU1RBUlQJ
KFBOWDgzM1hfQkFTRSArIDB4QzAwMCkKKyNkZWZpbmUgUE5YODMzWF9VQVJUMV9QT1JUU19FTkQJ
CShQTlg4MzNYX0JBU0UgKyAweENGRkYpCisKKyNkZWZpbmUgUE5YODMzWF9VU0JfUE9SVFNfU1RB
UlQJCShQTlg4MzNYX0JBU0UgKyAweDE5MDAwKQorI2RlZmluZSBQTlg4MzNYX1VTQl9QT1JUU19F
TkQJCShQTlg4MzNYX0JBU0UgKyAweDE5RkZGKQorCisjZGVmaW5lIFBOWDgzM1hfQ09ORklHX1VT
QgkJUE5YODMzWF9SRUcoMHg3MDA4KQorCisjZGVmaW5lIFBOWDgzM1hfSTJDMF9QT1JUU19TVEFS
VAkoUE5YODMzWF9CQVNFICsgMHhEMDAwKQorI2RlZmluZSBQTlg4MzNYX0kyQzBfUE9SVFNfRU5E
CQkoUE5YODMzWF9CQVNFICsgMHhERkZGKQorI2RlZmluZSBQTlg4MzNYX0kyQzFfUE9SVFNfU1RB
UlQJKFBOWDgzM1hfQkFTRSArIDB4RTAwMCkKKyNkZWZpbmUgUE5YODMzWF9JMkMxX1BPUlRTX0VO
RAkJKFBOWDgzM1hfQkFTRSArIDB4RUZGRikKKworI2RlZmluZSBQTlg4MzNYX0lERV9QT1JUU19T
VEFSVAkJKFBOWDgzM1hfQkFTRSArIDB4MUEwMDApCisjZGVmaW5lIFBOWDgzM1hfSURFX1BPUlRT
X0VORAkJKFBOWDgzM1hfQkFTRSArIDB4MUFGRkYpCisjZGVmaW5lIFBOWDgzM1hfSURFX01PRFVM
RV9JRAkJUE5YODMzWF9SRUcoMHgxQUZGQykKKworI2RlZmluZSBQTlg4MzNYX0lERV9NT0RVTEVf
SURfTU9EVUxFX0lEX01BU0sJMHhGRkZGMDAwMAorI2RlZmluZSBQTlg4MzNYX0lERV9NT0RVTEVf
SURfTU9EVUxFX0lEX1NISUZUCTE2CisjZGVmaW5lIFBOWDgzM1hfSURFX01PRFVMRV9JRF9WQUxV
RQkJMHhBMDA5CisKKworI2RlZmluZSBQTlg4MzNYX01JVV9TRUwwCQkJUE5YODMzWF9SRUcoMHgy
MDA0KQorI2RlZmluZSBQTlg4MzNYX01JVV9TRUwwX1RJTUlORwkJUE5YODMzWF9SRUcoMHgyMDA4
KQorI2RlZmluZSBQTlg4MzNYX01JVV9TRUwxCQkJUE5YODMzWF9SRUcoMHgyMDBDKQorI2RlZmlu
ZSBQTlg4MzNYX01JVV9TRUwxX1RJTUlORwkJUE5YODMzWF9SRUcoMHgyMDEwKQorI2RlZmluZSBQ
Tlg4MzNYX01JVV9TRUwyCQkJUE5YODMzWF9SRUcoMHgyMDE0KQorI2RlZmluZSBQTlg4MzNYX01J
VV9TRUwyX1RJTUlORwkJUE5YODMzWF9SRUcoMHgyMDE4KQorI2RlZmluZSBQTlg4MzNYX01JVV9T
RUwzCQkJUE5YODMzWF9SRUcoMHgyMDFDKQorI2RlZmluZSBQTlg4MzNYX01JVV9TRUwzX1RJTUlO
RwkJUE5YODMzWF9SRUcoMHgyMDIwKQorCisjZGVmaW5lIFBOWDgzM1hfTUlVX1NFTDBfU1BJX01P
REVfRU5BQkxFX01BU0sJKDEgPDwgMTQpCisjZGVmaW5lIFBOWDgzM1hfTUlVX1NFTDBfU1BJX01P
REVfRU5BQkxFX1NISUZUCTE0CisKKyNkZWZpbmUgUE5YODMzWF9NSVVfU0VMMF9CVVJTVF9NT0RF
X0VOQUJMRV9NQVNLCSgxIDw8IDcpCisjZGVmaW5lIFBOWDgzM1hfTUlVX1NFTDBfQlVSU1RfTU9E
RV9FTkFCTEVfU0hJRlQJNworCisjZGVmaW5lIFBOWDgzM1hfTUlVX1NFTDBfQlVSU1RfUEFHRV9M
RU5fTUFTSwkoMHhGIDw8IDkpCisjZGVmaW5lIFBOWDgzM1hfTUlVX1NFTDBfQlVSU1RfUEFHRV9M
RU5fU0hJRlQJOQorCisjZGVmaW5lIFBOWDgzM1hfTUlVX0NPTkZJR19TUEkJCVBOWDgzM1hfUkVH
KDB4MjAwMCkKKworI2RlZmluZSBQTlg4MzNYX01JVV9DT05GSUdfU1BJX09QQ09ERV9NQVNLCSgw
eEZGIDw8IDMpCisjZGVmaW5lIFBOWDgzM1hfTUlVX0NPTkZJR19TUElfT1BDT0RFX1NISUZUCTMK
KworI2RlZmluZSBQTlg4MzNYX01JVV9DT05GSUdfU1BJX0RBVEFfRU5BQkxFX01BU0sJKDEgPDwg
MikKKyNkZWZpbmUgUE5YODMzWF9NSVVfQ09ORklHX1NQSV9EQVRBX0VOQUJMRV9TSElGVAkyCisK
KyNkZWZpbmUgUE5YODMzWF9NSVVfQ09ORklHX1NQSV9BRERSX0VOQUJMRV9NQVNLCSgxIDw8IDEp
CisjZGVmaW5lIFBOWDgzM1hfTUlVX0NPTkZJR19TUElfQUREUl9FTkFCTEVfU0hJRlQJMQorCisj
ZGVmaW5lIFBOWDgzM1hfTUlVX0NPTkZJR19TUElfU1lOQ19NQVNLCSgxIDw8IDApCisjZGVmaW5l
IFBOWDgzM1hfTUlVX0NPTkZJR19TUElfU1lOQ19TSElGVAkwCisKKyNkZWZpbmUgUE5YODMzWF9X
UklURV9DT05GSUdfU1BJKG9wY29kZSwgZGF0YV9lbmFibGUsIGFkZHJfZW5hYmxlLCBzeW5jKSBc
CisgICBQTlg4MzNYX01JVV9DT05GSUdfU1BJID0gXAorICAgKChvcGNvZGUpIDw8IFBOWDgzM1hf
TUlVX0NPTkZJR19TUElfT1BDT0RFX1NISUZUKSB8IFwKKyAgICgoZGF0YV9lbmFibGUpIDw8IFBO
WDgzM1hfTUlVX0NPTkZJR19TUElfREFUQV9FTkFCTEVfU0hJRlQpIHwgXAorICAgKChhZGRyX2Vu
YWJsZSkgPDwgUE5YODMzWF9NSVVfQ09ORklHX1NQSV9BRERSX0VOQUJMRV9TSElGVCkgfCBcCisg
ICAoKHN5bmMpIDw8IFBOWDgzM1hfTUlVX0NPTkZJR19TUElfU1lOQ19TSElGVCkKKworI2RlZmlu
ZSBQTlg4MzM1X0lQMzkwMl9QT1JUU19TVEFSVAkJKFBOWDgzM1hfQkFTRSArIDB4MkYwMDApCisj
ZGVmaW5lIFBOWDgzMzVfSVAzOTAyX1BPUlRTX0VORAkJKFBOWDgzM1hfQkFTRSArIDB4MkZGRkYp
CisjZGVmaW5lIFBOWDgzMzVfSVAzOTAyX01PRFVMRV9JRAkJUE5YODMzWF9SRUcoMHgyRkZGQykK
KworI2RlZmluZSBQTlg4MzM1X0lQMzkwMl9NT0RVTEVfSURfTU9EVUxFX0lEX01BU0sJCTB4RkZG
RjAwMDAKKyNkZWZpbmUgUE5YODMzNV9JUDM5MDJfTU9EVUxFX0lEX01PRFVMRV9JRF9TSElGVAkx
NgorI2RlZmluZSBQTlg4MzM1X0lQMzkwMl9NT0RVTEVfSURfVkFMVUUJCQkweDM5MDIKKworIC8q
IEkvTyBsb2NhdGlvbihnZXRzIHJlbWFwcGVkKSovCisjZGVmaW5lIFBOWDgzMzVfTkFORF9CQVNF
CSAgICAweDE4MDAwMDAwCisvKiBJL08gbG9jYXRpb24gd2l0aCBDTEUgaGlnaCAqLworI2RlZmlu
ZSBQTlg4MzM1X05BTkRfQ0xFX01BU0sJMHgwMDEwMDAwMAorLyogSS9PIGxvY2F0aW9uIHdpdGgg
QUxFIGhpZ2ggKi8KKyNkZWZpbmUgUE5YODMzNV9OQU5EX0FMRV9NQVNLCTB4MDAwMTAwMDAKKwor
I2RlZmluZSBQTlg4MzM1X1NBVEFfUE9SVFNfU1RBUlQJKFBOWDgzM1hfQkFTRSArIDB4MkUwMDAp
CisjZGVmaW5lIFBOWDgzMzVfU0FUQV9QT1JUU19FTkQJCShQTlg4MzNYX0JBU0UgKyAweDJFRkZG
KQorI2RlZmluZSBQTlg4MzM1X1NBVEFfTU9EVUxFX0lECQlQTlg4MzNYX1JFRygweDJFRkZDKQor
CisjZGVmaW5lIFBOWDgzMzVfU0FUQV9NT0RVTEVfSURfTU9EVUxFX0lEX01BU0sJMHhGRkZGMDAw
MAorI2RlZmluZSBQTlg4MzM1X1NBVEFfTU9EVUxFX0lEX01PRFVMRV9JRF9TSElGVAkxNgorI2Rl
ZmluZSBQTlg4MzM1X1NBVEFfTU9EVUxFX0lEX1ZBTFVFCQkweEEwOTkKKworI2VuZGlmCmRpZmYg
LXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5jbHVkZS9hc20tbWlw
cy9tYWNoLXBueDgzM3gvd2FyLmggbGludXgtMi42LjI2LXJjNC9pbmNsdWRlL2FzbS1taXBzL21h
Y2gtcG54ODMzeC93YXIuaAotLS0gbGludXgtMi42LjI2LXJjNC5vcmlnL2luY2x1ZGUvYXNtLW1p
cHMvbWFjaC1wbng4MzN4L3dhci5oCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAw
CisrKyBsaW51eC0yLjYuMjYtcmM0L2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L3dhci5o
CTIwMDgtMDYtMDUgMDk6MzQ6MjIuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsMjUgQEAKKy8q
CisgKiBUaGlzIGZpbGUgaXMgc3ViamVjdCB0byB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGljZW5zZS4gIFNlZSB0aGUgZmlsZSAiQ09QWUlO
RyIgaW4gdGhlIG1haW4gZGlyZWN0b3J5IG9mIHRoaXMgYXJjaGl2ZQorICogZm9yIG1vcmUgZGV0
YWlscy4KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDIsIDIwMDQsIDIwMDcgYnkgUmFsZiBCYWVj
aGxlIDxyYWxmQGxpbnV4LW1pcHMub3JnPgorICovCisjaWZuZGVmIF9fQVNNX01JUFNfTUFDSF9Q
Tlg4MzNYX1dBUl9ICisjZGVmaW5lIF9fQVNNX01JUFNfTUFDSF9QTlg4MzNYX1dBUl9ICisKKyNk
ZWZpbmUgUjQ2MDBfVjFfSU5ERVhfSUNBQ0hFT1BfV0FSCTAKKyNkZWZpbmUgUjQ2MDBfVjFfSElU
X0NBQ0hFT1BfV0FSCTAKKyNkZWZpbmUgUjQ2MDBfVjJfSElUX0NBQ0hFT1BfV0FSCTAKKyNkZWZp
bmUgUjU0MzJfQ1AwX0lOVEVSUlVQVF9XQVIJCTAKKyNkZWZpbmUgQkNNMTI1MF9NM19XQVIJCQkw
CisjZGVmaW5lIFNJQllURV8xOTU2X1dBUgkJCTAKKyNkZWZpbmUgTUlQUzRLX0lDQUNIRV9SRUZJ
TExfV0FSCTAKKyNkZWZpbmUgTUlQU19DQUNIRV9TWU5DX1dBUgkJMAorI2RlZmluZSBUWDQ5WFhf
SUNBQ0hFX0lOREVYX0lOVl9XQVIJMAorI2RlZmluZSBSTTkwMDBfQ0RFWF9TTVBfV0FSCQkwCisj
ZGVmaW5lIElDQUNIRV9SRUZJTExTX1dPUktBUk9VTkRfV0FSCTAKKyNkZWZpbmUgUjEwMDAwX0xM
U0NfV0FSCQkJMAorI2RlZmluZSBNSVBTMzRLX01JU1NFRF9JVExCX1dBUgkJMAorCisjZW5kaWYg
LyogX19BU01fTUlQU19NQUNIX1BOWDg1NTBfV0FSX0ggKi8KCg==
------=_Part_40178_9324120.1213273787394--
