Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 18:00:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38519 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821115AbaCSRAg5JzR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 18:00:36 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2JH0XC3029874;
        Wed, 19 Mar 2014 18:00:33 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2JH0UuH029873;
        Wed, 19 Mar 2014 18:00:30 +0100
Date:   Wed, 19 Mar 2014 18:00:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        linux-mips@linux-mips.org, Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] gpio: vr41xx: mark GPIO lines used for IRQ
Message-ID: <20140319170030.GH17197@linux-mips.org>
References: <1390518477-10020-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390518477-10020-1-git-send-email-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jan 24, 2014 at 12:07:57AM +0100, Linus Walleij wrote:

Added Yoichi to cc.

> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> the gpiolib so we can keep track of the usage centrally.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> It would be much appreciated if one of the MIPS people could
> test this patch, thanks in advance. (I did compile-test it
> with a MIPS cross compiler.)
> ---
>  drivers/gpio/gpio-vr41xx.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
> index b983bc079102..c6728cee0cfd 100644
> --- a/drivers/gpio/gpio-vr41xx.c
> +++ b/drivers/gpio/gpio-vr41xx.c
> @@ -80,6 +80,7 @@ static DEFINE_SPINLOCK(giu_lock);
>  static unsigned long giu_flags;
>  
>  static void __iomem *giu_base;
> +static struct gpio_chip vr41xx_gpio_chip;
>  
>  #define giu_read(offset)		readw(giu_base + (offset))
>  #define giu_write(offset, value)	writew((value), giu_base + (offset))
> @@ -134,12 +135,31 @@ static void unmask_giuint_low(struct irq_data *d)
>  	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(d->irq));
>  }
>  
> +static unsigned int startup_giuint(struct irq_data *data)
> +{
> +	if (gpio_lock_as_irq(&vr41xx_gpio_chip, data->hwirq))
> +		dev_err(vr41xx_gpio_chip.dev,
> +			"unable to lock HW IRQ %lu for IRQ\n",
> +			data->hwirq);
> +	/* Satisfy the .enable semantics by unmasking the line */
> +	unmask_giuint_low(data);
> +	return 0;
> +}
> +
> +static void shutdown_giuint(struct irq_data *data)
> +{
> +	mask_giuint_low(data);
> +	gpio_unlock_as_irq(&vr41xx_gpio_chip, data->hwirq);
> +}
> +
>  static struct irq_chip giuint_low_irq_chip = {
>  	.name		= "GIUINTL",
>  	.irq_ack	= ack_giuint_low,
>  	.irq_mask	= mask_giuint_low,
>  	.irq_mask_ack	= mask_ack_giuint_low,
>  	.irq_unmask	= unmask_giuint_low,
> +	.irq_startup	= startup_giuint,
> +	.irq_shutdown	= shutdown_giuint,
>  };
>  
>  static void ack_giuint_high(struct irq_data *d)

I haven't received any test results but as it's looking good I'm queueing
this for 3.15.

Thanks,

  Ralf
