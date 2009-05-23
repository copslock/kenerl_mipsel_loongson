Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 12:17:35 +0100 (BST)
Received: from mail-ew0-f171.google.com ([209.85.219.171]:38593 "EHLO
	mail-ew0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022573AbZEWLR3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 May 2009 12:17:29 +0100
Received: by ewy19 with SMTP id 19so2487241ewy.0
        for <linux-mips@linux-mips.org>; Sat, 23 May 2009 04:17:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kZEK7jMkNMZrYWBqP1iZzziKaZ+UzKzQY/AxvWLVYBs=;
        b=uONXpgvLHnlmWDAxk7EweBBC+aWQnVqY3b/8+TRXskejLjfpXtjT0rWOnGXf4tgT7i
         n8iWqkhOWqKlqA9oD4q0/sQGLQP3L5VLivasjxeUrcnMg2ar2d+OcSn74Utb4ctwOk7l
         Moxk8w646nHyHlvk1kP6sR95UMPfjd8/xxdpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VMuwiprTNv0Yk/sy4bUORzN+UDReTMke2L0Z0q4P3upaCA1ERtgSXYLI43D9hSpkML
         uG+ZiLMBh9XEWVVtWbdkRT1FK9J3M9bWsW7urrYCaFVR3rOAUciC/uQACe/3ARNihhmB
         h0f80ev/kQ/VFOYHT90img177GltVGxXF/VBg=
Received: by 10.210.133.19 with SMTP id g19mr2148681ebd.60.1243077443624;
        Sat, 23 May 2009 04:17:23 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm3901416eyh.30.2009.05.23.04.17.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 04:17:22 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH 1/4] Alchemy: rewrite GPIO support.
Date:	Sat, 23 May 2009 13:17:21 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905231317.21470.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 22 May 2009 22:24:56 Manuel Lauss, vous avez écrit :
> The current in-kernel Alchemy GPIO support is far too inflexible for
> all my use cases.  To address this, the following changes are made:
>
> * create generic functions which deal with manipulating the on-chip
>   GPIO1/2 blocks.  These functions are universally useful.
> * Macros for shared interrupt management and GPIO2 block control.
> * support for both built-in CONFIG_GPIOLIB
>
>   If CONFIG_GPIOLIB is not enabled, provide linux gpio framework
>   compatibility by directly inlining the GPIO1/2 functions.  GPIO access
>   is limited to on-chip ones and they can be accessed as documented in
>   the datasheets (GPIO0-31 and 200-215).
>
>   If CONFIG_GPIOLIB is selected, two (2) gpio_chip-s, one for GPIO1 and
>   one for GPIO2, are registered.  GPIOs can still be accessed by using
>   the numberspace established in the databooks.
>
>   However this is not yet flexible enough for my uses:  My Alchemy
>   systems have a documented "external" gpio interface (fixed, different
>   numberspace) and can support a variety of baseboards, some of which
>   are equipped with I2C gpio expanders.  I want to be able to provide
>   the default 16 GPIOs of the CPU board numbered as 0..15 and also
>   support gpio expanders, if present, starting as gpio16.
>
>   To achieve this, a new Kconfig symbol for Alchemy is introduced,
>   CONFIG_ALCHEMY_GPIO_INDIRECT, which boards can enable to signal
>   that they don't want the Alchemy numberspace exposed to the outside
>   world, and provide their own instead.  Boards are now responsible for
>   providing the linux gpio interface glue code (either in a custom
>   gpio.h header (in board include directory) or with new gpio_chips).
>   The convenience macros for on-chip GPIO manipulation are of course
>   still usable (with the default gpio numberspace from the databooks).
>
>   To make the board-specific inlined gpio functions work, the MIPS
>   Makefile must be changed so that the mach-au1x00/gpio.h header is
>   included _after_ the board headers, by moving the inclusion of
>   the mach-au1x00/ to the end of the header list.
>
>   see arch/mips/include/asm/mach-au1x00/gpio.h for more info.
>
> Cc: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  arch/mips/Makefile                       |    5 +-
>  arch/mips/alchemy/Kconfig                |   11 +-
>  arch/mips/alchemy/common/gpio.c          |  177 +++------
>  arch/mips/include/asm/mach-au1x00/gpio.h |  612
> ++++++++++++++++++++++++++++- 4 files changed, 659 insertions(+), 146
> deletions(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index c4cae9e..c7ddef1 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -184,7 +184,6 @@ load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
>  # Common Alchemy Au1x00 stuff
>  #
>  core-$(CONFIG_SOC_AU1X00)	+= arch/mips/alchemy/common/
> -cflags-$(CONFIG_SOC_AU1X00)	+=
> -I$(srctree)/arch/mips/include/asm/mach-au1x00
>
>  #
>  # AMD Alchemy Pb1000 eval board
> @@ -282,6 +281,10 @@ load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
>  libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
>  load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
>
> +# must be last for Alchemy systems for GPIO to work properly
> +cflags-$(CONFIG_SOC_AU1X00)	+=
> -I$(srctree)/arch/mips/include/asm/mach-au1x00 +
> +
>  #
>  # Cobalt Server
>  #
> diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
> index 8128aeb..ed2b7e1 100644
> --- a/arch/mips/alchemy/Kconfig
> +++ b/arch/mips/alchemy/Kconfig
> @@ -1,3 +1,11 @@
> +
> +# select this in your board config if you don't want to use the gpio
> +# namespace as documented in the manuals.  In this case however you need
> +# to create the necessary gpio_* functions in your board code/headers!
> +# see arch/mips/include/asm/mach-au1x00/gpio.h   for more information.
> +config ALCHEMY_GPIO_INDIRECT
> +	def_bool n
> +
>  choice
>  	prompt "Machine type"
>  	depends on MACH_ALCHEMY
> @@ -134,4 +142,5 @@ config SOC_AU1X00
>  	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_APM_EMULATION
> -	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_GPIO
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> diff --git a/arch/mips/alchemy/common/gpio.c
> b/arch/mips/alchemy/common/gpio.c index 91a9c44..6d63e94 100644
> --- a/arch/mips/alchemy/common/gpio.c
> +++ b/arch/mips/alchemy/common/gpio.c
> @@ -1,6 +1,6 @@
>  /*
>   *  Copyright (C) 2007-2009, OpenWrt.org, Florian Fainelli
> <florian@openwrt.org> - *  	Architecture specific GPIO support
> + *  	GPIO support for Au1000, Au1500, Au1100, Au1550 and Au12x0.
>   *
>   *  This program is free software; you can redistribute	 it and/or modify
> it *  under  the terms of	 the GNU General  Public License as published by
> the @@ -23,10 +23,12 @@
>   *  675 Mass Ave, Cambridge, MA 02139, USA.
>   *
>   *  Notes :
> - * 	au1000 SoC have only one GPIO line : GPIO1
> - * 	others have a second one : GPIO2
> + * 	au1000 SoC have only one GPIO block : GPIO1
> + * 	Au1100, Au15x0, Au12x0 have a second one : GPIO2
>   */
>
> +#if defined(CONFIG_GPIOLIB) && !defined(CONFIG_ALCHEMY_GPIO_INDIRECT)
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
> @@ -34,168 +36,99 @@
>  #include <linux/gpio.h>
>
>  #include <asm/mach-au1x00/au1000.h>
> -#include <asm/gpio.h>
> -
> -struct au1000_gpio_chip {
> -	struct gpio_chip	chip;
> -	void __iomem		*regbase;
> -};
> +#include <asm/mach-au1x00/gpio.h>
>
>  #if !defined(CONFIG_SOC_AU1000)
> -static int au1000_gpio2_get(struct gpio_chip *chip, unsigned offset)
> +static int gpio2_get(struct gpio_chip *chip, unsigned offset)
>  {
> -	u32 mask = 1 << offset;
> -	struct au1000_gpio_chip *gpch;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -	return readl(gpch->regbase + AU1000_GPIO2_ST) & mask;
> +	return alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
>  }
>
> -static void au1000_gpio2_set(struct gpio_chip *chip,
> -				unsigned offset, int value)
> +static void gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
> -	u32 mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
> -	struct au1000_gpio_chip *gpch;
> -	unsigned long flags;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -
> -	local_irq_save(flags);
> -	writel(mask, gpch->regbase + AU1000_GPIO2_OUT);
> -	local_irq_restore(flags);
> +	alchemy_gpio2_set_value(offset + ALCHEMY_GPIO2_BASE, value);
>  }
>
> -static int au1000_gpio2_direction_input(struct gpio_chip *chip, unsigned
> offset) +static int gpio2_direction_input(struct gpio_chip *chip, unsigned
> offset) {
> -	u32 mask = 1 << offset;
> -	u32 tmp;
> -	struct au1000_gpio_chip *gpch;
> -	unsigned long flags;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -
> -	local_irq_save(flags);
> -	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
> -	tmp &= ~mask;
> -	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
> -	local_irq_restore(flags);
> -
> -	return 0;
> +	return alchemy_gpio2_direction_input(offset + ALCHEMY_GPIO2_BASE);
>  }
>
> -static int au1000_gpio2_direction_output(struct gpio_chip *chip,
> -					unsigned offset, int value)
> +static int gpio2_direction_output(struct gpio_chip *chip, unsigned offset,
> +				  int value)
>  {
> -	u32 mask = 1 << offset;
> -	u32 out_mask = ((GPIO2_OUT_EN_MASK << offset) | (!!value << offset));
> -	u32 tmp;
> -	struct au1000_gpio_chip *gpch;
> -	unsigned long flags;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -
> -	local_irq_save(flags);
> -	tmp = readl(gpch->regbase + AU1000_GPIO2_DIR);
> -	tmp |= mask;
> -	writel(tmp, gpch->regbase + AU1000_GPIO2_DIR);
> -	writel(out_mask, gpch->regbase + AU1000_GPIO2_OUT);
> -	local_irq_restore(flags);
> +	return alchemy_gpio2_direction_output(offset + ALCHEMY_GPIO2_BASE,
> +						value);
> +}
>
> -	return 0;
> +static int gpio2_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +	return alchemy_gpio2_to_irq(offset + ALCHEMY_GPIO2_BASE);
>  }
>  #endif /* !defined(CONFIG_SOC_AU1000) */
>
> -static int au1000_gpio1_get(struct gpio_chip *chip, unsigned offset)
> +static int gpio1_get(struct gpio_chip *chip, unsigned offset)
>  {
> -	u32 mask = 1 << offset;
> -	struct au1000_gpio_chip *gpch;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -	return readl(gpch->regbase + AU1000_GPIO1_ST) & mask;
> +	return alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
>  }
>
> -static void au1000_gpio1_set(struct gpio_chip *chip,
> +static void gpio1_set(struct gpio_chip *chip,
>  				unsigned offset, int value)
>  {
> -	u32 mask = 1 << offset;
> -	u32 reg_offset;
> -	struct au1000_gpio_chip *gpch;
> -	unsigned long flags;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -
> -	if (value)
> -		reg_offset = AU1000_GPIO1_OUT;
> -	else
> -		reg_offset = AU1000_GPIO1_CLR;
> -
> -	local_irq_save(flags);
> -	writel(mask, gpch->regbase + reg_offset);
> -	local_irq_restore(flags);
> +	alchemy_gpio1_set_value(offset + ALCHEMY_GPIO1_BASE, value);
>  }
>
> -static int au1000_gpio1_direction_input(struct gpio_chip *chip, unsigned
> offset) +static int gpio1_direction_input(struct gpio_chip *chip, unsigned
> offset) {
> -	u32 mask = 1 << offset;
> -	struct au1000_gpio_chip *gpch;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -	writel(mask, gpch->regbase + AU1000_GPIO1_ST);
> -
> -	return 0;
> +	return alchemy_gpio1_direction_input(offset + ALCHEMY_GPIO1_BASE);
>  }
>
> -static int au1000_gpio1_direction_output(struct gpio_chip *chip,
> +static int gpio1_direction_output(struct gpio_chip *chip,
>  					unsigned offset, int value)
>  {
> -	u32 mask = 1 << offset;
> -	struct au1000_gpio_chip *gpch;
> -
> -	gpch = container_of(chip, struct au1000_gpio_chip, chip);
> -
> -	writel(mask, gpch->regbase + AU1000_GPIO1_TRI_OUT);
> -	au1000_gpio1_set(chip, offset, value);
> +	return alchemy_gpio1_direction_output(offset + ALCHEMY_GPIO1_BASE,
> +					     value);
> +}
>
> -	return 0;
> +static int gpio1_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +	return alchemy_gpio1_to_irq(offset + ALCHEMY_GPIO1_BASE);
>  }
>
> -struct au1000_gpio_chip au1000_gpio_chip[] = {
> +struct gpio_chip alchemy_gpio_chip[] = {
>  	[0] = {
> -		.regbase			= (void __iomem *)SYS_BASE,
> -		.chip = {
> -			.label			= "au1000-gpio1",
> -			.direction_input	= au1000_gpio1_direction_input,
> -			.direction_output	= au1000_gpio1_direction_output,
> -			.get			= au1000_gpio1_get,
> -			.set			= au1000_gpio1_set,
> -			.base			= 0,
> -			.ngpio			= 32,
> -		},
> +		.label			= "alchemy-gpio1",
> +		.direction_input	= gpio1_direction_input,
> +		.direction_output	= gpio1_direction_output,
> +		.get			= gpio1_get,
> +		.set			= gpio1_set,
> +		.to_irq			= gpio1_to_irq,
> +		.base			= ALCHEMY_GPIO1_BASE,
> +		.ngpio			= ALCHEMY_GPIO1_NUM,
>  	},
>  #if !defined(CONFIG_SOC_AU1000)
>  	[1] = {
> -		.regbase                        = (void __iomem *)GPIO2_BASE,
> -		.chip = {
> -			.label                  = "au1000-gpio2",
> -			.direction_input        = au1000_gpio2_direction_input,
> -			.direction_output       = au1000_gpio2_direction_output,
> -			.get                    = au1000_gpio2_get,
> -			.set                    = au1000_gpio2_set,
> -			.base                   = AU1XXX_GPIO_BASE,
> -			.ngpio                  = 32,
> -		},
> +		.label                  = "alchemy-gpio2",
> +		.direction_input        = gpio2_direction_input,
> +		.direction_output       = gpio2_direction_output,
> +		.get                    = gpio2_get,
> +		.set                    = gpio2_set,
> +		.to_irq			= gpio2_to_irq,
> +		.base                   = ALCHEMY_GPIO2_BASE,
> +		.ngpio                  = ALCHEMY_GPIO2_NUM,
>  	},
>  #endif
>  };
>
> -static int __init au1000_gpio_init(void)
> +static int __init alchemy_gpio_init(void)
>  {
> -	gpiochip_add(&au1000_gpio_chip[0].chip);
> +	gpiochip_add(&alchemy_gpio_chip[0]);
>  #if !defined(CONFIG_SOC_AU1000)
> -	gpiochip_add(&au1000_gpio_chip[1].chip);
> +	gpiochip_add(&alchemy_gpio_chip[1]);
>  #endif
>
>  	return 0;
>  }
> -arch_initcall(au1000_gpio_init);
> +arch_initcall(alchemy_gpio_init);
>
> +#endif	/* GPIOLIB && !ALCHEMY_GPIO_INDIRECT */
> diff --git a/arch/mips/include/asm/mach-au1x00/gpio.h
> b/arch/mips/include/asm/mach-au1x00/gpio.h index 34d9b72..241ac1a 100644
> --- a/arch/mips/include/asm/mach-au1x00/gpio.h
> +++ b/arch/mips/include/asm/mach-au1x00/gpio.h
> @@ -1,33 +1,601 @@
> -#ifndef _AU1XXX_GPIO_H_
> -#define _AU1XXX_GPIO_H_
> +/*
> + * GPIO functions for Au1000, Au1500, Au1100, Au1550, Au1200
> + *
> + * Copyright (c) 2009 Manuel Lauss.
> + *
> + * Licensed under the terms outlined in the file COPYING.
> + */
>
> -#include <linux/types.h>
> +#ifndef _ALCHEMY_GPIO_H_
> +#define _ALCHEMY_GPIO_H_
>
> -#define AU1XXX_GPIO_BASE	200
> +#include <asm/mach-au1x00/au1000.h>
>
> -/* GPIO bank 1 offsets */
> -#define AU1000_GPIO1_TRI_OUT	0x0100
> -#define AU1000_GPIO1_OUT	0x0108
> -#define AU1000_GPIO1_ST		0x0110
> -#define AU1000_GPIO1_CLR	0x010C
> +/* The default GPIO numberspace as documented in the Alchemy manuals.
> + * GPIO0-31 from GPIO1 block,   GPIO200-215 from GPIO2 block.
> + */
> +#define ALCHEMY_GPIO1_BASE	0
> +#define ALCHEMY_GPIO2_BASE	200
>
> -/* GPIO bank 2 offsets */
> -#define AU1000_GPIO2_DIR	0x00
> -#define AU1000_GPIO2_RSVD	0x04
> -#define AU1000_GPIO2_OUT	0x08
> -#define AU1000_GPIO2_ST		0x0C
> -#define AU1000_GPIO2_INT	0x10
> -#define AU1000_GPIO2_EN		0x14
> +#define ALCHEMY_GPIO1_NUM	32
> +#define ALCHEMY_GPIO2_NUM	16
> +#define ALCHEMY_GPIO1_MAX 	(ALCHEMY_GPIO1_BASE + ALCHEMY_GPIO1_NUM - 1)
> +#define ALCHEMY_GPIO2_MAX	(ALCHEMY_GPIO2_BASE + ALCHEMY_GPIO2_NUM - 1)
>
> -#define GPIO2_OUT_EN_MASK	0x00010000
> +#define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
>
> -#define gpio_to_irq(gpio)	NULL
>
> -#define gpio_get_value __gpio_get_value
> -#define gpio_set_value __gpio_set_value
> +static inline int au1000_gpio1_to_irq(int gpio)
> +{
> +	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
> +}
>
> -#define gpio_cansleep __gpio_cansleep
> +static inline int au1000_gpio2_to_irq(int gpio)
> +{
> +	return -ENXIO;
> +}
> +
> +#ifdef CONFIG_SOC_AU1000
> +static inline int au1000_irq_to_gpio(int irq)
> +{
> +	if ((irq >= AU1000_GPIO_0) && (irq <= AU1000_GPIO_31))
> +		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
> +
> +	return -ENXIO;
> +}
> +#endif
> +
> +static inline int au1500_gpio1_to_irq(int gpio)
> +{
> +	gpio -= ALCHEMY_GPIO1_BASE;
> +
> +	switch (gpio) {
> +	case 0 ... 15:
> +	case 20:
> +	case 23 ... 28:	return MAKE_IRQ(1, gpio);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static inline int au1500_gpio2_to_irq(int gpio)
> +{
> +	gpio -= ALCHEMY_GPIO2_BASE;
> +
> +	switch (gpio) {
> +	case 0 ... 3:	return MAKE_IRQ(1, 16 + gpio - 0);
> +	case 4 ... 5:	return MAKE_IRQ(1, 21 + gpio - 4);
> +	case 6 ... 7:	return MAKE_IRQ(1, 29 + gpio - 6);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +#ifdef CONFIG_SOC_AU1500
> +static inline int au1500_irq_to_gpio(int irq)
> +{
> +	switch (irq) {
> +	case AU1000_GPIO_0 ... AU1000_GPIO_15:
> +	case AU1500_GPIO_20:
> +	case AU1500_GPIO_23 ... AU1500_GPIO_28:
> +		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
> +	case AU1500_GPIO_200 ... AU1500_GPIO_203:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_200) + 0;
> +	case AU1500_GPIO_204 ... AU1500_GPIO_205:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_204) + 4;
> +	case AU1500_GPIO_206 ... AU1500_GPIO_207:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
> +	case AU1500_GPIO_208_215:
> +		return ALCHEMY_GPIO2_BASE + 8;
> +	}
> +
> +	return -ENXIO;
> +}
> +#endif
> +
> +static inline int au1100_gpio1_to_irq(int gpio)
> +{
> +	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
> +}
> +
> +static inline int au1100_gpio2_to_irq(int gpio)
> +{
> +	gpio -= ALCHEMY_GPIO2_BASE;
> +
> +	if ((gpio >= 8) && (gpio <= 15))
> +		return MAKE_IRQ(0, 29);		/* shared GPIO208_215 */
> +}
> +
> +#ifdef CONFIG_SOC_AU1100
> +static inline int au1100_irq_to_gpio(int irq)
> +{
> +	switch (irq) {
> +	case AU1000_GPIO_0 ... AU1000_GPIO_31:
> +		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
> +	case AU1100_GPIO_208_215:
> +		return ALCHEMY_GPIO2_BASE + 8;
> +	}
> +
> +	return -ENXIO;
> +}
> +#endif
> +
> +static inline int au1550_gpio1_to_irq(int gpio)
> +{
> +	gpio -= ALCHEMY_GPIO1_BASE;
> +
> +	switch (gpio) {
> +	case 0 ... 15:
> +	case 20 ... 28:	return MAKE_IRQ(1, gpio);
> +	case 16 ... 17:	return MAKE_IRQ(1, 18 + gpio - 16);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static inline int au1550_gpio2_to_irq(int gpio)
> +{
> +	gpio -= ALCHEMY_GPIO2_BASE;
> +
> +	switch (gpio) {
> +	case 0:		return MAKE_IRQ(1, 16);
> +	case 1 ... 5:	return MAKE_IRQ(1, 17);	/* shared GPIO201_205 */
> +	case 6 ... 7:	return MAKE_IRQ(1, 29 + gpio - 6);
> +	case 8 ... 15:	return MAKE_IRQ(1, 31);	/* shared GPIO208_215 */
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +#ifdef CONFIG_SOC_AU1550
> +static inline int au1550_irq_to_gpio(int irq)
> +{
> +	switch (irq) {
> +	case AU1000_GPIO_0 ... AU1000_GPIO_15:
> +		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
> +	case AU1550_GPIO_200:
> +	case AU1500_GPIO_201_205:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1550_GPIO_200) + 0;
> +	case AU1500_GPIO_16 ... AU1500_GPIO_28:
> +		return ALCHEMY_GPIO1_BASE + (irq - AU1500_GPIO_16) + 16;
> +	case AU1500_GPIO_206 ... AU1500_GPIO_208_218:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1500_GPIO_206) + 6;
> +	}
> +
> +	return -ENXIO;
> +}
> +#endif
> +
> +static inline int au1200_gpio1_to_irq(int gpio)
> +{
> +	return MAKE_IRQ(1, gpio - ALCHEMY_GPIO1_BASE);
> +}
> +
> +static inline int au1200_gpio2_to_irq(int gpio)
> +{
> +	gpio -= ALCHEMY_GPIO2_BASE;
> +
> +	switch (gpio) {
> +	case 0 ... 2:	return MAKE_IRQ(0, 5 + gpio - 0);
> +	case 3:		return MAKE_IRQ(0, 22);
> +	case 4 ... 7:	return MAKE_IRQ(0, 24 + gpio - 4);
> +	case 8 ... 15:	return MAKE_IRQ(0, 28);	/* shared GPIO208_215 */
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +#ifdef CONFIG_SOC_AU1200
> +static inline int au1200_irq_to_gpio(int irq)
> +{
> +	switch (irq) {
> +	case AU1000_GPIO_0 ... AU1000_GPIO_31:
> +		return ALCHEMY_GPIO1_BASE + (irq - AU1000_GPIO_0) + 0;
> +	case AU1200_GPIO_200 ... AU1200_GPIO_202:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_200) + 0;
> +	case AU1200_GPIO_203:
> +		return ALCHEMY_GPIO2_BASE + 3;
> +	case AU1200_GPIO_204 ... AU1200_GPIO_208_215:
> +		return ALCHEMY_GPIO2_BASE + (irq - AU1200_GPIO_204) + 4;
> +	}
> +
> +	return -ENXIO;
> +}
> +#endif
> +
> +/*
> + * GPIO1 block macros for common linux gpio functions.
> + */
> +static inline void alchemy_gpio1_set_value(int gpio, int v)
> +{
> +	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
> +	unsigned long r = v ? SYS_OUTPUTSET : SYS_OUTPUTCLR;
> +	au_writel(mask, r);
> +	au_sync();
> +}
> +
> +static inline int alchemy_gpio1_get_value(int gpio)
> +{
> +	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
> +	return au_readl(SYS_PINSTATERD) & mask;
> +}
> +
> +static inline int alchemy_gpio1_direction_input(int gpio)
> +{
> +	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO1_BASE);
> +	au_writel(mask, SYS_TRIOUTCLR);
> +	au_sync();
> +	return 0;
> +}
> +
> +static inline int alchemy_gpio1_direction_output(int gpio, int v)
> +{
> +	/* hardware switches to "output" mode when one of the two
> +	 * "set_value" registers is accessed.
> +	 */
> +	alchemy_gpio1_set_value(gpio, v);
> +	return 0;
> +}
> +
> +static inline int alchemy_gpio1_is_valid(int gpio)
> +{
> +	return ((gpio >= ALCHEMY_GPIO1_BASE) && (gpio <= ALCHEMY_GPIO1_MAX));
> +}
> +
> +static inline int alchemy_gpio1_to_irq(int gpio)
> +{
> +#if defined(CONFIG_SOC_AU1000)
> +	return au1000_gpio1_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1100)
> +	return au1100_gpio1_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1500)
> +	return au1500_gpio1_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1550)
> +	return au1550_gpio1_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1200)
> +	return au1200_gpio1_to_irq(gpio);
> +#else
> +	return -ENXIO;
> +#endif
> +}
> +
> +/*
> + * GPIO2 block macros for common linux GPIO functions. The 'gpio'
> + * parameter must be in range of ALCHEMY_GPIO2_BASE..ALCHEMY_GPIO2_MAX.
> + */
> +/* unlocked versions of to_input/to_output */
> +static inline void __alchemy_gpio2_to_output(int gpio)
> +{
> +	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
> +	unsigned long d = au_readl(GPIO2_DIR);
> +	d |= mask;
> +	au_writel(d, GPIO2_DIR);
> +	au_sync();
> +}
> +
> +static inline void __alchemy_gpio2_to_input(int gpio)
> +{
> +	unsigned long mask = 1 << (gpio - ALCHEMY_GPIO2_BASE);
> +	unsigned long d = au_readl(GPIO2_DIR);
> +	d &= ~mask;
> +	au_writel(d, GPIO2_DIR);
> +	au_sync();
> +}
> +
> +static inline void alchemy_gpio2_set_value(int gpio, int v)
> +{
> +	unsigned long mask;
> +	mask = ((v) ? 0x00010001 : 0x00010000) << (gpio - ALCHEMY_GPIO2_BASE);
> +	au_writel(mask, GPIO2_OUTPUT);
> +	au_sync();
> +}
> +
> +static inline int alchemy_gpio2_get_value(int gpio)
> +{
> +	return au_readl(GPIO2_PINSTATE) & (1 << (gpio - ALCHEMY_GPIO2_BASE));
> +}
> +
> +static inline int alchemy_gpio2_direction_input(int gpio)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	__alchemy_gpio2_to_input(gpio);
> +	local_irq_restore(flags);
> +	return 0;
> +}
> +
> +static inline int alchemy_gpio2_direction_output(int gpio, int v)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	__alchemy_gpio2_to_output(gpio);
> +	local_irq_restore(flags);
> +	alchemy_gpio2_set_value(gpio, v);
> +	return 0;
> +}
> +
> +static inline int alchemy_gpio2_is_valid(int gpio)
> +{
> +	return ((gpio >= ALCHEMY_GPIO2_BASE) && (gpio <= ALCHEMY_GPIO2_MAX));
> +}
> +
> +static inline int alchemy_gpio2_to_irq(int gpio)
> +{
> +#if defined(CONFIG_SOC_AU1000)
> +	return au1000_gpio2_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1100)
> +	return au1100_gpio2_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1500)
> +	return au1500_gpio2_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1550)
> +	return au1550_gpio2_to_irq(gpio);
> +#elif defined(CONFIG_SOC_AU1200)
> +	return au1200_gpio2_to_irq(gpio);
> +#else
> +	return -ENXIO;
> +#endif
> +}
> +
> +/**********************************************************************/
> +
> +/* GPIO2 shared interrupts and control */
> +
> +static inline void __alchemy_gpio2_mod_int(int gpio2, int en)
> +{
> +	unsigned long r = au_readl(GPIO2_INTENABLE);
> +	if (en)
> +		r |= 1 << gpio2;
> +	else
> +		r &= ~(1 << gpio2);
> +	au_writel(r, GPIO2_INTENABLE);
> +	au_sync();
> +}
> +
> +/**
> + * alchemy_gpio2_enable_int - Enable a GPIO2 pins' shared irq
> contribution. + * @gpio2:	The GPIO2 pin to activate (200...215).
> + *
> + * GPIO208-215 have one shared interrupt line to the INTC.  They are
> + * and'ed with a per-pin enable bit and finally or'ed together to form
> + * a single irq request (useful for active-high sources).
> + * With this function, a pins' individual contribution to the int request
> + * can be enabled.  As with all other GPIO-based interrupts, the INTC
> + * must be programmed to accept the GPIO208_215 interrupt as well.
> + *
> + * NOTE: Calling this macro is only necessary for GPIO208-215; all other
> + * GPIO2-based interrupts have their own request to the INTC.  Please
> + * consult your Alchemy databook for more information!
> + *
> + * NOTE: On the Au1550, GPIOs 201-205 also have a shared interrupt request
> + * line to the INTC, GPIO201_205.  This function can be used for those
> + * as well.
> + *
> + * NOTE: 'gpio2' parameter must be in range of the GPIO2 numberspace
> + * (200-215 by default). No sanity checks are made,
> + */
> +static inline void alchemy_gpio2_enable_int(int gpio2)
> +{
> +	unsigned long flags;
> +
> +	gpio2 -= ALCHEMY_GPIO2_BASE;
> +
> +#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
> +	/* Au1100/Au1500 have GPIO208-215 enable bits at 0..7 */
> +	gpio2 -= 8;
> +#endif
> +	local_irq_save(flags);
> +	__alchemy_gpio2_mod_int(gpio2, 0);
> +	local_irq_restore(flags);
> +}
> +
> +/**
> + * alchemy_gpio2_disable_int - Disable a GPIO2 pins' shared irq
> contribution. + * @gpio2:	The GPIO2 pin to activate (200...215).
> + *
> + * see function alchemy_gpio2_enable_int() for more information.
> + */
> +static inline void alchemy_gpio2_disable_int(int gpio2)
> +{
> +	unsigned long flags;
> +
> +	gpio2 -= ALCHEMY_GPIO2_BASE;
> +
> +#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1500)
> +	/* Au1100/Au1500 have GPIO208-215 enable bits at 0..7 */
> +	gpio2 -= 8;
> +#endif
> +	local_irq_save(flags);
> +	__alchemy_gpio2_mod_int(gpio2, 0);
> +	local_irq_restore(flags);
> +}
> +
> +/**
> + * alchemy_gpio2_enable -  Activate GPIO2 block.
> + *
> + * The GPIO2 block must be enabled excplicitly to work.  On systems
> + * where this isn't done by the bootloader, this macro can be used.
> + */
> +static inline void alchemy_gpio2_enable(void)
> +{
> +	au_writel(3, GPIO2_ENABLE);	/* reset, clock enabled */
> +	au_sync();
> +	au_writel(1, GPIO2_ENABLE);	/* clock enabled */
> +	au_sync();
> +}
> +
> +/**
> + * alchemy_gpio2_disable - disable GPIO2 block.
> + *
> + * Disable and put GPIO2 block in low-power mode.
> + */
> +static inline void alchemy_gpio2_disable(void)
> +{
> +	au_writel(2, GPIO2_ENABLE);	/* reset, clock disabled */
> +	au_sync();
> +}
> +
> +/**********************************************************************/
> +
> +/* wrappers for on-chip gpios; can be used before gpio chips have been
> + * registered with gpiolib.
> + */
> +static inline int alchemy_gpio_direction_input(int gpio)
> +{
> +	return (gpio >= ALCHEMY_GPIO2_BASE) ?
> +		alchemy_gpio2_direction_input(gpio) :
> +		alchemy_gpio1_direction_input(gpio);
> +}
> +
> +static inline int alchemy_gpio_direction_output(int gpio, int v)
> +{
> +	return (gpio >= ALCHEMY_GPIO2_BASE) ?
> +		alchemy_gpio2_direction_output(gpio, v) :
> +		alchemy_gpio1_direction_output(gpio, v);
> +}
> +
> +static inline int alchemy_gpio_get_value(int gpio)
> +{
> +	return (gpio >= ALCHEMY_GPIO2_BASE) ?
> +		alchemy_gpio2_get_value(gpio) :
> +		alchemy_gpio1_get_value(gpio);
> +}
> +
> +static inline void alchemy_gpio_set_value(int gpio, int v)
> +{
> +	if (gpio >= ALCHEMY_GPIO2_BASE)
> +		alchemy_gpio2_set_value(gpio, v);
> +	else
> +		alchemy_gpio1_set_value(gpio, v);
> +}
> +
> +static inline int alchemy_gpio_is_valid(int gpio)
> +{
> +	return (gpio >= ALCHEMY_GPIO2_BASE) ?
> +		alchemy_gpio2_is_valid(gpio) :
> +		alchemy_gpio1_is_valid(gpio);
> +}
> +
> +static inline int alchemy_gpio_cansleep(int gpio)
> +{
> +	return 0;	/* Alchemy never gets tired */
> +}
> +
> +static inline int alchemy_gpio_to_irq(int gpio)
> +{
> +	return (gpio >= ALCHEMY_GPIO2_BASE) ?
> +		alchemy_gpio2_to_irq(gpio) :
> +		alchemy_gpio1_to_irq(gpio);
> +}
> +
> +static inline int alchemy_irq_to_gpio(int irq)
> +{
> +#if defined(CONFIG_SOC_AU1000)
> +	return au1000_irq_to_gpio(irq);
> +#elif defined(CONFIG_SOC_AU1100)
> +	return au1100_irq_to_gpio(irq);
> +#elif defined(CONFIG_SOC_AU1500)
> +	return au1500_irq_to_gpio(irq);
> +#elif defined(CONFIG_SOC_AU1550)
> +	return au1550_irq_to_gpio(irq);
> +#elif defined(CONFIG_SOC_AU1200)
> +	return au1200_irq_to_gpio(irq);
> +#else
> +	return -ENXIO;
> +#endif
> +}
> +
> +/**********************************************************************/
> +
> +/* Linux gpio framework integration.
> + *
> + * 4 use cases of Au1000-Au1200 GPIOS:
> + *(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
> + *	Board must register gpiochips.
> + *(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
> + *	2 (1 for Au1000) gpio_chips are registered.
> + *
> + *(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
> + *	the boards' gpio.h must provide	the linux gpio wrapper functions,
> + *
> + *(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
> + *	inlinable gpio functions are provided which enable access to the
> + *	Au1000 gpios only by using the numbers straight out of the data-
> + *	sheets.
> +
> + * Cases 1 and 3 are intended for boards which want to provide their own
> + * GPIO namespace and -operations (i.e. for example you have 8 GPIOs
> + * which are in part provided by spare Au1000 GPIO pins and in part by
> + * an external FPGA but you still want them to be accssible in linux
> + * as gpio0-7. The board can of course use the alchemy_gpioX_* functions
> + * as required).
> + */
> +
> +#ifndef CONFIG_GPIOLIB
> +
> +
> +#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (4) */
> +
> +static inline int gpio_direction_input(int gpio)
> +{
> +	return alchemy_gpio_direction_input(gpio);
> +}
> +
> +static inline int gpio_direction_output(int gpio, int v)
> +{
> +	return alchemy_gpio_direction_output(gpio, v);
> +}
> +
> +static inline int gpio_get_value(int gpio)
> +{
> +	return alchemy_gpio_get_value(gpio);
> +}
> +
> +static inline void gpio_set_value(int gpio, int v)
> +{
> +	alchemy_gpio_set_value(gpio, v);
> +}
> +
> +static inline int gpio_is_valid(int gpio)
> +{
> +	return alchemy_gpio_is_valid(gpio);
> +}
> +
> +static inline int gpio_cansleep(int gpio)
> +{
> +	return alchemy_gpio_cansleep(gpio);
> +}
> +
> +static inline int gpio_to_irq(int gpio)
> +{
> +	return alchemy_gpio_to_irq(gpio);
> +}
> +
> +static inline int irq_to_gpio(int irq)
> +{
> +	return alchemy_irq_to_gpio(irq);
> +}
> +
> +#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
> +
> +
> +#else	/* CONFIG GPIOLIB */
> +
> +
> + /* using gpiolib to provide up to 2 gpio_chips for on-chip gpios */
> +#ifndef CONFIG_ALCHEMY_GPIO_INDIRECT	/* case (2) */
> +
> +/* get everything through gpiolib */
> +#define gpio_to_irq	__gpio_to_irq
> +#define gpio_get_value	__gpio_get_value
> +#define gpio_set_value	__gpio_set_value
> +#define gpio_cansleep	__gpio_cansleep
> +#define irq_to_gpio	alchemy_irq_to_gpio
>
>  #include <asm-generic/gpio.h>
>
> -#endif /* _AU1XXX_GPIO_H_ */
> +#endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
> +
> +
> +#endif	/* !CONFIG_GPIOLIB */
> +
> +#endif /* _ALCHEMY_GPIO_H_ */



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
