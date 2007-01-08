Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 17:43:22 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:59 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28574356AbXAHRms (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 17:42:48 +0000
Received: by nf-out-0910.google.com with SMTP id l24so8744178nfc
        for <linux-mips@linux-mips.org>; Mon, 08 Jan 2007 09:42:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=UanY6F5Ng1phtAl8TgXmd9KzL7v2cpbPHuTk4gLdJ+XQJJZgAELxvN8OR4ty4RDnFB+maM4QPqaL4Vr6vTCdM8TPHdnvMmbgAMVrg7yMw4dOhR96HWQFa/gG/vHZCQaBP8EvpM4XfuJ14p+fjKkfJ7clLmo7aeR9yLuyFvsojXY=
Received: by 10.48.220.15 with SMTP id s15mr11206482nfg.1168278166956;
        Mon, 08 Jan 2007 09:42:46 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p45sm107678077nfa.2007.01.08.09.42.45;
        Mon, 08 Jan 2007 09:42:46 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id D175A23F76E; Mon,  8 Jan 2007 18:44:52 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/2] FLATMEM: introduce PHYS_OFFSET.
Date:	Mon,  8 Jan 2007 18:44:52 +0100
Message-Id: <11682782923407-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11682782923799-git-send-email-fbuihuu@gmail.com>
References: <11682782923799-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

The old code was assuming that min_low_pfn was always 0. This
means that platforms having a big hole at their memory start
paid the price of wasting some memory for the allocation of
unused entries in mem_map[].

This patch prevents this waste.

It introduces PHYS_OFFSET define which is the start of the
physical memory and uses it wherever needed. Specially when
converting physical/virtual addresses into virtual/physical
ones.

Currently all platforms defines PHYS_OFFSET to 0.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |    3 +++
 include/asm-mips/io.h    |    4 ++--
 include/asm-mips/page.h  |   25 +++++++++++++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 581409d..63c17ce 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -315,6 +315,9 @@ static void __init bootmem_init(void)
 
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
+	if (min_low_pfn != ARCH_PFN_OFFSET)
+		panic("PHYS_OFFSET(%lx) and your mem start(%lx) don't match",
+		      PHYS_OFFSET, PFN_PHYS(min_low_pfn));
 
 	/*
 	 * Determine low and high memory ranges
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 38d1399..e1592af 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -115,7 +115,7 @@ static inline void set_io_port_base(unsigned long base)
  */
 static inline unsigned long virt_to_phys(volatile const void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
 }
 
 /*
@@ -132,7 +132,7 @@ static inline unsigned long virt_to_phys(volatile const void *address)
  */
 static inline void * phys_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
 }
 
 /*
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 2f9e1a9..d3fbd83 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -34,6 +34,20 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * This gives the physical RAM offset.
+ */
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET		0UL
+#endif
+
+/*
+ * It's normally defined only for FLATMEM config but it's
+ * used in our early mem init code for all memory models.
+ * So always define it.
+ */
+#define ARCH_PFN_OFFSET		PFN_UP(PHYS_OFFSET)
+
 #include <linux/pfn.h>
 #include <asm/io.h>
 
@@ -132,20 +146,23 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
+/*
+ * __pa()/__va() should be used only during mem init.
+ */
 #if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET
 #endif
-#define __pa(x)			((unsigned long)(x) - __pa_page_offset(x))
-#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
-#define __va(x)			((void *)((unsigned long)(x) + PAGE_OFFSET))
+#define __pa(x)		((unsigned long)(x) - __pa_page_offset(x) + PHYS_OFFSET)
+#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
+#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x),0))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 #ifdef CONFIG_FLATMEM
 
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
 
 #elif defined(CONFIG_SPARSEMEM)
 
-- 
1.4.4.3.ge6d4
