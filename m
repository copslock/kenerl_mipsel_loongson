Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2012 23:33:26 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45391 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825916Ab2KTWdZGEUpL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2012 23:33:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 212688F61;
        Tue, 20 Nov 2012 23:33:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xrhxCbvcNGZG; Tue, 20 Nov 2012 23:32:52 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:6d1e:baeb:418:870b] (unknown [IPv6:2001:470:1f0b:447:6d1e:baeb:418:870b])
        by hauke-m.de (Postfix) with ESMTPSA id E5ADA8F60;
        Tue, 20 Nov 2012 23:32:50 +0100 (CET)
Message-ID: <50AC050E.3070206@hauke-m.de>
Date:   Tue, 20 Nov 2012 23:32:46 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, zajec5@gmail.com, m@bues.ch
Subject: Re: [PATCH 4/8] bcma: add GPIO driver
References: <1353365877-11131-1-git-send-email-hauke@hauke-m.de> <1353365877-11131-5-git-send-email-hauke@hauke-m.de> <1849463.Q1jRPkmcje@flexo>
In-Reply-To: <1849463.Q1jRPkmcje@flexo>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 35062
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/20/2012 10:42 AM, Florian Fainelli wrote:
> Hi Hauke,
> 
> This driver looks good to me, a couple of minor comments below.
> 
> On Monday 19 November 2012 23:57:53 Hauke Mehrtens wrote:
>> Register a GPIO driver to access the GPIOs provided by the chip.
>> The GPIOs of the SoC should always start at 0 and the other GPIOs could
>> start at a random position. There is just one SoC in a system and when
>> they start at 0 the number is predictable.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> [snip]
>> +#ifdef CONFIG_BCMA_DRIVER_GPIO
>> +/* driver_gpio.c */
>> +int bcma_gpio_init(struct bcma_drv_cc *cc);
>> +#else
>> +static inline int bcma_gpio_init(struct bcma_drv_cc *cc)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_BCMA_DRIVER_GPIO */
> 
> I wonder if it would not make more sense here to return -ENODEV or -ENOTSUPP
> so we can identify a kernel not being built with BCMA GPIO support.

I added that and changed the logging for such a message to debug level,
but I do not know if this would confuse people just using bcma/ssb for
their wireless pcie cards.

>> +
>>  #endif
>> diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
>> new file mode 100644
>> index 0000000..2b9e404
>> --- /dev/null
>> +++ b/drivers/bcma/driver_gpio.c
>> @@ -0,0 +1,95 @@
>> +/*
>> + * Broadcom specific AMBA
>> + * GPIO driver
>> + *
>> + * Copyright 2011, Broadcom Corporation
>> + * Copyright 2012, Hauke Mehrtens <hauke@hauke-m.de>
>> + *
>> + * Licensed under the GNU/GPL. See COPYING for details.
>> + */
>> +
>> +#include <linux/gpio.h>
>> +#include <linux/export.h>
>> +#include <linux/bcma/bcma.h>
>> +
>> +#include "bcma_private.h"
>> +
>> +static inline struct bcma_drv_cc *bcma_gpio_get_cc(struct gpio_chip *chip)
>> +{
>> +	return container_of(chip, struct bcma_drv_cc, gpio);
>> +}
>> +
>> +static int bcma_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
>> +{
>> +	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
>> +
>> +	return !!bcma_chipco_gpio_in(cc, 1 << gpio);
>> +}
>> +
>> +static void bcma_gpio_set_value(struct gpio_chip *chip, unsigned gpio,
>> +				int value)
>> +{
>> +	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
>> +
>> +	bcma_chipco_gpio_out(cc, 1 << gpio, value ? 1 << gpio : 0);
> 
> This is a little confusing at first, because most GPIO "drivers" actually just
> pass the value directly.

The bcma_chipco_gpio API exposes the raw registers, and the conversion
of the generic GPIO API to these registers is done here. Should I change
something here?

> [snip]
> 
>> +int bcma_gpio_init(struct bcma_drv_cc *cc)
>> +{
>> +	struct gpio_chip *chip = &cc->gpio;
>> +
>> +	chip->label		= "bcma_gpio";
>> +	chip->owner		= THIS_MODULE;
>> +	chip->request		= bcma_gpio_request;
>> +	chip->free		= bcma_gpio_free;
>> +	chip->get		= bcma_gpio_get_value;
>> +	chip->set		= bcma_gpio_set_value;
>> +	chip->direction_input	= bcma_gpio_direction_input;
>> +	chip->direction_output	= bcma_gpio_direction_output;
>> +	chip->ngpio		= 16;
>> +	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
>> +		chip->base		= 0;
>> +	else
>> +		chip->base		= -1;
> 
> You might want to add a comment to explain why base auto-assignment is not used
> when the host type is SOC.

I added a comment.

> --
> Florian
> 
