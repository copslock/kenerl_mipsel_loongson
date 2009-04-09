Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 15:28:14 +0100 (BST)
Received: from exprod8og101.obsmtp.com ([64.18.3.82]:57510 "HELO
	exprod8og101.obsmtp.com") by ftp.linux-mips.org with SMTP
	id S20032485AbZDIO2E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 15:28:04 +0100
Received: from source ([12.239.216.72]) by exprod8ob101.postini.com ([64.18.7.12]) with SMTP
	ID DSNKSd4F8evXN6EVtIJIq7ERlG+GL4Ddzc0n@postini.com; Thu, 09 Apr 2009 07:28:03 PDT
Received: from 10.8.0.44 ([10.8.0.44]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Thu,  9 Apr 2009 14:27:58 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 09 Apr 2009 09:27:58 -0500
Subject: Re: [PATCH v3 2/5] Alchemy: Au1300 new interrupt controller
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20090409120715.1f53f12c@scarran.roarinelk.net>
References: <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
	 <1239233768-11927-2-git-send-email-khickey@rmicorp.com>
	 <1239233768-11927-3-git-send-email-khickey@rmicorp.com>
	 <20090409120715.1f53f12c@scarran.roarinelk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Thu, 09 Apr 2009 09:27:58 -0500
Message-Id: <1239287278.5812.6.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-04-09 at 12:07 +0200, Manuel Lauss wrote:
> Hi Kevin!
> 
> Some major nits:
> 
> > --- /dev/null
> > +++ b/arch/mips/alchemy/common/gpio_int.c
> > +static struct irq_chip gpio_int_irq_type = {
> > +	.name 		= "Au GPIO/INT",
> > +	.ack		= gpio_int_ack,
> > +	.mask		= gpio_int_mask,
> > +	.unmask		= gpio_int_unmask,
> > +	.mask_ack	= gpio_int_mask_ack
> > +void __init arch_init_irq(void)
> > +{
>  [...]
> > +	for (i = 0; i < nr_basic_irqs; ++i) {
> > +		printk(KERN_DEBUG "Initializing IRQ %d\n",
> > +			basic_irqs[i].number);
> > +		set_pin_cfg(&basic_irqs[i]);
> > +		if (basic_irqs[i].intcfg == LEVEL_LOW)
> > +			set_irq_chip_and_handler_name(
> > +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> > +				&gpio_int_irq_type,
> > +				handle_level_irq,
> > +				"lowlevel");
> > +		else if (basic_irqs[i].intcfg == LEVEL_HIGH)
> > +			set_irq_chip_and_handler_name(
> > +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> > +				&gpio_int_irq_type,
> > +				handle_level_irq,
> > +				"highlevel");
> > +		else if (basic_irqs[i].intcfg == FALLING)
> > +			set_irq_chip_and_handler_name(
> > +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> > +				&gpio_int_irq_type,
> > +				handle_edge_irq,
> > +				"fallingedge");
> > +		else if (basic_irqs[i].intcfg == RISING)
> > +			set_irq_chip_and_handler_name(
> > +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> > +				&gpio_int_irq_type,
> > +				handle_edge_irq,
> > +				"risingedge");
> > +		else if (basic_irqs[i].intcfg == ANY_CHANGE)
> > +			set_irq_chip_and_handler_name(
> > +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> > +				&gpio_int_irq_type,
> > +				handle_edge_irq,
> > +				"bothedge");
> > +		else
> > +			set_irq_chip(
> > +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> > +				&gpio_int_irq_type);
> > +	}
> 
> Please please move this to a irq_chip.set_irq_type hook,  and replace
> LEVEL_LOW and friends with linux' IRQ_TYPE_LEVEL_LOW... constants
> (So one can pass IRQ flags via platform resource information).
> 
> 
> > diff --git a/arch/mips/alchemy/devboards/cascade_irq.c b/arch/mips/alchemy/devboards/cascade_irq.c
> > + * The following must be declared/defined in an included file:
> > + * - volatile struct bcsr_regs (declared)
> > + *   (which much include fields int_status, intset_mask, intclr_mask, intset,
> > + *   and intclr)
> > + * - volatile struct bcsr_regs *const bcsr (defined)
> > + * - CASCADE_IRQ_MIN
> > + * - CASCADE_IRQ_MAX
> > + * - CASCADE_IRQ_TYPE_STRING
> > + * - CASCADE_IRQ (System IRQ to which the cascade is connected)
> > + */
> > +
> > +void __init board_init_irq(void);
> > +
> > +irqreturn_t cascade_handler(int irq, void *dev_id)
> > +{
> > +	u16 int_status = au_ioread16(&db_bcsr->int_status);
> > +	int irq_in_service;
> > +
> > +	au_iowrite16(int_status, &db_bcsr->int_status);
> > +	for ( ; int_status; int_status &= int_status - 1) {
> > +		irq_in_service = CASCADE_IRQ_MIN + __ffs(int_status);
> > +		db_set_hex((u8)(irq_in_service));
> > +		do_IRQ(irq_in_service);
> 
> generic_handle_irq() please,
> 
> 
> > +static unsigned int cascade_startup(unsigned int irq)
> > +{
> > +	int retval = 0;
> > +
> > +	mutex_lock(&cascade_use_count_mutex);
> > +	++cascade_use_count;
> > +	if (cascade_use_count == 1)
> > +		retval = request_irq(CASCADE_IRQ,
> > +				&cascade_handler, 0, "Cascade",
> > +				&cascade_handler);
> 
> Use "set_irq_chained_handler" after registering the cascades and the
> startup/shutdown hooks can go away.
> 
> Also, "cascade" is too generic, maybe call it "db1300cascade". The
> Db1200 too has a cascade but works slightly different (I even doubt it
> makes sense to place this code outside the directory.  As it currently
> is, it's not generic enough to be usable by the Db1200/Pb1200; and
> the code is rather tiny anyway).
> 
To address all of your comments, I wrote this code some time ago and
have not had time to digest some of the changes that have been posted to
the DB1200 interrupt code since then.  I have every intention of finding
some time down the line to revisit this and merge it with the DB1200
cascade code.  The controllers are very similar - in fact in my local
tree I am using this same code on both platforms.

In the interest of time and schedule, I was hoping to have this version
included in 2.6.30 so that I had something to build on for future
updates and something to release other driver and peripheral patches
against.

> (Off topic:  why the 2-stage mask/unmask system [the 'enable' and
> 'mask' bits] I didn't make sense to me on the DB1200 either...)
> 
I'm not really sure either but I can ask the folks responsible for the
CPLD.  My guess is that it is just because traditionally interrupt
controllers have both enables and masks and that's how it was written.

> 
> > +/*
> > + * Set the GPIO to the specified value.  The value must be 0 or 1.  Any other
> > + * value results in a no-op.
> > + *
> > + * This call will implicitly reconfigure the pin to be a GPIO if it is
> > + * configured as a device pin.
> > + */
> > +void set_gpio(u8 gpio, u8 value);
> > +
> > +/*
> > + * Get the value of any GPIO pin (including those controlled by devices).
> > + *
> > + * This will not change the pin configuration
> > + */
> > +u8 get_gpio(u8 gpio);
> > +
> > +#endif /* _GPIO_INT_H */
> > +
> 
> no support for linux' GPIO framework?
Again, at the time I was unaware of any GPIO standards.  I will probably
revise this to use gpiolib or whaterver down the line.
> 

-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
