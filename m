Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:04:21 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:41588 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023275AbZEOWEP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:04:15 +0100
Received: by pxi17 with SMTP id 17so1365238pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:04:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=jIqLLj7ErGqj3ud0bHtu12L4B1sQOwyGAteOCc08wpQ=;
        b=jPHi5ZvWc1q9750ZOJna5WcWrGrP/1avTrZKgjAWyzto6y5JcXh2nfANEnHnYHNlNK
         aymev+RWexXGH3sv46JovEMYbI7/Kxdwnz8UhKO5G9DoFepE6auFXgEPDtK5VB3Q0t+g
         /nUDRFPkDnLZ92UXucqCB4sHCW435yvc/66TA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=dD/AgyZSt9YDaDNxm1Bh/j1XJ/nOVLLAOIVSE/aCUL2H5/yOgCEH3VlAwj8ALqsh4z
         8fSjCzjWVExZHB2BcYy9JUJ6tRJHi/HNrXwR44WrkU8v2296k156hpTVHCxNYpt34B7W
         UXMeVsp9jakcoDORJHJow6os8vITKZaynAUNo=
Received: by 10.115.48.12 with SMTP id a12mr5779400wak.161.1242425048285;
        Fri, 15 May 2009 15:04:08 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id v39sm1962927wah.31.2009.05.15.15.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:04:07 -0700 (PDT)
Subject: [PATCH 07/30] loongson: replace tons of magic numbers to symbols
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:04:01 +0800
Message-Id: <1242425041.10164.147.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 7aac74a4bca17af89ef550be44a665851e2ca773 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 00:13:51 +0800
Subject: [PATCH 07/30] loongson: replace tons of magic numbers to
symbols

---
 arch/mips/include/asm/mach-loongson/machine.h |   27 +++++++++++++++++
 arch/mips/include/asm/mach-loongson/mem.h     |    8 +++++
 arch/mips/loongson/fuloong-2e/bonito-irq.c    |    4 +-
 arch/mips/loongson/fuloong-2e/dbg_io.c        |    9 ++---
 arch/mips/loongson/fuloong-2e/irq.c           |    8 ++--
 arch/mips/loongson/fuloong-2e/mem.c           |    6 ++-
 arch/mips/loongson/fuloong-2e/misc.c          |    4 ++-
 arch/mips/loongson/fuloong-2e/pci.c           |   40
+++++++++++++++----------
 arch/mips/loongson/fuloong-2e/reset.c         |   16 +++++-----
 arch/mips/loongson/fuloong-2e/setup.c         |    5 ++-
 10 files changed, 88 insertions(+), 39 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/machine.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mem.h

diff --git a/arch/mips/include/asm/mach-loongson/machine.h
b/arch/mips/include/asm/mach-loongson/machine.h
new file mode 100644
index 0000000..3614619
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
+#define LOONGSON_DMATIMEOUT_IRQ   	(LOONGSON_IRQ_BASE + 10) 
+
+
+#endif				/* ! __MACHINE_H */
diff --git a/arch/mips/include/asm/mach-loongson/mem.h
b/arch/mips/include/asm/mach-loongson/mem.h
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
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c
b/arch/mips/loongson/fuloong-2e/bonito-irq.c
index cd7d3d1..61f473d 100644
--- a/arch/mips/loongson/fuloong-2e/bonito-irq.c
+++ b/arch/mips/loongson/fuloong-2e/bonito-irq.c
@@ -31,7 +31,7 @@
 #include <linux/interrupt.h>
 
 #include <loongson.h>
-
+#include <machine.h>
 
 static inline void bonito_irq_enable(unsigned int irq)
 {
@@ -66,5 +66,5 @@ void bonito_irq_init(void)
 		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
 	}
 
-	setup_irq(LOONGSON_IRQ_BASE + 10, &dma_timeout_irqaction);
+	setup_irq(LOONGSON_DMATIMEOUT_IRQ, &dma_timeout_irqaction);
 }
diff --git a/arch/mips/loongson/fuloong-2e/dbg_io.c
b/arch/mips/loongson/fuloong-2e/dbg_io.c
index 3ad3a49..3eab7e6 100644
--- a/arch/mips/loongson/fuloong-2e/dbg_io.c
+++ b/arch/mips/loongson/fuloong-2e/dbg_io.c
@@ -34,6 +34,8 @@
 
 #include <asm/serial.h>
 
+#include <machine.h>
+
 #define         UART16550_BAUD_2400             2400
 #define         UART16550_BAUD_4800             4800
 #define         UART16550_BAUD_9600             9600
@@ -59,11 +61,8 @@
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
diff --git a/arch/mips/loongson/fuloong-2e/irq.c
b/arch/mips/loongson/fuloong-2e/irq.c
index e764a4e..1d5ddb6 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -31,7 +31,7 @@
 #include <asm/i8259.h>
 
 #include <loongson.h>
-
+#include <machine.h>
 
 /*
  * the first level int-handler will jump here if it is a bonito irq
@@ -78,7 +78,7 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
 
 	if (pending & CAUSEF_IP7) {
-		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+		do_IRQ(LOONGSON_TIMER_IRQ);
 	} else if (pending & CAUSEF_IP5) {
 		i8259_irqdispatch();
 	} else if (pending & CAUSEF_IP2) {
@@ -135,8 +135,8 @@ void __init arch_init_irq(void)
 	*/
 
 	/* bonito irq at IP2 */
-	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cascade_irqaction);
+	setup_irq(LOONGSON_NORTH_BRIDGE_IRQ, &cascade_irqaction);
 	/* 8259 irq at IP5 */
-	setup_irq(MIPS_CPU_IRQ_BASE + 5, &cascade_irqaction);
+	setup_irq(LOONGSON_SOUTH_BRIDGE_IRQ, &cascade_irqaction);
 
 }
diff --git a/arch/mips/loongson/fuloong-2e/mem.c
b/arch/mips/loongson/fuloong-2e/mem.c
index f5d7372..52e5357 100644
--- a/arch/mips/loongson/fuloong-2e/mem.c
+++ b/arch/mips/loongson/fuloong-2e/mem.c
@@ -11,6 +11,8 @@
 
 #include <asm/bootinfo.h>
 
+#include <mem.h>
+
 extern unsigned int memsize, highmemsize;
 
 void __init prom_init_memory(void)
@@ -18,7 +20,7 @@ void __init prom_init_memory(void)
 	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
 #ifdef CONFIG_64BIT
 	if (highmemsize > 0) {
-		add_memory_region(0x20000000,
+		add_memory_region(LOONGSON_HIGHMEM_START,
 				  highmemsize << 20, BOOT_MEM_RAM);
 	}
 #endif				/* CONFIG_64BIT */
@@ -35,5 +37,5 @@ int __uncached_access(struct file *file, unsigned long
addr)
 	 * reside between 0x1000:0000 and 0x2000:0000.
 	 */
 	return addr >= __pa(high_memory) ||
-		((addr >= 0x10000000) && (addr < 0x20000000));
+		((addr >= LOONGSON_MMIO_MEM_START) && (addr <
LOONGSON_MMIO_MEM_END));
 }
diff --git a/arch/mips/loongson/fuloong-2e/misc.c
b/arch/mips/loongson/fuloong-2e/misc.c
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
diff --git a/arch/mips/loongson/fuloong-2e/pci.c
b/arch/mips/loongson/fuloong-2e/pci.c
index 1a7b4e9..9cd71bc 100644
--- a/arch/mips/loongson/fuloong-2e/pci.c
+++ b/arch/mips/loongson/fuloong-2e/pci.c
@@ -58,35 +58,43 @@ static struct pci_controller
loongson_pci_controller = {
 static void __init ict_pcimap(void)
 {
 	/*
-	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
+	 * local to PCI mapping for CPU accessing PCI space
 	 *
 	 * CPU address space [256M,448M] is window for accessing pci space
-	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
-	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+	 * we set pcimap_lo[0,1,2] to map it to pci space[0M,64M], [320M,448M]
+	 *
+	 * pcimap: PCI_MAP2  PCI_Mem_Lo2 PCI_Mem_Lo1 PCI_Mem_Lo0
+	 *           [<2G]   [384M,448M] [320M,384M] [0M,64M]
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
+	LOONGSON_PCI_HIT0_SEL_L = 0xc000000cul;	/* size: 256M, burst
transmission, pre-fetch enable, 64bit */
+	LOONGSON_PCI_HIT0_SEL_H = 0xfffffffful;
+	LOONGSON_PCI_HIT1_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
+	LOONGSON_PCI_HIT1_SEL_H = 0x00000000ul;
+	LOONGSON_PCI_HIT2_SEL_L = 0x00000006ul;	/* set this BAR as invalid */
+	LOONGSON_PCI_HIT2_SEL_H = 0x00000000ul;
+
+	/* avoid deadlock of PCI reading/writing lock operation */
+	LOONGSON_PCI_ISR4C = 0xd2000001ul;
 
+	/* can not change gnt to break pci transfer when device's gnt not
deassert
+	   for some broken device */
+	LOONGSON_PXARB_CFG = 0x00fe0105ul;
 }
 
 static int __init pcibios_init(void)
 {
 	ict_pcimap();
 
-	loongson_pci_controller.io_map_base =
-	    (unsigned long) ioremap(LOONGSON_IO_PORT_BASE,
-				    loongson_pci_io_resource.end -
-				    loongson_pci_io_resource.start + 1);
+	loongson_pci_controller.io_map_base = mips_io_port_base;
 
 	register_pci_controller(&loongson_pci_controller);
 
diff --git a/arch/mips/loongson/fuloong-2e/reset.c
b/arch/mips/loongson/fuloong-2e/reset.c
index 664ba77..f2fff56 100644
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -8,20 +8,20 @@
  * Author: Fuxin Zhang, zhangfx@lemote.com
  */
 
+#include <linux/io.h>
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
 
+#include <loongson.h>
+
 static void loongson_restart(char *command)
 {
-#ifdef CONFIG_32BIT
-	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xbfe00104 |= (1 << 2);
-#else
-	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
-#endif
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+	LOONGSON_GENCFG &= ~LOONGSON_GENCFG_CPUSELFRESET;
+	LOONGSON_GENCFG |= LOONGSON_GENCFG_CPUSELFRESET;
+
+	/* reboot via jumping to 0xbfc00000 */
+	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
 }
 
 static void loongson_halt(void)
diff --git a/arch/mips/loongson/fuloong-2e/setup.c
b/arch/mips/loongson/fuloong-2e/setup.c
index 36791d9..636cdbe 100644
--- a/arch/mips/loongson/fuloong-2e/setup.c
+++ b/arch/mips/loongson/fuloong-2e/setup.c
@@ -25,7 +25,10 @@ static void loongson_wbflush(void)
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
