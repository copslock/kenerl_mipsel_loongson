Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 15:05:32 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:25607 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224979AbVHZOFQ>; Fri, 26 Aug 2005 15:05:16 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7QEAm33010523;
	Fri, 26 Aug 2005 15:10:48 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7QEAl0w010522;
	Fri, 26 Aug 2005 15:10:47 +0100
Date:	Fri, 26 Aug 2005 15:10:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
Message-ID: <20050826141047.GA8777@linux-mips.org>
References: <20050825154249.GC2731@linux-mips.org> <20050825211218Z8225471-3678+7505@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825211218Z8225471-3678+7505@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 25, 2005 at 05:17:48PM -0400, Bryan Althouse wrote:

> If I change the line "hwif->irq = 0" in my driver to "hwif->irq = 5", my SMP
> kernel no longer experiences SMP badness.  Instead, I get many lines like
> "hda: lost interrupt", and the drive is not usable.  If I compile the kernel
> without SMP, the drive works properly as before.  I tried irq = 5 because I
> noticed that /proc/interrupts indicated that ide0 was being probed at 5.
> With the SMP kernel, /proc/interrupts shows a count of 0 for ide0.  My
> non-SMP kernel shows a count that increments when the drive is being used
> (as expected).

Try this patch below and let me know.  I would also like to ask those
people who used to suffer from aliases with IDE PIO to try this patch.

  Ralf

Index: include/asm-mips/mach-generic/ide.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-generic/ide.h,v
retrieving revision 1.9
diff -u -r1.9 ide.h
--- include/asm-mips/mach-generic/ide.h	19 Apr 2005 12:26:59 -0000	1.9
+++ include/asm-mips/mach-generic/ide.h	26 Aug 2005 14:04:38 -0000
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/stddef.h>
 #include <asm/processor.h>
+#include <asm/cacheflush.h>
 
 #ifndef MAX_HWIFS
 # ifdef CONFIG_BLK_DEV_IDEPCI
@@ -105,12 +106,14 @@
 
 /* MIPS port and memory-mapped I/O string operations.  */
 
-static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
+static inline void __ide_flush_dcache_range(unsigned long addr,
+	unsigned long size)
 {
-	if (cpu_has_dc_aliases) {
-		unsigned long end = addr + size;
-		for (; addr < end; addr += PAGE_SIZE)
-			flush_dcache_page(virt_to_page(addr));
+	unsigned long end = addr + size;
+
+	while (addr < end) {
+		SetPageDcacheDirty(virt_to_page(addr));
+		addr += PAGE_SIZE;
 	}
 }
 
