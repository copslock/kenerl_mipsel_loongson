Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 13:24:19 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44648 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990492AbdLAMYKsr9Mx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 13:24:10 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131A31596;
        Fri,  1 Dec 2017 04:24:03 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CE893F318;
        Fri,  1 Dec 2017 04:24:01 -0800 (PST)
Date:   Fri, 1 Dec 2017 12:23:59 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
Message-ID: <20171201122356.GR22781@e103592.cambridge.arm.com>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk>
 <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk>
 <20171130172839.GQ22781@e103592.cambridge.arm.com>
 <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <Dave.Martin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Dave.Martin@arm.com
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

On Thu, Nov 30, 2017 at 07:38:25PM +0000, Maciej W. Rozycki wrote:
> Hi Dave,
> 
> > > linux-mips-nt-prfpreg-count.diff
> > > Index: linux-sfr-test/arch/mips/kernel/ptrace.c
> > > ===================================================================
> > > --- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-11-21 22:12:00.000000000 +0000
> > > +++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-11-21 22:13:13.471970000 +0000
> > > @@ -484,7 +484,7 @@ static int fpr_set_msa(struct task_struc
> > >  	int err;
> > >  
> > >  	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
> > > -	for (i = 0; i < NUM_FPU_REGS && *count >= sizeof(elf_fpreg_t); i++) {
> > > +	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> > > 
> > >  		err = user_regset_copyin(pos, count, kbuf, ubuf,
> > >  					 &fpr_val, i * sizeof(elf_fpreg_t),
> > >  					 (i + 1) * sizeof(elf_fpreg_t));
> > 
> > But mips*_regsets[REGSET_FPR].size == sizeof(elf_fpreg_t),
> > linux/kernel/regset.c:ptrace_regset() polices
> > iov_len % regset->size == 0, and each user_regset_copyout() call here
> > transfers sizeof(elf_fpreg_t) bytes, decrementing *count by that
> > amount unless something goest wrong in which case we return.
> 
>  Good point, I missed that check.

Understandable.  If took me a fair while to figure out how the logic
typically works here.

>  I don't think however that re-enforcing in arch code, especially in such 
> a subtle way, a constraint that has already been enforced upstream in 
> generic code is a good idea, because if we ever decide to relax the 
> constraint, then all the arch code will have to be carefully reviewed.
> 
> > If we can't end up with that, then this patch doesn't change ABI-
> > observable behaviour, unless I've missed something.
> 
>  Right, in which case there is no need to backport this change if it is 
> given a go-ahead.
> 
> > If we can end up with that somehow, then this patch reintroduces the
> > issue d614fd58a283 aims to fix, whereby fpr_val can contain
> > uninitialised kernel stack which userspace can then obtain via
> > PTRACE_GETREGSET.
> 
>  That wasn't actually clarified in the referred commit's description, 
> which it should in the first place, and I wasn't able to track down any 
> review of your change as submitted, which would be the potential second 
> source of such support information.  The description isn't even correct, 
> as it states that if a short buffer is supplied, then the old values held 
> in thread's registers are preserved, which clearly isn't correct as 
> individual registers do get written from the beginning of the regset up to 
> the point no more data is available to fill a whole register.

True, the commit message leaves something to be desired here.  This was
one of a bunch of patches applying similar fixes to various arches, so
I pasted the same commit message as a general description for the changes
as a set -- but you're right, it doesn't describe this spefic change
correctly here.  My bad.

>  You are of course right about the (partially) uninitialised variable, and 
> I think there are two ways to address it:
> 
> 1. By preinitialising it, i.e.:
> 
> 	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> 		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
> 		err = user_regset_copyin(pos, count, kbuf, ubuf,
> 					 &fpr_val, i * sizeof(elf_fpreg_t),
> 					 (i + 1) * sizeof(elf_fpreg_t));
> 		if (err)
> 			return err;
> 		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> 	}
> 
>    but that would be an overkill given that we assert that `count' is a 
>    multiple of `sizeof(elf_fpreg_t)'.

Agreed.

Was a partial write to fscr ever supported by this regset?  Your commit
message suggested that my patch may have broken that, but I can't see
how it was ever possible in the first place... unless .size has been
changed for this regset at some point.

If my patch does cause an ABI regression, then it certainly should be
fixed though.

> 2. Actually assert what we rely on having been enforced by generic code, 
>    i.e.:
> 
> 	BUG_ON(*count % sizeof(elf_fpreg_t));
> 	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
> 		err = user_regset_copyin(pos, count, kbuf, ubuf,
> 					 &fpr_val, i * sizeof(elf_fpreg_t),
> 					 (i + 1) * sizeof(elf_fpreg_t));
> 		if (err)
> 			return err;
> 		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> 	}
> 
>    so that a discrepancy between generic code and the arch handler is 
>    caught should it happen.

The important property is that *count is at least sufficient to fill
fpr_val, so that a zero return user_regset_copyin() means fpr_val has
been fully initialised with user data.

So while your check is not wrong

(since *count > 0 && *count % sizeof(elf_fpreg_t) == 0 implies
*count >= sizeof(elf_fpreg_t))

I don't see how this is an improvement on the original check.


Either way, maybe adding a comment to explain the purpose of the check
would be a good idea.

Cheers
---Dave
