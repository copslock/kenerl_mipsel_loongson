Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 03:50:12 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:17461 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225199AbTCMDuL>;
	Thu, 13 Mar 2003 03:50:11 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 6F1166EC; Thu, 13 Mar 2003 04:50:08 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: 1/2 cleanup of c-andes.c
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 13 Mar 2003 04:50:08 +0100
Message-ID: <863cls6i33.fsf@trasno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi ralf

Make only once the detection of the secondary cache line size.
Once there, make  andes_flush_icache_page have the right types and
remove the wrong export.

Later, Juan.


 build/arch/mips64/mm/c-andes.c     |   53 ++++++++++++++++++++++++-------------
 build/include/asm-mips64/pgtable.h |    7 ----
 2 files changed, 36 insertions(+), 24 deletions(-)

diff -puN build/include/asm-mips64/pgtable.h~mips64-sc-line-size build/include/asm-mips64/pgtable.h
--- 24/build/include/asm-mips64/pgtable.h~mips64-sc-line-size	2003-03-13 04:11:14.000000000 +0100
+++ 24-quintela/build/include/asm-mips64/pgtable.h	2003-03-13 04:11:14.000000000 +0100
@@ -61,7 +61,6 @@ extern void (*_flush_cache_l1)(void);
  * are io coherent. The only place where we might be overoptimizing
  * out icache flushes are from mprotect (when PROT_EXEC is added).
  */
-extern void andes_flush_icache_page(unsigned long);
 #define flush_cache_mm(mm)		do { } while(0)
 #define flush_cache_range(mm,start,end)	do { } while(0)
 #define flush_cache_page(vma,page)	do { } while(0)
@@ -69,11 +68,7 @@ extern void andes_flush_icache_page(unsi
 #define flush_icache_range(start, end)	_flush_cache_l1()
 #define flush_icache_user_range(vma, page, addr, len) \
 	flush_icache_page((vma), (page))
-#define flush_icache_page(vma, page)					\
-do {									\
-	if ((vma)->vm_flags & VM_EXEC)					\
-		andes_flush_icache_page(phys_to_virt(page_to_phys(page))); \
-} while (0)
+#define flush_icache_page(vma, page)	_flush_icache_page(vma, page)
 
 #else
 
diff -puN build/arch/mips64/mm/c-andes.c~mips64-sc-line-size build/arch/mips64/mm/c-andes.c
--- 24/build/arch/mips64/mm/c-andes.c~mips64-sc-line-size	2003-03-13 04:11:14.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-andes.c	2003-03-13 04:34:10.000000000 +0100
@@ -17,8 +17,6 @@
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 
-static int scache_lsz64;
-
 extern void andes_clear_page(void * page);
 extern void andes_copy_page(void * to, void * from);
 
@@ -35,12 +33,14 @@ static void andes_flush_cache_l1(void)
  * This is only used during initialization time. vmalloc() also calls
  * this, but that will be changed pretty soon.
  */
-static void andes_flush_cache_l2(void)
+static void andes_flush_cache_l2_64(void)
 {
-	if (sc_lsize() == 64)
-		blast_scache64();
-	else
-		blast_scache128();
+	blast_scache64();
+}
+
+static void andes_flush_cache_l2_128(void)
+{
+	blast_scache128();
 }
 
 static void andes_flush_cache_all(void)
@@ -50,7 +50,7 @@ static void andes_flush_cache_all(void)
 static void andes___flush_cache_all(void)
 {
 	andes_flush_cache_l1();
-	andes_flush_cache_l2();
+	flush_cache_l2();
 }
 
 /*
@@ -60,14 +60,29 @@ static void andes___flush_cache_all(void
  * secondary cache will result in any entries in the primary caches also
  * getting invalidated.
  */
-void andes_flush_icache_page(unsigned long page)
+
+static void andes_flush_icache_page64(struct vm_area_struct *vma,
+				      struct page *page)
 {
-	if (scache_lsz64)
-		blast_scache64_page(page);
-	else
-		blast_scache128_page(page);
+	unsigned long pfn;
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	pfn = (unsigned long)phys_to_virt(page_to_phys(page));
+	blast_scache64_page(pfn);
 }
 
+static void andes_flush_icache_page128(struct vm_area_struct *vma,
+	struct page *page)
+{
+	unsigned long pfn;
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	pfn = (unsigned long)phys_to_virt(page_to_phys(page));
+	blast_scache128_page(pfn);
+ }
+
 static void andes_flush_cache_sigtramp(unsigned long addr)
 {
 	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
@@ -95,13 +110,15 @@ void __init ld_mmu_andes(void)
 	_flush_cache_all = andes_flush_cache_all;
 	___flush_cache_all = andes___flush_cache_all;
 	_flush_cache_l1 = andes_flush_cache_l1;
-	_flush_cache_l2 = andes_flush_cache_l2;
 	_flush_cache_sigtramp = andes_flush_cache_sigtramp;
 
-	if (sc_lsize() == 64)
-		scache_lsz64 = 1;
-	else
-		scache_lsz64 = 0;
+	if (sc_lsize() == 64) {
+		_flush_cache_l2 = andes_flush_cache_l2_64;
+		_flush_icache_page = andes_flush_icache_page64;
+	} else {
+		_flush_cache_l2 = andes_flush_cache_l2_128;
+		_flush_icache_page = andes_flush_icache_page128;
+	}
 
 	flush_cache_l1();
 }

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
