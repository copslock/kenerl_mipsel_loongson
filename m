Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 06:43:51 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:56607
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225195AbVAGGnp>; Fri, 7 Jan 2005 06:43:45 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Jan 2005 06:43:43 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id DD1E7239E1D; Fri,  7 Jan 2005 15:43:39 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j076hdRm012231;
	Fri, 7 Jan 2005 15:43:39 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 07 Jan 2005 15:43:39 +0900 (JST)
Message-Id: <20050107.154339.96686680.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: mach-generic/ide.h fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  Here is a patch to current mach-generic/ide.h.

1. Call pci_dev_put to decrement reference count.

2. Flush dcache to fix mmap problem on PIO IDE which was discussed
   about a year ago on this ML.  The last block redefines insw/insl
   since ide_iops.c calls plain insw instead of __ide_insw (does
   anybody know why __ide_insw was defined but not used?).

Please review.  Thank you.


diff -u linux-mips/include/asm-mips/mach-generic/ide.h linux/include/asm-mips/mach-generic/ide.h
--- linux-mips/include/asm-mips/mach-generic/ide.h	2004-12-28 10:56:09.000000000 +0900
+++ linux/include/asm-mips/mach-generic/ide.h	2005-01-07 15:26:04.165150062 +0900
@@ -18,6 +18,7 @@
 #include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <asm/processor.h>
 
 #ifndef MAX_HWIFS
 # ifdef CONFIG_BLK_DEV_IDEPCI
@@ -32,8 +33,13 @@
 static __inline__ int ide_probe_legacy(void)
 {
 #ifdef CONFIG_PCI
-	return (pci_get_class(PCI_CLASS_BRIDGE_EISA << 8, NULL) != NULL) ||
-	       (pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL) != NULL);
+	struct pci_dev *dev;
+	if ((dev = pci_get_class(PCI_CLASS_BRIDGE_EISA << 8, NULL)) != NULL ||
+	    (dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL)) != NULL) {
+		pci_dev_put(dev);
+		return 1;
+	}
+	return 0;
 #elif defined(CONFIG_EISA) || defined(CONFIG_ISA)
 	return 1;
 #else
@@ -98,16 +104,54 @@
 
 /* MIPS port and memory-mapped I/O string operations.  */
 
-#define __ide_insw	insw
-#define __ide_insl	insl
+static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
+{
+	if (cpu_has_dc_aliases) {
+#ifdef CONFIG_DMA_NONCOHERENT
+		dma_cache_wback(addr, size);
+#else
+		unsigned long end = addr + size;
+		for (; addr < end; addr += PAGE_SIZE)
+			flush_data_cache_page(addr);
+#endif
+	}
+}
+
+static inline void __ide_insw(unsigned long port, void *addr, unsigned int count)
+{
+	insw(port, addr, count);
+	__ide_flush_dcache_range((unsigned long)addr, count * 2);
+}
+
+static inline void __ide_insl(unsigned long port, void *addr, unsigned int count)
+{
+	insl(port, addr, count);
+	__ide_flush_dcache_range((unsigned long)addr, count * 4);
+}
+
 #define __ide_outsw	outsw
 #define __ide_outsl	outsl
 
-#define __ide_mm_insw	readsw
-#define __ide_mm_insl	readsl
+static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
+{
+	readsw(port, addr, count);
+	__ide_flush_dcache_range((unsigned long)addr, count * 2);
+}
+static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
+{
+	readsl(port, addr, count);
+	__ide_flush_dcache_range((unsigned long)addr, count * 4);
+}
+
 #define __ide_mm_outsw	writesw
 #define __ide_mm_outsl	writesl
 
+/* ide_insw calls insw, not __ide_insw.  Why? */
+#undef insw
+#undef insl
+#define insw(port, addr, count) __ide_insw(port, addr, count)
+#define insl(port, addr, count) __ide_insl(port, addr, count)
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_MACH_GENERIC_IDE_H */

---
Atsushi Nemoto
