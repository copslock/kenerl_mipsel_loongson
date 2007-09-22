Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2007 19:59:34 +0100 (BST)
Received: from smtp115.sbc.mail.re3.yahoo.com ([66.196.96.88]:5220 "HELO
	smtp115.sbc.mail.re3.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20026703AbXIVS7Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Sep 2007 19:59:25 +0100
Received: (qmail 75260 invoked from network); 22 Sep 2007 18:59:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=PBPn3taQ3tc3fWJDHnRT2/hkmvTu16XwgvY5VtMJfGjYeOcXzi91PxSZRcKp/J38AZSQ6F9RaDS/dTM+ZcH8RJUMPqthdNu7pHHcRahkqXFuZjeDETQ46QkLIdFGEwxDQafklvA7Zd0BFauHWBiln9mzjxWPVMxDKLuKejagcBA=  ;
Received: from unknown (HELO adsl-69-226-248-13.dsl.pltn13.pacbell.net) (david-b@pacbell.net@69.226.208.120 with login)
  by smtp115.sbc.mail.re3.yahoo.com with SMTP; 22 Sep 2007 18:59:17 -0000
X-YMail-OSG: M0cUybEVM1k8q3TNoP3blclF2niEp69Hwr1E.8L17rrHOOiQDgiWZK7RopuqMBdNWyvxatvK7w--
Received: by adsl-69-226-248-13.dsl.pltn13.pacbell.net (Postfix, from userid 500)
	id BC8122371A7; Sat, 22 Sep 2007 11:59:16 -0700 (PDT)
Date:	Sat, 22 Sep 2007 11:59:16 -0700
From:	David Brownell <david-b@pacbell.net>
To:	technoboy85@gmail.com, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH][MIPS][3/7] AR7: gpio char device
Cc:	nico@openwrt.org, linux-mips@linux-mips.org,
	akpm@linux-foundation.org
References: <200709201728.10866.technoboy85@gmail.com>
 <200709201800.53887.technoboy85@gmail.com>
 <20070923.014201.75184195.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070923.014201.75184195.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20070922185916.BC8122371A7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Sat, Sep 22 2007 at 9:50am Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Thu, 20 Sep 2007 18:00:53 +0200, Matteo Croce <technoboy85@gmail.com> wrote:
> > Char device to access GPIO pins
> > 
> > Signed-off-by: Matteo Croce <technoboy85@gmail.com>
> > Signed-off-by: Nicolas Thill <nico@openwrt.org>
>
> This driver is almost platform independent.  The only
> platform-specific part is its name and AR7_GPIO_MAX.  It would be
> great if this driver was really "generic" and could be used with any
> GPIO API providers.
>
> I think there were some discussions about userspace API for GPIO on
> LKML, but cannot remember the detail.
>
> David, give us a comment please?

It's not yet platform-neutral even given those issues; see below.
And it's insufficient by itself, which is the main technical point
I'd raise:  without even udev/mdev hooks, it needs manual setup.

I don't think anyone has yet *proposed* a platform-neutral userspace
interface to GPIOs yet.  They all seem to include at least platform
specific pinmux setup ... which is probably inevitable, but that
would seem to need abstracting into platform-specific hooks.

There have been a few folk expressing interest in a userspace GPIO
interface, and a few system-specific examples.  The most flexible ones
that come to mind are on Gumstix PXA2xx boards.  One enables GPIO
IRQs through a gpio-events module; and a /proc/gpio/GPIOnn interface
monitors all the pins and their configurations (which may mean they
aren't used for GPIOs at all).  On some AVR32 boards, Atmel had a
(less capable) configfs interface, mostly used for LED access.

More detailed comments are embedded below.

- Dave


> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index b391776..b98aedf 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -928,6 +928,15 @@ config MWAVE
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called mwave.
> >  
> > +config AR7_GPIO
> > +	tristate "TI AR7 GPIO Support"
> > +	depends on AR7

As noted, this isn't generic.  It could depend on GENERIC_GPIO if
the text and code were generic.  I'll avoid commenting on AR7 symbols
in the rest of this note; just assume that they'd all be wrong.


> > +	help
> > +	  Give userspace access to the GPIO pins on the Texas Instruments AR7 
> > +	  processors.
> > +
> > +	  If compiled as a module, it will be called ar7_gpio.
> > +
> >  config SCx200_GPIO
> >  	tristate "NatSemi SCx200 GPIO Support"
> >  	depends on SCx200
> > diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> > index d68ddbe..804319e 100644
> > --- a/drivers/char/Makefile
> > +++ b/drivers/char/Makefile
> > @@ -89,6 +89,7 @@ obj-$(CONFIG_COBALT_LCD)	+= lcd.o
> >  obj-$(CONFIG_PPDEV)		+= ppdev.o
> >  obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
> >  obj-$(CONFIG_NWFLASH)		+= nwflash.o
> > +obj-$(CONFIG_AR7_GPIO)		+= ar7_gpio.o
> >  obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
> >  obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
> >  obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
> > diff --git a/drivers/char/ar7_gpio.c b/drivers/char/ar7_gpio.c
> > new file mode 100644
> > index 0000000..d57a23e
> > --- /dev/null
> > +++ b/drivers/char/ar7_gpio.c
> > @@ -0,0 +1,158 @@
> > +/*
> > + * Copyright (C) 2007 Nicolas Thill <nico@openwrt.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/io.h>
> > +#include <linux/types.h>
> > +#include <linux/cdev.h>
> > +#include <gpio.h>
>
> This should be "#include <asm/gpio.h>".

Yes.  The MIPS people seem to have an idiosyncratic convention whereby
"-Iinclude/asm-mips/mach-XXX" and/or "-Iinclude/asm-mips" get added to 
the CPP flags, but relying on that is clearly nonportable.


> > +
> > +#define DRVNAME "ar7_gpio"
> > +#define LONGNAME "TI AR7 GPIOs Driver"
> > +
> > +MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
> > +MODULE_DESCRIPTION(LONGNAME);
> > +MODULE_LICENSE("GPL");
> > +
> > +static int ar7_gpio_major;
> > +
> > +static ssize_t ar7_gpio_write(struct file *file, const char __user *buf,
> > +	size_t len, loff_t *ppos)
> > +{
> > +	int pin = iminor(file->f_dentry->d_inode);

The assumption here seems to be that each GPIO signal has its own
device node in /dev, using a dynamically assigned major number.

Now, one problem is that puts a ceiling of 256 GPIOs on the system;
and also limits their numbering scheme.  Some systems already use
GPIO numbers bigger than 256.  Right now most systems don't have that
many on-chip GPIOs, even if they use BGA-400 or similar large packages,
but I'd expect that to change before long.  And boards can easily
have that many GPIOs (or potential ones) given I/O expanders etc.


Especially given the need to reconfigure things, I wonder if it
wouldn't be better to have such stuff use configfs, with attribute
operations.  That could also let the GPIO names be specified to better
match the system or board documentation ... e.g. vendors have several
naming conventions for GPIOs (on one system, "GPIO-38"; another, "PB6";
another, "P2.6"), and sometimes board-specific names are wanted.


> > +	size_t i;
> > +
> > +	for (i = 0; i < len; ++i) {
> > +		char c;
> > +		if (get_user(c, buf + i))
> > +			return -EFAULT;
> > +		switch (c) {
> > +		case '0':
> > +			gpio_set_value(pin, 0);
> > +			break;
> > +		case '1':
> > +			gpio_set_value(pin, 1);
> > +			break;

To be generic, I'd use the gpio_set_value_cansleep() variant
here ... it won't hurt for built-in GPIOs, but it will be
mandatory if the signal is accessed through an external I2C
or SPI based GPIO expander.


> > +		case 'd':
> > +		case 'D':
> > +			ar7_gpio_disable(pin);
> > +			break;
> > +		case 'e':
> > +		case 'E':
> > +			ar7_gpio_enable(pin);
> > +			break;

I don't know what these ar7_gpio_{en,dis}able() calls do.
Maybe they're some kind of pinmux option.

The gpio_request()/gpio_free() calls aren't used, and
they should be ...


> > +		case 'i':
> > +		case 'I':
> > +		case '<':
> > +			gpio_direction_input(pin);

> > +			break;
> > +		case 'o':
> > +		case 'O':
> > +		case '>':
> > +			gpio_direction_output(pin);

The gpio_direction_{in,out}put() calls can fail, e.g. if the
pin isn't configured as GPIO or can't work in that direction.
Even AR7-specific code should check those return codes...


> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t ar7_gpio_read(struct file *file, char __user *buf,
> > +	size_t len, loff_t *ppos)
> > +{
> > +	int pin = iminor(file->f_dentry->d_inode);
> > +	int value;
> > +
> > +	value = gpio_get_value(pin);
> > +	if (put_user(value ? '1' : '0', buf))
> > +		return -EFAULT;
> > +
> > +	return 1;
> > +}

So this is a basic GPIO facility that allows input and output GPIOs.
No events reported to userspace, no pinmux.

I have nothing against basic facilities, so long as they're structured
well enough that "obvious" required extensions aren't problematic.


> > +
> > +static int ar7_gpio_open(struct inode *inode, struct file *file)
> > +{
> > +	int m = iminor(inode);
> > +
> > +	if (m >= AR7_GPIO_MAX)
> > +		return -EINVAL;

This might be a reasonable place to use gpio_request(), rather
than testing against an AR7-specific constant.

> > +
> > +	return nonseekable_open(inode, file);
> > +}
> > +
> > +static int ar7_gpio_release(struct inode *inode, struct file *file)
> > +{
> > +	return 0;

... and this would then be where gpio_free() is used.

> > +}
> > +
> > +static const struct file_operations ar7_gpio_fops = {
> > +	.owner   = THIS_MODULE,
> > +	.write   = ar7_gpio_write,
> > +	.read    = ar7_gpio_read,
> > +	.open    = ar7_gpio_open,
> > +	.release = ar7_gpio_release,
> > +	.llseek  = no_llseek,
> > +};
> > +
> > +static struct platform_device *ar7_gpio_device;
> > +
> > +static int __init ar7_gpio_init(void)
> > +{
> > +	int rc;
> > +
> > +	ar7_gpio_device = platform_device_alloc(DRVNAME, -1);
> > +	if (!ar7_gpio_device)
> > +		return -ENOMEM;

Only legacy drivers should create their own device nodes.
But this node doesn't seem to be used for *ANYTHING* so I
don't know why it even exists...

> > +
> > +	rc = platform_device_add(ar7_gpio_device);
> > +	if (rc < 0)
> > +		goto out_put;
> > +
> > +	rc = register_chrdev(ar7_gpio_major, DRVNAME, &ar7_gpio_fops);
> > +	if (rc < 0)
> > +		goto out_put;
> > +
> > +	ar7_gpio_major = rc;

Similarly, there's nothing here to cause the various /dev nodes to be
created by udev/mdev ... that seems like a significant omission.

If this were done with configfs, I might imagine there'd be a control
node which would accept userspace commands like

	- create node for GPIO N and call it "elvis"
	- remove GPIO node "elvis"

The former would then gpio_request(N, "elvis") and create some configfs
node called "elvis" with attributes that would let it be configured
as input or output, and which would expose its value.  The latter would
get rid of that node and gpio_free().

Ideally, boards would be able to preload a bunch of GPIO declarations
so that sysadmins didn't need to risk goofing that up.


> > +
> > +	rc = 0;
> > +
> > +	goto out;
> > +
> > +out_put:
> > +	platform_device_put(ar7_gpio_device);
> > +out:
> > +	return rc;
> > +}
> > +
> > +static void __exit ar7_gpio_exit(void)
> > +{
> > +	unregister_chrdev(ar7_gpio_major, DRVNAME);
> > +	platform_device_unregister(ar7_gpio_device);
> > +}
> > +
> > +module_init(ar7_gpio_init);
> > +module_exit(ar7_gpio_exit);
>
> ---
> Atsushi Nemoto
>
