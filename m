Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 13:50:43 +0000 (GMT)
Received: from p508B5FA1.dip.t-dialin.net ([IPv6:::ffff:80.139.95.161]:18054
	"EHLO p508B5FA1.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225272AbSLQNum>; Tue, 17 Dec 2002 13:50:42 +0000
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:65429 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S868141AbSLQNul>; Tue, 17 Dec 2002 14:50:41 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA09231;
	Tue, 17 Dec 2002 14:39:22 +0100 (MET)
Date: Tue, 17 Dec 2002 14:39:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021216124009.D10178@mvista.com>
Message-ID: <Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 16 Dec 2002, Jun Sun wrote:

> > > >  OCW3 defaults to IRR in our setup (as it does for the chip itself after
> > > > writing ICWs) -- you need to select ISR explicitly before reading and
> > > > reset it afterwards to avoid surprises.  Unless we change the default for
> > > > MIPS, which seems feasible -- we don't have to handle i386 oddities like
> > > > I/O APICs and weird chipset bugs.  And we avoid the need to grab a
> > > > spinlock here.  Alpha went this path. 
> 
> I actually meant to read IRR.

 So the IRQ isn't ACKed within i8259As at this point -- I see.  Anyway you
named your variable "isr", so it's at least confusing. 

> I had the code for a while.  I remembered I was reading a i8259 programming 
> guide which recommands this method (perhaps for that MIPS board, which should
> generally apply to other MIPS boards.).  The idea is to read IRR to figure 
> out which interrupt you want to service and directly ack it and mask it.

 The idea is mostly OK, although I'd do it differently -- see below.  In
addition to derivatives I recommend reading the Intel's i8259A original
datasheet.

> This style fits more or less what we are doing with the rest of IRQ handling.

 But remember the i8259A is alien to MIPS systems -- it was designed with
i8080/i8086 processors in mind.  Specifically the way you handle it now
(no ACK for i8259As) breaks badly with edge-triggered interrupts. 

> > Even if we needed do_slow_gettimeoffset(), 
> 
> No MIPS boards are using do_slow_gettimeoffset().  We really should get
> rid of it.

 I know none does at the moment.  But are you sure there is no system that
would need it and might be supported one day?

> >  BTW, I thought on the code a bit and I discovered a few potential
> > problems due to races.  Handling them depends on the way acks are sent to
> > i8259s -- Jun, could you please elaborate?
> 
> I am not sure which part you are referring to.  The dispatch_i8259_irq() itself
> is called from the first-level interrupt handling routine (assembly or in C),
> running with interrupt disabled.

 I thought an IRQ is already ACKed within i8259As.  Then you could have a
race with interrupt masking if an IRQ was masked just at the moment it
would be ACKed.

> When you decide to service an i8259 IRQ, you move on to call do_IRQ(), still
> with interrupt disabled.  Pretty early in do_IRQ() we will do an ACK which will
> clear the bit in IRR, before possibly later we turn on interrupt again.

 The i8259A doesn't work this way.  With your proposed code the IRR is
never cleared (which is a problem for edge-triggered interrupts -- such an
interrupt gets signalled again once it's unmasked, until deasserted by a
device).  The i8259A only clears a bit in the IRR when it receives an ACK
(it then copies the bit to the corresponding bit of the ISR) or when an
interrupt goes away (a device deasserts it). 

 I understand you may be confused by the Linux nomenclature -- for Linux
an ACK is what for the i8259A an EOI is (and mask_and_ack_8259A() does
send EOIs to the chips under the assumption the causing IRQ is already
ACKed -- see the code).  There is no Linux name for what the i8259A calls
an ACK as Linux basically never sends ACKs to i8259As, because interrupts
arriving from them are ACKed by hardware by the means of INTA cycles
(which assert the INTA# lines of i8259As).  For the i386 there is actually
an exception for the NMI watchdog running in specific obscure
configurations involving an i82489DX discrete APIC where an explicit ACK
is sent by Linux to the master i8259A to deassert the NMI -- can you find
it? ;-) 

 Here is an example (untested) code that I would recommend.  It sends
explicit ACKs to the i8259As, which has the following advantages:

- the priority resolver of the i8259A is respected -- the settings of FNM,
EFNM (sort-of), rotating and SMM are obeyed,

- you get the IRQ number directly out of the i8259As,

- edge-triggered interrupts are handled properly,

- you don't have to mess with the mask.


asmlinkage void dispatch_i8259_irq(struct pt_regs *regs)
{
	int irq, real;

	spin_lock(&i8259A_lock);

	outb(0x0c, 0x20);
	iob();
	/* ACK the IRQ (master). */
	irq = inb(0x20);
	real = (irq & 0x80);
	irq &= 0x7;
	if (!real)
		goto spurious_master;

	if (irq == 2) {
		outb(0x0c, 0xa0);
		iob();
		/* ACK the IRQ (slave). */
		irq = inb(0xa0);
		real = (irq & 0x80);
		irq = (irq & 0x7) + 8;
		if (!real)
			goto spurious_slave;
	}

	spin_unlock(&i8259A_lock);

	do_IRQ(irq, regs);

	return;

spurious_slave:
	/* IRQ 2 was ACKed in the master; send an EOI to clear it. */
	outb(0x62, 0x20);
	iob();
spurious_master:

	spin_unlock(&i8259A_lock);

	printk("spurious 8259A interrupt: IRQ%d.\n", irq);
	atomic_inc(&irq_err_count);
}
	

 Does it work for you?  And what do you think of it?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
