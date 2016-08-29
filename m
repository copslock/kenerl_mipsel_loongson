Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Aug 2016 10:55:58 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38857 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992022AbcH2IzuCH7Di (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Aug 2016 10:55:50 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OCN00JWCY4UAK70@mailout2.w1.samsung.com>; Mon,
 29 Aug 2016 09:55:42 +0100 (BST)
X-AuditID: cbfec7f4-f79cb6d000001359-b0-57c3f88ec4bc
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 68.F1.04953.E88F3C75; Mon,
 29 Aug 2016 09:55:42 +0100 (BST)
Received: from [106.120.53.23] by eusync1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0OCN001LSY4T2650@eusync1.samsung.com>; Mon,
 29 Aug 2016 09:55:42 +0100 (BST)
From:   Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 10/19] leds: Remove SEAD3 driver
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
 <20160826141751.13121-11-paul.burton@imgtec.com>
Cc:     Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-id: <5f2e6c11-d4a7-dfa0-e94a-cf2a1cd66541@samsung.com>
Date:   Mon, 29 Aug 2016 10:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-version: 1.0
In-reply-to: <20160826141751.13121-11-paul.burton@imgtec.com>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xy7p9Pw6HG1x/J25xedccNoutb9Yx
        WkyYOond4v6+jewWl/aoWOze9ZTVgc2jZ+cZRo+jK9cyeeyZ/4PV4/MmuQCWKC6blNSczLLU
        In27BK6M50ctCy4pVUxe/YOtgfG/dBcjJ4eEgIlEz5ubLBC2mMSFe+vZuhi5OIQEljJKLN58
        ghkkISTwjFFi0/tSEJtNwFDi54vXTCC2sIC5xKtLi8FsEYFMiZ+v3zBB1OdJvP76gRHEZhZI
        knj89QiYzStgJ3Hn9Wk2EJtFQFViw/S/YPNFBSIkbq36CFUjKPFj8j2wgzgFbCUaXn1mhphj
        K7Hg/ToWCFteYvOat8wTGAVmIWmZhaRsFpKyBYzMqxhFU0uTC4qT0nMN9YoTc4tL89L1kvNz
        NzFCgvnLDsbFx6wOMQpwMCrx8EY8PxQuxJpYVlyZe4hRgoNZSYT36PfD4UK8KYmVValF+fFF
        pTmpxYcYpTlYlMR55+56HyIkkJ5YkpqdmlqQWgSTZeLglGpgXH1q67qsFt9ZIbLXvOJr/mzP
        c/nj++Dv/auM+ZtYTJf4VV2bfuOK0qPZy/ek7nqy/9f15W0r7qmLTM9fscDOtTz8zPZ9Fi5d
        4h8SNzZ8YTiQ+Vwqp19OJ37is9wTGR5/fk+/lKvo55eU3Siqv97zo9ysNd9kkg8Vfp7A5tY8
        /d6Jmizx3JNX+pVYijMSDbWYi4oTAeJSfuZiAgAA
Return-Path: <j.anaszewski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: j.anaszewski@samsung.com
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

Hi Paul,

On 08/26/2016 04:17 PM, Paul Burton wrote:
> SEAD3 is now using the generic syscon & regmap based register-bit-led
> driver, so remove the unused custom SEAD3 LED driver.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
> Changes in v2: None
>
>  drivers/leds/Kconfig      | 10 ------
>  drivers/leds/Makefile     |  1 -
>  drivers/leds/leds-sead3.c | 78 -----------------------------------------------
>  3 files changed, 89 deletions(-)
>  delete mode 100644 drivers/leds/leds-sead3.c
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9dcc9b1..025de7e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -574,16 +574,6 @@ config LEDS_KTD2692
>
>  	  Say Y to enable this driver.
>
> -config LEDS_SEAD3
> -	tristate "LED support for the MIPS SEAD 3 board"
> -	depends on LEDS_CLASS && MIPS_SEAD3
> -	help
> -	  Say Y here to include support for the FLED and PLED LEDs on SEAD3 eval
> -	  boards.
> -
> -	  This driver can also be built as a module. If so the module
> -	  will be called leds-sead3.
> -
>  config LEDS_IS31FL32XX
>  	tristate "LED support for ISSI IS31FL32XX I2C LED controller family"
>  	depends on LEDS_CLASS && I2C && OF
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 0684c86..da594cf 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -66,7 +66,6 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
>  obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
>  obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
>  obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
> -obj-$(CONFIG_LEDS_SEAD3)		+= leds-sead3.o
>  obj-$(CONFIG_LEDS_IS31FL32XX)		+= leds-is31fl32xx.o
>
>  # LED SPI Drivers
> diff --git a/drivers/leds/leds-sead3.c b/drivers/leds/leds-sead3.c
> deleted file mode 100644
> index eb97a32..0000000
> --- a/drivers/leds/leds-sead3.c
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> - * Copyright (C) 2015 Imagination Technologies, Inc.
> - */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/leds.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -
> -#include <asm/mips-boards/sead3-addr.h>
> -
> -static void sead3_pled_set(struct led_classdev *led_cdev,
> -		enum led_brightness value)
> -{
> -	writel(value, (void __iomem *)SEAD3_CPLD_P_LED);
> -}
> -
> -static void sead3_fled_set(struct led_classdev *led_cdev,
> -		enum led_brightness value)
> -{
> -	writel(value, (void __iomem *)SEAD3_CPLD_F_LED);
> -}
> -
> -static struct led_classdev sead3_pled = {
> -	.name		= "sead3::pled",
> -	.brightness_set = sead3_pled_set,
> -	.flags		= LED_CORE_SUSPENDRESUME,
> -};
> -
> -static struct led_classdev sead3_fled = {
> -	.name		= "sead3::fled",
> -	.brightness_set = sead3_fled_set,
> -	.flags		= LED_CORE_SUSPENDRESUME,
> -};
> -
> -static int sead3_led_probe(struct platform_device *pdev)
> -{
> -	int ret;
> -
> -	ret = led_classdev_register(&pdev->dev, &sead3_pled);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = led_classdev_register(&pdev->dev, &sead3_fled);
> -	if (ret < 0)
> -		led_classdev_unregister(&sead3_pled);
> -
> -	return ret;
> -}
> -
> -static int sead3_led_remove(struct platform_device *pdev)
> -{
> -	led_classdev_unregister(&sead3_pled);
> -	led_classdev_unregister(&sead3_fled);
> -
> -	return 0;
> -}
> -
> -static struct platform_driver sead3_led_driver = {
> -	.probe		= sead3_led_probe,
> -	.remove		= sead3_led_remove,
> -	.driver		= {
> -		.name		= "sead3-led",
> -	},
> -};
> -
> -module_platform_driver(sead3_led_driver);
> -
> -MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
> -MODULE_DESCRIPTION("SEAD3 LED driver");
> -MODULE_LICENSE("GPL");
>

Currently the patch doesn't apply cleanly on the linux-leds.git,
for-next branch, due to the fresh changes in the surrounding code in
the drivers/leds/Makefile and Kconfig. Does this patch depend on
the previous patches in this series, or I can take it now and apply
to the LEDs git?

-- 
Best regards,
Jacek Anaszewski
