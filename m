Received:  by oss.sgi.com id <S553795AbRBHMID>;
	Thu, 8 Feb 2001 04:08:03 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:9630 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553800AbRBHMHz>;
	Thu, 8 Feb 2001 04:07:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA02875;
	Thu, 8 Feb 2001 13:05:12 +0100 (MET)
Date:   Thu, 8 Feb 2001 13:05:12 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Jun Sun <jsun@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <005901c091c3$ab3c9b60$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010208125342.29177I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 8 Feb 2001, Kevin D. Kissell wrote:

> Well, in fact it ends up being both.  The compiler substitutes library
> invocations for FP instructions, one-for-one.

 That's a compiler emulator.  You need to generate special code and place
handlers in libgcc just like it's already being done for integer
operations not supported by a CPU.  I suppose all necessary glue code is
already present in gcc.

> The notion of using libc emulation based on catching SIGFP,
> on the other hand, is so silly that I didn't even understand that
> that's what you were referring to!  It would be an amazing pig,
> and there are corner cases, such as the emulation of the
> instructions in the delay slot of branch-on-floating-condition,
> that would be damned difficult to handle that way.

 How much more difficult than in the kernel?  The kernel needs to take
care of these case as well.  Do you mean we miss certain information that
is available for the kernel in the epc register?  Well, we may always make
the kernel pass it back, if needed. 

 I'm not particularly amazed by the idea, but it's certainly doable.

> > > >  You never want to configure glibc with the --without-fp option.
> > >
> > > That's certainly what we had to do for OpenBSD without FP
> > > emulation!  What is the alternative?
> >
> >  Write one. ;-)
> 
> I don't understand, the alternative to building a --without-fp
> glibc (which Carsten and I did for OpenBSD once already)
> is to write *what*?

 An FP emulator for OpenBSD.  Not that I care much...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
