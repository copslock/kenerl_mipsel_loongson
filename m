Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:30:17 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039254AbXAJQaP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:30:15 +0000
Received: from nf-out-0910.google.com ([64.233.182.186]:33237 "EHLO
	nf-out-0910.google.com") by lappi.linux-mips.net with ESMTP
	id S136405AbXAJImD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 09:42:03 +0100
Received: by nf-out-0910.google.com with SMTP id l24so408123nfc
        for <linux-mips@linux-mips.org>; Wed, 10 Jan 2007 00:42:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=RygRHZYm1PlsEbyYnyUDziBaH9GLl+JSShtb4mOIKrYEf5DZUSvwroWujJ0lCbdS7+UjOhiuBAhwLown4igSiPDDN22GjUE3jBwkutdapNS5QN4in7pFjuvRy36J/GDit/2vgwFctT2o+0mUDhm2g1/pAR6SShZ6OZtLG+LEHIU=
Received: by 10.49.57.1 with SMTP id j1mr997173nfk.1168418522012;
        Wed, 10 Jan 2007 00:42:02 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p45sm3241412nfa.2007.01.10.00.41.59;
        Wed, 10 Jan 2007 00:42:01 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 3EC2323F76A; Wed, 10 Jan 2007 09:44:06 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/2] FLATMEM: introduce PHYS_OFFSET.
Date:	Wed, 10 Jan 2007 09:44:05 +0100
Message-Id: <11684186464085-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <116841864595-git-send-email-fbuihuu@gmail.com>
References: <116841864595-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13572
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

Conflicts:

	arch/mips/kernel/setup.c
---
 arch/mips/kernel/setup.c |   12 ++++++++----
 include/asm-mips/io.h    |    4 ++--
 include/asm-mips/page.h  |   25 +++++++++++++++++++++----
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f352cd9..e1d76b8 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -315,13 +315,17 @@ static void __init bootmem_init(void)
 
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
-	if (min_low_pfn > 0) {
+	if (min_low_pfn > ARCH_PFN_OFFSET) {
 		printk(KERN_INFO
 		       "Wasting %lu bytes for tracking %lu unused pages\n",
-		       min_low_pfn * sizeof(struct page),
-		       min_low_pfn);
-		min_low_pfn = 0;
+		       (min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
+		       min_low_pfn - ARCH_PFN_OFFSET);
+	} else if (min_low_pfn < ARCH_PFN_OFFSET) {
+		printk(KERN_INFO
+		       "%lu free pages won't be used\n",
+		       ARCH_PFN_OFFSET - min_low_pfn);
 	}
+	min_low_pfn = ARCH_PFN_OFFSET;
 
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
