Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 17:52:52 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:43919 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8224907AbUJKQwr>; Mon, 11 Oct 2004 17:52:47 +0100
Received: from gateway.junsun.net (c-24-6-204-16.client.comcast.net[24.6.204.16])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2004101116523701400rgvpce>; Mon, 11 Oct 2004 16:52:37 +0000
Received: from gateway.junsun.net (gateway [127.0.0.1])
	by gateway.junsun.net (8.12.8/8.12.8) with ESMTP id i9BGsOTW028866;
	Mon, 11 Oct 2004 09:54:24 -0700
Received: (from jsun@localhost)
	by gateway.junsun.net (8.12.8/8.12.8/Submit) id i9BGsOfq028864;
	Mon, 11 Oct 2004 09:54:24 -0700
Date: Mon, 11 Oct 2004 09:54:24 -0700
From: Jun Sun <jsun@junsun.net>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
Message-ID: <20041011165424.GA28667@gateway.junsun.net>
References: <20041006220936.GA21135@gateway.junsun.net> <20041007.101558.126571743.nemoto@toshiba-tops.co.jp> <20041008194514.GB31533@gateway.junsun.net> <20041009.233810.74756865.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041009.233810.74756865.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Sat, Oct 09, 2004 at 11:38:10PM +0900, Atsushi Nemoto wrote:
> >>>>> On Fri, 8 Oct 2004 12:45:14 -0700, Jun Sun <jsun@junsun.net> said:
> 
> jsun> This problem is apparently bigger than I thought.
> 
> Yes, I agree too!
> 
> jsun> Preemption in the middle FPU manipulation in kernel can cause
> jsun> trouble to above assumptions but we can avoid it by using proper
> jsun> disable_preemption and enable_preemption.
> 
> Yes, it is already done in 2.4 preempt-patch.  Applying them to 2.6 is
> easy.
> 
> jsun> Now we basically face another trouble, i.e., put_user/get_user.
> 
> Yes.  And it is not only for preemptable kernel.  So "let's disable
> CONFIG_PREEMPT for now" can not be workaround :-) And it affects 2.4
> kernel also.
> 
> jsun> Maybe the easy way out is to allow FPU trap in kernel.  What do
> jsun> you think?  The idea sounds dangerous but seems to be OK for the
> jsun> suitations we are discussing here.
> 
> I suppose allowing FPU trap in kernel is too dangerous.  I'm not sure
> it is really OK, and it will make the FPU management somewhat fragile.
> In the past, the "lazy fpu switch" had some bugs which are very hard
> to find and fix.  So I prefer simple and robust approach.
> 

I actually don't see which approach is more "simple and robust".

In terms of being simple, allowing kernel mode FPU trap is definitely simpler.

If you can't find any pitfalls of this approach it is actually robust.
The new FPU code is already greatly simplified.  It is possible
kernel FPU trap is not that evil anymore (assuming kernel continues
voluntarily not using FPU).

Note you will also have additional benefit of not worry about the
the preemption related fix.

It is very easy to try this, do you mind giving it a try and let us
know the results?

> jsun> The other approach is basically your fix.  That is, if we are in
> jsun> the middle of a block FPU manipulations, we ensure we have
> jsun> consistent FPU state after each operation that could potentially
> jsun> switch the current process out.
> 
> jsun> As to where should we put the "if (....) own_fpu()", I think it
> jsun> should be put right after the operation we could be switched
> jsun> out, i.e., get_user()/ put_user() in this case.
> 
> Hmm... in this case, we do NOT need any real FPU in the emulator.  We
> need it to just before restoring FPU reg values from the emulator.
> Obtaining FPU on each get_user/put_user seems to be overkill for me.

I meant you regain FPU owner _after_ the get_user/put_user() call, not
_inside_ them.

> But this is just a style issue.
> 

I think it is easier for other people to understand why you
want to regain FPU if you put it _right_ after a place where people see
the ownership could be lost.  Otherwise, simply adding a code to regain
FPU before you may fault seems rather random.

> And I noticed that my previous patch is not complete.  If context
> switch occur on get_user/put_user in fpu_emulator, 'resume' code will
> overwrite the current fpu context again (which might be already
> modified by fpu emulator).  Calling lose_fpu() explicitly before
> calling the fpu emulator will fix this problem.  The fixed do_fpe
> should be:
> 
> 		save_fp(current);
> 		/* Ensure 'resume' not overwrite saved fp context again. */
> 		lose_fpu();
> 
> 		/* Run the emulator */
> 		sig = fpu_emulator_cop1Handler (0, regs,
> 			&current->thread.fpu.soft);
> 		own_fpu();	/* Using the FPU again.  */
> 

This piece of code seems to make sense.

> jsun> BTW, it is safe to disable preemption before calling anything
> jsun> functions that could potentially block or switch current process
> jsun> out.
> 
> It is safe?  get_user/put_user will fail if preempt disabled.  Excerpt
> from do_page_fault:
> 
> 	/*
> 	 * If we're in an interrupt or have no user
> 	 * context, we must not take the fault..
> 	 */
> 	if (in_atomic() || !mm)
> 		goto bad_area_nosemaphore;
> 

It should be safe.  This might be a bug in kernel.  I bet in_atomic()
is "in_interrupt()" in older version of the code, which seems to be
the correct code.  When you diable preemption you still have a process
context.

I have not read the patch yet.

BTW, have you thought about possibly the third approach, which is to 
somehow isolate the code segment where get_user/put_user could cause
page faults and then make sure all FPU manipulations will succeed?

Thanks for the work.

Jun
