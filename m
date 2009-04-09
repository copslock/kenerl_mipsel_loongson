Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 11:07:27 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:61150 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20028879AbZDIKHU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 11:07:20 +0100
Received: (qmail 31359 invoked from network); 9 Apr 2009 12:07:18 +0200
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 9 Apr 2009 12:07:18 +0200
Date:	Thu, 9 Apr 2009 12:07:15 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH v3 2/5] Alchemy: Au1300 new interrupt controller
Message-ID: <20090409120715.1f53f12c@scarran.roarinelk.net>
In-Reply-To: <1239233768-11927-3-git-send-email-khickey@rmicorp.com>
References: <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
	<1239233768-11927-2-git-send-email-khickey@rmicorp.com>
	<1239233768-11927-3-git-send-email-khickey@rmicorp.com>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Kevin!

Some major nits:

> --- /dev/null
> +++ b/arch/mips/alchemy/common/gpio_int.c
> +static struct irq_chip gpio_int_irq_type = {
> +	.name 		= "Au GPIO/INT",
> +	.ack		= gpio_int_ack,
> +	.mask		= gpio_int_mask,
> +	.unmask		= gpio_int_unmask,
> +	.mask_ack	= gpio_int_mask_ack
> +void __init arch_init_irq(void)
> +{
 [...]
> +	for (i = 0; i < nr_basic_irqs; ++i) {
> +		printk(KERN_DEBUG "Initializing IRQ %d\n",
> +			basic_irqs[i].number);
> +		set_pin_cfg(&basic_irqs[i]);
> +		if (basic_irqs[i].intcfg == LEVEL_LOW)
> +			set_irq_chip_and_handler_name(
> +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> +				&gpio_int_irq_type,
> +				handle_level_irq,
> +				"lowlevel");
> +		else if (basic_irqs[i].intcfg == LEVEL_HIGH)
> +			set_irq_chip_and_handler_name(
> +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> +				&gpio_int_irq_type,
> +				handle_level_irq,
> +				"highlevel");
> +		else if (basic_irqs[i].intcfg == FALLING)
> +			set_irq_chip_and_handler_name(
> +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> +				&gpio_int_irq_type,
> +				handle_edge_irq,
> +				"fallingedge");
> +		else if (basic_irqs[i].intcfg == RISING)
> +			set_irq_chip_and_handler_name(
> +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> +				&gpio_int_irq_type,
> +				handle_edge_irq,
> +				"risingedge");
> +		else if (basic_irqs[i].intcfg == ANY_CHANGE)
> +			set_irq_chip_and_handler_name(
> +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> +				&gpio_int_irq_type,
> +				handle_edge_irq,
> +				"bothedge");
> +		else
> +			set_irq_chip(
> +				basic_irqs[i].number + GPINT_LINUX_IRQ_OFFSET,
> +				&gpio_int_irq_type);
> +	}

Please please move this to a irq_chip.set_irq_type hook,  and replace
LEVEL_LOW and friends with linux' IRQ_TYPE_LEVEL_LOW... constants
(So one can pass IRQ flags via platform resource information).


> diff --git a/arch/mips/alchemy/devboards/cascade_irq.c b/arch/mips/alchemy/devboards/cascade_irq.c
> + * The following must be declared/defined in an included file:
> + * - volatile struct bcsr_regs (declared)
> + *   (which much include fields int_status, intset_mask, intclr_mask, intset,
> + *   and intclr)
> + * - volatile struct bcsr_regs *const bcsr (defined)
> + * - CASCADE_IRQ_MIN
> + * - CASCADE_IRQ_MAX
> + * - CASCADE_IRQ_TYPE_STRING
> + * - CASCADE_IRQ (System IRQ to which the cascade is connected)
> + */
> +
> +void __init board_init_irq(void);
> +
> +irqreturn_t cascade_handler(int irq, void *dev_id)
> +{
> +	u16 int_status = au_ioread16(&db_bcsr->int_status);
> +	int irq_in_service;
> +
> +	au_iowrite16(int_status, &db_bcsr->int_status);
> +	for ( ; int_status; int_status &= int_status - 1) {
> +		irq_in_service = CASCADE_IRQ_MIN + __ffs(int_status);
> +		db_set_hex((u8)(irq_in_service));
> +		do_IRQ(irq_in_service);

generic_handle_irq() please,


> +static unsigned int cascade_startup(unsigned int irq)
> +{
> +	int retval = 0;
> +
> +	mutex_lock(&cascade_use_count_mutex);
> +	++cascade_use_count;
> +	if (cascade_use_count == 1)
> +		retval = request_irq(CASCADE_IRQ,
> +				&cascade_handler, 0, "Cascade",
> +				&cascade_handler);

Use "set_irq_chained_handler" after registering the cascades and the
startup/shutdown hooks can go away.

Also, "cascade" is too generic, maybe call it "db1300cascade". The
Db1200 too has a cascade but works slightly different (I even doubt it
makes sense to place this code outside the directory.  As it currently
is, it's not generic enough to be usable by the Db1200/Pb1200; and
the code is rather tiny anyway).

(Off topic:  why the 2-stage mask/unmask system [the 'enable' and
'mask' bits] I didn't make sense to me on the DB1200 either...)



> +/*
> + * Set the GPIO to the specified value.  The value must be 0 or 1.  Any other
> + * value results in a no-op.
> + *
> + * This call will implicitly reconfigure the pin to be a GPIO if it is
> + * configured as a device pin.
> + */
> +void set_gpio(u8 gpio, u8 value);
> +
> +/*
> + * Get the value of any GPIO pin (including those controlled by devices).
> + *
> + * This will not change the pin configuration
> + */
> +u8 get_gpio(u8 gpio);
> +
> +#endif /* _GPIO_INT_H */
> +

no support for linux' GPIO framework?


Thanks!
	Manuel Lauss
