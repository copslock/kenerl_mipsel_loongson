Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2011 16:16:10 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:52102 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903619Ab1J1OQD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2011 16:16:03 +0200
Received: by eye3 with SMTP id 3so4151503eye.36
        for <multiple recipients>; Fri, 28 Oct 2011 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=LBf7UXzJ7pBejJekoEgK3LG20/CVh9pG47iG2thq12c=;
        b=Sxwq/ysc0xnlu6j1apb5c5ywpVontfgtgDovujhu/4UtqwuKTt63rVCT0iiVQJETBV
         THETAIRDcz8KZzXhAz8qeDBBuktTifB6PVkhppAUJomd42qpcRLogSY7uK3gZmecxARu
         3hi0P7sSNe+ISzIS/OVzRfl1hN2RL3sBJcUss=
MIME-Version: 1.0
Received: by 10.216.9.135 with SMTP id 7mr957801wet.100.1319811358236; Fri, 28
 Oct 2011 07:15:58 -0700 (PDT)
Received: by 10.216.167.138 with HTTP; Fri, 28 Oct 2011 07:15:58 -0700 (PDT)
Date:   Fri, 28 Oct 2011 22:15:58 +0800
Message-ID: <CAJd=RBAQpea=wr2Nv6U1yRAH1bwaCvMxpnjfnKdhzAN3mtbK7A@mail.gmail.com>
Subject: [PATCH] MIPS: Keep TLB cache hot while flushing
From:   Hillf Danton <dhillf@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20610

Hi David,

If we only flush the TLB of the given huge page, the TLB cache remains hot for
the relevant mm as it is, and less will be refilled after flush, huge or not.

As always all comments and ideas welcome.

Thanks

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/include/asm/hugetlb.h	Sat May 14 15:21:01 2011
+++ b/arch/mips/include/asm/hugetlb.h	Fri Oct 28 22:08:05 2011
@@ -70,7 +70,7 @@ static inline pte_t huge_ptep_get_and_cl
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
 {
-	flush_tlb_mm(vma->vm_mm);
+	flush_tlb_page(vma, addr & huge_page_mask(hstate_vma(vma)));
 }

 static inline int huge_pte_none(pte_t pte)
