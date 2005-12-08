Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2005 17:21:28 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:30024 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133969AbVLHRU7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Dec 2005 17:20:59 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB8HKft27987;
	Thu, 8 Dec 2005 21:20:41 +0400
Message-ID: <43986B68.4000309@ru.mvista.com>
Date:	Thu, 08 Dec 2005 20:20:40 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Peter Popov <ppopov@embeddedalley.com>, ralf@linux-mips.org
CC:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips PNX8550
References: <20051207191100.20648.qmail@web410.biz.mail.mud.yahoo.com> <43973A84.3090306@ru.mvista.com>
In-Reply-To: <43973A84.3090306@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090706010406070506020107"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090706010406070506020107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Pete, Ralf,

This patch adds support for STB810 board based on Philips PNX8550 processor.

1) added arch/mips/philips/pnx8550/stb810/* files based on the 
arch/mips/philips/pnx8550/jbs/*
2) modified Kconfig and Makefile in arch/mips/
3) added new board ID in bootinfo.h to identify STB810 board
4) added pnx8550-stb810_defconfig

5) STB810 platform has a special bootloader "PNX8550 bootlader" that 
does not have ELF loader,
so it's needed to point to the kernel_entry. (modified 
arch_mips/kernel/head.S)

6) arch/mips/philips/pnx8550/common/platform.c - compile fix
7) arch/mips/philips/pnx8550/common/prom.c - fix for proper parsing 
bootloader command-line.


Pete could you please review?

TIA,
Vladimir

Vladimir A. Barinov wrote:

> Hi Pete,
>
>>  
>>
>>> I used a quite different board (STB810), but it's
>>> based on the same board dependent code as JBS (i.e
>>> arch/mips/philips/pnx8550/jbs). I haven't worked with
>>> JBS board and I'm not sure if slot=10 is needed for
>>> that, but it's really necessary for STB810.
>>>   
>>
>>
>> The JBS has only 3 pci slots and I tested all three.
>> So the fourth one you added won't do any damage but
>> it's not quite right either.
>>  
>>
>>> I also has another question - Could you please
>>> advice: shall I create a different
>>> arch/mips/philips/pnx8550/stb810
>>> and add MACH_PHILIPS_STB810 ID and defconfig
>>> or I can use exiting JBS one?
>>>   
>>
>>
>> Is anything else different that would justify the new
>> directory? If not, perhaps we just need an STB board
>> selection in arch/mips/Kconfig, a defconfig, and an
>> ifdef around that pci slot you sent.
>>  
>>
> The are only 3 small file in the  arch/mips/philips/pnx8550/jbs 
> directory:
> 1)  board_setup.c is the same for STB810
> 2) init.c may be needs cosmetic changes to identify the board:
> "Philips PNX8550/JBS" -> "Philips PNX8550/STB810"
> MACH_PHILIPS_JBS -> MACH_PHILIPS_STB810
>
> I'm not sure are they really needed?
> 3) irq.map needs change to add slot 10 and remove slot 17 for STB810 
> board.
>
> That's all :)
>
>


--------------090706010406070506020107
Content-Type: text/plain;
 name="stb810.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stb810.patch"

 arch/mips/Kconfig                              |    5 
 arch/mips/Makefile                             |    5 
 arch/mips/configs/pnx8550-stb810_defconfig     | 1117 +++++++++++++++++++++++++
 arch/mips/kernel/head.S                        |    2 
 arch/mips/philips/pnx8550/common/platform.c    |    1 
 arch/mips/philips/pnx8550/common/prom.c        |   20 
 arch/mips/philips/pnx8550/stb810/Makefile      |    4 
 arch/mips/philips/pnx8550/stb810/board_setup.c |   56 +
 arch/mips/philips/pnx8550/stb810/irqmap.c      |   23 
 arch/mips/philips/pnx8550/stb810/prom_init.c   |   49 +
 include/asm-mips/bootinfo.h                    |    1 
 11 files changed, 1268 insertions(+), 15 deletions(-)

Index: linux-2.6.15_0/arch/mips/Kconfig
===================================================================
--- linux-2.6.15_0.orig/arch/mips/Kconfig
+++ linux-2.6.15_0/arch/mips/Kconfig
@@ -445,6 +445,11 @@ config PNX8550_JBS
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
+config PNX8550_STB810
+	bool "Support for Philips PNX8550 based STB810 board"
+	select PNX8550
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
 config DDB5074
 	bool "Support for NEC DDB Vrc-5074 (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
Index: linux-2.6.15_0/arch/mips/Makefile
===================================================================
--- linux-2.6.15_0.orig/arch/mips/Makefile
+++ linux-2.6.15_0/arch/mips/Makefile
@@ -583,6 +583,11 @@ libs-$(CONFIG_PNX8550_JBS)	+= arch/mips/
 #cflags-$(CONFIG_PNX8550_JBS)	+= -Iinclude/asm-mips/mach-pnx8550
 load-$(CONFIG_PNX8550_JBS)	+= 0xffffffff80060000
 
+# Philips PNX8550 STB810 board
+#
+libs-$(CONFIG_PNX8550_STB810)	+= arch/mips/philips/pnx8550/stb810/
+load-$(CONFIG_PNX8550_STB810)	+= 0xffffffff80060000
+
 #
 # SGI IP22 (Indy/Indigo2)
 #
Index: linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/Makefile
@@ -0,0 +1,4 @@
+
+# Makefile for the Philips STB810 Board.
+
+lib-y := prom_init.o board_setup.o irqmap.o
Index: linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/board_setup.c
===================================================================
--- /dev/null
+++ linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/board_setup.c
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
Index: linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/irqmap.c
===================================================================
--- /dev/null
+++ linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/irqmap.c
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
Index: linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/prom_init.c
===================================================================
--- /dev/null
+++ linux-2.6.15_0/arch/mips/philips/pnx8550/stb810/prom_init.c
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
Index: linux-2.6.15_0/include/asm-mips/bootinfo.h
===================================================================
--- linux-2.6.15_0.orig/include/asm-mips/bootinfo.h
+++ linux-2.6.15_0/include/asm-mips/bootinfo.h
@@ -138,6 +138,7 @@
 #define  MACH_PHILIPS_NINO	0	/* Nino */
 #define  MACH_PHILIPS_VELO	1	/* Velo */
 #define  MACH_PHILIPS_JBS	2	/* JBS */
+#define  MACH_PHILIPS_STB810	3	/* STB810 */
 
 /*
  * Valid machtype for group Globespan
Index: linux-2.6.15_0/arch/mips/philips/pnx8550/common/platform.c
===================================================================
--- linux-2.6.15_0.orig/arch/mips/philips/pnx8550/common/platform.c
+++ linux-2.6.15_0/arch/mips/philips/pnx8550/common/platform.c
@@ -18,6 +18,7 @@
 #include <linux/resource.h>
 #include <linux/serial.h>
 #include <linux/serial_ip3106.h>
+#include <linux/platform_device.h>
 
 #include <int.h>
 #include <usb.h>
Index: linux-2.6.15_0/arch/mips/philips/pnx8550/common/prom.c
===================================================================
--- linux-2.6.15_0.orig/arch/mips/philips/pnx8550/common/prom.c
+++ linux-2.6.15_0/arch/mips/philips/pnx8550/common/prom.c
@@ -35,23 +35,15 @@ char * prom_getcmdline(void)
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
Index: linux-2.6.15_0/arch/mips/kernel/head.S
===================================================================
--- linux-2.6.15_0.orig/arch/mips/kernel/head.S
+++ linux-2.6.15_0/arch/mips/kernel/head.S
@@ -116,7 +116,7 @@
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
 
-#if defined(CONFIG_QEMU) || defined(CONFIG_MIPS_SIM)
+#if defined(CONFIG_QEMU) || defined(CONFIG_MIPS_SIM) || defined(CONFIG_PNX8550_STB810)
 	/*
 	 * Give us a fighting chance of running if execution beings at the
 	 * kernel load address.  This is needed because this platform does
Index: linux-2.6.15_0/arch/mips/configs/pnx8550-stb810_defconfig
===================================================================
--- /dev/null
+++ linux-2.6.15_0/arch/mips/configs/pnx8550-stb810_defconfig
@@ -0,0 +1,1117 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.15-rc4
+# Thu Dec  8 19:10:40 2005
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MIPS_SIM is not set
+# CONFIG_MOMENCO_JAGUAR_ATX is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_3 is not set
+# CONFIG_MOMENCO_OCELOT_C is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_PNX8550_V2PCI is not set
+# CONFIG_PNX8550_JBS is not set
+CONFIG_PNX8550_STB810=y
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_QEMU is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_BIGSUR is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_PTSWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SNI_RM200_PCI is not set
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+# CONFIG_TOSHIBA_RBTX4938 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_PNX8550=y
+CONFIG_SOC_PNX8550=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
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
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_MIPS32_R1=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR1=y
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
+# CONFIG_MIPS_MT is not set
+# CONFIG_64BIT_PHYS_ADDR is not set
+# CONFIG_CPU_ADVANCED is not set
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
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
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_DEBUG is not set
+CONFIG_MMU=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
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
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
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
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
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
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECD=m
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+CONFIG_BLK_DEV_IDESCSI=y
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+CONFIG_BLK_DEV_OFFBOARD=y
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+CONFIG_BLK_DEV_HPT366=y
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
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
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+CONFIG_SCSI_ISCSI_ATTRS=m
+# CONFIG_SCSI_SAS_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+CONFIG_ISCSI_TCP=m
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA24XX is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
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
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
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
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+CONFIG_NATSEMI=y
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
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
+CONFIG_SERIAL_IP3106=y
+CONFIG_SERIAL_IP3106_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
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
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
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
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+CONFIG_USB_STORAGE_DATAFAB=y
+CONFIG_USB_STORAGE_FREECOM=y
+CONFIG_USB_STORAGE_ISD200=y
+CONFIG_USB_STORAGE_DPCM=y
+CONFIG_USB_STORAGE_USBAT=y
+CONFIG_USB_STORAGE_SDDR09=y
+CONFIG_USB_STORAGE_SDDR55=y
+CONFIG_USB_STORAGE_JUMPSHOT=y
+
+#
+# USB Input Devices
+#
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
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
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETKIT is not set
+# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_LD is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
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
+# CONFIG_PROC_KCORE is not set
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
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
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=m
+# CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
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
+CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+CONFIG_DEBUG_SLAB=y
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+CONFIG_CROSSCOMPILE=y
+CONFIG_CMDLINE="console=ttyS1,38400n8 kgdb=ttyS0 root=/dev/nfs ip=bootp"
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_KGDB is not set
+# CONFIG_RUNTIME_DEBUG is not set
+# CONFIG_MIPS_UNCACHED is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=m
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=m

--------------090706010406070506020107--
