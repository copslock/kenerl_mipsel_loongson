Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6ULiPM13316
	for linux-mips-outgoing; Mon, 30 Jul 2001 14:44:25 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6ULiOV13313
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 14:44:24 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA15257;
	Mon, 30 Jul 2001 14:44:15 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA12486;
	Mon, 30 Jul 2001 14:44:09 -0700 (PDT)
Message-ID: <07f601c11941$6ade3280$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Ralf Baechle" <ralf@uni-koblenz.de>,
   "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>,
   <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010730221944.19618C-100000@delta.ds2.pg.gda.pl>
Subject: Re: [PATCH] wrong use of compute_return_epc() in /mips/kernel/traps.c
Date: Mon, 30 Jul 2001 23:48:35 +0200
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

>  That's why I took the KISS approach.  Current code is cheap and satisfies
> the specs I use, i.e. glibc's info pages.  If anyone needs anything more
> one is free to improve handlers.

The handlers cannot spontaneously generate information known
only to the kernel.

> > I missed the beginning of this thread, but it looks from the
> > patch as if this is really about handling integer overflow
> > exceptions, not FP exceptions.  That's unfortunate.
>
>  The patch is about break and trap instruction handlers, indeed.
>
> > To begin with you are correct in that we should be
> > passing the EPC value at the exception (and certainly not
> > the result  of invoking compute_return_epc(), much less
> > its side effects!), and the state of the BD bit from the
> > Cause register, either abstracted into a variable in the
> > info structure or as a flat-out copy of the Cause register.
>
>  I don't think passing BD is needed here.  Enough information is
> available.  A SIGFPE due to a branch or a jump instruction is impossible.
> Unless you have a chip on fire, in which case problems with signal
> handlers are insignificant.
>
> > I would recommend the former as being less of a security
> > hole.  Yes, we could blow that off and make the user
> > decode for branches himself, but it's tacky. But what's
> > more pernicious is the fact that, being an integer exception,
> > it could have resulted from an overflow of any of the GPRs,
> > including those that will be used by the low-level library
> > code dispatching the signal to the user, and in the generated
> > code of the user's own signal handler.  If we actually want
> > to allow the user to fix the operation and saturate (or whatever)
> > the destination register, enough of the trap context needs
> > to be passed up to the signal handler *and* back down
> > on the signal return to allow that manipulation, followed
> > by a resumption of execution at the instruction following
> > the one that generated the trap.
>
>  Let's just leave it as an excercise to one writing some emulation code.

An excercise much akin to squaring the circle.  Think
about it.  Your program has overflowed on an operation
on a0.  The signal is sent, and your signal routine is called,
trashing a0 with the first argument.  For greater amusement,
assume that the instruction was "add a0, a0, a1" (which
is what could easily happen in a C function that begins
by summing its first two arguments).  I simply do not see
how user level code can determine whether the overflow
was postive or negative without knowlege of the inputs,
and those inputs may well have existed only in the registers.
And even assuming that one could deduce the correct value,
how would you propose patching it back into the execution
stream, particularly in the presence of delayed branches?

> A general-purpose handler in the kernel or libc (which no one will
> probably use) is an overkill and by defining own strict coding rules (be
> it a calling convention, shadow registers or whatever) one can create
> software that suits one's specific needs.

Yeah.  Right.  Shadow registers will allow you to be certain
that you haven't trashed your inputs.  They won't help you
resume execution with a corrected value in the destination
register of the faulting instruction.  I have no problem with
declaring that signals  cannot be used to handle overflow
exceptions.  I do have a problem with falsely pretending to
support such handling. We can decide (for now) that the problem
doesn't need to  be solved.  We can decide to call it a "TODO"
for some time  when we're old and grey.   We can solve it now.
I really don't care.  But it's dishonest to say that the current code
solves it,  even  to a first order of approximation.  To trot out an
overused Einstein quote,

"Everything should be as simple as possible. But not simpler".

            Kevin K.
