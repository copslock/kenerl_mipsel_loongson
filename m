Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2009 12:10:33 +0200 (CEST)
Received: from mail-ew0-f215.google.com ([209.85.219.215]:50217 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492860AbZGOKK1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2009 12:10:27 +0200
Received: by ewy11 with SMTP id 11so3783507ewy.0
        for <multiple recipients>; Wed, 15 Jul 2009 03:10:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wJoFE2Ga1cxDlNsrVO98MKQZVBDyFCZDHwHVyfSOe/8=;
        b=qwJ2FwzGzyc76HuMkwHCWUcdf5PXCqnuVPygzWUiDUIrez854yU+8Scj1Hh/ofJJUn
         BlMr8NTgVFudZAuIGPlXv4XifxpiHg7fyYvn5zlRop0lCh1kOFUocnnO5T7OoBtW+U1v
         Vf07xeaQ2ILcKDvPlShwQmxSCAHkBBakGntxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=vlGEawI0WfmmosQDghFSlXoKbhS1Crf4KB/P4gKxLV0ycApST0mSAyGuketJxaSA6E
         lbYH42b4x3DPYG+hxiwlf4wPzcxzprrccYNce85QT73qQeLdB8fONf9HZPv9PW3JwLFc
         8P0A5U9WjD49WXk+7wy0AWQ1jtfVZ1RMmqjho=
Received: by 10.210.116.16 with SMTP id o16mr4237208ebc.88.1247652621864;
        Wed, 15 Jul 2009 03:10:21 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm1167331eyz.51.2009.07.15.03.10.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 03:10:21 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Wed, 15 Jul 2009 12:10:19 +0200
Subject: [PATCH 2/2] ar7_wdt: convert to become a platform driver
MIME-Version: 1.0
X-UID:	627
X-Length: 4382
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907151210.20294.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch converts the ar7_wdt driver to become a platform
driver. The AR7 SoC specific identification and base register
calculation is performed by the board code, therefore we no
longer need to have access to ar7_chip_id.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index bfce332..9c2c4e7 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
@@ -76,24 +77,10 @@ static unsigned expect_close;
 /* XXX currently fixed, allows max margin ~68.72 secs */
 #define prescale_value 0xffff
 
-/* Offset of the WDT registers */
-static unsigned long ar7_regs_wdt;
+/* Resource of the WDT registers */
+static struct resource *ar7_regs_wdt;
 /* Pointer to the remapped WDT IO space */
 static struct ar7_wdt *ar7_wdt;
-static void ar7_wdt_get_regs(void)
-{
-	u16 chip_id = ar7_chip_id();
-	switch (chip_id) {
-	case AR7_CHIP_7100:
-	case AR7_CHIP_7200:
-		ar7_regs_wdt = AR7_REGS_WDT;
-		break;
-	default:
-		ar7_regs_wdt = UR8_REGS_WDT;
-		break;
-	}
-}
-
 
 static void ar7_wdt_kick(u32 value)
 {
@@ -298,22 +285,33 @@ static struct miscdevice ar7_wdt_miscdev = {
 	.fops		= &ar7_wdt_fops,
 };
 
-static int __init ar7_wdt_init(void)
+static int __init ar7_wdt_probe(struct platform_device *pdev)
 {
 	int rc;
 
 	spin_lock_init(&wdt_lock);
 
-	ar7_wdt_get_regs();
+	ar7_regs_wdt =
+		platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!ar7_regs_wdt) {
+		printk(KERN_ERR DRVNAME ": could not get registers resource\n");
+		rc = -ENODEV;
+		goto out;
+	}
 
-	if (!request_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt),
-							LONGNAME)) {
+	if (!request_mem_region(ar7_regs_wdt->start,
+				resource_size(ar7_regs_wdt), LONGNAME)) {
 		printk(KERN_WARNING DRVNAME ": watchdog I/O region busy\n");
-		return -EBUSY;
+		rc = -EBUSY;
+		goto out;
 	}
 
-	ar7_wdt = (struct ar7_wdt *)
-			ioremap(ar7_regs_wdt, sizeof(struct ar7_wdt));
+	ar7_wdt = ioremap(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
+	if (!ar7_wdt) {
+		printk(KERN_ERR DRVNAME ": could not ioremap registers\n");
+		rc = -ENXIO;
+		goto out;
+	}
 
 	ar7_wdt_disable_wdt();
 	ar7_wdt_prescale(prescale_value);
@@ -337,17 +335,35 @@ out_register:
 	unregister_reboot_notifier(&ar7_wdt_notifier);
 out_alloc:
 	iounmap(ar7_wdt);
-	release_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt));
+	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
 out:
 	return rc;
 }
 
-static void __exit ar7_wdt_cleanup(void)
+static int __devexit ar7_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ar7_wdt_miscdev);
 	unregister_reboot_notifier(&ar7_wdt_notifier);
 	iounmap(ar7_wdt);
-	release_mem_region(ar7_regs_wdt, sizeof(struct ar7_wdt));
+	release_mem_region(ar7_regs_wdt->start, resource_size(ar7_regs_wdt));
+
+	return 0;
+}
+
+static struct platform_driver ar7_wdt_driver = {
+	.driver.name = "ar7_wdt",
+	.probe = ar7_wdt_probe,
+	.remove = __devexit_p(ar7_wdt_remove),
+};
+
+static int __init ar7_wdt_init(void)
+{
+	return platform_driver_register(&ar7_wdt_driver);
+}
+
+static void __exit ar7_wdt_cleanup(void)
+{
+	platform_driver_unregister(&ar7_wdt_driver);
 }
 
 module_init(ar7_wdt_init);
