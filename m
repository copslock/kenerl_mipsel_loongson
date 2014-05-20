Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:53:43 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:30437
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855106AbaETOuAPCIOF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:50:00 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:49:39 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 13/15] MIPS: Add defconfig for mips_paravirt
Date:   Tue, 20 May 2014 16:47:14 +0200
Message-ID: <1400597236-11352-14-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6069001)(6009001)(428001)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(575784001)(93916002)(87286001)(4396001)(19580395003)(83072002)(88136002)(85852003)(21056001)(76176999)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(19580405001)(579004);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/configs/mips_paravirt_defconfig | 1524 +++++++++++++++++++++++++++++
 1 file changed, 1524 insertions(+)
 create mode 100644 arch/mips/configs/mips_paravirt_defconfig

diff --git a/arch/mips/configs/mips_paravirt_defconfig b/arch/mips/configs/mips_paravirt_defconfig
new file mode 100644
index 0000000..f0cac9c
--- /dev/null
+++ b/arch/mips/configs/mips_paravirt_defconfig
@@ -0,0 +1,1524 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Linux/mips 3.15.0-rc4 Kernel Configuration
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+# CONFIG_MIPS_ALCHEMY is not set
+# CONFIG_AR7 is not set
+# CONFIG_ATH79 is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_MACH_JZ4740 is not set
+# CONFIG_LANTIQ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
+# CONFIG_MACH_LOONGSON1 is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD3 is not set
+# CONFIG_NEC_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
+# CONFIG_PMC_MSP is not set
+# CONFIG_RALINK is not set
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
+# CONFIG_CAVIUM_OCTEON_SOC is not set
+# CONFIG_NLM_XLR_BOARD is not set
+# CONFIG_NLM_XLP_BOARD is not set
+CONFIG_MIPS_PARAVIRT=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_CAVIUM_CN63XXP1 is not set
+CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=1
+CONFIG_MIPS_PCI_VIRTIO=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K=y
+CONFIG_ARCH_DMA_ADDR_T_64BIT=y
+CONFIG_DMA_COHERENT=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+# CONFIG_MIPS_MACHINE is not set
+# CONFIG_NO_IOPORT_MAP is not set
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
+CONFIG_SYS_SUPPORTS_HUGETLBFS=y
+CONFIG_MIPS_HUGE_TLB_SUPPORT=y
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_MIPS_L1_CACHE_SHIFT_7=y
+CONFIG_MIPS_L1_CACHE_SHIFT=7
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32_R2 is not set
+# CONFIG_CPU_MIPS64_R2 is not set
+CONFIG_CPU_CAVIUM_OCTEON=y
+CONFIG_SYS_HAS_CPU_MIPS32_R2=y
+CONFIG_SYS_HAS_CPU_MIPS64_R2=y
+CONFIG_SYS_HAS_CPU_CAVIUM_OCTEON=y
+CONFIG_WEAK_ORDERING=y
+CONFIG_CPU_MIPSR2=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_HUGEPAGES=y
+CONFIG_MIPS_PGD_C0_CONTEXT=y
+CONFIG_HARDWARE_WATCHPOINTS=y
+
+#
+# Kernel type
+#
+CONFIG_64BIT=y
+# CONFIG_KVM_GUEST is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_CPU_GENERIC_DUMP_TLB=y
+CONFIG_MIPS_MT_DISABLED=y
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_HAVE_MEMBLOCK=y
+CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
+CONFIG_ARCH_DISCARD_MEMBLOCK=y
+# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_COMPACTION=y
+CONFIG_MIGRATION=y
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
+# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
+CONFIG_CROSS_MEMORY_ATTACH=y
+CONFIG_NEED_PER_CPU_KM=y
+# CONFIG_CLEANCACHE is not set
+# CONFIG_FRONTSWAP is not set
+# CONFIG_CMA is not set
+# CONFIG_ZBUD is not set
+# CONFIG_ZSMALLOC is not set
+# CONFIG_SMP is not set
+CONFIG_SYS_SUPPORTS_SMP=y
+CONFIG_NR_CPUS_DEFAULT_4=y
+# CONFIG_HZ_48 is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+CONFIG_HZ_1000=y
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=1000
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_COUNT=y
+# CONFIG_KEXEC is not set
+# CONFIG_CRASH_DUMP is not set
+CONFIG_SECCOMP=y
+# CONFIG_MIPS_O32_FP64_SUPPORT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_IRQ_WORK=y
+CONFIG_BUILDTIME_EXTABLE_SORT=y
+
+#
+# General setup
+#
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+# CONFIG_COMPILE_TEST is not set
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_DEFAULT_HOSTNAME="(none)"
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_FHANDLE is not set
+CONFIG_USELIB=y
+# CONFIG_AUDIT is not set
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_GENERIC_IRQ_SHOW=y
+CONFIG_IRQ_FORCED_THREADING=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+
+#
+# Timers subsystem
+#
+CONFIG_HZ_PERIODIC=y
+# CONFIG_NO_HZ_IDLE is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+
+#
+# CPU/Task time and stats accounting
+#
+CONFIG_TICK_CPU_ACCOUNTING=y
+# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+# CONFIG_TASKSTATS is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_PREEMPT_RCU=y
+CONFIG_PREEMPT_RCU=y
+CONFIG_RCU_STALL_COMMON=y
+CONFIG_RCU_FANOUT=64
+CONFIG_RCU_FANOUT_LEAF=16
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_RCU_BOOST is not set
+# CONFIG_RCU_NOCB_CPU is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+# CONFIG_SYSFS_DEPRECATED is not set
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EXPERT=y
+CONFIG_SYSFS_SYSCALL=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_PCI_QUIRKS=y
+# CONFIG_EMBEDDED is not set
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_COMPAT_BRK=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+# CONFIG_JUMP_LABEL is not set
+# CONFIG_UPROBES is not set
+CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_GENERIC_SMP_IDLE_THREAD=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+CONFIG_HAVE_ARCH_JUMP_LABEL=y
+CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
+CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
+CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
+CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
+CONFIG_SECCOMP_FILTER=y
+CONFIG_HAVE_CC_STACKPROTECTOR=y
+# CONFIG_CC_STACKPROTECTOR is not set
+CONFIG_CC_STACKPROTECTOR_NONE=y
+# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
+# CONFIG_CC_STACKPROTECTOR_STRONG is not set
+CONFIG_HAVE_CONTEXT_TRACKING=y
+CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
+CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
+CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
+CONFIG_MODULES_USE_ELF_RELA=y
+CONFIG_MODULES_USE_ELF_REL=y
+CONFIG_CLONE_BACKWARDS=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
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
+# CONFIG_MODULE_SIG is not set
+CONFIG_BLOCK=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_BSGLIB is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+# CONFIG_BLK_CMDLINE_PARSER is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_BLOCK_COMPAT=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+CONFIG_UNINLINE_SPIN_UNLOCK=y
+CONFIG_FREEZER=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCI_PRI is not set
+# CONFIG_PCI_PASID is not set
+
+#
+# PCI host controller drivers
+#
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_MMU=y
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+# CONFIG_RAPIDIO is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_BINFMT_SCRIPT=y
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_COREDUMP=y
+CONFIG_MIPS32_COMPAT=y
+CONFIG_COMPAT=y
+CONFIG_SYSVIPC_COMPAT=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
+CONFIG_BINFMT_ELF32=y
+
+#
+# Power management options
+#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+CONFIG_PM_SLEEP=y
+# CONFIG_PM_AUTOSLEEP is not set
+# CONFIG_PM_WAKELOCKS is not set
+# CONFIG_PM_RUNTIME is not set
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_DIAG is not set
+CONFIG_UNIX=y
+# CONFIG_UNIX_DIAG is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+# CONFIG_IP_FIB_TRIE_STATS is not set
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+CONFIG_NET_IP_TUNNEL=y
+CONFIG_IP_MROUTE=y
+# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_SYN_COOKIES=y
+# CONFIG_NET_IPVTI is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+# CONFIG_IPV6_VTI is not set
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_SIT_6RD is not set
+CONFIG_IPV6_NDISC_NODETYPE=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_GRE is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NET_PTP_CLASSIFY is not set
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+# CONFIG_BRIDGE is not set
+CONFIG_HAVE_NET_DSA=y
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+CONFIG_DNS_RESOLVER=y
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETLINK_MMAP is not set
+# CONFIG_NETLINK_DIAG is not set
+# CONFIG_NET_MPLS_GSO is not set
+# CONFIG_HSR is not set
+CONFIG_NET_RX_BUSY_POLL=y
+CONFIG_BQL=y
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
+CONFIG_FIB_RULES=y
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
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
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_GENERIC_CPU_DEVICES is not set
+# CONFIG_DMA_SHARED_BUFFER is not set
+
+#
+# Bus devices
+#
+# CONFIG_CONNECTOR is not set
+# CONFIG_MTD is not set
+# CONFIG_PARPORT is not set
+CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_NULL_BLK is not set
+# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_DRBD is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_NVME is not set
+# CONFIG_BLK_DEV_SKD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_VIRTIO_BLK is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_BLK_DEV_RBD is not set
+# CONFIG_BLK_DEV_RSXX is not set
+
+#
+# Misc devices
+#
+# CONFIG_DUMMY_IRQ is not set
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+# CONFIG_ATMEL_SSC is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HP_ILO is not set
+# CONFIG_PCH_PHUB is not set
+# CONFIG_SRAM is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_CB710_CORE is not set
+
+#
+# Texas Instruments shared transport line discipline
+#
+
+#
+# Altera FPGA firmware download module
+#
+
+#
+# Intel MIC Host Driver
+#
+
+#
+# Intel MIC Card Driver
+#
+# CONFIG_GENWQE is not set
+# CONFIG_ECHO is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
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
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_ISCSI_BOOT_SYSFS is not set
+# CONFIG_SCSI_CXGB3_ISCSI is not set
+# CONFIG_SCSI_CXGB4_ISCSI is not set
+# CONFIG_SCSI_BNX2_ISCSI is not set
+# CONFIG_SCSI_BNX2X_FCOE is not set
+# CONFIG_BE2ISCSI is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_HPSA is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_3W_SAS is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_MVSAS is not set
+# CONFIG_SCSI_MVUMI is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_SCSI_ESAS2R is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_MPT2SAS is not set
+# CONFIG_SCSI_MPT3SAS is not set
+# CONFIG_SCSI_UFSHCD is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_LIBFC is not set
+# CONFIG_LIBFCOE is not set
+# CONFIG_FCOE is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_PMCRAID is not set
+# CONFIG_SCSI_PM8001 is not set
+# CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_BFA_FC is not set
+# CONFIG_SCSI_VIRTIO is not set
+# CONFIG_SCSI_CHELSIO_FCOE is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_TARGET_CORE is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_FIREWIRE_NOSY is not set
+# CONFIG_I2O is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+# CONFIG_DUMMY is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_VXLAN is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_VIRTIO_NET is not set
+# CONFIG_NLMON is not set
+# CONFIG_ARCNET is not set
+
+#
+# CAIF transport drivers
+#
+
+#
+# Distributed Switch Architecture drivers
+#
+# CONFIG_NET_DSA_MV88E6XXX is not set
+# CONFIG_NET_DSA_MV88E6060 is not set
+# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
+# CONFIG_NET_DSA_MV88E6131 is not set
+# CONFIG_NET_DSA_MV88E6123_61_65 is not set
+CONFIG_ETHERNET=y
+CONFIG_NET_VENDOR_3COM=y
+# CONFIG_VORTEX is not set
+# CONFIG_TYPHOON is not set
+CONFIG_NET_VENDOR_ADAPTEC=y
+# CONFIG_ADAPTEC_STARFIRE is not set
+CONFIG_NET_VENDOR_ALTEON=y
+# CONFIG_ACENIC is not set
+# CONFIG_ALTERA_TSE is not set
+CONFIG_NET_VENDOR_AMD=y
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_PCNET32 is not set
+CONFIG_NET_VENDOR_ARC=y
+CONFIG_NET_VENDOR_ATHEROS=y
+# CONFIG_ATL2 is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_ALX is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+CONFIG_NET_VENDOR_BROCADE=y
+# CONFIG_BNA is not set
+# CONFIG_NET_CALXEDA_XGMAC is not set
+CONFIG_NET_VENDOR_CHELSIO=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_CHELSIO_T4 is not set
+# CONFIG_CHELSIO_T4VF is not set
+CONFIG_NET_VENDOR_CISCO=y
+# CONFIG_ENIC is not set
+# CONFIG_DM9000 is not set
+# CONFIG_DNET is not set
+CONFIG_NET_VENDOR_DEC=y
+# CONFIG_NET_TULIP is not set
+CONFIG_NET_VENDOR_DLINK=y
+# CONFIG_DL2K is not set
+# CONFIG_SUNDANCE is not set
+CONFIG_NET_VENDOR_EMULEX=y
+# CONFIG_BE2NET is not set
+CONFIG_NET_VENDOR_EXAR=y
+# CONFIG_S2IO is not set
+# CONFIG_VXGE is not set
+CONFIG_NET_VENDOR_HP=y
+# CONFIG_HP100 is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_IP1000 is not set
+# CONFIG_JME is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+CONFIG_NET_VENDOR_MELLANOX=y
+# CONFIG_MLX4_EN is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_MLX5_CORE is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+CONFIG_NET_VENDOR_MYRI=y
+# CONFIG_MYRI10GE is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_NET_VENDOR_NVIDIA=y
+# CONFIG_FORCEDETH is not set
+CONFIG_NET_VENDOR_OKI=y
+# CONFIG_ETHOC is not set
+CONFIG_NET_PACKET_ENGINE=y
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+CONFIG_NET_VENDOR_QLOGIC=y
+# CONFIG_QLA3XXX is not set
+# CONFIG_QLCNIC is not set
+# CONFIG_QLGE is not set
+# CONFIG_NETXEN_NIC is not set
+CONFIG_NET_VENDOR_REALTEK=y
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_R8169 is not set
+# CONFIG_SH_ETH is not set
+CONFIG_NET_VENDOR_RDC=y
+# CONFIG_R6040 is not set
+CONFIG_NET_VENDOR_SAMSUNG=y
+# CONFIG_SXGBE_ETH is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_NET_VENDOR_SILAN=y
+# CONFIG_SC92031 is not set
+CONFIG_NET_VENDOR_SIS=y
+# CONFIG_SIS900 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SFC is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_NET_VENDOR_SUN=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NIU is not set
+CONFIG_NET_VENDOR_TEHUTI=y
+# CONFIG_TEHUTI is not set
+CONFIG_NET_VENDOR_TI=y
+# CONFIG_TLAN is not set
+CONFIG_NET_VENDOR_TOSHIBA=y
+# CONFIG_TC35815 is not set
+CONFIG_NET_VENDOR_VIA=y
+# CONFIG_VIA_RHINE is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_AT803X_PHY is not set
+# CONFIG_AMD_PHY is not set
+CONFIG_MARVELL_PHY=y
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+CONFIG_BROADCOM_PHY=y
+# CONFIG_BCM7XXX_PHY is not set
+CONFIG_BCM87XX_PHY=y
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_WLAN is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_VMXNET3 is not set
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_TTY=y
+# CONFIG_VT is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+CONFIG_DEVKMEM=y
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MFD_HSU is not set
+# CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_SCCNXP is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+# CONFIG_SERIAL_PCH_UART is not set
+# CONFIG_SERIAL_ARC is not set
+# CONFIG_SERIAL_RP2 is not set
+# CONFIG_SERIAL_FSL_LPUART is not set
+# CONFIG_TTY_PRINTK is not set
+CONFIG_HVC_DRIVER=y
+CONFIG_VIRTIO_CONSOLE=y
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_I2C is not set
+# CONFIG_SPI is not set
+# CONFIG_SPMI is not set
+# CONFIG_HSI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+
+#
+# PPS generators support
+#
+
+#
+# PTP clock support
+#
+# CONFIG_PTP_1588_CLOCK is not set
+
+#
+# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
+#
+CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_POWER_AVS is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+CONFIG_BCMA_POSSIBLE=y
+
+#
+# Broadcom specific AMBA
+#
+# CONFIG_BCMA is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_CROS_EC is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_LPC_ICH is not set
+# CONFIG_LPC_SCH is not set
+# CONFIG_MFD_JANZ_CMODIO is not set
+# CONFIG_MFD_KEMPLD is not set
+# CONFIG_MFD_RDC321X is not set
+# CONFIG_MFD_RTSX_PCI is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_ABX500_CORE is not set
+# CONFIG_MFD_SYSCON is not set
+# CONFIG_MFD_TI_AM335X_TSCADC is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_VX855 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+CONFIG_VGA_ARB=y
+CONFIG_VGA_ARB_MAX_GPUS=16
+
+#
+# Direct Rendering Manager
+#
+# CONFIG_DRM is not set
+
+#
+# Frame buffer Devices
+#
+# CONFIG_FB is not set
+# CONFIG_EXYNOS_VIDEO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_SOUND is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_UWB is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_VIRT_DRIVERS is not set
+CONFIG_VIRTIO=y
+
+#
+# Virtio drivers
+#
+CONFIG_VIRTIO_PCI=y
+# CONFIG_VIRTIO_BALLOON is not set
+# CONFIG_VIRTIO_MMIO is not set
+
+#
+# Microsoft Hyper-V guest support
+#
+# CONFIG_STAGING is not set
+
+#
+# Hardware Spinlock drivers
+#
+# CONFIG_SH_TIMER_CMT is not set
+# CONFIG_SH_TIMER_MTU2 is not set
+# CONFIG_SH_TIMER_TMU is not set
+# CONFIG_EM_TIMER_STI is not set
+# CONFIG_MAILBOX is not set
+# CONFIG_IOMMU_SUPPORT is not set
+
+#
+# Remoteproc drivers
+#
+# CONFIG_STE_MODEM_RPROC is not set
+
+#
+# Rpmsg drivers
+#
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_VME_BUS is not set
+# CONFIG_PWM is not set
+# CONFIG_IPACK_BUS is not set
+# CONFIG_RESET_CONTROLLER is not set
+# CONFIG_FMC is not set
+
+#
+# PHY Subsystem
+#
+# CONFIG_GENERIC_PHY is not set
+# CONFIG_PHY_SAMSUNG_USB2 is not set
+# CONFIG_POWERCAP is not set
+# CONFIG_MCB is not set
+
+#
+# Firmware Drivers
+#
+# CONFIG_FIRMWARE_MEMMAP is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT23=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_JBD2=y
+# CONFIG_JBD2_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FS_POSIX_ACL=y
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_FANOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_QUOTACTL is not set
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
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_KERNFS=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_TMPFS_XATTR is not set
+CONFIG_HUGETLBFS=y
+CONFIG_HUGETLB_PAGE=y
+# CONFIG_CONFIGFS_FS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V2=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
+# CONFIG_NFS_SWAP is not set
+CONFIG_NFS_V4_1=y
+# CONFIG_NFS_V4_2 is not set
+CONFIG_PNFS_FILE_LAYOUT=y
+CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
+# CONFIG_NFS_V4_1_MIGRATION is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFS_USE_LEGACY_DNS is not set
+CONFIG_NFS_USE_KERNEL_DNS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_SUNRPC_BACKCHANNEL=y
+# CONFIG_SUNRPC_DEBUG is not set
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
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
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_MAC_ROMAN is not set
+# CONFIG_NLS_MAC_CELTIC is not set
+# CONFIG_NLS_MAC_CENTEURO is not set
+# CONFIG_NLS_MAC_CROATIAN is not set
+# CONFIG_NLS_MAC_CYRILLIC is not set
+# CONFIG_NLS_MAC_GAELIC is not set
+# CONFIG_NLS_MAC_GREEK is not set
+# CONFIG_NLS_MAC_ICELAND is not set
+# CONFIG_NLS_MAC_INUIT is not set
+# CONFIG_NLS_MAC_ROMANIAN is not set
+# CONFIG_NLS_MAC_TURKISH is not set
+CONFIG_NLS_UTF8=y
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+
+#
+# printk and dmesg options
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_DYNAMIC_DEBUG is not set
+
+#
+# Compile-time checks and compiler options
+#
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_INFO_REDUCED is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=2048
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
+CONFIG_DEBUG_KERNEL=y
+
+#
+# Memory Debugging
+#
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_HAVE_DEBUG_KMEMLEAK=y
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_SHIRQ is not set
+
+#
+# Debug Lockups and Hangs
+#
+# CONFIG_LOCKUP_DETECTOR is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+CONFIG_PANIC_TIMEOUT=0
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+CONFIG_DEBUG_PREEMPT=y
+
+#
+# Lock Debugging (spinlocks, mutexes, etc...)
+#
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_LOCK_TORTURE_TEST is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+
+#
+# RCU Debugging
+#
+# CONFIG_PROVE_RCU_DELAY is not set
+# CONFIG_SPARSE_RCU_POINTER is not set
+# CONFIG_TORTURE_TEST is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+CONFIG_RCU_CPU_STALL_TIMEOUT=21
+CONFIG_RCU_CPU_STALL_VERBOSE=y
+# CONFIG_RCU_CPU_STALL_INFO is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
+CONFIG_HAVE_C_RECORDMCOUNT=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+
+#
+# Runtime Testing
+#
+# CONFIG_LKDTM is not set
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_PERCPU_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_TEST_STRING_HELPERS is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_TEST_MODULE is not set
+# CONFIG_TEST_USER_COPY is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_EARLY_PRINTK=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_RUNTIME_DEBUG is not set
+# CONFIG_SPINLOCK_TEST is not set
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+# CONFIG_PERSISTENT_KEYRINGS is not set
+# CONFIG_BIG_KEYS is not set
+# CONFIG_ENCRYPTED_KEYS is not set
+# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
+# CONFIG_SECURITY_DMESG_RESTRICT is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP2=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_USER is not set
+CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
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
+# CONFIG_CRYPTO_CMAC is not set
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_CRC32 is not set
+# CONFIG_CRYPTO_CRCT10DIF is not set
+# CONFIG_CRYPTO_GHASH is not set
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
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
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
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+# CONFIG_CRYPTO_LZ4 is not set
+# CONFIG_CRYPTO_LZ4HC is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_ASYMMETRIC_KEY_TYPE is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_NET_UTILS=y
+CONFIG_NO_GENERIC_PCI_IOPORT_MAP=y
+CONFIG_GENERIC_PCI_IOMAP=y
+CONFIG_GENERIC_IO=y
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC16=y
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC32_SELFTEST is not set
+CONFIG_CRC32_SLICEBY8=y
+# CONFIG_CRC32_SLICEBY4 is not set
+# CONFIG_CRC32_SARWATE is not set
+# CONFIG_CRC32_BIT is not set
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+# CONFIG_CRC8 is not set
+# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
+# CONFIG_RANDOM32_SELFTEST is not set
+CONFIG_ZLIB_INFLATE=y
+# CONFIG_XZ_DEC is not set
+# CONFIG_XZ_DEC_BCJ is not set
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_ASSOCIATIVE_ARRAY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT_MAP=y
+CONFIG_HAS_DMA=y
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
+# CONFIG_AVERAGE is not set
+# CONFIG_CORDIC is not set
+# CONFIG_DDR is not set
+CONFIG_OID_REGISTRY=y
+# CONFIG_VIRTUALIZATION is not set
-- 
1.7.9.5
