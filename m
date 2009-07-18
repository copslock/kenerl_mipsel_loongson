Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jul 2009 23:50:12 +0200 (CEST)
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:64476 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492848AbZGRVuE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Jul 2009 23:50:04 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAOvgYUpR93io/2dsb2JhbADLegmEAwU
Received: from 168.120-247-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.247.120.168])
  by relay.skynet.be with ESMTP; 18 Jul 2009 23:49:58 +0200
Received: from wim by infomag with local (Exim 4.69)
	(envelope-from <wim@infomag.iguana.be>)
	id 1MSHn4-0006TN-98; Sat, 18 Jul 2009 23:49:58 +0200
Date:	Sat, 18 Jul 2009 23:49:58 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Message-ID: <20090718214958.GA24850@infomag.iguana.be>
References: <200907151210.20294.florian@openwrt.org> <20090718190930.GC23797@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20090718190930.GC23797@infomag.iguana.be>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

Forgot the attachment...

Kind regards,
Wim.

> Hi Florian,
> 
> > This patch converts the ar7_wdt driver to become a platform
> > driver. The AR7 SoC specific identification and base register
> > calculation is performed by the board code, therefore we no
> > longer need to have access to ar7_chip_id.
> 
> > @@ -298,22 +285,33 @@ static struct miscdevice ar7_wdt_miscdev = {
> >  	.fops		= &ar7_wdt_fops,
> >  };
> >  
> > -static int __init ar7_wdt_init(void)
> > +static int __init ar7_wdt_probe(struct platform_device *pdev)
> 
> Should be __devinit .
> 
> > +static struct platform_driver ar7_wdt_driver = {
> > +	.driver.name = "ar7_wdt",
> > +	.probe = ar7_wdt_probe,
> > +	.remove = __devexit_p(ar7_wdt_remove),
> > +};
> 
> I prefer to have it as follows (so that the driver.owner field is also set):
> static struct platform_driver ar7_wdt_driver = {
> 	.probe = ar7_wdt_probe,
> 	.remove = __devexit_p(ar7_wdt_remove),
> 	.driver = {
> 		.owner = THIS_MODULE,
> 		.name = "ar7_wdt",
> 	},
> };
> 
> I suggest to also change the reboot notifier code into a platform shutdown method.
> You then get something like the attached patch (untested, uncompiled and I included above 2 remarks).
> For the rest: code is OK for me. After the __init to __devinit fix you can add my signed-off-by.
> 
> Kind regards,
> Wim.
> 

--TB36FDmn/VVEgNH/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="ar7_wdt.diff"

--- ar7_wdt.c.orig	2009-07-18 20:54:33.000000000 +0200
+++ ar7_wdt.c	2009-07-18 21:06:00.000000000 +0200
@@ -30,8 +30,6 @@
 #include <linux/miscdevice.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/fs.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -189,20 +187,6 @@
 	return 0;
 }
 
-static int ar7_wdt_notify_sys(struct notifier_block *this,
-			      unsigned long code, void *unused)
-{
-	if (code == SYS_HALT || code == SYS_POWER_OFF)
-		if (!nowayout)
-			ar7_wdt_disable_wdt();
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block ar7_wdt_notifier = {
-	.notifier_call = ar7_wdt_notify_sys,
-};
-
 static ssize_t ar7_wdt_write(struct file *file, const char *data,
 			     size_t len, loff_t *ppos)
 {
@@ -286,7 +270,7 @@
 	.fops		= &ar7_wdt_fops,
 };
 
-static int __init ar7_wdt_probe(struct platform_device *pdev)
+static int __devinit ar7_wdt_probe(struct platform_device *pdev)
 {
 	int rc;
 
@@ -318,22 +302,13 @@
 	ar7_wdt_prescale(prescale_value);
 	ar7_wdt_update_margin(margin);
 
-	rc = register_reboot_notifier(&ar7_wdt_notifier);
-	if (rc) {
-		printk(KERN_ERR DRVNAME
-			": unable to register reboot notifier\n");
-		goto out_alloc;
-	}
-
 	rc = misc_register(&ar7_wdt_miscdev);
 	if (rc) {
 		printk(KERN_ERR DRVNAME ": unable to register misc device\n");
-		goto out_register;
+		goto out_alloc;
 	}
 	goto out;
 
-out_register:
-	unregister_reboot_notifier(&ar7_wdt_notifier);
 out_alloc:
 	iounmap(ar7_wdt);
 	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
@@ -344,17 +319,26 @@
 static int __devexit ar7_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ar7_wdt_miscdev);
-	unregister_reboot_notifier(&ar7_wdt_notifier);
 	iounmap(ar7_wdt);
 	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
 
 	return 0;
 }
 
+static void ar7_wdt_shutdown(struct platform_device *pdev)
+{
+	if (!nowayout)
+		ar7_wdt_disable_wdt();
+}
+
 static struct platform_driver ar7_wdt_driver = {
-	.driver.name = "ar7_wdt",
 	.probe = ar7_wdt_probe,
 	.remove = __devexit_p(ar7_wdt_remove),
+	.shutdown = ar7_wdt_shutdown,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "ar7_wdt",
+	},
 };
 
 static int __init ar7_wdt_init(void)

--TB36FDmn/VVEgNH/--
