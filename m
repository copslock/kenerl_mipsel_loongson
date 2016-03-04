Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 18:47:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14345 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013288AbcCDRr0atEOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 18:47:26 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id F0E2E50BF09FC;
        Fri,  4 Mar 2016 17:47:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 4 Mar 2016 17:47:20 +0000
Received: from localhost (10.100.200.173) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar
 2016 17:47:19 +0000
Date:   Fri, 4 Mar 2016 17:47:18 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>, "Lars
 Persson" <lars.persson@axis.com>, "stable # v4 . 1+"
        <stable@vger.kernel.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, David
 Daney <david.daney@cavium.com>, Huacai Chen <chenhc@lemote.com>, Aneesh Kumar
 K.V <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>, Jerome Marchand
        <jmarchan@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/4] MIPS: Sync icache & dcache in set_pte_at
Message-ID: <20160304174718.GA4468@NP-P-BURTON>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
 <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
 <56D5CDB3.80407@caviumnetworks.com>
 <20160301171940.GA26791@NP-P-BURTON>
 <56D9C95A.5020106@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56D9C95A.5020106@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.173]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52452
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

On Fri, Mar 04, 2016 at 09:43:54AM -0800, David Daney wrote:
> On 03/01/2016 09:19 AM, Paul Burton wrote:
> >On Tue, Mar 01, 2016 at 09:13:23AM -0800, David Daney wrote:
> >>On 02/29/2016 06:37 PM, Paul Burton wrote:
> >>[...]
> >>>@@ -234,6 +237,22 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
> >>>  }
> >>>  #endif
> >>>
> >>>+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >>>+			      pte_t *ptep, pte_t pteval)
> >>>+{
> >>>+	extern void __update_cache(unsigned long address, pte_t pte);
> >>>+
> >>>+	if (!pte_present(pteval))
> >>>+		goto cache_sync_done;
> >>>+
> >>>+	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
> >>>+		goto cache_sync_done;
> >>>+
> >>>+	__update_cache(addr, pteval);
> >>>+cache_sync_done:
> >>>+	set_pte(ptep, pteval);
> >>>+}
> >>>+
> >>
> >>This seems crazy.
> >
> >Perhaps, but also correct...
> >
> >>I don't think any other architecture does this type of work in set_pte_at().
> >
> >Yes they do. As mentioned in the commit message see arm, ia64 or powerpc
> >for architectures that all do the same sort of thing in set_pte_at.
> >
> >>Can you look into finding a better way?
> >
> >Not that I can see.
> >
> >>What if you ...
> >>
> >>
> >>>  /*
> >>>   * (pmds are folded into puds so this doesn't get actually called,
> >>>   * but the define is needed for a generic inline function.)
> >>>@@ -430,15 +449,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >>>
> >>>  extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
> >>>  	pte_t pte);
> >>>-extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
> >>>-	pte_t pte);
> >>>
> >>>  static inline void update_mmu_cache(struct vm_area_struct *vma,
> >>>  	unsigned long address, pte_t *ptep)
> >>>  {
> >>>  	pte_t pte = *ptep;
> >>>  	__update_tlb(vma, address, pte);
> >>>-	__update_cache(vma, address, pte);
> >>
> >>... Reversed the order of these two operations?
> >
> >It would make no difference. The window for the race exists between
> >flush_dcache_page & set_pte_at. update_mmu_cache isn't called until
> >later than set_pte_at, so cannot possibly avoid the race. The commit
> >message walks through where the race exists - I don't think you've read
> >it.
> 
> 
> I think the code that calls set_pte_at() should be fixed.
> 
> If cache maintenance is needed before modifying the page tables, that is
> explicitly done in the calling code.
> 
> In migrate.c (remove_migration_pte, similar in do_swap_page) we have:
>    .
>    .
>    .
> 	flush_dcache_page(new);
> 	set_pte_at(mm, addr, ptep, pte);
>    .
>    .
>    .
> 
> Similar in huge_memory.c (unfreeze_page_vma, freeze_page_vma, etc.)
> 
> The point being, the callers have the knowledge about what is changing and
> should make sure they do the right thing to keep the caches consistent.  The
> job of set_pte_at() is to manipulate the page tables, nothing else.

...but if we do the flush in flush_dcache_page then we abandon the lazy
flushing.

Why do you want MIPS to be different to every other widely used
architecture that has this problem? set_pte_at clearly is not used only
to manipulate page tables, no matter what you might like.

Thanks,
    Paul
