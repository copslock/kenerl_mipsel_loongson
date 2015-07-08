Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 15:45:58 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36273 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010457AbbGHNp4dNwed (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 15:45:56 +0200
Received: by lbbpo10 with SMTP id po10so56436412lbb.3
        for <linux-mips@linux-mips.org>; Wed, 08 Jul 2015 06:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=GCezas/So5b8phmg4IJ3Iu41bJSQOYXjHiR/wV0y5W8=;
        b=AjANZn8ugnpZiuuNb6/L5TBKaVlFGkDwi5ZnFTTyywYfL0rEE1TGjGQ2pKSCULyu73
         9rT2Gq+8NEWqQ49/y7Wvlus4v5C8rzb0j/dBS/AYWVCqSSspVuAKP+/wl9WC2nmlgrPa
         c4WokalbO39s/SXkUYbJin83UdZl20T2gn4Kp4n7QHOJVgP6DP3W526Hv681j8u1zJ7P
         x/SHIQIAHWZXHpdCGhfDkP8ImA2ah9+81Tq71ZE+vZF8ilRlU1a8GjjUbMzfMQTUCuWg
         gIt4EtvLIa8c/PM6Rl6gKkNJpQvRzhP0JdfrnPf4/DbMODy0ttT9BXQozilcpfyTdSHK
         WJ8w==
X-Gm-Message-State: ALoCoQkq8EPN7AUukb4cbG8QfhnGK2MGD+7Ie2C84DMtfLOhU6asJtyZ9LB6bsf7mXEj+hE5SIqx
X-Received: by 10.112.162.70 with SMTP id xy6mr9751715lbb.122.1436363150705;
        Wed, 08 Jul 2015 06:45:50 -0700 (PDT)
Received: from [192.168.3.154] (ppp83-237-253-206.pppoe.mtu-net.ru. [83.237.253.206])
        by smtp.gmail.com with ESMTPSA id tp10sm648182lbb.4.2015.07.08.06.45.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 06:45:49 -0700 (PDT)
Subject: Re: [PATCH] MIPS, IRQCHIP: Move i8259 irqchip driver to
 drivers/irqchip.
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20150708124608.GS18167@linux-mips.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <559D298C.4020302@cogentembedded.com>
Date:   Wed, 8 Jul 2015 16:45:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150708124608.GS18167@linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello.

On 7/8/2015 3:46 PM, Ralf Baechle wrote:

>   arch/mips/Kconfig           |   4 -
>   arch/mips/kernel/Makefile   |   1 -
>   arch/mips/kernel/i8259.c    | 384 --------------------------------------------
>   drivers/irqchip/Kconfig     |   4 +
>   drivers/irqchip/Makefile    |   1 +
>   drivers/irqchip/irq-i8259.c | 383 +++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 388 insertions(+), 389 deletions(-)

[...]

> diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
> new file mode 100644
> index 0000000..a29638a
> --- /dev/null
> +++ b/drivers/irqchip/irq-i8259.c
> @@ -0,0 +1,383 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Code to handle x86 style IRQs plus some generic interrupt stuff.
> + *
> + * Copyright (C) 1992 Linus Torvalds
> + * Copyright (C) 1994 - 2000 Ralf Baechle
> + */
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/of_irq.h>
> +#include <linux/spinlock.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/irq.h>
> +
> +#include <asm/i8259.h>
> +#include <asm/io.h>
> +
> +/*
> + * This is the 'legacy' 8259A Programmable Interrupt Controller,
> + * present in the majority of PC/AT boxes.
> + * plus some generic x86 specific things if generic specifics makes
> + * any sense at all.
> + * this file should become arch/i386/kernel/irq.c when the old irq.c
> + * moves to arch independent land

    This comment doesn't make sense anymore, does it?

> +static struct irq_chip i8259A_chip = {
> +	.name			= "XT-PIC",

    This name is wrong, wrong, wrong. XT only had single 8259 (and is not 
supported by Linux anyway) while jhere we drive the AT specific two cascaded 
8259s (which is just wrong in my opinion as well).

> +	.irq_mask		= disable_8259A_irq,
> +	.irq_disable		= disable_8259A_irq,
> +	.irq_unmask		= enable_8259A_irq,
> +	.irq_mask_ack		= mask_and_ack_8259A,

    I have always thought 8259 was the "fast-EOI" class interrupt chip, I've 
never quite understood all this mask-and-ACK type handling for 8259...

[...]
> +/*
> + * Careful! The 8259A is a fragile beast, it pretty
> + * much _has_ to be done exactly like this (mask it
> + * first, _then_ send the EOI, and the order of EOI
> + * to the two 8259s is important!
> + */
> +static void mask_and_ack_8259A(struct irq_data *d)
> +{
[...]
> +handle_real_irq:
> +	if (irq & 8) {
> +		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */

    Hardly.

> +		outb(cached_slave_mask, PIC_SLAVE_IMR);
> +		outb(0x60+(irq&7), PIC_SLAVE_CMD);/* 'Specific EOI' to slave */

   Need spaces around ops.

> +		outb(0x60+PIC_CASCADE_IR, PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
> +	} else {
> +		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
> +		outb(cached_master_mask, PIC_MASTER_IMR);
> +		outb(0x60+irq, PIC_MASTER_CMD); /* 'Specific EOI to master */

    Same here...

> +	}
> +	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
> +	return;

> +	{
> +		static int spurious_irq_mask;
> +		/*
> +		 * At this point we can be sure the IRQ is spurious,
> +		 * lets ACK and report it. [once per IRQ]

    There's no point in ACKing spurious interrupt, if my memory serves. The 
in-srvice register doesn't have the bit set, so no need to clear it.

> +		 */
> +		if (!(spurious_irq_mask & irqmask)) {
> +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
> +			spurious_irq_mask |= irqmask;
> +		}
> +		atomic_inc(&irq_err_count);
> +		/*
> +		 * Theoretically we do not have to handle this IRQ,
> +		 * but in Linux this does not cause problems and is
> +		 * simpler for us.
> +		 */
> +		goto handle_real_irq;

    Hum... only because it doesn't cause issues?

WBR, Sergei
