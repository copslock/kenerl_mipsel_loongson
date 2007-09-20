Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:38:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19105 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022996AbXITQim (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:38:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8KGcfgn003252;
	Thu, 20 Sep 2007 17:38:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8KGceEq003251;
	Thu, 20 Sep 2007 17:38:40 +0100
Date:	Thu, 20 Sep 2007 17:38:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][4/6] led: update Cobalt Qube series front LED support
Message-ID: <20070920163840.GE5522@linux-mips.org>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp> <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp> <20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp> <20070920230656.640886f5.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070920230656.640886f5.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 11:06:56PM +0900, Yoichi Yuasa wrote:

> Update Cobalt Qube series front LED support.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/leds/leds-cobalt-qube.c mips/drivers/leds/leds-cobalt-qube.c
> --- mips-orig/drivers/leds/leds-cobalt-qube.c	2007-09-14 11:16:22.397075500 +0900
> +++ mips/drivers/leds/leds-cobalt-qube.c	2007-09-14 11:38:52.797470250 +0900
> @@ -3,40 +3,100 @@
>   *
>   * Control the Cobalt Qube series front LED
>   */
> -
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/types.h>
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/leds.h>
> -#include <asm/mach-cobalt/cobalt.h>
>  
> -static void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightness brightness)
> +#include <asm/io.h>

<linux/io.h>

> +
> +#define LED_FRONT_LEFT	0x01
> +#define LED_FRONT_RIGHT	0x02
> +
> +static void __iomem *led_port;
> +static u8 led_value;
> +
> +static void qube_front_led_set(struct led_classdev *led_cdev,
> +                               enum led_brightness brightness)
>  {
>  	if (brightness)
> -		COBALT_LED_PORT = COBALT_LED_BAR_LEFT | COBALT_LED_BAR_RIGHT;
> +		led_value = LED_FRONT_LEFT | LED_FRONT_RIGHT;
>  	else
> -		COBALT_LED_PORT = 0;
> +		led_value = ~(LED_FRONT_LEFT | LED_FRONT_RIGHT);
> +	writeb(led_value, led_port);
> +}
> +
> +static struct led_classdev qube_front_led = {
> +	.name			= "qube-front",
> +	.brightness		= LED_FULL,
> +	.brightness_set		= qube_front_led_set,
> +	.default_trigger	= "ide-disk",
> +};
> +
> +static int __devinit cobalt_qube_led_probe(struct platform_device *pdev)
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
> +	led_value = LED_FRONT_LEFT | LED_FRONT_RIGHT;
> +	writeb(led_value, led_port);
> +
> +	retval = led_classdev_register(&pdev->dev, &qube_front_led);
> +	if (retval)
> +		goto err_iounmap;
> +
> +	return 0;
> +
> +err_iounmap:
> +	iounmap(led_port);
> +	led_port = NULL;
> +
> +	return retval;
> +}
> +
> +static int __devexit cobalt_qube_led_remove(struct platform_device *pdev)
> +{
> +	led_classdev_unregister(&qube_front_led);
> +
> +	if (led_port) {
> +		iounmap(led_port);
> +		led_port = NULL;
> +	}
> +
> +	return 0;
>  }
>  
> -static struct led_classdev cobalt_led = {
> -       .name = "cobalt-front-led",
> -       .brightness_set = cobalt_led_set,
> -       .default_trigger = "ide-disk",
> +static struct platform_driver cobalt_qube_led_driver = {
> +	.probe	= cobalt_qube_led_probe,
> +	.remove	= __devexit_p(cobalt_qube_led_remove),
> +	.driver	= {
> +		.name	= "Cobalt Qube LEDs",

Again, please make this something lowercase without spaces.

> +		.owner	= THIS_MODULE,
> +	},
>  };
>  
> -static int __init cobalt_led_init(void)
> +static int __init cobalt_qube_led_init(void)
>  {
> -	return led_classdev_register(NULL, &cobalt_led);
> +	return platform_driver_register(&cobalt_qube_led_driver);
>  }
>  
> -static void __exit cobalt_led_exit(void)
> +static void __exit cobalt_qube_led_exit(void)
>  {
> -	led_classdev_unregister(&cobalt_led);
> +	platform_driver_unregister(&cobalt_qube_led_driver);
>  }
>  
> -module_init(cobalt_led_init);
> -module_exit(cobalt_led_exit);
> +module_init(cobalt_qube_led_init);
> +module_exit(cobalt_qube_led_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Front LED support for Cobalt Qube series");

  Ralf
