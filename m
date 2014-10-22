Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 17:22:48 +0200 (CEST)
Received: from mail-yh0-f47.google.com ([209.85.213.47]:54343 "EHLO
        mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012130AbaJVPWp4XFY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 17:22:45 +0200
Received: by mail-yh0-f47.google.com with SMTP id c41so3649695yho.6
        for <multiple recipients>; Wed, 22 Oct 2014 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rbA0mvH8qDfeton8O8EPK8KhSbSnZsi3rft5wZf0Bo4=;
        b=NOsXspif7lOALVsSybAEPXDDroQ+iVk2eo3vUEYvLBF+2q3qizEr3BKi7L0HdyLR9V
         0XXmMlH9leZpSeW0Kv8YVvOt1NC+EjDXazm+zPf/GW2nMU59rL/3rZQk8ga7kKDIE3As
         vZXtNre5uLWqGwL1+aeKJeklnASyeL8ZOLNZDNvWdzQISGrFLH/InQQWmEmyGd55N5ZJ
         XDUxro9iA3YPQX0La9vFM6+ycj42U5gHleL3DdVkFM/HT2NS+qysLQPa4lDLuyNNT54t
         NCjS2MyOpHr/oIWQWmCOnsDurS6lUUMSLpv+38CfpDwz3te24CcI44gxIcksfmZKFrBV
         QwpQ==
X-Received: by 10.236.201.102 with SMTP id a66mr60147015yho.1.1413991358740;
 Wed, 22 Oct 2014 08:22:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Wed, 22 Oct 2014 08:22:18 -0700 (PDT)
In-Reply-To: <54476D5B.3070503@openwrt.org>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-10-git-send-email-ryazanov.s.a@gmail.com> <54476D5B.3070503@openwrt.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 22 Oct 2014 19:22:18 +0400
Message-ID: <CAHNKnsThJbdxrSNgNKBWf0MUSYb676QW3wjg+3bLt65K7o-0nw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] MIPS: ath25: register various chip devices
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-10-22 12:39 GMT+04:00 John Crispin <blogic@openwrt.org>:
> On 22/10/2014 01:03, Sergey Ryazanov wrote:
>> Register GPIO, watchdog and flash devices.
>>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com> ---
>>
>> Changes since v1: - rename MIPS machine ar231x -> ath25
>>
>> arch/mips/ath25/Kconfig                        |  2 +
>> arch/mips/ath25/ar2315.c                       | 86
>> +++++++++++++++++++++++++- arch/mips/ath25/ar5312.c
>> | 53 +++++++++++++++-
>> arch/mips/include/asm/mach-ath25/ar2315_regs.h |  5 ++
>> arch/mips/include/asm/mach-ath25/ar5312_regs.h |  2 + 5 files
>> changed, 144 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/ath25/Kconfig b/arch/mips/ath25/Kconfig
>> index ca3dde4..7bcdbf3 100644 --- a/arch/mips/ath25/Kconfig +++
>> b/arch/mips/ath25/Kconfig @@ -1,9 +1,11 @@ config SOC_AR5312 bool
>> "Atheros AR5312/AR2312+ SoC support" depends on ATH25 +       select
>> GPIO_AR5312 default y
>>
>> config SOC_AR2315 bool "Atheros AR2315+ SoC support" depends on
>> ATH25 +       select GPIO_AR2315 default y
>
> please do not select these 2 until the driver
>
Ok

>
>> diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
>> index f239035..ac784d7 100644 --- a/arch/mips/ath25/ar2315.c +++
>> b/arch/mips/ath25/ar2315.c @@ -16,7 +16,10 @@
>>
>> #include <linux/init.h> #include <linux/kernel.h> +#include
>> <linux/platform_device.h> #include <linux/reboot.h> +#include
>> <linux/delay.h> +#include <linux/gpio.h> #include <asm/bootinfo.h>
>> #include <asm/reboot.h> #include <asm/time.h> @@ -136,6 +139,66 @@
>> void __init ar2315_arch_init_irq(void)
>> irq_set_chained_handler(AR2315_IRQ_MISC, ar2315_misc_irq_handler);
>> }
>>
>> +static struct resource ar2315_spiflash_res[] = { +   { +             .name =
>> "spiflash_read", +            .flags = IORESOURCE_MEM, +              .start =
>> AR2315_SPI_READ, +            .end = AR2315_SPI_READ + 0x1000000 - 1, +       }, +
>> { +           .name = "spiflash_mmr", +               .flags = IORESOURCE_MEM, +              .start
>> = AR2315_SPI_MMR, +           .end = AR2315_SPI_MMR + 12 - 1, +       }, +}; +
>> +static struct platform_device ar2315_spiflash = { +  .id = -1, +
>> .name = "ar2315-spiflash", +  .resource = ar2315_spiflash_res, +
>> .num_resources = ARRAY_SIZE(ar2315_spiflash_res) +}; + +static
>> struct resource ar2315_wdt_res[] = { +        { +             .flags =
>> IORESOURCE_MEM, +             .start = AR2315_WD, +           .end = AR2315_WD + 8 -
>> 1, +  }, +    { +             .flags = IORESOURCE_IRQ, +      } +}; + +static struct
>> platform_device ar2315_wdt = { +      .id = -1, +     .name = "ar2315-wdt",
>> +     .resource = ar2315_wdt_res, +   .num_resources =
>> ARRAY_SIZE(ar2315_wdt_res) +}; + +static struct resource
>> ar2315_gpio_res[] = { +       { +             .name = "ar2315-gpio", +                .flags =
>> IORESOURCE_MEM, +             .start = AR2315_GPIO, +         .end = AR2315_GPIO +
>> 0x10 - 1, +   }, +    { +             .name = "ar2315-gpio", +                .flags =
>> IORESOURCE_IRQ, +     }, +}; + +static struct platform_device
>> ar2315_gpio = { +     .id = -1, +     .name = "ar2315-gpio", +        .resource =
>> ar2315_gpio_res, +    .num_resources = ARRAY_SIZE(ar2315_gpio_res)
>> +}; +
>
> i think none of these needs to be part of the series. add them with
> their corresponding drivers please
>
Ok

>> /* * NB: We use mapping size that is larger than the actual flash
>> size, * but this shouldn't be a problem here, because the flash
>> will simply @@ -146,8 +209,20 @@ ar2315_flash_limit = (u8
>> *)KSEG1ADDR(AR2315_SPI_READ + 0x1000000);
>>
>> void __init ar2315_init_devices(void) { +     struct resource *res; +
>> /* Find board configuration */
>> ath25_find_config(ar2315_flash_limit); + +    res =
>> &ar2315_gpio_res[1]; +        res->start = ar2315_misc_irq_base +
>> AR2315_MISC_IRQ_GPIO; +       res->end = res->start; +
>> platform_device_register(&ar2315_gpio); +     res =
>> &ar2315_wdt_res[1]; + res->start = ar2315_misc_irq_base +
>> AR2315_MISC_IRQ_WATCHDOG; +   res->end = res->start; +
>> platform_device_register(&ar2315_wdt); +
>> platform_device_register(&ar2315_spiflash); }
>>
>> static void ar2315_restart(char *command) @@ -159,8 +234,15 @@
>> static void ar2315_restart(char *command) /* try reset the system
>> via reset control */ ath25_write_reg(AR2315_COLD_RESET,
>> AR2317_RESET_SYSTEM);
>>
>> -     /* Attempt to jump to the mips reset location - the boot loader -
>> * itself might be able to recover the system */ +     /* Cold reset
>> does not work on the AR2315/6, use the GPIO reset bits +       * a
>> workaround. Give it some time to attempt a gpio based hardware +       *
>> reset (atheros reference design workaround) */ +
>> gpio_request_one(AR2315_RESET_GPIO, GPIOF_OUT_INIT_LOW, "Reset");
>
> same here ...
>
Yep

>
>> +     mdelay(100); + +        /* Some boards (e.g. Senao EOC-2610) don't
>> implement the reset logic +    * workaround. Attempt to jump to the
>> mips reset location - +        * the boot loader itself might be able to
>> recover the system */ mips_reset_vec(); }
>>
>> diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
>> index faa0633..99c2745 100644 --- a/arch/mips/ath25/ar5312.c +++
>> b/arch/mips/ath25/ar5312.c @@ -16,6 +16,8 @@
>>
>> #include <linux/init.h> #include <linux/kernel.h> +#include
>> <linux/platform_device.h> +#include <linux/mtd/physmap.h> #include
>> <linux/reboot.h> #include <asm/bootinfo.h> #include <asm/reboot.h>
>> @@ -131,15 +133,59 @@ void __init ar5312_arch_init_irq(void)
>> irq_set_chained_handler(AR5312_IRQ_MISC, ar5312_misc_irq_handler);
>> }
>>
>> +static struct physmap_flash_data ar5312_flash_data = { +     .width =
>> 2, +}; + +static struct resource ar5312_flash_resource = { +  .start
>> = AR5312_FLASH, +     .end = AR5312_FLASH + 0x800000 - 1, +   .flags =
>> IORESOURCE_MEM, +}; + +static struct platform_device
>> ar5312_physmap_flash = { +    .name = "physmap-flash", +      .id = 0, +
>> .dev.platform_data = &ar5312_flash_data, +    .resource =
>> &ar5312_flash_resource, +     .num_resources = 1, +}; + +static struct
>> resource ar5312_gpio_res[] = { +      { +             .name = "ar5312-gpio", +
>> .flags = IORESOURCE_MEM, +            .start = AR5312_GPIO, +         .end =
>> AR5312_GPIO + 0x0c - 1, +     }, +}; + +static struct platform_device
>> ar5312_gpio = { +     .name = "ar5312-gpio", +        .id = -1, +     .resource =
>> ar5312_gpio_res, +    .num_resources = ARRAY_SIZE(ar5312_gpio_res),
>> +}; +
>
> and here .. etc etc
>
Ok

>> static void __init ar5312_flash_init(void) { -        u32 ctl; +      u32 ctl =
>> ath25_read_reg(AR5312_FLASHCTL0) & AR5312_FLASHCTL_MW; + +    /* fixup
>> flash width */ +      switch (ctl) { +        case AR5312_FLASHCTL_MW16: +
>> ar5312_flash_data.width = 2; +                break; +        case AR5312_FLASHCTL_MW8:
>> +     default: +              ar5312_flash_data.width = 1; +          break; +        }
>>
>> /* * Configure flash bank 0. * Assume 8M window size. Flash will be
>> aliased if it's smaller */ -  ctl = ath25_read_reg(AR5312_FLASHCTL0)
>> & AR5312_FLASHCTL_MW; ctl |= AR5312_FLASHCTL_E |
>> AR5312_FLASHCTL_AC_8M | AR5312_FLASHCTL_RBLE; ctl |= 0x01 <<
>> AR5312_FLASHCTL_IDCY_S; ctl |= 0x07 << AR5312_FLASHCTL_WST1_S; @@
>> -182,6 +228,9 @@ void __init ar5312_init_devices(void) /*
>> Everything else is probably AR5312 or compatible */ else ath25_soc
>> = ATH25_SOC_AR5312; + +
>> platform_device_register(&ar5312_physmap_flash); +
>> platform_device_register(&ar5312_gpio); }
>>
>> static void ar5312_restart(char *command) diff --git
>> a/arch/mips/include/asm/mach-ath25/ar2315_regs.h
>> b/arch/mips/include/asm/mach-ath25/ar2315_regs.h index
>> e680abc..d61c8a1 100644 ---
>> a/arch/mips/include/asm/mach-ath25/ar2315_regs.h +++
>> b/arch/mips/include/asm/mach-ath25/ar2315_regs.h @@ -283,6 +283,11
>> @@ #define AR2315_AMBACLK_CLK_DIV_M   0x0000000c #define
>> AR2315_AMBACLK_CLK_DIV_S      2
>>
>> +/* GPIO MMR base address */ +#define AR2315_GPIO                     (AR2315_DSLBASE
>> + 0x0088) + +#define AR2315_RESET_GPIO        5 + /* *  PCI Clock Control
>> */ diff --git a/arch/mips/include/asm/mach-ath25/ar5312_regs.h
>> b/arch/mips/include/asm/mach-ath25/ar5312_regs.h index
>> afcd0b2..d715385 100644 ---
>> a/arch/mips/include/asm/mach-ath25/ar5312_regs.h +++
>> b/arch/mips/include/asm/mach-ath25/ar5312_regs.h @@ -210,4 +210,6
>> @@ #define AR5312_MEM_CFG1_AC1_M      0x00007000      /* bank 1: SDRAM addr
>> check */ #define AR5312_MEM_CFG1_AC1_S        12
>>
>> +#define AR5312_GPIO          (AR5312_APBBASE  + 0x2000) + #endif     /*
>> __ASM_MACH_ATH25_AR5312_REGS_H */
>>

-- 
BR,
Sergey
