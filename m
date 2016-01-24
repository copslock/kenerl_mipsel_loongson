Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jan 2016 01:08:37 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:57640 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009715AbcAXAIfiCipf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Jan 2016 01:08:35 +0100
Received: by nf.lan (Postfix, from userid 501)
        id 570AC129D9128; Sun, 24 Jan 2016 01:08:34 +0100 (CET)
From:   Felix Fietkau <nbd@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org
Subject: [PATCH] MIPS: fix cache flushing for highmem pages
Date:   Sun, 24 Jan 2016 01:08:34 +0100
Message-Id: <1453594114-98252-1-git-send-email-nbd@openwrt.org>
X-Mailer: git-send-email 2.2.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
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

Most cache flush ops were no-op for highmem pages. This led to nasty
segfaults and (in the case of page_address(page) == NULL) kernel
crashes.

Fix this by always flushing highmem pages using kmap/kunmap_atomic
around the actual cache flush. This might be a bit inefficient, but at
least it's stable.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 arch/mips/mm/cache.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index aab218c..1b20165 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 
 #include <asm/cacheflush.h>
 #include <asm/processor.h>
@@ -78,18 +79,29 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 	return 0;
 }
 
+static void
+flush_highmem_page(struct page *page)
+{
+	void *addr = kmap_atomic(page);
+	flush_data_cache_page((unsigned long)addr);
+	kunmap_atomic(addr);
+}
+
 void __flush_dcache_page(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long addr;
 
-	if (PageHighMem(page))
-		return;
 	if (mapping && !mapping_mapped(mapping)) {
 		SetPageDcacheDirty(page);
 		return;
 	}
 
+	if (PageHighMem(page)) {
+		flush_highmem_page(page);
+		return;
+	}
+
 	/*
 	 * We could delay the flush for the !page_mapping case too.  But that
 	 * case is for exec env/arg pages and those are %99 certainly going to
@@ -105,6 +117,11 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 {
 	unsigned long addr = (unsigned long) page_address(page);
 
+	if (PageHighMem(page)) {
+		flush_highmem_page(page);
+		return;
+	}
+
 	if (pages_do_alias(addr, vmaddr)) {
 		if (page_mapped(page) && !Page_dcache_dirty(page)) {
 			void *kaddr;
@@ -123,8 +140,10 @@ void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
 {
 	unsigned long addr;
 
-	if (PageHighMem(page))
+	if (PageHighMem(page)) {
+		flush_highmem_page(page);
 		return;
+	}
 
 	addr = (unsigned long) page_address(page);
 	flush_data_cache_page(addr);
@@ -142,7 +161,12 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	if (unlikely(!pfn_valid(pfn)))
 		return;
 	page = pfn_to_page(pfn);
-	if (page_mapping(page) && Page_dcache_dirty(page)) {
+	if (!Page_dcache_dirty(page))
+		return;
+
+	if (PageHighMem(page)) {
+		flush_highmem_page(page);
+	} else if (page_mapping(page)) {
 		addr = (unsigned long) page_address(page);
 		if (exec || pages_do_alias(addr, address & PAGE_MASK))
 			flush_data_cache_page(addr);
-- 
2.2.2
