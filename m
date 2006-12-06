Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 15:48:07 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:41844 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038329AbWLFPrH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 15:47:07 +0000
Received: by nf-out-0910.google.com with SMTP id l24so555911nfc
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 07:47:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=eQODzc4tJ7rlK8H6lq30Yr0psYD/FuOcydmvFooco+tx+SXFGXrsJsTQFMoIxRLENWw120lBeRhr1/cz5Du6IB+RA0ek9Q5YxNm7Fyb4XcOIje/RnXXcgOKrMRFmJ7yEvqHTkxlDk85OIfPFOmWnz29GuQWyi7GmhJQg0saWIrM=
Received: by 10.49.20.15 with SMTP id x15mr2390435nfi.1165420027035;
        Wed, 06 Dec 2006 07:47:07 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm2266129nfc.2006.12.06.07.47.06;
        Wed, 06 Dec 2006 07:47:06 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id E135A23F76F; Wed,  6 Dec 2006 16:48:30 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 3/3] FLATMEM: allow memory to start at pfn != 0
Date:	Wed,  6 Dec 2006 16:48:30 +0100
Message-Id: <11654201101967-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165420110699-git-send-email-fbuihuu@gmail.com>
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch introduces PHYS_OFFSET define which is the start of the
physical memory and uses it wherever needed. Specially when converting
physical/virtual addresses into virtual/physical ones.

Currently all platforms defines PHYS_OFFSET to 0.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |    3 +++
 include/asm-mips/io.h    |    4 ++--
 include/asm-mips/page.h  |   25 +++++++++++++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8e58d7f..46312c2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -315,6 +315,9 @@ static void __init bootmem_init(void)
 
 	if (min_low_pfn >= max_low_pfn)
 		panic("Boggus memory mapping !!!");
+	if (min_low_pfn != ARCH_PFN_OFFSET)
+		panic("PHYS_OFFSET(%lx) and your mem start(%lx) don't match",
+		      PHYS_OFFSET, PFN_PHYS(min_low_pfn));
 
 	/*
 	 * Determine low and high memory ranges
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 38d1399..e1592af 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -115,7 +115,7 @@ static inline void set_io_port_base(unsi
  */
 static inline unsigned long virt_to_phys(volatile const void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
 }
 
 /*
@@ -132,7 +132,7 @@ static inline unsigned long virt_to_phys
  */
 static inline void * phys_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
 }
 
 /*
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 5c4284b..6894dc2 100644
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
 #include <asm/cpu-features.h>
 #include <asm/io.h>
@@ -133,20 +147,23 @@ typedef struct { unsigned long pgprot; }
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
1.4.4.1
