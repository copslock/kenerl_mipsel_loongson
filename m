Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2009 08:49:17 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:40077 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20807986AbZCHItN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Mar 2009 08:49:13 +0000
Received: (qmail 27698 invoked from network); 8 Mar 2009 09:49:12 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 8 Mar 2009 09:49:12 +0100
Date:	Sun, 8 Mar 2009 09:49:12 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 02/10] Alchemy: Au1300 new interrupt controller
Message-ID: <20090308094912.426c9533@scarran.roarinelk.net>
In-Reply-To: <1236453608.9848.16.camel@kh-d820>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	<788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	<0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	<20090307104932.49408650@scarran.roarinelk.net>
	<1236453608.9848.16.camel@kh-d820>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Sat, 07 Mar 2009 13:20:08 -0600
Kevin Hickey <khickey@rmicorp.com> wrote:

> > > +asmlinkage void plat_irq_dispatch(void)
> > > +{
> > > +	unsigned int intr;
> > > +	u32 bank;
> > > +	u32 reg_msk;
> > > +	unsigned int pending = read_c0_status() & read_c0_cause();
> > > +	/*
> > > +	 * C0 timer tick
> > > +	 */
> > > +	if (pending & CAUSEF_IP7)
> > > +		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
> > > +	else if (pending & (CAUSEF_IP2 | CAUSEF_IP3)) {
> > > +		intr = au_ioread32(&gpio_int->pri_enc);
> > > +		bank = GPINT_BANK_FROM_INT(intr);
> > > +		reg_msk = GPINT_BIT_FROM_INT(bank, intr);
> > > +
> > > +		if (intr != 127) {
> > > +			if (pending & CAUSEF_IP3)
> > > +				board_irq_dispatch(intr);
> > 
> > What is this supposed to do? (missed debug code?)
> board_irq_dispatch (which as I said above should be in a non-devboard
> include) is used to display the IRQ number on the hex LEDs on the DB1300
> board.  I tried to keep it generic so that other boards could do what
> they want or leave it unimplemented and have it optimized out.  The
> CAUSEF_IP3 part is there to not display the timer tick (since it pretty
> much floods out the other IRQ displays).  I should really do that
> segregation in the board_irq_dispatch call; I was pretty focused on my
> board when I wrote this code.

Oh okay. I was wondering about the IP3.
We should probably make a list of all (possible) hooks available into
the alchemy core code (and give them nice prefixed names ;-) )


> > (FWIW, I'm working on getting rid of the explicit CPU-type config
> > options and instead do runtime detection and configuration of
> > dma/dbdma/irq/ and so on).
> 
> Why?  Won't that just lead to a larger kernel binary since it will have
> all of the tables in it?  I would prefer to only compile in the data
> that I need.  Unless I'm missing what you're doing...

All Alchemy chips are more or less identical. Some have different
sd/ddr controller, some have different dma, and some lack peripherals
others do have;  most periperhals have identical mmio addresses across
chip types.

Interestingly even the devboard designers assigned a unique 4bit value
to each board type; with a bit of work you could in theory build one
kernel binary which runs on all of them.

That's what I'm aiming at.

Best regards,
	Manuel Lauss
