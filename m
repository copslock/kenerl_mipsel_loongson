Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 11:16:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34910 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492063Ab0AKKQC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2010 11:16:02 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0BAFlu5014692;
        Mon, 11 Jan 2010 11:15:47 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0BAFh7A014690;
        Mon, 11 Jan 2010 11:15:43 +0100
Date:   Mon, 11 Jan 2010 11:15:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc:     Hugh Dickins <hugh.dickins@tiscali.co.uk>,
        linux-mips@linux-mips.org, Carsten Otte <cotte@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhltc@us.ibm.com>,
        Ulrich Drepper <drepper@gmail.com>
Subject: Re: [PATCH] mips,mm: Reinstate move_pte optimization
Message-ID: <20100111101543.GD13886@linux-mips.org>
References: <20091225083305.AA78.A69D9226@jp.fujitsu.com>
 <alpine.LSU.2.00.0912301437420.3369@sister.anvils>
 <20100107151527.8784.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100107151527.8784.A69D9226@jp.fujitsu.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6954

On Thu, Jan 07, 2010 at 03:32:57PM +0900, KOSAKI Motohiro wrote:

> > to include/linux/mm.h - I'd prefer to keep it private if we can.
> > But for completeness, this would involve resurrecting the 2.6.19
> > MIPS move_pte(), which makes sure mremap() move doesn't interfere
> > with our assumptions.  Something like
> > 
> > #define __HAVE_ARCH_MOVE_PTE
> > pte_t move_pte(pte_t pte, pgprot_t prot, unsigned long old_addr,
> >                                          unsigned long new_addr)
> > {
> > 	if (pte_present(pte) && is_zero_pfn(pte_pfn(pte)))
> > 		pte = mk_pte(ZERO_PAGE(new_addr), prot);
> > 	return pte;
> > }
> > 
> > in arch/mips/include/asm/pgtable.h.
> 
> I agree with resurrecting mips move_pte. At least your patch
> passed my cross compile test :)
> 
> Ralf, can you please review following patch?

Looks good.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
