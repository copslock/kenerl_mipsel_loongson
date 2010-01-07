Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 07:33:16 +0100 (CET)
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:34764 "EHLO
        fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491080Ab0AGGdM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 07:33:12 +0100
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
        by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id o076X18r021159
        (envelope-from kosaki.motohiro@jp.fujitsu.com);
        Thu, 7 Jan 2010 15:33:01 +0900
Received: from smail (m6 [127.0.0.1])
        by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B43045DE4C;
        Thu,  7 Jan 2010 15:32:59 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
        by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FD9245DE4E;
        Thu,  7 Jan 2010 15:32:59 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
        by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id DEB2D1DB803E;
        Thu,  7 Jan 2010 15:32:58 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
        by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 7AB4C1DB804B;
        Thu,  7 Jan 2010 15:32:58 +0900 (JST)
Received: from m108.css.fujitsu.com (m108 [127.0.0.1])
        by m108.s.css.fujitsu.com (Postfix) with ESMTP id BD1A1B6800B;
        Thu,  7 Jan 2010 15:32:57 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.124.100.179])
        by m108.s.css.fujitsu.com (Postfix) with ESMTP id 2574FB6800A;
        Thu,  7 Jan 2010 15:32:57 +0900 (JST)
X-SecurityPolicyCheck-FJ: OK by FujitsuOutboundMailChecker v1.3.1
Received: from KOSANOTE2[10.124.100.179] by KOSANOTE2 (FujitsuOutboundMailChecker v1.3.1/9992[10.124.100.179]); Thu, 07 Jan 2010 15:33:04 +0900 (JST)
From:   KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To:     Hugh Dickins <hugh.dickins@tiscali.co.uk>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Carsten Otte <cotte@de.ibm.com>
Subject: [PATCH] mips,mm: Reinstate move_pte optimization
Cc:     kosaki.motohiro@jp.fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhltc@us.ibm.com>,
        Ulrich Drepper <drepper@gmail.com>
In-Reply-To: <alpine.LSU.2.00.0912301437420.3369@sister.anvils>
References: <20091225083305.AA78.A69D9226@jp.fujitsu.com> <alpine.LSU.2.00.0912301437420.3369@sister.anvils>
Message-Id: <20100107151527.8784.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.50.07 [ja]
Date:   Thu,  7 Jan 2010 15:32:57 +0900 (JST)
X-archive-position: 25527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kosaki.motohiro@jp.fujitsu.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4727

CC to mips folks.

> If something like this or your replacment does go forward,
> then I think that test is better inside the "if (!page->mapping)"
> below.  Admittedly that adds even more mm-dependence here (relying
> on a zero page to have NULL page->mapping); but isn't page_to_pfn()
> one of those functions which is trivial on many configs but expensive
> on some?  Better call it only in the rare case that it's needed.
> 
> Though wouldn't it be even better not to use is_zero_pfn() at all?
> That was convenient in mm/memory.c because it had the pfn or pte right
> at hand, but here a traditional (page == ZERO_PAGE(address)) would be
> more efficient.
> 
> Which would save having to move is_zero_pfn() from mm/memory.c
> to include/linux/mm.h - I'd prefer to keep it private if we can.
> But for completeness, this would involve resurrecting the 2.6.19
> MIPS move_pte(), which makes sure mremap() move doesn't interfere
> with our assumptions.  Something like
> 
> #define __HAVE_ARCH_MOVE_PTE
> pte_t move_pte(pte_t pte, pgprot_t prot, unsigned long old_addr,
>                                          unsigned long new_addr)
> {
> 	if (pte_present(pte) && is_zero_pfn(pte_pfn(pte)))
> 		pte = mk_pte(ZERO_PAGE(new_addr), prot);
> 	return pte;
> }
> 
> in arch/mips/include/asm/pgtable.h.

I agree with resurrecting mips move_pte. At least your patch
passed my cross compile test :)

Ralf, can you please review following patch?


======================================================
Subject: [PATCH] mips,mm: Reinstate move_pte optimization
From: Hugh Dickins <hugh.dickins@tiscali.co.uk>

About three years ago, we removed mips specific move_pte by commit
701dfbc1cb (mm: mremap correct rmap accounting). because it is only
small optimization and it has bug.

However new zero-page thing doesn't have such problem and behavior
consistency of mremap have worth a bit.

This patch reinstate it.

Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Nick Piggin <npiggin@suse.de>
Cc: Carsten Otte <cotte@de.ibm.com>
---
 arch/mips/include/asm/pgtable.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 1854336..6ad2f73 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -387,6 +387,14 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 #endif
 
+#define __HAVE_ARCH_MOVE_PTE
+pte_t move_pte(pte_t pte, pgprot_t prot, unsigned long old_addr, unsigned long new_addr)
+{
+	if (pte_present(pte) && is_zero_pfn(pte_pfn(pte)))
+		pte = mk_pte(ZERO_PAGE(new_addr), prot);
+	return pte;
+}
+
 #include <asm-generic/pgtable.h>
 
 /*
-- 
1.6.5.2
