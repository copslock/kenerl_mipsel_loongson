Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 20:45:24 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.230]:24108 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28575944AbYFETpS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 20:45:18 +0100
Received: by wx-out-0506.google.com with SMTP id s13so605486wxc.21
        for <linux-mips@linux-mips.org>; Thu, 05 Jun 2008 12:45:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=8CD9XVpVJqugWOHYmIWZbL6Yz9Jc3aEU8t/JrNA8bQE=;
        b=daaSKpPkt/8hcPTVqWqu0oq3cCcA4J8UQGMWgnvbMdLf4ZgLJR1m5TbhfNpUTugeM2
         p/fhiWe5dV4rBJ61ln+RbG5jriRRoKScXH8RTs9+TNpLfl9J7s/uVS0r5EDbog38Q/Q2
         OEhFpt3/3Hr5W7tXY0LZVnw4gustSDZqBb/P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QP7wielJSj2wl7xLV259Ifj21KSn/LUgQrQRJuBsbtwxXrMPL0UOIz73BP0SPN+ZLp
         msv0BnvykC179mGNbB3U2qUX0nOEBGamX3eP7mtSoQt7vUBIh5X9TDDj7qI3tPPPOM5a
         +t89Qn7+Uc+hshUX3CbEywMzSOuAHIJXrxFx4=
Received: by 10.90.101.17 with SMTP id y17mr1984877agb.82.1212695113373;
        Thu, 05 Jun 2008 12:45:13 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Thu, 5 Jun 2008 12:45:13 -0700 (PDT)
Message-ID: <64660ef00806051245n5ba8ffc5hece63f743d2e2d01@mail.gmail.com>
Date:	Thu, 5 Jun 2008 20:45:13 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux kernel
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: b72ba0c454018c89
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Tried to post earlier and did not get through, can send patch file
separately if mail server wont accept it.

Daniel Laird
------------------------------------------------------
The following patch add support for the NXP PNX833x SOC.  More
specifically it adds support for
the STB222/5 variant.  This has I2C support, NAND and onboard ethernet
support.
SATA, USB, NOR flash, WATCHDOG are all pending patches after I get this in :-).

 arch/mips/Kconfig                          |   33
 arch/mips/Makefile                         |    8
 arch/mips/configs/pnx8335-stb225_defconfig | 1150 +++++++++++++++++++++
 arch/mips/nxp/pnx833x/common/Makefile      |    1
 arch/mips/nxp/pnx833x/common/gdb_hook.c    |  162 +++
 arch/mips/nxp/pnx833x/common/interrupts.c  |  363 ++++++
 arch/mips/nxp/pnx833x/common/platform.c    |  337 ++++++
 arch/mips/nxp/pnx833x/common/prom.c        |   69 +
 arch/mips/nxp/pnx833x/common/reset.c       |   48
 arch/mips/nxp/pnx833x/common/setup.c       |   63 +
 arch/mips/nxp/pnx833x/stb22x/Makefile      |    1
 arch/mips/nxp/pnx833x/stb22x/board.c       |  138 ++
 drivers/i2c/busses/Kconfig                 |   12
 drivers/i2c/busses/Makefile                |    1
 drivers/i2c/busses/i2c-pnx0105.c           |  328 ++++++
 drivers/net/Kconfig                        |    9
 drivers/net/Makefile                       |    1
 drivers/net/ip3902.c                       | 1534 +++++++++++++++++++++++++++++
 include/asm-mips/mach-pnx833x/gpio.h       |  171 +++
 include/asm-mips/mach-pnx833x/irq.h        |  138 ++
 include/asm-mips/mach-pnx833x/pnx833x.h    |  194 +++
 include/asm-mips/mach-pnx833x/war.h        |   25
 include/linux/i2c-id.h                     |    1
 include/linux/i2c-pnx0105.h                |   58 +
 24 files changed, 4845 insertions(+)

 Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig
linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig
--- linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig 2008-06-04
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
--- linux-2.6.26-rc4.orig/arch/mips/Kconfig     2008-06-03
10:56:51.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/Kconfig  2008-06-03 17:12:19.000000000 +0100
@@ -311,6 +311,19 @@
       select SYS_HAS_CPU_VR41XX
       select GENERIC_HARDIRQS_NO__DO_IRQ

+config NXP_STB220
+       bool "NXP STB220 board"
+       select SOC_PNX833X
+       help
+        Support for NXP Semiconductors STB220 Development Board.
+
+config NXP_STB225
+       bool "NXP 225 board"
+       select SOC_PNX833X
+       select SOC_PNX8335
+       help
+        Support for NXP Semiconductors STB225 Development Board.
+
 config PNX8550_JBS
       bool "NXP PNX8550 based JBS board"
       select PNX8550
@@ -947,6 +960,26 @@
       bool
       select SERIAL_RM9000

+config SOC_PNX833X
+       bool
+       select CEVT_R4K
+       select CSRC_R4K
+       select IRQ_CPU
+       select DMA_NONCOHERENT
+       select SYS_HAS_EARLY_PRINTK
+       select SYS_HAS_CPU_MIPS32_R2
+       select SYS_SUPPORTS_32BIT_KERNEL
+       select SYS_SUPPORTS_LITTLE_ENDIAN
+       select SYS_SUPPORTS_BIG_ENDIAN
+       select GENERIC_HARDIRQS_NO__DO_IRQ
+       select SYS_SUPPORTS_KGDB
+       select GENERIC_GPIO
+       select CPU_MIPSR2_IRQ_VI
+
+config SOC_PNX8335
+       bool
+       select SOC_PNX833X
+
 config PNX8550
       bool
       select SOC_PNX8550
diff -urN --exclude=.svn linux-2.6.26-rc4.orig/arch/mips/Makefile
linux-2.6.26-rc4/arch/mips/Makefile
--- linux-2.6.26-rc4.orig/arch/mips/Makefile    2008-06-03
10:56:51.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/Makefile 2008-06-03 17:13:03.000000000 +0100
@@ -409,6 +409,14 @@
 #
 load-$(CONFIG_TANBAC_TB022X)   += 0xffffffff80000000

+# NXP STB225
+core-$(CONFIG_SOC_PNX833X)             += arch/mips/nxp/pnx833x/common/
+cflags-$(CONFIG_SOC_PNX833X)   += -Iinclude/asm-mips/mach-pnx833x
+libs-$(CONFIG_NXP_STB220)              += arch/mips/nxp/pnx833x/stb22x/
+load-$(CONFIG_NXP_STB220)              += 0xffffffff80001000
+libs-$(CONFIG_NXP_STB225)              += arch/mips/nxp/pnx833x/stb22x/
+load-$(CONFIG_NXP_STB225)              += 0xffffffff80001000
+
 #
 # Common NXP PNX8550
 #
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/gdb_hook.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/gdb_hook.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/gdb_hook.c
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/gdb_hook.c    2008-06-05
11:16:42.000000000 +0100
@@ -0,0 +1,162 @@
+/*
+ *  gdb_hook.c: gdb hook for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+
+/***********************************************
+* INCLUDE FILES                                *
+************************************************/
+
+#include <asm/mach-pnx833x/pnx833x.h>
+#include <linux/serial_pnx8xxx.h>
+
+/***********************************************
+* LOCAL MACROS                                 *
+************************************************/
+
+#define UART0 (unsigned char *)PNX833X_UART0_PORTS_START
+#define UART1 (unsigned char *)PNX833X_UART1_PORTS_START
+
+/***********************************************
+* LOCAL TYPEDEFS                               *
+************************************************/
+
+/***********************************************
+* STATIC FUNCTION PROTOTYPES                   *
+************************************************/
+
+/***********************************************
+* STATIC DATA                                  *
+************************************************/
+
+static unsigned char *kgdb_uart    = UART1;
+static unsigned char *console_uart = UART0;
+static volatile int delay_count;
+
+/***********************************************
+* EXPORTED DATA                                *
+************************************************/
+
+/***********************************************
+* FUNCTION IMPLEMENTATION                      *
+************************************************/
+
+static unsigned int serial_in(unsigned char *base_address, int offset)
+{
+       return *((unsigned int volatile *)(base_address + offset));
+}
+
+static void serial_out(unsigned char *base_address, int offset, int value)
+{
+       *((unsigned int volatile *)(base_address + offset)) = value;
+}
+
+static void do_delay(void)
+{
+       int i;
+       for (i = 0; i < 10000; i++)
+               delay_count++;
+}
+
+static int put_char(unsigned char *base_address, char c)
+{
+       /* Wait for TX to be ready */
+       while (((serial_in(base_address, PNX8XXX_FIFO) &
PNX8XXX_UART_FIFO_TXFIFO) >> 16) > 15)
+               do_delay();
+
+       /* Send the next character */
+       serial_out(base_address, PNX8XXX_FIFO, c);
+       serial_out(base_address, PNX8XXX_ICLR, PNX8XXX_UART_INT_TX);
+
+       return 1;
+}
+
+static char get_char(unsigned char *base_address)
+{
+       char output;
+
+       /* Wait for RX to be ready */
+       while ((serial_in(base_address, PNX8XXX_FIFO) &
PNX8XXX_UART_FIFO_RXFIFO) == 0)
+               do_delay();
+
+       /* Get the character */
+       output = serial_in(base_address, PNX8XXX_FIFO) & 0xFF;
+
+       /* Move onto the next character in the buffer */
+       serial_out(base_address, PNX8XXX_LCR, serial_in(base_address,
PNX8XXX_LCR) | PNX8XXX_UART_LCR_RX_NEXT);
+       serial_out(base_address, PNX8XXX_ICLR, PNX8XXX_UART_INT_RX);
+
+       return output;
+}
+
+static void serial_init(unsigned char *base_address)
+{
+       serial_out(base_address, PNX8XXX_LCR, PNX8XXX_UART_LCR_8BIT |
PNX8XXX_UART_LCR_TX_RST | PNX8XXX_UART_LCR_RX_RST);
+       serial_out(base_address, PNX8XXX_MCR, PNX8XXX_UART_MCR_DTR |
PNX8XXX_UART_MCR_RTS);
+       serial_out(base_address, PNX8XXX_BAUD, 1); /* 115200 Baud */
+       serial_out(base_address, PNX8XXX_CFG, 0x00060030);
+       serial_out(base_address, PNX8XXX_ICLR, -1);
+       serial_out(base_address, PNX8XXX_IEN, 0);
+}
+
+static void setup_serial_output(void)
+{
+       static bool initialised;
+       if (!initialised) {
+               serial_init(kgdb_uart);
+               serial_init(console_uart);
+               initialised = true;
+       }
+}
+
+int rs_kgdb_hook(int tty_no, int speed)
+{
+       kgdb_uart    = tty_no ? UART1 : UART0;
+       console_uart = tty_no ? UART0 : UART1;
+
+       setup_serial_output();
+
+       return speed;
+}
+
+int prom_putchar(char c)
+{
+       setup_serial_output();
+       return put_char(console_uart, c);
+}
+
+char prom_getchar(void)
+{
+       setup_serial_output();
+       return get_char(console_uart);
+}
+
+int put_debug_char(char c)
+{
+       setup_serial_output();
+       return put_char(kgdb_uart, c);
+}
+
+char get_debug_char(void)
+{
+       setup_serial_output();
+       return get_char(kgdb_uart);
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/interrupts.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/interrupts.c
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c  2008-06-05
11:44:06.000000000 +0100
@@ -0,0 +1,363 @@
+/*
+ *  interrupts.c: Interrupt mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+       unsigned int irq = PNX833X_REGFIELD(PIC_INT_SRC, INT_SRC);
+
+       if ((irq >= 1) && (irq < (PNX833X_PIC_NUM_IRQ))) {
+               unsigned long priority = PNX833X_PIC_INT_PRIORITY;
+               PNX833X_PIC_INT_PRIORITY = irq_prio[irq];
+
+               if (irq == PNX833X_PIC_GPIO_INT) {
+                       unsigned long mask = PNX833X_PIO_INT_STATUS &
PNX833X_PIO_INT_ENABLE;
+                       int pin;
+                       while ((pin = ffs(mask & 0xffff))) {
+                               pin -= 1;
+                               do_IRQ(PNX833X_GPIO_IRQ_BASE + pin);
+                               mask &= ~(1 << pin);
+                       }
+               } else {
+                       do_IRQ(irq + PNX833X_PIC_IRQ_BASE);
+               }
+
+               PNX833X_PIC_INT_PRIORITY = priority;
+       } else {
+               printk(KERN_ERR "plat_irq_dispatch: unexpected irq %u\n", irq);
+       }
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+       unsigned int pending = read_c0_status() & read_c0_cause();
+
+       if (pending & STATUSF_IP4)
+               pic_dispatch();
+       else if (pending & STATUSF_IP7)
+               do_IRQ(PNX833X_TIMER_IRQ);
+       else
+               spurious_interrupt();
+}
+
+static inline void pnx833x_hard_enable_pic_irq(unsigned int irq)
+{
+       /* Currently we do this by setting IRQ priority to 1.
+          If priority support is being implemented, 1 should be repalced
+               by a better value. */
+       PNX833X_PIC_INT_REG(irq) = irq_prio[irq];
+}
+
+static inline void pnx833x_hard_disable_pic_irq(unsigned int irq)
+{
+       /* Disable IRQ by writing setting it's priority to 0 */
+       PNX833X_PIC_INT_REG(irq) = 0;
+}
+
+static int irqflags[PNX833X_PIC_NUM_IRQ];      /* initialized by zeroes */
+#define IRQFLAG_STARTED                1
+#define IRQFLAG_DISABLED       2
+
+static DEFINE_SPINLOCK(irq_lock);
+
+static unsigned int pnx833x_startup_pic_irq(unsigned int irq)
+{
+       unsigned long flags;
+       unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+       spin_lock_irqsave(&irq_lock, flags);
+
+       irqflags[pic_irq] = IRQFLAG_STARTED;    /* started, not disabled */
+       pnx833x_hard_enable_pic_irq(pic_irq);
+
+       spin_unlock_irqrestore(&irq_lock, flags);
+       return 0;
+}
+
+static void pnx833x_shutdown_pic_irq(unsigned int irq)
+{
+       unsigned long flags;
+       unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+       spin_lock_irqsave(&irq_lock, flags);
+
+       irqflags[pic_irq] = 0;                  /* not started */
+       pnx833x_hard_disable_pic_irq(pic_irq);
+
+       spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static void pnx833x_enable_pic_irq(unsigned int irq)
+{
+       unsigned long flags;
+       unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+       spin_lock_irqsave(&irq_lock, flags);
+
+       irqflags[pic_irq] &= ~IRQFLAG_DISABLED;
+       if (irqflags[pic_irq] == IRQFLAG_STARTED)
+               pnx833x_hard_enable_pic_irq(pic_irq);
+
+       spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static void pnx833x_disable_pic_irq(unsigned int irq)
+{
+       unsigned long flags;
+       unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
+
+       spin_lock_irqsave(&irq_lock, flags);
+
+       irqflags[pic_irq] |= IRQFLAG_DISABLED;
+       pnx833x_hard_disable_pic_irq(pic_irq);
+
+       spin_unlock_irqrestore(&irq_lock, flags);
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
+static DEFINE_SPINLOCK(gpio_irq_lock);
+
+static unsigned int pnx833x_startup_gpio_irq(unsigned int irq)
+{
+       int pin = irq - PNX833X_GPIO_IRQ_BASE;
+       unsigned long flags;
+       spin_lock_irqsave(&gpio_irq_lock, flags);
+       gpio_enable_irq(pin);
+       spin_unlock_irqrestore(&gpio_irq_lock, flags);
+       return 0;
+}
+
+static void pnx833x_enable_gpio_irq(unsigned int irq)
+{
+       int pin = irq - PNX833X_GPIO_IRQ_BASE;
+       unsigned long flags;
+       spin_lock_irqsave(&gpio_irq_lock, flags);
+       gpio_enable_irq(pin);
+       spin_unlock_irqrestore(&gpio_irq_lock, flags);
+}
+
+static void pnx833x_disable_gpio_irq(unsigned int irq)
+{
+       int pin = irq - PNX833X_GPIO_IRQ_BASE;
+       unsigned long flags;
+       spin_lock_irqsave(&gpio_irq_lock, flags);
+       gpio_disable_irq(pin);
+       spin_unlock_irqrestore(&gpio_irq_lock, flags);
+}
+
+static void pnx833x_ack_gpio_irq(unsigned int irq)
+{
+}
+
+static void pnx833x_end_gpio_irq(unsigned int irq)
+{
+       int pin = irq - PNX833X_GPIO_IRQ_BASE;
+       unsigned long flags;
+       spin_lock_irqsave(&gpio_irq_lock, flags);
+       gpio_clear_irq(pin);
+       spin_unlock_irqrestore(&gpio_irq_lock, flags);
+}
+
+static int pnx833x_set_type_gpio_irq(unsigned int irq, unsigned int flow_type)
+{
+       int pin = irq - PNX833X_GPIO_IRQ_BASE;
+       int gpio_mode;
+
+       switch (flow_type) {
+       case IRQ_TYPE_EDGE_RISING:
+               gpio_mode = GPIO_INT_EDGE_RISING;
+               break;
+       case IRQ_TYPE_EDGE_FALLING:
+               gpio_mode = GPIO_INT_EDGE_FALLING;
+               break;
+       case IRQ_TYPE_EDGE_BOTH:
+               gpio_mode = GPIO_INT_EDGE_BOTH;
+               break;
+       case IRQ_TYPE_LEVEL_HIGH:
+               gpio_mode = GPIO_INT_LEVEL_HIGH;
+               break;
+       case IRQ_TYPE_LEVEL_LOW:
+               gpio_mode = GPIO_INT_LEVEL_LOW;
+               break;
+       default:
+               gpio_mode = GPIO_INT_NONE;
+               break;
+       }
+
+       gpio_setup_irq(gpio_mode, pin);
+
+       return 0;
+}
+
+static struct irq_chip pnx833x_pic_irq_type = {
+       .typename = "PNX-PIC",
+       .startup = pnx833x_startup_pic_irq,
+       .shutdown = pnx833x_shutdown_pic_irq,
+       .enable = pnx833x_enable_pic_irq,
+       .disable = pnx833x_disable_pic_irq,
+       .ack = pnx833x_ack_pic_irq,
+       .end = pnx833x_end_pic_irq
+};
+
+static struct irq_chip pnx833x_gpio_irq_type = {
+       .typename = "PNX-GPIO",
+       .startup = pnx833x_startup_gpio_irq,
+       .shutdown = pnx833x_disable_gpio_irq,
+       .enable = pnx833x_enable_gpio_irq,
+       .disable = pnx833x_disable_gpio_irq,
+       .ack = pnx833x_ack_gpio_irq,
+       .end = pnx833x_end_gpio_irq,
+       .set_type = pnx833x_set_type_gpio_irq
+};
+
+void __init arch_init_irq(void)
+{
+       unsigned int irq;
+
+       /* setup standard internal cpu irqs */
+       mips_cpu_irq_init();
+
+       /* Set IRQ information in irq_desc */
+       for (irq = PNX833X_PIC_IRQ_BASE; irq < (PNX833X_PIC_IRQ_BASE +
PNX833X_PIC_NUM_IRQ); irq++) {
+               pnx833x_hard_disable_pic_irq(irq);
+               set_irq_chip_and_handler(irq, &pnx833x_pic_irq_type,
handle_simple_irq);
+       }
+
+       for (irq = PNX833X_GPIO_IRQ_BASE; irq < (PNX833X_GPIO_IRQ_BASE +
PNX833X_GPIO_NUM_IRQ); irq++)
+               set_irq_chip_and_handler(irq, &pnx833x_gpio_irq_type,
handle_simple_irq);
+
+       /* Set PIC priority limiter register to 0 */
+       PNX833X_PIC_INT_PRIORITY = 0;
+
+       /* Setup GPIO IRQ dispatching */
+       pnx833x_startup_pic_irq(PNX833X_PIC_GPIO_INT);
+
+       /* Enable PIC IRQs (HWIRQ2) */
+       if (cpu_has_vint)
+               set_vi_handler(4, pic_dispatch);
+
+       write_c0_status(read_c0_status() | IE_IRQ2);
+}
+
+
+void __init plat_time_init(void)
+{
+       /* calculate mips_hpt_frequency based on PNX833X_CLOCK_CPUCP_CTL reg */
+
+       extern unsigned long mips_hpt_frequency;
+       unsigned long reg = PNX833X_CLOCK_CPUCP_CTL;
+
+       if (!(PNX833X_BIT(reg, CLOCK_CPUCP_CTL, EXIT_RESET))) {
+               /* Functional clock is disabled so use crystal frequency */
+               mips_hpt_frequency = 25;
+       } else {
+#if defined(CONFIG_SOC_PNX8335)
+               /* Functional clock is enabled, so get clock multiplier */
+               mips_hpt_frequency = 90 + (10 *
PNX8335_REGFIELD(CLOCK_PLL_CPU_CTL, FREQ));
+#else
+               static const unsigned long int freq[4] = {240, 160, 120, 80};
+               mips_hpt_frequency = freq[PNX833X_FIELD(reg,
CLOCK_CPUCP_CTL, DIV_CLOCK)];
+#endif
+       }
+
+       printk(KERN_INFO "CPU clock is %ld MHz\n", mips_hpt_frequency);
+
+       mips_hpt_frequency *= 500000;
+}
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/Makefile
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/Makefile
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/Makefile 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/Makefile      2008-03-03
13:09:30.000000000 +0000
@@ -0,0 +1 @@
+obj-y := interrupts.o platform.o prom.o setup.o reset.o gdb_hook.o
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/platform.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/platform.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/platform.c
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/platform.c    2008-06-05
11:09:06.000000000 +0100
@@ -0,0 +1,337 @@
+/*
+ *  platform.c: platform support for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+#include <pnx833x.h>
+
+#if defined(CONFIG_SERIAL_PNX8XXX) || defined(CONFIG_SERIAL_PNX8XXX_MODULE)
+static u64 uart_dmamask     = ~(u32)0;
+
+static struct resource pnx833x_uart_resources[] = {
+       [0] = {
+               .start          = PNX833X_UART0_PORTS_START,
+               .end            = PNX833X_UART0_PORTS_END,
+               .flags          = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start          = PNX833X_PIC_UART0_INT,
+               .end            = PNX833X_PIC_UART0_INT,
+               .flags          = IORESOURCE_IRQ,
+       },
+       [2] = {
+               .start          = PNX833X_UART1_PORTS_START,
+               .end            = PNX833X_UART1_PORTS_END,
+               .flags          = IORESOURCE_MEM,
+       },
+       [3] = {
+               .start          = PNX833X_PIC_UART1_INT,
+               .end            = PNX833X_PIC_UART1_INT,
+               .flags          = IORESOURCE_IRQ,
+       },
+};
+
+struct pnx8xxx_port pnx8xxx_ports[] = {
+       [0] = {
+               .port   = {
+                       .type           = PORT_PNX8XXX,
+                       .iotype         = UPIO_MEM,
+                       .membase        = (void __iomem
*)PNX833X_UART0_PORTS_START,
+                       .mapbase        = PNX833X_UART0_PORTS_START,
+                       .irq            = PNX833X_PIC_UART0_INT,
+                       .uartclk        = 3692300,
+                       .fifosize       = 16,
+                       .flags          = UPF_BOOT_AUTOCONF,
+                       .line           = 0,
+               },
+       },
+       [1] = {
+               .port   = {
+                       .type           = PORT_PNX8XXX,
+                       .iotype         = UPIO_MEM,
+                       .membase        = (void __iomem
*)PNX833X_UART1_PORTS_START,
+                       .mapbase        = PNX833X_UART1_PORTS_START,
+                       .irq            = PNX833X_PIC_UART1_INT,
+                       .uartclk        = 3692300,
+                       .fifosize       = 16,
+                       .flags          = UPF_BOOT_AUTOCONF,
+                       .line           = 1,
+               },
+       },
+};
+
+static struct platform_device pnx833x_uart_device = {
+       .name           = "pnx8xxx-uart",
+       .id             = -1,
+       .dev = {
+               .dma_mask               = &uart_dmamask,
+               .coherent_dma_mask      = 0xffffffff,
+               .platform_data          = pnx8xxx_ports,
+       },
+       .num_resources  = ARRAY_SIZE(pnx833x_uart_resources),
+       .resource       = pnx833x_uart_resources,
+};
+#endif
+
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+static u64 ehci_dmamask     = ~(u32)0;
+
+static struct resource pnx833x_usb_ehci_resources[] = {
+       [0] = {
+               .start          = PNX833X_USB_PORTS_START,
+               .end            = PNX833X_USB_PORTS_END,
+               .flags          = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start          = PNX833X_PIC_USB_INT,
+               .end            = PNX833X_PIC_USB_INT,
+               .flags          = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device pnx833x_usb_ehci_device = {
+       .name           = "pnx833x-ehci",
+       .id             = -1,
+       .dev = {
+               .dma_mask               = &ehci_dmamask,
+               .coherent_dma_mask      = 0xffffffff,
+       },
+       .num_resources  = ARRAY_SIZE(pnx833x_usb_ehci_resources),
+       .resource       = pnx833x_usb_ehci_resources,
+};
+#endif
+
+#if defined(CONFIG_I2C_PNX0105) || defined(CONFIG_I2C_PNX0105_MODULE)
+static struct resource pnx833x_i2c0_resources[] = {
+       {
+               .start          = PNX833X_I2C0_PORTS_START,
+               .end            = PNX833X_I2C0_PORTS_END,
+               .flags          = IORESOURCE_MEM,
+       },
+       {
+               .start          = PNX833X_PIC_I2C0_INT,
+               .end            = PNX833X_PIC_I2C0_INT,
+               .flags          = IORESOURCE_IRQ,
+       },
+};
+
+static struct resource pnx833x_i2c1_resources[] = {
+       {
+               .start          = PNX833X_I2C1_PORTS_START,
+               .end            = PNX833X_I2C1_PORTS_END,
+               .flags          = IORESOURCE_MEM,
+       },
+       {
+               .start          = PNX833X_PIC_I2C1_INT,
+               .end            = PNX833X_PIC_I2C1_INT,
+               .flags          = IORESOURCE_IRQ,
+       },
+};
+
+static struct i2c_pnx0105_dev pnx833x_i2c_dev[] = {
+       {
+               .base = PNX833X_I2C0_PORTS_START,
+               .irq = -1, /* should be PNX833X_PIC_I2C0_INT but
polling is faster */
+               .clock = 6,     /* 0 == 400 kHz, 4 == 100 kHz(Maximum HDMI), 6 =
50kHz(Prefered HDCP) */
+               .bus_addr = 0,  /* no slave support */
+       },
+       {
+               .base = PNX833X_I2C1_PORTS_START,
+               .irq = -1,      /* on high freq, polling is faster */
+               /*.irq = PNX833X_PIC_I2C1_INT,*/
+               .clock = 4,     /* 0 == 400 kHz, 4 == 100 kHz. 100 kHz
seems a safe
default for now */
+               .bus_addr = 0,  /* no slave support */
+       },
+};
+
+static struct platform_device pnx833x_i2c0_device = {
+       .name           = "i2c-pnx0105",
+       .id             = 0,
+       .dev = {
+               .platform_data = &pnx833x_i2c_dev[0],
+       },
+       .num_resources  = ARRAY_SIZE(pnx833x_i2c0_resources),
+       .resource       = pnx833x_i2c0_resources,
+};
+
+static struct platform_device pnx833x_i2c1_device = {
+       .name           = "i2c-pnx0105",
+       .id             = 1,
+       .dev = {
+               .platform_data = &pnx833x_i2c_dev[1],
+       },
+       .num_resources  = ARRAY_SIZE(pnx833x_i2c1_resources),
+       .resource       = pnx833x_i2c1_resources,
+};
+#endif
+
+#if defined(CONFIG_IP3902) || defined(CONFIG_IP3902_MODULE)
+static u64 ethernet_dmamask = ~(u32)0;
+
+static struct resource pnx833x_ethernet_resources[] = {
+       [0] = {
+               .start = PNX8335_IP3902_PORTS_START,
+               .end   = PNX8335_IP3902_PORTS_END,
+               .flags = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start = PNX8335_PIC_ETHERNET_INT,
+               .end   = PNX8335_PIC_ETHERNET_INT,
+               .flags = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device pnx833x_ethernet_device = {
+       .name = "ip3902-eth",
+       .id   = -1,
+       .dev  = {
+               .dma_mask          = &ethernet_dmamask,
+               .coherent_dma_mask = 0xffffffff,
+       },
+       .num_resources = ARRAY_SIZE(pnx833x_ethernet_resources),
+       .resource      = pnx833x_ethernet_resources,
+};
+#endif
+
+#if defined(CONFIG_SATA_PNX833X) || defined(CONFIG_SATA_PNX833X_MODULE)
+static struct resource pnx833x_sata_resources[] = {
+       [0] = {
+               .start = PNX8335_SATA_PORTS_START,
+               .end   = PNX8335_SATA_PORTS_END,
+               .flags = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start = PNX8335_PIC_SATA_INT,
+               .end   = PNX8335_PIC_SATA_INT,
+               .flags = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device pnx833x_sata_device = {
+       .name          = "pnx833x-sata",
+       .id            = -1,
+       .num_resources = ARRAY_SIZE(pnx833x_sata_resources),
+       .resource      = pnx833x_sata_resources,
+};
+#endif
+
+#if defined(CONFIG_MTD_NAND_PLATFORM) ||
defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+
+#define STB225_NAND_BASE           0x18000000  /* I/O location(gets remapped)*/
+#define STB225_NAND_CLE_MASK   0x00100000      /* I/O location with CLE high */
+#define STB225_NAND_ALE_MASK   0x00010000      /* I/O location with ALE high */
+
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *part_probes[] = { "cmdlinepart", 0 };
+#endif
+
+static void
+pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+       struct nand_chip *this = mtd->priv;
+       unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
+
+       if (cmd == NAND_CMD_NONE)
+               return;
+
+       if (ctrl & NAND_CLE)
+               writeb(cmd, (void __iomem *)(nandaddr + STB225_NAND_CLE_MASK));
+       else
+               writeb(cmd, (void __iomem *) (nandaddr + STB225_NAND_ALE_MASK));
+}
+
+static struct platform_nand_data pnx833x_flash_nand_data = {
+       .chip = {
+               .chip_delay             = 25,
+#ifdef CONFIG_MTD_PARTITIONS
+               .part_probe_types       = part_probes,
+#endif
+       },
+       .ctrl = {
+               .cmd_ctrl               = pnx833x_flash_nand_cmd_ctrl
+       }
+};
+
+/* Set start to be the correct address (STB225_NAND_BASE with no 0xb!!),
+   12 bytes more seems to be the standard that allows for NAND access.*/
+static struct resource pnx833x_flash_nand_resource = {
+       .start  = STB225_NAND_BASE,
+       .end    = STB225_NAND_BASE + 12,
+       .flags  = IORESOURCE_MEM,
+};
+
+static struct platform_device pnx833x_flash_nand = {
+       .name           = "gen_nand",
+       .id                     = -1,
+       .num_resources  = 1,
+       .resource           = &pnx833x_flash_nand_resource,
+       .dev            = {
+               .platform_data = &pnx833x_flash_nand_data,
+       },
+};
+#endif /* CONFIG_MTD_NAND_PLATFORM */
+
+static struct platform_device *pnx833x_platform_devices[] __initdata = {
+#if defined(CONFIG_SERIAL_PNX8XXX) || defined(CONFIG_SERIAL_PNX8XXX_MODULE)
+       &pnx833x_uart_device,
+#endif
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+       &pnx833x_usb_ehci_device,
+#endif
+#if defined(CONFIG_I2C_PNX0105) || defined(CONFIG_I2C_PNX0105_MODULE)
+       &pnx833x_i2c0_device,
+       &pnx833x_i2c1_device,
+#endif
+#if defined(CONFIG_IP3902) || defined(CONFIG_IP3902_MODULE)
+       &pnx833x_ethernet_device,
+#endif
+#if defined(CONFIG_SATA_PNX833X) || defined(CONFIG_SATA_PNX833X_MODULE)
+       &pnx833x_sata_device,
+#endif
+#if defined(CONFIG_MTD_NAND_PLATFORM) ||
defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+       &pnx833x_flash_nand,
+#endif
+};
+
+int __init pnx833x_platform_init(void)
+{
+       int res;
+
+       if (ARRAY_SIZE(pnx833x_platform_devices)) {
+               res = platform_add_devices(pnx833x_platform_devices,
+               ARRAY_SIZE(pnx833x_platform_devices));
+       }
+       return res;
+}
+
+arch_initcall(pnx833x_platform_init);
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/prom.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/prom.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/prom.c   1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/prom.c        2008-06-05
09:26:59.000000000 +0100
@@ -0,0 +1,69 @@
+/*
+ *  prom.c:
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+       int argc = fw_arg0;
+       char **argv = (char **)fw_arg1;
+       char *c = &(arcs_cmdline[0]);
+       int i;
+
+       for (i = 1; i < argc; i++) {
+               strcpy(c, argv[i]);
+               c += strlen(argv[i]);
+               if (i < argc-1)
+                       *c++ = ' ';
+       }
+       *c = 0;
+}
+
+char __init *prom_getenv(char *envname)
+{
+       extern char **prom_envp;
+       char **env = prom_envp;
+       int i;
+
+       i = strlen(envname);
+
+       while (*env) {
+               if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
+                       return *env + i + 1;
+               env++;
+       }
+
+       return 0;
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+char * __init prom_getcmdline(void)
+{
+       return arcs_cmdline;
+}
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/reset.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/reset.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/reset.c  1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/reset.c       2008-06-05
11:27:00.000000000 +0100
@@ -0,0 +1,48 @@
+/*
+ *  reset.c: reset support for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+       printk(KERN_ALERT "\n\nRestarting ...\n\n");
+
+       PNX833X_RESET_CONTROL_2 = 0;
+       PNX833X_RESET_CONTROL = 0;
+}
+
+void pnx833x_machine_halt(void)
+{
+       printk(KERN_ALERT "\n\nSystem halted.\n\n");
+
+       while (1)
+               __asm__ __volatile__ ("wait");
+}
+
+void pnx833x_machine_power_off(void)
+{
+       printk(KERN_ALERT "\n\nPower off not implemented.");
+       pnx833x_machine_halt();
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/setup.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/setup.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/setup.c  1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/setup.c       2008-06-05
11:46:31.000000000 +0100
@@ -0,0 +1,63 @@
+/*
+ *  setup.c: Setup PNX833X Soc.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+       /* fake pci bus to avoid bounce buffers */
+       PCI_DMA_BUS_IS_PHYS = 1;
+
+       /* set mips clock to 320MHz */
+#if defined(CONFIG_SOC_PNX8335)
+       PNX8335_WRITEFIELD(0x17, CLOCK_PLL_CPU_CTL, FREQ);
+#endif
+       gpio_init();    /* so it will be ready in board_setup() */
+
+       pnx833x_board_setup();
+
+       _machine_restart = pnx833x_machine_restart;
+       _machine_halt = pnx833x_machine_halt;
+       pm_power_off = pnx833x_machine_power_off;
+
+       /* IO/MEM resources. */
+       set_io_port_base(KSEG1);
+       ioport_resource.start = 0;
+       ioport_resource.end = ~0;
+       iomem_resource.start = 0;
+       iomem_resource.end = ~0;
+
+       return 0;
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/board.c
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/board.c
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/board.c  1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/board.c       2008-06-05
11:17:10.000000000 +0100
@@ -0,0 +1,138 @@
+/*
+ *  board.c: STB225 board support.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+       return "NXP STB22x";
+}
+
+static inline unsigned long env_or_default(char *env, unsigned long dfl)
+{
+       char *str = prom_getenv(env);
+       return str ? simple_strtol(str, 0, 0) : dfl;
+}
+
+void __init prom_init(void)
+{
+       unsigned long memsize;
+
+       prom_argc = fw_arg0;
+       prom_argv = (char **)fw_arg1;
+       prom_envp = (char **)fw_arg2;
+
+       prom_init_cmdline();
+
+       memsize = env_or_default("memsize", 0x02000000);
+       add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
+void __init pnx833x_board_setup(void)
+{
+#if defined(CONFIG_SERIAL_PNX8XXX) || defined(CONFIG_SERIAL_PNX8XXX_MODULE)
+       gpio_select_function_alt(4);
+       gpio_select_output(4);
+       gpio_select_function_alt(5);
+       gpio_select_input(5);
+       gpio_select_function_alt(6);
+       gpio_select_input(6);
+       gpio_select_function_alt(7);
+       gpio_select_output(7);
+#endif
+
+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+       gpio_select_function_alt(25);
+       gpio_select_function_alt(26);
+#endif
+
+#if defined(CONFIG_IP3902) || defined(CONFIG_IP3902_MODULE)
+       gpio_select_function_alt(27);
+       gpio_select_function_alt(28);
+       gpio_select_function_alt(29);
+       gpio_select_function_alt(30);
+       gpio_select_function_alt(31);
+       gpio_select_function_alt(32);
+       gpio_select_function_alt(33);
+#endif
+
+#if defined(CONFIG_MTD_NAND_PLATFORM) ||
defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+       /* Setup MIU for NAND access on CS0...
+        *
+        * (it seems that we must also configure CS1 for reliable operation,
+        * otherwise the first read ID command will fail if it's read as 4 bytes
+        * but pass if it's read as 1 word.)
+        */
+
+       /* Setup MIU CS0 & CS1 timing */
+       PNX833X_MIU_SEL0 = 0;
+       PNX833X_MIU_SEL1 = 0;
+       PNX833X_MIU_SEL0_TIMING = 0x50003081;
+       PNX833X_MIU_SEL1_TIMING = 0x50003081;
+
+       /* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does
not need this) */
+       gpio_select_function_alt(0);
+
+       /* Setup GPIO 04 to input NAND read/busy signal */
+       gpio_select_function_io(4);
+       gpio_select_input(4);
+
+       /* Setup GPIO 05 to disable NAND write protect */
+       gpio_select_function_io(5);
+       gpio_select_output(5);
+       gpio_write(1, 5);
+
+#elif defined(CONFIG_MTD_CFI) || defined(CONFIG_MTD_CFI_MODULE)
+
+       /* Set up MIU for 16-bit NOR access on CS0 and CS1... */
+
+       /* Setup MIU CS0 & CS1 timing */
+       PNX833X_MIU_SEL0 = 1;
+       PNX833X_MIU_SEL1 = 1;
+       PNX833X_MIU_SEL0_TIMING = 0x6A08D082;
+       PNX833X_MIU_SEL1_TIMING = 0x6A08D082;
+
+       /* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does
not need this) */
+       gpio_select_function_alt(0);
+#endif
+}
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/Makefile
linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/Makefile
--- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/Makefile 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/Makefile      2008-03-03
13:09:30.000000000 +0000
@@ -0,0 +1 @@
+lib-y := board.o
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-pnx0105.c
linux-2.6.26-rc4/drivers/i2c/busses/i2c-pnx0105.c
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-pnx0105.c      1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-pnx0105.c   2008-06-05
11:25:57.000000000 +0100
@@ -0,0 +1,328 @@
+/*
+ *  i2c-pnx0105.c: driver for PNX833X I2C (IP0105 Block)
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Copyright (C) 2006 Nikita Youshchenko <yoush@debian.org>
+ *
+ *  Partially based on i2c-pca-isa driver, Copyright (C) 2004 Arcom Control
+ *  Systems.
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-pnx0105.h>
+#include <linux/i2c-algo-pca.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+static inline unsigned long i2c_pnx0105_in(struct i2c_pnx0105_dev
*dev, int offset)
+{
+       return readl((unsigned long *)(dev->base + offset));
+}
+
+static inline void i2c_pnx0105_out(struct i2c_pnx0105_dev *dev, int
offset, unsigned long value)
+{
+       writel(value, (unsigned long *)(dev->base + offset));
+}
+
+static void i2c_pnx0105_writebyte(void *pa, int reg, int val)
+{
+       struct i2c_algo_pca_data *algo_data = container_of(pa, struct
i2c_algo_pca_data, data);
+       struct i2c_pnx0105_dev *dev = container_of(algo_data, struct
i2c_pnx0105_dev, algo_data);
+       int old_si;
+
+#ifdef DEBUG
+       static char *names[] = { "T/O", "DAT", "ADR", "CON"};
+       printk(KERN_DEBUG "i2c_pnx0105(0x%08lx): write %s <= %#04x\n",
dev->base, names[reg], val);
+#endif
+
+       switch (reg) {
+
+       case I2C_PCA_DAT:
+               i2c_pnx0105_out(dev, I2C_PNX0105_DAT, val & 255);
+               break;
+
+       case I2C_PCA_ADR:
+               i2c_pnx0105_out(dev, I2C_PNX0105_ADDRESS, val & 255);
+               break;
+
+       case I2C_PCA_CON:
+               /* Possible RACE: just after init, or after stop,
+                  SI bit is zero. That means that when STA bit
+                  is written, hardware starts to process it
+                  immediately. It could complete very fast (or
+                  perhaps thread may get preempted), so when code
+                  several lines below is executed, SI could already
+                  be set to indicate that STA processing is complete.
+                  In this case, SI must NOT be cleared here, so
+                  hardware won't continue and send slave address
+                  before it was written to register.
+                  However, if SI bit is currently set, hardware
+                  won't process command immediately, and SI should
+                  be cleared at the bottom, to enable processing.
+                  Solution: just check SI here, and clear it only
+                  if it was set before any new value was written
+                  to command register.
+                */
+               old_si = i2c_pnx0105_in(dev, I2C_PNX0105_INT_STATUS) & 1;
+
+               i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, val & 255);
+
+               /* We have to process STO bit separately */
+               if (val & I2C_PCA_CON_STO)
+                       i2c_pnx0105_out(dev, I2C_PNX0105_STOP, 1);
+
+               /* And also SI bit ... */
+               if (old_si && !(val & I2C_PCA_CON_SI)) {
+                       i2c_pnx0105_out(dev, I2C_PNX0105_INT_CLEAR, 1);
+                       if (dev->irq > -1 && !(val & I2C_PCA_CON_STO))
+                               i2c_pnx0105_out(dev, I2C_PNX0105_INT_ENABLE, 1);
+               }
+
+               break;
+
+       default:
+               BUG();
+       }
+}
+
+static int i2c_pnx0105_readbyte(void *pa, int reg)
+{
+       struct i2c_algo_pca_data *algo_data = container_of(pa, struct
i2c_algo_pca_data, data);
+       struct i2c_pnx0105_dev *dev = container_of(algo_data, struct
i2c_pnx0105_dev, algo_data);
+       int res = 0;
+
+       switch (reg) {
+
+       case I2C_PCA_STA:
+               if (dev->timeout) {
+                       res = 0xff;
+                       dev->timeout = 0;
+               } else
+                       res     = i2c_pnx0105_in(dev, I2C_PNX0105_STATUS) & 255;
+               break;
+
+       case I2C_PCA_DAT:
+               res = i2c_pnx0105_in(dev, I2C_PNX0105_DAT) & 255;
+               break;
+
+       case I2C_PCA_CON:
+               res = i2c_pnx0105_in(dev, I2C_PNX0105_CONTROL) & 255;
+
+               /* Read SI bit from elsewhere */
+               if (i2c_pnx0105_in(dev, I2C_PNX0105_INT_STATUS))
+                       res |= I2C_PCA_CON_SI;
+               else
+                       res     &= ~I2C_PCA_CON_SI;
+
+               break;
+
+       default:
+               BUG();
+       }
+
+#ifdef DEBUG
+       {
+               static char *names[] = { "STA", "DAT", "ADR", "CON"};
+               printk(KERN_DEBUG "i2c_pnx0105(0x%08lx): read %s => %#04x\n",
dev->base, names[reg], res);
+       }
+#endif
+       return res;
+}
+
+static inline void i2c_pnx0105_reset(struct i2c_pnx0105_dev *dev)
+{
+       unsigned long val = i2c_pnx0105_in(dev, I2C_PNX0105_CONTROL) & 0x47;
+       i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, val | 0x40);
+       i2c_pnx0105_out(dev, I2C_PNX0105_STOP, 1);
+       i2c_pnx0105_out(dev, I2C_PNX0105_INT_CLEAR, 1);
+       udelay(200);
+       i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, val);
+}
+
+static inline int i2c_pnx0105_intr_condition(struct i2c_pnx0105_dev *dev)
+{
+       return i2c_pnx0105_in(dev, I2C_PNX0105_INT_STATUS) & 1;
+}
+
+static int i2c_pnx0105_waitforcompletion(void *pa)
+{
+       struct i2c_algo_pca_data *algo_data = container_of(pa, struct
i2c_algo_pca_data, data);
+       struct i2c_pnx0105_dev *dev = container_of(algo_data, struct
i2c_pnx0105_dev, algo_data);
+
+       /* Set some timeout */
+#define JIFFIES_TO_WAIT        ((HZ / 100) + 1)        /* attempt to
model 10 milliseconds */
+
+       if (dev->irq > -1) {
+               wait_event_timeout(dev->wait,
+
i2c_pnx0105_intr_condition(dev), JIFFIES_TO_WAIT);
+       } else {
+               unsigned long end = jiffies + JIFFIES_TO_WAIT;
+               while (!i2c_pnx0105_intr_condition(dev) &&
+                          time_before(jiffies, end)) {
+                       if (in_atomic())
+                               udelay(100);
+                       else
+                               schedule();
+               }
+       }
+
+       if (i2c_pnx0105_intr_condition(dev))
+               return 0;
+
+       /* Timeout. Reset device and make next status read to return 0xff */
+       i2c_pnx0105_reset(dev);
+       dev->timeout = 1;
+       return -EIO;    /* Ignored anyway */
+}
+
+static irqreturn_t i2c_pnx0105_interrupt(int this_irq, void *dev_id)
+{
+       struct i2c_pnx0105_dev *dev = (struct i2c_pnx0105_dev *)dev_id;
+
+       /* Disable interrupt for a while (until it's actually handled) */
+       i2c_pnx0105_out(dev, I2C_PNX0105_INT_ENABLE, 0);
+
+       /* Wake up any process waiting for this interrupt */
+       wake_up_interruptible(&dev->wait);
+
+       return IRQ_HANDLED;
+}
+
+static int __devinit i2c_pnx0105_probe(struct platform_device *pdev)
+{
+       struct i2c_pnx0105_dev *dev = (struct i2c_pnx0105_dev *)
pdev->dev.platform_data;
+       struct i2c_algo_pca_data *algo_data = &dev->algo_data;
+       struct i2c_adapter *adap = &dev->adap;
+       int res;
+
+       algo_data->write_byte = i2c_pnx0105_writebyte;
+       algo_data->read_byte = i2c_pnx0105_readbyte;
+       algo_data->wait_for_completion = i2c_pnx0105_waitforcompletion;
+
+       adap->owner = THIS_MODULE;
+       adap->id = I2C_HW_A_PNX0105;
+       adap->algo_data = algo_data;
+       strncpy(adap->name, pdev->name, I2C_NAME_SIZE);
+
+       dev->timeout = 0;
+       init_waitqueue_head(&dev->wait);
+
+       if (request_region(dev->base, I2C_PNX0105_IO_SIZE, "i2c-pnx") == 0) {
+               printk(KERN_ERR "i2c-pnx0105: request_region(0x%08lx) failed\n",
+                          dev->base);
+               return -EBUSY;
+       }
+
+       /* Disable interrupt - just to be sure ... */
+       i2c_pnx0105_out(dev, I2C_PNX0105_INT_ENABLE, 0);
+
+       if (dev->irq > -1) {
+               res = request_irq(dev->irq, i2c_pnx0105_interrupt, 0,
"i2c-pnx", dev);
+               if (res < 0) {
+                       printk(KERN_ERR "i2c-pnx0105: request_irq() failed\n");
+                       goto err_region;
+               }
+       }
+
+       /* Rude attempt to probe hardware, to avoid future hangups if it is
+          not responding */
+       i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, 0x60);
+       udelay(200);
+       res = i2c_pnx0105_intr_condition(dev) ? 0 : -ENODEV;
+       i2c_pnx0105_reset(dev);
+
+       if (res < 0) {
+               printk(KERN_ERR "i2c-pnx0105: device at 0x%08lx is not
responding\n",
+                          dev->base);
+               goto err_irq;
+       }
+
+       res = i2c_pca_add_bus(adap);
+       if (res < 0) {
+               printk(KERN_ERR "i2c-pnx0105: i2c_pca_add_bus() failed\n");
+               goto err_irq;
+       }
+
+       printk(KERN_INFO "i2c-pnx0105: registered device at 0x%08lx",
dev->base);
+       if (dev->irq > -1)
+               printk(KERN_ERR ", irq %d", dev->irq);
+       printk(KERN_INFO "\n");
+
+       return 0;
+
+err_irq:
+       if (dev->irq > -1)
+               free_irq(dev->irq, dev);
+
+err_region:
+       release_region(dev->base, I2C_PNX0105_IO_SIZE);
+
+       return res;
+}
+
+static int __devexit i2c_pnx0105_remove(struct platform_device *pdev)
+{
+       struct i2c_pnx0105_dev *dev = (struct i2c_pnx0105_dev *)
pdev->dev.platform_data;
+       struct i2c_adapter *adap = &dev->adap;
+       int res;
+
+       res = i2c_del_adapter(adap);
+       if (res < 0)
+               return res;
+
+       if (dev->irq > -1)
+               free_irq(dev->irq, dev);
+
+       release_region(dev->base, I2C_PNX0105_IO_SIZE);
+
+       return 0;
+}
+
+static struct platform_driver i2c_pnx0105_driver = {
+       .probe      = i2c_pnx0105_probe,
+       .remove     = __devexit_p(i2c_pnx0105_remove),
+                                 .driver     = {
+               .owner  = THIS_MODULE,
+               .name   = "i2c-pnx0105",
+       },
+};
+
+static int __init i2c_pnx0105_init(void)
+{
+       return platform_driver_register(&i2c_pnx0105_driver);
+}
+
+static void __exit i2c_pnx0105_cleanup(void)
+{
+       platform_driver_unregister(&i2c_pnx0105_driver);
+}
+
+module_init(i2c_pnx0105_init);
+module_exit(i2c_pnx0105_cleanup);
+
+MODULE_AUTHOR("Nikita Youshchenko <yoush@debian.org>");
+MODULE_DESCRIPTION("PNX833X I2C driver");
+MODULE_LICENSE("GPL");
+
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/drivers/i2c/busses/Kconfig
linux-2.6.26-rc4/drivers/i2c/busses/Kconfig
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/Kconfig    2008-06-03
10:56:53.000000000 +0100
+++ linux-2.6.26-rc4/drivers/i2c/busses/Kconfig 2008-06-04
09:29:35.000000000 +0100
@@ -677,6 +677,18 @@
         This driver can also be built as a module.  If so, the module
         will be called i2c-pnx.

+config I2C_PNX0105
+       tristate "I2C bus support for Philips PNX8XXX targets"
+       depends on I2C && SOC_PNX833X
+       select I2C_ALGOPCA
+       default y
+       help
+         Support for NXP PNX SoC internal I2C (IP0105).
+         Say y or m if you want to use PNX I2C interfaces.
+
+         This driver can also be built as a module.  If so, the module
+         will be called i2c-pnx0105.
+
 config I2C_PMCMSP
       tristate "PMC MSP I2C TWI Controller"
       depends on PMC_MSP
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/drivers/i2c/busses/Makefile
linux-2.6.26-rc4/drivers/i2c/busses/Makefile
--- linux-2.6.26-rc4.orig/drivers/i2c/busses/Makefile   2008-06-03
10:56:53.000000000 +0100
+++ linux-2.6.26-rc4/drivers/i2c/busses/Makefile        2008-06-04
09:29:40.000000000 +0100
@@ -34,6 +34,7 @@
 obj-$(CONFIG_I2C_PIIX4)                += i2c-piix4.o
 obj-$(CONFIG_I2C_PMCMSP)       += i2c-pmcmsp.o
 obj-$(CONFIG_I2C_PNX)          += i2c-pnx.o
+obj-$(CONFIG_I2C_PNX0105)      += i2c-pnx0105.o
 obj-$(CONFIG_I2C_PROSAVAGE)    += i2c-prosavage.o
 obj-$(CONFIG_I2C_PXA)          += i2c-pxa.o
 obj-$(CONFIG_I2C_S3C2410)      += i2c-s3c2410.o
diff -urN --exclude=.svn linux-2.6.26-rc4.orig/drivers/net/ip3902.c
linux-2.6.26-rc4/drivers/net/ip3902.c
--- linux-2.6.26-rc4.orig/drivers/net/ip3902.c  1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/drivers/net/ip3902.c       2008-06-05
11:27:28.000000000 +0100
@@ -0,0 +1,1534 @@
+/*
+ *  ip3902.c: NXP ip3902 embedded 10/100 Ethernet controller support
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
+ *
+ *  Based on ax88796.c, by Ben Dooks.
+ *     Based on previous ip3902.c by Nikita V. Youshchenko
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/isapnp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/crc32.h>
+#include <linux/inet_lro.h>
+#include <asm/system.h>
+#include <linux/io.h>
+
+#define DRVNAME "ip3902-eth"
+#define DRVVERSION "1.00"
+
+#define IP3902_NAPI
+
+/* "Strange hardware" support macros */
+
+/* These control endianness of descriptors and statuses.
+ * If none if LITTLE_ENDIAN_xxx and BIG_ENDIAN_xxx is defined, system endian
+ * is used for xxx */
+#define LITTLE_ENDIAN_DESCRIPTORS
+#undef BIG_ENDIAN_DESCRIPTORS
+#undef LITTLE_ENDIAN_STATUSES
+#define BIG_ENDIAN_STATUSES
+
+#define ETH_RX_SKB_SIZE        0x600   /* 1536 bytes, just over max mtu */
+#define TX_RING_SIZE           64
+#define RX_RING_SIZE           64
+#define IP3902_NAPI_WEIGHT     48
+#define MAX_LRO_DESCRIPTORS    6
+#define LRO_THRESHOLD          3
+
+#define BYTES_IN_ETHERNET_CRC   4
+#define MAX_DESCS_PER_SKB      (MAX_SKB_FRAGS + 1)
+
+#define NEXT_TX(i) (((i) == TX_RING_SIZE-1) ? 0 : (i)+1)
+#define NEXT_RX(i) (((i) == RX_RING_SIZE-1) ? 0 : (i)+1)
+
+/* Access to IP3902 registers */
+
+/* Alcatel (Packet Engines) core registers */
+#define MAC1_REG               0x000   /* R/W: MAC configuration register 1 */
+#define MAC2_REG               0x004   /* R/W: MAC configuration register 2 */
+#define IPGT_REG               0x008   /* R/W: Back-to-Back
Inter-Packet-Gap register */
+#define IPGR_REG               0x00c   /* R/W: Non Back-to-Back
Inter-Packet-Gap register */
+#define CLRT_REG               0x010   /* R/W: Collision window /
Retry register */
+#define MAXF_REG               0x014   /* R/W: Maximum Frame register */
+#define SUPP_REG               0x018   /* R/W: PHY Support register */
+#define TEST_REG               0x01C   /* R/W: Test register */
+#define MCFG_REG               0x020   /* R/W: MII Mgmt
Con???guration register */
+#define MCMD_REG               0x024   /* R/W: MII Mgmt Command register */
+#define MADR_REG               0x028   /* R/W: MII Mgmt Address register */
+#define MWTD_REG               0x02C   /* WO:  MII Mgmt Write Data register */
+#define MRDD_REG               0x030   /* RO:  MII Mgmt Read Data register */
+#define MIND_REG               0x034   /* RO:  MII Mgmt Indicators register */
+#define SA0_REG                        0x040   /* R/W: Station
Address 0 register */
+#define SA1_REG                        0x044   /* R/W: Station
Address 1 register */
+#define SA2_REG                        0x048   /* R/W: Station
Address 2 register */
+
+/* Control registers */
+#define COMMAND_REG            0x100   /* R/W: Command register */
+#define STATUS_REG             0x104   /* RO:  Status register */
+#define RX_DESC_REG            0x108   /* R/W: Receive descriptor
base address register */
+#define RX_STATUS_REG          0x10C   /* R/W: Receive status base
address register */
+#define RX_DESC_NUMBER_REG     0x110   /* R/W: Receive number of
descriptors register */
+#define RX_PRODUCE_INDEX_REG   0x114   /* RO:  Receive produce index
register */
+#define RX_CONSUME_INDEX_REG   0x118   /* R/W: Receive consume index
register */
+#define TX_DESC_REG            0x11C   /* R/W: Non real-time transmit
descriptor
base address register */
+#define TX_STATUS_REG          0x120   /* R/W: Non real-time transmit status
base address register */
+#define TX_DESC_NUMBER_REG     0x124   /* R/W: Non real-time transmit
number of descriptors register */
+#define TX_PRODUCE_INDEX_REG   0x128   /* R/W: Non real-time transmit
produce index register */
+#define TX_CONSUME_INDEX_REG   0x12C   /* RO:  Non real-time transmit
consume index register */
+#define TX_RT_DESC_REG         0x130   /* R/W: Real-time transmit descriptor
base address register */
+#define TX_RT_STATUS_REG       0x134   /* R/W: Real-time transmit status base
address register */
+#define TX_RT_DESC_NUMBER_REG  0x138   /* R/W: Real-time transmit number
of descriptors register */
+#define TX_RT_PRODUCE_INDEX_REG        0x13C   /* R/W: Real-time transmit
produce index register */
+#define TX_RT_CONSUME_INDEX_REG        0x140   /* RO:  Real-time transmit
consume index register */
+#define QOS_TIMEOUT_REG                0x148   /* R/W: Transmit
quality of service
time-out register */
+#define TSV0_REG               0x158   /* RO:  Transmit status vector
0 register */
+#define TSV1_REG               0x15C   /* RO:  Transmit status vector
1 register */
+#define RSV_REG                        0x160   /* RO:  Receive status
vector register */
+#define FC_COUNTER_REG         0x170   /* R/W: Flow control counter register */
+#define FC_STATUS_REG          0x174   /* RO:  Flow control status register */
+
+/* Rx filter registers */
+#define FILTER_CTRL_REG                0x200   /* R/W: Receive filter
control register */
+#define FILTER_WOL_STATUS_REG  0x204   /* RO:  Receive filter WoL status
register */
+#define FILTER_WOL_CLEAR_REG   0x208   /* WO:  Receive filter WoL
clear register */
+#define HASH_FILTER_L_REG      0x210   /* R/W: Hash filter table LSBs
register */
+#define HASH_FILTER_H_REG      0x214   /* R/W: Hash filter table MSBs
register */
+
+/* DVP Standard registers */
+#define INT_STATUS_REG         0xFE0   /* RO:  Interrupt status register */
+#define INT_ENABLE_REG         0xFE4   /* R/W: Interrupt enable register */
+#define INT_CLEAR_REG          0xFE8   /* WO:  Interrupt clear register */
+#define INT_SET_REG            0xFEC   /* WO:  Interrupt set register */
+#define POWERDOWN_REG          0xFF4   /* R/W: Power-down register */
+#define MODULE_ID_REG          0xFFC   /* RO:  Module ID register */
+
+/* Bits for MAC1 register */
+#define MAC1_SOFT_RESET                (1 << 15)
+#define MAC1_TX_FLOW_CONTROL   (1 << 3)
+#define MAC1_RX_FLOW_CONTROL   (1 << 2)
+#define MAC1_RECEIVE_PASS_ALL  (1 << 1)
+#define MAC1_RECEIVE_ENABLE    (1 << 0)
+
+/* Bits for MAC2 register */
+#define MAC2_AUTO_DETECT_PAD_ENABLE    (1 << 7)
+#define MAC2_VLAN_PAD_ENABLE           (1 << 6)
+#define MAC2_PAD_CRC_ENABLE            (1 << 5)
+#define MAC2_CRC_ENABLE                        (1 << 4)
+#define MAC2_FULL_DUPLEX               (1 << 0)
+
+#define INITIAL_MAC2   (MAC2_AUTO_DETECT_PAD_ENABLE |
MAC2_VLAN_PAD_ENABLE | MAC2_PAD_CRC_ENABLE | MAC2_CRC_ENABLE)
+
+/* Recommended values for IPGT register (see sec. 3.3.2.3 0f datasheet */
+#define IPGT_FD_VALUE  0x15
+#define IPGT_HD_VALUE  0x12
+
+/* Bits for MCMD register */
+#define MCMD_READ              (1 << 0)
+
+/* Bits for MIND register */
+#define MIND_NOT_VALID         (1 << 2)
+#define MIND_BUSY              (1 << 0)
+
+/* Bits for command register */
+#define COMMAND_ENABLE_QOS     (1 << 11)
+#define COMMAND_FULL_DUPLEX    (1 << 10)
+#define COMMAND_RMII_MODE      (1 << 9)
+#define COMMAND_TX_FLOW_CONTROL        (1 << 8)
+#define COMMAND_PROMISC                (1 << 7)
+#define COMMAND_ALLOW_SHORT    (1 << 6)
+#define COMMAND_RX_RESET       (1 << 5)
+#define COMMAND_TX_RESET       (1 << 4)
+#define COMMAND_RESET          (1 << 3)
+#define COMMAND_TX_RT_ENABLE   (1 << 2)
+#define COMMAND_TX_ENABLE      (1 << 1)
+#define COMMAND_RX_ENABLE      (1 << 0)
+
+/* Bits for receive filter control register */
+#define FILTER_ACCEPT_SELF             (1 << 5)
+#define FILTER_ACCEPT_MCAST_HASH       (1 << 4)
+#define FILTER_ACCEPT_UCAST_HASH       (1 << 3)
+#define FILTER_ACCEPT_MCAST_ANY                (1 << 2)
+#define FILTER_ACCEPT_BCAST_ANY                (1 << 1)
+#define FILTER_ACCEPT_UCAST_ANY                (1 << 0)
+
+/* Bits for interrupt registers */
+#define WAKEUP_INT             (1 << 13)
+#define SOFT_INT               (1 << 12)
+#define TX_RT_DONE_INT         (1 << 11)
+#define TX_RT_FINISHED_INT     (1 << 10)
+#define TX_RT_ERROR_INT                (1 << 9)
+#define TX_RT_UNDERRUN_INT     (1 << 8)
+#define TX_DONE_INT            (1 << 7)
+#define TX_FINISHED_INT                (1 << 6)
+#define TX_ERROR_INT           (1 << 5)
+#define TX_UNDERRUN_INT                (1 << 4)
+#define RX_DONE_INT            (1 << 3)
+#define RX_FINISHED_INT                (1 << 2)
+#define RX_ERROR_INT           (1 << 1)
+#define RX_OVERRUN_INT         (1 << 0)
+
+/* Bit for POWERDOWN register */
+#define POWERDOWN_VALUE                (1 << 31)
+
+/* Bits for TX control */
+#define TX_CONTROL_INT         (1 << 31)
+#define TX_CONTROL_LAST                (1 << 30)
+#define TX_CONTROL_CRC         (1 << 29)
+#define TX_CONTROL_PAD         (1 << 28)
+#define TX_CONTROL_HUGE                (1 << 27)
+#define TX_CONTROL_OVERRIDE    (1 << 26)
+
+/* these flags used for non-last fragment of a frame */
+#define TX_CONTROL_ALL_NOTLAST (TX_CONTROL_CRC | TX_CONTROL_PAD |
TX_CONTROL_OVERRIDE)
+/* these flags used for last fragment of a frame, and for single-fragment
+ * frames */
+#define TX_CONTROL_ALL_LAST    (TX_CONTROL_ALL_NOTLAST | TX_CONTROL_LAST
| TX_CONTROL_INT)
+
+/* Bits for TX status */
+#define TX_STATUS_ERROR                        (1 << 31)
+#define TX_STATUS_UNDERRUN             (1 << 29)
+#define TX_STATUS_LATE_COLLISION       (1 << 28)
+#define TX_STATUS_MANY_COLLISIONS      (1 << 27)
+#define TX_STATUS_MANY_DEFER           (1 << 26)
+#define TX_STATUS_COLLISIONS(s)        ((s >> 21) & 15)
+
+/* Bits for RX control */
+#define RX_CONTROL_INT         (1 << 31)
+
+/* Bits for RX status */
+#define RX_STATUS_ERROR                        (1 << 31)
+#define RX_STATUS_LAST_FRAG            (1 << 30)
+#define RX_STATUS_OVERRUN              (1 << 28)
+#define RX_STATUS_ALIGNMENT_ERROR      (1 << 27)
+#define RX_STATUS_RANGE_ERROR          (1 << 26)
+#define RX_STATUS_LENGTH_ERROR         (1 << 25)
+#define RX_STATUS_SYMBOL_ERROR         (1 << 24)
+#define RX_STATUS_CRC_ERROR            (1 << 23)
+#define RX_STATUS_BROADCAST            (1 << 22)
+#define RX_STATUS_MULTICAST            (1 << 21)
+#define RX_STATUS_FAIL_FILTER          (1 << 20)
+#define RX_STATUS_VLAN                 (1 << 19)
+#define RX_STATUS_CONTROL_FRAME                (1 << 18)
+#define RX_STATUS_LENGTH(s)            ((s & 0x7ff) + 1)
+
+/* Bits for RSV register */
+#define RSV_VLAN                       (1 << 30)
+#define RSV_CONTROL_FRAME              (1 << 27)
+#define RSV_DRIBBLE_NIBBLE             (1 << 26)
+#define RSV_BROADCAST                  (1 << 25)
+#define RSV_MULTICAST                  (1 << 24)
+#define RSV_LENGTH_OUT_OF_RANGE                (1 << 22)
+#define RSV_LENGTH_CHECK_ERROR         (1 << 21)
+#define RSV_CRC_ERROR                  (1 << 20)
+#define RSV_RECEIVE_CODE_VIOLATION     (1 << 19)
+#define RSV_MASK                       0xFFFF
+
+static char *mac_address;
+module_param(mac_address, charp, S_IRUGO);
+MODULE_PARM_DESC(mac_address, "MAC address of the device");
+
+
+/* device private data */
+struct ip3902_descriptor {
+       unsigned long address;
+       unsigned long control;
+};
+
+struct ip3902_rx_status {
+       unsigned long status;
+       unsigned long hash_crc;
+};
+
+struct ip3902_dma_struct {
+       struct ip3902_descriptor rx_desc[RX_RING_SIZE];
+       struct ip3902_rx_status rx_status[RX_RING_SIZE];
+       struct ip3902_descriptor tx_desc[TX_RING_SIZE];
+       unsigned long tx_status[TX_RING_SIZE];
+};
+
+struct ip3902_private {
+       spinlock_t      mii_lock;
+       struct mii_if_info  mii;
+       u32         msg_enable;
+
+       spinlock_t      lock;
+       struct net_device   *ndev;
+       struct platform_device  *pdev;
+       struct resource     *bus;
+       void __iomem        *mem;
+#ifdef IP3902_NAPI
+       struct napi_struct napi;
+#endif
+
+       struct ip3902_dma_struct *ds;           /* descriptors and statuses */
+       dma_addr_t ds_dma;
+
+       struct sk_buff *rx_skb[RX_RING_SIZE];   /* where to recieve to */
+       struct sk_buff *tx_skb[TX_RING_SIZE];   /* where to send from */
+       bool tx_first_desc[TX_RING_SIZE];       /* true if this is the
first desc
of an skb */
+
+       int rx_next_allocate;                   /* index in rx ring
where skb should be allocated */
+       int rx_next_consume;                    /* index in rx ring
where data should be read
when available */
+       int tx_next_produce;                    /* index in tx ring
where new data should be put */
+       int tx_next_deallocate;                 /* index in tx ring of
first not freed skb */
+
+#ifdef CONFIG_INET_LRO
+       bool                use_lro;
+       int                 lro_count;
+       struct net_lro_mgr  lro_mgr;
+       struct net_lro_desc lro_desc[MAX_LRO_DESCRIPTORS];
+       struct timer_list   lro_timer;
+#endif
+
+       unsigned char running;
+       unsigned char resume_open;
+
+};
+
+static inline unsigned long ip3902_read_reg(struct net_device *ndev, int reg)
+{
+       unsigned long value = readl((void * __iomem)(ndev->base_addr + reg));
+       return value;
+}
+
+static inline void ip3902_write_reg(struct net_device *ndev, int reg,
+
 unsigned long val)
+{
+       writel(val, (void * __iomem)(ndev->base_addr + reg));
+}
+
+static inline void ip3902_write_tx_desc(struct ip3902_private
*ip3902_priv, int pos, unsigned long address, unsigned long control)
+{
+#if defined(BIG_ENDIAN_DESCRIPTORS)
+       ip3902_priv->ds->tx_desc[pos].address = cpu_to_be32(address);
+       ip3902_priv->ds->tx_desc[pos].control = cpu_to_be32(control);
+#elif defined(LITTLE_ENDIAN_DESCRIPTORS)
+       ip3902_priv->ds->tx_desc[pos].address = cpu_to_le32(address);
+       ip3902_priv->ds->tx_desc[pos].control = cpu_to_le32(control);
+#else
+       ip3902_priv->ds->tx_desc[pos].address = address;
+       ip3902_priv->ds->tx_desc[pos].control = control;
+#endif
+       wmb();
+}
+
+static inline void ip3902_read_tx_desc(struct ip3902_private
*ip3902_priv, int pos, dma_addr_t *address, int *length)
+{
+#if defined(BIG_ENDIAN_DESCRIPTORS)
+       *address =
(dma_addr_t)be32_to_cpu(ip3902_priv->ds->tx_desc[pos].address);
+       *length  =
(int)be32_to_cpu(ip3902_priv->ds->tx_desc[pos].control) & 0xffff;
+#elif defined(LITTLE_ENDIAN_DESCRIPTORS)
+       *address =
(dma_addr_t)le32_to_cpu(ip3902_priv->ds->tx_desc[pos].address);
+       *length  =
(int)le32_to_cpu(ip3902_priv->ds->tx_desc[pos].control) & 0xffff;
+#else
+       *address = (dma_addr_t)ip3902_priv->ds->tx_desc[pos].address;
+       *length  = (int)ip3902_priv->ds->tx_desc[pos].control & 0xffff;
+#endif
+}
+
+static inline unsigned long ip3902_read_tx_status(struct
ip3902_private *ip3902_priv, int pos)
+{
+#if defined(BIG_ENDIAN_STATUSES)
+       return be32_to_cpu(ip3902_priv->ds->tx_status[pos]);
+#elif defined(LITTLE_ENDIAN_STATUSES)
+       return le32_to_cpu(ip3902_priv->ds->tx_status[pos]);
+#else
+       return ip3902_priv->ds->tx_status[pos];
+#endif
+}
+
+static inline void ip3902_write_rx_desc(struct ip3902_private
*ip3902_priv, int pos, unsigned long address, unsigned long control)
+{
+#if defined(BIG_ENDIAN_DESCRIPTORS)
+       ip3902_priv->ds->rx_desc[pos].address = cpu_to_be32(address);
+       ip3902_priv->ds->rx_desc[pos].control = cpu_to_be32(control);
+#elif defined(LITTLE_ENDIAN_DESCRIPTORS)
+       ip3902_priv->ds->rx_desc[pos].address = cpu_to_le32(address);
+       ip3902_priv->ds->rx_desc[pos].control = cpu_to_le32(control);
+#else
+       ip3902_priv->ds->rx_desc[pos].address = address;
+       ip3902_priv->ds->rx_desc[pos].control = control;
+#endif
+       wmb();
+}
+
+static inline void ip3902_read_rx_desc(struct ip3902_private
*ip3902_priv, int pos, dma_addr_t *address, int *length)
+{
+#if defined(BIG_ENDIAN_DESCRIPTORS)
+       *address =
(dma_addr_t)be32_to_cpu(ip3902_priv->ds->rx_desc[pos].address);
+       *length  =
(int)be32_to_cpu(ip3902_priv->ds->rx_desc[pos].control) & 0xffff;
+#elif defined(LITTLE_ENDIAN_DESCRIPTORS)
+       *address =
(dma_addr_t)le32_to_cpu(ip3902_priv->ds->rx_desc[pos].address);
+       *length  =
(int)le32_to_cpu(ip3902_priv->ds->rx_desc[pos].control) & 0xffff;
+#else
+       *address = (dma_addr_t)ip3902_priv->ds->rx_desc[pos].address;
+       *length  = (int)ip3902_priv->ds->rx_desc[pos].control & 0xffff;
+#endif
+}
+
+static inline unsigned long ip3902_read_rx_status(struct net_device
*ndev, struct ip3902_private *ip3902_priv, int pos)
+{
+#if defined(BIG_ENDIAN_STATUSES)
+       return be32_to_cpu(ip3902_priv->ds->rx_status[pos].status);
+#elif defined(LITTLE_ENDIAN_STATUSES)
+       return le32_to_cpu(ip3902_priv->ds->rx_status[pos].status);
+#else
+       return ip3902_priv->ds->rx_status[pos].status;
+#endif
+}
+
+static inline void ip3902_write_madr_reg(struct net_device *ndev, int
phy_id, int location)
+{
+       /* assume ranges of phy_id and location are correct - we set masks in
+        * struct mii_if_info for that */
+
+       unsigned long val = (phy_id << 8) | location;
+       ip3902_write_reg(ndev, MADR_REG, val);
+}
+
+static inline int ip3902_wait_mdio_op_complete(struct net_device
*ndev, unsigned long mask)
+{
+       int timeout = 10000;            /* to avoid hangup in case of
unexpected badness ... */
+
+       while (--timeout > 0) {
+               if ((ip3902_read_reg(ndev, MIND_REG) & mask) == 0)
+                       return 0;
+               udelay(1);
+       }
+
+       return -EIO;
+}
+
+static int ip3902_mdio_read(struct net_device *ndev, int phy_id, int location)
+{
+       ip3902_write_madr_reg(ndev, phy_id, location);
+       ip3902_write_reg(ndev, MCMD_REG, 0);
+       ip3902_write_reg(ndev, MCMD_REG, MCMD_READ);
+       if (ip3902_wait_mdio_op_complete(ndev, MIND_NOT_VALID | MIND_BUSY) < 0)
+               return 0;
+       else
+               return ip3902_read_reg(ndev, MRDD_REG) & 0xffff;
+}
+
+static void ip3902_mdio_write(struct net_device *ndev, int phy_id,
int location, int val)
+{
+       ip3902_write_madr_reg(ndev, phy_id, location);
+       ip3902_write_reg(ndev, MWTD_REG, val & 0xffff);
+       ip3902_wait_mdio_op_complete(ndev, MIND_BUSY);
+}
+
+static inline int ip3902_nr_free_descs(int head, int tail, int size)
+{
+       int free;
+
+       if (head >= tail)
+               free = (tail + size) - head;
+       else
+               free = tail - head;
+
+       return free;
+}
+
+static void ip3902_eth_rx_refill_descs(struct net_device *ndev,
struct ip3902_private *ip3902_priv)
+{
+       do {
+               int rx_index = ip3902_priv->rx_next_allocate;
+               struct sk_buff *skb = netdev_alloc_skb(ndev, ETH_RX_SKB_SIZE +
dma_get_cache_alignment());
+
+               if (skb) {
+                       int unaligned = (((u32)skb->data) + ETH_HLEN) &
(dma_get_cache_alignment() - 1);
+                       unsigned long desc_address;
+
+                       if (unaligned)
+                               skb_reserve(skb,
(dma_get_cache_alignment() - unaligned));
+
+                       desc_address = dma_map_single(NULL, skb->data,
ETH_RX_SKB_SIZE,
DMA_FROM_DEVICE);
+                       ip3902_write_rx_desc(ip3902_priv, rx_index,
desc_address,
(ETH_RX_SKB_SIZE - 1) | RX_CONTROL_INT);
+
+                       ip3902_priv->rx_skb[rx_index] = skb;
+                       ip3902_priv->rx_next_allocate = NEXT_RX(rx_index);
+               } else {
+                       ip3902_write_reg(ndev, RX_CONSUME_INDEX_REG,
ip3902_priv->rx_next_allocate);
+                       return;
+               }
+       } while (ip3902_priv->rx_next_allocate != ip3902_priv->rx_next_consume);
+
+       ip3902_write_reg(ndev, RX_CONSUME_INDEX_REG,
ip3902_priv->rx_next_allocate);
+}
+
+static int ip3902_eth_receive_queue(struct net_device *ndev, struct
ip3902_private *ip3902_priv, int budget)
+{
+       int rx_index    = ip3902_priv->rx_next_consume;
+       int write_index = ip3902_read_reg(ndev, RX_PRODUCE_INDEX_REG);
+       int received = 0;
+       int limit;
+
+       do {
+               limit = write_index;
+               spin_lock(&ip3902_priv->lock);
+               while (rx_index != limit) {
+                       unsigned long status =
ip3902_read_rx_status(ndev, ip3902_priv, rx_index);
+
+                       if (!(status & RX_STATUS_LAST_FRAG)) {
+                               printk(DRVNAME ": broken RX status:
%08lx\n", status);
+                               continue;
+                       }
+
+                       if (status & RX_STATUS_FAIL_FILTER)
+                               continue;
+
+                       /* Looks like hardware returns RANGE_ERROR for
each frame */
+                       if (status & (RX_STATUS_OVERRUN |
RX_STATUS_ALIGNMENT_ERROR |
RX_STATUS_LENGTH_ERROR | RX_STATUS_CRC_ERROR)) {
+                               ndev->stats.rx_errors++;
+
+                               if (status & RX_STATUS_OVERRUN)
+                                       ndev->stats.rx_fifo_errors++;
+
+                               if (status & RX_STATUS_ALIGNMENT_ERROR)
+                                       ndev->stats.rx_frame_errors++;
+
+                               if (status & (RX_STATUS_RANGE_ERROR |
RX_STATUS_LENGTH_ERROR))
+                                       ndev->stats.rx_length_errors++;
+
+                               if (status & RX_STATUS_CRC_ERROR)
+                                       ndev->stats.rx_crc_errors++;
+
+                       } else {
+                               if (--budget < 0) {
+                                       /* we got packets, but no quota */
+                                       /* store current ring pointer state */
+                                       ip3902_priv->rx_next_consume = rx_index;
+                                       return received;
+                               } else {
+                                       struct sk_buff *skb    =
ip3902_priv->rx_skb[rx_index];
+                                       int             length =
RX_STATUS_LENGTH(status);
+                                       dma_addr_t      data_addr;
+                                       int             data_length;
+
+                                       ndev->stats.rx_packets++;
+                                       ndev->stats.rx_bytes += length;
+                                       if (status & RX_STATUS_MULTICAST)
+                                               ndev->stats.multicast++;
+
+                                       skb_put(skb, length -
BYTES_IN_ETHERNET_CRC);
+                                       skb->protocol =
eth_type_trans(skb, ndev);
+
+#ifdef CONFIG_INET_LRO
+                                       if (ip3902_priv->use_lro)
+
lro_receive_skb(&ip3902_priv->lro_mgr, skb, ip3902_priv);
+                                       else
+                                               netif_receive_skb(skb);
+
+                                       ip3902_priv->lro_count++;
+#else
+#ifdef IP3902_NAPI
+                                       netif_receive_skb(skb);
+#else
+                                       netif_rx(skb);
+#endif
+#endif
+
+
ip3902_read_rx_desc(ip3902_priv, rx_index, &data_addr, &data_length);
+                                       dma_unmap_single(NULL,
data_addr, ETH_RX_SKB_SIZE, DMA_FROM_DEVICE);
+
+                                       ip3902_priv->rx_skb[rx_index] = NULL;
+                                       ndev->last_rx = jiffies;
+                                       received++;
+                               }
+                       }
+                       rx_index = NEXT_RX(rx_index);
+               }
+
+               spin_unlock(&ip3902_priv->lock);
+               ip3902_priv->rx_next_consume = rx_index;
+               ip3902_eth_rx_refill_descs(ndev, ip3902_priv);
+               write_index = ip3902_read_reg(ndev, RX_PRODUCE_INDEX_REG);
+       } while (limit != write_index);
+
+#ifdef CONFIG_INET_LRO
+       if (ip3902_priv->use_lro) {
+               if (timer_pending(&ip3902_priv->lro_timer)) {
+                       mod_timer(&ip3902_priv->lro_timer, jiffies + 2);
+               } else {
+                       ip3902_priv->lro_timer.expires  = jiffies + 2;
+                       add_timer(&ip3902_priv->lro_timer);
+               }
+       }
+#endif
+
+       return received;
+}
+
+#ifdef IP3902_NAPI
+static int ip3902_poll(struct napi_struct *napi, int budget)
+{
+       struct ip3902_private *ip3902_priv = container_of(napi, struct
ip3902_private, napi);
+       struct net_device *ndev = ip3902_priv->ndev;
+       int work_done;
+
+       work_done = ip3902_eth_receive_queue(ndev, ip3902_priv, budget);
+
+       if (work_done < budget) {
+               ip3902_write_reg(ndev, INT_CLEAR_REG, RX_DONE_INT);
+               ip3902_write_reg(ndev, INT_CLEAR_REG, 0);
+               netif_rx_complete(ndev, napi);
+               ip3902_write_reg(ndev, INT_ENABLE_REG, (TX_UNDERRUN_INT |
RX_DONE_INT | RX_OVERRUN_INT));
+       }
+
+       return work_done;
+}
+#endif
+
+#ifdef CONFIG_INET_LRO
+static void ip3902_lro_timeout(unsigned long data)
+{
+       struct ip3902_private *ip3902_priv = (struct ip3902_private *)data;
+
+       spin_lock(&ip3902_priv->lock);
+       if (ip3902_priv->lro_count <= LRO_THRESHOLD) {
+               ip3902_priv->use_lro = false;
+               ip3902_priv->lro_count = 0;
+       }
+       lro_flush_all(&ip3902_priv->lro_mgr);
+       spin_unlock(&ip3902_priv->lock);
+}
+#endif
+
+#define ip3902_eth_free_completed_tx_descs(ndev, priv)
ip3902_eth_free_tx_descs(ndev, priv, 0)
+#define ip3902_eth_free_all_tx_descs(ndev, priv)
ip3902_eth_free_tx_descs(ndev, priv, 1)
+
+static void ip3902_eth_free_tx_descs(struct net_device *ndev, struct
ip3902_private *ip3902_priv, int force)
+{
+       int limit;
+
+       if (force)
+               limit = ip3902_priv->tx_next_produce;
+       else
+               limit = ip3902_read_reg(ndev, TX_CONSUME_INDEX_REG);
+
+       while (ip3902_priv->tx_next_deallocate != limit) {
+               int             length;
+               int             tx_index;
+               unsigned long   status;
+               dma_addr_t      addr;
+               struct sk_buff *skb;
+
+               tx_index = ip3902_priv->tx_next_deallocate;
+
+               ip3902_priv->tx_next_deallocate = NEXT_TX(tx_index);
+               ip3902_read_tx_desc(ip3902_priv, tx_index, &addr, &length);
+               skb = ip3902_priv->tx_skb[tx_index];
+
+               status = ip3902_read_tx_status(ip3902_priv, tx_index);
+               if (status & TX_STATUS_ERROR) {
+                       ndev->stats.tx_errors++;
+                       if (status & TX_STATUS_LATE_COLLISION)
+                               ndev->stats.tx_aborted_errors++;
+
+                       if (status & (TX_STATUS_MANY_COLLISIONS |
TX_STATUS_MANY_DEFER))
+                               ndev->stats.tx_window_errors++;
+
+               } else {
+                       ndev->stats.tx_packets++;
+                       ndev->stats.tx_bytes   += skb->len;
+                       ndev->stats.collisions += TX_STATUS_COLLISIONS(status);
+               }
+
+               if (skb)
+                       ip3902_priv->tx_skb[tx_index] = NULL;
+
+               if (ip3902_priv->tx_first_desc[tx_index] == true)
+                       dma_unmap_single(NULL, addr, length, DMA_TO_DEVICE);
+               else
+                       dma_unmap_page(NULL, addr, length, DMA_TO_DEVICE);
+
+               if (skb)
+                       dev_kfree_skb_irq(skb);
+       }
+}
+
+static void ip3902_reset_tx(struct net_device *ndev, struct
ip3902_private *ip3902_priv, int initial)
+{
+       unsigned long val;
+
+       /* Reset Tx hardware */
+       val = ip3902_read_reg(ndev, COMMAND_REG);
+       val &= ~(COMMAND_TX_RT_ENABLE | COMMAND_TX_ENABLE);
+       val |= COMMAND_TX_RESET;
+       ip3902_write_reg(ndev, COMMAND_REG, val);
+
+       if (!initial)
+               ip3902_eth_free_all_tx_descs(ndev, ip3902_priv);
+
+       ip3902_priv->tx_next_produce    = 0;
+       ip3902_priv->tx_next_deallocate = 0;
+
+       /* Configure Tx registers */
+       ip3902_write_reg(ndev, TX_DESC_REG,   ip3902_priv->ds_dma +
offsetof(struct ip3902_dma_struct, tx_desc));
+       ip3902_write_reg(ndev, TX_STATUS_REG, ip3902_priv->ds_dma +
offsetof(struct ip3902_dma_struct, tx_status));
+       ip3902_write_reg(ndev, TX_DESC_NUMBER_REG, TX_RING_SIZE - 1);
+       ip3902_write_reg(ndev, TX_PRODUCE_INDEX_REG,
ip3902_priv->tx_next_produce);
+       ip3902_write_reg(ndev, TX_CONSUME_INDEX_REG,
ip3902_priv->tx_next_deallocate);
+}
+
+static void ip3902_reset_rx(struct net_device *ndev, struct
ip3902_private *ip3902_priv, int init)
+{
+       unsigned long val;
+
+       /* Reset Rx hardware */
+       val = ip3902_read_reg(ndev, COMMAND_REG);
+       val &= ~COMMAND_RX_ENABLE;
+       val |= COMMAND_RX_RESET;
+       ip3902_write_reg(ndev, COMMAND_REG, val);
+
+       /* Set maximum frame size register */
+       ip3902_write_reg(ndev, MAXF_REG, ETH_RX_SKB_SIZE);
+
+       if (init) {
+               ip3902_priv->rx_next_allocate   = 0;
+               ip3902_priv->rx_next_consume    = 0;
+               ip3902_eth_rx_refill_descs(ndev, ip3902_priv);
+       }
+
+       /* Prepare skb's for Rx (any skb's already prepared will be reused)
+        * and configure Rx registers */
+       ip3902_write_reg(ndev, RX_DESC_REG, ip3902_priv->ds_dma +
offsetof(struct ip3902_dma_struct, rx_desc));
+       ip3902_write_reg(ndev, RX_STATUS_REG, ip3902_priv->ds_dma +
offsetof(struct ip3902_dma_struct, rx_status));
+       ip3902_write_reg(ndev, RX_DESC_NUMBER_REG, RX_RING_SIZE - 1);
+       ip3902_write_reg(ndev, RX_PRODUCE_INDEX_REG,
ip3902_priv->rx_next_consume);
+}
+
+static inline void ip3902_start_tx(struct net_device *ndev)
+{
+       unsigned long val;
+
+       val = ip3902_read_reg(ndev, COMMAND_REG);
+       val |= COMMAND_TX_ENABLE;
+       ip3902_write_reg(ndev, COMMAND_REG, val);
+}
+
+static inline void ip3902_start_rx(struct net_device *ndev)
+{
+       unsigned long val;
+
+       /* First on high-level ... */
+       val = ip3902_read_reg(ndev, COMMAND_REG);
+       val |= (COMMAND_RX_ENABLE | COMMAND_ALLOW_SHORT);
+       ip3902_write_reg(ndev, COMMAND_REG, val);
+
+       /* ... and then on low-level (after high level is ready to receive) */
+       val = ip3902_read_reg(ndev, MAC1_REG);
+       val |= MAC1_RECEIVE_ENABLE;     /* flow control frames won't be passed
to driver */
+       ip3902_write_reg(ndev, MAC1_REG, val);
+}
+
+/* Interrupt handler body - split out to use both in interrupt handler
+ * and in net poll controller.
+ *
+ * Internal routine, called with lock held. */
+static void ip3902_do_handle_interrupt(struct net_device *ndev,
struct ip3902_private *ip3902_priv, unsigned long status)
+{
+       ip3902_write_reg(ndev, INT_CLEAR_REG, status);
+       ip3902_write_reg(ndev, INT_CLEAR_REG, 0);
+
+       if (status & TX_UNDERRUN_INT) {
+               printk(KERN_ERR DRVNAME ": %s: fatal Tx underrun,
resetting Tx\n",
ndev->name);
+               ip3902_reset_tx(ndev, ip3902_priv, 0);
+               ip3902_start_tx(ndev);
+       }
+
+       if (status & RX_OVERRUN_INT) {
+               printk(KERN_ERR DRVNAME ": %s: fatal Rx overrun,
resetting Rx\n",
ndev->name);
+               ip3902_reset_rx(ndev, ip3902_priv, 0);
+               ip3902_start_rx(ndev);
+       } else if (status & RX_DONE_INT) {
+#ifdef IP3902_NAPI
+               /* Disable the Rx interrupt */
+               ip3902_write_reg(ndev, INT_ENABLE_REG, (RX_OVERRUN_INT
| TX_UNDERRUN_INT));
+               netif_rx_schedule(ndev, &ip3902_priv->napi);
+#else
+               ip3902_eth_receive_queue(ndev, ip3902_priv, RX_RING_SIZE);
+#endif
+       }
+}
+
+static irqreturn_t ip3902_interrupt(int irq, void *dev_instance)
+{
+       struct net_device *ndev = (struct net_device *) dev_instance;
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       unsigned long status;
+
+       status = ip3902_read_reg(ndev, INT_STATUS_REG) & (TX_DONE_INT |
TX_UNDERRUN_INT | RX_DONE_INT | RX_OVERRUN_INT);
+       do {
+               if (!status) {
+                       return IRQ_NONE;
+               } else {
+                       ip3902_do_handle_interrupt(ndev, ip3902_priv, status);
+                       status = ip3902_read_reg(ndev, INT_STATUS_REG)
& (TX_DONE_INT |
TX_UNDERRUN_INT | RX_DONE_INT | RX_OVERRUN_INT);
+               }
+       } while (status);
+
+       return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void ip3902_net_poll(struct net_device *ndev)
+{
+       disable_irq_lockdep(ndev->irq);
+       ip3902_interrupt(ndev->irq, ndev);
+       enable_irq_lockdep(ndev->irq);
+}
+#endif
+
+static int eth_alloc_tx_desc_index(struct ip3902_private *ip3902_priv)
+{
+       int tx_desc_curr;
+
+       tx_desc_curr = ip3902_priv->tx_next_produce;
+       ip3902_priv->tx_next_produce = NEXT_TX(tx_desc_curr);
+
+       return tx_desc_curr;
+}
+
+static void eth_tx_fill_frag_descs(struct ip3902_private
*ip3902_priv, struct sk_buff *skb)
+{
+       int frag = 0;
+       int tx_index;
+
+       do {
+               skb_frag_t   *this_frag = &skb_shinfo(skb)->frags[frag];
+               unsigned long desc_address;
+               unsigned long desc_control;
+
+               tx_index = eth_alloc_tx_desc_index(ip3902_priv);
+
+               if (frag == (skb_shinfo(skb)->nr_frags - 1)) {
+                       desc_control = (this_frag->size - 1) |
TX_CONTROL_ALL_NOTLAST;
+                       ip3902_priv->tx_skb[tx_index] = skb;
+               } else {
+                       desc_control = (this_frag->size - 1) |
TX_CONTROL_ALL_LAST;
+                       ip3902_priv->tx_skb[tx_index] = NULL;
+               }
+
+               ip3902_priv->tx_first_desc[tx_index] = false;
+               desc_address = dma_map_page(NULL, this_frag->page,
+
 this_frag->page_offset,
+
 this_frag->size,
+
 DMA_TO_DEVICE);
+               ip3902_write_tx_desc(ip3902_priv, tx_index,
desc_address, desc_control);
+       } while (++frag < skb_shinfo(skb)->nr_frags);
+}
+
+static int ip3902_submit_skb_for_tx(struct net_device *ndev, struct
sk_buff *skb)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       int nr_frags;
+       int free_desc;
+       int ret = 0;
+
+#ifdef CONFIG_INET_LRO
+       if (ip3902_priv->lro_count > LRO_THRESHOLD)
+               ip3902_priv->use_lro = true;
+
+       ip3902_priv->lro_count = 0;
+#endif
+
+       free_desc = ip3902_nr_free_descs(ip3902_priv->tx_next_produce,
ip3902_priv->tx_next_deallocate, TX_RING_SIZE);
+       nr_frags  = skb_shinfo(skb)->nr_frags;
+
+       if (free_desc <= nr_frags) {
+               ip3902_eth_free_completed_tx_descs(ndev, ip3902_priv);
+               free_desc = ip3902_nr_free_descs(ip3902_priv->tx_next_produce,
ip3902_priv->tx_next_deallocate, TX_RING_SIZE);
+       }
+
+       if (free_desc > nr_frags) {
+               unsigned long desc_address;
+               unsigned long desc_control;
+               int tx_index;
+               int length;
+
+               tx_index = eth_alloc_tx_desc_index(ip3902_priv);
+
+               if (nr_frags) {
+                       eth_tx_fill_frag_descs(ip3902_priv, skb);
+                       length = skb_headlen(skb);
+                       desc_control = (length - 1) | TX_CONTROL_ALL_NOTLAST;
+                       ip3902_priv->tx_skb[tx_index] = NULL;
+               } else {
+                       length = skb->len;
+                       desc_control = (length - 1) | TX_CONTROL_ALL_LAST;
+                       ip3902_priv->tx_skb[tx_index] = skb;
+               }
+
+               ip3902_priv->tx_first_desc[tx_index] = true;
+               desc_address  = dma_map_single(NULL, skb->data,
length, DMA_TO_DEVICE);
+
+               ip3902_write_tx_desc(ip3902_priv, tx_index,
desc_address, desc_control);
+               ip3902_write_reg(ndev, TX_PRODUCE_INDEX_REG,
ip3902_priv->tx_next_produce);
+               ip3902_eth_free_completed_tx_descs(ndev, ip3902_priv);
+       } else {
+               ret = -ENOMEM;
+       }
+
+       return ret;
+}
+
+static int ip3902_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+       int ret;
+
+       BUG_ON(netif_queue_stopped(ndev));
+       BUG_ON(skb == NULL);
+       ret = ip3902_submit_skb_for_tx(ndev, skb);
+
+       if (ret) {
+               printk(KERN_ERR "%s: transmit with queue full\n", ndev->name);
+               netif_stop_queue(ndev);
+       } else {
+               ndev->stats.tx_bytes += skb->len;
+               ndev->stats.tx_packets++;
+               ndev->trans_start = jiffies;
+       }
+
+       return ret;             /* success */
+}
+
+static void ip3902_do_set_rx_filter(struct net_device *ndev, struct
ip3902_private *ip3902_priv)
+{
+       unsigned long creg, freg;
+
+       creg = ip3902_read_reg(ndev, COMMAND_REG);
+       if (ndev->flags & IFF_PROMISC) {
+               /* If interface is in promiscuous mode, just disable filter */
+               ip3902_write_reg(ndev, COMMAND_REG, creg | COMMAND_PROMISC);
+               return;
+       }
+       /* Enable filter */
+       ip3902_write_reg(ndev, COMMAND_REG, creg & ~COMMAND_PROMISC);
+
+       /* Frames for self address and broadcast frames are always accepted */
+       freg = FILTER_ACCEPT_SELF | FILTER_ACCEPT_BCAST_ANY;
+
+       if (ndev->flags & IFF_ALLMULTI) {
+               /* Accept all multicast frames */
+               freg |= FILTER_ACCEPT_MCAST_ANY;
+       } else if (ndev->mc_count > 0) {
+               /* Accept some multicast frames */
+               u64 hash_mask = 0;
+               struct dev_mc_list *mc;
+
+               freg |= FILTER_ACCEPT_MCAST_HASH;
+               for (mc = ndev->mc_list; mc; mc = mc->next) {
+                       int b = (ether_crc(ETH_ALEN, mc->dmi_addr) >>
23) & 0x3f;
+                       hash_mask |= (1 << b);
+               }
+               ip3902_write_reg(ndev, HASH_FILTER_L_REG, hash_mask &
0xffffffff);
+               ip3902_write_reg(ndev, HASH_FILTER_H_REG, hash_mask >> 32);
+       }
+
+       ip3902_write_reg(ndev, FILTER_CTRL_REG, freg);
+}
+
+static void ip3902_set_rx_filter(struct net_device *ndev)
+{
+       struct ip3902_private *ip3902_priv = (struct ip3902_private
*)netdev_priv(ndev);
+
+       ip3902_do_set_rx_filter(ndev, ip3902_priv);
+}
+
+static void set_duplex_mode(struct net_device *ndev, int duplex)
+{
+       unsigned long val;
+
+       if (duplex) {
+               /* Full Duplex mode */
+
+               val = ip3902_read_reg(ndev, MAC2_REG);
+               val |= MAC2_FULL_DUPLEX;
+               ip3902_write_reg(ndev, MAC2_REG, val);
+
+               ip3902_write_reg(ndev, IPGT_REG, IPGT_FD_VALUE);
+
+               val = ip3902_read_reg(ndev, COMMAND_REG);
+               val |= COMMAND_FULL_DUPLEX;
+               ip3902_write_reg(ndev, COMMAND_REG, val);
+       } else {
+               /* Half Duplex mode */
+
+               val = ip3902_read_reg(ndev, MAC2_REG);
+               val &= ~MAC2_FULL_DUPLEX;
+               ip3902_write_reg(ndev, MAC2_REG, val);
+
+               ip3902_write_reg(ndev, IPGT_REG, IPGT_HD_VALUE);
+
+               val = ip3902_read_reg(ndev, COMMAND_REG);
+               val &= ~COMMAND_FULL_DUPLEX;
+               ip3902_write_reg(ndev, COMMAND_REG, val);
+       }
+}
+
+static int ip3902_ioctl(struct net_device *ndev, struct ifreq *req, int cmd)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       unsigned int duplex_changed;
+       unsigned long flags;
+       int rc;
+
+       if (!netif_running(ndev))
+               return -EINVAL;
+
+       spin_lock_irqsave(&ip3902_priv->mii_lock, flags);
+       rc = generic_mii_ioctl(&ip3902_priv->mii, if_mii(req), cmd,
&duplex_changed);
+       spin_unlock_irqrestore(&ip3902_priv->mii_lock, flags);
+       if (duplex_changed)
+               set_duplex_mode(ndev, ip3902_priv->mii.full_duplex);
+
+       return rc;
+}
+
+/* ethtool ops */
+
+static void ip3902_get_drvinfo(struct net_device *ndev,
+                                                          struct
ethtool_drvinfo *info)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+
+       strcpy(info->driver, DRVNAME);
+       strcpy(info->version, DRVVERSION);
+       strcpy(info->bus_info, ip3902_priv->ndev->name);
+}
+
+static int ip3902_get_settings(struct net_device *ndev, struct
ethtool_cmd *cmd)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       unsigned long flags;
+
+       spin_lock_irqsave(&ip3902_priv->mii_lock, flags);
+       mii_ethtool_gset(&ip3902_priv->mii, cmd);
+       spin_lock_irqsave(&ip3902_priv->mii_lock, flags);
+
+       return 0;
+}
+
+static int ip3902_set_settings(struct net_device *ndev, struct
ethtool_cmd *cmd)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       unsigned long flags;
+       int rc;
+
+       spin_lock_irqsave(&ip3902_priv->mii_lock, flags);
+       rc = mii_ethtool_sset(&ip3902_priv->mii, cmd);
+       spin_lock_irqsave(&ip3902_priv->mii_lock, flags);
+
+       return rc;
+}
+
+static int ip3902_nway_reset(struct net_device *ndev)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       return mii_nway_restart(&ip3902_priv->mii);
+}
+
+static u32 ip3902_get_link(struct net_device *ndev)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       return mii_link_ok(&ip3902_priv->mii);
+}
+
+static const struct ethtool_ops ip3902_ethtool_ops = {
+       .get_drvinfo    = ip3902_get_drvinfo,
+       .get_settings   = ip3902_get_settings,
+       .set_settings   = ip3902_set_settings,
+       .nway_reset     = ip3902_nway_reset,
+       .get_link       = ip3902_get_link,
+       .get_sg         = ethtool_op_get_sg,
+       .set_sg         = ethtool_op_set_sg,
+};
+
+/* setup code */
+
+static void ip3902_eth_update_mac_address(struct net_device *ndev)
+{
+       ip3902_write_reg(ndev, SA0_REG, (ndev->dev_addr[5] << 8) |
ndev->dev_addr[4]);
+       ip3902_write_reg(ndev, SA1_REG, (ndev->dev_addr[3] << 8) |
ndev->dev_addr[2]);
+       ip3902_write_reg(ndev, SA2_REG, (ndev->dev_addr[1] << 8) |
ndev->dev_addr[0]);
+}
+
+static int ip3902_eth_set_mac_address(struct net_device *ndev, void *addr)
+{
+       int i;
+
+       for (i = 0; i < 6; i++)
+               /* +2 is for the offset of the HW addr type */
+               ndev->dev_addr[i] = ((unsigned char *)addr)[i + 2];
+
+       ip3902_eth_update_mac_address(ndev);
+       return 0;
+}
+
+static void ip3902_hw_deinit(struct net_device *ndev)
+{
+       unsigned long val;
+
+       /* Stop Rx and Tx hardware and disable interrupts */
+       val = ip3902_read_reg(ndev, COMMAND_REG);
+       val &= ~(COMMAND_TX_ENABLE | COMMAND_RX_ENABLE);
+       ip3902_write_reg(ndev, COMMAND_REG, val);
+       ip3902_write_reg(ndev, INT_ENABLE_REG, 0);
+
+       /* Put low-level hardware into reset, and high-level into poweroff */
+       ip3902_write_reg(ndev, MAC1_REG, MAC1_SOFT_RESET);
+       ip3902_write_reg(ndev, POWERDOWN_REG, POWERDOWN_VALUE);
+}
+
+static int ethernet_phy_get(struct net_device *ndev)
+{
+       int addr;
+
+       for (addr = 1; addr < 32; addr++) {
+               int stat;
+               stat = ip3902_mdio_read(ndev, addr, MII_BMSR);
+               if ((stat != 0) && (stat != 0xffff))
+                       return addr;
+       }
+       printk(KERN_ERR DRVNAME ": could not locate PHY\n");
+       return -EIO;
+}
+
+static int ip3902_hw_init(struct net_device *ndev, struct
ip3902_private *ip3902_priv)
+{
+       int ret = 0;
+
+       /* Poweron hardware */
+       ip3902_write_reg(ndev, POWERDOWN_REG, 0);
+
+       /* Move low level out of reset (also initialize the registers)*/
+       ip3902_write_reg(ndev, MAC1_REG, 0);
+       ip3902_write_reg(ndev, MAC2_REG, INITIAL_MAC2);
+
+       ip3902_priv->mii.phy_id = ethernet_phy_get(ndev);
+
+       if (ip3902_priv->mii.phy_id < 0) {
+               ret = ip3902_priv->mii.phy_id;
+       } else {
+               ip3902_eth_update_mac_address(ndev);
+
+               /* "Initialize" command register (before resets - those routines
+                * use read-modify-write operations on that register */
+               ip3902_write_reg(ndev, COMMAND_REG, COMMAND_ALLOW_SHORT);
+
+               /* Reset and configure Rx and Tx */
+               ip3902_reset_tx(ndev, ip3902_priv, 1);
+               ip3902_reset_rx(ndev, ip3902_priv, 1);
+
+               /* Initialize Rx filtering */
+               ip3902_do_set_rx_filter(ndev, ip3902_priv);
+
+               /* Clear all interrupts, and enable interesting interrupts */
+               ip3902_write_reg(ndev, INT_CLEAR_REG, 0xffffffff);
+               ip3902_write_reg(ndev, INT_CLEAR_REG, 0);
+               ip3902_write_reg(ndev, INT_ENABLE_REG, (TX_UNDERRUN_INT |
RX_DONE_INT | RX_OVERRUN_INT));
+
+               /* Start Tx and Rx hardware */
+               ip3902_start_tx(ndev);
+               ip3902_start_rx(ndev);
+       }
+       return 0;
+}
+
+static int ip3902_open(struct net_device *ndev)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+       int ret;
+
+       dev_dbg(&ip3902_priv->ndev->dev, "%s: open\n", ndev->name);
+
+       ret = request_irq(ndev->irq, ip3902_interrupt, 0, ndev->name, ndev);
+       if (ret)
+               return ret;
+
+       ret = ip3902_hw_init(ndev, ip3902_priv);
+
+       if (ret)
+               return ret;
+
+       mii_check_media(&ip3902_priv->mii, netif_msg_link(ip3902_priv), 1);
+       set_duplex_mode(ndev, ip3902_priv->mii.full_duplex);
+
+#ifdef CONFIG_INET_LRO
+       init_timer(&ip3902_priv->lro_timer);
+       ip3902_priv->lro_timer.data     = (unsigned long) ip3902_priv;
+       ip3902_priv->lro_timer.function = ip3902_lro_timeout;
+#endif
+
+       netif_start_queue(ndev);
+
+#ifdef IP3902_NAPI
+       napi_enable(&ip3902_priv->napi);
+#endif
+
+       ip3902_priv->running = 1;
+
+       return 0;
+}
+
+static int ip3902_close(struct net_device *ndev)
+{
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+
+       dev_dbg(&ip3902_priv->ndev->dev, "%s: close\n", ndev->name);
+
+       ip3902_priv->running = 0;
+       wmb();
+
+#ifdef CONFIG_INET_LRO
+       del_timer(&ip3902_priv->lro_timer);
+#endif
+
+#ifdef IP3902_NAPI
+       napi_disable(&ip3902_priv->napi);
+#endif
+
+       ip3902_hw_deinit(ndev);
+
+       netif_stop_queue(ndev);
+
+       ip3902_eth_free_all_tx_descs(ndev, ip3902_priv);
+
+       free_irq(ndev->irq, ndev);
+       return 0;
+}
+
+static int parse_mac_address(struct net_device *ndev)
+{
+       int n = sscanf(mac_address, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+                                  &ndev->dev_addr[0], &ndev->dev_addr[1],
+                                  &ndev->dev_addr[2], &ndev->dev_addr[3],
+                                  &ndev->dev_addr[4], &ndev->dev_addr[5]);
+
+       if (n == 6)
+               return 0;
+
+       printk(KERN_WARNING DRVNAME": failed to parse mac address string
\"%s\"\n", mac_address);
+       return -EINVAL;
+}
+
+static void ip3902_hw_shutdown(struct net_device *ndev, struct
ip3902_private *ip3902_priv)
+{
+       dma_free_coherent(NULL, sizeof(*(ip3902_priv->ds)), ip3902_priv->ds,
ip3902_priv->ds_dma);
+}
+
+static int ip3902_hw_startup(struct net_device *ndev, struct
ip3902_private *ip3902_priv)
+{
+       ip3902_priv->ds = dma_alloc_coherent(NULL,
sizeof(*(ip3902_priv->ds)), &ip3902_priv->ds_dma, GFP_KERNEL);
+       if (!ip3902_priv->ds) {
+               printk(KERN_ERR DRVNAME ": can't allocate DMA structure\n");
+               ip3902_hw_shutdown(ndev, ip3902_priv);
+               return -ENOMEM;
+       }
+
+       /* Poweron hardware */
+       ip3902_write_reg(ndev, POWERDOWN_REG, 0);
+
+       /* set mii clock */
+       ip3902_write_reg(ndev, MCFG_REG, 0x1c);
+
+       /* Move low level out of reset (also initialize the registers)*/
+       ip3902_write_reg(ndev, MAC1_REG, 0);
+       ip3902_write_reg(ndev, MAC2_REG, INITIAL_MAC2);
+
+       if (!mac_address || parse_mac_address(ndev) < 0) {
+               unsigned long val;
+
+               val = ip3902_read_reg(ndev, SA0_REG);
+               ndev->dev_addr[5] = (val >> 8) & 255;
+               ndev->dev_addr[4] = val & 255;
+               val = ip3902_read_reg(ndev, SA1_REG);
+               ndev->dev_addr[3] = (val >> 8) & 255;
+               ndev->dev_addr[2] = val & 255;
+               val = ip3902_read_reg(ndev, SA2_REG);
+               ndev->dev_addr[1] = (val >> 8) & 255;
+               ndev->dev_addr[0] = val & 255;
+       }
+
+       /* Put low-level hardware into reset, and high-level into poweroff */
+       ip3902_write_reg(ndev, MAC1_REG, MAC1_SOFT_RESET);
+       ip3902_write_reg(ndev, POWERDOWN_REG, POWERDOWN_VALUE);
+
+       return 0;
+}
+
+static int ip3902_init_dev(struct net_device *ndev, struct
ip3902_private *ip3902_priv)
+{
+       int ret;
+
+       ret = ip3902_hw_startup(ndev, ip3902_priv);
+
+       if (!ret) {
+               ndev->hard_start_xmit    = ip3902_start_xmit;
+               ndev->set_mac_address    = ip3902_eth_set_mac_address;
+               ndev->set_multicast_list = ip3902_set_rx_filter;
+               ndev->open               = ip3902_open;
+               ndev->stop               = ip3902_close;
+               ndev->do_ioctl           = ip3902_ioctl;
+               ndev->features           = 0;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+               ndev->poll_controller    = ip3902_net_poll;
+#endif
+               SET_ETHTOOL_OPS(ndev, &ip3902_ethtool_ops);
+
+               ip3902_priv->msg_enable     = NETIF_MSG_LINK;
+               ip3902_priv->mii.phy_id_mask    = 0x1f;
+               ip3902_priv->mii.reg_num_mask   = 0x1f;
+               ip3902_priv->mii.mdio_read  = ip3902_mdio_read;
+               ip3902_priv->mii.mdio_write = ip3902_mdio_write;
+               ip3902_priv->mii.dev        = ndev;
+
+               spin_lock_init(&ip3902_priv->lock);
+
+               ret = register_netdev(ndev);
+
+               if (ret)
+                       ip3902_hw_shutdown(ndev, ip3902_priv);
+       }
+
+       return ret;
+}
+
+#ifdef CONFIG_INET_LRO
+static int ip3902_get_skb_hdr(struct sk_buff *skb, void **iphdr, void
**tcph, u64 *hdr_flags, void *priv)
+{
+       unsigned int ip_len;
+       struct iphdr *iph;
+
+       /* non tcp packet */
+       skb_reset_network_header(skb);
+       iph = ip_hdr(skb);
+       if (iph->protocol != IPPROTO_TCP)
+               return -1;
+
+       ip_len = ip_hdrlen(skb);
+       skb_set_transport_header(skb, ip_len);
+       *tcph = tcp_hdr(skb);
+
+       /* check if ip header and tcp header are complete */
+       if (iph->tot_len < ip_len + tcp_hdrlen(skb))
+               return -1;
+
+       *hdr_flags = LRO_IPV4 | LRO_TCP;
+       *iphdr = iph;
+
+       return 0;
+}
+#endif
+
+static int ip3902_remove(struct platform_device *pdev)
+{
+       struct net_device     *ndev = platform_get_drvdata(pdev);
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+
+       platform_set_drvdata(pdev, NULL);
+
+       unregister_netdev(ndev);
+
+       iounmap(ip3902_priv->mem);
+       release_resource(ip3902_priv->bus);
+       kfree(ip3902_priv->bus);
+
+       free_netdev(ndev);
+
+       return 0;
+}
+
+/* ip3902_probe
+ *
+ * This is the entry point when the platform device system uses to
+ * notify us of a new device to attach to. Allocate memory, find
+ * the resources and information passed, and map the necessary registers.
+*/
+
+static int ip3902_probe(struct platform_device *pdev)
+{
+       struct net_device     *ndev;
+       struct ip3902_private *ip3902_priv;
+       struct resource       *res;
+       size_t                 size;
+       int                    ret;
+
+       ndev = alloc_etherdev(sizeof(struct ip3902_private));
+
+       if (ndev == NULL)
+               return -ENOMEM;
+
+       ip3902_priv = netdev_priv(ndev);
+
+       memset(ip3902_priv, 0, sizeof(struct ip3902_private));
+
+       spin_lock_init(&ip3902_priv->mii_lock);
+
+       ip3902_priv->ndev = ndev;
+       ip3902_priv->pdev = pdev;
+
+#ifdef IP3902_NAPI
+       netif_napi_add(ndev, &ip3902_priv->napi, ip3902_poll,
IP3902_NAPI_WEIGHT);
+#endif
+
+#ifdef CONFIG_INET_LRO
+       ip3902_priv->use_lro   = false;
+       ip3902_priv->lro_count = 0;
+       ip3902_priv->lro_mgr.max_aggr = IP3902_NAPI_WEIGHT;
+       ip3902_priv->lro_mgr.max_desc = MAX_LRO_DESCRIPTORS;
+       ip3902_priv->lro_mgr.lro_arr = ip3902_priv->lro_desc;
+       ip3902_priv->lro_mgr.get_skb_header = ip3902_get_skb_hdr;
+#ifdef IP3902_NAPI
+       ip3902_priv->lro_mgr.features = LRO_F_NAPI;
+#else
+       ip3902_priv->lro_mgr.features = 0;
+#endif
+       ip3902_priv->lro_mgr.dev = ndev;
+       ip3902_priv->lro_mgr.ip_summed = 0;
+       ip3902_priv->lro_mgr.ip_summed_aggr = 0;
+#endif
+
+       platform_set_drvdata(pdev, ndev);
+
+       /* find the platform resources */
+       ndev->irq  = platform_get_irq(pdev, 0);
+       if (ndev->irq < 0) {
+               dev_err(&pdev->dev, "no IRQ specified\n");
+               ret = -ENXIO;
+               goto exit_mem;
+       }
+
+       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       if (res == NULL) {
+               dev_err(&pdev->dev, "no MEM specified\n");
+               ret = -ENXIO;
+               goto exit_mem;
+       }
+       size = (res->end - res->start) + 1;
+
+       ip3902_priv->bus = request_mem_region(res->start & 0x1fffffff, size,
pdev->name);
+       if (ip3902_priv->bus == NULL) {
+               dev_err(&pdev->dev, "cannot reserve registers\n");
+               ret = -ENXIO;
+               goto exit_mem;
+       }
+
+       ip3902_priv->mem = ioremap(res->start & 0x1fffffff, size);
+       ndev->base_addr = (unsigned long)ip3902_priv->mem;
+
+       if (ip3902_priv->mem == NULL) {
+               dev_err(&pdev->dev, "Cannot ioremap area (%08llx,%08llx)\n",
+                               (unsigned long long)res->start,
+                               (unsigned long long)res->end);
+
+               ret = -ENXIO;
+               goto exit_req;
+       }
+
+       SET_NETDEV_DEV(ndev, &pdev->dev);
+
+       /* got resources, now initialise and register device */
+       ret = ip3902_init_dev(ndev, ip3902_priv);
+       if (!ret) {
+               printk(KERN_INFO "NXP ip3902 10/100 Ethernet platform
driver irq %d
base %08lx\n", ndev->irq, ndev->base_addr);
+               return 0;
+       }
+
+exit_req:
+       release_resource(ip3902_priv->bus);
+       kfree(ip3902_priv->bus);
+
+exit_mem:
+       free_netdev(ndev);
+
+       return ret;
+}
+
+/* suspend and resume */
+
+#ifdef CONFIG_PM
+static int ip3902_suspend(struct platform_device *pdev, pm_message_t state)
+{
+       struct net_device     *ndev = platform_get_drvdata(pdev);
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+
+       ip3902_priv->resume_open = ip3902_priv->running;
+
+       netif_device_detach(ndev);
+       ip3902_close(ndev);
+
+       return 0;
+}
+
+static int ip3902_resume(struct platform_device *pdev)
+{
+       struct net_device     *ndev = platform_get_drvdata(pdev);
+       struct ip3902_private *ip3902_priv = netdev_priv(ndev);
+
+       netif_device_attach(ndev);
+
+       if (ip3902_priv->resume_open)
+               ip3902_open(ndev);
+
+       return 0;
+}
+
+#else
+       #define ip3902_suspend NULL
+       #define ip3902_resume  NULL
+#endif
+
+static struct platform_driver ip3902drv = {
+       .driver = {
+               .name       = "ip3902-eth",
+               .owner      = THIS_MODULE,
+       },
+       .probe      = ip3902_probe,
+       .remove     = ip3902_remove,
+       .suspend    = ip3902_suspend,
+       .resume     = ip3902_resume,
+};
+
+static int __init ip3902drv_init(void)
+{
+       return platform_driver_register(&ip3902drv);
+}
+
+static void __exit ip3902drv_exit(void)
+{
+       platform_driver_unregister(&ip3902drv);
+}
+
+module_init(ip3902drv_init);
+module_exit(ip3902drv_exit);
+
+MODULE_DESCRIPTION("NXP IP3902 10/100 Ethernet platform driver");
+MODULE_AUTHOR("Chris Steel, <chris.steel@nxp.com>");
+MODULE_LICENSE("GPL v2");
diff -urN --exclude=.svn linux-2.6.26-rc4.orig/drivers/net/Kconfig
linux-2.6.26-rc4/drivers/net/Kconfig
--- linux-2.6.26-rc4.orig/drivers/net/Kconfig   2008-06-03
10:56:55.000000000 +0100
+++ linux-2.6.26-rc4/drivers/net/Kconfig        2008-06-03
17:16:59.000000000 +0100
@@ -1884,6 +1884,15 @@
         Say Y here if you want to use the NE2000 compatible
         controller on the Renesas H8/300 processor.

+config IP3902
+       tristate "NXP IP3902 ethernet hardware support"
+       depends on SOC_PNX8335 && NET_ETHERNET
+       select MII
+       select CRC32
+       help
+         This is a driver for NXP IP3902 ethernet hardware found
+         in PNX8335 and probably other SOCs.
+
 source "drivers/net/fec_8xx/Kconfig"
 source "drivers/net/fs_enet/Kconfig"

diff -urN --exclude=.svn linux-2.6.26-rc4.orig/drivers/net/Makefile
linux-2.6.26-rc4/drivers/net/Makefile
--- linux-2.6.26-rc4.orig/drivers/net/Makefile  2008-06-03
10:56:55.000000000 +0100
+++ linux-2.6.26-rc4/drivers/net/Makefile       2008-06-03
17:17:11.000000000 +0100
@@ -122,6 +122,7 @@
 obj-$(CONFIG_FORCEDETH) += forcedeth.o
 obj-$(CONFIG_NE_H8300) += ne-h8300.o
 obj-$(CONFIG_AX88796) += ax88796.o
+obj-$(CONFIG_IP3902) += ip3902.o

 obj-$(CONFIG_TSI108_ETH) += tsi108_eth.o
 obj-$(CONFIG_MV643XX_ETH) += mv643xx_eth.o
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h  1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h       2008-06-05
11:07:19.000000000 +0100
@@ -0,0 +1,171 @@
+/*
+ *  gpio.h: GPIO Support for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+#define SET_REG_BIT(reg, bit)          reg |= (1 << (bit))
+#define CLEAR_REG_BIT(reg, bit)                reg &= ~(1 << (bit))
+
+/* Initialize GPIO to a known state */
+static inline void gpio_init(void)
+{
+       PNX833X_PIO_DIR = 0;
+       PNX833X_PIO_DIR2 = 0;
+       PNX833X_PIO_SEL = 0;
+       PNX833X_PIO_SEL2 = 0;
+       PNX833X_PIO_INT_EDGE = 0;
+       PNX833X_PIO_INT_HI = 0;
+       PNX833X_PIO_INT_LO = 0;
+
+       /* clear any GPIO interrupt requests */
+       PNX833X_PIO_INT_CLEAR = 0xffff;
+       PNX833X_PIO_INT_CLEAR = 0;
+       PNX833X_PIO_INT_ENABLE = 0;
+}
+
+/* Select GPIO direction for a pin */
+static inline void gpio_select_input(unsigned int pin)
+{
+       if (pin < 32)
+               CLEAR_REG_BIT(PNX833X_PIO_DIR, pin);
+       else
+               CLEAR_REG_BIT(PNX833X_PIO_DIR2, pin & 31);
+}
+static inline void gpio_select_output(unsigned int pin)
+{
+       if (pin < 32)
+               SET_REG_BIT(PNX833X_PIO_DIR, pin);
+       else
+               SET_REG_BIT(PNX833X_PIO_DIR2, pin & 31);
+}
+
+/* Select GPIO or alternate function for a pin */
+static inline void gpio_select_function_io(unsigned int pin)
+{
+       if (pin < 32)
+               CLEAR_REG_BIT(PNX833X_PIO_SEL, pin);
+       else
+               CLEAR_REG_BIT(PNX833X_PIO_SEL2, pin & 31);
+}
+static inline void gpio_select_function_alt(unsigned int pin)
+{
+       if (pin < 32)
+               SET_REG_BIT(PNX833X_PIO_SEL, pin);
+       else
+               SET_REG_BIT(PNX833X_PIO_SEL2, pin & 31);
+}
+
+/* Read GPIO pin */
+static inline int gpio_read(unsigned int pin)
+{
+       if (pin < 32)
+               return(PNX833X_PIO_IN >> pin) & 1;
+       else
+               return(PNX833X_PIO_IN2 >> (pin & 31)) & 1;
+}
+
+/* Write GPIO pin */
+static inline void gpio_write(unsigned int val, unsigned int pin)
+{
+       if (pin < 32) {
+               if (val)
+                       SET_REG_BIT(PNX833X_PIO_OUT, pin);
+               else
+                       CLEAR_REG_BIT(PNX833X_PIO_OUT, pin);
+       } else {
+               if (val)
+                       SET_REG_BIT(PNX833X_PIO_OUT2, pin & 31);
+               else
+                       CLEAR_REG_BIT(PNX833X_PIO_OUT2, pin & 31);
+       }
+}
+
+/* Configure GPIO interrupt */
+#define GPIO_INT_NONE          0
+#define GPIO_INT_LEVEL_LOW     1
+#define GPIO_INT_LEVEL_HIGH    2
+#define GPIO_INT_EDGE_RISING   3
+#define GPIO_INT_EDGE_FALLING  4
+#define GPIO_INT_EDGE_BOTH     5
+static inline void gpio_setup_irq(int when, unsigned int pin)
+{
+       switch (when) {
+       case GPIO_INT_LEVEL_LOW:
+               CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+               CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
+               SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
+               break;
+       case GPIO_INT_LEVEL_HIGH:
+               CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+               SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
+               CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
+               break;
+       case GPIO_INT_EDGE_RISING:
+               SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+               SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
+               CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
+               break;
+       case GPIO_INT_EDGE_FALLING:
+               SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+               CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
+               SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
+               break;
+       case GPIO_INT_EDGE_BOTH:
+               SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+               SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
+               SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
+               break;
+       default:
+               CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
+               CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
+               CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
+               break;
+       }
+}
+
+/* Enable/disable GPIO interrupt */
+static inline void gpio_enable_irq(unsigned int pin)
+{
+       SET_REG_BIT(PNX833X_PIO_INT_ENABLE, pin);
+}
+static inline void gpio_disable_irq(unsigned int pin)
+{
+       CLEAR_REG_BIT(PNX833X_PIO_INT_ENABLE, pin);
+}
+
+/* Clear GPIO interrupt request */
+static inline void gpio_clear_irq(unsigned int pin)
+{
+       SET_REG_BIT(PNX833X_PIO_INT_CLEAR, pin);
+       CLEAR_REG_BIT(PNX833X_PIO_INT_CLEAR, pin);
+}
+
+#endif
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq.h   1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq.h        2008-06-05
10:28:19.000000000 +0100
@@ -0,0 +1,138 @@
+/*
+ *  irq.h: IRQ mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+
+#if defined(CONFIG_SOC_PNX8335)
+       #define PNX833X_PIC_NUM_IRQ                     58
+#else
+       #define PNX833X_PIC_NUM_IRQ                     37
+#endif
+
+#define MIPS_CPU_NUM_IRQ                               8
+#define PNX833X_GPIO_NUM_IRQ                   16
+
+#define MIPS_CPU_IRQ_BASE                              0
+#define PNX833X_PIC_IRQ_BASE                   (MIPS_CPU_IRQ_BASE +
MIPS_CPU_NUM_IRQ)
+#define PNX833X_GPIO_IRQ_BASE                  (PNX833X_PIC_IRQ_BASE
+ PNX833X_PIC_NUM_IRQ)
+#define NR_IRQS
 (MIPS_CPU_NUM_IRQ + PNX833X_PIC_NUM_IRQ +
PNX833X_GPIO_NUM_IRQ)
+
+
+#define PNX833X_TIMER_IRQ                              (MIPS_CPU_IRQ_BASE + 7)
+
+/* Interrupts supported by PIC */
+#define PNX833X_PIC_I2C0_INT                   (PNX833X_PIC_IRQ_BASE +  1)
+#define PNX833X_PIC_I2C1_INT                   (PNX833X_PIC_IRQ_BASE +  2)
+#define PNX833X_PIC_UART0_INT                  (PNX833X_PIC_IRQ_BASE +  3)
+#define PNX833X_PIC_UART1_INT                  (PNX833X_PIC_IRQ_BASE +  4)
+#define PNX833X_PIC_TS_IN0_DV_INT              (PNX833X_PIC_IRQ_BASE +  5)
+#define PNX833X_PIC_TS_IN0_DMA_INT             (PNX833X_PIC_IRQ_BASE +  6)
+#define PNX833X_PIC_GPIO_INT                   (PNX833X_PIC_IRQ_BASE +  7)
+#define PNX833X_PIC_AUDIO_DEC_INT              (PNX833X_PIC_IRQ_BASE +  8)
+#define PNX833X_PIC_VIDEO_DEC_INT              (PNX833X_PIC_IRQ_BASE +  9)
+#define PNX833X_PIC_CONFIG_INT                 (PNX833X_PIC_IRQ_BASE + 10)
+#define PNX833X_PIC_AOI_INT
(PNX833X_PIC_IRQ_BASE + 11)
+#define PNX833X_PIC_SYNC_INT                   (PNX833X_PIC_IRQ_BASE + 12)
+#define PNX8330_PIC_SPU_INT
(PNX833X_PIC_IRQ_BASE + 13)
+#define PNX8335_PIC_SATA_INT                   (PNX833X_PIC_IRQ_BASE + 13)
+#define PNX833X_PIC_OSD_INT
(PNX833X_PIC_IRQ_BASE + 14)
+#define PNX833X_PIC_DISP1_INT                  (PNX833X_PIC_IRQ_BASE + 15)
+#define PNX833X_PIC_DEINTERLACER_INT   (PNX833X_PIC_IRQ_BASE + 16)
+#define PNX833X_PIC_DISPLAY2_INT               (PNX833X_PIC_IRQ_BASE + 17)
+#define PNX833X_PIC_VC_INT
(PNX833X_PIC_IRQ_BASE + 18)
+#define PNX833X_PIC_SC_INT
(PNX833X_PIC_IRQ_BASE + 19)
+#define PNX833X_PIC_IDE_INT
(PNX833X_PIC_IRQ_BASE + 20)
+#define PNX833X_PIC_IDE_DMA_INT
(PNX833X_PIC_IRQ_BASE + 21)
+#define PNX833X_PIC_TS_IN1_DV_INT              (PNX833X_PIC_IRQ_BASE + 22)
+#define PNX833X_PIC_TS_IN1_DMA_INT             (PNX833X_PIC_IRQ_BASE + 23)
+#define PNX833X_PIC_SGDX_DMA_INT               (PNX833X_PIC_IRQ_BASE + 24)
+#define PNX833X_PIC_TS_OUT_INT                 (PNX833X_PIC_IRQ_BASE + 25)
+#define PNX833X_PIC_IR_INT
(PNX833X_PIC_IRQ_BASE + 26)
+#define PNX833X_PIC_VMSP1_INT                  (PNX833X_PIC_IRQ_BASE + 27)
+#define PNX833X_PIC_VMSP2_INT                  (PNX833X_PIC_IRQ_BASE + 28)
+#define PNX833X_PIC_PIBC_INT                   (PNX833X_PIC_IRQ_BASE + 29)
+#define PNX833X_PIC_TS_IN0_TRD_INT             (PNX833X_PIC_IRQ_BASE + 30)
+#define PNX833X_PIC_SGDX_TPD_INT               (PNX833X_PIC_IRQ_BASE + 31)
+#define PNX833X_PIC_USB_INT
(PNX833X_PIC_IRQ_BASE + 32)
+#define PNX833X_PIC_TS_IN1_TRD_INT             (PNX833X_PIC_IRQ_BASE + 33)
+#define PNX833X_PIC_CLOCK_INT                  (PNX833X_PIC_IRQ_BASE + 34)
+#define PNX833X_PIC_SGDX_PARSER_INT            (PNX833X_PIC_IRQ_BASE + 35)
+#define PNX833X_PIC_VMSP_DMA_INT               (PNX833X_PIC_IRQ_BASE + 36)
+
+#if defined(CONFIG_SOC_PNX8335)
+#define PNX8335_PIC_MIU_INT
(PNX833X_PIC_IRQ_BASE + 37)
+#define PNX8335_PIC_AVCHIP_IRQ_INT
(PNX833X_PIC_IRQ_BASE + 38)
+#define PNX8335_PIC_SYNC_HD_INT
(PNX833X_PIC_IRQ_BASE + 39)
+#define PNX8335_PIC_DISP_HD_INT
(PNX833X_PIC_IRQ_BASE + 40)
+#define PNX8335_PIC_DISP_SCALER_INT
(PNX833X_PIC_IRQ_BASE + 41)
+#define PNX8335_PIC_OSD_HD1_INT
(PNX833X_PIC_IRQ_BASE + 42)
+#define PNX8335_PIC_DTL_WRITER_Y_INT           (PNX833X_PIC_IRQ_BASE + 43)
+#define PNX8335_PIC_DTL_WRITER_C_INT           (PNX833X_PIC_IRQ_BASE + 44)
+#define PNX8335_PIC_DTL_EMULATOR_Y_IR_INT      (PNX833X_PIC_IRQ_BASE + 45)
+#define PNX8335_PIC_DTL_EMULATOR_C_IR_INT      (PNX833X_PIC_IRQ_BASE + 46)
+#define PNX8335_PIC_DENC_TTX_INT
(PNX833X_PIC_IRQ_BASE + 47)
+#define PNX8335_PIC_MMI_SIF0_INT
(PNX833X_PIC_IRQ_BASE + 48)
+#define PNX8335_PIC_MMI_SIF1_INT
(PNX833X_PIC_IRQ_BASE + 49)
+#define PNX8335_PIC_MMI_CDMMU_INT
(PNX833X_PIC_IRQ_BASE + 50)
+#define PNX8335_PIC_PIBCS_INT
(PNX833X_PIC_IRQ_BASE + 51)
+#define PNX8335_PIC_ETHERNET_INT
(PNX833X_PIC_IRQ_BASE + 52)
+#define PNX8335_PIC_VMSP1_0_INT
(PNX833X_PIC_IRQ_BASE + 53)
+#define PNX8335_PIC_VMSP1_1_INT
(PNX833X_PIC_IRQ_BASE + 54)
+#define PNX8335_PIC_VMSP1_DMA_INT
(PNX833X_PIC_IRQ_BASE + 55)
+#define PNX8335_PIC_TDGR_DE_INT
(PNX833X_PIC_IRQ_BASE + 56)
+#define PNX8335_PIC_IR1_IRQ_INT
(PNX833X_PIC_IRQ_BASE + 57)
+#endif
+
+/* GPIO interrupts */
+#define PNX833X_GPIO_0_INT
(PNX833X_GPIO_IRQ_BASE +  0)
+#define PNX833X_GPIO_1_INT
(PNX833X_GPIO_IRQ_BASE +  1)
+#define PNX833X_GPIO_2_INT
(PNX833X_GPIO_IRQ_BASE +  2)
+#define PNX833X_GPIO_3_INT
(PNX833X_GPIO_IRQ_BASE +  3)
+#define PNX833X_GPIO_4_INT
(PNX833X_GPIO_IRQ_BASE +  4)
+#define PNX833X_GPIO_5_INT
(PNX833X_GPIO_IRQ_BASE +  5)
+#define PNX833X_GPIO_6_INT
(PNX833X_GPIO_IRQ_BASE +  6)
+#define PNX833X_GPIO_7_INT
(PNX833X_GPIO_IRQ_BASE +  7)
+#define PNX833X_GPIO_8_INT
(PNX833X_GPIO_IRQ_BASE +  8)
+#define PNX833X_GPIO_9_INT
(PNX833X_GPIO_IRQ_BASE +  9)
+#define PNX833X_GPIO_10_INT
(PNX833X_GPIO_IRQ_BASE + 10)
+#define PNX833X_GPIO_11_INT
(PNX833X_GPIO_IRQ_BASE + 11)
+#define PNX833X_GPIO_12_INT
(PNX833X_GPIO_IRQ_BASE + 12)
+#define PNX833X_GPIO_13_INT
(PNX833X_GPIO_IRQ_BASE + 13)
+#define PNX833X_GPIO_14_INT
(PNX833X_GPIO_IRQ_BASE + 14)
+#define PNX833X_GPIO_15_INT
(PNX833X_GPIO_IRQ_BASE + 15)
+
+#endif
+
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/pnx833x.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/pnx833x.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/pnx833x.h
 1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/pnx833x.h    2008-06-05
10:11:24.000000000 +0100
@@ -0,0 +1,194 @@
+/*
+ *  pnx833x.h: Register mappings for PNX833X.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *       Chris Steel <chris.steel@nxp.com>
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
+#define PNX833X_BASE           (0xa0000000ul + 0x17E00000ul)
+
+#define PNX833X_REG(offs)      *((volatile unsigned long
*)(PNX833X_BASE + offs))
+
+/* Registers are named exactly as in PNX833X docs, just with PNX833X_ prefix */
+
+/* Read access to multibit fields */
+#define PNX833X_BIT(val, reg, field)   ((val) & PNX833X_##reg##_##field)
+#define PNX833X_REGBIT(reg, field)     PNX833X_BIT(PNX833X_##reg, reg, field)
+
+/* Use PNX833X_FIELD to extract a field from val */
+#define PNX_FIELD(cpu, val, reg, field) \
+               (((val) & PNX##cpu##_##reg##_##field##_MASK) >> \
+                       PNX##cpu##_##reg##_##field##_SHIFT)
+#define PNX833X_FIELD(val, reg, field) PNX_FIELD(833X, val, reg, field)
+#define PNX8330_FIELD(val, reg, field) PNX_FIELD(8330, val, reg, field)
+#define PNX8335_FIELD(val, reg, field) PNX_FIELD(8335, val, reg, field)
+
+/* Use PNX833X_REGFIELD to extract a field from a register */
+#define PNX833X_REGFIELD(reg, field)   PNX833X_FIELD(PNX833X_##reg, reg, field)
+#define PNX8330_REGFIELD(reg, field)   PNX8330_FIELD(PNX8330_##reg, reg, field)
+#define PNX8335_REGFIELD(reg, field)   PNX8335_FIELD(PNX8335_##reg, reg, field)
+
+
+#define PNX_WRITEFIELD(cpu, val, reg, field) \
+       PNX##cpu##_##reg = (PNX##cpu##_##reg &
~(PNX##cpu##_##reg##_##field##_MASK)) | \
+                                               ((val) <<
PNX##cpu##_##reg##_##field##_SHIFT)
+#define PNX833X_WRITEFIELD(val, reg, field) \
+                                       PNX_WRITEFIELD(833X, val, reg, field)
+#define PNX8330_WRITEFIELD(val, reg, field) \
+                                       PNX_WRITEFIELD(8330, val, reg, field)
+#define PNX8335_WRITEFIELD(val, reg, field) \
+                                       PNX_WRITEFIELD(8335, val, reg, field)
+
+
+/* Macros to detect CPU type */
+
+#define PNX833X_CONFIG_MODULE_ID               PNX833X_REG(0x7FFC)
+#define PNX833X_CONFIG_MODULE_ID_MAJREV_MASK   0x0000f000
+#define PNX833X_CONFIG_MODULE_ID_MAJREV_SHIFT  12
+#define PNX8330_CONFIG_MODULE_MAJREV           4
+#define PNX8335_CONFIG_MODULE_MAJREV           5
+#define CPU_IS_PNX8330 (PNX833X_REGFIELD(CONFIG_MODULE_ID, MAJREV) == \
+                                       PNX8330_CONFIG_MODULE_MAJREV)
+#define CPU_IS_PNX8335 (PNX833X_REGFIELD(CONFIG_MODULE_ID, MAJREV) == \
+                                       PNX8335_CONFIG_MODULE_MAJREV)
+
+
+
+#define PNX833X_RESET_CONTROL          PNX833X_REG(0x8004)
+#define PNX833X_RESET_CONTROL_2        PNX833X_REG(0x8014)
+
+#define PNX833X_PIC_REG(offs)          PNX833X_REG(0x01000 + (offs))
+#define PNX833X_PIC_INT_PRIORITY       PNX833X_PIC_REG(0x0)
+#define PNX833X_PIC_INT_SRC            PNX833X_PIC_REG(0x4)
+#define PNX833X_PIC_INT_SRC_INT_SRC_MASK       0x00000FF8ul    /* bits 11:3 */
+#define PNX833X_PIC_INT_SRC_INT_SRC_SHIFT      3
+#define PNX833X_PIC_INT_REG(irq)       PNX833X_PIC_REG(0x10 + 4*(irq))
+
+#define PNX833X_CLOCK_CPUCP_CTL        PNX833X_REG(0x9228)
+#define PNX833X_CLOCK_CPUCP_CTL_EXIT_RESET     0x00000002ul    /* bit 1 */
+#define PNX833X_CLOCK_CPUCP_CTL_DIV_CLOCK_MASK 0x00000018ul    /* bits 4:3 */
+#define PNX833X_CLOCK_CPUCP_CTL_DIV_CLOCK_SHIFT        3
+
+#define PNX8335_CLOCK_PLL_CPU_CTL              PNX833X_REG(0x9020)
+#define PNX8335_CLOCK_PLL_CPU_CTL_FREQ_MASK    0x1f
+#define PNX8335_CLOCK_PLL_CPU_CTL_FREQ_SHIFT   0
+
+#define PNX833X_CONFIG_MUX             PNX833X_REG(0x7004)
+#define PNX833X_CONFIG_MUX_IDE_MUX     0x00000080              /* bit 7 */
+
+#define PNX8330_CONFIG_POLYFUSE_7      PNX833X_REG(0x7040)
+#define PNX8330_CONFIG_POLYFUSE_7_BOOT_MODE_MASK       0x00180000
+#define PNX8330_CONFIG_POLYFUSE_7_BOOT_MODE_SHIFT      19
+
+#define PNX833X_PIO_IN         PNX833X_REG(0xF000)
+#define PNX833X_PIO_OUT                PNX833X_REG(0xF004)
+#define PNX833X_PIO_DIR                PNX833X_REG(0xF008)
+#define PNX833X_PIO_SEL                PNX833X_REG(0xF014)
+#define PNX833X_PIO_INT_EDGE   PNX833X_REG(0xF020)
+#define PNX833X_PIO_INT_HI     PNX833X_REG(0xF024)
+#define PNX833X_PIO_INT_LO     PNX833X_REG(0xF028)
+#define PNX833X_PIO_INT_STATUS PNX833X_REG(0xFFE0)
+#define PNX833X_PIO_INT_ENABLE PNX833X_REG(0xFFE4)
+#define PNX833X_PIO_INT_CLEAR  PNX833X_REG(0xFFE8)
+#define PNX833X_PIO_IN2                PNX833X_REG(0xF05C)
+#define PNX833X_PIO_OUT2       PNX833X_REG(0xF060)
+#define PNX833X_PIO_DIR2       PNX833X_REG(0xF064)
+#define PNX833X_PIO_SEL2       PNX833X_REG(0xF068)
+
+#define PNX833X_UART0_PORTS_START      (PNX833X_BASE + 0xB000)
+#define PNX833X_UART0_PORTS_END                (PNX833X_BASE + 0xBFFF)
+#define PNX833X_UART1_PORTS_START      (PNX833X_BASE + 0xC000)
+#define PNX833X_UART1_PORTS_END                (PNX833X_BASE + 0xCFFF)
+
+#define PNX833X_USB_PORTS_START                (PNX833X_BASE + 0x19000)
+#define PNX833X_USB_PORTS_END          (PNX833X_BASE + 0x19FFF)
+
+#define PNX833X_CONFIG_USB             PNX833X_REG(0x7008)
+
+#define PNX833X_I2C0_PORTS_START       (PNX833X_BASE + 0xD000)
+#define PNX833X_I2C0_PORTS_END         (PNX833X_BASE + 0xDFFF)
+#define PNX833X_I2C1_PORTS_START       (PNX833X_BASE + 0xE000)
+#define PNX833X_I2C1_PORTS_END         (PNX833X_BASE + 0xEFFF)
+
+#define PNX833X_IDE_PORTS_START                (PNX833X_BASE + 0x1A000)
+#define PNX833X_IDE_PORTS_END          (PNX833X_BASE + 0x1AFFF)
+#define PNX833X_IDE_MODULE_ID          PNX833X_REG(0x1AFFC)
+
+#define PNX833X_IDE_MODULE_ID_MODULE_ID_MASK   0xFFFF0000
+#define PNX833X_IDE_MODULE_ID_MODULE_ID_SHIFT  16
+#define PNX833X_IDE_MODULE_ID_VALUE            0xA009
+
+
+#define PNX833X_MIU_SEL0                       PNX833X_REG(0x2004)
+#define PNX833X_MIU_SEL0_TIMING                PNX833X_REG(0x2008)
+#define PNX833X_MIU_SEL1                       PNX833X_REG(0x200C)
+#define PNX833X_MIU_SEL1_TIMING                PNX833X_REG(0x2010)
+#define PNX833X_MIU_SEL2                       PNX833X_REG(0x2014)
+#define PNX833X_MIU_SEL2_TIMING                PNX833X_REG(0x2018)
+#define PNX833X_MIU_SEL3                       PNX833X_REG(0x201C)
+#define PNX833X_MIU_SEL3_TIMING                PNX833X_REG(0x2020)
+
+#define PNX833X_MIU_SEL0_SPI_MODE_ENABLE_MASK  (1 << 14)
+#define PNX833X_MIU_SEL0_SPI_MODE_ENABLE_SHIFT 14
+
+#define PNX833X_MIU_SEL0_BURST_MODE_ENABLE_MASK        (1 << 7)
+#define PNX833X_MIU_SEL0_BURST_MODE_ENABLE_SHIFT       7
+
+#define PNX833X_MIU_SEL0_BURST_PAGE_LEN_MASK   (0xF << 9)
+#define PNX833X_MIU_SEL0_BURST_PAGE_LEN_SHIFT  9
+
+#define PNX833X_MIU_CONFIG_SPI         PNX833X_REG(0x2000)
+
+#define PNX833X_MIU_CONFIG_SPI_OPCODE_MASK     (0xFF << 3)
+#define PNX833X_MIU_CONFIG_SPI_OPCODE_SHIFT    3
+
+#define PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_MASK        (1 << 2)
+#define PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_SHIFT       2
+
+#define PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_MASK        (1 << 1)
+#define PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_SHIFT       1
+
+#define PNX833X_MIU_CONFIG_SPI_SYNC_MASK       (1 << 0)
+#define PNX833X_MIU_CONFIG_SPI_SYNC_SHIFT      0
+
+#define PNX833X_WRITE_CONFIG_SPI(opcode, data_enable, addr_enable, sync) \
+   PNX833X_MIU_CONFIG_SPI = \
+   ((opcode) << PNX833X_MIU_CONFIG_SPI_OPCODE_SHIFT) | \
+   ((data_enable) << PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_SHIFT) | \
+   ((addr_enable) << PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_SHIFT) | \
+   ((sync) << PNX833X_MIU_CONFIG_SPI_SYNC_SHIFT)
+
+#define PNX8335_IP3902_PORTS_START             (PNX833X_BASE + 0x2F000)
+#define PNX8335_IP3902_PORTS_END               (PNX833X_BASE + 0x2FFFF)
+#define PNX8335_IP3902_MODULE_ID               PNX833X_REG(0x2FFFC)
+
+#define PNX8335_IP3902_MODULE_ID_MODULE_ID_MASK                0xFFFF0000
+#define PNX8335_IP3902_MODULE_ID_MODULE_ID_SHIFT       16
+#define PNX8335_IP3902_MODULE_ID_VALUE                 0x3902
+
+#define PNX8335_SATA_PORTS_START       (PNX833X_BASE + 0x2E000)
+#define PNX8335_SATA_PORTS_END         (PNX833X_BASE + 0x2EFFF)
+#define PNX8335_SATA_MODULE_ID         PNX833X_REG(0x2EFFC)
+
+#define PNX8335_SATA_MODULE_ID_MODULE_ID_MASK  0xFFFF0000
+#define PNX8335_SATA_MODULE_ID_MODULE_ID_SHIFT 16
+#define PNX8335_SATA_MODULE_ID_VALUE           0xA099
+
+#endif
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/war.h
linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/war.h
--- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/war.h   1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/war.h        2008-06-05
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
+#define R4600_V1_INDEX_ICACHEOP_WAR    0
+#define R4600_V1_HIT_CACHEOP_WAR       0
+#define R4600_V2_HIT_CACHEOP_WAR       0
+#define R5432_CP0_INTERRUPT_WAR                0
+#define BCM1250_M3_WAR                 0
+#define SIBYTE_1956_WAR                        0
+#define MIPS4K_ICACHE_REFILL_WAR       0
+#define MIPS_CACHE_SYNC_WAR            0
+#define TX49XX_ICACHE_INDEX_INV_WAR    0
+#define RM9000_CDEX_SMP_WAR            0
+#define ICACHE_REFILLS_WORKAROUND_WAR  0
+#define R10000_LLSC_WAR                        0
+#define MIPS34K_MISSED_ITLB_WAR                0
+
+#endif /* __ASM_MIPS_MACH_PNX8550_WAR_H */
diff -urN --exclude=.svn linux-2.6.26-rc4.orig/include/linux/i2c-id.h
linux-2.6.26-rc4/include/linux/i2c-id.h
--- linux-2.6.26-rc4.orig/include/linux/i2c-id.h        2008-06-05
11:41:44.000000000 +0100
+++ linux-2.6.26-rc4/include/linux/i2c-id.h     2008-06-04
09:33:51.000000000 +0100
@@ -129,6 +129,7 @@

 /* --- PCA 9564 based algorithms */
 #define I2C_HW_A_ISA           0x1a0000 /* generic ISA Bus interface card */
+#define I2C_HW_A_PNX0105       0x1a0001 /* NXP PNX833X SoC I2C */

 /* --- PowerPC on-chip adapters
         */
 #define I2C_HW_OCP             0x120000 /* IBM on-chip I2C adapter */
diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/include/linux/i2c-pnx0105.h
linux-2.6.26-rc4/include/linux/i2c-pnx0105.h
--- linux-2.6.26-rc4.orig/include/linux/i2c-pnx0105.h   1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.26-rc4/include/linux/i2c-pnx0105.h        2008-06-05
09:32:31.000000000 +0100
@@ -0,0 +1,58 @@
+/*
+ *  i2c-pnx0105.h: driver for PNX833X I2C (IP0105 Block)
+ *    Copyright (C) 2006 Nikita Youshchenko <yoush@debian.org>
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
+#ifndef _LINUX_I2C_PNX0105_H
+#define _LINUX_I2C_PNX0105_H
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-pca.h>
+#include <linux/wait.h>
+
+struct i2c_pnx0105_dev {
+       unsigned long base;
+       int irq;
+       unsigned char clock;    /* value to write to freq bits of control reg */
+       unsigned char bus_addr; /* bus address for slave mode; currently not
supported */
+
+       int timeout;            /* non-zero when timeout was detected */
+       wait_queue_head_t wait;
+
+       struct i2c_algo_pca_data algo_data;
+       struct i2c_adapter adap;
+};
+
+/* Register area size */
+#define I2C_PNX0105_IO_SIZE            0x1000
+
+/* Register offsets */
+#define I2C_PNX0105_CONTROL     0x0000
+#define I2C_PNX0105_DAT         0x0004
+#define I2C_PNX0105_STATUS             0x0008
+#define I2C_PNX0105_ADDRESS            0x000C
+#define I2C_PNX0105_STOP               0x0010
+#define I2C_PNX0105_PD          0x0014
+#define I2C_PNX0105_SET_PINS   0x0018
+#define I2C_PNX0105_OBS_PINS   0x001C
+#define I2C_PNX0105_INT_STATUS 0x0FE0
+#define I2C_PNX0105_INT_ENABLE 0x0FE4
+#define I2C_PNX0105_INT_CLEAR  0x0FE8
+#define I2C_PNX0105_INT_SET            0x0FEC
+#define I2C_PNX0105_POWER_DOWN 0x0FF4
+#define I2C_PNX0105_MODULE_ID  0x0FFC
+
+#endif
