Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 11:31:54 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56772 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904026Ab1KQKbs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 11:31:48 +0100
Received: by faar25 with SMTP id r25so3378817faa.36
        for <multiple recipients>; Thu, 17 Nov 2011 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bPGVGppSetNar61uVqAZbJNOyIutjW+LUHus0Xax1uo=;
        b=w5owmIQSGFgHM8Nn6TV4dDXhCUY5owKjkXxaiQQmKlWkNi+sgoYOj9cuxfNmU73ePx
         9mC6dUxuPVD4IEc5cGE/eJaRPk4NRm/7M6s4qxwu74Dm0vfEYCOTMCq65jA+Zd2kn+Au
         yY6zLJV43WgoHciB0TunH8eRs4Fu6A83olHIc=
MIME-Version: 1.0
Received: by 10.182.124.42 with SMTP id mf10mr8917816obb.5.1321525902708; Thu,
 17 Nov 2011 02:31:42 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Thu, 17 Nov 2011 02:31:42 -0800 (PST)
In-Reply-To: <CAEWqx58YQAKQ=D=qteipHQq5Q==+aEiKMYP4FczMZ9kReogMDQ@mail.gmail.com>
References: <1321440940-20246-1-git-send-email-xsecute@googlemail.com>
        <1321440940-20246-3-git-send-email-xsecute@googlemail.com>
        <4EC416CF.3050707@openwrt.org>
        <CAEWqx58YQAKQ=D=qteipHQq5Q==+aEiKMYP4FczMZ9kReogMDQ@mail.gmail.com>
Date:   Thu, 17 Nov 2011 11:31:42 +0100
Message-ID: <CAEWqx59k97AMU6hH0NCC2TMEY2mu8d5ytxO68oEsa=7uvLBA4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Initial support for the Ubiquiti Networks XM board.
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14339

Did not reply to all.....

2011/11/16 René Bolldorf <xsecute@googlemail.com>:
> On Wed, Nov 16, 2011 at 9:02 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
>> Hi Rene,
>>
>>> Signed-off-by: Rene Bolldorf <xsecute@googlemail.com>
>>> ---
>>>  arch/mips/ath79/Kconfig        |   12 ++++
>>>  arch/mips/ath79/Makefile       |    1 +
>>>  arch/mips/ath79/Platform       |    7 ++-
>>>  arch/mips/ath79/mach-ubnt-xm.c |  110 ++++++++++++++++++++++++++++++++++++++++
>>>  arch/mips/ath79/machtypes.h    |    1 +
>>>  5 files changed, 128 insertions(+), 3 deletions(-)
>>>  create mode 100644 arch/mips/ath79/mach-ubnt-xm.c
>>>
>>> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
>>> index 4770741..fa74e73 100644
>>> --- a/arch/mips/ath79/Kconfig
>>> +++ b/arch/mips/ath79/Kconfig
>>> @@ -23,6 +23,16 @@ config ATH79_MACH_PB44
>>>         Say 'Y' here if you want your kernel to support the
>>>         Atheros PB44 reference board.
>>>
>>> +config ATH79_MACH_UBNT_XM
>>> +     bool "Ubiquiti Networks XM board"
>>> +     select SOC_AR724X
>>> +     select ATH79_DEV_GPIO_BUTTONS
>>> +     select ATH79_DEV_LEDS_GPIO
>>> +     select ATH79_DEV_SPI
>>> +     help
>>> +       Say 'Y' here if you want your kernel to support the
>>> +       Ubiquiti Networks XM board.
>>> +
>>>  endmenu
>>>
>>>  config SOC_AR71XX
>>> @@ -33,6 +43,8 @@ config SOC_AR71XX
>>>  config SOC_AR724X
>>>       select USB_ARCH_HAS_EHCI
>>>       select USB_ARCH_HAS_OHCI
>>> +     select HW_HAS_PCI
>>> +     select PCI
>>
>> Please don't select the whole PCI subsystem. Even if the hardware has PCI
>> support, not everyone wants to build a kernel with PCI support.
>>
>>>       def_bool n
>>>
>>>  config SOC_AR913X
>>> diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
>>> index c33d465..ac9f375 100644
>>> --- a/arch/mips/ath79/Makefile
>>> +++ b/arch/mips/ath79/Makefile
>>> @@ -26,3 +26,4 @@ obj-$(CONFIG_ATH79_DEV_SPI)         += dev-spi.o
>>>  #
>>>  obj-$(CONFIG_ATH79_MACH_AP81)                += mach-ap81.o
>>>  obj-$(CONFIG_ATH79_MACH_PB44)                += mach-pb44.o
>>> +obj-$(CONFIG_ATH79_MACH_UBNT_XM)     += mach-ubnt-xm.o
>>> diff --git a/arch/mips/ath79/Platform b/arch/mips/ath79/Platform
>>> index 2bd6636..aca7ab1 100644
>>> --- a/arch/mips/ath79/Platform
>>> +++ b/arch/mips/ath79/Platform
>>> @@ -2,6 +2,7 @@
>>>  # Atheros AR71xx/AR724x/AR913x
>>>  #
>>>
>>> -platform-$(CONFIG_ATH79)     += ath79/
>>> -cflags-$(CONFIG_ATH79)               += -I$(srctree)/arch/mips/include/asm/mach-ath79
>>> -load-$(CONFIG_ATH79)         = 0xffffffff80060000
>>> +platform-$(CONFIG_ATH79)             += ath79/
>>> +cflags-$(CONFIG_ATH79)                       += -I$(srctree)/arch/mips/include/asm/mach-ath79
>>> +load-$(CONFIG_ATH79)                 = 0xffffffff80060000
>>> +load-$(CONFIG_ATH79_MACH_UBNT_XM)    = 0xffffffff80002000
>>
>> Please don't add another load address here.The ath79 platform code has been
>> designed in a way which allows a single kernel image to run on all
>> AR71xx/AR724x/AR913X/AR933x based boards, and the 0x80060000 load address has
>> been chosen due to compatibility reasons. It allows to boot the kernel on older
>> boards which are using RedBoot as the bootloader. The U-Boot on the
>> AR724x/AR933x based boards can load the kernel to 0x8006000.
>>
>>> diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
>>> new file mode 100644
>>> index 0000000..150a0a0
>>> --- /dev/null
>>> +++ b/arch/mips/ath79/mach-ubnt-xm.c
>>> @@ -0,0 +1,110 @@
>>> +/*
>>> + *  Ubiquiti Networks XM board support
>>> + *
>>> + *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
>>> + *
>>> + *  Derived from: mach-pb44.c
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modify it
>>> + *  under the terms of the GNU General Public License version 2 as published
>>> + *  by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/ath9k_platform.h>
>>> +
>>> +#include "machtypes.h"
>>> +#include "dev-gpio-buttons.h"
>>> +#include "dev-leds-gpio.h"
>>> +#include "dev-spi.h"
>>> +
>>> +#define UBNT_XM_GPIO_LED_L1          0
>>> +#define UBNT_XM_GPIO_LED_L2          1
>>> +#define UBNT_XM_GPIO_LED_L3          11
>>> +#define UBNT_XM_GPIO_LED_L4          7
>>> +
>>> +#define UBNT_XM_GPIO_BTN_RESET               12
>>> +
>>> +#define UBNT_XM_KEYS_POLL_INTERVAL   20
>>> +#define UBNT_XM_KEYS_DEBOUNCE_INTERVAL       (3 * UBNT_XM_KEYS_POLL_INTERVAL)
>>> +
>>> +#define UBNT_XM_PCI_IRQ                      48
>>> +#define UBNT_XM_EEPROM_ADDR          (u8 *) KSEG1ADDR(0x1fff1000)
>>> +
>>> +static struct gpio_led ubnt_xm_leds_gpio[] __initdata = {
>>> +     {
>>> +             .name           = "signal:poor",
>>> +             .gpio           = UBNT_XM_GPIO_LED_L1,
>>> +             .active_low     = 0,
>>> +     }, {
>>> +             .name           = "signal:bad",
>>> +             .gpio           = UBNT_XM_GPIO_LED_L2,
>>> +             .active_low     = 0,
>>> +     }, {
>>> +             .name           = "signal:good",
>>> +             .gpio           = UBNT_XM_GPIO_LED_L3,
>>> +             .active_low     = 0,
>>> +     }, {
>>> +             .name           = "signal:excellent",
>>> +             .gpio           = UBNT_XM_GPIO_LED_L4,
>>> +             .active_low     = 0,
>>> +     },
>>
>> The LED names should follow the Linux LED Device Naming convention.
>> See Documentation/leds/leds-class.txt.
>>
>>> +};
>>> +
>>> +static struct gpio_keys_button ubnt_xm_gpio_keys[] __initdata = {
>>> +     {
>>> +             .desc           = "reset",
>>> +             .type           = EV_KEY,
>>> +             .code           = KEY_RESTART,
>>> +             .debounce_interval = UBNT_XM_KEYS_DEBOUNCE_INTERVAL,
>>> +             .gpio           = UBNT_XM_GPIO_BTN_RESET,
>>> +             .active_low     = 1,
>>> +     }
>>> +};
>>> +
>>> +static struct spi_board_info ubnt_xm_spi_info[] = {
>>> +     {
>>> +             .bus_num        = 0,
>>> +             .chip_select    = 0,
>>> +             .max_speed_hz   = 25000000,
>>> +             .modalias       = "mx25l6405d",
>>> +     }
>>> +};
>>> +
>>> +static struct ath79_spi_platform_data ubnt_xm_spi_data = {
>>> +     .bus_num                = 0,
>>> +     .num_chipselect         = 1,
>>> +};
>>> +
>>> +static struct ath9k_platform_data ubnt_xm_eeprom_data;
>>> +
>>> +int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
>>> +{
>>> +     return UBNT_XM_PCI_IRQ;
>>> +}
>>> +
>>> +int pcibios_plat_dev_init(struct pci_dev *dev)
>>> +{
>>> +     dev->dev.platform_data = &ubnt_xm_eeprom_data;
>>> +
>>> +     return 0;
>>> +}
>>
>> The 'pci_bios_map_irq' and 'pcibios_plat_dev_init' functions are global, so you
>> can have only one instance of them within the kernel. Adding these functions
>> into a machine specific file would prevent to build a kernel which supports
>> multiple different boards.
>>
>>> +
>>> +static void __init ubnt_xm_init(void)
>>> +{
>>> +     ath79_register_leds_gpio(-1, ARRAY_SIZE(ubnt_xm_leds_gpio),
>>> +                              ubnt_xm_leds_gpio);
>>
>> The Ubiquiti xM family has several different models. Registering all of the assigned
>> GPIO lines varies between the different boards.
>>
> I know that the GPIO lines from NanoBridge, Picostation and Rocket
> with board revision v1 are the same.
> I note this in the kconf help text.
>
> I improve the code and send a V2.
>
> Thank you for the hints.
>>> +
>>> +     ath79_register_gpio_keys_polled(-1, UBNT_XM_KEYS_POLL_INTERVAL,
>>> +                                     ARRAY_SIZE(ubnt_xm_gpio_keys),
>>> +                                     ubnt_xm_gpio_keys);
>>> +
>>> +     ath79_register_spi(&ubnt_xm_spi_data, ubnt_xm_spi_info,
>>> +                        ARRAY_SIZE(ubnt_xm_spi_info));
>>> +
>>> +     memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
>>> +            sizeof(ubnt_xm_eeprom_data.eeprom_data));
>>> +}
>>> +
>>> +MIPS_MACHINE(ATH79_MACH_UBNT_XM, "UBNT-XM", "Ubiquiti Networks XM board", ubnt_xm_init);
>>> diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
>>> index 3940fe4..1bb0747 100644
>>> --- a/arch/mips/ath79/machtypes.h
>>> +++ b/arch/mips/ath79/machtypes.h
>>> @@ -18,6 +18,7 @@ enum ath79_mach_type {
>>>       ATH79_MACH_GENERIC = 0,
>>>       ATH79_MACH_AP81,                /* Atheros AP81 reference board */
>>>       ATH79_MACH_PB44,                /* Atheros PB44 reference board */
>>> +     ATH79_MACH_UBNT_XM,             /* Ubiquiti Networks XM board */
>>>  };
>>>
>>>  #endif /* _ATH79_MACHTYPE_H */
>>
>>
>
