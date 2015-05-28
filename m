Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 13:53:32 +0200 (CEST)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:34315 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012979AbbE1Lw4OyDLI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 13:52:56 +0200
Received: from /spool/local
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dingel@linux.vnet.ibm.com>;
        Thu, 28 May 2015 12:52:53 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 28 May 2015 12:52:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AD8ED17D8059;
        Thu, 28 May 2015 12:53:45 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4SBqoNR25886934;
        Thu, 28 May 2015 11:52:50 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4S6kQso013638;
        Thu, 28 May 2015 02:46:30 -0400
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t4S6kQYU013617;
        Thu, 28 May 2015 02:46:26 -0400
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 2944)
        id 41DB5122445A; Thu, 28 May 2015 13:52:46 +0200 (CEST)
From:   Dominik Dingel <dingel@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Zhen <zhenzhang.zhang@huawei.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Jason J. Herne" <jjherne@linux.vnet.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/5] s390/hugetlb: remove dead code for sw emulated huge pages
Date:   Thu, 28 May 2015 13:52:36 +0200
Message-Id: <1432813957-46874-5-git-send-email-dingel@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1432813957-46874-1-git-send-email-dingel@linux.vnet.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15052811-0013-0000-0000-0000042AB45F
Return-Path: <dingel@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dingel@linux.vnet.ibm.com
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

We now support only hugepages on hardware with EDAT1 support.
So we remove the prepare/release_hugepage hooks and
simplify set_huge_pte_at and huge_ptep_get.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 arch/s390/include/asm/hugetlb.h |  3 ---
 arch/s390/mm/hugetlbpage.c      | 60 +++--------------------------------------
 2 files changed, 3 insertions(+), 60 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index dfb542a..0130d03 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -37,9 +37,6 @@ static inline int prepare_hugepage_range(struct file *file,
 
 #define arch_clear_hugepage_flags(page)		do { } while (0)
 
-int arch_prepare_hugepage(struct page *page);
-void arch_release_hugepage(struct page *page);
-
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 				  pte_t *ptep)
 {
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index fa6e1bc..999616b 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -80,31 +80,16 @@ static inline pte_t __pmd_to_pte(pmd_t pmd)
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte)
 {
-	pmd_t pmd;
+	pmd_t pmd = __pte_to_pmd(pte);
 
-	pmd = __pte_to_pmd(pte);
-	if (!MACHINE_HAS_HPAGE) {
-		/* Emulated huge ptes loose the dirty and young bit */
-		pmd_val(pmd) &= ~_SEGMENT_ENTRY_ORIGIN;
-		pmd_val(pmd) |= pte_page(pte)[1].index;
-	} else
-		pmd_val(pmd) |= _SEGMENT_ENTRY_LARGE;
+	pmd_val(pmd) |= _SEGMENT_ENTRY_LARGE;
 	*(pmd_t *) ptep = pmd;
 }
 
 pte_t huge_ptep_get(pte_t *ptep)
 {
-	unsigned long origin;
-	pmd_t pmd;
+	pmd_t pmd = *(pmd_t *) ptep;
 
-	pmd = *(pmd_t *) ptep;
-	if (!MACHINE_HAS_HPAGE && pmd_present(pmd)) {
-		origin = pmd_val(pmd) & _SEGMENT_ENTRY_ORIGIN;
-		pmd_val(pmd) &= ~_SEGMENT_ENTRY_ORIGIN;
-		pmd_val(pmd) |= *(unsigned long *) origin;
-		/* Emulated huge ptes are young and dirty by definition */
-		pmd_val(pmd) |= _SEGMENT_ENTRY_YOUNG | _SEGMENT_ENTRY_DIRTY;
-	}
 	return __pmd_to_pte(pmd);
 }
 
@@ -119,45 +104,6 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
-int arch_prepare_hugepage(struct page *page)
-{
-	unsigned long addr = page_to_phys(page);
-	pte_t pte;
-	pte_t *ptep;
-	int i;
-
-	if (MACHINE_HAS_HPAGE)
-		return 0;
-
-	ptep = (pte_t *) pte_alloc_one(&init_mm, addr);
-	if (!ptep)
-		return -ENOMEM;
-
-	pte_val(pte) = addr;
-	for (i = 0; i < PTRS_PER_PTE; i++) {
-		set_pte_at(&init_mm, addr + i * PAGE_SIZE, ptep + i, pte);
-		pte_val(pte) += PAGE_SIZE;
-	}
-	page[1].index = (unsigned long) ptep;
-	return 0;
-}
-
-void arch_release_hugepage(struct page *page)
-{
-	pte_t *ptep;
-
-	if (MACHINE_HAS_HPAGE)
-		return;
-
-	ptep = (pte_t *) page[1].index;
-	if (!ptep)
-		return;
-	clear_table((unsigned long *) ptep, _PAGE_INVALID,
-		    PTRS_PER_PTE * sizeof(pte_t));
-	page_table_free(&init_mm, (unsigned long *) ptep);
-	page[1].index = 0;
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
-- 
2.3.7
