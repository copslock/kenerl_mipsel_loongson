Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GKQeh07960
	for linux-mips-outgoing; Thu, 16 Aug 2001 13:26:40 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GKQbj07957
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 13:26:38 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7GKVKA23927;
	Thu, 16 Aug 2001 13:31:20 -0700
Message-ID: <3B7C2B26.907BC359@mvista.com>
Date: Thu, 16 Aug 2001 13:20:54 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
References: <018201c12680$8f13e680$0deca8c0@Ulysses> <01a001c12688$7fdbbf00$0deca8c0@Ulysses>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > If the current thread does *not* own the FPU, we don't
> > need to save the thread FP state. If the signal handler
> > does no FP, so much the better, there's nothing to
> > be done.   If the signal handler uses FP, it will acquire
> > the FPU by normal means. The FP context will be saved
> > into the thread context of the previous owner, the signalling
> > thread will acquire the FPU, and the signal handler will do
> > it's FP. On return from the signal, we *must* de-allocate the
> > FPU and clear the CU1 bit.  If that's done, and the
> > thread (which had not *owned* the FPU prior to the
> > signal) starts doing FP again, normal mechanisms
> > will cause it's FP context to be restored.  If we don't,
> > it will start exectuing with a bogus FP context.
> 
> There is, actually, one conceptual hole in this
> scheme (and in every other one we've seen) if the
> following scenario occurs.  The current thread does
> not own the FPU, the signal handler executes FP
> instructions and runs for so long that it gets
> switched out.  The thread's FP state will then
> become that of the signal handler, and, since the
> thread didn't have the FPU when the signal context
> was set up, it the pre-signal state will be lost.
> 
> From that standpoint, the old code that saved the
> contex if current->used_math was almost correct.
> Almost correct, because the naive dump-the-FPU
> code is correct only if the FPU belongs to the thread.
> If it doesn't, the last saved thead FPU context, and not
> the FPU contents, needs to be copied into the signal
> context.  Symmetrically, in restore_sigcontext(), the current
> code restores the FPU if we *owned* the fp prior to the
> signal, but we must likewise restore the thread FPU
> context from the sigcontext if we *didn't* own the FPU, but
> the signal handler subsequently acquired it.
> 
> The alternative to doing direct sigcontext<->thread context
> saves/restores without passing through the FPU would
> be to force a fpu context switch on every signal dispatch,
> which I find rather inelegant.
> 
> I'll see if I can't come up with a new patch that also
> takes this into account, but may not have time before
> I take off on vacation this weekend...
> 
>             Kevin K.

Kevin,

The following pseudo code should take care of that bug.


setup_sigcontext():

...

if (owned_fp) ASSERT(current->used_math);	/* my assumption, obvious */

err |= __put_user(owned_fp, &sc->sc_ownedfp);
err |= __put_user(current->used_math, &sc->sc_used_math);

if (owned_math) {
	/* save current FP state to signal context */
	current->used_math = 0;
	/* perhaps some other bits need to be modified etc */
} else if (current->used_math) {
	/* copy FP state from thread structure to signal context */
	current->used_math = 0;
	/* perhaps some other bits need to be modified etc */
}

....

restore_context():

..
__get_user(owned_fp, &sc->sc_ownedfp);
__get_user(&current->used_math, &sc->sc_used_math);

if (owned_fp) ASSERT(current->used_math);	/* my assumption, obvious */

if (owned_fp) {
	restore_fp_context(sc);
	last_task_used_math = current;
} else if (current->used_math) {
	/* copy FP state from signal context to thread structure */
}


(I meant to do that myself, of course, but yeah, yeah, ... :-0)

Jun
