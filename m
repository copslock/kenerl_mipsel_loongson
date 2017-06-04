Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2017 20:55:15 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34600
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdFDSzGjAOuI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Jun 2017 20:55:06 +0200
Received: by mail-wm0-x243.google.com with SMTP id 70so2204126wme.1;
        Sun, 04 Jun 2017 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=We+6+RGURm9vg8e1hayklAAWQkw7Xn1jH5fGJ2I3bBM=;
        b=uTjqtpq9kPdzoOsKWhAg9O/g2D99LDTz4ntp2dVK7O6Jwyf0NJsG0WjvQgQiaUBtZV
         l2sSpD6iBO5m6wmbTXfyirBNQWz5TDuNjibWl23uRFoE63ZrZhJMfDx/DUrlL+PxzBJm
         VehsPswee+TGt1UNIPalNk2fNRKeHcOz6WMIyaomPFGZ+DJb8FLcdj/c0/CVSazPQuJj
         OnmGmgD7FtsuaN0vMwfhyISnRPfDMdao+/YciiJg5ZW35ZyX0OPVtaNtHaBtt9e0Y3NY
         XudmOWPUvOiiXSpJaOE75FZ4g1FQIEZgDMtyB3W6n3SqptfRxckNJLPhF1UkURiz35JC
         ntXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=We+6+RGURm9vg8e1hayklAAWQkw7Xn1jH5fGJ2I3bBM=;
        b=rqNcRgCbt1lR2nd7T01Fq+VLkzMruv71aF4ExQX0mD92BRCds0RsyxymAnMlTT+szN
         sjwdroE2nzXKUNpcuLkbP6k2w9ZT1U0ZHqwuVxhFgehnpNqK+IHubMisGcqUVlbN38Nt
         r7rPejor7V6rlfsDP/HwDbld0MyfhgWLl5NEX23K/+UaO4pL4ITdoDMGmdUiUwpXRu8r
         IAOhwbkKWkDpSyrP7/2MDnf3EySYDrzdy+ahO9hebYI6QV7GZ18zclrcqXujEu+D4PRw
         MHVHV/8i4TjO8Ip9dk8NTNxeK4XLx97oF2zQqnOAH08W+ccHQTqEtGFeEvYQaolV/YCR
         OJ9A==
X-Gm-Message-State: AODbwcAX1x8/HC3WXp+7ySwqT9Bpl//WfZ30KYANyXKxEDuWUge4t1Xy
        Is0xp4B5RsLxe7gF0zE=
X-Received: by 10.28.128.198 with SMTP id b189mr5199916wmd.79.1496602501095;
        Sun, 04 Jun 2017 11:55:01 -0700 (PDT)
Received: from [192.168.1.17] (afti233.neoplus.adsl.tpnet.pl. [178.42.242.233])
        by smtp.gmail.com with ESMTPSA id 49sm2477806wrz.8.2017.06.04.11.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jun 2017 11:55:00 -0700 (PDT)
Subject: Re: [PATCH] leds: Remove SEAD-3 driver
To:     Paul Burton <paul.burton@imgtec.com>, linux-leds@vger.kernel.org
References: <20170602220007.6927-1-paul.burton@imgtec.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Richard Purdie <rpurdie@rpsys.net>, linux-mips@linux-mips.org
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <719d876e-2ec6-c33b-43eb-74800523837c@gmail.com>
Date:   Sun, 4 Jun 2017 20:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170602220007.6927-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jacek.anaszewski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jacek.anaszewski@gmail.com
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

On 06/03/2017 12:00 AM, Paul Burton wrote:
> SEAD3 is using the generic syscon & regmap based register-bit-led
> driver as of commit c764583f40b8 ("MIPS: SEAD3: Use register-bit-led
> driver via DT for LEDs") merged in the v4.9 cycle. As such the custom
> SEAD-3 LED driver is now unused, so remove it.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> 
> ---
> 
>  drivers/leds/Kconfig      | 10 ------
>  drivers/leds/Makefile     |  1 -
>  drivers/leds/leds-sead3.c | 78 -----------------------------------------------
>  3 files changed, 89 deletions(-)
>  delete mode 100644 drivers/leds/leds-sead3.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6c2999872090..1e47b9182c33 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -590,16 +590,6 @@ config LEDS_KTD2692
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
>  config LEDS_IS31FL319X
>  	tristate "LED Support for ISSI IS31FL319x I2C LED controller family"
>  	depends on LEDS_CLASS && I2C && OF
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 45f133962ed8..8c056dd047e2 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -66,7 +66,6 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
>  obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
>  obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
>  obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
> -obj-$(CONFIG_LEDS_SEAD3)		+= leds-sead3.o
>  obj-$(CONFIG_LEDS_IS31FL319X)		+= leds-is31fl319x.o
>  obj-$(CONFIG_LEDS_IS31FL32XX)		+= leds-is31fl32xx.o
>  obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
> diff --git a/drivers/leds/leds-sead3.c b/drivers/leds/leds-sead3.c
> deleted file mode 100644
> index eb97a3271bb3..000000000000
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

Applied, thanks.

-- 
Best regards,
Jacek Anaszewski
