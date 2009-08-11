Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2009 15:51:23 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.146]:17413 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492635AbZHKNvQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2009 15:51:16 +0200
Received: by ey-out-1920.google.com with SMTP id 13so939611eye.54
        for <multiple recipients>; Tue, 11 Aug 2009 06:51:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VWOqSgD02snaRDWAkA84wktKwWXwTAu+sO1qPT6fHvk=;
        b=BhKvCtmETKnzDxAwgN0KZLDU7Exbah7kEKy7NFu/Ianw1/Nt0qlLMykmVAIopp6sEN
         66GG13jcxI1BpRAKTnGanYR2BhjAfcO1qF7KldRliXB4yoj0rlHkgIvpfGbVCq5BpJm3
         vRtvRsScJkAAhaFUesrx+Mo18efqztiqzSWCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fHuYxZZlnIWkoQTb9aDvJofeNP7zsWDgOE6HBaHA7DpbMUvcW7US9ZYU06z/jFD1PQ
         8NvEdgEYwNtUVnAhkK58T3Wjrbt8hIH4gy7wEf8E++W7jj1s84vfSrTCGRPuWfDS5Vtk
         DTC4Tdn6WksP1e8hqJY8Yu6eZeoX2remsfwfY=
Received: by 10.210.70.8 with SMTP id s8mr867343eba.69.1249995161058;
        Tue, 11 Aug 2009 05:52:41 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm172871eyg.15.2009.08.11.05.52.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 05:52:35 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Date:	Tue, 11 Aug 2009 14:52:26 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200907151210.20294.florian@openwrt.org> <20090718214958.GA24850@infomag.iguana.be> <200907211211.35085.florian@openwrt.org>
In-Reply-To: <200907211211.35085.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908111452.28418.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Wim,

Le Tuesday 21 July 2009 12:11:32 Florian Fainelli, vous avez écrit :
> Hi Wim,
>
> Le Saturday 18 July 2009 23:49:58 Wim Van Sebroeck, vous avez écrit :
> > Hi Florian,
> >
> > Forgot the attachment...
> >
> > Kind regards,
> > Wim.
> >
> > > Hi Florian,
> > >
> > > > This patch converts the ar7_wdt driver to become a platform
> > > > driver. The AR7 SoC specific identification and base register
> > > > calculation is performed by the board code, therefore we no
> > > > longer need to have access to ar7_chip_id.
> > > >
> > > > @@ -298,22 +285,33 @@ static struct miscdevice ar7_wdt_miscdev = {
> > > >  	.fops		= &ar7_wdt_fops,
> > > >  };
> > > >
> > > > -static int __init ar7_wdt_init(void)
> > > > +static int __init ar7_wdt_probe(struct platform_device *pdev)
> > >
> > > Should be __devinit .
> > >
> > > > +static struct platform_driver ar7_wdt_driver = {
> > > > +	.driver.name = "ar7_wdt",
> > > > +	.probe = ar7_wdt_probe,
> > > > +	.remove = __devexit_p(ar7_wdt_remove),
> > > > +};
> > >
> > > I prefer to have it as follows (so that the driver.owner field is also
> > > set): static struct platform_driver ar7_wdt_driver = {
> > > 	.probe = ar7_wdt_probe,
> > > 	.remove = __devexit_p(ar7_wdt_remove),
> > > 	.driver = {
> > > 		.owner = THIS_MODULE,
> > > 		.name = "ar7_wdt",
> > > 	},
> > > };
> > >
> > > I suggest to also change the reboot notifier code into a platform
> > > shutdown method. You then get something like the attached patch
> > > (untested, uncompiled and I included above 2 remarks). For the rest:
> > > code is OK for me. After the __init to __devinit fix you can add my
> > > signed-off-by.
>
> Thanks, patch updated and attached.
>
> > > Kind regards,
> > > Wim.
>
> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH 2/2 v2] ar7_wdt: convert to become a platform driver
>
> This patch converts the ar7_wdt driver to become
> a platform driver. The AR7 SoC specific identification
> and base register calculation is performed by the board
> code, therefore we no longer need to have access to
> ar7_chip_id. We also remove the reboot notifier code to
> use the platform shutdown method as Wim suggested.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Any news on this patch ?

> --
> diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
> index 2f8643e..82855b0 100644
> --- a/drivers/watchdog/ar7_wdt.c
> +++ b/drivers/watchdog/ar7_wdt.c
> @@ -28,9 +28,8 @@
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/miscdevice.h>
> +#include <linux/platform_device.h>
>  #include <linux/watchdog.h>
> -#include <linux/notifier.h>
> -#include <linux/reboot.h>
>  #include <linux/fs.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
> @@ -76,24 +75,10 @@ static unsigned expect_close;
>  /* XXX currently fixed, allows max margin ~68.72 secs */
>  #define prescale_value 0xffff
>
> -/* Offset of the WDT registers */
> -static unsigned long ar7_regs_wdt;
> +/* Resource of the WDT registers */
> +static struct resource *ar7_regs_wdt;
>  /* Pointer to the remapped WDT IO space */
>  static struct ar7_wdt *ar7_wdt;
> -static void ar7_wdt_get_regs(void)
> -{
> -	u16 chip_id = ar7_chip_id();
> -	switch (chip_id) {
> -	case AR7_CHIP_7100:
> -	case AR7_CHIP_7200:
> -		ar7_regs_wdt = AR7_REGS_WDT;
> -		break;
> -	default:
> -		ar7_regs_wdt = UR8_REGS_WDT;
> -		break;
> -	}
> -}
> -
>
>  static void ar7_wdt_kick(u32 value)
>  {
> @@ -202,20 +187,6 @@ static int ar7_wdt_release(struct inode *inode, struct
> file *file) return 0;
>  }
>
> -static int ar7_wdt_notify_sys(struct notifier_block *this,
> -			      unsigned long code, void *unused)
> -{
> -	if (code == SYS_HALT || code == SYS_POWER_OFF)
> -		if (!nowayout)
> -			ar7_wdt_disable_wdt();
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block ar7_wdt_notifier = {
> -	.notifier_call = ar7_wdt_notify_sys,
> -};
> -
>  static ssize_t ar7_wdt_write(struct file *file, const char *data,
>  			     size_t len, loff_t *ppos)
>  {
> @@ -299,56 +270,85 @@ static struct miscdevice ar7_wdt_miscdev = {
>  	.fops		= &ar7_wdt_fops,
>  };
>
> -static int __init ar7_wdt_init(void)
> +static int __devinit ar7_wdt_probe(struct platform_device *pdev)
>  {
>  	int rc;
>
>  	spin_lock_init(&wdt_lock);
>
> -	ar7_wdt_get_regs();
> +	ar7_regs_wdt =
> +		platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	if (!ar7_regs_wdt) {
> +		printk(KERN_ERR DRVNAME ": could not get registers resource\n");
> +		rc = -ENODEV;
> +		goto out;
> +	}
>
> -	if (!request_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt),
> -							LONGNAME)) {
> +	if (!request_mem_region(ar7_regs_wdt->start,
> +				resource_size(ar7_regs_wdt), LONGNAME)) {
>  		printk(KERN_WARNING DRVNAME ": watchdog I/O region busy\n");
> -		return -EBUSY;
> +		rc = -EBUSY;
> +		goto out;
>  	}
>
> -	ar7_wdt = (struct ar7_wdt *)
> -			ioremap(ar7_regs_wdt, sizeof(struct ar7_wdt));
> +	ar7_wdt = ioremap(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
> +	if (!ar7_wdt) {
> +		printk(KERN_ERR DRVNAME ": could not ioremap registers\n");
> +		rc = -ENXIO;
> +		goto out;
> +	}
>
>  	ar7_wdt_disable_wdt();
>  	ar7_wdt_prescale(prescale_value);
>  	ar7_wdt_update_margin(margin);
>
> -	rc = register_reboot_notifier(&ar7_wdt_notifier);
> -	if (rc) {
> -		printk(KERN_ERR DRVNAME
> -			": unable to register reboot notifier\n");
> -		goto out_alloc;
> -	}
> -
>  	rc = misc_register(&ar7_wdt_miscdev);
>  	if (rc) {
>  		printk(KERN_ERR DRVNAME ": unable to register misc device\n");
> -		goto out_register;
> +		goto out_alloc;
>  	}
>  	goto out;
>
> -out_register:
> -	unregister_reboot_notifier(&ar7_wdt_notifier);
>  out_alloc:
>  	iounmap(ar7_wdt);
> -	release_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt));
> +	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
>  out:
>  	return rc;
>  }
>
> -static void __exit ar7_wdt_cleanup(void)
> +static int __devexit ar7_wdt_remove(struct platform_device *pdev)
>  {
>  	misc_deregister(&ar7_wdt_miscdev);
> -	unregister_reboot_notifier(&ar7_wdt_notifier);
>  	iounmap(ar7_wdt);
> -	release_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt));
> +	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
> +
> +	return 0;
> +}
> +
> +static void ar7_wdt_shutdown(struct platform_device *pdev)
> +{
> +	if (!nowayout)
> +		ar7_wdt_disable_wdt();
> +}
> +
> +static struct platform_driver ar7_wdt_driver = {
> +	.probe = ar7_wdt_probe,
> +	.remove = __devexit_p(ar7_wdt_remove),
> +	.shutdown = ar7_wdt_shutdown,
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "ar7_wdt",
> +	},
> +};
> +
> +static int __init ar7_wdt_init(void)
> +{
> +	return platform_driver_register(&ar7_wdt_driver);
> +}
> +
> +static void __exit ar7_wdt_cleanup(void)
> +{
> +	platform_driver_unregister(&ar7_wdt_driver);
>  }
>
>  module_init(ar7_wdt_init);



-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
