Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 10:12:19 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:30373 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S20022946AbZDVJMM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 10:12:12 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 1F0AC27400E; Wed, 22 Apr 2009 11:12:08 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 5530E27400D;
	Wed, 22 Apr 2009 11:12:06 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 1A533828D5;
	Wed, 22 Apr 2009 11:15:36 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 4BCBAFF855;
	Wed, 22 Apr 2009 11:15:19 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Philippe Vachon <philippe@cowpig.ca>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
References: <20090422063747.GA2009@cowpig.ca>
Organization: Mandriva
Date:	Wed, 22 Apr 2009 11:15:19 +0200
In-Reply-To: <20090422063747.GA2009@cowpig.ca> (Philippe Vachon's message of "Wed, 22 Apr 2009 02:37:47 -0400")
Message-ID: <m363gxgic8.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Philippe Vachon <philippe@cowpig.ca> writes:

Hi,

> This patch eliminates magic numbers and adds accessors for memory-mapped
> registers. As well, it removes some inline assembly and restructures how
> the early printk code behaves.
>
> Signed-off-by: Philippe Vachon <philippe@cowpig.ca>
> ---
>  arch/mips/include/asm/mach-lemote/loongson2e.h |   60 +++++++++++
>  arch/mips/lemote/lm2e/dbg_io.c                 |  125 ++---------------------
>  arch/mips/lemote/lm2e/prom.c                   |   10 +--
>  arch/mips/lemote/lm2e/reset.c                  |   18 ++--
>  4 files changed, 82 insertions(+), 131 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-lemote/loongson2e.h
>
> diff --git a/arch/mips/include/asm/mach-lemote/loongson2e.h b/arch/mips/include/asm/mach-lemote/loongson2e.h
> new file mode 100644
> index 0000000..82c1a95
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-lemote/loongson2e.h
> @@ -0,0 +1,60 @@
> +/* Accessor functions for the Loongson 2E MMIO registers
> + *
> + * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +#ifndef __ASM_MACH_LEMOTE_LOONGSON2E
> +#define __ASM_MACH_LEMOTE_LOONGSON2E
> +
> +#include <linux/types.h>
> +
> +/* Loongson 2E Control Registers */
> +#define LS2E_REG_BASE		0x1fe00100 /* start of config registers */
> +#define LS2E_GENCFG_REG		(LS2E_REG_BASE + 0x04)
> +
> +#define LS2E_RESET_VECTOR	0x1fc00000 /* this should be obvious! */
> +

Theses are neither Lemote nor 2E specifics. 2E and 2F controllers are
very similar (and they're similar to the bonito stuff). Why do you need
a specific header instead of using the Bonito64.h header for theses
constants ? And if you really want to create it, please rename all to
loongson and remove lemote references as it'll work on 2F and on boards
from ST.

> +/* UART address (16550 -- on the Fulong) */
> +#define LS2E_UART_BASE		0x1fd003f8

It happens to be 0x1fd003f8 but it could have been at a different
address base. For instance, on 2f, depending on the board, there's
0x1ff003f8 and 0x1fd003f8 (I think there's also some board with a
different address than theses but I'm not sure).

> +/* Various system parameters passed from PMON */
> +extern unsigned long bus_clock;
> +extern unsigned long cpu_clock_freq;
> +extern unsigned int memsize, highmemsize;
> +
> +static inline void ls2e_writeb(uint8_t value, unsigned long addr)
> +{
> +	*(volatile uint8_t *)addr = value;
> +}
> +

What about readl/writel and friends ?

[...]

> -void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
> +void prom_putchar(char c)
>  {
> -	u32 divisor;
> -
> -	/* disable interrupts */
> -	UART16550_WRITE(OFS_INTR_ENABLE, 0);
> +	int timeout;
> +	phys_addr_t uart_base = (phys_addr_t)ioremap_nocache(LS2E_UART_BASE, 8);
> +	char reg = ls2e_readb(uart_base + UART_LSR) & UART_LSR_THRE;

hmm... I may be wrong on that but using ioremap looks here looks not a
good idea. This code is called by early_printk so you can end up calling
it very early in the boot process.
Also, you're calling ioremap everytime this function is called. Why
don't you do that only the first time ?

[...]

> diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
> index 099387a..0989d28 100644
> --- a/arch/mips/lemote/lm2e/reset.c
> +++ b/arch/mips/lemote/lm2e/reset.c
> @@ -7,20 +7,22 @@
>   * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
>   * Author: Fuxin Zhang, zhangfx@lemote.com
>   */
> +
>  #include <linux/pm.h>
> +#include <linux/io.h>
> +#include <loongson2e.h>
>  
>  #include <asm/reboot.h>
>  
>  static void loongson2e_restart(char *command)
>  {
> -#ifdef CONFIG_32BIT
> -	*(unsigned long *)0xbfe00104 &= ~(1 << 2);
> -	*(unsigned long *)0xbfe00104 |= (1 << 2);
> -#else
> -	*(unsigned long *)0xffffffffbfe00104 &= ~(1 << 2);
> -	*(unsigned long *)0xffffffffbfe00104 |= (1 << 2);
> -#endif
> -	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
> +	uint32_t ctl =
> +		(ls2e_readl((phys_addr_t)ioremap_nocache(LS2E_GENCFG_REG, 4))
> +		& ~(1 << 2)) | 1 << 2;
> +
> +	ls2e_writel(ctl, (phys_addr_t)ioremap_nocache(LS2E_GENCFG_REG, 4));
> +
> +	((void (*)(void))ioremap_nocache(LS2E_RESET_VECTOR, 4))();

same remark as for the serial stuff. I'm really not sure that calling ioremap
in such a place is a good idea (say, you've panic'ed and booted with
panic=3, will this still work ?).


Arnaud
