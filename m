Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2008 15:05:36 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:43587 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20043739AbYFYOF2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2008 15:05:28 +0100
Received: by mo.po.2iij.net (mo31) id m5PE4oj8049043; Wed, 25 Jun 2008 23:04:50 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox300) id m5PE4kqa028318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 25 Jun 2008 23:04:46 +0900
Date:	Wed, 25 Jun 2008 23:04:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org
Subject: Re: [PATCH][2/2] add new Cobalt LCD platform device register
Message-Id: <20080625230446.edcf7435.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080624141746.d7ddacc7.akpm@linux-foundation.org>
References: <20080624223004.d54f14fe.yoichi_yuasa@tripeaks.co.jp>
	<20080624224702.5aa7f7ac.yoichi_yuasa@tripeaks.co.jp>
	<20080624141746.d7ddacc7.akpm@linux-foundation.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jun 2008 14:17:46 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 24 Jun 2008 22:47:02 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > Add new Cobalt LCD platform device register.
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> > diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/Makefile linux/arch/mips/cobalt/Makefile
> > --- linux-orig/arch/mips/cobalt/Makefile	2008-06-01 18:01:46.808253360 +0900
> > +++ linux/arch/mips/cobalt/Makefile	2008-06-01 22:55:40.342007921 +0900
> > @@ -2,7 +2,7 @@
> >  # Makefile for the Cobalt micro systems family specific parts of the kernel
> >  #
> >  
> > -obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o time.o
> > +obj-y := buttons.o irq.o lcd.o led.o reset.o rtc.o serial.o setup.o time.o
> >  
> >  obj-$(CONFIG_PCI)		+= pci.o
> >  obj-$(CONFIG_EARLY_PRINTK)	+= console.o
> > diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/lcd.c linux/arch/mips/cobalt/lcd.c
> > --- linux-orig/arch/mips/cobalt/lcd.c	1970-01-01 09:00:00.000000000 +0900
> > +++ linux/arch/mips/cobalt/lcd.c	2008-06-01 22:55:40.350008376 +0900
> > @@ -0,0 +1,55 @@
> > +/*
> > + *  Registration of Cobalt LCD platform device.
> > + *
> > + *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > + */
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/platform_device.h>
> > +
> > +static struct resource cobalt_lcd_resource __initdata = {
> > +	.start	= 0x1f000000,
> > +	.end	= 0x1f00001f,
> > +	.flags	= IORESOURCE_MEM,
> > +};
> > +
> > +static __init int cobalt_lcd_add(void)
> > +{
> > +	struct platform_device *pdev;
> > +	int retval;
> > +
> > +	pdev = platform_device_alloc("cobalt-lcd", -1);
> > +	if (!pdev)
> > +		return -ENOMEM;
> > +
> > +	retval = platform_device_add_resources(pdev, &cobalt_lcd_resource, 1);
> > +	if (retval)
> > +		goto err_free_device;
> > +
> > +	retval = platform_device_add(pdev);
> > +	if (retval)
> > +		goto err_free_device;
> > +
> > +	return 0;
> > +
> > +err_free_device:
> > +	platform_device_put(pdev);
> > +
> > +	return retval;
> > +}
> > +device_initcall(cobalt_lcd_add);
> 
> afacit this driver can be compiled for and loaded on basically any
> platform and architecture.
> 
> And that's OK - there are pros and cons to doing this.  But I wonder
> what happens if someone _does_ load this driver on (say) an x86 box? 
> If it malfunctions in some manner then we might need to be stricter in
> Kconfig or at runtime?

The runtime check is difficult to this driver.
I'll update Kconfig check.

Yoichi
