Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:23:51 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34923 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041487AbcFIVTET7AWE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:19:04 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7Lq-0005LY-1A; Thu, 09 Jun 2016 21:18:54 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7Ln-0006By-AW; Thu, 09 Jun 2016 14:18:51 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Lars Persson <lars.persson@axis.com>,
        "Steven J . Hill" <sjhill@realitydiluted.com>,
        David Daney <david.daney@cavium.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 098/206] MIPS: Sync icache & dcache in set_pte_at
Date:   Thu,  9 Jun 2016 14:15:07 -0700
Message-Id: <1465507015-23052-99-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 37d22a0d798b5c938b277d32cfd86dc231381342 upstream.

It's possible for pages to become visible prior to update_mmu_cache
running if a thread within the same address space preempts the current
thread or runs simultaneously on another CPU. That is, the following
scenario is possible:

    CPU0                            CPU1

    write to page
    flush_dcache_page
    flush_icache_page
    set_pte_at
                                    map page
    update_mmu_cache

If CPU1 maps the page in between CPU0's set_pte_at, which marks it valid
& visible, and update_mmu_cache where the dcache flush occurs then CPU1s
icache will fill from stale data (unless it fills from the dcache, in
which case all is good, but most MIPS CPUs don't have this property).
Commit 4d46a67a3eb8 ("MIPS: Fix race condition in lazy cache flushing.")
attempted to fix that by performing the dcache flush in
flush_icache_page such that it occurs before the set_pte_at call makes
the page visible. However it has the problem that not all code that
writes to pages exposed to userland call flush_icache_page. There are
many callers of set_pte_at under mm/ and only 2 of them do call
flush_icache_page. Thus the race window between a page becoming visible
& being coherent between the icache & dcache remains open in some cases.

To illustrate some of the cases, a WARN was added to __update_cache with
this patch applied that triggered in cases where a page about to be
flushed from the dcache was not the last page provided to
flush_icache_page. That is, backtraces were obtained for cases in which
the race window is left open without this patch. The 2 standout examples
follow.

When forking a process:

[   15.271842] [<80417630>] __update_cache+0xcc/0x188
[   15.277274] [<80530394>] copy_page_range+0x56c/0x6ac
[   15.282861] [<8042936c>] copy_process.part.54+0xd40/0x17ac
[   15.289028] [<80429f80>] do_fork+0xe4/0x420
[   15.293747] [<80413808>] handle_sys+0x128/0x14c

When exec'ing an ELF binary:

[   14.445964] [<80417630>] __update_cache+0xcc/0x188
[   14.451369] [<80538d88>] move_page_tables+0x414/0x498
[   14.457075] [<8055d848>] setup_arg_pages+0x220/0x318
[   14.462685] [<805b0f38>] load_elf_binary+0x530/0x12a0
[   14.468374] [<8055ec3c>] search_binary_handler+0xbc/0x214
[   14.474444] [<8055f6c0>] do_execveat_common+0x43c/0x67c
[   14.480324] [<8055f938>] do_execve+0x38/0x44
[   14.485137] [<80413808>] handle_sys+0x128/0x14c

These code paths write into a page, call flush_dcache_page then call
set_pte_at without flush_icache_page inbetween. The end result is that
the icache can become corrupted & userland processes may execute
unexpected or invalid code, typically resulting in a reserved
instruction exception, a trap or a segfault.

Fix this race condition fully by performing any cache maintenance
required to keep the icache & dcache in sync in set_pte_at, before the
page is made valid. This has the added bonus of ensuring the cache
maintenance always happens in one location, rather than being duplicated
in flush_icache_page & update_mmu_cache. It also matches the way other
architectures solve the same problem (see arm, ia64 & powerpc).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Cc: Lars Persson <lars.persson@axis.com>
Fixes: 4d46a67a3eb8 ("MIPS: Fix race condition in lazy cache flushing.")
Cc: Steven J. Hill <sjhill@realitydiluted.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12722/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/cacheflush.h |  6 ------
 arch/mips/include/asm/pgtable.h    | 26 +++++++++++++++++++++-----
 arch/mips/mm/cache.c               | 19 +++----------------
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 723229f..176de58 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -51,7 +51,6 @@ extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
 extern void __flush_dcache_page(struct page *page);
-extern void __flush_icache_page(struct vm_area_struct *vma, struct page *page);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_page(struct page *page)
@@ -77,11 +76,6 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
-	if (!cpu_has_ic_fills_f_dc && (vma->vm_flags & VM_EXEC) &&
-	    Page_dcache_dirty(page)) {
-		__flush_icache_page(vma, page);
-		ClearPageDcacheDirty(page);
-	}
 }
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 6bc427f..29a9de2 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -127,10 +127,14 @@ do {									\
 	}								\
 } while(0)
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval);
+
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
 #define pte_none(pte)		(!(((pte).pte_high) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	((pte).pte_low & _PAGE_PRESENT)
+#define pte_no_exec(pte)	((pte).pte_low & _PAGE_NO_EXEC)
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
@@ -148,7 +152,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 			buddy->pte_high |= _PAGE_GLOBAL;
 	}
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -166,6 +169,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 
 #define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
+#define pte_no_exec(pte)	(pte_val(pte) & _PAGE_NO_EXEC)
 
 /*
  * Certain architectures need to do special things when pte's
@@ -218,7 +222,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 #endif
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -234,6 +237,22 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 }
 #endif
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	extern void __update_cache(unsigned long address, pte_t pte);
+
+	if (!pte_present(pteval))
+		goto cache_sync_done;
+
+	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
+		goto cache_sync_done;
+
+	__update_cache(addr, pteval);
+cache_sync_done:
+	set_pte(ptep, pteval);
+}
+
 /*
  * (pmds are folded into puds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
@@ -428,15 +447,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte);
-extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte);
 
 static inline void update_mmu_cache(struct vm_area_struct *vma,
 	unsigned long address, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 	__update_tlb(vma, address, pte);
-	__update_cache(vma, address, pte);
 }
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 0d71fdd..48e8172 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -119,30 +119,17 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 
 EXPORT_SYMBOL(__flush_anon_page);
 
-void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
-{
-	unsigned long addr;
-
-	if (PageHighMem(page))
-		return;
-
-	addr = (unsigned long) page_address(page);
-	flush_data_cache_page(addr);
-}
-EXPORT_SYMBOL_GPL(__flush_icache_page);
-
-void __update_cache(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte)
+void __update_cache(unsigned long address, pte_t pte)
 {
 	struct page *page;
 	unsigned long pfn, addr;
-	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
+	int exec = !pte_no_exec(pte) && !cpu_has_ic_fills_f_dc;
 
 	pfn = pte_pfn(pte);
 	if (unlikely(!pfn_valid(pfn)))
 		return;
 	page = pfn_to_page(pfn);
-	if (page_mapping(page) && Page_dcache_dirty(page)) {
+	if (Page_dcache_dirty(page)) {
 		if (PageHighMem(page))
 			addr = (unsigned long)kmap_atomic(page);
 		else
-- 
2.7.4
