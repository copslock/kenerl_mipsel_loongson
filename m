Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:00:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38329 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022242AbXITQAg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:00:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8KG0ZcH013281;
	Thu, 20 Sep 2007 17:00:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8KG0Y9M013280;
	Thu, 20 Sep 2007 17:00:34 +0100
Date:	Thu, 20 Sep 2007 17:00:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2/6] led: add Cobalt Raq series LEDs support
Message-ID: <20070920160034.GC5522@linux-mips.org>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp> <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 11:03:22PM +0900, Yoichi Yuasa wrote:

> diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/leds/leds-cobalt-raq.c mips/drivers/leds/leds-cobalt-raq.c
> --- mips-orig/drivers/leds/leds-cobalt-raq.c	1970-01-01 09:00:00.000000000 +0900
> +++ mips/drivers/leds/leds-cobalt-raq.c	2007-09-14 13:06:03.900173500 +0900
> @@ -0,0 +1,135 @@
> +/*
> + *  LEDs driver for the Cobalt Raq series.
> + *
> + *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.

Do you really want to allow version 2 or newer?  (Just checking)

> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/leds.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <asm/io.h>

This should be <linux/io.h>

> +
> +#define LED_WEB		0x04
> +#define LED_POWER_OFF	0x08
> +
> +static void __iomem *led_port;
> +static u8 led_value;
> +static DEFINE_SPINLOCK(led_value_lock);
> +
> +static void raq_web_led_set(struct led_classdev *led_cdev,
> +                            enum led_brightness brightness)
> +{
> +	spin_lock_irq(&led_value_lock);
> +
> +	if (brightness)
> +		led_value |= LED_WEB;
> +	else
> +		led_value &= ~LED_WEB;
> +	writeb(led_value, led_port);
> +
> +	spin_unlock_irq(&led_value_lock);
> +}
> +
> +static struct led_classdev raq_web_led = {
> +	.name		= "raq-web",
> +	.brightness_set	= raq_web_led_set,
> +};
> +
> +static void raq_power_off_led_set(struct led_classdev *led_cdev,
> +                                  enum led_brightness brightness)
> +{
> +	spin_lock_irq(&led_value_lock);
> +
> +	if (brightness)
> +		led_value |= LED_POWER_OFF;
> +	else
> +		led_value &= ~LED_POWER_OFF;
> +	writeb(led_value, led_port);
> +
> +	spin_unlock_irq(&led_value_lock);
> +}
> +
> +static struct led_classdev raq_power_off_led = {
> +	.name			= "raq-power-off",
> +	.brightness_set		= raq_power_off_led_set,
> +	.default_trigger	= "power-off",
> +};
> +
> +static int __devinit cobalt_raq_led_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int retval;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EBUSY;
> +
> +	led_port = ioremap(res->start, res->end - res->start + 1);
> +	if (!led_port)
> +		return -ENOMEM;
> +
> +	retval = led_classdev_register(&pdev->dev, &raq_power_off_led);
> +	if (retval)
> +		goto err_iounmap;
> +
> +	retval = led_classdev_register(&pdev->dev, &raq_web_led);
> +	if (retval)
> +		goto err_unregister;
> +
> +	return 0;
> +
> +err_unregister:
> +	led_classdev_unregister(&raq_power_off_led);
> +
> +err_iounmap:
> +	iounmap(led_port);
> +	led_port = NULL;
> +
> +	return retval;
> +}
> +
> +static int __devexit cobalt_raq_led_remove(struct platform_device *pdev)
> +{
> +	led_classdev_unregister(&raq_power_off_led);
> +	led_classdev_unregister(&raq_web_led);
> +
> +	if (led_port) {
> +		iounmap(led_port);
> +		led_port = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cobalt_raq_led_driver = {
> +	.probe	= cobalt_raq_led_probe,
> +	.remove	= __devexit_p(cobalt_raq_led_remove),
> +	.driver = {
> +		.name	= "Cobalt Raq LEDs",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init cobalt_raq_led_init(void)
> +{
> +	return platform_driver_register(&cobalt_raq_led_driver);
> +}
> +
> +module_init(cobalt_raq_led_init);

  Ralf
