Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 22:31:45 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:13714 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025782AbYADWbh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2008 22:31:37 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JAv4g-0005ax-00; Fri, 04 Jan 2008 23:31:34 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4D570C2EF2; Fri,  4 Jan 2008 23:31:07 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SNI_RM: collected changes
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080104223107.4D570C2EF2@solo.franken.de>
Date:	Fri,  4 Jan 2008 23:31:07 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- EISA support for non PCI RMs (RM200 and RM400-xxx). The major part
  is the splitting of the EISA and onboard ISA of the RM200, which
  makes the EISA bus on the RM200 look like on other RMs.
- 64bit kernel support
- system type detection is now common for big and little endian (thanks
  Ralf)
- moved sniprom code to arch/mips/fw
- added call_o32 function to arch/mips/fw/lib, which uses a private
  stack for calling prom functions
- fix problem with isa interrupts, which makes using pit clockevent
  possible

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

This is 2.6.25 material and replaces [PATCH] SNI_RM: EISA support for 
A20R/RM200

 arch/mips/Kconfig           |    4 +
 arch/mips/Makefile          |    2 +
 arch/mips/fw/lib/Makefile   |    5 +
 arch/mips/fw/lib/call_o32.S |   97 +++++++++++++
 arch/mips/fw/sni/Makefile   |    5 +
 arch/mips/fw/sni/sniprom.c  |  152 ++++++++++++++++++++
 arch/mips/sni/Makefile      |    2 +-
 arch/mips/sni/a20r.c        |   13 ++-
 arch/mips/sni/eisa.c        |   52 +++++++
 arch/mips/sni/irq.c         |    4 +-
 arch/mips/sni/rm200.c       |  326 +++++++++++++++++++++++++++++++++++++++++--
 arch/mips/sni/setup.c       |  143 +++++++++++++++++++-
 arch/mips/sni/sniprom.c     |  251 ---------------------------------
 arch/mips/sni/time.c        |    1 +
 include/asm-mips/bootinfo.h |    1 +
 include/asm-mips/mipsprom.h |    2 +
 include/asm-mips/sni.h      |  159 ++++++++++++---------
 18 files changed, 1042 insertions(+), 338 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 291d368..515fcac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -573,6 +573,7 @@ config SNI_RM
 	bool "SNI RM200/300/400"
 	select ARC if CPU_LITTLE_ENDIAN
 	select ARC32 if CPU_LITTLE_ENDIAN
+	select SNIPROM if CPU_BIG_ENDIAN
 	select ARCH_MAY_HAVE_PC_FDC
 	select BOOT_ELF32
 	select CEVT_R4K
@@ -957,6 +959,9 @@ config SERIAL_RM9000
 config ARC32
 	bool
 
+config SNIPROM
+	bool
+
 config BOOT_ELF32
 	bool
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a1f8d8b..f2ea18b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -152,6 +152,8 @@ endif
 #
 libs-$(CONFIG_ARC)		+= arch/mips/fw/arc/
 libs-$(CONFIG_CFE)		+= arch/mips/fw/cfe/
+libs-$(CONFIG_SNIPROM)		+= arch/mips/fw/sni/
+libs-y				+= arch/mips/fw/lib/
 libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/sibyte/cfe/
 
 #
diff --git a/arch/mips/fw/lib/Makefile b/arch/mips/fw/lib/Makefile
new file mode 100644
index 0000000..84befc9
--- /dev/null
+++ b/arch/mips/fw/lib/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for generic prom monitor library routines under Linux.
+#
+
+lib-$(CONFIG_64BIT)	+= call_o32.o
diff --git a/arch/mips/fw/lib/call_o32.S b/arch/mips/fw/lib/call_o32.S
new file mode 100644
index 0000000..bdf7d1d
--- /dev/null
+++ b/arch/mips/fw/lib/call_o32.S
@@ -0,0 +1,97 @@
+/*
+ *	arch/mips/dec/prom/call_o32.S
+ *
+ *	O32 interface for the 64 (or N32) ABI.
+ *
+ *	Copyright (C) 2002  Maciej W. Rozycki
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/asm.h>
+#include <asm/regdef.h>
+
+/* Maximum number of arguments supported.  Must be even!  */
+#define O32_ARGC	32
+/* Number of static registers we save.  */
+#define O32_STATC	11
+/* Frame size for static register  */
+#define O32_FRAMESZ	(SZREG * O32_STATC)
+/* Frame size on new stack */
+#define O32_FRAMESZ_NEW (SZREG + 4 * O32_ARGC)
+
+		.text
+
+/*
+ * O32 function call dispatcher, for interfacing 32-bit ROM routines.
+ *
+ * The standard 64 (N32) calling sequence is supported, with a0
+ * holding a function pointer, a1 a new stack pointer, a2-a7 -- its
+ * first six arguments and the stack -- remaining ones (up to O32_ARGC,
+ * including a2-a7). Static registers, gp and fp are preserved, v0 holds
+ * a result. This code relies on the called o32 function for sp and ra
+ * restoration and this dispatcher has to be placed in a KSEGx (or KUSEG)
+ * address space.  Any pointers passed have to point to addresses within
+ * one of these spaces as well.
+ */
+NESTED(call_o32, O32_FRAMESZ, ra)
+		REG_SUBU	sp,O32_FRAMESZ
+
+		REG_S		ra,O32_FRAMESZ-1*SZREG(sp)
+		REG_S		fp,O32_FRAMESZ-2*SZREG(sp)
+		REG_S		gp,O32_FRAMESZ-3*SZREG(sp)
+		REG_S		s7,O32_FRAMESZ-4*SZREG(sp)
+		REG_S		s6,O32_FRAMESZ-5*SZREG(sp)
+		REG_S		s5,O32_FRAMESZ-6*SZREG(sp)
+		REG_S		s4,O32_FRAMESZ-7*SZREG(sp)
+		REG_S		s3,O32_FRAMESZ-8*SZREG(sp)
+		REG_S		s2,O32_FRAMESZ-9*SZREG(sp)
+		REG_S		s1,O32_FRAMESZ-10*SZREG(sp)
+		REG_S		s0,O32_FRAMESZ-11*SZREG(sp)
+
+		move		jp,a0
+		REG_SUBU	s0,a1,O32_FRAMESZ_NEW
+		REG_S		sp,O32_FRAMESZ_NEW-1*SZREG(s0)
+
+		sll		a0,a2,zero
+		sll		a1,a3,zero
+		sll		a2,a4,zero
+		sll		a3,a5,zero
+		sw		a6,0x10(s0)
+		sw		a7,0x14(s0)
+
+		PTR_LA		t0,O32_FRAMESZ(sp)
+		PTR_LA		t1,0x18(s0)
+		li		t2,O32_ARGC-6
+1:
+		lw		t3,(t0)
+		REG_ADDU	t0,SZREG
+		sw		t3,(t1)
+		REG_SUBU	t2,1
+		REG_ADDU	t1,4
+		bnez		t2,1b
+
+		move		sp,s0
+
+		jalr		jp
+
+		REG_L		sp,O32_FRAMESZ_NEW-1*SZREG(sp)
+
+		REG_L		s0,O32_FRAMESZ-11*SZREG(sp)
+		REG_L		s1,O32_FRAMESZ-10*SZREG(sp)
+		REG_L		s2,O32_FRAMESZ-9*SZREG(sp)
+		REG_L		s3,O32_FRAMESZ-8*SZREG(sp)
+		REG_L		s4,O32_FRAMESZ-7*SZREG(sp)
+		REG_L		s5,O32_FRAMESZ-6*SZREG(sp)
+		REG_L		s6,O32_FRAMESZ-5*SZREG(sp)
+		REG_L		s7,O32_FRAMESZ-4*SZREG(sp)
+		REG_L		gp,O32_FRAMESZ-3*SZREG(sp)
+		REG_L		fp,O32_FRAMESZ-2*SZREG(sp)
+		REG_L		ra,O32_FRAMESZ-1*SZREG(sp)
+
+		REG_ADDU	sp,O32_FRAMESZ
+		jr		ra
+END(call_o32)
diff --git a/arch/mips/fw/sni/Makefile b/arch/mips/fw/sni/Makefile
new file mode 100644
index 0000000..d9740a3
--- /dev/null
+++ b/arch/mips/fw/sni/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the SNI prom monitor routines under Linux.
+#
+
+lib-$(CONFIG_SNIPROM)	+= sniprom.o
diff --git a/arch/mips/fw/sni/sniprom.c b/arch/mips/fw/sni/sniprom.c
new file mode 100644
index 0000000..aec5dc0
--- /dev/null
+++ b/arch/mips/fw/sni/sniprom.c
@@ -0,0 +1,152 @@
+/*
+ * Big Endian PROM code for SNI RM machines
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2006 Florian Lohoff (flo@rfc822.org)
+ * Copyright (C) 2005-2006 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/console.h>
+
+#include <asm/addrspace.h>
+#include <asm/sni.h>
+#include <asm/mipsprom.h>
+#include <asm/mipsregs.h>
+#include <asm/bootinfo.h>
+
+/* special SNI prom calls */
+/*
+ * This does not exist in all proms - SINIX compares
+ * the prom env variable "version" against "2.0008"
+ * or greater. If lesser it tries to probe interesting
+ * registers
+ */
+#define PROM_GET_MEMCONF	58
+#define PROM_GET_HWCONF         61
+
+#define PROM_VEC		(u64 *)CKSEG1ADDR(0x1fc00000)
+#define PROM_ENTRY(x)		(PROM_VEC + (x))
+
+#define ___prom_putchar         ((int *(*)(int))PROM_ENTRY(PROM_PUTCHAR))
+#define ___prom_getenv          ((char *(*)(char *))PROM_ENTRY(PROM_GETENV))
+#define ___prom_get_memconf     ((void (*)(void *))PROM_ENTRY(PROM_GET_MEMCONF))
+#define ___prom_get_hwconf      ((u32 (*)(void))PROM_ENTRY(PROM_GET_HWCONF))
+
+#ifdef CONFIG_64BIT
+
+static u8 o32_stk[16384];
+#define O32_STK   &o32_stk[sizeof(o32_stk)]
+
+#define __PROM_O32(fun, arg) fun arg __asm__(#fun); \
+				     __asm__(#fun " = call_o32")
+
+int   __PROM_O32(__prom_putchar, (int *(*)(int), void *, int));
+char *__PROM_O32(__prom_getenv, (char *(*)(char *), void *, char *));
+void  __PROM_O32(__prom_get_memconf, (void (*)(void *), void *, void *));
+u32   __PROM_O32(__prom_get_hwconf, (u32 (*)(void), void *));
+
+#define _prom_putchar(x)     __prom_putchar(___prom_putchar, O32_STK, x)
+#define _prom_getenv(x)      __prom_getenv(___prom_getenv, O32_STK, x)
+#define _prom_get_memconf(x) __prom_get_memconf(___prom_get_memconf, O32_STK, x)
+#define _prom_get_hwconf()   __prom_get_hwconf(___prom_get_hwconf, O32_STK)
+
+#else
+#define _prom_putchar(x)     ___prom_putchar(x)
+#define _prom_getenv(x)      ___prom_getenv(x)
+#define _prom_get_memconf(x) ___prom_get_memconf(x)
+#define _prom_get_hwconf(x)  ___prom_get_hwconf(x)
+#endif
+
+void prom_putchar(char c)
+{
+	_prom_putchar(c);
+}
+
+
+char *prom_getenv(char *s)
+{
+	return _prom_getenv(s);
+}
+
+void *prom_get_hwconf(void)
+{
+	u32 hwconf = _prom_get_hwconf();
+
+	if (hwconf == 0xffffffff)
+		return NULL;
+
+	return (void *)CKSEG1ADDR(hwconf);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+/*
+ * /proc/cpuinfo system type
+ *
+ */
+char *system_type = "Unknown";
+const char *get_system_type(void)
+{
+	return system_type;
+}
+
+static void __init sni_mem_init(void)
+{
+	int i, memsize;
+	struct membank {
+		u32		size;
+		u32		base;
+		u32		size2;
+		u32		pad1;
+		u32		pad2;
+	} memconf[8];
+	int brd_type = *(unsigned char *)SNI_IDPROM_BRDTYPE;
+
+
+	/* MemSIZE from prom in 16MByte chunks */
+	memsize = *((unsigned char *) SNI_IDPROM_MEMSIZE) * 16;
+
+	pr_debug("IDProm memsize: %u MByte\n", memsize);
+
+	/* get memory bank layout from prom */
+	_prom_get_memconf(&memconf);
+
+	pr_debug("prom_get_mem_conf memory configuration:\n");
+	for (i = 0; i < 8 && memconf[i].size; i++) {
+		if (brd_type == SNI_BRD_PCI_TOWER ||
+		    brd_type == SNI_BRD_PCI_TOWER_CPLUS) {
+			if (memconf[i].base >= 0x20000000 &&
+			    memconf[i].base <  0x30000000)
+				memconf[i].base -= 0x20000000;
+		}
+		pr_debug("Bank%d: %08x @ %08x\n", i,
+			memconf[i].size, memconf[i].base);
+		add_memory_region(memconf[i].base, memconf[i].size,
+				  BOOT_MEM_RAM);
+	}
+}
+
+void __init prom_init(void)
+{
+	int argc = fw_arg0;
+	u32 *argv = (u32 *)CKSEG0ADDR(fw_arg1);
+	int i;
+
+	sni_mem_init();
+
+	/* copy prom cmdline parameters to kernel cmdline */
+	for (i = 1; i < argc; i++) {
+		strcat(arcs_cmdline, (char *)CKSEG0ADDR(argv[i]));
+		if (i < (argc - 1))
+			strcat(arcs_cmdline, " ");
+	}
+}
+
diff --git a/arch/mips/sni/Makefile b/arch/mips/sni/Makefile
index 3a99cd6..a7dbeeb 100644
--- a/arch/mips/sni/Makefile
+++ b/arch/mips/sni/Makefile
@@ -3,6 +3,6 @@
 #
 
 obj-y += irq.o reset.o setup.o a20r.o rm200.o pcimt.o pcit.o time.o
-obj-$(CONFIG_CPU_BIG_ENDIAN) += sniprom.o
+obj-$(CONFIG_EISA) += eisa.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index b746075..3f8cf5e 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -117,10 +117,19 @@ static struct resource sc26xx_rsrc[] = {
 	}
 };
 
+static unsigned int sc26xx_data[2] = {
+	/* DTR   |   RTS    |   DSR    |   CTS     |   DCD     |   RI    */
+	(8 << 0) | (4 << 4) | (6 << 8) | (0 << 12) | (6 << 16) | (0 << 20),
+	(3 << 0) | (2 << 4) | (1 << 8) | (2 << 12) | (3 << 16) | (4 << 20)
+};
+
 static struct platform_device sc26xx_pdev = {
 	.name           = "SC26xx",
 	.num_resources  = ARRAY_SIZE(sc26xx_rsrc),
-	.resource       = sc26xx_rsrc
+	.resource       = sc26xx_rsrc,
+	.dev			= {
+		.platform_data	= sc26xx_data,
+	}
 };
 
 static u32 a20r_ack_hwint(void)
@@ -231,9 +240,9 @@ static int __init snirm_a20r_setup_devinit(void)
 	        platform_device_register(&sc26xx_pdev);
 	        platform_device_register(&a20r_serial8250_device);
 	        platform_device_register(&a20r_ds1216_device);
+		sni_eisa_root_init();
 	        break;
 	}
-
 	return 0;
 }
 
diff --git a/arch/mips/sni/eisa.c b/arch/mips/sni/eisa.c
new file mode 100644
index 0000000..2fd2412
--- /dev/null
+++ b/arch/mips/sni/eisa.c
@@ -0,0 +1,52 @@
+/*
+ * Virtual EISA root driver.
+ * Acts as a placeholder if we don't have a proper EISA bridge.
+ *
+ * (C) 2003 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ * modified for SNI usage by Thomas Bogendoerfer
+ *
+ * This code is released under the GPL version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/eisa.h>
+#include <linux/init.h>
+
+/* The default EISA device parent (virtual root device).
+ * Now use a platform device, since that's the obvious choice. */
+
+static struct platform_device eisa_root_dev = {
+	.name = "eisa",
+	.id   = 0,
+};
+
+static struct eisa_root_device eisa_bus_root = {
+	.dev           = &eisa_root_dev.dev,
+	.bus_base_addr = 0,
+	.res	       = &ioport_resource,
+	.slots	       = EISA_MAX_SLOTS,
+	.dma_mask      = 0xffffffff,
+	.force_probe   = 1,
+};
+
+int __init sni_eisa_root_init(void)
+{
+	int r;
+
+	r = platform_device_register(&eisa_root_dev);
+	if (!r)
+		return r;
+
+	eisa_root_dev.dev.driver_data = &eisa_bus_root;
+
+	if (eisa_root_register(&eisa_bus_root)) {
+		/* A real bridge may have been registered before
+		 * us. So quietly unregister. */
+		platform_device_unregister(&eisa_root_dev);
+		return -1;
+	}
+	return 0;
+}
+
+
diff --git a/arch/mips/sni/irq.c b/arch/mips/sni/irq.c
index 9ccffdf..e8e72bb 100644
--- a/arch/mips/sni/irq.c
+++ b/arch/mips/sni/irq.c
@@ -35,14 +35,14 @@ static irqreturn_t sni_isa_irq_handler(int dummy, void *p)
 	if (unlikely(irq < 0))
 		return IRQ_NONE;
 
-	do_IRQ(irq);
+	generic_handle_irq(irq);
 	return IRQ_HANDLED;
 }
 
 struct irqaction sni_isa_irq = {
 	.handler = sni_isa_irq_handler,
 	.name = "ISA",
-	.flags = IRQF_SHARED
+	.flags = IRQF_SHARED | IRQF_DISABLED
 };
 
 /*
diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
index 67b061e..5310aa7 100644
--- a/arch/mips/sni/rm200.c
+++ b/arch/mips/sni/rm200.c
@@ -5,30 +5,36 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2006 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
+ * Copyright (C) 2006,2007 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
+ *
+ * i8259 parts ripped out of arch/mips/kernel/i8259.c
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/io.h>
 
 #include <asm/sni.h>
 #include <asm/time.h>
 #include <asm/irq_cpu.h>
 
-#define PORT(_base,_irq)				\
+#define RM200_I8259A_IRQ_BASE 32
+
+#define MEMPORT(_base,_irq)				\
 	{						\
-		.iobase		= _base,		\
+		.mapbase	= _base,		\
 		.irq		= _irq,			\
 		.uartclk	= 1843200,		\
-		.iotype		= UPIO_PORT,		\
-		.flags		= UPF_BOOT_AUTOCONF,	\
+		.iotype		= UPIO_MEM,		\
+		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP, \
 	}
 
 static struct plat_serial8250_port rm200_data[] = {
-	PORT(0x3f8, 4),
-	PORT(0x2f8, 3),
+	MEMPORT(0x160003f8, RM200_I8259A_IRQ_BASE + 4),
+	MEMPORT(0x160002f8, RM200_I8259A_IRQ_BASE + 3),
 	{ },
 };
 
@@ -112,15 +118,311 @@ static int __init snirm_setup_devinit(void)
 		platform_device_register(&rm200_ds1216_device);
 		platform_device_register(&snirm_82596_rm200_pdev);
 		platform_device_register(&snirm_53c710_rm200_pdev);
+		sni_eisa_root_init();
 	}
 	return 0;
 }
 
 device_initcall(snirm_setup_devinit);
 
+/*
+ * RM200 has an ISA and an EISA bus. The iSA bus is only used
+ * for onboard devices and also has twi i8259 PICs. Since these
+ * PICs are no accessible via inb/outb the following code uses
+ * readb/writeb to access them
+ */
+
+DEFINE_SPINLOCK(sni_rm200_i8259A_lock);
+#define PIC_CMD    0x00
+#define PIC_IMR    0x01
+#define PIC_ISR    PIC_CMD
+#define PIC_POLL   PIC_ISR
+#define PIC_OCW3   PIC_ISR
+
+/* i8259A PIC related value */
+#define PIC_CASCADE_IR		2
+#define MASTER_ICW4_DEFAULT	0x01
+#define SLAVE_ICW4_DEFAULT	0x01
+
+/*
+ * This contains the irq mask for both 8259A irq controllers,
+ */
+static unsigned int rm200_cached_irq_mask = 0xffff;
+static __iomem u8 *rm200_pic_master;
+static __iomem u8 *rm200_pic_slave;
+
+#define cached_master_mask	(rm200_cached_irq_mask)
+#define cached_slave_mask	(rm200_cached_irq_mask >> 8)
+
+static void sni_rm200_disable_8259A_irq(unsigned int irq)
+{
+	unsigned int mask;
+	unsigned long flags;
+
+	irq -= RM200_I8259A_IRQ_BASE;
+	mask = 1 << irq;
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+	rm200_cached_irq_mask |= mask;
+	if (irq & 8)
+		writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+	else
+		writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+}
+
+static void sni_rm200_enable_8259A_irq(unsigned int irq)
+{
+	unsigned int mask;
+	unsigned long flags;
+
+	irq -= RM200_I8259A_IRQ_BASE;
+	mask = ~(1 << irq);
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+	rm200_cached_irq_mask &= mask;
+	if (irq & 8)
+		writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+	else
+		writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+}
+
+static inline int sni_rm200_i8259A_irq_real(unsigned int irq)
+{
+	int value;
+	int irqmask = 1 << irq;
+
+	if (irq < 8) {
+		writeb(0x0B, rm200_pic_master + PIC_CMD);
+		value = readb(rm200_pic_master + PIC_CMD) & irqmask;
+		writeb(0x0A, rm200_pic_master + PIC_CMD);
+		return value;
+	}
+	writeb(0x0B, rm200_pic_slave + PIC_CMD); /* ISR register */
+	value = readb(rm200_pic_slave + PIC_CMD) & (irqmask >> 8);
+	writeb(0x0A, rm200_pic_slave + PIC_CMD);
+	return value;
+}
+
+/*
+ * Careful! The 8259A is a fragile beast, it pretty
+ * much _has_ to be done exactly like this (mask it
+ * first, _then_ send the EOI, and the order of EOI
+ * to the two 8259s is important!
+ */
+void sni_rm200_mask_and_ack_8259A(unsigned int irq)
+{
+	unsigned int irqmask;
+	unsigned long flags;
+
+	irq -= RM200_I8259A_IRQ_BASE;
+	irqmask = 1 << irq;
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+	/*
+	 * Lightweight spurious IRQ detection. We do not want
+	 * to overdo spurious IRQ handling - it's usually a sign
+	 * of hardware problems, so we only do the checks we can
+	 * do without slowing down good hardware unnecessarily.
+	 *
+	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
+	 * usually resulting from the 8259A-1|2 PICs) occur
+	 * even if the IRQ is masked in the 8259A. Thus we
+	 * can check spurious 8259A IRQs without doing the
+	 * quite slow i8259A_irq_real() call for every IRQ.
+	 * This does not cover 100% of spurious interrupts,
+	 * but should be enough to warn the user that there
+	 * is something bad going on ...
+	 */
+	if (rm200_cached_irq_mask & irqmask)
+		goto spurious_8259A_irq;
+	rm200_cached_irq_mask |= irqmask;
+
+handle_real_irq:
+	if (irq & 8) {
+		readb(rm200_pic_slave + PIC_IMR);
+		writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+		writeb(0x60+(irq & 7), rm200_pic_slave + PIC_CMD);
+		writeb(0x60+PIC_CASCADE_IR, rm200_pic_master + PIC_CMD);
+	} else {
+		readb(rm200_pic_master + PIC_IMR);
+		writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+		writeb(0x60+irq, rm200_pic_master + PIC_CMD);
+	}
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+	return;
+
+spurious_8259A_irq:
+	/*
+	 * this is the slow path - should happen rarely.
+	 */
+	if (sni_rm200_i8259A_irq_real(irq))
+		/*
+		 * oops, the IRQ _is_ in service according to the
+		 * 8259A - not spurious, go handle it.
+		 */
+		goto handle_real_irq;
+
+	{
+		static int spurious_irq_mask;
+		/*
+		 * At this point we can be sure the IRQ is spurious,
+		 * lets ACK and report it. [once per IRQ]
+		 */
+		if (!(spurious_irq_mask & irqmask)) {
+			printk(KERN_DEBUG
+			       "spurious RM200 8259A interrupt: IRQ%d.\n", irq);
+			spurious_irq_mask |= irqmask;
+		}
+		atomic_inc(&irq_err_count);
+		/*
+		 * Theoretically we do not have to handle this IRQ,
+		 * but in Linux this does not cause problems and is
+		 * simpler for us.
+		 */
+		goto handle_real_irq;
+	}
+}
+
+static struct irq_chip sni_rm200_i8259A_chip = {
+	.name		= "RM200-XT-PIC",
+	.mask		= sni_rm200_disable_8259A_irq,
+	.unmask		= sni_rm200_enable_8259A_irq,
+	.mask_ack	= sni_rm200_mask_and_ack_8259A,
+};
+
+/*
+ * Do the traditional i8259 interrupt polling thing.  This is for the few
+ * cases where no better interrupt acknowledge method is available and we
+ * absolutely must touch the i8259.
+ */
+static inline int sni_rm200_i8259_irq(void)
+{
+	int irq;
+
+	spin_lock(&sni_rm200_i8259A_lock);
+
+	/* Perform an interrupt acknowledge cycle on controller 1. */
+	writeb(0x0C, rm200_pic_master + PIC_CMD);	/* prepare for poll */
+	irq = readb(rm200_pic_master + PIC_CMD) & 7;
+	if (irq == PIC_CASCADE_IR) {
+		/*
+		 * Interrupt is cascaded so perform interrupt
+		 * acknowledge on controller 2.
+		 */
+		writeb(0x0C, rm200_pic_slave + PIC_CMD); /* prepare for poll */
+		irq = (readb(rm200_pic_slave + PIC_CMD) & 7) + 8;
+	}
+
+	if (unlikely(irq == 7)) {
+		/*
+		 * This may be a spurious interrupt.
+		 *
+		 * Read the interrupt status register (ISR). If the most
+		 * significant bit is not set then there is no valid
+		 * interrupt.
+		 */
+		writeb(0x0B, rm200_pic_master + PIC_ISR); /* ISR register */
+		if (~readb(rm200_pic_master + PIC_ISR) & 0x80)
+			irq = -1;
+	}
+
+	spin_unlock(&sni_rm200_i8259A_lock);
+
+	return likely(irq >= 0) ? irq + RM200_I8259A_IRQ_BASE : irq;
+}
+
+void sni_rm200_init_8259A(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sni_rm200_i8259A_lock, flags);
+
+	writeb(0xff, rm200_pic_master + PIC_IMR);
+	writeb(0xff, rm200_pic_slave + PIC_IMR);
+
+	writeb(0x11, rm200_pic_master + PIC_CMD);
+	writeb(0, rm200_pic_master + PIC_IMR);
+	writeb(1U << PIC_CASCADE_IR, rm200_pic_master + PIC_IMR);
+	writeb(MASTER_ICW4_DEFAULT, rm200_pic_master + PIC_IMR);
+	writeb(0x11, rm200_pic_slave + PIC_CMD);
+	writeb(8, rm200_pic_slave + PIC_IMR);
+	writeb(PIC_CASCADE_IR, rm200_pic_slave + PIC_IMR);
+	writeb(SLAVE_ICW4_DEFAULT, rm200_pic_slave + PIC_IMR);
+	udelay(100);		/* wait for 8259A to initialize */
+
+	writeb(cached_master_mask, rm200_pic_master + PIC_IMR);
+	writeb(cached_slave_mask, rm200_pic_slave + PIC_IMR);
+
+	spin_unlock_irqrestore(&sni_rm200_i8259A_lock, flags);
+}
+
+/*
+ * IRQ2 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction sni_rm200_irq2 = {
+	no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL
+};
+
+static struct resource sni_rm200_pic1_resource = {
+	.name = "onboard ISA pic1",
+	.start = 0x16000020,
+	.end = 0x16000023,
+	.flags = IORESOURCE_BUSY
+};
+
+static struct resource sni_rm200_pic2_resource = {
+	.name = "onboard ISA pic2",
+	.start = 0x160000a0,
+	.end = 0x160000a3,
+	.flags = IORESOURCE_BUSY
+};
+
+/* ISA irq handler */
+static irqreturn_t sni_rm200_i8259A_irq_handler(int dummy, void *p)
+{
+	int irq;
+
+	irq = sni_rm200_i8259_irq();
+	if (unlikely(irq < 0))
+		return IRQ_NONE;
+
+	do_IRQ(irq);
+	return IRQ_HANDLED;
+}
+
+struct irqaction sni_rm200_i8259A_irq = {
+	.handler = sni_rm200_i8259A_irq_handler,
+	.name = "onboard ISA",
+	.flags = IRQF_SHARED
+};
+
+void __init sni_rm200_i8259_irqs(void)
+{
+	int i;
+
+	rm200_pic_master = ioremap_nocache(0x16000020, 4);
+	if (!rm200_pic_master)
+		return;
+	rm200_pic_slave = ioremap_nocache(0x160000a0, 4);
+	if (!rm200_pic_master) {
+		iounmap(rm200_pic_master);
+		return;
+	}
+
+	insert_resource(&iomem_resource, &sni_rm200_pic1_resource);
+	insert_resource(&iomem_resource, &sni_rm200_pic2_resource);
+
+	sni_rm200_init_8259A();
+
+	for (i = RM200_I8259A_IRQ_BASE; i < RM200_I8259A_IRQ_BASE + 16; i++)
+		set_irq_chip_and_handler(i, &sni_rm200_i8259A_chip,
+					 handle_level_irq);
+
+	setup_irq(RM200_I8259A_IRQ_BASE + PIC_CASCADE_IR, &sni_rm200_irq2);
+}
+
 
-#define SNI_RM200_INT_STAT_REG  0xbc000000
-#define SNI_RM200_INT_ENA_REG   0xbc080000
+#define SNI_RM200_INT_STAT_REG  CKSEG1ADDR(0xbc000000)
+#define SNI_RM200_INT_ENA_REG   CKSEG1ADDR(0xbc080000)
 
 #define SNI_RM200_INT_START  24
 #define SNI_RM200_INT_END    28
@@ -181,17 +483,17 @@ void __init sni_rm200_irq_init(void)
 
 	* (volatile u8 *)SNI_RM200_INT_ENA_REG = 0x1f;
 
+	sni_rm200_i8259_irqs();
 	mips_cpu_irq_init();
 	/* Actually we've got more interrupts to handle ...  */
 	for (i = SNI_RM200_INT_START; i <= SNI_RM200_INT_END; i++)
 		set_irq_chip(i, &rm200_irq_type);
 	sni_hwint = sni_rm200_hwint;
 	change_c0_status(ST0_IM, IE_IRQ0);
-	setup_irq(SNI_RM200_INT_START + 0, &sni_isa_irq);
+	setup_irq(SNI_RM200_INT_START + 0, &sni_rm200_i8259A_irq);
+	setup_irq(SNI_RM200_INT_START + 1, &sni_isa_irq);
 }
 
 void __init sni_rm200_init(void)
 {
-	set_io_port_base(SNI_PORT_BASE + 0x02000000);
-	ioport_resource.end += 0x02000000;
 }
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index e8b26bd..5484e1c 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -19,11 +19,17 @@
 #include <asm/sgialib.h>
 #endif
 
+#ifdef CONFIG_SNIPROM
+#include <asm/mipsprom.h>
+#endif
+
+#include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/reboot.h>
 #include <asm/sni.h>
 
 unsigned int sni_brd_type;
+EXPORT_SYMBOL(sni_brd_type);
 
 extern void sni_machine_restart(char *command);
 extern void sni_machine_power_off(void);
@@ -47,20 +53,152 @@ static void __init sni_display_setup(void)
 #endif
 }
 
+static void __init sni_console_setup(void)
+{
+#ifndef CONFIG_ARC
+	char *ctype;
+	char *cdev;
+	char *baud;
+	int port;
+	static char options[8];
+
+	cdev = prom_getenv("console_dev");
+	if (strncmp(cdev, "tty", 3) == 0) {
+		ctype = prom_getenv("console");
+		switch (*ctype) {
+		default:
+		case 'l':
+			port = 0;
+			baud = prom_getenv("lbaud");
+			break;
+		case 'r':
+			port = 1;
+			baud = prom_getenv("rbaud");
+			break;
+		}
+		if (baud)
+			strcpy(options, baud);
+		if (strncmp(cdev, "tty552", 6) == 0)
+			add_preferred_console("ttyS", port,
+					      baud ? options : NULL);
+		else
+			add_preferred_console("ttySC", port,
+					      baud ? options : NULL);
+	}
+#endif
+}
+
+#ifdef DEBUG
+static void __init sni_idprom_dump(void)
+{
+	int	i;
+
+	pr_debug("SNI IDProm dump:\n");
+	for (i = 0; i < 256; i++) {
+		if (i%16 == 0)
+			pr_debug("%04x ", i);
+
+		printk("%02x ", *(unsigned char *) (SNI_IDPROM_BASE + i));
+
+		if (i % 16 == 15)
+			printk("\n");
+	}
+}
+#endif
 
 void __init plat_mem_setup(void)
 {
+	int cputype;
+
 	set_io_port_base(SNI_PORT_BASE);
 //	ioport_resource.end = sni_io_resource.end;
 
 	/*
 	 * Setup (E)ISA I/O memory access stuff
 	 */
-	isa_slot_offset = 0xb0000000;
+	isa_slot_offset = CKSEG1ADDR(0xb0000000);
 #ifdef CONFIG_EISA
 	EISA_bus = 1;
 #endif
 
+	sni_brd_type = *(unsigned char *)SNI_IDPROM_BRDTYPE;
+	cputype = *(unsigned char *)SNI_IDPROM_CPUTYPE;
+	switch (sni_brd_type) {
+	case SNI_BRD_TOWER_OASIC:
+		switch (cputype) {
+		case SNI_CPU_M8030:
+			system_type = "RM400-330";
+			break;
+		case SNI_CPU_M8031:
+			system_type = "RM400-430";
+			break;
+		case SNI_CPU_M8037:
+			system_type = "RM400-530";
+			break;
+		case SNI_CPU_M8034:
+			system_type = "RM400-730";
+			break;
+		default:
+			system_type = "RM400-xxx";
+			break;
+		}
+		break;
+	case SNI_BRD_MINITOWER:
+		switch (cputype) {
+		case SNI_CPU_M8021:
+		case SNI_CPU_M8043:
+			system_type = "RM400-120";
+			break;
+		case SNI_CPU_M8040:
+			system_type = "RM400-220";
+			break;
+		case SNI_CPU_M8053:
+			system_type = "RM400-225";
+			break;
+		case SNI_CPU_M8050:
+			system_type = "RM400-420";
+			break;
+		default:
+			system_type = "RM400-xxx";
+			break;
+		}
+		break;
+	case SNI_BRD_PCI_TOWER:
+		system_type = "RM400-Cxx";
+		break;
+	case SNI_BRD_RM200:
+		system_type = "RM200-xxx";
+		break;
+	case SNI_BRD_PCI_MTOWER:
+		system_type = "RM300-Cxx";
+		break;
+	case SNI_BRD_PCI_DESKTOP:
+		switch (read_c0_prid() & 0xff00) {
+		case PRID_IMP_R4600:
+		case PRID_IMP_R4700:
+			system_type = "RM200-C20";
+			break;
+		case PRID_IMP_R5000:
+			system_type = "RM200-C40";
+			break;
+		default:
+			system_type = "RM200-Cxx";
+			break;
+		}
+		break;
+	case SNI_BRD_PCI_TOWER_CPLUS:
+		system_type = "RM400-Exx";
+		break;
+	case SNI_BRD_PCI_MTOWER_CPLUS:
+		system_type = "RM300-Exx";
+		break;
+	}
+	pr_debug("Found SNI brdtype %02x name %s\n", sni_brd_type, system_type);
+
+#ifdef DEBUG
+	sni_idprom_dump();
+#endif
+
 	switch (sni_brd_type) {
 	case SNI_BRD_10:
 	case SNI_BRD_10NEW:
@@ -89,9 +227,10 @@ void __init plat_mem_setup(void)
 	pm_power_off = sni_machine_power_off;
 
 	sni_display_setup();
+	sni_console_setup();
 }
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 
 #include <linux/pci.h>
 #include <video/vga.h>
diff --git a/arch/mips/sni/sniprom.c b/arch/mips/sni/sniprom.c
deleted file mode 100644
index eff4b89..0000000
--- a/arch/mips/sni/sniprom.c
+++ /dev/null
@@ -1,251 +0,0 @@
-/*
- * Big Endian PROM code for SNI RM machines
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2005-2006 Florian Lohoff (flo@rfc822.org)
- * Copyright (C) 2005-2006 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
- */
-
-#define DEBUG
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/console.h>
-
-#include <asm/addrspace.h>
-#include <asm/sni.h>
-#include <asm/mipsprom.h>
-#include <asm/mipsregs.h>
-#include <asm/bootinfo.h>
-
-/* special SNI prom calls */
-/*
- * This does not exist in all proms - SINIX compares
- * the prom env variable "version" against "2.0008"
- * or greater. If lesser it tries to probe interesting
- * registers
- */
-#define PROM_GET_MEMCONF	58
-
-#define PROM_VEC		(u64 *)CKSEG1ADDR(0x1fc00000)
-#define PROM_ENTRY(x)		(PROM_VEC + (x))
-
-
-static int *(*__prom_putchar)(int)        = (int *(*)(int))PROM_ENTRY(PROM_PUTCHAR);
-
-void prom_putchar(char c)
-{
-	__prom_putchar(c);
-}
-
-static char *(*__prom_getenv)(char *)     = (char *(*)(char *))PROM_ENTRY(PROM_GETENV);
-static void (*__prom_get_memconf)(void *) = (void (*)(void *))PROM_ENTRY(PROM_GET_MEMCONF);
-
-char *prom_getenv(char *s)
-{
-	return __prom_getenv(s);
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-/*
- * /proc/cpuinfo system type
- *
- */
-static const char *systype = "Unknown";
-const char *get_system_type(void)
-{
-	return systype;
-}
-
-#define SNI_IDPROM_BASE                0xbff00000
-#define SNI_IDPROM_MEMSIZE             (SNI_IDPROM_BASE+0x28)  /* Memsize in 16MB quantities */
-#define SNI_IDPROM_BRDTYPE             (SNI_IDPROM_BASE+0x29)  /* Board Type */
-#define SNI_IDPROM_CPUTYPE             (SNI_IDPROM_BASE+0x30)  /* CPU Type */
-
-#define SNI_IDPROM_SIZE	0x1000
-
-#ifdef DEBUG
-static void __init sni_idprom_dump(void)
-{
-	int	i;
-
-	pr_debug("SNI IDProm dump:\n");
-	for (i = 0; i < 256; i++) {
-		if (i%16 == 0)
-			pr_debug("%04x ", i);
-
-		printk("%02x ", *(unsigned char *) (SNI_IDPROM_BASE + i));
-
-		if (i % 16 == 15)
-			printk("\n");
-	}
-}
-#endif
-
-static void __init sni_mem_init(void )
-{
-	int i, memsize;
-	struct membank {
-	        u32		size;
-	        u32		base;
-	        u32		size2;
-	        u32		pad1;
-	        u32		pad2;
-	} memconf[8];
-
-	/* MemSIZE from prom in 16MByte chunks */
-	memsize = *((unsigned char *) SNI_IDPROM_MEMSIZE) * 16;
-
-	pr_debug("IDProm memsize: %lu MByte\n", memsize);
-
-	/* get memory bank layout from prom */
-	__prom_get_memconf(&memconf);
-
-	pr_debug("prom_get_mem_conf memory configuration:\n");
-	for (i = 0;i < 8 && memconf[i].size; i++) {
-		if (sni_brd_type == SNI_BRD_PCI_TOWER ||
-		    sni_brd_type == SNI_BRD_PCI_TOWER_CPLUS) {
-			if (memconf[i].base >= 0x20000000 &&
-			    memconf[i].base <  0x30000000) {
-				memconf[i].base -= 0x20000000;
-			}
-	}
-		pr_debug("Bank%d: %08x @ %08x\n", i,
-			memconf[i].size, memconf[i].base);
-		add_memory_region(memconf[i].base, memconf[i].size, BOOT_MEM_RAM);
-	}
-}
-
-static void __init sni_console_setup(void)
-{
-	char *ctype;
-	char *cdev;
-	char *baud;
-	int port;
-	static char options[8];
-
-	cdev = prom_getenv("console_dev");
-	if (strncmp (cdev, "tty", 3) == 0) {
-		ctype = prom_getenv("console");
-		switch (*ctype) {
-		default:
-		case 'l':
-	                port = 0;
-	                baud = prom_getenv("lbaud");
-	                break;
-		case 'r':
-	                port = 1;
-	                baud = prom_getenv("rbaud");
-	                break;
-		}
-		if (baud)
-			strcpy(options, baud);
-		if (strncmp (cdev, "tty552", 6) == 0)
-			add_preferred_console("ttyS", port, baud ? options : NULL);
-		else
-			add_preferred_console("ttySC", port, baud ? options : NULL);
-	}
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (void *)fw_arg1;
-	int i;
-	int cputype;
-
-	sni_brd_type = *(unsigned char *)SNI_IDPROM_BRDTYPE;
-	cputype = *(unsigned char *)SNI_IDPROM_CPUTYPE;
-	switch (sni_brd_type) {
-	case SNI_BRD_TOWER_OASIC:
-	        switch (cputype) {
-		case SNI_CPU_M8030:
-		        systype = "RM400-330";
-		        break;
-		case SNI_CPU_M8031:
-		        systype = "RM400-430";
-		        break;
-		case SNI_CPU_M8037:
-		        systype = "RM400-530";
-		        break;
-		case SNI_CPU_M8034:
-		        systype = "RM400-730";
-		        break;
-		default:
-			systype = "RM400-xxx";
-			break;
-		}
-	        break;
-	case SNI_BRD_MINITOWER:
-	        switch (cputype) {
-		case SNI_CPU_M8021:
-		case SNI_CPU_M8043:
-		        systype = "RM400-120";
-		        break;
-		case SNI_CPU_M8040:
-		        systype = "RM400-220";
-		        break;
-		case SNI_CPU_M8053:
-		        systype = "RM400-225";
-		        break;
-		case SNI_CPU_M8050:
-		        systype = "RM400-420";
-		        break;
-		default:
-			systype = "RM400-xxx";
-			break;
-		}
-	        break;
-	case SNI_BRD_PCI_TOWER:
-	        systype = "RM400-Cxx";
-	        break;
-	case SNI_BRD_RM200:
-	        systype = "RM200-xxx";
-	        break;
-	case SNI_BRD_PCI_MTOWER:
-	        systype = "RM300-Cxx";
-	        break;
-	case SNI_BRD_PCI_DESKTOP:
-	        switch (read_c0_prid() & 0xff00) {
-		case PRID_IMP_R4600:
-		case PRID_IMP_R4700:
-		        systype = "RM200-C20";
-		        break;
-		case PRID_IMP_R5000:
-		        systype = "RM200-C40";
-		        break;
-		default:
-		        systype = "RM200-Cxx";
-		        break;
-		}
-	        break;
-	case SNI_BRD_PCI_TOWER_CPLUS:
-	        systype = "RM400-Exx";
-	        break;
-	case SNI_BRD_PCI_MTOWER_CPLUS:
-	        systype = "RM300-Exx";
-	        break;
-	}
-	pr_debug("Found SNI brdtype %02x name %s\n", sni_brd_type, systype);
-
-#ifdef DEBUG
-	sni_idprom_dump();
-#endif
-	sni_mem_init();
-	sni_console_setup();
-
-	/* copy prom cmdline parameters to kernel cmdline */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-}
-
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 6f339af..796e3ce 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -178,6 +178,7 @@ void __init plat_time_init(void)
 		sni_a20r_timer_setup();
 		break;
 	}
+	setup_pit_timer();
 }
 
 unsigned long read_persistent_clock(void)
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index b2dd9b3..c8b6625 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -200,6 +200,7 @@
 
 #define CL_SIZE			COMMAND_LINE_SIZE
 
+extern char *system_type;
 const char *get_system_type(void);
 
 extern unsigned long mips_machtype;
diff --git a/include/asm-mips/mipsprom.h b/include/asm-mips/mipsprom.h
index ce7cff7..146d41b 100644
--- a/include/asm-mips/mipsprom.h
+++ b/include/asm-mips/mipsprom.h
@@ -71,4 +71,6 @@
 #define PROM_NV_GET		53	/* XXX */
 #define PROM_NV_SET		54	/* XXX */
 
+extern char *prom_getenv(char *);
+
 #endif /* __ASM_MIPS_PROM_H */
diff --git a/include/asm-mips/sni.h b/include/asm-mips/sni.h
index af08145..e716447 100644
--- a/include/asm-mips/sni.h
+++ b/include/asm-mips/sni.h
@@ -35,23 +35,23 @@ extern unsigned int sni_brd_type;
 #define SNI_CPU_M8050           0x0b
 #define SNI_CPU_M8053           0x0d
 
-#define SNI_PORT_BASE		0xb4000000
+#define SNI_PORT_BASE		CKSEG1ADDR(0xb4000000)
 
 #ifndef __MIPSEL__
 /*
  * ASIC PCI registers for big endian configuration.
  */
-#define PCIMT_UCONF		0xbfff0004
-#define PCIMT_IOADTIMEOUT2	0xbfff000c
-#define PCIMT_IOMEMCONF		0xbfff0014
-#define PCIMT_IOMMU		0xbfff001c
-#define PCIMT_IOADTIMEOUT1	0xbfff0024
-#define PCIMT_DMAACCESS		0xbfff002c
-#define PCIMT_DMAHIT		0xbfff0034
-#define PCIMT_ERRSTATUS		0xbfff003c
-#define PCIMT_ERRADDR		0xbfff0044
-#define PCIMT_SYNDROME		0xbfff004c
-#define PCIMT_ITPEND		0xbfff0054
+#define PCIMT_UCONF		CKSEG1ADDR(0xbfff0004)
+#define PCIMT_IOADTIMEOUT2	CKSEG1ADDR(0xbfff000c)
+#define PCIMT_IOMEMCONF		CKSEG1ADDR(0xbfff0014)
+#define PCIMT_IOMMU		CKSEG1ADDR(0xbfff001c)
+#define PCIMT_IOADTIMEOUT1	CKSEG1ADDR(0xbfff0024)
+#define PCIMT_DMAACCESS		CKSEG1ADDR(0xbfff002c)
+#define PCIMT_DMAHIT		CKSEG1ADDR(0xbfff0034)
+#define PCIMT_ERRSTATUS		CKSEG1ADDR(0xbfff003c)
+#define PCIMT_ERRADDR		CKSEG1ADDR(0xbfff0044)
+#define PCIMT_SYNDROME		CKSEG1ADDR(0xbfff004c)
+#define PCIMT_ITPEND		CKSEG1ADDR(0xbfff0054)
 #define  IT_INT2		0x01
 #define  IT_INTD		0x02
 #define  IT_INTC		0x04
@@ -60,32 +60,32 @@ extern unsigned int sni_brd_type;
 #define  IT_EISA		0x20
 #define  IT_SCSI		0x40
 #define  IT_ETH			0x80
-#define PCIMT_IRQSEL		0xbfff005c
-#define PCIMT_TESTMEM		0xbfff0064
-#define PCIMT_ECCREG		0xbfff006c
-#define PCIMT_CONFIG_ADDRESS	0xbfff0074
-#define PCIMT_ASIC_ID		0xbfff007c	/* read */
-#define PCIMT_SOFT_RESET	0xbfff007c	/* write */
-#define PCIMT_PIA_OE		0xbfff0084
-#define PCIMT_PIA_DATAOUT	0xbfff008c
-#define PCIMT_PIA_DATAIN	0xbfff0094
-#define PCIMT_CACHECONF		0xbfff009c
-#define PCIMT_INVSPACE		0xbfff00a4
+#define PCIMT_IRQSEL		CKSEG1ADDR(0xbfff005c)
+#define PCIMT_TESTMEM		CKSEG1ADDR(0xbfff0064)
+#define PCIMT_ECCREG		CKSEG1ADDR(0xbfff006c)
+#define PCIMT_CONFIG_ADDRESS	CKSEG1ADDR(0xbfff0074)
+#define PCIMT_ASIC_ID		CKSEG1ADDR(0xbfff007c)	/* read */
+#define PCIMT_SOFT_RESET	CKSEG1ADDR(0xbfff007c)	/* write */
+#define PCIMT_PIA_OE		CKSEG1ADDR(0xbfff0084)
+#define PCIMT_PIA_DATAOUT	CKSEG1ADDR(0xbfff008c)
+#define PCIMT_PIA_DATAIN	CKSEG1ADDR(0xbfff0094)
+#define PCIMT_CACHECONF		CKSEG1ADDR(0xbfff009c)
+#define PCIMT_INVSPACE		CKSEG1ADDR(0xbfff00a4)
 #else
 /*
  * ASIC PCI registers for little endian configuration.
  */
-#define PCIMT_UCONF		0xbfff0000
-#define PCIMT_IOADTIMEOUT2	0xbfff0008
-#define PCIMT_IOMEMCONF		0xbfff0010
-#define PCIMT_IOMMU		0xbfff0018
-#define PCIMT_IOADTIMEOUT1	0xbfff0020
-#define PCIMT_DMAACCESS		0xbfff0028
-#define PCIMT_DMAHIT		0xbfff0030
-#define PCIMT_ERRSTATUS		0xbfff0038
-#define PCIMT_ERRADDR		0xbfff0040
-#define PCIMT_SYNDROME		0xbfff0048
-#define PCIMT_ITPEND		0xbfff0050
+#define PCIMT_UCONF		CKSEG1ADDR(0xbfff0000)
+#define PCIMT_IOADTIMEOUT2	CKSEG1ADDR(0xbfff0008)
+#define PCIMT_IOMEMCONF		CKSEG1ADDR(0xbfff0010)
+#define PCIMT_IOMMU		CKSEG1ADDR(0xbfff0018)
+#define PCIMT_IOADTIMEOUT1	CKSEG1ADDR(0xbfff0020)
+#define PCIMT_DMAACCESS		CKSEG1ADDR(0xbfff0028)
+#define PCIMT_DMAHIT		CKSEG1ADDR(0xbfff0030)
+#define PCIMT_ERRSTATUS		CKSEG1ADDR(0xbfff0038)
+#define PCIMT_ERRADDR		CKSEG1ADDR(0xbfff0040)
+#define PCIMT_SYNDROME		CKSEG1ADDR(0xbfff0048)
+#define PCIMT_ITPEND		CKSEG1ADDR(0xbfff0050)
 #define  IT_INT2		0x01
 #define  IT_INTD		0x02
 #define  IT_INTC		0x04
@@ -94,20 +94,20 @@ extern unsigned int sni_brd_type;
 #define  IT_EISA		0x20
 #define  IT_SCSI		0x40
 #define  IT_ETH			0x80
-#define PCIMT_IRQSEL		0xbfff0058
-#define PCIMT_TESTMEM		0xbfff0060
-#define PCIMT_ECCREG		0xbfff0068
-#define PCIMT_CONFIG_ADDRESS	0xbfff0070
-#define PCIMT_ASIC_ID		0xbfff0078	/* read */
-#define PCIMT_SOFT_RESET	0xbfff0078	/* write */
-#define PCIMT_PIA_OE		0xbfff0080
-#define PCIMT_PIA_DATAOUT	0xbfff0088
-#define PCIMT_PIA_DATAIN	0xbfff0090
-#define PCIMT_CACHECONF		0xbfff0098
-#define PCIMT_INVSPACE		0xbfff00a0
+#define PCIMT_IRQSEL		CKSEG1ADDR(0xbfff0058)
+#define PCIMT_TESTMEM		CKSEG1ADDR(0xbfff0060)
+#define PCIMT_ECCREG		CKSEG1ADDR(0xbfff0068)
+#define PCIMT_CONFIG_ADDRESS	CKSEG1ADDR(0xbfff0070)
+#define PCIMT_ASIC_ID		CKSEG1ADDR(0xbfff0078)	/* read */
+#define PCIMT_SOFT_RESET	CKSEG1ADDR(0xbfff0078)	/* write */
+#define PCIMT_PIA_OE		CKSEG1ADDR(0xbfff0080)
+#define PCIMT_PIA_DATAOUT	CKSEG1ADDR(0xbfff0088)
+#define PCIMT_PIA_DATAIN	CKSEG1ADDR(0xbfff0090)
+#define PCIMT_CACHECONF		CKSEG1ADDR(0xbfff0098)
+#define PCIMT_INVSPACE		CKSEG1ADDR(0xbfff00a0)
 #endif
 
-#define PCIMT_PCI_CONF		0xbfff0100
+#define PCIMT_PCI_CONF		CKSEG1ADDR(0xbfff0100)
 
 /*
  * Data port for the PCI bus in IO space
@@ -117,34 +117,34 @@ extern unsigned int sni_brd_type;
 /*
  * Board specific registers
  */
-#define PCIMT_CSMSR		0xbfd00000
-#define PCIMT_CSSWITCH		0xbfd10000
-#define PCIMT_CSITPEND		0xbfd20000
-#define PCIMT_AUTO_PO_EN	0xbfd30000
-#define PCIMT_CLR_TEMP		0xbfd40000
-#define PCIMT_AUTO_PO_DIS	0xbfd50000
-#define PCIMT_EXMSR		0xbfd60000
-#define PCIMT_UNUSED1		0xbfd70000
-#define PCIMT_CSWCSM		0xbfd80000
-#define PCIMT_UNUSED2		0xbfd90000
-#define PCIMT_CSLED		0xbfda0000
-#define PCIMT_CSMAPISA		0xbfdb0000
-#define PCIMT_CSRSTBP		0xbfdc0000
-#define PCIMT_CLRPOFF		0xbfdd0000
-#define PCIMT_CSTIMER		0xbfde0000
-#define PCIMT_PWDN		0xbfdf0000
+#define PCIMT_CSMSR		CKSEG1ADDR(0xbfd00000)
+#define PCIMT_CSSWITCH		CKSEG1ADDR(0xbfd10000)
+#define PCIMT_CSITPEND		CKSEG1ADDR(0xbfd20000)
+#define PCIMT_AUTO_PO_EN	CKSEG1ADDR(0xbfd30000)
+#define PCIMT_CLR_TEMP		CKSEG1ADDR(0xbfd40000)
+#define PCIMT_AUTO_PO_DIS	CKSEG1ADDR(0xbfd50000)
+#define PCIMT_EXMSR		CKSEG1ADDR(0xbfd60000)
+#define PCIMT_UNUSED1		CKSEG1ADDR(0xbfd70000)
+#define PCIMT_CSWCSM		CKSEG1ADDR(0xbfd80000)
+#define PCIMT_UNUSED2		CKSEG1ADDR(0xbfd90000)
+#define PCIMT_CSLED		CKSEG1ADDR(0xbfda0000)
+#define PCIMT_CSMAPISA		CKSEG1ADDR(0xbfdb0000)
+#define PCIMT_CSRSTBP		CKSEG1ADDR(0xbfdc0000)
+#define PCIMT_CLRPOFF		CKSEG1ADDR(0xbfdd0000)
+#define PCIMT_CSTIMER		CKSEG1ADDR(0xbfde0000)
+#define PCIMT_PWDN		CKSEG1ADDR(0xbfdf0000)
 
 /*
  * A20R based boards
  */
-#define A20R_PT_CLOCK_BASE      0xbc040000
-#define A20R_PT_TIM0_ACK        0xbc050000
-#define A20R_PT_TIM1_ACK        0xbc060000
+#define A20R_PT_CLOCK_BASE      CKSEG1ADDR(0xbc040000)
+#define A20R_PT_TIM0_ACK        CKSEG1ADDR(0xbc050000)
+#define A20R_PT_TIM1_ACK        CKSEG1ADDR(0xbc060000)
 
 #define SNI_A20R_IRQ_BASE       MIPS_CPU_IRQ_BASE
 #define SNI_A20R_IRQ_TIMER      (SNI_A20R_IRQ_BASE+5)
 
-#define SNI_PCIT_INT_REG        0xbfff000c
+#define SNI_PCIT_INT_REG        CKSEG1ADDR(0xbfff000c)
 
 #define SNI_PCIT_INT_START      24
 #define SNI_PCIT_INT_END        30
@@ -186,10 +186,30 @@ extern unsigned int sni_brd_type;
 /*
  * Base address for the mapped 16mb EISA bus segment.
  */
-#define PCIMT_EISA_BASE		0xb0000000
+#define PCIMT_EISA_BASE		CKSEG1ADDR(0xb0000000)
 
 /* PCI EISA Interrupt acknowledge  */
-#define PCIMT_INT_ACKNOWLEDGE	0xba000000
+#define PCIMT_INT_ACKNOWLEDGE	CKSEG1ADDR(0xba000000)
+
+/*
+ *  SNI ID PROM
+ *
+ * SNI_IDPROM_MEMSIZE  Memsize in 16MB quantities
+ * SNI_IDPROM_BRDTYPE  Board Type
+ * SNI_IDPROM_CPUTYPE  CPU Type on RM400
+ */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define __SNI_END 0
+#endif
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define __SNI_END 3
+#endif
+#define SNI_IDPROM_BASE        CKSEG1ADDR(0x1ff00000)
+#define SNI_IDPROM_MEMSIZE     (SNI_IDPROM_BASE + (0x28 ^ __SNI_END))
+#define SNI_IDPROM_BRDTYPE     (SNI_IDPROM_BASE + (0x29 ^ __SNI_END))
+#define SNI_IDPROM_CPUTYPE     (SNI_IDPROM_BASE + (0x30 ^ __SNI_END))
+
+#define SNI_IDPROM_SIZE	0x1000
 
 /* board specific init functions */
 extern void sni_a20r_init(void);
@@ -207,6 +227,9 @@ extern void sni_pcimt_irq_init(void);
 /* timer inits */
 extern void sni_cpu_time_init(void);
 
+/* eisa init for RM200/400 */
+extern int sni_eisa_root_init(void);
+
 /* common irq stuff */
 extern void (*sni_hwint)(void);
 extern struct irqaction sni_isa_irq;
