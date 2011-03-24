Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 13:23:37 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:37466 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1CXMXd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 13:23:33 +0100
Received: by eyh6 with SMTP id 6so2582426eyh.36
        for <multiple recipients>; Thu, 24 Mar 2011 05:23:28 -0700 (PDT)
Received: by 10.14.13.143 with SMTP id b15mr3051297eeb.46.1300969408173;
        Thu, 24 Mar 2011 05:23:28 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.104.70])
        by mx.google.com with ESMTPS id q53sm4461796eeh.4.2011.03.24.05.23.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 05:23:27 -0700 (PDT)
Message-ID: <4D8B3768.7020806@mvista.com>
Date:   Thu, 24 Mar 2011 15:22:00 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 14/38] mips: gic: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de> <20110323210535.903372061@linutronix.de>
In-Reply-To: <20110323210535.903372061@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 24-03-2011 0:08, Thomas Gleixner wrote:

> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/mips/kernel/irq-gic.c |   44 ++++++++++++++++++--------------------------
>   1 file changed, 18 insertions(+), 26 deletions(-)

> Index: linux-mips-next/arch/mips/kernel/irq-gic.c
> ===================================================================
> --- linux-mips-next.orig/arch/mips/kernel/irq-gic.c
> +++ linux-mips-next/arch/mips/kernel/irq-gic.c
> @@ -87,17 +87,9 @@ unsigned int gic_get_int(void)
>   	return i;
>   }
>
> -static unsigned int gic_irq_startup(unsigned int irq)
> +static void gic_irq_ack(struct irq_data *d)
>   {
> -	irq -= _irqbase;
> -	pr_debug("CPU%d: %s: irq%d\n", smp_processor_id(), __func__, irq);
> -	GIC_SET_INTR_MASK(irq);
> -	return 0;
> -}
> -
> -static void gic_irq_ack(unsigned int irq)
> -{
> -	irq -= _irqbase;
> +	unsigned int irq = d->irq - _irqbase;

    The style of this file assumes empty lines aftrer the declaration block:

> @@ -123,13 +115,14 @@ static void gic_unmask_irq(unsigned int
>
>   static DEFINE_SPINLOCK(gic_lock);
>
> -static int gic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
> +static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
> +			    bool force)
>   {
> +	unsigned int irq = d->irq - _irqbase;
>   	cpumask_t	tmp = CPU_MASK_NONE;
>   	unsigned long	flags;
>   	int		i;
>
> -	irq -= _irqbase;
>   	pr_debug("%s(%d) called\n", __func__, irq);
>   	cpumask_and(&tmp, cpumask, cpu_online_mask);
>   	if (cpus_empty(tmp))

WBR, Sergei
