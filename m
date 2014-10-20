Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 08:27:38 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53331 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011870AbaJTG1gHflch (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 08:27:36 +0200
Received: by mail-ie0-f171.google.com with SMTP id tr6so4099914ieb.30
        for <multiple recipients>; Sun, 19 Oct 2014 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s933R7eMLCbN5LQs/oUwSO+mQnDIjQctB7bYhakGg+A=;
        b=fB3md338nNKs+dtJaOUIsyjp1HGK0uT1iSTHEICp0o7z2YPMEdzRFE91cmYAI/ftMj
         YsrcErNk9o22sgR4FFPw+Hx7RDBlOUYIOnfk+7zczrUtsg/1CgGgE/TXjKSSXUWXkuMn
         NlmJONFe6zl/eujotNuKXqdlNgOVr9R+7H4ztTDA8nlJR+Zd0kTj4ULY+ZnBXj1/vBIK
         R6J2ejeI6yZVDQ91kRIytOkc8r/f914z/0uz6g8iwk/FFDnYWk66no0DqVBaCIA3ZLYt
         PagXV6LhqdGx0DlSBFGbk07/SICtAJClXEZ0ka0jhgi8z6LDiIxVgJbInFow24xgeF9N
         sKWg==
X-Received: by 10.50.43.130 with SMTP id w2mr16005402igl.34.1413786449734;
 Sun, 19 Oct 2014 23:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Sun, 19 Oct 2014 23:27:09 -0700 (PDT)
In-Reply-To: <54449E43.40304@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
 <1412972930-16777-4-git-send-email-blogic@openwrt.org> <CAAVeFu+kC0RFxVfuhukFPdDLxMd3v7Eo+=7BYJ4sUh1cGSkJzw@mail.gmail.com>
 <54449E43.40304@openwrt.org>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 20 Oct 2014 15:27:09 +0900
Message-ID: <CAAVeFuKgbsrZr88qXVf9DCJEmEjLx4ZMbwjZ=szQKMSihW7=-Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] GPIO: MIPS: ralink: add gpio driver for ralink MT762x SoC
To:     John Crispin <blogic@openwrt.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Mon, Oct 20, 2014 at 2:31 PM, John Crispin <blogic@openwrt.org> wrote:
>
>
> On 20/10/2014 06:57, Alexandre Courbot wrote:
>> On Sat, Oct 11, 2014 at 5:28 AM, John Crispin <blogic@openwrt.org>
>> wrote:
>>> Add gpio driver for Ralink SoC. This driver makes the gpio core
>>> on MT7621 and MT7628 work.
>>
>> Basically I have the same remarks as for the rt2880 driver. Both
>> seem to be very similar, and to work kind of like the gpio-generic
>> driver. I wonder if there wouldn't be a way to leverage this
>> driver instead of rewriting the same logic X times?
>>
>> Some more comments below...
>>
>>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org> Cc:
>>> linux-mips@linux-mips.org Cc: linux-gpio@vger.kernel.org ---
>>> drivers/gpio/Kconfig       |    6 ++ drivers/gpio/Makefile
>>> | 1 + drivers/gpio/gpio-mt7621.c |  195
>>> ++++++++++++++++++++++++++++++++++++++++++++ 3 files changed,
>>> 202 insertions(+) create mode 100644 drivers/gpio/gpio-mt7621.c
>>>
>>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index
>>> c91b15b..1ef83a0 100644 --- a/drivers/gpio/Kconfig +++
>>> b/drivers/gpio/Kconfig @@ -523,6 +523,12 @@ config
>>> GPIO_MC9S08DZ60 help Select this to enable the MC9S08DZ60 GPIO
>>> driver
>>>
>>> +config GPIO_MT7621 +       bool "Mediatek GPIO Support" +
>>> depends on MIPS && (SOC_MT7620 || SOC_MT7621) +       help + Say
>>> yes here to support the Mediatek SoC GPIO device + config
>>> GPIO_PCA953X tristate "PCA95[357]x, PCA9698, TCA64xx, and
>>> MAX7310 I/O ports" depends on I2C diff --git
>>> a/drivers/gpio/Makefile b/drivers/gpio/Makefile index
>>> d8f0f17..60a9e0e 100644 --- a/drivers/gpio/Makefile +++
>>> b/drivers/gpio/Makefile @@ -57,6 +57,7 @@
>>> obj-$(CONFIG_GPIO_MPC8XXX)    += gpio-mpc8xxx.o
>>> obj-$(CONFIG_GPIO_MSIC)                += gpio-msic.o
>>> obj-$(CONFIG_GPIO_MSM_V1)      += gpio-msm-v1.o
>>> obj-$(CONFIG_GPIO_MSM_V2)      += gpio-msm-v2.o
>>> +obj-$(CONFIG_GPIO_MT7621)      += gpio-mt7621.o
>>> obj-$(CONFIG_GPIO_MVEBU)        += gpio-mvebu.o
>>> obj-$(CONFIG_GPIO_MXC)         += gpio-mxc.o
>>> obj-$(CONFIG_GPIO_MXS)         += gpio-mxs.o diff --git
>>> a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c new
>>> file mode 100644 index 0000000..7faf2c0 --- /dev/null +++
>>> b/drivers/gpio/gpio-mt7621.c @@ -0,0 +1,195 @@ +/* + * This
>>> program is free software; you can redistribute it and/or modify
>>> it + * under the terms of the GNU General Public License version
>>> 2 as published + * by the Free Software Foundation. + * + *
>>> Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org> + *
>>> Copyright (C) 2013 John Crispin <blogic@openwrt.org> + */ +
>>> +#include <linux/io.h> +#include <linux/err.h> +#include
>>> <linux/gpio.h> +#include <linux/module.h> +#include
>>> <linux/of_irq.h> +#include <linux/spinlock.h> +#include
>>> <linux/irqdomain.h> +#include <linux/interrupt.h> +#include
>>> <linux/platform_device.h> + +#define MTK_BANK_WIDTH         32 +
>>> +enum mediatek_gpio_reg { +       GPIO_REG_CTRL = 0, +
>>> GPIO_REG_POL, +       GPIO_REG_DATA, +       GPIO_REG_DSET, +
>>> GPIO_REG_DCLR, +}; + +static void __iomem *mtk_gc_membase; +
>>> +struct mtk_gc { +       struct gpio_chip chip; + spinlock_t
>>> lock; +       int bank; +}; + +static inline struct mtk_gc
>>> +*to_mediatek_gpio(struct gpio_chip *chip) +{ + struct mtk_gc
>>> *mgc; + +       mgc = container_of(chip, struct mtk_gc, chip); +
>>> +       return mgc; +} + +static inline void +mtk_gpio_w32(struct
>>> mtk_gc *rg, u8 reg, u32 val) +{ + iowrite32(val, mtk_gc_membase +
>>> (reg * 0x10) + (rg->bank * 0x4)); +} + +static inline u32
>>> +mtk_gpio_r32(struct mtk_gc *rg, u8 reg) +{ +       return
>>> ioread32(mtk_gc_membase + (reg * 0x10) + (rg->bank * 0x4)); +} +
>>> +static void +mediatek_gpio_set(struct gpio_chip *chip, unsigned
>>> offset, int value) +{ +       struct mtk_gc *rg =
>>> to_mediatek_gpio(chip); + +       mtk_gpio_w32(rg, (value) ?
>>> GPIO_REG_DSET : GPIO_REG_DCLR, BIT(offset)); +} + +static int
>>> +mediatek_gpio_get(struct gpio_chip *chip, unsigned offset) +{ +
>>> struct mtk_gc *rg = to_mediatek_gpio(chip); + +       return
>>> !!(mtk_gpio_r32(rg, GPIO_REG_DATA) & BIT(offset)); +} + +static
>>> int +mediatek_gpio_direction_input(struct gpio_chip *chip,
>>> unsigned offset) +{ +       struct mtk_gc *rg =
>>> to_mediatek_gpio(chip); + unsigned long flags; +       u32 t; +
>>> + spin_lock_irqsave(&rg->lock, flags); +       t =
>>> mtk_gpio_r32(rg, GPIO_REG_CTRL); +       t &= ~BIT(offset); +
>>> mtk_gpio_w32(rg, GPIO_REG_CTRL, t); +
>>> spin_unlock_irqrestore(&rg->lock, flags); + +       return 0; +}
>>> + +static int +mediatek_gpio_direction_output(struct gpio_chip
>>> *chip, +                                       unsigned offset,
>>> int value) +{ +       struct mtk_gc *rg = to_mediatek_gpio(chip);
>>> +       unsigned long flags; +       u32 t; + +
>>> spin_lock_irqsave(&rg->lock, flags); +       t = mtk_gpio_r32(rg,
>>> GPIO_REG_CTRL); +       t |= BIT(offset); + mtk_gpio_w32(rg,
>>> GPIO_REG_CTRL, t); + mediatek_gpio_set(chip, offset, value); +
>>> spin_unlock_irqrestore(&rg->lock, flags); + +       return 0; +}
>>> + +static int +mediatek_gpio_request(struct gpio_chip *chip,
>>> unsigned offset) +{ +       int gpio = chip->base + offset; + +
>>> return pinctrl_request_gpio(gpio); +} + +static void
>>> +mediatek_gpio_free(struct gpio_chip *chip, unsigned offset) +{
>>> + int gpio = chip->base + offset; + + pinctrl_free_gpio(gpio); +}
>>> + +static int +mediatek_gpio_bank_probe(struct platform_device
>>> *pdev, struct device_node *bank) +{ +       const __be32 *id =
>>> of_get_property(bank, "reg", NULL); +       struct mtk_gc *rg =
>>> devm_kzalloc(&pdev->dev, + sizeof(struct mtk_gc), GFP_KERNEL); +
>>> if (!rg || !id) + return -ENOMEM; + +
>>> spin_lock_init(&rg->lock); + + rg->chip.dev = &pdev->dev; +
>>> rg->chip.label = dev_name(&pdev->dev); +       rg->chip.of_node =
>>> bank; + rg->chip.base = MTK_BANK_WIDTH * be32_to_cpu(*id);
>>
>> Argh, no, I don't think so. The GPIO integer space is not something
>> you can arbitrarily use like this. Any value that is not -1 is
>> dangerous here.
>>
>> If you add your banks one after the other, like you are seemingly
>> doing here, then you have a high probability of ending with
>> consecutive numbers. This cannot be guaranteed 100% though. That's
>> why we are trying to get away from the integer numberspace and to
>> use GPIO descriptors instead.
>
> dou you have an example of a driver already doing so ?

AFAICT all recent GPIO drivers set chip.base to -1. This member has
not been used in age - relying on a GPIO being given a particular
number is dangerous and a bad practice generally speaking.

>
>
>
>>
>>> +       rg->chip.ngpio = MTK_BANK_WIDTH; +
>>> rg->chip.direction_input = mediatek_gpio_direction_input; +
>>> rg->chip.direction_output = mediatek_gpio_direction_output; +
>>> rg->chip.get = mediatek_gpio_get; +       rg->chip.set =
>>> mediatek_gpio_set; +       rg->chip.request =
>>> mediatek_gpio_request; +       rg->chip.free =
>>> mediatek_gpio_free; + +       /* set polarity to low for all
>>> gpios */ +       mtk_gpio_w32(rg, GPIO_REG_POL, 0); + +
>>> dev_info(&pdev->dev, "registering %d gpios\n", rg->chip.ngpio); +
>>> +       return gpiochip_add(&rg->chip); +} + +static int
>>> +mediatek_gpio_probe(struct platform_device *pdev) +{ + struct
>>> device_node *bank, *np = pdev->dev.of_node; +       struct
>>> resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0); +
>>> +       mtk_gc_membase = devm_ioremap_resource(&pdev->dev, res);
>>> +       if (IS_ERR(mtk_gc_membase)) +               return
>>> PTR_ERR(mtk_gc_membase); + +       for_each_child_of_node(np,
>>> bank) +               if (of_device_is_compatible(bank,
>>> "mediatek,mt7621-gpio-bank")) + mediatek_gpio_bank_probe(pdev,
>>> bank);
>>
>> Here you may want to make sure the banks are parsed in the right
>> order if the order of their base number matters to you. Another
>> solution would be to just have a property with the number of
>> banks, and use that instead of sub-nodes for each bank. This should
>> be doable here since your banks do not have special properties of
>> their own, nor do they differ from each other.
>>
>>
>
> that would be redundant or not "i will now list <4> banks", "here are
> the 4 banks". that is what the count helpers are for if we need to be
> aware of the number of properties prior to parsing the node.

My suggestion was to have a property indicating the number of banks,
and not listing them further.

>
> i am not sure i have seen another instance of dts using a count index
> for the following properties array/table/... do you have an example of
> a driver doing so ?

gpio-bcm-kona does something close: the number of interrupts specified
indicate how many banks the chip has. I would not rely too much on
existing bindings to decide what a "good" practice is.

Note that my question is only relevant if you care about the numbers
that your GPIOs are going to receive. The GPIO integer interface is
deprecated and our recommendation is to build your system in such a
way that you don't need to use it (something that is made easier by
DT) ; in this case your current binding would work.
