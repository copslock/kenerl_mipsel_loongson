Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 10:20:08 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9063 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824821Ab3HUITuHg0eA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 10:19:50 +0200
Received: (qmail 11599 invoked by uid 89); 21 Aug 2013 08:19:50 -0000
Received: by simscan 1.3.1 ppid: 11570, pid: 11596, t: 0.1495s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO azrael.ibk.sigmapriv.at) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 21 Aug 2013 08:19:50 -0000
From:   Richard Weinberger <richard@nod.at>
To:     linux-arch@vger.kernel.org
Cc:     mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org,
        lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
Date:   Wed, 21 Aug 2013 10:19:25 +0200
Message-Id: <1377073172-3662-2-git-send-email-richard@nod.at>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Instead of having one defconfig for both i386 and x86_64
we have now two.
This is the first step to get rid of SUBARCH.

This patch is based on: https://lkml.org/lkml/2013/7/4/396

Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/configs/i386_defconfig   | 954 +++++++++++++++++++++++++++++++++++++++
 arch/um/configs/x86_64_defconfig | 943 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 1897 insertions(+)
 create mode 100644 arch/um/configs/i386_defconfig
 create mode 100644 arch/um/configs/x86_64_defconfig

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
new file mode 100644
index 0000000..488ac2a
--- /dev/null
+++ b/arch/um/configs/i386_defconfig
@@ -0,0 +1,954 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# User Mode Linux 3.9.0-rc6 Kernel Configuration
+#
+CONFIG_DEFCONFIG_LIST="arch/$ARCH/defconfig"
+CONFIG_UML=y
+CONFIG_MMU=y
+CONFIG_NO_IOMEM=y
+# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+# CONFIG_STACKTRACE_SUPPORT is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_BUG=y
+CONFIG_HZ=100
+
+#
+# UML-specific options
+#
+
+#
+# Host processor type and features
+#
+# CONFIG_M486 is not set
+# CONFIG_M586 is not set
+# CONFIG_M586TSC is not set
+# CONFIG_M586MMX is not set
+CONFIG_M686=y
+# CONFIG_MPENTIUMII is not set
+# CONFIG_MPENTIUMIII is not set
+# CONFIG_MPENTIUMM is not set
+# CONFIG_MPENTIUM4 is not set
+# CONFIG_MK6 is not set
+# CONFIG_MK7 is not set
+# CONFIG_MK8 is not set
+# CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
+# CONFIG_MWINCHIPC6 is not set
+# CONFIG_MWINCHIP3D is not set
+# CONFIG_MELAN is not set
+# CONFIG_MGEODEGX1 is not set
+# CONFIG_MGEODE_LX is not set
+# CONFIG_MCYRIXIII is not set
+# CONFIG_MVIAC3_2 is not set
+# CONFIG_MVIAC7 is not set
+# CONFIG_MPSC is not set
+# CONFIG_MCORE2 is not set
+# CONFIG_MATOM is not set
+# CONFIG_GENERIC_CPU is not set
+# CONFIG_X86_GENERIC is not set
+CONFIG_X86_INTERNODE_CACHE_SHIFT=5
+CONFIG_X86_L1_CACHE_SHIFT=5
+# CONFIG_X86_PPRO_FENCE is not set
+CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_X86_TSC=y
+CONFIG_X86_CMPXCHG64=y
+CONFIG_X86_CMOV=y
+CONFIG_X86_MINIMUM_CPU_FAMILY=5
+CONFIG_CPU_SUP_INTEL=y
+CONFIG_CPU_SUP_AMD=y
+CONFIG_CPU_SUP_CENTAUR=y
+CONFIG_CPU_SUP_TRANSMETA_32=y
+CONFIG_UML_X86=y
+# CONFIG_64BIT is not set
+CONFIG_X86_32=y
+# CONFIG_X86_64 is not set
+# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_3_LEVEL_PGTABLES is not set
+CONFIG_ARCH_HAS_SC_SIGNALS=y
+CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
+CONFIG_GENERIC_HWEIGHT=y
+# CONFIG_STATIC_LINK is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_COMPACTION is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_CROSS_MEMORY_ATTACH=y
+CONFIG_NEED_PER_CPU_KM=y
+# CONFIG_CLEANCACHE is not set
+# CONFIG_FRONTSWAP is not set
+CONFIG_LD_SCRIPT_DYN=y
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_HAVE_AOUT=y
+# CONFIG_BINFMT_AOUT is not set
+CONFIG_BINFMT_MISC=m
+CONFIG_COREDUMP=y
+CONFIG_HOSTFS=y
+# CONFIG_HPPFS is not set
+CONFIG_MCONSOLE=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_KERNEL_STACK_ORDER=1
+# CONFIG_MMAPPER is not set
+CONFIG_NO_DMA=y
+CONFIG_IRQ_WORK=y
+
+#
+# General setup
+#
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=128
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_DEFAULT_HOSTNAME="(none)"
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_FHANDLE is not set
+# CONFIG_AUDIT is not set
+CONFIG_HAVE_GENERIC_HARDIRQS=y
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_SHOW=y
+# CONFIG_ALWAYS_USE_PERSISTENT_CLOCK is not set
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+
+#
+# Timers subsystem
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+
+#
+# CPU/Task time and stats accounting
+#
+CONFIG_TICK_CPU_ACCOUNTING=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TINY_RCU=y
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_RCU_STALL_COMMON is not set
+# CONFIG_TREE_RCU_TRACE is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+# CONFIG_CGROUP_DEBUG is not set
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_PROC_PID_CPUSET=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_RESOURCE_COUNTERS=y
+# CONFIG_MEMCG is not set
+CONFIG_CGROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_CFS_BANDWIDTH is not set
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_BLK_CGROUP=y
+# CONFIG_DEBUG_BLK_CGROUP is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+CONFIG_NAMESPACES=y
+CONFIG_UTS_NS=y
+CONFIG_IPC_NS=y
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_NET_NS=y
+CONFIG_UIDGID_CONVERTED=y
+# CONFIG_UIDGID_STRICT_TYPE_CHECKS is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+# CONFIG_EXPERT is not set
+CONFIG_HAVE_UID16=y
+CONFIG_UID16=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_HOTPLUG=y
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
+# CONFIG_EMBEDDED is not set
+
+#
+# Kernel Performance Events And Counters
+#
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_COMPAT_BRK=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
+CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
+CONFIG_MODULES_USE_ELF_REL=y
+CONFIG_CLONE_BACKWARDS=y
+CONFIG_OLD_SIGSUSPEND3=y
+CONFIG_OLD_SIGACTION=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
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
+CONFIG_LBDAF=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_BSGLIB is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+# CONFIG_BLK_DEV_THROTTLING is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=m
+# CONFIG_CFQ_GROUP_IOSCHED is not set
+CONFIG_DEFAULT_DEADLINE=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="deadline"
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+CONFIG_FREEZER=y
+
+#
+# UML Character Devices
+#
+CONFIG_STDERR_CONSOLE=y
+CONFIG_STDIO_CONSOLE=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_XTERM_CHAN=y
+# CONFIG_NOCONFIG_CHAN is not set
+CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
+CONFIG_CON_CHAN="xterm"
+CONFIG_SSL_CHAN="pts"
+CONFIG_UML_SOUND=m
+CONFIG_SOUND=m
+CONFIG_SOUND_OSS_CORE=y
+CONFIG_HOSTAUDIO=m
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+CONFIG_FW_LOADER_USER_HELPER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_GENERIC_CPU_DEVICES=y
+# CONFIG_DMA_SHARED_BUFFER is not set
+
+#
+# Bus devices
+#
+# CONFIG_CONNECTOR is not set
+# CONFIG_MTD is not set
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_UBD=y
+# CONFIG_BLK_DEV_UBD_SYNC is not set
+CONFIG_BLK_DEV_COW_COMMON=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_DRBD is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_RBD is not set
+
+#
+# Misc devices
+#
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
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
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+CONFIG_DUMMY=m
+# CONFIG_EQUALIZER is not set
+# CONFIG_MII is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_VXLAN is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+CONFIG_TUN=m
+# CONFIG_VETH is not set
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
+CONFIG_NET_VENDOR_INTEL=y
+CONFIG_NET_VENDOR_I825XX=y
+CONFIG_NET_VENDOR_MARVELL=y
+# CONFIG_MVMDIO is not set
+CONFIG_NET_VENDOR_NATSEMI=y
+CONFIG_NET_VENDOR_8390=y
+# CONFIG_PHYLIB is not set
+CONFIG_PPP=m
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_FILTER is not set
+# CONFIG_PPP_MPPE is not set
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPPOE is not set
+# CONFIG_PPP_ASYNC is not set
+# CONFIG_PPP_SYNC_TTY is not set
+CONFIG_SLIP=m
+CONFIG_SLHC=m
+# CONFIG_SLIP_COMPRESSED is not set
+# CONFIG_SLIP_SMART is not set
+# CONFIG_SLIP_MODE_SLIP6 is not set
+CONFIG_WLAN=y
+# CONFIG_HOSTAP is not set
+# CONFIG_WL_TI is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+
+#
+# Character devices
+#
+CONFIG_TTY=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=32
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+CONFIG_DEVKMEM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_UML_RANDOM=y
+# CONFIG_R3964 is not set
+# CONFIG_NSC_GPIO is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_I2C is not set
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
+# CONFIG_PTP_1588_CLOCK_PCH is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_POWER_AVS is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+# CONFIG_REGULATOR is not set
+CONFIG_SOUND_OSS_CORE_PRECLAIM=y
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB_ARCH_HAS_XHCI is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# Virtio drivers
+#
+
+#
+# Microsoft Hyper-V guest support
+#
+# CONFIG_STAGING is not set
+
+#
+# Hardware Spinlock drivers
+#
+# CONFIG_MAILBOX is not set
+CONFIG_IOMMU_SUPPORT=y
+
+#
+# Remoteproc drivers
+#
+
+#
+# Rpmsg drivers
+#
+# CONFIG_VIRT_DRIVERS is not set
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_PWM is not set
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
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_NET_IPVTI is not set
+# CONFIG_INET_AH is not set
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
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
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
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETPRIO_CGROUP is not set
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
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
+
+#
+# UML Network Devices
+#
+CONFIG_UML_NET=y
+CONFIG_UML_NET_ETHERTAP=y
+CONFIG_UML_NET_TUNTAP=y
+CONFIG_UML_NET_SLIP=y
+CONFIG_UML_NET_DAEMON=y
+# CONFIG_UML_NET_VDE is not set
+CONFIG_UML_NET_MCAST=y
+# CONFIG_UML_NET_PCAP is not set
+CONFIG_UML_NET_SLIRP=y
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT23=y
+# CONFIG_EXT4_FS_POSIX_ACL is not set
+# CONFIG_EXT4_FS_SECURITY is not set
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_JBD2=y
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=y
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_REISERFS_FS_XATTR is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_FANOTIFY is not set
+CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
+CONFIG_PRINT_QUOTA_WARNING=y
+# CONFIG_QUOTA_DEBUG is not set
+# CONFIG_QFMT_V1 is not set
+# CONFIG_QFMT_V2 is not set
+CONFIG_QUOTACTL=y
+CONFIG_AUTOFS4_FS=m
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
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_TMPFS_XATTR is not set
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
+# CONFIG_LOGFS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX6FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_F2FS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
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
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
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
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
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
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=m
+CONFIG_CRYPTO_RNG2=m
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_MANAGER2 is not set
+# CONFIG_CRYPTO_USER is not set
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
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_CRC32 is not set
+# CONFIG_CRYPTO_GHASH is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
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
+# CONFIG_CRYPTO_AES_586 is not set
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
+# CONFIG_CRYPTO_SALSA20_586 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_TWOFISH_586 is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+CONFIG_CRYPTO_ANSI_CPRNG=m
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_FIRST_BIT=y
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
+# CONFIG_XZ_DEC is not set
+# CONFIG_XZ_DEC_BCJ is not set
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+# CONFIG_AVERAGE is not set
+# CONFIG_CORDIC is not set
+# CONFIG_DDR is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_LOCKUP_DETECTOR is not set
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+# CONFIG_DETECT_HUNG_TASK is not set
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_INFO_REDUCED is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+CONFIG_DEBUG_MEMORY_INIT=y
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+CONFIG_FRAME_POINTER=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+
+#
+# RCU Debugging
+#
+# CONFIG_SPARSE_RCU_POINTER is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_GPROF is not set
+# CONFIG_GCOV is not set
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
new file mode 100644
index 0000000..66a38c6
--- /dev/null
+++ b/arch/um/configs/x86_64_defconfig
@@ -0,0 +1,943 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# User Mode Linux 3.9.0-rc6 Kernel Configuration
+#
+CONFIG_DEFCONFIG_LIST="arch/$ARCH/defconfig"
+CONFIG_UML=y
+CONFIG_MMU=y
+CONFIG_NO_IOMEM=y
+# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
+CONFIG_LOCKDEP_SUPPORT=y
+# CONFIG_STACKTRACE_SUPPORT is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_BUG=y
+CONFIG_HZ=100
+
+#
+# UML-specific options
+#
+
+#
+# Host processor type and features
+#
+# CONFIG_M486 is not set
+# CONFIG_M586 is not set
+# CONFIG_M586TSC is not set
+# CONFIG_M586MMX is not set
+# CONFIG_M686 is not set
+# CONFIG_MPENTIUMII is not set
+# CONFIG_MPENTIUMIII is not set
+# CONFIG_MPENTIUMM is not set
+# CONFIG_MPENTIUM4 is not set
+# CONFIG_MK6 is not set
+# CONFIG_MK7 is not set
+# CONFIG_MK8 is not set
+# CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
+# CONFIG_MWINCHIPC6 is not set
+# CONFIG_MWINCHIP3D is not set
+# CONFIG_MELAN is not set
+# CONFIG_MGEODEGX1 is not set
+# CONFIG_MGEODE_LX is not set
+# CONFIG_MCYRIXIII is not set
+# CONFIG_MVIAC3_2 is not set
+# CONFIG_MVIAC7 is not set
+# CONFIG_MPSC is not set
+# CONFIG_MCORE2 is not set
+# CONFIG_MATOM is not set
+CONFIG_GENERIC_CPU=y
+CONFIG_X86_INTERNODE_CACHE_SHIFT=6
+CONFIG_X86_L1_CACHE_SHIFT=6
+CONFIG_X86_TSC=y
+CONFIG_X86_CMPXCHG64=y
+CONFIG_X86_CMOV=y
+CONFIG_X86_MINIMUM_CPU_FAMILY=64
+CONFIG_CPU_SUP_INTEL=y
+CONFIG_CPU_SUP_AMD=y
+CONFIG_CPU_SUP_CENTAUR=y
+CONFIG_UML_X86=y
+CONFIG_64BIT=y
+# CONFIG_X86_32 is not set
+CONFIG_X86_64=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
+CONFIG_3_LEVEL_PGTABLES=y
+# CONFIG_ARCH_HAS_SC_SIGNALS is not set
+# CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA is not set
+CONFIG_GENERIC_HWEIGHT=y
+# CONFIG_STATIC_LINK is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_COMPACTION is not set
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_CROSS_MEMORY_ATTACH=y
+CONFIG_NEED_PER_CPU_KM=y
+# CONFIG_CLEANCACHE is not set
+# CONFIG_FRONTSWAP is not set
+CONFIG_LD_SCRIPT_DYN=y
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+# CONFIG_HAVE_AOUT is not set
+CONFIG_BINFMT_MISC=m
+CONFIG_COREDUMP=y
+CONFIG_HOSTFS=y
+# CONFIG_HPPFS is not set
+CONFIG_MCONSOLE=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_KERNEL_STACK_ORDER=1
+# CONFIG_MMAPPER is not set
+CONFIG_NO_DMA=y
+CONFIG_IRQ_WORK=y
+
+#
+# General setup
+#
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=128
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_DEFAULT_HOSTNAME="(none)"
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_FHANDLE is not set
+# CONFIG_AUDIT is not set
+CONFIG_HAVE_GENERIC_HARDIRQS=y
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_SHOW=y
+# CONFIG_ALWAYS_USE_PERSISTENT_CLOCK is not set
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+
+#
+# Timers subsystem
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+
+#
+# CPU/Task time and stats accounting
+#
+CONFIG_TICK_CPU_ACCOUNTING=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TINY_RCU=y
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_RCU_STALL_COMMON is not set
+# CONFIG_TREE_RCU_TRACE is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+# CONFIG_CGROUP_DEBUG is not set
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_PROC_PID_CPUSET=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_RESOURCE_COUNTERS=y
+# CONFIG_MEMCG is not set
+CONFIG_CGROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_CFS_BANDWIDTH is not set
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_BLK_CGROUP=y
+# CONFIG_DEBUG_BLK_CGROUP is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+CONFIG_NAMESPACES=y
+CONFIG_UTS_NS=y
+CONFIG_IPC_NS=y
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_NET_NS=y
+CONFIG_UIDGID_CONVERTED=y
+# CONFIG_UIDGID_STRICT_TYPE_CHECKS is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+# CONFIG_EXPERT is not set
+CONFIG_HAVE_UID16=y
+CONFIG_UID16=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_HOTPLUG=y
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
+# CONFIG_EMBEDDED is not set
+
+#
+# Kernel Performance Events And Counters
+#
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_COMPAT_BRK=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
+CONFIG_MODULES_USE_ELF_RELA=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
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
+# CONFIG_BLK_DEV_THROTTLING is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=m
+# CONFIG_CFQ_GROUP_IOSCHED is not set
+CONFIG_DEFAULT_DEADLINE=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="deadline"
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+CONFIG_FREEZER=y
+
+#
+# UML Character Devices
+#
+CONFIG_STDERR_CONSOLE=y
+CONFIG_STDIO_CONSOLE=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_XTERM_CHAN=y
+# CONFIG_NOCONFIG_CHAN is not set
+CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
+CONFIG_CON_CHAN="xterm"
+CONFIG_SSL_CHAN="pts"
+CONFIG_UML_SOUND=m
+CONFIG_SOUND=m
+CONFIG_SOUND_OSS_CORE=y
+CONFIG_HOSTAUDIO=m
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+CONFIG_FW_LOADER_USER_HELPER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_GENERIC_CPU_DEVICES=y
+# CONFIG_DMA_SHARED_BUFFER is not set
+
+#
+# Bus devices
+#
+# CONFIG_CONNECTOR is not set
+# CONFIG_MTD is not set
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_UBD=y
+# CONFIG_BLK_DEV_UBD_SYNC is not set
+CONFIG_BLK_DEV_COW_COMMON=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_DRBD is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_RBD is not set
+
+#
+# Misc devices
+#
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_93CX6 is not set
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
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+CONFIG_DUMMY=m
+# CONFIG_EQUALIZER is not set
+# CONFIG_MII is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_VXLAN is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+CONFIG_TUN=m
+# CONFIG_VETH is not set
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
+CONFIG_NET_VENDOR_INTEL=y
+CONFIG_NET_VENDOR_I825XX=y
+CONFIG_NET_VENDOR_MARVELL=y
+# CONFIG_MVMDIO is not set
+CONFIG_NET_VENDOR_NATSEMI=y
+CONFIG_NET_VENDOR_8390=y
+# CONFIG_PHYLIB is not set
+CONFIG_PPP=m
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_FILTER is not set
+# CONFIG_PPP_MPPE is not set
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPPOE is not set
+# CONFIG_PPP_ASYNC is not set
+# CONFIG_PPP_SYNC_TTY is not set
+CONFIG_SLIP=m
+CONFIG_SLHC=m
+# CONFIG_SLIP_COMPRESSED is not set
+# CONFIG_SLIP_SMART is not set
+# CONFIG_SLIP_MODE_SLIP6 is not set
+CONFIG_WLAN=y
+# CONFIG_HOSTAP is not set
+# CONFIG_WL_TI is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+
+#
+# Character devices
+#
+CONFIG_TTY=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=32
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+CONFIG_DEVKMEM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_UML_RANDOM=y
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_I2C is not set
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
+# CONFIG_PTP_1588_CLOCK_PCH is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_POWER_AVS is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+# CONFIG_REGULATOR is not set
+CONFIG_SOUND_OSS_CORE_PRECLAIM=y
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB_ARCH_HAS_XHCI is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# Virtio drivers
+#
+
+#
+# Microsoft Hyper-V guest support
+#
+# CONFIG_STAGING is not set
+
+#
+# Hardware Spinlock drivers
+#
+# CONFIG_MAILBOX is not set
+CONFIG_IOMMU_SUPPORT=y
+
+#
+# Remoteproc drivers
+#
+
+#
+# Rpmsg drivers
+#
+# CONFIG_VIRT_DRIVERS is not set
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_PWM is not set
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
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_NET_IPVTI is not set
+# CONFIG_INET_AH is not set
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
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
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
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETPRIO_CGROUP is not set
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
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
+
+#
+# UML Network Devices
+#
+CONFIG_UML_NET=y
+CONFIG_UML_NET_ETHERTAP=y
+CONFIG_UML_NET_TUNTAP=y
+CONFIG_UML_NET_SLIP=y
+CONFIG_UML_NET_DAEMON=y
+# CONFIG_UML_NET_VDE is not set
+CONFIG_UML_NET_MCAST=y
+# CONFIG_UML_NET_PCAP is not set
+CONFIG_UML_NET_SLIRP=y
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT23=y
+# CONFIG_EXT4_FS_POSIX_ACL is not set
+# CONFIG_EXT4_FS_SECURITY is not set
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_JBD2=y
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=y
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_REISERFS_FS_XATTR is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_FANOTIFY is not set
+CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
+CONFIG_PRINT_QUOTA_WARNING=y
+# CONFIG_QUOTA_DEBUG is not set
+# CONFIG_QFMT_V1 is not set
+# CONFIG_QFMT_V2 is not set
+CONFIG_QUOTACTL=y
+CONFIG_AUTOFS4_FS=m
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
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_TMPFS_XATTR is not set
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
+# CONFIG_LOGFS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX6FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_F2FS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
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
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
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
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
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
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=m
+CONFIG_CRYPTO_RNG2=m
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_MANAGER2 is not set
+# CONFIG_CRYPTO_USER is not set
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
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_CRC32 is not set
+# CONFIG_CRYPTO_GHASH is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
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
+# CONFIG_CRYPTO_AES_X86_64 is not set
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
+# CONFIG_CRYPTO_SALSA20_X86_64 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+CONFIG_CRYPTO_ANSI_CPRNG=m
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_FIRST_BIT=y
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
+# CONFIG_XZ_DEC is not set
+# CONFIG_XZ_DEC_BCJ is not set
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+# CONFIG_AVERAGE is not set
+# CONFIG_CORDIC is not set
+# CONFIG_DDR is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_LOCKUP_DETECTOR is not set
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+# CONFIG_DETECT_HUNG_TASK is not set
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_INFO_REDUCED is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+CONFIG_DEBUG_MEMORY_INIT=y
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+CONFIG_FRAME_POINTER=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+
+#
+# RCU Debugging
+#
+# CONFIG_SPARSE_RCU_POINTER is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_GPROF is not set
+# CONFIG_GCOV is not set
+CONFIG_EARLY_PRINTK=y
-- 
1.8.1.4
