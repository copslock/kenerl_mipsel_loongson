Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 19:55:27 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49148 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225289AbSLQTz1>;
	Tue, 17 Dec 2002 19:55:27 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBHJsus01368;
	Tue, 17 Dec 2002 11:54:56 -0800
Date: Tue, 17 Dec 2002 11:54:56 -0800
From: Jun Sun <jsun@mvista.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021217115456.I11575@mvista.com>
References: <20021216124009.D10178@mvista.com> <Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl> <15871.13866.515311.16388@arsenal.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15871.13866.515311.16388@arsenal.algor.co.uk>; from dom@algor.co.uk on Tue, Dec 17, 2002 at 02:35:22PM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 02:35:22PM +0000, Dominic Sweetman wrote:
> 
> >  The i8259A doesn't work this way.  With your proposed code the IRR
> > is never cleared (which is a problem for edge-triggered interrupts
> > -- such an interrupt gets signalled again once it's unmasked, until
> > deasserted by a device).  The i8259A only clears a bit in the IRR
> > when it receives an ACK (it then copies the bit to the corresponding
> > bit of the ISR) or when an interrupt goes away (a device deasserts
> > it).
> 
> Just a few comments on the hardware:
> 
> As I recall, you can clear a stored edge-triggered interrupt using a
> "specific EOI".  In the 8080 microprocessor for which the 8259 was
> designed, this command was magically communicated to the 8259 when the
> CPU ran its "return from interrupt" instruction.  I think even in the
> 8086 this had to be replaced with an explicit I/O cycle.
> 
> People not using x86 CPUs should consider putting the i8259 into
> "special mask mode".  Then it behaves simply and predictably,
> providing an interrupt on any active unmasked input.  You lose the
> i8259 interrupt priority stuff, but this is only one of the
> advantages.  

This sounds a lot like the doc I read when I did the programming.  Does
anybody know *the doc* I am talking about?  I can't seem to find it anymore.

Meanwhile I find myself cannot answer Maciej's question as to when IRR 
bit is cleared under edge triggering case.  Perhaps the hardware does it 
automatically when IRQ is generated?

I will probe further and reply to you later.

Jun
