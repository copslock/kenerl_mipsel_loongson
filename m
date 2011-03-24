Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 13:46:22 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:45154 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1CXMqS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 13:46:18 +0100
Received: by eyh6 with SMTP id 6so2595635eyh.36
        for <multiple recipients>; Thu, 24 Mar 2011 05:46:13 -0700 (PDT)
Received: by 10.14.19.140 with SMTP id n12mr2974097een.168.1300970772995;
        Thu, 24 Mar 2011 05:46:12 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.104.70])
        by mx.google.com with ESMTPS id b52sm4477223eei.8.2011.03.24.05.46.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 05:46:11 -0700 (PDT)
Message-ID: <4D8B3CBC.3080307@mvista.com>
Date:   Thu, 24 Mar 2011 15:44:44 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 37/38] mips: vr41xx: Cleanup the direct access to irq_desc[]
References: <20110323210437.398062704@linutronix.de> <20110323210538.070462971@linutronix.de>
In-Reply-To: <20110323210538.070462971@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 24.03.2011 0:09, Thomas Gleixner wrote:

> Tons of unused code, but that's Ralfs problem.

> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
[...]

> Index: linux-mips-next/arch/mips/vr41xx/common/irq.c
> ===================================================================
> --- linux-mips-next.orig/arch/mips/vr41xx/common/irq.c
> +++ linux-mips-next/arch/mips/vr41xx/common/irq.c
> @@ -62,7 +62,6 @@ EXPORT_SYMBOL_GPL(cascade_irq);
>   static void irq_dispatch(unsigned int irq)
>   {
>   	irq_cascade_t *cascade;
> -	struct irq_desc *desc;
>
>   	if (irq>= NR_IRQS) {
>   		atomic_inc(&irq_err_count);
> @@ -71,14 +70,16 @@ static void irq_dispatch(unsigned int ir
>
>   	cascade = irq_cascade + irq;
>   	if (cascade->get_irq != NULL) {
> -		unsigned int source_irq = irq;
> +		struct irq_desc *desc = irq_to_desc(irq);
> +		struct irq_data *idata = irq_desc_get_irq_data(desc);
> +		struct irq_chip *chip = irq_desc_get_chip(desc);
>   		int ret;
> -		desc = irq_desc + source_irq;
> -		if (desc->chip->mask_ack)
> -			desc->chip->mask_ack(source_irq);
> +
> +		if (chip->irq_mask_ack)
> +			chip->irq_mask_ack(idata);
>   		else {
> -			desc->chip->mask(source_irq);
> -			desc->chip->ack(source_irq);
> +			chip->irq_mask(idata);
> +			chip->irq_ack(idata);
>   		}
>   		ret = cascade->get_irq(irq);
>   		irq = ret;
> @@ -86,8 +87,8 @@ static void irq_dispatch(unsigned int ir
>   			atomic_inc(&irq_err_count);
>   		else
>   			irq_dispatch(irq);
> -		if (!(desc->status&  IRQ_DISABLED)&&  desc->chip->unmask)
> -			desc->chip->unmask(source_irq);
> +		if (!(desc->status&  IRQ_DISABLED)&&  chip->irq_unmask)
> +			chip->irq_unmask(idata);

    Hm, doesn't this (I mean the old) code break after the previous patch?

WBR, Sergei
