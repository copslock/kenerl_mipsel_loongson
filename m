Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 12:49:30 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:65294 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493198Ab0LBLt0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Dec 2010 12:49:26 +0100
Received: by eyd9 with SMTP id 9so4151429eyd.36
        for <multiple recipients>; Thu, 02 Dec 2010 03:49:25 -0800 (PST)
Received: by 10.14.37.10 with SMTP id x10mr45261eea.30.1291290565273;
        Thu, 02 Dec 2010 03:49:25 -0800 (PST)
Received: from [192.168.2.2] ([91.79.87.12])
        by mx.google.com with ESMTPS id b52sm398969eei.13.2010.12.02.03.49.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 03:49:23 -0800 (PST)
Message-ID: <4CF78755.2070109@mvista.com>
Date:   Thu, 02 Dec 2010 14:47:33 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        mcdonald.shane@gmail.com
Subject: Re: [RFC 1/3] VSMP support for msp71xx family of platforms.
References: <1291220307.31413.14.camel@paanoop1-desktop>
In-Reply-To: <1291220307.31413.14.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

On 01.12.2010 19:18, Anoop P A wrote:
>> From e5148874243f0b2b610cd6b077084bd782961d94 Mon Sep 17 00:00:00 2001
> Message-Id:
> <e5148874243f0b2b610cd6b077084bd782961d94.1291219118.git.anoop.pa@gmail.com>
> In-Reply-To:<cover.1291219118.git.anoop.pa@gmail.com>
> References:<cover.1291219118.git.anoop.pa@gmail.com>
> From: Anoop P A<anoop.pa@gmail.com>
> Date: Wed, 1 Dec 2010 20:58:28 +0530
> Subject: [RFC 1/3] VSMP support for msp71xx family of platforms.

    Don't include this into the patch, or Ralf will have to hand edit it out.

> Cc: anoop.pa@gmail.com

    This should be in the signoff section.

> msp_smp.c initiliase IPI call and resched irq.

    Only "initializes".

> Signed-off-by: Anoop P A<anoop.pa@gmail.com>
[...]

> diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile
> b/arch/mips/pmc-sierra/msp71xx/Makefile
> index e107f79..09627ae 100644
> --- a/arch/mips/pmc-sierra/msp71xx/Makefile
> +++ b/arch/mips/pmc-sierra/msp71xx/Makefile
> @@ -6,7 +6,8 @@ obj-y += msp_prom.o msp_setup.o msp_irq.o \
>  obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
>  obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
>  obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
> -obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
> +obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o msp_irq_per.o

    What does this change have to do with the rest of the patch?

> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_smp.c
> b/arch/mips/pmc-sierra/msp71xx/msp_smp.c
> new file mode 100644
> index 0000000..31a6c72
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_smp.c
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
> + * Copyright (C) 2001 Ralf Baechle
> + * Copyright (C) 2010 PMC-Sierra, Inc.
> + *
> + *  VSMP support for MSP platforms . Derived from malta vsmp support.
> + *
> + *  This program is free software; you can distribute it and/or modify
> it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but
> WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> along
> + *  with this program; if not, write to the Free Software Foundation,
> Inc.,

    Your patch is line-wrapped.

> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + */
> +#include<linux/smp.h>
> +#include<linux/interrupt.h>
> +
> +#ifdef CONFIG_MIPS_MT_SMP
> +#define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
> +#define MIPS_CPU_IPI_CALL_IRQ 1		/* SW int 1 for call */

    Align the comments please, and align the macro values with a tab.

> +static struct irqaction irq_resched = {
> +	.handler	= ipi_resched_interrupt,
> +	.flags		= IRQF_DISABLED|IRQF_PERCPU,

    Need spaces around |.

> +	.name		= "IPI_resched"
> +};
> +
> +static struct irqaction irq_call = {
> +	.handler	= ipi_call_interrupt,
> +	.flags		= IRQF_DISABLED|IRQF_PERCPU,

    Need spaces around |.

> +	.name		= "IPI_call"
> +};

    Need an empty line here.

> +void __init arch_init_ipiirq(int irq, struct irqaction *action)
> +{
> +	setup_irq(irq, action);
> +	set_irq_handler(irq, handle_percpu_irq);
> +}

    Need an empty line here.

> +void __init msp_vsmp_int_init(void)
> +{
> +	set_vi_handler (MIPS_CPU_IPI_RESCHED_IRQ, ipi_resched_dispatch);
> +	set_vi_handler (MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);

    Spaces between the function name and ( are not allowed -- run your patch 
thru scripts/checkpatch.pl.

WBR, Sergei
