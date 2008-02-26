Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2008 19:56:03 +0000 (GMT)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:7045 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28586491AbYBZTz7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Feb 2008 19:55:59 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 892295BC03B;
	Tue, 26 Feb 2008 21:55:58 +0200 (EET)
Date:	Tue, 26 Feb 2008 21:54:54 +0200
From:	Adrian Bunk <adrian.bunk@movial.fi>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] mips: use KBUILD_DEFCONFIG
Message-ID: <20080226195454.GC4898@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <adrian.bunk@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adrian.bunk@movial.fi
Precedence: bulk
X-list: linux-mips

With KBUILD_DEFCONFIG we don't have to ship a second copy of 
ip22_defconfig

Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>

---

 arch/mips/Makefile  |    2 
 arch/mips/defconfig | 1158 --------------------------------------------
 2 files changed, 2 insertions(+), 1158 deletions(-)

57da2fa4b7e8c035c8317e8796ca6d2ea17c1d1f diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 001c017..93ef27b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -12,6 +12,8 @@
 # for "archclean" cleaning up for this architecture.
 #
 
+KBUILD_DEFCONFIG := ip22_defconfig
+
 cflags-y :=
 
 #
diff --git a/arch/mips/defconfig b/arch/mips/defconfig
deleted file mode 100644
index 4f5e56c..0000000
--- a/arch/mips/defconfig
+++ /dev/null
@@ -1,1158 +0,0 @@
-#
-# Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Tue Aug  7 12:39:49 2007
-#
-CONFIG_MIPS=y
-
-#
-# Machine selection
-#
-CONFIG_ZONE_DMA=y
-# CONFIG_MACH_ALCHEMY is not set
-# CONFIG_BASLER_EXCITE is not set
-# CONFIG_MIPS_COBALT is not set
-# CONFIG_MACH_DECSTATION is not set
-# CONFIG_MACH_JAZZ is not set
-# CONFIG_LEMOTE_FULONG is not set
-# CONFIG_MIPS_ATLAS is not set
-# CONFIG_MIPS_MALTA is not set
-# CONFIG_MIPS_SEAD is not set
-# CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
-# CONFIG_MACH_VR41XX is not set
-# CONFIG_PNX8550_JBS is not set
-# CONFIG_PNX8550_STB810 is not set
-# CONFIG_PMC_MSP is not set
-# CONFIG_PMC_YOSEMITE is not set
-CONFIG_SGI_IP22=y
-# CONFIG_SGI_IP27 is not set
-# CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_CRHINE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_CRHONE is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_SWARM is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_BIGSUR is not set
-# CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
-# CONFIG_WR_PPMC is not set
-CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
-CONFIG_GENERIC_FIND_NEXT_BIT=y
-CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
-CONFIG_ARC=y
-CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_SYS_HAS_EARLY_PRINTK=y
-# CONFIG_NO_IOPORT is not set
-CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN=y
-CONFIG_CPU_BIG_ENDIAN=y
-# CONFIG_CPU_LITTLE_ENDIAN is not set
-CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
-CONFIG_IRQ_CPU=y
-CONFIG_SWAP_IO_SPACE=y
-CONFIG_ARC32=y
-CONFIG_BOOT_ELF32=y
-CONFIG_MIPS_L1_CACHE_SHIFT=5
-CONFIG_ARC_CONSOLE=y
-CONFIG_ARC_PROMLIB=y
-
-#
-# CPU selection
-#
-# CONFIG_CPU_LOONGSON2 is not set
-# CONFIG_CPU_MIPS32_R1 is not set
-# CONFIG_CPU_MIPS32_R2 is not set
-# CONFIG_CPU_MIPS64_R1 is not set
-# CONFIG_CPU_MIPS64_R2 is not set
-# CONFIG_CPU_R3000 is not set
-# CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
-# CONFIG_CPU_R4300 is not set
-# CONFIG_CPU_R4X00 is not set
-# CONFIG_CPU_TX49XX is not set
-CONFIG_CPU_R5000=y
-# CONFIG_CPU_R5432 is not set
-# CONFIG_CPU_R6000 is not set
-# CONFIG_CPU_NEVADA is not set
-# CONFIG_CPU_R8000 is not set
-# CONFIG_CPU_R10000 is not set
-# CONFIG_CPU_RM7000 is not set
-# CONFIG_CPU_RM9000 is not set
-# CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_R4X00=y
-CONFIG_SYS_HAS_CPU_R5000=y
-CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
-
-#
-# Kernel type
-#
-CONFIG_32BIT=y
-# CONFIG_64BIT is not set
-CONFIG_PAGE_SIZE_4KB=y
-# CONFIG_PAGE_SIZE_8KB is not set
-# CONFIG_PAGE_SIZE_16KB is not set
-# CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_BOARD_SCACHE=y
-CONFIG_IP22_CPU_SCACHE=y
-CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMP is not set
-# CONFIG_MIPS_MT_SMTC is not set
-CONFIG_CPU_HAS_LLSC=y
-CONFIG_CPU_HAS_SYNC=y
-CONFIG_GENERIC_HARDIRQS=y
-CONFIG_GENERIC_IRQ_PROBE=y
-CONFIG_ARCH_FLATMEM_ENABLE=y
-CONFIG_SELECT_MEMORY_MODEL=y
-CONFIG_FLATMEM_MANUAL=y
-# CONFIG_DISCONTIGMEM_MANUAL is not set
-# CONFIG_SPARSEMEM_MANUAL is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
-CONFIG_BOUNCE=y
-CONFIG_VIRT_TO_BUS=y
-# CONFIG_HZ_48 is not set
-# CONFIG_HZ_100 is not set
-# CONFIG_HZ_128 is not set
-# CONFIG_HZ_250 is not set
-# CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
-# CONFIG_HZ_1024 is not set
-CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
-# CONFIG_PREEMPT_NONE is not set
-CONFIG_PREEMPT_VOLUNTARY=y
-# CONFIG_PREEMPT is not set
-# CONFIG_KEXEC is not set
-CONFIG_SECCOMP=y
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_STACKTRACE_SUPPORT=y
-CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
-
-#
-# General setup
-#
-CONFIG_EXPERIMENTAL=y
-CONFIG_BROKEN_ON_SMP=y
-CONFIG_INIT_ENV_ARG_LIMIT=32
-CONFIG_LOCALVERSION=""
-CONFIG_LOCALVERSION_AUTO=y
-CONFIG_SWAP=y
-CONFIG_SYSVIPC=y
-CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
-# CONFIG_BSD_PROCESS_ACCT is not set
-# CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
-# CONFIG_AUDIT is not set
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
-# CONFIG_BLK_DEV_INITRD is not set
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_SYSCTL=y
-CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_PRINTK=y
-CONFIG_BUG=y
-CONFIG_ELF_CORE=y
-CONFIG_BASE_FULL=y
-CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
-CONFIG_EPOLL=y
-CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
-CONFIG_EVENTFD=y
-CONFIG_SHMEM=y
-CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
-# CONFIG_SLOB is not set
-CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
-CONFIG_BASE_SMALL=0
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_KMOD=y
-CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
-# CONFIG_BLK_DEV_BSG is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
-# CONFIG_DEFAULT_CFQ is not set
-# CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
-
-#
-# Bus options (PCI, PCMCIA, EISA, ISA, TC)
-#
-CONFIG_HW_HAS_EISA=y
-# CONFIG_ARCH_SUPPORTS_MSI is not set
-# CONFIG_EISA is not set
-CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-
-#
-# Executable file formats
-#
-CONFIG_BINFMT_ELF=y
-CONFIG_BINFMT_MISC=m
-CONFIG_TRAD_SIGNALS=y
-
-#
-# Power management options
-#
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_SUSPEND is not set
-
-#
-# Networking
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-CONFIG_PACKET_MMAP=y
-CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
-# CONFIG_XFRM_SUB_POLICY is not set
-CONFIG_XFRM_MIGRATE=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_FIB_HASH=y
-CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-# CONFIG_SYN_COOKIES is not set
-CONFIG_INET_AH=m
-CONFIG_INET_ESP=m
-CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_TUNNEL=m
-CONFIG_INET_TUNNEL=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_CUBIC=y
-CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-CONFIG_IP_VS=m
-# CONFIG_IP_VS_DEBUG is not set
-CONFIG_IP_VS_TAB_BITS=12
-
-#
-# IPVS transport protocol load balancing support
-#
-CONFIG_IP_VS_PROTO_TCP=y
-CONFIG_IP_VS_PROTO_UDP=y
-CONFIG_IP_VS_PROTO_ESP=y
-CONFIG_IP_VS_PROTO_AH=y
-
-#
-# IPVS scheduler
-#
-CONFIG_IP_VS_RR=m
-CONFIG_IP_VS_WRR=m
-CONFIG_IP_VS_LC=m
-CONFIG_IP_VS_WLC=m
-CONFIG_IP_VS_LBLC=m
-CONFIG_IP_VS_LBLCR=m
-CONFIG_IP_VS_DH=m
-CONFIG_IP_VS_SH=m
-CONFIG_IP_VS_SED=m
-CONFIG_IP_VS_NQ=m
-
-#
-# IPVS application helper
-#
-CONFIG_IP_VS_FTP=m
-CONFIG_IPV6=m
-CONFIG_IPV6_PRIVACY=y
-CONFIG_IPV6_ROUTER_PREF=y
-CONFIG_IPV6_ROUTE_INFO=y
-CONFIG_IPV6_OPTIMISTIC_DAD=y
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_TUNNEL=m
-CONFIG_INET6_TUNNEL=m
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
-CONFIG_INET6_XFRM_MODE_TUNNEL=m
-CONFIG_INET6_XFRM_MODE_BEET=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
-CONFIG_IPV6_SIT=m
-CONFIG_IPV6_TUNNEL=m
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_IPV6_SUBTREES=y
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
-CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_ACCT=y
-CONFIG_NF_CONNTRACK_MARK=y
-CONFIG_NF_CONNTRACK_SECMARK=y
-CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_GRE=m
-CONFIG_NF_CT_PROTO_SCTP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
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
-CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
-CONFIG_NETFILTER_XT_TARGET_DSCP=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
-CONFIG_NETFILTER_XT_TARGET_NFLOG=m
-CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
-CONFIG_NETFILTER_XT_TARGET_TRACE=m
-CONFIG_NETFILTER_XT_TARGET_SECMARK=m
-CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
-CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
-CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
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
-CONFIG_NETFILTER_XT_MATCH_U32=m
-CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
-
-#
-# IP: Netfilter Configuration
-#
-CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_NF_CONNTRACK_PROC_COMPAT=y
-CONFIG_IP_NF_QUEUE=m
-CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_IPRANGE=m
-CONFIG_IP_NF_MATCH_TOS=m
-CONFIG_IP_NF_MATCH_RECENT=m
-CONFIG_IP_NF_MATCH_ECN=m
-CONFIG_IP_NF_MATCH_AH=m
-CONFIG_IP_NF_MATCH_TTL=m
-CONFIG_IP_NF_MATCH_OWNER=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
-CONFIG_NF_NAT=m
-CONFIG_NF_NAT_NEEDED=y
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_SAME=m
-CONFIG_NF_NAT_SNMP_BASIC=m
-CONFIG_NF_NAT_PROTO_GRE=m
-CONFIG_NF_NAT_FTP=m
-CONFIG_NF_NAT_IRC=m
-CONFIG_NF_NAT_TFTP=m
-CONFIG_NF_NAT_AMANDA=m
-CONFIG_NF_NAT_PPTP=m
-CONFIG_NF_NAT_H323=m
-CONFIG_NF_NAT_SIP=m
-CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_TOS=m
-CONFIG_IP_NF_TARGET_ECN=m
-CONFIG_IP_NF_TARGET_TTL=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
-CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_ARPTABLES=m
-CONFIG_IP_NF_ARPFILTER=m
-CONFIG_IP_NF_ARP_MANGLE=m
-
-#
-# IPv6: Netfilter Configuration (EXPERIMENTAL)
-#
-CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
-CONFIG_IP6_NF_IPTABLES=m
-CONFIG_IP6_NF_MATCH_RT=m
-CONFIG_IP6_NF_MATCH_OPTS=m
-CONFIG_IP6_NF_MATCH_FRAG=m
-CONFIG_IP6_NF_MATCH_HL=m
-CONFIG_IP6_NF_MATCH_OWNER=m
-CONFIG_IP6_NF_MATCH_IPV6HEADER=m
-CONFIG_IP6_NF_MATCH_AH=m
-CONFIG_IP6_NF_MATCH_MH=m
-CONFIG_IP6_NF_MATCH_EUI64=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_LOG=m
-CONFIG_IP6_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_MANGLE=m
-CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_RAW=m
-# CONFIG_IP_DCCP is not set
-CONFIG_IP_SCTP=m
-# CONFIG_SCTP_DBG_MSG is not set
-# CONFIG_SCTP_DBG_OBJCNT is not set
-# CONFIG_SCTP_HMAC_NONE is not set
-# CONFIG_SCTP_HMAC_SHA1 is not set
-CONFIG_SCTP_HMAC_MD5=y
-# CONFIG_TIPC is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-CONFIG_NET_SCHED=y
-CONFIG_NET_SCH_FIFO=y
-
-#
-# Queueing/Scheduling
-#
-CONFIG_NET_SCH_CBQ=m
-CONFIG_NET_SCH_HTB=m
-CONFIG_NET_SCH_HFSC=m
-CONFIG_NET_SCH_PRIO=m
-CONFIG_NET_SCH_RR=m
-CONFIG_NET_SCH_RED=m
-CONFIG_NET_SCH_SFQ=m
-CONFIG_NET_SCH_TEQL=m
-CONFIG_NET_SCH_TBF=m
-CONFIG_NET_SCH_GRED=m
-CONFIG_NET_SCH_DSMARK=m
-CONFIG_NET_SCH_NETEM=m
-CONFIG_NET_SCH_INGRESS=m
-
-#
-# Classification
-#
-CONFIG_NET_CLS=y
-CONFIG_NET_CLS_BASIC=m
-CONFIG_NET_CLS_TCINDEX=m
-CONFIG_NET_CLS_ROUTE4=m
-CONFIG_NET_CLS_ROUTE=y
-CONFIG_NET_CLS_FW=m
-CONFIG_NET_CLS_U32=m
-# CONFIG_CLS_U32_PERF is not set
-# CONFIG_CLS_U32_MARK is not set
-CONFIG_NET_CLS_RSVP=m
-CONFIG_NET_CLS_RSVP6=m
-# CONFIG_NET_EMATCH is not set
-CONFIG_NET_CLS_ACT=y
-CONFIG_NET_ACT_POLICE=y
-CONFIG_NET_ACT_GACT=m
-CONFIG_GACT_PROB=y
-CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
-CONFIG_NET_ACT_PEDIT=m
-CONFIG_NET_ACT_SIMP=m
-CONFIG_NET_CLS_POLICE=y
-# CONFIG_NET_CLS_IND is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-# CONFIG_AF_RXRPC is not set
-CONFIG_FIB_RULES=y
-
-#
-# Wireless
-#
-CONFIG_CFG80211=m
-CONFIG_WIRELESS_EXT=y
-CONFIG_MAC80211=m
-# CONFIG_MAC80211_DEBUG is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_CRYPT_TKIP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_RFKILL=m
-CONFIG_RFKILL_INPUT=m
-# CONFIG_NET_9P is not set
-
-#
-# Device Drivers
-#
-
-#
-# Generic Driver Options
-#
-CONFIG_STANDALONE=y
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_SYS_HYPERVISOR is not set
-CONFIG_CONNECTOR=m
-# CONFIG_MTD is not set
-# CONFIG_PARPORT is not set
-CONFIG_BLK_DEV=y
-# CONFIG_BLK_DEV_COW_COMMON is not set
-# CONFIG_BLK_DEV_LOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
-# CONFIG_MISC_DEVICES is not set
-# CONFIG_IDE is not set
-
-#
-# SCSI device support
-#
-CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
-CONFIG_SCSI_DMA=y
-CONFIG_SCSI_TGT=m
-# CONFIG_SCSI_NETLINK is not set
-CONFIG_SCSI_PROC_FS=y
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
-# CONFIG_CHR_DEV_OSST is not set
-CONFIG_BLK_DEV_SR=y
-# CONFIG_BLK_DEV_SR_VENDOR is not set
-# CONFIG_CHR_DEV_SG is not set
-CONFIG_CHR_DEV_SCH=m
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-# CONFIG_SCSI_MULTI_LUN is not set
-CONFIG_SCSI_CONSTANTS=y
-# CONFIG_SCSI_LOGGING is not set
-CONFIG_SCSI_SCAN_ASYNC=y
-CONFIG_SCSI_WAIT_SCAN=m
-
-#
-# SCSI Transports
-#
-CONFIG_SCSI_SPI_ATTRS=m
-# CONFIG_SCSI_FC_ATTRS is not set
-CONFIG_SCSI_ISCSI_ATTRS=m
-# CONFIG_SCSI_SAS_LIBSAS is not set
-CONFIG_SCSI_LOWLEVEL=y
-CONFIG_ISCSI_TCP=m
-CONFIG_SGIWD93_SCSI=y
-# CONFIG_SCSI_DEBUG is not set
-# CONFIG_ATA is not set
-# CONFIG_MD is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
-# CONFIG_IFB is not set
-CONFIG_DUMMY=m
-CONFIG_BONDING=m
-CONFIG_MACVLAN=m
-CONFIG_EQUALIZER=m
-CONFIG_TUN=m
-CONFIG_PHYLIB=m
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-# CONFIG_VITESSE_PHY is not set
-# CONFIG_SMSC_PHY is not set
-# CONFIG_BROADCOM_PHY is not set
-# CONFIG_ICPLUS_PHY is not set
-# CONFIG_FIXED_PHY is not set
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_AX88796 is not set
-# CONFIG_DM9000 is not set
-CONFIG_SGISEEQ=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-
-#
-# Wireless LAN
-#
-CONFIG_WLAN_PRE80211=y
-CONFIG_STRIP=m
-CONFIG_WLAN_80211=y
-# CONFIG_LIBERTAS is not set
-CONFIG_HOSTAP=m
-# CONFIG_HOSTAP_FIRMWARE is not set
-# CONFIG_WAN is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
-# CONFIG_NETCONSOLE is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_ISDN is not set
-# CONFIG_PHONE is not set
-
-#
-# Input device support
-#
-CONFIG_INPUT=y
-# CONFIG_INPUT_FF_MEMLESS is not set
-# CONFIG_INPUT_POLLDEV is not set
-
-#
-# Userland interfaces
-#
-CONFIG_INPUT_MOUSEDEV=m
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input Device Drivers
-#
-CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_KEYBOARD_SUNKBD is not set
-# CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
-# CONFIG_KEYBOARD_NEWTON is not set
-# CONFIG_KEYBOARD_STOWAWAY is not set
-CONFIG_INPUT_MOUSE=y
-CONFIG_MOUSE_PS2=m
-# CONFIG_MOUSE_PS2_ALPS is not set
-CONFIG_MOUSE_PS2_LOGIPS2PP=y
-# CONFIG_MOUSE_PS2_SYNAPTICS is not set
-# CONFIG_MOUSE_PS2_LIFEBOOK is not set
-CONFIG_MOUSE_PS2_TRACKPOINT=y
-# CONFIG_MOUSE_PS2_TOUCHKIT is not set
-CONFIG_MOUSE_SERIAL=m
-# CONFIG_MOUSE_VSXXXAA is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
-
-#
-# Hardware I/O ports
-#
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-CONFIG_SERIO_LIBPS2=y
-CONFIG_SERIO_RAW=m
-# CONFIG_GAMEPORT is not set
-
-#
-# Character devices
-#
-CONFIG_VT=y
-CONFIG_VT_CONSOLE=y
-CONFIG_HW_CONSOLE=y
-CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_SERIAL_NONSTANDARD is not set
-
-#
-# Serial drivers
-#
-# CONFIG_SERIAL_8250 is not set
-
-#
-# Non-8250 serial port support
-#
-CONFIG_SERIAL_IP22_ZILOG=m
-CONFIG_SERIAL_CORE=m
-CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_IPMI_HANDLER is not set
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-CONFIG_INDYDOG=m
-# CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
-CONFIG_SGI_DS1286=m
-# CONFIG_R3964 is not set
-CONFIG_RAW_DRIVER=m
-CONFIG_MAX_RAW_DEVS=256
-# CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
-
-#
-# SPI support
-#
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
-# CONFIG_W1 is not set
-# CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
-
-#
-# Multifunction device drivers
-#
-# CONFIG_MFD_SM501 is not set
-
-#
-# Multimedia devices
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_DAB is not set
-
-#
-# Graphics support
-#
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Display device support
-#
-# CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-
-#
-# Console display driver support
-#
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_SGI_NEWPORT_CONSOLE=y
-CONFIG_DUMMY_CONSOLE=y
-CONFIG_FONT_8x16=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
-# CONFIG_LOGO_LINUX_CLUT224 is not set
-CONFIG_LOGO_SGI_CLUT224=y
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-CONFIG_HID_SUPPORT=y
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
-CONFIG_USB_SUPPORT=y
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-#
-
-#
-# USB Gadget Support
-#
-# CONFIG_USB_GADGET is not set
-# CONFIG_MMC is not set
-# CONFIG_NEW_LEDS is not set
-# CONFIG_RTC_CLASS is not set
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
-# Userspace I/O
-#
-# CONFIG_UIO is not set
-
-#
-# File systems
-#
-CONFIG_EXT2_FS=m
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_EXT4DEV_FS is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
-# CONFIG_REISERFS_FS is not set
-# CONFIG_JFS_FS is not set
-CONFIG_FS_POSIX_ACL=y
-CONFIG_XFS_FS=m
-CONFIG_XFS_QUOTA=y
-CONFIG_XFS_SECURITY=y
-# CONFIG_XFS_POSIX_ACL is not set
-# CONFIG_XFS_RT is not set
-# CONFIG_GFS2_FS is not set
-# CONFIG_OCFS2_FS is not set
-CONFIG_MINIX_FS=m
-# CONFIG_ROMFS_FS is not set
-CONFIG_INOTIFY=y
-CONFIG_INOTIFY_USER=y
-CONFIG_QUOTA=y
-# CONFIG_QFMT_V1 is not set
-CONFIG_QFMT_V2=m
-CONFIG_QUOTACTL=y
-CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
-CONFIG_GENERIC_ACL=y
-
-#
-# CD-ROM/DVD Filesystems
-#
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_UDF_NLS=y
-
-#
-# DOS/FAT/NT Filesystems
-#
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_FAT_DEFAULT_CODEPAGE=437
-CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
-# CONFIG_NTFS_FS is not set
-
-#
-# Pseudo filesystems
-#
-CONFIG_PROC_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_PROC_SYSCTL=y
-CONFIG_SYSFS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-# CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
-
-#
-# Miscellaneous filesystems
-#
-# CONFIG_ADFS_FS is not set
-# CONFIG_AFFS_FS is not set
-# CONFIG_ECRYPT_FS is not set
-# CONFIG_HFS_FS is not set
-# CONFIG_HFSPLUS_FS is not set
-# CONFIG_BEFS_FS is not set
-# CONFIG_BFS_FS is not set
-CONFIG_EFS_FS=m
-# CONFIG_CRAMFS is not set
-# CONFIG_VXFS_FS is not set
-# CONFIG_HPFS_FS is not set
-# CONFIG_QNX4FS_FS is not set
-# CONFIG_SYSV_FS is not set
-CONFIG_UFS_FS=m
-# CONFIG_UFS_FS_WRITE is not set
-# CONFIG_UFS_DEBUG is not set
-
-#
-# Network File Systems
-#
-CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
-CONFIG_NFS_V3_ACL=y
-# CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-CONFIG_NFSD_V2_ACL=y
-CONFIG_NFSD_V3=y
-CONFIG_NFSD_V3_ACL=y
-# CONFIG_NFSD_V4 is not set
-CONFIG_NFSD_TCP=y
-CONFIG_LOCKD=m
-CONFIG_LOCKD_V4=y
-CONFIG_EXPORTFS=m
-CONFIG_NFS_ACL_SUPPORT=m
-CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=m
-CONFIG_SUNRPC_GSS=m
-# CONFIG_SUNRPC_BIND34 is not set
-CONFIG_RPCSEC_GSS_KRB5=m
-# CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
-CONFIG_SMB_NLS_REMOTE="cp437"
-CONFIG_CIFS=m
-# CONFIG_CIFS_STATS is not set
-# CONFIG_CIFS_WEAK_PW_HASH is not set
-# CONFIG_CIFS_XATTR is not set
-# CONFIG_CIFS_DEBUG2 is not set
-# CONFIG_CIFS_EXPERIMENTAL is not set
-# CONFIG_NCP_FS is not set
-CONFIG_CODA_FS=m
-# CONFIG_CODA_FS_OLD_API is not set
-# CONFIG_AFS_FS is not set
-
-#
-# Partition Types
-#
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_ACORN_PARTITION is not set
-# CONFIG_OSF_PARTITION is not set
-# CONFIG_AMIGA_PARTITION is not set
-# CONFIG_ATARI_PARTITION is not set
-# CONFIG_MAC_PARTITION is not set
-CONFIG_MSDOS_PARTITION=y
-# CONFIG_BSD_DISKLABEL is not set
-# CONFIG_MINIX_SUBPARTITION is not set
-# CONFIG_SOLARIS_X86_PARTITION is not set
-# CONFIG_UNIXWARE_DISKLABEL is not set
-# CONFIG_LDM_PARTITION is not set
-CONFIG_SGI_PARTITION=y
-# CONFIG_ULTRIX_PARTITION is not set
-# CONFIG_SUN_PARTITION is not set
-# CONFIG_KARMA_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
-# CONFIG_SYSV68_PARTITION is not set
-
-#
-# Native Language Support
-#
-CONFIG_NLS=m
-CONFIG_NLS_DEFAULT="iso8859-1"
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
-# CONFIG_DLM_DEBUG is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
-# Kernel hacking
-#
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-# CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_MUST_CHECK=y
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
-# CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
-
-#
-# Security options
-#
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-# CONFIG_SECURITY is not set
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_ABLKCIPHER=m
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
-CONFIG_CRYPTO_CRYPTD=m
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
-# CONFIG_CRYPTO_HW is not set
-
-#
-# Library routines
-#
-CONFIG_BITREVERSE=m
-# CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=m
-# CONFIG_CRC_ITU_T is not set
-CONFIG_CRC32=m
-# CONFIG_CRC7 is not set
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
-CONFIG_HAS_IOMEM=y
-CONFIG_HAS_IOPORT=y
-CONFIG_HAS_DMA=y
