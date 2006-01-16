Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:47:22 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:34834 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133509AbWAPQrB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 16:47:01 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8CA2364D54; Mon, 16 Jan 2006 16:50:29 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 47FC78517; Mon, 16 Jan 2006 16:50:18 +0000 (GMT)
Date:	Mon, 16 Jan 2006 16:50:18 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
Message-ID: <20060116165018.GE5798@deprecation.cyrius.com>
References: <20050414185949.GA5578@skeleton-jack> <20060116154543.GA26771@deprecation.cyrius.com> <43CBCAAE.6030403@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CBCAAE.6030403@jg555.com>
User-Agent: Mutt/1.5.11
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Jim Gifford <maillist@jg555.com> [2006-01-16 08:32]:
> This include the iomap.c, which is not accepted by Ralf.

I suppose that's just an omission.  Here's Yuasa's patch again (with a
minor change so it applies to 2.6.15).

iomap implementation for Linux/MIPS

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>


diff -urN linux-mips/arch/mips/lib/Makefile new/arch/mips/lib/Makefile
--- linux-mips/arch/mips/lib/Makefile	2006-01-10 11:21:15.000000000 +0000
+++ new/arch/mips/lib/Makefile	2006-01-16 16:45:26.000000000 +0000
@@ -2,7 +2,7 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o memcpy.o promlib.o strlen_user.o strncpy_user.o \
-	   strnlen_user.o uncached.o
+lib-y	+= csum_partial_copy.o iomap.o memcpy.o promlib.o strlen_user.o \
+	   strncpy_user.o strnlen_user.o uncached.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN linux-mips/arch/mips/lib/iomap.c new/arch/mips/lib/iomap.c
--- linux-mips/arch/mips/lib/iomap.c	1970-01-01 01:00:00.000000000 +0100
+++ new/arch/mips/lib/iomap.c	2006-01-16 16:45:35.000000000 +0000
@@ -0,0 +1,78 @@
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
+void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	unsigned long end;
+
+	end = port + nr - 1UL;
+	if (ioport_resource.start > port ||
+	    ioport_resource.end < end || port > end)
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
diff -urN linux-mips/include/asm-mips/io.h new/include/asm-mips/io.h
--- linux-mips/include/asm-mips/io.h	2006-01-10 11:21:59.000000000 +0000
+++ new/include/asm-mips/io.h	2006-01-16 16:45:35.000000000 +0000
@@ -535,6 +535,34 @@
 }
 
 /*
+ * Memory Mapped I/O
+ */
+#define ioread8(addr)		readb(addr)
+#define ioread16(addr)		readw(addr)
+#define ioread32(addr)		readl(addr)
+
+#define iowrite8(b,addr)	writeb(b,addr)
+#define iowrite16(w,addr)	writew(w,addr)
+#define iowrite32(l,addr)	writel(l,addr)
+
+#define ioread8_rep(a,b,c)	readsb(a,b,c)
+#define ioread16_rep(a,b,c)	readsw(a,b,c)
+#define ioread32_rep(a,b,c)	readsl(a,b,c)
+
+#define iowrite8_rep(a,b,c)	writesb(a,b,c)
+#define iowrite16_rep(a,b,c)	writesw(a,b,c)
+#define iowrite32_rep(a,b,c)	writesl(a,b,c)
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

-- 
Martin Michlmayr
http://www.cyrius.com/
