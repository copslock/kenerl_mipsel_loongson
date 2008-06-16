Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 15:50:06 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.232]:36308 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20040318AbYFPOtZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 15:49:25 +0100
Received: by wr-out-0506.google.com with SMTP id 58so2984841wri.8
        for <linux-mips@linux-mips.org>; Mon, 16 Jun 2008 07:49:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:x-google-sender-auth;
        bh=zppKGtp9t7DLU28AfNzNwo9o8lX27cCa1aZGl7jxpU4=;
        b=CnzLeK1f7TwZaEKW4aNrBNey5k4ctm158s0no4LhH4YKbM26/8BaQkv5qENrjgtOCz
         DXdwKxzCGrBBSReXV0sgKill1E/n9Z1MjmjAVBO1DjXeBSsXYpo2G2Za6P0w411pgzr9
         EDUapYOhQVeCIfQiACWDjqyCOIDqMkFeugq8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :x-google-sender-auth;
        b=uIRuLqQYzxxihedfdv0fmEJcfdxBYaGvh663eY0MrTB+8b9/dcmBxQH6zCALXx9ueQ
         05VYzXyZgAbLnWHk5DoIHmlYXWS2jlp68YQQHb4YKWkVZea8FxWeV8pj2PGxPwTKyow3
         qy6Mqw6BjcRahau3lDJbHIIvShrh7GllXvsm8=
Received: by 10.90.73.17 with SMTP id v17mr7094537aga.87.1213627762249;
        Mon, 16 Jun 2008 07:49:22 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Mon, 16 Jun 2008 07:49:21 -0700 (PDT)
Message-ID: <64660ef00806160749g11c5add3m95d8bf5d46553b8e@mail.gmail.com>
Date:	Mon, 16 Jun 2008 15:49:21 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: =?WINDOWS-1256?Q?[PATCH_1/2]_:_Add_support_for_NXP_PNX833?= =?WINDOWS-1256?Q?x_(STB222/5)_into_linux_kernel=FE_(UPDATE)?=
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8336_959225.1213627762193"
X-Google-Sender-Auth: e1bda9c6311f861a
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

------=_Part_8336_959225.1213627762193
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following patch add support for the NXP PNX833x SOC.  More
specifically it adds support for the STB222/5 variant. It fixes
the vectored interrupt issue.

 arch/mips/Kconfig                           |   33
 arch/mips/Makefile                          |    8
 arch/mips/configs/pnx8335-stb225_defconfig  | 1154 ++++++++++++++++++++++++++++
 arch/mips/nxp/pnx833x/common/Makefile       |    1
 arch/mips/nxp/pnx833x/common/gdb_hook.c     |  134 +++
 arch/mips/nxp/pnx833x/common/interrupts.c   |  380 +++++++++
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
 17 files changed, 2907 insertions(+)

Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig
linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig
--- linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig	2008-06-16
13:21:41.000000000 +0100
@@ -0,0 +1,1154 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.26-rc4
+# Mon Jun 16 13:21:29 2008
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
+CONFIG_SERIAL_PNX8XXX=y
+CONFIG_SERIAL_PNX8XXX_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
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
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c	2008-06-16
14:55:50.000000000 +0100
@@ -0,0 +1,380 @@
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
+static int mips_cpu_timer_irq;
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
+static void pnx833x_timer_dispatch(void)
+{
+	do_IRQ(mips_cpu_timer_irq);
+}
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
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	if (cpu_has_vint)
+		set_vi_handler(cp0_compare_irq, pnx833x_timer_dispatch);
+
+	mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+	return mips_cpu_timer_irq;
+}
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

------=_Part_8336_959225.1213627762193
Content-Type: text/x-patch; name=nxp_pnx833x_stb225_support_update_2.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhj6m2zo1
Content-Disposition: attachment;
 filename=nxp_pnx833x_stb225_support_update_2.patch

VGhlIGZvbGxvd2luZyBwYXRjaCBhZGQgc3VwcG9ydCBmb3IgdGhlIE5YUCBQTlg4MzN4IFNPQy4g
IE1vcmUKc3BlY2lmaWNhbGx5IGl0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFNUQjIyMi81IHZhcmlh
bnQuIEl0IGZpeGVzCnRoZSB2ZWN0b3JlZCBpbnRlcnJ1cHQgaXNzdWUuCgogYXJjaC9taXBzL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMzMgCiBhcmNoL21pcHMvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgOCAKIGFyY2gvbWlwcy9jb25maWdzL3Bu
eDgzMzUtc3RiMjI1X2RlZmNvbmZpZyAgfCAxMTU0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIGFyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vTWFrZWZpbGUgICAgICAgfCAgICAxIAog
YXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5jICAgICB8ICAxMzQgKysrCiBh
cmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL2ludGVycnVwdHMuYyAgIHwgIDM4MCArKysrKysr
KysKIGFyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vcGxhdGZvcm0uYyAgICAgfCAgMzA2ICsr
KysrKysKIGFyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vcHJvbS5jICAgICAgICAgfCAgIDcw
ICsKIGFyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vcmVzZXQuYyAgICAgICAgfCAgIDQ1ICsK
IGFyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vc2V0dXAuYyAgICAgICAgfCAgIDY0ICsKIGFy
Y2gvbWlwcy9ueHAvcG54ODMzeC9zdGIyMngvTWFrZWZpbGUgICAgICAgfCAgICAxIAogYXJjaC9t
aXBzL254cC9wbng4MzN4L3N0YjIyeC9ib2FyZC5jICAgICAgICB8ICAxMzMgKysrCiBpbmNsdWRl
L2FzbS1taXBzL21hY2gtcG54ODMzeC9ncGlvLmggICAgICAgIHwgIDE3MiArKysrCiBpbmNsdWRl
L2FzbS1taXBzL21hY2gtcG54ODMzeC9pcnEtbWFwcGluZy5oIHwgIDEyNiArKysKIGluY2x1ZGUv
YXNtLW1pcHMvbWFjaC1wbng4MzN4L2lycS5oICAgICAgICAgfCAgIDUzICsKIGluY2x1ZGUvYXNt
LW1pcHMvbWFjaC1wbng4MzN4L3BueDgzM3guaCAgICAgfCAgMjAyICsrKysKIGluY2x1ZGUvYXNt
LW1pcHMvbWFjaC1wbng4MzN4L3dhci5oICAgICAgICAgfCAgIDI1IAogMTcgZmlsZXMgY2hhbmdl
ZCwgMjkwNyBpbnNlcnRpb25zKCspCgpTaWduZWQtb2ZmLWJ5OiBkYW5pZWwuai5sYWlyZCA8ZGFu
aWVsLmoubGFpcmRAbnhwLmNvbT4KCmRpZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYu
MjYtcmM0Lm9yaWcvYXJjaC9taXBzL2NvbmZpZ3MvcG54ODMzNS1zdGIyMjVfZGVmY29uZmlnIGxp
bnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL2NvbmZpZ3MvcG54ODMzNS1zdGIyMjVfZGVmY29uZmln
Ci0tLSBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL2NvbmZpZ3MvcG54ODMzNS1zdGIy
MjVfZGVmY29uZmlnCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51
eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9jb25maWdzL3BueDgzMzUtc3RiMjI1X2RlZmNvbmZpZwky
MDA4LTA2LTE2IDEzOjIxOjQxLjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDExNTQgQEAKKyMK
KyMgQXV0b21hdGljYWxseSBnZW5lcmF0ZWQgbWFrZSBjb25maWc6IGRvbid0IGVkaXQKKyMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yNi1yYzQKKyMgTW9uIEp1biAxNiAxMzoyMToyOSAyMDA4
CisjCitDT05GSUdfTUlQUz15CisKKyMKKyMgTWFjaGluZSBzZWxlY3Rpb24KKyMKKyMgQ09ORklH
X01BQ0hfQUxDSEVNWSBpcyBub3Qgc2V0CisjIENPTkZJR19CQVNMRVJfRVhDSVRFIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX0JDTTQ3WFggaXMgbm90IHNldAorIyBDT05GSUdfTUlQU19DT0JBTFQgaXMg
bm90IHNldAorIyBDT05GSUdfTUFDSF9ERUNTVEFUSU9OIGlzIG5vdCBzZXQKKyMgQ09ORklHX01B
Q0hfSkFaWiBpcyBub3Qgc2V0CisjIENPTkZJR19MQVNBVCBpcyBub3Qgc2V0CisjIENPTkZJR19M
RU1PVEVfRlVMT05HIGlzIG5vdCBzZXQKKyMgQ09ORklHX01JUFNfQVRMQVMgaXMgbm90IHNldAor
IyBDT05GSUdfTUlQU19NQUxUQSBpcyBub3Qgc2V0CisjIENPTkZJR19NSVBTX1NFQUQgaXMgbm90
IHNldAorIyBDT05GSUdfTUlQU19TSU0gaXMgbm90IHNldAorIyBDT05GSUdfTUFSS0VJTlMgaXMg
bm90IHNldAorIyBDT05GSUdfTUFDSF9WUjQxWFggaXMgbm90IHNldAorIyBDT05GSUdfTlhQX1NU
QjIyMCBpcyBub3Qgc2V0CitDT05GSUdfTlhQX1NUQjIyNT15CisjIENPTkZJR19QTlg4NTUwX0pC
UyBpcyBub3Qgc2V0CisjIENPTkZJR19QTlg4NTUwX1NUQjgxMCBpcyBub3Qgc2V0CisjIENPTkZJ
R19QTUNfTVNQIGlzIG5vdCBzZXQKKyMgQ09ORklHX1BNQ19ZT1NFTUlURSBpcyBub3Qgc2V0Cisj
IENPTkZJR19TR0lfSVAyMiBpcyBub3Qgc2V0CisjIENPTkZJR19TR0lfSVAyNyBpcyBub3Qgc2V0
CisjIENPTkZJR19TR0lfSVAyOCBpcyBub3Qgc2V0CisjIENPTkZJR19TR0lfSVAzMiBpcyBub3Qg
c2V0CisjIENPTkZJR19TSUJZVEVfQ1JISU5FIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NJQllURV9D
QVJNRUwgaXMgbm90IHNldAorIyBDT05GSUdfU0lCWVRFX0NSSE9ORSBpcyBub3Qgc2V0CisjIENP
TkZJR19TSUJZVEVfUkhPTkUgaXMgbm90IHNldAorIyBDT05GSUdfU0lCWVRFX1NXQVJNIGlzIG5v
dCBzZXQKKyMgQ09ORklHX1NJQllURV9MSVRUTEVTVVIgaXMgbm90IHNldAorIyBDT05GSUdfU0lC
WVRFX1NFTlRPU0EgaXMgbm90IHNldAorIyBDT05GSUdfU0lCWVRFX0JJR1NVUiBpcyBub3Qgc2V0
CisjIENPTkZJR19TTklfUk0gaXMgbm90IHNldAorIyBDT05GSUdfVE9TSElCQV9KTVIzOTI3IGlz
IG5vdCBzZXQKKyMgQ09ORklHX1RPU0hJQkFfUkJUWDQ5MjcgaXMgbm90IHNldAorIyBDT05GSUdf
VE9TSElCQV9SQlRYNDkzOCBpcyBub3Qgc2V0CisjIENPTkZJR19XUl9QUE1DIGlzIG5vdCBzZXQK
K0NPTkZJR19SV1NFTV9HRU5FUklDX1NQSU5MT0NLPXkKKyMgQ09ORklHX0FSQ0hfSEFTX0lMT0cy
X1UzMiBpcyBub3Qgc2V0CisjIENPTkZJR19BUkNIX0hBU19JTE9HMl9VNjQgaXMgbm90IHNldAor
Q09ORklHX0FSQ0hfU1VQUE9SVFNfT1BST0ZJTEU9eQorQ09ORklHX0dFTkVSSUNfRklORF9ORVhU
X0JJVD15CitDT05GSUdfR0VORVJJQ19IV0VJR0hUPXkKK0NPTkZJR19HRU5FUklDX0NBTElCUkFU
RV9ERUxBWT15CitDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CitDT05GSUdfR0VORVJJQ19U
SU1FPXkKK0NPTkZJR19HRU5FUklDX0NNT1NfVVBEQVRFPXkKK0NPTkZJR19TQ0hFRF9OT19OT19P
TUlUX0ZSQU1FX1BPSU5URVI9eQorQ09ORklHX0dFTkVSSUNfSEFSRElSUVNfTk9fX0RPX0lSUT15
CitDT05GSUdfQ0VWVF9SNEs9eQorQ09ORklHX0NTUkNfUjRLPXkKK0NPTkZJR19ETUFfTk9OQ09I
RVJFTlQ9eQorQ09ORklHX0RNQV9ORUVEX1BDSV9NQVBfU1RBVEU9eQorQ09ORklHX0VBUkxZX1BS
SU5USz15CitDT05GSUdfU1lTX0hBU19FQVJMWV9QUklOVEs9eQorIyBDT05GSUdfSE9UUExVR19D
UFUgaXMgbm90IHNldAorIyBDT05GSUdfTk9fSU9QT1JUIGlzIG5vdCBzZXQKK0NPTkZJR19HRU5F
UklDX0dQSU89eQorIyBDT05GSUdfQ1BVX0JJR19FTkRJQU4gaXMgbm90IHNldAorQ09ORklHX0NQ
VV9MSVRUTEVfRU5ESUFOPXkKK0NPTkZJR19TWVNfU1VQUE9SVFNfQklHX0VORElBTj15CitDT05G
SUdfU1lTX1NVUFBPUlRTX0xJVFRMRV9FTkRJQU49eQorQ09ORklHX0lSUV9DUFU9eQorQ09ORklH
X1NPQ19QTlg4MzNYPXkKK0NPTkZJR19TT0NfUE5YODMzNT15CitDT05GSUdfTUlQU19MMV9DQUNI
RV9TSElGVD01CisKKyMKKyMgQ1BVIHNlbGVjdGlvbgorIworIyBDT05GSUdfQ1BVX0xPT05HU09O
MiBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfTUlQUzMyX1IxIGlzIG5vdCBzZXQKK0NPTkZJR19D
UFVfTUlQUzMyX1IyPXkKKyMgQ09ORklHX0NQVV9NSVBTNjRfUjEgaXMgbm90IHNldAorIyBDT05G
SUdfQ1BVX01JUFM2NF9SMiBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfUjMwMDAgaXMgbm90IHNl
dAorIyBDT05GSUdfQ1BVX1RYMzlYWCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfVlI0MVhYIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0NQVV9SNDMwMCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfUjRY
MDAgaXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1RYNDlYWCBpcyBub3Qgc2V0CisjIENPTkZJR19D
UFVfUjUwMDAgaXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1I1NDMyIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0NQVV9SNjAwMCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfTkVWQURBIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0NQVV9SODAwMCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfUjEwMDAwIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0NQVV9STTcwMDAgaXMgbm90IHNldAorIyBDT05GSUdfQ1BVX1JNOTAw
MCBpcyBub3Qgc2V0CisjIENPTkZJR19DUFVfU0IxIGlzIG5vdCBzZXQKK0NPTkZJR19TWVNfSEFT
X0NQVV9NSVBTMzJfUjI9eQorQ09ORklHX0NQVV9NSVBTMzI9eQorQ09ORklHX0NQVV9NSVBTUjI9
eQorQ09ORklHX1NZU19TVVBQT1JUU18zMkJJVF9LRVJORUw9eQorQ09ORklHX0NQVV9TVVBQT1JU
U18zMkJJVF9LRVJORUw9eQorCisjCisjIEtlcm5lbCB0eXBlCisjCitDT05GSUdfMzJCSVQ9eQor
IyBDT05GSUdfNjRCSVQgaXMgbm90IHNldAorQ09ORklHX1BBR0VfU0laRV80S0I9eQorIyBDT05G
SUdfUEFHRV9TSVpFXzhLQiBpcyBub3Qgc2V0CisjIENPTkZJR19QQUdFX1NJWkVfMTZLQiBpcyBu
b3Qgc2V0CisjIENPTkZJR19QQUdFX1NJWkVfNjRLQiBpcyBub3Qgc2V0CitDT05GSUdfQ1BVX0hB
U19QUkVGRVRDSD15CitDT05GSUdfTUlQU19NVF9ESVNBQkxFRD15CisjIENPTkZJR19NSVBTX01U
X1NNUCBpcyBub3Qgc2V0CisjIENPTkZJR19NSVBTX01UX1NNVEMgaXMgbm90IHNldAorQ09ORklH
X0NQVV9IQVNfTExTQz15CitDT05GSUdfQ1BVX01JUFNSMl9JUlFfVkk9eQorQ09ORklHX0NQVV9I
QVNfU1lOQz15CitDT05GSUdfR0VORVJJQ19IQVJESVJRUz15CitDT05GSUdfR0VORVJJQ19JUlFf
UFJPQkU9eQorQ09ORklHX0NQVV9TVVBQT1JUU19ISUdITUVNPXkKK0NPTkZJR19BUkNIX0ZMQVRN
RU1fRU5BQkxFPXkKK0NPTkZJR19BUkNIX1BPUFVMQVRFU19OT0RFX01BUD15CitDT05GSUdfU0VM
RUNUX01FTU9SWV9NT0RFTD15CitDT05GSUdfRkxBVE1FTV9NQU5VQUw9eQorIyBDT05GSUdfRElT
Q09OVElHTUVNX01BTlVBTCBpcyBub3Qgc2V0CisjIENPTkZJR19TUEFSU0VNRU1fTUFOVUFMIGlz
IG5vdCBzZXQKK0NPTkZJR19GTEFUTUVNPXkKK0NPTkZJR19GTEFUX05PREVfTUVNX01BUD15Cisj
IENPTkZJR19TUEFSU0VNRU1fU1RBVElDIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NQQVJTRU1FTV9W
TUVNTUFQX0VOQUJMRSBpcyBub3Qgc2V0CitDT05GSUdfUEFHRUZMQUdTX0VYVEVOREVEPXkKK0NP
TkZJR19TUExJVF9QVExPQ0tfQ1BVUz00CisjIENPTkZJR19SRVNPVVJDRVNfNjRCSVQgaXMgbm90
IHNldAorQ09ORklHX1pPTkVfRE1BX0ZMQUc9MAorQ09ORklHX1ZJUlRfVE9fQlVTPXkKK0NPTkZJ
R19USUNLX09ORVNIT1Q9eQorQ09ORklHX05PX0haPXkKK0NPTkZJR19ISUdIX1JFU19USU1FUlM9
eQorQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQorIyBDT05GSUdfSFpfNDggaXMg
bm90IHNldAorIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKK0NPTkZJR19IWl8xMjg9eQorIyBD
T05GSUdfSFpfMjUwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0haXzI1NiBpcyBub3Qgc2V0CisjIENP
TkZJR19IWl8xMDAwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0haXzEwMjQgaXMgbm90IHNldAorQ09O
RklHX1NZU19TVVBQT1JUU19BUkJJVF9IWj15CitDT05GSUdfSFo9MTI4CisjIENPTkZJR19QUkVF
TVBUX05PTkUgaXMgbm90IHNldAorQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZPXkKKyMgQ09ORklH
X1BSRUVNUFQgaXMgbm90IHNldAorIyBDT05GSUdfS0VYRUMgaXMgbm90IHNldAorIyBDT05GSUdf
U0VDQ09NUCBpcyBub3Qgc2V0CitDT05GSUdfTE9DS0RFUF9TVVBQT1JUPXkKK0NPTkZJR19TVEFD
S1RSQUNFX1NVUFBPUlQ9eQorQ09ORklHX0RFRkNPTkZJR19MSVNUPSIvbGliL21vZHVsZXMvJFVO
QU1FX1JFTEVBU0UvLmNvbmZpZyIKKworIworIyBHZW5lcmFsIHNldHVwCisjCitDT05GSUdfRVhQ
RVJJTUVOVEFMPXkKK0NPTkZJR19CUk9LRU5fT05fU01QPXkKK0NPTkZJR19JTklUX0VOVl9BUkdf
TElNSVQ9MzIKK0NPTkZJR19MT0NBTFZFUlNJT049IiIKKyMgQ09ORklHX0xPQ0FMVkVSU0lPTl9B
VVRPIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NXQVAgaXMgbm90IHNldAorQ09ORklHX1NZU1ZJUEM9
eQorQ09ORklHX1NZU1ZJUENfU1lTQ1RMPXkKKyMgQ09ORklHX1BPU0lYX01RVUVVRSBpcyBub3Qg
c2V0CisjIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUIGlzIG5vdCBzZXQKKyMgQ09ORklHX1RBU0tT
VEFUUyBpcyBub3Qgc2V0CisjIENPTkZJR19BVURJVCBpcyBub3Qgc2V0CisjIENPTkZJR19JS0NP
TkZJRyBpcyBub3Qgc2V0CitDT05GSUdfTE9HX0JVRl9TSElGVD0xNAorIyBDT05GSUdfQ0dST1VQ
UyBpcyBub3Qgc2V0CisjIENPTkZJR19HUk9VUF9TQ0hFRCBpcyBub3Qgc2V0CitDT05GSUdfU1lT
RlNfREVQUkVDQVRFRD15CitDT05GSUdfU1lTRlNfREVQUkVDQVRFRF9WMj15CisjIENPTkZJR19S
RUxBWSBpcyBub3Qgc2V0CisjIENPTkZJR19OQU1FU1BBQ0VTIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0JMS19ERVZfSU5JVFJEIGlzIG5vdCBzZXQKK0NPTkZJR19DQ19PUFRJTUlaRV9GT1JfU0laRT15
CitDT05GSUdfU1lTQ1RMPXkKK0NPTkZJR19FTUJFRERFRD15CitDT05GSUdfU1lTQ1RMX1NZU0NB
TEw9eQorQ09ORklHX1NZU0NUTF9TWVNDQUxMX0NIRUNLPXkKK0NPTkZJR19LQUxMU1lNUz15Cisj
IENPTkZJR19LQUxMU1lNU19FWFRSQV9QQVNTIGlzIG5vdCBzZXQKK0NPTkZJR19IT1RQTFVHPXkK
K0NPTkZJR19QUklOVEs9eQorQ09ORklHX0JVRz15CitDT05GSUdfRUxGX0NPUkU9eQorQ09ORklH
X1BDU1BLUl9QTEFURk9STT15CitDT05GSUdfQ09NUEFUX0JSSz15CitDT05GSUdfQkFTRV9GVUxM
PXkKK0NPTkZJR19GVVRFWD15CitDT05GSUdfQU5PTl9JTk9ERVM9eQorQ09ORklHX0VQT0xMPXkK
K0NPTkZJR19TSUdOQUxGRD15CitDT05GSUdfVElNRVJGRD15CitDT05GSUdfRVZFTlRGRD15CitD
T05GSUdfU0hNRU09eQorQ09ORklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKK0NPTkZJR19TTEFCPXkK
KyMgQ09ORklHX1NMVUIgaXMgbm90IHNldAorIyBDT05GSUdfU0xPQiBpcyBub3Qgc2V0CisjIENP
TkZJR19QUk9GSUxJTkcgaXMgbm90IHNldAorIyBDT05GSUdfTUFSS0VSUyBpcyBub3Qgc2V0CitD
T05GSUdfSEFWRV9PUFJPRklMRT15CisjIENPTkZJR19IQVZFX0tQUk9CRVMgaXMgbm90IHNldAor
IyBDT05GSUdfSEFWRV9LUkVUUFJPQkVTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0hBVkVfRE1BX0FU
VFJTIGlzIG5vdCBzZXQKK0NPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15CitDT05GSUdfU0xBQklO
Rk89eQorQ09ORklHX1JUX01VVEVYRVM9eQorIyBDT05GSUdfVElOWV9TSE1FTSBpcyBub3Qgc2V0
CitDT05GSUdfQkFTRV9TTUFMTD0wCitDT05GSUdfTU9EVUxFUz15CisjIENPTkZJR19NT0RVTEVf
Rk9SQ0VfTE9BRCBpcyBub3Qgc2V0CitDT05GSUdfTU9EVUxFX1VOTE9BRD15CisjIENPTkZJR19N
T0RVTEVfRk9SQ0VfVU5MT0FEIGlzIG5vdCBzZXQKKyMgQ09ORklHX01PRFZFUlNJT05TIGlzIG5v
dCBzZXQKKyMgQ09ORklHX01PRFVMRV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CitDT05GSUdf
S01PRD15CitDT05GSUdfQkxPQ0s9eQorIyBDT05GSUdfTEJEIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0JMS19ERVZfSU9fVFJBQ0UgaXMgbm90IHNldAorIyBDT05GSUdfTFNGIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0JMS19ERVZfQlNHIGlzIG5vdCBzZXQKKworIworIyBJTyBTY2hlZHVsZXJzCisjCitD
T05GSUdfSU9TQ0hFRF9OT09QPXkKKyMgQ09ORklHX0lPU0NIRURfQVMgaXMgbm90IHNldAorIyBD
T05GSUdfSU9TQ0hFRF9ERUFETElORSBpcyBub3Qgc2V0CisjIENPTkZJR19JT1NDSEVEX0NGUSBp
cyBub3Qgc2V0CisjIENPTkZJR19ERUZBVUxUX0FTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RFRkFV
TFRfREVBRExJTkUgaXMgbm90IHNldAorIyBDT05GSUdfREVGQVVMVF9DRlEgaXMgbm90IHNldAor
Q09ORklHX0RFRkFVTFRfTk9PUD15CitDT05GSUdfREVGQVVMVF9JT1NDSEVEPSJub29wIgorQ09O
RklHX0NMQVNTSUNfUkNVPXkKKworIworIyBCdXMgb3B0aW9ucyAoUENJLCBQQ01DSUEsIEVJU0Es
IElTQSwgVEMpCisjCisjIENPTkZJR19BUkNIX1NVUFBPUlRTX01TSSBpcyBub3Qgc2V0CitDT05G
SUdfTU1VPXkKKyMgQ09ORklHX1BDQ0FSRCBpcyBub3Qgc2V0CisKKyMKKyMgRXhlY3V0YWJsZSBm
aWxlIGZvcm1hdHMKKyMKK0NPTkZJR19CSU5GTVRfRUxGPXkKKyMgQ09ORklHX0JJTkZNVF9NSVND
IGlzIG5vdCBzZXQKK0NPTkZJR19UUkFEX1NJR05BTFM9eQorCisjCisjIFBvd2VyIG1hbmFnZW1l
bnQgb3B0aW9ucworIworQ09ORklHX0FSQ0hfU1VTUEVORF9QT1NTSUJMRT15CitDT05GSUdfUE09
eQorIyBDT05GSUdfUE1fREVCVUcgaXMgbm90IHNldAorQ09ORklHX1BNX1NMRUVQPXkKK0NPTkZJ
R19TVVNQRU5EPXkKK0NPTkZJR19TVVNQRU5EX0ZSRUVaRVI9eQorCisjCisjIE5ldHdvcmtpbmcK
KyMKK0NPTkZJR19ORVQ9eQorCisjCisjIE5ldHdvcmtpbmcgb3B0aW9ucworIworQ09ORklHX1BB
Q0tFVD15CisjIENPTkZJR19QQUNLRVRfTU1BUCBpcyBub3Qgc2V0CitDT05GSUdfVU5JWD15CitD
T05GSUdfWEZSTT15CisjIENPTkZJR19YRlJNX1VTRVIgaXMgbm90IHNldAorIyBDT05GSUdfWEZS
TV9TVUJfUE9MSUNZIGlzIG5vdCBzZXQKKyMgQ09ORklHX1hGUk1fTUlHUkFURSBpcyBub3Qgc2V0
CisjIENPTkZJR19YRlJNX1NUQVRJU1RJQ1MgaXMgbm90IHNldAorIyBDT05GSUdfTkVUX0tFWSBp
cyBub3Qgc2V0CitDT05GSUdfSU5FVD15CitDT05GSUdfSVBfTVVMVElDQVNUPXkKKyMgQ09ORklH
X0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBub3Qgc2V0CitDT05GSUdfSVBfRklCX0hBU0g9eQorQ09O
RklHX0lQX1BOUD15CitDT05GSUdfSVBfUE5QX0RIQ1A9eQorIyBDT05GSUdfSVBfUE5QX0JPT1RQ
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0lQX1BOUF9SQVJQIGlzIG5vdCBzZXQKKyMgQ09ORklHX05F
VF9JUElQIGlzIG5vdCBzZXQKKyMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0CisjIENPTkZJ
R19JUF9NUk9VVEUgaXMgbm90IHNldAorIyBDT05GSUdfQVJQRCBpcyBub3Qgc2V0CisjIENPTkZJ
R19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0CitDT05GSUdfSU5FVF9BSD15CisjIENPTkZJR19JTkVU
X0VTUCBpcyBub3Qgc2V0CisjIENPTkZJR19JTkVUX0lQQ09NUCBpcyBub3Qgc2V0CisjIENPTkZJ
R19JTkVUX1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lORVRfVFVOTkVMIGlzIG5v
dCBzZXQKK0NPTkZJR19JTkVUX1hGUk1fTU9ERV9UUkFOU1BPUlQ9eQorQ09ORklHX0lORVRfWEZS
TV9NT0RFX1RVTk5FTD15CitDT05GSUdfSU5FVF9YRlJNX01PREVfQkVFVD15CisjIENPTkZJR19J
TkVUX0xSTyBpcyBub3Qgc2V0CitDT05GSUdfSU5FVF9ESUFHPXkKK0NPTkZJR19JTkVUX1RDUF9E
SUFHPXkKKyMgQ09ORklHX1RDUF9DT05HX0FEVkFOQ0VEIGlzIG5vdCBzZXQKK0NPTkZJR19UQ1Bf
Q09OR19DVUJJQz15CitDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0iY3ViaWMiCisjIENPTkZJR19U
Q1BfTUQ1U0lHIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lQVjYgaXMgbm90IHNldAorIyBDT05GSUdf
TkVUV09SS19TRUNNQVJLIGlzIG5vdCBzZXQKKyMgQ09ORklHX05FVEZJTFRFUiBpcyBub3Qgc2V0
CisjIENPTkZJR19JUF9EQ0NQIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNl
dAorIyBDT05GSUdfVElQQyBpcyBub3Qgc2V0CisjIENPTkZJR19BVE0gaXMgbm90IHNldAorIyBD
T05GSUdfQlJJREdFIGlzIG5vdCBzZXQKKyMgQ09ORklHX1ZMQU5fODAyMVEgaXMgbm90IHNldAor
IyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0xMQzIgaXMgbm90IHNldAorIyBD
T05GSUdfSVBYIGlzIG5vdCBzZXQKKyMgQ09ORklHX0FUQUxLIGlzIG5vdCBzZXQKKyMgQ09ORklH
X1gyNSBpcyBub3Qgc2V0CisjIENPTkZJR19MQVBCIGlzIG5vdCBzZXQKKyMgQ09ORklHX0VDT05F
VCBpcyBub3Qgc2V0CisjIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKKyMgQ09ORklHX05F
VF9TQ0hFRCBpcyBub3Qgc2V0CisKKyMKKyMgTmV0d29yayB0ZXN0aW5nCisjCisjIENPTkZJR19O
RVRfUEtUR0VOIGlzIG5vdCBzZXQKKyMgQ09ORklHX0hBTVJBRElPIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0NBTiBpcyBub3Qgc2V0CisjIENPTkZJR19JUkRBIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JU
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0FGX1JYUlBDIGlzIG5vdCBzZXQKKworIworIyBXaXJlbGVz
cworIworIyBDT05GSUdfQ0ZHODAyMTEgaXMgbm90IHNldAorIyBDT05GSUdfV0lSRUxFU1NfRVhU
IGlzIG5vdCBzZXQKKyMgQ09ORklHX01BQzgwMjExIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lFRUU4
MDIxMSBpcyBub3Qgc2V0CisjIENPTkZJR19SRktJTEwgaXMgbm90IHNldAorIyBDT05GSUdfTkVU
XzlQIGlzIG5vdCBzZXQKKworIworIyBEZXZpY2UgRHJpdmVycworIworCisjCisjIEdlbmVyaWMg
RHJpdmVyIE9wdGlvbnMKKyMKK0NPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmluL2hvdHBs
dWciCitDT05GSUdfU1RBTkRBTE9ORT15CitDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15
CitDT05GSUdfRldfTE9BREVSPXkKKyMgQ09ORklHX1NZU19IWVBFUlZJU09SIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CitDT05GSUdfTVREPXkKKyMgQ09ORklHX01U
RF9ERUJVRyBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfQ09OQ0FUIGlzIG5vdCBzZXQKK0NPTkZJ
R19NVERfUEFSVElUSU9OUz15CisjIENPTkZJR19NVERfUkVEQk9PVF9QQVJUUyBpcyBub3Qgc2V0
CitDT05GSUdfTVREX0NNRExJTkVfUEFSVFM9eQorIyBDT05GSUdfTVREX0FSN19QQVJUUyBpcyBu
b3Qgc2V0CisKKyMKKyMgVXNlciBNb2R1bGVzIEFuZCBUcmFuc2xhdGlvbiBMYXllcnMKKyMKK0NP
TkZJR19NVERfQ0hBUj15CitDT05GSUdfTVREX0JMS0RFVlM9eQorQ09ORklHX01URF9CTE9DSz15
CisjIENPTkZJR19GVEwgaXMgbm90IHNldAorIyBDT05GSUdfTkZUTCBpcyBub3Qgc2V0CisjIENP
TkZJR19JTkZUTCBpcyBub3Qgc2V0CisjIENPTkZJR19SRkRfRlRMIGlzIG5vdCBzZXQKKyMgQ09O
RklHX1NTRkRDIGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9PT1BTIGlzIG5vdCBzZXQKKworIwor
IyBSQU0vUk9NL0ZsYXNoIGNoaXAgZHJpdmVycworIworQ09ORklHX01URF9DRkk9eQorIyBDT05G
SUdfTVREX0pFREVDUFJPQkUgaXMgbm90IHNldAorQ09ORklHX01URF9HRU5fUFJPQkU9eQorQ09O
RklHX01URF9DRklfQURWX09QVElPTlM9eQorIyBDT05GSUdfTVREX0NGSV9OT1NXQVAgaXMgbm90
IHNldAorIyBDT05GSUdfTVREX0NGSV9CRV9CWVRFX1NXQVAgaXMgbm90IHNldAorQ09ORklHX01U
RF9DRklfTEVfQllURV9TV0FQPXkKK0NPTkZJR19NVERfQ0ZJX0dFT01FVFJZPXkKK0NPTkZJR19N
VERfTUFQX0JBTktfV0lEVEhfMT15CitDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzI9eQorQ09O
RklHX01URF9NQVBfQkFOS19XSURUSF80PXkKKyMgQ09ORklHX01URF9NQVBfQkFOS19XSURUSF84
IGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8xNiBpcyBub3Qgc2V0Cisj
IENPTkZJR19NVERfTUFQX0JBTktfV0lEVEhfMzIgaXMgbm90IHNldAorQ09ORklHX01URF9DRklf
STE9eQorQ09ORklHX01URF9DRklfSTI9eQorIyBDT05GSUdfTVREX0NGSV9JNCBpcyBub3Qgc2V0
CisjIENPTkZJR19NVERfQ0ZJX0k4IGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9PVFAgaXMgbm90
IHNldAorIyBDT05GSUdfTVREX0NGSV9JTlRFTEVYVCBpcyBub3Qgc2V0CitDT05GSUdfTVREX0NG
SV9BTURTVEQ9eQorIyBDT05GSUdfTVREX0NGSV9TVEFBIGlzIG5vdCBzZXQKK0NPTkZJR19NVERf
Q0ZJX1VUSUw9eQorIyBDT05GSUdfTVREX1JBTSBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfUk9N
IGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9BQlNFTlQgaXMgbm90IHNldAorCisjCisjIE1hcHBp
bmcgZHJpdmVycyBmb3IgY2hpcCBhY2Nlc3MKKyMKKyMgQ09ORklHX01URF9DT01QTEVYX01BUFBJ
TkdTIGlzIG5vdCBzZXQKK0NPTkZJR19NVERfUEhZU01BUD15CitDT05GSUdfTVREX1BIWVNNQVBf
U1RBUlQ9MHgxODAwMDAwMAorQ09ORklHX01URF9QSFlTTUFQX0xFTj0weDA0MDAwMDAwCitDT05G
SUdfTVREX1BIWVNNQVBfQkFOS1dJRFRIPTIKKyMgQ09ORklHX01URF9QTEFUUkFNIGlzIG5vdCBz
ZXQKKworIworIyBTZWxmLWNvbnRhaW5lZCBNVEQgZGV2aWNlIGRyaXZlcnMKKyMKKyMgQ09ORklH
X01URF9TTFJBTSBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfUEhSQU0gaXMgbm90IHNldAorIyBD
T05GSUdfTVREX01URFJBTSBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfQkxPQ0syTVREIGlzIG5v
dCBzZXQKKworIworIyBEaXNrLU9uLUNoaXAgRGV2aWNlIERyaXZlcnMKKyMKKyMgQ09ORklHX01U
RF9ET0MyMDAwIGlzIG5vdCBzZXQKKyMgQ09ORklHX01URF9ET0MyMDAxIGlzIG5vdCBzZXQKKyMg
Q09ORklHX01URF9ET0MyMDAxUExVUyBpcyBub3Qgc2V0CisjIENPTkZJR19NVERfTkFORCBpcyBu
b3Qgc2V0CisjIENPTkZJR19NVERfT05FTkFORCBpcyBub3Qgc2V0CisKKyMKKyMgVUJJIC0gVW5z
b3J0ZWQgYmxvY2sgaW1hZ2VzCisjCisjIENPTkZJR19NVERfVUJJIGlzIG5vdCBzZXQKKyMgQ09O
RklHX1BBUlBPUlQgaXMgbm90IHNldAorQ09ORklHX0JMS19ERVY9eQorIyBDT05GSUdfQkxLX0RF
Vl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKK0NPTkZJR19CTEtfREVWX0xPT1A9eQorIyBDT05GSUdf
QkxLX0RFVl9DUllQVE9MT09QIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0JMS19ERVZfUkFNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NEUk9NX1BL
VENEVkQgaXMgbm90IHNldAorIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQKKyMgQ09O
RklHX01JU0NfREVWSUNFUyBpcyBub3Qgc2V0CitDT05GSUdfSEFWRV9JREU9eQorIyBDT05GSUdf
SURFIGlzIG5vdCBzZXQKKworIworIyBTQ1NJIGRldmljZSBzdXBwb3J0CisjCisjIENPTkZJR19S
QUlEX0FUVFJTIGlzIG5vdCBzZXQKK0NPTkZJR19TQ1NJPXkKK0NPTkZJR19TQ1NJX0RNQT15Cisj
IENPTkZJR19TQ1NJX1RHVCBpcyBub3Qgc2V0CisjIENPTkZJR19TQ1NJX05FVExJTksgaXMgbm90
IHNldAorQ09ORklHX1NDU0lfUFJPQ19GUz15CisKKyMKKyMgU0NTSSBzdXBwb3J0IHR5cGUgKGRp
c2ssIHRhcGUsIENELVJPTSkKKyMKK0NPTkZJR19CTEtfREVWX1NEPXkKKyMgQ09ORklHX0NIUl9E
RVZfU1QgaXMgbm90IHNldAorIyBDT05GSUdfQ0hSX0RFVl9PU1NUIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0JMS19ERVZfU1IgaXMgbm90IHNldAorIyBDT05GSUdfQ0hSX0RFVl9TRyBpcyBub3Qgc2V0
CisjIENPTkZJR19DSFJfREVWX1NDSCBpcyBub3Qgc2V0CisKKyMKKyMgU29tZSBTQ1NJIGRldmlj
ZXMgKGUuZy4gQ0QganVrZWJveCkgc3VwcG9ydCBtdWx0aXBsZSBMVU5zCisjCisjIENPTkZJR19T
Q1NJX01VTFRJX0xVTiBpcyBub3Qgc2V0CisjIENPTkZJR19TQ1NJX0NPTlNUQU5UUyBpcyBub3Qg
c2V0CisjIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAorIyBDT05GSUdfU0NTSV9TQ0FO
X0FTWU5DIGlzIG5vdCBzZXQKK0NPTkZJR19TQ1NJX1dBSVRfU0NBTj1tCisKKyMKKyMgU0NTSSBU
cmFuc3BvcnRzCisjCisjIENPTkZJR19TQ1NJX1NQSV9BVFRSUyBpcyBub3Qgc2V0CisjIENPTkZJ
R19TQ1NJX0ZDX0FUVFJTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMg
bm90IHNldAorIyBDT05GSUdfU0NTSV9TQVNfTElCU0FTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1ND
U0lfU1JQX0FUVFJTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NDU0lfTE9XTEVWRUwgaXMgbm90IHNl
dAorQ09ORklHX0FUQT15CisjIENPTkZJR19BVEFfTk9OU1RBTkRBUkQgaXMgbm90IHNldAorQ09O
RklHX1NBVEFfUE1QPXkKK0NPTkZJR19BVEFfU0ZGPXkKKyMgQ09ORklHX1NBVEFfTVYgaXMgbm90
IHNldAorIyBDT05GSUdfUEFUQV9QTEFURk9STSBpcyBub3Qgc2V0CisjIENPTkZJR19NRCBpcyBu
b3Qgc2V0CitDT05GSUdfTkVUREVWSUNFUz15CisjIENPTkZJR19ORVRERVZJQ0VTX01VTFRJUVVF
VUUgaXMgbm90IHNldAorIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldAorIyBDT05GSUdfQk9ORElO
RyBpcyBub3Qgc2V0CisjIENPTkZJR19NQUNWTEFOIGlzIG5vdCBzZXQKKyMgQ09ORklHX0VRVUFM
SVpFUiBpcyBub3Qgc2V0CisjIENPTkZJR19UVU4gaXMgbm90IHNldAorIyBDT05GSUdfVkVUSCBp
cyBub3Qgc2V0CisjIENPTkZJR19QSFlMSUIgaXMgbm90IHNldAorQ09ORklHX05FVF9FVEhFUk5F
VD15CitDT05GSUdfTUlJPXkKKyMgQ09ORklHX0FYODg3OTYgaXMgbm90IHNldAorIyBDT05GSUdf
RE05MDAwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lCTV9ORVdfRU1BQ19aTUlJIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0lCTV9ORVdfRU1BQ19SR01JSSBpcyBub3Qgc2V0CisjIENPTkZJR19JQk1fTkVX
X0VNQUNfVEFIIGlzIG5vdCBzZXQKKyMgQ09ORklHX0lCTV9ORVdfRU1BQ19FTUFDNCBpcyBub3Qg
c2V0CisjIENPTkZJR19CNDQgaXMgbm90IHNldAorIyBDT05GSUdfSVAzOTAyIGlzIG5vdCBzZXQK
KyMgQ09ORklHX05FVERFVl8xMDAwIGlzIG5vdCBzZXQKKyMgQ09ORklHX05FVERFVl8xMDAwMCBp
cyBub3Qgc2V0CisKKyMKKyMgV2lyZWxlc3MgTEFOCisjCisjIENPTkZJR19XTEFOX1BSRTgwMjEx
IGlzIG5vdCBzZXQKKyMgQ09ORklHX1dMQU5fODAyMTEgaXMgbm90IHNldAorIyBDT05GSUdfSVdM
V0lGSV9MRURTIGlzIG5vdCBzZXQKKyMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CisjIENPTkZJR19Q
UFAgaXMgbm90IHNldAorIyBDT05GSUdfU0xJUCBpcyBub3Qgc2V0CisjIENPTkZJR19ORVRDT05T
T0xFIGlzIG5vdCBzZXQKKyMgQ09ORklHX05FVFBPTEwgaXMgbm90IHNldAorIyBDT05GSUdfTkVU
X1BPTExfQ09OVFJPTExFUiBpcyBub3Qgc2V0CisjIENPTkZJR19JU0ROIGlzIG5vdCBzZXQKKyMg
Q09ORklHX1BIT05FIGlzIG5vdCBzZXQKKworIworIyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAorIwor
Q09ORklHX0lOUFVUPXkKKyMgQ09ORklHX0lOUFVUX0ZGX01FTUxFU1MgaXMgbm90IHNldAorIyBD
T05GSUdfSU5QVVRfUE9MTERFViBpcyBub3Qgc2V0CisKKyMKKyMgVXNlcmxhbmQgaW50ZXJmYWNl
cworIworIyBDT05GSUdfSU5QVVRfTU9VU0VERVYgaXMgbm90IHNldAorIyBDT05GSUdfSU5QVVRf
Sk9ZREVWIGlzIG5vdCBzZXQKK0NPTkZJR19JTlBVVF9FVkRFVj1tCitDT05GSUdfSU5QVVRfRVZC
VUc9bQorCisjCisjIElucHV0IERldmljZSBEcml2ZXJzCisjCisjIENPTkZJR19JTlBVVF9LRVlC
T0FSRCBpcyBub3Qgc2V0CisjIENPTkZJR19JTlBVVF9NT1VTRSBpcyBub3Qgc2V0CisjIENPTkZJ
R19JTlBVVF9KT1lTVElDSyBpcyBub3Qgc2V0CisjIENPTkZJR19JTlBVVF9UQUJMRVQgaXMgbm90
IHNldAorIyBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4gaXMgbm90IHNldAorIyBDT05GSUdfSU5Q
VVRfTUlTQyBpcyBub3Qgc2V0CisKKyMKKyMgSGFyZHdhcmUgSS9PIHBvcnRzCisjCitDT05GSUdf
U0VSSU89eQorIyBDT05GSUdfU0VSSU9fSTgwNDIgaXMgbm90IHNldAorQ09ORklHX1NFUklPX1NF
UlBPUlQ9eQorIyBDT05GSUdfU0VSSU9fTElCUFMyIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFUklP
X1JBVyBpcyBub3Qgc2V0CisjIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CisKKyMKKyMgQ2hh
cmFjdGVyIGRldmljZXMKKyMKK0NPTkZJR19WVD15CisjIENPTkZJR19WVF9DT05TT0xFIGlzIG5v
dCBzZXQKK0NPTkZJR19IV19DT05TT0xFPXkKKyMgQ09ORklHX1ZUX0hXX0NPTlNPTEVfQklORElO
RyBpcyBub3Qgc2V0CitDT05GSUdfREVWS01FTT15CisjIENPTkZJR19TRVJJQUxfTk9OU1RBTkRB
UkQgaXMgbm90IHNldAorCisjCisjIFNlcmlhbCBkcml2ZXJzCisjCisjIENPTkZJR19TRVJJQUxf
ODI1MCBpcyBub3Qgc2V0CisKKyMKKyMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAorIwor
Q09ORklHX1NFUklBTF9QTlg4WFhYPXkKK0NPTkZJR19TRVJJQUxfUE5YOFhYWF9DT05TT0xFPXkK
K0NPTkZJR19TRVJJQUxfQ09SRT15CitDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CitDT05G
SUdfVU5JWDk4X1BUWVM9eQorIyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90IHNldAorIyBDT05G
SUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKK0NPTkZJR19IV19SQU5ET009eQorIyBDT05GSUdf
UjM5NjQgaXMgbm90IHNldAorIyBDT05GSUdfUkFXX0RSSVZFUiBpcyBub3Qgc2V0CisjIENPTkZJ
R19UQ0dfVFBNIGlzIG5vdCBzZXQKK0NPTkZJR19JMkM9eQorQ09ORklHX0kyQ19CT0FSRElORk89
eQorQ09ORklHX0kyQ19DSEFSREVWPXkKK0NPTkZJR19JMkNfQUxHT1BDQT15CisKKyMKKyMgSTJD
IEhhcmR3YXJlIEJ1cyBzdXBwb3J0CisjCisjIENPTkZJR19JMkNfR1BJTyBpcyBub3Qgc2V0Cisj
IENPTkZJR19JMkNfT0NPUkVTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19QQVJQT1JUX0xJR0hU
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19TSU1URUMgaXMgbm90IHNldAorIyBDT05GSUdfSTJD
X1RBT1NfRVZNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0kyQ19QQ0FfUExBVEZPUk0gaXMgbm90IHNldAorQ09ORklHX0kyQ19QTlgwMTA1PXkKKwor
IworIyBNaXNjZWxsYW5lb3VzIEkyQyBDaGlwIHN1cHBvcnQKKyMKKyMgQ09ORklHX0RTMTY4MiBp
cyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX0VFUFJPTSBpcyBub3Qgc2V0CisjIENPTkZJR19T
RU5TT1JTX1BDRjg1NzQgaXMgbm90IHNldAorIyBDT05GSUdfUENGODU3NSBpcyBub3Qgc2V0Cisj
IENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNldAorIyBDT05GSUdfU0VOU09SU19NQVg2
ODc1IGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFTlNPUlNfVFNMMjU1MCBpcyBub3Qgc2V0CisjIENP
TkZJR19JMkNfREVCVUdfQ09SRSBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfREVCVUdfQUxHTyBp
cyBub3Qgc2V0CisjIENPTkZJR19JMkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ky
Q19ERUJVR19DSElQIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CisjIENPTkZJ
R19XMSBpcyBub3Qgc2V0CisjIENPTkZJR19QT1dFUl9TVVBQTFkgaXMgbm90IHNldAorIyBDT05G
SUdfSFdNT04gaXMgbm90IHNldAorIyBDT05GSUdfVEhFUk1BTCBpcyBub3Qgc2V0CisjIENPTkZJ
R19XQVRDSERPRyBpcyBub3Qgc2V0CisKKyMKKyMgU29uaWNzIFNpbGljb24gQmFja3BsYW5lCisj
CitDT05GSUdfU1NCX1BPU1NJQkxFPXkKKyMgQ09ORklHX1NTQiBpcyBub3Qgc2V0CisKKyMKKyMg
TXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycworIworIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0hUQ19QQVNJQzMgaXMgbm90IHNldAorCisjCisjIE11bHRpbWVkaWEg
ZGV2aWNlcworIworCisjCisjIE11bHRpbWVkaWEgY29yZSBzdXBwb3J0CisjCisjIENPTkZJR19W
SURFT19ERVYgaXMgbm90IHNldAorQ09ORklHX0RWQl9DT1JFPXkKK0NPTkZJR19WSURFT19NRURJ
QT15CisKKyMKKyMgTXVsdGltZWRpYSBkcml2ZXJzCisjCisjIENPTkZJR19NRURJQV9BVFRBQ0gg
aXMgbm90IHNldAorQ09ORklHX01FRElBX1RVTkVSPXkKKyMgQ09ORklHX01FRElBX1RVTkVSX0NV
U1RPTUlaRSBpcyBub3Qgc2V0CitDT05GSUdfTUVESUFfVFVORVJfU0lNUExFPXkKK0NPTkZJR19N
RURJQV9UVU5FUl9UREE4MjkwPXkKK0NPTkZJR19NRURJQV9UVU5FUl9UREE5ODg3PXkKK0NPTkZJ
R19NRURJQV9UVU5FUl9URUE1NzYxPXkKK0NPTkZJR19NRURJQV9UVU5FUl9URUE1NzY3PXkKK0NP
TkZJR19NRURJQV9UVU5FUl9NVDIwWFg9eQorQ09ORklHX01FRElBX1RVTkVSX1hDMjAyOD15CitD
T05GSUdfTUVESUFfVFVORVJfWEM1MDAwPXkKK0NPTkZJR19EVkJfQ0FQVFVSRV9EUklWRVJTPXkK
KyMgQ09ORklHX1RUUENJX0VFUFJPTSBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfQjJDMl9GTEVY
Q09QIGlzIG5vdCBzZXQKKworIworIyBTdXBwb3J0ZWQgRFZCIEZyb250ZW5kcworIworCisjCisj
IEN1c3RvbWlzZSBEVkIgRnJvbnRlbmRzCisjCisjIENPTkZJR19EVkJfRkVfQ1VTVE9NSVNFIGlz
IG5vdCBzZXQKKworIworIyBEVkItUyAoc2F0ZWxsaXRlKSBmcm9udGVuZHMKKyMKKyMgQ09ORklH
X0RWQl9DWDI0MTEwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9DWDI0MTIzIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0RWQl9NVDMxMiBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfUzVIMTQyMCBpcyBu
b3Qgc2V0CisjIENPTkZJR19EVkJfU1RWMDI5OSBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfVERB
ODA4MyBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfVERBMTAwODYgaXMgbm90IHNldAorIyBDT05G
SUdfRFZCX1ZFUzFYOTMgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX1RVTkVSX0lURDEwMDAgaXMg
bm90IHNldAorIyBDT05GSUdfRFZCX1REQTgyNlggaXMgbm90IHNldAorIyBDT05GSUdfRFZCX1RV
QTYxMDAgaXMgbm90IHNldAorCisjCisjIERWQi1UICh0ZXJyZXN0cmlhbCkgZnJvbnRlbmRzCisj
CisjIENPTkZJR19EVkJfU1A4ODcwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9TUDg4N1ggaXMg
bm90IHNldAorIyBDT05GSUdfRFZCX0NYMjI3MDAgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0NY
MjI3MDIgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0w2NDc4MSBpcyBub3Qgc2V0CitDT05GSUdf
RFZCX1REQTEwMDRYPXkKKyMgQ09ORklHX0RWQl9OWFQ2MDAwIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0RWQl9NVDM1MiBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfWkwxMDM1MyBpcyBub3Qgc2V0Cisj
IENPTkZJR19EVkJfRElCMzAwME1CIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9ESUIzMDAwTUMg
aXMgbm90IHNldAorIyBDT05GSUdfRFZCX0RJQjcwMDBNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RW
Ql9ESUI3MDAwUCBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfVERBMTAwNDggaXMgbm90IHNldAor
CisjCisjIERWQi1DIChjYWJsZSkgZnJvbnRlbmRzCisjCisjIENPTkZJR19EVkJfVkVTMTgyMCBp
cyBub3Qgc2V0CisjIENPTkZJR19EVkJfVERBMTAwMjEgaXMgbm90IHNldAorIyBDT05GSUdfRFZC
X1REQTEwMDIzIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9TVFYwMjk3IGlzIG5vdCBzZXQKKwor
IworIyBBVFNDIChOb3J0aCBBbWVyaWNhbi9Lb3JlYW4gVGVycmVzdHJpYWwvQ2FibGUgRFRWKSBm
cm9udGVuZHMKKyMKKyMgQ09ORklHX0RWQl9OWFQyMDBYIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RW
Ql9PUjUxMjExIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9PUjUxMTMyIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0RWQl9CQ00zNTEwIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9MR0RUMzMwWCBpcyBu
b3Qgc2V0CisjIENPTkZJR19EVkJfUzVIMTQwOSBpcyBub3Qgc2V0CisjIENPTkZJR19EVkJfQVU4
NTIyIGlzIG5vdCBzZXQKKyMgQ09ORklHX0RWQl9TNUgxNDExIGlzIG5vdCBzZXQKKworIworIyBE
aWdpdGFsIHRlcnJlc3RyaWFsIG9ubHkgdHVuZXJzL1BMTAorIworIyBDT05GSUdfRFZCX1BMTCBp
cyBub3Qgc2V0CisjIENPTkZJR19EVkJfVFVORVJfRElCMDA3MCBpcyBub3Qgc2V0CisKKyMKKyMg
U0VDIGNvbnRyb2wgZGV2aWNlcyBmb3IgRFZCLVMKKyMKKyMgQ09ORklHX0RWQl9MTkJQMjEgaXMg
bm90IHNldAorIyBDT05GSUdfRFZCX0lTTDY0MDUgaXMgbm90IHNldAorIyBDT05GSUdfRFZCX0lT
TDY0MjEgaXMgbm90IHNldAorIyBDT05GSUdfREFCIGlzIG5vdCBzZXQKKworIworIyBHcmFwaGlj
cyBzdXBwb3J0CisjCisjIENPTkZJR19WR0FTVEFURSBpcyBub3Qgc2V0CisjIENPTkZJR19WSURF
T19PVVRQVVRfQ09OVFJPTCBpcyBub3Qgc2V0CitDT05GSUdfRkI9eQorIyBDT05GSUdfRklSTVdB
UkVfRURJRCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9EREMgaXMgbm90IHNldAorIyBDT05GSUdf
RkJfQ0ZCX0ZJTExSRUNUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0NGQl9DT1BZQVJFQSBpcyBu
b3Qgc2V0CisjIENPTkZJR19GQl9DRkJfSU1BR0VCTElUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZC
X0NGQl9SRVZfUElYRUxTX0lOX0JZVEUgaXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0ZJTExS
RUNUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NZU19DT1BZQVJFQSBpcyBub3Qgc2V0CisjIENP
TkZJR19GQl9TWVNfSU1BR0VCTElUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0ZPUkVJR05fRU5E
SUFOIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NZU19GT1BTIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0ZCX1NWR0FMSUIgaXMgbm90IHNldAorIyBDT05GSUdfRkJfTUFDTU9ERVMgaXMgbm90IHNldAor
IyBDT05GSUdfRkJfQkFDS0xJR0hUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX01PREVfSEVMUEVS
UyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9USUxFQkxJVFRJTkcgaXMgbm90IHNldAorCisjCisj
IEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2ZXJzCisjCisjIENPTkZJR19GQl9TMUQxM1hYWCBp
cyBub3Qgc2V0CisjIENPTkZJR19GQl9WSVJUVUFMIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JBQ0tM
SUdIVF9MQ0RfU1VQUE9SVCBpcyBub3Qgc2V0CisKKyMKKyMgRGlzcGxheSBkZXZpY2Ugc3VwcG9y
dAorIworIyBDT05GSUdfRElTUExBWV9TVVBQT1JUIGlzIG5vdCBzZXQKKworIworIyBDb25zb2xl
IGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKKyMKKyMgQ09ORklHX1ZHQV9DT05TT0xFIGlzIG5vdCBz
ZXQKK0NPTkZJR19EVU1NWV9DT05TT0xFPXkKKyMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEUg
aXMgbm90IHNldAorIyBDT05GSUdfTE9HTyBpcyBub3Qgc2V0CisKKyMKKyMgU291bmQKKyMKK0NP
TkZJR19TT1VORD1tCisKKyMKKyMgQWR2YW5jZWQgTGludXggU291bmQgQXJjaGl0ZWN0dXJlCisj
CitDT05GSUdfU05EPW0KK0NPTkZJR19TTkRfVElNRVI9bQorQ09ORklHX1NORF9QQ009bQorQ09O
RklHX1NORF9TRVFVRU5DRVI9bQorIyBDT05GSUdfU05EX1NFUV9EVU1NWSBpcyBub3Qgc2V0CitD
T05GSUdfU05EX09TU0VNVUw9eQorQ09ORklHX1NORF9NSVhFUl9PU1M9bQorQ09ORklHX1NORF9Q
Q01fT1NTPW0KK0NPTkZJR19TTkRfUENNX09TU19QTFVHSU5TPXkKK0NPTkZJR19TTkRfU0VRVUVO
Q0VSX09TUz15CisjIENPTkZJR19TTkRfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAorQ09ORklH
X1NORF9TVVBQT1JUX09MRF9BUEk9eQorQ09ORklHX1NORF9WRVJCT1NFX1BST0NGUz15CitDT05G
SUdfU05EX1ZFUkJPU0VfUFJJTlRLPXkKK0NPTkZJR19TTkRfREVCVUc9eQorQ09ORklHX1NORF9E
RUJVR19ERVRFQ1Q9eQorIyBDT05GSUdfU05EX1BDTV9YUlVOX0RFQlVHIGlzIG5vdCBzZXQKKwor
IworIyBHZW5lcmljIGRldmljZXMKKyMKKyMgQ09ORklHX1NORF9EVU1NWSBpcyBub3Qgc2V0Cisj
IENPTkZJR19TTkRfVklSTUlESSBpcyBub3Qgc2V0CisjIENPTkZJR19TTkRfTVRQQVYgaXMgbm90
IHNldAorIyBDT05GSUdfU05EX1NFUklBTF9VMTY1NTAgaXMgbm90IHNldAorIyBDT05GSUdfU05E
X01QVTQwMSBpcyBub3Qgc2V0CisKKyMKKyMgQUxTQSBNSVBTIGRldmljZXMKKyMKKworIworIyBT
eXN0ZW0gb24gQ2hpcCBhdWRpbyBzdXBwb3J0CisjCisjIENPTkZJR19TTkRfU09DIGlzIG5vdCBz
ZXQKKworIworIyBBTFNBIFNvQyBhdWRpbyBmb3IgRnJlZXNjYWxlIFNPQ3MKKyMKKworIworIyBT
b0MgQXVkaW8gZm9yIHRoZSBUZXhhcyBJbnN0cnVtZW50cyBPTUFQCisjCisKKyMKKyMgT3BlbiBT
b3VuZCBTeXN0ZW0KKyMKKyMgQ09ORklHX1NPVU5EX1BSSU1FIGlzIG5vdCBzZXQKK0NPTkZJR19I
SURfU1VQUE9SVD15CitDT05GSUdfSElEPXkKKyMgQ09ORklHX0hJRF9ERUJVRyBpcyBub3Qgc2V0
CisjIENPTkZJR19ISURSQVcgaXMgbm90IHNldAorQ09ORklHX1VTQl9TVVBQT1JUPXkKKyMgQ09O
RklHX1VTQl9BUkNIX0hBU19IQ0QgaXMgbm90IHNldAorIyBDT05GSUdfVVNCX0FSQ0hfSEFTX09I
Q0kgaXMgbm90IHNldAorIyBDT05GSUdfVVNCX0FSQ0hfSEFTX0VIQ0kgaXMgbm90IHNldAorIyBD
T05GSUdfVVNCX09UR19XSElURUxJU1QgaXMgbm90IHNldAorIyBDT05GSUdfVVNCX09UR19CTEFD
S0xJU1RfSFVCIGlzIG5vdCBzZXQKKworIworIyBOT1RFOiBVU0JfU1RPUkFHRSBlbmFibGVzIFND
U0ksIGFuZCAnU0NTSSBkaXNrIHN1cHBvcnQnCisjCisjIENPTkZJR19VU0JfR0FER0VUIGlzIG5v
dCBzZXQKKyMgQ09ORklHX01NQyBpcyBub3Qgc2V0CisjIENPTkZJR19NRU1TVElDSyBpcyBub3Qg
c2V0CisjIENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0CisjIENPTkZJR19BQ0NFU1NJQklMSVRZ
IGlzIG5vdCBzZXQKK0NPTkZJR19SVENfTElCPXkKKyMgQ09ORklHX1JUQ19DTEFTUyBpcyBub3Qg
c2V0CisjIENPTkZJR19VSU8gaXMgbm90IHNldAorCisjCisjIEZpbGUgc3lzdGVtcworIworQ09O
RklHX0VYVDJfRlM9bQorIyBDT05GSUdfRVhUMl9GU19YQVRUUiBpcyBub3Qgc2V0CisjIENPTkZJ
R19FWFQyX0ZTX1hJUCBpcyBub3Qgc2V0CisjIENPTkZJR19FWFQzX0ZTIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0VYVDRERVZfRlMgaXMgbm90IHNldAorIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90
IHNldAorIyBDT05GSUdfSkZTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZTX1BPU0lYX0FDTCBp
cyBub3Qgc2V0CisjIENPTkZJR19YRlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdfT0NGUzJfRlMg
aXMgbm90IHNldAorIyBDT05GSUdfRE5PVElGWSBpcyBub3Qgc2V0CitDT05GSUdfSU5PVElGWT15
CitDT05GSUdfSU5PVElGWV9VU0VSPXkKKyMgQ09ORklHX1FVT1RBIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CisjIENPTkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQK
KyMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAorCisjCisjIENELVJPTS9EVkQgRmlsZXN5c3Rl
bXMKKyMKKyMgQ09ORklHX0lTTzk2NjBfRlMgaXMgbm90IHNldAorIyBDT05GSUdfVURGX0ZTIGlz
IG5vdCBzZXQKKworIworIyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCisjCitDT05GSUdfRkFUX0ZT
PW0KK0NPTkZJR19NU0RPU19GUz1tCitDT05GSUdfVkZBVF9GUz1tCitDT05GSUdfRkFUX0RFRkFV
TFRfQ09ERVBBR0U9NDM3CitDT05GSUdfRkFUX0RFRkFVTFRfSU9DSEFSU0VUPSJpc284ODU5LTEi
CisjIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKKworIworIyBQc2V1ZG8gZmlsZXN5c3RlbXMK
KyMKK0NPTkZJR19QUk9DX0ZTPXkKKyMgQ09ORklHX1BST0NfS0NPUkUgaXMgbm90IHNldAorQ09O
RklHX1BST0NfU1lTQ1RMPXkKK0NPTkZJR19TWVNGUz15CitDT05GSUdfVE1QRlM9eQorIyBDT05G
SUdfVE1QRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKKyMgQ09ORklHX0hVR0VUTEJfUEFHRSBpcyBu
b3Qgc2V0CisjIENPTkZJR19DT05GSUdGU19GUyBpcyBub3Qgc2V0CisKKyMKKyMgTWlzY2VsbGFu
ZW91cyBmaWxlc3lzdGVtcworIworIyBDT05GSUdfQURGU19GUyBpcyBub3Qgc2V0CisjIENPTkZJ
R19BRkZTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0hGU19GUyBpcyBub3Qgc2V0CisjIENPTkZJ
R19IRlNQTFVTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAorIyBD
T05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0VGU19GUyBpcyBub3Qgc2V0CitDT05G
SUdfSkZGUzJfRlM9eQorQ09ORklHX0pGRlMyX0ZTX0RFQlVHPTAKK0NPTkZJR19KRkZTMl9GU19X
UklURUJVRkZFUj15CisjIENPTkZJR19KRkZTMl9GU19XQlVGX1ZFUklGWSBpcyBub3Qgc2V0Cisj
IENPTkZJR19KRkZTMl9TVU1NQVJZIGlzIG5vdCBzZXQKKyMgQ09ORklHX0pGRlMyX0ZTX1hBVFRS
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0pGRlMyX0NPTVBSRVNTSU9OX09QVElPTlMgaXMgbm90IHNl
dAorQ09ORklHX0pGRlMyX1pMSUI9eQorIyBDT05GSUdfSkZGUzJfTFpPIGlzIG5vdCBzZXQKK0NP
TkZJR19KRkZTMl9SVElNRT15CisjIENPTkZJR19KRkZTMl9SVUJJTiBpcyBub3Qgc2V0CitDT05G
SUdfQ1JBTUZTPXkKKyMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdfTUlOSVhf
RlMgaXMgbm90IHNldAorIyBDT05GSUdfSFBGU19GUyBpcyBub3Qgc2V0CisjIENPTkZJR19RTlg0
RlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNldAorIyBDT05GSUdf
U1lTVl9GUyBpcyBub3Qgc2V0CisjIENPTkZJR19VRlNfRlMgaXMgbm90IHNldAorQ09ORklHX05F
VFdPUktfRklMRVNZU1RFTVM9eQorQ09ORklHX05GU19GUz15CitDT05GSUdfTkZTX1YzPXkKKyMg
Q09ORklHX05GU19WM19BQ0wgaXMgbm90IHNldAorIyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBzZXQK
K0NPTkZJR19ORlNEPW0KK0NPTkZJR19ORlNEX1YzPXkKKyMgQ09ORklHX05GU0RfVjNfQUNMIGlz
IG5vdCBzZXQKKyMgQ09ORklHX05GU0RfVjQgaXMgbm90IHNldAorQ09ORklHX1JPT1RfTkZTPXkK
K0NPTkZJR19MT0NLRD15CitDT05GSUdfTE9DS0RfVjQ9eQorQ09ORklHX0VYUE9SVEZTPW0KK0NP
TkZJR19ORlNfQ09NTU9OPXkKK0NPTkZJR19TVU5SUEM9eQorIyBDT05GSUdfU1VOUlBDX0JJTkQz
NCBpcyBub3Qgc2V0CisjIENPTkZJR19SUENTRUNfR1NTX0tSQjUgaXMgbm90IHNldAorIyBDT05G
SUdfUlBDU0VDX0dTU19TUEtNMyBpcyBub3Qgc2V0CisjIENPTkZJR19TTUJfRlMgaXMgbm90IHNl
dAorIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CisjIENPTkZJR19OQ1BfRlMgaXMgbm90IHNldAor
IyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CisjIENPTkZJR19BRlNfRlMgaXMgbm90IHNldAor
CisjCisjIFBhcnRpdGlvbiBUeXBlcworIworIyBDT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEIGlz
IG5vdCBzZXQKK0NPTkZJR19NU0RPU19QQVJUSVRJT049eQorQ09ORklHX05MUz15CitDT05GSUdf
TkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKK0NPTkZJR19OTFNfQ09ERVBBR0VfNDM3PW0KKyMgQ09O
RklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzc3
NSBpcyBub3Qgc2V0CitDT05GSUdfTkxTX0NPREVQQUdFXzg1MD1tCisjIENPTkZJR19OTFNfQ09E
RVBBR0VfODUyIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19DT0RFUEFHRV84NTUgaXMgbm90IHNl
dAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfQ09E
RVBBR0VfODYwIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19DT0RFUEFHRV84NjEgaXMgbm90IHNl
dAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfQ09E
RVBBR0VfODYzIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19DT0RFUEFHRV84NjQgaXMgbm90IHNl
dAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfQ09E
RVBBR0VfODY2IGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19DT0RFUEFHRV84NjkgaXMgbm90IHNl
dAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfQ09E
RVBBR0VfOTUwIGlzIG5vdCBzZXQKK0NPTkZJR19OTFNfQ09ERVBBR0VfOTMyPW0KKyMgQ09ORklH
X05MU19DT0RFUEFHRV85NDkgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0NPREVQQUdFXzg3NCBp
cyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQKKyMgQ09ORklHX05M
U19DT0RFUEFHRV8xMjUwIGlzIG5vdCBzZXQKKyMgQ09ORklHX05MU19DT0RFUEFHRV8xMjUxIGlz
IG5vdCBzZXQKK0NPTkZJR19OTFNfQVNDSUk9bQorQ09ORklHX05MU19JU084ODU5XzE9bQorIyBD
T05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV8zIGlz
IG5vdCBzZXQKKyMgQ09ORklHX05MU19JU084ODU5XzQgaXMgbm90IHNldAorIyBDT05GSUdfTkxT
X0lTTzg4NTlfNSBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5vdCBzZXQK
KyMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90IHNldAorIyBDT05GSUdfTkxTX0lTTzg4NTlf
OSBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CisjIENPTkZJ
R19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CitDT05GSUdfTkxTX0lTTzg4NTlfMTU9bQorIyBD
T05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CisjIENPTkZJR19OTFNfS09JOF9VIGlzIG5vdCBz
ZXQKK0NPTkZJR19OTFNfVVRGOD1tCisjIENPTkZJR19ETE0gaXMgbm90IHNldAorCisjCisjIEtl
cm5lbCBoYWNraW5nCisjCitDT05GSUdfVFJBQ0VfSVJRRkxBR1NfU1VQUE9SVD15CisjIENPTkZJ
R19QUklOVEtfVElNRSBpcyBub3Qgc2V0CitDT05GSUdfRU5BQkxFX1dBUk5fREVQUkVDQVRFRD15
CitDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9eQorQ09ORklHX0ZSQU1FX1dBUk49MTAyNAorIyBD
T05GSUdfTUFHSUNfU1lTUlEgaXMgbm90IHNldAorIyBDT05GSUdfVU5VU0VEX1NZTUJPTFMgaXMg
bm90IHNldAorIyBDT05GSUdfREVCVUdfRlMgaXMgbm90IHNldAorIyBDT05GSUdfSEVBREVSU19D
SEVDSyBpcyBub3Qgc2V0CisjIENPTkZJR19ERUJVR19LRVJORUwgaXMgbm90IHNldAorIyBDT05G
SUdfU0FNUExFUyBpcyBub3Qgc2V0CitDT05GSUdfQ01ETElORT0iIgorQ09ORklHX1NZU19TVVBQ
T1JUU19LR0RCPXkKKworIworIyBTZWN1cml0eSBvcHRpb25zCisjCisjIENPTkZJR19LRVlTIGlz
IG5vdCBzZXQKKyMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFQ1VSSVRZ
X0ZJTEVfQ0FQQUJJTElUSUVTIGlzIG5vdCBzZXQKK0NPTkZJR19DUllQVE89eQorCisjCisjIENy
eXB0byBjb3JlIG9yIGhlbHBlcgorIworQ09ORklHX0NSWVBUT19BTEdBUEk9eQorQ09ORklHX0NS
WVBUT19IQVNIPXkKK0NPTkZJR19DUllQVE9fTUFOQUdFUj15CisjIENPTkZJR19DUllQVE9fR0Yx
MjhNVUwgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX05VTEwgaXMgbm90IHNldAorIyBDT05G
SUdfQ1JZUFRPX0NSWVBURCBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fQVVUSEVOQyBpcyBu
b3Qgc2V0CisjIENPTkZJR19DUllQVE9fVEVTVCBpcyBub3Qgc2V0CisKKyMKKyMgQXV0aGVudGlj
YXRlZCBFbmNyeXB0aW9uIHdpdGggQXNzb2NpYXRlZCBEYXRhCisjCisjIENPTkZJR19DUllQVE9f
Q0NNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19HQ00gaXMgbm90IHNldAorIyBDT05GSUdf
Q1JZUFRPX1NFUUlWIGlzIG5vdCBzZXQKKworIworIyBCbG9jayBtb2RlcworIworIyBDT05GSUdf
Q1JZUFRPX0NCQyBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fQ1RSIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0NSWVBUT19DVFMgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX0VDQiBpcyBub3Qg
c2V0CisjIENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19QQ0JD
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19YVFMgaXMgbm90IHNldAorCisjCisjIEhhc2gg
bW9kZXMKKyMKK0NPTkZJR19DUllQVE9fSE1BQz15CisjIENPTkZJR19DUllQVE9fWENCQyBpcyBu
b3Qgc2V0CisKKyMKKyMgRGlnZXN0CisjCisjIENPTkZJR19DUllQVE9fQ1JDMzJDIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX0NSWVBUT19NRDQgaXMgbm90IHNldAorQ09ORklHX0NSWVBUT19NRDU9eQor
IyBDT05GSUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5vdCBzZXQKK0NPTkZJR19DUllQVE9fU0hB
MT15CisjIENPTkZJR19DUllQVE9fU0hBMjU2IGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19T
SEE1MTIgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX1RHUjE5MiBpcyBub3Qgc2V0CisjIENP
TkZJR19DUllQVE9fV1A1MTIgaXMgbm90IHNldAorCisjCisjIENpcGhlcnMKKyMKKyMgQ09ORklH
X0NSWVBUT19BRVMgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX0FOVUJJUyBpcyBub3Qgc2V0
CisjIENPTkZJR19DUllQVE9fQVJDNCBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fQkxPV0ZJ
U0ggaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX0NBTUVMTElBIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fQ0FTVDYgaXMgbm90
IHNldAorIyBDT05GSUdfQ1JZUFRPX0RFUyBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fRkNS
WVBUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0NSWVBUT19LSEFaQUQgaXMgbm90IHNldAorIyBDT05G
SUdfQ1JZUFRPX1NBTFNBMjAgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRPX1NFRUQgaXMgbm90
IHNldAorIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlQgaXMgbm90IHNldAorIyBDT05GSUdfQ1JZUFRP
X1RFQSBpcyBub3Qgc2V0CisjIENPTkZJR19DUllQVE9fVFdPRklTSCBpcyBub3Qgc2V0CisKKyMK
KyMgQ29tcHJlc3Npb24KKyMKKyMgQ09ORklHX0NSWVBUT19ERUZMQVRFIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0NSWVBUT19MWk8gaXMgbm90IHNldAorQ09ORklHX0NSWVBUT19IVz15CisKKyMKKyMg
TGlicmFyeSByb3V0aW5lcworIworQ09ORklHX0JJVFJFVkVSU0U9eQorIyBDT05GSUdfR0VORVJJ
Q19GSU5EX0ZJUlNUX0JJVCBpcyBub3Qgc2V0CisjIENPTkZJR19DUkNfQ0NJVFQgaXMgbm90IHNl
dAorIyBDT05GSUdfQ1JDMTYgaXMgbm90IHNldAorIyBDT05GSUdfQ1JDX0lUVV9UIGlzIG5vdCBz
ZXQKK0NPTkZJR19DUkMzMj15CisjIENPTkZJR19DUkM3IGlzIG5vdCBzZXQKKyMgQ09ORklHX0xJ
QkNSQzMyQyBpcyBub3Qgc2V0CitDT05GSUdfWkxJQl9JTkZMQVRFPXkKK0NPTkZJR19aTElCX0RF
RkxBVEU9eQorQ09ORklHX1BMSVNUPXkKK0NPTkZJR19IQVNfSU9NRU09eQorQ09ORklHX0hBU19J
T1BPUlQ9eQorQ09ORklHX0hBU19ETUE9eQpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGludXgt
Mi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9LY29uZmlnIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9t
aXBzL0tjb25maWcKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvS2NvbmZpZwky
MDA4LTA2LTAzIDEwOjU2OjUxLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9h
cmNoL21pcHMvS2NvbmZpZwkyMDA4LTA2LTAzIDE3OjEyOjE5LjAwMDAwMDAwMCArMDEwMApAQCAt
MzExLDYgKzMxMSwxOSBAQAogCXNlbGVjdCBTWVNfSEFTX0NQVV9WUjQxWFgKIAlzZWxlY3QgR0VO
RVJJQ19IQVJESVJRU19OT19fRE9fSVJRCiAKK2NvbmZpZyBOWFBfU1RCMjIwCisJYm9vbCAiTlhQ
IFNUQjIyMCBib2FyZCIKKwlzZWxlY3QgU09DX1BOWDgzM1gKKwloZWxwCisJIFN1cHBvcnQgZm9y
IE5YUCBTZW1pY29uZHVjdG9ycyBTVEIyMjAgRGV2ZWxvcG1lbnQgQm9hcmQuCisKK2NvbmZpZyBO
WFBfU1RCMjI1CisJYm9vbCAiTlhQIDIyNSBib2FyZCIKKwlzZWxlY3QgU09DX1BOWDgzM1gKKwlz
ZWxlY3QgU09DX1BOWDgzMzUKKwloZWxwCisJIFN1cHBvcnQgZm9yIE5YUCBTZW1pY29uZHVjdG9y
cyBTVEIyMjUgRGV2ZWxvcG1lbnQgQm9hcmQuCisKIGNvbmZpZyBQTlg4NTUwX0pCUwogCWJvb2wg
Ik5YUCBQTlg4NTUwIGJhc2VkIEpCUyBib2FyZCIKIAlzZWxlY3QgUE5YODU1MApAQCAtOTQ3LDYg
Kzk2MCwyNiBAQAogCWJvb2wKIAlzZWxlY3QgU0VSSUFMX1JNOTAwMAogCitjb25maWcgU09DX1BO
WDgzM1gKKwlib29sCisJc2VsZWN0IENFVlRfUjRLCisJc2VsZWN0IENTUkNfUjRLCisJc2VsZWN0
IElSUV9DUFUKKwlzZWxlY3QgRE1BX05PTkNPSEVSRU5UCisJc2VsZWN0IFNZU19IQVNfRUFSTFlf
UFJJTlRLCisJc2VsZWN0IFNZU19IQVNfQ1BVX01JUFMzMl9SMgorCXNlbGVjdCBTWVNfU1VQUE9S
VFNfMzJCSVRfS0VSTkVMCisJc2VsZWN0IFNZU19TVVBQT1JUU19MSVRUTEVfRU5ESUFOCisJc2Vs
ZWN0IFNZU19TVVBQT1JUU19CSUdfRU5ESUFOCisJc2VsZWN0IEdFTkVSSUNfSEFSRElSUVNfTk9f
X0RPX0lSUQorCXNlbGVjdCBTWVNfU1VQUE9SVFNfS0dEQgorCXNlbGVjdCBHRU5FUklDX0dQSU8K
KwlzZWxlY3QgQ1BVX01JUFNSMl9JUlFfVkkKKworY29uZmlnIFNPQ19QTlg4MzM1CisJYm9vbAor
CXNlbGVjdCBTT0NfUE5YODMzWAorCiBjb25maWcgUE5YODU1MAogCWJvb2wKIAlzZWxlY3QgU09D
X1BOWDg1NTAKZGlmZiAtdXJOIC0tZXhjbHVkZT0uc3ZuIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9h
cmNoL21pcHMvTWFrZWZpbGUgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvTWFrZWZpbGUKLS0t
IGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvTWFrZWZpbGUJMjAwOC0wNi0wMyAxMDo1
Njo1MS4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL01ha2Vm
aWxlCTIwMDgtMDYtMDMgMTc6MTM6MDMuMDAwMDAwMDAwICswMTAwCkBAIC00MDksNiArNDA5LDE0
IEBACiAjCiBsb2FkLSQoQ09ORklHX1RBTkJBQ19UQjAyMlgpCSs9IDB4ZmZmZmZmZmY4MDAwMDAw
MAogCisjIE5YUCBTVEIyMjUKK2NvcmUtJChDT05GSUdfU09DX1BOWDgzM1gpCQkrPSBhcmNoL21p
cHMvbnhwL3BueDgzM3gvY29tbW9uLworY2ZsYWdzLSQoQ09ORklHX1NPQ19QTlg4MzNYKQkrPSAt
SWluY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4CitsaWJzLSQoQ09ORklHX05YUF9TVEIyMjAp
CQkrPSBhcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4LworbG9hZC0kKENPTkZJR19OWFBfU1RC
MjIwKQkJKz0gMHhmZmZmZmZmZjgwMDAxMDAwCitsaWJzLSQoQ09ORklHX05YUF9TVEIyMjUpCQkr
PSBhcmNoL21pcHMvbnhwL3BueDgzM3gvc3RiMjJ4LworbG9hZC0kKENPTkZJR19OWFBfU1RCMjI1
KQkJKz0gMHhmZmZmZmZmZjgwMDAxMDAwCisKICMKICMgQ29tbW9uIE5YUCBQTlg4NTUwCiAjCmRp
ZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254
cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5jIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254
cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5jCi0tLSBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJj
aC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9nZGJfaG9vay5jCTE5NzAtMDEtMDEgMDE6MDA6MDAu
MDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMz
eC9jb21tb24vZ2RiX2hvb2suYwkyMDA4LTA2LTA2IDExOjI5OjAxLjAwMDAwMDAwMCArMDEwMApA
QCAtMCwwICsxLDEzNCBAQAorLyoKKyAqICBnZGJfaG9vay5jOiBnZGIgaG9vayBmb3IgUE5YODMz
WC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENocmlz
IFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwu
ai5sYWlyZEBueHAuY29tPgorICoKKyAqICBCYXNlZCBvbiBQTlg4NTUwLgorICoKKyAqICBUaGlz
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
LCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKyNpbmNsdWRlIDxsaW51eC9zZXJpYWxf
cG54OHh4eC5oPgorI2luY2x1ZGUgPGFzbS9tYWNoLXBueDgzM3gvcG54ODMzeC5oPgorCisjZGVm
aW5lIFVBUlQwICh1bnNpZ25lZCBjaGFyICopUE5YODMzWF9VQVJUMF9QT1JUU19TVEFSVAorI2Rl
ZmluZSBVQVJUMSAodW5zaWduZWQgY2hhciAqKVBOWDgzM1hfVUFSVDFfUE9SVFNfU1RBUlQKKwor
c3RhdGljIHVuc2lnbmVkIGNoYXIgKmtnZGJfdWFydCAgICA9IFVBUlQxOworc3RhdGljIHVuc2ln
bmVkIGNoYXIgKmNvbnNvbGVfdWFydCA9IFVBUlQwOworc3RhdGljIHZvbGF0aWxlIGludCBkZWxh
eV9jb3VudDsKKworc3RhdGljIHVuc2lnbmVkIGludCBzZXJpYWxfaW4odW5zaWduZWQgY2hhciAq
YmFzZV9hZGRyZXNzLCBpbnQgb2Zmc2V0KQoreworCXJldHVybiAqKCh1bnNpZ25lZCBpbnQgdm9s
YXRpbGUgKikoYmFzZV9hZGRyZXNzICsgb2Zmc2V0KSk7Cit9CisKK3N0YXRpYyB2b2lkIHNlcmlh
bF9vdXQodW5zaWduZWQgY2hhciAqYmFzZV9hZGRyZXNzLCBpbnQgb2Zmc2V0LCBpbnQgdmFsdWUp
Cit7CisJKigodW5zaWduZWQgaW50IHZvbGF0aWxlICopKGJhc2VfYWRkcmVzcyArIG9mZnNldCkp
ID0gdmFsdWU7Cit9CisKK3N0YXRpYyB2b2lkIGRvX2RlbGF5KHZvaWQpCit7CisJaW50IGk7CisJ
Zm9yIChpID0gMDsgaSA8IDEwMDAwOyBpKyspCisJCWRlbGF5X2NvdW50Kys7Cit9CisKK3N0YXRp
YyBpbnQgcHV0X2NoYXIodW5zaWduZWQgY2hhciAqYmFzZV9hZGRyZXNzLCBjaGFyIGMpCit7CisJ
LyogV2FpdCBmb3IgVFggdG8gYmUgcmVhZHkgKi8KKwl3aGlsZSAoKChzZXJpYWxfaW4oYmFzZV9h
ZGRyZXNzLCBQTlg4WFhYX0ZJRk8pICYgUE5YOFhYWF9VQVJUX0ZJRk9fVFhGSUZPKSA+PiAxNikg
PiAxNSkKKwkJZG9fZGVsYXkoKTsKKworCS8qIFNlbmQgdGhlIG5leHQgY2hhcmFjdGVyICovCisJ
c2VyaWFsX291dChiYXNlX2FkZHJlc3MsIFBOWDhYWFhfRklGTywgYyk7CisJc2VyaWFsX291dChi
YXNlX2FkZHJlc3MsIFBOWDhYWFhfSUNMUiwgUE5YOFhYWF9VQVJUX0lOVF9UWCk7CisKKwlyZXR1
cm4gMTsKK30KKworc3RhdGljIGNoYXIgZ2V0X2NoYXIodW5zaWduZWQgY2hhciAqYmFzZV9hZGRy
ZXNzKQoreworCWNoYXIgb3V0cHV0OworCisJLyogV2FpdCBmb3IgUlggdG8gYmUgcmVhZHkgKi8K
Kwl3aGlsZSAoKHNlcmlhbF9pbihiYXNlX2FkZHJlc3MsIFBOWDhYWFhfRklGTykgJiBQTlg4WFhY
X1VBUlRfRklGT19SWEZJRk8pID09IDApCisJCWRvX2RlbGF5KCk7CisKKwkvKiBHZXQgdGhlIGNo
YXJhY3RlciAqLworCW91dHB1dCA9IHNlcmlhbF9pbihiYXNlX2FkZHJlc3MsIFBOWDhYWFhfRklG
TykgJiAweEZGOworCisJLyogTW92ZSBvbnRvIHRoZSBuZXh0IGNoYXJhY3RlciBpbiB0aGUgYnVm
ZmVyICovCisJc2VyaWFsX291dChiYXNlX2FkZHJlc3MsIFBOWDhYWFhfTENSLCBzZXJpYWxfaW4o
YmFzZV9hZGRyZXNzLCBQTlg4WFhYX0xDUikgfCBQTlg4WFhYX1VBUlRfTENSX1JYX05FWFQpOwor
CXNlcmlhbF9vdXQoYmFzZV9hZGRyZXNzLCBQTlg4WFhYX0lDTFIsIFBOWDhYWFhfVUFSVF9JTlRf
UlgpOworCisJcmV0dXJuIG91dHB1dDsKK30KKworc3RhdGljIHZvaWQgc2VyaWFsX2luaXQodW5z
aWduZWQgY2hhciAqYmFzZV9hZGRyZXNzKQoreworCXNlcmlhbF9vdXQoYmFzZV9hZGRyZXNzLCBQ
Tlg4WFhYX0xDUiwgUE5YOFhYWF9VQVJUX0xDUl84QklUIHwgUE5YOFhYWF9VQVJUX0xDUl9UWF9S
U1QgfCBQTlg4WFhYX1VBUlRfTENSX1JYX1JTVCk7CisJc2VyaWFsX291dChiYXNlX2FkZHJlc3Ms
IFBOWDhYWFhfTUNSLCBQTlg4WFhYX1VBUlRfTUNSX0RUUiB8IFBOWDhYWFhfVUFSVF9NQ1JfUlRT
KTsKKwlzZXJpYWxfb3V0KGJhc2VfYWRkcmVzcywgUE5YOFhYWF9CQVVELCAxKTsgLyogMTE1MjAw
IEJhdWQgKi8KKwlzZXJpYWxfb3V0KGJhc2VfYWRkcmVzcywgUE5YOFhYWF9DRkcsIDB4MDAwNjAw
MzApOworCXNlcmlhbF9vdXQoYmFzZV9hZGRyZXNzLCBQTlg4WFhYX0lDTFIsIC0xKTsKKwlzZXJp
YWxfb3V0KGJhc2VfYWRkcmVzcywgUE5YOFhYWF9JRU4sIDApOworfQorCitzdGF0aWMgdm9pZCBz
ZXR1cF9zZXJpYWxfb3V0cHV0KHZvaWQpCit7CisJc3RhdGljIGJvb2wgaW5pdGlhbGlzZWQ7CisJ
aWYgKCFpbml0aWFsaXNlZCkgeworCQlzZXJpYWxfaW5pdChrZ2RiX3VhcnQpOworCQlzZXJpYWxf
aW5pdChjb25zb2xlX3VhcnQpOworCQlpbml0aWFsaXNlZCA9IHRydWU7CisJfQorfQorCitpbnQg
cnNfa2dkYl9ob29rKGludCB0dHlfbm8sIGludCBzcGVlZCkKK3sKKwlrZ2RiX3VhcnQgICAgPSB0
dHlfbm8gPyBVQVJUMSA6IFVBUlQwOworCWNvbnNvbGVfdWFydCA9IHR0eV9ubyA/IFVBUlQwIDog
VUFSVDE7CisKKwlzZXR1cF9zZXJpYWxfb3V0cHV0KCk7CisKKwlyZXR1cm4gc3BlZWQ7Cit9CisK
K2ludCBwcm9tX3B1dGNoYXIoY2hhciBjKQoreworCXNldHVwX3NlcmlhbF9vdXRwdXQoKTsKKwly
ZXR1cm4gcHV0X2NoYXIoY29uc29sZV91YXJ0LCBjKTsKK30KKworY2hhciBwcm9tX2dldGNoYXIo
dm9pZCkKK3sKKwlzZXR1cF9zZXJpYWxfb3V0cHV0KCk7CisJcmV0dXJuIGdldF9jaGFyKGNvbnNv
bGVfdWFydCk7Cit9CisKK2ludCBwdXRfZGVidWdfY2hhcihjaGFyIGMpCit7CisJc2V0dXBfc2Vy
aWFsX291dHB1dCgpOworCXJldHVybiBwdXRfY2hhcihrZ2RiX3VhcnQsIGMpOworfQorCitjaGFy
IGdldF9kZWJ1Z19jaGFyKHZvaWQpCit7CisJc2V0dXBfc2VyaWFsX291dHB1dCgpOworCXJldHVy
biBnZXRfY2hhcihrZ2RiX3VhcnQpOworfQpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGludXgt
Mi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vaW50ZXJydXB0cy5j
IGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9pbnRlcnJ1cHRz
LmMKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9u
L2ludGVycnVwdHMuYwkxOTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMAorKysgbGlu
dXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL2ludGVycnVwdHMuYwky
MDA4LTA2LTE2IDE0OjU1OjUwLjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDM4MCBAQAorLyoK
KyAqICBpbnRlcnJ1cHRzLmM6IEludGVycnVwdCBtYXBwaW5ncyBmb3IgUE5YODMzWC4KKyAqCisg
KiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENocmlzIFN0ZWVsIDxj
aHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwuai5sYWlyZEBu
eHAuY29tPgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
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
bmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9pcnEuaD4KKyNpbmNsdWRl
IDxsaW51eC9oYXJkaXJxLmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVk
ZSA8YXNtL21pcHNyZWdzLmg+CisjaW5jbHVkZSA8YXNtL2lycV9jcHUuaD4KKyNpbmNsdWRlIDxp
cnEuaD4KKyNpbmNsdWRlIDxpcnEtbWFwcGluZy5oPgorI2luY2x1ZGUgPGdwaW8uaD4KKworc3Rh
dGljIGludCBtaXBzX2NwdV90aW1lcl9pcnE7CisKK3N0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQg
aXJxX3ByaW9bUE5YODMzWF9QSUNfTlVNX0lSUV0gPQoreworICAgIDAsIC8qIHVudXNlZCAqLwor
ICAgIDQsIC8qIFBOWDgzM1hfUElDX0kyQzBfSU5UICAgICAgICAgICAgICAgICAxICovCisgICAg
NCwgLyogUE5YODMzWF9QSUNfSTJDMV9JTlQgICAgICAgICAgICAgICAgIDIgKi8KKyAgICAxLCAv
KiBQTlg4MzNYX1BJQ19VQVJUMF9JTlQgICAgICAgICAgICAgICAgMyAqLworICAgIDEsIC8qIFBO
WDgzM1hfUElDX1VBUlQxX0lOVCAgICAgICAgICAgICAgICA0ICovCisgICAgNiwgLyogUE5YODMz
WF9QSUNfVFNfSU4wX0RWX0lOVCAgICAgICAgICAgIDUgKi8KKyAgICA2LCAvKiBQTlg4MzNYX1BJ
Q19UU19JTjBfRE1BX0lOVCAgICAgICAgICAgNiAqLworICAgIDcsIC8qIFBOWDgzM1hfUElDX0dQ
SU9fSU5UICAgICAgICAgICAgICAgICA3ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfQVVESU9f
REVDX0lOVCAgICAgICAgICAgIDggKi8KKyAgICA1LCAvKiBQTlg4MzNYX1BJQ19WSURFT19ERUNf
SU5UICAgICAgICAgICAgOSAqLworICAgIDQsIC8qIFBOWDgzM1hfUElDX0NPTkZJR19JTlQgICAg
ICAgICAgICAgIDEwICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfQU9JX0lOVCAgICAgICAgICAg
ICAgICAgMTEgKi8KKyAgICA5LCAvKiBQTlg4MzNYX1BJQ19TWU5DX0lOVCAgICAgICAgICAgICAg
ICAxMiAqLworICAgIDksIC8qIFBOWDgzMzVfUElDX1NBVEFfSU5UICAgICAgICAgICAgICAgIDEz
ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfT1NEX0lOVCAgICAgICAgICAgICAgICAgMTQgKi8K
KyAgICA5LCAvKiBQTlg4MzNYX1BJQ19ESVNQMV9JTlQgICAgICAgICAgICAgICAxNSAqLworICAg
IDQsIC8qIFBOWDgzM1hfUElDX0RFSU5URVJMQUNFUl9JTlQgICAgICAgIDE2ICovCisgICAgOSwg
LyogUE5YODMzWF9QSUNfRElTUExBWTJfSU5UICAgICAgICAgICAgMTcgKi8KKyAgICA0LCAvKiBQ
Tlg4MzNYX1BJQ19WQ19JTlQgICAgICAgICAgICAgICAgICAxOCAqLworICAgIDQsIC8qIFBOWDgz
M1hfUElDX1NDX0lOVCAgICAgICAgICAgICAgICAgIDE5ICovCisgICAgOSwgLyogUE5YODMzWF9Q
SUNfSURFX0lOVCAgICAgICAgICAgICAgICAgMjAgKi8KKyAgICA5LCAvKiBQTlg4MzNYX1BJQ19J
REVfRE1BX0lOVCAgICAgICAgICAgICAyMSAqLworICAgIDYsIC8qIFBOWDgzM1hfUElDX1RTX0lO
MV9EVl9JTlQgICAgICAgICAgIDIyICovCisgICAgNiwgLyogUE5YODMzWF9QSUNfVFNfSU4xX0RN
QV9JTlQgICAgICAgICAgMjMgKi8KKyAgICA0LCAvKiBQTlg4MzNYX1BJQ19TR0RYX0RNQV9JTlQg
ICAgICAgICAgICAyNCAqLworICAgIDQsIC8qIFBOWDgzM1hfUElDX1RTX09VVF9JTlQgICAgICAg
ICAgICAgIDI1ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNfSVJfSU5UICAgICAgICAgICAgICAg
ICAgMjYgKi8KKyAgICAzLCAvKiBQTlg4MzNYX1BJQ19WTVNQMV9JTlQgICAgICAgICAgICAgICAy
NyAqLworICAgIDMsIC8qIFBOWDgzM1hfUElDX1ZNU1AyX0lOVCAgICAgICAgICAgICAgIDI4ICov
CisgICAgNCwgLyogUE5YODMzWF9QSUNfUElCQ19JTlQgICAgICAgICAgICAgICAgMjkgKi8KKyAg
ICA0LCAvKiBQTlg4MzNYX1BJQ19UU19JTjBfVFJEX0lOVCAgICAgICAgICAzMCAqLworICAgIDQs
IC8qIFBOWDgzM1hfUElDX1NHRFhfVFBEX0lOVCAgICAgICAgICAgIDMxICovCisgICAgNSwgLyog
UE5YODMzWF9QSUNfVVNCX0lOVCAgICAgICAgICAgICAgICAgMzIgKi8KKyAgICA0LCAvKiBQTlg4
MzNYX1BJQ19UU19JTjFfVFJEX0lOVCAgICAgICAgICAzMyAqLworICAgIDQsIC8qIFBOWDgzM1hf
UElDX0NMT0NLX0lOVCAgICAgICAgICAgICAgIDM0ICovCisgICAgNCwgLyogUE5YODMzWF9QSUNf
U0dEWF9QQVJTRVJfSU5UICAgICAgICAgMzUgKi8KKyAgICA0LCAvKiBQTlg4MzNYX1BJQ19WTVNQ
X0RNQV9JTlQgICAgICAgICAgICAzNiAqLworI2lmIGRlZmluZWQoQ09ORklHX1NPQ19QTlg4MzM1
KQorICAgIDQsIC8qIFBOWDgzMzVfUElDX01JVV9JTlQgICAgICAgICAgICAgICAgIDM3ICovCisg
ICAgNCwgLyogUE5YODMzNV9QSUNfQVZDSElQX0lSUV9JTlQgICAgICAgICAgMzggKi8KKyAgICA5
LCAvKiBQTlg4MzM1X1BJQ19TWU5DX0hEX0lOVCAgICAgICAgICAgICAzOSAqLworICAgIDksIC8q
IFBOWDgzMzVfUElDX0RJU1BfSERfSU5UICAgICAgICAgICAgIDQwICovCisgICAgOSwgLyogUE5Y
ODMzNV9QSUNfRElTUF9TQ0FMRVJfSU5UICAgICAgICAgNDEgKi8KKyAgICA0LCAvKiBQTlg4MzM1
X1BJQ19PU0RfSEQxX0lOVCAgICAgICAgICAgICA0MiAqLworICAgIDQsIC8qIFBOWDgzMzVfUElD
X0RUTF9XUklURVJfWV9JTlQgICAgICAgIDQzICovCisgICAgNCwgLyogUE5YODMzNV9QSUNfRFRM
X1dSSVRFUl9DX0lOVCAgICAgICAgNDQgKi8KKyAgICA0LCAvKiBQTlg4MzM1X1BJQ19EVExfRU1V
TEFUT1JfWV9JUl9JTlQgICA0NSAqLworICAgIDQsIC8qIFBOWDgzMzVfUElDX0RUTF9FTVVMQVRP
Ul9DX0lSX0lOVCAgIDQ2ICovCisgICAgNCwgLyogUE5YODMzNV9QSUNfREVOQ19UVFhfSU5UICAg
ICAgICAgICAgNDcgKi8KKyAgICA0LCAvKiBQTlg4MzM1X1BJQ19NTUlfU0lGMF9JTlQgICAgICAg
ICAgICA0OCAqLworICAgIDQsIC8qIFBOWDgzMzVfUElDX01NSV9TSUYxX0lOVCAgICAgICAgICAg
IDQ5ICovCisgICAgNCwgLyogUE5YODMzNV9QSUNfTU1JX0NETU1VX0lOVCAgICAgICAgICAgNTAg
Ki8KKyAgICA0LCAvKiBQTlg4MzM1X1BJQ19QSUJDU19JTlQgICAgICAgICAgICAgICA1MSAqLwor
ICAgMTIsIC8qIFBOWDgzMzVfUElDX0VUSEVSTkVUX0lOVCAgICAgICAgICAgIDUyICovCisgICAg
MywgLyogUE5YODMzNV9QSUNfVk1TUDFfMF9JTlQgICAgICAgICAgICAgNTMgKi8KKyAgICAzLCAv
KiBQTlg4MzM1X1BJQ19WTVNQMV8xX0lOVCAgICAgICAgICAgICA1NCAqLworICAgIDQsIC8qIFBO
WDgzMzVfUElDX1ZNU1AxX0RNQV9JTlQgICAgICAgICAgIDU1ICovCisgICAgNCwgLyogUE5YODMz
NV9QSUNfVERHUl9ERV9JTlQgICAgICAgICAgICAgNTYgKi8KKyAgICA0LCAvKiBQTlg4MzM1X1BJ
Q19JUjFfSVJRX0lOVCAgICAgICAgICAgICA1NyAqLworI2VuZGlmCit9OworCitzdGF0aWMgdm9p
ZCBwbng4MzN4X3RpbWVyX2Rpc3BhdGNoKHZvaWQpCit7CisJZG9fSVJRKG1pcHNfY3B1X3RpbWVy
X2lycSk7Cit9CisKK3N0YXRpYyB2b2lkIHBpY19kaXNwYXRjaCh2b2lkKQoreworCXVuc2lnbmVk
IGludCBpcnEgPSBQTlg4MzNYX1JFR0ZJRUxEKFBJQ19JTlRfU1JDLCBJTlRfU1JDKTsKKworCWlm
ICgoaXJxID49IDEpICYmIChpcnEgPCAoUE5YODMzWF9QSUNfTlVNX0lSUSkpKSB7CisJCXVuc2ln
bmVkIGxvbmcgcHJpb3JpdHkgPSBQTlg4MzNYX1BJQ19JTlRfUFJJT1JJVFk7CisJCVBOWDgzM1hf
UElDX0lOVF9QUklPUklUWSA9IGlycV9wcmlvW2lycV07CisKKwkJaWYgKGlycSA9PSBQTlg4MzNY
X1BJQ19HUElPX0lOVCkgeworCQkJdW5zaWduZWQgbG9uZyBtYXNrID0gUE5YODMzWF9QSU9fSU5U
X1NUQVRVUyAmIFBOWDgzM1hfUElPX0lOVF9FTkFCTEU7CisJCQlpbnQgcGluOworCQkJd2hpbGUg
KChwaW4gPSBmZnMobWFzayAmIDB4ZmZmZikpKSB7CisJCQkJcGluIC09IDE7CisJCQkJZG9fSVJR
KFBOWDgzM1hfR1BJT19JUlFfQkFTRSArIHBpbik7CisJCQkJbWFzayAmPSB+KDEgPDwgcGluKTsK
KwkJCX0KKwkJfSBlbHNlIHsKKwkJCWRvX0lSUShpcnEgKyBQTlg4MzNYX1BJQ19JUlFfQkFTRSk7
CisJCX0KKworCQlQTlg4MzNYX1BJQ19JTlRfUFJJT1JJVFkgPSBwcmlvcml0eTsKKwl9IGVsc2Ug
eworCQlwcmludGsoS0VSTl9FUlIgInBsYXRfaXJxX2Rpc3BhdGNoOiB1bmV4cGVjdGVkIGlycSAl
dVxuIiwgaXJxKTsKKwl9Cit9CisKK2FzbWxpbmthZ2Ugdm9pZCBwbGF0X2lycV9kaXNwYXRjaCh2
b2lkKQoreworCXVuc2lnbmVkIGludCBwZW5kaW5nID0gcmVhZF9jMF9zdGF0dXMoKSAmIHJlYWRf
YzBfY2F1c2UoKTsKKworCWlmIChwZW5kaW5nICYgU1RBVFVTRl9JUDQpCisJCXBpY19kaXNwYXRj
aCgpOworCWVsc2UgaWYgKHBlbmRpbmcgJiBTVEFUVVNGX0lQNykKKwkJZG9fSVJRKFBOWDgzM1hf
VElNRVJfSVJRKTsKKwllbHNlCisJCXNwdXJpb3VzX2ludGVycnVwdCgpOworfQorCitzdGF0aWMg
aW5saW5lIHZvaWQgcG54ODMzeF9oYXJkX2VuYWJsZV9waWNfaXJxKHVuc2lnbmVkIGludCBpcnEp
Cit7CisJLyogQ3VycmVudGx5IHdlIGRvIHRoaXMgYnkgc2V0dGluZyBJUlEgcHJpb3JpdHkgdG8g
MS4KKwkgICBJZiBwcmlvcml0eSBzdXBwb3J0IGlzIGJlaW5nIGltcGxlbWVudGVkLCAxIHNob3Vs
ZCBiZSByZXBhbGNlZAorCQlieSBhIGJldHRlciB2YWx1ZS4gKi8KKwlQTlg4MzNYX1BJQ19JTlRf
UkVHKGlycSkgPSBpcnFfcHJpb1tpcnFdOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcG54ODMz
eF9oYXJkX2Rpc2FibGVfcGljX2lycSh1bnNpZ25lZCBpbnQgaXJxKQoreworCS8qIERpc2FibGUg
SVJRIGJ5IHdyaXRpbmcgc2V0dGluZyBpdCdzIHByaW9yaXR5IHRvIDAgKi8KKwlQTlg4MzNYX1BJ
Q19JTlRfUkVHKGlycSkgPSAwOworfQorCitzdGF0aWMgaW50IGlycWZsYWdzW1BOWDgzM1hfUElD
X05VTV9JUlFdOwkvKiBpbml0aWFsaXplZCBieSB6ZXJvZXMgKi8KKyNkZWZpbmUgSVJRRkxBR19T
VEFSVEVECQkxCisjZGVmaW5lIElSUUZMQUdfRElTQUJMRUQJMgorCitzdGF0aWMgREVGSU5FX1NQ
SU5MT0NLKHBueDgzM3hfaXJxX2xvY2spOworCitzdGF0aWMgdW5zaWduZWQgaW50IHBueDgzM3hf
c3RhcnR1cF9waWNfaXJxKHVuc2lnbmVkIGludCBpcnEpCit7CisJdW5zaWduZWQgbG9uZyBmbGFn
czsKKwl1bnNpZ25lZCBpbnQgcGljX2lycSA9IGlycSAtIFBOWDgzM1hfUElDX0lSUV9CQVNFOwor
CisJc3Bpbl9sb2NrX2lycXNhdmUoJnBueDgzM3hfaXJxX2xvY2ssIGZsYWdzKTsKKworCWlycWZs
YWdzW3BpY19pcnFdID0gSVJRRkxBR19TVEFSVEVEOwkvKiBzdGFydGVkLCBub3QgZGlzYWJsZWQg
Ki8KKwlwbng4MzN4X2hhcmRfZW5hYmxlX3BpY19pcnEocGljX2lycSk7CisKKwlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZwbng4MzN4X2lycV9sb2NrLCBmbGFncyk7CisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyB2b2lkIHBueDgzM3hfc2h1dGRvd25fcGljX2lycSh1bnNpZ25lZCBpbnQgaXJxKQor
eworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJdW5zaWduZWQgaW50IHBpY19pcnEgPSBpcnEgLSBQ
Tlg4MzNYX1BJQ19JUlFfQkFTRTsKKworCXNwaW5fbG9ja19pcnFzYXZlKCZwbng4MzN4X2lycV9s
b2NrLCBmbGFncyk7CisKKwlpcnFmbGFnc1twaWNfaXJxXSA9IDA7CQkJLyogbm90IHN0YXJ0ZWQg
Ki8KKwlwbng4MzN4X2hhcmRfZGlzYWJsZV9waWNfaXJxKHBpY19pcnEpOworCisJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmcG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworfQorCitzdGF0aWMgdm9p
ZCBwbng4MzN4X2VuYWJsZV9waWNfaXJxKHVuc2lnbmVkIGludCBpcnEpCit7CisJdW5zaWduZWQg
bG9uZyBmbGFnczsKKwl1bnNpZ25lZCBpbnQgcGljX2lycSA9IGlycSAtIFBOWDgzM1hfUElDX0lS
UV9CQVNFOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJnBueDgzM3hfaXJxX2xvY2ssIGZsYWdzKTsK
KworCWlycWZsYWdzW3BpY19pcnFdICY9IH5JUlFGTEFHX0RJU0FCTEVEOworCWlmIChpcnFmbGFn
c1twaWNfaXJxXSA9PSBJUlFGTEFHX1NUQVJURUQpCisJCXBueDgzM3hfaGFyZF9lbmFibGVfcGlj
X2lycShwaWNfaXJxKTsKKworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBueDgzM3hfaXJxX2xv
Y2ssIGZsYWdzKTsKK30KKworc3RhdGljIHZvaWQgcG54ODMzeF9kaXNhYmxlX3BpY19pcnEodW5z
aWduZWQgaW50IGlycSkKK3sKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCXVuc2lnbmVkIGludCBw
aWNfaXJxID0gaXJxIC0gUE5YODMzWF9QSUNfSVJRX0JBU0U7CisKKwlzcGluX2xvY2tfaXJxc2F2
ZSgmcG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworCisJaXJxZmxhZ3NbcGljX2lycV0gfD0gSVJR
RkxBR19ESVNBQkxFRDsKKwlwbng4MzN4X2hhcmRfZGlzYWJsZV9waWNfaXJxKHBpY19pcnEpOwor
CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworfQor
CitzdGF0aWMgdm9pZCBwbng4MzN4X2Fja19waWNfaXJxKHVuc2lnbmVkIGludCBpcnEpCit7Cit9
CisKK3N0YXRpYyB2b2lkIHBueDgzM3hfZW5kX3BpY19pcnEodW5zaWduZWQgaW50IGlycSkKK3sK
K30KKworc3RhdGljIERFRklORV9TUElOTE9DSyhwbng4MzN4X2dwaW9fcG54ODMzeF9pcnFfbG9j
ayk7CisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgcG54ODMzeF9zdGFydHVwX2dwaW9faXJxKHVuc2ln
bmVkIGludCBpcnEpCit7CisJaW50IHBpbiA9IGlycSAtIFBOWDgzM1hfR1BJT19JUlFfQkFTRTsK
Kwl1bnNpZ25lZCBsb25nIGZsYWdzOworCXNwaW5fbG9ja19pcnFzYXZlKCZwbng4MzN4X2dwaW9f
cG54ODMzeF9pcnFfbG9jaywgZmxhZ3MpOworCXBueDgzM3hfZ3Bpb19lbmFibGVfaXJxKHBpbik7
CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG54ODMzeF9ncGlvX3BueDgzM3hfaXJxX2xvY2ss
IGZsYWdzKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgcG54ODMzeF9lbmFibGVfZ3Bp
b19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwlpbnQgcGluID0gaXJxIC0gUE5YODMzWF9HUElP
X0lSUV9CQVNFOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJc3Bpbl9sb2NrX2lycXNhdmUoJnBu
eDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7CisJcG54ODMzeF9ncGlvX2VuYWJs
ZV9pcnEocGluKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwbng4MzN4X2dwaW9fcG54ODMz
eF9pcnFfbG9jaywgZmxhZ3MpOworfQorCitzdGF0aWMgdm9pZCBwbng4MzN4X2Rpc2FibGVfZ3Bp
b19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwlpbnQgcGluID0gaXJxIC0gUE5YODMzWF9HUElP
X0lSUV9CQVNFOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJc3Bpbl9sb2NrX2lycXNhdmUoJnBu
eDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7CisJcG54ODMzeF9ncGlvX2Rpc2Fi
bGVfaXJxKHBpbik7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG54ODMzeF9ncGlvX3BueDgz
M3hfaXJxX2xvY2ssIGZsYWdzKTsKK30KKworc3RhdGljIHZvaWQgcG54ODMzeF9hY2tfZ3Bpb19p
cnEodW5zaWduZWQgaW50IGlycSkKK3sKK30KKworc3RhdGljIHZvaWQgcG54ODMzeF9lbmRfZ3Bp
b19pcnEodW5zaWduZWQgaW50IGlycSkKK3sKKwlpbnQgcGluID0gaXJxIC0gUE5YODMzWF9HUElP
X0lSUV9CQVNFOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJc3Bpbl9sb2NrX2lycXNhdmUoJnBu
eDgzM3hfZ3Bpb19wbng4MzN4X2lycV9sb2NrLCBmbGFncyk7CisJcG54ODMzeF9ncGlvX2NsZWFy
X2lycShwaW4pOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBueDgzM3hfZ3Bpb19wbng4MzN4
X2lycV9sb2NrLCBmbGFncyk7Cit9CisKK3N0YXRpYyBpbnQgcG54ODMzeF9zZXRfdHlwZV9ncGlv
X2lycSh1bnNpZ25lZCBpbnQgaXJxLCB1bnNpZ25lZCBpbnQgZmxvd190eXBlKQoreworCWludCBw
aW4gPSBpcnEgLSBQTlg4MzNYX0dQSU9fSVJRX0JBU0U7CisJaW50IGdwaW9fbW9kZTsKKworCXN3
aXRjaCAoZmxvd190eXBlKSB7CisJY2FzZSBJUlFfVFlQRV9FREdFX1JJU0lORzoKKwkJZ3Bpb19t
b2RlID0gR1BJT19JTlRfRURHRV9SSVNJTkc7CisJCWJyZWFrOworCWNhc2UgSVJRX1RZUEVfRURH
RV9GQUxMSU5HOgorCQlncGlvX21vZGUgPSBHUElPX0lOVF9FREdFX0ZBTExJTkc7CisJCWJyZWFr
OworCWNhc2UgSVJRX1RZUEVfRURHRV9CT1RIOgorCQlncGlvX21vZGUgPSBHUElPX0lOVF9FREdF
X0JPVEg7CisJCWJyZWFrOworCWNhc2UgSVJRX1RZUEVfTEVWRUxfSElHSDoKKwkJZ3Bpb19tb2Rl
ID0gR1BJT19JTlRfTEVWRUxfSElHSDsKKwkJYnJlYWs7CisJY2FzZSBJUlFfVFlQRV9MRVZFTF9M
T1c6CisJCWdwaW9fbW9kZSA9IEdQSU9fSU5UX0xFVkVMX0xPVzsKKwkJYnJlYWs7CisJZGVmYXVs
dDoKKwkJZ3Bpb19tb2RlID0gR1BJT19JTlRfTk9ORTsKKwkJYnJlYWs7CisJfQorCisJcG54ODMz
eF9ncGlvX3NldHVwX2lycShncGlvX21vZGUsIHBpbik7CisKKwlyZXR1cm4gMDsKK30KKworc3Rh
dGljIHN0cnVjdCBpcnFfY2hpcCBwbng4MzN4X3BpY19pcnFfdHlwZSA9IHsKKwkudHlwZW5hbWUg
PSAiUE5YLVBJQyIsCisJLnN0YXJ0dXAgPSBwbng4MzN4X3N0YXJ0dXBfcGljX2lycSwKKwkuc2h1
dGRvd24gPSBwbng4MzN4X3NodXRkb3duX3BpY19pcnEsCisJLmVuYWJsZSA9IHBueDgzM3hfZW5h
YmxlX3BpY19pcnEsCisJLmRpc2FibGUgPSBwbng4MzN4X2Rpc2FibGVfcGljX2lycSwKKwkuYWNr
ID0gcG54ODMzeF9hY2tfcGljX2lycSwKKwkuZW5kID0gcG54ODMzeF9lbmRfcGljX2lycQorfTsK
Kworc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBwbng4MzN4X2dwaW9faXJxX3R5cGUgPSB7CisJLnR5
cGVuYW1lID0gIlBOWC1HUElPIiwKKwkuc3RhcnR1cCA9IHBueDgzM3hfc3RhcnR1cF9ncGlvX2ly
cSwKKwkuc2h1dGRvd24gPSBwbng4MzN4X2Rpc2FibGVfZ3Bpb19pcnEsCisJLmVuYWJsZSA9IHBu
eDgzM3hfZW5hYmxlX2dwaW9faXJxLAorCS5kaXNhYmxlID0gcG54ODMzeF9kaXNhYmxlX2dwaW9f
aXJxLAorCS5hY2sgPSBwbng4MzN4X2Fja19ncGlvX2lycSwKKwkuZW5kID0gcG54ODMzeF9lbmRf
Z3Bpb19pcnEsCisJLnNldF90eXBlID0gcG54ODMzeF9zZXRfdHlwZV9ncGlvX2lycQorfTsKKwor
dm9pZCBfX2luaXQgYXJjaF9pbml0X2lycSh2b2lkKQoreworCXVuc2lnbmVkIGludCBpcnE7CisK
KwkvKiBzZXR1cCBzdGFuZGFyZCBpbnRlcm5hbCBjcHUgaXJxcyAqLworCW1pcHNfY3B1X2lycV9p
bml0KCk7CisKKwkvKiBTZXQgSVJRIGluZm9ybWF0aW9uIGluIGlycV9kZXNjICovCisJZm9yIChp
cnEgPSBQTlg4MzNYX1BJQ19JUlFfQkFTRTsgaXJxIDwgKFBOWDgzM1hfUElDX0lSUV9CQVNFICsg
UE5YODMzWF9QSUNfTlVNX0lSUSk7IGlycSsrKSB7CisJCXBueDgzM3hfaGFyZF9kaXNhYmxlX3Bp
Y19pcnEoaXJxKTsKKwkJc2V0X2lycV9jaGlwX2FuZF9oYW5kbGVyKGlycSwgJnBueDgzM3hfcGlj
X2lycV90eXBlLCBoYW5kbGVfc2ltcGxlX2lycSk7CisJfQorCisJZm9yIChpcnEgPSBQTlg4MzNY
X0dQSU9fSVJRX0JBU0U7IGlycSA8IChQTlg4MzNYX0dQSU9fSVJRX0JBU0UgKyBQTlg4MzNYX0dQ
SU9fTlVNX0lSUSk7IGlycSsrKQorCQlzZXRfaXJxX2NoaXBfYW5kX2hhbmRsZXIoaXJxLCAmcG54
ODMzeF9ncGlvX2lycV90eXBlLCBoYW5kbGVfc2ltcGxlX2lycSk7CisKKwkvKiBTZXQgUElDIHBy
aW9yaXR5IGxpbWl0ZXIgcmVnaXN0ZXIgdG8gMCAqLworCVBOWDgzM1hfUElDX0lOVF9QUklPUklU
WSA9IDA7CisKKwkvKiBTZXR1cCBHUElPIElSUSBkaXNwYXRjaGluZyAqLworCXBueDgzM3hfc3Rh
cnR1cF9waWNfaXJxKFBOWDgzM1hfUElDX0dQSU9fSU5UKTsKKworCS8qIEVuYWJsZSBQSUMgSVJR
cyAoSFdJUlEyKSAqLworCWlmIChjcHVfaGFzX3ZpbnQpCisJCXNldF92aV9oYW5kbGVyKDQsIHBp
Y19kaXNwYXRjaCk7CisKKwl3cml0ZV9jMF9zdGF0dXMocmVhZF9jMF9zdGF0dXMoKSB8IElFX0lS
UTIpOworfQorCit1bnNpZ25lZCBpbnQgX19jcHVpbml0IGdldF9jMF9jb21wYXJlX2ludCh2b2lk
KQoreworCWlmIChjcHVfaGFzX3ZpbnQpCisJCXNldF92aV9oYW5kbGVyKGNwMF9jb21wYXJlX2ly
cSwgcG54ODMzeF90aW1lcl9kaXNwYXRjaCk7CisKKwltaXBzX2NwdV90aW1lcl9pcnEgPSBNSVBT
X0NQVV9JUlFfQkFTRSArIGNwMF9jb21wYXJlX2lycTsKKwlyZXR1cm4gbWlwc19jcHVfdGltZXJf
aXJxOworfQorCit2b2lkIF9faW5pdCBwbGF0X3RpbWVfaW5pdCh2b2lkKQoreworCS8qIGNhbGN1
bGF0ZSBtaXBzX2hwdF9mcmVxdWVuY3kgYmFzZWQgb24gUE5YODMzWF9DTE9DS19DUFVDUF9DVEwg
cmVnICovCisKKwlleHRlcm4gdW5zaWduZWQgbG9uZyBtaXBzX2hwdF9mcmVxdWVuY3k7CisJdW5z
aWduZWQgbG9uZyByZWcgPSBQTlg4MzNYX0NMT0NLX0NQVUNQX0NUTDsKKworCWlmICghKFBOWDgz
M1hfQklUKHJlZywgQ0xPQ0tfQ1BVQ1BfQ1RMLCBFWElUX1JFU0VUKSkpIHsKKwkJLyogRnVuY3Rp
b25hbCBjbG9jayBpcyBkaXNhYmxlZCBzbyB1c2UgY3J5c3RhbCBmcmVxdWVuY3kgKi8KKwkJbWlw
c19ocHRfZnJlcXVlbmN5ID0gMjU7CisJfSBlbHNlIHsKKyNpZiBkZWZpbmVkKENPTkZJR19TT0Nf
UE5YODMzNSkKKwkJLyogRnVuY3Rpb25hbCBjbG9jayBpcyBlbmFibGVkLCBzbyBnZXQgY2xvY2sg
bXVsdGlwbGllciAqLworCQltaXBzX2hwdF9mcmVxdWVuY3kgPSA5MCArICgxMCAqIFBOWDgzMzVf
UkVHRklFTEQoQ0xPQ0tfUExMX0NQVV9DVEwsIEZSRVEpKTsKKyNlbHNlCisJCXN0YXRpYyBjb25z
dCB1bnNpZ25lZCBsb25nIGludCBmcmVxWzRdID0gezI0MCwgMTYwLCAxMjAsIDgwfTsKKwkJbWlw
c19ocHRfZnJlcXVlbmN5ID0gZnJlcVtQTlg4MzNYX0ZJRUxEKHJlZywgQ0xPQ0tfQ1BVQ1BfQ1RM
LCBESVZfQ0xPQ0spXTsKKyNlbmRpZgorCX0KKworCXByaW50ayhLRVJOX0lORk8gIkNQVSBjbG9j
ayBpcyAlbGQgTUh6XG4iLCBtaXBzX2hwdF9mcmVxdWVuY3kpOworCisJbWlwc19ocHRfZnJlcXVl
bmN5ICo9IDUwMDAwMDsKK30KKwpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGludXgtMi42LjI2
LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vTWFrZWZpbGUgbGludXgtMi42
LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL01ha2VmaWxlCi0tLSBsaW51eC0y
LjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9NYWtlZmlsZQkxOTcw
LTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9hcmNo
L21pcHMvbnhwL3BueDgzM3gvY29tbW9uL01ha2VmaWxlCTIwMDgtMDMtMDMgMTM6MDk6MzAuMDAw
MDAwMDAwICswMDAwCkBAIC0wLDAgKzEgQEAKK29iai15IDo9IGludGVycnVwdHMubyBwbGF0Zm9y
bS5vIHByb20ubyBzZXR1cC5vIHJlc2V0Lm8gZ2RiX2hvb2subwpkaWZmIC11ck4gLS1leGNsdWRl
PS5zdm4gbGludXgtMi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24v
cGxhdGZvcm0uYyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24v
cGxhdGZvcm0uYwotLS0gbGludXgtMi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMz
eC9jb21tb24vcGxhdGZvcm0uYwkxOTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMAor
KysgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL3BsYXRmb3Jt
LmMJMjAwOC0wNi0xMiAxMzowODowNy4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSwzMDYgQEAK
Ky8qCisgKiAgcGxhdGZvcm0uYzogcGxhdGZvcm0gc3VwcG9ydCBmb3IgUE5YODMzWC4KKyAqCisg
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
ZGUgPGxpbnV4L2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgor
I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNs
dWRlIDxsaW51eC9yZXNvdXJjZS5oPgorI2luY2x1ZGUgPGxpbnV4L3NlcmlhbC5oPgorI2luY2x1
ZGUgPGxpbnV4L3NlcmlhbF9wbng4eHh4Lmg+CisjaW5jbHVkZSA8bGludXgvaTJjLXBueDAxMDUu
aD4KKyNpbmNsdWRlIDxsaW51eC9tdGQvbmFuZC5oPgorI2luY2x1ZGUgPGxpbnV4L210ZC9wYXJ0
aXRpb25zLmg+CisKKyNpbmNsdWRlIDxpcnEuaD4KKyNpbmNsdWRlIDxpcnEtbWFwcGluZy5oPgor
I2luY2x1ZGUgPHBueDgzM3guaD4KKworc3RhdGljIHU2NCB1YXJ0X2RtYW1hc2sgICAgID0gfih1
MzIpMDsKKworc3RhdGljIHN0cnVjdCByZXNvdXJjZSBwbng4MzN4X3VhcnRfcmVzb3VyY2VzW10g
PSB7CisJWzBdID0geworCQkuc3RhcnQJCT0gUE5YODMzWF9VQVJUMF9QT1JUU19TVEFSVCwKKwkJ
LmVuZAkJPSBQTlg4MzNYX1VBUlQwX1BPUlRTX0VORCwKKwkJLmZsYWdzCQk9IElPUkVTT1VSQ0Vf
TUVNLAorCX0sCisJWzFdID0geworCQkuc3RhcnQJCT0gUE5YODMzWF9QSUNfVUFSVDBfSU5ULAor
CQkuZW5kCQk9IFBOWDgzM1hfUElDX1VBUlQwX0lOVCwKKwkJLmZsYWdzCQk9IElPUkVTT1VSQ0Vf
SVJRLAorCX0sCisJWzJdID0geworCQkuc3RhcnQJCT0gUE5YODMzWF9VQVJUMV9QT1JUU19TVEFS
VCwKKwkJLmVuZAkJPSBQTlg4MzNYX1VBUlQxX1BPUlRTX0VORCwKKwkJLmZsYWdzCQk9IElPUkVT
T1VSQ0VfTUVNLAorCX0sCisJWzNdID0geworCQkuc3RhcnQJCT0gUE5YODMzWF9QSUNfVUFSVDFf
SU5ULAorCQkuZW5kCQk9IFBOWDgzM1hfUElDX1VBUlQxX0lOVCwKKwkJLmZsYWdzCQk9IElPUkVT
T1VSQ0VfSVJRLAorCX0sCit9OworCitzdHJ1Y3QgcG54OHh4eF9wb3J0IHBueDh4eHhfcG9ydHNb
XSA9IHsKKwlbMF0gPSB7CisJCS5wb3J0ICAgPSB7CisJCQkudHlwZQkJPSBQT1JUX1BOWDhYWFgs
CisJCQkuaW90eXBlCQk9IFVQSU9fTUVNLAorCQkJLm1lbWJhc2UJPSAodm9pZCBfX2lvbWVtICop
UE5YODMzWF9VQVJUMF9QT1JUU19TVEFSVCwKKwkJCS5tYXBiYXNlCT0gUE5YODMzWF9VQVJUMF9Q
T1JUU19TVEFSVCwKKwkJCS5pcnEJCT0gUE5YODMzWF9QSUNfVUFSVDBfSU5ULAorCQkJLnVhcnRj
bGsJPSAzNjkyMzAwLAorCQkJLmZpZm9zaXplCT0gMTYsCisJCQkuZmxhZ3MJCT0gVVBGX0JPT1Rf
QVVUT0NPTkYsCisJCQkubGluZQkJPSAwLAorCQl9LAorCX0sCisJWzFdID0geworCQkucG9ydCAg
ID0geworCQkJLnR5cGUJCT0gUE9SVF9QTlg4WFhYLAorCQkJLmlvdHlwZQkJPSBVUElPX01FTSwK
KwkJCS5tZW1iYXNlCT0gKHZvaWQgX19pb21lbSAqKVBOWDgzM1hfVUFSVDFfUE9SVFNfU1RBUlQs
CisJCQkubWFwYmFzZQk9IFBOWDgzM1hfVUFSVDFfUE9SVFNfU1RBUlQsCisJCQkuaXJxCQk9IFBO
WDgzM1hfUElDX1VBUlQxX0lOVCwKKwkJCS51YXJ0Y2xrCT0gMzY5MjMwMCwKKwkJCS5maWZvc2l6
ZQk9IDE2LAorCQkJLmZsYWdzCQk9IFVQRl9CT09UX0FVVE9DT05GLAorCQkJLmxpbmUJCT0gMSwK
KwkJfSwKKwl9LAorfTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgcG54ODMzeF91
YXJ0X2RldmljZSA9IHsKKwkubmFtZQkJPSAicG54OHh4eC11YXJ0IiwKKwkuaWQJCT0gLTEsCisJ
LmRldiA9IHsKKwkJLmRtYV9tYXNrCQk9ICZ1YXJ0X2RtYW1hc2ssCisJCS5jb2hlcmVudF9kbWFf
bWFzawk9IDB4ZmZmZmZmZmYsCisJCS5wbGF0Zm9ybV9kYXRhCQk9IHBueDh4eHhfcG9ydHMsCisJ
fSwKKwkubnVtX3Jlc291cmNlcwk9IEFSUkFZX1NJWkUocG54ODMzeF91YXJ0X3Jlc291cmNlcyks
CisJLnJlc291cmNlCT0gcG54ODMzeF91YXJ0X3Jlc291cmNlcywKK307CisKK3N0YXRpYyB1NjQg
ZWhjaV9kbWFtYXNrICAgICA9IH4odTMyKTA7CisKK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgcG54
ODMzeF91c2JfZWhjaV9yZXNvdXJjZXNbXSA9IHsKKwlbMF0gPSB7CisJCS5zdGFydAkJPSBQTlg4
MzNYX1VTQl9QT1JUU19TVEFSVCwKKwkJLmVuZAkJPSBQTlg4MzNYX1VTQl9QT1JUU19FTkQsCisJ
CS5mbGFncwkJPSBJT1JFU09VUkNFX01FTSwKKwl9LAorCVsxXSA9IHsKKwkJLnN0YXJ0CQk9IFBO
WDgzM1hfUElDX1VTQl9JTlQsCisJCS5lbmQJCT0gUE5YODMzWF9QSUNfVVNCX0lOVCwKKwkJLmZs
YWdzCQk9IElPUkVTT1VSQ0VfSVJRLAorCX0sCit9OworCitzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RldmljZSBwbng4MzN4X3VzYl9laGNpX2RldmljZSA9IHsKKwkubmFtZQkJPSAicG54ODMzeC1l
aGNpIiwKKwkuaWQJCT0gLTEsCisJLmRldiA9IHsKKwkJLmRtYV9tYXNrCQk9ICZlaGNpX2RtYW1h
c2ssCisJCS5jb2hlcmVudF9kbWFfbWFzawk9IDB4ZmZmZmZmZmYsCisJfSwKKwkubnVtX3Jlc291
cmNlcwk9IEFSUkFZX1NJWkUocG54ODMzeF91c2JfZWhjaV9yZXNvdXJjZXMpLAorCS5yZXNvdXJj
ZQk9IHBueDgzM3hfdXNiX2VoY2lfcmVzb3VyY2VzLAorfTsKKworc3RhdGljIHN0cnVjdCByZXNv
dXJjZSBwbng4MzN4X2kyYzBfcmVzb3VyY2VzW10gPSB7CisJeworCQkuc3RhcnQJCT0gUE5YODMz
WF9JMkMwX1BPUlRTX1NUQVJULAorCQkuZW5kCQk9IFBOWDgzM1hfSTJDMF9QT1JUU19FTkQsCisJ
CS5mbGFncwkJPSBJT1JFU09VUkNFX01FTSwKKwl9LAorCXsKKwkJLnN0YXJ0CQk9IFBOWDgzM1hf
UElDX0kyQzBfSU5ULAorCQkuZW5kCQk9IFBOWDgzM1hfUElDX0kyQzBfSU5ULAorCQkuZmxhZ3MJ
CT0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgcG54
ODMzeF9pMmMxX3Jlc291cmNlc1tdID0geworCXsKKwkJLnN0YXJ0CQk9IFBOWDgzM1hfSTJDMV9Q
T1JUU19TVEFSVCwKKwkJLmVuZAkJPSBQTlg4MzNYX0kyQzFfUE9SVFNfRU5ELAorCQkuZmxhZ3MJ
CT0gSU9SRVNPVVJDRV9NRU0sCisJfSwKKwl7CisJCS5zdGFydAkJPSBQTlg4MzNYX1BJQ19JMkMx
X0lOVCwKKwkJLmVuZAkJPSBQTlg4MzNYX1BJQ19JMkMxX0lOVCwKKwkJLmZsYWdzCQk9IElPUkVT
T1VSQ0VfSVJRLAorCX0sCit9OworCitzdGF0aWMgc3RydWN0IGkyY19wbngwMTA1X2RldiBwbng4
MzN4X2kyY19kZXZbXSA9IHsKKwl7CisJCS5iYXNlID0gUE5YODMzWF9JMkMwX1BPUlRTX1NUQVJU
LAorCQkuaXJxID0gLTEsIC8qIHNob3VsZCBiZSBQTlg4MzNYX1BJQ19JMkMwX0lOVCBidXQgcG9s
bGluZyBpcyBmYXN0ZXIgKi8KKwkJLmNsb2NrID0gNiwJLyogMCA9PSA0MDAga0h6LCA0ID09IDEw
MCBrSHooTWF4aW11bSBIRE1JKSwgNiA9IDUwa0h6KFByZWZlcmVkIEhEQ1ApICovCisJCS5idXNf
YWRkciA9IDAsCS8qIG5vIHNsYXZlIHN1cHBvcnQgKi8KKwl9LAorCXsKKwkJLmJhc2UgPSBQTlg4
MzNYX0kyQzFfUE9SVFNfU1RBUlQsCisJCS5pcnEgPSAtMSwJLyogb24gaGlnaCBmcmVxLCBwb2xs
aW5nIGlzIGZhc3RlciAqLworCQkvKi5pcnEgPSBQTlg4MzNYX1BJQ19JMkMxX0lOVCwqLworCQku
Y2xvY2sgPSA0LAkvKiAwID09IDQwMCBrSHosIDQgPT0gMTAwIGtIei4gMTAwIGtIeiBzZWVtcyBh
IHNhZmUgZGVmYXVsdCBmb3Igbm93ICovCisJCS5idXNfYWRkciA9IDAsCS8qIG5vIHNsYXZlIHN1
cHBvcnQgKi8KKwl9LAorfTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgcG54ODMz
eF9pMmMwX2RldmljZSA9IHsKKwkubmFtZQkJPSAiaTJjLXBueDAxMDUiLAorCS5pZAkJPSAwLAor
CS5kZXYgPSB7CisJCS5wbGF0Zm9ybV9kYXRhID0gJnBueDgzM3hfaTJjX2RldlswXSwKKwl9LAor
CS5udW1fcmVzb3VyY2VzICA9IEFSUkFZX1NJWkUocG54ODMzeF9pMmMwX3Jlc291cmNlcyksCisJ
LnJlc291cmNlCT0gcG54ODMzeF9pMmMwX3Jlc291cmNlcywKK307CisKK3N0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlIHBueDgzM3hfaTJjMV9kZXZpY2UgPSB7CisJLm5hbWUJCT0gImkyYy1w
bngwMTA1IiwKKwkuaWQJCT0gMSwKKwkuZGV2ID0geworCQkucGxhdGZvcm1fZGF0YSA9ICZwbng4
MzN4X2kyY19kZXZbMV0sCisJfSwKKwkubnVtX3Jlc291cmNlcyAgPSBBUlJBWV9TSVpFKHBueDgz
M3hfaTJjMV9yZXNvdXJjZXMpLAorCS5yZXNvdXJjZQk9IHBueDgzM3hfaTJjMV9yZXNvdXJjZXMs
Cit9OworCitzdGF0aWMgdTY0IGV0aGVybmV0X2RtYW1hc2sgPSB+KHUzMikwOworCitzdGF0aWMg
c3RydWN0IHJlc291cmNlIHBueDgzM3hfZXRoZXJuZXRfcmVzb3VyY2VzW10gPSB7CisJWzBdID0g
eworCQkuc3RhcnQgPSBQTlg4MzM1X0lQMzkwMl9QT1JUU19TVEFSVCwKKwkJLmVuZCAgID0gUE5Y
ODMzNV9JUDM5MDJfUE9SVFNfRU5ELAorCQkuZmxhZ3MgPSBJT1JFU09VUkNFX01FTSwKKwl9LAor
CVsxXSA9IHsKKwkJLnN0YXJ0ID0gUE5YODMzNV9QSUNfRVRIRVJORVRfSU5ULAorCQkuZW5kICAg
PSBQTlg4MzM1X1BJQ19FVEhFUk5FVF9JTlQsCisJCS5mbGFncyA9IElPUkVTT1VSQ0VfSVJRLAor
CX0sCit9OworCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBwbng4MzN4X2V0aGVybmV0
X2RldmljZSA9IHsKKwkubmFtZSA9ICJpcDM5MDItZXRoIiwKKwkuaWQgICA9IC0xLAorCS5kZXYg
ID0geworCQkuZG1hX21hc2sgICAgICAgICAgPSAmZXRoZXJuZXRfZG1hbWFzaywKKwkJLmNvaGVy
ZW50X2RtYV9tYXNrID0gMHhmZmZmZmZmZiwKKwl9LAorCS5udW1fcmVzb3VyY2VzID0gQVJSQVlf
U0laRShwbng4MzN4X2V0aGVybmV0X3Jlc291cmNlcyksCisJLnJlc291cmNlICAgICAgPSBwbng4
MzN4X2V0aGVybmV0X3Jlc291cmNlcywKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgcG54
ODMzeF9zYXRhX3Jlc291cmNlc1tdID0geworCVswXSA9IHsKKwkJLnN0YXJ0ID0gUE5YODMzNV9T
QVRBX1BPUlRTX1NUQVJULAorCQkuZW5kICAgPSBQTlg4MzM1X1NBVEFfUE9SVFNfRU5ELAorCQku
ZmxhZ3MgPSBJT1JFU09VUkNFX01FTSwKKwl9LAorCVsxXSA9IHsKKwkJLnN0YXJ0ID0gUE5YODMz
NV9QSUNfU0FUQV9JTlQsCisJCS5lbmQgICA9IFBOWDgzMzVfUElDX1NBVEFfSU5ULAorCQkuZmxh
Z3MgPSBJT1JFU09VUkNFX0lSUSwKKwl9LAorfTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgcG54ODMzeF9zYXRhX2RldmljZSA9IHsKKwkubmFtZSAgICAgICAgICA9ICJwbng4MzN4
LXNhdGEiLAorCS5pZCAgICAgICAgICAgID0gLTEsCisJLm51bV9yZXNvdXJjZXMgPSBBUlJBWV9T
SVpFKHBueDgzM3hfc2F0YV9yZXNvdXJjZXMpLAorCS5yZXNvdXJjZSAgICAgID0gcG54ODMzeF9z
YXRhX3Jlc291cmNlcywKK307CisKK3N0YXRpYyBjb25zdCBjaGFyICpwYXJ0X3Byb2Jlc1tdID0g
eyAiY21kbGluZXBhcnQiLCAwIH07CisKK3N0YXRpYyB2b2lkCitwbng4MzN4X2ZsYXNoX25hbmRf
Y21kX2N0cmwoc3RydWN0IG10ZF9pbmZvICptdGQsIGludCBjbWQsIHVuc2lnbmVkIGludCBjdHJs
KQoreworCXN0cnVjdCBuYW5kX2NoaXAgKnRoaXMgPSBtdGQtPnByaXY7CisJdW5zaWduZWQgbG9u
ZyBuYW5kYWRkciA9ICh1bnNpZ25lZCBsb25nKXRoaXMtPklPX0FERFJfVzsKKworCWlmIChjbWQg
PT0gTkFORF9DTURfTk9ORSkKKwkJcmV0dXJuOworCisJaWYgKGN0cmwgJiBOQU5EX0NMRSkKKwkJ
d3JpdGViKGNtZCwgKHZvaWQgX19pb21lbSAqKShuYW5kYWRkciArIFBOWDgzMzVfTkFORF9DTEVf
TUFTSykpOworCWVsc2UKKwkJd3JpdGViKGNtZCwgKHZvaWQgX19pb21lbSAqKSAobmFuZGFkZHIg
KyBQTlg4MzM1X05BTkRfQUxFX01BU0spKTsKK30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9u
YW5kX2RhdGEgcG54ODMzeF9mbGFzaF9uYW5kX2RhdGEgPSB7CisJLmNoaXAgPSB7CisJCS5jaGlw
X2RlbGF5CQk9IDI1LAorCQkucGFydF9wcm9iZV90eXBlcyAJPSBwYXJ0X3Byb2JlcywKKwl9LAor
CS5jdHJsID0geworCQkuY21kX2N0cmwgCQk9IHBueDgzM3hfZmxhc2hfbmFuZF9jbWRfY3RybAor
CX0KK307CisKKy8qCisgKiBTZXQgc3RhcnQgdG8gYmUgdGhlIGNvcnJlY3QgYWRkcmVzcyAoUE5Y
ODMzNV9OQU5EX0JBU0Ugd2l0aCBubyAweGIhISksCisgKiAxMiBieXRlcyBtb3JlIHNlZW1zIHRv
IGJlIHRoZSBzdGFuZGFyZCB0aGF0IGFsbG93cyBmb3IgTkFORCBhY2Nlc3MuCisgKi8KK3N0YXRp
YyBzdHJ1Y3QgcmVzb3VyY2UgcG54ODMzeF9mbGFzaF9uYW5kX3Jlc291cmNlID0geworCS5zdGFy
dCAJPSBQTlg4MzM1X05BTkRfQkFTRSwKKwkuZW5kIAk9IFBOWDgzMzVfTkFORF9CQVNFICsgMTIs
CisJLmZsYWdzIAk9IElPUkVTT1VSQ0VfTUVNLAorfTsKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgcG54ODMzeF9mbGFzaF9uYW5kID0geworCS5uYW1lCSAgICAgICAgPSAiZ2VuX25h
bmQiLAorCS5pZAkJICAgICAgICA9IC0xLAorCS5udW1fcmVzb3VyY2VzCT0gMSwKKwkucmVzb3Vy
Y2UJICAgID0gJnBueDgzM3hfZmxhc2hfbmFuZF9yZXNvdXJjZSwKKwkuZGV2ICAgICAgICAgICAg
PSB7CisJCS5wbGF0Zm9ybV9kYXRhID0gJnBueDgzM3hfZmxhc2hfbmFuZF9kYXRhLAorCX0sCit9
OworCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcG54ODMzeF9wbGF0Zm9ybV9kZXZp
Y2VzW10gX19pbml0ZGF0YSA9IHsKKwkmcG54ODMzeF91YXJ0X2RldmljZSwKKwkmcG54ODMzeF91
c2JfZWhjaV9kZXZpY2UsCisJJnBueDgzM3hfaTJjMF9kZXZpY2UsCisJJnBueDgzM3hfaTJjMV9k
ZXZpY2UsCisJJnBueDgzM3hfZXRoZXJuZXRfZGV2aWNlLAorCSZwbng4MzN4X3NhdGFfZGV2aWNl
LAorCSZwbng4MzN4X2ZsYXNoX25hbmQsCit9OworCitzdGF0aWMgaW50IF9faW5pdCBwbng4MzN4
X3BsYXRmb3JtX2luaXQodm9pZCkKK3sKKwlpbnQgcmVzOworCisJcmVzID0gcGxhdGZvcm1fYWRk
X2RldmljZXMocG54ODMzeF9wbGF0Zm9ybV9kZXZpY2VzLAorCQkJCQkJCSAgIEFSUkFZX1NJWkUo
cG54ODMzeF9wbGF0Zm9ybV9kZXZpY2VzKSk7CisJcmV0dXJuIHJlczsKK30KKworYXJjaF9pbml0
Y2FsbChwbng4MzN4X3BsYXRmb3JtX2luaXQpOwpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGlu
dXgtMi42LjI2LXJjNC5vcmlnL2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vcHJvbS5jIGxp
bnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9wcm9tLmMKLS0tIGxp
bnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL3Byb20uYwkx
OTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9h
cmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9uL3Byb20uYwkyMDA4LTA2LTA2IDExOjI5OjU1LjAw
MDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDcwIEBACisvKgorICogIHByb20uYzoKKyAqCisgKiAg
Q29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENocmlzIFN0ZWVsIDxjaHJp
cy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwuai5sYWlyZEBueHAu
Y29tPgorICoKKyAqICBCYXNlZCBvbiBzb2Z0d2FyZSB3cml0dGVuIGJ5OgorICogICAgICBOaWtp
dGEgWW91c2hjaGVua28gPHlvdXNoQGRlYmlhbi5vcmc+LCBiYXNlZCBvbiBQTlg4NTUwIGNvZGUu
CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICog
IChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJvZ3Jh
bSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICog
IGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJh
bnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQ
VVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3Jl
IGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07
IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqICBGb3VuZGF0aW9uLCBJbmMu
LCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4KKyAqLworI2luY2x1ZGUg
PGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxhc20vYm9vdGluZm8uaD4KKyNpbmNsdWRlIDxsaW51
eC9zdHJpbmcuaD4KKwordm9pZCBfX2luaXQgcHJvbV9pbml0X2NtZGxpbmUodm9pZCkKK3sKKwlp
bnQgYXJnYyA9IGZ3X2FyZzA7CisJY2hhciAqKmFyZ3YgPSAoY2hhciAqKilmd19hcmcxOworCWNo
YXIgKmMgPSAmKGFyY3NfY21kbGluZVswXSk7CisJaW50IGk7CisKKwlmb3IgKGkgPSAxOyBpIDwg
YXJnYzsgaSsrKSB7CisJCXN0cmNweShjLCBhcmd2W2ldKTsKKwkJYyArPSBzdHJsZW4oYXJndltp
XSk7CisJCWlmIChpIDwgYXJnYy0xKQorCQkJKmMrKyA9ICcgJzsKKwl9CisJKmMgPSAwOworfQor
CitjaGFyIF9faW5pdCAqcHJvbV9nZXRlbnYoY2hhciAqZW52bmFtZSkKK3sKKwlleHRlcm4gY2hh
ciAqKnByb21fZW52cDsKKwljaGFyICoqZW52ID0gcHJvbV9lbnZwOworCWludCBpOworCisJaSA9
IHN0cmxlbihlbnZuYW1lKTsKKworCXdoaWxlICgqZW52KSB7CisJCWlmIChzdHJuY21wKGVudm5h
bWUsICplbnYsIGkpID09IDAgJiYgKigqZW52K2kpID09ICc9JykKKwkJCXJldHVybiAqZW52ICsg
aSArIDE7CisJCWVudisrOworCX0KKworCXJldHVybiAwOworfQorCit2b2lkIF9faW5pdCBwcm9t
X2ZyZWVfcHJvbV9tZW1vcnkodm9pZCkKK3sKK30KKworY2hhciAqIF9faW5pdCBwcm9tX2dldGNt
ZGxpbmUodm9pZCkKK3sKKwlyZXR1cm4gYXJjc19jbWRsaW5lOworfQorCmRpZmYgLXVyTiAtLWV4
Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L2Nv
bW1vbi9yZXNldC5jIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1v
bi9yZXNldC5jCi0tLSBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4
L2NvbW1vbi9yZXNldC5jCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBs
aW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9jb21tb24vcmVzZXQuYwkyMDA4
LTA2LTEyIDEyOjAxOjIzLjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDQ1IEBACisvKgorICog
IHJlc2V0LmM6IHJlc2V0IHN1cHBvcnQgZm9yIFBOWDgzM1guCisgKgorICogIENvcHlyaWdodCAy
MDA4IE5YUCBTZW1pY29uZHVjdG9ycworICoJICBDaHJpcyBTdGVlbCA8Y2hyaXMuc3RlZWxAbnhw
LmNvbT4KKyAqICAgIERhbmllbCBMYWlyZCA8ZGFuaWVsLmoubGFpcmRAbnhwLmNvbT4KKyAqCisg
KiAgQmFzZWQgb24gc29mdHdhcmUgd3JpdHRlbiBieToKKyAqICAgICAgTmlraXRhIFlvdXNoY2hl
bmtvIDx5b3VzaEBkZWJpYW4ub3JnPiwgYmFzZWQgb24gUE5YODU1MCBjb2RlLgorICoKKyAqICBU
aGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBv
cHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9V
VCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICog
IE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNl
ZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgor
ICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdy
aXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiAgRm91bmRhdGlvbiwgSW5jLiwgNjc1IE1hc3Mg
QXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKyNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+CisjaW5jbHVkZSA8bGludXgvcmVib290Lmg+CisjaW5jbHVkZSA8cG54ODMzeC5oPgorCit2
b2lkIHBueDgzM3hfbWFjaGluZV9yZXN0YXJ0KGNoYXIgKmNvbW1hbmQpCit7CisJUE5YODMzWF9S
RVNFVF9DT05UUk9MXzIgPSAwOworCVBOWDgzM1hfUkVTRVRfQ09OVFJPTCA9IDA7Cit9CisKK3Zv
aWQgcG54ODMzeF9tYWNoaW5lX2hhbHQodm9pZCkKK3sKKwl3aGlsZSAoMSkKKwkJX19hc21fXyBf
X3ZvbGF0aWxlX18gKCJ3YWl0Iik7CisKK30KKwordm9pZCBwbng4MzN4X21hY2hpbmVfcG93ZXJf
b2ZmKHZvaWQpCit7CisJcG54ODMzeF9tYWNoaW5lX2hhbHQoKTsKK30KZGlmZiAtdXJOIC0tZXhj
bHVkZT0uc3ZuIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29t
bW9uL3NldHVwLmMgbGludXgtMi42LjI2LXJjNC9hcmNoL21pcHMvbnhwL3BueDgzM3gvY29tbW9u
L3NldHVwLmMKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3BueDgzM3gv
Y29tbW9uL3NldHVwLmMJMTk3MC0wMS0wMSAwMTowMDowMC4wMDAwMDAwMDAgKzAxMDAKKysrIGxp
bnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L2NvbW1vbi9zZXR1cC5jCTIwMDgt
MDYtMDYgMTE6MzA6MTYuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsNjQgQEAKKy8qCisgKiAg
c2V0dXAuYzogU2V0dXAgUE5YODMzWCBTb2MuCisgKgorICogIENvcHlyaWdodCAyMDA4IE5YUCBT
ZW1pY29uZHVjdG9ycworICoJICBDaHJpcyBTdGVlbCA8Y2hyaXMuc3RlZWxAbnhwLmNvbT4KKyAq
ICAgIERhbmllbCBMYWlyZCA8ZGFuaWVsLmoubGFpcmRAbnhwLmNvbT4KKyAqCisgKiAgQmFzZWQg
b24gc29mdHdhcmUgd3JpdHRlbiBieToKKyAqICAgICAgTmlraXRhIFlvdXNoY2hlbmtvIDx5b3Vz
aEBkZWJpYW4ub3JnPiwgYmFzZWQgb24gUE5YODU1MCBjb2RlLgorICoKKyAqICBUaGlzIHByb2dy
YW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlm
eQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0
aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4g
dGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FS
UkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAq
ICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRo
ZSBGcmVlIFNvZnR3YXJlCisgKiAgRm91bmRhdGlvbiwgSW5jLiwgNjc1IE1hc3MgQXZlLCBDYW1i
cmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5j
bHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvaW9wb3J0Lmg+CisjaW5j
bHVkZSA8bGludXgvaW8uaD4KKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxhc20v
cmVib290Lmg+CisjaW5jbHVkZSA8cG54ODMzeC5oPgorI2luY2x1ZGUgPGdwaW8uaD4KKworZXh0
ZXJuIHZvaWQgcG54ODMzeF9ib2FyZF9zZXR1cCh2b2lkKTsKK2V4dGVybiB2b2lkIHBueDgzM3hf
bWFjaGluZV9yZXN0YXJ0KGNoYXIgKik7CitleHRlcm4gdm9pZCBwbng4MzN4X21hY2hpbmVfaGFs
dCh2b2lkKTsKK2V4dGVybiB2b2lkIHBueDgzM3hfbWFjaGluZV9wb3dlcl9vZmYodm9pZCk7CisK
K2ludCBfX2luaXQgcGxhdF9tZW1fc2V0dXAodm9pZCkKK3sKKwkvKiBmYWtlIHBjaSBidXMgdG8g
YXZvaWQgYm91bmNlIGJ1ZmZlcnMgKi8KKwlQQ0lfRE1BX0JVU19JU19QSFlTID0gMTsKKworCS8q
IHNldCBtaXBzIGNsb2NrIHRvIDMyME1IeiAqLworI2lmIGRlZmluZWQoQ09ORklHX1NPQ19QTlg4
MzM1KQorCVBOWDgzMzVfV1JJVEVGSUVMRCgweDE3LCBDTE9DS19QTExfQ1BVX0NUTCwgRlJFUSk7
CisjZW5kaWYKKwlwbng4MzN4X2dwaW9faW5pdCgpOwkvKiBzbyBpdCB3aWxsIGJlIHJlYWR5IGlu
IGJvYXJkX3NldHVwKCkgKi8KKworCXBueDgzM3hfYm9hcmRfc2V0dXAoKTsKKworCV9tYWNoaW5l
X3Jlc3RhcnQgPSBwbng4MzN4X21hY2hpbmVfcmVzdGFydDsKKwlfbWFjaGluZV9oYWx0ID0gcG54
ODMzeF9tYWNoaW5lX2hhbHQ7CisJcG1fcG93ZXJfb2ZmID0gcG54ODMzeF9tYWNoaW5lX3Bvd2Vy
X29mZjsKKworCS8qIElPL01FTSByZXNvdXJjZXMuICovCisJc2V0X2lvX3BvcnRfYmFzZShLU0VH
MSk7CisJaW9wb3J0X3Jlc291cmNlLnN0YXJ0ID0gMDsKKwlpb3BvcnRfcmVzb3VyY2UuZW5kID0g
fjA7CisJaW9tZW1fcmVzb3VyY2Uuc3RhcnQgPSAwOworCWlvbWVtX3Jlc291cmNlLmVuZCA9IH4w
OworCisJcmV0dXJuIDA7Cit9CmRpZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYt
cmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L3N0YjIyeC9ib2FyZC5jIGxpbnV4LTIuNi4y
Ni1yYzQvYXJjaC9taXBzL254cC9wbng4MzN4L3N0YjIyeC9ib2FyZC5jCi0tLSBsaW51eC0yLjYu
MjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4L3N0YjIyeC9ib2FyZC5jCTE5NzAtMDEt
MDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlw
cy9ueHAvcG54ODMzeC9zdGIyMngvYm9hcmQuYwkyMDA4LTA2LTA2IDExOjI4OjUwLjAwMDAwMDAw
MCArMDEwMApAQCAtMCwwICsxLDEzMyBAQAorLyoKKyAqICBib2FyZC5jOiBTVEIyMjUgYm9hcmQg
c3VwcG9ydC4KKyAqCisgKiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkg
IENocmlzIFN0ZWVsIDxjaHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxk
YW5pZWwuai5sYWlyZEBueHAuY29tPgorICoKKyAqICBCYXNlZCBvbiBzb2Z0d2FyZSB3cml0dGVu
IGJ5OgorICogICAgICBOaWtpdGEgWW91c2hjaGVua28gPHlvdXNoQGRlYmlhbi5vcmc+LCBiYXNl
ZCBvbiBQTlg4NTUwIGNvZGUuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkK
KyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRo
ZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisg
KgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdp
bGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVu
IHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcg
d2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAq
ICBGb3VuZGF0aW9uLCBJbmMuLCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVT
QS4KKyAqLworI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxhc20vYm9vdGluZm8u
aD4KKyNpbmNsdWRlIDxsaW51eC9tbS5oPgorI2luY2x1ZGUgPHBueDgzM3guaD4KKyNpbmNsdWRl
IDxncGlvLmg+CisKKy8qIGVuZGlhbmVzcyB0d2lkZGxlcnMgKi8KKyNkZWZpbmUgUE5YODMzNV9E
RUJVRzAgMHg0NDAwCisjZGVmaW5lIFBOWDgzMzVfREVCVUcxIDB4NDQwNAorI2RlZmluZSBQTlg4
MzM1X0RFQlVHMiAweDQ0MDgKKyNkZWZpbmUgUE5YODMzNV9ERUJVRzMgMHg0NDBjCisjZGVmaW5l
IFBOWDgzMzVfREVCVUc0IDB4NDQxMAorI2RlZmluZSBQTlg4MzM1X0RFQlVHNSAweDQ0MTQKKyNk
ZWZpbmUgUE5YODMzNV9ERUJVRzYgMHg0NDE4CisjZGVmaW5lIFBOWDgzMzVfREVCVUc3IDB4NDQx
YworCitpbnQgcHJvbV9hcmdjOworY2hhciAqKnByb21fYXJndiA9IDAsICoqcHJvbV9lbnZwID0g
MDsKKworZXh0ZXJuIHZvaWQgcHJvbV9pbml0X2NtZGxpbmUodm9pZCk7CitleHRlcm4gY2hhciAq
cHJvbV9nZXRlbnYoY2hhciAqZW52bmFtZSk7CisKK2NvbnN0IGNoYXIgKmdldF9zeXN0ZW1fdHlw
ZSh2b2lkKQoreworCXJldHVybiAiTlhQIFNUQjIyeCI7Cit9CisKK3N0YXRpYyBpbmxpbmUgdW5z
aWduZWQgbG9uZyBlbnZfb3JfZGVmYXVsdChjaGFyICplbnYsIHVuc2lnbmVkIGxvbmcgZGZsKQor
eworCWNoYXIgKnN0ciA9IHByb21fZ2V0ZW52KGVudik7CisJcmV0dXJuIHN0ciA/IHNpbXBsZV9z
dHJ0b2woc3RyLCAwLCAwKSA6IGRmbDsKK30KKwordm9pZCBfX2luaXQgcHJvbV9pbml0KHZvaWQp
Cit7CisJdW5zaWduZWQgbG9uZyBtZW1zaXplOworCisJcHJvbV9hcmdjID0gZndfYXJnMDsKKwlw
cm9tX2FyZ3YgPSAoY2hhciAqKilmd19hcmcxOworCXByb21fZW52cCA9IChjaGFyICoqKWZ3X2Fy
ZzI7CisKKwlwcm9tX2luaXRfY21kbGluZSgpOworCisJbWVtc2l6ZSA9IGVudl9vcl9kZWZhdWx0
KCJtZW1zaXplIiwgMHgwMjAwMDAwMCk7CisJYWRkX21lbW9yeV9yZWdpb24oMCwgbWVtc2l6ZSwg
Qk9PVF9NRU1fUkFNKTsKK30KKwordm9pZCBfX2luaXQgcG54ODMzeF9ib2FyZF9zZXR1cCh2b2lk
KQoreworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDQpOworCXBueDgzM3hfZ3Bp
b19zZWxlY3Rfb3V0cHV0KDQpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDUp
OworCXBueDgzM3hfZ3Bpb19zZWxlY3RfaW5wdXQoNSk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9m
dW5jdGlvbl9hbHQoNik7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9pbnB1dCg2KTsKKwlwbng4MzN4
X2dwaW9fc2VsZWN0X2Z1bmN0aW9uX2FsdCg3KTsKKwlwbng4MzN4X2dwaW9fc2VsZWN0X291dHB1
dCg3KTsKKworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDI1KTsKKwlwbng4MzN4
X2dwaW9fc2VsZWN0X2Z1bmN0aW9uX2FsdCgyNik7CisKKwlwbng4MzN4X2dwaW9fc2VsZWN0X2Z1
bmN0aW9uX2FsdCgyNyk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9hbHQoMjgpOwor
CXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDI5KTsKKwlwbng4MzN4X2dwaW9fc2Vs
ZWN0X2Z1bmN0aW9uX2FsdCgzMCk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9hbHQo
MzEpOworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDMyKTsKKwlwbng4MzN4X2dw
aW9fc2VsZWN0X2Z1bmN0aW9uX2FsdCgzMyk7CisKKyNpZiBkZWZpbmVkKENPTkZJR19NVERfTkFO
RF9QTEFURk9STSkgfHwgZGVmaW5lZChDT05GSUdfTVREX05BTkRfUExBVEZPUk1fTU9EVUxFKQor
CS8qIFNldHVwIE1JVSBmb3IgTkFORCBhY2Nlc3Mgb24gQ1MwLi4uCisJICoKKwkgKiAoaXQgc2Vl
bXMgdGhhdCB3ZSBtdXN0IGFsc28gY29uZmlndXJlIENTMSBmb3IgcmVsaWFibGUgb3BlcmF0aW9u
LAorCSAqIG90aGVyd2lzZSB0aGUgZmlyc3QgcmVhZCBJRCBjb21tYW5kIHdpbGwgZmFpbCBpZiBp
dCdzIHJlYWQgYXMgNCBieXRlcworCSAqIGJ1dCBwYXNzIGlmIGl0J3MgcmVhZCBhcyAxIHdvcmQu
KQorCSAqLworCisJLyogU2V0dXAgTUlVIENTMCAmIENTMSB0aW1pbmcgKi8KKwlQTlg4MzNYX01J
VV9TRUwwID0gMDsKKwlQTlg4MzNYX01JVV9TRUwxID0gMDsKKwlQTlg4MzNYX01JVV9TRUwwX1RJ
TUlORyA9IDB4NTAwMDMwODE7CisJUE5YODMzWF9NSVVfU0VMMV9USU1JTkcgPSAweDUwMDAzMDgx
OworCisJLyogU2V0dXAgR1BJTyAwMCBmb3IgdXNlIGFzIE1JVSBDUzEgKENTMCBpcyBub3QgbXVs
dGlwbGV4ZWQsIHNvIGRvZXMgbm90IG5lZWQgdGhpcykgKi8KKwlwbng4MzN4X2dwaW9fc2VsZWN0
X2Z1bmN0aW9uX2FsdCgwKTsKKworCS8qIFNldHVwIEdQSU8gMDQgdG8gaW5wdXQgTkFORCByZWFk
L2J1c3kgc2lnbmFsICovCisJcG54ODMzeF9ncGlvX3NlbGVjdF9mdW5jdGlvbl9pbyg0KTsKKwlw
bng4MzN4X2dwaW9fc2VsZWN0X2lucHV0KDQpOworCisJLyogU2V0dXAgR1BJTyAwNSB0byBkaXNh
YmxlIE5BTkQgd3JpdGUgcHJvdGVjdCAqLworCXBueDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25f
aW8oNSk7CisJcG54ODMzeF9ncGlvX3NlbGVjdF9vdXRwdXQoNSk7CisJcG54ODMzeF9ncGlvX3dy
aXRlKDEsIDUpOworCisjZWxpZiBkZWZpbmVkKENPTkZJR19NVERfQ0ZJKSB8fCBkZWZpbmVkKENP
TkZJR19NVERfQ0ZJX01PRFVMRSkKKworCS8qIFNldCB1cCBNSVUgZm9yIDE2LWJpdCBOT1IgYWNj
ZXNzIG9uIENTMCBhbmQgQ1MxLi4uICovCisKKwkvKiBTZXR1cCBNSVUgQ1MwICYgQ1MxIHRpbWlu
ZyAqLworCVBOWDgzM1hfTUlVX1NFTDAgPSAxOworCVBOWDgzM1hfTUlVX1NFTDEgPSAxOworCVBO
WDgzM1hfTUlVX1NFTDBfVElNSU5HID0gMHg2QTA4RDA4MjsKKwlQTlg4MzNYX01JVV9TRUwxX1RJ
TUlORyA9IDB4NkEwOEQwODI7CisKKwkvKiBTZXR1cCBHUElPIDAwIGZvciB1c2UgYXMgTUlVIENT
MSAoQ1MwIGlzIG5vdCBtdWx0aXBsZXhlZCwgc28gZG9lcyBub3QgbmVlZCB0aGlzKSAqLworCXBu
eDgzM3hfZ3Bpb19zZWxlY3RfZnVuY3Rpb25fYWx0KDApOworI2VuZGlmCit9CmRpZmYgLXVyTiAt
LWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvYXJjaC9taXBzL254cC9wbng4MzN4
L3N0YjIyeC9NYWtlZmlsZSBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9z
dGIyMngvTWFrZWZpbGUKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMvbnhwL3Bu
eDgzM3gvc3RiMjJ4L01ha2VmaWxlCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAw
CisrKyBsaW51eC0yLjYuMjYtcmM0L2FyY2gvbWlwcy9ueHAvcG54ODMzeC9zdGIyMngvTWFrZWZp
bGUJMjAwOC0wMy0wMyAxMzowOTozMC4wMDAwMDAwMDAgKzAwMDAKQEAgLTAsMCArMSBAQAorbGli
LXkgOj0gYm9hcmQubwpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGludXgtMi42LjI2LXJjNC5v
cmlnL2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2dwaW8uaCBsaW51eC0yLjYuMjYtcmM0
L2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2dwaW8uaAotLS0gbGludXgtMi42LjI2LXJj
NC5vcmlnL2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2dwaW8uaAkxOTcwLTAxLTAxIDAx
OjAwOjAwLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9pbmNsdWRlL2FzbS1t
aXBzL21hY2gtcG54ODMzeC9ncGlvLmgJMjAwOC0wNi0wNiAxMToyOTowOS4wMDAwMDAwMDAgKzAx
MDAKQEAgLTAsMCArMSwxNzIgQEAKKy8qCisgKiAgZ3Bpby5oOiBHUElPIFN1cHBvcnQgZm9yIFBO
WDgzM1guCisgKgorICogIENvcHlyaWdodCAyMDA4IE5YUCBTZW1pY29uZHVjdG9ycworICoJICBD
aHJpcyBTdGVlbCA8Y2hyaXMuc3RlZWxAbnhwLmNvbT4KKyAqICAgIERhbmllbCBMYWlyZCA8ZGFu
aWVsLmoubGFpcmRAbnhwLmNvbT4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2Yg
dGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4K
KyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2
ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJl
Y2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9u
ZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQor
ICogIEZvdW5kYXRpb24sIEluYy4sIDY3NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEzOSwg
VVNBLgorICovCisjaWZuZGVmIF9fQVNNX01JUFNfTUFDSF9QTlg4MzNYX0dQSU9fSAorI2RlZmlu
ZSBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9HUElPX0gKKworLyogQklHIEZBVCBXQVJOSU5HOiBy
YWNlcyBkYW5nZXIhCisgICBObyBwcm90ZWN0aW9ucyBleGlzdCBoZXJlLiBDdXJyZW50IHVzZXJz
IGFyZSBvbmx5IGVhcmx5IGluaXQgY29kZSwKKyAgIHdoZW4gbG9ja2luZyBpcyBub3QgbmVlZGVk
IGJlY2F1c2Ugbm8gY3VuY3VyZW5jeSB5ZXQgZXhpc3RzIHRoZXJlLAorICAgYW5kIEdQSU8gSVJR
IGRpc3BhdGNoZXIsIHdoaWNoIGRvZXMgbG9ja2luZy4KKyAgIEhvd2V2ZXIsIGlmIG1hbnkgdXNl
cyB3aWxsIGV2ZXIgaGFwcGVuLCBwcm9wZXIgbG9ja2luZyB3aWxsIGJlIG5lZWRlZAorICAgLSBp
bmNsdWRpbmcgbG9ja2luZyBiZXR3ZWVuIGRpZmZlcmVudCB1c2VzCisqLworCisjaW5jbHVkZSAi
cG54ODMzeC5oIgorCisjZGVmaW5lIFNFVF9SRUdfQklUKHJlZywgYml0KQkJcmVnIHw9ICgxIDw8
IChiaXQpKQorI2RlZmluZSBDTEVBUl9SRUdfQklUKHJlZywgYml0KQkJcmVnICY9IH4oMSA8PCAo
Yml0KSkKKworLyogSW5pdGlhbGl6ZSBHUElPIHRvIGEga25vd24gc3RhdGUgKi8KK3N0YXRpYyBp
bmxpbmUgdm9pZCBwbng4MzN4X2dwaW9faW5pdCh2b2lkKQoreworCVBOWDgzM1hfUElPX0RJUiA9
IDA7CisJUE5YODMzWF9QSU9fRElSMiA9IDA7CisJUE5YODMzWF9QSU9fU0VMID0gMDsKKwlQTlg4
MzNYX1BJT19TRUwyID0gMDsKKwlQTlg4MzNYX1BJT19JTlRfRURHRSA9IDA7CisJUE5YODMzWF9Q
SU9fSU5UX0hJID0gMDsKKwlQTlg4MzNYX1BJT19JTlRfTE8gPSAwOworCisJLyogY2xlYXIgYW55
IEdQSU8gaW50ZXJydXB0IHJlcXVlc3RzICovCisJUE5YODMzWF9QSU9fSU5UX0NMRUFSID0gMHhm
ZmZmOworCVBOWDgzM1hfUElPX0lOVF9DTEVBUiA9IDA7CisJUE5YODMzWF9QSU9fSU5UX0VOQUJM
RSA9IDA7Cit9CisKKy8qIFNlbGVjdCBHUElPIGRpcmVjdGlvbiBmb3IgYSBwaW4gKi8KK3N0YXRp
YyBpbmxpbmUgdm9pZCBwbng4MzN4X2dwaW9fc2VsZWN0X2lucHV0KHVuc2lnbmVkIGludCBwaW4p
Cit7CisJaWYgKHBpbiA8IDMyKQorCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX0RJUiwgcGlu
KTsKKwllbHNlCisJCUNMRUFSX1JFR19CSVQoUE5YODMzWF9QSU9fRElSMiwgcGluICYgMzEpOwor
fQorc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bpb19zZWxlY3Rfb3V0cHV0KHVuc2lnbmVk
IGludCBwaW4pCit7CisJaWYgKHBpbiA8IDMyKQorCQlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19E
SVIsIHBpbik7CisJZWxzZQorCQlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19ESVIyLCBwaW4gJiAz
MSk7Cit9CisKKy8qIFNlbGVjdCBHUElPIG9yIGFsdGVybmF0ZSBmdW5jdGlvbiBmb3IgYSBwaW4g
Ki8KK3N0YXRpYyBpbmxpbmUgdm9pZCBwbng4MzN4X2dwaW9fc2VsZWN0X2Z1bmN0aW9uX2lvKHVu
c2lnbmVkIGludCBwaW4pCit7CisJaWYgKHBpbiA8IDMyKQorCQlDTEVBUl9SRUdfQklUKFBOWDgz
M1hfUElPX1NFTCwgcGluKTsKKwllbHNlCisJCUNMRUFSX1JFR19CSVQoUE5YODMzWF9QSU9fU0VM
MiwgcGluICYgMzEpOworfQorc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bpb19zZWxlY3Rf
ZnVuY3Rpb25fYWx0KHVuc2lnbmVkIGludCBwaW4pCit7CisJaWYgKHBpbiA8IDMyKQorCQlTRVRf
UkVHX0JJVChQTlg4MzNYX1BJT19TRUwsIHBpbik7CisJZWxzZQorCQlTRVRfUkVHX0JJVChQTlg4
MzNYX1BJT19TRUwyLCBwaW4gJiAzMSk7Cit9CisKKy8qIFJlYWQgR1BJTyBwaW4gKi8KK3N0YXRp
YyBpbmxpbmUgaW50IHBueDgzM3hfZ3Bpb19yZWFkKHVuc2lnbmVkIGludCBwaW4pCit7CisJaWYg
KHBpbiA8IDMyKQorCQlyZXR1cm4oUE5YODMzWF9QSU9fSU4gPj4gcGluKSAmIDE7CisJZWxzZQor
CQlyZXR1cm4oUE5YODMzWF9QSU9fSU4yID4+IChwaW4gJiAzMSkpICYgMTsKK30KKworLyogV3Jp
dGUgR1BJTyBwaW4gKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCBwbng4MzN4X2dwaW9fd3JpdGUodW5z
aWduZWQgaW50IHZhbCwgdW5zaWduZWQgaW50IHBpbikKK3sKKwlpZiAocGluIDwgMzIpIHsKKwkJ
aWYgKHZhbCkKKwkJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX09VVCwgcGluKTsKKwkJZWxzZQor
CQkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19PVVQsIHBpbik7CisJfSBlbHNlIHsKKwkJaWYg
KHZhbCkKKwkJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX09VVDIsIHBpbiAmIDMxKTsKKwkJZWxz
ZQorCQkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19PVVQyLCBwaW4gJiAzMSk7CisJfQorfQor
CisvKiBDb25maWd1cmUgR1BJTyBpbnRlcnJ1cHQgKi8KKyNkZWZpbmUgR1BJT19JTlRfTk9ORQkJ
MAorI2RlZmluZSBHUElPX0lOVF9MRVZFTF9MT1cJMQorI2RlZmluZSBHUElPX0lOVF9MRVZFTF9I
SUdICTIKKyNkZWZpbmUgR1BJT19JTlRfRURHRV9SSVNJTkcJMworI2RlZmluZSBHUElPX0lOVF9F
REdFX0ZBTExJTkcJNAorI2RlZmluZSBHUElPX0lOVF9FREdFX0JPVEgJNQorc3RhdGljIGlubGlu
ZSB2b2lkIHBueDgzM3hfZ3Bpb19zZXR1cF9pcnEoaW50IHdoZW4sIHVuc2lnbmVkIGludCBwaW4p
Cit7CisJc3dpdGNoICh3aGVuKSB7CisJY2FzZSBHUElPX0lOVF9MRVZFTF9MT1c6CisJCUNMRUFS
X1JFR19CSVQoUE5YODMzWF9QSU9fSU5UX0VER0UsIHBpbik7CisJCUNMRUFSX1JFR19CSVQoUE5Y
ODMzWF9QSU9fSU5UX0hJLCBwaW4pOworCQlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfTE8s
IHBpbik7CisJCWJyZWFrOworCWNhc2UgR1BJT19JTlRfTEVWRUxfSElHSDoKKwkJQ0xFQVJfUkVH
X0JJVChQTlg4MzNYX1BJT19JTlRfRURHRSwgcGluKTsKKwkJU0VUX1JFR19CSVQoUE5YODMzWF9Q
SU9fSU5UX0hJLCBwaW4pOworCQlDTEVBUl9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9MTywgcGlu
KTsKKwkJYnJlYWs7CisJY2FzZSBHUElPX0lOVF9FREdFX1JJU0lORzoKKwkJU0VUX1JFR19CSVQo
UE5YODMzWF9QSU9fSU5UX0VER0UsIHBpbik7CisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX0lO
VF9ISSwgcGluKTsKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfTE8sIHBpbik7CisJ
CWJyZWFrOworCWNhc2UgR1BJT19JTlRfRURHRV9GQUxMSU5HOgorCQlTRVRfUkVHX0JJVChQTlg4
MzNYX1BJT19JTlRfRURHRSwgcGluKTsKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRf
SEksIHBpbik7CisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9MTywgcGluKTsKKwkJYnJl
YWs7CisJY2FzZSBHUElPX0lOVF9FREdFX0JPVEg6CisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElP
X0lOVF9FREdFLCBwaW4pOworCQlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfSEksIHBpbik7
CisJCVNFVF9SRUdfQklUKFBOWDgzM1hfUElPX0lOVF9MTywgcGluKTsKKwkJYnJlYWs7CisJZGVm
YXVsdDoKKwkJQ0xFQVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfRURHRSwgcGluKTsKKwkJQ0xF
QVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfSEksIHBpbik7CisJCUNMRUFSX1JFR19CSVQoUE5Y
ODMzWF9QSU9fSU5UX0xPLCBwaW4pOworCQlicmVhazsKKwl9Cit9CisKKy8qIEVuYWJsZS9kaXNh
YmxlIEdQSU8gaW50ZXJydXB0ICovCitzdGF0aWMgaW5saW5lIHZvaWQgcG54ODMzeF9ncGlvX2Vu
YWJsZV9pcnEodW5zaWduZWQgaW50IHBpbikKK3sKKwlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19J
TlRfRU5BQkxFLCBwaW4pOworfQorc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bpb19kaXNh
YmxlX2lycSh1bnNpZ25lZCBpbnQgcGluKQoreworCUNMRUFSX1JFR19CSVQoUE5YODMzWF9QSU9f
SU5UX0VOQUJMRSwgcGluKTsKK30KKworLyogQ2xlYXIgR1BJTyBpbnRlcnJ1cHQgcmVxdWVzdCAq
Lworc3RhdGljIGlubGluZSB2b2lkIHBueDgzM3hfZ3Bpb19jbGVhcl9pcnEodW5zaWduZWQgaW50
IHBpbikKK3sKKwlTRVRfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfQ0xFQVIsIHBpbik7CisJQ0xF
QVJfUkVHX0JJVChQTlg4MzNYX1BJT19JTlRfQ0xFQVIsIHBpbik7Cit9CisKKyNlbmRpZgpkaWZm
IC11ck4gLS1leGNsdWRlPS5zdm4gbGludXgtMi42LjI2LXJjNC5vcmlnL2luY2x1ZGUvYXNtLW1p
cHMvbWFjaC1wbng4MzN4L2lycS5oIGxpbnV4LTIuNi4yNi1yYzQvaW5jbHVkZS9hc20tbWlwcy9t
YWNoLXBueDgzM3gvaXJxLmgKLS0tIGxpbnV4LTIuNi4yNi1yYzQub3JpZy9pbmNsdWRlL2FzbS1t
aXBzL21hY2gtcG54ODMzeC9pcnEuaAkxOTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEw
MAorKysgbGludXgtMi42LjI2LXJjNC9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9pcnEu
aAkyMDA4LTA2LTEyIDEzOjA1OjMxLjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDUzIEBACisv
KgorICogIGlycS5oOiBJUlEgbWFwcGluZ3MgZm9yIFBOWDgzM1guCisgKgorICogIENvcHlyaWdo
dCAyMDA4IE5YUCBTZW1pY29uZHVjdG9ycworICoJICBDaHJpcyBTdGVlbCA8Y2hyaXMuc3RlZWxA
bnhwLmNvbT4KKyAqICAgIERhbmllbCBMYWlyZCA8ZGFuaWVsLmoubGFpcmRAbnhwLmNvbT4KKyAq
CisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRl
IGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJl
IEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0
IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlz
IGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0
IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkg
b2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBP
U0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogIEZvdW5kYXRpb24sIEluYy4sIDY3
NSBNYXNzIEF2ZSwgQ2FtYnJpZGdlLCBNQSAwMjEzOSwgVVNBLgorICovCisKKyNpZm5kZWYgX19B
U01fTUlQU19NQUNIX1BOWDgzM1hfSVJRX0gKKyNkZWZpbmUgX19BU01fTUlQU19NQUNIX1BOWDgz
M1hfSVJRX0gKKy8qCisgKiBUaGUgIklSUSBudW1iZXJzIiBhcmUgY29tcGxldGVseSB2aXJ0dWFs
LgorICoKKyAqIEluIFBOWDgzMzAvMSwgd2UgaGF2ZSA0OCBpbnRlcnJ1cHQgbGluZXMsIG51bWJl
cmVkIGZyb20gMSB0byA0OC4KKyAqIExldCdzIHVzZSBudW1iZXJzIDEuLjQ4IGZvciBQSUMgaW50
ZXJydXB0cywgbnVtYmVyIDAgZm9yIHRpbWVyIGludGVycnVwdCwKKyAqIG51bWJlcnMgNDkuLjY0
IGZvciAodmlydHVhbCkgR1BJTyBpbnRlcnJ1cHRzLgorICoKKyAqIEluIFBOWDgzMzUsIHdlIGhh
dmUgNTcgaW50ZXJydXB0IGxpbmVzLCBudW1iZXJlZCBmcm9tIDEgdG8gNTcsCisgKiBjb25uZWN0
ZWQgdG8gUElDLCB3aGljaCB1c2VzIGNvcmUgaGFyZHdhcmUgaW50ZXJydXB0IDIsIGFuZCBhbHNv
CisgKiBhIHRpbWVyIGludGVycnVwdCB0aHJvdWdoIGhhcmR3YXJlIGludGVycnVwdCA1LgorICog
TGV0J3MgdXNlIG51bWJlcnMgMS4uNjQgZm9yIFBJQyBpbnRlcnJ1cHRzLCBudW1iZXIgMCBmb3Ig
dGltZXIgaW50ZXJydXB0LAorICogbnVtYmVycyA2NS4uODAgZm9yICh2aXJ0dWFsKSBHUElPIGlu
dGVycnVwdHMuCisgKgorICovCisjaWYgZGVmaW5lZChDT05GSUdfU09DX1BOWDgzMzUpCisJI2Rl
ZmluZSBQTlg4MzNYX1BJQ19OVU1fSVJRCQkJNTgKKyNlbHNlCisJI2RlZmluZSBQTlg4MzNYX1BJ
Q19OVU1fSVJRCQkJMzcKKyNlbmRpZgorCisjZGVmaW5lIE1JUFNfQ1BVX05VTV9JUlEJCQkJOAor
I2RlZmluZSBQTlg4MzNYX0dQSU9fTlVNX0lSUQkJCTE2CisKKyNkZWZpbmUgTUlQU19DUFVfSVJR
X0JBU0UJCQkJMAorI2RlZmluZSBQTlg4MzNYX1BJQ19JUlFfQkFTRQkJCShNSVBTX0NQVV9JUlFf
QkFTRSArIE1JUFNfQ1BVX05VTV9JUlEpCisjZGVmaW5lIFBOWDgzM1hfR1BJT19JUlFfQkFTRQkJ
CShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIFBOWDgzM1hfUElDX05VTV9JUlEpCisjZGVmaW5lIE5S
X0lSUVMJCQkJCQkJKE1JUFNfQ1BVX05VTV9JUlEgKyBQTlg4MzNYX1BJQ19OVU1fSVJRICsgUE5Y
ODMzWF9HUElPX05VTV9JUlEpCisKKyNlbmRpZgpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGlu
dXgtMi42LjI2LXJjNC5vcmlnL2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L2lycS1tYXBw
aW5nLmggbGludXgtMi42LjI2LXJjNC9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9pcnEt
bWFwcGluZy5oCi0tLSBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5jbHVkZS9hc20tbWlwcy9tYWNo
LXBueDgzM3gvaXJxLW1hcHBpbmcuaAkxOTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEw
MAorKysgbGludXgtMi42LjI2LXJjNC9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC9pcnEt
bWFwcGluZy5oCTIwMDgtMDYtMTIgMTM6MDc6MTkuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEs
MTI2IEBACisKKy8qCisgKiAgaXJxLmg6IElSUSBtYXBwaW5ncyBmb3IgUE5YODMzWC4KKyAqCisg
KiAgQ29weXJpZ2h0IDIwMDggTlhQIFNlbWljb25kdWN0b3JzCisgKgkgIENocmlzIFN0ZWVsIDxj
aHJpcy5zdGVlbEBueHAuY29tPgorICogICAgRGFuaWVsIExhaXJkIDxkYW5pZWwuai5sYWlyZEBu
eHAuY29tPgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
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
biwgSW5jLiwgNjc1IE1hc3MgQXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisgKi8KKwor
I2lmbmRlZiBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9JUlFfTUFQUElOR19ICisjZGVmaW5lIF9f
QVNNX01JUFNfTUFDSF9QTlg4MzNYX0lSUV9NQVBQSU5HX0gKKy8qCisgKiBUaGUgIklSUSBudW1i
ZXJzIiBhcmUgY29tcGxldGVseSB2aXJ0dWFsLgorICoKKyAqIEluIFBOWDgzMzAvMSwgd2UgaGF2
ZSA0OCBpbnRlcnJ1cHQgbGluZXMsIG51bWJlcmVkIGZyb20gMSB0byA0OC4KKyAqIExldCdzIHVz
ZSBudW1iZXJzIDEuLjQ4IGZvciBQSUMgaW50ZXJydXB0cywgbnVtYmVyIDAgZm9yIHRpbWVyIGlu
dGVycnVwdCwKKyAqIG51bWJlcnMgNDkuLjY0IGZvciAodmlydHVhbCkgR1BJTyBpbnRlcnJ1cHRz
LgorICoKKyAqIEluIFBOWDgzMzUsIHdlIGhhdmUgNTcgaW50ZXJydXB0IGxpbmVzLCBudW1iZXJl
ZCBmcm9tIDEgdG8gNTcsCisgKiBjb25uZWN0ZWQgdG8gUElDLCB3aGljaCB1c2VzIGNvcmUgaGFy
ZHdhcmUgaW50ZXJydXB0IDIsIGFuZCBhbHNvCisgKiBhIHRpbWVyIGludGVycnVwdCB0aHJvdWdo
IGhhcmR3YXJlIGludGVycnVwdCA1LgorICogTGV0J3MgdXNlIG51bWJlcnMgMS4uNjQgZm9yIFBJ
QyBpbnRlcnJ1cHRzLCBudW1iZXIgMCBmb3IgdGltZXIgaW50ZXJydXB0LAorICogbnVtYmVycyA2
NS4uODAgZm9yICh2aXJ0dWFsKSBHUElPIGludGVycnVwdHMuCisgKgorICovCisjaW5jbHVkZSA8
aXJxLmg+CisKKyNkZWZpbmUgUE5YODMzWF9USU1FUl9JUlEJCQkJKE1JUFNfQ1BVX0lSUV9CQVNF
ICsgNykKKworLyogSW50ZXJydXB0cyBzdXBwb3J0ZWQgYnkgUElDICovCisjZGVmaW5lIFBOWDgz
M1hfUElDX0kyQzBfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgIDEpCisjZGVmaW5lIFBO
WDgzM1hfUElDX0kyQzFfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgIDIpCisjZGVmaW5l
IFBOWDgzM1hfUElDX1VBUlQwX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArICAzKQorI2Rl
ZmluZSBQTlg4MzNYX1BJQ19VQVJUMV9JTlQJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAgNCkK
KyNkZWZpbmUgUE5YODMzWF9QSUNfVFNfSU4wX0RWX0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNF
ICsgIDUpCisjZGVmaW5lIFBOWDgzM1hfUElDX1RTX0lOMF9ETUFfSU5UCQkoUE5YODMzWF9QSUNf
SVJRX0JBU0UgKyAgNikKKyNkZWZpbmUgUE5YODMzWF9QSUNfR1BJT19JTlQJCQkoUE5YODMzWF9Q
SUNfSVJRX0JBU0UgKyAgNykKKyNkZWZpbmUgUE5YODMzWF9QSUNfQVVESU9fREVDX0lOVAkJKFBO
WDgzM1hfUElDX0lSUV9CQVNFICsgIDgpCisjZGVmaW5lIFBOWDgzM1hfUElDX1ZJREVPX0RFQ19J
TlQJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArICA5KQorI2RlZmluZSBQTlg4MzNYX1BJQ19DT05G
SUdfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTApCisjZGVmaW5lIFBOWDgzM1hfUElD
X0FPSV9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTEpCisjZGVmaW5lIFBOWDgzM1hf
UElDX1NZTkNfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTIpCisjZGVmaW5lIFBOWDgz
MzBfUElDX1NQVV9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTMpCisjZGVmaW5lIFBO
WDgzMzVfUElDX1NBVEFfSU5UCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTMpCisjZGVmaW5l
IFBOWDgzM1hfUElDX09TRF9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMTQpCisjZGVm
aW5lIFBOWDgzM1hfUElDX0RJU1AxX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDE1KQor
I2RlZmluZSBQTlg4MzNYX1BJQ19ERUlOVEVSTEFDRVJfSU5UCShQTlg4MzNYX1BJQ19JUlFfQkFT
RSArIDE2KQorI2RlZmluZSBQTlg4MzNYX1BJQ19ESVNQTEFZMl9JTlQJCShQTlg4MzNYX1BJQ19J
UlFfQkFTRSArIDE3KQorI2RlZmluZSBQTlg4MzNYX1BJQ19WQ19JTlQJCQkJKFBOWDgzM1hfUElD
X0lSUV9CQVNFICsgMTgpCisjZGVmaW5lIFBOWDgzM1hfUElDX1NDX0lOVAkJCQkoUE5YODMzWF9Q
SUNfSVJRX0JBU0UgKyAxOSkKKyNkZWZpbmUgUE5YODMzWF9QSUNfSURFX0lOVAkJCQkoUE5YODMz
WF9QSUNfSVJRX0JBU0UgKyAyMCkKKyNkZWZpbmUgUE5YODMzWF9QSUNfSURFX0RNQV9JTlQJCQko
UE5YODMzWF9QSUNfSVJRX0JBU0UgKyAyMSkKKyNkZWZpbmUgUE5YODMzWF9QSUNfVFNfSU4xX0RW
X0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMjIpCisjZGVmaW5lIFBOWDgzM1hfUElDX1RT
X0lOMV9ETUFfSU5UCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAyMykKKyNkZWZpbmUgUE5YODMz
WF9QSUNfU0dEWF9ETUFfSU5UCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAyNCkKKyNkZWZpbmUg
UE5YODMzWF9QSUNfVFNfT1VUX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDI1KQorI2Rl
ZmluZSBQTlg4MzNYX1BJQ19JUl9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMjYpCisj
ZGVmaW5lIFBOWDgzM1hfUElDX1ZNU1AxX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDI3
KQorI2RlZmluZSBQTlg4MzNYX1BJQ19WTVNQMl9JTlQJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0Ug
KyAyOCkKKyNkZWZpbmUgUE5YODMzWF9QSUNfUElCQ19JTlQJCQkoUE5YODMzWF9QSUNfSVJRX0JB
U0UgKyAyOSkKKyNkZWZpbmUgUE5YODMzWF9QSUNfVFNfSU4wX1RSRF9JTlQJCShQTlg4MzNYX1BJ
Q19JUlFfQkFTRSArIDMwKQorI2RlZmluZSBQTlg4MzNYX1BJQ19TR0RYX1RQRF9JTlQJCShQTlg4
MzNYX1BJQ19JUlFfQkFTRSArIDMxKQorI2RlZmluZSBQTlg4MzNYX1BJQ19VU0JfSU5UCQkJCShQ
Tlg4MzNYX1BJQ19JUlFfQkFTRSArIDMyKQorI2RlZmluZSBQTlg4MzNYX1BJQ19UU19JTjFfVFJE
X0lOVAkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgMzMpCisjZGVmaW5lIFBOWDgzM1hfUElDX0NM
T0NLX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDM0KQorI2RlZmluZSBQTlg4MzNYX1BJ
Q19TR0RYX1BBUlNFUl9JTlQJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDM1KQorI2RlZmluZSBQ
Tlg4MzNYX1BJQ19WTVNQX0RNQV9JTlQJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDM2KQorCisj
aWYgZGVmaW5lZChDT05GSUdfU09DX1BOWDgzMzUpCisjZGVmaW5lIFBOWDgzMzVfUElDX01JVV9J
TlQJCQkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDM3KQorI2RlZmluZSBQTlg4MzM1X1BJQ19B
VkNISVBfSVJRX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDM4KQorI2RlZmluZSBQTlg4
MzM1X1BJQ19TWU5DX0hEX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyAzOSkKKyNkZWZp
bmUgUE5YODMzNV9QSUNfRElTUF9IRF9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNDAp
CisjZGVmaW5lIFBOWDgzMzVfUElDX0RJU1BfU0NBTEVSX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFf
QkFTRSArIDQxKQorI2RlZmluZSBQTlg4MzM1X1BJQ19PU0RfSEQxX0lOVAkJCQkoUE5YODMzWF9Q
SUNfSVJRX0JBU0UgKyA0MikKKyNkZWZpbmUgUE5YODMzNV9QSUNfRFRMX1dSSVRFUl9ZX0lOVAkJ
KFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNDMpCisjZGVmaW5lIFBOWDgzMzVfUElDX0RUTF9XUklU
RVJfQ19JTlQJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDQ0KQorI2RlZmluZSBQTlg4MzM1X1BJ
Q19EVExfRU1VTEFUT1JfWV9JUl9JTlQJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNDUpCisjZGVm
aW5lIFBOWDgzMzVfUElDX0RUTF9FTVVMQVRPUl9DX0lSX0lOVAkoUE5YODMzWF9QSUNfSVJRX0JB
U0UgKyA0NikKKyNkZWZpbmUgUE5YODMzNV9QSUNfREVOQ19UVFhfSU5UCQkJKFBOWDgzM1hfUElD
X0lSUV9CQVNFICsgNDcpCisjZGVmaW5lIFBOWDgzMzVfUElDX01NSV9TSUYwX0lOVAkJCShQTlg4
MzNYX1BJQ19JUlFfQkFTRSArIDQ4KQorI2RlZmluZSBQTlg4MzM1X1BJQ19NTUlfU0lGMV9JTlQJ
CQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyA0OSkKKyNkZWZpbmUgUE5YODMzNV9QSUNfTU1JX0NE
TU1VX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDUwKQorI2RlZmluZSBQTlg4MzM1X1BJ
Q19QSUJDU19JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNFICsgNTEpCisjZGVmaW5lIFBOWDgz
MzVfUElDX0VUSEVSTkVUX0lOVAkJCShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDUyKQorI2RlZmlu
ZSBQTlg4MzM1X1BJQ19WTVNQMV8wX0lOVAkJCQkoUE5YODMzWF9QSUNfSVJRX0JBU0UgKyA1MykK
KyNkZWZpbmUgUE5YODMzNV9QSUNfVk1TUDFfMV9JTlQJCQkJKFBOWDgzM1hfUElDX0lSUV9CQVNF
ICsgNTQpCisjZGVmaW5lIFBOWDgzMzVfUElDX1ZNU1AxX0RNQV9JTlQJCQkoUE5YODMzWF9QSUNf
SVJRX0JBU0UgKyA1NSkKKyNkZWZpbmUgUE5YODMzNV9QSUNfVERHUl9ERV9JTlQJCQkJKFBOWDgz
M1hfUElDX0lSUV9CQVNFICsgNTYpCisjZGVmaW5lIFBOWDgzMzVfUElDX0lSMV9JUlFfSU5UCQkJ
CShQTlg4MzNYX1BJQ19JUlFfQkFTRSArIDU3KQorI2VuZGlmCisKKy8qIEdQSU8gaW50ZXJydXB0
cyAqLworI2RlZmluZSBQTlg4MzNYX0dQSU9fMF9JTlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNF
ICsgIDApCisjZGVmaW5lIFBOWDgzM1hfR1BJT18xX0lOVAkJCShQTlg4MzNYX0dQSU9fSVJRX0JB
U0UgKyAgMSkKKyNkZWZpbmUgUE5YODMzWF9HUElPXzJfSU5UCQkJKFBOWDgzM1hfR1BJT19JUlFf
QkFTRSArICAyKQorI2RlZmluZSBQTlg4MzNYX0dQSU9fM19JTlQJCQkoUE5YODMzWF9HUElPX0lS
UV9CQVNFICsgIDMpCisjZGVmaW5lIFBOWDgzM1hfR1BJT180X0lOVAkJCShQTlg4MzNYX0dQSU9f
SVJRX0JBU0UgKyAgNCkKKyNkZWZpbmUgUE5YODMzWF9HUElPXzVfSU5UCQkJKFBOWDgzM1hfR1BJ
T19JUlFfQkFTRSArICA1KQorI2RlZmluZSBQTlg4MzNYX0dQSU9fNl9JTlQJCQkoUE5YODMzWF9H
UElPX0lSUV9CQVNFICsgIDYpCisjZGVmaW5lIFBOWDgzM1hfR1BJT183X0lOVAkJCShQTlg4MzNY
X0dQSU9fSVJRX0JBU0UgKyAgNykKKyNkZWZpbmUgUE5YODMzWF9HUElPXzhfSU5UCQkJKFBOWDgz
M1hfR1BJT19JUlFfQkFTRSArICA4KQorI2RlZmluZSBQTlg4MzNYX0dQSU9fOV9JTlQJCQkoUE5Y
ODMzWF9HUElPX0lSUV9CQVNFICsgIDkpCisjZGVmaW5lIFBOWDgzM1hfR1BJT18xMF9JTlQJCQko
UE5YODMzWF9HUElPX0lSUV9CQVNFICsgMTApCisjZGVmaW5lIFBOWDgzM1hfR1BJT18xMV9JTlQJ
CQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgMTEpCisjZGVmaW5lIFBOWDgzM1hfR1BJT18xMl9J
TlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgMTIpCisjZGVmaW5lIFBOWDgzM1hfR1BJT18x
M19JTlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgMTMpCisjZGVmaW5lIFBOWDgzM1hfR1BJ
T18xNF9JTlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgMTQpCisjZGVmaW5lIFBOWDgzM1hf
R1BJT18xNV9JTlQJCQkoUE5YODMzWF9HUElPX0lSUV9CQVNFICsgMTUpCisKKyNlbmRpZgorCmRp
ZmYgLXVyTiAtLWV4Y2x1ZGU9LnN2biBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5jbHVkZS9hc20t
bWlwcy9tYWNoLXBueDgzM3gvcG54ODMzeC5oIGxpbnV4LTIuNi4yNi1yYzQvaW5jbHVkZS9hc20t
bWlwcy9tYWNoLXBueDgzM3gvcG54ODMzeC5oCi0tLSBsaW51eC0yLjYuMjYtcmM0Lm9yaWcvaW5j
bHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvcG54ODMzeC5oCTE5NzAtMDEtMDEgMDE6MDA6MDAu
MDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMjYtcmM0L2luY2x1ZGUvYXNtLW1pcHMvbWFj
aC1wbng4MzN4L3BueDgzM3guaAkyMDA4LTA2LTA2IDExOjI5OjQzLjAwMDAwMDAwMCArMDEwMApA
QCAtMCwwICsxLDIwMiBAQAorLyoKKyAqICBwbng4MzN4Lmg6IFJlZ2lzdGVyIG1hcHBpbmdzIGZv
ciBQTlg4MzNYLgorICoKKyAqICBDb3B5cmlnaHQgMjAwOCBOWFAgU2VtaWNvbmR1Y3RvcnMKKyAq
CSAgQ2hyaXMgU3RlZWwgPGNocmlzLnN0ZWVsQG54cC5jb20+CisgKiAgICBEYW5pZWwgTGFpcmQg
PGRhbmllbC5qLmxhaXJkQG54cC5jb20+CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAy
IG9mIHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91
dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJ
VE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2
ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAg
YWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdh
cmUKKyAqICBGb3VuZGF0aW9uLCBJbmMuLCA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIx
MzksIFVTQS4KKyAqLworI2lmbmRlZiBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9QTlg4MzNYX0gK
KyNkZWZpbmUgX19BU01fTUlQU19NQUNIX1BOWDgzM1hfUE5YODMzWF9ICisKKy8qIEFsbCByZWdz
IGFyZSBhY2Nlc3NlZCBpbiBLU0VHMSAqLworI2RlZmluZSBQTlg4MzNYX0JBU0UJCSgweGEwMDAw
MDAwdWwgKyAweDE3RTAwMDAwdWwpCisKKyNkZWZpbmUgUE5YODMzWF9SRUcob2ZmcykJKigodm9s
YXRpbGUgdW5zaWduZWQgbG9uZyAqKShQTlg4MzNYX0JBU0UgKyBvZmZzKSkKKworLyogUmVnaXN0
ZXJzIGFyZSBuYW1lZCBleGFjdGx5IGFzIGluIFBOWDgzM1ggZG9jcywganVzdCB3aXRoIFBOWDgz
M1hfIHByZWZpeCAqLworCisvKiBSZWFkIGFjY2VzcyB0byBtdWx0aWJpdCBmaWVsZHMgKi8KKyNk
ZWZpbmUgUE5YODMzWF9CSVQodmFsLCByZWcsIGZpZWxkKQkoKHZhbCkgJiBQTlg4MzNYXyMjcmVn
IyNfIyNmaWVsZCkKKyNkZWZpbmUgUE5YODMzWF9SRUdCSVQocmVnLCBmaWVsZCkJUE5YODMzWF9C
SVQoUE5YODMzWF8jI3JlZywgcmVnLCBmaWVsZCkKKworLyogVXNlIFBOWDgzM1hfRklFTEQgdG8g
ZXh0cmFjdCBhIGZpZWxkIGZyb20gdmFsICovCisjZGVmaW5lIFBOWF9GSUVMRChjcHUsIHZhbCwg
cmVnLCBmaWVsZCkgXAorCQkoKCh2YWwpICYgUE5YIyNjcHUjI18jI3JlZyMjXyMjZmllbGQjI19N
QVNLKSA+PiBcCisJCQlQTlgjI2NwdSMjXyMjcmVnIyNfIyNmaWVsZCMjX1NISUZUKQorI2RlZmlu
ZSBQTlg4MzNYX0ZJRUxEKHZhbCwgcmVnLCBmaWVsZCkJUE5YX0ZJRUxEKDgzM1gsIHZhbCwgcmVn
LCBmaWVsZCkKKyNkZWZpbmUgUE5YODMzMF9GSUVMRCh2YWwsIHJlZywgZmllbGQpCVBOWF9GSUVM
RCg4MzMwLCB2YWwsIHJlZywgZmllbGQpCisjZGVmaW5lIFBOWDgzMzVfRklFTEQodmFsLCByZWcs
IGZpZWxkKQlQTlhfRklFTEQoODMzNSwgdmFsLCByZWcsIGZpZWxkKQorCisvKiBVc2UgUE5YODMz
WF9SRUdGSUVMRCB0byBleHRyYWN0IGEgZmllbGQgZnJvbSBhIHJlZ2lzdGVyICovCisjZGVmaW5l
IFBOWDgzM1hfUkVHRklFTEQocmVnLCBmaWVsZCkJUE5YODMzWF9GSUVMRChQTlg4MzNYXyMjcmVn
LCByZWcsIGZpZWxkKQorI2RlZmluZSBQTlg4MzMwX1JFR0ZJRUxEKHJlZywgZmllbGQpCVBOWDgz
MzBfRklFTEQoUE5YODMzMF8jI3JlZywgcmVnLCBmaWVsZCkKKyNkZWZpbmUgUE5YODMzNV9SRUdG
SUVMRChyZWcsIGZpZWxkKQlQTlg4MzM1X0ZJRUxEKFBOWDgzMzVfIyNyZWcsIHJlZywgZmllbGQp
CisKKworI2RlZmluZSBQTlhfV1JJVEVGSUVMRChjcHUsIHZhbCwgcmVnLCBmaWVsZCkgXAorCVBO
WCMjY3B1IyNfIyNyZWcgPSAoUE5YIyNjcHUjI18jI3JlZyAmIH4oUE5YIyNjcHUjI18jI3JlZyMj
XyMjZmllbGQjI19NQVNLKSkgfCBcCisJCQkJCQkoKHZhbCkgPDwgUE5YIyNjcHUjI18jI3JlZyMj
XyMjZmllbGQjI19TSElGVCkKKyNkZWZpbmUgUE5YODMzWF9XUklURUZJRUxEKHZhbCwgcmVnLCBm
aWVsZCkgXAorCQkJCQlQTlhfV1JJVEVGSUVMRCg4MzNYLCB2YWwsIHJlZywgZmllbGQpCisjZGVm
aW5lIFBOWDgzMzBfV1JJVEVGSUVMRCh2YWwsIHJlZywgZmllbGQpIFwKKwkJCQkJUE5YX1dSSVRF
RklFTEQoODMzMCwgdmFsLCByZWcsIGZpZWxkKQorI2RlZmluZSBQTlg4MzM1X1dSSVRFRklFTEQo
dmFsLCByZWcsIGZpZWxkKSBcCisJCQkJCVBOWF9XUklURUZJRUxEKDgzMzUsIHZhbCwgcmVnLCBm
aWVsZCkKKworCisvKiBNYWNyb3MgdG8gZGV0ZWN0IENQVSB0eXBlICovCisKKyNkZWZpbmUgUE5Y
ODMzWF9DT05GSUdfTU9EVUxFX0lECQlQTlg4MzNYX1JFRygweDdGRkMpCisjZGVmaW5lIFBOWDgz
M1hfQ09ORklHX01PRFVMRV9JRF9NQUpSRVZfTUFTSwkweDAwMDBmMDAwCisjZGVmaW5lIFBOWDgz
M1hfQ09ORklHX01PRFVMRV9JRF9NQUpSRVZfU0hJRlQJMTIKKyNkZWZpbmUgUE5YODMzMF9DT05G
SUdfTU9EVUxFX01BSlJFVgkJNAorI2RlZmluZSBQTlg4MzM1X0NPTkZJR19NT0RVTEVfTUFKUkVW
CQk1CisjZGVmaW5lIENQVV9JU19QTlg4MzMwCShQTlg4MzNYX1JFR0ZJRUxEKENPTkZJR19NT0RV
TEVfSUQsIE1BSlJFVikgPT0gXAorCQkJCQlQTlg4MzMwX0NPTkZJR19NT0RVTEVfTUFKUkVWKQor
I2RlZmluZSBDUFVfSVNfUE5YODMzNQkoUE5YODMzWF9SRUdGSUVMRChDT05GSUdfTU9EVUxFX0lE
LCBNQUpSRVYpID09IFwKKwkJCQkJUE5YODMzNV9DT05GSUdfTU9EVUxFX01BSlJFVikKKworCisK
KyNkZWZpbmUgUE5YODMzWF9SRVNFVF9DT05UUk9MCQlQTlg4MzNYX1JFRygweDgwMDQpCisjZGVm
aW5lIFBOWDgzM1hfUkVTRVRfQ09OVFJPTF8yIAlQTlg4MzNYX1JFRygweDgwMTQpCisKKyNkZWZp
bmUgUE5YODMzWF9QSUNfUkVHKG9mZnMpCQlQTlg4MzNYX1JFRygweDAxMDAwICsgKG9mZnMpKQor
I2RlZmluZSBQTlg4MzNYX1BJQ19JTlRfUFJJT1JJVFkJUE5YODMzWF9QSUNfUkVHKDB4MCkKKyNk
ZWZpbmUgUE5YODMzWF9QSUNfSU5UX1NSQwkJUE5YODMzWF9QSUNfUkVHKDB4NCkKKyNkZWZpbmUg
UE5YODMzWF9QSUNfSU5UX1NSQ19JTlRfU1JDX01BU0sJMHgwMDAwMEZGOHVsCS8qIGJpdHMgMTE6
MyAqLworI2RlZmluZSBQTlg4MzNYX1BJQ19JTlRfU1JDX0lOVF9TUkNfU0hJRlQJMworI2RlZmlu
ZSBQTlg4MzNYX1BJQ19JTlRfUkVHKGlycSkJUE5YODMzWF9QSUNfUkVHKDB4MTAgKyA0KihpcnEp
KQorCisjZGVmaW5lIFBOWDgzM1hfQ0xPQ0tfQ1BVQ1BfQ1RMCVBOWDgzM1hfUkVHKDB4OTIyOCkK
KyNkZWZpbmUgUE5YODMzWF9DTE9DS19DUFVDUF9DVExfRVhJVF9SRVNFVAkweDAwMDAwMDAydWwJ
LyogYml0IDEgKi8KKyNkZWZpbmUgUE5YODMzWF9DTE9DS19DUFVDUF9DVExfRElWX0NMT0NLX01B
U0sJMHgwMDAwMDAxOHVsCS8qIGJpdHMgNDozICovCisjZGVmaW5lIFBOWDgzM1hfQ0xPQ0tfQ1BV
Q1BfQ1RMX0RJVl9DTE9DS19TSElGVAkzCisKKyNkZWZpbmUgUE5YODMzNV9DTE9DS19QTExfQ1BV
X0NUTAkJUE5YODMzWF9SRUcoMHg5MDIwKQorI2RlZmluZSBQTlg4MzM1X0NMT0NLX1BMTF9DUFVf
Q1RMX0ZSRVFfTUFTSwkweDFmCisjZGVmaW5lIFBOWDgzMzVfQ0xPQ0tfUExMX0NQVV9DVExfRlJF
UV9TSElGVAkwCisKKyNkZWZpbmUgUE5YODMzWF9DT05GSUdfTVVYCQlQTlg4MzNYX1JFRygweDcw
MDQpCisjZGVmaW5lIFBOWDgzM1hfQ09ORklHX01VWF9JREVfTVVYCTB4MDAwMDAwODAJCS8qIGJp
dCA3ICovCisKKyNkZWZpbmUgUE5YODMzMF9DT05GSUdfUE9MWUZVU0VfNwlQTlg4MzNYX1JFRygw
eDcwNDApCisjZGVmaW5lIFBOWDgzMzBfQ09ORklHX1BPTFlGVVNFXzdfQk9PVF9NT0RFX01BU0sJ
MHgwMDE4MDAwMAorI2RlZmluZSBQTlg4MzMwX0NPTkZJR19QT0xZRlVTRV83X0JPT1RfTU9ERV9T
SElGVAkxOQorCisjZGVmaW5lIFBOWDgzM1hfUElPX0lOCQlQTlg4MzNYX1JFRygweEYwMDApCisj
ZGVmaW5lIFBOWDgzM1hfUElPX09VVAkJUE5YODMzWF9SRUcoMHhGMDA0KQorI2RlZmluZSBQTlg4
MzNYX1BJT19ESVIJCVBOWDgzM1hfUkVHKDB4RjAwOCkKKyNkZWZpbmUgUE5YODMzWF9QSU9fU0VM
CQlQTlg4MzNYX1JFRygweEYwMTQpCisjZGVmaW5lIFBOWDgzM1hfUElPX0lOVF9FREdFCVBOWDgz
M1hfUkVHKDB4RjAyMCkKKyNkZWZpbmUgUE5YODMzWF9QSU9fSU5UX0hJCVBOWDgzM1hfUkVHKDB4
RjAyNCkKKyNkZWZpbmUgUE5YODMzWF9QSU9fSU5UX0xPCVBOWDgzM1hfUkVHKDB4RjAyOCkKKyNk
ZWZpbmUgUE5YODMzWF9QSU9fSU5UX1NUQVRVUwlQTlg4MzNYX1JFRygweEZGRTApCisjZGVmaW5l
IFBOWDgzM1hfUElPX0lOVF9FTkFCTEUJUE5YODMzWF9SRUcoMHhGRkU0KQorI2RlZmluZSBQTlg4
MzNYX1BJT19JTlRfQ0xFQVIJUE5YODMzWF9SRUcoMHhGRkU4KQorI2RlZmluZSBQTlg4MzNYX1BJ
T19JTjIJCVBOWDgzM1hfUkVHKDB4RjA1QykKKyNkZWZpbmUgUE5YODMzWF9QSU9fT1VUMglQTlg4
MzNYX1JFRygweEYwNjApCisjZGVmaW5lIFBOWDgzM1hfUElPX0RJUjIJUE5YODMzWF9SRUcoMHhG
MDY0KQorI2RlZmluZSBQTlg4MzNYX1BJT19TRUwyCVBOWDgzM1hfUkVHKDB4RjA2OCkKKworI2Rl
ZmluZSBQTlg4MzNYX1VBUlQwX1BPUlRTX1NUQVJUCShQTlg4MzNYX0JBU0UgKyAweEIwMDApCisj
ZGVmaW5lIFBOWDgzM1hfVUFSVDBfUE9SVFNfRU5ECQkoUE5YODMzWF9CQVNFICsgMHhCRkZGKQor
I2RlZmluZSBQTlg4MzNYX1VBUlQxX1BPUlRTX1NUQVJUCShQTlg4MzNYX0JBU0UgKyAweEMwMDAp
CisjZGVmaW5lIFBOWDgzM1hfVUFSVDFfUE9SVFNfRU5ECQkoUE5YODMzWF9CQVNFICsgMHhDRkZG
KQorCisjZGVmaW5lIFBOWDgzM1hfVVNCX1BPUlRTX1NUQVJUCQkoUE5YODMzWF9CQVNFICsgMHgx
OTAwMCkKKyNkZWZpbmUgUE5YODMzWF9VU0JfUE9SVFNfRU5ECQkoUE5YODMzWF9CQVNFICsgMHgx
OUZGRikKKworI2RlZmluZSBQTlg4MzNYX0NPTkZJR19VU0IJCVBOWDgzM1hfUkVHKDB4NzAwOCkK
KworI2RlZmluZSBQTlg4MzNYX0kyQzBfUE9SVFNfU1RBUlQJKFBOWDgzM1hfQkFTRSArIDB4RDAw
MCkKKyNkZWZpbmUgUE5YODMzWF9JMkMwX1BPUlRTX0VORAkJKFBOWDgzM1hfQkFTRSArIDB4REZG
RikKKyNkZWZpbmUgUE5YODMzWF9JMkMxX1BPUlRTX1NUQVJUCShQTlg4MzNYX0JBU0UgKyAweEUw
MDApCisjZGVmaW5lIFBOWDgzM1hfSTJDMV9QT1JUU19FTkQJCShQTlg4MzNYX0JBU0UgKyAweEVG
RkYpCisKKyNkZWZpbmUgUE5YODMzWF9JREVfUE9SVFNfU1RBUlQJCShQTlg4MzNYX0JBU0UgKyAw
eDFBMDAwKQorI2RlZmluZSBQTlg4MzNYX0lERV9QT1JUU19FTkQJCShQTlg4MzNYX0JBU0UgKyAw
eDFBRkZGKQorI2RlZmluZSBQTlg4MzNYX0lERV9NT0RVTEVfSUQJCVBOWDgzM1hfUkVHKDB4MUFG
RkMpCisKKyNkZWZpbmUgUE5YODMzWF9JREVfTU9EVUxFX0lEX01PRFVMRV9JRF9NQVNLCTB4RkZG
RjAwMDAKKyNkZWZpbmUgUE5YODMzWF9JREVfTU9EVUxFX0lEX01PRFVMRV9JRF9TSElGVAkxNgor
I2RlZmluZSBQTlg4MzNYX0lERV9NT0RVTEVfSURfVkFMVUUJCTB4QTAwOQorCisKKyNkZWZpbmUg
UE5YODMzWF9NSVVfU0VMMAkJCVBOWDgzM1hfUkVHKDB4MjAwNCkKKyNkZWZpbmUgUE5YODMzWF9N
SVVfU0VMMF9USU1JTkcJCVBOWDgzM1hfUkVHKDB4MjAwOCkKKyNkZWZpbmUgUE5YODMzWF9NSVVf
U0VMMQkJCVBOWDgzM1hfUkVHKDB4MjAwQykKKyNkZWZpbmUgUE5YODMzWF9NSVVfU0VMMV9USU1J
TkcJCVBOWDgzM1hfUkVHKDB4MjAxMCkKKyNkZWZpbmUgUE5YODMzWF9NSVVfU0VMMgkJCVBOWDgz
M1hfUkVHKDB4MjAxNCkKKyNkZWZpbmUgUE5YODMzWF9NSVVfU0VMMl9USU1JTkcJCVBOWDgzM1hf
UkVHKDB4MjAxOCkKKyNkZWZpbmUgUE5YODMzWF9NSVVfU0VMMwkJCVBOWDgzM1hfUkVHKDB4MjAx
QykKKyNkZWZpbmUgUE5YODMzWF9NSVVfU0VMM19USU1JTkcJCVBOWDgzM1hfUkVHKDB4MjAyMCkK
KworI2RlZmluZSBQTlg4MzNYX01JVV9TRUwwX1NQSV9NT0RFX0VOQUJMRV9NQVNLCSgxIDw8IDE0
KQorI2RlZmluZSBQTlg4MzNYX01JVV9TRUwwX1NQSV9NT0RFX0VOQUJMRV9TSElGVAkxNAorCisj
ZGVmaW5lIFBOWDgzM1hfTUlVX1NFTDBfQlVSU1RfTU9ERV9FTkFCTEVfTUFTSwkoMSA8PCA3KQor
I2RlZmluZSBQTlg4MzNYX01JVV9TRUwwX0JVUlNUX01PREVfRU5BQkxFX1NISUZUCTcKKworI2Rl
ZmluZSBQTlg4MzNYX01JVV9TRUwwX0JVUlNUX1BBR0VfTEVOX01BU0sJKDB4RiA8PCA5KQorI2Rl
ZmluZSBQTlg4MzNYX01JVV9TRUwwX0JVUlNUX1BBR0VfTEVOX1NISUZUCTkKKworI2RlZmluZSBQ
Tlg4MzNYX01JVV9DT05GSUdfU1BJCQlQTlg4MzNYX1JFRygweDIwMDApCisKKyNkZWZpbmUgUE5Y
ODMzWF9NSVVfQ09ORklHX1NQSV9PUENPREVfTUFTSwkoMHhGRiA8PCAzKQorI2RlZmluZSBQTlg4
MzNYX01JVV9DT05GSUdfU1BJX09QQ09ERV9TSElGVAkzCisKKyNkZWZpbmUgUE5YODMzWF9NSVVf
Q09ORklHX1NQSV9EQVRBX0VOQUJMRV9NQVNLCSgxIDw8IDIpCisjZGVmaW5lIFBOWDgzM1hfTUlV
X0NPTkZJR19TUElfREFUQV9FTkFCTEVfU0hJRlQJMgorCisjZGVmaW5lIFBOWDgzM1hfTUlVX0NP
TkZJR19TUElfQUREUl9FTkFCTEVfTUFTSwkoMSA8PCAxKQorI2RlZmluZSBQTlg4MzNYX01JVV9D
T05GSUdfU1BJX0FERFJfRU5BQkxFX1NISUZUCTEKKworI2RlZmluZSBQTlg4MzNYX01JVV9DT05G
SUdfU1BJX1NZTkNfTUFTSwkoMSA8PCAwKQorI2RlZmluZSBQTlg4MzNYX01JVV9DT05GSUdfU1BJ
X1NZTkNfU0hJRlQJMAorCisjZGVmaW5lIFBOWDgzM1hfV1JJVEVfQ09ORklHX1NQSShvcGNvZGUs
IGRhdGFfZW5hYmxlLCBhZGRyX2VuYWJsZSwgc3luYykgXAorICAgUE5YODMzWF9NSVVfQ09ORklH
X1NQSSA9IFwKKyAgICgob3Bjb2RlKSA8PCBQTlg4MzNYX01JVV9DT05GSUdfU1BJX09QQ09ERV9T
SElGVCkgfCBcCisgICAoKGRhdGFfZW5hYmxlKSA8PCBQTlg4MzNYX01JVV9DT05GSUdfU1BJX0RB
VEFfRU5BQkxFX1NISUZUKSB8IFwKKyAgICgoYWRkcl9lbmFibGUpIDw8IFBOWDgzM1hfTUlVX0NP
TkZJR19TUElfQUREUl9FTkFCTEVfU0hJRlQpIHwgXAorICAgKChzeW5jKSA8PCBQTlg4MzNYX01J
VV9DT05GSUdfU1BJX1NZTkNfU0hJRlQpCisKKyNkZWZpbmUgUE5YODMzNV9JUDM5MDJfUE9SVFNf
U1RBUlQJCShQTlg4MzNYX0JBU0UgKyAweDJGMDAwKQorI2RlZmluZSBQTlg4MzM1X0lQMzkwMl9Q
T1JUU19FTkQJCShQTlg4MzNYX0JBU0UgKyAweDJGRkZGKQorI2RlZmluZSBQTlg4MzM1X0lQMzkw
Ml9NT0RVTEVfSUQJCVBOWDgzM1hfUkVHKDB4MkZGRkMpCisKKyNkZWZpbmUgUE5YODMzNV9JUDM5
MDJfTU9EVUxFX0lEX01PRFVMRV9JRF9NQVNLCQkweEZGRkYwMDAwCisjZGVmaW5lIFBOWDgzMzVf
SVAzOTAyX01PRFVMRV9JRF9NT0RVTEVfSURfU0hJRlQJMTYKKyNkZWZpbmUgUE5YODMzNV9JUDM5
MDJfTU9EVUxFX0lEX1ZBTFVFCQkJMHgzOTAyCisKKyAvKiBJL08gbG9jYXRpb24oZ2V0cyByZW1h
cHBlZCkqLworI2RlZmluZSBQTlg4MzM1X05BTkRfQkFTRQkgICAgMHgxODAwMDAwMAorLyogSS9P
IGxvY2F0aW9uIHdpdGggQ0xFIGhpZ2ggKi8KKyNkZWZpbmUgUE5YODMzNV9OQU5EX0NMRV9NQVNL
CTB4MDAxMDAwMDAKKy8qIEkvTyBsb2NhdGlvbiB3aXRoIEFMRSBoaWdoICovCisjZGVmaW5lIFBO
WDgzMzVfTkFORF9BTEVfTUFTSwkweDAwMDEwMDAwCisKKyNkZWZpbmUgUE5YODMzNV9TQVRBX1BP
UlRTX1NUQVJUCShQTlg4MzNYX0JBU0UgKyAweDJFMDAwKQorI2RlZmluZSBQTlg4MzM1X1NBVEFf
UE9SVFNfRU5ECQkoUE5YODMzWF9CQVNFICsgMHgyRUZGRikKKyNkZWZpbmUgUE5YODMzNV9TQVRB
X01PRFVMRV9JRAkJUE5YODMzWF9SRUcoMHgyRUZGQykKKworI2RlZmluZSBQTlg4MzM1X1NBVEFf
TU9EVUxFX0lEX01PRFVMRV9JRF9NQVNLCTB4RkZGRjAwMDAKKyNkZWZpbmUgUE5YODMzNV9TQVRB
X01PRFVMRV9JRF9NT0RVTEVfSURfU0hJRlQJMTYKKyNkZWZpbmUgUE5YODMzNV9TQVRBX01PRFVM
RV9JRF9WQUxVRQkJMHhBMDk5CisKKyNlbmRpZgpkaWZmIC11ck4gLS1leGNsdWRlPS5zdm4gbGlu
dXgtMi42LjI2LXJjNC5vcmlnL2luY2x1ZGUvYXNtLW1pcHMvbWFjaC1wbng4MzN4L3dhci5oIGxp
bnV4LTIuNi4yNi1yYzQvaW5jbHVkZS9hc20tbWlwcy9tYWNoLXBueDgzM3gvd2FyLmgKLS0tIGxp
bnV4LTIuNi4yNi1yYzQub3JpZy9pbmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC93YXIuaAkx
OTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjI2LXJjNC9p
bmNsdWRlL2FzbS1taXBzL21hY2gtcG54ODMzeC93YXIuaAkyMDA4LTA2LTA1IDA5OjM0OjIyLjAw
MDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDI1IEBACisvKgorICogVGhpcyBmaWxlIGlzIHN1Ympl
Y3QgdG8gdGhlIHRlcm1zIGFuZCBjb25kaXRpb25zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMK
KyAqIExpY2Vuc2UuICBTZWUgdGhlIGZpbGUgIkNPUFlJTkciIGluIHRoZSBtYWluIGRpcmVjdG9y
eSBvZiB0aGlzIGFyY2hpdmUKKyAqIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogQ29weXJpZ2h0
IChDKSAyMDAyLCAyMDA0LCAyMDA3IGJ5IFJhbGYgQmFlY2hsZSA8cmFsZkBsaW51eC1taXBzLm9y
Zz4KKyAqLworI2lmbmRlZiBfX0FTTV9NSVBTX01BQ0hfUE5YODMzWF9XQVJfSAorI2RlZmluZSBf
X0FTTV9NSVBTX01BQ0hfUE5YODMzWF9XQVJfSAorCisjZGVmaW5lIFI0NjAwX1YxX0lOREVYX0lD
QUNIRU9QX1dBUgkwCisjZGVmaW5lIFI0NjAwX1YxX0hJVF9DQUNIRU9QX1dBUgkwCisjZGVmaW5l
IFI0NjAwX1YyX0hJVF9DQUNIRU9QX1dBUgkwCisjZGVmaW5lIFI1NDMyX0NQMF9JTlRFUlJVUFRf
V0FSCQkwCisjZGVmaW5lIEJDTTEyNTBfTTNfV0FSCQkJMAorI2RlZmluZSBTSUJZVEVfMTk1Nl9X
QVIJCQkwCisjZGVmaW5lIE1JUFM0S19JQ0FDSEVfUkVGSUxMX1dBUgkwCisjZGVmaW5lIE1JUFNf
Q0FDSEVfU1lOQ19XQVIJCTAKKyNkZWZpbmUgVFg0OVhYX0lDQUNIRV9JTkRFWF9JTlZfV0FSCTAK
KyNkZWZpbmUgUk05MDAwX0NERVhfU01QX1dBUgkJMAorI2RlZmluZSBJQ0FDSEVfUkVGSUxMU19X
T1JLQVJPVU5EX1dBUgkwCisjZGVmaW5lIFIxMDAwMF9MTFNDX1dBUgkJCTAKKyNkZWZpbmUgTUlQ
UzM0S19NSVNTRURfSVRMQl9XQVIJCTAKKworI2VuZGlmIC8qIF9fQVNNX01JUFNfTUFDSF9QTlg4
NTUwX1dBUl9IICovCg==
------=_Part_8336_959225.1213627762193--
