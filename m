Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:58:18 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:17027 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225232AbTC0C4C>;
	Thu, 27 Mar 2003 02:56:02 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 0245346A59; Thu, 27 Mar 2003 03:54:34 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: Better handling of PG_dcache_dirty
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:34 +0100
Message-ID: <m2znnhcydx.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

Use coherent names:
    s/Page_dcache_dirty/PageDcacheDirty/
And remove WO pg_flags variable (too much copy & paste from sparc64).

Later, Juan.


 build/arch/mips/mm/c-mips32.c      |    3 +--
 build/arch/mips/mm/c-r4k.c         |    3 +--
 build/arch/mips/mm/c-r5432.c       |    3 +--
 build/arch/mips/mm/c-tx39.c        |    3 +--
 build/arch/mips/mm/c-tx49.c        |    3 +--
 build/arch/mips64/mm/c-mips64.c    |    3 +--
 build/arch/mips64/mm/c-r4k.c       |    3 +--
 build/include/asm-mips/pgtable.h   |    2 +-
 build/include/asm-mips64/pgtable.h |    2 +-
 9 files changed, 9 insertions(+), 16 deletions(-)

diff -puN build/include/asm-mips/pgtable.h~PG_dcache_dirty build/include/asm-mips/pgtable.h
--- 24/build/include/asm-mips/pgtable.h~PG_dcache_dirty	2003-03-27 02:25:51.000000000 +0100
+++ 24-quintela/build/include/asm-mips/pgtable.h	2003-03-27 02:26:35.000000000 +0100
@@ -70,7 +70,7 @@ extern void (*_flush_icache_all)(void);
  */
 #define PG_dcache_dirty			PG_arch_1
 
-#define Page_dcache_dirty(page)		\
+#define PageDcacheDirty(page)		\
 	test_bit(PG_dcache_dirty, &(page)->flags)
 #define SetPageDcacheDirty(page)	\
 	set_bit(PG_dcache_dirty, &(page)->flags)
diff -puN build/include/asm-mips64/pgtable.h~PG_dcache_dirty build/include/asm-mips64/pgtable.h
--- 24/build/include/asm-mips64/pgtable.h~PG_dcache_dirty	2003-03-27 02:25:54.000000000 +0100
+++ 24-quintela/build/include/asm-mips64/pgtable.h	2003-03-27 02:26:09.000000000 +0100
@@ -77,7 +77,7 @@ extern void (*_flush_icache_all)(void);
  */
 #define PG_dcache_dirty			PG_arch_1
 
-#define Page_dcache_dirty(page)		\
+#define PageDcacheDirty(page)		\
 	test_bit(PG_dcache_dirty, &(page)->flags)
 #define SetPageDcacheDirty(page)	\
 	set_bit(PG_dcache_dirty, &(page)->flags)
diff -puN build/arch/mips64/mm/c-r4k.c~PG_dcache_dirty build/arch/mips64/mm/c-r4k.c
--- 24/build/arch/mips64/mm/c-r4k.c~PG_dcache_dirty	2003-03-27 02:27:38.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-r4k.c	2003-03-27 02:56:24.000000000 +0100
@@ -1085,10 +1085,9 @@ void __update_cache(struct vm_area_struc
 	pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		r4k_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);
diff -puN build/arch/mips64/mm/c-mips64.c~PG_dcache_dirty build/arch/mips64/mm/c-mips64.c
--- 24/build/arch/mips64/mm/c-mips64.c~PG_dcache_dirty	2003-03-27 02:27:40.000000000 +0100
+++ 24-quintela/build/arch/mips64/mm/c-mips64.c	2003-03-27 02:56:18.000000000 +0100
@@ -425,10 +425,9 @@ void __update_cache(struct vm_area_struc
         pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		mips64_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);
diff -puN build/arch/mips/mm/c-mips32.c~PG_dcache_dirty build/arch/mips/mm/c-mips32.c
--- 24/build/arch/mips/mm/c-mips32.c~PG_dcache_dirty	2003-03-27 02:27:54.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-mips32.c	2003-03-27 02:55:23.000000000 +0100
@@ -409,10 +409,9 @@ void __update_cache(struct vm_area_struc
 	pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		mips32_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);
diff -puN build/arch/mips/mm/c-r4k.c~PG_dcache_dirty build/arch/mips/mm/c-r4k.c
--- 24/build/arch/mips/mm/c-r4k.c~PG_dcache_dirty	2003-03-27 02:28:00.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r4k.c	2003-03-27 02:55:29.000000000 +0100
@@ -568,10 +568,9 @@ void __update_cache(struct vm_area_struc
 	pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		r4k_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);
diff -puN build/arch/mips/mm/c-r5432.c~PG_dcache_dirty build/arch/mips/mm/c-r5432.c
--- 24/build/arch/mips/mm/c-r5432.c~PG_dcache_dirty	2003-03-27 02:28:03.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-r5432.c	2003-03-27 02:55:35.000000000 +0100
@@ -437,10 +437,9 @@ void __update_cache(struct vm_area_struc
 	pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		r5432_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);
diff -puN build/arch/mips/mm/c-tx39.c~PG_dcache_dirty build/arch/mips/mm/c-tx39.c
--- 24/build/arch/mips/mm/c-tx39.c~PG_dcache_dirty	2003-03-27 02:28:11.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-tx39.c	2003-03-27 02:55:41.000000000 +0100
@@ -323,10 +323,9 @@ void __update_cache(struct vm_area_struc
 	pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		tx39_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);
diff -puN build/arch/mips/mm/c-tx49.c~PG_dcache_dirty build/arch/mips/mm/c-tx49.c
--- 24/build/arch/mips/mm/c-tx49.c~PG_dcache_dirty	2003-03-27 02:28:13.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/c-tx49.c	2003-03-27 02:55:47.000000000 +0100
@@ -284,10 +284,9 @@ void __update_cache(struct vm_area_struc
 	pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	unsigned long pg_flags;
 
 	if (VALID_PAGE(page) && page->mapping &&
-	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	    PageDcacheDirty(page)) {
 		tx49_flush_dcache_page_impl(page);
 
 		ClearPageDcacheDirty(page);

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
