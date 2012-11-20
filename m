Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 10:44:24 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:38301 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823054Ab2KTJoXIywbY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2012 10:44:23 +0100
Received: by mail-bk0-f49.google.com with SMTP id jm19so1064237bkc.36
        for <multiple recipients>; Tue, 20 Nov 2012 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=r5LLSgJJEuRVYvVT7dQQ/d8+1nXSG9fLWEEOy65uRKU=;
        b=cQtQQLD0wR5ctZmwWeQLGxsrHgc3gD1K323HhPdEc5vS29ZTYh6Han/kSaiRbTd1hx
         OE3k0f1oYdYTndTIPQht25aLBTgN9Rd6yIgx+j42I7TUeGwuWJH4bjWu94zf/fQSg/TV
         94L2o6mi9VBHp6HBNNw0KOFjsFG0ueU1B8qGNtwWx4IXjYxT+D4Amgud/AG3OUkKpImU
         +nieMaJzJCkRpDJCfmvXu7EA8KEzX56I0BfZID12aQUSwhLO7J/vmPy6bJTQNROuYD0D
         ILfKQLksM0txrKBT/dLruG7kSmqgMoAlVIqNCgjlmUTifEz7b2TaVYWmM2ej7m+6K6OU
         Jq4Q==
Received: by 10.204.8.18 with SMTP id f18mr705379bkf.82.1353404657632;
        Tue, 20 Nov 2012 01:44:17 -0800 (PST)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id d16sm6233345bkw.2.2012.11.20.01.44.16
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 01:44:16 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, zajec5@gmail.com, m@bues.ch
Subject: Re: [PATCH 4/8] bcma: add GPIO driver
Date:   Tue, 20 Nov 2012 10:42:33 +0100
Message-ID: <1849463.Q1jRPkmcje@flexo>
Organization: OpenWrt
User-Agent: KMail/4.9.2 (Linux/3.5.0-17-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <1353365877-11131-5-git-send-email-hauke@hauke-m.de>
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de> <1353365877-11131-5-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 35057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hauke,

This driver looks good to me, a couple of minor comments below.

On Monday 19 November 2012 23:57:53 Hauke Mehrtens wrote:
> Register a GPIO driver to access the GPIOs provided by the chip.
> The GPIOs of the SoC should always start at 0 and the other GPIOs could
> start at a random position. There is just one SoC in a system and when
> they start at 0 the number is predictable.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
[snip]
> +#ifdef CONFIG_BCMA_DRIVER_GPIO
> +/* driver_gpio.c */
> +int bcma_gpio_init(struct bcma_drv_cc *cc);
> +#else
> +static inline int bcma_gpio_init(struct bcma_drv_cc *cc)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_BCMA_DRIVER_GPIO */

I wonder if it would not make more sense here to return -ENODEV or -ENOTSUPP
so we can identify a kernel not being built with BCMA GPIO support.

> +
>  #endif
> diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
> new file mode 100644
> index 0000000..2b9e404
> --- /dev/null
> +++ b/drivers/bcma/driver_gpio.c
> @@ -0,0 +1,95 @@
> +/*
> + * Broadcom specific AMBA
> + * GPIO driver
> + *
> + * Copyright 2011, Broadcom Corporation
> + * Copyright 2012, Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/export.h>
> +#include <linux/bcma/bcma.h>
> +
> +#include "bcma_private.h"
> +
> +static inline struct bcma_drv_cc *bcma_gpio_get_cc(struct gpio_chip *chip)
> +{
> +	return container_of(chip, struct bcma_drv_cc, gpio);
> +}
> +
> +static int bcma_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
> +{
> +	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
> +
> +	return !!bcma_chipco_gpio_in(cc, 1 << gpio);
> +}
> +
> +static void bcma_gpio_set_value(struct gpio_chip *chip, unsigned gpio,
> +				int value)
> +{
> +	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
> +
> +	bcma_chipco_gpio_out(cc, 1 << gpio, value ? 1 << gpio : 0);

This is a little confusing at first, because most GPIO "drivers" actually just
pass the value directly.

[snip]

> +int bcma_gpio_init(struct bcma_drv_cc *cc)
> +{
> +	struct gpio_chip *chip = &cc->gpio;
> +
> +	chip->label		= "bcma_gpio";
> +	chip->owner		= THIS_MODULE;
> +	chip->request		= bcma_gpio_request;
> +	chip->free		= bcma_gpio_free;
> +	chip->get		= bcma_gpio_get_value;
> +	chip->set		= bcma_gpio_set_value;
> +	chip->direction_input	= bcma_gpio_direction_input;
> +	chip->direction_output	= bcma_gpio_direction_output;
> +	chip->ngpio		= 16;
> +	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
> +		chip->base		= 0;
> +	else
> +		chip->base		= -1;

You might want to add a comment to explain why base auto-assignment is not used
when the host type is SOC.
--
Florian
