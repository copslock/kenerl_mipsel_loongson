Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2007 18:39:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:21962 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024664AbXIHRi5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Sep 2007 18:38:57 +0100
Received: from localhost (p5230-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6DB35C663; Sun,  9 Sep 2007 02:38:51 +0900 (JST)
Date:	Sun, 09 Sep 2007 02:40:20 +0900 (JST)
Message-Id: <20070909.024020.61508994.anemo@mba.ocn.ne.jp>
To:	technoboy85@gmail.com
Cc:	linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, nico@openwrt.org, ralf@linux-mips.org,
	openwrt-devel@lists.openwrt.org, akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200709080218.50236.technoboy85@gmail.com>
References: <200709080143.12345.technoboy85@gmail.com>
	<200709080218.50236.technoboy85@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 8 Sep 2007 02:18:49 +0200, Matteo Croce <technoboy85@gmail.com> wrote:
> Support for memory mapping, clock and the vlynq bus

Just some random comments.

> diff --git a/arch/mips/ar7/Makefile b/arch/mips/ar7/Makefile
> new file mode 100644
> index 0000000..e6ba02c
> --- /dev/null
> +++ b/arch/mips/ar7/Makefile
> @@ -0,0 +1,13 @@
> +
> +obj-y := \
> +	prom.o \
> +	setup.o \
> +	memory.o \
> +	irq.o \
> +	time.o \
> +	platform.o \
> +	gpio.o \
> +	clock.o \
> +	vlynq.o
> +
> +EXTRA_AFLAGS := $(CFLAGS)

This EXTRA_AFLAGS line is redundant.  You can drop it safely.

> diff --git a/arch/mips/ar7/irq.c b/arch/mips/ar7/irq.c
> new file mode 100644
> index 0000000..f131301
> --- /dev/null
> +++ b/arch/mips/ar7/irq.c
...
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>

No need to include <linux/irq.h>

> +#define REG(addr) (*(volatile u32 *)(KSEG1ADDR(AR7_REGS_IRQ) + addr))

You can remove this "volatile" rewriting something like:

#define REG_RD(addr) \
	readl((void __iomem *)(KSEG1ADDR(AR7_REGS_IRQ) + (addr)))
#define REG_WR(val, addr) \
	writel(val, (void __iomem *)(KSEG1ADDR(AR7_REGS_IRQ) + (addr)))

> +static struct irq_chip ar7_irq_type = {
> +	.typename = "AR7",

The typename is obsolete and not needed if you have name field.

> +static void ar7_unmask_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	/* enable the interrupt channel  bit */
> +	REG(ESR_OFFSET(irq)) = 1 << ((irq - ar7_irq_base) % 32);
> +	local_irq_restore(flags);
> +}
> +
> +static void ar7_mask_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	/* disable the interrupt channel bit */
> +	REG(ECR_OFFSET(irq)) = 1 << ((irq - ar7_irq_base) % 32);
> +	local_irq_restore(flags);
> +}
> +
> +static void ar7_unmask_secondary_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	/* enable the interrupt channel  bit */
> +	REG(SEC_ESR_OFFSET) = 1 << (irq - ar7_irq_base - 40);
> +	local_irq_restore(flags);
> +}
> +
> +static void ar7_mask_secondary_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	/* disable the interrupt channel bit */
> +	REG(SEC_ECR_OFFSET) = 1 << (irq - ar7_irq_base - 40);
> +	local_irq_restore(flags);
> +}

The mask, unmask routines are always called irq disabled.  So you can
drop these local_irqsave/restore pairs.

> +	for (i = 0; i < 40; i++) {
> +		REG(CHNL_OFFSET(i)) = i;
> +		/* Primary IRQ's */
> +		irq_desc[i + base].status = IRQ_DISABLED;
> +		irq_desc[i + base].action = NULL;
> +		irq_desc[i + base].depth = 1;
> +		irq_desc[i + base].chip = &ar7_irq_type;
> +		/* Secondary IRQ's */
> +		if (i < 32) {
> +			irq_desc[i + base + 40].status = IRQ_DISABLED;
> +			irq_desc[i + base + 40].action = NULL;
> +			irq_desc[i + base + 40].depth = 1;
> +			irq_desc[i + base + 40].chip = &ar7_secondary_irq_type;
> +		}
> +	}

Use set_irq_chip() or its variants instead of touching irq_desc[]
directly.  It seems this platform can set GENERIC_HARDIRQS_NO__DO_IRQ
in Kconfig, using handle_level_irq irq handler.

> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int pending = read_c0_status() & read_c0_cause();
> +	if (pending & STATUSF_IP7)		/* cpu timer */
> +		do_IRQ(7);
> +	else if (pending & STATUSF_IP2)		/* int0 hardware line */
> +		do_IRQ(2);
> +	else
> +		spurious_interrupt();
> +}

It would be safer to mask 'pending' with ST0_IM.

> diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
> new file mode 100644
> index 0000000..0437f65
...
> +/* from adm5120/prom.c */
> +void prom_printf(char *fmt, ...)
> +{
> +	va_list args;
> +	int l;
> +	char *p, *buf_end;
> +	char buf[1024];
> +
> +	va_start(args, fmt);
> +	l = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf) */
> +	va_end(args);
> +
> +	buf_end = buf + l;
> +
> +	for (p = buf; p < buf_end; p++) {
> +		/* Crude cr/nl handling is better than none */
> +		if (*p == '\n')
> +			prom_putchar('\r');
> +		prom_putchar(*p);
> +	}
> +}

prom_printf() is not used in recent linux-mips.

> diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
> new file mode 100644
> index 0000000..fea75c1
> --- /dev/null
> +++ b/arch/mips/ar7/time.c
...
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/time.h>
> +#include <linux/timex.h>
> +#include <linux/mc146818rtc.h>
> +#include <linux/ptrace.h>
> +#include <linux/hardirq.h>
> +#include <linux/irq.h>
> +#include <linux/cpu.h>
> +#include <asm/time.h>

You do not have to include so many headers.

> diff --git a/arch/mips/ar7/vlynq.c b/arch/mips/ar7/vlynq.c
> new file mode 100644
> index 0000000..dd4796e
> --- /dev/null
> +++ b/arch/mips/ar7/vlynq.c
...
> +struct vlynq_regs {
> +	volatile u32 revision;
> +	volatile u32 control;
> +	volatile u32 status;
> +	volatile u32 int_prio;
> +	volatile u32 int_status;
> +	volatile u32 int_pending;
> +	volatile u32 int_ptr;
> +	volatile u32 tx_offset;
> +	volatile struct vlynq_mapping rx_mapping[4];
> +	volatile u32 chip;
> +	volatile u32 autonego;
> +	volatile u32 unused[6];
> +	volatile u32 int_device[8];
> +} __attribute__ ((packed));

You can drop these volatile, using readl/writel for accessing these
members.

> +static void vlynq_irq_unmask(unsigned int irq)
> +{
> +	volatile u32 val;
> +	struct vlynq_device *dev = irq_desc[irq].chip_data;

This "volatile" should be removed.
Use get_irq_chip_data(irq) instead of using irq_desc[] directly.

> +static void vlynq_irq_mask(unsigned int irq)
> +{
> +	volatile u32 val;

This "volatile" should be removed.

> +static int vlynq_irq_type(unsigned int irq, unsigned int flow_type)
> +{
> +	volatile u32 val;

This "volatile" should be removed.

> +static struct irq_chip vlynq_irq_chip = {
> +	.typename = "VLYNQ",

The typename is obsolete and not needed if you have name field.

> +	for (i = 0; i < PER_DEVICE_IRQS; i++) {
> +		if ((i == dev->local_irq) || (i == dev->remote_irq))
> +			continue;
> +		irq_desc[dev->irq_start + i].status = IRQ_DISABLED;
> +		irq_desc[dev->irq_start + i].action = 0;
> +		irq_desc[dev->irq_start + i].depth = 1;
> +		irq_desc[dev->irq_start + i].chip = &vlynq_irq_chip;
> +		irq_desc[dev->irq_start + i].chip_data = dev;
> +		dev->remote->int_device[i >> 2] = 0;
> +	}

Use set_irq_chip() or its variants.

> +	dev = kmalloc(sizeof(struct vlynq_device), GFP_KERNEL);
> +	if (!dev) {
> +		printk(KERN_ERR "vlynq: failed to allocate device structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	memset(dev, 0, sizeof(struct vlynq_device));

Use kzalloc().

> +int __init vlynq_init(void)

This can be static.

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 6379003..75a46ba 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1075,9 +1075,23 @@ void *set_except_vector(int n, void *addr)
>  
>  	exception_handlers[n] = handler;
>  	if (n == 0 && cpu_has_divec) {
> +#ifdef CONFIG_AR7
> +		/* lui k0, 0x0000 */
> +		*(volatile u32 *)(CAC_BASE+0x200) =
> +				0x3c1a0000 | (handler >> 16);
> +		/* ori k0, 0x0000 */
> +		*(volatile u32 *)(CAC_BASE+0x204) =
> +				0x375a0000 | (handler & 0xffff);
> +		/* jr k0 */
> +		*(volatile u32 *)(CAC_BASE+0x208) = 0x03400008;
> +		/* nop */
> +		*(volatile u32 *)(CAC_BASE+0x20C) = 0x00000000;
> +		flush_icache_range(CAC_BASE+0x200, CAC_BASE+0x210);
> +#else
>  		*(volatile u32 *)(ebase + 0x200) = 0x08000000 |
>  		                                 (0x03ffffff & (handler >> 2));
>  		flush_icache_range(ebase + 0x200, ebase + 0x204);
> +#endif
>  	}
>  	return (void *)old_handler;
>  }

Runtime checking, something like this would be better than ifdef:

	if ((handler ^ (ebase + 4)) & 0xfc000000)
		/* use jr */
		...
	} else {
		/* use j */
		...
	}

---
Atsushi Nemoto
