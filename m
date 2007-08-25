Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2007 18:53:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9886 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025454AbXHYRxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Aug 2007 18:53:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7PHrq5A007378
	for <linux-mips@linux-mips.org>; Sat, 25 Aug 2007 18:53:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7PHrqQL007377
	for linux-mips@linux-mips.org; Sat, 25 Aug 2007 18:53:52 +0100
Date:	Sat, 25 Aug 2007 18:53:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [tsbogend@alpha.franken.de: [PATCH] JAZZ fixes]
Message-ID: <20070825175352.GA7332@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

----- Forwarded message from Thomas Bogendoerfer <tsbogend@alpha.franken.de> -----

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Sat, 25 Aug 2007 11:01:50 +0200
To: ralf@linux-mips.org
Subject: [PATCH] JAZZ fixes
Content-Type: text/plain; charset=us-ascii


- restructured irq handling
- switched vdma to use memory allocated via get_free_pages
- setup platform devices for serial, jazz_esp and jazzsonic
- fixed cmos rtc access

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5bde1ad..5e7efdc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -93,6 +93,7 @@ config MACH_JAZZ
 	select ARC32
 	select ARCH_MAY_HAVE_PC_FDC
 	select GENERIC_ISA_DMA
+	select IRQ_CPU
 	select I8259
 	select ISA
 	select PCSPEAKER
diff --git a/arch/mips/jazz/Makefile b/arch/mips/jazz/Makefile
index 575a944..5aee0c2 100644
--- a/arch/mips/jazz/Makefile
+++ b/arch/mips/jazz/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the Jazz family specific parts of the kernel
 #
 
-obj-y	 	:= irq.o jazzdma.o jazz-platform.o reset.o setup.o
+obj-y	 	:= irq.o jazzdma.o reset.o setup.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 015cf4b..5623541 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -11,15 +11,17 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#include <asm/irq_cpu.h>
 #include <asm/i8259.h>
 #include <asm/io.h>
 #include <asm/jazz.h>
+#include <asm/pgtable.h>
 
 static DEFINE_SPINLOCK(r4030_lock);
 
 static void enable_r4030_irq(unsigned int irq)
 {
-	unsigned int mask = 1 << (irq - JAZZ_PARALLEL_IRQ);
+	unsigned int mask = 1 << (irq - JAZZ_IRQ_START);
 	unsigned long flags;
 
 	spin_lock_irqsave(&r4030_lock, flags);
@@ -30,7 +32,7 @@ static void enable_r4030_irq(unsigned int irq)
 
 void disable_r4030_irq(unsigned int irq)
 {
-	unsigned int mask = ~(1 << (irq - JAZZ_PARALLEL_IRQ));
+	unsigned int mask = ~(1 << (irq - JAZZ_IRQ_START));
 	unsigned long flags;
 
 	spin_lock_irqsave(&r4030_lock, flags);
@@ -51,7 +53,7 @@ void __init init_r4030_ints(void)
 {
 	int i;
 
-	for (i = JAZZ_PARALLEL_IRQ; i <= JAZZ_TIMER_IRQ; i++)
+	for (i = JAZZ_IRQ_START; i <= JAZZ_IRQ_END; i++)
 		set_irq_chip_and_handler(i, &r4030_irq_type, handle_level_irq);
 
 	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE, 0);
@@ -66,82 +68,40 @@ void __init init_r4030_ints(void)
  */
 void __init arch_init_irq(void)
 {
+	/*
+	 * this is a hack to get back the still needed wired mapping
+	 * killed by init_mm()
+	 */
+
+	/* Map 0xe0000000 -> 0x0:800005C0, 0xe0010000 -> 0x1:30000580 */
+	add_wired_entry(0x02000017, 0x03c00017, 0xe0000000, PM_64K);
+	/* Map 0xe2000000 -> 0x0:900005C0, 0xe3010000 -> 0x0:910005C0 */
+	add_wired_entry(0x02400017, 0x02440017, 0xe2000000, PM_16M);
+	/* Map 0xe4000000 -> 0x0:600005C0, 0xe4100000 -> 400005C0 */
+	add_wired_entry(0x01800017, 0x01000017, 0xe4000000, PM_4M);
+
 	init_i8259_irqs();			/* Integrated i8259  */
+	mips_cpu_irq_init();
 	init_r4030_ints();
 
-	change_c0_status(ST0_IM, IE_IRQ4 | IE_IRQ3 | IE_IRQ2 | IE_IRQ1);
-}
-
-static void loc_call(unsigned int irq, unsigned int mask)
-{
-	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE,
-	                  r4030_read_reg16(JAZZ_IO_IRQ_ENABLE) & mask);
-	do_IRQ(irq);
-	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE,
-	                  r4030_read_reg16(JAZZ_IO_IRQ_ENABLE) | mask);
-}
-
-static void ll_local_dev(void)
-{
-	switch (r4030_read_reg32(JAZZ_IO_IRQ_SOURCE)) {
-	case 0:
-		panic("Unimplemented loc_no_irq handler");
-		break;
-	case 4:
-		loc_call(JAZZ_PARALLEL_IRQ, JAZZ_IE_PARALLEL);
-		break;
-	case 8:
-		loc_call(JAZZ_PARALLEL_IRQ, JAZZ_IE_FLOPPY);
-		break;
-	case 12:
-		panic("Unimplemented loc_sound handler");
-		break;
-	case 16:
-		panic("Unimplemented loc_video handler");
-		break;
-	case 20:
-		loc_call(JAZZ_ETHERNET_IRQ, JAZZ_IE_ETHERNET);
-		break;
-	case 24:
-		loc_call(JAZZ_SCSI_IRQ, JAZZ_IE_SCSI);
-		break;
-	case 28:
-		loc_call(JAZZ_KEYBOARD_IRQ, JAZZ_IE_KEYBOARD);
-		break;
-	case 32:
-		loc_call(JAZZ_MOUSE_IRQ, JAZZ_IE_MOUSE);
-		break;
-	case 36:
-		loc_call(JAZZ_SERIAL1_IRQ, JAZZ_IE_SERIAL1);
-		break;
-	case 40:
-		loc_call(JAZZ_SERIAL2_IRQ, JAZZ_IE_SERIAL2);
-		break;
-	}
+	change_c0_status(ST0_IM, IE_IRQ2 | IE_IRQ1);
 }
 
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_cause() & read_c0_status();
+	unsigned int irq;
 
-	if (pending & IE_IRQ5)
-		write_c0_compare(0);
-	else if (pending & IE_IRQ4) {
+	if (pending & IE_IRQ4) {
 		r4030_read_reg32(JAZZ_TIMER_REGISTER);
 		do_IRQ(JAZZ_TIMER_IRQ);
-	} else if (pending & IE_IRQ3)
-		panic("Unimplemented ISA NMI handler");
-	else if (pending & IE_IRQ2)
+	} else if (pending & IE_IRQ2)
 		do_IRQ(r4030_read_reg32(JAZZ_EISA_IRQ_ACK));
 	else if (pending & IE_IRQ1) {
-		ll_local_dev();
-	} else if (unlikely(pending & IE_IRQ0))
-		panic("Unimplemented local_dma handler");
-	else if (pending & IE_SW1) {
-		clear_c0_cause(IE_SW1);
-		panic("Unimplemented sw1 handler");
-	} else if (pending & IE_SW0) {
-		clear_c0_cause(IE_SW0);
-		panic("Unimplemented sw0 handler");
+		irq = *(volatile u8 *)JAZZ_IO_IRQ_SOURCE >> 2;
+		if (likely(irq > 0))
+			do_IRQ(irq + JAZZ_IRQ_START - 1);
+		else
+			panic("Unimplemented loc_no_irq handler");
 	}
 }
diff --git a/arch/mips/jazz/jazz-platform.c b/arch/mips/jazz/jazz-platform.c
deleted file mode 100644
index fd73670..0000000
--- a/arch/mips/jazz/jazz-platform.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/serial_8250.h>
-
-#include <asm/jazz.h>
-
-/*
- * Confusion ...  It seems the original Microsoft Jazz machine used to have a
- * 4.096MHz clock for its UART while the MIPS Magnum and Millenium systems
- * had 8MHz.  The Olivetti M700-10 and the Acer PICA have 1.8432MHz like PCs.
- */
-#ifdef CONFIG_OLIVETTI_M700
-#define JAZZ_BASE_BAUD 1843200
-#else
-#define JAZZ_BASE_BAUD	8000000	/* 3072000 */
-#endif
-
-#define JAZZ_UART_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP)
-
-#define JAZZ_PORT(base, int)						\
-{									\
-	.mapbase	= base,						\
-	.irq		= int,						\
-	.uartclk	= JAZZ_BASE_BAUD,				\
-	.iotype		= UPIO_MEM,					\
-	.flags		= JAZZ_UART_FLAGS,				\
-	.regshift	= 0,						\
-}
-
-static struct plat_serial8250_port uart8250_data[] = {
-	JAZZ_PORT(JAZZ_SERIAL1_BASE, JAZZ_SERIAL1_IRQ),
-	JAZZ_PORT(JAZZ_SERIAL2_BASE, JAZZ_SERIAL2_IRQ),
-	{ },
-};
-
-static struct platform_device uart8250_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= uart8250_data,
-	},
-};
-
-static int __init uart8250_init(void)
-{
-	return platform_device_register(&uart8250_device);
-}
-
-module_init(uart8250_init);
-
-MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("8250 UART probe driver for the Jazz family");
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index e8e0ffb..c672c08 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -27,7 +27,7 @@
  */
 #define CONF_DEBUG_VDMA 0
 
-static unsigned long vdma_pagetable_start;
+static VDMA_PGTBL_ENTRY *pgtbl;
 
 static DEFINE_SPINLOCK(vdma_lock);
 
@@ -46,7 +46,6 @@ static int debuglvl = 3;
  */
 static inline void vdma_pgtbl_init(void)
 {
-	VDMA_PGTBL_ENTRY *pgtbl = (VDMA_PGTBL_ENTRY *) vdma_pagetable_start;
 	unsigned long paddr = 0;
 	int i;
 
@@ -60,31 +59,31 @@ static inline void vdma_pgtbl_init(void)
 /*
  * Initialize the Jazz R4030 dma controller
  */
-void __init vdma_init(void)
+static int __init vdma_init(void)
 {
 	/*
 	 * Allocate 32k of memory for DMA page tables.  This needs to be page
 	 * aligned and should be uncached to avoid cache flushing after every
 	 * update.
 	 */
-	vdma_pagetable_start =
-		(unsigned long) alloc_bootmem_low_pages(VDMA_PGTBL_SIZE);
-	if (!vdma_pagetable_start)
+	pgtbl = (VDMA_PGTBL_ENTRY *)__get_free_pages(GFP_KERNEL | GFP_DMA,
+						    get_order(VDMA_PGTBL_SIZE));
+	if (!pgtbl)
 		BUG();
-	dma_cache_wback_inv(vdma_pagetable_start, VDMA_PGTBL_SIZE);
-	vdma_pagetable_start = KSEG1ADDR(vdma_pagetable_start);
+	dma_cache_wback_inv((unsigned long)pgtbl, VDMA_PGTBL_SIZE);
+	pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
 
 	/*
 	 * Clear the R4030 translation table
 	 */
 	vdma_pgtbl_init();
 
-	r4030_write_reg32(JAZZ_R4030_TRSTBL_BASE,
-			  CPHYSADDR(vdma_pagetable_start));
+	r4030_write_reg32(JAZZ_R4030_TRSTBL_BASE, CPHYSADDR(pgtbl));
 	r4030_write_reg32(JAZZ_R4030_TRSTBL_LIM, VDMA_PGTBL_SIZE);
 	r4030_write_reg32(JAZZ_R4030_TRSTBL_INV, 0);
 
-	printk("VDMA: R4030 DMA pagetables initialized.\n");
+	printk(KERN_INFO "VDMA: R4030 DMA pagetables initialized.\n");
+	return 0;
 }
 
 /*
@@ -92,7 +91,6 @@ void __init vdma_init(void)
  */
 unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 {
-	VDMA_PGTBL_ENTRY *entry = (VDMA_PGTBL_ENTRY *) vdma_pagetable_start;
 	int first, last, pages, frame, i;
 	unsigned long laddr, flags;
 
@@ -114,10 +112,10 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 	/*
 	 * Find free chunk
 	 */
-	pages = (size + 4095) >> 12;	/* no. of pages to allocate */
+	pages = VDMA_PAGE(paddr + size) - VDMA_PAGE(paddr) + 1;
 	first = 0;
 	while (1) {
-		while (entry[first].owner != VDMA_PAGE_EMPTY &&
+		while (pgtbl[first].owner != VDMA_PAGE_EMPTY &&
 		       first < VDMA_PGTBL_ENTRIES) first++;
 		if (first + pages > VDMA_PGTBL_ENTRIES) {	/* nothing free */
 			spin_unlock_irqrestore(&vdma_lock, flags);
@@ -125,12 +123,13 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		}
 
 		last = first + 1;
-		while (entry[last].owner == VDMA_PAGE_EMPTY
+		while (pgtbl[last].owner == VDMA_PAGE_EMPTY
 		       && last - first < pages)
 			last++;
 
 		if (last - first == pages)
 			break;	/* found */
+		first = last + 1;
 	}
 
 	/*
@@ -140,8 +139,8 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 	frame = paddr & ~(VDMA_PAGESIZE - 1);
 
 	for (i = first; i < last; i++) {
-		entry[i].frame = frame;
-		entry[i].owner = laddr;
+		pgtbl[i].frame = frame;
+		pgtbl[i].owner = laddr;
 		frame += VDMA_PAGESIZE;
 	}
 
@@ -160,10 +159,10 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 			printk("%08x ", i << 12);
 		printk("\nPADDR: ");
 		for (i = first; i < last; i++)
-			printk("%08x ", entry[i].frame);
+			printk("%08x ", pgtbl[i].frame);
 		printk("\nOWNER: ");
 		for (i = first; i < last; i++)
-			printk("%08x ", entry[i].owner);
+			printk("%08x ", pgtbl[i].owner);
 		printk("\n");
 	}
 
@@ -181,7 +180,6 @@ EXPORT_SYMBOL(vdma_alloc);
  */
 int vdma_free(unsigned long laddr)
 {
-	VDMA_PGTBL_ENTRY *pgtbl = (VDMA_PGTBL_ENTRY *) vdma_pagetable_start;
 	int i;
 
 	i = laddr >> 12;
@@ -213,8 +211,6 @@ EXPORT_SYMBOL(vdma_free);
  */
 int vdma_remap(unsigned long laddr, unsigned long paddr, unsigned long size)
 {
-	VDMA_PGTBL_ENTRY *pgtbl =
-	    (VDMA_PGTBL_ENTRY *) vdma_pagetable_start;
 	int first, pages, npages;
 
 	if (laddr > 0xffffff) {
@@ -289,8 +285,6 @@ unsigned long vdma_phys2log(unsigned long paddr)
 {
 	int i;
 	int frame;
-	VDMA_PGTBL_ENTRY *pgtbl =
-	    (VDMA_PGTBL_ENTRY *) vdma_pagetable_start;
 
 	frame = paddr & ~(VDMA_PAGESIZE - 1);
 
@@ -312,9 +306,6 @@ EXPORT_SYMBOL(vdma_phys2log);
  */
 unsigned long vdma_log2phys(unsigned long laddr)
 {
-	VDMA_PGTBL_ENTRY *pgtbl =
-	    (VDMA_PGTBL_ENTRY *) vdma_pagetable_start;
-
 	return pgtbl[laddr >> 12].frame + (laddr & (VDMA_PAGESIZE - 1));
 }
 
@@ -564,3 +555,5 @@ int vdma_get_enable(int channel)
 
 	return enable;
 }
+
+arch_initcall(vdma_init);
diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
index 798279e..5c6271a 100644
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 1996, 1997, 1998, 2001 by Ralf Baechle
  * Copyright (C) 2001 MIPS Technologies, Inc.
+ * Copyright (C) 2007 by Thomas Bogendoerfer
  */
 #include <linux/eisa.h>
 #include <linux/hdreg.h>
@@ -20,6 +21,8 @@
 #include <linux/ide.h>
 #include <linux/pm.h>
 #include <linux/screen_info.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
 
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
@@ -30,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/time.h>
 #include <asm/traps.h>
+#include <asm/mc146818-time.h>
 
 extern asmlinkage void jazz_handle_int(void);
 
@@ -72,10 +76,8 @@ void __init plat_mem_setup(void)
 
 	/* Map 0xe0000000 -> 0x0:800005C0, 0xe0010000 -> 0x1:30000580 */
 	add_wired_entry (0x02000017, 0x03c00017, 0xe0000000, PM_64K);
-
 	/* Map 0xe2000000 -> 0x0:900005C0, 0xe3010000 -> 0x0:910005C0 */
 	add_wired_entry (0x02400017, 0x02440017, 0xe2000000, PM_16M);
-
 	/* Map 0xe4000000 -> 0x0:600005C0, 0xe4100000 -> 400005C0 */
 	add_wired_entry (0x01800017, 0x01000017, 0xe4000000, PM_4M);
 
@@ -94,6 +96,7 @@ void __init plat_mem_setup(void)
 
 	_machine_restart = jazz_machine_restart;
 
+#ifdef CONFIG_VT
 	screen_info = (struct screen_info) {
 		0, 0,		/* orig-x, orig-y */
 		0,		/* unused */
@@ -105,6 +108,112 @@ void __init plat_mem_setup(void)
 		0,		/* orig_video_isVGA */
 		16		/* orig_video_points */
 	};
+#endif
 
-	vdma_init();
+	add_preferred_console("ttyS", 0, "9600");
 }
+
+#ifdef CONFIG_OLIVETTI_M700
+#define UART_CLK  1843200
+#else
+/* Some Jazz machines seem to have an 8MHz crystal clock but I don't know
+   exactly which ones ... XXX */
+#define UART_CLK (8000000 / 16) /* ( 3072000 / 16) */
+#endif
+
+#define MEMPORT(_base, _irq)				\
+	{						\
+		.mapbase	= (_base),		\
+		.membase	= (void *)(_base),	\
+		.irq		= (_irq),		\
+		.uartclk	= UART_CLK,		\
+		.iotype		= UPIO_MEM,		\
+		.flags		= UPF_BOOT_AUTOCONF,	\
+	}
+
+static struct plat_serial8250_port jazz_serial_data[] = {
+	MEMPORT(JAZZ_SERIAL1_BASE, JAZZ_SERIAL1_IRQ),
+	MEMPORT(JAZZ_SERIAL2_BASE, JAZZ_SERIAL2_IRQ),
+	{ },
+};
+
+static struct platform_device jazz_serial8250_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev			= {
+		.platform_data	= jazz_serial_data,
+	},
+};
+
+static struct resource jazz_esp_rsrc[] = {
+	{
+		.start = JAZZ_SCSI_BASE,
+		.end   = JAZZ_SCSI_BASE + 31,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.start = JAZZ_SCSI_DMA,
+		.end   = JAZZ_SCSI_DMA,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.start = JAZZ_SCSI_IRQ,
+		.end   = JAZZ_SCSI_IRQ,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct platform_device jazz_esp_pdev = {
+	.name           = "jazz_esp",
+	.num_resources  = ARRAY_SIZE(jazz_esp_rsrc),
+	.resource       = jazz_esp_rsrc
+};
+
+static struct resource jazz_sonic_rsrc[] = {
+	{
+		.start = JAZZ_ETHERNET_BASE,
+		.end   = JAZZ_ETHERNET_BASE + 0xff,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.start = JAZZ_ETHERNET_IRQ,
+		.end   = JAZZ_ETHERNET_IRQ,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct platform_device jazz_sonic_pdev = {
+	.name           = "jazzsonic",
+	.num_resources  = ARRAY_SIZE(jazz_sonic_rsrc),
+	.resource       = jazz_sonic_rsrc
+};
+
+static struct resource jazz_cmos_rsrc[] = {
+	{
+		.start = 0x70,
+		.end   = 0x71,
+		.flags = IORESOURCE_IO
+	},
+	{
+		.start = 8,
+		.end   = 8,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct platform_device jazz_cmos_pdev = {
+	.name           = "rtc_cmos",
+	.num_resources  = ARRAY_SIZE(jazz_cmos_rsrc),
+	.resource       = jazz_cmos_rsrc
+};
+
+static int __init jazz_setup_devinit(void)
+{
+	platform_device_register(&jazz_serial8250_device);
+	platform_device_register(&jazz_esp_pdev);
+	platform_device_register(&jazz_sonic_pdev);
+	platform_device_register(&jazz_cmos_pdev);
+	return 0;
+}
+
+device_initcall(jazz_setup_devinit);
diff --git a/include/asm-mips/jazz.h b/include/asm-mips/jazz.h
index 81cbf00..83f449d 100644
--- a/include/asm-mips/jazz.h
+++ b/include/asm-mips/jazz.h
@@ -185,37 +185,25 @@ typedef struct {
 #define JAZZ_IO_IRQ_ENABLE      0xe0010002
 
 /*
- * JAZZ interrupt enable bits
- */
-#define JAZZ_IE_PARALLEL            (1 << 0)
-#define JAZZ_IE_FLOPPY              (1 << 1)
-#define JAZZ_IE_SOUND               (1 << 2)
-#define JAZZ_IE_VIDEO               (1 << 3)
-#define JAZZ_IE_ETHERNET            (1 << 4)
-#define JAZZ_IE_SCSI                (1 << 5)
-#define JAZZ_IE_KEYBOARD            (1 << 6)
-#define JAZZ_IE_MOUSE               (1 << 7)
-#define JAZZ_IE_SERIAL1             (1 << 8)
-#define JAZZ_IE_SERIAL2             (1 << 9)
-
-/*
  * JAZZ Interrupt Level definitions
  *
  * This is somewhat broken.  For reasons which nobody can remember anymore
  * we remap the Jazz interrupts to the usual ISA style interrupt numbers.
  */
-#define JAZZ_PARALLEL_IRQ       16
-#define JAZZ_FLOPPY_IRQ         17
-#define JAZZ_SOUND_IRQ          18
-#define JAZZ_VIDEO_IRQ          19
-#define JAZZ_ETHERNET_IRQ       20
-#define JAZZ_SCSI_IRQ           21
-#define JAZZ_KEYBOARD_IRQ       22
-#define JAZZ_MOUSE_IRQ          23
-#define JAZZ_SERIAL1_IRQ        24
-#define JAZZ_SERIAL2_IRQ        25
-
-#define JAZZ_TIMER_IRQ          31
+#define JAZZ_IRQ_START          24
+#define JAZZ_IRQ_END            (24 + 9)
+#define JAZZ_PARALLEL_IRQ       (JAZZ_IRQ_START + 0)
+#define JAZZ_FLOPPY_IRQ         (JAZZ_IRQ_START + 1)
+#define JAZZ_SOUND_IRQ          (JAZZ_IRQ_START + 2)
+#define JAZZ_VIDEO_IRQ          (JAZZ_IRQ_START + 3)
+#define JAZZ_ETHERNET_IRQ       (JAZZ_IRQ_START + 4)
+#define JAZZ_SCSI_IRQ           (JAZZ_IRQ_START + 5)
+#define JAZZ_KEYBOARD_IRQ       (JAZZ_IRQ_START + 6)
+#define JAZZ_MOUSE_IRQ          (JAZZ_IRQ_START + 7)
+#define JAZZ_SERIAL1_IRQ        (JAZZ_IRQ_START + 8)
+#define JAZZ_SERIAL2_IRQ        (JAZZ_IRQ_START + 9)
+
+#define JAZZ_TIMER_IRQ          (MIPS_CPU_IRQ_BASE+6)
 
 
 /*
diff --git a/include/asm-mips/jazzdma.h b/include/asm-mips/jazzdma.h
index 0a205b7..8bb37bb 100644
--- a/include/asm-mips/jazzdma.h
+++ b/include/asm-mips/jazzdma.h
@@ -7,7 +7,6 @@
 /*
  * Prototypes and macros
  */
-extern void vdma_init(void);
 extern unsigned long vdma_alloc(unsigned long paddr, unsigned long size);
 extern int vdma_free(unsigned long laddr);
 extern int vdma_remap(unsigned long laddr, unsigned long paddr,
diff --git a/include/asm-mips/mach-jazz/mc146818rtc.h b/include/asm-mips/mach-jazz/mc146818rtc.h
index f44fdba..987f727 100644
--- a/include/asm-mips/mach-jazz/mc146818rtc.h
+++ b/include/asm-mips/mach-jazz/mc146818rtc.h
@@ -4,12 +4,15 @@
  * for more details.
  *
  * Copyright (C) 1998, 2001, 03 by Ralf Baechle
+ * Copyright (C) 2007 Thomas Bogendoerfer
  *
  * RTC routines for Jazz style attached Dallas chip.
  */
 #ifndef __ASM_MACH_JAZZ_MC146818RTC_H
 #define __ASM_MACH_JAZZ_MC146818RTC_H
 
+#include <linux/delay.h>
+
 #include <asm/io.h>
 #include <asm/jazz.h>
 
@@ -19,16 +22,17 @@
 static inline unsigned char CMOS_READ(unsigned long addr)
 {
 	outb_p(addr, RTC_PORT(0));
-
-	return *(char *)JAZZ_RTC_BASE;
+	return *(volatile char *)JAZZ_RTC_BASE;
 }
 
 static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 {
 	outb_p(addr, RTC_PORT(0));
-	*(char *)JAZZ_RTC_BASE = data;
+	*(volatile char *)JAZZ_RTC_BASE = data;
 }
 
 #define RTC_ALWAYS_BCD	0
 
+#define mc146818_decode_year(year) ((year) + 1980)
+
 #endif /* __ASM_MACH_JAZZ_MC146818RTC_H */

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

----- End forwarded message -----

  Ralf
