Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jan 2005 17:10:22 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:14835 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225421AbVALRKP>;
	Wed, 12 Jan 2005 17:10:15 +0000
Received: MO(mo00)id j0CHACLa024498; Thu, 13 Jan 2005 02:10:12 +0900 (JST)
Received: MDO(mdo00) id j0CHABBI016581; Thu, 13 Jan 2005 02:10:12 +0900 (JST)
Received: 4UMRO01 id j0CHAAVA017526; Thu, 13 Jan 2005 02:10:11 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Thu, 13 Jan 2005 02:10:09 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] add iomap funtions
Message-Id: <20050113021009.6b04f1d0.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050113.004258.25909217.anemo@mba.ocn.ne.jp>
References: <20050112012433.382a97dd.yuasa@hh.iij4u.or.jp>
	<20050113.004258.25909217.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Jan 2005 00:42:58 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Wed, 12 Jan 2005 01:24:33 +0900, Yoichi Yuasa <yuasa@hh.iij4u.or.jp> said:
> 
> yuasa> This patch adds iomap functions to MIPS system.
> yuasa> Some MIPS systems are unable to define PIO space by
> yuasa> PIO_MASK/PIO_RESERVED.  This is the reason that I didn't use
> yuasa> the general iomap implementation.
> 
> How about defining ioreadN/iowriteN macros in io.h ?
> 
> #define ioread8(addr)	readb(addr)
> #define ioread8_rep(port, buf, count)	readsb(port, buf, count)
> etc.
> 
> Then ioport_map and io{read,write}{8,16,32} will be more efficient
> than {in,out}[bwl].

Thank you for your comment.
I update iomap patch.

Ralf, please apply update patch to v2.6.

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
+++ a/arch/mips/lib/iomap.c	Thu Jan 13 01:14:11 2005
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
diff -urN -X dontdiff a-orig/include/asm-mips/io.h a/include/asm-mips/io.h
--- a-orig/include/asm-mips/io.h	Mon Dec 27 15:22:30 2004
+++ a/include/asm-mips/io.h	Thu Jan 13 01:35:51 2005
@@ -478,6 +478,34 @@
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
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
