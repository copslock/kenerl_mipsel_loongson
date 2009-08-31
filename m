Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 02:15:37 +0200 (CEST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:28855 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493316AbZHaAP1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2009 02:15:27 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AswEAB+zmkqrR7O6/2dsb2JhbACcJaJaiEEBKo16BYIoBhGBW4Fa
X-IronPort-AV: E=Sophos;i="4.44,301,1249257600"; 
   d="scan'208";a="378537733"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 31 Aug 2009 00:15:11 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n7V0FBqm031033;
	Sun, 30 Aug 2009 17:15:11 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id n7V0FB5H016976;
	Mon, 31 Aug 2009 00:15:11 GMT
Date:	Sun, 30 Aug 2009 17:15:11 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] mips:powertv: Base files for Cisco Powertv platform, v4
Message-ID: <20090831001511.GA9059@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=207792; t=1251677711; x=1252541711;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH]=20mips=3Apowertv=3A=20Base=20files=20fo
	r=20Cisco=20Powertv=20platform,=20v4
	|Sender:=20;
	bh=tqX6xOBXM1mRQGuh/Hyi/OV0j2nRiZhXFZ0AX5vbZdI=;
	b=tk+/LkpiDgRAmA2lureX7b9qxEV6E7L2AGqxfycJNl5qNsQ4sDH1IH8gZx
	8xBu/G+oZhdDjrtu+rlDrwxLGQX/SFhuAVR9B2ev2oqudWXhBQ6hmv2nlAJi
	3FDLRbWRa+;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

This patch adds the Cisco Powertv cable settop box to the MIPS tree. This
platform is based on a MIPS 24Kc processor with various devices integrated
on the same ASIC. There are multiple models of this box, with differing
configuration but the same kernel runs across the product line.

This code has been out of the tree *way* too long and, though it has no
checkpatch errors, it a few checkpatch warnings and other non-standard things
in it. Still, you have to start sometime, so this is where things are today.
Adds the Cisco PowerTV platform to the configuration and Make files so
that we can build a kernel for it.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/Kconfig                                  |   26 +
 arch/mips/Makefile                                 |    8 +
 arch/mips/configs/powertv_defconfig                | 1550 ++++++++++++++++++++
 arch/mips/include/asm/mach-powertv/asic.h          |  109 ++
 arch/mips/include/asm/mach-powertv/asic_regs.h     |  157 ++
 arch/mips/include/asm/mach-powertv/dma-coherence.h |  121 ++
 arch/mips/include/asm/mach-powertv/interrupts.h    |  256 ++++
 arch/mips/include/asm/mach-powertv/ioremap.h       |   92 ++
 arch/mips/include/asm/mach-powertv/irq.h           |   27 +
 arch/mips/include/asm/mach-powertv/war.h           |   28 +
 arch/mips/include/asm/setup.h                      |    2 +-
 arch/mips/powertv/Kconfig                          |   21 +
 arch/mips/powertv/Makefile                         |   40 +
 arch/mips/powertv/asic/Kconfig                     |   28 +
 arch/mips/powertv/asic/Makefile                    |   35 +
 arch/mips/powertv/asic/asic-calliope.c             |  100 ++
 arch/mips/powertv/asic/asic-cronus.c               |  100 ++
 arch/mips/powertv/asic/asic-zeus.c                 |  100 ++
 arch/mips/powertv/asic/asic_devices.c              |  789 ++++++++++
 arch/mips/powertv/asic/asic_int.c                  |  125 ++
 arch/mips/powertv/asic/irq_asic.c                  |  116 ++
 arch/mips/powertv/asic/prealloc-calliope.c         |  622 ++++++++
 arch/mips/powertv/asic/prealloc-cronus.c           |  610 ++++++++
 arch/mips/powertv/asic/prealloc-cronuslite.c       |  292 ++++
 arch/mips/powertv/asic/prealloc-zeus.c             |  461 ++++++
 arch/mips/powertv/cevt-powertv.c                   |  175 +++
 arch/mips/powertv/cmdline.c                        |   52 +
 arch/mips/powertv/csrc-powertv.c                   |  180 +++
 arch/mips/powertv/init.c                           |  128 ++
 arch/mips/powertv/init.h                           |   30 +
 arch/mips/powertv/memory.c                         |  184 +++
 arch/mips/powertv/pci/Makefile                     |   28 +
 arch/mips/powertv/pci/fixup-powertv.c              |   36 +
 arch/mips/powertv/pci/powertv-pci.h                |   31 +
 arch/mips/powertv/powertv-clock.h                  |   30 +
 arch/mips/powertv/powertv_setup.c                  |  351 +++++
 arch/mips/powertv/reset.c                          |   70 +
 arch/mips/powertv/reset.h                          |   28 +
 arch/mips/powertv/time.c                           |   30 +
 39 files changed, 7167 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ca0fe1..aa96089 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -333,6 +333,24 @@ config PMC_YOSEMITE
 	  Yosemite is an evaluation board for the RM9000x2 processor
 	  manufactured by PMC-Sierra.
 
+config POWERTV
+	bool "Support for Cisco PowerTV Platform"
+	select BOOT_ELF32
+	select CEVT_R4K
+	select CSRC_POWERTV
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select CPU_MIPSR2_IRQ_VI
+	select CPU_MIPSR2_IRQ_EI
+	select USB_OHCI_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	help
+	  This enables support for the Cisco PowerTV Platform.
+
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
 	select ARC
@@ -663,6 +681,7 @@ source "arch/mips/basler/excite/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
+source "arch/mips/powertv/Kconfig"
 source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
@@ -806,6 +825,13 @@ config EARLY_PRINTK
 config SYS_HAS_EARLY_PRINTK
 	bool
 
+config COMMAND_LINE_SIZE
+	int "Maximum size of command line passed to kernel from bootloader"
+	default 256
+	help
+	  Most systems work well with the default value, but some bootloaders pass more
+	  information on the command line than others. A smaller value is good here.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP && HOTPLUG && SYS_SUPPORTS_HOTPLUG_CPU
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 861da51..6b4971f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -436,6 +436,14 @@ core-$(CONFIG_NEC_MARKEINS)	+= arch/mips/emma/markeins/
 load-$(CONFIG_NEC_MARKEINS)	+= 0xffffffff88100000
 
 #
+# Cisco PowerTV Platform
+#
+core-$(CONFIG_POWERTV)		+= arch/mips/powertv/
+#cflags-$(CONFIG_POWERTV)	+= -I$(srctree)/arch/mips/include/asm/mach-mips
+cflags-$(CONFIG_POWERTV)        += -I$(srctree)/arch/mips/include/asm/mach-powertv
+load-$(CONFIG_POWERTV)		+= 0xffffffff90800000
+
+#
 # SGI IP22 (Indy/Indigo2)
 #
 # Set the load address to >= 0xffffffff88069000 if you want to leave space for
diff --git a/arch/mips/configs/powertv_defconfig b/arch/mips/configs/powertv_defconfig
new file mode 100644
index 0000000..a662c08
--- /dev/null
+++ b/arch/mips/configs/powertv_defconfig
@@ -0,0 +1,1550 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.31-rc5
+# Fri Aug 28 14:49:33 2009
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+# CONFIG_MACH_ALCHEMY is not set
+# CONFIG_AR7 is not set
+# CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_LEMOTE_FULONG is not set
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
+CONFIG_POWERTV=y
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
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIN_RUNTIME_RESOURCES is not set
+# CONFIG_BOOTLOADER_DRIVER is not set
+CONFIG_BOOTLOADER_FAMILY="R2"
+CONFIG_CSRC_POWERTV=y
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
+CONFIG_CEVT_R4K=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_EARLY_PRINTK is not set
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+CONFIG_COMMAND_LINE_SIZE=4096
+# CONFIG_NO_IOPORT is not set
+CONFIG_CPU_BIG_ENDIAN=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
+CONFIG_BOOT_ELF32=y
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
+# CONFIG_CPU_R5500 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_HAS_CPU_MIPS32_R2=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR2=y
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
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_MIPSR2_IRQ_VI=y
+CONFIG_CPU_MIPSR2_IRQ_EI=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+# CONFIG_HIGHMEM is not set
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_SYS_SUPPORTS_HIGHMEM=y
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
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
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
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
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
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+CONFIG_RELAY=y
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+CONFIG_TIMERFD=y
+# CONFIG_EVENTFD is not set
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Performance Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_PCI_QUIRKS=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_STRIP_ASM_SYMS is not set
+CONFIG_COMPAT_BRK=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+# CONFIG_SLOW_WORK is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
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
+# CONFIG_PROBE_INITRD_HEADER is not set
+# CONFIG_FREEZER is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCI_LEGACY is not set
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+CONFIG_MMU=y
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
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
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_XFRM_IPCOMP=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_MULTIPLE_TABLES is not set
+# CONFIG_IP_ROUTE_MULTIPATH is not set
+# CONFIG_IP_ROUTE_VERBOSE is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+CONFIG_IPV6=y
+CONFIG_IPV6_PRIVACY=y
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+CONFIG_INET6_AH=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_IPCOMP=y
+# CONFIG_IPV6_MIP6 is not set
+CONFIG_INET6_XFRM_TUNNEL=y
+CONFIG_INET6_TUNNEL=y
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+# CONFIG_IPV6_SIT is not set
+CONFIG_IPV6_TUNNEL=y
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+CONFIG_NETFILTER_ADVANCED=y
+# CONFIG_BRIDGE_NETFILTER is not set
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK_QUEUE is not set
+# CONFIG_NETFILTER_NETLINK_LOG is not set
+# CONFIG_NF_CONNTRACK is not set
+CONFIG_NETFILTER_XTABLES=y
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
+# CONFIG_NETFILTER_XT_TARGET_MARK is not set
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
+# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
+# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_HL is not set
+# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_MAC is not set
+# CONFIG_NETFILTER_XT_MATCH_MARK is not set
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
+# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
+# CONFIG_NETFILTER_XT_MATCH_REALM is not set
+# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
+# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+# CONFIG_NETFILTER_XT_MATCH_STRING is not set
+# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_TIME is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
+# CONFIG_IP_VS is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_NF_DEFRAG_IPV4 is not set
+# CONFIG_IP_NF_QUEUE is not set
+CONFIG_IP_NF_IPTABLES=y
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+# CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+CONFIG_IP_NF_FILTER=y
+# CONFIG_IP_NF_TARGET_REJECT is not set
+# CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
+# CONFIG_IP_NF_MANGLE is not set
+# CONFIG_IP_NF_TARGET_TTL is not set
+# CONFIG_IP_NF_RAW is not set
+CONFIG_IP_NF_ARPTABLES=y
+CONFIG_IP_NF_ARPFILTER=y
+# CONFIG_IP_NF_ARP_MANGLE is not set
+
+#
+# IPv6: Netfilter Configuration
+#
+# CONFIG_IP6_NF_QUEUE is not set
+CONFIG_IP6_NF_IPTABLES=y
+# CONFIG_IP6_NF_MATCH_AH is not set
+# CONFIG_IP6_NF_MATCH_EUI64 is not set
+# CONFIG_IP6_NF_MATCH_FRAG is not set
+# CONFIG_IP6_NF_MATCH_OPTS is not set
+# CONFIG_IP6_NF_MATCH_HL is not set
+# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
+# CONFIG_IP6_NF_MATCH_MH is not set
+# CONFIG_IP6_NF_MATCH_RT is not set
+# CONFIG_IP6_NF_TARGET_HL is not set
+# CONFIG_IP6_NF_TARGET_LOG is not set
+CONFIG_IP6_NF_FILTER=y
+# CONFIG_IP6_NF_TARGET_REJECT is not set
+# CONFIG_IP6_NF_MANGLE is not set
+# CONFIG_IP6_NF_RAW is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+CONFIG_STP=y
+CONFIG_BRIDGE=y
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+CONFIG_LLC=y
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+CONFIG_NET_SCHED=y
+
+#
+# Queueing/Scheduling
+#
+# CONFIG_NET_SCH_CBQ is not set
+# CONFIG_NET_SCH_HTB is not set
+# CONFIG_NET_SCH_HFSC is not set
+# CONFIG_NET_SCH_PRIO is not set
+# CONFIG_NET_SCH_MULTIQ is not set
+# CONFIG_NET_SCH_RED is not set
+# CONFIG_NET_SCH_SFQ is not set
+# CONFIG_NET_SCH_TEQL is not set
+CONFIG_NET_SCH_TBF=y
+# CONFIG_NET_SCH_GRED is not set
+# CONFIG_NET_SCH_DSMARK is not set
+# CONFIG_NET_SCH_NETEM is not set
+# CONFIG_NET_SCH_DRR is not set
+
+#
+# Classification
+#
+# CONFIG_NET_CLS_BASIC is not set
+# CONFIG_NET_CLS_TCINDEX is not set
+# CONFIG_NET_CLS_ROUTE4 is not set
+# CONFIG_NET_CLS_FW is not set
+# CONFIG_NET_CLS_U32 is not set
+# CONFIG_NET_CLS_RSVP is not set
+# CONFIG_NET_CLS_RSVP6 is not set
+# CONFIG_NET_CLS_FLOW is not set
+# CONFIG_NET_EMATCH is not set
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_SCH_FIFO=y
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
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
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
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
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
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
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
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
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
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=32768
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
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
+# CONFIG_SCSI_PROC_FS is not set
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
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# See the help texts for more information.
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_ATL2 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_JME is not set
+CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+CONFIG_CHELSIO_T3_DEPENDS=y
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_ENIC is not set
+# CONFIG_IXGBE is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_VXGE is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_EN is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
+# CONFIG_QLGE is not set
+# CONFIG_SFC is not set
+# CONFIG_BE2NET is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
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
+CONFIG_USB_RTL8150=y
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
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
+# CONFIG_VT is not set
+# CONFIG_DEVKMEM is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_I2C is not set
+# CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
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
+# CONFIG_MFD_TMIO is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
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
+# CONFIG_USB_DEBUG is not set
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
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
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
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
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB port drivers
+#
+CONFIG_USB_SERIAL=y
+CONFIG_USB_SERIAL_CONSOLE=y
+# CONFIG_USB_EZUSB is not set
+# CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
+# CONFIG_USB_SERIAL_BELKIN is not set
+# CONFIG_USB_SERIAL_CH341 is not set
+# CONFIG_USB_SERIAL_WHITEHEAT is not set
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+CONFIG_USB_SERIAL_CP210X=y
+# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+# CONFIG_USB_SERIAL_FTDI_SIO is not set
+# CONFIG_USB_SERIAL_FUNSOFT is not set
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_GARMIN is not set
+# CONFIG_USB_SERIAL_IPW is not set
+# CONFIG_USB_SERIAL_IUU is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+# CONFIG_USB_SERIAL_KEYSPAN is not set
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+# CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_MOTOROLA is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_SERIAL_OTI6858 is not set
+# CONFIG_USB_SERIAL_QUALCOMM is not set
+# CONFIG_USB_SERIAL_SPCP8X5 is not set
+# CONFIG_USB_SERIAL_HP4X is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
+# CONFIG_USB_SERIAL_SYMBOL is not set
+# CONFIG_USB_SERIAL_TI is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OPTION is not set
+# CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_OPTICON is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
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
+# CONFIG_NOP_USB_XCEIV is not set
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
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+CONFIG_FUSE_FS=y
+# CONFIG_CUSE is not set
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
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+CONFIG_CRAMFS=y
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
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
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
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
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_PRINTK_TIME=y
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_PREEMPT is not set
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
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_TRACING_SUPPORT=y
+CONFIG_FTRACE=y
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_PREEMPT_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
+# CONFIG_BOOT_TRACER is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_KMEMCHECK is not set
+CONFIG_CMDLINE="rw dhash_entries=1024 ihash_entries=1024 ip=10.0.1.3:10.0.1.1:10.0.1.1:255.255.255.0:zeus:eth0: root=/dev/nfs nfsroot=/nfsroot/cramfs,wsize=512,rsize=512,tcp nokgdb console=ttyUSB0,115200 memsize=252M"
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD=y
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
+CONFIG_CRYPTO_AUTHENC=y
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
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
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
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
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
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
new file mode 100644
index 0000000..fd02c4d
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -0,0 +1,109 @@
+/*
+ *				asic.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _ASM_MACH_POWERTV_ASIC_H
+#define _ASM_MACH_POWERTV_ASIC_H
+
+#include <linux/ioport.h>
+#include <asm/mach-powertv/asic_regs.h>
+
+#define DVR_CAPABLE     (1<<0)
+#define PCIE_CAPABLE    (1<<1)
+#define FFS_CAPABLE     (1<<2)
+#define DISPLAY_CAPABLE (1<<3)
+
+/* Platform Family types
+ * For compitability, the new value must be added in the end */
+enum family_type {
+	FAMILY_8500,
+	FAMILY_8500RNG,
+	FAMILY_4500,
+	FAMILY_1500,
+	FAMILY_8600,
+	FAMILY_4600,
+	FAMILY_4600VZA,
+	FAMILY_8600VZB,
+	FAMILY_1500VZE,
+	FAMILY_1500VZF,
+	FAMILIES
+};
+
+/* Register maps for each ASIC */
+extern const struct register_map calliope_register_map;
+extern const struct register_map cronus_register_map;
+extern const struct register_map zeus_register_map;
+
+extern struct resource dvr_cronus_resources[];
+extern struct resource dvr_zeus_resources[];
+extern struct resource non_dvr_calliope_resources[];
+extern struct resource non_dvr_cronus_resources[];
+extern struct resource non_dvr_cronuslite_resources[];
+extern struct resource non_dvr_vz_calliope_resources[];
+extern struct resource non_dvr_vze_calliope_resources[];
+extern struct resource non_dvr_vzf_calliope_resources[];
+extern struct resource non_dvr_zeus_resources[];
+
+extern void powertv_platform_init(void);
+extern void platform_alloc_bootmem(void);
+extern enum asic_type platform_get_asic(void);
+extern enum family_type platform_get_family(void);
+extern int platform_supports_dvr(void);
+extern int platform_supports_ffs(void);
+extern int platform_supports_pcie(void);
+extern int platform_supports_display(void);
+extern void configure_platform(void);
+extern void platform_configure_usb_ehci(void);
+extern void platform_unconfigure_usb_ehci(void);
+extern void platform_configure_usb_ohci(void);
+extern void platform_unconfigure_usb_ohci(void);
+
+/* Platform Resources */
+#define ASIC_RESOURCE_GET_EXISTS 1
+extern struct resource *asic_resource_get(const char *name);
+extern void platform_release_memory(void *baddr, int size);
+
+/* Reboot Cause */
+extern void set_reboot_cause(char code, unsigned int data, unsigned int data2);
+extern void set_locked_reboot_cause(char code, unsigned int data,
+	unsigned int data2);
+
+enum sys_reboot_type {
+	sys_unknown_reboot = 0x00,	/* Unknown reboot cause */
+	sys_davic_change = 0x01,	/* Reboot due to change in DAVIC
+					 * mode */
+	sys_user_reboot = 0x02,		/* Reboot initiated by user */
+	sys_system_reboot = 0x03,	/* Reboot initiated by OS */
+	sys_trap_reboot = 0x04,		/* Reboot due to a CPU trap */
+	sys_silent_reboot = 0x05,	/* Silent reboot */
+	sys_boot_ldr_reboot = 0x06,	/* Bootloader reboot */
+	sys_power_up_reboot = 0x07,	/* Power on bootup.  Older
+					 * drivers may report as
+					 * userReboot. */
+	sys_code_change = 0x08,		/* Reboot to take code change.
+					 * Older drivers may report as
+					 * userReboot. */
+	sys_hardware_reset = 0x09,	/* HW watchdog or front-panel
+					 * reset button reset.  Older
+					 * drivers may report as
+					 * userReboot. */
+	sys_watchdogInterrupt = 0x0A	/* Pre-watchdog interrupt */
+};
+
+#endif /* _ASM_MACH_POWERTV_ASIC_H */
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
new file mode 100644
index 0000000..ee1ad6c
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -0,0 +1,157 @@
+/*
+ *				asic_regs.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __ASM_MACH_POWERTV_ASIC_H_
+#define __ASM_MACH_POWERTV_ASIC_H_
+#include <linux/io.h>
+
+/* ASIC types */
+enum asic_type {
+	ASIC_UNKNOWN,
+	ASIC_ZEUS,
+	ASIC_CALLIOPE,
+	ASIC_CRONUS,
+	ASIC_CRONUSLITE,
+	ASICS
+};
+
+/* hardcoded values read from Chip Version registers */
+#define CRONUS_10	0x0B4C1C20
+#define CRONUS_11	0x0B4C1C21
+#define CRONUSLITE_10	0x0B4C1C40
+
+#define NAND_FLASH_BASE	0x03000000
+#define ZEUS_IO_BASE	0x09000000
+#define CALLIOPE_IO_BASE	0x08000000
+#define CRONUS_IO_BASE	0x09000000
+#define ASIC_IO_SIZE	0x01000000
+
+/* Definitions for backward compatibility */
+#define UART1_INTSTAT	uart1_intstat
+#define UART1_INTEN	uart1_inten
+#define UART1_CONFIG1	uart1_config1
+#define UART1_CONFIG2	uart1_config2
+#define UART1_DIVISORHI	uart1_divisorhi
+#define UART1_DIVISORLO	uart1_divisorlo
+#define UART1_DATA	uart1_data
+#define UART1_STATUS	uart1_status
+
+/* ASIC register enumeration */
+struct register_map {
+	u32 eic_slow0_strt_add;
+	u32 eic_cfg_bits;
+	u32 eic_ready_status;
+
+	u32 chipver3;
+	u32 chipver2;
+	u32 chipver1;
+	u32 chipver0;
+
+	u32 uart1_intstat;
+	u32 uart1_inten;
+	u32 uart1_config1;
+	u32 uart1_config2;
+	u32 uart1_divisorhi;
+	u32 uart1_divisorlo;
+	u32 uart1_data;
+	u32 uart1_status;
+
+	u32 int_stat_3;
+	u32 int_stat_2;
+	u32 int_stat_1;
+	u32 int_stat_0;
+	u32 int_config;
+	u32 int_int_scan;
+	u32 ien_int_3;
+	u32 ien_int_2;
+	u32 ien_int_1;
+	u32 ien_int_0;
+	u32 int_level_3_3;
+	u32 int_level_3_2;
+	u32 int_level_3_1;
+	u32 int_level_3_0;
+	u32 int_level_2_3;
+	u32 int_level_2_2;
+	u32 int_level_2_1;
+	u32 int_level_2_0;
+	u32 int_level_1_3;
+	u32 int_level_1_2;
+	u32 int_level_1_1;
+	u32 int_level_1_0;
+	u32 int_level_0_3;
+	u32 int_level_0_2;
+	u32 int_level_0_1;
+	u32 int_level_0_0;
+	u32 int_docsis_en;
+
+	u32 mips_pll_setup;
+	u32 usb_fs;
+	u32 test_bus;
+	u32 crt_spare;
+	u32 usb2_ohci_int_mask;
+	u32 usb2_strap;
+	u32 ehci_hcapbase;
+	u32 ohci_hc_revision;
+	u32 bcm1_bs_lmi_steer;
+	u32 usb2_control;
+	u32 usb2_stbus_obc;
+	u32 usb2_stbus_mess_size;
+	u32 usb2_stbus_chunk_size;
+
+	u32 pcie_regs;
+	u32 tim_ch;
+	u32 tim_cl;
+	u32 gpio_dout;
+	u32 gpio_din;
+	u32 gpio_dir;
+	u32 watchdog;
+	u32 front_panel;
+
+	u32 register_maps;
+};
+
+extern enum asic_type asic;
+extern const struct register_map *register_map;
+extern unsigned long asic_phy_base;	/* Physical address of ASIC */
+extern unsigned long asic_base;		/* Virtual address of ASIC */
+
+/*
+ * Macros to interface to registers through their ioremapped address
+ * asic_reg_offset	Returns the offset of a given register from the start
+ *			of the ASIC address space
+ * asic_reg_phys_addr	Returns the physical address of the given register
+ * asic_reg_addr	Returns the iomapped virtual address of the given
+ *			register.
+ */
+#define asic_reg_offset(x)	(register_map->x)
+#define asic_reg_phys_addr(x)	(asic_phy_base + asic_reg_offset(x))
+#define asic_reg_addr(x) \
+	((unsigned int *) (asic_base + asic_reg_offset(x)))
+
+/*
+ * The asic_reg macro is gone. It should be replaced by either asic_read or
+ * asic_write, as appropriate.
+ */
+
+#define asic_read(x)		readl(asic_reg_addr(x))
+#define asic_write(v, x)	writel(v, asic_reg_addr(x))
+
+extern void asic_irq_init(void);
+#endif
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
new file mode 100644
index 0000000..e6a5d71
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -0,0 +1,121 @@
+/*
+ *				dma-coherence.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Version from mach-generic modified to support PowerTV port
+ * Portions Copyright (C) 2009  Cisco Systems, Inc.
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *
+ */
+
+#ifndef __ASM_MACH_POWERTV_DMA_COHERENCE_H
+#define __ASM_MACH_POWERTV_DMA_COHERENCE_H
+
+#include <linux/sched.h>
+#include <linux/version.h>
+#include <linux/device.h>
+#include <asm/mach-powertv/asic.h>
+
+static inline bool is_kseg2(void *addr)
+{
+	return (unsigned long)addr >= KSEG2;
+}
+
+static inline unsigned long virt_to_phys_from_pte(void *addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+
+	unsigned long virt_addr = (unsigned long)addr;
+	unsigned long phys_addr = 0UL;
+
+	/* get the page global directory. */
+	pgd = pgd_offset_k(virt_addr);
+
+	if (!pgd_none(*pgd)) {
+		/* get the page upper directory */
+		pud = pud_offset(pgd, virt_addr);
+		if (!pud_none(*pud)) {
+			/* get the page middle directory */
+			pmd = pmd_offset(pud, virt_addr);
+			if (!pmd_none(*pmd)) {
+				/* get a pointer to the page table entry */
+				ptep = pte_offset(pmd, virt_addr);
+				pte = *ptep;
+				/* check for a valid page */
+				if (pte_present(pte)) {
+					/* get the physical address the page is
+					 * refering to */
+					phys_addr = (unsigned long)
+						page_to_phys(pte_page(pte));
+					/* add the offset within the page */
+					phys_addr |= (virt_addr & ~PAGE_MASK);
+				}
+			}
+		}
+	}
+
+	return phys_addr;
+}
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+	size_t size)
+{
+	if (is_kseg2(addr))
+		return phys_to_bus(virt_to_phys_from_pte(addr));
+	else
+		return phys_to_bus(virt_to_phys(addr));
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+	struct page *page)
+{
+	return phys_to_bus(page_to_phys(page));
+}
+
+static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr)
+{
+	return bus_to_phys(dma_addr);
+}
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
+{
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 0;
+}
+
+#endif /* __ASM_MACH_POWERTV_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-powertv/interrupts.h b/arch/mips/include/asm/mach-powertv/interrupts.h
new file mode 100644
index 0000000..66cd34c
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/interrupts.h
@@ -0,0 +1,256 @@
+/*
+ *				interrupts.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef	_ASM_MACH_POWERTV_INTERRUPTS_H_
+#define _ASM_MACH_POWERTV_INTERRUPTS_H_
+
+/*
+ * Defines for all of the interrupt lines
+ */
+
+/* Definitions for backward compatibility */
+#define kIrq_Uart1		irq_uart1
+
+#define ibase 0
+
+/*------------- Register: int_stat_3 */
+/* 126 unused (bit 31) */
+#define irq_asc2video		(ibase+126)	/* ASC 2 Video Interrupt */
+#define irq_asc1video		(ibase+125)	/* ASC 1 Video Interrupt */
+#define irq_comms_block_wd	(ibase+124)	/* ASC 1 Video Interrupt */
+#define irq_fdma_mailbox	(ibase+123)	/* FDMA Mailbox Output */
+#define irq_fdma_gp		(ibase+122)	/* FDMA GP Output */
+#define irq_mips_pic		(ibase+121)	/* MIPS Performance Counter
+						 * Interrupt */
+#define irq_mips_timer		(ibase+120)	/* MIPS Timer Interrupt */
+#define irq_memory_protect	(ibase+119)	/* Memory Protection Interrupt
+						 * -- Ored by glue logic inside
+						 *  SPARC ILC (see
+						 *  INT_MEM_PROT_STAT, below,
+						 *  for individual interrupts)
+						 */
+/* 118 unused (bit 22) */
+#define irq_sbag		(ibase+117)	/* SBAG Interrupt -- Ored by
+						 * glue logic inside SPARC ILC
+						 * (see INT_SBAG_STAT, below,
+						 * for individual interrupts) */
+#define irq_qam_b_fec		(ibase+116)	/* QAM  B FEC Interrupt */
+#define irq_qam_a_fec		(ibase+115)	/* QAM A FEC Interrupt */
+/* 114 unused 	(bit 18) */
+#define irq_mailbox		(ibase+113)	/* Mailbox Debug Interrupt  --
+						 * Ored by glue logic inside
+						 * SPARC ILC (see
+						 * INT_MAILBOX_STAT, below, for
+						 * individual interrupts) */
+#define irq_fuse_stat1		(ibase+112)	/* Fuse Status 1 */
+#define irq_fuse_stat2		(ibase+111)	/* Fuse Status 2 */
+#define irq_fuse_stat3		(ibase+110)	/* Blitter Interrupt / Fuse
+						 * Status 3 */
+#define irq_blitter		(ibase+110)	/* Blitter Interrupt / Fuse
+						 * Status 3 */
+#define irq_avc1_pp0		(ibase+109)	/* AVC Decoder #1 PP0
+						 * Interrupt */
+#define irq_avc1_pp1		(ibase+108)	/* AVC Decoder #1 PP1
+						 * Interrupt */
+#define irq_avc1_mbe		(ibase+107)	/* AVC Decoder #1 MBE
+						 * Interrupt */
+#define irq_avc2_pp0		(ibase+106)	/* AVC Decoder #2 PP0
+						 * Interrupt */
+#define irq_avc2_pp1		(ibase+105)	/* AVC Decoder #2 PP1
+						 * Interrupt */
+#define irq_avc2_mbe		(ibase+104)	/* AVC Decoder #2 MBE
+						 * Interrupt */
+#define irq_zbug_spi		(ibase+103)	/* Zbug SPI Slave Interrupt */
+#define irq_qam_mod2		(ibase+102)	/* QAM Modulator 2 DMA
+						 * Interrupt */
+#define irq_ir_rx		(ibase+101)	/* IR RX 2 Interrupt */
+#define irq_aud_dsp2		(ibase+100)	/* Audio DSP #2 Interrupt */
+#define irq_aud_dsp1		(ibase+99)	/* Audio DSP #1 Interrupt */
+#define irq_docsis		(ibase+98)	/* DOCSIS Debug Interrupt */
+#define irq_sd_dvp1		(ibase+97)	/* SD DVP #1 Interrupt */
+#define irq_sd_dvp2		(ibase+96)	/* SD DVP #2 Interrupt */
+/*------------- Register: int_stat_2 */
+#define irq_hd_dvp		(ibase+95)	/* HD DVP Interrupt */
+#define kIrq_Prewatchdog	(ibase+94)	/* watchdog Pre-Interrupt */
+#define irq_timer2		(ibase+93)	/* Programmable Timer
+						 * Interrupt 2 */
+#define irq_1394		(ibase+92)	/* 1394 Firewire Interrupt */
+#define irq_usbohci		(ibase+91)	/* USB 2.0 OHCI Interrupt */
+#define irq_usbehci		(ibase+90)	/* USB 2.0 EHCI Interrupt */
+#define irq_pciexp		(ibase+89)	/* PCI Express 0 Interrupt */
+#define irq_pciexp0		(ibase+89)	/* PCI Express 0 Interrupt */
+#define irq_afe1		(ibase+88)	/* AFE 1 Interrupt */
+#define irq_sata		(ibase+87)	/* SATA 1 Interrupt */
+#define irq_sata1		(ibase+87)	/* SATA 1 Interrupt */
+#define irq_dtcp		(ibase+86)	/* DTCP Interrupt */
+#define irq_pciexp1		(ibase+85)	/* PCI Express 1 Interrupt */
+/* 84 unused 	(bit 20) */
+/* 83 unused 	(bit 19) */
+/* 82 unused 	(bit 18) */
+#define irq_sata2		(ibase+81)	/* SATA2 Interrupt */
+#define irq_uart2		(ibase+80)	/* UART2 Interrupt */
+#define irq_legacy_usb		(ibase+79)	/* Legacy USB Host ISR (1.1
+						 * Host module) */
+#define irq_pod			(ibase+78)	/* POD Interrupt */
+#define irq_slave_usb		(ibase+77)	/* Slave USB */
+#define irq_denc1		(ibase+76)	/* DENC #1 VTG Interrupt */
+#define irq_vbi_vtg		(ibase+75)	/* VBI VTG Interrupt */
+#define irq_afe2		(ibase+74)	/* AFE 2 Interrupt */
+#define irq_denc2		(ibase+73)	/* DENC #2 VTG Interrupt */
+#define irq_asc2		(ibase+72)	/* ASC #2 Interrupt */
+#define irq_asc1		(ibase+71)	/* ASC #1 Interrupt */
+#define irq_mod_dma		(ibase+70)	/* Modulator DMA Interrupt */
+#define irq_byte_eng1		(ibase+69)	/* Byte Engine Interrupt [1] */
+#define irq_byte_eng0		(ibase+68)	/* Byte Engine Interrupt [0] */
+/* 67 unused 	(bit 03) */
+/* 66 unused 	(bit 02) */
+/* 65 unused 	(bit 01) */
+/* 64 unused 	(bit 00) */
+/*------------- Register: int_stat_1 */
+/* 63 unused 	(bit 31) */
+/* 62 unused 	(bit 30) */
+/* 61 unused 	(bit 29) */
+/* 60 unused 	(bit 28) */
+/* 59 unused 	(bit 27) */
+/* 58 unused 	(bit 26) */
+/* 57 unused 	(bit 25) */
+/* 56 unused 	(bit 24) */
+#define irq_buf_dma_mem2mem	(ibase+55)	/* BufDMA Memory to Memory
+						 * Interrupt */
+#define irq_buf_dma_usbtransmit	(ibase+54)	/* BufDMA USB Transmit
+						 * Interrupt */
+#define irq_buf_dma_qpskpodtransmit (ibase+53)	/* BufDMA QPSK/POD Tramsit
+						 * Interrupt */
+#define irq_buf_dma_transmit_error (ibase+52)	/* BufDMA Transmit Error
+						 * Interrupt */
+#define irq_buf_dma_usbrecv	(ibase+51)	/* BufDMA USB Receive
+						 * Interrupt */
+#define irq_buf_dma_qpskpodrecv	(ibase+50)	/* BufDMA QPSK/POD Receive
+						 * Interrupt */
+#define irq_buf_dma_recv_error	(ibase+49)	/* BufDMA Receive Error
+						 * Interrupt */
+#define irq_qamdma_transmit_play (ibase+48)	/* QAMDMA Transmit/Play
+						 * Interrupt */
+#define irq_qamdma_transmit_error (ibase+47)	/* QAMDMA Transmit Error
+						 * Interrupt */
+#define irq_qamdma_recv2high	(ibase+46)	/* QAMDMA Receive 2 High
+						 * (Chans 63-32) */
+#define irq_qamdma_recv2low	(ibase+45)	/* QAMDMA Receive 2 Low
+						 * (Chans 31-0) */
+#define irq_qamdma_recv1high	(ibase+44)	/* QAMDMA Receive 1 High
+						 * (Chans 63-32) */
+#define irq_qamdma_recv1low	(ibase+43)	/* QAMDMA Receive 1 Low
+						 * (Chans 31-0) */
+#define irq_qamdma_recv_error	(ibase+42)	/* QAMDMA Receive Error
+						 * Interrupt */
+#define irq_mpegsplice		(ibase+41)	/* MPEG Splice Interrupt */
+#define irq_deinterlace_rdy	(ibase+40)	/* Deinterlacer Frame Ready
+						 * Interrupt */
+#define irq_ext_in0		(ibase+39)	/* External Interrupt irq_in0 */
+#define irq_gpio3		(ibase+38)	/* GP I/O IRQ 3 - From GP I/O
+						 * Module */
+#define irq_gpio2		(ibase+37)	/* GP I/O IRQ 2 - From GP I/O
+						 * Module (ABE_intN) */
+#define irq_pcrcmplt1		(ibase+36)	/* PCR Capture Complete  or
+						 * Discontinuity 1 */
+#define irq_pcrcmplt2		(ibase+35)	/* PCR Capture Complete or
+						 * Discontinuity 2 */
+#define irq_parse_peierr	(ibase+34)	/* PID Parser Error Detect
+						 * (PEI) */
+#define irq_parse_cont_err	(ibase+33)	/* PID Parser continuity error
+						 * detect */
+#define irq_ds1framer		(ibase+32)	/* DS1 Framer Interrupt */
+/*------------- Register: int_stat_0 */
+#define irq_gpio1		(ibase+31)	/* GP I/O IRQ 1 - From GP I/O
+						 * Module */
+#define irq_gpio0		(ibase+30)	/* GP I/O IRQ 0 - From GP I/O
+						 * Module */
+#define irq_qpsk_out_aloha	(ibase+29)	/* QPSK Output Slotted Aloha
+						 * (chan 3) Transmission
+						 * Completed OK */
+#define irq_qpsk_out_tdma	(ibase+28)	/* QPSK Output TDMA (chan 2)
+						 * Transmission Completed OK */
+#define irq_qpsk_out_reserve	(ibase+27)	/* QPSK Output Reservation
+						 * (chan 1) Transmission
+						 * Completed OK */
+#define irq_qpsk_out_aloha_err	(ibase+26)	/* QPSK Output Slotted Aloha
+						 * (chan 3)Transmission
+						 * completed with Errors. */
+#define irq_qpsk_out_tdma_err	(ibase+25)	/* QPSK Output TDMA (chan 2)
+						 * Transmission completed with
+						 * Errors. */
+#define irq_qpsk_out_rsrv_err	(ibase+24)	/* QPSK Output Reservation
+						 * (chan 1) Transmission
+						 * completed with Errors */
+#define irq_aloha_fail		(ibase+23)	/* Unsuccessful Resend of Aloha
+						 * for N times. Aloha retry
+						 * timeout for channel 3. */
+#define irq_timer1		(ibase+22)	/* Programmable Timer
+						 * Interrupt */
+#define irq_keyboard		(ibase+21)	/* Keyboard Module Interrupt */
+#define irq_i2c			(ibase+20)	/* I2C Module Interrupt */
+#define irq_spi			(ibase+19)	/* SPI Module Interrupt */
+#define irq_irblaster		(ibase+18)	/* IR Blaster Interrupt */
+#define irq_splice_detect	(ibase+17)	/* PID Key Change Interrupt or
+						 * Splice Detect Interrupt */
+#define irq_se_micro		(ibase+16)	/* Secure Micro I/F Module
+						 * Interrupt */
+#define irq_uart1		(ibase+15)	/* UART Interrupt */
+#define irq_irrecv		(ibase+14)	/* IR Receiver Interrupt */
+#define irq_host_int1		(ibase+13)	/* Host-to-Host Interrupt 1 */
+#define irq_host_int0		(ibase+12)	/* Host-to-Host Interrupt 0 */
+#define irq_qpsk_hecerr		(ibase+11)	/* QPSK HEC Error Interrupt */
+#define irq_qpsk_crcerr		(ibase+10)	/* QPSK AAL-5 CRC Error
+						 * Interrupt */
+/* 9 unused 	(bit 09) */
+/* 8 unused 	(bit 08) */
+#define irq_psicrcerr		(ibase+7) 	/* QAM PSI CRC Error
+						 * Interrupt */
+#define irq_psilength_err	(ibase+6) 	/* QAM PSI Length Error
+						 * Interrupt */
+#define irq_esfforward		(ibase+5) 	/* ESF Interrupt Mark From
+						 * Forward Path Reference -
+						 * every 3ms when forward Mbits
+						 * and forward slot control
+						 * bytes are updated. */
+#define irq_esfreverse		(ibase+4) 	/* ESF Interrupt Mark from
+						 * Reverse Path Reference -
+						 * delayed from forward mark by
+						 * the ranging delay plus a
+						 * fixed amount. When reverse
+						 * Mbits and reverse slot
+						 * control bytes are updated.
+						 * Occurs every 3ms for 3.0M and
+						 * 1.554 M upstream rates and
+						 * every 6 ms for 256K upstream
+						 * rate. */
+#define irq_aloha_timeout	(ibase+3) 	/* Slotted-Aloha timeout on
+						 * Channel 1. */
+#define irq_reservation		(ibase+2) 	/* Partial (or Incremental)
+						 * Reservation Message Completed
+						 * or Slotted aloha verify for
+						 * channel 1. */
+#define irq_aloha3		(ibase+1) 	/* Slotted-Aloha Message Verify
+						 * Interrupt or Reservation
+						 * increment completed for
+						 * channel 3. */
+#define irq_mpeg_d		(ibase+0) 	/* MPEG Decoder Interrupt */
+#endif	/* _ASM_MACH_POWERTV_INTERRUPTS_H_ */
+
diff --git a/arch/mips/include/asm/mach-powertv/ioremap.h b/arch/mips/include/asm/mach-powertv/ioremap.h
new file mode 100644
index 0000000..1d3be37
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/ioremap.h
@@ -0,0 +1,92 @@
+/*
+ *				ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ * Portions Copyright (C)  Cisco Systems, Inc.
+ */
+#ifndef __ASM_MACH_POWERTV_IOREMAP_H
+#define __ASM_MACH_POWERTV_IOREMAP_H
+
+#include <linux/types.h>
+
+#define LOW_MEM_BOUNDARY_PHYS	0x20000000
+#define LOW_MEM_BOUNDARY_MASK	(~(LOW_MEM_BOUNDARY_PHYS - 1))
+
+/*
+ * The bus addresses are different than the physical addresses that
+ * the processor sees by an offset. This offset varies by ASIC
+ * version. Define a variable to hold the offset and some macros to
+ * make the conversion simpler. */
+extern unsigned long phys_to_bus_offset;
+
+#ifdef CONFIG_HIGHMEM
+#define MEM_GAP_PHYS		0x60000000
+/*
+ * TODO: We will use the hard code for conversion between physical and
+ * bus until the bootloader releases their device tree to us.
+ */
+#define phys_to_bus(x) (((x) < LOW_MEM_BOUNDARY_PHYS) ? \
+	((x) + phys_to_bus_offset) : (x))
+#define bus_to_phys(x) (((x) < MEM_GAP_PHYS_ADDR) ? \
+	((x) - phys_to_bus_offset) : (x))
+#else
+#define phys_to_bus(x) ((x) + phys_to_bus_offset)
+#define bus_to_phys(x) ((x) - phys_to_bus_offset)
+#endif
+
+/*
+ * Determine whether the address we are given is for an ASIC device
+ * Params:  addr    Address to check
+ * Returns: Zero if the address is not for ASIC devices, non-zero
+ *      if it is.
+ */
+static inline int asic_is_device_addr(phys_t addr)
+{
+	return !((phys_t)addr & (phys_t) LOW_MEM_BOUNDARY_MASK);
+}
+
+/*
+ * Determine whether the address we are given is external RAM mappable
+ * into KSEG1.
+ * Params:  addr    Address to check
+ * Returns: Zero if the address is not for external RAM and
+ */
+static inline int asic_is_lowmem_ram_addr(phys_t addr)
+{
+	/*
+	 * The RAM always starts at the following address in the processor's
+	 * physical address space
+	 */
+	static const phys_t phys_ram_base = 0x10000000;
+	phys_t bus_ram_base;
+
+	bus_ram_base = phys_to_bus_offset + phys_ram_base;
+
+	return addr >= bus_ram_base &&
+		addr < (bus_ram_base + (LOW_MEM_BOUNDARY_PHYS - phys_ram_base));
+}
+
+/*
+ * Allow physical addresses to be fixed up to help peripherals located
+ * outside the low 32-bit range -- generic pass-through version.
+ */
+static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+	unsigned long flags)
+{
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return 0;
+}
+#endif /* __ASM_MACH_POWERTV_IOREMAP_H */
diff --git a/arch/mips/include/asm/mach-powertv/irq.h b/arch/mips/include/asm/mach-powertv/irq.h
new file mode 100644
index 0000000..6ff4f67
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/irq.h
@@ -0,0 +1,27 @@
+/*
+ *				irq.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _ASM_MACH_POWERTV_IRQ_H
+#define _ASM_MACH_POWERTV_IRQ_H
+#include <asm/mach-powertv/interrupts.h>
+
+#define MIPS_CPU_IRQ_BASE	ibase
+#define NR_IRQS			127
+#endif
diff --git a/arch/mips/include/asm/mach-powertv/war.h b/arch/mips/include/asm/mach-powertv/war.h
new file mode 100644
index 0000000..7ac05ec
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/war.h
@@ -0,0 +1,28 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This version for the PowerTV platform copied from the Malta version.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ */
+#ifndef __ASM_MACH_POWERTV_WAR_H
+#define __ASM_MACH_POWERTV_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	1
+#define MIPS_CACHE_SYNC_WAR		1
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	1
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MACH_POWERTV_WAR_H */
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index e600ced..132e397 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -1,7 +1,7 @@
 #ifndef _MIPS_SETUP_H
 #define _MIPS_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
 
 #ifdef  __KERNEL__
 extern void setup_early_printk(void);
diff --git a/arch/mips/powertv/Kconfig b/arch/mips/powertv/Kconfig
new file mode 100644
index 0000000..ff0e7e3
--- /dev/null
+++ b/arch/mips/powertv/Kconfig
@@ -0,0 +1,21 @@
+source "arch/mips/powertv/asic/Kconfig"
+
+config BOOTLOADER_DRIVER
+	bool "PowerTV Bootloader Driver Support"
+	default n
+	depends on POWERTV
+	help
+	  Use this option if you want to load bootloader driver.
+
+config BOOTLOADER_FAMILY
+	string "POWERTV Bootloader Family string"
+	default "85"
+	depends on POWERTV && !BOOTLOADER_DRIVER
+	help
+	  This value should be specified when the bootloader driver is disabled
+	  and must be exactly two characters long. Families supported are:
+	    R1 - RNG-100  R2 - RNG-200
+	    A1 - Class A  B1 - Class B
+	    E1 - Class E  F1 - Class F
+	    44 - 45xx     46 - 46xx
+	    85 - 85xx     86 - 86xx
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
new file mode 100644
index 0000000..145d065
--- /dev/null
+++ b/arch/mips/powertv/Makefile
@@ -0,0 +1,40 @@
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+# Portions copyright (C)  2009 Cisco Systems, Inc.
+#
+# This program is free software; you can distribute it and/or modify it
+# under the terms of the GNU General Public License (Version 2) as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+#
+# Makefile for the Cisco PowerTV-specific kernel interface routines
+# under Linux.
+#
+
+EXTRA_CFLAGS += -Wall -Werror
+
+obj-y	:=
+
+obj-$(CONFIG_POWERTV)	+=	cmdline.o \
+				init.o \
+				memory.o \
+				reset.o \
+				time.o \
+				powertv_setup.o \
+				asic/ \
+				pci/
+
+obj-$(CONFIG_CEVT_POWERTV)	+=	cevt-powertv.o
+obj-$(CONFIG_CSRC_POWERTV)	+=	csrc-powertv.o
diff --git a/arch/mips/powertv/asic/Kconfig b/arch/mips/powertv/asic/Kconfig
new file mode 100644
index 0000000..2016bfe
--- /dev/null
+++ b/arch/mips/powertv/asic/Kconfig
@@ -0,0 +1,28 @@
+config MIN_RUNTIME_RESOURCES
+	bool "Support for minimum runtime resources"
+	default n
+	depends on POWERTV
+	help
+	  Enables support for minimizing the number of (SA asic) runtime
+	  resources that are preallocated by the kernel.
+
+config MIN_RUNTIME_DOCSIS
+	bool "Support for minimum DOCSIS resource"
+	default y
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated DOCSIS resource.
+
+config MIN_RUNTIME_PMEM
+	bool "Support for minimum PMEM resource"
+	default y
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated Memory resource.
+
+config MIN_RUNTIME_TFTP
+	bool "Support for minimum TFTP resource"
+	default y
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated TFTP resource.
diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
new file mode 100644
index 0000000..873d079
--- /dev/null
+++ b/arch/mips/powertv/asic/Makefile
@@ -0,0 +1,35 @@
+# *****************************************************************************
+#                          Make file for PowerTV Asic related files
+#
+# Copyright (C) 2009  Scientific-Atlanta, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# *****************************************************************************
+
+EXTRA_CFLAGS += -Wall -Werror
+
+obj-y	:=
+
+obj-$(CONFIG_POWERTV)	+=	asic-calliope.o \
+				asic-cronus.o \
+				asic-zeus.o \
+				asic_devices.o \
+				asic_int.o \
+				irq_asic.o \
+				prealloc-calliope.o \
+				prealloc-cronus.o \
+				prealloc-cronuslite.o \
+				prealloc-zeus.o
diff --git a/arch/mips/powertv/asic/asic-calliope.c b/arch/mips/powertv/asic/asic-calliope.c
new file mode 100644
index 0000000..458ef76
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-calliope.c
@@ -0,0 +1,100 @@
+/*
+ *                   		asic-calliope.c
+ *
+ * Locations of devices in the Calliope ASIC.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ */
+
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map calliope_register_map = {
+	.eic_slow0_strt_add = 0x800000,
+	.eic_cfg_bits = 0x800038,
+	.eic_ready_status = 0x80004c,
+
+	.chipver3 = 0xA00800,
+	.chipver2 = 0xA00804,
+	.chipver1 = 0xA00808,
+	.chipver0 = 0xA0080c,
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = 0xA01800,
+	.uart1_inten = 0xA01804,
+	.uart1_config1 = 0xA01808,
+	.uart1_config2 = 0xA0180C,
+	.uart1_divisorhi = 0xA01810,
+	.uart1_divisorlo = 0xA01814,
+	.uart1_data = 0xA01818,
+	.uart1_status = 0xA0181C,
+
+	.int_stat_3 = 0xA02800,
+	.int_stat_2 = 0xA02804,
+	.int_stat_1 = 0xA02808,
+	.int_stat_0 = 0xA0280c,
+	.int_config = 0xA02810,
+	.int_int_scan = 0xA02818,
+	.ien_int_3 = 0xA02830,
+	.ien_int_2 = 0xA02834,
+	.ien_int_1 = 0xA02838,
+	.ien_int_0 = 0xA0283c,
+	.int_level_3_3 = 0xA02880,
+	.int_level_3_2 = 0xA02884,
+	.int_level_3_1 = 0xA02888,
+	.int_level_3_0 = 0xA0288c,
+	.int_level_2_3 = 0xA02890,
+	.int_level_2_2 = 0xA02894,
+	.int_level_2_1 = 0xA02898,
+	.int_level_2_0 = 0xA0289c,
+	.int_level_1_3 = 0xA028a0,
+	.int_level_1_2 = 0xA028a4,
+	.int_level_1_1 = 0xA028a8,
+	.int_level_1_0 = 0xA028ac,
+	.int_level_0_3 = 0xA028b0,
+	.int_level_0_2 = 0xA028b4,
+	.int_level_0_1 = 0xA028b8,
+	.int_level_0_0 = 0xA028bc,
+	.int_docsis_en = 0xA028F4,
+
+	.mips_pll_setup = 0x980000,
+	.usb_fs = 0x980030,     	/* -default 72800028- */
+	.test_bus = 0x9800CC,
+	.crt_spare = 0x9800d4,
+	.usb2_ohci_int_mask = 0x9A000c,
+	.usb2_strap = 0x9A0014,
+	.ehci_hcapbase = 0x9BFE00,
+	.ohci_hc_revision = 0x9BFC00,
+	.bcm1_bs_lmi_steer = 0x9E0004,
+	.usb2_control = 0x9E0054,
+	.usb2_stbus_obc = 0x9BFF00,
+	.usb2_stbus_mess_size = 0x9BFF04,
+	.usb2_stbus_chunk_size = 0x9BFF08,
+
+	.pcie_regs = 0x000000,      	/* -doesn't exist- */
+	.tim_ch = 0xA02C10,
+	.tim_cl = 0xA02C14,
+	.gpio_dout = 0xA02c20,
+	.gpio_din = 0xA02c24,
+	.gpio_dir = 0xA02c2C,
+	.watchdog = 0xA02c30,
+	.front_panel = 0x000000,    	/* -not used- */
+};
diff --git a/arch/mips/powertv/asic/asic-cronus.c b/arch/mips/powertv/asic/asic-cronus.c
new file mode 100644
index 0000000..94737eb
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-cronus.c
@@ -0,0 +1,100 @@
+/*
+ *                   		asic-cronus.c
+ *
+ * Locations of devices in the Cronus ASIC
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ */
+
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map cronus_register_map = {
+	.eic_slow0_strt_add = 0x000000,
+	.eic_cfg_bits = 0x000038,
+	.eic_ready_status = 0x00004C,
+
+	.chipver3 = 0x2A0800,
+	.chipver2 = 0x2A0804,
+	.chipver1 = 0x2A0808,
+	.chipver0 = 0x2A080C,
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = 0x2A1800,
+	.uart1_inten = 0x2A1804,
+	.uart1_config1 = 0x2A1808,
+	.uart1_config2 = 0x2A180C,
+	.uart1_divisorhi = 0x2A1810,
+	.uart1_divisorlo = 0x2A1814,
+	.uart1_data = 0x2A1818,
+	.uart1_status = 0x2A181C,
+
+	.int_stat_3 = 0x2A2800,
+	.int_stat_2 = 0x2A2804,
+	.int_stat_1 = 0x2A2808,
+	.int_stat_0 = 0x2A280C,
+	.int_config = 0x2A2810,
+	.int_int_scan = 0x2A2818,
+	.ien_int_3 = 0x2A2830,
+	.ien_int_2 = 0x2A2834,
+	.ien_int_1 = 0x2A2838,
+	.ien_int_0 = 0x2A283C,
+	.int_level_3_3 = 0x2A2880,
+	.int_level_3_2 = 0x2A2884,
+	.int_level_3_1 = 0x2A2888,
+	.int_level_3_0 = 0x2A288C,
+	.int_level_2_3 = 0x2A2890,
+	.int_level_2_2 = 0x2A2894,
+	.int_level_2_1 = 0x2A2898,
+	.int_level_2_0 = 0x2A289C,
+	.int_level_1_3 = 0x2A28A0,
+	.int_level_1_2 = 0x2A28A4,
+	.int_level_1_1 = 0x2A28A8,
+	.int_level_1_0 = 0x2A28AC,
+	.int_level_0_3 = 0x2A28B0,
+	.int_level_0_2 = 0x2A28B4,
+	.int_level_0_1 = 0x2A28B8,
+	.int_level_0_0 = 0x2A28BC,
+	.int_docsis_en = 0x2A28F4,
+
+	.mips_pll_setup = 0x1C0000,
+	.usb_fs = 0x1C0018,
+	.test_bus = 0x1C00CC,
+	.crt_spare = 0x1c00d4,
+	.usb2_ohci_int_mask = 0x20000C,
+	.usb2_strap = 0x200014,
+	.ehci_hcapbase = 0x21FE00,
+	.ohci_hc_revision = 0x1E0000,
+	.bcm1_bs_lmi_steer = 0x2E0008,
+	.usb2_control = 0x2E004C,
+	.usb2_stbus_obc = 0x21FF00,
+	.usb2_stbus_mess_size = 0x21FF04,
+	.usb2_stbus_chunk_size = 0x21FF08,
+
+	.pcie_regs = 0x220000,
+	.tim_ch = 0x2A2C10,
+	.tim_cl = 0x2A2C14,
+	.gpio_dout = 0x2A2C20,
+	.gpio_din = 0x2A2C24,
+	.gpio_dir = 0x2A2C2C,
+	.watchdog = 0x2A2C30,
+	.front_panel = 0x2A3800,
+};
diff --git a/arch/mips/powertv/asic/asic-zeus.c b/arch/mips/powertv/asic/asic-zeus.c
new file mode 100644
index 0000000..36200f7
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-zeus.c
@@ -0,0 +1,100 @@
+/*
+ *                   		asic-zeus.c
+ *
+ * Locations of devices in the Zeus ASIC
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ */
+
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map zeus_register_map = {
+	.eic_slow0_strt_add = 0x000000,
+	.eic_cfg_bits = 0x000038,
+	.eic_ready_status = 0x00004c,
+
+	.chipver3 = 0x280800,
+	.chipver2 = 0x280804,
+	.chipver1 = 0x280808,
+	.chipver0 = 0x28080c,
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = 0x281800,
+	.uart1_inten = 0x281804,
+	.uart1_config1 = 0x281808,
+	.uart1_config2 = 0x28180C,
+	.uart1_divisorhi = 0x281810,
+	.uart1_divisorlo = 0x281814,
+	.uart1_data = 0x281818,
+	.uart1_status = 0x28181C,
+
+	.int_stat_3 = 0x282800,
+	.int_stat_2 = 0x282804,
+	.int_stat_1 = 0x282808,
+	.int_stat_0 = 0x28280c,
+	.int_config = 0x282810,
+	.int_int_scan = 0x282818,
+	.ien_int_3 = 0x282830,
+	.ien_int_2 = 0x282834,
+	.ien_int_1 = 0x282838,
+	.ien_int_0 = 0x28283c,
+	.int_level_3_3 = 0x282880,
+	.int_level_3_2 = 0x282884,
+	.int_level_3_1 = 0x282888,
+	.int_level_3_0 = 0x28288c,
+	.int_level_2_3 = 0x282890,
+	.int_level_2_2 = 0x282894,
+	.int_level_2_1 = 0x282898,
+	.int_level_2_0 = 0x28289c,
+	.int_level_1_3 = 0x2828a0,
+	.int_level_1_2 = 0x2828a4,
+	.int_level_1_1 = 0x2828a8,
+	.int_level_1_0 = 0x2828ac,
+	.int_level_0_3 = 0x2828b0,
+	.int_level_0_2 = 0x2828b4,
+	.int_level_0_1 = 0x2828b8,
+	.int_level_0_0 = 0x2828bc,
+	.int_docsis_en = 0x2828F4,
+
+	.mips_pll_setup = 0x1a0000,
+	.usb_fs = 0x1a0018,
+	.test_bus = 0x1a0238,
+	.crt_spare = 0x1a0090,
+	.usb2_ohci_int_mask = 0x1e000c,
+	.usb2_strap = 0x1e0014,
+	.ehci_hcapbase = 0x1FFE00,
+	.ohci_hc_revision = 0x1FFC00,
+	.bcm1_bs_lmi_steer = 0x2C0008,
+	.usb2_control = 0x2c01a0,
+	.usb2_stbus_obc = 0x1FFF00,
+	.usb2_stbus_mess_size = 0x1FFF04,
+	.usb2_stbus_chunk_size = 0x1FFF08,
+
+	.pcie_regs = 0x200000,
+	.tim_ch = 0x282C10,
+	.tim_cl = 0x282C14,
+	.gpio_dout = 0x282c20,
+	.gpio_din = 0x282c24,
+	.gpio_dir = 0x282c2C,
+	.watchdog = 0x282c30,
+	.front_panel = 0x283800,
+};
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
new file mode 100644
index 0000000..edef822
--- /dev/null
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -0,0 +1,789 @@
+/*
+ *                   ASIC Device List Intialization
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *****************************************************************************
+ *
+ * File Name:    asic_devices.c
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ *
+ * NOTE: The bootloader allocates persistent memory at an address which is
+ * 16 MiB below the end of the highest address in KSEG0. All fixed
+ * address memory reservations must avoid this region.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/serial_reg.h>
+#include <linux/io.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <asm/page.h>
+#include <linux/swap.h>
+#include <linux/highmem.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/asic_regs.h>
+#include <asm/mach-powertv/interrupts.h>
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+#include <asm/mach-powertv/kbldr.h>
+#endif
+#include <asm/bootinfo.h>
+
+#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
+
+/*
+ * Forward Prototypes
+ */
+static void pmem_setup_resource(void);
+
+/*
+ * Global Variables
+ */
+enum asic_type asic;
+
+unsigned int platform_features;
+unsigned int platform_family;
+const struct register_map  *register_map;
+EXPORT_SYMBOL(register_map);			/* Exported for testing */
+unsigned long asic_phy_base;
+unsigned long asic_base;
+EXPORT_SYMBOL(asic_base);			/* Exported for testing */
+struct resource *gp_resources;
+static bool usb_configured;
+
+/*
+ * Don't recommend to use it directly, it is usually used by kernel internally.
+ * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
+ */
+unsigned long phys_to_bus_offset;
+EXPORT_SYMBOL(phys_to_bus_offset);
+
+/*
+ *
+ * IO Resource Definition
+ *
+ */
+
+struct resource asic_resource = {
+	.name  = "ASIC Resource",
+	.start = 0,
+	.end   = ASIC_IO_SIZE,
+	.flags = IORESOURCE_MEM,
+};
+
+/*
+ *
+ * USB Host Resource Definition
+ *
+ */
+
+static struct resource ehci_resources[] = {
+	{
+		.parent = &asic_resource,
+		.start  = 0,
+		.end    = 0xff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = irq_usbehci,
+		.end    = irq_usbehci,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device ehci_device = {
+	.name = "powertv-ehci",
+	.id = 0,
+	.num_resources = 2,
+	.resource = ehci_resources,
+	.dev = {
+		.dma_mask = &ehci_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
+static struct resource ohci_resources[] = {
+	{
+		.parent = &asic_resource,
+		.start  = 0,
+		.end    = 0xff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = irq_usbohci,
+		.end    = irq_usbohci,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ohci_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device ohci_device = {
+	.name = "powertv-ohci",
+	.id = 0,
+	.num_resources = 2,
+	.resource = ohci_resources,
+	.dev = {
+		.dma_mask = &ohci_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
+static struct platform_device *platform_devices[] = {
+	&ehci_device,
+	&ohci_device,
+};
+
+/*
+ *
+ * Platform Configuration and Device Initialization
+ *
+ */
+static void __init fs_update(int pe, int md, int sdiv, int disable_div_by_3)
+{
+	int en_prg, byp, pwr, nsb, val;
+	int sout;
+
+	sout = 1;
+	en_prg = 1;
+	byp = 0;
+	nsb = 1;
+	pwr = 1;
+
+	val = ((sdiv << 29) | (md << 24) | (pe<<8) | (sout<<3) | (byp<<2) |
+		(nsb<<1) | (disable_div_by_3<<5));
+
+	asic_write(val, usb_fs);
+	asic_write(val | (en_prg<<4), usb_fs);
+	asic_write(val | (en_prg<<4) | pwr, usb_fs);
+}
+
+/*
+ * Allow override of bootloader-specified model
+ */
+static char __initdata cmdline[CONFIG_COMMAND_LINE_SIZE];
+#define	FORCEFAMILY_PARAM	"forcefamily"
+
+static __init int check_forcefamily(unsigned char forced_family[2])
+{
+	const char *p;
+
+	forced_family[0] = '\0';
+	forced_family[1] = '\0';
+
+	/* Check the command line for a forcefamily directive */
+	strncpy(cmdline, arcs_cmdline, CONFIG_COMMAND_LINE_SIZE - 1);
+	p = strstr(cmdline, FORCEFAMILY_PARAM);
+	if (p && (p != cmdline) && (*(p - 1) != ' '))
+		p = strstr(p, " " FORCEFAMILY_PARAM "=");
+
+	if (p) {
+		p += strlen(FORCEFAMILY_PARAM "=");
+
+		if (*p == '\0' || *(p + 1) == '\0' ||
+			(*(p + 2) != '\0' && *(p + 2) != ' '))
+			pr_err(FORCEFAMILY_PARAM " must be exactly two "
+				"characters long, ignoring value\n");
+
+		else {
+			forced_family[0] = *p;
+			forced_family[1] = *(p + 1);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * platform_set_family - determine major platform family type.
+ *
+ * Returns family type; -1 if none
+ * Returns the family type; -1 if none
+ *
+ */
+static __init noinline void platform_set_family(void)
+{
+#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
+
+	unsigned char forced_family[2];
+	unsigned short bootldr_family;
+
+	check_forcefamily(forced_family);
+
+	if (forced_family[0] != '\0' && forced_family[1] != '\0')
+		bootldr_family = BOOTLDRFAMILY(forced_family[0],
+			forced_family[1]);
+	else {
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+		bootldr_family = (unsigned short) kbldr_GetSWFamily();
+#else
+#if defined(CONFIG_BOOTLOADER_FAMILY)
+		bootldr_family = (unsigned short) BOOTLDRFAMILY(
+			CONFIG_BOOTLOADER_FAMILY[0],
+			CONFIG_BOOTLOADER_FAMILY[1]);
+#else
+#error "Unknown Bootloader Family"
+#endif
+#endif
+	}
+
+	pr_info("Bootloader Family = 0x%04X\n", bootldr_family);
+
+	switch (bootldr_family) {
+	case BOOTLDRFAMILY('R', '1'):
+		platform_family = FAMILY_1500;
+		break;
+	case BOOTLDRFAMILY('4', '4'):
+		platform_family = FAMILY_4500;
+		break;
+	case BOOTLDRFAMILY('4', '6'):
+		platform_family = FAMILY_4600;
+		break;
+	case BOOTLDRFAMILY('A', '1'):
+		platform_family = FAMILY_4600VZA;
+		break;
+	case BOOTLDRFAMILY('8', '5'):
+		platform_family = FAMILY_8500;
+		break;
+	case BOOTLDRFAMILY('R', '2'):
+		platform_family = FAMILY_8500RNG;
+		break;
+	case BOOTLDRFAMILY('8', '6'):
+		platform_family = FAMILY_8600;
+		break;
+	case BOOTLDRFAMILY('B', '1'):
+		platform_family = FAMILY_8600VZB;
+		break;
+	case BOOTLDRFAMILY('E', '1'):
+		platform_family = FAMILY_1500VZE;
+		break;
+	case BOOTLDRFAMILY('F', '1'):
+		platform_family = FAMILY_1500VZF;
+		break;
+	default:
+		platform_family = -1;
+	}
+}
+
+unsigned int platform_get_family(void)
+{
+	return platform_family;
+}
+EXPORT_SYMBOL(platform_get_family);
+
+/*
+ * \brief usb_eye_configure() for optimizing the USB eye on Calliope.
+ *
+ * \param     unsigned int value saved to the register.
+ *
+ * \return    none
+ *
+ */
+static void __init usb_eye_configure(unsigned int value)
+{
+	asic_write(asic_read(crt_spare) | value, crt_spare);
+}
+
+/*
+ * platform_get_asic - determine the ASIC type.
+ *
+ * \param     none
+ *
+ * \return    ASIC type; ASIC_UNKNOWN if none
+ *
+ */
+enum asic_type platform_get_asic(void)
+{
+	return asic;
+}
+EXPORT_SYMBOL(platform_get_asic);
+
+/*
+ * platform_configure_usb - usb configuration based on platform type.
+ * @bcm1_usb2_ctl:	value for the BCM1_USB2_CTL register, which is
+ *			quirky
+ */
+static void __init platform_configure_usb(void)
+{
+	u32 bcm1_usb2_ctl;
+
+	if (usb_configured)
+		return;
+
+	switch (asic) {
+	case ASIC_ZEUS:
+		fs_update(0x0000, 0x11, 0x02, 0);
+		bcm1_usb2_ctl = 0x803;
+		break;
+
+	case ASIC_CRONUS:
+	case ASIC_CRONUSLITE:
+		fs_update(0x0000, 0x11, 0x02, 0);
+		bcm1_usb2_ctl = 0x803;
+		break;
+
+	case ASIC_CALLIOPE:
+		fs_update(0x0000, 0x11, 0x02, 1);
+
+		switch (platform_family) {
+		case FAMILY_1500VZE:
+			break;
+
+		case FAMILY_1500VZF:
+			usb_eye_configure(0x003c0000);
+			break;
+
+		default:
+			usb_eye_configure(0x00300000);
+			break;
+		}
+
+		bcm1_usb2_ctl = 0x803;
+		break;
+
+	default:
+		pr_err("Unknown ASIC type: %d\n", asic);
+		break;
+	}
+
+	/* turn on USB power */
+	asic_write(0, usb2_strap);
+	/* Enable all OHCI interrupts */
+	asic_write(bcm1_usb2_ctl, usb2_control);
+	/* USB2_STBUS_OBC store32/load32 */
+	asic_write(3, usb2_stbus_obc);
+	/* USB2_STBUS_MESS_SIZE 2 packets */
+	asic_write(1, usb2_stbus_mess_size);
+	/* USB2_STBUS_CHUNK_SIZE 2 packets */
+	asic_write(1, usb2_stbus_chunk_size);
+
+	usb_configured = true;
+}
+
+/*
+ * Set up the USB EHCI interface
+ */
+void platform_configure_usb_ehci()
+{
+	platform_configure_usb();
+}
+
+/*
+ * Set up the USB OHCI interface
+ */
+void platform_configure_usb_ohci()
+{
+	platform_configure_usb();
+}
+
+/*
+ * Shut the USB EHCI interface down--currently a NOP
+ */
+void platform_unconfigure_usb_ehci()
+{
+}
+
+/*
+ * Shut the USB OHCI interface down--currently a NOP
+ */
+void platform_unconfigure_usb_ohci()
+{
+}
+
+/**
+ * configure_platform - configuration based on platform type.
+ */
+void __init configure_platform(void)
+{
+	platform_set_family();
+
+	switch (platform_family) {
+	case FAMILY_1500:
+	case FAMILY_1500VZE:
+	case FAMILY_1500VZF:
+		platform_features = FFS_CAPABLE;
+		asic = ASIC_CALLIOPE;
+		asic_phy_base = CALLIOPE_IO_BASE;
+		register_map = &calliope_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+
+		if (platform_family == FAMILY_1500VZE) {
+			gp_resources = non_dvr_vze_calliope_resources;
+			pr_info("Platform: 1500/Vz Class E - "
+				"CALLIOPE, NON_DVR_CAPABLE\n");
+		} else if (platform_family == FAMILY_1500VZF) {
+			gp_resources = non_dvr_vzf_calliope_resources;
+			pr_info("Platform: 1500/Vz Class F - "
+				"CALLIOPE, NON_DVR_CAPABLE\n");
+		} else {
+			gp_resources = non_dvr_calliope_resources;
+			pr_info("Platform: 1500/RNG100 - CALLIOPE, "
+				"NON_DVR_CAPABLE\n");
+		}
+		break;
+
+	case FAMILY_4500:
+		platform_features = FFS_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		asic = ASIC_ZEUS;
+		asic_phy_base = ZEUS_IO_BASE;
+		register_map = &zeus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = non_dvr_zeus_resources;
+
+		pr_info("Platform: 4500 - ZEUS, NON_DVR_CAPABLE\n");
+		break;
+
+	case FAMILY_4600:
+	{
+		unsigned int chipversion = 0;
+
+		/* The settop has PCIE but it isn't used, so don't advertise
+		 * it*/
+		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
+		asic_phy_base = CRONUS_IO_BASE;   /* same as Cronus */
+		register_map = &cronus_register_map;   /* same as Cronus */
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = non_dvr_cronuslite_resources;
+
+		/* ASIC version will determine if this is a real CronusLite or
+		 * Castrati(Cronus) */
+		chipversion  = asic_read(chipver3) << 24;
+		chipversion |= asic_read(chipver2) << 16;
+		chipversion |= asic_read(chipver1) << 8;
+		chipversion |= asic_read(chipver0);
+
+		if ((chipversion == CRONUS_10) || (chipversion == CRONUS_11))
+			asic = ASIC_CRONUS;
+		else
+			asic = ASIC_CRONUSLITE;
+
+		pr_info("Platform: 4600 - %s, NON_DVR_CAPABLE, "
+			"chipversion=0x%08X\n",
+			(asic == ASIC_CRONUS) ? "CRONUS" : "CRONUS LITE",
+			chipversion);
+		break;
+	}
+	case FAMILY_4600VZA:
+		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
+		asic = ASIC_CRONUS;
+		asic_phy_base = CRONUS_IO_BASE;
+		register_map = &cronus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = non_dvr_cronus_resources;
+
+		pr_info("Platform: Vz Class A - CRONUS, NON_DVR_CAPABLE\n");
+		break;
+
+	case FAMILY_8500:
+	case FAMILY_8500RNG:
+		platform_features = DVR_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		asic = ASIC_ZEUS;
+		asic_phy_base = ZEUS_IO_BASE;
+		register_map = &zeus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = dvr_zeus_resources;
+
+		pr_info("Platform: 8500/RNG200 - ZEUS, DVR_CAPABLE\n");
+		break;
+
+	case FAMILY_8600:
+	case FAMILY_8600VZB:
+		platform_features = DVR_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		asic = ASIC_CRONUS;
+		asic_phy_base = CRONUS_IO_BASE;
+		register_map = &cronus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = dvr_cronus_resources;
+
+		pr_info("Platform: 8600/Vz Class B - CRONUS, "
+			"DVR_CAPABLE\n");
+		break;
+
+	default:
+		pr_crit("Platform:  UNKNOWN PLATFORM\n");
+		break;
+	}
+
+	switch (asic) {
+	case ASIC_ZEUS:
+		phys_to_bus_offset = 0x30000000;
+		break;
+	case ASIC_CALLIOPE:
+		phys_to_bus_offset = 0x10000000;
+		break;
+	case ASIC_CRONUSLITE:
+		/* Fall through */
+	case ASIC_CRONUS:
+		/*
+		 * TODO: We suppose 0x10000000 aliases into 0x20000000-
+		 * 0x2XXXXXXX. If 0x10000000 aliases into 0x60000000-
+		 * 0x6XXXXXXX, the offset should be 0x50000000, not 0x10000000.
+		 */
+		phys_to_bus_offset = 0x10000000;
+		break;
+	default:
+		phys_to_bus_offset = 0x00000000;
+		break;
+	}
+}
+
+/**
+ * platform_devices_init - sets up USB device resourse.
+ */
+static int __init platform_devices_init(void)
+{
+	pr_notice("%s: ----- Initializing USB resources -----\n", __func__);
+
+	asic_resource.start = asic_phy_base;
+	asic_resource.end += asic_resource.start;
+
+	ehci_resources[0].start = asic_reg_phys_addr(ehci_hcapbase);
+	ehci_resources[0].end += ehci_resources[0].start;
+
+	ohci_resources[0].start = asic_reg_phys_addr(ohci_hc_revision);
+	ohci_resources[0].end += ohci_resources[0].start;
+
+	set_io_port_base(0);
+
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+
+	return 0;
+}
+
+arch_initcall(platform_devices_init);
+
+/*
+ *
+ * BOOTMEM ALLOCATION
+ *
+ */
+/*
+ * Allocates/reserves the Platform memory resources early in the boot process.
+ * This ignores any resources that are designated IORESOURCE_IO
+ */
+void __init platform_alloc_bootmem(void)
+{
+	int i;
+	int total = 0;
+
+	/* Get persistent memory data from command line before allocating
+	 * resources. This need to happen before normal command line parsing
+	 * has been done */
+	pmem_setup_resource();
+
+	/* Loop through looking for resources that want a particular address */
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		int size = gp_resources[i].end - gp_resources[i].start + 1;
+		if ((gp_resources[i].start != 0) &&
+			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
+			reserve_bootmem(bus_to_phys(gp_resources[i].start),
+				size, 0);
+			total += gp_resources[i].end -
+				gp_resources[i].start + 1;
+			pr_info("reserve resource %s at %08x (%u bytes)\n",
+				gp_resources[i].name, gp_resources[i].start,
+				gp_resources[i].end -
+					gp_resources[i].start + 1);
+		}
+	}
+
+	/* Loop through assigning addresses for those that are left */
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		int size = gp_resources[i].end - gp_resources[i].start + 1;
+		if ((gp_resources[i].start == 0) &&
+			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
+			void *mem = alloc_bootmem_pages(size);
+
+			if (mem == NULL)
+				pr_err("Unable to allocate bootmem pages "
+					"for %s\n", gp_resources[i].name);
+
+			else {
+				gp_resources[i].start =
+					phys_to_bus(virt_to_phys(mem));
+				gp_resources[i].end =
+					gp_resources[i].start + size - 1;
+				total += size;
+				pr_info("allocate resource %s at %08x "
+						"(%u bytes)\n",
+					gp_resources[i].name,
+					gp_resources[i].start, size);
+			}
+		}
+	}
+
+	pr_info("Total Platform driver memory allocation: 0x%08x\n", total);
+
+	/* indicate resources that are platform I/O related */
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		if ((gp_resources[i].start != 0) &&
+			((gp_resources[i].flags & IORESOURCE_IO) != 0)) {
+			pr_info("reserved platform resource %s at %08x\n",
+				gp_resources[i].name, gp_resources[i].start);
+		}
+	}
+}
+
+/*
+ *
+ * PERSISTENT MEMORY (PMEM) CONFIGURATION
+ *
+ */
+static unsigned long pmemaddr __initdata;
+
+static int __init early_param_pmemaddr(char *p)
+{
+	pmemaddr = (unsigned long)simple_strtoul(p, NULL, 0);
+	return 0;
+}
+early_param("pmemaddr", early_param_pmemaddr);
+
+static long pmemlen __initdata;
+
+static int __init early_param_pmemlen(char *p)
+{
+/* TODO: we can use this code when and if the bootloader ever changes this */
+#if 0
+	pmemlen = (unsigned long)simple_strtoul(p, NULL, 0);
+#else
+	pmemlen = 0x20000;
+#endif
+	return 0;
+}
+early_param("pmemlen", early_param_pmemlen);
+
+/*
+ * Set up persistent memory. If we were given values, we patch the array of
+ * resources. Otherwise, persistent memory may be allocated anywhere at all.
+ */
+static void __init pmem_setup_resource(void)
+{
+	struct resource *resource;
+	resource = asic_resource_get("DiagPersistentMemory");
+
+	if (resource && pmemaddr && pmemlen) {
+		/* The address provided by bootloader is in kseg0. Convert to
+		 * a bus address. */
+		resource->start = phys_to_bus(pmemaddr - 0x80000000);
+		resource->end = resource->start + pmemlen - 1;
+
+		pr_info("persistent memory: start=0x%x  end=0x%x\n",
+			resource->start, resource->end);
+	}
+}
+
+/*
+ *
+ * RESOURCE ACCESS FUNCTIONS
+ *
+ */
+
+/**
+ * asic_resource_get - retrieves parameters for a platform resource.
+ * @name:	string to match resource
+ *
+ * Returns a pointer to a struct resource corresponding to the given name.
+ *
+ * CANNOT BE NAMED platform_resource_get, which would be the obvious choice,
+ * as this function name is already declared
+ */
+struct resource *asic_resource_get(const char *name)
+{
+	int i;
+
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		if (strcmp(gp_resources[i].name, name) == 0)
+			return &gp_resources[i];
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(asic_resource_get);
+
+/**
+ * platform_release_memory - release pre-allocated memory
+ * @ptr:	pointer to memory to release
+ * @size:	size of resource
+ *
+ * This must only be called for memory allocated or reserved via the boot
+ * memory allocator.
+ */
+void platform_release_memory(void *ptr, int size)
+{
+	unsigned long addr;
+	unsigned long end;
+
+	addr = ((unsigned long)ptr + (PAGE_SIZE - 1)) & PAGE_MASK;
+	end = ((unsigned long)ptr + size) & PAGE_MASK;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(__va(addr)));
+		init_page_count(virt_to_page(__va(addr)));
+		free_page((unsigned long)__va(addr));
+	}
+}
+EXPORT_SYMBOL(platform_release_memory);
+
+/*
+ *
+ * FEATURE AVAILABILITY FUNCTIONS
+ *
+ */
+int platform_supports_dvr(void)
+{
+	return (platform_features & DVR_CAPABLE) != 0;
+}
+
+int platform_supports_ffs(void)
+{
+	return (platform_features & FFS_CAPABLE) != 0;
+}
+
+int platform_supports_pcie(void)
+{
+	return (platform_features & PCIE_CAPABLE) != 0;
+}
+
+int platform_supports_display(void)
+{
+	return (platform_features & DISPLAY_CAPABLE) != 0;
+}
diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
new file mode 100644
index 0000000..80b2eed
--- /dev/null
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -0,0 +1,125 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2001 Ralf Baechle
+ * Portions copyright (C) 2009  Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Routines for generic manipulation of the interrupts found on the PowerTV
+ * platform.
+ *
+ * The interrupt controller is located in the South Bridge a PIIX4 device
+ * with two internal 82C95 interrupt controllers.
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/kernel.h>
+#include <linux/random.h>
+
+#include <asm/irq_cpu.h>
+#include <linux/io.h>
+#include <asm/irq_regs.h>
+#include <asm/mips-boards/generic.h>
+
+#include <asm/mach-powertv/asic_regs.h>
+
+static DEFINE_SPINLOCK(asic_irq_lock);
+
+static inline int get_int(void)
+{
+	unsigned long flags;
+	int irq;
+
+	spin_lock_irqsave(&asic_irq_lock, flags);
+
+	irq = (asic_read(int_int_scan) >> 4) - 1;
+
+	if (irq == 0 || irq >= NR_IRQS)
+		irq = -1;
+
+	spin_unlock_irqrestore(&asic_irq_lock, flags);
+
+	return irq;
+}
+
+static void asic_irqdispatch(void)
+{
+	int irq;
+
+	irq = get_int();
+	if (irq < 0)
+		return;  /* interrupt has already been cleared */
+
+	do_IRQ(irq);
+}
+
+static inline int clz(unsigned long x)
+{
+	__asm__(
+	"	.set	push					\n"
+	"	.set	mips32					\n"
+	"	clz	%0, %1					\n"
+	"	.set	pop					\n"
+	: "=r" (x)
+	: "r" (x));
+
+	return x;
+}
+
+/*
+ * Version of ffs that only looks at bits 12..15.
+ */
+static inline unsigned int irq_ffs(unsigned int pending)
+{
+	return fls(pending) - 1 + CAUSEB_IP;
+}
+
+/*
+ * TODO: check how it works under EIC mode.
+ */
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int irq;
+
+	irq = irq_ffs(pending);
+
+	if (irq == CAUSEF_IP3)
+		asic_irqdispatch();
+	else if (irq >= 0)
+		do_IRQ(irq);
+	else
+		spurious_interrupt();
+}
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	asic_irq_init();
+
+	/*
+	 * Initialize interrupt exception vectors.
+	 */
+	if (cpu_has_veic || cpu_has_vint) {
+		int nvec = cpu_has_veic ? 64 : 8;
+		for (i = 0; i < nvec; i++)
+			set_vi_handler(i, asic_irqdispatch);
+	}
+}
diff --git a/arch/mips/powertv/asic/irq_asic.c b/arch/mips/powertv/asic/irq_asic.c
new file mode 100644
index 0000000..b54d244
--- /dev/null
+++ b/arch/mips/powertv/asic/irq_asic.c
@@ -0,0 +1,116 @@
+/*
+ * Portions copyright (C) 2005-2009 Scientific Atlanta
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * Modified from arch/mips/kernel/irq-rm7000.c:
+ * Copyright (C) 2003 Ralf Baechle
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+#include <asm/mach-powertv/asic_regs.h>
+
+static inline void unmask_asic_irq(unsigned int irq)
+{
+	unsigned long enable_bit;
+
+	enable_bit = (1 << (irq & 0x1f));
+
+	switch (irq >> 5) {
+	case 0:
+		asic_write(asic_read(ien_int_0) | enable_bit, ien_int_0);
+		break;
+	case 1:
+		asic_write(asic_read(ien_int_1) | enable_bit, ien_int_1);
+		break;
+	case 2:
+		asic_write(asic_read(ien_int_2) | enable_bit, ien_int_2);
+		break;
+	case 3:
+		asic_write(asic_read(ien_int_3) | enable_bit, ien_int_3);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void mask_asic_irq(unsigned int irq)
+{
+	unsigned long disable_mask;
+
+	disable_mask = ~(1 << (irq & 0x1f));
+
+	switch (irq >> 5) {
+	case 0:
+		asic_write(asic_read(ien_int_0) & disable_mask, ien_int_0);
+		break;
+	case 1:
+		asic_write(asic_read(ien_int_1) & disable_mask, ien_int_1);
+		break;
+	case 2:
+		asic_write(asic_read(ien_int_2) & disable_mask, ien_int_2);
+		break;
+	case 3:
+		asic_write(asic_read(ien_int_3) & disable_mask, ien_int_3);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static struct irq_chip asic_irq_chip = {
+	.name = "ASIC Level",
+	.ack = mask_asic_irq,
+	.mask = mask_asic_irq,
+	.mask_ack = mask_asic_irq,
+	.unmask = unmask_asic_irq,
+	.eoi = unmask_asic_irq,
+};
+
+void __init asic_irq_init(void)
+{
+	int i;
+
+	/* set priority to 0 */
+	write_c0_status(read_c0_status() & ~(0x0000fc00));
+
+	asic_write(0, ien_int_0);
+	asic_write(0, ien_int_1);
+	asic_write(0, ien_int_2);
+	asic_write(0, ien_int_3);
+
+	asic_write(0x0fffffff, int_level_3_3);
+	asic_write(0xffffffff, int_level_3_2);
+	asic_write(0xffffffff, int_level_3_1);
+	asic_write(0xffffffff, int_level_3_0);
+	asic_write(0xffffffff, int_level_2_3);
+	asic_write(0xffffffff, int_level_2_2);
+	asic_write(0xffffffff, int_level_2_1);
+	asic_write(0xffffffff, int_level_2_0);
+	asic_write(0xffffffff, int_level_1_3);
+	asic_write(0xffffffff, int_level_1_2);
+	asic_write(0xffffffff, int_level_1_1);
+	asic_write(0xffffffff, int_level_1_0);
+	asic_write(0xffffffff, int_level_0_3);
+	asic_write(0xffffffff, int_level_0_2);
+	asic_write(0xffffffff, int_level_0_1);
+	asic_write(0xffffffff, int_level_0_0);
+
+	asic_write(0xf, int_int_scan);
+
+	/*
+	 * Initialize interrupt handlers.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		set_irq_chip_and_handler(i, &asic_irq_chip, handle_level_irq);
+}
diff --git a/arch/mips/powertv/asic/prealloc-calliope.c b/arch/mips/powertv/asic/prealloc-calliope.c
new file mode 100644
index 0000000..0384201
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-calliope.c
@@ -0,0 +1,622 @@
+/*
+ *                   		prealloc-calliope.c
+ *
+ * Memory pre-allocations for Calliope boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * NON_DVR_CAPABLE CALLIOPE RESOURCES
+ */
+struct resource non_dvr_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",     	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x24200000 - 1,	/*2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",   /*8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x26700000 - 1, /*~36.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00600000 - 1,	/* 6 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DOCSIS Subsystem
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x22000000,
+		.end    = 0x22700000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x22700000,
+		.end    = 0x23500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23700000,
+		.end    = 0x23720000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer (don't need recording buffers)
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 *
+	 */
+	{ },
+};
+
+struct resource non_dvr_vz_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x24200000 - 1, /*2 Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8k block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x22202000,
+		.end    = 0x22C20B85 - 1,	/* 10.12 Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x20300000,
+		.end    = 0x20620000-1,  /*3.125 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x20100000,
+		.end    = 0x20300000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23900000,
+		.end    = 0x23920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE+0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
+
+struct resource non_dvr_vze_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x22000000,
+		.end    = 0x22200000 - 1,	/*2  Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8k block ST231a monitor */
+		.start  = 0x22200000,
+		.end    = 0x22202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x22202000,
+		.end    = 0x22C20B85 - 1,	/* 10.12 Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x20396000,
+		.end    = 0x206B6000 - 1,		/* 3.125 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x20100000,
+		.end    = 0x20396000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x206B6000,
+		.end    = 0x206D6000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE+0x400 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
+
+struct resource non_dvr_vzf_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/*Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x24200000 - 1,	/*2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/*8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		/* ~19.4 (21.5MiB - (2MiB + 8KiB)) */
+		.end    = 0x25580000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00480000 - 1,  /* 4.5 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x22700000,
+		.end    = 0x23500000 - 1, /* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23700000,
+		.end    = 0x23720000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer (don't need recording buffers)
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,  /* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit1
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,  /* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
diff --git a/arch/mips/powertv/asic/prealloc-cronus.c b/arch/mips/powertv/asic/prealloc-cronus.c
new file mode 100644
index 0000000..4435286
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-cronus.c
@@ -0,0 +1,610 @@
+/*
+ *                   		prealloc-cronus.c
+ *
+ * Memory pre-allocations for Cronus boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * DVR_CAPABLE CRONUS RESOURCES
+ */
+struct resource dvr_cronus_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x241FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24201FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "ITFS",
+		.start  = 0x64180000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x6430DFFF,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		/* (945K * 8) = (128K *3) 5 playbacks / 3 server */
+		.end    = 0x64AD0000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "AvfsFileSys",
+		.start  = 0x64AD0000,
+		.end    = 0x64AD1000 - 1,  /* 4K */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
+
+/*
+ * NON_DVR_CAPABLE CRONUS RESOURCES
+ */
+struct resource non_dvr_cronus_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x241FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24201FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		.end    = 0x645D2C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	{ },
+};
diff --git a/arch/mips/powertv/asic/prealloc-cronuslite.c b/arch/mips/powertv/asic/prealloc-cronuslite.c
new file mode 100644
index 0000000..2aaedd9
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-cronuslite.c
@@ -0,0 +1,292 @@
+/*
+ *                   		prealloc-cronuslite.c
+ *
+ * Memory pre-allocations for Cronus Lite boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * NON_DVR_CAPABLE CRONUSLITE RESOURCES
+ */
+struct resource non_dvr_cronuslite_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x63B80000 - 1,  /* 6 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x63B83000,
+		.end    = 0x63B84000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x63B84000,
+		.end    = 0x63E48C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x63B80000,
+		.end    = 0x63B82800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
diff --git a/arch/mips/powertv/asic/prealloc-zeus.c b/arch/mips/powertv/asic/prealloc-zeus.c
new file mode 100644
index 0000000..59c79f6
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-zeus.c
@@ -0,0 +1,461 @@
+/*
+ *                   		prealloc-zeus.c
+ *
+ * Memory pre-allocations for Zeus boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * DVR_CAPABLE RESOURCES
+ */
+struct resource dvr_zeus_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x20000000,
+		.end    = 0x201FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x20200000,
+		.end    = 0x20201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x20202000,
+		.end    = 0x21FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x30000000,
+		.end    = 0x301FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x30200000,
+		.end    = 0x30201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x30202000,
+		.end    = 0x31FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00c00000 - 1,	/* 12 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x40100000,
+		.end    = 0x407fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x46900000,
+		.end    = 0x47700000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x47900000,
+		.end    = 0x47920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,	/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,	/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "ITFS",
+		.start  = 0x00000000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x0018DFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		/* (945K * 8) = (128K * 3) 5 playbacks / 3 server */
+		.end    = 0x007c2000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "AvfsFileSys",
+		.start  = 0x00000000,
+		.end    = 0x00001000 - 1,  /* 4K */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
+
+/*
+ * NON_DVR_CAPABLE ZEUS RESOURCES
+ */
+struct resource non_dvr_zeus_resources[] __initdata =
+{
+	/*
+	 * VIDEO1 / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x20000000,
+		.end    = 0x201FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x20200000,
+		.end    = 0x20201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x20202000,
+		.end    = 0x21FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00600000 - 1,	/* 6 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DOCSIS Subsystem
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x40100000,
+		.end    = 0x407fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x46900000,
+		.end    = 0x47700000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x47900000,
+		.end    = 0x47920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	{ },
+};
diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
new file mode 100644
index 0000000..0f7d90e
--- /dev/null
+++ b/arch/mips/powertv/cevt-powertv.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2008 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#if 0
+/*
+ * The file comes from kernel/cevt-r4k.c
+ */
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/version.h>
+
+#include <asm/smtc_ipi.h>
+
+#include <asm/mach-powertv/interrupts.h>
+#include "powertv-clock.h"
+
+static int mips_next_event(unsigned long delta,
+	struct clock_event_device *evt)
+{
+	unsigned int cnt;
+	int res;
+
+	cnt = read_c0_count();
+	cnt += delta;
+	write_c0_compare(cnt);
+	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
+	return res;
+}
+
+static void mips_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+	/* Nothing to do ...  */
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
+static int cp0_timer_irq_installed;
+
+/*
+ * Timer ack for an R4k-compatible timer of a known frequency.
+ */
+static void c0_timer_ack(void)
+{
+	write_c0_compare(read_c0_compare());
+}
+
+#ifndef CONFIG_SEPARATE_PCI_TI
+/*
+ * Possibly handle a performance counter interrupt.
+ * Return true if the timer interrupt should not be checked
+ */
+static inline int handle_perf_irq(int r2)
+{
+	/*
+	 * The performance counter overflow interrupt may be shared with the
+	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
+	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
+	 * and we can't reliably determine if a counter interrupt has also
+	 * happened (!r2) then don't check for a timer interrupt.
+	 */
+	return (cp0_perfcount_irq < 0) &&
+		perf_irq() == IRQ_HANDLED &&
+		!r2;
+}
+#endif
+
+static irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
+{
+	const int r2 = cpu_has_mips_r2;
+	struct clock_event_device *cd;
+	int cpu = smp_processor_id();
+
+#ifndef CONFIG_SEPARATE_PCI_TI
+	/*
+	 * Suckage alert:
+	 * Before R2 of the architecture there was no way to see if a
+	 * performance counter interrupt was pending, so we have to run
+	 * the performance counter interrupt handler anyway.
+	 */
+	if (handle_perf_irq(r2))
+		return IRQ_HANDLED;
+#endif
+
+	/*
+	 * The same applies to performance counter interrupts.  But with the
+	 * above we now know that the reason we got here must be a timer
+	 * interrupt.  Being the paranoiacs we are we check anyway.
+	 */
+	if (!r2 || (read_c0_cause() & (1 << 30))) {
+		c0_timer_ack();
+		cd = &per_cpu(mips_clockevent_device, cpu);
+		cd->event_handler(cd);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction c0_compare_irqaction = {
+	.handler = c0_compare_interrupt,
+	.flags = IRQF_DISABLED | IRQF_PERCPU,
+	.name = "timer",
+};
+
+static void mips_event_handler(struct clock_event_device *dev)
+{
+}
+
+int __cpuinit powertv_clockevent_init(void)
+{
+	uint64_t mips_freq = mips_hpt_frequency;
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+	unsigned int irq;
+
+	if (!cpu_has_counter || !mips_hpt_frequency)
+		return -ENXIO;
+
+
+	irq = irq_mips_timer;
+
+	cd = &per_cpu(mips_clockevent_device, cpu);
+
+	cd->name		= "MIPS";
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
+
+	/* Calculate the min / max delta */
+	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
+	cd->shift		= 32;
+	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+
+	cd->rating		= 300;
+	cd->irq			= irq;
+	cd->cpumask		= get_cpu_mask(cpu);
+
+	cd->set_next_event	= mips_next_event;
+	cd->set_mode		= mips_set_mode;
+	cd->event_handler	= mips_event_handler;
+
+	clockevents_register_device(cd);
+
+	if (cp0_timer_irq_installed)
+		return 0;
+
+	cp0_timer_irq_installed = 1;
+
+	setup_irq(irq, &c0_compare_irqaction);
+
+	return 0;
+}
+#endif
+
+#include <asm/mach-powertv/interrupts.h>
+#include <asm/time.h>			/* Not included in linux/time.h */
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return irq_mips_timer;
+}
diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
new file mode 100644
index 0000000..98d73cb
--- /dev/null
+++ b/arch/mips/powertv/cmdline.c
@@ -0,0 +1,52 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Kernel command line creation using the prom monitor (YAMON) argc/argv.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+
+#include "init.h"
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension.
+ */
+#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+void  __init prom_init_cmdline(void)
+{
+	int len;
+
+	if (prom_argc != 1)
+		return;
+
+	len = strlen(arcs_cmdline);
+
+	arcs_cmdline[len] = ' ';
+
+	strlcpy(arcs_cmdline + len + 1, (char *)_prom_argv,
+		COMMAND_LINE_SIZE - len - 1);
+}
diff --git a/arch/mips/powertv/csrc-powertv.c b/arch/mips/powertv/csrc-powertv.c
new file mode 100644
index 0000000..a27c16c
--- /dev/null
+++ b/arch/mips/powertv/csrc-powertv.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright (C) 2008 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+/*
+ * The file comes from kernel/csrc-r4k.c
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+
+#include <asm/time.h>			/* Not included in linux/time.h */
+
+#include <asm/mach-powertv/asic_regs.h>
+#include "powertv-clock.h"
+
+/* MIPS PLL Register Definitions */
+#define PLL_GET_M(x)		(((x) >> 8) & 0x000000FF)
+#define PLL_GET_N(x)		(((x) >> 16) & 0x000000FF)
+#define PLL_GET_P(x)		(((x) >> 24) & 0x00000007)
+
+/*
+ * returns:  Clock frequency in kHz
+ */
+unsigned int __init mips_get_pll_freq(void)
+{
+	unsigned int pll_reg, m, n, p;
+	unsigned int fin = 54000; /* Base frequency in kHz */
+	unsigned int fout;
+
+	/* Read PLL register setting */
+	pll_reg = asic_read(mips_pll_setup);
+	m = PLL_GET_M(pll_reg);
+	n = PLL_GET_N(pll_reg);
+	p = PLL_GET_P(pll_reg);
+	pr_info("MIPS PLL Register:0x%x  M=%d  N=%d  P=%d\n", pll_reg, m, n, p);
+
+	/* Calculate clock frequency = (2 * N * 54MHz) / (M * (2**P)) */
+	fout = ((2 * n * fin) / (m * (0x01 << p)));
+
+	pr_info("MIPS Clock Freq=%d kHz\n", fout);
+
+	return fout;
+}
+
+static cycle_t c0_hpt_read(struct clocksource *cs)
+{
+	return read_c0_count();
+}
+
+static struct clocksource clocksource_mips = {
+	.name		= "powertv-counter",
+	.read		= c0_hpt_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void __init powertv_c0_hpt_clocksource_init(void)
+{
+	unsigned int pll_freq = mips_get_pll_freq();
+
+	pr_info("CPU frequency %d.%02d MHz\n", pll_freq / 1000,
+		(pll_freq % 1000) * 100 / 1000);
+
+	mips_hpt_frequency = pll_freq / 2 * 1000;
+
+	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
+
+	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
+
+	clocksource_register(&clocksource_mips);
+}
+
+/**
+ * struct tim_c - free running counter
+ * @hi:	High 16 bits of the counter
+ * @lo:	Low 32 bits of the counter
+ *
+ * Lays out the structure of the free running counter in memory. This counter
+ * increments at a rate of 27 MHz/8 on all platforms.
+ */
+struct tim_c {
+	unsigned int hi;
+	unsigned int lo;
+};
+
+static struct tim_c *tim_c;
+
+static cycle_t tim_c_read(struct clocksource *cs)
+{
+	unsigned int hi;
+	unsigned int next_hi;
+	unsigned int lo;
+
+	hi = readl(&tim_c->hi);
+
+	for (;;) {
+		lo = readl(&tim_c->lo);
+		next_hi = readl(&tim_c->hi);
+		if (next_hi == hi)
+			break;
+		hi = next_hi;
+	}
+
+pr_crit("%s: read %llx\n", __func__, ((u64) hi << 32) | lo);
+	return ((u64) hi << 32) | lo;
+}
+
+#define TIM_C_SIZE		48		/* # bits in the timer */
+
+static struct clocksource clocksource_tim_c = {
+	.name		= "powertv-tim_c",
+	.read		= tim_c_read,
+	.mask		= CLOCKSOURCE_MASK(TIM_C_SIZE),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+/**
+ * powertv_tim_c_clocksource_init - set up a clock source for the TIM_C clock
+ *
+ * The hard part here is coming up with a constant k and shift s such that
+ * the 48-bit TIM_C value multiplied by k doesn't overflow and that value,
+ * when shifted right by s, yields the corresponding number of nanoseconds.
+ * We know that TIM_C counts at 27 MHz/8, so each cycle corresponds to
+ * 1 / (27,000,000/8) seconds. Multiply that by a billion and you get the
+ * number of nanoseconds. Since the TIM_C value has 48 bits and the math is
+ * done in 64 bits, avoiding an overflow means that k must be less than
+ * 64 - 48 = 16 bits.
+ */
+static void __init powertv_tim_c_clocksource_init(void)
+{
+	int			prescale;
+	unsigned long		dividend;
+	unsigned long		k;
+	int			s;
+	const int		max_k_bits = (64 - 48) - 1;
+	const unsigned long	billion = 1000000000;
+	const unsigned long	counts_per_second = 27000000 / 8;
+
+	prescale = BITS_PER_LONG - ilog2(billion) - 1;
+	dividend = billion << prescale;
+	k = dividend / counts_per_second;
+	s = ilog2(k) - max_k_bits;
+
+	if (s < 0)
+		s = prescale;
+
+	else {
+		k >>= s;
+		s += prescale;
+	}
+
+	clocksource_tim_c.mult = k;
+	clocksource_tim_c.shift = s;
+	clocksource_tim_c.rating = 200;
+
+	clocksource_register(&clocksource_tim_c);
+	tim_c = (struct tim_c *) asic_reg_addr(tim_ch);
+}
+
+/**
+ powertv_clocksource_init - initialize all clocksources
+ */
+void __init powertv_clocksource_init(void)
+{
+	powertv_c0_hpt_clocksource_init();
+	powertv_tim_c_clocksource_init();
+}
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
new file mode 100644
index 0000000..5f4e4c3
--- /dev/null
+++ b/arch/mips/powertv/init.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * PROM library initialisation code.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+#include <linux/io.h>
+#include <asm/system.h>
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
+
+#include <asm/mips-boards/prom.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mach-powertv/asic.h>
+
+#include "init.h"
+
+int prom_argc;
+int *_prom_argv, *_prom_envp;
+unsigned long _prom_memsize;
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension, if running in 64-bit mode.
+ */
+#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
+
+char *prom_getenv(char *envname)
+{
+	char *result = NULL;
+
+	if (_prom_envp != NULL) {
+		/*
+		 * Return a pointer to the given environment variable.
+		 * In 64-bit mode: we're using 64-bit pointers, but all pointers
+		 * in the PROM structures are only 32-bit, so we need some
+		 * workarounds, if we are running in 64-bit mode.
+		 */
+		int i, index = 0;
+
+		i = strlen(envname);
+
+		while (prom_envp(index)) {
+			if (strncmp(envname, prom_envp(index), i) == 0) {
+				result = prom_envp(index + 1);
+				break;
+			}
+			index += 2;
+		}
+	}
+
+	return result;
+}
+
+/* TODO: Verify on linux-mips mailing list that the following two  */
+/* functions are correct                                           */
+/* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
+/* BootROM exception vectors. Flush their cache entries. test it.  */
+
+static void __init mips_nmi_setup(void)
+{
+	void *base;
+#if defined(CONFIG_CPU_MIPS32_R1)
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa80) :
+		(void *)(CAC_BASE + 0x380);
+#elif defined(CONFIG_CPU_MIPS32_R2)
+	base = (void *)0xbfc00000;
+#else
+#error NMI exception handler address not defined
+#endif
+}
+
+static void __init mips_ejtag_setup(void)
+{
+	void *base;
+
+#if defined(CONFIG_CPU_MIPS32_R1)
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa00) :
+		(void *)(CAC_BASE + 0x300);
+#elif defined(CONFIG_CPU_MIPS32_R2)
+	base = (void *)0xbfc00480;
+#else
+#error EJTAG exception handler address not defined
+#endif
+}
+
+void __init prom_init(void)
+{
+	prom_argc = fw_arg0;
+	_prom_argv = (int *) fw_arg1;
+	_prom_envp = (int *) fw_arg2;
+	_prom_memsize = (unsigned long) fw_arg3;
+
+	board_nmi_handler_setup = mips_nmi_setup;
+	board_ejtag_handler_setup = mips_ejtag_setup;
+
+	pr_info("\nLINUX started...\n");
+	prom_init_cmdline();
+	configure_platform();
+	prom_meminit();
+
+#ifndef CONFIG_BOOTLOADER_DRIVER
+	pr_info("\nBootloader driver isn't loaded...\n");
+#endif
+}
diff --git a/arch/mips/powertv/init.h b/arch/mips/powertv/init.h
new file mode 100644
index 0000000..332cfed
--- /dev/null
+++ b/arch/mips/powertv/init.h
@@ -0,0 +1,30 @@
+/*
+ *				init.h
+ *
+ * Definitions from powertv init.c file
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef _POWERTV_INIT_H
+#define _POWERTV_INIT_H
+extern int prom_argc;
+extern int *_prom_argv;
+extern unsigned long _prom_memsize;
+#endif
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
new file mode 100644
index 0000000..4ef689c
--- /dev/null
+++ b/arch/mips/powertv/memory.c
@@ -0,0 +1,184 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Apparently originally from arch/mips/malta-memory.c. Modified to work
+ * with the PowerTV bootloader.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/pfn.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <asm/mips-boards/prom.h>
+
+#include "init.h"
+
+/* Memory constants */
+#define KIBIBYTE(n)		((n) * 1024)	/* Number of kibibytes */
+#define MEBIBYTE(n)		((n) * KIBIBYTE(1024)) /* Number of mebibytes */
+#define DEFAULT_MEMSIZE		MEBIBYTE(256)	/* If no memsize provided */
+#define LOW_MEM_MAX		MEBIBYTE(252)	/* Max usable low mem */
+#define RES_BOOTLDR_MEMSIZE	MEBIBYTE(1)	/* Memory reserved for bldr */
+#define BOOT_MEM_SIZE		KIBIBYTE(256)	/* Memory reserved for bldr */
+#define PHYS_MEM_START		0x10000000	/* Start of physical memory */
+
+unsigned long ptv_memsize;
+
+void __init prom_meminit(void)
+{
+	char *memsize_str;
+	unsigned long memsize = 0;
+	unsigned int physend;
+	char cmdline[CL_SIZE], *ptr;
+	int low_mem;
+	int high_mem;
+
+	/* Check the command line first for a memsize directive */
+	strcpy(cmdline, arcs_cmdline);
+	ptr = strstr(cmdline, "memsize=");
+	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+		ptr = strstr(ptr, " memsize=");
+
+	if (ptr) {
+		memsize = memparse(ptr + 8, &ptr);
+	} else {
+		/* otherwise look in the environment */
+		memsize_str = prom_getenv("memsize");
+
+		if (memsize_str != NULL) {
+			pr_info("prom memsize = %s\n", memsize_str);
+			memsize = simple_strtol(memsize_str, NULL, 0);
+		}
+
+		if (memsize == 0) {
+			if (_prom_memsize != 0) {
+				memsize = _prom_memsize;
+				pr_info("_prom_memsize = 0x%lx\n", memsize);
+				/* add in memory that the bootloader doesn't
+				 * report */
+				memsize += BOOT_MEM_SIZE;
+			} else {
+				memsize = DEFAULT_MEMSIZE;
+				pr_info("Memsize not passed by bootloader, "
+					"defaulting to 0x%lx\n", memsize);
+			}
+		}
+	}
+
+	/* Store memsize for diagnostic purposes */
+	ptv_memsize = memsize;
+
+	physend = PFN_ALIGN(&_end) - 0x80000000;
+	if (memsize > LOW_MEM_MAX) {
+		low_mem = LOW_MEM_MAX;
+		high_mem = memsize - low_mem;
+	} else {
+		low_mem = memsize;
+		high_mem = 0;
+	}
+
+/*
+ * TODO: We will use the hard code for memory configuration until
+ * the bootloader releases their device tree to us.
+ */
+	/*
+	 * Add the memory reserved for use by the bootloader to the
+	 * memory map.
+	 */
+	add_memory_region(PHYS_MEM_START, RES_BOOTLDR_MEMSIZE,
+		BOOT_MEM_RESERVED);
+#ifdef CONFIG_HIGHMEM_256_128
+	/*
+	 * Add memory in low for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 */
+	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
+		LOW_MEM_MAX - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	/*
+	 * Add the memory reserved for reset vector.
+	 */
+	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
+	/*
+	 * Add the memory reserved.
+	 */
+	add_memory_region(0x20000000, MEBIBYTE(1024 + 75), BOOT_MEM_RESERVED);
+	/*
+	 * Add memory in high for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 *
+	 * 75MB is reserved for devices which are using the memory in high.
+	 */
+	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
+		BOOT_MEM_RAM);
+#elif defined CONFIG_HIGHMEM_128_128
+	/*
+	 * Add memory in low for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 */
+	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
+		MEBIBYTE(128) - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	/*
+	 * Add the memory reserved.
+	 */
+	add_memory_region(PHYS_MEM_START + MEBIBYTE(128),
+		MEBIBYTE(128 + 1024 + 75), BOOT_MEM_RESERVED);
+	/*
+	 * Add memory in high for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 *
+	 * 75MB is reserved for devices which are using the memory in high.
+	 */
+	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
+		BOOT_MEM_RAM);
+#else
+	/* Add low memory regions for either:
+	 *   - no-highmemory configuration case -OR-
+	 *   - highmemory "HIGHMEM_LOWBANK_ONLY" case
+	 */
+	/*
+	 * Add memory for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 */
+	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
+		low_mem - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	/*
+	 * Add the memory reserved for reset vector.
+	 */
+	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
+#endif
+}
+
+void __init prom_free_prom_memory(void)
+{
+	unsigned long addr;
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
+	}
+}
diff --git a/arch/mips/powertv/pci/Makefile b/arch/mips/powertv/pci/Makefile
new file mode 100644
index 0000000..9249164
--- /dev/null
+++ b/arch/mips/powertv/pci/Makefile
@@ -0,0 +1,28 @@
+# *****************************************************************************
+#                          Make file for PowerTV PCI driver
+#
+# Copyright (C) 2009  Scientific-Atlanta, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# *****************************************************************************
+
+EXTRA_CFLAGS += -Wall -Werror
+
+obj-y	:=
+
+obj-$(CONFIG_PCI)	+= fixup-powertv.o
+
+
diff --git a/arch/mips/powertv/pci/fixup-powertv.c b/arch/mips/powertv/pci/fixup-powertv.c
new file mode 100644
index 0000000..726bc2e
--- /dev/null
+++ b/arch/mips/powertv/pci/fixup-powertv.c
@@ -0,0 +1,36 @@
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/mach-powertv/interrupts.h>
+#include "powertv-pci.h"
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return asic_pcie_map_irq(dev, slot, pin);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/*
+ * asic_pcie_map_irq
+ *
+ * Parameters:
+ * *dev - pointer to a pci_dev structure  (not used)
+ * slot - slot number  (not used)
+ * pin - pin number  (not used)
+ *
+ * Return Value:
+ * Returns: IRQ number (always the PCI Express IRQ number)
+ *
+ * Description:
+ * asic_pcie_map_irq will return the IRQ number of the PCI Express interrupt.
+ *
+ */
+int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return irq_pciexp;
+}
+EXPORT_SYMBOL(asic_pcie_map_irq);
diff --git a/arch/mips/powertv/pci/powertv-pci.h b/arch/mips/powertv/pci/powertv-pci.h
new file mode 100644
index 0000000..1b5886b
--- /dev/null
+++ b/arch/mips/powertv/pci/powertv-pci.h
@@ -0,0 +1,31 @@
+/*
+ *				powertv-pci.c
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+/*
+ * Local definitions for the powertv PCI code
+ */
+
+#ifndef _POWERTV_PCI_POWERTV_PCI_H_
+#define _POWERTV_PCI_POWERTV_PCI_H_
+extern int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+extern int asic_pcie_init(void);
+extern int asic_pcie_init(void);
+
+extern int log_level;
+#endif
diff --git a/arch/mips/powertv/powertv-clock.h b/arch/mips/powertv/powertv-clock.h
new file mode 100644
index 0000000..5c1f093
--- /dev/null
+++ b/arch/mips/powertv/powertv-clock.h
@@ -0,0 +1,30 @@
+/*
+ *				powertv-clock.h
+ *
+ * Definitions for clocks
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef _POWERTV_POWERTV_CLOCK_H
+#define _POWERTV_POWERTV_CLOCK_H
+extern int powertv_clockevent_init(void);
+extern void powertv_clocksource_init(void);
+extern unsigned int mips_get_pll_freq(void);
+#endif
diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
new file mode 100644
index 0000000..bd8ebf1
--- /dev/null
+++ b/arch/mips/powertv/powertv_setup.c
@@ -0,0 +1,351 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/screen_info.h>
+#include <linux/notifier.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/ctype.h>
+
+#include <linux/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/dma.h>
+#include <linux/time.h>
+#include <asm/traps.h>
+#include <asm/asm-offsets.h>
+#include "reset.h"
+
+#define VAL(n)		STR(n)
+
+/*
+ * Macros for loading addresses and storing registers:
+ * PTR_LA	Load the address into a register
+ * LONG_S	Store the full width of the given register.
+ * LONG_L	Load the full width of the given register
+ * PTR_ADDIU	Add a constant value to a register used as a pointer
+ * REG_SIZE	Number of 8-bit bytes in a full width register
+ */
+#ifdef CONFIG_64BIT
+#warning TODO: 64-bit code needs to be verified
+#define PTR_LA		"dla	"
+#define LONG_S		"sd	"
+#define LONG_L		"ld	"
+#define PTR_ADDIU	"daddiu	"
+#define REG_SIZE	"8"		/* In bytes */
+#endif
+
+#ifdef CONFIG_32BIT
+#define PTR_LA		"la	"
+#define LONG_S		"sw	"
+#define LONG_L		"lw	"
+#define PTR_ADDIU	"addiu	"
+#define REG_SIZE	"4"		/* In bytes */
+#endif
+
+static struct pt_regs die_regs;
+static bool have_die_regs;
+
+static void register_panic_notifier(void);
+static int panic_handler(struct notifier_block *notifier_block,
+	unsigned long event, void *cause_string);
+
+const char *get_system_type(void)
+{
+	return "PowerTV";
+}
+
+void __init plat_mem_setup(void)
+{
+	panic_on_oops = 1;
+	register_panic_notifier();
+
+#if 0
+	mips_pcibios_init();
+#endif
+	mips_reboot_setup();
+}
+
+/*
+ * Install a panic notifier for platform-specific diagnostics
+ */
+static void register_panic_notifier()
+{
+	static struct notifier_block panic_notifier = {
+		.notifier_call = panic_handler,
+		.next = NULL,
+		.priority	= INT_MAX
+	};
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
+}
+
+static int panic_handler(struct notifier_block *notifier_block,
+	unsigned long event, void *cause_string)
+{
+	struct pt_regs	my_regs;
+
+	/* Save all of the registers */
+	{
+		unsigned long	at, v0, v1; /* Must be on the stack */
+
+		/* Start by saving $at and v0 on the stack. We use $at
+		 * ourselves, but it looks like the compiler may use v0 or v1
+		 * to load the address of the pt_regs structure. We'll come
+		 * back later to store the registers in the pt_regs
+		 * structure. */
+		__asm__ __volatile__ (
+			".set	noat\n"
+			LONG_S		"$at, %[at]\n"
+			LONG_S		"$2, %[v0]\n"
+			LONG_S		"$3, %[v1]\n"
+		:
+			[at] "=m" (at),
+			[v0] "=m" (v0),
+			[v1] "=m" (v1)
+		:
+		:	"at"
+		);
+
+		__asm__ __volatile__ (
+			".set	noat\n"
+			"move		$at, %[pt_regs]\n"
+
+			/* Argument registers */
+			LONG_S		"$4, " VAL(PT_R4) "($at)\n"
+			LONG_S		"$5, " VAL(PT_R5) "($at)\n"
+			LONG_S		"$6, " VAL(PT_R6) "($at)\n"
+			LONG_S		"$7, " VAL(PT_R7) "($at)\n"
+
+			/* Temporary regs */
+			LONG_S		"$8, " VAL(PT_R8) "($at)\n"
+			LONG_S		"$9, " VAL(PT_R9) "($at)\n"
+			LONG_S		"$10, " VAL(PT_R10) "($at)\n"
+			LONG_S		"$11, " VAL(PT_R11) "($at)\n"
+			LONG_S		"$12, " VAL(PT_R12) "($at)\n"
+			LONG_S		"$13, " VAL(PT_R13) "($at)\n"
+			LONG_S		"$14, " VAL(PT_R14) "($at)\n"
+			LONG_S		"$15, " VAL(PT_R15) "($at)\n"
+
+			/* "Saved" registers */
+			LONG_S		"$16, " VAL(PT_R16) "($at)\n"
+			LONG_S		"$17, " VAL(PT_R17) "($at)\n"
+			LONG_S		"$18, " VAL(PT_R18) "($at)\n"
+			LONG_S		"$19, " VAL(PT_R19) "($at)\n"
+			LONG_S		"$20, " VAL(PT_R20) "($at)\n"
+			LONG_S		"$21, " VAL(PT_R21) "($at)\n"
+			LONG_S		"$22, " VAL(PT_R22) "($at)\n"
+			LONG_S		"$23, " VAL(PT_R23) "($at)\n"
+
+			/* Add'l temp regs */
+			LONG_S		"$24, " VAL(PT_R24) "($at)\n"
+			LONG_S		"$25, " VAL(PT_R25) "($at)\n"
+
+			/* Kernel temp regs */
+			LONG_S		"$26, " VAL(PT_R26) "($at)\n"
+			LONG_S		"$27, " VAL(PT_R27) "($at)\n"
+
+			/* Global pointer, stack pointer, frame pointer and
+			 * return address */
+			LONG_S		"$gp, " VAL(PT_R28) "($at)\n"
+			LONG_S		"$sp, " VAL(PT_R29) "($at)\n"
+			LONG_S		"$fp, " VAL(PT_R30) "($at)\n"
+			LONG_S		"$ra, " VAL(PT_R31) "($at)\n"
+
+			/* Now we can get the $at and v0 registers back and
+			 * store them */
+			LONG_L		"$8, %[at]\n"
+			LONG_S		"$8, " VAL(PT_R1) "($at)\n"
+			LONG_L		"$8, %[v0]\n"
+			LONG_S		"$8, " VAL(PT_R2) "($at)\n"
+			LONG_L		"$8, %[v1]\n"
+			LONG_S		"$8, " VAL(PT_R3) "($at)\n"
+		:
+		:
+			[at] "m" (at),
+			[v0] "m" (v0),
+			[v1] "m" (v1),
+			[pt_regs] "r" (&my_regs)
+		:	"at", "t0"
+		);
+
+		/* Set the current EPC value to be the current location in this
+		 * function */
+		__asm__ __volatile__ (
+			".set	noat\n"
+		"1:\n"
+			PTR_LA		"$at, 1b\n"
+			LONG_S		"$at, %[cp0_epc]\n"
+		:
+			[cp0_epc] "=m" (my_regs.cp0_epc)
+		:
+		:	"at"
+		);
+
+		my_regs.cp0_cause = read_c0_cause();
+		my_regs.cp0_status = read_c0_status();
+	}
+
+#ifdef CONFIG_DIAGNOSTICS
+	failure_report((char *) cause_string,
+		have_die_regs ? &die_regs : &my_regs);
+	have_die_regs = false;
+#else
+	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
+		"zzzz... \n");
+#endif
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * Platform-specific handling of oops
+ * @str:	Pointer to the oops string
+ * @regs:	Pointer to the oops registers
+ * All we do here is to save the registers for subsequent printing through
+ * the panic notifier.
+ */
+void platform_die(const char *str, const struct pt_regs *regs)
+{
+	/* If we already have saved registers, don't overwrite them as they
+	 * they apply to the initial fault */
+
+	if (!have_die_regs) {
+		have_die_regs = true;
+		die_regs = *regs;
+	}
+}
+
+/* Information about the RF MAC address, if one was supplied on the
+ * command line. */
+static bool have_rfmac;
+static u8 rfmac[ETH_ALEN];
+
+static int rfmac_param(char *p)
+{
+	u8	*q;
+	bool	is_high_nibble;
+	int	c;
+
+	/* Skip a leading "0x", if present */
+	if (*p == '0' && *(p+1) == 'x')
+		p += 2;
+
+	q = rfmac;
+	is_high_nibble = true;
+
+	for (c = (unsigned char) *p++;
+		isxdigit(c) && q - rfmac < ETH_ALEN;
+		c = (unsigned char) *p++) {
+		int	nibble;
+
+		nibble = (isdigit(c) ? (c - '0') :
+			(isupper(c) ? c - 'A' + 10 : c - 'a' + 10));
+
+		if (is_high_nibble)
+			*q = nibble << 4;
+		else
+			*q++ |= nibble;
+
+		is_high_nibble = !is_high_nibble;
+	}
+
+	/* If we parsed all the way to the end of the parameter value and
+	 * parsed all ETH_ALEN bytes, we have a usable RF MAC address */
+	have_rfmac = (c == '\0' && q - rfmac == ETH_ALEN);
+
+	return 0;
+}
+
+early_param("rfmac", rfmac_param);
+
+/*
+ * Generate an Ethernet MAC address that has a good chance of being unique.
+ * @addr:	Pointer to six-byte array containing the Ethernet address
+ * Generates an Ethernet MAC address that is highly likely to be unique for
+ * this particular system on a network with other systems of the same type.
+ *
+ * The problem we are solving is that, when random_ether_addr() is used to
+ * generate MAC addresses at startup, there isn't much entropy for the random
+ * number generator to use and the addresses it produces are fairly likely to
+ * be the same as those of other identical systems on the same local network.
+ * This is true even for relatively small numbers of systems (for the reason
+ * why, see the Wikipedia entry for "Birthday problem" at:
+ *	http://en.wikipedia.org/wiki/Birthday_problem
+ *
+ * The good news is that we already have a MAC address known to be unique, the
+ * RF MAC address. The bad news is that this address is already in use on the
+ * RF interface. Worse, the obvious trick, taking the RF MAC address and
+ * turning on the locally managed bit, has already been used for other devices.
+ * Still, this does give us something to work with.
+ *
+ * The approach we take is:
+ * 1.	If we can't get the RF MAC Address, just call random_ether_addr.
+ * 2.	Use the 24-bit NIC-specific bits of the RF MAC address as the last 24
+ *	bits of the new address. This is very likely to be unique, except for
+ *	the current box.
+ * 3.	To avoid using addresses already on the current box, we set the top
+ *	six bits of the address with a value different from any currently
+ *	registered Scientific Atlanta organizationally unique identifyer
+ *	(OUI). This avoids duplication with any addresses on the system that
+ *	were generated from valid Scientific Atlanta-registered address by
+ *	simply flipping the locally managed bit.
+ * 4.	We aren't generating a multicast address, so we leave the multicast
+ *	bit off. Since we aren't using a registered address, we have to set
+ *	the locally managed bit.
+ * 5.	We then randomly generate the remaining 16-bits. This does two
+ *	things:
+ *	a.	It allows us to call this function for more than one device
+ *		in this system
+ *	b.	It ensures that things will probably still work even if
+ *		some device on the device network has a locally managed
+ *		address that matches the top six bits from step 2.
+ */
+void platform_random_ether_addr(u8 addr[ETH_ALEN])
+{
+	const int num_random_bytes = 2;
+	const unsigned char non_sciatl_oui_bits = 0xc0u;
+	const unsigned char mac_addr_locally_managed = (1 << 1);
+
+	if (!have_rfmac) {
+		pr_warning("rfmac not available on command line; "
+			"generating random MAC address\n");
+		random_ether_addr(addr);
+	}
+
+	else {
+		int	i;
+
+		/* Set the first byte to something that won't match a Scientific
+		 * Atlanta OUI, is locally managed, and isn't a multicast
+		 * address */
+		addr[0] = non_sciatl_oui_bits | mac_addr_locally_managed;
+
+		/* Get some bytes of random address information */
+		get_random_bytes(&addr[1], num_random_bytes);
+
+		/* Copy over the NIC-specific bits of the RF MAC address */
+		for (i = 1 + num_random_bytes; i < ETH_ALEN; i++)
+			addr[i] = rfmac[i];
+	}
+}
diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
new file mode 100644
index 0000000..ec8fe80
--- /dev/null
+++ b/arch/mips/powertv/reset.c
@@ -0,0 +1,70 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ */
+#include <linux/pm.h>
+
+#include <linux/io.h>
+#include <asm/reboot.h>			/* Not included by linux/reboot.h */
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+#include <asm/mach-powertv/kbldr.h>
+#endif
+
+#include <asm/mach-powertv/asic_regs.h>
+#include "reset.h"
+
+static void mips_machine_restart(char *command);
+static void mips_machine_halt(void);
+
+static void mips_machine_restart(char *command)
+{
+#ifdef CONFIG_BOOTLOADER_DRIVER
+	/*
+	 * Call the bootloader's reset function to ensure
+	 * that persistent data is flushed before hard reset
+	 */
+	kbldr_SetCauseAndReset();
+#else
+	writel(0x1, asic_reg_addr(watchdog));
+#endif
+}
+
+static void mips_machine_halt(void)
+{
+#ifdef CONFIG_BOOTLOADER_DRIVER
+	/*
+	 * Call the bootloader's reset function to ensure
+	 * that persistent data is flushed before hard reset
+	 */
+	kbldr_SetCauseAndReset();
+#else
+	writel(0x1, asic_reg_addr(watchdog));
+#endif
+}
+
+void mips_reboot_setup(void)
+{
+	_machine_restart = mips_machine_restart;
+	_machine_halt = mips_machine_halt;
+	pm_power_off = mips_machine_halt;
+}
diff --git a/arch/mips/powertv/reset.h b/arch/mips/powertv/reset.h
new file mode 100644
index 0000000..93d58b9
--- /dev/null
+++ b/arch/mips/powertv/reset.h
@@ -0,0 +1,28 @@
+/*
+ *				reset.h
+ *
+ * Definitions from powertv reset.c file
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef _POWERTV_POWERTV_RESET_H
+#define _POWERTV_POWERTV_RESET_H
+extern void mips_reboot_setup(void);
+#endif
diff --git a/arch/mips/powertv/time.c b/arch/mips/powertv/time.c
new file mode 100644
index 0000000..eaa9919
--- /dev/null
+++ b/arch/mips/powertv/time.c
@@ -0,0 +1,30 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Setting up the clock on the MIPS boards.
+ */
+
+#include <asm/time.h>
+
+#include "powertv-clock.h"
+
+void __init plat_time_init(void)
+{
+	powertv_clocksource_init();
+	r4k_clockevent_init();
+}
