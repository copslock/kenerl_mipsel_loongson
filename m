Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14K5tV30992
	for linux-mips-outgoing; Mon, 4 Feb 2002 12:05:55 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14K5jA30793;
	Mon, 4 Feb 2002 12:05:45 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g14J1aB11076;
	Mon, 4 Feb 2002 11:01:36 -0800
Message-ID: <3C5EDB08.B4F2FF7B@mvista.com>
Date: Mon, 04 Feb 2002 11:03:36 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
References: <Pine.GSO.3.96.1020204101743.5750B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Sun, 3 Feb 2002, Ralf Baechle wrote:
> 
> > >  Hmm, the assumption might be justifiable for the i386 only?  Shouldn't
> > > i8259.c be fixed instead?
> >
> > These are the ISA interrupts; many drivers make assumptions about the
> > interrupts numbers, so we can't really change the numbers anyway.  For
> > any non-ISA interrupt it's number can be choosen freely.
> 
>  I don't think such assumptions are sane even for the i386 -- an I/O APIC
> system is free to route ISA interrupts to whichever I/O APIC inputs are
> available, not necessarily the low 16.  The Intel MP Spec explicitly
> allows such a setup -- ISA interrupts are only tied in default
> configurations, which are rarely used (probably not at all these days).
> 
>  Anyway, only the drivers that read an IRQ number from jumpers or Flash
> memory need to be checked, and these are a minority (3Com Ethernet cards
> and possibly very few others).  These that do probing (with probe_irq) or
> simply take the number from an option will work automatically.
> 
>  While I agree for 2.4 it might be not the best idea to do such changes,
> for 2.5 it's worth considering, isn't it?
> 

This patch is from me.  It merely reflects a change of the irq base mapping
from 0x20 to 0x0.  I think someone did this change for Malta board.

A better solution is to have init_i8259_irqs() take an argument that is the
base IRQ number, like many other irq controller code do.  This way it is a
board level decision as what block of IRQs i8259 should use.

Jun
