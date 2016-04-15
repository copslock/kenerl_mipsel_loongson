Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:39:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51542 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026655AbcDOKinvBnIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:38:43 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 89A59BC38150F;
        Fri, 15 Apr 2016 11:38:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:38:36 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:38:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, Paul Burton
        <paul.burton@imgtec.com>, Adam Buchbinder <adam.buchbinder@gmail.com>,
        "David Daney" <david.daney@cavium.com>, "Maciej W. Rozycki"
        <macro@linux-mips.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Aneesh
 Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>, Markos Chandras
        <markos.chandras@imgtec.com>, Alex Smith <alex.smith@imgtec.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 05/12] MIPS: mm: Standardise on _PAGE_NO_READ, drop _PAGE_READ
Date:   Fri, 15 Apr 2016 11:36:53 +0100
Message-ID: <1460716620-13382-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.59]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Ever since support for RI/XI was implemented by commit 6dd9344cfc41
("MIPS: Implement Read Inhibit/eXecute Inhibit") we've had a mixture of
_PAGE_READ & _PAGE_NO_READ bits. Rather than keep both around, switch
away from using _PAGE_READ to determine page presence & instead invert
the use to _PAGE_NO_READ. Wherever we formerly had no definition for
_PAGE_NO_READ, change what was _PAGE_READ to _PAGE_NO_READ. The end
result is that we consistently use _PAGE_NO_READ to determine whether a
page is readable, regardless of whether RI/XI is implemented.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/pgtable-bits.h | 19 ++++---------------
 arch/mips/include/asm/pgtable.h      | 23 +++++++----------------
 arch/mips/mm/tlbex.c                 | 13 ++++---------
 3 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index c81fc17..5bc663d 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -49,7 +49,6 @@ enum pgtable_bits {
 
 	/* Used only by software (masked out before writing EntryLo*) */
 	_PAGE_PRESENT_SHIFT = 24,
-	_PAGE_READ_SHIFT,
 	_PAGE_WRITE_SHIFT,
 	_PAGE_ACCESSED_SHIFT,
 	_PAGE_MODIFIED_SHIFT,
@@ -66,7 +65,7 @@ enum pgtable_bits {
 enum pgtable_bits {
 	/* Used only by software (writes to EntryLo ignored) */
 	_PAGE_PRESENT_SHIFT,
-	_PAGE_READ_SHIFT,
+	_PAGE_NO_READ_SHIFT,
 	_PAGE_WRITE_SHIFT,
 	_PAGE_ACCESSED_SHIFT,
 	_PAGE_MODIFIED_SHIFT,
@@ -85,7 +84,7 @@ enum pgtable_bits {
 	/* Used only by software (masked out before writing EntryLo*) */
 	_PAGE_PRESENT_SHIFT,
 #if !defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_MIPSR6)
-	_PAGE_READ_SHIFT,
+	_PAGE_NO_READ_SHIFT,
 #endif
 	_PAGE_WRITE_SHIFT,
 	_PAGE_ACCESSED_SHIFT,
@@ -98,7 +97,6 @@ enum pgtable_bits {
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	_PAGE_NO_EXEC_SHIFT,
 	_PAGE_NO_READ_SHIFT,
-	_PAGE_READ_SHIFT = _PAGE_NO_READ_SHIFT,
 #endif
 	_PAGE_GLOBAL_SHIFT,
 	_PAGE_VALID_SHIFT,
@@ -110,11 +108,6 @@ enum pgtable_bits {
 
 /* Used only by software */
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
-# define _PAGE_READ		(cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
-#else
-# define _PAGE_READ		(1 << _PAGE_READ_SHIFT)
-#endif
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
@@ -125,11 +118,10 @@ enum pgtable_bits {
 /* Used by TLB hardware (placed in EntryLo*) */
 #if (defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32))
 # define _PAGE_NO_EXEC		(1 << _PAGE_NO_EXEC_SHIFT)
-# define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
 #elif defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 # define _PAGE_NO_EXEC		(cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)
-# define _PAGE_NO_READ		(cpu_has_rixi ? (1 << _PAGE_NO_READ_SHIFT) : 0)
 #endif
+#define _PAGE_NO_READ		(1 << _PAGE_NO_READ_SHIFT)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
 #define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
@@ -145,9 +137,6 @@ enum pgtable_bits {
 #ifndef _PAGE_NO_EXEC
 #define _PAGE_NO_EXEC		0
 #endif
-#ifndef _PAGE_NO_READ
-#define _PAGE_NO_READ		0
-#endif
 
 #define _PAGE_SILENT_READ	_PAGE_VALID
 #define _PAGE_SILENT_WRITE	_PAGE_DIRTY
@@ -245,7 +234,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 #define _CACHE_UNCACHED_ACCELERATED	(7<<_CACHE_SHIFT)
 #endif
 
-#define __READABLE	(_PAGE_SILENT_READ | _PAGE_READ | _PAGE_ACCESSED)
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED)
 #define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 9a4fe01..1459ee9 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -23,18 +23,19 @@
 struct mm_struct;
 struct vm_area_struct;
 
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | _PAGE_READ | \
+#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
+				 _CACHE_CACHABLE_NONCOHERENT)
+#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
 				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_NO_EXEC | \
+#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
 				 _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_READ | \
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
 			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
@@ -307,7 +308,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte.pte_low |= _PAGE_ACCESSED;
-	if (pte.pte_low & _PAGE_READ)
+	if (!(pte.pte_low & _PAGE_NO_READ))
 		pte.pte_high |= _PAGE_SILENT_READ;
 	return pte;
 }
@@ -353,13 +354,8 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pte_val(pte) & _PAGE_NO_READ))
 		pte_val(pte) |= _PAGE_SILENT_READ;
-	else
-#endif
-	if (pte_val(pte) & _PAGE_READ)
-		pte_val(pte) |= _PAGE_SILENT_READ;
 	return pte;
 }
 
@@ -542,13 +538,8 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 {
 	pmd_val(pmd) |= _PAGE_ACCESSED;
 
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pmd_val(pmd) & _PAGE_NO_READ))
 		pmd_val(pmd) |= _PAGE_SILENT_READ;
-	else
-#endif
-	if (pmd_val(pmd) & _PAGE_READ)
-		pmd_val(pmd) |= _PAGE_SILENT_READ;
 
 	return pmd;
 }
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 86aa7c2..7e3272f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -234,20 +234,16 @@ static void output_pgtable_bits_defines(void)
 	pr_debug("\n");
 
 	pr_define("_PAGE_PRESENT_SHIFT %d\n", _PAGE_PRESENT_SHIFT);
-	pr_define("_PAGE_READ_SHIFT %d\n", _PAGE_READ_SHIFT);
+	pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
 	pr_define("_PAGE_WRITE_SHIFT %d\n", _PAGE_WRITE_SHIFT);
 	pr_define("_PAGE_ACCESSED_SHIFT %d\n", _PAGE_ACCESSED_SHIFT);
 	pr_define("_PAGE_MODIFIED_SHIFT %d\n", _PAGE_MODIFIED_SHIFT);
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
 #endif
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
-	if (cpu_has_rixi) {
 #ifdef _PAGE_NO_EXEC_SHIFT
+	if (cpu_has_rixi)
 		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
-		pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
-#endif
-	}
 #endif
 	pr_define("_PAGE_GLOBAL_SHIFT %d\n", _PAGE_GLOBAL_SHIFT);
 	pr_define("_PAGE_VALID_SHIFT %d\n", _PAGE_VALID_SHIFT);
@@ -1615,9 +1611,8 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 			cur = t;
 		}
 		uasm_i_andi(p, t, cur,
-			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
-		uasm_i_xori(p, t, t,
-			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
+			(_PAGE_PRESENT | _PAGE_NO_READ) >> _PAGE_PRESENT_SHIFT);
+		uasm_i_xori(p, t, t, _PAGE_PRESENT >> _PAGE_PRESENT_SHIFT);
 		uasm_il_bnez(p, r, t, lid);
 		if (pte == t)
 			/* You lose the SMP race :-(*/
-- 
2.8.0
