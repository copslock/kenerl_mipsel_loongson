Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:52:09 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:59965 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025174AbZETVv7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:51:59 +0100
Received: by pzk40 with SMTP id 40so624572pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:51:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eZ5tqsyFXNSZ+xzuFAc6yVoCix2G7+wSBYH7cr+jzMc=;
        b=wrzEUh9ROEn/xVKp1+huuwmhHRnIKMmZJOfeM3nnaLT8Bk8Pvg1WTSwxD4RoMSKHX3
         njah8whuOHlaQjXLL9FsMnenZtxUIRH/EK0LxuDrKpwEDT2RU4XUjhIml1V6Be8goDvY
         R6N3uY3PYMsrq92W783XIZgHAmpcuSpXTJh5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wh1O0EC2qcQsyyPnroZOE78YfO+VNvMObQRclQCOlrHhi3nG3FDTvnTR4ipYUUr9EA
         6Gt4Hbm0jWIyGJoCvo7x0LbThWbA5M/eSbOdnXSTMzg3Lw+QsFTE6fAq/ruhEsfgBnB3
         l1UAAvNam2ZVQOlyvfByL63jvYx/2vagNmCfw=
Received: by 10.142.125.4 with SMTP id x4mr644537wfc.315.1242856311814;
        Wed, 20 May 2009 14:51:51 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 29sm1156560wfg.8.2009.05.20.14.51.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:51:50 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 07/27] replace tons of magic numbers by understandable symbols
Date:	Thu, 21 May 2009 05:51:40 +0800
Message-Id: <a32a65a4b7c785030cc72adfa865db0311a4d52e.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

tons of magic numbers are replaced by understandable symbols, and two
new header files are added to support this substitution.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    3 ++
 arch/mips/include/asm/mach-loongson/machine.h  |   27 ++++++++++++++++++
 arch/mips/include/asm/mach-loongson/mem.h      |    8 +++++
 arch/mips/loongson/fuloong-2e/bonito-irq.c     |    3 +-
 arch/mips/loongson/fuloong-2e/dbg_io.c         |   12 +++----
 arch/mips/loongson/fuloong-2e/irq.c            |    7 ++--
 arch/mips/loongson/fuloong-2e/mem.c            |    9 +++--
 arch/mips/loongson/fuloong-2e/misc.c           |    4 ++-
 arch/mips/loongson/fuloong-2e/pci.c            |   36 ++++++++++++++++--------
 arch/mips/loongson/fuloong-2e/reset.c          |   19 +++++++-----
 arch/mips/loongson/fuloong-2e/setup.c          |    5 ++-
 11 files changed, 96 insertions(+), 37 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/machine.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mem.h

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index bce85a8..5ad629e 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -14,6 +14,9 @@
 #ifndef __LOONGSON_H
 #define __LOONGSON_H
 
+#include <linux/io.h>
+#include <linux/init.h>
+
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
 
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
new file mode 100644
index 0000000..5f2cd3a
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -0,0 +1,27 @@
+/*
+ * board-specific header file
+ *
+ * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
+ *
+ * This program is free software; you can redistribute it
+ * and/or modify it under the terms of the GNU General
+ * Public License as published by the Free Software
+ * Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MACHINE_H
+#define __MACHINE_H
+
+#define MACH_NAME			"lemote-fuloong(2e)"
+
+#define LOONGSON_UART_BASE		0x1fd003f8
+
+#define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)
+#define LOONGSON_UART_IRQ		(MIPS_CPU_IRQ_BASE + 4)
+#define LOONGSON_SOUTH_BRIDGE_IRQ 	(MIPS_CPU_IRQ_BASE + 5)
+#define LOONGSON_TIMER_IRQ        	(MIPS_CPU_IRQ_BASE + 7)
+#define LOONGSON_DMATIMEOUT_IRQ		(LOONGSON_IRQ_BASE + 10)
+
+
+#endif				/* ! __MACHINE_H */
diff --git a/arch/mips/include/asm/mach-loongson/mem.h b/arch/mips/include/asm/mach-loongson/mem.h
new file mode 100644
index 0000000..ad01dc2
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/mem.h
@@ -0,0 +1,8 @@
+#ifndef __MEM_H
+#define __MEM_H
+
+#define LOONGSON_HIGHMEM_START	0x20000000
+#define LOONGSON_MMIO_MEM_START 0x10000000
+#define LOONGSON_MMIO_MEM_END	0x20000000
+
+#endif	/* !__MEM_H */
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c b/arch/mips/loongson/fuloong-2e/bonito-irq.c
index 8a32651..1f43447 100644
--- a/arch/mips/loongson/fuloong-2e/bonito-irq.c
+++ b/arch/mips/loongson/fuloong-2e/bonito-irq.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 
 #include <loongson.h>
+#include <machine.h>
 
 static inline void bonito_irq_enable(unsigned int irq)
 {
@@ -64,5 +65,5 @@ void bonito_irq_init(void)
 	for (i = LOONGSON_IRQ_BASE; i < LOONGSON_IRQ_BASE + 32; i++)
 		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
 
-	setup_irq(LOONGSON_IRQ_BASE + 10, &dma_timeout_irqaction);
+	setup_irq(LOONGSON_DMATIMEOUT_IRQ, &dma_timeout_irqaction);
 }
diff --git a/arch/mips/loongson/fuloong-2e/dbg_io.c b/arch/mips/loongson/fuloong-2e/dbg_io.c
index 84f8320..1ace08f 100644
--- a/arch/mips/loongson/fuloong-2e/dbg_io.c
+++ b/arch/mips/loongson/fuloong-2e/dbg_io.c
@@ -28,12 +28,13 @@
  *
  */
 
-#include <linux/io.h>
-#include <linux/init.h>
 #include <linux/types.h>
 
 #include <asm/serial.h>
 
+#include <loongson.h>
+#include <machine.h>
+
 #define         UART16550_BAUD_2400             2400
 #define         UART16550_BAUD_4800             4800
 #define         UART16550_BAUD_9600             9600
@@ -59,11 +60,8 @@
 /* ----------------------------------------------------- */
 
 /* === CONFIG === */
-#ifdef CONFIG_64BIT
-#define         BASE                    (0xffffffffbfd003f8)
-#else
-#define         BASE                    (0xbfd003f8)
-#endif
+
+#define		BASE			ioremap_nocache(LOONGSON_UART_BASE, 8)
 
 #define         MAX_BAUD                BASE_BAUD
 /* === END OF CONFIG === */
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index edd1563..e04ff30 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -31,6 +31,7 @@
 #include <asm/i8259.h>
 
 #include <loongson.h>
+#include <machine.h>
 
 /*
  * the first level int-handler will jump here if it is a bonito irq
@@ -75,7 +76,7 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
 
 	if (pending & CAUSEF_IP7)
-		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+		do_IRQ(LOONGSON_TIMER_IRQ);
 	else if (pending & CAUSEF_IP5)
 		i8259_irqdispatch();
 	else if (pending & CAUSEF_IP2)
@@ -129,8 +130,8 @@ void __init arch_init_irq(void)
 	*/
 
 	/* bonito irq at IP2 */
-	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cascade_irqaction);
+	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &cascade_irqaction);
 	/* 8259 irq at IP5 */
-	setup_irq(MIPS_CPU_IRQ_BASE + 5, &cascade_irqaction);
+	setup_irq(LOONGSON_SOUTH_BRIDGE_IRQ, &cascade_irqaction);
 
 }
diff --git a/arch/mips/loongson/fuloong-2e/mem.c b/arch/mips/loongson/fuloong-2e/mem.c
index 2a0f4e6..7f6ee37 100644
--- a/arch/mips/loongson/fuloong-2e/mem.c
+++ b/arch/mips/loongson/fuloong-2e/mem.c
@@ -7,18 +7,18 @@
 
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/init.h>
 
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
+#include <mem.h>
 
 void __init prom_init_memory(void)
 {
 	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
 #ifdef CONFIG_64BIT
 	if (highmemsize > 0) {
-		add_memory_region(0x20000000,
+		add_memory_region(LOONGSON_HIGHMEM_START,
 				  highmemsize << 20, BOOT_MEM_RAM);
 	}
 #endif				/* CONFIG_64BIT */
@@ -34,6 +34,7 @@ int __uncached_access(struct file *file, unsigned long addr)
 	 * On the Lemote Loongson 2e system, the peripheral registers
 	 * reside between 0x1000:0000 and 0x2000:0000.
 	 */
-	return addr >= __pa(high_memory) ||
-		((addr >= 0x10000000) && (addr < 0x20000000));
+	return addr >= __pa(high_memory) || \
+		((addr >= LOONGSON_MMIO_MEM_START) && \
+			(addr < LOONGSON_MMIO_MEM_END));
 }
diff --git a/arch/mips/loongson/fuloong-2e/misc.c b/arch/mips/loongson/fuloong-2e/misc.c
index d9532ca..1b8044c 100644
--- a/arch/mips/loongson/fuloong-2e/misc.c
+++ b/arch/mips/loongson/fuloong-2e/misc.c
@@ -7,7 +7,9 @@
  * option) any later version.
  */
 
+#include <machine.h>
+
 const char *get_system_type(void)
 {
-	return "fuloong-2e";
+	return MACH_NAME;
 }
diff --git a/arch/mips/loongson/fuloong-2e/pci.c b/arch/mips/loongson/fuloong-2e/pci.c
index cfc09a1..89bc1af 100644
--- a/arch/mips/loongson/fuloong-2e/pci.c
+++ b/arch/mips/loongson/fuloong-2e/pci.c
@@ -55,25 +55,37 @@ static struct pci_controller  loongson_pci_controller = {
 static void __init ict_pcimap(void)
 {
 	/*
-	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
+	 * local to PCI mapping for CPU accessing PCI space
 	 *
 	 * CPU address space [256M,448M] is window for accessing pci space
-	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
-	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+	 * we set pcimap_lo[0,1,2] to map it to pci space[0M, 64M], [320M,448M]
+	 *
+	 * pcimap:  PCI_MAP2  PCI_Mem_Lo2 PCI_Mem_Lo1 PCI_Mem_Lo0
+	 *            [<2G]   [384M,448M] [320M,384M] [0M,64M]
 	 */
-	/* 1,00 0110 ,0001 01,00 0000 */
-	LOONGSON_PCIMAP = 0x46140;
-
-	/* 1, 00 0010, 0000,01, 00 0000 */
-	/* LOONGSON_PCIMAP = 0x42040; */
+	LOONGSON_PCIMAP = LOONGSON_PCIMAP_PCIMAP_2 |
+	    LOONGSON_PCIMAP_WIN(2, 0x18000000) |
+	    LOONGSON_PCIMAP_WIN(1, 0x14000000) |
+	    LOONGSON_PCIMAP_WIN(0, 0);
 
 	/*
-	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
+	 * PCI-DMA to local mapping: [2G,2G+256M] -> [0M,256M]
 	 */
-	LOONGSON_PCIBASE0 = 0x80000000;
-	LOONGSON_PCIBASE1 = 0x00800000;
-	LOONGSON_PCIBASE2 = 0x90000000;
+	LOONGSON_PCIBASE0 = 0x80000000ul;	/* base: 2G -> mmap: 0M */
+	/* size: 256M, burst transmission, pre-fetch enable, 64bit */
+	LOONGSON_PCI_HIT0_SEL_L = 0xc000000cul;
+	LOONGSON_PCI_HIT0_SEL_H = 0xfffffffful;
+	LOONGSON_PCI_HIT1_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
+	LOONGSON_PCI_HIT1_SEL_H = 0x00000000ul;
+	LOONGSON_PCI_HIT2_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
+	LOONGSON_PCI_HIT2_SEL_H = 0x00000000ul;
+
+	/* avoid deadlock of PCI reading/writing lock operation */
+	LOONGSON_PCI_ISR4C = 0xd2000001ul;
 
+	/* can not change gnt to break pci transfer when device's gnt not
+	deassert for some broken device */
+	LOONGSON_PXARB_CFG = 0x00fe0105ul;
 }
 
 static int __init pcibios_init(void)
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson/fuloong-2e/reset.c
index 769a2ce..87244a1 100644
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -6,21 +6,24 @@
  *
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (c) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin, wuzj@lemote.com
  */
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
+#include <loongson.h>
 
 static void loongson_restart(char *command)
 {
-#ifdef CONFIG_32BIT
-	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xbfe00104 |= (1 << 2);
-#else
-	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
-#endif
-	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
+	LOONGSON_GENCFG &= ~LOONGSON_GENCFG_CPUSELFRESET;
+	LOONGSON_GENCFG |= LOONGSON_GENCFG_CPUSELFRESET;
+
+	/* reboot via jumping to 0xbfc00000 */
+	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
 }
 
 static void loongson_halt(void)
diff --git a/arch/mips/loongson/fuloong-2e/setup.c b/arch/mips/loongson/fuloong-2e/setup.c
index 770d7b5..4fcbe48 100644
--- a/arch/mips/loongson/fuloong-2e/setup.c
+++ b/arch/mips/loongson/fuloong-2e/setup.c
@@ -27,7 +27,10 @@ static void loongson_wbflush(void)
 	asm(".set\tpush\n\t"
 	    ".set\tnoreorder\n\t"
 	    ".set mips3\n\t"
-	    "sync\n\t" "nop\n\t" ".set\tpop\n\t" ".set mips0\n\t");
+	    "sync\n\t"
+	    "nop\n\t"
+	    ".set\tpop\n\t"
+	    ".set mips0\n\t");
 }
 
 void __init loongson_wbflush_setup(void)
-- 
1.6.2.1
