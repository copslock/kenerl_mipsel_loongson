Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 16:13:29 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:35577 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225250AbUKDQNY>;
	Thu, 4 Nov 2004 16:13:24 +0000
Received: MO(mo01)id iA4GDKWr014952; Fri, 5 Nov 2004 01:13:20 +0900 (JST)
Received: MDO(mdo01) id iA4GDJuu002266; Fri, 5 Nov 2004 01:13:20 +0900 (JST)
Received: 4UMRO01 id iA4GDIU1022268; Fri, 5 Nov 2004 01:13:19 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Fri, 5 Nov 2004 01:13:17 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] add iomap funtions
Message-Id: <20041105011317.012b10ad.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch adds iomap functions to MIPS system.
Please apply this patch to v2.6.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
--- b-orig/arch/mips/lib/Makefile	Mon Jan  5 17:27:29 2004
+++ b/arch/mips/lib/Makefile	Fri Nov  5 00:55:23 2004
@@ -2,7 +2,7 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o dec_and_lock.o memcpy.o promlib.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o
+lib-y	+= csum_partial_copy.o dec_and_lock.o iomap.o memcpy.o promlib.o \
+	   strlen_user.o strncpy_user.o strnlen_user.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff b-orig/arch/mips/lib/iomap.c b/arch/mips/lib/iomap.c
--- b-orig/arch/mips/lib/iomap.c	Thu Jan  1 09:00:00 1970
+++ b/arch/mips/lib/iomap.c	Fri Nov  5 00:55:23 2004
@@ -0,0 +1,69 @@
+/*
+ *  iomap.c, Memory Mapped I/O routines for MIPS architecture.
+ *
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+
+void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return (void __iomem *)(mips_io_port_base + port);
+}
+
+EXPORT_SYMBOL(ioport_map);
+
+void ioport_unmap(void __iomem *addr)
+{
+}
+
+EXPORT_SYMBOL(ioport_unmap);
+
+void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	unsigned long start, len, flags;
+
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+
+	if (start == 0 || len == 0)
+		return NULL;
+	if (maxlen != 0 && len > maxlen)
+		len = maxlen;
+
+	flags = pci_resource_flags(dev, bar);
+	if (flags & IORESOURCE_IO)
+		return ioport_map(start, len);
+	if (flags & IORESOURCE_MEM) {
+		if (flags & IORESOURCE_CACHEABLE)
+			return ioremap_cacheable_cow(start, len);
+		return ioremap_nocache(start, len);
+	}
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(pci_iomap);
+
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+
+EXPORT_SYMBOL(pci_iounmap);
diff -urN -X dontdiff b-orig/include/asm-mips/io.h b/include/asm-mips/io.h
--- b-orig/include/asm-mips/io.h	Thu Oct 21 17:34:51 2004
+++ b/include/asm-mips/io.h	Fri Nov  5 00:55:23 2004
@@ -353,6 +353,77 @@
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
 /*
+ * Memory Mapped I/O
+ */
+#define ioread8(addr)		readb(addr)
+#define ioread16(addr)		readw(addr)
+#define ioread32(addr)		readl(addr)
+
+#define iowrite8(val,addr)	writeb(val,addr)
+#define iowrite16(val,addr)	writew(val,addr)
+#define iowrite32(val,addr)	writel(val,addr)
+
+static inline void fastcall ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	while (count-- > 0) {
+		uint8_t val = __raw_readb(addr);
+		*(volatile uint8_t *)dst = val;
+		(uint8_t *)dst++;
+	}
+}
+
+static inline void fastcall ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	while (count-- > 0) {
+		uint16_t val = __raw_readw(addr);
+		*(volatile uint16_t *)dst = val;
+		(uint16_t *)dst++;
+	}
+}
+
+static inline void fastcall ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	while (count-- > 0) {
+		uint32_t val = __raw_readl(addr);
+		*(volatile uint32_t *)dst = val;
+		(uint32_t *)dst++;
+	}
+}
+
+static inline void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	while (count-- > 0) {
+		__raw_writeb(*(uint8_t *)src, addr);
+		(uint8_t *)src++;
+	}
+}
+
+static inline void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	while (count-- > 0) {
+		__raw_writew(*(uint16_t *)src, addr);
+		(uint16_t *)src++;
+	}
+}
+
+static inline void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	while (count-- > 0) {
+		__raw_writel(*(uint32_t *)src, addr);
+		(uint32_t *)src++;
+	}
+}
+
+/* Create a virtual mapping cookie for an IO port range */
+extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+extern void ioport_unmap(void __iomem *);
+
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+
+/*
  * ISA space is 'always mapped' on currently supported MIPS systems, no need
  * to explicitly ioremap() it. The fact that the ISA IO space is mapped
  * to PAGE_OFFSET is pure coincidence - it does not mean ISA values
