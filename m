Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 15:36:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50134 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20036943AbYGMOgP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 15:36:15 +0100
Received: from localhost (p1204-ipad207funabasi.chiba.ocn.ne.jp [222.145.83.204])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4576FA98D; Sun, 13 Jul 2008 23:36:09 +0900 (JST)
Date:	Sun, 13 Jul 2008 23:37:56 +0900 (JST)
Message-Id: <20080713.233756.32098529.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] txx9: rename asm-mips/mach-jmr3927 to asm-mips/mach-tx39xx
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Rename mach-jmr3927 directory to more proper name to make adding other
platforms easier.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
git-diff --stat -M output:
 arch/mips/Makefile                                 |    2 +-
 arch/mips/txx9/generic/setup.c                     |   10 ++++++++++
 arch/mips/txx9/jmr3927/setup.c                     |    4 ++--
 .../{mach-jmr3927 => mach-tx39xx}/ioremap.h        |    8 ++++----
 .../{mach-jmr3927 => mach-tx39xx}/mangle-port.h    |   13 +++++++++----
 .../asm-mips/{mach-jmr3927 => mach-tx39xx}/war.h   |    6 +++---
 6 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6c4eb9f..01408a9 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -554,7 +554,7 @@ all-$(CONFIG_SNI_RM)		:= vmlinux.ecoff
 # Common TXx9
 #
 core-$(CONFIG_MACH_TX39XX)	+= arch/mips/txx9/generic/
-cflags-$(CONFIG_MACH_TX39XX) += -Iinclude/asm-mips/mach-jmr3927
+cflags-$(CONFIG_MACH_TX39XX) += -Iinclude/asm-mips/mach-tx39xx
 load-$(CONFIG_MACH_TX39XX)	+= 0xffffffff80050000
 core-$(CONFIG_MACH_TX49XX)	+= arch/mips/txx9/generic/
 cflags-$(CONFIG_MACH_TX49XX) += -Iinclude/asm-mips/mach-tx49xx
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 517828e..452cb9e 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -200,3 +200,13 @@ asmlinkage void plat_irq_dispatch(void)
 	else
 		spurious_interrupt();
 }
+
+/* see include/asm-mips/mach-tx39xx/mangle-port.h, for example. */
+#ifdef NEEDS_TXX9_SWIZZLE_ADDR_B
+static unsigned long __swizzle_addr_none(unsigned long port)
+{
+	return port;
+}
+unsigned long (*__swizzle_addr_b)(unsigned long port) = __swizzle_addr_none;
+EXPORT_SYMBOL(__swizzle_addr_b);
+#endif
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 43a8dad..61edc4a 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -315,7 +315,7 @@ static void __init tx3927_setup(void)
 }
 
 /* This trick makes rtc-ds1742 driver usable as is. */
-unsigned long __swizzle_addr_b(unsigned long port)
+static unsigned long jmr3927_swizzle_addr_b(unsigned long port)
 {
 	if ((port & 0xffff0000) != JMR3927_IOC_NVRAMB_ADDR)
 		return port;
@@ -326,7 +326,6 @@ unsigned long __swizzle_addr_b(unsigned long port)
 	return port | 1;
 #endif
 }
-EXPORT_SYMBOL(__swizzle_addr_b);
 
 static int __init jmr3927_rtc_init(void)
 {
@@ -361,6 +360,7 @@ static int __init jmr3927_wdt_init(void)
 
 static void __init jmr3927_device_init(void)
 {
+	__swizzle_addr_b = jmr3927_swizzle_addr_b;
 	jmr3927_rtc_init();
 	jmr3927_wdt_init();
 }
diff --git a/include/asm-mips/mach-jmr3927/ioremap.h b/include/asm-mips/mach-jmr3927/ioremap.h
deleted file mode 100644
index 29989ff..0000000
--- a/include/asm-mips/mach-jmr3927/ioremap.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- *	include/asm-mips/mach-jmr3927/ioremap.h
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- */
-#ifndef __ASM_MACH_JMR3927_IOREMAP_H
-#define __ASM_MACH_JMR3927_IOREMAP_H
-
-#include <linux/types.h>
-
-/*
- * Allow physical addresses to be fixed up to help peripherals located
- * outside the low 32-bit range -- generic pass-through version.
- */
-static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
-{
-	return phys_addr;
-}
-
-static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
-	unsigned long flags)
-{
-#define TXX9_DIRECTMAP_BASE	0xff000000ul
-	if (offset >= TXX9_DIRECTMAP_BASE &&
-	    offset < TXX9_DIRECTMAP_BASE + 0xff0000)
-		return (void __iomem *)offset;
-	return NULL;
-}
-
-static inline int plat_iounmap(const volatile void __iomem *addr)
-{
-	return (unsigned long)addr >= TXX9_DIRECTMAP_BASE;
-}
-
-#endif /* __ASM_MACH_JMR3927_IOREMAP_H */
diff --git a/include/asm-mips/mach-jmr3927/mangle-port.h b/include/asm-mips/mach-jmr3927/mangle-port.h
deleted file mode 100644
index 11bffcd..0000000
--- a/include/asm-mips/mach-jmr3927/mangle-port.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __ASM_MACH_JMR3927_MANGLE_PORT_H
-#define __ASM_MACH_JMR3927_MANGLE_PORT_H
-
-extern unsigned long __swizzle_addr_b(unsigned long port);
-#define __swizzle_addr_w(port)	(port)
-#define __swizzle_addr_l(port)	(port)
-#define __swizzle_addr_q(port)	(port)
-
-#define ioswabb(a, x)		(x)
-#define __mem_ioswabb(a, x)	(x)
-#define ioswabw(a, x)		le16_to_cpu(x)
-#define __mem_ioswabw(a, x)	(x)
-#define ioswabl(a, x)		le32_to_cpu(x)
-#define __mem_ioswabl(a, x)	(x)
-#define ioswabq(a, x)		le64_to_cpu(x)
-#define __mem_ioswabq(a, x)	(x)
-
-#endif /* __ASM_MACH_JMR3927_MANGLE_PORT_H */
diff --git a/include/asm-mips/mach-jmr3927/war.h b/include/asm-mips/mach-jmr3927/war.h
deleted file mode 100644
index 1ff55fb..0000000
--- a/include/asm-mips/mach-jmr3927/war.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_JMR3927_WAR_H
-#define __ASM_MIPS_MACH_JMR3927_WAR_H
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
-#endif /* __ASM_MIPS_MACH_JMR3927_WAR_H */
diff --git a/include/asm-mips/mach-tx39xx/ioremap.h b/include/asm-mips/mach-tx39xx/ioremap.h
new file mode 100644
index 0000000..93c6c04
--- /dev/null
+++ b/include/asm-mips/mach-tx39xx/ioremap.h
@@ -0,0 +1,38 @@
+/*
+ *	include/asm-mips/mach-tx39xx/ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MACH_TX39XX_IOREMAP_H
+#define __ASM_MACH_TX39XX_IOREMAP_H
+
+#include <linux/types.h>
+
+/*
+ * Allow physical addresses to be fixed up to help peripherals located
+ * outside the low 32-bit range -- generic pass-through version.
+ */
+static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+	unsigned long flags)
+{
+#define TXX9_DIRECTMAP_BASE	0xff000000ul
+	if (offset >= TXX9_DIRECTMAP_BASE &&
+	    offset < TXX9_DIRECTMAP_BASE + 0xff0000)
+		return (void __iomem *)offset;
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return (unsigned long)addr >= TXX9_DIRECTMAP_BASE;
+}
+
+#endif /* __ASM_MACH_TX39XX_IOREMAP_H */
diff --git a/include/asm-mips/mach-tx39xx/mangle-port.h b/include/asm-mips/mach-tx39xx/mangle-port.h
new file mode 100644
index 0000000..ef0b502
--- /dev/null
+++ b/include/asm-mips/mach-tx39xx/mangle-port.h
@@ -0,0 +1,23 @@
+#ifndef __ASM_MACH_TX39XX_MANGLE_PORT_H
+#define __ASM_MACH_TX39XX_MANGLE_PORT_H
+
+#if defined(CONFIG_TOSHIBA_JMR3927)
+extern unsigned long (*__swizzle_addr_b)(unsigned long port);
+#define NEEDS_TXX9_SWIZZLE_ADDR_B
+#else
+#define __swizzle_addr_b(port)	(port)
+#endif
+#define __swizzle_addr_w(port)	(port)
+#define __swizzle_addr_l(port)	(port)
+#define __swizzle_addr_q(port)	(port)
+
+#define ioswabb(a, x)		(x)
+#define __mem_ioswabb(a, x)	(x)
+#define ioswabw(a, x)		le16_to_cpu(x)
+#define __mem_ioswabw(a, x)	(x)
+#define ioswabl(a, x)		le32_to_cpu(x)
+#define __mem_ioswabl(a, x)	(x)
+#define ioswabq(a, x)		le64_to_cpu(x)
+#define __mem_ioswabq(a, x)	(x)
+
+#endif /* __ASM_MACH_TX39XX_MANGLE_PORT_H */
diff --git a/include/asm-mips/mach-tx39xx/war.h b/include/asm-mips/mach-tx39xx/war.h
new file mode 100644
index 0000000..4338146
--- /dev/null
+++ b/include/asm-mips/mach-tx39xx/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_TX39XX_WAR_H
+#define __ASM_MIPS_MACH_TX39XX_WAR_H
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
+#endif /* __ASM_MIPS_MACH_TX39XX_WAR_H */
