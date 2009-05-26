Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:04:05 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:19733 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024627AbZEZTD7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:03:59 +0100
Received: by wa-out-1112.google.com with SMTP id n4so684019wag.0
        for <multiple recipients>; Tue, 26 May 2009 12:03:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5LJy2u/B9XZZatTdOC+nd4ombWxEbIz63Ze4jV1wZpg=;
        b=ktYvcJOQBode01kMwxmQgeM0CQ4M6zSy0VZdXGZrKCdbAXTl0t6eD9h6sPJ2r4IbTI
         e3Bhh9JbWMcKx6FNExFbZVZ063sqvq76ltoDGuj26nkbhHjjAF1JfDBpl5ATB6kEGpcn
         n4wqlqhgwakIfoiFdO8AHxblp6a/OxyiGCwyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CEV5tJmTNh3JOeJ9gXL6zqeZt4qSXGJmmFEfd5UmsvCEZbNP/0fTLWLFjj2eRQZx9X
         ePjBLrIe0Tbw87KdetARQUNZ5bbaWyw+s16qVZehuwnCVji+PWiDknEAwzhR6Md4b71Z
         YB9eKagyH7gUaT5PgybYZYvQZlRSoG856caMI=
Received: by 10.114.204.7 with SMTP id b7mr18221431wag.184.1243364636201;
        Tue, 26 May 2009 12:03:56 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id j34sm11773178waf.64.2009.05.26.12.03.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:03:52 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 04/23] remove reference to bonito64.h
Date:	Wed, 27 May 2009 03:03:42 +0800
Message-Id: <9e690d376fa803c4ab57e1c74052f45bd3323292.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

in loongson2e, there is an internal bonito64 compatiable north bridge,
but in loongson2f and the later loongson revisions, this will change a
lot, so, remove reference from bonito64.h and create a new loongson.h is
better.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |  194 +++++++++++++++++++++++-
 arch/mips/include/asm/mach-loongson/pci.h      |    2 +-
 arch/mips/include/asm/mips-boards/bonito64.h   |    5 -
 arch/mips/loongson/fuloong-2e/bonito-irq.c     |   10 +-
 arch/mips/loongson/fuloong-2e/irq.c            |   23 ++--
 arch/mips/loongson/fuloong-2e/pci.c            |   15 +-
 arch/mips/pci/Makefile                         |    2 +-
 arch/mips/pci/fixup-fuloong2e.c                |    5 +-
 arch/mips/pci/ops-bonito64.c                   |    7 -
 arch/mips/pci/ops-fuloong2e.c                  |  160 +++++++++++++++++++
 10 files changed, 382 insertions(+), 41 deletions(-)
 create mode 100644 arch/mips/pci/ops-fuloong2e.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 18ebef1..26308b5 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -1,7 +1,19 @@
 /*
- * loongson-specific header file
+ * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
  */
 
+#ifndef __LOONGSON_H
+#define __LOONGSON_H
+
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
 
@@ -12,3 +24,183 @@ extern unsigned long memsize, highmemsize;
 /* loongson-based machines specific reboot setup */
 extern void loongson_reboot_setup(void);
 
+#define LOONGSON_REG(x) \
+	(*(u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
+#define LOONGSON_IRQ_BASE	32
+
+#define LOONGSON_FLASH_BASE	0x1c000000
+#define LOONGSON_FLASH_SIZE	0x02000000	/* 32M */
+#define LOONGSON_FLASH_TOP	(LOONGSON_FLASH_BASE+LOONGSON_FLASH_SIZE-1)
+
+#define LOONGSON_LIO0_BASE	0x1e000000
+#define LOONGSON_LIO0_SIZE	0x01C00000	/* 28M */
+#define LOONGSON_LIO0_TOP	(LOONGSON_LIO0_BASE+LOONGSON_LIO0_SIZE-1)
+
+#define LOONGSON_BOOT_BASE	0x1fc00000
+#define LOONGSON_BOOT_SIZE	0x00100000	/* 1M */
+#define LOONGSON_BOOT_TOP 	(LOONGSON_BOOT_BASE+LOONGSON_BOOT_SIZE-1)
+#define LOONGSON_REG_BASE 	0x1fe00000
+#define LOONGSON_REG_SIZE 	0x00100000	/* 256Bytes + 256Bytes + ??? */
+#define LOONGSON_REG_TOP	(LOONGSON_REG_BASE+LOONGSON_REG_SIZE-1)
+
+#define LOONGSON_LIO1_BASE 	0x1ff00000
+#define LOONGSON_LIO1_SIZE 	0x00100000	/* 1M */
+#define LOONGSON_LIO1_TOP	(LOONGSON_LIO1_BASE+LOONGSON_LIO1_SIZE-1)
+
+#define LOONGSON_PCILO0_BASE	0x10000000
+#define LOONGSON_PCILO1_BASE	0x14000000
+#define LOONGSON_PCILO2_BASE	0x18000000
+#define LOONGSON_PCILO_BASE	LOONGSON_PCILO0_BASE
+#define LOONGSON_PCILO_SIZE	0x0c000000	/* 64M * 3 */
+#define LOONGSON_PCILO_TOP	(LOONGSON_PCILO0_BASE+LOONGSON_PCILO_SIZE-1)
+
+#define LOONGSON_PCICFG_BASE	0x1fe80000
+#define LOONGSON_PCICFG_SIZE	0x00000800	/* 2K */
+#define LOONGSON_PCICFG_TOP	(LOONGSON_PCICFG_BASE+LOONGSON_PCICFG_SIZE-1)
+#define LOONGSON_PCIIO_BASE	0x1fd00000
+#define LOONGSON_PCIIO_SIZE	0x00100000	/* 1M */
+#define LOONGSON_PCIIO_TOP	(LOONGSON_PCIIO_BASE+LOONGSON_PCIIO_SIZE-1)
+
+/* Loongson Register Bases */
+
+#define LOONGSON_PCICONFIGBASE	0x00
+#define LOONGSON_REGBASE	0x100
+
+/* PCI Configuration Registers */
+
+#define LOONGSON_PCI_REG(x)	LOONGSON_REG(LOONGSON_PCICONFIGBASE + (x))
+#define LOONGSON_PCIDID		LOONGSON_PCI_REG(0x00)
+#define LOONGSON_PCICMD		LOONGSON_PCI_REG(0x04)
+#define LOONGSON_PCICLASS 	LOONGSON_PCI_REG(0x08)
+#define LOONGSON_PCILTIMER	LOONGSON_PCI_REG(0x0c)
+#define LOONGSON_PCIBASE0 	LOONGSON_PCI_REG(0x10)
+#define LOONGSON_PCIBASE1 	LOONGSON_PCI_REG(0x14)
+#define LOONGSON_PCIBASE2 	LOONGSON_PCI_REG(0x18)
+#define LOONGSON_PCIBASE3 	LOONGSON_PCI_REG(0x1c)
+#define LOONGSON_PCIBASE4 	LOONGSON_PCI_REG(0x20)
+#define LOONGSON_PCIEXPRBASE	LOONGSON_PCI_REG(0x30)
+#define LOONGSON_PCIINT		LOONGSON_PCI_REG(0x3c)
+
+#define LOONGSON_PCI_ISR4C	LOONGSON_PCI_REG(0x4c)
+
+#define LOONGSON_PCICMD_PERR_CLR	0x80000000
+#define LOONGSON_PCICMD_SERR_CLR	0x40000000
+#define LOONGSON_PCICMD_MABORT_CLR	0x20000000
+#define LOONGSON_PCICMD_MTABORT_CLR	0x10000000
+#define LOONGSON_PCICMD_TABORT_CLR	0x08000000
+#define LOONGSON_PCICMD_MPERR_CLR 	0x01000000
+#define LOONGSON_PCICMD_PERRRESPEN	0x00000040
+#define LOONGSON_PCICMD_ASTEPEN		0x00000080
+#define LOONGSON_PCICMD_SERREN		0x00000100
+#define LOONGSON_PCILTIMER_BUSLATENCY	0x0000ff00
+#define LOONGSON_PCILTIMER_BUSLATENCY_SHIFT	8
+
+/* Loongson h/w Configuration */
+
+#define LOONGSON_GENCFG_OFFSET		0x4
+#define LOONGSON_GENCFG	LOONGSON_REG(LOONGSON_REGBASE + LOONGSON_GENCFG_OFFSET)
+
+#define LOONGSON_GENCFG_DEBUGMODE	0x00000001
+#define LOONGSON_GENCFG_SNOOPEN		0x00000002
+#define LOONGSON_GENCFG_CPUSELFRESET	0x00000004
+
+#define LOONGSON_GENCFG_FORCE_IRQA	0x00000008
+#define LOONGSON_GENCFG_IRQA_ISOUT	0x00000010
+#define LOONGSON_GENCFG_IRQA_FROM_INT1	0x00000020
+#define LOONGSON_GENCFG_BYTESWAP	0x00000040
+
+#define LOONGSON_GENCFG_UNCACHED	0x00000080
+#define LOONGSON_GENCFG_PREFETCHEN	0x00000100
+#define LOONGSON_GENCFG_WBEHINDEN	0x00000200
+#define LOONGSON_GENCFG_CACHEALG	0x00000c00
+#define LOONGSON_GENCFG_CACHEALG_SHIFT	10
+#define LOONGSON_GENCFG_PCIQUEUE	0x00001000
+#define LOONGSON_GENCFG_CACHESTOP	0x00002000
+#define LOONGSON_GENCFG_MSTRBYTESWAP	0x00004000
+#define LOONGSON_GENCFG_BUSERREN	0x00008000
+#define LOONGSON_GENCFG_NORETRYTIMEOUT	0x00010000
+#define LOONGSON_GENCFG_SHORTCOPYTIMEOUT	0x00020000
+
+/* PCI address map control */
+
+#define LOONGSON_PCIMAP			LOONGSON_REG(LOONGSON_REGBASE + 0x10)
+#define LOONGSON_PCIMEMBASECFG		LOONGSON_REG(LOONGSON_REGBASE + 0x14)
+#define LOONGSON_PCIMAP_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x18)
+
+/* GPIO Regs - r/w */
+
+#define LOONGSON_GPIODATA 		LOONGSON_REG(LOONGSON_REGBASE + 0x1c)
+#define LOONGSON_GPIOIE			LOONGSON_REG(LOONGSON_REGBASE + 0x20)
+
+/* ICU Configuration Regs - r/w */
+
+#define LOONGSON_INTEDGE		LOONGSON_REG(LOONGSON_REGBASE + 0x24)
+#define LOONGSON_INTSTEER 		LOONGSON_REG(LOONGSON_REGBASE + 0x28)
+#define LOONGSON_INTPOL			LOONGSON_REG(LOONGSON_REGBASE + 0x2c)
+
+/* ICU Enable Regs - IntEn & IntISR are r/o. */
+
+#define LOONGSON_INTENSET 		LOONGSON_REG(LOONGSON_REGBASE + 0x30)
+#define LOONGSON_INTENCLR 		LOONGSON_REG(LOONGSON_REGBASE + 0x34)
+#define LOONGSON_INTEN			LOONGSON_REG(LOONGSON_REGBASE + 0x38)
+#define LOONGSON_INTISR			LOONGSON_REG(LOONGSON_REGBASE + 0x3c)
+
+/* ICU */
+#define LOONGSON_ICU_MBOXES		0x0000000f
+#define LOONGSON_ICU_MBOXES_SHIFT 	0
+#define LOONGSON_ICU_DMARDY		0x00000010
+#define LOONGSON_ICU_DMAEMPTY		0x00000020
+#define LOONGSON_ICU_COPYRDY		0x00000040
+#define LOONGSON_ICU_COPYEMPTY		0x00000080
+#define LOONGSON_ICU_COPYERR		0x00000100
+#define LOONGSON_ICU_PCIIRQ		0x00000200
+#define LOONGSON_ICU_MASTERERR		0x00000400
+#define LOONGSON_ICU_SYSTEMERR		0x00000800
+#define LOONGSON_ICU_DRAMPERR		0x00001000
+#define LOONGSON_ICU_RETRYERR		0x00002000
+#define LOONGSON_ICU_GPIOS		0x01ff0000
+#define LOONGSON_ICU_GPIOS_SHIFT		16
+#define LOONGSON_ICU_GPINS		0x7e000000
+#define LOONGSON_ICU_GPINS_SHIFT		25
+#define LOONGSON_ICU_MBOX(N)		(1<<(LOONGSON_ICU_MBOXES_SHIFT+(N)))
+#define LOONGSON_ICU_GPIO(N)		(1<<(LOONGSON_ICU_GPIOS_SHIFT+(N)))
+#define LOONGSON_ICU_GPIN(N)		(1<<(LOONGSON_ICU_GPINS_SHIFT+(N)))
+
+/* PCI prefetch window base & mask */
+
+#define LOONGSON_MEM_WIN_BASE_L 	LOONGSON_REG(LOONGSON_REGBASE + 0x40)
+#define LOONGSON_MEM_WIN_BASE_H 	LOONGSON_REG(LOONGSON_REGBASE + 0x44)
+#define LOONGSON_MEM_WIN_MASK_L 	LOONGSON_REG(LOONGSON_REGBASE + 0x48)
+#define LOONGSON_MEM_WIN_MASK_H 	LOONGSON_REG(LOONGSON_REGBASE + 0x4c)
+
+/* PCI_Hit*_Sel_* */
+
+#define LOONGSON_PCI_HIT0_SEL_L		LOONGSON_REG(LOONGSON_REGBASE + 0x50)
+#define LOONGSON_PCI_HIT0_SEL_H		LOONGSON_REG(LOONGSON_REGBASE + 0x54)
+#define LOONGSON_PCI_HIT1_SEL_L		LOONGSON_REG(LOONGSON_REGBASE + 0x58)
+#define LOONGSON_PCI_HIT1_SEL_H		LOONGSON_REG(LOONGSON_REGBASE + 0x5c)
+#define LOONGSON_PCI_HIT2_SEL_L		LOONGSON_REG(LOONGSON_REGBASE + 0x60)
+#define LOONGSON_PCI_HIT2_SEL_H		LOONGSON_REG(LOONGSON_REGBASE + 0x64)
+
+/* PXArb Config & Status */
+
+#define LOONGSON_PXARB_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x68)
+#define LOONGSON_PXARB_STATUS		LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
+
+/* Chip Config */
+#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
+
+/* pcimap */
+
+#define LOONGSON_PCIMAP_PCIMAP_LO0	0x0000003f
+#define LOONGSON_PCIMAP_PCIMAP_LO0_SHIFT	0
+#define LOONGSON_PCIMAP_PCIMAP_LO1	0x00000fc0
+#define LOONGSON_PCIMAP_PCIMAP_LO1_SHIFT	6
+#define LOONGSON_PCIMAP_PCIMAP_LO2	0x0003f000
+#define LOONGSON_PCIMAP_PCIMAP_LO2_SHIFT	12
+#define LOONGSON_PCIMAP_PCIMAP_2	0x00040000
+#define LOONGSON_PCIMAP_WIN(WIN, ADDR)	\
+	((((ADDR)>>26) & LOONGSON_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
+
+#endif				/* __LOONGSON_H */
+
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
index e685096..9a351be 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -22,7 +22,7 @@
 #ifndef _LOONGSON_PCI_H_
 #define _LOONGSON_PCI_H_
 
-extern struct pci_ops bonito64_pci_ops;
+extern struct pci_ops loongson_pci_ops;
 
 #define LOONGSON2E_PCI_MEM_START	0x14000000UL
 #define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
diff --git a/arch/mips/include/asm/mips-boards/bonito64.h b/arch/mips/include/asm/mips-boards/bonito64.h
index a576ce0..d14e2ad 100644
--- a/arch/mips/include/asm/mips-boards/bonito64.h
+++ b/arch/mips/include/asm/mips-boards/bonito64.h
@@ -26,11 +26,6 @@
 /* offsets from base register */
 #define BONITO(x)	(x)
 
-#elif defined(CONFIG_LEMOTE_FULOONG2E)
-
-#define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x)))
-#define BONITO_IRQ_BASE   32
-
 #else
 
 /*
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c b/arch/mips/loongson/fuloong-2e/bonito-irq.c
index 5adf373..91b9c08 100644
--- a/arch/mips/loongson/fuloong-2e/bonito-irq.c
+++ b/arch/mips/loongson/fuloong-2e/bonito-irq.c
@@ -34,18 +34,18 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
-#include <asm/mips-boards/bonito64.h>
+#include <loongson.h>
 
 
 static inline void bonito_irq_enable(unsigned int irq)
 {
-	BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE));
+	LOONGSON_INTENSET = (1 << (irq - LOONGSON_IRQ_BASE));
 	mmiowb();
 }
 
 static inline void bonito_irq_disable(unsigned int irq)
 {
-	BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+	LOONGSON_INTENCLR = (1 << (irq - LOONGSON_IRQ_BASE));
 	mmiowb();
 }
 
@@ -66,8 +66,8 @@ void bonito_irq_init(void)
 {
 	u32 i;
 
-	for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++)
+	for (i = LOONGSON_IRQ_BASE; i < LOONGSON_IRQ_BASE + 32; i++)
 		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
 
-	setup_irq(BONITO_IRQ_BASE + 10, &dma_timeout_irqaction);
+	setup_irq(LOONGSON_IRQ_BASE + 10, &dma_timeout_irqaction);
 }
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index 1b0d491..20030c0 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -32,7 +32,6 @@
 #include <asm/irq_cpu.h>
 #include <asm/i8259.h>
 #include <asm/mipsregs.h>
-#include <asm/mips-boards/bonito64.h>
 
 #include <loongson.h>
 
@@ -45,21 +44,21 @@ static void bonito_irqdispatch(void)
 	int i;
 
 	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
-	int_status = BONITO_INTISR;
+	int_status = LOONGSON_INTISR;
 	if (int_status & (1 << 10)) {
 		while (int_status & (1 << 10)) {
 			udelay(1);
-			int_status = BONITO_INTISR;
+			int_status = LOONGSON_INTISR;
 		}
 	}
 
 	/* Get pending sources, masked by current enables */
-	int_status = BONITO_INTISR & BONITO_INTEN;
+	int_status = LOONGSON_INTISR & LOONGSON_INTEN;
 
 	if (int_status != 0) {
 		i = __ffs(int_status);
 		int_status &= ~(1 << i);
-		do_IRQ(BONITO_IRQ_BASE + i);
+		do_IRQ(LOONGSON_IRQ_BASE + i);
 	}
 }
 
@@ -103,15 +102,15 @@ void __init arch_init_irq(void)
 	local_irq_disable();
 
 	/* most bonito irq should be level triggered */
-	BONITO_INTEDGE = BONITO_ICU_SYSTEMERR | BONITO_ICU_MASTERERR |
-		BONITO_ICU_RETRYERR | BONITO_ICU_MBOXES;
-	BONITO_INTSTEER = 0;
+	LOONGSON_INTEDGE = LOONGSON_ICU_SYSTEMERR | LOONGSON_ICU_MASTERERR |
+		LOONGSON_ICU_RETRYERR | LOONGSON_ICU_MBOXES;
+	LOONGSON_INTSTEER = 0;
 
 	/*
 	 * Mask out all interrupt by writing "1" to all bit position in
 	 * the interrupt reset reg.
 	 */
-	BONITO_INTENCLR = ~0;
+	LOONGSON_INTENCLR = ~0;
 
 	/* init all controller
 	 *   0-15         ------> i8259 interrupt
@@ -125,10 +124,10 @@ void __init arch_init_irq(void)
 	bonito_irq_init();
 
 	/*
-	printk("GPIODATA=%x, GPIOIE=%x\n", BONITO_GPIODATA, BONITO_GPIOIE);
+	printk("GPIODATA=%x, GPIOIE=%x\n", LOONGSON_GPIODATA, LOONGSON_GPIOIE);
 	printk("INTEN=%x, INTSET=%x, INTCLR=%x, INTISR=%x\n",
-			BONITO_INTEN, BONITO_INTENSET,
-			BONITO_INTENCLR, BONITO_INTISR);
+			LOONGSON_INTEN, LOONGSON_INTENSET,
+			LOONGSON_INTENCLR, LOONGSON_INTISR);
 	*/
 
 	/* bonito irq at IP2 */
diff --git a/arch/mips/loongson/fuloong-2e/pci.c b/arch/mips/loongson/fuloong-2e/pci.c
index 4c4bc07..1d81110 100644
--- a/arch/mips/loongson/fuloong-2e/pci.c
+++ b/arch/mips/loongson/fuloong-2e/pci.c
@@ -29,7 +29,8 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <asm/mips-boards/bonito64.h>
+
+#include <loongson.h>
 #include <pci.h>
 
 static struct resource loongson2e_pci_mem_resource = {
@@ -47,7 +48,7 @@ static struct resource loongson2e_pci_io_resource = {
 };
 
 static struct pci_controller  loongson2e_pci_controller = {
-	.pci_ops        = &bonito64_pci_ops,
+	.pci_ops        = &loongson_pci_ops,
 	.io_resource    = &loongson2e_pci_io_resource,
 	.mem_resource   = &loongson2e_pci_mem_resource,
 	.mem_offset     = 0x00000000UL,
@@ -64,17 +65,17 @@ static void __init ict_pcimap(void)
 	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
 	 */
 	/* 1,00 0110 ,0001 01,00 0000 */
-	BONITO_PCIMAP = 0x46140;
+	LOONGSON_PCIMAP = 0x46140;
 
 	/* 1, 00 0010, 0000,01, 00 0000 */
-	/* BONITO_PCIMAP = 0x42040; */
+	/* LOONGSON_PCIMAP = 0x42040; */
 
 	/*
 	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
 	 */
-	BONITO_PCIBASE0 = 0x80000000;
-	BONITO_PCIBASE1 = 0x00800000;
-	BONITO_PCIBASE2 = 0x90000000;
+	LOONGSON_PCIBASE0 = 0x80000000;
+	LOONGSON_PCIBASE1 = 0x00800000;
+	LOONGSON_PCIBASE2 = 0x90000000;
 
 }
 
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 1c66fc0..a0cc238 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
-obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-bonito64.o
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-fuloong2e.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
index bd26008..0e3c5de 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -31,7 +31,8 @@
  */
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <asm/mips-boards/bonito64.h>
+
+#include <loongson.h>
 
 /* South bridge slot number is set by the pci probe process */
 static u8 sb_slot = 5;
@@ -53,7 +54,7 @@ int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 			break;
 		}
 	} else {
-		irq = BONITO_IRQ_BASE + 25 + pin;
+		irq = LOONGSON_IRQ_BASE + 25 + pin;
 	}
 	return irq;
 
diff --git a/arch/mips/pci/ops-bonito64.c b/arch/mips/pci/ops-bonito64.c
index e3b091d..39de8cb 100644
--- a/arch/mips/pci/ops-bonito64.c
+++ b/arch/mips/pci/ops-bonito64.c
@@ -29,14 +29,9 @@
 #define PCI_ACCESS_READ  0
 #define PCI_ACCESS_WRITE 1
 
-#ifdef CONFIG_LEMOTE_FULOONG2E
-#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (offset))
-#define ID_SEL_BEGIN 11
-#else
 #define CFG_SPACE_REG(offset) \
 	(void *)CKSEG1ADDR(_pcictrl_bonito_pcicfg + (offset))
 #define ID_SEL_BEGIN 10
-#endif
 #define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
 
 
@@ -78,11 +73,9 @@ static int bonito64_pcibios_config_access(unsigned char access_type,
 	addrp = CFG_SPACE_REG(addr & 0xffff);
 	if (access_type == PCI_ACCESS_WRITE) {
 		writel(cpu_to_le32(*data), addrp);
-#ifndef CONFIG_LEMOTE_FULOONG2E
 		/* Wait till done */
 		while (BONITO_PCIMSTAT & 0xF)
 			;
-#endif
 	} else {
 		*data = le32_to_cpu(readl(addrp));
 	}
diff --git a/arch/mips/pci/ops-fuloong2e.c b/arch/mips/pci/ops-fuloong2e.c
new file mode 100644
index 0000000..6bb7919
--- /dev/null
+++ b/arch/mips/pci/ops-fuloong2e.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
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
+ * MIPS boards specific PCI support.
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <loongson.h>
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+#define CFG_SPACE_REG(offset) \
+	(void *)CKSEG1ADDR(LOONGSON_PCICFG_BASE | (offset))
+#define ID_SEL_BEGIN 11
+#define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
+
+
+static int loongson_pcibios_config_access(unsigned char access_type,
+				      struct pci_bus *bus,
+				      unsigned int devfn, int where,
+				      u32 *data)
+{
+	u32 busnum = bus->number;
+	u32 addr, type;
+	u32 dummy;
+	void *addrp;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+
+	if (busnum == 0) {
+		/* Type 0 configuration for onboard PCI bus */
+		if (device > MAX_DEV_NUM)
+			return -1;
+
+		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
+		type = 0;
+	} else {
+		/* Type 1 configuration for offboard PCI bus */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		type = 0x10000;
+	}
+
+	/* Clear aborts */
+	LOONGSON_PCICMD |= LOONGSON_PCICMD_MABORT_CLR | \
+				LOONGSON_PCICMD_MTABORT_CLR;
+
+	LOONGSON_PCIMAP_CFG = (addr >> 16) | type;
+
+	/* Flush Bonito register block */
+	dummy = LOONGSON_PCIMAP_CFG;
+	mmiowb();
+
+	addrp = CFG_SPACE_REG(addr & 0xffff);
+	if (access_type == PCI_ACCESS_WRITE)
+		writel(cpu_to_le32(*data), addrp);
+	else
+		*data = le32_to_cpu(readl(addrp));
+
+	/* Detect Master/Target abort */
+	if (LOONGSON_PCICMD & (LOONGSON_PCICMD_MABORT_CLR |
+			     LOONGSON_PCICMD_MTABORT_CLR)) {
+		/* Error occurred */
+
+		/* Clear bits */
+		LOONGSON_PCICMD |= (LOONGSON_PCICMD_MABORT_CLR |
+				  LOONGSON_PCICMD_MTABORT_CLR);
+
+		return -1;
+	}
+
+	return 0;
+
+}
+
+
+/*
+ * We can't address 8 and 16 bit words directly.  Instead we have to
+ * read/write a 32bit word and mask/modify the data we actually want.
+ */
+static int loongson_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
+				       &data))
+		return -1;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int loongson_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (size == 4)
+		data = val;
+	else {
+		if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
+					where, &data))
+			return -1;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+	}
+
+	if (loongson_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where,
+				       &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops loongson_pci_ops = {
+	.read = loongson_pcibios_read,
+	.write = loongson_pcibios_write
+};
-- 
1.6.0.4
