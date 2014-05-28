Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 17:38:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23131 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816207AbaE1PiVbHIIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 May 2014 17:38:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 40E76742CEC5C
        for <linux-mips@linux-mips.org>; Wed, 28 May 2014 16:38:11 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 28 May
 2014 16:38:14 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 28 May 2014 16:38:14 +0100
Received: from pburton-laptop.home (192.168.159.200) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 28 May
 2014 16:38:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 15/39] MIPS: add kmap_noncoherent to wire a cached non-coherent TLB entry
Date:   Wed, 28 May 2014 16:38:07 +0100
Message-ID: <1401291487-4301-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1397652810-4336-16-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-16-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.200]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40287
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

This is identical to kmap_coherent apart from the cache coherency
attribute used for the TLB entry, so kmap_coherent is abstracted to
__kmap_pgprot which is then called for both kmap_coherent &
kmap_noncoherent. This will be used by a subsequent patch.

Suggested-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - s/kmap_prot/__kmap_pgprot/ to avoid clashing with a macro in
    asm/highmem.h
---
 arch/mips/include/asm/cacheflush.h |  6 ++++++
 arch/mips/include/asm/pgtable.h    |  2 ++
 arch/mips/mm/init.c                | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 69468de..e08381a 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -113,6 +113,12 @@ unsigned long run_uncached(void *func);
 
 extern void *kmap_coherent(struct page *page, unsigned long addr);
 extern void kunmap_coherent(void);
+extern void *kmap_noncoherent(struct page *page, unsigned long addr);
+
+static inline void kunmap_noncoherent(void)
+{
+	kunmap_coherent();
+}
 
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 static inline void flush_kernel_dcache_page(struct page *page)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 008324d..539ddd1 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -32,6 +32,8 @@ struct vm_area_struct;
 				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
+				 _PAGE_GLOBAL | _CACHE_CACHABLE_NONCOHERENT)
 #define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (cpu_has_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
 				 _page_cachable_default)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4fc74c7..80ff52e 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -114,7 +114,7 @@ static void __init kmap_coherent_init(void)
 static inline void kmap_coherent_init(void) {}
 #endif
 
-void *kmap_coherent(struct page *page, unsigned long addr)
+static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr, flags, entrylo;
@@ -133,7 +133,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
 #endif
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
-	pte = mk_pte(page, PAGE_KERNEL);
+	pte = mk_pte(page, prot);
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
 	entrylo = pte.pte_high;
 #else
@@ -171,6 +171,16 @@ void *kmap_coherent(struct page *page, unsigned long addr)
 	return (void*) vaddr;
 }
 
+void *kmap_coherent(struct page *page, unsigned long addr)
+{
+	return __kmap_pgprot(page, addr, PAGE_KERNEL);
+}
+
+void *kmap_noncoherent(struct page *page, unsigned long addr)
+{
+	return __kmap_pgprot(page, addr, PAGE_KERNEL_NC);
+}
+
 void kunmap_coherent(void)
 {
 #ifndef CONFIG_MIPS_MT_SMTC
-- 
1.9.3
