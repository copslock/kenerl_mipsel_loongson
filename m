Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 15:22:49 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:10433 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20037524AbWLGPWm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 15:22:42 +0000
Received: (qmail 19980 invoked from network); 7 Dec 2006 15:23:14 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO laja) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 7 Dec 2006 15:23:14 -0000
Date:	Thu, 7 Dec 2006 18:22:34 +0300
From:	Vitaly Wool <vitalywool@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] add STB810 support (Philips PNX8550-based)
Message-Id: <20061207182234.83212939.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

Hello Ralf,

please find the patch that adds support for STB810 below.

 arch/mips/Kconfig                              |    5 
 arch/mips/Makefile                             |    5 
 arch/mips/configs/pnx8550-stb810_defconfig     | 1117 +++++++++++++++++++++++++
 arch/mips/kernel/head.S                        |    2 
 arch/mips/philips/pnx8550/common/prom.c        |   20 
 arch/mips/philips/pnx8550/stb810/Makefile      |    4 
 arch/mips/philips/pnx8550/stb810/board_setup.c |   56 +
 arch/mips/philips/pnx8550/stb810/irqmap.c      |   23 
 arch/mips/philips/pnx8550/stb810/prom_init.c   |   49 +
 include/asm-mips/bootinfo.h                    |    1 
 10 files changed, 1267 insertions(+), 15 deletions(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips.git/arch/mips/philips/pnx8550/stb810/Makefile	2006-12-07 18:21:04.000000000 +0300
@@ -0,0 +1,4 @@
+
+# Makefile for the Philips STB810 Board.
+
+lib-y := prom_init.o board_setup.o irqmap.o
Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/board_setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips.git/arch/mips/philips/pnx8550/stb810/board_setup.c	2006-12-07 18:21:04.000000000 +0300
@@ -0,0 +1,56 @@
+/*
+ *  STB810 specific board startup routines.
+ *
+ *  Based on the arch/mips/philips/pnx8550/jbs/board_setup.c
+ *
+ *  Author: MontaVista Software, Inc.
+ *          source@mvista.com
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <linux/mc146818rtc.h>
+#include <linux/delay.h>
+
+#include <asm/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/reboot.h>
+#include <asm/pgtable.h>
+
+#include <glb.h>
+
+/* CP0 hazard avoidance. */
+#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
+				     "nop; nop; nop; nop; nop; nop;\n\t" \
+				     ".set reorder\n\t")
+
+void __init board_setup(void)
+{
+	unsigned long config0, configpr;
+
+	config0 = read_c0_config();
+
+	/* clear all three cache coherency fields */
+	config0 &= ~(0x7 | (7<<25) | (7<<28));
+	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
+			(CONF_CM_DEFAULT<<28));
+	write_c0_config(config0);
+	BARRIER;
+
+	configpr = read_c0_config7();
+	configpr |= (1<<19); /* enable tlb */
+	write_c0_config7(configpr);
+	BARRIER;
+}
Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/irqmap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips.git/arch/mips/philips/pnx8550/stb810/irqmap.c	2006-12-07 18:21:04.000000000 +0300
@@ -0,0 +1,23 @@
+/*
+ *  Philips STB810 board irqmap.
+ *
+ *  Author: MontaVista Software, Inc.
+ *          source@mvista.com
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <int.h>
+
+char irq_tab_jbs[][5] __initdata = {
+ [8] =  { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+ [9] =  { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+ [10] = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
+};
+
Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/prom_init.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips.git/arch/mips/philips/pnx8550/stb810/prom_init.c	2006-12-07 18:21:04.000000000 +0300
@@ -0,0 +1,49 @@
+/*
+ *  STB810 specific prom routines
+ *
+ *  Author: MontaVista Software, Inc.
+ *          source@mvista.com
+ *
+ *  Copyright 2005 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+int prom_argc;
+char **prom_argv, **prom_envp;
+extern void  __init prom_init_cmdline(void);
+extern char *prom_getenv(char *envname);
+
+const char *get_system_type(void)
+{
+	return "Philips PNX8550/STB810";
+}
+
+void __init prom_init(void)
+{
+
+	unsigned long memsize;
+	prom_argc = (int) fw_arg0;
+	prom_argv = (char **) fw_arg1;
+	prom_envp = (char **) fw_arg2;
+
+	prom_init_cmdline();
+
+	mips_machgroup = MACH_GROUP_PHILIPS;
+	mips_machtype = MACH_PHILIPS_STB810;
+
+	memsize = 0x08000000; /* Trimedia uses memory above */
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
Index: linux-mips.git/include/asm-mips/bootinfo.h
===================================================================
--- linux-mips.git.orig/include/asm-mips/bootinfo.h	2006-12-07 18:20:47.000000000 +0300
+++ linux-mips.git/include/asm-mips/bootinfo.h	2006-12-07 18:21:04.000000000 +0300
@@ -131,6 +131,7 @@
 #define  MACH_PHILIPS_NINO	0	/* Nino */
 #define  MACH_PHILIPS_VELO	1	/* Velo */
 #define  MACH_PHILIPS_JBS	2	/* JBS */
+#define  MACH_PHILIPS_STB810	3	/* STB810 */
 
 /*
  * Valid machtype for group SIBYTE
Index: linux-mips.git/arch/mips/philips/pnx8550/common/prom.c
===================================================================
--- linux-mips.git.orig/arch/mips/philips/pnx8550/common/prom.c	2006-12-07 18:20:47.000000000 +0300
+++ linux-mips.git/arch/mips/philips/pnx8550/common/prom.c	2006-12-07 18:21:04.000000000 +0300
@@ -35,23 +35,15 @@
 	return &(arcs_cmdline[0]);
 }
 
-void  prom_init_cmdline(void)
+void __init prom_init_cmdline(void)
 {
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
+	int i;
 
-	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
+	arcs_cmdline[0] = '\0';
+	for (i = 0; i < prom_argc; i++) {
+		strcat(arcs_cmdline, prom_argv[i]);
+		strcat(arcs_cmdline, " ");
 	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
 }
 
 char *prom_getenv(char *envname)
Index: linux-mips.git/arch/mips/kernel/head.S
===================================================================
--- linux-mips.git.orig/arch/mips/kernel/head.S	2006-12-07 18:20:47.000000000 +0300
+++ linux-mips.git/arch/mips/kernel/head.S	2006-12-07 18:21:04.000000000 +0300
@@ -138,7 +138,7 @@
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
 
-#if defined(CONFIG_QEMU) || defined(CONFIG_MIPS_SIM)
+#if defined(CONFIG_QEMU) || defined(CONFIG_MIPS_SIM) || defined(CONFIG_PNX8550_STB810)
 	/*
 	 * Give us a fighting chance of running if execution beings at the
 	 * kernel load address.  This is needed because this platform does
Index: linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig	2006-12-07 18:21:04.000000000 +0300
@@ -0,0 +1,1777 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.19-rc5
+# Wed Nov  8 13:46:57 2006
+#
+CONFIG_ARM=y
+# CONFIG_GENERIC_TIME is not set
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_UID16=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+CONFIG_BLOCK=y
+# CONFIG_BLK_DEV_IO_TRACE is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# System Type
+#
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_CLPS7500 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CO285 is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_L7200 is not set
+CONFIG_ARCH_PNX4008=y
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_OMAP is not set
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=y
+CONFIG_CPU_ARM926T=y
+CONFIG_CPU_32v5=y
+CONFIG_CPU_ABRT_EV5TJ=y
+CONFIG_CPU_CACHE_VIVT=y
+CONFIG_CPU_COPY_V4WB=y
+CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
+
+#
+# Processor Features
+#
+CONFIG_ARM_THUMB=y
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
+# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+
+#
+# Bus support
+#
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+CONFIG_PREEMPT=y
+# CONFIG_NO_IDLE_HZ is not set
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ALIGNMENT_TRAP=y
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="mem=64M console=ttyS0,115200 ip=dhcp"
+# CONFIG_XIP_KERNEL is not set
+
+#
+# Floating point emulation
+#
+
+#
+# At least one emulation must be selected
+#
+CONFIG_FPE_NWFPE=y
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+# CONFIG_VFP is not set
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_AOUT=m
+CONFIG_BINFMT_MISC=m
+# CONFIG_ARTHUR is not set
+
+#
+# Power management options
+#
+CONFIG_PM=y
+CONFIG_PM_LEGACY=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_APM is not set
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_FWMARK=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+CONFIG_NET_IPIP=y
+# CONFIG_NET_IPGRE is not set
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
+CONFIG_INET_IPCOMP=m
+CONFIG_INET_XFRM_TUNNEL=m
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+
+#
+# IP: Virtual Server Configuration
+#
+CONFIG_IP_VS=m
+# CONFIG_IP_VS_DEBUG is not set
+CONFIG_IP_VS_TAB_BITS=12
+
+#
+# IPVS transport protocol load balancing support
+#
+CONFIG_IP_VS_PROTO_TCP=y
+CONFIG_IP_VS_PROTO_UDP=y
+CONFIG_IP_VS_PROTO_ESP=y
+CONFIG_IP_VS_PROTO_AH=y
+
+#
+# IPVS scheduler
+#
+CONFIG_IP_VS_RR=m
+CONFIG_IP_VS_WRR=m
+CONFIG_IP_VS_LC=m
+CONFIG_IP_VS_WLC=m
+CONFIG_IP_VS_LBLC=m
+CONFIG_IP_VS_LBLCR=m
+CONFIG_IP_VS_DH=m
+CONFIG_IP_VS_SH=m
+CONFIG_IP_VS_SED=m
+CONFIG_IP_VS_NQ=m
+
+#
+# IPVS application helper
+#
+CONFIG_IP_VS_FTP=m
+CONFIG_IPV6=m
+CONFIG_IPV6_PRIVACY=y
+# CONFIG_IPV6_ROUTER_PREF is not set
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+# CONFIG_IPV6_MIP6 is not set
+CONFIG_INET6_XFRM_TUNNEL=m
+CONFIG_INET6_TUNNEL=m
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_XFRM_MODE_TUNNEL=m
+CONFIG_INET6_XFRM_MODE_BEET=m
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=m
+CONFIG_IPV6_TUNNEL=m
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_NETLABEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+CONFIG_BRIDGE_NETFILTER=y
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_NETFILTER_XTABLES is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=m
+CONFIG_IP_NF_CT_ACCT=y
+CONFIG_IP_NF_CONNTRACK_MARK=y
+# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
+CONFIG_IP_NF_CT_PROTO_SCTP=m
+CONFIG_IP_NF_FTP=m
+CONFIG_IP_NF_IRC=m
+# CONFIG_IP_NF_NETBIOS_NS is not set
+CONFIG_IP_NF_TFTP=m
+CONFIG_IP_NF_AMANDA=m
+# CONFIG_IP_NF_PPTP is not set
+# CONFIG_IP_NF_H323 is not set
+# CONFIG_IP_NF_SIP is not set
+CONFIG_IP_NF_QUEUE=m
+
+#
+# IPv6: Netfilter Configuration (EXPERIMENTAL)
+#
+CONFIG_IP6_NF_QUEUE=m
+
+#
+# DECnet: Netfilter Configuration
+#
+CONFIG_DECNET_NF_GRABULATOR=m
+
+#
+# Bridge: Netfilter Configuration
+#
+CONFIG_BRIDGE_NF_EBTABLES=m
+CONFIG_BRIDGE_EBT_BROUTE=m
+CONFIG_BRIDGE_EBT_T_FILTER=m
+CONFIG_BRIDGE_EBT_T_NAT=m
+CONFIG_BRIDGE_EBT_802_3=m
+CONFIG_BRIDGE_EBT_AMONG=m
+CONFIG_BRIDGE_EBT_ARP=m
+CONFIG_BRIDGE_EBT_IP=m
+CONFIG_BRIDGE_EBT_LIMIT=m
+CONFIG_BRIDGE_EBT_MARK=m
+CONFIG_BRIDGE_EBT_PKTTYPE=m
+CONFIG_BRIDGE_EBT_STP=m
+CONFIG_BRIDGE_EBT_VLAN=m
+CONFIG_BRIDGE_EBT_ARPREPLY=m
+CONFIG_BRIDGE_EBT_DNAT=m
+CONFIG_BRIDGE_EBT_MARK_T=m
+CONFIG_BRIDGE_EBT_REDIRECT=m
+CONFIG_BRIDGE_EBT_SNAT=m
+CONFIG_BRIDGE_EBT_LOG=m
+# CONFIG_BRIDGE_EBT_ULOG is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IP_SCTP=m
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+CONFIG_ATM=y
+CONFIG_ATM_CLIP=y
+# CONFIG_ATM_CLIP_NO_ICMP is not set
+CONFIG_ATM_LANE=m
+CONFIG_ATM_MPOA=m
+CONFIG_ATM_BR2684=m
+# CONFIG_ATM_BR2684_IPFILTER is not set
+CONFIG_BRIDGE=m
+CONFIG_VLAN_8021Q=m
+CONFIG_DECNET=m
+# CONFIG_DECNET_ROUTER is not set
+CONFIG_LLC=m
+CONFIG_LLC2=m
+CONFIG_IPX=m
+# CONFIG_IPX_INTERN is not set
+CONFIG_ATALK=m
+CONFIG_DEV_APPLETALK=m
+CONFIG_IPDDP=m
+CONFIG_IPDDP_ENCAP=y
+CONFIG_IPDDP_DECAP=y
+CONFIG_X25=m
+CONFIG_LAPB=m
+CONFIG_ECONET=m
+CONFIG_ECONET_AUNUDP=y
+CONFIG_ECONET_NATIVE=y
+CONFIG_WAN_ROUTER=m
+
+#
+# QoS and/or fair queueing
+#
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CLK_JIFFIES=y
+# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
+# CONFIG_NET_SCH_CLK_CPU is not set
+
+#
+# Queueing/Scheduling
+#
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_HFSC=m
+CONFIG_NET_SCH_ATM=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NET_SCH_INGRESS=m
+
+#
+# Classification
+#
+CONFIG_NET_CLS=y
+# CONFIG_NET_CLS_BASIC is not set
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_ROUTE=y
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+# CONFIG_CLS_U32_PERF is not set
+# CONFIG_CLS_U32_MARK is not set
+CONFIG_NET_CLS_RSVP=m
+CONFIG_NET_CLS_RSVP6=m
+# CONFIG_NET_EMATCH is not set
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_CLS_POLICE=y
+# CONFIG_NET_CLS_IND is not set
+CONFIG_NET_ESTIMATOR=y
+
+#
+# Network testing
+#
+CONFIG_NET_PKTGEN=m
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_IEEE80211=m
+# CONFIG_IEEE80211_DEBUG is not set
+# CONFIG_IEEE80211_CRYPT_WEP is not set
+CONFIG_IEEE80211_CRYPT_CCMP=m
+CONFIG_IEEE80211_CRYPT_TKIP=m
+# CONFIG_IEEE80211_SOFTMAC is not set
+CONFIG_WIRELESS_EXT=y
+CONFIG_FIB_RULES=y
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
+# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
+# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AFS_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
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
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_DATAFLASH is not set
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SLRAM=m
+CONFIG_MTD_PHRAM=m
+CONFIG_MTD_MTDRAM=m
+CONFIG_MTDRAM_TOTAL_SIZE=4096
+CONFIG_MTDRAM_ERASE_SIZE=128
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+CONFIG_MTD_DOC2000=m
+CONFIG_MTD_DOC2001=m
+CONFIG_MTD_DOC2001PLUS=m
+CONFIG_MTD_DOCPROBE=m
+CONFIG_MTD_DOCECC=m
+# CONFIG_MTD_DOCPROBE_ADVANCED is not set
+CONFIG_MTD_DOCPROBE_ADDRESS=0
+
+#
+# NAND Flash Device Drivers
+#
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+CONFIG_MTD_NAND_PNX4008=y
+CONFIG_MTD_NAND_PNX4008_DMA=y
+CONFIG_MTD_NAND_PNX4008_HWECC=y
+CONFIG_MTD_NAND_NANDSIM=y
+
+#
+# OneNAND Flash Device Drivers
+#
+# CONFIG_MTD_ONENAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+CONFIG_BLK_DEV_NBD=y
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CDROM_PKTCDVD=m
+CONFIG_CDROM_PKTCDVD_BUFFERS=8
+# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=m
+CONFIG_SCSI_NETLINK=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+CONFIG_CHR_DEV_ST=m
+CONFIG_CHR_DEV_OSST=m
+CONFIG_BLK_DEV_SR=m
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=m
+CONFIG_CHR_DEV_SCH=m
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+
+#
+# SCSI Transports
+#
+CONFIG_SCSI_SPI_ATTRS=m
+CONFIG_SCSI_FC_ATTRS=m
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_ISCSI_TCP is not set
+CONFIG_SCSI_DEBUG=m
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+CONFIG_BONDING=m
+CONFIG_EQUALIZER=m
+CONFIG_TUN=m
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+CONFIG_NET_RADIO=y
+# CONFIG_NET_WIRELESS_RTNETLINK is not set
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+CONFIG_STRIP=m
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_HOSTAP is not set
+
+#
+# Wan interfaces
+#
+CONFIG_WAN=y
+CONFIG_HDLC=m
+# CONFIG_HDLC_RAW is not set
+# CONFIG_HDLC_RAW_ETH is not set
+# CONFIG_HDLC_CISCO is not set
+# CONFIG_HDLC_FR is not set
+# CONFIG_HDLC_PPP is not set
+# CONFIG_HDLC_X25 is not set
+CONFIG_DLCI=m
+CONFIG_DLCI_COUNT=24
+CONFIG_DLCI_MAX=8
+CONFIG_WAN_ROUTER_DRIVERS=y
+CONFIG_LAPBETHER=m
+CONFIG_X25_ASY=m
+
+#
+# ATM drivers
+#
+# CONFIG_ATM_DUMMY is not set
+CONFIG_ATM_TCP=m
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_MPPE=m
+CONFIG_PPPOE=m
+CONFIG_PPPOATM=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLHC=m
+CONFIG_SLIP_SMART=y
+CONFIG_SLIP_MODE_SLIP6=y
+CONFIG_SHAPER=m
+CONFIG_NETCONSOLE=m
+CONFIG_NETPOLL=y
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
+CONFIG_NET_POLL_CONTROLLER=y
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_JOYDEV=m
+CONFIG_INPUT_TSDEV=m
+CONFIG_INPUT_TSDEV_SCREEN_X=240
+CONFIG_INPUT_TSDEV_SCREEN_Y=320
+CONFIG_INPUT_EVDEV=m
+CONFIG_INPUT_EVBUG=m
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+CONFIG_KEYBOARD_SUNKBD=m
+CONFIG_KEYBOARD_LKKBD=m
+CONFIG_KEYBOARD_XTKBD=m
+CONFIG_KEYBOARD_NEWTON=m
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=m
+CONFIG_MOUSE_SERIAL=m
+CONFIG_MOUSE_VSXXXAA=m
+CONFIG_INPUT_JOYSTICK=y
+CONFIG_JOYSTICK_ANALOG=m
+CONFIG_JOYSTICK_A3D=m
+CONFIG_JOYSTICK_ADI=m
+CONFIG_JOYSTICK_COBRA=m
+CONFIG_JOYSTICK_GF2K=m
+CONFIG_JOYSTICK_GRIP=m
+CONFIG_JOYSTICK_GRIP_MP=m
+CONFIG_JOYSTICK_GUILLEMOT=m
+CONFIG_JOYSTICK_INTERACT=m
+CONFIG_JOYSTICK_SIDEWINDER=m
+CONFIG_JOYSTICK_TMDC=m
+CONFIG_JOYSTICK_IFORCE=m
+CONFIG_JOYSTICK_IFORCE_USB=y
+CONFIG_JOYSTICK_IFORCE_232=y
+CONFIG_JOYSTICK_WARRIOR=m
+CONFIG_JOYSTICK_MAGELLAN=m
+CONFIG_JOYSTICK_SPACEORB=m
+CONFIG_JOYSTICK_SPACEBALL=m
+CONFIG_JOYSTICK_STINGER=m
+# CONFIG_JOYSTICK_TWIDJOY is not set
+CONFIG_JOYSTICK_JOYDUMP=m
+CONFIG_INPUT_TOUCHSCREEN=y
+# CONFIG_TOUCHSCREEN_ADS7846 is not set
+CONFIG_TOUCHSCREEN_GUNZE=m
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=m
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_SERPORT=m
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIO_RAW=m
+CONFIG_GAMEPORT=m
+CONFIG_GAMEPORT_NS558=m
+CONFIG_GAMEPORT_L4=m
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+CONFIG_SERIAL_8250_RSA=y
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+CONFIG_SOFT_WATCHDOG=m
+CONFIG_PNX4008_WATCHDOG=y
+
+#
+# USB-based Watchdog Cards
+#
+CONFIG_USBPCWATCHDOG=m
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=m
+CONFIG_I2C_ALGOPCF=m
+CONFIG_I2C_ALGOPCA=m
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_PCA_ISA is not set
+CONFIG_I2C_PNX=y
+CONFIG_I2C_PNX_EARLY=y
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+CONFIG_SENSORS_EEPROM=m
+CONFIG_SENSORS_PCF8574=m
+# CONFIG_SENSORS_PCA9539 is not set
+CONFIG_SENSORS_PCF8591=m
+# CONFIG_SENSORS_MAX6875 is not set
+CONFIG_I2C_DEBUG_CORE=y
+CONFIG_I2C_DEBUG_ALGO=y
+CONFIG_I2C_DEBUG_BUS=y
+CONFIG_I2C_DEBUG_CHIP=y
+
+#
+# SPI support
+#
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_PNX=y
+
+#
+# SPI Protocol Masters
+#
+CONFIG_SPI_EEPROM=y
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Misc devices
+#
+# CONFIG_TIFM_CORE is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+CONFIG_DVB=y
+CONFIG_DVB_CORE=m
+# CONFIG_DVB_CORE_ATTACH is not set
+
+#
+# Supported USB Adapters
+#
+# CONFIG_DVB_USB is not set
+CONFIG_DVB_TTUSB_BUDGET=m
+CONFIG_DVB_TTUSB_DEC=m
+CONFIG_DVB_CINERGYT2=m
+CONFIG_DVB_CINERGYT2_TUNING=y
+CONFIG_DVB_CINERGYT2_STREAM_URB_COUNT=32
+CONFIG_DVB_CINERGYT2_STREAM_BUF_SIZE=512
+CONFIG_DVB_CINERGYT2_QUERY_INTERVAL=250
+CONFIG_DVB_CINERGYT2_ENABLE_RC_INPUT_DEVICE=y
+CONFIG_DVB_CINERGYT2_RC_QUERY_INTERVAL=100
+
+#
+# Supported FlexCopII (B2C2) Adapters
+#
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
+CONFIG_DVB_STV0299=m
+CONFIG_DVB_CX24110=m
+# CONFIG_DVB_CX24123 is not set
+CONFIG_DVB_TDA8083=m
+CONFIG_DVB_MT312=m
+CONFIG_DVB_VES1X93=m
+# CONFIG_DVB_S5H1420 is not set
+# CONFIG_DVB_TDA10086 is not set
+
+#
+# DVB-T (terrestrial) frontends
+#
+CONFIG_DVB_SP8870=m
+CONFIG_DVB_SP887X=m
+CONFIG_DVB_CX22700=m
+CONFIG_DVB_CX22702=m
+CONFIG_DVB_L64781=m
+CONFIG_DVB_TDA1004X=m
+CONFIG_DVB_NXT6000=m
+CONFIG_DVB_MT352=m
+# CONFIG_DVB_ZL10353 is not set
+CONFIG_DVB_DIB3000MB=m
+CONFIG_DVB_DIB3000MC=m
+
+#
+# DVB-C (cable) frontends
+#
+CONFIG_DVB_VES1820=m
+CONFIG_DVB_TDA10021=m
+CONFIG_DVB_STV0297=m
+
+#
+# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
+#
+# CONFIG_DVB_NXT200X is not set
+# CONFIG_DVB_OR51211 is not set
+# CONFIG_DVB_OR51132 is not set
+# CONFIG_DVB_BCM3510 is not set
+# CONFIG_DVB_LGDT330X is not set
+
+#
+# Tuners/PLL support
+#
+CONFIG_DVB_PLL=m
+# CONFIG_DVB_TDA826X is not set
+# CONFIG_DVB_TUNER_MT2060 is not set
+
+#
+# Miscellaneous devices
+#
+CONFIG_DVB_LNBP21=m
+# CONFIG_DVB_ISL6421 is not set
+# CONFIG_DVB_TUA6100 is not set
+# CONFIG_USB_DABUSB is not set
+
+#
+# Graphics support
+#
+CONFIG_FIRMWARE_EDID=y
+CONFIG_FB=y
+# CONFIG_FB_DDC is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_PNX4008_DUM=y
+CONFIG_FB_PNX4008_DUM_RGB=y
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+# CONFIG_FONT_8x16 is not set
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
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
+CONFIG_SND_HWDEP=m
+CONFIG_SND_RAWMIDI=m
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=m
+CONFIG_SND_PCM_OSS=m
+CONFIG_SND_PCM_OSS_PLUGINS=y
+CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+CONFIG_SND_MPU401_UART=m
+CONFIG_SND_DUMMY=m
+CONFIG_SND_VIRMIDI=m
+CONFIG_SND_MTPAV=m
+CONFIG_SND_SERIAL_U16550=m
+CONFIG_SND_MPU401=m
+
+#
+# ALSA ARM devices
+#
+
+#
+# USB devices
+#
+CONFIG_SND_USB_AUDIO=m
+
+#
+# Open Sound System
+#
+CONFIG_SOUND_PRIME=m
+# CONFIG_OSS_OBSOLETE_DRIVER is not set
+# CONFIG_SOUND_MSNDCLAS is not set
+# CONFIG_SOUND_MSNDPIN is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_BANDWIDTH=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB_SL811_HCD=m
+
+#
+# USB Device Class drivers
+#
+CONFIG_USB_ACM=m
+CONFIG_USB_PRINTER=m
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+CONFIG_USB_STORAGE_DATAFAB=y
+CONFIG_USB_STORAGE_FREECOM=y
+CONFIG_USB_STORAGE_DPCM=y
+CONFIG_USB_STORAGE_USBAT=y
+CONFIG_USB_STORAGE_SDDR09=y
+CONFIG_USB_STORAGE_SDDR55=y
+CONFIG_USB_STORAGE_JUMPSHOT=y
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=m
+CONFIG_USB_HIDINPUT=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+CONFIG_USB_HIDDEV=y
+
+#
+# USB HID Boot Protocol drivers
+#
+CONFIG_USB_KBD=m
+CONFIG_USB_MOUSE=m
+CONFIG_USB_AIPTEK=m
+CONFIG_USB_WACOM=m
+# CONFIG_USB_ACECAD is not set
+CONFIG_USB_KBTAB=m
+CONFIG_USB_POWERMATE=m
+# CONFIG_USB_TOUCHSCREEN is not set
+# CONFIG_USB_YEALINK is not set
+CONFIG_USB_XPAD=m
+CONFIG_USB_ATI_REMOTE=m
+# CONFIG_USB_ATI_REMOTE2 is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+CONFIG_USB_MDC800=m
+CONFIG_USB_MICROTEK=m
+
+#
+# USB Network Adapters
+#
+CONFIG_USB_CATC=y
+CONFIG_USB_KAWETH=y
+CONFIG_USB_PEGASUS=y
+CONFIG_USB_RTL8150=y
+CONFIG_USB_USBNET_MII=m
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_AX8817X=m
+CONFIG_USB_NET_CDCETHER=m
+# CONFIG_USB_NET_GL620A is not set
+CONFIG_USB_NET_NET1080=m
+# CONFIG_USB_NET_PLUSB is not set
+# CONFIG_USB_NET_MCS7830 is not set
+# CONFIG_USB_NET_RNDIS_HOST is not set
+# CONFIG_USB_NET_CDC_SUBSET is not set
+CONFIG_USB_NET_ZAURUS=m
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+# CONFIG_USB_SERIAL_AIRCABLE is not set
+# CONFIG_USB_SERIAL_AIRPRIME is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
+CONFIG_USB_SERIAL_BELKIN=m
+CONFIG_USB_SERIAL_WHITEHEAT=m
+CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
+# CONFIG_USB_SERIAL_CP2101 is not set
+CONFIG_USB_SERIAL_CYPRESS_M8=m
+CONFIG_USB_SERIAL_EMPEG=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+# CONFIG_USB_SERIAL_FUNSOFT is not set
+CONFIG_USB_SERIAL_VISOR=m
+CONFIG_USB_SERIAL_IPAQ=m
+CONFIG_USB_SERIAL_IR=m
+CONFIG_USB_SERIAL_EDGEPORT=m
+CONFIG_USB_SERIAL_EDGEPORT_TI=m
+# CONFIG_USB_SERIAL_GARMIN is not set
+CONFIG_USB_SERIAL_IPW=m
+CONFIG_USB_SERIAL_KEYSPAN_PDA=m
+CONFIG_USB_SERIAL_KEYSPAN=m
+# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
+# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
+CONFIG_USB_SERIAL_KLSI=m
+CONFIG_USB_SERIAL_KOBIL_SCT=m
+CONFIG_USB_SERIAL_MCT_U232=m
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
+CONFIG_USB_SERIAL_PL2303=m
+# CONFIG_USB_SERIAL_HP4X is not set
+CONFIG_USB_SERIAL_SAFE=m
+# CONFIG_USB_SERIAL_SAFE_PADDED is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
+# CONFIG_USB_SERIAL_TI is not set
+CONFIG_USB_SERIAL_CYBERJACK=m
+CONFIG_USB_SERIAL_XIRCOM=m
+# CONFIG_USB_SERIAL_OPTION is not set
+CONFIG_USB_SERIAL_OMNINET=m
+CONFIG_USB_EZUSB=y
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+CONFIG_USB_AUERSWALD=m
+CONFIG_USB_RIO500=m
+CONFIG_USB_LEGOTOWER=m
+CONFIG_USB_LCD=m
+CONFIG_USB_LED=m
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+CONFIG_USB_CYTHERM=m
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+CONFIG_USB_TEST=m
+
+#
+# USB DSL modem support
+#
+CONFIG_USB_ATM=m
+CONFIG_USB_SPEEDTOUCH=m
+# CONFIG_USB_CXACRU is not set
+# CONFIG_USB_UEAGLEATM is not set
+# CONFIG_USB_XUSBATM is not set
+
+#
+# USB Gadget Support
+#
+CONFIG_USB_GADGET=m
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_AT91 is not set
+CONFIG_USB_GADGET_DUMMY_HCD=y
+CONFIG_USB_DUMMY_HCD=m
+CONFIG_USB_GADGET_DUALSPEED=y
+CONFIG_USB_ZERO=m
+CONFIG_USB_ETH=m
+CONFIG_USB_ETH_RNDIS=y
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FILE_STORAGE=m
+# CONFIG_USB_FILE_STORAGE_TEST is not set
+CONFIG_USB_G_SERIAL=m
+# CONFIG_USB_MIDI_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+CONFIG_MMC=m
+# CONFIG_MMC_DEBUG is not set
+CONFIG_MMC_BLOCK=m
+# CONFIG_MMC_TIFM_SD is not set
+
+#
+# Real Time Clock
+#
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=m
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+CONFIG_REISERFS_FS_XATTR=y
+CONFIG_REISERFS_FS_POSIX_ACL=y
+CONFIG_REISERFS_FS_SECURITY=y
+CONFIG_JFS_FS=m
+CONFIG_JFS_POSIX_ACL=y
+# CONFIG_JFS_SECURITY is not set
+# CONFIG_JFS_DEBUG is not set
+CONFIG_JFS_STATISTICS=y
+CONFIG_FS_POSIX_ACL=y
+CONFIG_XFS_FS=m
+CONFIG_XFS_QUOTA=y
+CONFIG_XFS_SECURITY=y
+CONFIG_XFS_POSIX_ACL=y
+CONFIG_XFS_RT=y
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+CONFIG_MINIX_FS=m
+CONFIG_ROMFS_FS=m
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_QUOTA=y
+CONFIG_QFMT_V1=m
+CONFIG_QFMT_V2=m
+CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
+CONFIG_AUTOFS_FS=m
+CONFIG_AUTOFS4_FS=m
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_ZISOFS_FS=m
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_NTFS_FS=m
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+CONFIG_ADFS_FS=m
+# CONFIG_ADFS_FS_RW is not set
+CONFIG_AFFS_FS=m
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+CONFIG_BEFS_FS=m
+# CONFIG_BEFS_DEBUG is not set
+CONFIG_BFS_FS=m
+CONFIG_EFS_FS=m
+CONFIG_JFFS_FS=m
+CONFIG_JFFS_FS_VERBOSE=0
+CONFIG_JFFS_PROC_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+# CONFIG_JFFS2_ZLIB is not set
+# CONFIG_JFFS2_RTIME is not set
+# CONFIG_JFFS2_RUBIN is not set
+CONFIG_JFFS2_CMODE_NONE=y
+# CONFIG_JFFS2_CMODE_PRIORITY is not set
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_YAFFS_FS is not set
+CONFIG_CRAMFS=y
+CONFIG_VXFS_FS=m
+CONFIG_HPFS_FS=m
+CONFIG_QNX4FS_FS=m
+CONFIG_SYSV_FS=m
+CONFIG_UFS_FS=m
+# CONFIG_UFS_FS_WRITE is not set
+# CONFIG_UFS_DEBUG is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
+CONFIG_NFS_DIRECTIO=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+CONFIG_NFSD_V4=y
+CONFIG_NFSD_TCP=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+CONFIG_RPCSEC_GSS_SPKM3=m
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+CONFIG_CIFS=m
+# CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
+# CONFIG_CIFS_XATTR is not set
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_EXPERIMENTAL is not set
+CONFIG_NCP_FS=m
+CONFIG_NCPFS_PACKET_SIGNING=y
+CONFIG_NCPFS_IOCTL_LOCKING=y
+CONFIG_NCPFS_STRONG=y
+CONFIG_NCPFS_NFS_NS=y
+CONFIG_NCPFS_OS2_NS=y
+# CONFIG_NCPFS_SMALLDOS is not set
+CONFIG_NCPFS_NLS=y
+CONFIG_NCPFS_EXTRAS=y
+CONFIG_CODA_FS=m
+# CONFIG_CODA_FS_OLD_API is not set
+CONFIG_AFS_FS=m
+CONFIG_RXRPC=m
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ACORN_PARTITION=y
+# CONFIG_ACORN_PARTITION_CUMANA is not set
+# CONFIG_ACORN_PARTITION_EESOX is not set
+CONFIG_ACORN_PARTITION_ICS=y
+# CONFIG_ACORN_PARTITION_ADFS is not set
+# CONFIG_ACORN_PARTITION_POWERTEC is not set
+CONFIG_ACORN_PARTITION_RISCIX=y
+CONFIG_OSF_PARTITION=y
+CONFIG_AMIGA_PARTITION=y
+CONFIG_ATARI_PARTITION=y
+CONFIG_MAC_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_UNIXWARE_DISKLABEL=y
+CONFIG_LDM_PARTITION=y
+# CONFIG_LDM_DEBUG is not set
+CONFIG_SGI_PARTITION=y
+CONFIG_ULTRIX_PARTITION=y
+CONFIG_SUN_PARTITION=y
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=m
+CONFIG_NLS_DEFAULT="cp437"
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_CODEPAGE_737=m
+CONFIG_NLS_CODEPAGE_775=m
+CONFIG_NLS_CODEPAGE_850=m
+CONFIG_NLS_CODEPAGE_852=m
+CONFIG_NLS_CODEPAGE_855=m
+CONFIG_NLS_CODEPAGE_857=m
+CONFIG_NLS_CODEPAGE_860=m
+CONFIG_NLS_CODEPAGE_861=m
+CONFIG_NLS_CODEPAGE_862=m
+CONFIG_NLS_CODEPAGE_863=m
+CONFIG_NLS_CODEPAGE_864=m
+CONFIG_NLS_CODEPAGE_865=m
+CONFIG_NLS_CODEPAGE_866=m
+CONFIG_NLS_CODEPAGE_869=m
+CONFIG_NLS_CODEPAGE_936=m
+CONFIG_NLS_CODEPAGE_950=m
+CONFIG_NLS_CODEPAGE_932=m
+CONFIG_NLS_CODEPAGE_949=m
+CONFIG_NLS_CODEPAGE_874=m
+CONFIG_NLS_ISO8859_8=m
+CONFIG_NLS_CODEPAGE_1250=m
+CONFIG_NLS_CODEPAGE_1251=m
+CONFIG_NLS_ASCII=m
+CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_ISO8859_2=m
+CONFIG_NLS_ISO8859_3=m
+CONFIG_NLS_ISO8859_4=m
+CONFIG_NLS_ISO8859_5=m
+CONFIG_NLS_ISO8859_6=m
+CONFIG_NLS_ISO8859_7=m
+CONFIG_NLS_ISO8859_9=m
+CONFIG_NLS_ISO8859_13=m
+CONFIG_NLS_ISO8859_14=m
+CONFIG_NLS_ISO8859_15=m
+CONFIG_NLS_KOI8_R=m
+CONFIG_NLS_KOI8_U=m
+CONFIG_NLS_UTF8=m
+
+#
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+CONFIG_FRAME_POINTER=y
+CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUG_USER is not set
+# CONFIG_DEBUG_WAITQ is not set
+# CONFIG_DEBUG_ERRORS is not set
+CONFIG_DEBUG_LL=y
+# CONFIG_DEBUG_ICEDCC is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+CONFIG_SECURITY=y
+# CONFIG_SECURITY_NETWORK is not set
+CONFIG_SECURITY_CAPABILITIES=m
+CONFIG_SECURITY_ROOTPLUG=m
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_NULL=m
+CONFIG_CRYPTO_MD4=m
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=m
+CONFIG_CRYPTO_SHA256=m
+CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_WP512=m
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_BLOWFISH=m
+CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
+CONFIG_CRYPTO_SERPENT=m
+CONFIG_CRYPTO_AES=m
+CONFIG_CRYPTO_CAST5=m
+CONFIG_CRYPTO_CAST6=m
+CONFIG_CRYPTO_TEA=m
+CONFIG_CRYPTO_ARC4=m
+CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_DEFLATE=m
+CONFIG_CRYPTO_MICHAEL_MIC=m
+CONFIG_CRYPTO_CRC32C=m
+CONFIG_CRYPTO_TEST=m
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+CONFIG_CRC16=m
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=m
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=m
+CONFIG_TEXTSEARCH=y
+CONFIG_TEXTSEARCH_KMP=m
+CONFIG_PLIST=y
Index: linux-mips.git/arch/mips/Kconfig
===================================================================
--- linux-mips.git.orig/arch/mips/Kconfig	2006-12-07 18:20:47.000000000 +0300
+++ linux-mips.git/arch/mips/Kconfig	2006-12-07 18:21:04.000000000 +0300
@@ -459,6 +459,11 @@
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
+config PNX8550_STB810
+	bool "Support for Philips PNX8550 based STB810 board"
+	select PNX8550
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
 config DDB5477
 	bool "NEC DDB Vrc-5477"
 	select DDB5XXX_COMMON
Index: linux-mips.git/arch/mips/Makefile
===================================================================
--- linux-mips.git.orig/arch/mips/Makefile	2006-12-07 18:20:47.000000000 +0300
+++ linux-mips.git/arch/mips/Makefile	2006-12-07 18:21:04.000000000 +0300
@@ -463,6 +463,11 @@
 #cflags-$(CONFIG_PNX8550_JBS)	+= -Iinclude/asm-mips/mach-pnx8550
 load-$(CONFIG_PNX8550_JBS)	+= 0xffffffff80060000
 
+# Philips PNX8550 STB810 board
+#
+libs-$(CONFIG_PNX8550_STB810)	+= arch/mips/philips/pnx8550/stb810/
+load-$(CONFIG_PNX8550_STB810)	+= 0xffffffff80060000
+
 # NEC EMMA2RH boards
 #
 core-$(CONFIG_EMMA2RH)          += arch/mips/emma2rh/common/
