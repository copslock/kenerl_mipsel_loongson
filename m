Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UMTGR14193
	for linux-mips-outgoing; Mon, 30 Jul 2001 15:29:16 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UMTDV14184
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 15:29:13 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id AAA22038;
	Tue, 31 Jul 2001 00:31:24 +0200 (MET DST)
Date: Tue, 31 Jul 2001 00:31:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>,
   Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] wrong use of compute_return_epc() in /mips/kernel/traps.c
In-Reply-To: <07f601c11941$6ade3280$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010731001101.19618E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 30 Jul 2001, Kevin D. Kissell wrote:

> >  That's why I took the KISS approach.  Current code is cheap and satisfies
> > the specs I use, i.e. glibc's info pages.  If anyone needs anything more
> > one is free to improve handlers.
> 
> The handlers cannot spontaneously generate information known
> only to the kernel.

 I'm not sure what you mean here.  Could you please elaborate?

> An excercise much akin to squaring the circle.  Think
> about it.  Your program has overflowed on an operation
> on a0.  The signal is sent, and your signal routine is called,
> trashing a0 with the first argument.  For greater amusement,
> assume that the instruction was "add a0, a0, a1" (which
> is what could easily happen in a C function that begins
> by summing its first two arguments).  I simply do not see
> how user level code can determine whether the overflow
> was postive or negative without knowlege of the inputs,
> and those inputs may well have existed only in the registers.
> And even assuming that one could deduce the correct value,
> how would you propose patching it back into the execution
> stream, particularly in the presence of delayed branches?

 Sure, you are writing of the general case.  That's not solvable given
current interfaces.

> Yeah.  Right.  Shadow registers will allow you to be certain
> that you haven't trashed your inputs.  They won't help you
> resume execution with a corrected value in the destination
> register of the faulting instruction.  I have no problem with

 It actually depends on how you specify your requirements.

> declaring that signals  cannot be used to handle overflow
> exceptions.  I do have a problem with falsely pretending to
> support such handling. We can decide (for now) that the problem
> doesn't need to  be solved.  We can decide to call it a "TODO"
> for some time  when we're old and grey.   We can solve it now.

 Si_addr in the siginfo struct is specified to contain a faulting
instruction's reference.  My patch fixes the code to fullfill the
specification.  The code was meant to do it already when I submitted it
last year.  Somehow I made a bug and now I'm only fixing it. 

 We do nowhere pretend to support handling of overflow exceptions to the
extent that permits emulating of faulting instructions.  Check the docs,
namely the "Program Error Signals" node of glibc's info pages.  It seems
my handler's example was a bit unfortunate, sigh...

> I really don't care.  But it's dishonest to say that the current code
> solves it,  even  to a first order of approximation.  To trot out an
> overused Einstein quote,
> 
> "Everything should be as simple as possible. But not simpler".

 Yes, sure, we may hardcode a zero here, but what the gain would be? 
Providing a real value instead makes us adhere to the spec, it's only
marginally slower and it may be useful for anything, not only extending
precision.  For example one may print the address involved for user's
(developer's) feedback and abort the affected function only as opposed to
dumping a core.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
