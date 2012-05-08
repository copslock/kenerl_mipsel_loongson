Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 16:13:50 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41456 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903633Ab2EHONk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 16:13:40 +0200
Message-ID: <4FA929BA.9020702@openwrt.org>
Date:   Tue, 08 May 2012 16:12:10 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-4-git-send-email-blogic@openwrt.org> <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com>
In-Reply-To: <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Linus,

Thanks. I will fold your comments with Stephen's into a V2 and resend it.

> Shouldn't this be:
>
> depends on SOC_TYPE_XWAY
> depends on PINCTRL_LANTIQ
>
> ?
>
> So LANTIQ selects it's pinctrl driver, the the xway SoC
> selects its driver and they both are dependent on their
> respective system.
>
The whole select/depends part is broken. I will clean this up properly

>> diff --git a/drivers/pinctrl/pinctrl-lantiq.h b/drivers/pinctrl/pinctrl-lantiq.h
>> +#define ARRAY_AND_SIZE(x)      (x), ARRAY_SIZE(x)
I was actually considering to drop this. Having a "," inside a macro is
a bit ugly.
It leads to the calling code invoking the function with N-1 parameters,
although the function takes N parameters. I find this a bit
confusing/inconsistent.


>> +/* macros to help us access the registers */
>> +#define gpio_getbit(m, r, p)   (!!(ltq_r32(m + r) & (1 << p)))
>> +#define gpio_setbit(m, r, p)   ltq_w32_mask(0, (1 << p), m + r)
>> +#define gpio_clearbit(m, r, p) ltq_w32_mask((1 << p), 0, m + r)
> So what makes this arch so fantastic that it needs its own read/write functions?
> (Just curious...)
Nothing. Its a legacy macro from a few years ago when I first added
lantiq support inside openwrt. I personally like the macro. I use it
wherever I access lantiq registers.
When accessing generic memory ranges, as in the nand driver, I use
writeb() and co.

Matter of taste really. I would prefer to keep it this way if there are
no guidelines against it.

>> +/* ---------  gpio_chip related code --------- */
>> +
>> +int gpio_to_irq(unsigned int gpio)
>> +{
>> +       return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(gpio_to_irq);
>> +
>> +int irq_to_gpio(unsigned int gpio)
>> +{
>> +       return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(irq_to_gpio);
> Can't you just leave them undefined?

I just checked how ARM does it. They use
   arch/arm/include/asm/gpio.h

Let me talk to Ralf about this and make a MIPS version of said header file.

Thanks,
John
