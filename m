Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KM2An11875
	for linux-mips-outgoing; Fri, 20 Apr 2001 15:02:10 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KM24M11871
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 15:02:05 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3KM0Hg07530;
	Fri, 20 Apr 2001 19:00:17 -0300
Date: Fri, 20 Apr 2001 19:00:17 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: IRQ questions
Message-ID: <20010420190017.B7282@bacchus.dhis.org>
References: <3AE081E3.434E9126@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE081E3.434E9126@cotw.com>; from samcconn@cotw.com on Fri, Apr 20, 2001 at 11:37:24AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 20, 2001 at 11:37:24AM -0700, Scott A McConnell wrote:

> In 2.4.0-test 5 the file arch/mips/kernel/irq.c used to be built. Under
> 2.4.3 it no longer is. However, it appears it was renamed to old_irg.c
> and a new irq.c was created. I also noticed that an i8259.c files was
> added at some point. However, it does not seem to match the code that
> was in irq.c.

Not entirely, yet.  The idea is that a board can register a structure
containing information on how to handle an interrupt with the new irq.c
So a board which has PC-style i8259 PICs could call init_i8259_irqs
which in turn would register handlers for the interrupts 0 - 15 which
would be handle in i8259; handler for other interrupts controllers could
be registered also.

> Are there any notes available that explain how to convert from old style
> IRQ's to new?
> What are we suppose to do with the new irq.c which is not being used?

The IRQ changes should be considered work in progress; until the new
interrupt code you should just follow the example given by the many
existing implementations.

> I have a 2.4.3 kernel booting. I copied the old  arch/mips/kernel/irq.c
> to my target directory and changed

One valid solution ...  Still.  We want to eleminate all this code
duplication for no good reason.

> a few other things to get everything to compile. As long as I do not try
> to use a serial port everything seems to be working.  I booted with a
> frame buffer and started X.  The mouse and keyboard worked so some of my
> IRQ's appear to be working.
> 
> When I start the serial port things seem to go fine untile it trys to
> write the port at which point it starts running very slowly. Which is
> what make me think the kernel is being overcome with interrupts.

Or you don't receive interrupts at all.

  Ralf
