Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 15:48:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2731 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037585AbWLGPsd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 15:48:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB7FmVVq009033;
	Thu, 7 Dec 2006 15:48:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB7FmUYq009032;
	Thu, 7 Dec 2006 15:48:30 GMT
Date:	Thu, 7 Dec 2006 15:48:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add STB810 support (Philips PNX8550-based)
Message-ID: <20061207154830.GB4156@linux-mips.org>
References: <20061207182234.83212939.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207182234.83212939.vitalywool@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 07, 2006 at 06:22:34PM +0300, Vitaly Wool wrote:

> Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/Makefile
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/philips/pnx8550/stb810/Makefile	2006-12-07 18:21:04.000000000 +0300
> @@ -0,0 +1,4 @@
> +
> +# Makefile for the Philips STB810 Board.
> +
> +lib-y := prom_init.o board_setup.o irqmap.o
> Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/board_setup.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/philips/pnx8550/stb810/board_setup.c	2006-12-07 18:21:04.000000000 +0300
> @@ -0,0 +1,56 @@
> +/*
> + *  STB810 specific board startup routines.
> + *
> + *  Based on the arch/mips/philips/pnx8550/jbs/board_setup.c
> + *
> + *  Author: MontaVista Software, Inc.
> + *          source@mvista.com
> + *
> + *  Copyright 2005 MontaVista Software Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License as published by the
> + *  Free Software Foundation; either version 2 of the License, or (at your
> + *  option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/ioport.h>
> +#include <linux/mm.h>
> +#include <linux/console.h>
> +#include <linux/mc146818rtc.h>
> +#include <linux/delay.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/bootinfo.h>
> +#include <asm/irq.h>
> +#include <asm/mipsregs.h>
> +#include <asm/reboot.h>
> +#include <asm/pgtable.h>
> +
> +#include <glb.h>
> +
> +/* CP0 hazard avoidance. */
> +#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
> +				     "nop; nop; nop; nop; nop; nop;\n\t" \
> +				     ".set reorder\n\t")
> +
> +void __init board_setup(void)
> +{
> +	unsigned long config0, configpr;
> +
> +	config0 = read_c0_config();
> +
> +	/* clear all three cache coherency fields */
> +	config0 &= ~(0x7 | (7<<25) | (7<<28));
> +	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
> +			(CONF_CM_DEFAULT<<28));
> +	write_c0_config(config0);
> +	BARRIER;
> +
> +	configpr = read_c0_config7();
> +	configpr |= (1<<19); /* enable tlb */
> +	write_c0_config7(configpr);
> +	BARRIER;
> +}

You really need that hazard barrier?

Chances are you can get away without a hazard barrier I guess.

> Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/irqmap.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/philips/pnx8550/stb810/irqmap.c	2006-12-07 18:21:04.000000000 +0300

> +char irq_tab_jbs[][5] __initdata = {
> + [8] =  { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
> + [9] =  { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
> + [10] = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},

Coding style, indent with tabs.

> Index: linux-mips.git/arch/mips/kernel/head.S
> ===================================================================
> --- linux-mips.git.orig/arch/mips/kernel/head.S	2006-12-07 18:20:47.000000000 +0300
> +++ linux-mips.git/arch/mips/kernel/head.S	2006-12-07 18:21:04.000000000 +0300
> @@ -138,7 +138,7 @@
>  EXPORT(stext)					# used for profiling
>  EXPORT(_stext)
>  
> -#if defined(CONFIG_QEMU) || defined(CONFIG_MIPS_SIM)
> +#if defined(CONFIG_QEMU) || defined(CONFIG_MIPS_SIM) || defined(CONFIG_PNX8550_STB810)

Your firmware is really so broken it needs this?

> Index: linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig	2006-12-07 18:21:04.000000000 +0300
> @@ -0,0 +1,1777 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.19-rc5
> +# Wed Nov  8 13:46:57 2006
> +#
> +CONFIG_ARM=y

LOL.

Doesn't look quite right.  Let's see if you find out why ;-)

  Ralf
