Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 03:04:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4072 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025896AbaIEBEORxPaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 03:04:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9D0D22C261077;
        Fri,  5 Sep 2014 02:04:05 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:04:06 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:04:06 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 5 Sep 2014 02:04:05 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 4 Sep
 2014 18:04:03 -0700
Subject: [PATCH 3/3] MIPS: bugfix of PTE formats for swap and file entries
To:     <linux-mips@linux-mips.org>, <hauke@hauke-m.de>, <yanh@lemote.com>,
        <zajec5@gmail.com>, <ralf@linux-mips.org>, <alex.smith@imgtec.com>,
        <taohl@lemote.com>, <chenhc@lemote.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Thu, 4 Sep 2014 18:04:03 -0700
Message-ID: <20140905010403.15448.63847.stgit@linux-yegoshin>
In-Reply-To: <20140905010124.15448.53707.stgit@linux-yegoshin>
References: <20140905010124.15448.53707.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Some patch before last era set up hardcoded bits and offsets values of
PTE file and swap entries formats (traced up to last history era beginning)
in pgtable-32.h/pgtable-64.h

Patches

    commit 6ebba0e2f56ee77270a9ef8e92c1b4ec38e5f419
    Author: Sergei Shtylyov <sshtylyov@ru.mvista.com>
    Date:   Sat May 27 20:43:04 2006 +0400
    [MIPS] Fix swap entry for MIPS32 36-bit physical address

and

    commit 7cb710c9a617384cd0ed30638f3acc00125690fc
    Author: Sergei Shtylyov <sshtylyov@ru.mvista.com>
    Date:   Sat May 27 22:39:39 2006 +0400
    [MIPS] Fix non-linear memory mapping on MIPS

fixes some issues but doesn't change a hardcoded bits/offsets encoding,
so, the subsequent patches:

    commit 6dd9344cfc41bcc60a01cdc828cb278be7a10e01
    Author: David Daney <ddaney@caviumnetworks.com>
    Date:   Wed Feb 10 15:12:47 2010 -0800
    MIPS: Implement Read Inhibit/eXecute Inhibit

    commit 970d032fec3f9687446595ee2569fb70b858a69f
    Author: Ralf Baechle <ralf@linux-mips.org>
    Date:   Thu Oct 18 13:54:15 2012 +0200
    MIPS: Transparent Huge Pages support

changed PTE bit format yet another time but missed the appropriate bit/offset
changes in pgtable-32.h/pgtable-64.h for file/swap formats.
Besides that, bit formats now are many and even may be run-time dependent
(RI/XI availability or/and HUGE page support availability).

This bugfix patch:

I.  Introduces a symbolic named definitions for pgtable-32.h/pgtable-64.h
    in proper place - pgtable.h to underline a hard relationship between
    PTE bit positions in pgtable.h and file/swap entries format in
    pgtable-32.h/pgtable-64.h files.

II. Setup macros to fix multivariable formats (moving bits V/G depending on
    kernel config and run-time options) and put this issue finally to rest

Bug can pops-up in heavy paging environment in form of random application/kernel
crashes. It is unusual in embedded and that may be a reason why it is not
catched yet.

This change is based in assumption that excluded bits in file PTE format
(V/G/F/P) are located in two groups with P is rightmost (but 64BIT & MIPS32
configuration is a some special case). Previous patch in series "MIPS: PTE bit
positions slightly changed" does it.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/include/asm/pgtable-32.h   |  107 +++++++++++++++-------------------
 arch/mips/include/asm/pgtable-64.h   |   25 +++++---
 arch/mips/include/asm/pgtable-bits.h |   47 +++++++++++++++
 3 files changed, 110 insertions(+), 69 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index cd7d606..adba9db 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -152,76 +152,61 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_unmap(pte) ((void)(pte))
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
-
-/* Swap entries must have VALID bit cleared. */
-#define __swp_type(x)		(((x).val >> 10) & 0x1f)
-#define __swp_offset(x)		((x).val >> 15)
-#define __swp_entry(type,offset)	\
-	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
-
-/*
- * Bits 0, 4, 8, and 9 are taken, split up 28 bits of offset into this range:
- */
-#define PTE_FILE_MAX_BITS	28
-
-#define pte_to_pgoff(_pte)	((((_pte).pte >> 1 ) & 0x07) | \
-				 (((_pte).pte >> 2 ) & 0x38) | \
-				 (((_pte).pte >> 10) <<	 6 ))
-
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x07) << 1 ) | \
-					   (((off) & 0x38) << 2 ) | \
-					   (((off) >>  6 ) << 10) | \
-					   _PAGE_FILE })
-
-#else
-
-/* Swap entries must have VALID and GLOBAL bits cleared. */
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-#define __swp_type(x)		(((x).val >> 2) & 0x1f)
-#define __swp_offset(x)		 ((x).val >> 7)
-#define __swp_entry(type,offset)	\
-		((swp_entry_t)	{ ((type) << 2) | ((offset) << 7) })
-#else
-#define __swp_type(x)		(((x).val >> 8) & 0x1f)
-#define __swp_offset(x)		 ((x).val >> 13)
-#define __swp_entry(type,offset)	\
-		((swp_entry_t)	{ ((type) << 8) | ((offset) << 13) })
-#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 /*
- * Bits 0 and 1 of pte_high are taken, use the rest for the page offset...
- */
-#define PTE_FILE_MAX_BITS	30
-
-#define pte_to_pgoff(_pte)	((_pte).pte_high >> 2)
-#define pgoff_to_pte(off)	((pte_t) { _PAGE_FILE, (off) << 2 })
-
-#else
-/*
- * Bits 0, 4, 6, and 7 are taken, split up 28 bits of offset into this range:
+ * Two words PTE case:
+ * Bits 0 and 1 (V+G) of pte_high are taken, use the rest for the swaps and
+ * page offset...
+ * Bits F and P are in pte_low.
+ *
+ * Note: swp_entry_t is one word today.
  */
-#define PTE_FILE_MAX_BITS	28
+#define __swp_type(x)			\
+		(((x).val >> __SWP_PTE_SKIP_BITS_NUM) & __SWP_TYPE_MASK)
+#define __swp_offset(x)		\
+		((x).val >> (__SWP_PTE_SKIP_BITS_NUM + __SWP_TYPE_BITS_NUM))
+#define __swp_entry(type, offset)	\
+		((swp_entry_t)  { ((type) << __SWP_PTE_SKIP_BITS_NUM) | \
+		((offset) << (__SWP_TYPE_BITS_NUM + __SWP_PTE_SKIP_BITS_NUM)) })
+#define __pte_to_swp_entry(pte) ((swp_entry_t) { (pte).pte_high })
+#define __swp_entry_to_pte(x)	((pte_t) { 0, (x).val })
 
-#define pte_to_pgoff(_pte)	((((_pte).pte >> 1) & 0x7) | \
-				 (((_pte).pte >> 2) & 0x8) | \
-				 (((_pte).pte >> 8) <<	4))
+#define PTE_FILE_MAX_BITS	(32 - __SWP_PTE_SKIP_BITS_NUM)
 
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x7) << 1) | \
-					   (((off) & 0x8) << 2) | \
-					   (((off) >>  4) << 8) | \
-					   _PAGE_FILE })
-#endif
+#define pte_to_pgoff(_pte)	((_pte).pte_high >> __SWP_PTE_SKIP_BITS_NUM)
+#define pgoff_to_pte(off)	\
+		((pte_t) { _PAGE_FILE, (off) << __SWP_PTE_SKIP_BITS_NUM })
 
-#endif
+#else /* CONFIG_CPU_MIPS32 && !CONFIG_64BIT_PHYS_ADDR */
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-#define __pte_to_swp_entry(pte) ((swp_entry_t) { (pte).pte_high })
-#define __swp_entry_to_pte(x)	((pte_t) { 0, (x).val })
-#else
+/* Swap  entries must have V,G,P and F bits cleared. */
+#define __swp_type(x)		(((x).val >> _PAGE_DIRTY_SHIFT) & __SWP_TYPE_MASK)
+#define __swp_offset(x)	\
+		((x).val >> (_PAGE_DIRTY_SHIFT + __SWP_TYPE_BITS_NUM))
+#define __swp_entry(type, offset)	\
+		((swp_entry_t) { ((type) << _PAGE_DIRTY_SHIFT) | \
+		((offset) << (_PAGE_DIRTY_SHIFT + __SWP_TYPE_BITS_NUM)) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-#endif
 
+/*
+ * Bits V+G, and F+P are taken, split up 28 bits of offset into two bitfields:
+ */
+#define PTE_FILE_MAX_BITS	(32 - __FILE_PTE_TOTAL_BITS_NUM)
+
+#define pte_to_pgoff(_pte)	\
+		((((_pte).pte >> __FILE_PTE_TOTAL_BITS_NUM) & \
+		    ~(__FILE_PTE_LOW_MASK)) | \
+		 (((_pte).pte >> __FILE_PTE_LOW_BITS_NUM) & \
+		    (__FILE_PTE_LOW_MASK)))
+
+#define pgoff_to_pte(off)	\
+		((pte_t) { (((off) & __FILE_PTE_LOW_MASK) << \
+		      (__FILE_PTE_LOW_BITS_NUM)) | \
+		   (((off) & ~(__FILE_PTE_LOW_MASK)) << \
+		      (__FILE_PTE_TOTAL_BITS_NUM)) | \
+		   _PAGE_FILE })
+
+#endif /* CONFIG_64BIT_PHYS_ADDR && CONFIG_MIPS32 */
 #endif /* _ASM_PGTABLE_32_H */
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index e1c49a9..3484910 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -283,21 +283,30 @@ extern void pmd_init(unsigned long page, unsigned long pagetable);
  * low 32 bits zero.
  */
 static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
-{ pte_t pte; pte_val(pte) = (type << 32) | (offset << 40); return pte; }
+{
+	pte_t pte;
+
+	pte_val(pte) = (type << __SWP_PTE_SKIP_BITS_NUM) |
+		(offset << (__SWP_PTE_SKIP_BITS_NUM + __SWP_TYPE_BITS_NUM));
+	return pte;
+}
 
-#define __swp_type(x)		(((x).val >> 32) & 0xff)
-#define __swp_offset(x)		((x).val >> 40)
+#define __swp_type(x)		\
+		(((x).val >> __SWP_PTE_SKIP_BITS_NUM) & __SWP_TYPE_MASK)
+#define __swp_offset(x)	\
+		((x).val >> (__SWP_PTE_SKIP_BITS_NUM + __SWP_TYPE_BITS_NUM))
 #define __swp_entry(type, offset) ((swp_entry_t) { pte_val(mk_swap_pte((type), (offset))) })
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 /*
- * Bits 0, 4, 6, and 7 are taken. Let's leave bits 1, 2, 3, and 5 alone to
- * make things easier, and only use the upper 56 bits for the page offset...
+ * Take out all bits from V to bit 0. We should actually take out only VGFP but
+ * today PTE is too complicated by HUGE page support etc
  */
-#define PTE_FILE_MAX_BITS	56
+#define PTE_FILE_MAX_BITS	(64 - _PAGE_DIRTY_SHIFT)
 
-#define pte_to_pgoff(_pte)	((_pte).pte >> 8)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 8) | _PAGE_FILE })
+#define pte_to_pgoff(_pte)	((_pte).pte >> _PAGE_DIRTY_SHIFT)
+#define pgoff_to_pte(off)	\
+		((pte_t) { ((off) << _PAGE_DIRTY_SHIFT) | _PAGE_FILE })
 
 #endif /* _ASM_PGTABLE_64_H */
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index d47be80..708f681 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -121,6 +121,7 @@
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
+#define _PAGE_FILE_SHIFT	(_PAGE_MODIFIED_SHIFT)
 #define _PAGE_FILE		(_PAGE_MODIFIED)
 #define _PAGE_READ_SHIFT	\
 		(cpu_has_rixi ? _PAGE_MODIFIED_SHIFT : _PAGE_MODIFIED_SHIFT + 1)
@@ -225,6 +226,7 @@
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_PRESENT_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 /* set:pagecache unset:swap */
+#define _PAGE_FILE_SHIFT	(_PAGE_MODIFIED_SHIFT)
 #define _PAGE_FILE		(_PAGE_MODIFIED)
 /* implemented in software */
 #define _PAGE_WRITE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
@@ -292,6 +294,51 @@
 #define _PAGE_GLOBAL_SHIFT ilog2(_PAGE_GLOBAL)
 #endif
 
+/*
+ * Swap and File entries format definitions in PTE
+ * This constant definitions are here because it is linked with bit positions
+ * The real macros are still in pgtable-32/64.h
+ *
+ * There are 3 kind of format - 64BIT, generic 32BIT and 32BIT & 64BIT PA
+ */
+#define __SWP_TYPE_BITS_NUM	5
+#define __SWP_TYPE_MASK	((1 << __SWP_TYPE_BITS_NUM) - 1)
+
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
+
+/*
+ * Two words PTE case:
+ * Bits 0 and 1 (V+G) of pte_high are taken, use the rest for the swaps and
+ * page offset...
+ * Bits F and P are in pte_low.
+ *
+ * Note: swp_entry_t or file entry are one word today (pte_high)
+ */
+#define __SWP_PTE_SKIP_BITS_NUM	2
+
+#elif defined(CONFIG_64BIT)
+/*
+ * Swap entry is located in high 32 bits of PTE
+ *
+ * File entry starts right from D bit
+ */
+#define __SWP_PTE_SKIP_BITS_NUM	32
+
+#else /* CONFIG_CPU_MIPS32 && !CONFIG_64BIT_PHYS_ADDR */
+/*
+ * Swap entry is encoded starting right from D bit
+ *
+ * File entry is encoded in all bits besides V,G,F and P which are grouped in
+ * two fields with variable gap, so - additonal location info is defined here
+ */
+/* rightmost taken out field - F and P */
+#define __FILE_PTE_LOW_BITS_NUM	2
+/* total number of taken out bits - V,G,F,P */
+#define __FILE_PTE_TOTAL_BITS_NUM	4
+/* mask for intermediate field which is used for encoding */
+#define __FILE_PTE_LOW_MASK	((_PAGE_GLOBAL - 1) >> (_PAGE_FILE_SHIFT + 1))
+
+#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
 #ifndef __ASSEMBLY__
 /*
