Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GJG3405279
	for linux-mips-outgoing; Thu, 16 Aug 2001 12:16:03 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GJG1j05273
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 12:16:01 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA04761
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 12:15:51 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA26120
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 12:15:54 -0700 (PDT)
Message-ID: <01a001c12688$7fdbbf00$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <018201c12680$8f13e680$0deca8c0@Ulysses>
Subject: Re: FP emulator patch
Date: Thu, 16 Aug 2001 21:20:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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

There is, actually, one conceptual hole in this
scheme (and in every other one we've seen) if the
following scenario occurs.  The current thread does
not own the FPU, the signal handler executes FP
instructions and runs for so long that it gets
switched out.  The thread's FP state will then
become that of the signal handler, and, since the
thread didn't have the FPU when the signal context
was set up, it the pre-signal state will be lost.

>From that standpoint, the old code that saved the
contex if current->used_math was almost correct.
Almost correct, because the naive dump-the-FPU
code is correct only if the FPU belongs to the thread.
If it doesn't, the last saved thead FPU context, and not
the FPU contents, needs to be copied into the signal 
context.  Symmetrically, in restore_sigcontext(), the current 
code restores the FPU if we *owned* the fp prior to the 
signal, but we must likewise restore the thread FPU 
context from the sigcontext if we *didn't* own the FPU, but
the signal handler subsequently acquired it.

The alternative to doing direct sigcontext<->thread context
saves/restores without passing through the FPU would
be to force a fpu context switch on every signal dispatch,
which I find rather inelegant.

I'll see if I can't come up with a new patch that also
takes this into account, but may not have time before
I take off on vacation this weekend...

            Kevin K.
