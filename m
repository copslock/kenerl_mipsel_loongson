Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 22:29:36 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:56497 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903408Ab2IEU2O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 22:28:14 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1T9MCm-0004QI-GA; Wed, 05 Sep 2012 15:28:08 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 3/4] MIPS: Remove kernel_uses_smartmips_rixi from page table bits.
Date:   Wed,  5 Sep 2012 15:27:57 -0500
Message-Id: <1346876878-25965-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346876878-25965-1-git-send-email-sjhill@mips.com>
References: <1346876878-25965-1-git-send-email-sjhill@mips.com>
X-archive-position: 34421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Remove usage of the 'kernel_uses_smartmips_rixi' macro from all the
page table bit definitions in 'arch/mips/include/asm' directory.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/pgtable-bits.h |   24 ++++++++++++++----------
 arch/mips/include/asm/pgtable.h      |   12 ++++++------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index e9fe7e9..c266cba 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -79,9 +79,9 @@
 /* implemented in software */
 #define _PAGE_PRESENT_SHIFT	(0)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
-/* implemented in software, should be unused if kernel_uses_smartmips_rixi. */
-#define _PAGE_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
-#define _PAGE_READ ({if (kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_READ_SHIFT; })
+/* implemented in software, should be unused if cpu_has_ri. */
+#define _PAGE_READ_SHIFT	(cpu_has_ri ? _PAGE_PRESENT_SHIFT + 1: _PAGE_PRESENT_SHIFT)
+#define _PAGE_READ ({if (!cpu_has_ri) BUG(); 1 << _PAGE_READ_SHIFT; })
 /* implemented in software */
 #define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
@@ -104,12 +104,12 @@
 #endif
 
 /* Page cannot be executed */
-#define _PAGE_NO_EXEC_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
-#define _PAGE_NO_EXEC		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
+#define _PAGE_NO_EXEC_SHIFT	(cpu_has_xi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
+#define _PAGE_NO_EXEC		({if (!cpu_has_xi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
 
 /* Page cannot be read */
-#define _PAGE_NO_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
-#define _PAGE_NO_READ		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
+#define _PAGE_NO_READ_SHIFT	(cpu_has_ri ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
+#define _PAGE_NO_READ		({if (!cpu_has_ri) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
 
 #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
@@ -155,20 +155,24 @@
  */
 static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 {
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
+		unsigned long rixi;
 		int sa;
 #ifdef CONFIG_32BIT
 		sa = 31 - _PAGE_NO_READ_SHIFT;
 #else
 		sa = 63 - _PAGE_NO_READ_SHIFT;
 #endif
+		rixi = ((cpu_has_ri ? _PAGE_NO_READ : 0) |
+			(cpu_has_xi ? _PAGE_NO_EXEC : 0));
+
 		/*
 		 * C has no way to express that this is a DSRL
 		 * _PAGE_NO_EXEC_SHIFT followed by a ROTR 2.  Luckily
 		 * in the fast path this is done in assembly
 		 */
 		return (pte_val >> _PAGE_GLOBAL_SHIFT) |
-			((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
+			 ((pte_val & rixi) << sa);
 	}
 
 	return pte_val >> _PAGE_GLOBAL_SHIFT;
@@ -220,7 +224,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 
 #endif
 
-#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ))
+#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_ri ? 0 : _PAGE_READ))
 #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
 
 #define _PAGE_CHG_MASK  (_PFN_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index b2202a6..748aa6a 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -22,15 +22,15 @@ struct mm_struct;
 struct vm_area_struct;
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
+#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (cpu_has_ri ? 0 : _PAGE_READ) | \
 				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
-				 (kernel_uses_smartmips_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
+#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (cpu_has_ri ? 0 : _PAGE_READ) | \
+				 (cpu_has_xi ? _PAGE_NO_EXEC : 0) | _page_cachable_default)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (cpu_has_ri ? 0 : _PAGE_READ) | \
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
-#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
+#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (cpu_has_ri ? 0 : _PAGE_READ) | _PAGE_WRITE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
 			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
@@ -299,7 +299,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri) {
 		if (!(pte_val(pte) & _PAGE_NO_READ))
 			pte_val(pte) |= _PAGE_SILENT_READ;
 	} else {
-- 
1.7.9.5
