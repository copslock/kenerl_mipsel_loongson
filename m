Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 19:37:22 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53553 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819765Ab3K2ShTabpc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Nov 2013 19:37:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B89568F6E;
        Fri, 29 Nov 2013 19:37:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3EW03P78-jZa; Fri, 29 Nov 2013 19:37:13 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:75ef:27c:89bc:a22f] (unknown [IPv6:2001:470:1f0b:447:75ef:27c:89bc:a22f])
        by hauke-m.de (Postfix) with ESMTPSA id F3F1E8F6D;
        Fri, 29 Nov 2013 19:37:12 +0100 (CET)
Message-ID: <5298DED7.90708@hauke-m.de>
Date:   Fri, 29 Nov 2013 19:37:11 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V3 1/2] bcma: gpio: add own IRQ domain
References: <1385741397-32740-1-git-send-email-zajec5@gmail.com> <1385747290-22575-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1385747290-22575-1-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 11/29/2013 06:48 PM, Rafał Miłecki wrote:
> Input GPIO changes can generate interrupts, but we need kind of ACK for
> them by changing IRQ polarity. This is required to stop hardware from
> keep generating interrupts and generate another one on the next GPIO
> state change.
> This code allows using GPIOs with standard interrupts and add for
> example GPIO buttons support.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> V3: Apply Hauke's comments.
> 1) Use IRQ domain for CONFIG_BCMA_HOST_SOC only
> 2) Optimize bcma_gpio_irq_handler
> 3) Register GPIO chip after doing everything else
> 4) Improve cleaning paths
> ---
>  drivers/bcma/Kconfig                        |    1 +
>  drivers/bcma/driver_gpio.c                  |  126 ++++++++++++++++++++++++++-
>  include/linux/bcma/bcma_driver_chipcommon.h |    1 +
>  3 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
> index 7c081b3..0ee48be 100644
> --- a/drivers/bcma/Kconfig
> +++ b/drivers/bcma/Kconfig
> @@ -75,6 +75,7 @@ config BCMA_DRIVER_GMAC_CMN
>  config BCMA_DRIVER_GPIO
>  	bool "BCMA GPIO driver"
>  	depends on BCMA && GPIOLIB
> +	select IRQ_DOMAIN if BCMA_HOST_SOC
>  	help
>  	  Driver to provide access to the GPIO pins of the bcma bus.
>  
> diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
> index 45f0996..fe9b1bc 100644
> --- a/drivers/bcma/driver_gpio.c
> +++ b/drivers/bcma/driver_gpio.c
> @@ -9,6 +9,9 @@
>   */
>  
>  #include <linux/gpio.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
>  #include <linux/export.h>
>  #include <linux/bcma/bcma.h>
>  
> @@ -73,19 +76,117 @@ static void bcma_gpio_free(struct gpio_chip *chip, unsigned gpio)
>  	bcma_chipco_gpio_pullup(cc, 1 << gpio, 0);
>  }
>  
> +#ifdef CONFIG_BCMA_HOST_SOC
>  static int bcma_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
>  {
>  	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
>  
>  	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
> -		return bcma_core_irq(cc->core);
> +		return irq_find_mapping(cc->irq_domain, gpio);
>  	else
>  		return -EINVAL;
>  }
>  
> +static void bcma_gpio_irq_unmask(struct irq_data *d)
> +{
> +	struct bcma_drv_cc *cc = irq_data_get_irq_chip_data(d);
> +	int gpio = irqd_to_hwirq(d);
> +
> +	bcma_chipco_gpio_intmask(cc, BIT(gpio), BIT(gpio));
> +}
> +
> +static void bcma_gpio_irq_mask(struct irq_data *d)
> +{
> +	struct bcma_drv_cc *cc = irq_data_get_irq_chip_data(d);
> +	int gpio = irqd_to_hwirq(d);
> +
> +	bcma_chipco_gpio_intmask(cc, BIT(gpio), 0);
> +}
> +
> +static struct irq_chip bcma_gpio_irq_chip = {
> +	.name		= "BCMA-GPIO",
> +	.irq_mask	= bcma_gpio_irq_mask,
> +	.irq_unmask	= bcma_gpio_irq_unmask,
> +};
> +
> +static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
> +{
> +	struct bcma_drv_cc *cc = dev_id;
> +	u32 val = bcma_cc_read32(cc, BCMA_CC_GPIOIN);
> +	u32 mask = bcma_cc_read32(cc, BCMA_CC_GPIOIRQ);
> +	u32 pol = bcma_cc_read32(cc, BCMA_CC_GPIOPOL);
> +	u32 irqs = (val ^ pol) & mask;
> +	u32 pol_mask = 0, pol_val = 0;
> +	int gpio;
> +
> +	for_each_set_bit(gpio, (unsigned long *)&irqs, cc->gpio.ngpio) {
> +		generic_handle_irq(bcma_gpio_to_irq(&cc->gpio, gpio));
> +		pol_mask |= BIT(gpio);
> +		if (val & BIT(gpio))
> +			pol_val |= BIT(gpio);
> +	}

Instead of calculation pol_mask and pol_val bit for bit manually, you
can pretty easy calculate valid value like this:
pol_mask = irqs;
pol_val = val & irqs;

> +	bcma_chipco_gpio_polarity(cc, pol_mask, pol_val);
> +
> +	return irqs ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int bcma_gpio_irq_domain_init(struct bcma_drv_cc *cc)
> +{
> +	struct gpio_chip *chip = &cc->gpio;
> +	int gpio, hwirq, err;
> +
> +	cc->irq_domain = irq_domain_add_linear(NULL, chip->ngpio,
> +					       &irq_domain_simple_ops, cc);
> +	if (!cc->irq_domain) {
> +		err = -ENODEV;
> +		goto err_irq_domain;
> +	}
> +	for (gpio = 0; gpio < chip->ngpio; gpio++) {
> +		int irq = irq_create_mapping(cc->irq_domain, gpio);
> +
> +		irq_set_chip_data(irq, cc);
> +		irq_set_chip_and_handler(irq, &bcma_gpio_irq_chip,
> +					 handle_simple_irq);
> +	}
> +
> +	hwirq = bcma_core_irq(cc->core);
> +	err = request_irq(hwirq, bcma_gpio_irq_handler, IRQF_SHARED, "gpio",
> +			  cc);
> +	if (err)
> +		goto err_req_irq;
> +
> +	return 0;
> +
> +err_req_irq:
> +	for (gpio = 0; gpio < chip->ngpio; gpio++) {
> +		int irq = irq_find_mapping(cc->irq_domain, gpio);
> +
> +		irq_dispose_mapping(irq);
> +	}
> +	irq_domain_remove(cc->irq_domain);
> +err_irq_domain:
> +	return err;
> +}
> +
> +static void bcma_gpio_irq_domain_exit(struct bcma_drv_cc *cc)
> +{
> +	struct gpio_chip *chip = &cc->gpio;
> +	int gpio;
> +
> +	free_irq(bcma_core_irq(cc->core), cc);
> +	for (gpio = 0; gpio < chip->ngpio; gpio++) {
> +		int irq = irq_find_mapping(cc->irq_domain, gpio);
> +
> +		irq_dispose_mapping(irq);
> +	}
> +	irq_domain_remove(cc->irq_domain);
> +}
> +#endif

I do not like all these ifdefs, why not add this and remove some of them
from the code in bcma_gpio_init():

#else /* CONFIG_BCMA_HOST_SOC */

static int bcma_gpio_irq_domain_init(struct bcma_drv_cc *cc)
{
	return 0;
}
static void bcma_gpio_irq_domain_exit(struct bcma_drv_cc *cc)
{
	/* Nothing */
}
#endif /* CONFIG_BCMA_HOST_SOC */

> +
>  int bcma_gpio_init(struct bcma_drv_cc *cc)
>  {
>  	struct gpio_chip *chip = &cc->gpio;
> +	int err;
>  
>  	chip->label		= "bcma_gpio";
>  	chip->owner		= THIS_MODULE;
> @@ -95,7 +196,9 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>  	chip->set		= bcma_gpio_set_value;
>  	chip->direction_input	= bcma_gpio_direction_input;
>  	chip->direction_output	= bcma_gpio_direction_output;
> +#ifdef CONFIG_BCMA_HOST_SOC
>  	chip->to_irq		= bcma_gpio_to_irq;
> +#endif
>  	chip->ngpio		= 16;
>  	/* There is just one SoC in one device and its GPIO addresses should be
>  	 * deterministic to address them more easily. The other buses could get
> @@ -105,10 +208,29 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>  	else
>  		chip->base		= -1;
>  
> -	return gpiochip_add(chip);
> +#ifdef CONFIG_BCMA_HOST_SOC
> +	err = bcma_gpio_irq_domain_init(cc);
> +	if (err)
> +		return err;
> +#endif
> +
> +	err = gpiochip_add(chip);
> +	if (err) {
> +#ifdef CONFIG_BCMA_HOST_SOC
> +		bcma_gpio_irq_domain_exit(cc);
> +#endif
> +		return err;
> +	}
> +
> +	bcma_cc_set32(cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);

This should be moved into bcma_gpio_irq_domain_ini(), I do not know what
happens when we activate them on a PCIe device. IRQs should get
deactivated in bcma_gpio_irq_domain_exit().

> +
> +	return 0;
>  }
>  
>  int bcma_gpio_unregister(struct bcma_drv_cc *cc)
>  {
> +#ifdef CONFIG_BCMA_HOST_SOC
> +	bcma_gpio_irq_domain_exit(cc);
> +#endif
>  	return gpiochip_remove(&cc->gpio);
>  }
> diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
> index c49e1a1..63d105c 100644
> --- a/include/linux/bcma/bcma_driver_chipcommon.h
> +++ b/include/linux/bcma/bcma_driver_chipcommon.h
> @@ -640,6 +640,7 @@ struct bcma_drv_cc {
>  	spinlock_t gpio_lock;
>  #ifdef CONFIG_BCMA_DRIVER_GPIO
>  	struct gpio_chip gpio;
> +	struct irq_domain *irq_domain;
>  #endif
>  };
>  
> 
