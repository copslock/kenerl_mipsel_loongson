Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2002 20:40:33 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45049 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225243AbSLPUkc>;
	Mon, 16 Dec 2002 20:40:32 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBGKe9M11516;
	Mon, 16 Dec 2002 12:40:09 -0800
Date: Mon, 16 Dec 2002 12:40:09 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021216124009.D10178@mvista.com>
References: <20021214051851.A3756@linux-mips.org> <Pine.GSO.3.96.1021216140604.1430A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1021216140604.1430A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Dec 16, 2002 at 02:44:38PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 16, 2002 at 02:44:38PM +0100, Maciej W. Rozycki wrote:
> On Sat, 14 Dec 2002, Ralf Baechle wrote:
> 
> > >  OCW3 defaults to IRR in our setup (as it does for the chip itself after
> > > writing ICWs) -- you need to select ISR explicitly before reading and
> > > reset it afterwards to avoid surprises.  Unless we change the default for
> > > MIPS, which seems feasible -- we don't have to handle i386 oddities like
> > > I/O APICs and weird chipset bugs.  And we avoid the need to grab a
> > > spinlock here.  Alpha went this path. 
> >

I actually meant to read IRR.

I had the code for a while.  I remembered I was reading a i8259 programming 
guide which recommands this method (perhaps for that MIPS board, which should
generally apply to other MIPS boards.).  The idea is to read IRR to figure 
out which interrupt you want to service and directly ack it and mask it.

This style fits more or less what we are doing with the rest of IRQ handling.

> > We don't have I/O APICs but there's a bunch of MIPS boxes that are based
> > on Intel chipsets plus glue logic so we may have to deal with some of the
> > same kind of bugs.  And I'd not be surprised if the 8259 VHDL are coming
> > from the same source as the x86 ones so because I didn't want to tickle
> > the dragon's tail so I simply recycled the x86 code.  Overly defensive?
> > Probably.
> 
>  Definitely -- the only place the IRR is used is the Neptune (i82378IB/ZB
> SIO, i82379AB SIO.A or i82374EB/SB ESC; one or more of them -- the note in
> arch/i386/kernel/time.c isn't detailed enough) i8254 core latch
> malfunction workaround.  This is needed for do_slow_gettimeoffset(), which
> we do not need as we use the processor's internal timer for getting the
> offset (or are there any R3k-class systems with an Intel-style chipset?). 

I don't think so.

> Even if we needed do_slow_gettimeoffset(), 

No MIPS boards are using do_slow_gettimeoffset().  We really should get
rid of it.

>  BTW, I thought on the code a bit and I discovered a few potential
> problems due to races.  Handling them depends on the way acks are sent to
> i8259s -- Jun, could you please elaborate?
>

I am not sure which part you are referring to.  The dispatch_i8259_irq() itself
is called from the first-level interrupt handling routine (assembly or in C),
running with interrupt disabled.

When you decide to service an i8259 IRQ, you move on to call do_IRQ(), still
with interrupt disabled.  Pretty early in do_IRQ() we will do an ACK which will
clear the bit in IRR, before possibly later we turn on interrupt again.


Jun
