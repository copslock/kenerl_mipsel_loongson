Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 18:19:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3819 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011811AbcCARTrr63f2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 18:19:47 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A987541507476;
        Tue,  1 Mar 2016 17:19:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 17:19:41 +0000
Received: from localhost (10.100.200.175) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 1 Mar
 2016 17:19:41 +0000
Date:   Tue, 1 Mar 2016 17:19:40 +0000
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
Message-ID: <20160301171940.GA26791@NP-P-BURTON>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
 <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
 <56D5CDB3.80407@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <56D5CDB3.80407@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.175]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52386
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

On Tue, Mar 01, 2016 at 09:13:23AM -0800, David Daney wrote:
> On 02/29/2016 06:37 PM, Paul Burton wrote:
> [...]
> >@@ -234,6 +237,22 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
> >  }
> >  #endif
> >
> >+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >+			      pte_t *ptep, pte_t pteval)
> >+{
> >+	extern void __update_cache(unsigned long address, pte_t pte);
> >+
> >+	if (!pte_present(pteval))
> >+		goto cache_sync_done;
> >+
> >+	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
> >+		goto cache_sync_done;
> >+
> >+	__update_cache(addr, pteval);
> >+cache_sync_done:
> >+	set_pte(ptep, pteval);
> >+}
> >+
> 
> This seems crazy.

Perhaps, but also correct...

> I don't think any other architecture does this type of work in set_pte_at().

Yes they do. As mentioned in the commit message see arm, ia64 or powerpc
for architectures that all do the same sort of thing in set_pte_at.

> Can you look into finding a better way?

Not that I can see.

> What if you ...
> 
> 
> >  /*
> >   * (pmds are folded into puds so this doesn't get actually called,
> >   * but the define is needed for a generic inline function.)
> >@@ -430,15 +449,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >
> >  extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
> >  	pte_t pte);
> >-extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
> >-	pte_t pte);
> >
> >  static inline void update_mmu_cache(struct vm_area_struct *vma,
> >  	unsigned long address, pte_t *ptep)
> >  {
> >  	pte_t pte = *ptep;
> >  	__update_tlb(vma, address, pte);
> >-	__update_cache(vma, address, pte);
> 
> ... Reversed the order of these two operations?

It would make no difference. The window for the race exists between
flush_dcache_page & set_pte_at. update_mmu_cache isn't called until
later than set_pte_at, so cannot possibly avoid the race. The commit
message walks through where the race exists - I don't think you've read
it.

Thanks,
    Paul
