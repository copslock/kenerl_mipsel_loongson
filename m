Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 05:22:23 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:58328 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133528AbVLEFVp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2005 05:21:45 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sun, 04 Dec 2005 21:21:17 -0800
  id 00098009.4393CE4D.0000708B
Message-ID: <4393CE3B.20303@jg555.com>
Date:	Sun, 04 Dec 2005 21:20:59 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-28811-1133760077-0001-2"
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Cobalt IDE Patch
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-28811-1133760077-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is Peter Horton's IDE patch for the Cobalt. From the notes in 
Peter's file.

PIO "in" transfers can cause D-cache lines to be allocated
 to the data being read. If the target is the page cache then
 the kernel can create a user space mapping of the same page
 without flushing it from the D-cache. This has large potential
 to create cache aliases. The Cobalts seem to trigger this
 problem easily.


-- 
----
Jim Gifford
maillist@jg555.com


--=_server-28811-1133760077-0001-2
Content-Type: text/x-diff; name="cobalt_ide.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cobalt_ide.patch"

diff -Naur linux-mips-2.6.14.orig/include/asm-mips/cobalt/ide.h linux-mips-2.6.14/include/asm-mips/cobalt/ide.h
--- linux-mips-2.6.14.orig/include/asm-mips/cobalt/ide.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-mips-2.6.14/include/asm-mips/cobalt/ide.h	2005-11-17 14:58:19.000000000 -0800
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

--=_server-28811-1133760077-0001-2--
