Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:30:01 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:24487 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133509AbWAPQ3l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 16:29:41 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 16 Jan 2006 08:33:11 -0800
  id 001F0A73.43CBCAC7.00007371
Message-ID: <43CBCAAE.6030403@jg555.com>
Date:	Mon, 16 Jan 2006 08:32:46 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
References: <20050414185949.GA5578@skeleton-jack> <20060116154543.GA26771@deprecation.cyrius.com>
In-Reply-To: <20060116154543.GA26771@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Here's a link to the updated patch. Works under 2.6.15
http://www.linuxfromscratch.org/patches/downloads/linux/linux-2.6.15-mips_fix-1.patch

This include the iomap.c, which is not accepted by Ralf.

Submitted By: Jim Gifford (patches at jg555 dot com)
Date: 2006-01-09
Initial Package Version: 2.6.15
Origin: Jim Gifford
Upstream Status: Not Accepted
Description: Various Fixes for MIPS architectures

diff -Naur linux-2.6.15.orig/arch/mips/lib/Makefile 
linux-2.6.15/arch/mips/lib/Makefile
--- linux-2.6.15.orig/arch/mips/lib/Makefile    2006-01-09 
21:32:16.000000000 +0000
+++ linux-2.6.15/arch/mips/lib/Makefile    2006-01-09 21:37:56.000000000 
+0000
@@ -5,4 +5,6 @@
 lib-y    += csum_partial_copy.o memcpy.o promlib.o strlen_user.o 
strncpy_user.o \
        strnlen_user.o uncached.o
 
+obj-y    += iomap.o
+
 EXTRA_AFLAGS := $(CFLAGS)
diff -Naur linux-2.6.15.orig/arch/mips/lib/iomap.c 
linux-2.6.15/arch/mips/lib/iomap.c
--- linux-2.6.15.orig/arch/mips/lib/iomap.c    1970-01-01 
00:00:00.000000000 +0000
+++ linux-2.6.15/arch/mips/lib/iomap.c    2006-01-09 21:37:56.000000000 
+0000
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
02111-1307  USA
+ */
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+
+void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+    unsigned long end;
+
+    end = port + nr - 1UL;
+    if (ioport_resource.start > port ||
+        ioport_resource.end < end || port > end)
+        return NULL;
+
+    return (void __iomem *)(mips_io_port_base + port);
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
+    unsigned long start, len, flags;
+
+    if (dev == NULL)
+        return NULL;
+
+    start = pci_resource_start(dev, bar);
+    len = pci_resource_len(dev, bar);
+    if (!start || !len)
+        return NULL;
+
+    if (maxlen != 0 && len > maxlen)
+        len = maxlen;
+
+    flags = pci_resource_flags(dev, bar);
+    if (flags & IORESOURCE_IO)
+        return ioport_map(start, len);
+    if (flags & IORESOURCE_MEM) {
+        if (flags & IORESOURCE_CACHEABLE)
+            return ioremap_cacheable_cow(start, len);
+        return ioremap_nocache(start, len);
+    }
+
+    return NULL;
+}
+
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+    iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iomap);
+EXPORT_SYMBOL(pci_iounmap);
diff -Naur linux-2.6.15.orig/include/asm-mips/addrspace.h 
linux-2.6.15/include/asm-mips/addrspace.h
--- linux-2.6.15.orig/include/asm-mips/addrspace.h    2006-01-03 
03:21:10.000000000 +0000
+++ linux-2.6.15/include/asm-mips/addrspace.h    2006-01-09 
20:47:10.000000000 +0000
@@ -124,7 +124,7 @@
 #define PHYS_TO_XKSEG_CACHED(p)        
PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
 #define XKPHYS_TO_PHYS(p)        ((p) & TO_PHYS_MASK)
 #define PHYS_TO_XKPHYS(cm,a)        (_LLCONST_(0x8000000000000000) | \
-                     ((cm)<<59) | (a))
+                     ((unsigned long)(cm)<<59) | (a))
 
 #if defined (CONFIG_CPU_R4300)                        \
     || defined (CONFIG_CPU_R4X00)                    \
diff -Naur 
linux-2.6.15.orig/include/asm-mips/cobalt/cpu-feature-overrides.h 
linux-2.6.15/include/asm-mips/cobalt/cpu-feature-overrides.h
--- linux-2.6.15.orig/include/asm-mips/cobalt/cpu-feature-overrides.h    
1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/include/asm-mips/cobalt/cpu-feature-overrides.h    
2006-01-09 20:52:18.000000000 +0000
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General 
Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Ralf Baechle
+ */
+#ifndef __ASM_COBALT_CPU_FEATURE_OVERRIDES_H
+#define __ASM_COBALT_CPU_FEATURE_OVERRIDES_H
+
+#ifdef CONFIG_64BIT
+#define cpu_has_llsc            0
+#else
+#define cpu_has_llsc            1
+#endif
+
+#endif /* __ASM_COBALT_CPU_FEATURE_OVERRIDES_H */
diff -Naur linux-2.6.15.orig/include/asm-mips/cobalt/ide.h 
linux-2.6.15/include/asm-mips/cobalt/ide.h
--- linux-2.6.15.orig/include/asm-mips/cobalt/ide.h    1970-01-01 
00:00:00.000000000 +0000
+++ linux-2.6.15/include/asm-mips/cobalt/ide.h    2006-01-09 
20:47:10.000000000 +0000
@@ -0,0 +1,83 @@
+
+/*
+ * PIO "in" transfers can cause D-cache lines to be allocated
+ * to the data being read. If the target is the page cache then
+ * the kernel can create a user space mapping of the same page
+ * without flushing it from the D-cache. This has large potential
+ * to create cache aliases. The Cobalts seem to trigger this
+ * problem easily.
+ *
+ * MIPs doesn't have a flush_dcache_range() so we roll
+ * our own.
+ *
+ * -- pdh
+ */
+
+#define MAX_HWIFS            2
+
+#include <asm/r4kcache.h>
+
+static inline void __flush_dcache(void)
+{
+    unsigned long dc_size, dc_line, addr, end;
+
+    dc_size = current_cpu_data.dcache.ways << 
current_cpu_data.dcache.waybit;
+    dc_line = current_cpu_data.dcache.linesz;
+
+    addr = CKSEG0;
+    end = addr + dc_size;
+
+    for (; addr < end; addr += dc_line)
+        flush_dcache_line_indexed(addr);
+}
+
+static inline void __flush_dcache_range(unsigned long start, unsigned 
long end)
+{
+    unsigned long dc_size, dc_line, addr;
+
+    dc_size = current_cpu_data.dcache.ways << 
current_cpu_data.dcache.waybit;
+    dc_line = current_cpu_data.dcache.linesz;
+
+    addr = start & ~(dc_line - 1);
+    end += dc_line - 1;
+
+    if (end - addr < dc_size)
+        for (; addr < end; addr += dc_line)
+            flush_dcache_line(addr);
+    else
+        __flush_dcache();
+}
+
+static inline void __ide_insw(unsigned long port, void *addr, unsigned 
int count)
+{
+    insw(port, addr, count);
+
+    __flush_dcache_range((unsigned long) addr, (unsigned long) addr + 
count * 2);
+}
+
+static inline void __ide_insl(unsigned long port, void *addr, unsigned 
int count)
+{
+    insl(port, addr, count);
+
+    __flush_dcache_range((unsigned long) addr, (unsigned long) addr + 
count * 4);
+}
+
+static inline void __ide_mm_insw(volatile void __iomem *port, void 
*addr, unsigned int count)
+{
+    readsw(port, addr, count);
+
+    __flush_dcache_range((unsigned long) addr, (unsigned long) addr + 
count * 2);
+}
+
+static inline void __ide_mm_insl(volatile void __iomem *port, void 
*addr, unsigned int count)
+{
+    readsl(port, addr, count);
+
+    __flush_dcache_range((unsigned long) addr, (unsigned long) addr + 
count * 4);
+}
+
+#define insw            __ide_insw
+#define insl            __ide_insl
+
+#define __ide_mm_outsw        writesw
+#define __ide_mm_outsl        writesl
diff -Naur linux-2.6.15.orig/include/asm-mips/io.h 
linux-2.6.15/include/asm-mips/io.h
--- linux-2.6.15.orig/include/asm-mips/io.h    2006-01-09 
21:32:18.000000000 +0000
+++ linux-2.6.15/include/asm-mips/io.h    2006-01-09 20:47:10.000000000 
+0000
@@ -535,6 +535,62 @@
 }
 
 /*
+ * Memory Mapped I/O
+ */
+#define ioread8(addr)        readb(addr)
+#define ioread16(addr)        readw(addr)
+#define ioread32(addr)        readl(addr)
+
+#define iowrite8(b,addr)    writeb(b,addr)
+#define iowrite16(w,addr)    writew(w,addr)
+#define iowrite32(l,addr)    writel(l,addr)
+
+#define ioread8_rep(a,b,c)    readsb(a,b,c)
+#define ioread16_rep(a,b,c)    readsw(a,b,c)
+#define ioread32_rep(a,b,c)    readsl(a,b,c)
+
+#define iowrite8_rep(a,b,c)    writesb(a,b,c)
+#define iowrite16_rep(a,b,c)    writesw(a,b,c)
+#define iowrite32_rep(a,b,c)    writesl(a,b,c)
+
+/* Create a virtual mapping cookie for an IO port range */
+extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+extern void ioport_unmap(void __iomem *);
+
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned 
long max);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+
+/*
+ * Memory Mapped I/O
+ */
+#define ioread8(addr)        readb(addr)
+#define ioread16(addr)        readw(addr)
+#define ioread32(addr)        readl(addr)
+
+#define iowrite8(b,addr)    writeb(b,addr)
+#define iowrite16(w,addr)    writew(w,addr)
+#define iowrite32(l,addr)    writel(l,addr)
+
+#define ioread8_rep(a,b,c)    readsb(a,b,c)
+#define ioread16_rep(a,b,c)    readsw(a,b,c)
+#define ioread32_rep(a,b,c)    readsl(a,b,c)
+
+#define iowrite8_rep(a,b,c)    writesb(a,b,c)
+#define iowrite16_rep(a,b,c)    writesw(a,b,c)
+#define iowrite32_rep(a,b,c)    writesl(a,b,c)
+
+/* Create a virtual mapping cookie for an IO port range */
+extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+extern void ioport_unmap(void __iomem *);
+
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned 
long max);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+
+/*
  * ISA space is 'always mapped' on currently supported MIPS systems, no 
need
  * to explicitly ioremap() it. The fact that the ISA IO space is mapped
  * to PAGE_OFFSET is pure coincidence - it does not mean ISA values


-- 
----
Jim Gifford
maillist@jg555.com
