Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 18:38:18 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:47519 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S24145711AbYLESiP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2008 18:38:15 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 6FF82C80F6;
	Fri,  5 Dec 2008 20:38:08 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id gJJHRXxns1ed; Fri,  5 Dec 2008 20:38:08 +0200 (EET)
Received: from webmail.movial.fi (webmail.movial.fi [62.236.91.25])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 40755C80E6;
	Fri,  5 Dec 2008 20:38:08 +0200 (EET)
Received: by webmail.movial.fi (Postfix, from userid 33)
	id 24C2323CC69; Fri,  5 Dec 2008 20:38:08 +0200 (EET)
Received: from 88.114.236.15
        (SquirrelMail authenticated user dvorobye)
        by webmail.movial.fi with HTTP;
        Fri, 5 Dec 2008 20:38:08 +0200 (EET)
Message-ID: <42127.88.114.236.15.1228502288.squirrel@webmail.movial.fi>
In-Reply-To: <1225832216-6893-1-git-send-email-dmitri.vorobiev@movial.fi>
References:  <1225832216-6893-1-git-send-email-dmitri.vorobiev@movial.fi>
Date:	Fri, 5 Dec 2008 20:38:08 +0200 (EET)
Subject: Re: [PATCH 1/2] INPUT: remove IP22-specific code from sgi_btns
From:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>
To:	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

> The Indy front panel gets its own interrupt-based driver, so
> all Indy-specific code needs to be removed from the common
> Indy/O2 volume button driver. Additionally, the driver name
> is changed to emphasize that it is now SGI O2-specific.
>
> Build-tested for IP22 and IP32 targets.

Hi Ralf,

Any news about this patch and the next one? I just checked, it still
applies and builds beautifully :)

Thanks,
Dmitri

>
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> ---
>  drivers/input/misc/Kconfig    |   12 ++--
>  drivers/input/misc/Makefile   |    2 +-
>  drivers/input/misc/o2_btns.c  |  165
> +++++++++++++++++++++++++++++++++++++
>  drivers/input/misc/sgi_btns.c |  179
> -----------------------------------------
>  4 files changed, 172 insertions(+), 186 deletions(-)
>  create mode 100644 drivers/input/misc/o2_btns.c
>  delete mode 100644 drivers/input/misc/sgi_btns.c
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 199055d..1f93202 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -202,15 +202,15 @@ config INPUT_UINPUT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called uinput.
>
> -config INPUT_SGI_BTNS
> -	tristate "SGI Indy/O2 volume button interface"
> -	depends on SGI_IP22 || SGI_IP32
> +config INPUT_SGI_O2_BTNS
> +	tristate "SGI O2 volume button interface"
> +	depends on SGI_IP32
>  	select INPUT_POLLDEV
>  	help
> -	  Say Y here if you want to support SGI Indy/O2 volume button interface.
> +	  Say Y here if you want to support SGI O2 volume button interface.
>
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called sgi_btns.
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called o2_btns.
>
>  config HP_SDC_RTC
>  	tristate "HP SDC Real Time Clock"
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index d7db2ae..2b18c92 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -20,4 +20,4 @@ obj-$(CONFIG_INPUT_CM109)		+= cm109.o
>  obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
>  obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
>  obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
> -obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
> +obj-$(CONFIG_INPUT_SGI_O2_BTNS)		+= o2_btns.o
> diff --git a/drivers/input/misc/o2_btns.c b/drivers/input/misc/o2_btns.c
> new file mode 100644
> index 0000000..7adadc5
> --- /dev/null
> +++ b/drivers/input/misc/o2_btns.c
> @@ -0,0 +1,165 @@
> +/*
> + *  SGI Volume Button interface driver
> + *
> + *  Copyright (C) 2008  Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + */
> +#include <linux/init.h>
> +#include <linux/input-polldev.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/ip32/mace.h>
> +
> +static inline u8 button_status(void)
> +{
> +	u64 status;
> +
> +	status = readq(&mace->perif.audio.control);
> +	writeq(status & ~(3U << 23), &mace->perif.audio.control);
> +
> +	return (status >> 23) & 3;
> +}
> +
> +#define BUTTONS_POLL_INTERVAL	30	/* msec */
> +#define BUTTONS_COUNT_THRESHOLD	3
> +
> +static const unsigned short sgi_map[] = {
> +	KEY_VOLUMEDOWN,
> +	KEY_VOLUMEUP
> +};
> +
> +struct buttons_dev {
> +	struct input_polled_dev *poll_dev;
> +	unsigned short keymap[ARRAY_SIZE(sgi_map)];
> +	int count[ARRAY_SIZE(sgi_map)];
> +};
> +
> +static void handle_buttons(struct input_polled_dev *dev)
> +{
> +	struct buttons_dev *bdev = dev->private;
> +	struct input_dev *input = dev->input;
> +	u8 status;
> +	int i;
> +
> +	status = button_status();
> +
> +	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
> +		if (status & (1U << i)) {
> +			if (++bdev->count[i] == BUTTONS_COUNT_THRESHOLD) {
> +				input_event(input, EV_MSC, MSC_SCAN, i);
> +				input_report_key(input, bdev->keymap[i], 1);
> +				input_sync(input);
> +			}
> +		} else {
> +			if (bdev->count[i] >= BUTTONS_COUNT_THRESHOLD) {
> +				input_event(input, EV_MSC, MSC_SCAN, i);
> +				input_report_key(input, bdev->keymap[i], 0);
> +				input_sync(input);
> +			}
> +			bdev->count[i] = 0;
> +		}
> +	}
> +}
> +
> +static int __devinit sgi_buttons_probe(struct platform_device *pdev)
> +{
> +	struct buttons_dev *bdev;
> +	struct input_polled_dev *poll_dev;
> +	struct input_dev *input;
> +	int error, i;
> +
> +	bdev = kzalloc(sizeof(struct buttons_dev), GFP_KERNEL);
> +	poll_dev = input_allocate_polled_device();
> +	if (!bdev || !poll_dev) {
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	memcpy(bdev->keymap, sgi_map, sizeof(bdev->keymap));
> +
> +	poll_dev->private = bdev;
> +	poll_dev->poll = handle_buttons;
> +	poll_dev->poll_interval = BUTTONS_POLL_INTERVAL;
> +
> +	input = poll_dev->input;
> +	input->name = "SGI buttons";
> +	input->phys = "sgi/input0";
> +	input->id.bustype = BUS_HOST;
> +	input->dev.parent = &pdev->dev;
> +
> +	input->keycode = bdev->keymap;
> +	input->keycodemax = ARRAY_SIZE(bdev->keymap);
> +	input->keycodesize = sizeof(unsigned short);
> +
> +	input_set_capability(input, EV_MSC, MSC_SCAN);
> +	__set_bit(EV_KEY, input->evbit);
> +	for (i = 0; i < ARRAY_SIZE(sgi_map); i++)
> +		__set_bit(bdev->keymap[i], input->keybit);
> +	__clear_bit(KEY_RESERVED, input->keybit);
> +
> +	bdev->poll_dev = poll_dev;
> +	dev_set_drvdata(&pdev->dev, bdev);
> +
> +	error = input_register_polled_device(poll_dev);
> +	if (error)
> +		goto err_free_mem;
> +
> +	return 0;
> +
> + err_free_mem:
> +	input_free_polled_device(poll_dev);
> +	kfree(bdev);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	return error;
> +}
> +
> +static int __devexit sgi_buttons_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct buttons_dev *bdev = dev_get_drvdata(dev);
> +
> +	input_unregister_polled_device(bdev->poll_dev);
> +	input_free_polled_device(bdev->poll_dev);
> +	kfree(bdev);
> +	dev_set_drvdata(dev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sgi_buttons_driver = {
> +	.probe	= sgi_buttons_probe,
> +	.remove	= __devexit_p(sgi_buttons_remove),
> +	.driver	= {
> +		.name	= "sgibtns",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init sgi_buttons_init(void)
> +{
> +	return platform_driver_register(&sgi_buttons_driver);
> +}
> +
> +static void __exit sgi_buttons_exit(void)
> +{
> +	platform_driver_unregister(&sgi_buttons_driver);
> +}
> +
> +MODULE_LICENSE("GPL");
> +module_init(sgi_buttons_init);
> +module_exit(sgi_buttons_exit);
> diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
> deleted file mode 100644
> index be3a15f..0000000
> --- a/drivers/input/misc/sgi_btns.c
> +++ /dev/null
> @@ -1,179 +0,0 @@
> -/*
> - *  SGI Volume Button interface driver
> - *
> - *  Copyright (C) 2008  Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> - */
> -#include <linux/init.h>
> -#include <linux/input-polldev.h>
> -#include <linux/ioport.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -
> -#ifdef CONFIG_SGI_IP22
> -#include <asm/sgi/ioc.h>
> -
> -static inline u8 button_status(void)
> -{
> -	u8 status;
> -
> -	status = readb(&sgioc->panel) ^ 0xa0;
> -	return ((status & 0x80) >> 6) | ((status & 0x20) >> 5);
> -}
> -#endif
> -
> -#ifdef CONFIG_SGI_IP32
> -#include <asm/ip32/mace.h>
> -
> -static inline u8 button_status(void)
> -{
> -	u64 status;
> -
> -	status = readq(&mace->perif.audio.control);
> -	writeq(status & ~(3U << 23), &mace->perif.audio.control);
> -
> -	return (status >> 23) & 3;
> -}
> -#endif
> -
> -#define BUTTONS_POLL_INTERVAL	30	/* msec */
> -#define BUTTONS_COUNT_THRESHOLD	3
> -
> -static const unsigned short sgi_map[] = {
> -	KEY_VOLUMEDOWN,
> -	KEY_VOLUMEUP
> -};
> -
> -struct buttons_dev {
> -	struct input_polled_dev *poll_dev;
> -	unsigned short keymap[ARRAY_SIZE(sgi_map)];
> -	int count[ARRAY_SIZE(sgi_map)];
> -};
> -
> -static void handle_buttons(struct input_polled_dev *dev)
> -{
> -	struct buttons_dev *bdev = dev->private;
> -	struct input_dev *input = dev->input;
> -	u8 status;
> -	int i;
> -
> -	status = button_status();
> -
> -	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
> -		if (status & (1U << i)) {
> -			if (++bdev->count[i] == BUTTONS_COUNT_THRESHOLD) {
> -				input_event(input, EV_MSC, MSC_SCAN, i);
> -				input_report_key(input, bdev->keymap[i], 1);
> -				input_sync(input);
> -			}
> -		} else {
> -			if (bdev->count[i] >= BUTTONS_COUNT_THRESHOLD) {
> -				input_event(input, EV_MSC, MSC_SCAN, i);
> -				input_report_key(input, bdev->keymap[i], 0);
> -				input_sync(input);
> -			}
> -			bdev->count[i] = 0;
> -		}
> -	}
> -}
> -
> -static int __devinit sgi_buttons_probe(struct platform_device *pdev)
> -{
> -	struct buttons_dev *bdev;
> -	struct input_polled_dev *poll_dev;
> -	struct input_dev *input;
> -	int error, i;
> -
> -	bdev = kzalloc(sizeof(struct buttons_dev), GFP_KERNEL);
> -	poll_dev = input_allocate_polled_device();
> -	if (!bdev || !poll_dev) {
> -		error = -ENOMEM;
> -		goto err_free_mem;
> -	}
> -
> -	memcpy(bdev->keymap, sgi_map, sizeof(bdev->keymap));
> -
> -	poll_dev->private = bdev;
> -	poll_dev->poll = handle_buttons;
> -	poll_dev->poll_interval = BUTTONS_POLL_INTERVAL;
> -
> -	input = poll_dev->input;
> -	input->name = "SGI buttons";
> -	input->phys = "sgi/input0";
> -	input->id.bustype = BUS_HOST;
> -	input->dev.parent = &pdev->dev;
> -
> -	input->keycode = bdev->keymap;
> -	input->keycodemax = ARRAY_SIZE(bdev->keymap);
> -	input->keycodesize = sizeof(unsigned short);
> -
> -	input_set_capability(input, EV_MSC, MSC_SCAN);
> -	__set_bit(EV_KEY, input->evbit);
> -	for (i = 0; i < ARRAY_SIZE(sgi_map); i++)
> -		__set_bit(bdev->keymap[i], input->keybit);
> -	__clear_bit(KEY_RESERVED, input->keybit);
> -
> -	bdev->poll_dev = poll_dev;
> -	dev_set_drvdata(&pdev->dev, bdev);
> -
> -	error = input_register_polled_device(poll_dev);
> -	if (error)
> -		goto err_free_mem;
> -
> -	return 0;
> -
> - err_free_mem:
> -	input_free_polled_device(poll_dev);
> -	kfree(bdev);
> -	dev_set_drvdata(&pdev->dev, NULL);
> -	return error;
> -}
> -
> -static int __devexit sgi_buttons_remove(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct buttons_dev *bdev = dev_get_drvdata(dev);
> -
> -	input_unregister_polled_device(bdev->poll_dev);
> -	input_free_polled_device(bdev->poll_dev);
> -	kfree(bdev);
> -	dev_set_drvdata(dev, NULL);
> -
> -	return 0;
> -}
> -
> -static struct platform_driver sgi_buttons_driver = {
> -	.probe	= sgi_buttons_probe,
> -	.remove	= __devexit_p(sgi_buttons_remove),
> -	.driver	= {
> -		.name	= "sgibtns",
> -		.owner	= THIS_MODULE,
> -	},
> -};
> -
> -static int __init sgi_buttons_init(void)
> -{
> -	return platform_driver_register(&sgi_buttons_driver);
> -}
> -
> -static void __exit sgi_buttons_exit(void)
> -{
> -	platform_driver_unregister(&sgi_buttons_driver);
> -}
> -
> -MODULE_LICENSE("GPL");
> -module_init(sgi_buttons_init);
> -module_exit(sgi_buttons_exit);
> --
> 1.5.4.3
>
>
