Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 17:13:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:56041 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021951AbXFYQNW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2007 17:13:22 +0100
Received: from localhost (p3129-ipad201funabasi.chiba.ocn.ne.jp [222.146.66.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6814CBDF4; Tue, 26 Jun 2007 01:13:18 +0900 (JST)
Date:	Tue, 26 Jun 2007 01:14:01 +0900 (JST)
Message-Id: <20070626.011401.103777892.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make ioremap() work on TX39/49 special unmapped segment
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
X-archive-position: 15534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TX39XX and TX49XX have "reserved" segment in CKSEG3 area.
0xff000000-0xff3fffff on TX49XX and 0xff000000-0xfffeffff on TX39XX
are reserved (unmapped, uncached).  Controllers on these SoCs are
placed in this segment.

This patch add plat_ioremap() and plat_iounmap() to override default
behavior and implement these hooks for TX39/TX49.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Makefile                      |    2 +
 include/asm-mips/io.h                   |    8 ++++++
 include/asm-mips/mach-au1x00/ioremap.h  |   11 ++++++++
 include/asm-mips/mach-generic/ioremap.h |   11 ++++++++
 include/asm-mips/mach-jmr3927/ioremap.h |   38 ++++++++++++++++++++++++++++
 include/asm-mips/mach-tx49xx/ioremap.h  |   42 +++++++++++++++++++++++++++++++
 6 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2b9af2f..96d4abb 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -580,6 +580,7 @@ load-$(CONFIG_TOSHIBA_JMR3927)	+= 0xffffffff80050000
 #
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/toshiba_rbtx4927/
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/common/
+cflags-$(CONFIG_TOSHIBA_RBTX4927) += -Iinclude/asm-mips/mach-tx49xx
 load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 
 #
@@ -587,6 +588,7 @@ load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 #
 core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/tx4938/toshiba_rbtx4938/
 core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/tx4938/common/
+cflags-$(CONFIG_TOSHIBA_RBTX4938) += -Iinclude/asm-mips/mach-tx49xx
 load-$(CONFIG_TOSHIBA_RBTX4938) += 0xffffffff80100000
 
 cflags-y			+= -Iinclude/asm-mips/mach-generic
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 92ec261..12bcc1f 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -178,6 +178,11 @@ extern void __iounmap(const volatile void __iomem *addr);
 static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 	unsigned long flags)
 {
+	void __iomem *addr = plat_ioremap(offset, size, flags);
+
+	if (addr)
+		return addr;
+
 #define __IS_LOW512(addr) (!((phys_t)(addr) & (phys_t) ~0x1fffffffULL))
 
 	if (cpu_has_64bit_addresses) {
@@ -282,6 +287,9 @@ static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 
 static inline void iounmap(const volatile void __iomem *addr)
 {
+	if (plat_iounmap(addr))
+		return;
+
 #define __IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == CKSEG1)
 
 	if (cpu_has_64bit_addresses ||
diff --git a/include/asm-mips/mach-au1x00/ioremap.h b/include/asm-mips/mach-au1x00/ioremap.h
index 098fca4..364cea2 100644
--- a/include/asm-mips/mach-au1x00/ioremap.h
+++ b/include/asm-mips/mach-au1x00/ioremap.h
@@ -28,4 +28,15 @@ static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 	return __fixup_bigphys_addr(phys_addr, size);
 }
 
+static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+	unsigned long flags)
+{
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return 0;
+}
+
 #endif /* __ASM_MACH_AU1X00_IOREMAP_H */
diff --git a/include/asm-mips/mach-generic/ioremap.h b/include/asm-mips/mach-generic/ioremap.h
index 9b64ff6..b379938 100644
--- a/include/asm-mips/mach-generic/ioremap.h
+++ b/include/asm-mips/mach-generic/ioremap.h
@@ -20,4 +20,15 @@ static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 	return phys_addr;
 }
 
+static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+	unsigned long flags)
+{
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return 0;
+}
+
 #endif /* __ASM_MACH_GENERIC_IOREMAP_H */
diff --git a/include/asm-mips/mach-jmr3927/ioremap.h b/include/asm-mips/mach-jmr3927/ioremap.h
new file mode 100644
index 0000000..aa131ad
--- /dev/null
+++ b/include/asm-mips/mach-jmr3927/ioremap.h
@@ -0,0 +1,38 @@
+/*
+ *	include/asm-mips/mach-jmr3927/ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MACH_JMR3927_IOREMAP_H
+#define __ASM_MACH_JMR3927_IOREMAP_H
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
+	    offset < TXX9_DIRECTMAP_BASE + 0xf0000)
+		return (void __iomem *)offset;
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return (unsigned long)addr >= TXX9_DIRECTMAP_BASE;
+}
+
+#endif /* __ASM_MACH_JMR3927_IOREMAP_H */
diff --git a/include/asm-mips/mach-tx49xx/ioremap.h b/include/asm-mips/mach-tx49xx/ioremap.h
new file mode 100644
index 0000000..88cf546
--- /dev/null
+++ b/include/asm-mips/mach-tx49xx/ioremap.h
@@ -0,0 +1,42 @@
+/*
+ *	include/asm-mips/mach-tx49xx/ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MACH_TX49XX_IOREMAP_H
+#define __ASM_MACH_TX49XX_IOREMAP_H
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
+#ifdef CONFIG_64BIT
+#define TXX9_DIRECTMAP_BASE	0xfff000000ul
+#else
+#define TXX9_DIRECTMAP_BASE	0xff000000ul
+#endif
+	if (offset >= TXX9_DIRECTMAP_BASE &&
+	    offset < TXX9_DIRECTMAP_BASE + 0x400000)
+		return (void __iomem *)(unsigned long)(int)offset;
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return (unsigned long)addr >= (unsigned long)(int)TXX9_DIRECTMAP_BASE;
+}
+
+#endif /* __ASM_MACH_TX49XX_IOREMAP_H */
