Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 18:28:09 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:8610 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225289AbSLQS2I>; Tue, 17 Dec 2002 18:28:08 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA15504;
	Tue, 17 Dec 2002 19:27:43 +0100 (MET)
Date: Tue, 17 Dec 2002 19:27:42 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <15871.13866.515311.16388@arsenal.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1021217180330.7289D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Dec 2002, Dominic Sweetman wrote:

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

 An EOI command (be it the specific or the non-specific version) is used
to clear a bit in the ISR (unless the AEOI mode is activated; I'm not sure
why Linux doesn't use it as some code could be trimmed down -- probably
due to a historical reason) to permit further interrupts from the
respective input.  But a bit in the ISR is only copied from the IRR upon
an ACK.  Otherwise the i8259A still considers the IRQ pending.

 The EOI command has to arrive at the i8259A bus as a write cycle (i.e. 
with both CS# and WR# active) -- for i8080 and x86 systems a write cycle
to a system-specific location in the I/O address space of these processors
is typically the most convenient way, but memory-mapping is just fine,
too.  Also the i8080 has no "return from interrupt" instruction -- the
usual sequence is "ei; ret" (this is safe as "ei" defers enabling
interrupt acceptance until after the following instruction).  It's
possible there were systems that incorporated additional glue logic for
detecting this sequence of instructions (I haven't met any) and doing
writes to an i8259A, but I wouldn't believe they would be capable of
sending specific EOIs.  Non-specific ones -- certainly, but only for
systems with a single i8259A (you can have up to 9 i8259As per an
i8080/x86 system for 64 IRQ inputs without additional glue logic or
special arrangements).

> People not using x86 CPUs should consider putting the i8259 into
> "special mask mode".  Then it behaves simply and predictably,
> providing an interrupt on any active unmasked input.  You lose the
> i8259 interrupt priority stuff, but this is only one of the
> advantages.  You'd need to be reasonably knowledgeable about the Linux
> interrupt system to make this clean and compatible with the x86
> versions, but then these troubles would be over for ever and you'd be
> a Hero, First Class.

 It shouldn't be necessary for our handling model (but wouldn't hurt
either, even for the i386).  As we use almost unmodified code from the
i386 implementation, there is only a small window when interrupts are
marked "in service" by the i8259As -- mask_and_ack_8259A() sends an EOI to
the chips before dispatching handlers.  As a result there are no masked
interrupts with their ISR bits set.

> Alternatively, many MIPS systems have a hardware feature which enables
> them to generate imitation-x86 interrupt acknowledge cycles, so you
> can keep the 8259s in complete ignorance that they're not being
> controlled by an x86.  

 Do they ever need to "know"? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
