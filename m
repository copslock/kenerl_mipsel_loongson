Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 15:01:20 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:16513 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225761AbVBTPBF>; Sun, 20 Feb 2005 15:01:05 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D2sZz-0006x5-00; Sun, 20 Feb 2005 15:01:03 +0000
Date:	Sun, 20 Feb 2005 15:01:03 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6] Cobalt fixes [5 of 6]
Message-ID: <20050220150103.GF26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix Qube/RaQ PIO IDE to prevent D-cache aliasing problems.

P.

--- linux-cvs/include/asm-mips/cobalt/ide.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-wip/include/asm-mips/cobalt/ide.h	2005-02-20 14:00:49.000000000 +0000
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
