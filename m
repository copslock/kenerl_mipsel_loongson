Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Dec 2002 04:19:05 +0000 (GMT)
Received: from p508B6F04.dip.t-dialin.net ([80.139.111.4]:23233 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225264AbSLNETF>; Sat, 14 Dec 2002 04:19:05 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBE4Ipg04870;
	Sat, 14 Dec 2002 05:18:52 +0100
Date: Sat, 14 Dec 2002 05:18:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021214051851.A3756@linux-mips.org>
References: <20021213150853.F22731@mvista.com> <Pine.GSO.3.96.1021214004003.841D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021214004003.841D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sat, Dec 14, 2002 at 01:55:53AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 14, 2002 at 01:55:53AM +0100, Maciej W. Rozycki wrote:

>  OCW3 defaults to IRR in our setup (as it does for the chip itself after
> writing ICWs) -- you need to select ISR explicitly before reading and
> reset it afterwards to avoid surprises.  Unless we change the default for
> MIPS, which seems feasible -- we don't have to handle i386 oddities like
> I/O APICs and weird chipset bugs.  And we avoid the need to grab a
> spinlock here.  Alpha went this path. 

We don't have I/O APICs but there's a bunch of MIPS boxes that are based
on Intel chipsets plus glue logic so we may have to deal with some of the
same kind of bugs.  And I'd not be surprised if the 8259 VHDL are coming
from the same source as the x86 ones so because I didn't want to tickle
the dragon's tail so I simply recycled the x86 code.  Overly defensive?
Probably.

> > +		atomic_inc(&irq_err_count);
> > +	} else {
> > +		do_IRQ(irq,regs);
> 
>  And how about using an offset passed from a user?  We're not on a PC --
> i8259 IRQs do not have to start from 0.  E.g. I find cleaner allocating
> CPU IRQs first if handled.

There's still ISA drivers out there with hard coded interrupt numbers.
That's why we assume that ISA / i8259 interrupts are 0 ... 15.  Doesn't
legacy stuff suck ...

  Ralf
