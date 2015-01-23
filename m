Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2015 08:15:29 +0100 (CET)
Received: from mail-qg0-f54.google.com ([209.85.192.54]:38799 "EHLO
        mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010716AbbAWHPXQchTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jan 2015 08:15:23 +0100
Received: by mail-qg0-f54.google.com with SMTP id q108so4899517qgd.13;
        Thu, 22 Jan 2015 23:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RB3yPJOot6ZJTkHPPcy2zlbqyhOJVKIPUEk06tkyGM8=;
        b=dYh2bEPlmmaU7UTxS0kPCYIPSxlYnO+SDgfU/bRkEzPLuADOe7WH1Km1HMUPVd9PWW
         l4l9Erw6bZpdRYSP3zkDA4vsEwD+L3Zh9H9CPSLpxMrkyc7exekaSIPKP7j2yRoOCFJN
         th78Dj6rbr//GckhAwNo1Rq66T5eMnFharDdnOzprl7nZFfmukJEAArsjAw2Czt3jZnT
         kVAEk+zobP++JA3wW9bDnAGB56a+lsIS5cSThkvBo6oXlZE61zA4rhFUiIUlmhRA16+V
         twdeorYVwGI7lJdrmidnnmYSPEesIyw3LBjTg5t5+t7WBRms5WRCyq6psLB4//fq+JW7
         oVdg==
MIME-Version: 1.0
X-Received: by 10.140.82.47 with SMTP id g44mr10511767qgd.42.1421997317335;
 Thu, 22 Jan 2015 23:15:17 -0800 (PST)
Received: by 10.140.82.7 with HTTP; Thu, 22 Jan 2015 23:15:17 -0800 (PST)
In-Reply-To: <CAAVeFu+-m98_O1poRaxurDiUFkFu6t93On4ZM6xMWVW0-3Uvzw@mail.gmail.com>
References: <1419742654-15094-1-git-send-email-chenhc@lemote.com>
        <CAAVeFu+-m98_O1poRaxurDiUFkFu6t93On4ZM6xMWVW0-3Uvzw@mail.gmail.com>
Date:   Fri, 23 Jan 2015 15:15:17 +0800
X-Google-Sender-Auth: C0rFzqiSgvLGzgvIykgFvV5yzeY
Message-ID: <CAAhV-H5AE4fStmu4sHfRCUL=AVXTh7PzPfwMV6-sDRmSqoY7fA@mail.gmail.com>
Subject: Re: [PATCH V6 3/8] MIPS: Cleanup Loongson-2F's gpio driver
From:   Huacai Chen <chenhc@lemote.com>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Alexandre

I think all "(gpio >= STLS2F_N_GPIO)" can be removed in this file, not
only ls2f_gpio_get_value() and ls2f_gpio_set_value(), am I right?

Huacai

On Mon, Jan 19, 2015 at 2:17 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Sun, Dec 28, 2014 at 1:57 PM, Huacai Chen <chenhc@lemote.com> wrote:
>> This cleanup is prepare to move the driver to drivers/gpio. Custom
>> definitions of gpio_get_value()/gpio_set_value() are dropped.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/mach-loongson/gpio.h |   15 +++---
>>  arch/mips/loongson/common/gpio.c           |   82 +++++++++++-----------------
>>  2 files changed, 39 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/mach-loongson/gpio.h b/arch/mips/include/asm/mach-loongson/gpio.h
>> index 211a7b7..b3b2169 100644
>> --- a/arch/mips/include/asm/mach-loongson/gpio.h
>> +++ b/arch/mips/include/asm/mach-loongson/gpio.h
>> @@ -1,8 +1,9 @@
>>  /*
>> - * STLS2F GPIO Support
>> + * Loongson GPIO Support
>>   *
>>   * Copyright (c) 2008  Richard Liu, STMicroelectronics <richard.liu@st.com>
>>   * Copyright (c) 2008-2010  Arnaud Patard <apatard@mandriva.com>
>> + * Copyright (c) 2014  Huacai Chen <chenhc@lemote.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -10,14 +11,14 @@
>>   * (at your option) any later version.
>>   */
>>
>> -#ifndef __STLS2F_GPIO_H
>> -#define __STLS2F_GPIO_H
>> +#ifndef __LOONGSON_GPIO_H
>> +#define __LOONGSON_GPIO_H
>>
>>  #include <asm-generic/gpio.h>
>>
>> -extern void gpio_set_value(unsigned gpio, int value);
>> -extern int gpio_get_value(unsigned gpio);
>> -extern int gpio_cansleep(unsigned gpio);
>> +#define gpio_get_value __gpio_get_value
>> +#define gpio_set_value __gpio_set_value
>> +#define gpio_cansleep __gpio_cansleep
>>
>>  /* The chip can do interrupt
>>   * but it has not been tested and doc not clear
>> @@ -32,4 +33,4 @@ static inline int irq_to_gpio(int gpio)
>>         return -EINVAL;
>>  }
>>
>> -#endif                         /* __STLS2F_GPIO_H */
>> +#endif /* __LOONGSON_GPIO_H */
>> diff --git a/arch/mips/loongson/common/gpio.c b/arch/mips/loongson/common/gpio.c
>> index 29dbaa2..087aac3 100644
>> --- a/arch/mips/loongson/common/gpio.c
>> +++ b/arch/mips/loongson/common/gpio.c
>> @@ -24,55 +24,6 @@
>>
>>  static DEFINE_SPINLOCK(gpio_lock);
>>
>> -int gpio_get_value(unsigned gpio)
>> -{
>> -       u32 val;
>> -       u32 mask;
>> -
>> -       if (gpio >= STLS2F_N_GPIO)
>> -               return __gpio_get_value(gpio);
>> -
>> -       mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
>> -       spin_lock(&gpio_lock);
>> -       val = LOONGSON_GPIODATA;
>> -       spin_unlock(&gpio_lock);
>> -
>> -       return (val & mask) != 0;
>> -}
>> -EXPORT_SYMBOL(gpio_get_value);
>> -
>> -void gpio_set_value(unsigned gpio, int state)
>> -{
>> -       u32 val;
>> -       u32 mask;
>> -
>> -       if (gpio >= STLS2F_N_GPIO) {
>> -               __gpio_set_value(gpio, state);
>> -               return ;
>> -       }
>> -
>> -       mask = 1 << gpio;
>> -
>> -       spin_lock(&gpio_lock);
>> -       val = LOONGSON_GPIODATA;
>> -       if (state)
>> -               val |= mask;
>> -       else
>> -               val &= (~mask);
>> -       LOONGSON_GPIODATA = val;
>> -       spin_unlock(&gpio_lock);
>> -}
>> -EXPORT_SYMBOL(gpio_set_value);
>> -
>> -int gpio_cansleep(unsigned gpio)
>> -{
>> -       if (gpio < STLS2F_N_GPIO)
>> -               return 0;
>> -       else
>> -               return __gpio_cansleep(gpio);
>> -}
>> -EXPORT_SYMBOL(gpio_cansleep);
>> -
>>  static int ls2f_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
>>  {
>>         u32 temp;
>> @@ -113,13 +64,41 @@ static int ls2f_gpio_direction_output(struct gpio_chip *chip,
>>
>>  static int ls2f_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
>>  {
>> -       return gpio_get_value(gpio);
>> +       u32 val;
>> +       u32 mask;
>> +
>> +       if (gpio >= STLS2F_N_GPIO)
>> +               return __gpio_get_value(gpio);
>> +
>> +       mask = 1 << (gpio + STLS2F_GPIO_IN_OFFSET);
>> +       spin_lock(&gpio_lock);
>> +       val = LOONGSON_GPIODATA;
>> +       spin_unlock(&gpio_lock);
>
> Careful, you are not anymore dealing with absolute GPIO numbers like
> your former custom gpio_get_value() function did.
>
> This function will be called by the gpiolib core after it has matched
> the GPIO to your chip. So testing for gpio >= STLS2F_N_GPIO is not
> needed.
>
> Furthermore, the passed GPIO number will be relative to the chip's
> base index. In your case it seems like the base is 0, so this doesn't
> change anything, but be aware of this fact.
>
>> +
>> +       return (val & mask) != 0;
>>  }
>>
>>  static void ls2f_gpio_set_value(struct gpio_chip *chip,
>>                 unsigned gpio, int value)
>>  {
>> -       gpio_set_value(gpio, value);
>> +       u32 val;
>> +       u32 mask;
>> +
>> +       if (gpio >= STLS2F_N_GPIO) {
>> +               __gpio_set_value(gpio, value);
>> +               return;
>> +       }
>> +
>> +       mask = 1 << gpio;
>> +
>> +       spin_lock(&gpio_lock);
>> +       val = LOONGSON_GPIODATA;
>> +       if (value)
>> +               val |= mask;
>> +       else
>> +               val &= (~mask);
>> +       LOONGSON_GPIODATA = val;
>
> Same thing here.
>
> Since this is a potentially dangerous refactoring of this driver, I'd
> like a statement that confirms it is still working properly after
> patches 3, 4, and 5 of this series. IOW, please test your driver after
> each of these patches to ensure the refactoring is done properly.
>
