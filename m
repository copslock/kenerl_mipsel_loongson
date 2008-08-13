Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 13:59:33 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:11467 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20036895AbYHMM70 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Aug 2008 13:59:26 +0100
Received: (qmail 16477 invoked from network); 13 Aug 2008 14:59:23 +0200
Received: from unknown (HELO scarran) (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 13 Aug 2008 14:59:23 +0200
Date:	Wed, 13 Aug 2008 14:59:21 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: modernize Pb1200 IRQ cascade handling code.
Message-ID: <20080813145921.159b2180@scarran>
In-Reply-To: <48A2D4CB.1030901@ru.mvista.com>
References: <1218568881-3544-2-git-send-email-mano@roarinelk.homelinux.net>
	<48A2D4CB.1030901@ru.mvista.com>
Organization: Private
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, 13 Aug 2008 16:34:19 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:



> > -inline void pb1200_enable_irq(unsigned int irq_nr)
> > +static void pb1200_unmask_irq(unsigned int irq_nr)
> >  {
> >  	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
> >  	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
> >  }
> >  
> > -inline void pb1200_disable_irq(unsigned int irq_nr)
> > +static void pb1200_maskack_irq(unsigned int irq_nr)
> >  {
> >  	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
> >  	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
> >   
> 
>    I wonder what's the difference between int{clr|set} and 
> int{clr|set}_mask registers...

The irq assertion equation in the CPLD is:

int_condition = inten & intmask & int_input_pin;

In theory, the ->startup() and ->shutdown() methods should fiddle with
the enable bits;  the ->mask()/->unmask() methods should modfiy the mask
bits.  In practice, at least on my DB1200, if not BOTH of the enable
and mask bits are cleared, the CPLD triggers tons of spurious
interrupts.  I read through the verilog sources but could not find a
reason for this...


> [...]
> > +	bcsr->int_status = 1 << (irq_nr - PB1200_INT_BEGIN);	/* ack */
> >   
> 
>    The above comment said that writing to this register has no effect on 
> the level-triggered interrupts, so this statement doesn't seem to make 
> sense since you're treating all interrupts as level-triggered below.

They _all_ behave level-triggered, even the ones that should be edge.
Again, looking at the verilog code, no edge detection or similar is
implemented; for instance the SD card insert/eject irqs should
be edge-triggered, but behave differently: the insert irq stays asserted
as long as a card is in the socket, the eject irq is asserted as long
as no card is present.  The PCMCIA carrdetect irqs exhibit identical
behaviour.


> > @@ -113,12 +77,9 @@ static struct irq_chip external_irq_type = {
> >  #ifdef CONFIG_MIPS_DB1200
> >  	.name = "Db1200 Ext",
> >  #endif
> > -	.startup  = pb1200_startup_irq,
> > -	.shutdown = pb1200_shutdown_irq,
> > -	.ack      = pb1200_disable_irq,
> > -	.mask     = pb1200_disable_irq,
> > -	.mask_ack = pb1200_disable_irq,
> > -	.unmask   = pb1200_enable_irq,
> > +	.mask		= pb1200_maskack_irq,
> > +	.mask_ack	= pb1200_maskack_irq,
> >   
> 
>    You can use the same function for the mask() and mask_ack() methods 
> but it only should be masking IRQ, as clearing it doesn't make sense...

It doesn't make a difference in practice, but I'll create a separate
->mask() method without the acking part of the supposedly-edge ints ;-)


> > +	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++)
> > +		set_irq_chip_and_handler_name(irq, &external_irq_type,
> > +					 handle_level_irq, "level");
> >   
> 
>    Are all those IRQs indeed level-triggered?

See above.

Thanks,
	Manuel Lauss
