Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GIjl504302
	for linux-mips-outgoing; Thu, 16 Aug 2001 11:45:47 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GIjUj04293
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 11:45:46 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7GInpA18452;
	Thu, 16 Aug 2001 11:49:52 -0700
Message-ID: <3B7C15A0.2040205@pacbell.net>
Date: Thu, 16 Aug 2001 11:49:04 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
References: <018201c12680$8f13e680$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:
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
> 
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
> 
> The code I sketched last night is essentially correct,
> though it used a macro that doesn't exist.  I attach a
> patch relative to the current OSS repository's signal.c.
> The patch includes the stack frame tweak for the FPU
> emulator that was part of previous patches, but which
> is orthogonal to the problem under discussion.  I have
> built a kernel using this code and run 20 simultaneous
> copies of the MontaVista "stressor" program with no
> problems (though I also had the "v1.5" FPU emulator
> code).

I've lost track of all the patches now :-) Can I trouble you to create a 
complete patch of your arch/mips/math-emu, and whatever other files you've 
modifed, against Ralf's tree?

Pete
