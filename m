Received:  by oss.sgi.com id <S553782AbRBHLZm>;
	Thu, 8 Feb 2001 03:25:42 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:38557 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553773AbRBHLZh>;
	Thu, 8 Feb 2001 03:25:37 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA01475;
	Thu, 8 Feb 2001 12:19:45 +0100 (MET)
Date:   Thu, 8 Feb 2001 12:19:43 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Jun Sun <jsun@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <003901c091bd$33686520$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010208115525.29177E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 8 Feb 2001, Kevin D. Kissell wrote:

> Do you have some numbers to support this?  A proper library
> implementation does *not* trap to the kernel on each FPU
> instruction, and as such is considerably faster (and considerably
> larger - a factor for embedded apps!) than a kernel emulation.

 Now you are writing of a compiler emulation and not a library one.  While
such a solution is reasonable for firmware or other OS-less or even
libc-less environment, its much too painful for normal use.  Either you
lose for real FPU environments due to extra overhead to invoke FPU
operations or you have two sets of incompatible binaries (one that invokes
FPU diractly and the other one with emulator hooks).

> >  You never want to configure glibc with the --without-fp option.
> 
> That's certainly what we had to do for OpenBSD without FP
> emulation!  What is the alternative?

 Write one. ;-)

> That may be true for Alpha, but not for MIPS.  The only
> instructions that can *never* generate an unimplented
> operation trap on a denormalized operand are the
> loads, stores, and moves.  That's why we didn't bother
> breaking up the Algorithmics emulator into with-FPU
> and without-FPU modules - there was surprisingly little
> that could really be left out.

 I dont know the gory details of the Alpha FPU implementation, but from
what I've read, it's denormal handling that needs the emulation.  And all
bits are already present in our generic emulator -- the only glue needed
is mapping of opcodes to FP operations -- see arch/alpha/math-emu/math.c
how its done (the file is "whole" 9kB!). 

 There are no FP-less Alpha parts, though.  And that's not surprising --
the FPU is one of Alpha aces.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
