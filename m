Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 21:47:22 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:36374 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493527AbZHJTrQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Aug 2009 21:47:16 +0200
Received: by ewy12 with SMTP id 12so3917333ewy.0
        for <multiple recipients>; Mon, 10 Aug 2009 12:47:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8rn4C8V757SL6z/0GWGzx6DI8DCOE3152LxmpQfZHqA=;
        b=PWYxoN02wjYjIR73L2sHZqRyNBXAJIZiO3zYy8CjZTCeojL9aEC4W2QpVOAFpNkSqn
         /71JNdC/GbCm3Y2cBlz2TO7edRLp97QMUYfgywYBWX8g/YT40exUkSUx/VsTr1bdv3p4
         U0lirUT78Fo17H+PGZKV6vSPsKEbwV7AgFaWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RzcutPVD1SOVYUjvUnnyY/14KOfBEK/WTXnAj8TMDJdenjmmQ3LlflNTqxZe1IwJWF
         8NWkMkMGo/XwvmNzfI9FPO0UXb1BVcsN2dX+Z8av2ccHJ/faj5YgOlfQBshm4/5QCq5V
         GHLFko/1ctN5FU1jf0o+1lyJb+FKn+cCiN8Z0=
Received: by 10.210.140.16 with SMTP id n16mr5380291ebd.56.1249933630617;
        Mon, 10 Aug 2009 12:47:10 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 28sm213998eye.54.2009.08.10.12.47.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 12:47:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 8/8] bcm63xx: prepare for on-board watchdog support
Date:	Mon, 10 Aug 2009 21:47:05 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
References: <200908072347.16203.florian@openwrt.org> <20090808194033.GD22761@linux-mips.org>
In-Reply-To: <20090808194033.GD22761@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908102147.06692.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Saturday 08 August 2009 21:40:33 Ralf Baechle, vous avez écrit :
> On Fri, Aug 07, 2009 at 11:47:15PM +0200, Florian Fainelli wrote:
> > This patch registers the watchdog platform_device that
> > we are going to use in the watchdog platform_driver in
> > a subsequent patch.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
> > index 70ba038..a4abc11 100644
> > --- a/arch/mips/bcm63xx/Makefile
> > +++ b/arch/mips/bcm63xx/Makefile
> > @@ -5,6 +5,7 @@ obj-y		+= dev-usb-ohci.o
> >  obj-y		+= dev-usb-ehci.o
> >  obj-y		+= dev-enet.o
> >  obj-y		+= dev-dsp.o
> > +obj-y		+= dev-wdt.o
> >  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> >
> >  obj-y		+= boards/
> > diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> > b/arch/mips/bcm63xx/boards/board_bcm963xx.c index 17a8636..e6a7b4f 100644
> > --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> > +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> > @@ -28,6 +28,7 @@
> >  #include <bcm63xx_dev_usb_ohci.h>
> >  #include <bcm63xx_dev_usb_ehci.h>
> >  #include <bcm63xx_dev_dsp.h>
> > +#include <bcm63xx_dev_wdt.h>
> >  #include <board_bcm963xx.h>
> >
> >  #define PFX	"board_bcm963xx: "
> > @@ -798,6 +799,7 @@ int __init board_register_devices(void)
> >  	u32 val;
> >
> >  	bcm63xx_uart_register();
> > +	bcm63xx_wdt_register();
> >
> >  	if (board.has_pccard)
> >  		bcm63xx_pcmcia_register();
> > diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
> > new file mode 100644
> > index 0000000..6e18489
> > --- /dev/null
> > +++ b/arch/mips/bcm63xx/dev-wdt.c
> > @@ -0,0 +1,36 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General
> > Public + * License.  See the file "COPYING" in the main directory of this
> > archive + * for more details.
> > + *
> > + * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <bcm63xx_cpu.h>
> > +
> > +static struct resource wdt_resources[] = {
> > +	{
> > +		.start		= -1, /* filled at runtime */
> > +		.end		= -1, /* filled at runtime */
> > +		.flags		= IORESOURCE_MEM,
> > +	},
> > +};
> > +
> > +static struct platform_device bcm63xx_wdt_device = {
> > +	.name		= "bcm63xx-wdt",
> > +	.id		= 0,
> > +	.num_resources	= ARRAY_SIZE(wdt_resources),
> > +	.resource	= wdt_resources,
> > +};
> > +
> > +int __init bcm63xx_wdt_register(void)
> > +{
> > +	wdt_resources[0].start = bcm63xx_regset_address(RSET_WDT);
> > +	wdt_resources[0].end = wdt_resources[0].start;
> > +	wdt_resources[0].end += RSET_WDT_SIZE - 1;
> > +
> > +	return platform_device_register(&bcm63xx_wdt_device);
> > +}
> > diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h
> > b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h new file mode
> > 100644
> > index 0000000..4aae2c7
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_wdt.h
> > @@ -0,0 +1,6 @@
> > +#ifndef BCM63XX_DEV_WDT_H_
> > +#define BCM63XX_DEV_WDT_H_
> > +
> > +int bcm63xx_wdt_register(void);
> > +
> > +#endif /* BCM63XX_DEV_WDT_H_ */
>
> bcm63xx_dev_wdt.h only really exists to keep checpatch.pl happy - not a
> terribly good reason.  I suggest to remove the explicit call to
> bcm63xx_wdt_register, make the function static and use some initfunc magic
> to call it and bcm63xx_dev_wdt.h can go.

Thanks for your comment, I just sent two follow-up patches against patch 7/8 
which addresses that for the uart and watchdog registration.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
