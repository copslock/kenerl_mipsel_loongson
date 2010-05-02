Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 May 2010 11:39:44 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:56484 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491901Ab0EBJjL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 May 2010 11:39:11 +0200
Received: by wyg36 with SMTP id 36so777565wyg.36
        for <multiple recipients>; Sun, 02 May 2010 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=MAz+VIUoUdmk+3l949NKNLDxFC63WFcKyrHcvgdRqhY=;
        b=xvg9DT3Fas0P9rhZ90VjOhheAfMvIK8HhQK6t2aHxwTONp/B/CLk+WT3+jR92d9mOs
         SlBN9csbCC5eybmgyURCnQvr8Lpu6Lh/0TweeUixR3WV/LV6VcA7kYtCxAc4vJuLDRgQ
         w9cOFhmvUMi8aQtY5BBQBaobEjiZ6LUBLwJCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=kF2ndWvGwXhJihb0avb16P9+pdXOgaLKTTpe5zh6Nfr9Y7rTomRcckAA5oloZ+RwEO
         rfAW+R4IF8Ru65ESAgss1tkte6FgtlWiZmjg6x8tUuP0duMq2yxDJcpJJYyQIx3dAn4n
         TQXavgI51w2k7qt5/p7S93U42qmwE/Ans6w8I=
Received: by 10.216.160.12 with SMTP id t12mr10497875wek.154.1272793145423;
        Sun, 02 May 2010 02:39:05 -0700 (PDT)
Received: from lenovo.localnet (208.59.76-86.rev.gaoland.net [86.76.59.208])
        by mx.google.com with ESMTPS id z33sm10094543wbd.13.2010.05.02.02.39.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 02:39:04 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 2 May 2010 11:39:02 +0200
Subject: [PATCH 2/4] RB532: update defconfig
MIME-Version: 1.0
X-UID:  187
X-Length: 35268
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201005021139.02260.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This updates the Mikrotik RB532 defconfig with:
- tiny RCU
- RB532 input buttons driver
- RB532 LED driver
- RC32434 watchdog driver
- GPIO sysfs support
- Wireless support
- SquashFS support
- more LED triggers

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 57a5048..90a032a 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25
-# Mon Apr 28 12:24:17 2008
+# Linux kernel version: 2.6.34-rc6
+# Sat May  1 11:49:51 2010
 #
 CONFIG_MIPS=y
 
@@ -9,22 +9,25 @@ CONFIG_MIPS=y
 # Machine selection
 #
 # CONFIG_MACH_ALCHEMY is not set
+# CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
 # CONFIG_LASAT is not set
-# CONFIG_LEMOTE_FULONG is not set
-# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MACH_LOONGSON is not set
 # CONFIG_MIPS_MALTA is not set
-# CONFIG_MIPS_SEAD is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
+# CONFIG_NEC_MARKEINS is not set
 # CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
+# CONFIG_POWERTV is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP28 is not set
@@ -38,11 +41,14 @@ CONFIG_MIPS=y
 # CONFIG_SIBYTE_SENTOSA is not set
 # CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
 CONFIG_MIKROTIK_RB532=y
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
 # CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -53,14 +59,15 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_BOOT_RAW=y
+CONFIG_CEVT_R4K_LIB=y
 CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-# CONFIG_HOTPLUG_CPU is not set
+CONFIG_NEED_DMA_MAP_STATE=y
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
@@ -73,7 +80,8 @@ CONFIG_MIPS_L1_CACHE_SHIFT=4
 #
 # CPU selection
 #
-# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -86,6 +94,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -93,11 +102,13 @@ CONFIG_CPU_MIPS32_R1=y
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
@@ -107,11 +118,13 @@ CONFIG_32BIT=y
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -124,12 +137,13 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -151,6 +165,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -168,23 +183,31 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+# CONFIG_TREE_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
+# CONFIG_TREE_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_GROUP_SCHED=y
-CONFIG_FAIR_GROUP_SCHED=y
-# CONFIG_RT_GROUP_SCHED is not set
-CONFIG_USER_SCHED=y
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 # CONFIG_KALLSYMS is not set
@@ -192,54 +215,87 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 # CONFIG_ELF_CORE is not set
-CONFIG_COMPAT_BRK=y
+CONFIG_PCSPKR_PLATFORM=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
 # CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_PCI_QUIRKS is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
-# CONFIG_HAVE_KPROBES is not set
-# CONFIG_HAVE_KRETPROBES is not set
-CONFIG_PROC_PAGE_MONITOR=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_SLOW_WORK is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
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
-CONFIG_CLASSIC_RCU=y
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
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -248,7 +304,8 @@ CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
@@ -257,25 +314,22 @@ CONFIG_MMU=y
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
 # Networking options
 #
 CONFIG_PACKET=y
-CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -325,7 +379,6 @@ CONFIG_DEFAULT_VEGAS=y
 # CONFIG_DEFAULT_RENO is not set
 CONFIG_DEFAULT_TCP_CONG="vegas"
 # CONFIG_TCP_MD5SIG is not set
-# CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETWORK_SECMARK is not set
 CONFIG_NETFILTER=y
@@ -336,8 +389,9 @@ CONFIG_NETFILTER_ADVANCED=y
 #
 # Core Netfilter Configuration
 #
+CONFIG_NETFILTER_NETLINK=m
 # CONFIG_NETFILTER_NETLINK_QUEUE is not set
-# CONFIG_NETFILTER_NETLINK_LOG is not set
+CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NF_CONNTRACK=y
 CONFIG_NF_CT_ACCT=y
 CONFIG_NF_CONNTRACK_MARK=y
@@ -355,18 +409,23 @@ CONFIG_NF_CONNTRACK_IRC=m
 # CONFIG_NF_CONNTRACK_SIP is not set
 CONFIG_NF_CONNTRACK_TFTP=m
 # CONFIG_NF_CT_NETLINK is not set
+# CONFIG_NETFILTER_TPROXY is not set
 CONFIG_NETFILTER_XTABLES=y
 # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
 # CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
+# CONFIG_NETFILTER_XT_TARGET_CT is not set
 # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
+# CONFIG_NETFILTER_XT_TARGET_HL is not set
+# CONFIG_NETFILTER_XT_TARGET_LED is not set
 # CONFIG_NETFILTER_XT_TARGET_MARK is not set
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
 # CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
 CONFIG_NETFILTER_XT_TARGET_TRACE=m
 # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
 # CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
+# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
 CONFIG_NETFILTER_XT_MATCH_COMMENT=m
 # CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
@@ -375,18 +434,21 @@ CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
 CONFIG_NETFILTER_XT_MATCH_DCCP=m
 # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
 # CONFIG_NETFILTER_XT_MATCH_ESP is not set
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
 # CONFIG_NETFILTER_XT_MATCH_HELPER is not set
+# CONFIG_NETFILTER_XT_MATCH_HL is not set
 # CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
 # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
 CONFIG_NETFILTER_XT_MATCH_LIMIT=y
 # CONFIG_NETFILTER_XT_MATCH_MAC is not set
 # CONFIG_NETFILTER_XT_MATCH_MARK is not set
-# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
+# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
 # CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
 # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
 # CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
 CONFIG_NETFILTER_XT_MATCH_REALM=m
+# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
 CONFIG_NETFILTER_XT_MATCH_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_STATE=y
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
@@ -394,20 +456,21 @@ CONFIG_NETFILTER_XT_MATCH_STATE=y
 # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
 # CONFIG_NETFILTER_XT_MATCH_TIME is not set
 CONFIG_NETFILTER_XT_MATCH_U32=m
-CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
+# CONFIG_NETFILTER_XT_MATCH_OSF is not set
+# CONFIG_IP_VS is not set
 
 #
 # IP: Netfilter Configuration
 #
+CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_CONNTRACK_IPV4=y
 CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_IP_NF_QUEUE is not set
 CONFIG_IP_NF_IPTABLES=y
-# CONFIG_IP_NF_MATCH_RECENT is not set
-# CONFIG_IP_NF_MATCH_ECN is not set
+CONFIG_IP_NF_MATCH_ADDRTYPE=m
 # CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
 # CONFIG_IP_NF_MATCH_TTL is not set
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_REJECT=y
 # CONFIG_IP_NF_TARGET_LOG is not set
@@ -415,8 +478,8 @@ CONFIG_IP_NF_TARGET_REJECT=y
 CONFIG_NF_NAT=y
 CONFIG_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=y
-# CONFIG_IP_NF_TARGET_REDIRECT is not set
 # CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_REDIRECT is not set
 # CONFIG_NF_NAT_SNMP_BASIC is not set
 CONFIG_NF_NAT_FTP=m
 CONFIG_NF_NAT_IRC=m
@@ -426,17 +489,22 @@ CONFIG_NF_NAT_TFTP=m
 # CONFIG_NF_NAT_H323 is not set
 # CONFIG_NF_NAT_SIP is not set
 CONFIG_IP_NF_MANGLE=y
+# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
 # CONFIG_IP_NF_TARGET_ECN is not set
 # CONFIG_IP_NF_TARGET_TTL is not set
-# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
 CONFIG_IP_NF_RAW=m
 # CONFIG_IP_NF_ARPTABLES is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+CONFIG_STP=y
 CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
+# CONFIG_NET_DSA is not set
 CONFIG_VLAN_8021Q=y
+# CONFIG_VLAN_8021Q_GVRP is not set
 # CONFIG_DECNET is not set
 CONFIG_LLC=y
 CONFIG_LLC2=m
@@ -446,6 +514,8 @@ CONFIG_LLC2=m
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 CONFIG_NET_SCHED=y
 
 #
@@ -455,7 +525,7 @@ CONFIG_NET_SCH_CBQ=m
 # CONFIG_NET_SCH_HTB is not set
 # CONFIG_NET_SCH_HFSC is not set
 CONFIG_NET_SCH_PRIO=m
-CONFIG_NET_SCH_RR=m
+# CONFIG_NET_SCH_MULTIQ is not set
 # CONFIG_NET_SCH_RED is not set
 # CONFIG_NET_SCH_SFQ is not set
 # CONFIG_NET_SCH_TEQL is not set
@@ -463,6 +533,7 @@ CONFIG_NET_SCH_RR=m
 # CONFIG_NET_SCH_GRED is not set
 # CONFIG_NET_SCH_DSMARK is not set
 CONFIG_NET_SCH_NETEM=m
+# CONFIG_NET_SCH_DRR is not set
 # CONFIG_NET_SCH_INGRESS is not set
 
 #
@@ -496,8 +567,10 @@ CONFIG_NET_ACT_IPT=m
 # CONFIG_NET_ACT_NAT is not set
 CONFIG_NET_ACT_PEDIT=m
 # CONFIG_NET_ACT_SIMP is not set
+# CONFIG_NET_ACT_SKBEDIT is not set
 CONFIG_NET_CLS_IND=y
 CONFIG_NET_SCH_FIFO=y
+# CONFIG_DCB is not set
 
 #
 # Network testing
@@ -514,14 +587,19 @@ CONFIG_HAMRADIO=y
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 CONFIG_FIB_RULES=y
+CONFIG_WIRELESS=y
+CONFIG_WIRELESS_EXT=y
+CONFIG_WEXT_CORE=y
+CONFIG_WEXT_PROC=y
+CONFIG_WEXT_PRIV=y
+# CONFIG_CFG80211 is not set
+CONFIG_WIRELESS_EXT_SYSFS=y
+# CONFIG_LIB80211 is not set
 
 #
-# Wireless
+# CFG80211 needs to be enabled for MAC80211
 #
-# CONFIG_CFG80211 is not set
-CONFIG_WIRELESS_EXT=y
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -533,13 +611,17 @@ CONFIG_WIRELESS_EXT=y
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
@@ -612,6 +694,11 @@ CONFIG_MTD_NAND_PLATFORM=y
 # CONFIG_MTD_ONENAND is not set
 
 #
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
@@ -623,23 +710,36 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_PHANTOM is not set
-# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HP_ILO is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_CB710_CORE is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -656,10 +756,6 @@ CONFIG_SCSI_PROC_FS=y
 # CONFIG_BLK_DEV_SR is not set
 # CONFIG_CHR_DEV_SG is not set
 # CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
@@ -676,27 +772,35 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
+# CONFIG_SCSI_BNX2_ISCSI is not set
+# CONFIG_BE2ISCSI is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_HPSA is not set
 # CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_3W_SAS is not set
 # CONFIG_SCSI_ACARD is not set
 # CONFIG_SCSI_AACRAID is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_MVSAS is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_MPT2SAS is not set
 # CONFIG_SCSI_HPTIOP is not set
+# CONFIG_LIBFC is not set
+# CONFIG_LIBFCOE is not set
+# CONFIG_FCOE is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
-# CONFIG_SCSI_MVSAS is not set
 # CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
@@ -708,9 +812,15 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_PMCRAID is not set
+# CONFIG_SCSI_PM8001 is not set
 # CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_BFA_FC is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+# CONFIG_ATA_VERBOSE_ERROR is not set
 # CONFIG_SATA_PMP is not set
 # CONFIG_SATA_AHCI is not set
 # CONFIG_SATA_SIL24 is not set
@@ -732,6 +842,7 @@ CONFIG_ATA_SFF=y
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_ATIIXP is not set
 # CONFIG_PATA_CMD640_PCI is not set
 # CONFIG_PATA_CMD64X is not set
@@ -747,6 +858,7 @@ CONFIG_ATA_SFF=y
 # CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_IT8213 is not set
 # CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_LEGACY is not set
 # CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
 # CONFIG_PATA_MPIIX is not set
@@ -757,29 +869,39 @@ CONFIG_ATA_SFF=y
 # CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_PDC_OLD is not set
 # CONFIG_PATA_RADISYS is not set
 CONFIG_PATA_RB532=y
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
+# CONFIG_PATA_SCH is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
 #
+
+#
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# The newer stack is recommended.
+#
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 CONFIG_IFB=m
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -797,21 +919,28 @@ CONFIG_KORINA=y
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_KSZ884X_PCI is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 # CONFIG_TC35815 is not set
-# CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -821,30 +950,27 @@ CONFIG_NET_PCI=y
 # CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
+# CONFIG_SMSC9420 is not set
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 CONFIG_VIA_RHINE=y
 # CONFIG_VIA_RHINE_MMIO is not set
-CONFIG_VIA_RHINE_NAPI=y
 # CONFIG_SC92031 is not set
+# CONFIG_ATL2 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-CONFIG_WLAN_80211=y
-# CONFIG_IPW2100 is not set
-# CONFIG_IPW2200 is not set
-# CONFIG_LIBERTAS is not set
-# CONFIG_HERMES is not set
+CONFIG_WLAN=y
 CONFIG_ATMEL=m
 # CONFIG_PCI_ATMEL is not set
 # CONFIG_PRISM54 is not set
-# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_HOSTAP is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -864,6 +990,7 @@ CONFIG_SLHC=m
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
 # CONFIG_PHONE is not set
 
@@ -872,7 +999,8 @@ CONFIG_SLHC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
-# CONFIG_INPUT_POLLDEV is not set
+CONFIG_INPUT_POLLDEV=y
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -887,17 +1015,29 @@ CONFIG_INPUT=y
 #
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_MATRIX is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_INPUT_PCSPKR is not set
+# CONFIG_INPUT_ATI_REMOTE is not set
+# CONFIG_INPUT_ATI_REMOTE2 is not set
+# CONFIG_INPUT_KEYSPAN_REMOTE is not set
+# CONFIG_INPUT_POWERMATE is not set
+# CONFIG_INPUT_YEALINK is not set
+# CONFIG_INPUT_CM109 is not set
+# CONFIG_INPUT_UINPUT is not set
+# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
+CONFIG_INPUT_RB532_BUTTON=y
 
 #
 # Hardware I/O ports
@@ -909,6 +1049,7 @@ CONFIG_INPUT_KEYBOARD=y
 # Character devices
 #
 # CONFIG_VT is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 # CONFIG_NOZOMI is not set
 
@@ -928,105 +1069,95 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_TIMBERDALE is not set
 CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
-# CONFIG_RTC is not set
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
-# CONFIG_W1 is not set
-# CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
-# CONFIG_THERMAL is not set
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
 
 #
-# Watchdog Device Drivers
+# PPS support
 #
-# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_PPS is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
 
 #
-# PCI-based Watchdog Cards
+# Memory mapped GPIO expanders:
 #
-# CONFIG_PCIPCWATCHDOG is not set
-# CONFIG_WDTPCI is not set
+# CONFIG_GPIO_IT8761E is not set
+# CONFIG_GPIO_SCH is not set
 
 #
-# Sonics Silicon Backplane
+# I2C GPIO expanders:
 #
-CONFIG_SSB_POSSIBLE=y
-# CONFIG_SSB is not set
 
 #
-# Multifunction device drivers
-#
-# CONFIG_MFD_SM501 is not set
-# CONFIG_HTC_PASIC3 is not set
-
-#
-# Multimedia devices
-#
-CONFIG_VIDEO_DEV=m
-CONFIG_VIDEO_V4L2_COMMON=m
-CONFIG_VIDEO_ALLOW_V4L1=y
-CONFIG_VIDEO_V4L1_COMPAT=y
-CONFIG_VIDEO_V4L2=m
-CONFIG_VIDEO_V4L1=m
-CONFIG_VIDEO_CAPTURE_DRIVERS=y
-# CONFIG_VIDEO_ADV_DEBUG is not set
-# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
-
-#
-# Encoders/decoders and other helper chips
+# PCI GPIO expanders:
 #
+# CONFIG_GPIO_CS5535 is not set
+# CONFIG_GPIO_BT8XX is not set
+# CONFIG_GPIO_LANGWELL is not set
 
 #
-# Audio decoders
+# SPI GPIO expanders:
 #
 
 #
-# Video decoders
+# AC97 GPIO expanders:
 #
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
 
 #
-# Video and audio decoders
+# Watchdog Device Drivers
 #
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_ALIM7101_WDT is not set
+CONFIG_RC32434_WDT=y
 
 #
-# MPEG video encoders
+# PCI-based Watchdog Cards
 #
-# CONFIG_VIDEO_CX2341X is not set
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Video encoders
+# Sonics Silicon Backplane
 #
+# CONFIG_SSB is not set
 
 #
-# Video improvement chips
+# Multifunction device drivers
 #
-# CONFIG_VIDEO_VIVI is not set
-# CONFIG_VIDEO_CPIA is not set
-# CONFIG_VIDEO_STRADIS is not set
-# CONFIG_SOC_CAMERA is not set
-# CONFIG_RADIO_ADAPTERS is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_DAB is not set
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_TIMBERDALE is not set
+# CONFIG_LPC_SCH is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+# CONFIG_VGA_ARB is not set
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
@@ -1037,13 +1168,10 @@ CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-
-#
-# Sound
-#
 # CONFIG_SOUND is not set
 CONFIG_HID_SUPPORT=y
 # CONFIG_HID is not set
+# CONFIG_HID_PID is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1053,9 +1181,18 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# Enable Host or Gadget support to see Inventra options
+#
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 # CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_UWB is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
@@ -1064,41 +1201,67 @@ CONFIG_LEDS_CLASS=y
 #
 # LED drivers
 #
+CONFIG_LEDS_MIKROTIK_RB532=y
 # CONFIG_LEDS_GPIO is not set
+# CONFIG_LEDS_LT3593 is not set
+CONFIG_LEDS_TRIGGERS=y
 
 #
 # LED Triggers
 #
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_GPIO is not set
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
 
 #
+# TI VLYNQ
+#
+# CONFIG_STAGING is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_EXT4DEV_FS is not set
+# CONFIG_EXT4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -1117,15 +1280,13 @@ CONFIG_EXT2_FS=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_CONFIGFS_FS=y
-
-#
-# Miscellaneous filesystems
-#
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
@@ -1148,9 +1309,14 @@ CONFIG_JFFS2_RTIME=y
 CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_JFFS2_CMODE_SIZE is not set
 # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_LOGFS is not set
 # CONFIG_CRAMFS is not set
+CONFIG_SQUASHFS=y
+# CONFIG_SQUASHFS_EMBEDDED is not set
+CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -1160,6 +1326,7 @@ CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1198,11 +1365,22 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
 # CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_CMDLINE_BOOL is not set
 
 #
@@ -1210,18 +1388,32 @@ CONFIG_FRAME_WARN=1024
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 CONFIG_CRYPTO=y
 
 #
 # Crypto core or helper
 #
+# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=m
-CONFIG_CRYPTO_AEAD=m
-CONFIG_CRYPTO_BLKCIPHER=m
-# CONFIG_CRYPTO_MANAGER is not set
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=m
+CONFIG_CRYPTO_BLKCIPHER2=m
+CONFIG_CRYPTO_HASH=m
+CONFIG_CRYPTO_HASH2=m
+CONFIG_CRYPTO_RNG=m
+CONFIG_CRYPTO_RNG2=m
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_MANAGER2=m
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=m
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_TEST=m
@@ -1249,14 +1441,20 @@ CONFIG_CRYPTO_TEST=m
 #
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
-# CONFIG_CRYPTO_CRC32C is not set
+CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_GHASH is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
@@ -1266,7 +1464,7 @@ CONFIG_CRYPTO_TEST=m
 #
 # Ciphers
 #
-# CONFIG_CRYPTO_AES is not set
+CONFIG_CRYPTO_AES=m
 # CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
@@ -1286,27 +1484,36 @@ CONFIG_CRYPTO_TEST=m
 # Compression
 #
 # CONFIG_CRYPTO_DEFLATE is not set
+CONFIG_CRYPTO_ZLIB=y
 # CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+CONFIG_CRYPTO_ANSI_CPRNG=m
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
+CONFIG_GENERIC_FIND_LAST_BIT=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC16=m
+# CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
+CONFIG_DECOMPRESS_GZIP=y
 CONFIG_TEXTSEARCH=y
 CONFIG_TEXTSEARCH_KMP=m
 CONFIG_TEXTSEARCH_BM=m
 CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
