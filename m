Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2009 19:42:13 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:42819 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023103AbZFGSjW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2009 19:39:22 +0100
Received: by mail-fx0-f223.google.com with SMTP id 23so2654437fxm.0
        for <multiple recipients>; Sun, 07 Jun 2009 11:39:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l3vd4NDCk657WR6APw5EkwL+waLEiDrSstJUZonEpcQ=;
        b=jnh30NsNZs7r50KDmAfc01IWagp7ZfjYFs8d5aghpbSd8cJpaL1JHejBdpRTOWStFD
         UXHR1QxtcvQ7F0qhXvN9DukXWkPymPKYsn+tIIQlvPB8kbMcCyfbu8HOxgDYl5tzSH1v
         66gcg3kLnOSvI8Bgj2+5tUaBs1htRuqZJOojk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BomXFHDXy2bnwfg/tXEVkHdve56QHcgMNjpytt/3VL5+xY93flQVSFf7zkiv+nMlP0
         aX6AjwjPjAeUagEIe0aIKw3kJvMSh0sxKMc1/0+8ifjg8scQBirNKUPdSct5gwP32doI
         TjPYyRmKOykccnRBC4ZGO1bKb0pbxNZbW45lU=
Received: by 10.86.59.2 with SMTP id h2mr6223428fga.73.1244399962124;
        Sun, 07 Jun 2009 11:39:22 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 12sm421510fgg.0.2009.06.07.11.39.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 11:39:21 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 7/7] Alchemy: db1200 defconfig update.
Date:	Sun,  7 Jun 2009 20:39:04 +0200
Message-Id: <1244399944-29043-8-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244399944-29043-7-git-send-email-manuel.lauss@gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-6-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-7-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

With all supported goodness enabled.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/configs/db1200_defconfig | 1620 ++++++++++++++++++++++--------------
 1 files changed, 983 insertions(+), 637 deletions(-)

diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index ab17973..a748764 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -1,79 +1,97 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:25 2007
+# Linux kernel version: 2.6.30-rc8
+# Sun Jun  7 17:29:04 2009
 #
 CONFIG_MIPS=y
 
 #
 # Machine selection
 #
-CONFIG_ZONE_DMA=y
 CONFIG_MACH_ALCHEMY=y
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
-CONFIG_MIPS_DB1200=y
-# CONFIG_MIPS_MIRAGE is not set
 # CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_MALTA is not set
-# CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
-# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_NEC_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
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
-# CONFIG_SIBYTE_SWARM is not set
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
 # CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
 # CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
+# CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+CONFIG_ALCHEMY_GPIO_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+CONFIG_MIPS_DB1200=y
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1200=y
+CONFIG_SOC_AU1X00=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_COHERENT=y
+# CONFIG_HOTPLUG_CPU is not set
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1200=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -86,6 +104,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -93,11 +112,13 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -107,12 +128,12 @@ CONFIG_32BIT=y
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_64BIT_PHYS_ADDR=y
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
@@ -120,168 +141,189 @@ CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_CPU_SUPPORTS_HIGHMEM=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
-# CONFIG_HZ_100 is not set
+CONFIG_HZ_100=y
 # CONFIG_HZ_128 is not set
 # CONFIG_HZ_250 is not set
 # CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
+# CONFIG_HZ_1000 is not set
 # CONFIG_HZ_1024 is not set
 CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_KEXEC is not set
+# CONFIG_SECCOMP is not set
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
-CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION="-db1200"
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_SYSFS_DEPRECATED=y
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=18
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_STRIP_ASM_SYMS=y
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_AIO=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_SLOW_WORK is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_KMOD=y
-
-#
-# Block layer
-#
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
+# CONFIG_PCMCIA_IOCTL is not set
 
 #
 # PC-card bridges
 #
-CONFIG_PCMCIA_AU1X00=m
-
-#
-# PCI Hotplug Support
-#
+# CONFIG_PCMCIA_AU1X00 is not set
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+# CONFIG_HAVE_AOUT is not set
+CONFIG_BINFMT_MISC=y
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_APM_EMULATION is not set
 CONFIG_NET=y
 
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
+CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
-# CONFIG_XFRM_SUB_POLICY is not set
-CONFIG_XFRM_MIGRATE=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
+# CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
-# CONFIG_IP_PNP is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -292,107 +334,41 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_CUBIC=y
-CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_CUBIC is not set
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+CONFIG_TCP_CONG_HSTCP=y
+# CONFIG_TCP_CONG_HYBLA is not set
+# CONFIG_TCP_CONG_VEGAS is not set
+# CONFIG_TCP_CONG_SCALABLE is not set
+# CONFIG_TCP_CONG_LP is not set
+# CONFIG_TCP_CONG_VENO is not set
+# CONFIG_TCP_CONG_YEAH is not set
+# CONFIG_TCP_CONG_ILLINOIS is not set
+# CONFIG_DEFAULT_BIC is not set
+# CONFIG_DEFAULT_CUBIC is not set
+# CONFIG_DEFAULT_HTCP is not set
+# CONFIG_DEFAULT_VEGAS is not set
+# CONFIG_DEFAULT_WESTWOOD is not set
+CONFIG_DEFAULT_RENO=y
+CONFIG_DEFAULT_TCP_CONG="reno"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
-
-#
-# Core Netfilter Configuration
-#
-# CONFIG_NETFILTER_NETLINK is not set
-CONFIG_NF_CONNTRACK_ENABLED=m
-CONFIG_NF_CONNTRACK_SUPPORT=y
-# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
-CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_ACCT=y
-CONFIG_NF_CONNTRACK_MARK=y
-CONFIG_NF_CONNTRACK_SECMARK=y
-CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_GRE=m
-CONFIG_NF_CT_PROTO_SCTP=m
-CONFIG_NF_CONNTRACK_AMANDA=m
-CONFIG_NF_CONNTRACK_FTP=m
-CONFIG_NF_CONNTRACK_H323=m
-CONFIG_NF_CONNTRACK_IRC=m
-# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
-CONFIG_NF_CONNTRACK_PPTP=m
-CONFIG_NF_CONNTRACK_SANE=m
-CONFIG_NF_CONNTRACK_SIP=m
-CONFIG_NF_CONNTRACK_TFTP=m
-CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
-CONFIG_NETFILTER_XT_TARGET_NFLOG=m
-CONFIG_NETFILTER_XT_TARGET_SECMARK=m
-CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
-CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
-CONFIG_NETFILTER_XT_MATCH_DSCP=m
-CONFIG_NETFILTER_XT_MATCH_ESP=m
-CONFIG_NETFILTER_XT_MATCH_HELPER=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_LIMIT=m
-CONFIG_NETFILTER_XT_MATCH_MAC=m
-CONFIG_NETFILTER_XT_MATCH_MARK=m
-CONFIG_NETFILTER_XT_MATCH_POLICY=m
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
-CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
-CONFIG_NETFILTER_XT_MATCH_QUOTA=m
-CONFIG_NETFILTER_XT_MATCH_REALM=m
-CONFIG_NETFILTER_XT_MATCH_SCTP=m
-CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
-CONFIG_NETFILTER_XT_MATCH_STRING=m
-CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
-
-#
-# IP: Netfilter Configuration
-#
-CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_NF_CONNTRACK_PROC_COMPAT=y
-# CONFIG_IP_NF_QUEUE is not set
-# CONFIG_IP_NF_IPTABLES is not set
-# CONFIG_IP_NF_ARPTABLES is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -402,21 +378,25 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
 # CONFIG_NET_SCHED is not set
-CONFIG_NET_CLS_ROUTE=y
+# CONFIG_DCB is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_MAC80211_RC_DEFAULT_PID is not set
+# CONFIG_MAC80211_RC_DEFAULT_MINSTREL is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -425,25 +405,24 @@ CONFIG_NET_CLS_ROUTE=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -456,6 +435,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -481,19 +461,21 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
-# CONFIG_MTD_PHYSMAP is not set
-CONFIG_MTD_ALCHEMY=y
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_DATAFLASH is not set
+CONFIG_MTD_M25P80=y
+CONFIG_M25PXX_USE_FAST_READ=y
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -505,224 +487,132 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
 # CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_AU1550 is not set
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
-
-#
-# OneNAND Flash Device Drivers
-#
+CONFIG_MTD_NAND_PLATFORM=y
+# CONFIG_MTD_ALAUDA is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
-# Parallel port support
+# LPDDR flash memory drivers
 #
-# CONFIG_PARPORT is not set
+# CONFIG_MTD_LPDDR is not set
 
 #
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-# CONFIG_BLK_DEV_INITRD is not set
-# CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-
-#
-# ATA/ATAPI/MFM/RLL support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 CONFIG_IDE=y
-CONFIG_IDE_MAX_HWIFS=4
-CONFIG_BLK_DEV_IDE=y
 
 #
-# Please see Documentation/ide.txt for help/info on IDE drives
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
+CONFIG_IDE_XFER_MODE=y
+CONFIG_IDE_ATAPI=y
 # CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-CONFIG_IDEDISK_MULTI_MODE=y
-CONFIG_BLK_DEV_IDECS=m
-# CONFIG_BLK_DEV_IDECD is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_BLK_DEV_IDESCSI is not set
-# CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_TASK_IOCTL=y
+# CONFIG_IDE_PROC_FS is not set
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
 CONFIG_BLK_DEV_IDE_AU1XXX=y
 CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA=y
 # CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is not set
-CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
-# CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-CONFIG_SCSI=y
-CONFIG_SCSI_TGT=m
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
-CONFIG_SCSI_PROC_FS=y
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=y
-# CONFIG_CHR_DEV_ST is not set
-# CONFIG_CHR_DEV_OSST is not set
-CONFIG_BLK_DEV_SR=y
-# CONFIG_BLK_DEV_SR_VENDOR is not set
-CONFIG_CHR_DEV_SG=y
-# CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-CONFIG_SCSI_MULTI_LUN=y
-# CONFIG_SCSI_CONSTANTS is not set
-# CONFIG_SCSI_LOGGING is not set
-CONFIG_SCSI_SCAN_ASYNC=y
-
-#
-# SCSI Transports
-#
-# CONFIG_SCSI_SPI_ATTRS is not set
-# CONFIG_SCSI_FC_ATTRS is not set
-# CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
-# CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_DEBUG is not set
-
-#
-# PCMCIA SCSI adapter support
-#
-# CONFIG_PCMCIA_AHA152X is not set
-# CONFIG_PCMCIA_FDOMAIN is not set
-# CONFIG_PCMCIA_NINJA_SCSI is not set
-# CONFIG_PCMCIA_QLOGIC is not set
-# CONFIG_PCMCIA_SYM53C500 is not set
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
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_COMPAT_NET_DEV_OPS is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
+# CONFIG_VETH is not set
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_MIPS_AU1X00_ENET is not set
-# CONFIG_SMC91X is not set
+CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# PCMCIA network device support
-#
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+CONFIG_WLAN_80211=y
+# CONFIG_PCMCIA_RAYCS is not set
+# CONFIG_LIBERTAS is not set
+# CONFIG_ATMEL is not set
+# CONFIG_AIRO_CS is not set
+# CONFIG_PCMCIA_WL3501 is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_USB_NET_RNDIS_WLAN is not set
+# CONFIG_HOSTAP is not set
+# CONFIG_HERMES is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_NET_PCMCIA is not set
-
-#
-# Wan interfaces
-#
 # CONFIG_WAN is not set
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
@@ -730,16 +620,13 @@ CONFIG_MII=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+CONFIG_INPUT_POLLDEV=m
 
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -749,28 +636,26 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=y
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
 CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
 
 #
 # Serial drivers
@@ -778,33 +663,22 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_CS is not set
-CONFIG_SERIAL_8250_NR_UARTS=4
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 # CONFIG_SERIAL_8250_EXTENDED is not set
 CONFIG_SERIAL_8250_AU1X00=y
 
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+# CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
 #
@@ -813,223 +687,570 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
 # CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
 
 #
-# TPM devices
+# I2C Algorithms
 #
-# CONFIG_TCG_TPM is not set
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_AU1550=y
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
 
 #
-# I2C support
+# Miscellaneous I2C Chip support
 #
-# CONFIG_I2C is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
 
 #
-# SPI support
+# SPI Master Controller Drivers
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI_AU1550=y
+CONFIG_SPI_BITBANG=y
+# CONFIG_SPI_GPIO is not set
 
 #
-# Dallas's 1-wire bus
+# SPI Protocol Masters
 #
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=y
+# CONFIG_SENSORS_AD7414 is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADCXX is not set
+# CONFIG_SENSORS_ADM1021 is not set
+CONFIG_SENSORS_ADM1025=y
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+CONFIG_SENSORS_LM70=y
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_MAX1111 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_SHT15 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_LIS3_SPI is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Hardware Monitoring support
+# Sonics Silicon Backplane
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multimedia drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_DAB is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
-CONFIG_FB_CFB_FILLRECT=y
-CONFIG_FB_CFB_COPYAREA=y
-CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+CONFIG_FB_SYS_FILLRECT=y
+CONFIG_FB_SYS_COPYAREA=y
+CONFIG_FB_SYS_IMAGEBLIT=y
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+CONFIG_FB_SYS_FOPS=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_AU1200=y
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Console display driver support
+# Display device support
 #
-CONFIG_VGA_CONSOLE=y
-# CONFIG_VGACON_SOFT_SCROLLBACK is not set
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
-# Logo configuration
+# Console display driver support
 #
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+CONFIG_FONT_8x16=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
 CONFIG_LOGO=y
-CONFIG_LOGO_LINUX_MONO=y
-CONFIG_LOGO_LINUX_VGA16=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_SOUND=y
+# CONFIG_SOUND_OSS_CORE is not set
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+CONFIG_SND_HRTIMER=y
+CONFIG_SND_DYNAMIC_MINORS=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_SND_VERBOSE_PROCFS=y
+CONFIG_SND_VERBOSE_PRINTK=y
+# CONFIG_SND_DEBUG is not set
+CONFIG_SND_VMASTER=y
+CONFIG_SND_AC97_CODEC=y
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_MIPS is not set
+# CONFIG_SND_USB is not set
+# CONFIG_SND_PCMCIA is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_AC97_BUS=y
+CONFIG_SND_SOC_AU1XPSC=y
+CONFIG_SND_SOC_AU1XPSC_I2S=y
+CONFIG_SND_SOC_AU1XPSC_AC97=y
+CONFIG_SND_SOC_DB1200=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+# CONFIG_SND_SOC_ALL_CODECS is not set
+CONFIG_SND_SOC_AC97_CODEC=y
+CONFIG_SND_SOC_WM8731=y
+# CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=y
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+CONFIG_HIDRAW=y
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+CONFIG_USB_HIDDEV=y
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_DRAGONRISE_FF is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_NTRIG is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_GREENASIA_FF is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_THRUSTMASTER_FF is not set
+# CONFIG_ZEROPLUS_FF is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# Sound
+# Miscellaneous USB options
 #
-# CONFIG_SOUND is not set
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_SUSPEND=y
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
-# HID Devices
+# USB Host Controller Drivers
 #
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
+# CONFIG_USB_C67X00_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+# CONFIG_USB_OXU210HP_HCD is not set
+CONFIG_USB_EHCI_NO_IO_WATCHDOG=y
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# USB support
+# USB Device Class drivers
 #
-CONFIG_USB_ARCH_HAS_HCD=y
-CONFIG_USB_ARCH_HAS_OHCI=y
-CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 
 #
-# USB Gadget Support
+# also be needed; see USB_STORAGE Help for more info
 #
-CONFIG_USB_GADGET=m
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA2XX is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-# CONFIG_USB_GADGET_DUALSPEED is not set
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# MMC/SD Card support
+# USB Imaging devices
 #
-CONFIG_MMC=y
-# CONFIG_MMC_DEBUG is not set
-CONFIG_MMC_BLOCK=y
-CONFIG_MMC_AU1X=y
+# CONFIG_USB_MDC800 is not set
 
 #
-# LED devices
+# USB port drivers
 #
-# CONFIG_NEW_LEDS is not set
+# CONFIG_USB_SERIAL is not set
 
 #
-# LED drivers
+# USB Miscellaneous drivers
 #
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 
 #
-# LED Triggers
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD/SDIO Card Drivers
 #
+CONFIG_MMC_BLOCK=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_SDIO_UART=y
+# CONFIG_MMC_TEST is not set
 
 #
-# InfiniBand support
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_AU1X=y
+# CONFIG_MMC_SPI is not set
+# CONFIG_MEMSTICK is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
 #
+# CONFIG_LEDS_PCA9532 is not set
+# CONFIG_LEDS_GPIO is not set
+# CONFIG_LEDS_LP5521 is not set
+# CONFIG_LEDS_PCA955X is not set
+# CONFIG_LEDS_DAC124S085 is not set
+# CONFIG_LEDS_BD2802 is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+# LED Triggers
 #
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+# CONFIG_LEDS_TRIGGER_IDE_DISK is not set
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
 
 #
-# Real Time Clock
+# iptables trigger is under Netfilter config (LED target)
 #
-# CONFIG_RTC_CLASS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
 
 #
-# DMA Engine support
+# RTC interfaces
 #
-# CONFIG_DMA_ENGINE is not set
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
 
 #
-# DMA Clients
+# I2C RTC drivers
 #
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
 
 #
-# DMA Devices
+# SPI RTC drivers
 #
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
 
 #
-# Auxiliary Display support
+# Platform RTC drivers
 #
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Virtualization
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-# CONFIG_EXT2_FS_SECURITY is not set
+# CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_EXT4DEV_FS is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
 # CONFIG_REISERFS_FS is not set
-CONFIG_JFS_FS=y
-# CONFIG_JFS_POSIX_ACL is not set
-# CONFIG_JFS_SECURITY is not set
-# CONFIG_JFS_DEBUG is not set
-# CONFIG_JFS_STATISTICS is not set
+# CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
+CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
-CONFIG_GENERIC_ACL=y
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_UDF_NLS=y
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
@@ -1040,16 +1261,13 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
+# CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
-
-#
-# Miscellaneous filesystems
-#
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_ECRYPT_FS is not set
@@ -1061,119 +1279,191 @@ CONFIG_CONFIGFS_FS=m
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
-# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
 # CONFIG_JFFS2_FS_XATTR is not set
-# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
 CONFIG_JFFS2_RTIME=y
-# CONFIG_JFFS2_RUBIN is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_RUBIN=y
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_CRAMFS is not set
+CONFIG_SQUASHFS=y
+# CONFIG_SQUASHFS_EMBEDDED is not set
+CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+# CONFIG_NILFS2_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+CONFIG_NFSD_V4=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_RPCSEC_GSS_KRB5 is not set
-# CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=y
-# CONFIG_SMB_NLS_DEFAULT is not set
-# CONFIG_CIFS is not set
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+CONFIG_RPCSEC_GSS_SPKM3=y
+# CONFIG_SMB_FS is not set
+CONFIG_CIFS=y
+# CONFIG_CIFS_STATS is not set
+CONFIG_CIFS_WEAK_PW_HASH=y
+CONFIG_CIFS_UPCALL=y
+CONFIG_CIFS_XATTR=y
+CONFIG_CIFS_POSIX=y
+# CONFIG_CIFS_DEBUG2 is not set
+CONFIG_CIFS_DFS_UPCALL=y
+CONFIG_CIFS_EXPERIMENTAL=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
 #
-# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+CONFIG_LDM_PARTITION=y
+# CONFIG_LDM_DEBUG is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SYSV68_PARTITION is not set
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=m
-CONFIG_NLS_CODEPAGE_737=m
-CONFIG_NLS_CODEPAGE_775=m
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_CODEPAGE_852=m
-CONFIG_NLS_CODEPAGE_855=m
-CONFIG_NLS_CODEPAGE_857=m
-CONFIG_NLS_CODEPAGE_860=m
-CONFIG_NLS_CODEPAGE_861=m
-CONFIG_NLS_CODEPAGE_862=m
-CONFIG_NLS_CODEPAGE_863=m
-CONFIG_NLS_CODEPAGE_864=m
-CONFIG_NLS_CODEPAGE_865=m
-CONFIG_NLS_CODEPAGE_866=m
-CONFIG_NLS_CODEPAGE_869=m
-CONFIG_NLS_CODEPAGE_936=m
-CONFIG_NLS_CODEPAGE_950=m
-CONFIG_NLS_CODEPAGE_932=m
-CONFIG_NLS_CODEPAGE_949=m
-CONFIG_NLS_CODEPAGE_874=m
-CONFIG_NLS_ISO8859_8=m
-CONFIG_NLS_CODEPAGE_1250=m
-CONFIG_NLS_CODEPAGE_1251=m
-CONFIG_NLS_ASCII=m
-CONFIG_NLS_ISO8859_1=m
-CONFIG_NLS_ISO8859_2=m
-CONFIG_NLS_ISO8859_3=m
-CONFIG_NLS_ISO8859_4=m
-CONFIG_NLS_ISO8859_5=m
-CONFIG_NLS_ISO8859_6=m
-CONFIG_NLS_ISO8859_7=m
-CONFIG_NLS_ISO8859_9=m
-CONFIG_NLS_ISO8859_13=m
-CONFIG_NLS_ISO8859_14=m
-CONFIG_NLS_ISO8859_15=m
-CONFIG_NLS_KOI8_R=m
-CONFIG_NLS_KOI8_U=m
-CONFIG_NLS_UTF8=m
-
-#
-# Distributed Lock Manager
-#
-CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
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
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+CONFIG_NLS_ISO8859_15=y
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_MUST_CHECK=y
-# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=48M"
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_IRQ_DEBUG is not set
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_TRACING_SUPPORT=y
+
+#
+# Tracers
+#
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_TRACE_BRANCH_PROFILING is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_CMDLINE="console=ttyS0,115200 console=tty video=au1200fb:panel:bs"
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
 
 #
 # Security options
@@ -1181,67 +1471,123 @@ CONFIG_CMDLINE="mem=48M"
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_SECURITY_FILE_CAPABILITIES=y
+CONFIG_CRYPTO=y
 
 #
-# Cryptographic options
+# Crypto core or helper
 #
-CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=m
-CONFIG_CRYPTO_MANAGER=m
-CONFIG_CRYPTO_HMAC=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_TWOFISH_COMMON=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-CONFIG_CRYPTO_CAMELLIA=m
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
-# Hardware crypto devices
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
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
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
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
+CONFIG_CRYPTO_CAST5=y
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=y
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
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_ZLIB=y
+CONFIG_CRYPTO_LZO=y
+
+#
+# Random Number Generation
 #
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
-- 
1.6.3.1
