Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GIqwM04503
	for linux-mips-outgoing; Thu, 16 Aug 2001 11:52:58 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GIqsj04499
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 11:52:56 -0700
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15XSH7-0003DP-00; Thu, 16 Aug 2001 11:53:49 -0700
Date: Thu, 16 Aug 2001 11:53:49 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
Message-ID: <20010816115349.A12153@nevyn.them.org>
References: <018201c12680$8f13e680$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <018201c12680$8f13e680$0deca8c0@Ulysses>; from kevink@mips.com on Thu, Aug 16, 2001 at 08:23:32PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 08:23:32PM +0200, Kevin D. Kissell wrote:
> As I wrote last night, it looks to me as if FPU context
> management in signals was broken in all versions and
> proposed patches that I've seen.  The way I see it is this:
> 
> If the current thread "owns" the FPU, we need to save the
> FPU state in the sigcontext and restore it on return.  If
> the signal handler uses floating point, it already has the
> FPU, and can do what it wants with it.  If it doesn't use
> the FPU, then we'll save and restore FPU state for
> nothing, but better safe than sorry.  In either case,
> the current thread retains ownership of the FPU.
> There is no reason to muck with the ownership data
> or the Cp0.Status.CU1 enables, apart from the
> questionable bit of enabling it before the FP context
> save in case it wasn't enabled.  I think that should go
> away, but I don't have time to test exhastively.  In
> any case, CU1 should have it's pre-signal state
> going into the signal handler.

This bit sounds fine to me.

> If the current thread does *not* own the FPU, we don't
> need to save the thread FP state. If the signal handler
> does no FP, so much the better, there's nothing to
> be done.   If the signal handler uses FP, it will acquire 
> the FPU by normal means. The FP context will be saved 
> into the thread context of the previous owner, the signalling 
> thread will acquire the FPU, and the signal handler will do 
> it's FP. On return from the signal, we *must* de-allocate the
> FPU and clear the CU1 bit.  If that's done, and the
> thread (which had not *owned* the FPU prior to the
> signal) starts doing FP again, normal mechanisms
> will cause it's FP context to be restored.  If we don't,
> it will start exectuing with a bogus FP context.

No, this is wrong.

 - Current thread has an FPU state saved but does not own the FPU.
 - Signal handler uses FP
 - Acquires FP through a lazy switch
 - (FPU) Context switch occurs while in signal handler.

Where do we put the state now?  We save it in the process's thread
structure, of course.  Overwriting what was there.

If the process has ever used math, the sigcontext must contain a saved
FP state.

current->used_math should never be set to zero in this sort of
situation.  It's not an ownership flag!  It marks whether the FP state
in the thread structure is valid.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
