Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 16:24:59 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:35012 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225220AbVAKQYw>;
	Tue, 11 Jan 2005 16:24:52 +0000
Received: MO(mo00)id j0BGOnR7029167; Wed, 12 Jan 2005 01:24:49 +0900 (JST)
Received: MDO(mdo01) id j0BGOmMf023869; Wed, 12 Jan 2005 01:24:48 +0900 (JST)
Received: 4UMRO01 id j0BGOlFK008380; Wed, 12 Jan 2005 01:24:47 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Wed, 12 Jan 2005 01:24:33 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] add iomap funtions
Message-Id: <20050112012433.382a97dd.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch adds iomap functions to MIPS system.

Some MIPS systems are unable to define PIO space by PIO_MASK/PIO_RESERVED.
This is the reason that I didn't use the general iomap implementation.

Please apply this patch to v2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/lib/Makefile a/arch/mips/lib/Makefile
--- a-orig/arch/mips/lib/Makefile	Mon Jan  5 17:27:29 2004
+++ a/arch/mips/lib/Makefile	Wed Jan 12 01:10:23 2005
@@ -2,7 +2,7 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o dec_and_lock.o memcpy.o promlib.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o
+lib-y	+= csum_partial_copy.o dec_and_lock.o iomap.o memcpy.o promlib.o \
+	   strlen_user.o strncpy_user.o strnlen_user.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff a-orig/arch/mips/lib/iomap.c a/arch/mips/lib/iomap.c
--- a-orig/arch/mips/lib/iomap.c	Thu Jan  1 09:00:00 1970
+++ a/arch/mips/lib/iomap.c	Wed Jan 12 01:10:23 2005
@@ -0,0 +1,171 @@
+/*
+ *  iomap.c, Memory Mapped I/O routines for MIPS architecture.
+ *
+ *  This code is based on lib/iomap.c, by Linus Torvalds.
+ *
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+
+unsigned int fastcall ioread8(void __iomem *addr)
+{
+	return readb(addr);
+}
+
+unsigned int fastcall ioread16(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+unsigned int fastcall ioread32(void __iomem *addr)
+{
+	return readl(addr);
+}
+EXPORT_SYMBOL(ioread8);
+EXPORT_SYMBOL(ioread16);
+EXPORT_SYMBOL(ioread32);
+
+void fastcall iowrite8(u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+
+void fastcall iowrite16(u16 val, void __iomem *addr)
+{
+	writew(val, addr);
+}
+
+void fastcall iowrite32(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+EXPORT_SYMBOL(iowrite8);
+EXPORT_SYMBOL(iowrite16);
+EXPORT_SYMBOL(iowrite32);
+
+void fastcall ioread8_rep(void __iomem *port, void *buf, unsigned long count)
+{
+	while (--count >= 0) {
+		u8 val = __raw_readb(port);
+		*(u8 *)buf = val;
+		(u8 *)buf++;
+	}
+}
+
+void fastcall ioread16_rep(void __iomem *port, void *buf, unsigned long count)
+{
+	while (--count >= 0) {
+		u16 val = __raw_readw(port);
+		*(u16 *)buf = val;
+		(u16 *)buf++;
+	}
+}
+
+void fastcall ioread32_rep(void __iomem *port, void *buf, unsigned long count)
+{
+	while (--count >= 0) {
+		u32 val = __raw_readl(port);
+		*(u32 *)buf = val;
+		(u32 *)buf++;
+	}
+}
+EXPORT_SYMBOL(ioread8_rep);
+EXPORT_SYMBOL(ioread16_rep);
+EXPORT_SYMBOL(ioread32_rep);
+
+void fastcall iowrite8_rep(void __iomem *port, const void *buf, unsigned long count)
+{
+	while (--count >= 0) {
+		__raw_writeb(*(u8 *)buf, port);
+		(u8 *)buf++;
+	}
+}
+
+void fastcall iowrite16_rep(void __iomem *port, const void *buf, unsigned long count)
+{
+	while (--count >= 0) {
+		__raw_writew(*(u16 *)buf, port);
+		(u16 *)buf++;
+	}
+}
+
+void fastcall iowrite32_rep(void __iomem *port, const void *buf, unsigned long count)
+{
+	while (--count >= 0) {
+		__raw_writel(*(u32 *)buf, port);
+		(u32 *)buf++;
+	}
+}
+EXPORT_SYMBOL(iowrite8_rep);
+EXPORT_SYMBOL(iowrite16_rep);
+EXPORT_SYMBOL(iowrite32_rep);
+
+void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	unsigned long end;
+
+	end = port + nr - 1UL;
+	if (ioport_resource.start > port ||
+	    ioport_resource.end < end || start > end)
+		return NULL;
+
+	return (void __iomem *)(mips_io_port_base + port);
+}
+
+void ioport_unmap(void __iomem *addr)
+{
+}
+EXPORT_SYMBOL(ioport_map);
+EXPORT_SYMBOL(ioport_unmap);
+
+void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	unsigned long start, len, flags;
+
+	if (dev == NULL)
+		return NULL;
+
+	start = pci_resource_start(dev, bar);
+	len = pci_resource_len(dev, bar);
+	if (!start || !len)
+		return NULL;
+
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
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iomap);
+EXPORT_SYMBOL(pci_iounmap);
diff -urN -X dontdiff a-orig/include/asm-mips/io.h a/include/asm-mips/io.h
--- a-orig/include/asm-mips/io.h	Mon Dec 27 15:22:30 2004
+++ a/include/asm-mips/io.h	Wed Jan 12 01:10:23 2005
@@ -28,6 +28,8 @@
 
 #include <mangle-port.h>
 
+#include <asm-generic/iomap.h>
+
 /*
  * Slowdown I/O port space accesses for antique hardware.
  */
