Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 17:32:22 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:44929 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491825Ab0BZQcA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 17:32:00 +0100
Received: by bwz7 with SMTP id 7so225123bwz.24
        for <multiple recipients>; Fri, 26 Feb 2010 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=tRPQBSRsGqtkor9KjHH5CcEN+82DXJmI2tiMxn5YZ8M=;
        b=cJCuhSurvICqHKomGSLLgwKzIydTKoem/SaPm5vnXot14KmbK5HVydUhwICilefrfx
         jCeAwpwR7jbTRKfKR3aIcFO4Q+2K54kLZFUzWG4kQ7h0Pq+eFjAmGJcTtvWpWEvtd01I
         Gb7OfCEIIz4fh33dkg0OC66lxtZgUpDiMyC3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=r8jCvtzJxaue8Ncnnj2YshStnk/NrWS3cTFc17ZdoOAxoPSNYMngKDpMxj0SGWzLFP
         ywudl7ywKs46fWco2aLNphmliuRd91mhzzLoJf7gaghh0DNvwJHVMkm9fkXCLhHhobge
         tY1IQgktnOKFiMgwfN5Pl0IcydcsBOxrYcj4k=
Received: by 10.204.33.135 with SMTP id h7mr431572bkd.186.1267201906575;
        Fri, 26 Feb 2010 08:31:46 -0800 (PST)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 14sm159936bwz.2.2010.02.26.08.31.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 08:31:45 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: defconfig updates
Date:   Fri, 26 Feb 2010 17:32:45 +0100
Message-Id: <1267201965-28332-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

updated, leaner defconfig for the alchemy development boards.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/configs/db1000_defconfig | 1150 ++++++++++++++-------------
 arch/mips/configs/db1100_defconfig | 1137 ++++++++++++++-------------
 arch/mips/configs/db1200_defconfig |  179 ++++-
 arch/mips/configs/db1500_defconfig | 1372 ++++++++++++++------------------
 arch/mips/configs/db1550_defconfig | 1380 ++++++++++++++++++--------------
 arch/mips/configs/pb1100_defconfig | 1159 ++++++++++++++-------------
 arch/mips/configs/pb1200_defconfig | 1568 ++++++++++++++++++++++++++++++++++++
 arch/mips/configs/pb1500_defconfig | 1324 ++++++++++++++++--------------
 arch/mips/configs/pb1550_defconfig | 1354 +++++++++++++++++--------------
 9 files changed, 6340 insertions(+), 4283 deletions(-)
 create mode 100644 arch/mips/configs/pb1200_defconfig

diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 68e90cd..f66d406 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -1,78 +1,102 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:24 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 08:46:14 2010
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
-CONFIG_MIPS_DB1000=y
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+CONFIG_MIPS_DB1000=y
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1000=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1000=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -85,6 +109,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -92,11 +117,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -106,184 +134,244 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-db1000"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_LBDAF is not set
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
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 # CONFIG_PCI is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
+# CONFIG_PCMCIA_IOCTL is not set
 
 #
 # PC-card bridges
 #
 # CONFIG_PCMCIA_AU1X00 is not set
-
-#
-# PCI Hotplug Support
-#
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -294,110 +382,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -407,27 +410,24 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -436,25 +436,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
-# CONFIG_MTD_CMDLINE_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -467,6 +467,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -492,14 +493,13 @@ CONFIG_MTD_CFI_UTIL=y
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
@@ -516,174 +516,115 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
 # CONFIG_MTD_ONENAND is not set
 
 #
-# Parallel port support
+# LPDDR flash memory drivers
 #
-# CONFIG_PARPORT is not set
+# CONFIG_MTD_LPDDR is not set
 
 #
-# Plug and Play support
+# UBI - Unsorted block images
 #
-# CONFIG_PNPACPI is not set
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
 
 #
-# Block devices
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
 #
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
-
-#
-# Misc devices
-#
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
 CONFIG_PHYLIB=y
 
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_SMC91X is not set
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
-CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_3C589=m
-CONFIG_PCMCIA_3C574=m
-CONFIG_PCMCIA_FMVJ18X=m
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PCMCIA_NMCLAN=m
-CONFIG_PCMCIA_SMC91C92=m
-CONFIG_PCMCIA_XIRC2PS=m
-CONFIG_PCMCIA_AXNET=m
-
-#
-# Wan interfaces
-#
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
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
+# CONFIG_NET_PCMCIA is not set
 # CONFIG_WAN is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
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
@@ -691,16 +632,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -710,35 +649,33 @@ CONFIG_INPUT_EVDEV=y
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
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
 CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
-CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
 
 #
 # Serial drivers
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_CS=m
+# CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -750,198 +687,291 @@ CONFIG_SERIAL_8250_AU1X00=y
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
 # PCMCIA character devices
 #
-CONFIG_SYNCLINK_CS=m
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
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
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 
 #
-# Dallas's 1-wire bus
+# PPS support
 #
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
-
-#
-# Console display driver support
-#
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_DUMMY_CONSOLE=y
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
+# Display device support
 #
-# CONFIG_SOUND is not set
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
-# HID Devices
-#
-# CONFIG_HID is not set
-
-#
-# USB support
+# Console display driver support
 #
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+# CONFIG_USB_HIDDEV is not set
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
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
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
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Miscellaneous USB options
 #
+# CONFIG_USB_DEVICEFS is not set
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
-# USB Gadget Support
+# USB Host Controller Drivers
 #
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# MMC/SD Card support
+# USB Device Class drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# LED devices
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-# CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED Triggers
+# USB Imaging devices
 #
+# CONFIG_USB_MDC800 is not set
 
 #
-# InfiniBand support
+# USB port drivers
 #
+# CONFIG_USB_SERIAL is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
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
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 
 #
-# Real Time Clock
+# OTG and related infrastructure
 #
-# CONFIG_RTC_CLASS is not set
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
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
+# SPI RTC drivers
 #
 
 #
-# DMA Devices
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Auxiliary Display support
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Virtualization
+# TI VLYNQ
 #
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
 CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_EXT4DEV_FS is not set
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -960,74 +990,65 @@ CONFIG_GENERIC_ACL=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_CRAMFS=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
+CONFIG_NLS_CODEPAGE_850=y
 # CONFIG_NLS_CODEPAGE_852 is not set
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
@@ -1045,10 +1066,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=y
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1058,38 +1079,75 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
+CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
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
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1097,67 +1155,29 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+# CONFIG_SECURITYFS is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index 9081283..abb9a58 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -1,78 +1,102 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:24 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 08:50:15 2010
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
-CONFIG_MIPS_DB1100=y
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+CONFIG_MIPS_DB1100=y
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1100=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1100=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -85,6 +109,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -92,11 +117,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -106,173 +134,242 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-db1100"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_LBDAF is not set
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
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+# CONFIG_PCMCIA_IOCTL is not set
 
 #
-# PCCARD (PCMCIA/CardBus) support
-#
-# CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
+# PC-card bridges
 #
+# CONFIG_PCMCIA_AU1X00 is not set
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -283,110 +380,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -396,27 +408,24 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -425,25 +434,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -456,6 +465,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -481,14 +491,13 @@ CONFIG_MTD_CFI_UTIL=y
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
@@ -505,161 +514,123 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
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
+# UBI - Unsorted block images
 #
-# Block devices
-#
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
 
 #
-# Misc devices
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+# CONFIG_BLK_DEV_IDECS is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+CONFIG_IDE_TASK_IOCTL=y
+CONFIG_IDE_PROC_FS=y
 
 #
-# ATA/ATAPI/MFM/RLL support
+# IDE chipset support/bugfixes
 #
-# CONFIG_IDE is not set
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
 CONFIG_PHYLIB=y
 
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_SMC91X is not set
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
-# Wan interfaces
-#
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
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
+# CONFIG_NET_PCMCIA is not set
 # CONFIG_WAN is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
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
@@ -667,16 +638,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -686,34 +655,33 @@ CONFIG_INPUT_EVDEV=y
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
-CONFIG_SERIO_LIBPS2=m
-CONFIG_SERIO_RAW=m
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
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -725,78 +693,91 @@ CONFIG_SERIAL_8250_AU1X00=y
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
-# CONFIG_RAW_DRIVER is not set
 
 #
-# TPM devices
+# PCMCIA character devices
 #
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
+# CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 
 #
-# Dallas's 1-wire bus
+# PPS support
 #
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
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
 CONFIG_FB_AU1100=y
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -804,9 +785,10 @@ CONFIG_FB_AU1100=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
+# CONFIG_FONT_8x8 is not set
 CONFIG_FONT_8x16=y
 # CONFIG_FONT_6x11 is not set
 # CONFIG_FONT_7x14 is not set
@@ -816,132 +798,186 @@ CONFIG_FONT_8x16=y
 # CONFIG_FONT_SUN8x16 is not set
 # CONFIG_FONT_SUN12x22 is not set
 # CONFIG_FONT_10x18 is not set
-
-#
-# Logo configuration
-#
-CONFIG_LOGO=y
-CONFIG_LOGO_LINUX_MONO=y
-CONFIG_LOGO_LINUX_VGA16=y
-CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Sound
-#
+# CONFIG_LOGO is not set
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
-# CONFIG_HID is not set
-
-#
-# USB support
-#
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Miscellaneous USB options
 #
+# CONFIG_USB_DEVICEFS is not set
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
-# USB Gadget Support
+# USB Host Controller Drivers
 #
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# MMC/SD Card support
+# USB Device Class drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# LED devices
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-# CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED Triggers
+# USB Imaging devices
 #
+# CONFIG_USB_MDC800 is not set
 
 #
-# InfiniBand support
+# USB port drivers
 #
+# CONFIG_USB_SERIAL is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
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
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 
 #
-# Real Time Clock
+# OTG and related infrastructure
 #
-# CONFIG_RTC_CLASS is not set
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
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
+# SPI RTC drivers
 #
 
 #
-# DMA Devices
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Auxiliary Display support
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Virtualization
+# TI VLYNQ
 #
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
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -960,69 +996,76 @@ CONFIG_GENERIC_ACL=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_FS_POSIX_ACL=y
+CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_437 is not set
 # CONFIG_NLS_CODEPAGE_737 is not set
@@ -1062,34 +1105,71 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
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
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1097,67 +1177,32 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 51abc6e..991c20a 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc5
-# Mon Nov  2 21:09:28 2009
+# Linux kernel version: 2.6.33
+# Fri Feb 26 10:18:09 2010
 #
 CONFIG_MIPS=y
 
@@ -27,6 +27,7 @@ CONFIG_MACH_ALCHEMY=y
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
+# CONFIG_POWERTV is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP28 is not set
@@ -46,7 +47,7 @@ CONFIG_MACH_ALCHEMY=y
 # CONFIG_WR_PPMC is not set
 # CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
 # CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
-CONFIG_ALCHEMY_GPIO_AU1000=y
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
 # CONFIG_ALCHEMY_GPIO_INDIRECT is not set
 # CONFIG_MIPS_MTX1 is not set
 # CONFIG_MIPS_BOSPORUS is not set
@@ -64,6 +65,7 @@ CONFIG_MIPS_DB1200=y
 # CONFIG_MIPS_XXS1500 is not set
 CONFIG_SOC_AU1200=y
 CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -79,7 +81,6 @@ CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_CEVT_R4K_LIB=y
 CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_COHERENT=y
-CONFIG_EARLY_PRINTK=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
 # CONFIG_NO_IOPORT is not set
@@ -95,6 +96,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CPU selection
 #
 # CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -116,6 +118,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
 # CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
@@ -138,6 +141,7 @@ CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 CONFIG_64BIT_PHYS_ADDR=y
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -152,11 +156,9 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_PHYS_ADDR_T_64BIT=y
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 CONFIG_KSM=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
@@ -190,6 +192,14 @@ CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION="-db1200"
 CONFIG_LOCALVERSION_AUTO=y
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
@@ -202,14 +212,12 @@ CONFIG_POSIX_MQUEUE_SYSCTL=y
 #
 # RCU Subsystem
 #
-CONFIG_TREE_RCU=y
+# CONFIG_TREE_RCU is not set
 # CONFIG_TREE_PREEMPT_RCU is not set
-# CONFIG_RCU_TRACE is not set
-CONFIG_RCU_FANOUT=32
-CONFIG_RCU_FANOUT_EXACT=y
+CONFIG_TINY_RCU=y
 # CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_LOG_BUF_SHIFT=18
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
 # CONFIG_SYSFS_DEPRECATED_V2 is not set
@@ -240,10 +248,9 @@ CONFIG_AIO=y
 # Kernel Performance Events And Counters
 #
 # CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
-# CONFIG_SLAB is not set
-CONFIG_SLUB=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
 CONFIG_HAVE_OPROFILE=y
@@ -252,7 +259,8 @@ CONFIG_HAVE_OPROFILE=y
 # GCOV-based kernel profiling
 #
 # CONFIG_SLOW_WORK is not set
-# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
@@ -270,14 +278,41 @@ CONFIG_BLOCK=y
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
@@ -286,7 +321,6 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
 CONFIG_PCCARD=y
-# CONFIG_PCMCIA_DEBUG is not set
 CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
 # CONFIG_PCMCIA_IOCTL is not set
@@ -342,7 +376,7 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
+CONFIG_INET_LRO=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
@@ -382,8 +416,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 # CONFIG_WIRELESS is not set
-# CONFIG_MAC80211_RC_DEFAULT_PID is not set
-# CONFIG_MAC80211_RC_DEFAULT_MINSTREL is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
@@ -402,6 +434,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 CONFIG_FIRMWARE_IN_KERNEL=y
 CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -433,9 +467,6 @@ CONFIG_MTD_CFI=y
 # CONFIG_MTD_JEDECPROBE is not set
 CONFIG_MTD_GEN_PROBE=y
 # CONFIG_MTD_CFI_ADV_OPTIONS is not set
-# CONFIG_MTD_CFI_NOSWAP is not set
-# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
-# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
 CONFIG_MTD_MAP_BANK_WIDTH_1=y
 CONFIG_MTD_MAP_BANK_WIDTH_2=y
 CONFIG_MTD_MAP_BANK_WIDTH_4=y
@@ -505,6 +536,10 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_UB=y
 # CONFIG_BLK_DEV_RAM is not set
@@ -566,6 +601,7 @@ CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
 # CONFIG_ENC28J60 is not set
 # CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
 # CONFIG_DNET is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
@@ -610,14 +646,12 @@ CONFIG_SMC91X=y
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
@@ -723,13 +757,13 @@ CONFIG_I2C_AU1550=y
 #
 # Miscellaneous I2C Chip support
 #
-# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
 
 #
@@ -738,6 +772,8 @@ CONFIG_SPI_MASTER=y
 CONFIG_SPI_AU1550=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_SPI_GPIO is not set
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
 
 #
 # SPI Protocol Masters
@@ -751,6 +787,7 @@ CONFIG_SPI_BITBANG=y
 # CONFIG_PPS is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
 CONFIG_GPIO_SYSFS=y
 
 #
@@ -763,6 +800,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_ADP5588 is not set
 
 #
 # PCI GPIO expanders:
@@ -811,6 +849,7 @@ CONFIG_SENSORS_ADM1025=y
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 CONFIG_SENSORS_LM70=y
+# CONFIG_SENSORS_LM73 is not set
 # CONFIG_SENSORS_LM75 is not set
 # CONFIG_SENSORS_LM77 is not set
 # CONFIG_SENSORS_LM78 is not set
@@ -836,6 +875,7 @@ CONFIG_SENSORS_LM70=y
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_AMC6821 is not set
 # CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_TMP401 is not set
 # CONFIG_SENSORS_TMP421 is not set
@@ -849,6 +889,7 @@ CONFIG_SENSORS_LM70=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_SENSORS_LIS3_SPI is not set
+# CONFIG_SENSORS_LIS3_I2C is not set
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
@@ -869,6 +910,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM831X is not set
 # CONFIG_MFD_WM8350_I2C is not set
@@ -876,6 +918,8 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_MC13783 is not set
 # CONFIG_AB3100_CORE is not set
 # CONFIG_EZX_PCAP is not set
+# CONFIG_MFD_88PM8607 is not set
+# CONFIG_AB4500_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -1149,6 +1193,7 @@ CONFIG_LEDS_CLASS=y
 # CONFIG_LEDS_PCA955X is not set
 # CONFIG_LEDS_DAC124S085 is not set
 # CONFIG_LEDS_BD2802 is not set
+# CONFIG_LEDS_LT3593 is not set
 
 #
 # LED Triggers
@@ -1193,6 +1238,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_PCF8563 is not set
 # CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_BQ32K is not set
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
 # CONFIG_RTC_DRV_RX8581 is not set
@@ -1222,7 +1268,9 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
 # CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -1271,21 +1319,27 @@ CONFIG_INOTIFY_USER=y
 #
 # CD-ROM/DVD Filesystems
 #
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
 CONFIG_PROC_SYSCTL=y
 # CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_SYSFS=y
@@ -1423,24 +1477,71 @@ CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_MEMORY_INIT is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_CMDLINE_OVERRIDE is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
 #
-# CONFIG_KEYS is not set
+CONFIG_KEYS=y
+CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
 CONFIG_SECURITYFS=y
-CONFIG_SECURITY_FILE_CAPABILITIES=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 # CONFIG_CRYPTO is not set
 # CONFIG_BINARY_PRINTF is not set
 
@@ -1452,7 +1553,7 @@ CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_T10DIF is not set
-# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC_ITU_T=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index a151313..5424c91 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -1,80 +1,104 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:26 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 08:46:33 2010
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
-CONFIG_MIPS_DB1500=y
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+CONFIG_MIPS_DB1500=y
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1500=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1500=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -87,6 +111,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -94,11 +119,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -108,137 +136,207 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
-CONFIG_RESOURCES_64BIT=y
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-db1500"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_PCI_QUIRKS=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCI_LEGACY is not set
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
-CONFIG_CARDBUS=y
+# CONFIG_PCMCIA_IOCTL is not set
+# CONFIG_CARDBUS is not set
 
 #
 # PC-card bridges
@@ -246,51 +344,49 @@ CONFIG_CARDBUS=y
 # CONFIG_YENTA is not set
 # CONFIG_PD6729 is not set
 # CONFIG_I82092 is not set
-CONFIG_PCMCIA_AU1X00=m
-
-#
-# PCI Hotplug Support
-#
+# CONFIG_PCMCIA_AU1X00 is not set
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 # CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -301,110 +397,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -414,27 +425,24 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -443,25 +451,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
-# CONFIG_MTD_CMDLINE_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -474,6 +482,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -499,14 +508,14 @@ CONFIG_MTD_CFI_UTIL=y
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
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -524,152 +533,152 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
 # CONFIG_MTD_ONENAND is not set
 
 #
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
+# LPDDR flash memory drivers
 #
-# CONFIG_PNPACPI is not set
+# CONFIG_MTD_LPDDR is not set
 
 #
-# Block devices
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_LOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
-
-#
-# Misc devices
-#
-CONFIG_SGI_IOC4=m
-# CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
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
 # CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-# CONFIG_IDEDISK_MULTI_MODE is not set
-CONFIG_BLK_DEV_IDECS=m
-# CONFIG_BLK_DEV_DELKIN is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
 # CONFIG_IDE_GENERIC is not set
-# CONFIG_BLK_DEV_IDEPCI is not set
-# CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+CONFIG_BLK_DEV_IDEDMA_SFF=y
+
+#
+# PCI IDE chipsets support
+#
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+CONFIG_BLK_DEV_HPT366=y
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT8172 is not set
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
+CONFIG_BLK_DEV_IDEDMA=y
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
-# CONFIG_IEEE1394 is not set
 
 #
-# I2O device support
+# You can enable one or both FireWire driver stacks.
 #
-# CONFIG_I2O is not set
 
 #
-# Network device support
+# The newer stack is recommended.
 #
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
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
 CONFIG_PHYLIB=y
 
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -677,88 +686,51 @@ CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
-
-#
-# Tulip family network device support
-#
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_ATL2 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
+# CONFIG_WLAN is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Enable WiMAX (Networking options) to see the WiMAX drivers
 #
-# CONFIG_NET_RADIO is not set
 
 #
-# PCMCIA network device support
+# USB Network Adapters
 #
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
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -766,16 +738,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -785,33 +755,34 @@ CONFIG_INPUT_EVDEV=y
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
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_PCI is not set
 # CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
@@ -825,301 +796,143 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
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
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 
 #
 # PCMCIA character devices
 #
-CONFIG_SYNCLINK_CS=m
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
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
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 
 #
-# Dallas's 1-wire bus
+# PPS support
 #
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGA_ARB is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
-#
-CONFIG_SOUND=y
-
-#
-# Advanced Linux Sound Architecture
-#
-CONFIG_SND=m
-CONFIG_SND_TIMER=m
-CONFIG_SND_PCM=m
-CONFIG_SND_RAWMIDI=m
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_SEQ_DUMMY=m
-CONFIG_SND_OSSEMUL=y
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_PCM_OSS_PLUGINS=y
-CONFIG_SND_SEQUENCER_OSS=y
-# CONFIG_SND_DYNAMIC_MINORS is not set
-CONFIG_SND_SUPPORT_OLD_API=y
-CONFIG_SND_VERBOSE_PROCFS=y
-# CONFIG_SND_VERBOSE_PRINTK is not set
-# CONFIG_SND_DEBUG is not set
-
-#
-# Generic devices
-#
-CONFIG_SND_AC97_CODEC=m
-# CONFIG_SND_DUMMY is not set
-CONFIG_SND_VIRMIDI=m
-CONFIG_SND_MTPAV=m
-# CONFIG_SND_SERIAL_U16550 is not set
-# CONFIG_SND_MPU401 is not set
-
-#
-# PCI devices
-#
-# CONFIG_SND_AD1889 is not set
-# CONFIG_SND_ALS300 is not set
-# CONFIG_SND_ALI5451 is not set
-# CONFIG_SND_ATIIXP is not set
-# CONFIG_SND_ATIIXP_MODEM is not set
-# CONFIG_SND_AU8810 is not set
-# CONFIG_SND_AU8820 is not set
-# CONFIG_SND_AU8830 is not set
-# CONFIG_SND_AZT3328 is not set
-# CONFIG_SND_BT87X is not set
-# CONFIG_SND_CA0106 is not set
-# CONFIG_SND_CMIPCI is not set
-# CONFIG_SND_CS4281 is not set
-# CONFIG_SND_CS46XX is not set
-# CONFIG_SND_DARLA20 is not set
-# CONFIG_SND_GINA20 is not set
-# CONFIG_SND_LAYLA20 is not set
-# CONFIG_SND_DARLA24 is not set
-# CONFIG_SND_GINA24 is not set
-# CONFIG_SND_LAYLA24 is not set
-# CONFIG_SND_MONA is not set
-# CONFIG_SND_MIA is not set
-# CONFIG_SND_ECHO3G is not set
-# CONFIG_SND_INDIGO is not set
-# CONFIG_SND_INDIGOIO is not set
-# CONFIG_SND_INDIGODJ is not set
-# CONFIG_SND_EMU10K1 is not set
-# CONFIG_SND_EMU10K1X is not set
-# CONFIG_SND_ENS1370 is not set
-# CONFIG_SND_ENS1371 is not set
-# CONFIG_SND_ES1938 is not set
-# CONFIG_SND_ES1968 is not set
-# CONFIG_SND_FM801 is not set
-# CONFIG_SND_HDA_INTEL is not set
-# CONFIG_SND_HDSP is not set
-# CONFIG_SND_HDSPM is not set
-# CONFIG_SND_ICE1712 is not set
-# CONFIG_SND_ICE1724 is not set
-# CONFIG_SND_INTEL8X0 is not set
-# CONFIG_SND_INTEL8X0M is not set
-# CONFIG_SND_KORG1212 is not set
-# CONFIG_SND_MAESTRO3 is not set
-# CONFIG_SND_MIXART is not set
-# CONFIG_SND_NM256 is not set
-# CONFIG_SND_PCXHR is not set
-# CONFIG_SND_RIPTIDE is not set
-# CONFIG_SND_RME32 is not set
-# CONFIG_SND_RME96 is not set
-# CONFIG_SND_RME9652 is not set
-# CONFIG_SND_SONICVIBES is not set
-# CONFIG_SND_TRIDENT is not set
-# CONFIG_SND_VIA82XX is not set
-# CONFIG_SND_VIA82XX_MODEM is not set
-# CONFIG_SND_VX222 is not set
-# CONFIG_SND_YMFPCI is not set
-# CONFIG_SND_AC97_POWER_SAVE is not set
-
-#
-# ALSA MIPS devices
-#
-CONFIG_SND_AU1X00=m
-
-#
-# USB devices
-#
-# CONFIG_SND_USB_AUDIO is not set
-
-#
-# PCMCIA devices
-#
-# CONFIG_SND_VXPOCKET is not set
-# CONFIG_SND_PDAUDIOCF is not set
-
-#
-# SoC audio support
-#
-# CONFIG_SND_SOC is not set
-
-#
-# Open Sound System
-#
-CONFIG_SOUND_PRIME=y
-# CONFIG_OBSOLETE_OSS is not set
-# CONFIG_SOUND_BT878 is not set
-# CONFIG_SOUND_ICH is not set
-# CONFIG_SOUND_TRIDENT is not set
-# CONFIG_SOUND_MSNDCLAS is not set
-# CONFIG_SOUND_MSNDPIN is not set
-# CONFIG_SOUND_VIA82CXXX is not set
-CONFIG_AC97_BUS=m
-
-#
-# HID Devices
-#
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
-
-#
-# USB support
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
 #
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
 # Miscellaneous USB options
 #
 # CONFIG_USB_DEVICEFS is not set
-# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_SUSPEND=y
 # CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
 # USB Host Controller Drivers
 #
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
 # CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
 # USB Device Class drivers
 #
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
+# also be needed; see USB_STORAGE Help for more info
 #
 # CONFIG_USB_LIBUSUAL is not set
 
 #
-# USB Input Devices
-#
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-CONFIG_USB_YEALINK=m
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 
 #
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
-# CONFIG_USB_USBNET is not set
-CONFIG_USB_MON=y
-
-#
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set
 
 #
@@ -1128,7 +941,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
 # CONFIG_USB_ADUTUX is not set
-# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_SEVSEG is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
@@ -1136,112 +949,107 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
 # CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
-CONFIG_USB_LD=m
+# CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
-
-#
-# USB DSL modem support
-#
-
-#
-# USB Gadget Support
-#
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
 # CONFIG_USB_GADGET is not set
 
 #
-# MMC/SD Card support
+# OTG and related infrastructure
 #
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_UWB is not set
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
+# RTC interfaces
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
 
 #
-# DMA Engine support
+# SPI RTC drivers
 #
-# CONFIG_DMA_ENGINE is not set
 
 #
-# DMA Clients
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# DMA Devices
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
+# TI VLYNQ
 #
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
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -1260,74 +1068,81 @@ CONFIG_GENERIC_ACL=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_FS_POSIX_ACL=y
+CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
+CONFIG_NLS_CODEPAGE_850=y
 # CONFIG_NLS_CODEPAGE_852 is not set
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
@@ -1345,10 +1160,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=y
 # CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1358,38 +1173,76 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
+CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
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
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1397,67 +1250,32 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 6b64339..949b6dc 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -1,79 +1,103 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:27 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 08:58:22 2010
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
-CONFIG_MIPS_DB1550=y
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+CONFIG_MIPS_DB1550=y
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1550=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1550=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -86,6 +110,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -93,11 +118,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -107,137 +135,205 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
-CONFIG_RESOURCES_64BIT=y
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-db1550"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_PCI_QUIRKS=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
-CONFIG_CARDBUS=y
+# CONFIG_PCMCIA_IOCTL is not set
+# CONFIG_CARDBUS is not set
 
 #
 # PC-card bridges
@@ -245,51 +341,49 @@ CONFIG_CARDBUS=y
 # CONFIG_YENTA is not set
 # CONFIG_PD6729 is not set
 # CONFIG_I82092 is not set
-CONFIG_PCMCIA_AU1X00=m
-
-#
-# PCI Hotplug Support
-#
+# CONFIG_PCMCIA_AU1X00 is not set
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 # CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -300,110 +394,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -413,27 +422,24 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -442,25 +448,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -473,6 +479,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -498,20 +505,23 @@ CONFIG_MTD_CFI_UTIL=y
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
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
 #
 # CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SST25L is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -523,105 +533,96 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
-CONFIG_MTD_NAND=m
+CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
 # CONFIG_MTD_NAND_ECC_SMC is not set
-CONFIG_MTD_NAND_IDS=m
-CONFIG_MTD_NAND_AU1550=m
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_AU1550=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_CAFE is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
-
-#
-# OneNAND Flash Device Drivers
-#
+# CONFIG_MTD_NAND_PLATFORM is not set
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
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_SX8 is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
-
-#
-# Misc devices
-#
-CONFIG_SGI_IOC4=m
-# CONFIG_TIFM_CORE is not set
+# CONFIG_BLK_DEV_LOOP is not set
 
 #
-# ATA/ATAPI/MFM/RLL support
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
 #
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_UB=y
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
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
-# CONFIG_IDEDISK_MULTI_MODE is not set
-CONFIG_BLK_DEV_IDECS=m
-# CONFIG_BLK_DEV_DELKIN is not set
-# CONFIG_BLK_DEV_IDECD is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_TASK_IOCTL=y
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+CONFIG_BLK_DEV_IDEDMA_SFF=y
+
+#
+# PCI IDE chipsets support
+#
 CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_BLK_DEV_OFFBOARD is not set
-CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_PCI_AUTO is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
 # CONFIG_BLK_DEV_CMD64X is not set
 # CONFIG_BLK_DEV_TRIFLEX is not set
-# CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5520 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT34X is not set
-# CONFIG_BLK_DEV_HPT366 is not set
+CONFIG_BLK_DEV_HPT366=y
 # CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
-CONFIG_BLK_DEV_IT8213=m
+# CONFIG_BLK_DEV_IT8172 is not set
+# CONFIG_BLK_DEV_IT8213 is not set
 # CONFIG_BLK_DEV_IT821X is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
@@ -631,82 +632,65 @@ CONFIG_BLK_DEV_IT8213=m
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
-CONFIG_BLK_DEV_TC86C001=m
-# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_TC86C001 is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
-# CONFIG_IEEE1394 is not set
 
 #
-# I2O device support
+# You can enable one or both FireWire driver stacks.
 #
-# CONFIG_I2O is not set
 
 #
-# Network device support
+# The newer stack is recommended.
 #
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
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
 CONFIG_PHYLIB=y
 
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -714,96 +698,53 @@ CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
-
-#
-# Tulip family network device support
-#
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_ATL2 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
+# CONFIG_WLAN is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# PCMCIA network device support
+# Enable WiMAX (Networking options) to see the WiMAX drivers
 #
-CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_3C589=m
-CONFIG_PCMCIA_3C574=m
-CONFIG_PCMCIA_FMVJ18X=m
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PCMCIA_NMCLAN=m
-CONFIG_PCMCIA_SMC91C92=m
-CONFIG_PCMCIA_XIRC2PS=m
-CONFIG_PCMCIA_AXNET=m
 
 #
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_NET_PCMCIA is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -811,16 +752,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -830,26 +769,27 @@ CONFIG_INPUT_EVDEV=y
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
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -866,199 +806,420 @@ CONFIG_SERIAL_8250_AU1X00=y
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
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
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 
 #
 # PCMCIA character devices
 #
-CONFIG_SYNCLINK_CS=m
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
 # CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_COMPAT is not set
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
 
 #
-# I2C support
+# I2C Hardware Bus support
 #
-# CONFIG_I2C is not set
 
 #
-# SPI support
+# PC SMBus host controller drivers
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
 
 #
-# Dallas's 1-wire bus
+# I2C system bus drivers (mostly embedded / system-on-chip)
 #
-# CONFIG_W1 is not set
+CONFIG_I2C_AU1550=y
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
 
 #
-# Hardware Monitoring support
+# External I2C/SMBus adapter drivers
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
 
 #
-# Multimedia devices
+# Other I2C/SMBus bus drivers
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Miscellaneous I2C Chip support
 #
-# CONFIG_DVB is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
 
 #
-# Graphics support
+# SPI Master Controller Drivers
 #
-# CONFIG_FIRMWARE_EDID is not set
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_SPI_AU1550=y
+CONFIG_SPI_BITBANG=y
+# CONFIG_SPI_GPIO is not set
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
 
 #
-# Sound
+# SPI Protocol Masters
 #
-# CONFIG_SOUND is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 
 #
-# HID Devices
+# PPS support
 #
-# CONFIG_HID is not set
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# USB support
+# Sonics Silicon Backplane
+#
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
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_MFD_88PM8607 is not set
+# CONFIG_AB4500_CORE is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGA_ARB is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
 #
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
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
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_PCI is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_MIPS is not set
+CONFIG_SND_USB=y
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_CAIAQ is not set
+# CONFIG_SND_PCMCIA is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_AU1XPSC=y
+# CONFIG_SND_SOC_DB1200 is not set
+CONFIG_SND_SOC_I2C_AND_SPI=y
+# CONFIG_SND_SOC_ALL_CODECS is not set
+# CONFIG_SOUND_PRIME is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Miscellaneous USB options
 #
+# CONFIG_USB_DEVICEFS is not set
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
-# USB Gadget Support
+# USB Host Controller Drivers
 #
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# MMC/SD Card support
+# USB Device Class drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# LED devices
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-# CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED Triggers
+# USB Imaging devices
 #
+# CONFIG_USB_MDC800 is not set
 
 #
-# InfiniBand support
+# USB port drivers
 #
-# CONFIG_INFINIBAND is not set
+# CONFIG_USB_SERIAL is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
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
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_UWB is not set
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
 
 #
-# Real Time Clock
+# RTC interfaces
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
 
 #
-# DMA Engine support
+# I2C RTC drivers
 #
-# CONFIG_DMA_ENGINE is not set
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
+# CONFIG_RTC_DRV_BQ32K is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
 
 #
-# DMA Clients
+# SPI RTC drivers
 #
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
 
 #
-# DMA Devices
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Auxiliary Display support
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Virtualization
+# TI VLYNQ
 #
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
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -1077,75 +1238,82 @@ CONFIG_GENERIC_ACL=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
+CONFIG_CONFIGFS_FS=y
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+# CONFIG_JFFS2_FS_POSIX_ACL is not set
+# CONFIG_JFFS2_FS_SECURITY is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
 # CONFIG_NLS_CODEPAGE_860 is not set
@@ -1162,10 +1330,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=y
 # CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1175,38 +1343,75 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
+CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
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
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1214,67 +1419,32 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index ddf67f6..97382b6 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -1,79 +1,103 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:37 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 09:53:29 2010
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
-CONFIG_MIPS_PB1100=y
-# CONFIG_MIPS_PB1500 is not set
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+CONFIG_MIPS_PB1100=y
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1100=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1100=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -86,6 +110,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -93,11 +118,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -107,184 +135,244 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-pb1100"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_LBDAF is not set
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
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 # CONFIG_PCI is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
+# CONFIG_PCMCIA_IOCTL is not set
 
 #
 # PC-card bridges
 #
 # CONFIG_PCMCIA_AU1X00 is not set
-
-#
-# PCI Hotplug Support
-#
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -295,110 +383,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -408,27 +411,24 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -437,25 +437,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -468,6 +468,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -493,14 +494,13 @@ CONFIG_MTD_CFI_UTIL=y
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
@@ -517,166 +517,136 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
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
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_UB=y
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
 
 #
-# Misc devices
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+CONFIG_IDE_TASK_IOCTL=y
+# CONFIG_IDE_PROC_FS is not set
 
 #
-# ATA/ATAPI/MFM/RLL support
+# IDE chipset support/bugfixes
 #
-# CONFIG_IDE is not set
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
-CONFIG_PHYLIB=m
+# CONFIG_VETH is not set
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_MIPS_AU1X00_ENET is not set
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_SMC91X is not set
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
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
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
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
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
@@ -684,16 +654,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -703,28 +671,26 @@ CONFIG_INPUT_EVDEV=y
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
-CONFIG_SERIO_RAW=m
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
@@ -743,198 +709,288 @@ CONFIG_SERIAL_8250_AU1X00=y
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
 # PCMCIA character devices
 #
-CONFIG_SYNCLINK_CS=m
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
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
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 
 #
-# Dallas's 1-wire bus
+# PPS support
 #
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
-
-#
-# Console display driver support
-#
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_DUMMY_CONSOLE=y
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
+# Display device support
 #
-# CONFIG_SOUND is not set
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
-# HID Devices
-#
-# CONFIG_HID is not set
-
-#
-# USB support
+# Console display driver support
 #
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
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
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
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
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Miscellaneous USB options
 #
+# CONFIG_USB_DEVICEFS is not set
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
-# USB Gadget Support
+# USB Host Controller Drivers
 #
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# MMC/SD Card support
+# USB Device Class drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# LED devices
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-# CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED Triggers
+# USB Imaging devices
 #
+# CONFIG_USB_MDC800 is not set
 
 #
-# InfiniBand support
+# USB port drivers
 #
+# CONFIG_USB_SERIAL is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
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
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 
 #
-# Real Time Clock
+# OTG and related infrastructure
 #
-# CONFIG_RTC_CLASS is not set
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
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
+# SPI RTC drivers
 #
 
 #
-# DMA Devices
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Auxiliary Display support
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Virtualization
+# TI VLYNQ
 #
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
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -953,69 +1009,76 @@ CONFIG_GENERIC_ACL=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+# CONFIG_JFFS2_FS_POSIX_ACL is not set
+# CONFIG_JFFS2_FS_SECURITY is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_437 is not set
 # CONFIG_NLS_CODEPAGE_737 is not set
@@ -1055,34 +1118,71 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
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
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1090,67 +1190,32 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/pb1200_defconfig b/arch/mips/configs/pb1200_defconfig
new file mode 100644
index 0000000..e9ad773
--- /dev/null
+++ b/arch/mips/configs/pb1200_defconfig
@@ -0,0 +1,1568 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.33
+# Fri Feb 26 10:23:34 2010
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+CONFIG_MACH_ALCHEMY=y
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SIM is not set
+# CONFIG_NEC_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
+# CONFIG_PNX8550_JBS is not set
+# CONFIG_PNX8550_STB810 is not set
+# CONFIG_PMC_MSP is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_POWERTV is not set
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
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
+# CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+CONFIG_MIPS_PB1200=y
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1200=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
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
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
+CONFIG_CPU_MIPS32_R1=y
+# CONFIG_CPU_MIPS32_R2 is not set
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
+# CONFIG_CPU_R5500 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
+CONFIG_SYS_HAS_CPU_MIPS32_R1=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR1=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
+
+#
+# Kernel type
+#
+CONFIG_32BIT=y
+# CONFIG_64BIT is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_MIPS_MT_DISABLED=y
+# CONFIG_MIPS_MT_SMP is not set
+# CONFIG_MIPS_MT_SMTC is not set
+CONFIG_64BIT_PHYS_ADDR=y
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
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
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_48 is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_KEXEC is not set
+# CONFIG_SECCOMP is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION="-pb1200"
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_BZIP2=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_HAVE_KERNEL_LZO=y
+# CONFIG_KERNEL_GZIP is not set
+# CONFIG_KERNEL_BZIP2 is not set
+CONFIG_KERNEL_LZMA=y
+# CONFIG_KERNEL_LZO is not set
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_BLOCK=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+# CONFIG_FREEZER is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_MMU=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+# CONFIG_PCMCIA_IOCTL is not set
+
+#
+# PC-card bridges
+#
+# CONFIG_PCMCIA_AU1X00 is not set
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+# CONFIG_HAVE_AOUT is not set
+CONFIG_BINFMT_MISC=y
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Power management options
+#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_PM is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
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
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
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
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
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
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
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
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SST25L is not set
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
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_AU1550 is not set
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+CONFIG_MTD_NAND_PLATFORM=y
+# CONFIG_MTD_ALAUDA is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
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
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_UB=y
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
+
+#
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
+#
+CONFIG_IDE_XFER_MODE=y
+CONFIG_IDE_ATAPI=y
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
+# CONFIG_BLK_DEV_IDETAPE is not set
+CONFIG_IDE_TASK_IOCTL=y
+# CONFIG_IDE_PROC_FS is not set
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+CONFIG_BLK_DEV_IDE_AU1XXX=y
+CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA=y
+# CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
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
+CONFIG_NETDEVICES=y
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
+# CONFIG_MIPS_AU1X00_ENET is not set
+CONFIG_SMC91X=y
+# CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
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
+# CONFIG_NET_PCMCIA is not set
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
+# CONFIG_INPUT_SPARSEKMAP is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
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
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_CS is not set
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_SERIAL_8250_EXTENDED is not set
+CONFIG_SERIAL_8250_AU1X00=y
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MAX3100 is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
+
+#
+# I2C Algorithms
+#
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
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_AU1550=y
+CONFIG_SPI_BITBANG=y
+# CONFIG_SPI_GPIO is not set
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+CONFIG_GPIO_SYSFS=y
+
+#
+# Memory mapped GPIO expanders:
+#
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_ADP5588 is not set
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
+
+#
+# AC97 GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=y
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Native drivers
+#
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
+# CONFIG_SENSORS_LM73 is not set
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
+# CONFIG_SENSORS_AMC6821 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_TMP421 is not set
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
+# CONFIG_SENSORS_LIS3_I2C is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_UCB1400_CORE is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_MFD_88PM8607 is not set
+# CONFIG_AB4500_CORE is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
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
+CONFIG_FB_AU1200=y
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
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
+# CONFIG_LOGO is not set
+CONFIG_SOUND=y
+# CONFIG_SOUND_OSS_CORE is not set
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+# CONFIG_SND_HRTIMER is not set
+CONFIG_SND_DYNAMIC_MINORS=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+CONFIG_SND_VMASTER=y
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
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
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
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
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_DYNAMIC_MINORS=y
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
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
+
+#
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
+#
+CONFIG_MMC_BLOCK=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_AU1X=y
+# CONFIG_MMC_AT91 is not set
+# CONFIG_MMC_ATMELMCI is not set
+# CONFIG_MMC_SPI is not set
+# CONFIG_MEMSTICK is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+# CONFIG_LEDS_PCA9532 is not set
+# CONFIG_LEDS_GPIO is not set
+# CONFIG_LEDS_LP3944 is not set
+# CONFIG_LEDS_PCA955X is not set
+# CONFIG_LEDS_DAC124S085 is not set
+# CONFIG_LEDS_BD2802 is not set
+# CONFIG_LEDS_LT3593 is not set
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+# CONFIG_LEDS_TRIGGER_IDE_DISK is not set
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_GPIO is not set
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
+# CONFIG_ACCESSIBILITY is not set
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
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
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
+# CONFIG_RTC_DRV_BQ32K is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
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
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
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
+CONFIG_JFFS2_SUMMARY=y
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_JFFS2_RUBIN=y
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_CRAMFS is not set
+CONFIG_SQUASHFS=y
+# CONFIG_SQUASHFS_EMBEDDED is not set
+CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
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
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
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
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SYSV68_PARTITION is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
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
+CONFIG_NLS_CODEPAGE_1250=y
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
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
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_STRIP_ASM_SYMS=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,115200"
+# CONFIG_CMDLINE_OVERRIDE is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_SECURITY is not set
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index 5ec6083..7497d33 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -1,78 +1,102 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:37 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 10:05:27 2010
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
-CONFIG_MIPS_PB1500=y
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+CONFIG_MIPS_PB1500=y
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1500=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1500=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -85,6 +109,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -92,11 +117,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -106,190 +134,255 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
-CONFIG_RESOURCES_64BIT=y
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-pb1500"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_PCI_QUIRKS=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
 CONFIG_PCMCIA_IOCTL=y
-CONFIG_CARDBUS=y
+# CONFIG_CARDBUS is not set
 
 #
 # PC-card bridges
 #
 # CONFIG_YENTA is not set
-CONFIG_PD6729=m
+# CONFIG_PD6729 is not set
 # CONFIG_I82092 is not set
 # CONFIG_PCMCIA_AU1X00 is not set
-CONFIG_PCCARD_NONSTATIC=m
-
-#
-# PCI Hotplug Support
-#
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 # CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -300,110 +393,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -413,27 +421,24 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -442,25 +447,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -473,6 +478,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -498,14 +504,14 @@ CONFIG_MTD_CFI_UTIL=y
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
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -523,30 +529,20 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
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
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -554,67 +550,66 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_SX8 is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
-
-#
-# Misc devices
-#
-CONFIG_SGI_IOC4=m
-# CONFIG_TIFM_CORE is not set
 
 #
-# ATA/ATAPI/MFM/RLL support
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
 #
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_UB=y
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
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
-# CONFIG_IDEDISK_MULTI_MODE is not set
-CONFIG_BLK_DEV_IDECS=m
-# CONFIG_BLK_DEV_DELKIN is not set
-# CONFIG_BLK_DEV_IDECD is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_TASK_IOCTL=y
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+CONFIG_BLK_DEV_IDEDMA_SFF=y
+
+#
+# PCI IDE chipsets support
+#
 CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_BLK_DEV_OFFBOARD is not set
-CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_PCI_AUTO is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
 # CONFIG_BLK_DEV_CMD64X is not set
 # CONFIG_BLK_DEV_TRIFLEX is not set
-# CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5520 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT34X is not set
 CONFIG_BLK_DEV_HPT366=y
 # CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
-CONFIG_BLK_DEV_IT8213=m
+# CONFIG_BLK_DEV_IT8172 is not set
+# CONFIG_BLK_DEV_IT8213 is not set
 # CONFIG_BLK_DEV_IT821X is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
@@ -624,82 +619,65 @@ CONFIG_BLK_DEV_IT8213=m
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
-CONFIG_BLK_DEV_TC86C001=m
-# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_TC86C001 is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
-# CONFIG_IEEE1394 is not set
 
 #
-# I2O device support
+# You can enable one or both FireWire driver stacks.
 #
-# CONFIG_I2O is not set
 
 #
-# Network device support
+# The newer stack is recommended.
 #
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
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
 CONFIG_PHYLIB=y
 
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -707,96 +685,51 @@ CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
-
-#
-# Tulip family network device support
-#
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_ATL2 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
+# CONFIG_WLAN is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Enable WiMAX (Networking options) to see the WiMAX drivers
 #
-# CONFIG_NET_RADIO is not set
 
 #
-# PCMCIA network device support
-#
-CONFIG_NET_PCMCIA=y
-CONFIG_PCMCIA_3C589=m
-CONFIG_PCMCIA_3C574=m
-CONFIG_PCMCIA_FMVJ18X=m
-CONFIG_PCMCIA_PCNET=m
-CONFIG_PCMCIA_NMCLAN=m
-CONFIG_PCMCIA_SMC91C92=m
-CONFIG_PCMCIA_XIRC2PS=m
-CONFIG_PCMCIA_AXNET=m
-
-#
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_NET_PCMCIA is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -804,16 +737,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -823,33 +754,34 @@ CONFIG_INPUT_EVDEV=y
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
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_PCI is not set
 # CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
@@ -863,282 +795,450 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
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
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 
 #
 # PCMCIA character devices
 #
-CONFIG_SYNCLINK_CS=m
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
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
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 
 #
-# Dallas's 1-wire bus
+# PPS support
 #
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
-# CONFIG_FB is not set
+# CONFIG_VGA_ARB is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_TILEBLITTING=y
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+CONFIG_FB_S1D13XXX=y
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_VIA is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_CARMINE is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
+# Display device support
 #
-# CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
-# CONFIG_HID is not set
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
-# USB support
+# Console display driver support
 #
+CONFIG_VGA_CONSOLE=y
+# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+# CONFIG_LOGO is not set
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HIDRAW is not set
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
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
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
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Miscellaneous USB options
 #
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_DYNAMIC_MINORS=y
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_OTG is not set
+CONFIG_USB_OTG_WHITELIST=y
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
-# USB Gadget Support
+# USB Host Controller Drivers
 #
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# MMC/SD Card support
+# USB Device Class drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# LED devices
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-# CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED Triggers
+# USB Imaging devices
 #
+# CONFIG_USB_MDC800 is not set
 
 #
-# InfiniBand support
+# USB port drivers
 #
-# CONFIG_INFINIBAND is not set
+# CONFIG_USB_SERIAL is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
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
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 
 #
-# Real Time Clock
+# OTG and related infrastructure
 #
-# CONFIG_RTC_CLASS is not set
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_UWB is not set
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
+# SPI RTC drivers
 #
 
 #
-# DMA Devices
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Auxiliary Display support
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Virtualization
+# TI VLYNQ
 #
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
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
 #
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
 # CONFIG_NLS_CODEPAGE_860 is not set
@@ -1155,10 +1255,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=y
 # CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1168,38 +1268,75 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
+CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
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
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1207,67 +1344,32 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=y
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index 6647642..aa526f5 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -1,79 +1,103 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:37 2007
+# Linux kernel version: 2.6.33
+# Fri Feb 26 10:06:07 2010
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
-CONFIG_MIPS_PB1550=y
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_AR7 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
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
+# CONFIG_POWERTV is not set
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
+CONFIG_ALCHEMY_GPIOINT_AU1000=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+CONFIG_MIPS_PB1550=y
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1550=y
+CONFIG_SOC_AU1X00=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1550=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -86,6 +110,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -93,11 +118,14 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -107,190 +135,255 @@ CONFIG_32BIT=y
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
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
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
-CONFIG_RESOURCES_64BIT=y
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_CONSTRUCTORS=y
 
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
+CONFIG_LOCALVERSION="-pb1550"
 CONFIG_LOCALVERSION_AUTO=y
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
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
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
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_PCI_QUIRKS=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
 
 #
-# Loadable module support
+# GCOV-based kernel profiling
 #
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
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
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
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
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
-# CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
 CONFIG_PCMCIA_IOCTL=y
-CONFIG_CARDBUS=y
+# CONFIG_CARDBUS is not set
 
 #
 # PC-card bridges
 #
 # CONFIG_YENTA is not set
-CONFIG_PD6729=m
+# CONFIG_PD6729 is not set
 # CONFIG_I82092 is not set
 # CONFIG_PCMCIA_AU1X00 is not set
-CONFIG_PCCARD_NONSTATIC=m
-
-#
-# PCI Hotplug Support
-#
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
 # CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-
-#
-# Networking
-#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+# CONFIG_APM_EMULATION is not set
+CONFIG_PM_RUNTIME=y
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
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -301,110 +394,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
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
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
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
-CONFIG_NF_CT_NETLINK=m
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
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -414,27 +422,30 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
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
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_LIB80211 is not set
+
+#
+# CFG80211 needs to be enabled for MAC80211
+#
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -443,25 +454,25 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -474,6 +485,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -499,14 +511,14 @@ CONFIG_MTD_CFI_UTIL=y
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
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -524,30 +536,30 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
-# CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_AU1550=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
+# LPDDR flash memory drivers
 #
-# CONFIG_PNPACPI is not set
+# CONFIG_MTD_LPDDR is not set
 
 #
-# Block devices
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -555,67 +567,66 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_SX8 is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
 
 #
-# Misc devices
-#
-CONFIG_SGI_IOC4=m
-# CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
 #
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_UB=y
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
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
-# CONFIG_IDEDISK_MULTI_MODE is not set
-CONFIG_BLK_DEV_IDECS=m
-# CONFIG_BLK_DEV_DELKIN is not set
-# CONFIG_BLK_DEV_IDECD is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+CONFIG_BLK_DEV_IDEDMA_SFF=y
+
+#
+# PCI IDE chipsets support
+#
 CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_BLK_DEV_OFFBOARD is not set
-CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_PCI_AUTO is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
 # CONFIG_BLK_DEV_CMD64X is not set
 # CONFIG_BLK_DEV_TRIFLEX is not set
-# CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5520 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT34X is not set
 CONFIG_BLK_DEV_HPT366=y
 # CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
-CONFIG_BLK_DEV_IT8213=m
+# CONFIG_BLK_DEV_IT8172 is not set
+# CONFIG_BLK_DEV_IT8213 is not set
 # CONFIG_BLK_DEV_IT821X is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
@@ -625,82 +636,65 @@ CONFIG_BLK_DEV_IT8213=m
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
-CONFIG_BLK_DEV_TC86C001=m
-# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_TC86C001 is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
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
-# CONFIG_IEEE1394 is not set
 
 #
-# I2O device support
+# You can enable one or both FireWire driver stacks.
 #
-# CONFIG_I2O is not set
 
 #
-# Network device support
+# The newer stack is recommended.
 #
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
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
 CONFIG_PHYLIB=y
 
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
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_STE10XP=y
+CONFIG_LSI_ET1011C_PHY=y
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -708,88 +702,51 @@ CONFIG_MIPS_AU1X00_ENET=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
-
-#
-# Tulip family network device support
-#
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_ATL2 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
+# CONFIG_WLAN is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Enable WiMAX (Networking options) to see the WiMAX drivers
 #
-# CONFIG_NET_RADIO is not set
 
 #
-# PCMCIA network device support
+# USB Network Adapters
 #
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
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-# CONFIG_PPP_SYNC_TTY is not set
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -797,16 +754,14 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
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
 
@@ -816,33 +771,34 @@ CONFIG_INPUT_EVDEV=y
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
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_PCI is not set
 # CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
@@ -856,282 +812,492 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
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
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 
 #
 # PCMCIA character devices
 #
-CONFIG_SYNCLINK_CS=m
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
 # CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_COMPAT is not set
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
 
 #
-# I2C support
+# I2C Hardware Bus support
 #
-# CONFIG_I2C is not set
 
 #
-# SPI support
+# PC SMBus host controller drivers
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
 
 #
-# Dallas's 1-wire bus
+# I2C system bus drivers (mostly embedded / system-on-chip)
 #
-# CONFIG_W1 is not set
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
 
 #
-# Hardware Monitoring support
+# Other I2C/SMBus bus drivers
 #
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+# CONFIG_GPIOLIB is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Multimedia devices
+# Sonics Silicon Backplane
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_SSB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multifunction device drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_MFD_88PM8607 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGA_ARB is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# HID Devices
+# Display device support
 #
-# CONFIG_HID is not set
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
-# USB support
+# Console display driver support
 #
+CONFIG_VGA_CONSOLE=y
+# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
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
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
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
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Miscellaneous USB options
 #
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_SUSPEND=y
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
-# USB Gadget Support
+# USB Host Controller Drivers
 #
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# MMC/SD Card support
+# USB Device Class drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# LED devices
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-# CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# LED Triggers
+# USB Imaging devices
 #
+# CONFIG_USB_MDC800 is not set
 
 #
-# InfiniBand support
+# USB port drivers
 #
-# CONFIG_INFINIBAND is not set
+# CONFIG_USB_SERIAL is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
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
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_UWB is not set
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
 
 #
-# Real Time Clock
+# RTC interfaces
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
 
 #
-# DMA Engine support
+# I2C RTC drivers
 #
-# CONFIG_DMA_ENGINE is not set
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
+# CONFIG_RTC_DRV_BQ32K is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
 
 #
-# DMA Clients
+# SPI RTC drivers
 #
 
 #
-# DMA Devices
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
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
-# Auxiliary Display support
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
 
 #
-# Virtualization
+# TI VLYNQ
 #
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
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-CONFIG_REISERFS_FS_XATTR=y
-CONFIG_REISERFS_FS_POSIX_ACL=y
-CONFIG_REISERFS_FS_SECURITY=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
 #
-# CONFIG_ISO9660_FS is not set
-# CONFIG_UDF_FS is not set
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
+# CONFIG_PROC_KCORE is not set
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
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
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
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
-CONFIG_EXPORTFS=m
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
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
-CONFIG_NLS=m
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
 # CONFIG_NLS_CODEPAGE_860 is not set
@@ -1148,10 +1314,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=y
 # CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1161,38 +1327,75 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
+CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
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
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+CONFIG_DEBUG_ZBOOT=y
 
 #
 # Security options
@@ -1200,67 +1403,32 @@ CONFIG_CROSSCOMPILE=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
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
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=y
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
-- 
1.7.0
