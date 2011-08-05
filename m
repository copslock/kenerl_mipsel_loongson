Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2011 04:03:03 +0200 (CEST)
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:42919 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491784Ab1HECCv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Aug 2011 04:02:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=dvomlehn@cisco.com; l=6766; q=dns/txt;
  s=iport; t=1312509770; x=1313719370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWQ3IGsTxXll6EdoMu3w9TQ9f0WUpLwujYeJ6WhoINM=;
  b=YQNlyJZM5C1EiesQRncutHRFiCyx1Do4p0bcat+fLIVVS/9vhi+uhN1y
   JVrtnxmtiUKuny4QLbBgRMaiqxmNuL25SEzsg0cLmLesAKsxB1pWLhzcW
   fpCYnWymMWEOvuXpYRDlwUyzco23jQiZMNMlzf3BwOlmZE3KLxSVXfUjT
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAFBOO06rRDoI/2dsb2JhbABDp253gUABAQEBAgESARQTPwULCxguFEk1h0qiIwGeYIVjXwSjew
X-IronPort-AV: E=Sophos;i="4.67,320,1309737600"; 
   d="scan'208";a="9870324"
Received: from mtv-core-3.cisco.com ([171.68.58.8])
  by rcdn-iport-8.cisco.com with ESMTP; 05 Aug 2011 02:02:42 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by mtv-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p7522g53022474;
        Fri, 5 Aug 2011 02:02:42 GMT
Date:   Thu, 4 Aug 2011 22:02:42 -0400
From:   David VomLehn <dvomlehn@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] Pendantic stack backtrace code
Message-ID: <20110805020242.GA23916@dvomlehn-lnx2.corp.sa.net>
References: <20110706233614.GA19332@dvomlehn-lnx2.corp.sa.net> <20110802155759.GA891@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110802155759.GA891@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3771

On Tue, Aug 02, 2011 at 10:57:59AM -0500, Ralf Baechle wrote:
> On Wed, Jul 06, 2011 at 04:36:15PM -0700, David VomLehn wrote:
> 
> > This is the much updated version of the MIPS stack backtrace code submitted
> > a few years ago.
...
> > + * Copyright(C) 2007  Scientific-Atlanta, Inc.
> 
> Shouldn't this now be changed to Cisco?

I don't know whether you can retractively change it, but it should certainly
be Cisco from 2010 on.

> > +/* True if the corresponding MIPS register must be saved before use */
> 
> You mean a callee-saved register?

I do!

> I think this may need a few additions to handle some processor specific
> enhancements such as Cavium's BBIT0 etc. family of branches.

Sounds like a good idea. I think it should be pretty straightforward. Has
anyone besides Cavium added branches?

> > +#ifdef       SPECIAL_SYMBOL
> > +/* arch/mips/kernel/entry.S */
> > +SPECIAL_SYMBOL(ret_from_exception, KERNEL_FRAME_GLUE)
> > +SPECIAL_SYMBOL(ret_from_irq, KERNEL_FRAME_GLUE)
> [...]
> 
> We could modify RESTORE_SOME etc. to automatically generate a table of
> these SPECIAL_SYMBOLs instead of manually maintaining this table?

I'm not sure how to do this with RESTORE_SOME and friends, but using a
macro to build the symbol table by putting it in a special section might
be good. It would also help people who want to modify the code to remember
that the code marking needs to be maintained.

> > diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> > index 37acfa0..6548ae3 100644
> > --- a/arch/mips/kernel/entry.S
> > +++ b/arch/mips/kernel/entry.S
> > @@ -40,9 +40,10 @@ FEXPORT(__ret_from_irq)
> >  	andi	t0, t0, KU_USER
> >  	beqz	t0, resume_kernel
> >  
> > +	.globl	resume_userspace
> >  resume_userspace:
> >  	local_irq_disable		# make sure we dont miss an
> > -					# interrupt setting need_resched
> > +					# interrupt setting _need_resched
> 
> Huh?  The comment should say _TIF_NEED_RESCHED - but that's to long for
> the 80 colums.

Looks like I got a little incautious with vi.

> > index e9b3af2..dbf53b5 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -53,6 +53,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/types.h>
> >  #include <asm/stacktrace.h>
> > +#include <asm/kernel-backtrace.h>
> >  #include <asm/uasm.h>
> >  
> >  extern void check_wait(void);
> > @@ -86,6 +87,8 @@ extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
> >  				    struct mips_fpu_struct *ctx, int has_fpu,
> >  				    void *__user *fault_addr);
> >  
> > +#define MAX_STACK_FRAMES_PRINTED	100
> 
> Is this needed?  The size of the stack should limit the dump naturally and
> the code need some sort of safeguard to protect against running beyond the
> end of the stack anyway.

Good question. There is a case I've seen with from time to time in which
memory corruption causes the stack frame size to be detected to be zero.
So, the frame after the current frame starts where the current frame starts
and the return address is at the same location, and you just loop forever
in your backtrace. Bumping this number to 1000 is fine, just so long as
we are assured of termination in some reasonable timeframe.

> > + * match_short_get_got - checks for a match for short GOT recovery code
> > + * @in_vpc:  Pointer to the &struct vpc for the instruction at which
> > + *           the GOT recovery code may start.
> > + *
> > + * Returns:  true if it matches, zero if it does not.
> > + *
> > + * Matches the code fragment:
> > + *   li      gp,<value>
> > + *   addu    gp, gp, t9
> > + * which is a short version of the code used to recover the GOT (global offset
> > + * table) pointer from the address of the current function.
> 
> But there is no GOT in the kernel??

That's true. We not only use this code for doing kernel backtraces, but
we also backtrace the current task, which will normally be in user space
and have a GOT. (We write out other info that allows us to post-process it
and annotate the stack trace with the corresponding symbols) Doing the
user space backtrace is the primary motivation this code supports ABI
analysis. I'm happy to take this out for general consumption; what are your
thoughts?

> > +/*
> > + * find_return_abi - Find the end of the function by o32 ABI rules.
> > + * @bt:	Pointer to struct base_bt object.
> > + * Returns:	Zero if we found the end of the function, a negative errno value
> > + *		if we could not.
> > + *
> > + * If the function was found, ctx->fn_return will point to the "jr ra"
> > + * instruction, otherwise it will be set to NULL.
> > + * If the function was not found, ctx->fn_return will be set to NULL_REG.
> > + */
> > +static int find_return_abi(struct base_bt_ctx *ctx)
> > +{
> > +	int rc;
> > +	struct vpc vpc;
> > +	mips_instruction op;
> > +
> > +	ctx->fn_return = NULL;
> > +
> > +	/* Scan forward to find the "jr ra" that marks the end
> > +	 * of the current function */
> 
> Not really; gcc may place move part of the code path behind the jr $ra
> even though that violates the O32 ABI spec.  In the kernel this happens
> for do_one_initcall(), mips_display_message() and more.
> 
> And that's generally my concern with this approach - GCC's optimizer is
> becoming very good in the most recent versions.  In in the long run I see
> us forced to go down the DWARF alley but of course the 10, 20% bloat won't
> be popular.

The non-ABI tracing code already handles cases where the return code is
located in the middle of the function. I'll see if I can cover this in the
ABI code, too.

> But if users tell me they like this apprach and in practice it works well
> enough then I'm all for it.
> > +/*
> > + * This handles getting the next kernel stackframe. It checks to see if we are
> > + * in an exception or interrupt frame. If not, we just pass it along to the
> > + * process backtracing.
> > + * @kbt:	Pointer to the struct kernel_bt object
> > + *
> > + * Returns:	KERNEL_BT_END_IN_START_KERNEL The backtrace should stop
> > + *					because the next frame is for
> > + *					start_kernel(), whose memory has
> > + *					probably been freed and overwritten.
> 
> Not sure if it's worth the pain but we could set a flag in free_init_mem so
> kernel_backtrace_next would know if start_kernel is stil available.

If you had a flag, all that means is that you could backtrace to
start_kernel()'s caller, which you already know is kernel_entry. For the
time after free_init_mem, which is much longer than the time from boot
to free_init_mem, you wouldn't be able to do the backtrace. So, I don't
think it's worth it.

>   Ralf

-- 
David VL
