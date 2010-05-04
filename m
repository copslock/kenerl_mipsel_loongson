Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 13:33:14 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:59482 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492479Ab0EDLdI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 13:33:08 +0200
Received: by pxi1 with SMTP id 1so1671457pxi.36
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZUVC1kPdmeRgiz1QcWKC2v8/9lluutFJtxxLye5cZfc=;
        b=NdZtU4w6fz28jUVb+USN1gVKKrfln8O2+4zWM0TvSFn5GILV6y3t6FhRG472Na7xs2
         nkXlNBugjlIdLE/lnsYJOkY+flZ1bNoYgX0wPWrhzxHfYsu/X0WWjxAu4FXM3MKqMk0t
         r6tlqYWT6BHBzQDg1gq/+/ZDAZSXiUKZSlUP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=DYUEi/KtLLCHQIS0fLaX6cdXPOsuEJgEdb2TBm3qDnU9zyBb+6g5MkKD4h2usfU2yX
         DnNhbgMjMbO1EXj+vpYlrT2B/Dtj11hUTFAT9i0ugo5sh3buPbd3daJXwGC0xXhjkDDu
         +cyF4931lYjoXjHVNLiW8D1riFwdqu/MCp3ss=
Received: by 10.114.187.40 with SMTP id k40mr6342080waf.30.1272972781115;
        Tue, 04 May 2010 04:33:01 -0700 (PDT)
Received: from [192.168.2.214] ([202.201.14.140])
        by mx.google.com with ESMTPS id n32sm29183765wae.10.2010.05.04.04.32.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 04:33:00 -0700 (PDT)
Subject: Re: [PATCH 4/12] add loongson2f gpio interfact support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     yajin <yajinzhou@vm-kernel.org>
Cc:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        apatard@mandriva.com
In-Reply-To: <m2g180e2c241005040255zc1045a2fj85cb88d12c30a145@mail.gmail.com>
References: <m2g180e2c241005040255zc1045a2fj85cb88d12c30a145@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 04 May 2010 19:32:55 +0800
Message-ID: <1272972775.9547.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Yajin

Arnaud Patard have sent the gpio related patch out before:

"MIPS: Loongson 2F: Add gpio/gpioilb support"

It has been applied into the
git://www.linux-mips.org/pub/scm/linux-queue.git by Ralf and can be
browsed here:

http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=625c483738cc4609eaff7b2f69b51fb1ebff636c

So this patch is not needed and seems you are using the wrong git repo,
you need to use the linux-queue.git not the linux.git.

Regards,
	Wu Zhangjin

On Tue, 2010-05-04 at 17:55 +0800, yajin wrote:
> Add loongson2f GPIO interfact support. GPIOLIB needs these functions.
> 
> Signed-off-by: yajin <yajin@vm-kernel.org>
> ---
>  arch/mips/include/asm/mach-loongson/gpio.h |   34 +++++++
>  arch/mips/loongson/common/Makefile         |    5 +
>  arch/mips/loongson/common/gpio.c           |  145 ++++++++++++++++++++++++++++
>  3 files changed, 184 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson/gpio.h
>  create mode 100644 arch/mips/loongson/common/gpio.c
> 
> diff --git a/arch/mips/include/asm/mach-loongson/gpio.h
> b/arch/mips/include/asm/mach-loongson/gpio.h
> new file mode 100644
> index 0000000..00a7fae
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/gpio.h
> @@ -0,0 +1,34 @@
> +/*
> + * STLS2F GPIO Support
> + *
> + * Copyright (c) 2008  Richard Liu, STMicroelectronics <richard.liu@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __STLS2F_GPIO_H
> +#define __STLS2F_GPIO_H
> +
> +#include <asm-generic/gpio.h>
> +
> +extern void gpio_set_value(unsigned gpio, int value);
> +extern int gpio_get_value(unsigned gpio);
> +extern int gpio_cansleep(unsigned gpio);
> +
> +/* The chip can do interrupt
> + * but it has not been tested and doc not clear
> + */
> +static inline int gpio_to_irq(int gpio)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int irq_to_gpio(int gpio)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif                          /* __STLS2F_GPIO_H */
> diff --git a/arch/mips/loongson/common/Makefile
> b/arch/mips/loongson/common/Makefile
> index 7668c4d..404dbb5 100644
> --- a/arch/mips/loongson/common/Makefile
> +++ b/arch/mips/loongson/common/Makefile
> @@ -23,3 +23,8 @@ obj-$(CONFIG_CS5536) += cs5536/
>  #
> 
>  obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
> +
> +#
> +# Loongson 2f gpio
> +#
> +obj-$(CONFIG_GENERIC_GPIO) += gpio.o
> diff --git a/arch/mips/loongson/common/gpio.c b/arch/mips/loongson/common/gpio.c
> new file mode 100644
> index 0000000..346418a
> --- /dev/null
> +++ b/arch/mips/loongson/common/gpio.c
> @@ -0,0 +1,145 @@
> +/*
> + *  STLS2F GPIO Support
> + *
> + *  Copyright(c) 2008 Richard Liu,  STMicroelectronics  <richard.liu@st.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +#include <linux/gpio.h>
> +#include <loongson.h>
> +
> +/*
> + * North bridge of loongson 2f has 4 gpio pins.
> + * GPIO_Data: reg offset 0X1C
> + *      bit [3:0] gpio_out
> + *      bit [19:16] gpio_in
> + */
> +#define LOONGSON_GPIO_PINS      4
> +#define LOONGSON_GPIO_IN_SHIFT  16
> +
> +static DEFINE_SPINLOCK(gpio_lock);
> +
> +int gpio_get_value(unsigned gpio)
> +{
> +	u32 val;
> +	u32 mask;
> +
> +	if (gpio >= LOONGSON_GPIO_PINS)
> +		return __gpio_get_value(gpio);
> +
> +	mask = 1 << (gpio + LOONGSON_GPIO_IN_SHIFT);
> +	spin_lock(&gpio_lock);
> +	val = LOONGSON_GPIODATA;
> +	spin_unlock(&gpio_lock);
> +
> +	return ((val & mask) != 0);
> +}
> +EXPORT_SYMBOL(gpio_get_value);
> +
> +void gpio_set_value(unsigned gpio, int state)
> +{
> +	u32 val;
> +	u32 mask;
> +
> +	if (gpio >= LOONGSON_GPIO_PINS) {
> +		__gpio_set_value(gpio, state);
> +		return ;
> +	}
> +
> +	mask = 1 << gpio;
> +
> +	spin_lock(&gpio_lock);
> +	val = LOONGSON_GPIODATA;
> +	if (state)
> +		val |= mask;
> +	else
> +		val &= (~mask);
> +	LOONGSON_GPIODATA = val;
> +	spin_unlock(&gpio_lock);
> +}
> +EXPORT_SYMBOL(gpio_set_value);
> +
> +int gpio_cansleep(unsigned gpio)
> +{
> +	if (gpio < LOONGSON_GPIO_PINS)
> +		return 0;
> +	else
> +		return __gpio_cansleep(gpio);
> +}
> +EXPORT_SYMBOL(gpio_cansleep);
> +
> +static int loongson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
> +{
> +	u32 temp;
> +	u32 mask;
> +
> +	if (gpio >= LOONGSON_GPIO_PINS)
> +		return -EINVAL;
> +
> +	spin_lock(&gpio_lock);
> +	mask = 1 << gpio;
> +	temp = LOONGSON_GPIOIE;
> +	temp |= mask;
> +	LOONGSON_GPIOIE = temp;
> +	spin_unlock(&gpio_lock);
> +
> +	return 0;
> +}
> +
> +static int loongson_gpio_direction_output(struct gpio_chip *chip,
> +					  unsigned gpio, int level)
> +{
> +	u32 temp;
> +	u32 mask;
> +
> +	if (gpio >= LOONGSON_GPIO_PINS)
> +		return -EINVAL;
> +
> +	gpio_set_value(gpio, level);
> +	spin_lock(&gpio_lock);
> +	mask = 1 << gpio;
> +	temp = LOONGSON_GPIOIE;
> +	temp &= (~mask);
> +	LOONGSON_GPIOIE = temp;
> +	spin_unlock(&gpio_lock);
> +
> +	return 0;
> +}
> +
> +static int loongson_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
> +{
> +	return gpio_get_value(gpio);
> +}
> +
> +static void loongson_gpio_set_value(struct gpio_chip *chip,
> +				    unsigned gpio, int value)
> +{
> +	gpio_set_value(gpio, value);
> +}
> +
> +static struct gpio_chip loongson_gpio_chip = {
> +	.label                  = "loongson-gpio",
> +	.direction_input        = loongson_gpio_direction_input,
> +	.get                    = loongson_gpio_get_value,
> +	.direction_output       = loongson_gpio_direction_output,
> +	.set                    = loongson_gpio_set_value,
> +	.base                   = 0,
> +	.ngpio                  = LOONGSON_GPIO_PINS,
> +};
> +
> +static int __init loongson_gpio_setup(void)
> +{
> +	return gpiochip_add(&loongson_gpio_chip);
> +}
> +arch_initcall(loongson_gpio_setup);
