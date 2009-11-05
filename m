Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 14:14:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60590 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492347AbZKENOq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 14:14:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5DG8iu018415;
	Thu, 5 Nov 2009 14:16:08 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5DG3kp018412;
	Thu, 5 Nov 2009 14:16:03 +0100
Date:	Thu, 5 Nov 2009 14:16:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	huhb@lemote.com, yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 4/6] [loongson] add basic fuloong2f support
Message-ID: <20091105131603.GA18232@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com> <0f805f7d12c5a7cbcc125ba4a1b70113ec2047a6.1257325319.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f805f7d12c5a7cbcc125ba4a1b70113ec2047a6.1257325319.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 05:05:47PM +0800, Wu Zhangjin wrote:

> diff --git a/arch/mips/loongson/fuloong-2f/irq.c b/arch/mips/loongson/fuloong-2f/irq.c
> new file mode 100644
> index 0000000..22c45fd
> --- /dev/null
> +++ b/arch/mips/loongson/fuloong-2f/irq.c
> @@ -0,0 +1,114 @@
> +/*
> + * Copyright (C) 2007 Lemote Inc.
> + * Author: Fuxin Zhang, zhangfx@lemote.com
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/i8259.h>
> +#include <asm/mipsregs.h>
> +
> +#include <loongson.h>
> +#include <machine.h>
> +
> +#define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
> +#define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
> +#define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
> +#define LOONGSON_UART_IRQ	(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port */
> +#define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
> +
> +#define LOONGSON_INT_BIT_INT0		(1 << 11)
> +#define LOONGSON_INT_BIT_INT1		(1 << 12)
> +
> +static int mach_i8259_irq(void)
> +{
> +	int irq, isr, imr;
> +
> +	irq = -1;
> +
> +	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
> +		imr = inb(0x21) | (inb(0xa1) << 8);
> +		isr = inb(0x20) | (inb(0xa0) << 8);
> +		isr &= ~0x4;	/* irq2 for cascade */
> +		isr &= ~imr;
> +		irq = ffs(isr) - 1;
> +	}

Any reason why you're not using i8259_irq() from <asm/i8259.h> here?
That function not only gets the locking right, it also minimizes the number
of accesses to the i8259 - which even on modern silicon can be stuningly
slow.

> +#if 1
> +	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
> +	printk(KERN_INFO "cs5536 acc latency 0x%x\n", val);
> +	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
> +#endif

Seems like left over debug code?

> +	return;
> +}

And a useless return statement at the end of a void function.

  Ralf
