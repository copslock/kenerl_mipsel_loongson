Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 05:24:11 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:46470 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133390AbWF0EYA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 05:24:00 +0100
Received: (qmail 29053 invoked by uid 101); 27 Jun 2006 04:23:42 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 27 Jun 2006 04:23:42 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5R4NfV7011078;
	Mon, 26 Jun 2006 21:23:41 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7MQY6>; Mon, 26 Jun 2006 21:23:40 -0700
Message-ID: <C28979E4F697C249ABDA83AC0C33CDF80B6BCA@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	"'Yoichi Yuasa'" <yoichi_yuasa@tripeaks.co.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Subject: RE: [Patch 3/6] Sequoia Platform
Date:	Mon, 26 Jun 2006 21:23:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hello Yoichi,
I noticed that change from 2.6.16 to 2.6.17.1 and am doing it.. Will send the update soon. 
Thanks for the suggestions.

Kiran

-----Original Message-----
From: Yoichi Yuasa [mailto:yoichi_yuasa@tripeaks.co.jp] 
Sent: Monday, June 26, 2006 8:52 PM
To: Kiran Thota
Cc: ralf@linux-mips.org; linux-mips@linux-mips.org; Raj Palani
Subject: Re: [Patch 3/6] Sequoia Platform

Hello Kiran,

On Fri, 23 Jun 2006 18:56:54 -0700
Kiran Thota <Kiran_Thota@pmc-sierra.com> wrote:

> 
> 
> - Add IRQ controller (hacked from irq-rm9000.c)

If you change the IRQ numbers, I think that irq-rm9000.c and irq-rm7000.c can be used. 

> - Add Interrupt handlers

You should rewrite the assembler interrupt handler to C code.

> diff -Naur a/arch/mips/pmc-sierra/sequoia/setup.c b/arch/mips/pmc-sierra/sequoia/setup.c
> --- a/arch/mips/pmc-sierra/sequoia/setup.c	1969-12-31 16:00:00.000000000 -0800
> +++ b/arch/mips/pmc-sierra/sequoia/setup.c	2006-06-22 14:57:38.000000000 -0700
> @@ -0,0 +1,258 @@
> +/*
> + *  arch/mip/pmc-sierra/sequoia/setup.c
> + *
> + *  Copyright (C) 2006 PMC-Sierra Inc.
> + *  Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/mc146818rtc.h>
> +#include <linux/mm.h>
> +#include <linux/swap.h>
> +#include <linux/ioport.h>
> +#include <linux/console.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/timex.h>
> +#include <linux/vmalloc.h>
> +#include <asm/time.h>
> +#include <asm/bootinfo.h>
> +#include <asm/page.h>
> +#include <asm/bootinfo.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/processor.h>
> +#include <asm/ptrace.h>
> +#include <asm/reboot.h>
> +#include <asm/traps.h>
> +#include <linux/version.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/serial.h>
> +#include <linux/termios.h>
> +#include <linux/tty.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +
> +#include <linux/mm.h>
> +
> +#include <asm/pmc_sequoia.h>
> +
> +#include "setup.h"
> +
> +unsigned long titan_ge_base;
> +unsigned long cpu_clock;
> +unsigned long sequoia_memsize;
> +
> +/* Real Time Clock base */
> +#define CONV_BCD_TO_BIN(val)	(((val) & 0xf) + (((val) >> 4) * 10))
> +#define CONV_BIN_TO_BCD(val)	(((val) % 10) + (((val) / 10) << 4))

You should use #include <linux/bcd.h>.

> +void __init bus_error_init(void)
> +{ 
> +	/* Do nothing */
> +}

It doesn't need.

> +unsigned long m48t37y_get_time(void)
> +{
> +	unsigned char	*rtc_base = SEQUOIA_RTC_BASE_ADDR;
> +	unsigned int	year, month, day, hour, min, sec;
> +
> +	/* Stop the update to the time */
> +	rtc_base[0x7ff8] = 0x40;
> +
> +	year = CONV_BCD_TO_BIN(rtc_base[0x7fff]);
> +	year += CONV_BCD_TO_BIN(rtc_base[0x7ff1]) * 100;
> +
> +	month = CONV_BCD_TO_BIN(rtc_base[0x7ffe]);
> +	day = CONV_BCD_TO_BIN(rtc_base[0x7ffd]);
> +	hour = CONV_BCD_TO_BIN(rtc_base[0x7ffb]);
> +	min = CONV_BCD_TO_BIN(rtc_base[0x7ffa]);
> +	sec = CONV_BCD_TO_BIN(rtc_base[0x7ff9]);
> +
> +	/* Start the update to the time again */
> +	rtc_base[0x7ff8] = 0x00;
> +
> +	return mktime(year, month, day, hour, min, sec); }
> +
> +int m48t37y_set_time(unsigned long sec) {
> +	unsigned char	*rtc_base = SEQUOIA_RTC_BASE_ADDR;
> +        struct rtc_time tm;
> +
> +        /* convert to a more useful format -- note months count from 0 */
> +        to_tm(sec, &tm);
> +        tm.tm_mon += 1;
> +
> +        /* enable writing */
> +        rtc_base[0x7ff8] = 0x80;
> +
> +        /* year */
> +        rtc_base[0x7fff] = CONV_BIN_TO_BCD(tm.tm_year % 100);
> +        rtc_base[0x7ff1] = CONV_BIN_TO_BCD(tm.tm_year / 100);
> +
> +        /* month */
> +        rtc_base[0x7ffe] = CONV_BIN_TO_BCD(tm.tm_mon);
> +
> +        /* day */
> +        rtc_base[0x7ffd] = CONV_BIN_TO_BCD(tm.tm_mday);
> +
> +        /* hour/min/sec */
> +        rtc_base[0x7ffb] = CONV_BIN_TO_BCD(tm.tm_hour);
> +        rtc_base[0x7ffa] = CONV_BIN_TO_BCD(tm.tm_min);
> +        rtc_base[0x7ff9] = CONV_BIN_TO_BCD(tm.tm_sec);
> +
> +        /* day of week -- not really used, but let's keep it up-to-date */
> +        rtc_base[0x7ffc] = CONV_BIN_TO_BCD(tm.tm_wday + 1);
> +
> +        /* disable writing */
> +        rtc_base[0x7ff8] = 0x00;
> +
> +        return 0;
> +}

RTC driver is better.
It's very simple and easy to write, see drivers/rtc .

> +void __init plat_setup(void)

plat_mem_setup


> diff -Naur a/arch/mips/pmc-sierra/sequoia/setup.h b/arch/mips/pmc-sierra/sequoia/setup.h
> --- a/arch/mips/pmc-sierra/sequoia/setup.h	1969-12-31 16:00:00.000000000 -0800
> +++ b/arch/mips/pmc-sierra/sequoia/setup.h	2006-06-22 11:48:21.000000000 -0700
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright 2006 PMC-Sierra
> + * Author: PMC Sierra Inc (thotakir@pmc-sierra.com)
> + *
> + * Board specific definititions for the PMC-Sierra Sequoia
> + *
> + */
> +
> +#ifndef __SETUP_H__
> +#define __SETUP_H__
> +
> +/* Real Time Clock base */
> +#define CONV_BCD_TO_BIN(val)    (((val) & 0xf) + (((val) >> 4) * 10))
> +#define CONV_BIN_TO_BCD(val)    (((val) % 10) + (((val) / 10) << 4))
> +
> +#endif /* __SETUP_H__ */

You should use #include <linux/bcd.h> .

Yoichi
