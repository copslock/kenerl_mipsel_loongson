Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2007 17:41:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:21972 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022311AbXIVQlq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Sep 2007 17:41:46 +0100
Received: from localhost (p3087-ipad306funabasi.chiba.ocn.ne.jp [123.217.173.87])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 456DF942A; Sun, 23 Sep 2007 01:40:24 +0900 (JST)
Date:	Sun, 23 Sep 2007 01:42:01 +0900 (JST)
Message-Id: <20070923.014201.75184195.anemo@mba.ocn.ne.jp>
To:	technoboy85@gmail.com, David Brownell <david-b@pacbell.net>
Cc:	linux-mips@linux-mips.org, nico@openwrt.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][3/7] AR7: gpio char device
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200709201800.53887.technoboy85@gmail.com>
References: <200709201728.10866.technoboy85@gmail.com>
	<200709201800.53887.technoboy85@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Sep 2007 18:00:53 +0200, Matteo Croce <technoboy85@gmail.com> wrote:
> Char device to access GPIO pins
> 
> Signed-off-by: Matteo Croce <technoboy85@gmail.com>
> Signed-off-by: Nicolas Thill <nico@openwrt.org>

This driver is almost platform independent.  The only
platform-specific part is its name and AR7_GPIO_MAX.  It would be
great if this driver was really "generic" and could be used with any
GPIO API providers.

I think there were some discussions about userspace API for GPIO on
LKML, but cannot remember the detail.

David, give us a comment please?

> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index b391776..b98aedf 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -928,6 +928,15 @@ config MWAVE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mwave.
>  
> +config AR7_GPIO
> +	tristate "TI AR7 GPIO Support"
> +	depends on AR7
> +	help
> +	  Give userspace access to the GPIO pins on the Texas Instruments AR7 
> +	  processors.
> +
> +	  If compiled as a module, it will be called ar7_gpio.
> +
>  config SCx200_GPIO
>  	tristate "NatSemi SCx200 GPIO Support"
>  	depends on SCx200
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index d68ddbe..804319e 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_COBALT_LCD)	+= lcd.o
>  obj-$(CONFIG_PPDEV)		+= ppdev.o
>  obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
>  obj-$(CONFIG_NWFLASH)		+= nwflash.o
> +obj-$(CONFIG_AR7_GPIO)		+= ar7_gpio.o
>  obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
>  obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
>  obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
> diff --git a/drivers/char/ar7_gpio.c b/drivers/char/ar7_gpio.c
> new file mode 100644
> index 0000000..d57a23e
> --- /dev/null
> +++ b/drivers/char/ar7_gpio.c
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright (C) 2007 Nicolas Thill <nico@openwrt.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +#include <linux/types.h>
> +#include <linux/cdev.h>
> +#include <gpio.h>

This should be "#include <asm/gpio.h>".

> +
> +#define DRVNAME "ar7_gpio"
> +#define LONGNAME "TI AR7 GPIOs Driver"
> +
> +MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
> +MODULE_DESCRIPTION(LONGNAME);
> +MODULE_LICENSE("GPL");
> +
> +static int ar7_gpio_major;
> +
> +static ssize_t ar7_gpio_write(struct file *file, const char __user *buf,
> +	size_t len, loff_t *ppos)
> +{
> +	int pin = iminor(file->f_dentry->d_inode);
> +	size_t i;
> +
> +	for (i = 0; i < len; ++i) {
> +		char c;
> +		if (get_user(c, buf + i))
> +			return -EFAULT;
> +		switch (c) {
> +		case '0':
> +			gpio_set_value(pin, 0);
> +			break;
> +		case '1':
> +			gpio_set_value(pin, 1);
> +			break;
> +		case 'd':
> +		case 'D':
> +			ar7_gpio_disable(pin);
> +			break;
> +		case 'e':
> +		case 'E':
> +			ar7_gpio_enable(pin);
> +			break;
> +		case 'i':
> +		case 'I':
> +		case '<':
> +			gpio_direction_input(pin);
> +			break;
> +		case 'o':
> +		case 'O':
> +		case '>':
> +			gpio_direction_output(pin);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t ar7_gpio_read(struct file *file, char __user *buf,
> +	size_t len, loff_t *ppos)
> +{
> +	int pin = iminor(file->f_dentry->d_inode);
> +	int value;
> +
> +	value = gpio_get_value(pin);
> +	if (put_user(value ? '1' : '0', buf))
> +		return -EFAULT;
> +
> +	return 1;
> +}
> +
> +static int ar7_gpio_open(struct inode *inode, struct file *file)
> +{
> +	int m = iminor(inode);
> +
> +	if (m >= AR7_GPIO_MAX)
> +		return -EINVAL;
> +
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int ar7_gpio_release(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}
> +
> +static const struct file_operations ar7_gpio_fops = {
> +	.owner   = THIS_MODULE,
> +	.write   = ar7_gpio_write,
> +	.read    = ar7_gpio_read,
> +	.open    = ar7_gpio_open,
> +	.release = ar7_gpio_release,
> +	.llseek  = no_llseek,
> +};
> +
> +static struct platform_device *ar7_gpio_device;
> +
> +static int __init ar7_gpio_init(void)
> +{
> +	int rc;
> +
> +	ar7_gpio_device = platform_device_alloc(DRVNAME, -1);
> +	if (!ar7_gpio_device)
> +		return -ENOMEM;
> +
> +	rc = platform_device_add(ar7_gpio_device);
> +	if (rc < 0)
> +		goto out_put;
> +
> +	rc = register_chrdev(ar7_gpio_major, DRVNAME, &ar7_gpio_fops);
> +	if (rc < 0)
> +		goto out_put;
> +
> +	ar7_gpio_major = rc;
> +
> +	rc = 0;
> +
> +	goto out;
> +
> +out_put:
> +	platform_device_put(ar7_gpio_device);
> +out:
> +	return rc;
> +}
> +
> +static void __exit ar7_gpio_exit(void)
> +{
> +	unregister_chrdev(ar7_gpio_major, DRVNAME);
> +	platform_device_unregister(ar7_gpio_device);
> +}
> +
> +module_init(ar7_gpio_init);
> +module_exit(ar7_gpio_exit);

---
Atsushi Nemoto
