Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2002 13:44:31 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:48578 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225220AbSLPNob>; Mon, 16 Dec 2002 13:44:31 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA02156;
	Mon, 16 Dec 2002 14:44:38 +0100 (MET)
Date: Mon, 16 Dec 2002 14:44:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021214051851.A3756@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021216140604.1430A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 14 Dec 2002, Ralf Baechle wrote:

> >  OCW3 defaults to IRR in our setup (as it does for the chip itself after
> > writing ICWs) -- you need to select ISR explicitly before reading and
> > reset it afterwards to avoid surprises.  Unless we change the default for
> > MIPS, which seems feasible -- we don't have to handle i386 oddities like
> > I/O APICs and weird chipset bugs.  And we avoid the need to grab a
> > spinlock here.  Alpha went this path. 
> 
> We don't have I/O APICs but there's a bunch of MIPS boxes that are based
> on Intel chipsets plus glue logic so we may have to deal with some of the
> same kind of bugs.  And I'd not be surprised if the 8259 VHDL are coming
> from the same source as the x86 ones so because I didn't want to tickle
> the dragon's tail so I simply recycled the x86 code.  Overly defensive?
> Probably.

 Definitely -- the only place the IRR is used is the Neptune (i82378IB/ZB
SIO, i82379AB SIO.A or i82374EB/SB ESC; one or more of them -- the note in
arch/i386/kernel/time.c isn't detailed enough) i8254 core latch
malfunction workaround.  This is needed for do_slow_gettimeoffset(), which
we do not need as we use the processor's internal timer for getting the
offset (or are there any R3k-class systems with an Intel-style chipset?). 
Even if we needed do_slow_gettimeoffset(), I don't think anyone uses any
of these chips in a MIPS system (please correct me if I'm wrong) and the
workaround isn't implemented. 

 Some Alphas do actually use the i82378ZB SIO component, but they use a
processor's internal timer, too so they don't use do_slow_gettimeoffset()
and don't implement the workaround either.

 Surprisingly, there are no known i8259 core implementation bugs. 

 BTW, the workaround probably need not use the IRR -- the Read-Back i8254
command can be used to get the output state.  It's even possible with the
read-back command the latch for the counter would work correctly, so no
workaround would be needed at all.  The code is ancient, though, and
changing it would be tough -- a tester with a buggy system would be
needed. 

> > > +		atomic_inc(&irq_err_count);
> > > +	} else {
> > > +		do_IRQ(irq,regs);
> > 
> >  And how about using an offset passed from a user?  We're not on a PC --
> > i8259 IRQs do not have to start from 0.  E.g. I find cleaner allocating
> > CPU IRQs first if handled.
> 
> There's still ISA drivers out there with hard coded interrupt numbers.
> That's why we assume that ISA / i8259 interrupts are 0 ... 15.  Doesn't
> legacy stuff suck ...

 Ah, I see.

 BTW, I thought on the code a bit and I discovered a few potential
problems due to races.  Handling them depends on the way acks are sent to
i8259s -- Jun, could you please elaborate?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
