Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 14:19:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2947 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022388AbXCWOTu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 14:19:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2NEJeK5018770;
	Fri, 23 Mar 2007 14:19:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2NEJdaO018769;
	Fri, 23 Mar 2007 14:19:39 GMT
Date:	Fri, 23 Mar 2007 14:19:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Miklos Szeredi <miklos@szeredi.hu>
Cc:	linux-mips@linux-mips.org, Ravi.Pratap@hillcrestlabs.com
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070323141939.GB17311@linux-mips.org>
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 22, 2007 at 11:28:40PM +0100, Miklos Szeredi wrote:

> It seems that MIPS needs to implement flush_anon_page() for correct
> operation of get_user_pages() on anonymous pages.
> 
> This function is already implemented in PARISC and ARM.  Also see
> Documentation/cachetlb.txt.

**GRRRRR**

From <linux/highmem.h>:

#ifndef ARCH_HAS_FLUSH_ANON_PAGE
static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page
, unsigned long vmaddr)
{
}
#endif

See why such stuff is happening?  Providing a default implemntation may be
fine for i.e. strcpy() where it's only about providing a better mouse
trap than the standard one in lib/string.c.  It's an awfully bad idea for
something that matters for correctness such as flush_anon_page() ...

Oh well, I'm looking into it.  Fortunately I've written reasonable
infrastructure during the previous round of the cache alias wars, so this
case should be reasonably simple to solve.  First cut of patch below.

The other thing I still need to understand is why nobody actually seems
to have triggered this bug on MIPS so far.  I suppose our implementation
of flush_dcache_page() may have done a successful job at papering it
which means there might be some performance getting lost there as well.

Was this one found by code inspection or actually triggered by like FUSE?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 31819c5..f565608 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1994 - 2003 by Ralf Baechle
+ * Copyright (C) 1994 - 2003, 07 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2007 MIPS Technologies, Inc.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -88,6 +89,23 @@ void __flush_dcache_page(struct page *page)
 
 EXPORT_SYMBOL(__flush_dcache_page);
 
+void __flush_anon_page(struct vm_area_struct *vma, struct page *page,
+	unsigned long vmaddr)
+{
+	if (!cpu_has_dc_aliases)
+		return;
+
+	if (pages_do_alias((unsigned long)page_address(page), vmaddr)) {
+		void *kaddr;
+
+		kaddr = kmap_coherent(page, vmaddr);
+		flush_data_cache_page((unsigned long)kaddr);
+		kunmap_coherent(kaddr);
+	}
+}
+
+EXPORT_SYMBOL(__flush_anon_page);
+
 void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte)
 {
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 25abe91..e9951c0 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -123,7 +123,7 @@ static void __init kmap_coherent_init(void)
 static inline void kmap_coherent_init(void) {}
 #endif
 
-static inline void *kmap_coherent(struct page *page, unsigned long addr)
+void *kmap_coherent(struct page *page, unsigned long addr)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr, flags, entrylo;
@@ -177,7 +177,7 @@ static inline void *kmap_coherent(struct page *page, unsigned long addr)
 
 #define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
 
-static inline void kunmap_coherent(struct page *page)
+void kunmap_coherent(struct page *page)
 {
 #ifndef CONFIG_MIPS_MT_SMTC
 	unsigned int wired;
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index 0ddada3..1bd3310 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -48,6 +48,16 @@ static inline void flush_dcache_page(struct page *page)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
+#define ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vmaddr)
+{
+	extern void __flush_anon_page(struct vm_area_struct *vma,
+	                              struct page *, unsigned long);
+	if (PageAnon(page))
+		__flush_anon_page(vma, page, vmaddr);
+}
+
 static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
@@ -86,4 +96,7 @@ extern void (*flush_data_cache_page)(unsigned long addr);
 /* Run kernel code uncached, useful for cache probing functions. */
 unsigned long __init run_uncached(void *func);
 
+extern void *kmap_coherent(struct page *page, unsigned long addr);
+extern void kunmap_coherent(struct page *page);
+
 #endif /* _ASM_CACHEFLUSH_H */
