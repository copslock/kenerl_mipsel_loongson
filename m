Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 17:06:28 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:58027 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133539AbWAQRGJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 17:06:09 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 17 Jan 2006 09:09:46 -0800
  id 001D907B.43CD24DA.00005378
Message-ID: <43CD24BE.3010509@jg555.com>
Date:	Tue, 17 Jan 2006 09:09:18 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-21368-1137517787-0001-2"
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Martin Michlmayr <tbm@cyrius.com>,
	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/1] 64-bit fix
References: <20050414185949.GA5578@skeleton-jack> <20060116154543.GA26771@deprecation.cyrius.com> <43CBCAAE.6030403@jg555.com> <20060117135145.GE3336@linux-mips.org>
In-Reply-To: <20060117135145.GE3336@linux-mips.org>
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-21368-1137517787-0001-2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

As per our conversation Ralf, here is the patch without the iomap stuff 
in it.



-- 
----
Jim Gifford
maillist@jg555.com


--=_server-21368-1137517787-0001-2
Content-Type: text/x-diff; name="linux-2.6.15.1-mips_fix-1.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.15.1-mips_fix-1.patch"

Submitted By: Jim Gifford (patches at jg555 dot com)
Date: 2006-01-09
Initial Package Version: 2.6.15
Origin: Jim Gifford
Upstream Status: Not Accepted
Description: Various Fixes for MIPS architectures

diff -Naur linux-2.6.15.orig/include/asm-mips/addrspace.h linux-2.6.15/include/asm-mips/addrspace.h
--- linux-2.6.15.orig/include/asm-mips/addrspace.h	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.15/include/asm-mips/addrspace.h	2006-01-09 20:47:10.000000000 +0000
@@ -124,7 +124,7 @@
 #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
 #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
 #define PHYS_TO_XKPHYS(cm,a)		(_LLCONST_(0x8000000000000000) | \
-					 ((cm)<<59) | (a))
+					 ((unsigned long)(cm)<<59) | (a))
 
 #if defined (CONFIG_CPU_R4300)						\
     || defined (CONFIG_CPU_R4X00)					\
diff -Naur linux-2.6.15.orig/include/asm-mips/cobalt/cpu-feature-overrides.h linux-2.6.15/include/asm-mips/cobalt/cpu-feature-overrides.h
--- linux-2.6.15.orig/include/asm-mips/cobalt/cpu-feature-overrides.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/include/asm-mips/cobalt/cpu-feature-overrides.h	2006-01-09 20:52:18.000000000 +0000
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
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
diff -Naur linux-2.6.15.orig/include/asm-mips/cobalt/ide.h linux-2.6.15/include/asm-mips/cobalt/ide.h
--- linux-2.6.15.orig/include/asm-mips/cobalt/ide.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/include/asm-mips/cobalt/ide.h	2006-01-09 20:47:10.000000000 +0000
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
+#define MAX_HWIFS			2
+
+#include <asm/r4kcache.h>
+
+static inline void __flush_dcache(void)
+{
+	unsigned long dc_size, dc_line, addr, end;
+
+	dc_size = current_cpu_data.dcache.ways << current_cpu_data.dcache.waybit;
+	dc_line = current_cpu_data.dcache.linesz;
+
+	addr = CKSEG0;
+	end = addr + dc_size;
+
+	for (; addr < end; addr += dc_line)
+		flush_dcache_line_indexed(addr);
+}
+
+static inline void __flush_dcache_range(unsigned long start, unsigned long end)
+{
+	unsigned long dc_size, dc_line, addr;
+
+	dc_size = current_cpu_data.dcache.ways << current_cpu_data.dcache.waybit;
+	dc_line = current_cpu_data.dcache.linesz;
+
+	addr = start & ~(dc_line - 1);
+	end += dc_line - 1;
+
+	if (end - addr < dc_size)
+		for (; addr < end; addr += dc_line)
+			flush_dcache_line(addr);
+	else
+		__flush_dcache();
+}
+
+static inline void __ide_insw(unsigned long port, void *addr, unsigned int count)
+{
+	insw(port, addr, count);
+
+	__flush_dcache_range((unsigned long) addr, (unsigned long) addr + count * 2);
+}
+
+static inline void __ide_insl(unsigned long port, void *addr, unsigned int count)
+{
+	insl(port, addr, count);
+
+	__flush_dcache_range((unsigned long) addr, (unsigned long) addr + count * 4);
+}
+
+static inline void __ide_mm_insw(volatile void __iomem *port, void *addr, unsigned int count)
+{
+	readsw(port, addr, count);
+
+	__flush_dcache_range((unsigned long) addr, (unsigned long) addr + count * 2);
+}
+
+static inline void __ide_mm_insl(volatile void __iomem *port, void *addr, unsigned int count)
+{
+	readsl(port, addr, count);
+
+	__flush_dcache_range((unsigned long) addr, (unsigned long) addr + count * 4);
+}
+
+#define insw			__ide_insw
+#define insl			__ide_insl
+
+#define __ide_mm_outsw		writesw
+#define __ide_mm_outsl		writesl

--=_server-21368-1137517787-0001-2--
