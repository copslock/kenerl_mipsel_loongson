Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 00:50:29 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7927 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225423AbTJAXu1>;
	Thu, 2 Oct 2003 00:50:27 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h91NoN929739;
	Wed, 1 Oct 2003 16:50:23 -0700
Date: Wed, 1 Oct 2003 16:50:23 -0700
From: Jun Sun <jsun@mvista.com>
To: Craig Mautner <craig.mautner@alumni.ucsd.edu>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: schedule() BUG
Message-ID: <20031001165023.A26517@mvista.com>
References: <JKEMLDJFFLGLICKLLEFJMEEOCOAA.craig.mautner@alumni.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <JKEMLDJFFLGLICKLLEFJMEEOCOAA.craig.mautner@alumni.ucsd.edu>; from craig.mautner@alumni.ucsd.edu on Fri, Sep 12, 2003 at 11:04:16AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 12, 2003 at 11:04:16AM -0700, Craig Mautner wrote:
> We are using mips-linux 2.4.17, gcc 3.2.1 (MontaVista) and crashing in
> schedule():
>
> Unable to handle kernel paging request at virtual address 00000000, epc ==
> 800153c0, ra == 800153c0
> $0 : 00000000 9001f800 0000001b 00000000 0000001a 83f56000 8298f4a0 0000001f
> $8 : 00000001 ffffe2e0 000022e0 00000000 fffffff9 ffffffff 0000000a 00000002
> $16: 00000000 00000000 82af0000 8298f4a0 83f56000 00000000 80008000 00000000
> $24: 82af1dc2 00000002                   82af0000 82af1ef8 82af1ef8 800153c0
> epc  : 800153c0    Not tainted
> 
> The code is:
> 
>     {
>       struct mm_struct *mm = next->mm;
>       struct mm_struct *oldmm = prev->active_mm;
>       if (!mm) {
>            if (next->active_mm) BUG();   <- this is where we crash
>            next->active_mm = oldmm;
>            atomic_inc(&oldmm->mm_count);
>            enter_lazy_tlb(oldmm, next, this_cpu);
>       }
>         .
>         .
>         .
> 
> This seems to happen in our case when 'next' points to 'kswapd' although we
> think it could happen when switching to any kernel task (i.e. those tasks
> with mm==NULL).
> 
> We think the culprit is that we are taking an interrupt and rescheduling
> while at a vulnerable point in 'schedule()'. Interrupts are enabled in line
> 743. If we get an interrupt any time after line 785:
> 
>            next->active_mm = oldmm;
> 
> but before line 806
> 
> 	__schedule_tail()
> 
> completes the swap, the interrupt can force 'schedule()' to be reentered via
> 'ret_from_intr()'.
> 
> If so, 'kswapd's 'active_mm' field will be left non-zero, but 'current' will
> not have been set to point to 'kswapd'. The next time 'schedule()' tries to
> switch to 'kswapd', 'next' points to 'kswapd', and
> 
>         next->mm == NULL
>         next->active_mm != NULL
> 
> which is detected as an invalid state, so we hit the BUG.
> 
> Some questions:
> 	Are we looking at this correctly?
> 	Has anyone ever seen this before?
> 	Is there a published fix?
> 
> Thanks,
> 
> -Craig
> 

This is an known problem.  Please try the attached patch.

On R5432 CPU, there is also an hardware bug which can cause the same
problem.  Please double-check vec3_generic to see if workaround is 
at the beginning of the handler.

BTW, 2.4.17 is an old kernel. You really need to upgrade.

Jun
