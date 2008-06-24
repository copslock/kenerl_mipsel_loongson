Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 22:18:04 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:61411 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20042755AbYFXVR5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 22:17:57 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OLHkVk003402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 14:17:47 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m5OLHkBf006493;
	Tue, 24 Jun 2008 14:17:46 -0700
Date:	Tue, 24 Jun 2008 14:17:46 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [PATCH][2/2] add new Cobalt LCD platform device register
Message-Id: <20080624141746.d7ddacc7.akpm@linux-foundation.org>
In-Reply-To: <20080624224702.5aa7f7ac.yoichi_yuasa@tripeaks.co.jp>
References: <20080624223004.d54f14fe.yoichi_yuasa@tripeaks.co.jp>
	<20080624224702.5aa7f7ac.yoichi_yuasa@tripeaks.co.jp>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jun 2008 22:47:02 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> Add new Cobalt LCD platform device register.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/Makefile linux/arch/mips/cobalt/Makefile
> --- linux-orig/arch/mips/cobalt/Makefile	2008-06-01 18:01:46.808253360 +0900
> +++ linux/arch/mips/cobalt/Makefile	2008-06-01 22:55:40.342007921 +0900
> @@ -2,7 +2,7 @@
>  # Makefile for the Cobalt micro systems family specific parts of the kernel
>  #
>  
> -obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o time.o
> +obj-y := buttons.o irq.o lcd.o led.o reset.o rtc.o serial.o setup.o time.o
>  
>  obj-$(CONFIG_PCI)		+= pci.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= console.o
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/lcd.c linux/arch/mips/cobalt/lcd.c
> --- linux-orig/arch/mips/cobalt/lcd.c	1970-01-01 09:00:00.000000000 +0900
> +++ linux/arch/mips/cobalt/lcd.c	2008-06-01 22:55:40.350008376 +0900
> @@ -0,0 +1,55 @@
> +/*
> + *  Registration of Cobalt LCD platform device.
> + *
> + *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +
> +static struct resource cobalt_lcd_resource __initdata = {
> +	.start	= 0x1f000000,
> +	.end	= 0x1f00001f,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static __init int cobalt_lcd_add(void)
> +{
> +	struct platform_device *pdev;
> +	int retval;
> +
> +	pdev = platform_device_alloc("cobalt-lcd", -1);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	retval = platform_device_add_resources(pdev, &cobalt_lcd_resource, 1);
> +	if (retval)
> +		goto err_free_device;
> +
> +	retval = platform_device_add(pdev);
> +	if (retval)
> +		goto err_free_device;
> +
> +	return 0;
> +
> +err_free_device:
> +	platform_device_put(pdev);
> +
> +	return retval;
> +}
> +device_initcall(cobalt_lcd_add);

afacit this driver can be compiled for and loaded on basically any
platform and architecture.

And that's OK - there are pros and cons to doing this.  But I wonder
what happens if someone _does_ load this driver on (say) an x86 box? 
If it malfunctions in some manner then we might need to be stricter in
Kconfig or at runtime?
