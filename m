Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2014 01:19:47 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61835 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009303AbaJXXTpmdi54 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Oct 2014 01:19:45 +0200
Received: by mail-ie0-f177.google.com with SMTP id tp5so3261969ieb.36
        for <multiple recipients>; Fri, 24 Oct 2014 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X5kLkrikU1JwG3NCydpoMvTtlbGs0s4T0NIeo7qF1bM=;
        b=pgPdR9JacNxLH0cz/0o/42eHL0sb2sfVUuddNzMHpfPp7noM0W98KLKd355q7/Gb3E
         DriCa51lUEp1muFuf458MDIhrmpEd4XeX0f2ZsF7omI9lt6gL7FQvl3KQWLF0Ul8FUe1
         MBagQQx0rD1vhuJm0nT8UG6JW8Us8+ICcj2FJtqXbXAJ3gdJFGZ5cWydDnxVXvzSuMNY
         nFfoCVi2gBQEOKhuN+obOGH6kM7Ek03iNqIdIENRX+Yl8pmGy921j4i0WIPHtPYhdgUI
         r8zFZbmfbzsO1IRVQwtmaXOYiykerVvByp+gIZ6u7PRWdkR1SJ2G/9DO+Uy3aLqOcIC1
         dm9Q==
X-Received: by 10.50.6.2 with SMTP id w2mr6672990igw.29.1414192779321; Fri, 24
 Oct 2014 16:19:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.200 with HTTP; Fri, 24 Oct 2014 16:19:19 -0700 (PDT)
In-Reply-To: <1ab02cb057a06c402549ef028e2f0d136fc58279.1414108953.git.ralf@linux-mips.org>
References: <20141023235416.GA7529@linux-mips.org> <1ab02cb057a06c402549ef028e2f0d136fc58279.1414108953.git.ralf@linux-mips.org>
From:   Bryan Wu <cooloney@gmail.com>
Date:   Fri, 24 Oct 2014 16:19:19 -0700
Message-ID: <CAK5ve-JcfreXNjcRUTXiuYBx+eNptNKVh77JNQWSQVaxUW=yvA@mail.gmail.com>
Subject: Re: [PATCH 3/3] LED/MIPS: Move SEAD3 LED driver to where it belongs.
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Richard Purdie <rpurdie@rpsys.net>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cooloney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cooloney@gmail.com
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

On Thu, Oct 23, 2014 at 4:50 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Fixes the following randconfig problem
>
> leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
> leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'
>

I think you can fold these 3 patches into one patch then.

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/mti-sead3/Makefile     |  2 +-
>  arch/mips/mti-sead3/leds-sead3.c | 90 ----------------------------------------
>  drivers/leds/Kconfig             |  9 ++++
>  drivers/leds/Makefile            |  1 +
>  drivers/leds/leds-sead3.c        | 90 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 91 deletions(-)
>  delete mode 100644 arch/mips/mti-sead3/leds-sead3.c
>  create mode 100644 drivers/leds/leds-sead3.c
>
> diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
> index febf433..aa8a857 100644
> --- a/arch/mips/mti-sead3/Makefile
> +++ b/arch/mips/mti-sead3/Makefile
> @@ -15,7 +15,7 @@ obj-y                         := sead3-lcd.o sead3-display.o sead3-init.o \
>
>  obj-y                          += sead3-i2c-dev.o sead3-i2c.o \
>                                    sead3-pic32-i2c-drv.o sead3-pic32-bus.o \
> -                                  leds-sead3.o sead3-leds.o
> +                                  sead3-leds.o
>
>  obj-$(CONFIG_EARLY_PRINTK)     += sead3-console.o
>  obj-$(CONFIG_USB_EHCI_HCD)     += sead3-ehci.o
> diff --git a/arch/mips/mti-sead3/leds-sead3.c b/arch/mips/mti-sead3/leds-sead3.c
> deleted file mode 100644
> index e5632e6..0000000
> --- a/arch/mips/mti-sead3/leds-sead3.c
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> - */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/leds.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -
> -#define DRVNAME "sead3-led"
> -
> -static void sead3_pled_set(struct led_classdev *led_cdev,
> -               enum led_brightness value)
> -{
> -       pr_debug("sead3_pled_set\n");
> -       writel(value, (void __iomem *)0xBF000210);      /* FIXME */
> -}
> -
> -static void sead3_fled_set(struct led_classdev *led_cdev,
> -               enum led_brightness value)
> -{
> -       pr_debug("sead3_fled_set\n");
> -       writel(value, (void __iomem *)0xBF000218);      /* FIXME */
> -}
> -
> -static struct led_classdev sead3_pled = {
> -       .name           = "sead3::pled",
> -       .brightness_set = sead3_pled_set,
> -       .flags          = LED_CORE_SUSPENDRESUME,
> -};
> -
> -static struct led_classdev sead3_fled = {
> -       .name           = "sead3::fled",
> -       .brightness_set = sead3_fled_set,
> -       .flags          = LED_CORE_SUSPENDRESUME,
> -};
> -
> -static int sead3_led_probe(struct platform_device *pdev)
> -{
> -       int ret;
> -
> -       ret = led_classdev_register(&pdev->dev, &sead3_pled);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret = led_classdev_register(&pdev->dev, &sead3_fled);
> -       if (ret < 0)
> -               led_classdev_unregister(&sead3_pled);
> -
> -       return ret;
> -}
> -
> -static int sead3_led_remove(struct platform_device *pdev)
> -{
> -       led_classdev_unregister(&sead3_pled);
> -       led_classdev_unregister(&sead3_fled);
> -       return 0;
> -}
> -
> -static struct platform_driver sead3_led_driver = {
> -       .probe          = sead3_led_probe,
> -       .remove         = sead3_led_remove,
> -       .driver         = {
> -               .name           = DRVNAME,
> -               .owner          = THIS_MODULE,
> -       },
> -};
> -
> -static int __init sead3_led_init(void)
> -{
> -       return platform_driver_register(&sead3_led_driver);
> -}
> -
> -static void __exit sead3_led_exit(void)
> -{
> -       platform_driver_unregister(&sead3_led_driver);
> -}
> -
> -module_init(sead3_led_init);
> -module_exit(sead3_led_exit);
> -
> -MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
> -MODULE_DESCRIPTION("SEAD3 LED driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a210338..b86aa85 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -477,6 +477,15 @@ config LEDS_MENF21BMC
>           This driver can also be built as a module. If so the module
>           will be called leds-menf21bmc.
>
> +config LEDS_SEAD3
> +       tristate "LED support for the MIPS SEAD 3 board"
> +       depends on LEDS_CLASS && MIPS_SEAD3
> +       help
> +         Say Y here to include support for the MEN 14F021P00 BMC LEDs.
> +

Is this driver similar to drivers/leds/leds-menf21bmc.c? If we can
reuse the code it should be better.

> +         This driver can also be built as a module. If so the module
> +         will be called leds-sead3.
> +
>  comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
>
>  config LEDS_BLINKM
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index a2b1647..4f22241 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_BLINKM)             += leds-blinkm.o
>  obj-$(CONFIG_LEDS_SYSCON)              += leds-syscon.o
>  obj-$(CONFIG_LEDS_VERSATILE)           += leds-versatile.o
>  obj-$(CONFIG_LEDS_MENF21BMC)           += leds-menf21bmc.o
> +obj-$(CONFIG_LEDS_SEAD3)               += leds-sead3.o
>
>  # LED SPI Drivers
>  obj-$(CONFIG_LEDS_DAC124S085)          += leds-dac124s085.o
> diff --git a/drivers/leds/leds-sead3.c b/drivers/leds/leds-sead3.c
> new file mode 100644
> index 0000000..0cf79f5
> --- /dev/null
> +++ b/drivers/leds/leds-sead3.c
> @@ -0,0 +1,90 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +

Please reorder this list in alphabetic order.

> +static void sead3_pled_set(struct led_classdev *led_cdev,
> +               enum led_brightness value)
> +{
> +       pr_debug("sead3_pled_set\n");

Don't use pr_debug, please use dev_dbg();

> +       writel(value, (void __iomem *)0xBF000210);      /* FIXME */

Fix this, define some meaningful name of the address.

> +}
> +
> +static void sead3_fled_set(struct led_classdev *led_cdev,
> +               enum led_brightness value)
> +{
> +       pr_debug("sead3_fled_set\n");
Don't use pr_debug, please use dev_dbg();

> +       writel(value, (void __iomem *)0xBF000218);      /* FIXME */

ditto

> +}
> +
> +static struct led_classdev sead3_pled = {
> +       .name           = "sead3::pled",
> +       .brightness_set = sead3_pled_set,
> +       .flags          = LED_CORE_SUSPENDRESUME,
> +};
> +
> +static struct led_classdev sead3_fled = {
> +       .name           = "sead3::fled",
> +       .brightness_set = sead3_fled_set,
> +       .flags          = LED_CORE_SUSPENDRESUME,
> +};
> +

What's pled and fled? Please give more meaningful name or document it.

> +static int sead3_led_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       ret = led_classdev_register(&pdev->dev, &sead3_pled);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = led_classdev_register(&pdev->dev, &sead3_fled);
> +       if (ret < 0)
> +               led_classdev_unregister(&sead3_pled);
> +
> +       return ret;
> +}
> +
> +static int sead3_led_remove(struct platform_device *pdev)
> +{
> +       led_classdev_unregister(&sead3_pled);
> +       led_classdev_unregister(&sead3_fled);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver sead3_led_driver = {
> +       .probe          = sead3_led_probe,
> +       .remove         = sead3_led_remove,
> +       .driver         = {
> +               .name           = "sead3-led",
> +               .owner          = THIS_MODULE,
> +       },
> +};
> +
> +static int __init sead3_led_init(void)
> +{
> +       return platform_driver_register(&sead3_led_driver);
> +}
> +
> +static void __exit sead3_led_exit(void)
> +{
> +       platform_driver_unregister(&sead3_led_driver);
> +}
> +
> +module_init(sead3_led_init);
> +module_exit(sead3_led_exit);
> +

You can use module_platform_driver() here.

> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("SEAD3 LED driver");
> +MODULE_AUTHOR("Kristian Kielhofner <kris@krisk.org>");
> +MODULE_ALIAS("platform:sead3-led");
> --
> 1.9.3
>
