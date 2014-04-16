Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:59:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:55942 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837153AbaDPM6hF1pCh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:58:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 23244DEA29946
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:58:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:58:30 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:58:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 15/39] MIPS: add kmap_noncoherent to wire a cached non-coherent TLB entry
Date:   Wed, 16 Apr 2014 13:53:06 +0100
Message-ID: <1397652810-4336-16-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39822
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
kmap_prot which is then called for both kmap_coherent &
kmap_noncoherent. This will be used by a subsequent patch.

Suggested-by: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
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
index 4fc74c7..c40a194 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -114,7 +114,7 @@ static void __init kmap_coherent_init(void)
 static inline void kmap_coherent_init(void) {}
 #endif
 
-void *kmap_coherent(struct page *page, unsigned long addr)
+static void *kmap_prot(struct page *page, unsigned long addr, pgprot_t prot)
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
+	return kmap_prot(page, addr, PAGE_KERNEL);
+}
+
+void *kmap_noncoherent(struct page *page, unsigned long addr)
+{
+	return kmap_prot(page, addr, PAGE_KERNEL_NC);
+}
+
 void kunmap_coherent(void)
 {
 #ifndef CONFIG_MIPS_MT_SMTC
-- 
1.8.5.3
