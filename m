Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:32:00 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7395 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022929AbXITQb6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:31:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8KGVvMB003061;
	Thu, 20 Sep 2007 17:31:58 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8KGVupv003060;
	Thu, 20 Sep 2007 17:31:56 +0100
Date:	Thu, 20 Sep 2007 17:31:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][3/6]led: add Cobalt Raq LEDs platform register
Message-ID: <20070920163156.GD5522@linux-mips.org>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp> <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp> <20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 11:05:13PM +0900, Yoichi Yuasa wrote:
> From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
> --- mips-orig/arch/mips/cobalt/Makefile	2007-09-20 10:17:53.325755750 +0900
> +++ mips/arch/mips/cobalt/Makefile	2007-09-20 10:27:39.366381000 +0900
> @@ -2,7 +2,7 @@
>  # Makefile for the Cobalt micro systems family specific parts of the kernel
>  #
>  
> -obj-y := buttons.o irq.o reset.o rtc.o serial.o setup.o
> +obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o
>  
>  obj-$(CONFIG_PCI)		+= pci.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= console.o
> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/led.c mips/arch/mips/cobalt/led.c
> --- mips-orig/arch/mips/cobalt/led.c	1970-01-01 09:00:00.000000000 +0900
> +++ mips/arch/mips/cobalt/led.c	2007-09-20 10:27:39.370381250 +0900
> @@ -0,0 +1,56 @@
> +/*
> + *  Registration of Cobalt LED platform device.
> + *
> + *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +
> +static struct resource cobalt_led_resource __initdata = {
> +	.start	= 0x1c000000,
> +	.end	= 0x1c000000,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static __init int cobalt_led_add(void)
> +{
> +	struct platform_device *pdev;
> +	int retval;
> +
> +	pdev = platform_device_alloc("Cobalt Raq LEDs", -1);

Can you make that string something all lowercase without spaces?  The
device driver side (patch 2/6) would obviously need the same change.

Thanks,

  ralf
