Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 21:10:04 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:43015 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133645AbWFWUJy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 21:09:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id C45E47F4028;
	Fri, 23 Jun 2006 22:09:51 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00971-06; Fri, 23 Jun 2006 22:09:51 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 1FC037F4022;
	Fri, 23 Jun 2006 22:09:50 +0200 (CEST)
In-Reply-To: <20060623200722.GA4021@linux-mips.org>
References: <5798565C-F3E1-4EB5-8886-51D65BEFEF02@caiaq.de> <20060623200722.GA4021@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-987493802
Message-Id: <683C25AE-D891-4460-99DF-FE91891DC0F8@caiaq.de>
Cc:	linux-mips@linux-mips.org
From:	Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] au1200 USB - EHCI and OHCI fixes
Date:	Fri, 23 Jun 2006 22:09:45 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.750)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips


--Apple-Mail-1-987493802
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi,

On Jun 23, 2006, at 10:07 PM, Ralf Baechle wrote:

>> Anyway, here's a trivial patch that makes the USB subsystem working
>> on my board for both OHCI and EHCI.
>> It also removes the /* FIXME use "struct platform_driver" */.
>
> Patch is looking good but has been linewrapped, can you resend?

attached.

Daniel


--Apple-Mail-1-987493802
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="au1200-usb.patch"
Content-Disposition: attachment;
	filename=au1200-usb.patch

diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci-au1xxx.c
index 9b4697a..aed6ada 100644
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -41,8 +41,6 @@
 #endif
 #define USBH_DISABLE      (USB_MCFG_EBMEN | USB_MCFG_EMEMEN)
 
-#endif				/* Au1200 */
-
 extern int usb_disabled(void);
 
 /*-------------------------------------------------------------------------*/
@@ -107,9 +105,9 @@ int usb_ehci_au1xxx_probe(const struct h
 
 	/* Au1200 AB USB does not support coherent memory */
 	if (!(read_c0_prid() & 0xff)) {
-		pr_info("%s: this is chip revision AB!\n", dev->dev.name);
+		pr_info("%s: this is chip revision AB!\n", dev->name);
 		pr_info("%s: update your board or re-configure the kernel\n",
-			dev->dev.name);
+			dev->name);
 		return -ENODEV;
 	}
 #endif
@@ -228,9 +226,8 @@ static const struct hc_driver ehci_au1xx
 
 /*-------------------------------------------------------------------------*/
 
-static int ehci_hcd_au1xxx_drv_probe(struct device *dev)
+static int ehci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct usb_hcd *hcd = NULL;
 	int ret;
 
@@ -243,10 +240,9 @@ static int ehci_hcd_au1xxx_drv_probe(str
 	return ret;
 }
 
-static int ehci_hcd_au1xxx_drv_remove(struct device *dev)
+static int ehci_hcd_au1xxx_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_ehci_au1xxx_remove(hcd, pdev);
 	return 0;
@@ -269,12 +265,13 @@ static int ehci_hcd_au1xxx_drv_resume(st
 }
 */
 MODULE_ALIAS("au1xxx-ehci");
-/* FIXME use "struct platform_driver" */
-static struct device_driver ehci_hcd_au1xxx_driver = {
-	.name = "au1xxx-ehci",
-	.bus = &platform_bus_type,
+static struct platform_driver ehci_hcd_au1xxx_driver = {
 	.probe = ehci_hcd_au1xxx_drv_probe,
 	.remove = ehci_hcd_au1xxx_drv_remove,
 	/*.suspend      = ehci_hcd_au1xxx_drv_suspend, */
 	/*.resume       = ehci_hcd_au1xxx_drv_resume, */
+	.driver = {
+		.name = "au1xxx-ehci",
+		.bus = &platform_bus_type
+	}
 };
diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index a1c8b3b..64c2fb2 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -101,6 +101,7 @@ static void au1xxx_start_ohc(struct plat
 
 #endif  /* Au1200 */
 
+#ifndef CONFIG_SOC_AU1200
 	/* wait for reset complete (read register twice; see au1500 errata) */
 	while (au_readl(USB_HOST_CONFIG),
 		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
@@ -108,6 +109,7 @@ static void au1xxx_start_ohc(struct plat
 
 	printk(KERN_DEBUG __FILE__
 	": Clock to USB host has been enabled \n");
+#endif
 }
 
 static void au1xxx_stop_ohc(struct platform_device *dev)
@@ -157,9 +159,9 @@ static int usb_ohci_au1xxx_probe(const s
 	/* Au1200 AB USB does not support coherent memory */
 	if (!(read_c0_prid() & 0xff)) {
 		pr_info("%s: this is chip revision AB !!\n",
-			dev->dev.name);
+			dev->name);
 		pr_info("%s: update your board or re-configure the kernel\n",
-			dev->dev.name);
+			dev->name);
 		return -ENODEV;
 	}
 #endif

--Apple-Mail-1-987493802--
