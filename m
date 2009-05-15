Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:10:19 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.172]:7454 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023334AbZEOWKL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:10:11 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1225568wfa.21
        for <multiple recipients>; Fri, 15 May 2009 15:10:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=+CoeFZNprsPy41pz/gAyPCzJQb9q4NYeFMbo3G3Qes8=;
        b=L2w6YIOSZ1gvSc7gkYT6ouuvNVpSU2mpDhNlmuqGjL0hpFiOdQyS61HLktCJmEJFCy
         LmqpJRPBZU9/457/jry2Tu+akqtKqh0EoBwhNdOyBTlOGlPwQkO6DovKmsIQWGSxg3b0
         z/RRDy4lW1wwrGxAM3mx/15us1bcBUmuIlmi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lSF+AER9c6xbhXigwqPePBsSwMdJdzEKQ42I169PMydwCRvkRlF4gIquvHA6x76tQL
         IHvUufo6Ttfo7NOM9MM+cl6os3YOmIf/pv+tDN9onsWxMl2cA8nuXDxqI5JuhiQifXRz
         DLftJbwkLGzvXaLOxr9cizuk9cKE/MNq2Lf2E=
Received: by 10.142.57.19 with SMTP id f19mr1197117wfa.80.1242425409348;
        Fri, 15 May 2009 15:10:09 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id b39sm314553rvf.1.2009.05.15.15.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:10:08 -0700 (PDT)
Subject: [PATCH 12/30] loongson: add basic loongson-2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:10:02 +0800
Message-Id: <1242425402.10164.153.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 90697a98d8a589cfa503ae816e5f530cb682c4c0 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 02:36:24 +0800
Subject: [PATCH 12/30] loongson: add basic loongson-2f support

the main difference between loongson-2e and loongson-2f is that:

loongson-2f have an extra address windows configuration module, which
can be used to map CPU address space to DDR or PCI address space, or map
the PCI-DMA address space to DDR or LIO address space.
---
 arch/mips/Kconfig                                  |   18 +++++
 .../mips/include/asm/mach-loongson/dma-coherence.h |    4 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   75
++++++++++++++++++++
 arch/mips/include/asm/mach-loongson/mem.h          |   23 ++++++
 arch/mips/include/asm/mach-loongson/pci.h          |   29 +++++++-
 arch/mips/loongson/common/init.c                   |   18 +++++
 arch/mips/loongson/common/mem.c                    |   21 +++++-
 arch/mips/loongson/common/pci.c                    |   14 +++-
 8 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d4090bc..71d57e8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1006,7 +1006,22 @@ config CPU_LOONGSON2E
 	select CPU_LOONGSON2
 	help
 	  The Loongson 2E processor implements the MIPS III instruction set
+	  with many extensions. 
+	  
+	  It has an internal FPGA northbridge, which is compatiable to
+	  bonito64.
+
+config CPU_LOONGSON2F
+	bool "Loongson 2F"
+	depends on SYS_HAS_CPU_LOONGSON2F
+	select CPU_LOONGSON2
+	help
+	  The Loongson 2F processor implements the MIPS III instruction set
 	  with many extensions.
+	  
+	  Loongson2F have built-in DDR2 and PCIX controller. The PCIX
controller
+	  have a similar programming interface with FPGA northbridge used in
+	  Loongson2E.
 
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
@@ -1255,6 +1270,9 @@ config CPU_LOONGSON2
 config SYS_HAS_CPU_LOONGSON2E
 	bool
 
+config SYS_HAS_CPU_LOONGSON2F
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h
b/arch/mips/include/asm/mach-loongson/dma-coherence.h
index f27d0f8..6ba8279 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -27,7 +27,11 @@ static inline dma_addr_t plat_map_dma_mem_page(struct
device *dev,
 
 static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
 {
+#if defined(CONFIG_CPU_LOONGSON2F) & defined(CONFIG_64BIT)
+	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
+#else
 	return dma_addr & 0x7fffffff;
+#endif
 }
 
 static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t
dma_addr)
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
b/arch/mips/include/asm/mach-loongson/loongson.h
index 8395ea8..3d8c768 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -230,5 +230,80 @@
                                                   (((ADDR) &
(~(LOONGSON_PCIMEMBASECFG_MASK))) &
(~(LOONGSON_PCIMEMBASECFG_ADDRMASK(WIN, CFG)))) | \

(LOONGSON_PCIMEMBASECFG_ADDRTRANS(WIN, CFG)) \
                                                 )
+/* 
+ * address windows configuration module
+ *
+ * only loongson2f have this module
+ */
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+
+/* address window config module base address */
+#define LOONGSON_ADDRWINCFG_BASE		0x3ff00000ul
+#define LOONGSON_ADDRWINCFG_SIZE		0x180
+
+extern unsigned long _loongson_addrwincfg_base;
+#define LOONGSON_ADDRWINCFG(offset)	*(volatile u64
*)(_loongson_addrwincfg_base + (offset))
+
+#define CPU_WIN0_BASE	LOONGSON_ADDRWINCFG(0x00)
+#define CPU_WIN1_BASE	LOONGSON_ADDRWINCFG(0x08)
+#define CPU_WIN2_BASE	LOONGSON_ADDRWINCFG(0x10)
+#define CPU_WIN3_BASE	LOONGSON_ADDRWINCFG(0x18)
+
+#define CPU_WIN0_MASK	LOONGSON_ADDRWINCFG(0x20)
+#define CPU_WIN1_MASK	LOONGSON_ADDRWINCFG(0x28)
+#define CPU_WIN2_MASK	LOONGSON_ADDRWINCFG(0x30)
+#define CPU_WIN3_MASK	LOONGSON_ADDRWINCFG(0x38)
+
+#define CPU_WIN0_MMAP	LOONGSON_ADDRWINCFG(0x40)
+#define CPU_WIN1_MMAP	LOONGSON_ADDRWINCFG(0x48)
+#define CPU_WIN2_MMAP	LOONGSON_ADDRWINCFG(0x50)
+#define CPU_WIN3_MMAP	LOONGSON_ADDRWINCFG(0x58)
+
+#define PCIDMA_WIN0_BASE	LOONGSON_ADDRWINCFG(0x60)
+#define PCIDMA_WIN1_BASE	LOONGSON_ADDRWINCFG(0x68)
+#define PCIDMA_WIN2_BASE	LOONGSON_ADDRWINCFG(0x70)
+#define PCIDMA_WIN3_BASE	LOONGSON_ADDRWINCFG(0x78)
+
+#define PCIDMA_WIN0_MASK	LOONGSON_ADDRWINCFG(0x80)
+#define PCIDMA_WIN1_MASK	LOONGSON_ADDRWINCFG(0x88)
+#define PCIDMA_WIN2_MASK	LOONGSON_ADDRWINCFG(0x90)
+#define PCIDMA_WIN3_MASK	LOONGSON_ADDRWINCFG(0x98)
+
+#define PCIDMA_WIN0_MMAP	LOONGSON_ADDRWINCFG(0xa0)
+#define PCIDMA_WIN1_MMAP	LOONGSON_ADDRWINCFG(0xa8)
+#define PCIDMA_WIN2_MMAP	LOONGSON_ADDRWINCFG(0xb0)
+#define PCIDMA_WIN3_MMAP	LOONGSON_ADDRWINCFG(0xb8)
+
+#define ADDRWIN_WIN0	0
+#define ADDRWIN_WIN1	1
+#define ADDRWIN_WIN2	2
+#define ADDRWIN_WIN3	3
+
+#define ADDRWIN_MAP_DST_DDR	0
+#define ADDRWIN_MAP_DST_PCI	1
+#define ADDRWIN_MAP_DST_LIO	1
+
+/*
+ * s: CPU, PCIDMA
+ * d: DDR, PCI, LIO
+ * win: 0, 1, 2, 3
+ * src: map source
+ * dst: map destination
+ * size: ~mask + 1
+ */
+#define LOONGSON_ADDRWIN_CFG(s, d, w, src, dst, size) do {\
+	s##_WIN##w##_BASE = (src); \
+	s##_WIN##w##_MMAP = (src) | ADDRWIN_MAP_DST_##d; \
+	s##_WIN##w##_MASK = ~(size-1); \
+	} while (0);
+
+#define LOONGSON_ADDRWIN_CPUTOPCI(win, src, dst, size) \
+	LOONGSON_ADDRWIN_CFG(CPU, PCI, win, src, dst, size)
+#define LOONGSON_ADDRWIN_CPUTODDR(win, src, dst, size) \
+	LOONGSON_ADDRWIN_CFG(CPU, DDR, win, src, dst, size)
+#define LOONGSON_ADDRWIN_PCITODDR(win, src, dst, size) \
+	LOONGSON_ADDRWIN_CFG(PCIDMA, DDR, win, src, dst, size)
+
+#endif				/* ! CONFIG_CPU_LOONGSON2F && CONFIG_64BIT */
 
 #endif				/* __LOONGSON_H */
diff --git a/arch/mips/include/asm/mach-loongson/mem.h
b/arch/mips/include/asm/mach-loongson/mem.h
index ad01dc2..fb53be0 100644
--- a/arch/mips/include/asm/mach-loongson/mem.h
+++ b/arch/mips/include/asm/mach-loongson/mem.h
@@ -1,8 +1,31 @@
 #ifndef __MEM_H
 #define __MEM_H
 
+/*
+ * high memory space
+ *
+ * in loongson2e, starts from 512M
+ * in loongson2f, starts from 2G + 256M
+ */
+#ifdef CONFIG_CPU_LOONGSON2E
 #define LOONGSON_HIGHMEM_START	0x20000000
+#else
+#define LOONGSON_HIGHMEM_START	0x90000000
+#endif
+
+/*
+ * the peripheral registers(MMIO):
+ *
+ * On the Lemote Loongson 2e system, reside between 0x1000:0000 and
0x2000:0000.
+ * On the Lemote Loongson 2f system, reside between 0x1000:0000 and
0x8000:0000.
+ */
+
 #define LOONGSON_MMIO_MEM_START 0x10000000
+
+#ifdef CONFIG_CPU_LOONGSON2E
 #define LOONGSON_MMIO_MEM_END	0x20000000
+#else
+#define LOONGSON_MMIO_MEM_END	0x80000000
+#endif
 
 #endif	/* !__MEM_H */
diff --git a/arch/mips/include/asm/mach-loongson/pci.h
b/arch/mips/include/asm/mach-loongson/pci.h
index 4d3b647..fb17e0d 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
+ * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
  *
  * This program is free software; you can redistribute it
  * and/or modify it under the terms of the GNU General
@@ -22,9 +23,33 @@
 #ifndef _LOONGSON_PCI_H_
 #define _LOONGSON_PCI_H_
 
+/* this is an offset from mips_io_port_base */
+#define LOONGSON_PCI_IO_START		0x00004000UL
+
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+
+/*
+ * we use address window2 to map cpu address space to pci space
+ * window2: cpu [1G, 2G] -> pci [1G, 2G] 
+ * why not use window 0 & 1? because they are used by cpu when booting.
+ * window0: cpu [0, 256M] -> ddr [0, 256M]
+ * window1: cpu [256M, 512M] -> pci [256M, 512M]
+ */
+
+/* the smallest LOONGSON_CPU_MEM_SRC can be 512M */
+#define LOONGSON_CPU_MEM_SRC	0x40000000ul		/* 1G */
+#define LOONGSON_PCI_MEM_DST	LOONGSON_CPU_MEM_SRC
+
+#define LOONGSON_PCI_MEM_START	LOONGSON_PCI_MEM_DST
+#define LOONGSON_PCI_MEM_END	(0x80000000ul -1)	/* 2G */
+
+#define MMAP_CPUTOPCI_SIZE	(LOONGSON_PCI_MEM_END -
LOONGSON_PCI_MEM_START + 1)
+
+#else
+
 #define LOONGSON_PCI_MEM_START		0x14000000UL
 #define LOONGSON_PCI_MEM_END		0x1fffffffUL
-#define LOONGSON_PCI_IO_START		0x00004000UL
-#define LOONGSON_IO_PORT_BASE		0x1fd00000UL
+
+#endif			/* !(defined(CONFIG_CPU_LOONGSON2F) &&
defined(CONFIG_64BIT))*/
 
 #endif /* !_LOONGSON_PCI_H_ */
diff --git a/arch/mips/loongson/common/init.c
b/arch/mips/loongson/common/init.c
index 2c8bd8a..7bbe68b 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -22,6 +22,17 @@
 
 #include <loongson.h>
 
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+unsigned long _loongson_addrwincfg_base;
+
+/* Loongson CPU address windows config space base address */
+static inline void set_loongson_addrwincfg_base(unsigned long base)
+{
+	*(unsigned long *)&_loongson_addrwincfg_base = base;
+	barrier();
+}
+#endif
+
 extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
 
@@ -33,6 +44,13 @@ void __init prom_init(void)
 	/* init several base address */
 	set_io_port_base((unsigned long)
 			 ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
+
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+	set_loongson_addrwincfg_base((unsigned long)
+				     ioremap(LOONGSON_ADDRWINCFG_BASE,
+					     LOONGSON_ADDRWINCFG_SIZE));
+#endif
+
 	prom_init_cmdline();
 	prom_init_memory();
 }
diff --git a/arch/mips/loongson/common/mem.c
b/arch/mips/loongson/common/mem.c
index 52e5357..85de2dc 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -19,6 +19,23 @@ void __init prom_init_memory(void)
 {
 	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
 #ifdef CONFIG_64BIT
+#ifdef CONFIG_CPU_LOONGSON2F
+	{
+		int bit;
+
+		bit = fls(memsize + highmemsize);
+		if (bit != ffs(memsize + highmemsize))
+			bit += 20;
+		else
+			bit = bit + 20 - 1;
+
+		/* set cpu window3 to map CPU to DDR: 2G -> 2G */
+		LOONGSON_ADDRWIN_CPUTODDR(ADDRWIN_WIN3, 0x80000000ul,
+					  0x80000000ul, (1 << bit));
+		mmiowb();
+	}
+#endif				/* CONFIG_CPU_LOONGSON2F */
+
 	if (highmemsize > 0) {
 		add_memory_region(LOONGSON_HIGHMEM_START,
 				  highmemsize << 20, BOOT_MEM_RAM);
@@ -32,10 +49,6 @@ int __uncached_access(struct file *file, unsigned
long addr)
 	if (file->f_flags & O_SYNC)
 		return 1;
 
-	/*
-	 * On the Lemote Loongson 2e system, the peripheral registers
-	 * reside between 0x1000:0000 and 0x2000:0000.
-	 */
 	return addr >= __pa(high_memory) ||
 		((addr >= LOONGSON_MMIO_MEM_START) && (addr <
LOONGSON_MMIO_MEM_END));
 }
diff --git a/arch/mips/loongson/common/pci.c
b/arch/mips/loongson/common/pci.c
index 9cd71bc..1192fab 100644
--- a/arch/mips/loongson/common/pci.c
+++ b/arch/mips/loongson/common/pci.c
@@ -34,15 +34,15 @@
 extern struct pci_ops loongson_pci_ops;
 
 static struct resource loongson_pci_mem_resource = {
-	.name   = "LOONGSON PCI MEM",
+	.name   = "pci memory space",
 	.start  = LOONGSON_PCI_MEM_START,
 	.end    = LOONGSON_PCI_MEM_END,
 	.flags  = IORESOURCE_MEM,
 };
 
 static struct resource loongson_pci_io_resource = {
-	.name   = "LOONGSON PCI IO MEM",
-	.start  = LOONGSON_PCI_IO_START,
+	.name   = "pci io space",
+	.start  = LOONGSON_PCI_IO_START,	/* reserve regacy I/O space */
 	.end    = IO_SPACE_LIMIT,
 	.flags  = IORESOURCE_IO,
 };
@@ -88,6 +88,14 @@ static void __init ict_pcimap(void)
 	/* can not change gnt to break pci transfer when device's gnt not
deassert
 	   for some broken device */
 	LOONGSON_PXARB_CFG = 0x00fe0105ul;
+
+#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
+	/* 
+	 * set cpu addr window2 to map CPU address space to PCI address space
+	 */
+	LOONGSON_ADDRWIN_CPUTOPCI(ADDRWIN_WIN2, LOONGSON_CPU_MEM_SRC,
+				  LOONGSON_PCI_MEM_DST, MMAP_CPUTOPCI_SIZE);
+#endif			
 }
 
 static int __init pcibios_init(void)
-- 
1.6.2.1
