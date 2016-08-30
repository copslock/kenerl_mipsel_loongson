Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 16:42:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54393 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992009AbcH3Om1KTvSJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 16:42:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1DE6E5E967670;
        Tue, 30 Aug 2016 15:42:07 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 15:42:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2 10/19] leds: Remove SEAD3 driver
To:     Jacek Anaszewski <j.anaszewski@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
 <20160826141751.13121-11-paul.burton@imgtec.com>
 <5f2e6c11-d4a7-dfa0-e94a-cf2a1cd66541@samsung.com>
CC:     <linux-mips@linux-mips.org>, Richard Purdie <rpurdie@rpsys.net>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <a3339cb1-e405-dfb8-9a73-42756bb4fe67@imgtec.com>
Date:   Tue, 30 Aug 2016 15:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5f2e6c11-d4a7-dfa0-e94a-cf2a1cd66541@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 29/08/16 09:55, Jacek Anaszewski wrote:
> Hi Paul,
> 
> On 08/26/2016 04:17 PM, Paul Burton wrote:
>> SEAD3 is now using the generic syscon & regmap based register-bit-led
>> driver, so remove the unused custom SEAD3 LED driver.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/leds/Kconfig      | 10 ------
>>  drivers/leds/Makefile     |  1 -
>>  drivers/leds/leds-sead3.c | 78 -----------------------------------------------
>>  3 files changed, 89 deletions(-)
>>  delete mode 100644 drivers/leds/leds-sead3.c
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 9dcc9b1..025de7e 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -574,16 +574,6 @@ config LEDS_KTD2692
>>
>>        Say Y to enable this driver.
>>
>> -config LEDS_SEAD3
>> -    tristate "LED support for the MIPS SEAD 3 board"
>> -    depends on LEDS_CLASS && MIPS_SEAD3
>> -    help
>> -      Say Y here to include support for the FLED and PLED LEDs on SEAD3 eval
>> -      boards.
>> -
>> -      This driver can also be built as a module. If so the module
>> -      will be called leds-sead3.
>> -
>>  config LEDS_IS31FL32XX
>>      tristate "LED support for ISSI IS31FL32XX I2C LED controller family"
>>      depends on LEDS_CLASS && I2C && OF
>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>> index 0684c86..da594cf 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -66,7 +66,6 @@ obj-$(CONFIG_LEDS_VERSATILE)        += leds-versatile.o
>>  obj-$(CONFIG_LEDS_MENF21BMC)        += leds-menf21bmc.o
>>  obj-$(CONFIG_LEDS_KTD2692)        += leds-ktd2692.o
>>  obj-$(CONFIG_LEDS_POWERNV)        += leds-powernv.o
>> -obj-$(CONFIG_LEDS_SEAD3)        += leds-sead3.o
>>  obj-$(CONFIG_LEDS_IS31FL32XX)        += leds-is31fl32xx.o
>>
>>  # LED SPI Drivers
>> diff --git a/drivers/leds/leds-sead3.c b/drivers/leds/leds-sead3.c
>> deleted file mode 100644
>> index eb97a32..0000000
>> --- a/drivers/leds/leds-sead3.c
>> +++ /dev/null
>> @@ -1,78 +0,0 @@
>> -/*
>> - * This file is subject to the terms and conditions of the GNU General Public
>> - * License.  See the file "COPYING" in the main directory of this archive
>> - * for more details.
>> - *
>> - * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>> - * Copyright (C) 2015 Imagination Technologies, Inc.
>> - */
>> -#include <linux/kernel.h>
>> -#include <linux/module.h>
>> -#include <linux/init.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/leds.h>
>> -#include <linux/err.h>
>> -#include <linux/io.h>
>> -
>> -#include <asm/mips-boards/sead3-addr.h>
>> -
>> -static void sead3_pled_set(struct led_classdev *led_cdev,
>> -        enum led_brightness value)
>> -{
>> -    writel(value, (void __iomem *)SEAD3_CPLD_P_LED);
>> -}
>> -
>> -static void sead3_fled_set(struct led_classdev *led_cdev,
>> -        enum led_brightness value)
>> -{
>> -    writel(value, (void __iomem *)SEAD3_CPLD_F_LED);
>> -}
>> -
>> -static struct led_classdev sead3_pled = {
>> -    .name        = "sead3::pled",
>> -    .brightness_set = sead3_pled_set,
>> -    .flags        = LED_CORE_SUSPENDRESUME,
>> -};
>> -
>> -static struct led_classdev sead3_fled = {
>> -    .name        = "sead3::fled",
>> -    .brightness_set = sead3_fled_set,
>> -    .flags        = LED_CORE_SUSPENDRESUME,
>> -};
>> -
>> -static int sead3_led_probe(struct platform_device *pdev)
>> -{
>> -    int ret;
>> -
>> -    ret = led_classdev_register(&pdev->dev, &sead3_pled);
>> -    if (ret < 0)
>> -        return ret;
>> -
>> -    ret = led_classdev_register(&pdev->dev, &sead3_fled);
>> -    if (ret < 0)
>> -        led_classdev_unregister(&sead3_pled);
>> -
>> -    return ret;
>> -}
>> -
>> -static int sead3_led_remove(struct platform_device *pdev)
>> -{
>> -    led_classdev_unregister(&sead3_pled);
>> -    led_classdev_unregister(&sead3_fled);
>> -
>> -    return 0;
>> -}
>> -
>> -static struct platform_driver sead3_led_driver = {
>> -    .probe        = sead3_led_probe,
>> -    .remove        = sead3_led_remove,
>> -    .driver        = {
>> -        .name        = "sead3-led",
>> -    },
>> -};
>> -
>> -module_platform_driver(sead3_led_driver);
>> -
>> -MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
>> -MODULE_DESCRIPTION("SEAD3 LED driver");
>> -MODULE_LICENSE("GPL");
>>
> 
> Currently the patch doesn't apply cleanly on the linux-leds.git,
> for-next branch, due to the fresh changes in the surrounding code in
> the drivers/leds/Makefile and Kconfig. Does this patch depend on
> the previous patches in this series, or I can take it now and apply
> to the LEDs git?

Hi Jacek,

Ideally the patches to the SEAD-3 board code & DT would go in first such
that the board switches to the register-bit-led driver before this
custom driver is removed. Otherwise we'll lose support for the LEDs in
between you applying this patch & Ralf applying the rest.

Having said that I doubt anyone actually uses the SEAD-3 LEDs so I don't
mind so much if you & Ralf decide that's the easiest path forwards.

Thanks,
    Paul
