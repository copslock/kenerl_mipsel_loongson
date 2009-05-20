Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:50:56 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.250]:54638 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025170AbZETVul (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:50:41 +0100
Received: by rv-out-0708.google.com with SMTP id k29so231941rvb.24
        for <multiple recipients>; Wed, 20 May 2009 14:50:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hkwjIVOl2xzgJpnPqiJVeyYf7LwEFNMuX4O5gt/buTc=;
        b=CgOILNclL5nBl/yzzPLKKQLIluIK93ToQxanHMtLwvR2WGndn5ckA1E4nHZwFhs9xM
         NECT66gwgTjhxUUx5m2JAvlfIdKhEXvFyJ64o72hMLLgb86s5DH1+pwC1jMCK/KWcBdC
         5l4hmV8dVbzRhdFYpL4Epk9pJktgatd8Kp+k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XFPWjNEqp3a2Xhm3yj4yimZFfErR8pVUXPT8C6Rz5vQXnAjB5EnBMevvGadUSD+ocj
         r3zxhdD6atI3JkgsLv77lyvHCPzHrHco0tEbh1CkleLL69kt/gzSIBH/6sgaalROCq90
         8b1dKVAGOUpAIdFNoRe/sZe3Yzinoi/P5raY4=
Received: by 10.141.36.17 with SMTP id o17mr841969rvj.50.1242856238375;
        Wed, 20 May 2009 14:50:38 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id c20sm4895985rvf.0.2009.05.20.14.50.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:50:37 -0700 (PDT)
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
Subject: [loongson-PATCH-v1 04/27] change the naming methods
Date:	Thu, 21 May 2009 05:50:22 +0800
Message-Id: <c29fbc62564a7ed90e0d0cb8114a2c0b14155370.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

to support loongson-based machines made by non-lemote companies, some
lemote* names should be changed to loongson* names, and to support the
future loongson2f-based fulong machines, the current fulong's name
should be fuloong-2e or fuloong2e, and also, FULONG to FULOONG2E, lm2e
to fuloong2e, LEMOTE to LOONGSON.

at the same time, tons of lines have been cleaned up with the help of
scripts/checkpatch.pl

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .gitignore                                         |    1 +
 arch/mips/Kconfig                                  |    4 +-
 arch/mips/Makefile                                 |    6 +-
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   66 ------
 arch/mips/include/asm/mach-lemote/mc146818rtc.h    |   36 ---
 arch/mips/include/asm/mach-lemote/pci.h            |   30 ---
 arch/mips/include/asm/mach-lemote/war.h            |   25 --
 .../mips/include/asm/mach-loongson/dma-coherence.h |   66 ++++++
 arch/mips/include/asm/mach-loongson/loongson.h     |   14 ++
 arch/mips/include/asm/mach-loongson/mc146818rtc.h  |   36 +++
 arch/mips/include/asm/mach-loongson/pci.h          |   32 +++
 arch/mips/include/asm/mach-loongson/war.h          |   25 ++
 arch/mips/include/asm/mips-boards/bonito64.h       |    2 +-
 arch/mips/lemote/lm2e/Makefile                     |    7 -
 arch/mips/lemote/lm2e/bonito-irq.c                 |   74 ------
 arch/mips/lemote/lm2e/dbg_io.c                     |  146 ------------
 arch/mips/lemote/lm2e/irq.c                        |  144 ------------
 arch/mips/lemote/lm2e/mem.c                        |   23 --
 arch/mips/lemote/lm2e/pci.c                        |   97 --------
 arch/mips/lemote/lm2e/prom.c                       |   97 --------
 arch/mips/lemote/lm2e/reset.c                      |   41 ----
 arch/mips/lemote/lm2e/setup.c                      |  111 ---------
 arch/mips/loongson/fuloong-2e/Makefile             |    7 +
 arch/mips/loongson/fuloong-2e/bonito-irq.c         |   73 ++++++
 arch/mips/loongson/fuloong-2e/dbg_io.c             |  153 ++++++++++++
 arch/mips/loongson/fuloong-2e/irq.c                |  140 +++++++++++
 arch/mips/loongson/fuloong-2e/mem.c                |   23 ++
 arch/mips/loongson/fuloong-2e/pci.c                |   95 ++++++++
 arch/mips/loongson/fuloong-2e/prom.c               |   90 ++++++++
 arch/mips/loongson/fuloong-2e/reset.c              |   37 +++
 arch/mips/loongson/fuloong-2e/setup.c              |  108 +++++++++
 arch/mips/pci/Makefile                             |    2 +-
 arch/mips/pci/fixup-fuloong2e.c                    |  242 ++++++++++++++++++++
 arch/mips/pci/fixup-lm2e.c                         |  242 --------------------
 arch/mips/pci/ops-bonito64.c                       |   16 +-
 35 files changed, 1158 insertions(+), 1153 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-lemote/dma-coherence.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/mc146818rtc.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/pci.h
 delete mode 100644 arch/mips/include/asm/mach-lemote/war.h
 create mode 100644 arch/mips/include/asm/mach-loongson/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson.h
 create mode 100644 arch/mips/include/asm/mach-loongson/mc146818rtc.h
 create mode 100644 arch/mips/include/asm/mach-loongson/pci.h
 create mode 100644 arch/mips/include/asm/mach-loongson/war.h
 delete mode 100644 arch/mips/lemote/lm2e/Makefile
 delete mode 100644 arch/mips/lemote/lm2e/bonito-irq.c
 delete mode 100644 arch/mips/lemote/lm2e/dbg_io.c
 delete mode 100644 arch/mips/lemote/lm2e/irq.c
 delete mode 100644 arch/mips/lemote/lm2e/mem.c
 delete mode 100644 arch/mips/lemote/lm2e/pci.c
 delete mode 100644 arch/mips/lemote/lm2e/prom.c
 delete mode 100644 arch/mips/lemote/lm2e/reset.c
 delete mode 100644 arch/mips/lemote/lm2e/setup.c
 create mode 100644 arch/mips/loongson/fuloong-2e/Makefile
 create mode 100644 arch/mips/loongson/fuloong-2e/bonito-irq.c
 create mode 100644 arch/mips/loongson/fuloong-2e/dbg_io.c
 create mode 100644 arch/mips/loongson/fuloong-2e/irq.c
 create mode 100644 arch/mips/loongson/fuloong-2e/mem.c
 create mode 100644 arch/mips/loongson/fuloong-2e/pci.c
 create mode 100644 arch/mips/loongson/fuloong-2e/prom.c
 create mode 100644 arch/mips/loongson/fuloong-2e/reset.c
 create mode 100644 arch/mips/loongson/fuloong-2e/setup.c
 create mode 100644 arch/mips/pci/fixup-fuloong2e.c
 delete mode 100644 arch/mips/pci/fixup-lm2e.c

diff --git a/.gitignore b/.gitignore
index 869e1a3..bdcb7ba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@
 tags
 TAGS
 vmlinux
+vmlinux.32
 System.map
 Module.markers
 Module.symvers
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 557b191..d9ecb44 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -156,8 +156,8 @@ config LASAT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
-config LEMOTE_FULONG
-	bool "Lemote Fulong mini-PC"
+config LEMOTE_FULOONG2E
+	bool "Lemote Fuloong(2e) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
 	select CEVT_R4K
 	select CSRC_R4K
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a9b654f..7afec0b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -306,9 +306,9 @@ load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
 #
 # lemote fulong mini-PC board
 #
-core-$(CONFIG_LEMOTE_FULONG) +=arch/mips/lemote/lm2e/
-load-$(CONFIG_LEMOTE_FULONG) +=0xffffffff80100000
-cflags-$(CONFIG_LEMOTE_FULONG) += -I$(srctree)/arch/mips/include/asm/mach-lemote
+core-$(CONFIG_LEMOTE_FULOONG2E) +=arch/mips/loongson/fuloong-2e/
+load-$(CONFIG_LEMOTE_FULOONG2E) +=0xffffffff80100000
+cflags-$(CONFIG_LEMOTE_FULOONG2E) += -I$(srctree)/arch/mips/include/asm/mach-loongson
 
 #
 # MIPS Malta board
diff --git a/arch/mips/include/asm/mach-lemote/dma-coherence.h b/arch/mips/include/asm/mach-lemote/dma-coherence.h
deleted file mode 100644
index 38fad7d..0000000
--- a/arch/mips/include/asm/mach-lemote/dma-coherence.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006, 07  Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- */
-#ifndef __ASM_MACH_LEMOTE_DMA_COHERENCE_H
-#define __ASM_MACH_LEMOTE_DMA_COHERENCE_H
-
-struct device;
-
-static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
-					  size_t size)
-{
-	return virt_to_phys(addr) | 0x80000000;
-}
-
-static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
-					       struct page *page)
-{
-	return page_to_phys(page) | 0x80000000;
-}
-
-static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
-{
-	return dma_addr & 0x7fffffff;
-}
-
-static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
-{
-}
-
-static inline int plat_dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s,
-	 * so we can't guarantee allocations that must be
-	 * within a tighter range than GFP_DMA..
-	 */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-
-static inline void plat_extra_sync_for_device(struct device *dev)
-{
-	return;
-}
-
-static inline int plat_dma_mapping_error(struct device *dev,
-					 dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int plat_device_is_coherent(struct device *dev)
-{
-	return 0;
-}
-
-#endif /* __ASM_MACH_LEMOTE_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-lemote/mc146818rtc.h b/arch/mips/include/asm/mach-lemote/mc146818rtc.h
deleted file mode 100644
index ed5147e..0000000
--- a/arch/mips/include/asm/mach-lemote/mc146818rtc.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 2001, 03, 07 by Ralf Baechle (ralf@linux-mips.org)
- *
- * RTC routines for PC style attached Dallas chip.
- */
-#ifndef __ASM_MACH_LEMOTE_MC146818RTC_H
-#define __ASM_MACH_LEMOTE_MC146818RTC_H
-
-#include <linux/io.h>
-
-#define RTC_PORT(x)	(0x70 + (x))
-#define RTC_IRQ		8
-
-static inline unsigned char CMOS_READ(unsigned long addr)
-{
-	outb_p(addr, RTC_PORT(0));
-	return inb_p(RTC_PORT(1));
-}
-
-static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
-{
-	outb_p(addr, RTC_PORT(0));
-	outb_p(data, RTC_PORT(1));
-}
-
-#define RTC_ALWAYS_BCD	0
-
-#ifndef mc146818_decode_year
-#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
-#endif
-
-#endif /* __ASM_MACH_LEMOTE_MC146818RTC_H */
diff --git a/arch/mips/include/asm/mach-lemote/pci.h b/arch/mips/include/asm/mach-lemote/pci.h
deleted file mode 100644
index ea6aa14..0000000
--- a/arch/mips/include/asm/mach-lemote/pci.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
- *
- * This program is free software; you can redistribute it
- * and/or modify it under the terms of the GNU General
- * Public License as published by the Free Software
- * Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied
- * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- * PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
- * 02139, USA.
- */
-
-#ifndef _LEMOTE_PCI_H_
-#define _LEMOTE_PCI_H_
-
-#define LOONGSON2E_PCI_MEM_START	0x14000000UL
-#define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
-#define LOONGSON2E_PCI_IO_START		0x00004000UL
-#define LOONGSON2E_IO_PORT_BASE		0x1fd00000UL
-
-#endif /* !_LEMOTE_PCI_H_ */
diff --git a/arch/mips/include/asm/mach-lemote/war.h b/arch/mips/include/asm/mach-lemote/war.h
deleted file mode 100644
index 05f89e0..0000000
--- a/arch/mips/include/asm/mach-lemote/war.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_LEMOTE_WAR_H
-#define __ASM_MIPS_MACH_LEMOTE_WAR_H
-
-#define R4600_V1_INDEX_ICACHEOP_WAR	0
-#define R4600_V1_HIT_CACHEOP_WAR	0
-#define R4600_V2_HIT_CACHEOP_WAR	0
-#define R5432_CP0_INTERRUPT_WAR		0
-#define BCM1250_M3_WAR			0
-#define SIBYTE_1956_WAR			0
-#define MIPS4K_ICACHE_REFILL_WAR	0
-#define MIPS_CACHE_SYNC_WAR		0
-#define TX49XX_ICACHE_INDEX_INV_WAR	0
-#define RM9000_CDEX_SMP_WAR		0
-#define ICACHE_REFILLS_WORKAROUND_WAR	0
-#define R10000_LLSC_WAR			0
-#define MIPS34K_MISSED_ITLB_WAR		0
-
-#endif /* __ASM_MIPS_MACH_LEMOTE_WAR_H */
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
new file mode 100644
index 0000000..f27d0f8
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
@@ -0,0 +1,66 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006, 07  Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ */
+#ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
+#define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
+
+struct device;
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+					  size_t size)
+{
+	return virt_to_phys(addr) | 0x80000000;
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+					       struct page *page)
+{
+	return page_to_phys(page) | 0x80000000;
+}
+
+static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+{
+	return dma_addr & 0x7fffffff;
+}
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
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
+#endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
new file mode 100644
index 0000000..18ebef1
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -0,0 +1,14 @@
+/*
+ * loongson-specific header file
+ */
+
+/* loongson internal northbridge initialization */
+extern void bonito_irq_init(void);
+
+/* command line */
+extern unsigned long bus_clock, cpu_clock_freq;
+extern unsigned long memsize, highmemsize;
+
+/* loongson-based machines specific reboot setup */
+extern void loongson_reboot_setup(void);
+
diff --git a/arch/mips/include/asm/mach-loongson/mc146818rtc.h b/arch/mips/include/asm/mach-loongson/mc146818rtc.h
new file mode 100644
index 0000000..ed7fe97
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/mc146818rtc.h
@@ -0,0 +1,36 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998, 2001, 03, 07 by Ralf Baechle (ralf@linux-mips.org)
+ *
+ * RTC routines for PC style attached Dallas chip.
+ */
+#ifndef __ASM_MACH_LOONGSON_MC146818RTC_H
+#define __ASM_MACH_LOONGSON_MC146818RTC_H
+
+#include <linux/io.h>
+
+#define RTC_PORT(x)	(0x70 + (x))
+#define RTC_IRQ		8
+
+static inline unsigned char CMOS_READ(unsigned long addr)
+{
+	outb_p(addr, RTC_PORT(0));
+	return inb_p(RTC_PORT(1));
+}
+
+static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
+{
+	outb_p(addr, RTC_PORT(0));
+	outb_p(data, RTC_PORT(1));
+}
+
+#define RTC_ALWAYS_BCD	0
+
+#ifndef mc146818_decode_year
+#define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
+#endif
+
+#endif /* __ASM_MACH_LOONGSON_MC146818RTC_H */
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
new file mode 100644
index 0000000..e685096
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
+ *
+ * This program is free software; you can redistribute it
+ * and/or modify it under the terms of the GNU General
+ * Public License as published by the Free Software
+ * Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied
+ * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the Free
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
+ * 02139, USA.
+ */
+
+#ifndef _LOONGSON_PCI_H_
+#define _LOONGSON_PCI_H_
+
+extern struct pci_ops bonito64_pci_ops;
+
+#define LOONGSON2E_PCI_MEM_START	0x14000000UL
+#define LOONGSON2E_PCI_MEM_END		0x1fffffffUL
+#define LOONGSON2E_PCI_IO_START		0x00004000UL
+#define LOONGSON2E_IO_PORT_BASE		0x1fd00000UL
+
+#endif /* !_LOONGSON_PCI_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/war.h b/arch/mips/include/asm/mach-loongson/war.h
new file mode 100644
index 0000000..e42cace
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_LOONGSON_WAR_H
+#define __ASM_MIPS_MACH_LOONGSON_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_LOONGSON_WAR_H */
diff --git a/arch/mips/include/asm/mips-boards/bonito64.h b/arch/mips/include/asm/mips-boards/bonito64.h
index a0f04bb..a576ce0 100644
--- a/arch/mips/include/asm/mips-boards/bonito64.h
+++ b/arch/mips/include/asm/mips-boards/bonito64.h
@@ -26,7 +26,7 @@
 /* offsets from base register */
 #define BONITO(x)	(x)
 
-#elif defined(CONFIG_LEMOTE_FULONG)
+#elif defined(CONFIG_LEMOTE_FULOONG2E)
 
 #define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x)))
 #define BONITO_IRQ_BASE   32
diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
deleted file mode 100644
index d34671d..0000000
--- a/arch/mips/lemote/lm2e/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for Lemote Fulong mini-PC board.
-#
-
-obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
-
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/lemote/lm2e/bonito-irq.c b/arch/mips/lemote/lm2e/bonito-irq.c
deleted file mode 100644
index 8fc3bce..0000000
--- a/arch/mips/lemote/lm2e/bonito-irq.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/mips-boards/bonito64.h>
-
-
-static inline void bonito_irq_enable(unsigned int irq)
-{
-	BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE));
-	mmiowb();
-}
-
-static inline void bonito_irq_disable(unsigned int irq)
-{
-	BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
-	mmiowb();
-}
-
-static struct irq_chip bonito_irq_type = {
-	.name	= "bonito_irq",
-	.ack	= bonito_irq_disable,
-	.mask	= bonito_irq_disable,
-	.mask_ack = bonito_irq_disable,
-	.unmask	= bonito_irq_enable,
-};
-
-static struct irqaction dma_timeout_irqaction = {
-	.handler	= no_action,
-	.name		= "dma_timeout",
-};
-
-void bonito_irq_init(void)
-{
-	u32 i;
-
-	for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++) {
-		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
-	}
-
-	setup_irq(BONITO_IRQ_BASE + 10, &dma_timeout_irqaction);
-}
diff --git a/arch/mips/lemote/lm2e/dbg_io.c b/arch/mips/lemote/lm2e/dbg_io.c
deleted file mode 100644
index 6c95da3..0000000
--- a/arch/mips/lemote/lm2e/dbg_io.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include <asm/serial.h>
-
-#define         UART16550_BAUD_2400             2400
-#define         UART16550_BAUD_4800             4800
-#define         UART16550_BAUD_9600             9600
-#define         UART16550_BAUD_19200            19200
-#define         UART16550_BAUD_38400            38400
-#define         UART16550_BAUD_57600            57600
-#define         UART16550_BAUD_115200           115200
-
-#define         UART16550_PARITY_NONE           0
-#define         UART16550_PARITY_ODD            0x08
-#define         UART16550_PARITY_EVEN           0x18
-#define         UART16550_PARITY_MARK           0x28
-#define         UART16550_PARITY_SPACE          0x38
-
-#define         UART16550_DATA_5BIT             0x0
-#define         UART16550_DATA_6BIT             0x1
-#define         UART16550_DATA_7BIT             0x2
-#define         UART16550_DATA_8BIT             0x3
-
-#define         UART16550_STOP_1BIT             0x0
-#define         UART16550_STOP_2BIT             0x4
-
-/* ----------------------------------------------------- */
-
-/* === CONFIG === */
-#ifdef CONFIG_64BIT
-#define         BASE                    (0xffffffffbfd003f8)
-#else
-#define         BASE                    (0xbfd003f8)
-#endif
-
-#define         MAX_BAUD                BASE_BAUD
-/* === END OF CONFIG === */
-
-#define         REG_OFFSET              1
-
-/* register offset */
-#define         OFS_RCV_BUFFER          0
-#define         OFS_TRANS_HOLD          0
-#define         OFS_SEND_BUFFER         0
-#define         OFS_INTR_ENABLE         (1*REG_OFFSET)
-#define         OFS_INTR_ID             (2*REG_OFFSET)
-#define         OFS_DATA_FORMAT         (3*REG_OFFSET)
-#define         OFS_LINE_CONTROL        (3*REG_OFFSET)
-#define         OFS_MODEM_CONTROL       (4*REG_OFFSET)
-#define         OFS_RS232_OUTPUT        (4*REG_OFFSET)
-#define         OFS_LINE_STATUS         (5*REG_OFFSET)
-#define         OFS_MODEM_STATUS        (6*REG_OFFSET)
-#define         OFS_RS232_INPUT         (6*REG_OFFSET)
-#define         OFS_SCRATCH_PAD         (7*REG_OFFSET)
-
-#define         OFS_DIVISOR_LSB         (0*REG_OFFSET)
-#define         OFS_DIVISOR_MSB         (1*REG_OFFSET)
-
-/* memory-mapped read/write of the port */
-#define         UART16550_READ(y)	readb((char *)BASE + (y))
-#define         UART16550_WRITE(y, z)	writeb(z, (char *)BASE + (y))
-
-void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
-{
-	u32 divisor;
-
-	/* disable interrupts */
-	UART16550_WRITE(OFS_INTR_ENABLE, 0);
-
-	/* set up buad rate */
-	/* set DIAB bit */
-	UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
-
-	/* set divisor */
-	divisor = MAX_BAUD / baud;
-	UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
-	UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
-
-	/* clear DIAB bit */
-	UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
-
-	/* set data format */
-	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
-}
-
-static int remoteDebugInitialized;
-
-u8 getDebugChar(void)
-{
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		debugInit(UART16550_BAUD_115200,
-			  UART16550_DATA_8BIT,
-			  UART16550_PARITY_NONE, UART16550_STOP_1BIT);
-	}
-
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0) ;
-	return UART16550_READ(OFS_RCV_BUFFER);
-}
-
-int putDebugChar(u8 byte)
-{
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		/*
-		   debugInit(UART16550_BAUD_115200,
-		   UART16550_DATA_8BIT,
-		   UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
-	}
-
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0) ;
-	UART16550_WRITE(OFS_SEND_BUFFER, byte);
-	return 1;
-}
diff --git a/arch/mips/lemote/lm2e/irq.c b/arch/mips/lemote/lm2e/irq.c
deleted file mode 100644
index 3e0b7be..0000000
--- a/arch/mips/lemote/lm2e/irq.c
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/irq_cpu.h>
-#include <asm/i8259.h>
-#include <asm/mipsregs.h>
-#include <asm/mips-boards/bonito64.h>
-
-
-/*
- * the first level int-handler will jump here if it is a bonito irq
- */
-static void bonito_irqdispatch(void)
-{
-	u32 int_status;
-	int i;
-
-	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
-	int_status = BONITO_INTISR;
-	if (int_status & (1 << 10)) {
-		while (int_status & (1 << 10)) {
-			udelay(1);
-			int_status = BONITO_INTISR;
-		}
-	}
-
-	/* Get pending sources, masked by current enables */
-	int_status = BONITO_INTISR & BONITO_INTEN;
-
-	if (int_status != 0) {
-		i = __ffs(int_status);
-		int_status &= ~(1 << i);
-		do_IRQ(BONITO_IRQ_BASE + i);
-	}
-}
-
-static void i8259_irqdispatch(void)
-{
-	int irq;
-
-	irq = i8259_irq();
-	if (irq >= 0) {
-		do_IRQ(irq);
-	} else {
-		spurious_interrupt();
-	}
-
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
-
-	if (pending & CAUSEF_IP7) {
-		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
-	} else if (pending & CAUSEF_IP5) {
-		i8259_irqdispatch();
-	} else if (pending & CAUSEF_IP2) {
-		bonito_irqdispatch();
-	} else {
-		spurious_interrupt();
-	}
-}
-
-static struct irqaction cascade_irqaction = {
-	.handler = no_action,
-	.mask = CPU_MASK_NONE,
-	.name = "cascade",
-};
-
-void __init arch_init_irq(void)
-{
-	extern void bonito_irq_init(void);
-
-	/*
-	 * Clear all of the interrupts while we change the able around a bit.
-	 * int-handler is not on bootstrap
-	 */
-	clear_c0_status(ST0_IM | ST0_BEV);
-	local_irq_disable();
-
-	/* most bonito irq should be level triggered */
-	BONITO_INTEDGE = BONITO_ICU_SYSTEMERR | BONITO_ICU_MASTERERR |
-		BONITO_ICU_RETRYERR | BONITO_ICU_MBOXES;
-	BONITO_INTSTEER = 0;
-
-	/*
-	 * Mask out all interrupt by writing "1" to all bit position in
-	 * the interrupt reset reg.
-	 */
-	BONITO_INTENCLR = ~0;
-
-	/* init all controller
-	 *   0-15         ------> i8259 interrupt
-	 *   16-23        ------> mips cpu interrupt
-	 *   32-63        ------> bonito irq
-	 */
-
-	/* Sets the first-level interrupt dispatcher. */
-	mips_cpu_irq_init();
-	init_i8259_irqs();
-	bonito_irq_init();
-
-	/*
-	printk("GPIODATA=%x, GPIOIE=%x\n", BONITO_GPIODATA, BONITO_GPIOIE);
-	printk("INTEN=%x, INTSET=%x, INTCLR=%x, INTISR=%x\n",
-			BONITO_INTEN, BONITO_INTENSET,
-			BONITO_INTENCLR, BONITO_INTISR);
-	*/
-
-	/* bonito irq at IP2 */
-	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cascade_irqaction);
-	/* 8259 irq at IP5 */
-	setup_irq(MIPS_CPU_IRQ_BASE + 5, &cascade_irqaction);
-
-}
diff --git a/arch/mips/lemote/lm2e/mem.c b/arch/mips/lemote/lm2e/mem.c
deleted file mode 100644
index 16cd215..0000000
--- a/arch/mips/lemote/lm2e/mem.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/fs.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-
-/* override of arch/mips/mm/cache.c: __uncached_access */
-int __uncached_access(struct file *file, unsigned long addr)
-{
-	if (file->f_flags & O_SYNC)
-		return 1;
-
-	/*
-	 * On the Lemote Loongson 2e system, the peripheral registers
-	 * reside between 0x1000:0000 and 0x2000:0000.
-	 */
-	return addr >= __pa(high_memory) ||
-		((addr >= 0x10000000) && (addr < 0x20000000));
-}
diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
deleted file mode 100644
index 8be03a8..0000000
--- a/arch/mips/lemote/lm2e/pci.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * pci.c
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/mips-boards/bonito64.h>
-#include <asm/mach-lemote/pci.h>
-
-extern struct pci_ops bonito64_pci_ops;
-
-static struct resource loongson2e_pci_mem_resource = {
-	.name   = "LOONGSON2E PCI MEM",
-	.start  = LOONGSON2E_PCI_MEM_START,
-	.end    = LOONGSON2E_PCI_MEM_END,
-	.flags  = IORESOURCE_MEM,
-};
-
-static struct resource loongson2e_pci_io_resource = {
-	.name   = "LOONGSON2E PCI IO MEM",
-	.start  = LOONGSON2E_PCI_IO_START,
-	.end    = IO_SPACE_LIMIT,
-	.flags  = IORESOURCE_IO,
-};
-
-static struct pci_controller  loongson2e_pci_controller = {
-	.pci_ops        = &bonito64_pci_ops,
-	.io_resource    = &loongson2e_pci_io_resource,
-	.mem_resource   = &loongson2e_pci_mem_resource,
-	.mem_offset     = 0x00000000UL,
-	.io_offset      = 0x00000000UL,
-};
-
-static void __init ict_pcimap(void)
-{
-	/*
-	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
-	 *
-	 * CPU address space [256M,448M] is window for accessing pci space
-	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
-	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
-	 */
-	/* 1,00 0110 ,0001 01,00 0000 */
-	BONITO_PCIMAP = 0x46140;
-
-	/* 1, 00 0010, 0000,01, 00 0000 */
-	/* BONITO_PCIMAP = 0x42040; */
-
-	/*
-	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
-	 */
-	BONITO_PCIBASE0 = 0x80000000;
-	BONITO_PCIBASE1 = 0x00800000;
-	BONITO_PCIBASE2 = 0x90000000;
-
-}
-
-static int __init pcibios_init(void)
-{
-	ict_pcimap();
-
-	loongson2e_pci_controller.io_map_base =
-	    (unsigned long) ioremap(LOONGSON2E_IO_PORT_BASE,
-				    loongson2e_pci_io_resource.end -
-				    loongson2e_pci_io_resource.start + 1);
-
-	register_pci_controller(&loongson2e_pci_controller);
-
-	return 0;
-}
-
-arch_initcall(pcibios_init);
diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
deleted file mode 100644
index 7edc15d..0000000
--- a/arch/mips/lemote/lm2e/prom.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * Based on Ocelot Linux port, which is
- * Copyright 2001 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- *
- * Copyright 2003 ICT CAS
- * Author: Michael Guo <guoyi@ict.ac.cn>
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/init.h>
-#include <linux/bootmem.h>
-#include <asm/bootinfo.h>
-
-extern unsigned long bus_clock;
-extern unsigned long cpu_clock_freq;
-extern unsigned int memsize, highmemsize;
-extern int putDebugChar(unsigned char byte);
-
-static int argc;
-/* pmon passes arguments in 32bit pointers */
-static int *arg;
-static int *env;
-
-const char *get_system_type(void)
-{
-	return "lemote-fulong";
-}
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-	long l;
-
-	/* arg[0] is "g", the rest is boot parameters */
-	arcs_cmdline[0] = '\0';
-	for (i = 1; i < argc; i++) {
-		l = (long)arg[i];
-		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
-		    >= sizeof(arcs_cmdline))
-			break;
-		strcat(arcs_cmdline, ((char *)l));
-		strcat(arcs_cmdline, " ");
-	}
-}
-
-void __init prom_init(void)
-{
-	long l;
-	argc = fw_arg0;
-	arg = (int *)fw_arg1;
-	env = (int *)fw_arg2;
-
-	prom_init_cmdline();
-
-	if ((strstr(arcs_cmdline, "console=")) == NULL)
-		strcat(arcs_cmdline, " console=ttyS0,115200");
-	if ((strstr(arcs_cmdline, "root=")) == NULL)
-		strcat(arcs_cmdline, " root=/dev/hda1");
-
-#define parse_even_earlier(res, option, p)				\
-do {									\
-	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
-		res = simple_strtol((char *)p + strlen(option"="),	\
-				    NULL, 10);				\
-} while (0)
-
-	l = (long)*env;
-	while (l != 0) {
-		parse_even_earlier(bus_clock, "busclock", l);
-		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
-		parse_even_earlier(memsize, "memsize", l);
-		parse_even_earlier(highmemsize, "highmemsize", l);
-		env++;
-		l = (long)*env;
-	}
-	if (memsize == 0)
-		memsize = 256;
-
-	pr_info("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
-	       bus_clock, cpu_clock_freq, memsize, highmemsize);
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-void prom_putchar(char c)
-{
-	putDebugChar(c);
-}
diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
deleted file mode 100644
index 099387a..0000000
--- a/arch/mips/lemote/lm2e/reset.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- */
-#include <linux/pm.h>
-
-#include <asm/reboot.h>
-
-static void loongson2e_restart(char *command)
-{
-#ifdef CONFIG_32BIT
-	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xbfe00104 |= (1 << 2);
-#else
-	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
-	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
-#endif
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-static void loongson2e_halt(void)
-{
-	while (1) ;
-}
-
-static void loongson2e_power_off(void)
-{
-	loongson2e_halt();
-}
-
-void mips_reboot_setup(void)
-{
-	_machine_restart = loongson2e_restart;
-	_machine_halt = loongson2e_halt;
-	pm_power_off = loongson2e_power_off;
-}
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
deleted file mode 100644
index ebd6cea..0000000
--- a/arch/mips/lemote/lm2e/setup.c
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- * setup.c - board dependent boot routines
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/bootmem.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-
-#include <asm/bootinfo.h>
-#include <asm/mc146818-time.h>
-#include <asm/time.h>
-#include <asm/wbflush.h>
-#include <asm/mach-lemote/pci.h>
-
-#ifdef CONFIG_VT
-#include <linux/console.h>
-#include <linux/screen_info.h>
-#endif
-
-extern void mips_reboot_setup(void);
-
-unsigned long cpu_clock_freq;
-unsigned long bus_clock;
-unsigned int memsize;
-unsigned int highmemsize = 0;
-
-void __init plat_time_init(void)
-{
-	/* setup mips r4k timer */
-	mips_hpt_frequency = cpu_clock_freq / 2;
-}
-
-unsigned long read_persistent_clock(void)
-{
-	return mc146818_get_cmos_time();
-}
-
-void (*__wbflush)(void);
-EXPORT_SYMBOL(__wbflush);
-
-static void wbflush_loongson2e(void)
-{
-	asm(".set\tpush\n\t"
-	    ".set\tnoreorder\n\t"
-	    ".set mips3\n\t"
-	    "sync\n\t"
-	    "nop\n\t"
-	    ".set\tpop\n\t"
-	    ".set mips0\n\t");
-}
-
-void __init plat_mem_setup(void)
-{
-	set_io_port_base((unsigned long)ioremap(LOONGSON2E_IO_PORT_BASE,
-				IO_SPACE_LIMIT - LOONGSON2E_PCI_IO_START + 1));
-	mips_reboot_setup();
-
-	__wbflush = wbflush_loongson2e;
-
-	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
-#ifdef CONFIG_64BIT
-	if (highmemsize > 0) {
-		add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
-	}
-#endif
-
-#ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
-
-	screen_info = (struct screen_info) {
-		0, 25,		/* orig-x, orig-y */
-		    0,		/* unused */
-		    0,		/* orig-video-page */
-		    0,		/* orig-video-mode */
-		    80,		/* orig-video-cols */
-		    0, 0, 0,	/* ega_ax, ega_bx, ega_cx */
-		    25,		/* orig-video-lines */
-		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
-		    16		/* orig-video-points */
-	};
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
-#endif
-
-}
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
new file mode 100644
index 0000000..d34671d
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Lemote Fulong mini-PC board.
+#
+
+obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/fuloong-2e/bonito-irq.c b/arch/mips/loongson/fuloong-2e/bonito-irq.c
new file mode 100644
index 0000000..5adf373
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/bonito-irq.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+
+static inline void bonito_irq_enable(unsigned int irq)
+{
+	BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE));
+	mmiowb();
+}
+
+static inline void bonito_irq_disable(unsigned int irq)
+{
+	BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+	mmiowb();
+}
+
+static struct irq_chip bonito_irq_type = {
+	.name	= "bonito_irq",
+	.ack	= bonito_irq_disable,
+	.mask	= bonito_irq_disable,
+	.mask_ack = bonito_irq_disable,
+	.unmask	= bonito_irq_enable,
+};
+
+static struct irqaction dma_timeout_irqaction = {
+	.handler	= no_action,
+	.name		= "dma_timeout",
+};
+
+void bonito_irq_init(void)
+{
+	u32 i;
+
+	for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++)
+		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
+
+	setup_irq(BONITO_IRQ_BASE + 10, &dma_timeout_irqaction);
+}
diff --git a/arch/mips/loongson/fuloong-2e/dbg_io.c b/arch/mips/loongson/fuloong-2e/dbg_io.c
new file mode 100644
index 0000000..84f8320
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/dbg_io.c
@@ -0,0 +1,153 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include <asm/serial.h>
+
+#define         UART16550_BAUD_2400             2400
+#define         UART16550_BAUD_4800             4800
+#define         UART16550_BAUD_9600             9600
+#define         UART16550_BAUD_19200            19200
+#define         UART16550_BAUD_38400            38400
+#define         UART16550_BAUD_57600            57600
+#define         UART16550_BAUD_115200           115200
+
+#define         UART16550_PARITY_NONE           0
+#define         UART16550_PARITY_ODD            0x08
+#define         UART16550_PARITY_EVEN           0x18
+#define         UART16550_PARITY_MARK           0x28
+#define         UART16550_PARITY_SPACE          0x38
+
+#define         UART16550_DATA_5BIT             0x0
+#define         UART16550_DATA_6BIT             0x1
+#define         UART16550_DATA_7BIT             0x2
+#define         UART16550_DATA_8BIT             0x3
+
+#define         UART16550_STOP_1BIT             0x0
+#define         UART16550_STOP_2BIT             0x4
+
+/* ----------------------------------------------------- */
+
+/* === CONFIG === */
+#ifdef CONFIG_64BIT
+#define         BASE                    (0xffffffffbfd003f8)
+#else
+#define         BASE                    (0xbfd003f8)
+#endif
+
+#define         MAX_BAUD                BASE_BAUD
+/* === END OF CONFIG === */
+
+#define         REG_OFFSET              1
+
+/* register offset */
+#define         OFS_RCV_BUFFER          0
+#define         OFS_TRANS_HOLD          0
+#define         OFS_SEND_BUFFER         0
+#define         OFS_INTR_ENABLE         (1*REG_OFFSET)
+#define         OFS_INTR_ID             (2*REG_OFFSET)
+#define         OFS_DATA_FORMAT         (3*REG_OFFSET)
+#define         OFS_LINE_CONTROL        (3*REG_OFFSET)
+#define         OFS_MODEM_CONTROL       (4*REG_OFFSET)
+#define         OFS_RS232_OUTPUT        (4*REG_OFFSET)
+#define         OFS_LINE_STATUS         (5*REG_OFFSET)
+#define         OFS_MODEM_STATUS        (6*REG_OFFSET)
+#define         OFS_RS232_INPUT         (6*REG_OFFSET)
+#define         OFS_SCRATCH_PAD         (7*REG_OFFSET)
+
+#define         OFS_DIVISOR_LSB         (0*REG_OFFSET)
+#define         OFS_DIVISOR_MSB         (1*REG_OFFSET)
+
+/* memory-mapped read/write of the port */
+#define         UART16550_READ(y)	readb((char *)BASE + (y))
+#define         UART16550_WRITE(y, z)	writeb(z, (char *)BASE + (y))
+
+void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
+{
+	u32 divisor;
+
+	/* disable interrupts */
+	UART16550_WRITE(OFS_INTR_ENABLE, 0);
+
+	/* set up buad rate */
+	/* set DIAB bit */
+	UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
+
+	/* set divisor */
+	divisor = MAX_BAUD / baud;
+	UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
+	UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
+
+	/* clear DIAB bit */
+	UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+
+	/* set data format */
+	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
+}
+
+static int remoteDebugInitialized;
+
+u8 getDebugChar(void)
+{
+	if (!remoteDebugInitialized) {
+		remoteDebugInitialized = 1;
+		debugInit(UART16550_BAUD_115200,
+			  UART16550_DATA_8BIT,
+			  UART16550_PARITY_NONE, UART16550_STOP_1BIT);
+	}
+
+	while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0)
+		;
+	return UART16550_READ(OFS_RCV_BUFFER);
+}
+
+int putDebugChar(u8 byte)
+{
+	if (!remoteDebugInitialized) {
+		remoteDebugInitialized = 1;
+		/*
+		   debugInit(UART16550_BAUD_115200,
+		   UART16550_DATA_8BIT,
+		   UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
+	}
+
+	while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0)
+		;
+	UART16550_WRITE(OFS_SEND_BUFFER, byte);
+	return 1;
+}
+
+void prom_putchar(char c)
+{
+	putDebugChar(c);
+}
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson/fuloong-2e/irq.c
new file mode 100644
index 0000000..118cd37
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+#include <asm/mips-boards/bonito64.h>
+
+#include <loongson.h>
+
+/*
+ * the first level int-handler will jump here if it is a bonito irq
+ */
+static void bonito_irqdispatch(void)
+{
+	u32 int_status;
+	int i;
+
+	/* workaround the IO dma problem: let cpu looping to allow DMA finish */
+	int_status = BONITO_INTISR;
+	if (int_status & (1 << 10)) {
+		while (int_status & (1 << 10)) {
+			udelay(1);
+			int_status = BONITO_INTISR;
+		}
+	}
+
+	/* Get pending sources, masked by current enables */
+	int_status = BONITO_INTISR & BONITO_INTEN;
+
+	if (int_status != 0) {
+		i = __ffs(int_status);
+		int_status &= ~(1 << i);
+		do_IRQ(BONITO_IRQ_BASE + i);
+	}
+}
+
+static void i8259_irqdispatch(void)
+{
+	int irq;
+
+	irq = i8259_irq();
+	if (irq >= 0)
+		do_IRQ(irq);
+	else
+		spurious_interrupt();
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+	if (pending & CAUSEF_IP7)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+	else if (pending & CAUSEF_IP5)
+		i8259_irqdispatch();
+	else if (pending & CAUSEF_IP2)
+		bonito_irqdispatch();
+	else
+		spurious_interrupt();
+}
+
+static struct irqaction cascade_irqaction = {
+	.handler = no_action,
+	.mask = CPU_MASK_NONE,
+	.name = "cascade",
+};
+
+void __init arch_init_irq(void)
+{
+	/*
+	 * Clear all of the interrupts while we change the able around a bit.
+	 * int-handler is not on bootstrap
+	 */
+	clear_c0_status(ST0_IM | ST0_BEV);
+	local_irq_disable();
+
+	/* most bonito irq should be level triggered */
+	BONITO_INTEDGE = BONITO_ICU_SYSTEMERR | BONITO_ICU_MASTERERR |
+		BONITO_ICU_RETRYERR | BONITO_ICU_MBOXES;
+	BONITO_INTSTEER = 0;
+
+	/*
+	 * Mask out all interrupt by writing "1" to all bit position in
+	 * the interrupt reset reg.
+	 */
+	BONITO_INTENCLR = ~0;
+
+	/* init all controller
+	 *   0-15         ------> i8259 interrupt
+	 *   16-23        ------> mips cpu interrupt
+	 *   32-63        ------> bonito irq
+	 */
+
+	/* Sets the first-level interrupt dispatcher. */
+	mips_cpu_irq_init();
+	init_i8259_irqs();
+	bonito_irq_init();
+
+	/*
+	printk("GPIODATA=%x, GPIOIE=%x\n", BONITO_GPIODATA, BONITO_GPIOIE);
+	printk("INTEN=%x, INTSET=%x, INTCLR=%x, INTISR=%x\n",
+			BONITO_INTEN, BONITO_INTENSET,
+			BONITO_INTENCLR, BONITO_INTISR);
+	*/
+
+	/* bonito irq at IP2 */
+	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cascade_irqaction);
+	/* 8259 irq at IP5 */
+	setup_irq(MIPS_CPU_IRQ_BASE + 5, &cascade_irqaction);
+
+}
diff --git a/arch/mips/loongson/fuloong-2e/mem.c b/arch/mips/loongson/fuloong-2e/mem.c
new file mode 100644
index 0000000..16cd215
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/mem.c
@@ -0,0 +1,23 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/fs.h>
+#include <linux/fcntl.h>
+#include <linux/mm.h>
+
+/* override of arch/mips/mm/cache.c: __uncached_access */
+int __uncached_access(struct file *file, unsigned long addr)
+{
+	if (file->f_flags & O_SYNC)
+		return 1;
+
+	/*
+	 * On the Lemote Loongson 2e system, the peripheral registers
+	 * reside between 0x1000:0000 and 0x2000:0000.
+	 */
+	return addr >= __pa(high_memory) ||
+		((addr >= 0x10000000) && (addr < 0x20000000));
+}
diff --git a/arch/mips/loongson/fuloong-2e/pci.c b/arch/mips/loongson/fuloong-2e/pci.c
new file mode 100644
index 0000000..4c4bc07
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/pci.c
@@ -0,0 +1,95 @@
+/*
+ * pci.c
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/mips-boards/bonito64.h>
+#include <pci.h>
+
+static struct resource loongson2e_pci_mem_resource = {
+	.name   = "LOONGSON2E PCI MEM",
+	.start  = LOONGSON2E_PCI_MEM_START,
+	.end    = LOONGSON2E_PCI_MEM_END,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct resource loongson2e_pci_io_resource = {
+	.name   = "LOONGSON2E PCI IO MEM",
+	.start  = LOONGSON2E_PCI_IO_START,
+	.end    = IO_SPACE_LIMIT,
+	.flags  = IORESOURCE_IO,
+};
+
+static struct pci_controller  loongson2e_pci_controller = {
+	.pci_ops        = &bonito64_pci_ops,
+	.io_resource    = &loongson2e_pci_io_resource,
+	.mem_resource   = &loongson2e_pci_mem_resource,
+	.mem_offset     = 0x00000000UL,
+	.io_offset      = 0x00000000UL,
+};
+
+static void __init ict_pcimap(void)
+{
+	/*
+	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
+	 *
+	 * CPU address space [256M,448M] is window for accessing pci space
+	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
+	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+	 */
+	/* 1,00 0110 ,0001 01,00 0000 */
+	BONITO_PCIMAP = 0x46140;
+
+	/* 1, 00 0010, 0000,01, 00 0000 */
+	/* BONITO_PCIMAP = 0x42040; */
+
+	/*
+	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
+	 */
+	BONITO_PCIBASE0 = 0x80000000;
+	BONITO_PCIBASE1 = 0x00800000;
+	BONITO_PCIBASE2 = 0x90000000;
+
+}
+
+static int __init pcibios_init(void)
+{
+	ict_pcimap();
+
+	loongson2e_pci_controller.io_map_base =
+	    (unsigned long) ioremap(LOONGSON2E_IO_PORT_BASE,
+				    loongson2e_pci_io_resource.end -
+				    loongson2e_pci_io_resource.start + 1);
+
+	register_pci_controller(&loongson2e_pci_controller);
+
+	return 0;
+}
+
+arch_initcall(pcibios_init);
diff --git a/arch/mips/loongson/fuloong-2e/prom.c b/arch/mips/loongson/fuloong-2e/prom.c
new file mode 100644
index 0000000..95081f4
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/prom.c
@@ -0,0 +1,90 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+static int argc;
+/* pmon passes arguments in 32bit pointers */
+static int *arg;
+static int *env;
+
+const char *get_system_type(void)
+{
+	return "lemote-fulong";
+}
+
+void __init prom_init_cmdline(void)
+{
+	int i;
+	long l;
+
+	/* arg[0] is "g", the rest is boot parameters */
+	arcs_cmdline[0] = '\0';
+	for (i = 1; i < argc; i++) {
+		l = (long)arg[i];
+		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, ((char *)l));
+		strcat(arcs_cmdline, " ");
+	}
+}
+
+#define parse_even_earlier(res, option, p)				\
+do {									\
+	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
+			strict_strtol((char *)p + strlen(option"="),	\
+				    10, &res);				\
+} while (0)
+
+
+void __init prom_init(void)
+{
+	long l;
+	argc = fw_arg0;
+	arg = (int *)fw_arg1;
+	env = (int *)fw_arg2;
+
+	prom_init_cmdline();
+
+	if ((strstr(arcs_cmdline, "console=")) == NULL)
+		strcat(arcs_cmdline, " console=ttyS0,115200");
+	if ((strstr(arcs_cmdline, "root=")) == NULL)
+		strcat(arcs_cmdline, " root=/dev/hda1");
+
+	l = (long)*env;
+	while (l != 0) {
+		parse_even_earlier(bus_clock, "busclock", l);
+		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
+		parse_even_earlier(memsize, "memsize", l);
+		parse_even_earlier(highmemsize, "highmemsize", l);
+		env++;
+		l = (long)*env;
+	}
+	if (memsize == 0)
+		memsize = 256;
+
+	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
+	       bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson/fuloong-2e/reset.c
new file mode 100644
index 0000000..769a2ce
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -0,0 +1,37 @@
+/*
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ */
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+
+static void loongson_restart(char *command)
+{
+#ifdef CONFIG_32BIT
+	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
+	*(unsigned long *)0xbfe00104 |= (1 << 2);
+#else
+	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
+	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
+#endif
+	__asm__ __volatile__("jr\t%0" : : "r"(0xbfc00000));
+}
+
+static void loongson_halt(void)
+{
+	while (1)
+		;
+}
+
+void loongson_reboot_setup(void)
+{
+	_machine_restart = loongson_restart;
+	_machine_halt = loongson_halt;
+	pm_power_off = loongson_halt;
+}
diff --git a/arch/mips/loongson/fuloong-2e/setup.c b/arch/mips/loongson/fuloong-2e/setup.c
new file mode 100644
index 0000000..ae226a4
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/setup.c
@@ -0,0 +1,108 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ * setup.c - board dependent boot routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mc146818-time.h>
+#include <asm/wbflush.h>
+#include <asm/time.h>
+
+#include <loongson.h>
+#include <pci.h>
+
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#endif
+
+unsigned long cpu_clock_freq, bus_clock;
+unsigned long memsize, highmemsize;
+
+void __init plat_time_init(void)
+{
+	/* setup mips r4k timer */
+	mips_hpt_frequency = cpu_clock_freq / 2;
+}
+
+unsigned long read_persistent_clock(void)
+{
+	return mc146818_get_cmos_time();
+}
+
+void (*__wbflush)(void);
+EXPORT_SYMBOL(__wbflush);
+
+static void wbflush_loongson2e(void)
+{
+	asm(".set\tpush\n\t"
+	    ".set\tnoreorder\n\t"
+	    ".set mips3\n\t"
+	    "sync\n\t"
+	    "nop\n\t"
+	    ".set\tpop\n\t"
+	    ".set mips0\n\t");
+}
+
+void __init plat_mem_setup(void)
+{
+	set_io_port_base((unsigned long)ioremap(LOONGSON2E_IO_PORT_BASE,
+				IO_SPACE_LIMIT - LOONGSON2E_PCI_IO_START + 1));
+	loongson_reboot_setup();
+
+	__wbflush = wbflush_loongson2e;
+
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+#ifdef CONFIG_64BIT
+	if (highmemsize > 0)
+		add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+	conswitchp = &vga_con;
+
+	screen_info = (struct screen_info) {
+		0, 25,		/* orig-x, orig-y */
+		    0,		/* unused */
+		    0,		/* orig-video-page */
+		    0,		/* orig-video-mode */
+		    80,		/* orig-video-cols */
+		    0, 0, 0,	/* ega_ax, ega_bx, ega_cx */
+		    25,		/* orig-video-lines */
+		    VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
+		    16		/* orig-video-points */
+	};
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
+#endif
+#endif
+
+}
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index e8a97f5..1c66fc0 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
-obj-$(CONFIG_LEMOTE_FULONG)	+= fixup-lm2e.o ops-bonito64.o
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-bonito64.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
new file mode 100644
index 0000000..bd26008
--- /dev/null
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -0,0 +1,242 @@
+/*
+ * fixup-fuloong2e.c
+ *
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, ICT CAS
+ *   lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/mips-boards/bonito64.h>
+
+/* South bridge slot number is set by the pci probe process */
+static u8 sb_slot = 5;
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq = 0;
+
+	if (slot == sb_slot) {
+		switch (PCI_FUNC(dev->devfn)) {
+		case 2:
+			irq = 10;
+			break;
+		case 3:
+			irq = 11;
+			break;
+		case 5:
+			irq = 9;
+			break;
+		}
+	} else {
+		irq = BONITO_IRQ_BASE + 25 + pin;
+	}
+	return irq;
+
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static void __init fuloong2e_nec_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	/* Configues port 1, 2, 3, 4 to be validate*/
+	pci_read_config_dword(pdev, 0xe0, &val);
+	pci_write_config_dword(pdev, 0xe0, (val & ~7) | 0x4);
+
+	/* System clock is 48-MHz Oscillator. */
+	pci_write_config_dword(pdev, 0xe4, 1 << 5);
+}
+
+static void __init fuloong2e_686b_func0_fixup(struct pci_dev *pdev)
+{
+	unsigned char c;
+
+	sb_slot = PCI_SLOT(pdev->devfn);
+
+	printk(KERN_INFO "via686b fix: ISA bridge\n");
+
+	/*  Enable I/O Recovery time */
+	pci_write_config_byte(pdev, 0x40, 0x08);
+
+	/*  Enable ISA refresh */
+	pci_write_config_byte(pdev, 0x41, 0x01);
+
+	/*  disable ISA line buffer */
+	pci_write_config_byte(pdev, 0x45, 0x00);
+
+	/*  Gate INTR, and flush line buffer */
+	pci_write_config_byte(pdev, 0x46, 0xe0);
+
+	/*  Disable PCI Delay Transaction, Enable EISA ports 4D0/4D1. */
+	/* pci_write_config_byte(pdev, 0x47, 0x20); */
+
+	/*
+	 *  enable PCI Delay Transaction, Enable EISA ports 4D0/4D1.
+	 *  enable time-out timer
+	 */
+	pci_write_config_byte(pdev, 0x47, 0xe6);
+
+	/*
+	 * enable level trigger on pci irqs: 9,10,11,13
+	 * important! without this PCI interrupts won't work
+	 */
+	outb(0x2e, 0x4d1);
+
+	/*  512 K PCI Decode */
+	pci_write_config_byte(pdev, 0x48, 0x01);
+
+	/*  Wait for PGNT before grant to ISA Master/DMA */
+	pci_write_config_byte(pdev, 0x4a, 0x84);
+
+	/*
+	 * Plug'n'Play
+	 *
+	 *  Parallel DRQ 3, Floppy DRQ 2 (default)
+	 */
+	pci_write_config_byte(pdev, 0x50, 0x0e);
+
+	/*
+	 * IRQ Routing for Floppy and Parallel port
+	 *
+	 *  IRQ 6 for floppy, IRQ 7 for parallel port
+	 */
+	pci_write_config_byte(pdev, 0x51, 0x76);
+
+	/* IRQ Routing for serial ports (take IRQ 3 and 4) */
+	pci_write_config_byte(pdev, 0x52, 0x34);
+
+	/*  All IRQ's level triggered. */
+	pci_write_config_byte(pdev, 0x54, 0x00);
+
+	/* route PIRQA-D irq */
+	pci_write_config_byte(pdev, 0x55, 0x90);	/* bit 7-4, PIRQA */
+	pci_write_config_byte(pdev, 0x56, 0xba);	/* bit 7-4, PIRQC; */
+							/* 3-0, PIRQB */
+	pci_write_config_byte(pdev, 0x57, 0xd0);	/* bit 7-4, PIRQD */
+
+	/* enable function 5/6, audio/modem */
+	pci_read_config_byte(pdev, 0x85, &c);
+	c &= ~(0x3 << 2);
+	pci_write_config_byte(pdev, 0x85, c);
+
+	printk(KERN_INFO"via686b fix: ISA bridge done\n");
+}
+
+static void __init fuloong2e_686b_func1_fixup(struct pci_dev *pdev)
+{
+	printk(KERN_INFO"via686b fix: IDE\n");
+
+	/* Modify IDE controller setup */
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 48);
+	pci_write_config_byte(pdev, PCI_COMMAND,
+			      PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+			      PCI_COMMAND_MASTER);
+	pci_write_config_byte(pdev, 0x40, 0x0b);
+	/* legacy mode */
+	pci_write_config_byte(pdev, 0x42, 0x09);
+
+#if 1/* play safe, otherwise we may see notebook's usb keyboard lockup */
+	/* disable read prefetch/write post buffers */
+	pci_write_config_byte(pdev, 0x41, 0x02);
+
+	/* use 3/4 as fifo thresh hold  */
+	pci_write_config_byte(pdev, 0x43, 0x0a);
+	pci_write_config_byte(pdev, 0x44, 0x00);
+
+	pci_write_config_byte(pdev, 0x45, 0x00);
+#else
+	pci_write_config_byte(pdev, 0x41, 0xc2);
+	pci_write_config_byte(pdev, 0x43, 0x35);
+	pci_write_config_byte(pdev, 0x44, 0x1c);
+
+	pci_write_config_byte(pdev, 0x45, 0x10);
+#endif
+
+	printk(KERN_INFO"via686b fix: IDE done\n");
+}
+
+static void __init fuloong2e_686b_func2_fixup(struct pci_dev *pdev)
+{
+	/* irq routing */
+	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
+}
+
+static void __init fuloong2e_686b_func3_fixup(struct pci_dev *pdev)
+{
+	/* irq routing */
+	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
+}
+
+static void __init fuloong2e_686b_func5_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+	unsigned char c;
+
+	/* enable IO */
+	pci_write_config_byte(pdev, PCI_COMMAND,
+			      PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+			      PCI_COMMAND_MASTER);
+	pci_read_config_dword(pdev, 0x4, &val);
+	pci_write_config_dword(pdev, 0x4, val | 1);
+
+	/* route ac97 IRQ */
+	pci_write_config_byte(pdev, 0x3c, 9);
+
+	pci_read_config_byte(pdev, 0x8, &c);
+
+	/* link control: enable link & SGD PCM output */
+	pci_write_config_byte(pdev, 0x41, 0xcc);
+
+	/* disable game port, FM, midi, sb, enable write to reg2c-2f */
+	pci_write_config_byte(pdev, 0x42, 0x20);
+
+	/* we are using Avance logic codec */
+	pci_write_config_word(pdev, 0x2c, 0x1005);
+	pci_write_config_word(pdev, 0x2e, 0x4710);
+	pci_read_config_dword(pdev, 0x2c, &val);
+
+	pci_write_config_byte(pdev, 0x42, 0x0);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
+			 fuloong2e_686b_func0_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
+			 fuloong2e_686b_func1_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2,
+			 fuloong2e_686b_func2_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3,
+			 fuloong2e_686b_func3_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
+			 fuloong2e_686b_func5_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+			 fuloong2e_nec_fixup);
diff --git a/arch/mips/pci/fixup-lm2e.c b/arch/mips/pci/fixup-lm2e.c
deleted file mode 100644
index 08de000..0000000
--- a/arch/mips/pci/fixup-lm2e.c
+++ /dev/null
@@ -1,242 +0,0 @@
-/*
- * fixup-lm2e.c
- *
- * Copyright (C) 2004 ICT CAS
- * Author: Li xiaoyu, ICT CAS
- *   lixy@ict.ac.cn
- *
- * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/mips-boards/bonito64.h>
-
-/* South bridge slot number is set by the pci probe process */
-static u8 sb_slot = 5;
-
-int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq = 0;
-
-	if (slot == sb_slot) {
-		switch (PCI_FUNC(dev->devfn)) {
-		case 2:
-			irq = 10;
-			break;
-		case 3:
-			irq = 11;
-			break;
-		case 5:
-			irq = 9;
-			break;
-		}
-	} else {
-		irq = BONITO_IRQ_BASE + 25 + pin;
-	}
-	return irq;
-
-}
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	return 0;
-}
-
-static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
-{
-	unsigned int val;
-
-	/* Configues port 1, 2, 3, 4 to be validate*/
-	pci_read_config_dword(pdev, 0xe0, &val);
-	pci_write_config_dword(pdev, 0xe0, (val & ~7) | 0x4);
-
-	/* System clock is 48-MHz Oscillator. */
-	pci_write_config_dword(pdev, 0xe4, 1 << 5);
-}
-
-static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
-{
-	unsigned char c;
-
-	sb_slot = PCI_SLOT(pdev->devfn);
-
-	printk(KERN_INFO "via686b fix: ISA bridge\n");
-
-	/*  Enable I/O Recovery time */
-	pci_write_config_byte(pdev, 0x40, 0x08);
-
-	/*  Enable ISA refresh */
-	pci_write_config_byte(pdev, 0x41, 0x01);
-
-	/*  disable ISA line buffer */
-	pci_write_config_byte(pdev, 0x45, 0x00);
-
-	/*  Gate INTR, and flush line buffer */
-	pci_write_config_byte(pdev, 0x46, 0xe0);
-
-	/*  Disable PCI Delay Transaction, Enable EISA ports 4D0/4D1. */
-	/* pci_write_config_byte(pdev, 0x47, 0x20); */
-
-	/*
-	 *  enable PCI Delay Transaction, Enable EISA ports 4D0/4D1.
-	 *  enable time-out timer
-	 */
-	pci_write_config_byte(pdev, 0x47, 0xe6);
-
-	/*
-	 * enable level trigger on pci irqs: 9,10,11,13
-	 * important! without this PCI interrupts won't work
-	 */
-	outb(0x2e, 0x4d1);
-
-	/*  512 K PCI Decode */
-	pci_write_config_byte(pdev, 0x48, 0x01);
-
-	/*  Wait for PGNT before grant to ISA Master/DMA */
-	pci_write_config_byte(pdev, 0x4a, 0x84);
-
-	/*
-	 * Plug'n'Play
-	 *
-	 *  Parallel DRQ 3, Floppy DRQ 2 (default)
-	 */
-	pci_write_config_byte(pdev, 0x50, 0x0e);
-
-	/*
-	 * IRQ Routing for Floppy and Parallel port
-	 *
-	 *  IRQ 6 for floppy, IRQ 7 for parallel port
-	 */
-	pci_write_config_byte(pdev, 0x51, 0x76);
-
-	/* IRQ Routing for serial ports (take IRQ 3 and 4) */
-	pci_write_config_byte(pdev, 0x52, 0x34);
-
-	/*  All IRQ's level triggered. */
-	pci_write_config_byte(pdev, 0x54, 0x00);
-
-	/* route PIRQA-D irq */
-	pci_write_config_byte(pdev, 0x55, 0x90);	/* bit 7-4, PIRQA */
-	pci_write_config_byte(pdev, 0x56, 0xba);	/* bit 7-4, PIRQC; */
-							/* 3-0, PIRQB */
-	pci_write_config_byte(pdev, 0x57, 0xd0);	/* bit 7-4, PIRQD */
-
-	/* enable function 5/6, audio/modem */
-	pci_read_config_byte(pdev, 0x85, &c);
-	c &= ~(0x3 << 2);
-	pci_write_config_byte(pdev, 0x85, c);
-
-	printk(KERN_INFO"via686b fix: ISA bridge done\n");
-}
-
-static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
-{
-	printk(KERN_INFO"via686b fix: IDE\n");
-
-	/* Modify IDE controller setup */
-	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 48);
-	pci_write_config_byte(pdev, PCI_COMMAND,
-			      PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-			      PCI_COMMAND_MASTER);
-	pci_write_config_byte(pdev, 0x40, 0x0b);
-	/* legacy mode */
-	pci_write_config_byte(pdev, 0x42, 0x09);
-
-#if 1/* play safe, otherwise we may see notebook's usb keyboard lockup */
-	/* disable read prefetch/write post buffers */
-	pci_write_config_byte(pdev, 0x41, 0x02);
-
-	/* use 3/4 as fifo thresh hold  */
-	pci_write_config_byte(pdev, 0x43, 0x0a);
-	pci_write_config_byte(pdev, 0x44, 0x00);
-
-	pci_write_config_byte(pdev, 0x45, 0x00);
-#else
-	pci_write_config_byte(pdev, 0x41, 0xc2);
-	pci_write_config_byte(pdev, 0x43, 0x35);
-	pci_write_config_byte(pdev, 0x44, 0x1c);
-
-	pci_write_config_byte(pdev, 0x45, 0x10);
-#endif
-
-	printk(KERN_INFO"via686b fix: IDE done\n");
-}
-
-static void __init loongson2e_686b_func2_fixup(struct pci_dev *pdev)
-{
-	/* irq routing */
-	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
-}
-
-static void __init loongson2e_686b_func3_fixup(struct pci_dev *pdev)
-{
-	/* irq routing */
-	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
-}
-
-static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
-{
-	unsigned int val;
-	unsigned char c;
-
-	/* enable IO */
-	pci_write_config_byte(pdev, PCI_COMMAND,
-			      PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-			      PCI_COMMAND_MASTER);
-	pci_read_config_dword(pdev, 0x4, &val);
-	pci_write_config_dword(pdev, 0x4, val | 1);
-
-	/* route ac97 IRQ */
-	pci_write_config_byte(pdev, 0x3c, 9);
-
-	pci_read_config_byte(pdev, 0x8, &c);
-
-	/* link control: enable link & SGD PCM output */
-	pci_write_config_byte(pdev, 0x41, 0xcc);
-
-	/* disable game port, FM, midi, sb, enable write to reg2c-2f */
-	pci_write_config_byte(pdev, 0x42, 0x20);
-
-	/* we are using Avance logic codec */
-	pci_write_config_word(pdev, 0x2c, 0x1005);
-	pci_write_config_word(pdev, 0x2e, 0x4710);
-	pci_read_config_dword(pdev, 0x2c, &val);
-
-	pci_write_config_byte(pdev, 0x42, 0x0);
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
-			 loongson2e_686b_func0_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
-			 loongson2e_686b_func1_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2,
-			 loongson2e_686b_func2_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3,
-			 loongson2e_686b_func3_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
-			 loongson2e_686b_func5_fixup);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
-			 loongson2e_nec_fixup);
diff --git a/arch/mips/pci/ops-bonito64.c b/arch/mips/pci/ops-bonito64.c
index f742c51..e3b091d 100644
--- a/arch/mips/pci/ops-bonito64.c
+++ b/arch/mips/pci/ops-bonito64.c
@@ -29,11 +29,12 @@
 #define PCI_ACCESS_READ  0
 #define PCI_ACCESS_WRITE 1
 
-#ifdef CONFIG_LEMOTE_FULONG
+#ifdef CONFIG_LEMOTE_FULOONG2E
 #define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (offset))
 #define ID_SEL_BEGIN 11
 #else
-#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(_pcictrl_bonito_pcicfg + (offset))
+#define CFG_SPACE_REG(offset) \
+	(void *)CKSEG1ADDR(_pcictrl_bonito_pcicfg + (offset))
 #define ID_SEL_BEGIN 10
 #endif
 #define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
@@ -42,7 +43,7 @@
 static int bonito64_pcibios_config_access(unsigned char access_type,
 				      struct pci_bus *bus,
 				      unsigned int devfn, int where,
-				      u32 * data)
+				      u32 *data)
 {
 	u32 busnum = bus->number;
 	u32 addr, type;
@@ -77,9 +78,10 @@ static int bonito64_pcibios_config_access(unsigned char access_type,
 	addrp = CFG_SPACE_REG(addr & 0xffff);
 	if (access_type == PCI_ACCESS_WRITE) {
 		writel(cpu_to_le32(*data), addrp);
-#ifndef CONFIG_LEMOTE_FULONG
+#ifndef CONFIG_LEMOTE_FULOONG2E
 		/* Wait till done */
-		while (BONITO_PCIMSTAT & 0xF);
+		while (BONITO_PCIMSTAT & 0xF)
+			;
 #endif
 	} else {
 		*data = le32_to_cpu(readl(addrp));
@@ -107,7 +109,7 @@ static int bonito64_pcibios_config_access(unsigned char access_type,
  * read/write a 32bit word and mask/modify the data we actually want.
  */
 static int bonito64_pcibios_read(struct pci_bus *bus, unsigned int devfn,
-			     int where, int size, u32 * val)
+			     int where, int size, u32 *val)
 {
 	u32 data = 0;
 
@@ -144,7 +146,7 @@ static int bonito64_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 		data = val;
 	else {
 		if (bonito64_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
-		                               where, &data))
+					where, &data))
 			return -1;
 
 		if (size == 1)
-- 
1.6.2.1
