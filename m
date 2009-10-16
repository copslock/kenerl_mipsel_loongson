Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:20:23 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:63187 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493065AbZJPGSG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:18:06 +0200
Received: by mail-px0-f187.google.com with SMTP id 17so681893pxi.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:18:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=qhD5uGBHsg572FIGKW1sU4DOArVq2UubcxhDcVCgmhI=;
        b=XLcAI5BTxTjNTs7tPmdX1mYKrQEGG9fkKpglhi3BFKbKAXufNhQSB+Kki+oOUNHkFX
         wpdNLhI+IS91J69GDdt55iwrh27cWZN5Bv3rptknRM6BsdasDMRN+c68eEGblyedbNWE
         0AmfX/vHGpBgowy8TPR+xv+AWSPYfl1VfzOQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pNFJy7JavwJt4WBr0iwn5VZzbIPhGvcaKd3pNDfCqyYaL3369xqwMPGX5cQeVmF4Jj
         wOUfUgTgDnfgV5zd2QoxDhpZ0XFcsBph2Segt0ZqoU5T71Fm923SL/QTeWzl0kf/8rWW
         a/YuGiuD43i00gd7nFNx5oWyAy5BLMepXp17A=
Received: by 10.115.67.8 with SMTP id u8mr1196924wak.190.1255673884963;
        Thu, 15 Oct 2009 23:18:04 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:18:04 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 6/7] [loongson] remove reference from bonito64
Date:	Fri, 16 Oct 2009 14:17:19 +0800
Message-Id: <2aaf6778010c608858cf7af1bd46d226f89bf355.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <35c04cb5cd3aa4c2d2fc3cbb471304a7f3434ebb.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
 <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
 <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
 <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
 <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
 <35c04cb5cd3aa4c2d2fc3cbb471304a7f3434ebb.1255673756.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

There is a built-in northbridge in loongson2e/2f, which is bonito64
compatiable, but it differs from bonito64. to avoid influencing the
original bonito64 support and make the loongson support more
maintainable, it's better to remove reference from bonito64.

And this patch is a very important preparation for the coming loongson2f
family machines' support, all the coming patches depend on it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |  182 ++++++++++++++++++++++--
 arch/mips/include/asm/mach-loongson/machine.h  |    2 +-
 arch/mips/include/asm/mach-loongson/pci.h      |    6 +-
 arch/mips/include/asm/mips-boards/bonito64.h   |    5 -
 arch/mips/loongson/common/bonito-irq.c         |    8 +-
 arch/mips/loongson/common/init.c               |    2 +-
 arch/mips/loongson/common/irq.c                |   12 +-
 arch/mips/loongson/common/pci.c                |   12 +-
 arch/mips/loongson/common/reset.c              |    2 +-
 arch/mips/loongson/fuloong-2e/irq.c            |    4 +-
 arch/mips/loongson/fuloong-2e/reset.c          |    4 +-
 arch/mips/pci/Makefile                         |    2 +-
 arch/mips/pci/fixup-fuloong2e.c                |    5 +-
 arch/mips/pci/ops-bonito64.c                   |    7 -
 arch/mips/pci/ops-fuloong2e.c                  |  154 ++++++++++++++++++++
 15 files changed, 352 insertions(+), 55 deletions(-)
 create mode 100644 arch/mips/pci/ops-fuloong2e.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index da70bcf..e6869aa 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -15,9 +15,6 @@
 #include <linux/io.h>
 #include <linux/init.h>
 
-/* there is an internal bonito64-compatiable northbridge in loongson2e/2f */
-#include <asm/mips-boards/bonito64.h>
-
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
 
@@ -41,24 +38,181 @@ extern void __init set_irq_trigger_mode(void);
 extern void __init mach_init_irq(void);
 extern void mach_irq_dispatch(unsigned int pending);
 
+#define LOONGSON_REG(x) \
+	(*(volatile u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
+
+#define LOONGSON_IRQ_BASE	32
+#define LOONGSON2_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
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
 /* PCI Configuration Registers */
-#define LOONGSON_PCI_ISR4C  BONITO_PCI_REG(0x4c)
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
 
 /* PCI_Hit*_Sel_* */
 
-#define LOONGSON_PCI_HIT0_SEL_L     BONITO(BONITO_REGBASE + 0x50)
-#define LOONGSON_PCI_HIT0_SEL_H     BONITO(BONITO_REGBASE + 0x54)
-#define LOONGSON_PCI_HIT1_SEL_L     BONITO(BONITO_REGBASE + 0x58)
-#define LOONGSON_PCI_HIT1_SEL_H     BONITO(BONITO_REGBASE + 0x5c)
-#define LOONGSON_PCI_HIT2_SEL_L     BONITO(BONITO_REGBASE + 0x60)
-#define LOONGSON_PCI_HIT2_SEL_H     BONITO(BONITO_REGBASE + 0x64)
+#define LOONGSON_PCI_HIT0_SEL_L		LOONGSON_REG(LOONGSON_REGBASE + 0x50)
+#define LOONGSON_PCI_HIT0_SEL_H		LOONGSON_REG(LOONGSON_REGBASE + 0x54)
+#define LOONGSON_PCI_HIT1_SEL_L		LOONGSON_REG(LOONGSON_REGBASE + 0x58)
+#define LOONGSON_PCI_HIT1_SEL_H		LOONGSON_REG(LOONGSON_REGBASE + 0x5c)
+#define LOONGSON_PCI_HIT2_SEL_L		LOONGSON_REG(LOONGSON_REGBASE + 0x60)
+#define LOONGSON_PCI_HIT2_SEL_H		LOONGSON_REG(LOONGSON_REGBASE + 0x64)
 
 /* PXArb Config & Status */
 
-#define LOONGSON_PXARB_CFG      BONITO(BONITO_REGBASE + 0x68)
-#define LOONGSON_PXARB_STATUS       BONITO(BONITO_REGBASE + 0x6c)
+#define LOONGSON_PXARB_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x68)
+#define LOONGSON_PXARB_STATUS		LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
+
+/* pcimap */
 
-/* loongson2-specific perf counter IRQ */
-#define LOONGSON2_PERFCNT_IRQ   (MIPS_CPU_IRQ_BASE + 6)
+#define LOONGSON_PCIMAP_PCIMAP_LO0	0x0000003f
+#define LOONGSON_PCIMAP_PCIMAP_LO0_SHIFT	0
+#define LOONGSON_PCIMAP_PCIMAP_LO1	0x00000fc0
+#define LOONGSON_PCIMAP_PCIMAP_LO1_SHIFT	6
+#define LOONGSON_PCIMAP_PCIMAP_LO2	0x0003f000
+#define LOONGSON_PCIMAP_PCIMAP_LO2_SHIFT	12
+#define LOONGSON_PCIMAP_PCIMAP_2	0x00040000
+#define LOONGSON_PCIMAP_WIN(WIN, ADDR)	\
+	((((ADDR)>>26) & LOONGSON_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
 
 #endif /* __ASM_MACH_LOONGSON_LOONGSON_H */
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 206ea20..ea5954c 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_LEMOTE_FULOONG2E
 
-#define LOONGSON_UART_BASE (BONITO_PCIIO_BASE + 0x3f8)
+#define LOONGSON_UART_BASE (LOONGSON_PCIIO_BASE + 0x3f8)
 
 #define LOONGSON_MACHTYPE MACH_LEMOTE_FL2E
 
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
index f1663ca..576487c 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -22,13 +22,13 @@
 #ifndef __ASM_MACH_LOONGSON_PCI_H_
 #define __ASM_MACH_LOONGSON_PCI_H_
 
-extern struct pci_ops bonito64_pci_ops;
+extern struct pci_ops loongson_pci_ops;
 
 #ifdef CONFIG_LEMOTE_FULOONG2E
 
 /* this pci memory space is mapped by pcimap in pci.c */
-#define LOONGSON_PCI_MEM_START	BONITO_PCILO1_BASE
-#define LOONGSON_PCI_MEM_END	(BONITO_PCILO1_BASE + 0x04000000 * 2)
+#define LOONGSON_PCI_MEM_START	LOONGSON_PCILO1_BASE
+#define LOONGSON_PCI_MEM_END	(LOONGSON_PCILO1_BASE + 0x04000000 * 2)
 /* this is an offset from mips_io_port_base */
 #define LOONGSON_PCI_IO_START	0x00004000UL
 
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
diff --git a/arch/mips/loongson/common/bonito-irq.c b/arch/mips/loongson/common/bonito-irq.c
index 3e31e7a..a1cbd11 100644
--- a/arch/mips/loongson/common/bonito-irq.c
+++ b/arch/mips/loongson/common/bonito-irq.c
@@ -17,13 +17,13 @@
 
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
 
@@ -44,8 +44,8 @@ void bonito_irq_init(void)
 {
 	u32 i;
 
-	for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++)
+	for (i = LOONGSON_IRQ_BASE; i < LOONGSON_IRQ_BASE + 32; i++)
 		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
 
-	setup_irq(BONITO_IRQ_BASE + 10, &dma_timeout_irqaction);
+	setup_irq(LOONGSON_IRQ_BASE + 10, &dma_timeout_irqaction);
 }
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index 3abe927..b7e4913 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -18,7 +18,7 @@ void __init prom_init(void)
 {
     /* init base address of io space */
 	set_io_port_base((unsigned long)
-		ioremap(BONITO_PCIIO_BASE, BONITO_PCIIO_SIZE));
+		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
 
 	prom_init_cmdline();
 	prom_init_env();
diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
index b32b4a3..20e7328 100644
--- a/arch/mips/loongson/common/irq.c
+++ b/arch/mips/loongson/common/irq.c
@@ -20,21 +20,21 @@ void bonito_irqdispatch(void)
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
 
@@ -60,13 +60,13 @@ void __init arch_init_irq(void)
 	set_irq_trigger_mode();
 
 	/* no steer */
-	BONITO_INTSTEER = 0;
+	LOONGSON_INTSTEER = 0;
 
 	/*
 	 * Mask out all interrupt by writing "1" to all bit position in
 	 * the interrupt reset reg.
 	 */
-	BONITO_INTENCLR = ~0;
+	LOONGSON_INTENCLR = ~0;
 
 	/* machine specific irq init */
 	mach_init_irq();
diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson/common/pci.c
index a3a4abf..a7eb8b9 100644
--- a/arch/mips/loongson/common/pci.c
+++ b/arch/mips/loongson/common/pci.c
@@ -27,7 +27,7 @@ static struct resource loongson_pci_io_resource = {
 };
 
 static struct pci_controller  loongson_pci_controller = {
-	.pci_ops        = &bonito64_pci_ops,
+	.pci_ops        = &loongson_pci_ops,
 	.io_resource    = &loongson_pci_io_resource,
 	.mem_resource   = &loongson_pci_mem_resource,
 	.mem_offset     = 0x00000000UL,
@@ -44,15 +44,15 @@ static void __init setup_pcimap(void)
 	 * pcimap: PCI_MAP2  PCI_Mem_Lo2 PCI_Mem_Lo1 PCI_Mem_Lo0
 	 * 	     [<2G]   [384M,448M] [320M,384M] [0M,64M]
 	 */
-	BONITO_PCIMAP = BONITO_PCIMAP_PCIMAP_2 |
-		BONITO_PCIMAP_WIN(2, BONITO_PCILO2_BASE) |
-		BONITO_PCIMAP_WIN(1, BONITO_PCILO1_BASE) |
-		BONITO_PCIMAP_WIN(0, 0);
+	LOONGSON_PCIMAP = LOONGSON_PCIMAP_PCIMAP_2 |
+		LOONGSON_PCIMAP_WIN(2, LOONGSON_PCILO2_BASE) |
+		LOONGSON_PCIMAP_WIN(1, LOONGSON_PCILO1_BASE) |
+		LOONGSON_PCIMAP_WIN(0, 0);
 
 	/*
 	 * PCI-DMA to local mapping: [2G,2G+256M] -> [0M,256M]
 	 */
-	BONITO_PCIBASE0 = 0x80000000ul;   /* base: 2G -> mmap: 0M */
+	LOONGSON_PCIBASE0 = 0x80000000ul;   /* base: 2G -> mmap: 0M */
 	/* size: 256M, burst transmission, pre-fetch enable, 64bit */
 	LOONGSON_PCI_HIT0_SEL_L = 0xc000000cul;
 	LOONGSON_PCI_HIT0_SEL_H = 0xfffffffful;
diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 97e9182..d57f171 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -22,7 +22,7 @@ static void loongson_restart(char *command)
 	mach_prepare_reboot();
 
 	/* reboot via jumping to boot base address */
-	((void (*)(void))ioremap_nocache(BONITO_BOOT_BASE, 4)) ();
+	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
 }
 
 static void loongson_halt(void)
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
index 7888cf6..320e937 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -47,8 +47,8 @@ static struct irqaction cascade_irqaction = {
 void __init set_irq_trigger_mode(void)
 {
 	/* most bonito irq should be level triggered */
-	BONITO_INTEDGE = BONITO_ICU_SYSTEMERR | BONITO_ICU_MASTERERR |
-	    BONITO_ICU_RETRYERR | BONITO_ICU_MBOXES;
+	LOONGSON_INTEDGE = LOONGSON_ICU_SYSTEMERR | LOONGSON_ICU_MASTERERR |
+	    LOONGSON_ICU_RETRYERR | LOONGSON_ICU_MBOXES;
 }
 
 void __init mach_init_irq(void)
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson/fuloong-2e/reset.c
index 677fe18..fc16c67 100644
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -14,8 +14,8 @@
 
 void mach_prepare_reboot(void)
 {
-	BONITO_BONGENCFG &= ~(1 << 2);
-	BONITO_BONGENCFG |= (1 << 2);
+	LOONGSON_GENCFG &= ~(1 << 2);
+	LOONGSON_GENCFG |= (1 << 2);
 }
 
 void mach_prepare_shutdown(void)
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 91bfe73..0610c86 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
-obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-bonito64.o
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-fuloong2e.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
index 0c4c7a8..4f6d8da 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -13,7 +13,8 @@
  */
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <asm/mips-boards/bonito64.h>
+
+#include <loongson.h>
 
 /* South bridge slot number is set by the pci probe process */
 static u8 sb_slot = 5;
@@ -35,7 +36,7 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 			break;
 		}
 	} else {
-		irq = BONITO_IRQ_BASE + 25 + pin;
+		irq = LOONGSON_IRQ_BASE + 25 + pin;
 	}
 	return irq;
 
diff --git a/arch/mips/pci/ops-bonito64.c b/arch/mips/pci/ops-bonito64.c
index 54e55e7..1b3e03f 100644
--- a/arch/mips/pci/ops-bonito64.c
+++ b/arch/mips/pci/ops-bonito64.c
@@ -29,13 +29,8 @@
 #define PCI_ACCESS_READ  0
 #define PCI_ACCESS_WRITE 1
 
-#ifdef CONFIG_LEMOTE_FULOONG2E
-#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (offset))
-#define ID_SEL_BEGIN 11
-#else
 #define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(_pcictrl_bonito_pcicfg + (offset))
 #define ID_SEL_BEGIN 10
-#endif
 #define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
 
 
@@ -77,10 +72,8 @@ static int bonito64_pcibios_config_access(unsigned char access_type,
 	addrp = CFG_SPACE_REG(addr & 0xffff);
 	if (access_type == PCI_ACCESS_WRITE) {
 		writel(cpu_to_le32(*data), addrp);
-#ifndef CONFIG_LEMOTE_FULOONG2E
 		/* Wait till done */
 		while (BONITO_PCIMSTAT & 0xF);
-#endif
 	} else {
 		*data = le32_to_cpu(readl(addrp));
 	}
diff --git a/arch/mips/pci/ops-fuloong2e.c b/arch/mips/pci/ops-fuloong2e.c
new file mode 100644
index 0000000..171f65c
--- /dev/null
+++ b/arch/mips/pci/ops-fuloong2e.c
@@ -0,0 +1,154 @@
+/*
+ * fuloong2e specific PCI support.
+ *
+ * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
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
1.6.2.1
