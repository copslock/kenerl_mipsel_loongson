Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7HqoW17026
	for linux-mips-outgoing; Fri, 7 Dec 2001 09:52:50 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB7Hqgo17023
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 09:52:43 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB7GqQu23739;
	Fri, 7 Dec 2001 14:52:26 -0200
Date: Fri, 7 Dec 2001 14:52:26 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Serial Console on Malta broken?
Message-ID: <20011207145225.B17998@dea.linux-mips.net>
References: <1006808755.7860.5.camel@localhost.localdomain> <20011127175420.F29424@dea.linux-mips.net> <1006884537.2037.4.camel@localhost.localdomain> <20011207100937.D1347@dea.linux-mips.net> <1007741762.1387.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1007741762.1387.3.camel@localhost.localdomain>; from marc_karasek@ivivity.com on Fri, Dec 07, 2001 at 11:15:39AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Dec 07, 2001 at 11:15:39AM -0500, Marc Karasek wrote:

> I will try it as soon as I can.  I also did some snooping and found that
> the exception handler was not even getting fired.  It was getting the
> two interrupts (36, 38) but no other "exceptions/interrupts" at all. 
> Even spurious ones...  It looked to me like the i8259 was locked up or
> waiting for something.  I put back in the old stuff.  (Carsten sent me
> the old malta_int.c and a patch file) And that works.
> 
> Just a thought but, in looking at the two codes (old/new) the old one
> seems to be more applicable for an embedded system.  In that it treats
> the interrupt controller as a set of registers.  I know that it really
> is a i8259, but most people will not put a southbridge in there embedded
> design.  They are more likely to have a fpga or asic that handles the
> interrupts.  In using the Malta as a reference design and linux as the
> RTOS it might be better to have the old code for porting.  As it will
> probably be closer to the what the embedded design will be. 

If you're going to use a legacy i8259 interrupt controller it'll almost
certainly reside on ports 0x20 / 0xa0 like the original controllers in
the PC.  Now, from a software point of few the i8259 is a pain in the
lower part of the body so you better stay from it anyway.

Any other interrupt controller can easily be plugged into the interrupt
handling.  Take a look at arch/mips/kernel/i8259.c's structure.  Basically
all it does is filling in a number of entries into the irq_desc[] array
for interrupts 0 to 15, most important for understanding is the
struct hw_interrupt_type i8259A_irq_type.  It contains the name of the
interrupt handler and a bunch of methods to enable, disable etc. an
interrupt.  Almost all the complexity is handled in hardware that way
and code to support a particular interrupt controler is easily reusable,
i8259.c being the primary example.  Another example would be the
Momenco Ocelot which mostly uses the RM7000's internal interrupt
controller.

The old code was such a pain in the a** to maintain that removing support
for it was one of the first things I did for 2.5.0 and I won't accept any
patches for 2.4 that use the old style interupt handling for new systems.

  Ralf
