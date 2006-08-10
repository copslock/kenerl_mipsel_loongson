Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 07:53:43 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:32004 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20043072AbWHJGxl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Aug 2006 07:53:41 +0100
Received: (qmail 9123 invoked by uid 1000); 10 Aug 2006 08:53:37 +0200
Date:	Thu, 10 Aug 2006 08:53:37 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Au1200 OHCI/EHCI fixes
Message-ID: <20060810065337.GA8889@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

This little patch fixes compileproblems in Au1000
OHCI/EHCI code. Run-tested on custom Au1200 Platform.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>


diff -Naurp linux-2.6.17.7-base/drivers/usb/host/ehci-au1xxx.c linux-2.6.17.7-work/drivers/usb/host/ehci-au1xxx.c
--- linux-2.6.17.7-base/drivers/usb/host/ehci-au1xxx.c	2006-08-02 08:12:42.378136000 +0200
+++ linux-2.6.17.7-work/drivers/usb/host/ehci-au1xxx.c	2006-08-09 13:57:54.576811000 +0200
@@ -111,9 +111,9 @@ int usb_ehci_au1xxx_probe(const struct h
 
 	/* Au1200 AB USB does not support coherent memory */
 	if (!(read_c0_prid() & 0xff)) {
-		pr_info("%s: this is chip revision AB!\n", dev->dev.name);
+		pr_info("%s: this is chip revision AB!\n", dev->dev.driver->name);
 		pr_info("%s: update your board or re-configure the kernel\n",
-			dev->dev.name);
+			dev->dev.driver->name);
 		return -ENODEV;
 	}
 #endif
diff -Naurp linux-2.6.17.7-base/drivers/usb/host/ohci-au1xxx.c linux-2.6.17.7-work/drivers/usb/host/ohci-au1xxx.c
--- linux-2.6.17.7-base/drivers/usb/host/ohci-au1xxx.c	2006-08-02 08:12:42.398136000 +0200
+++ linux-2.6.17.7-work/drivers/usb/host/ohci-au1xxx.c	2006-08-10 08:46:56.430581000 +0200
@@ -84,6 +84,11 @@ static void au1xxx_start_ohc(struct plat
 	au_writel(USBH_ENABLE_INIT, USB_HOST_CONFIG);
 	udelay(1000);
 
+	/* wait for reset complete (read register twice; see au1500 errata) */
+	while (au_readl(USB_HOST_CONFIG),
+		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
+		udelay(1000);
+
 #else   /* Au1200 */
 
 	/* write HW defaults again in case Yamon cleared them */
@@ -101,11 +106,6 @@ static void au1xxx_start_ohc(struct plat
 
 #endif  /* Au1200 */
 
-	/* wait for reset complete (read register twice; see au1500 errata) */
-	while (au_readl(USB_HOST_CONFIG),
-		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
-		udelay(1000);
-
 	printk(KERN_DEBUG __FILE__
 	": Clock to USB host has been enabled \n");
 }
@@ -157,9 +157,9 @@ static int usb_ohci_au1xxx_probe(const s
 	/* Au1200 AB USB does not support coherent memory */
 	if (!(read_c0_prid() & 0xff)) {
 		pr_info("%s: this is chip revision AB !!\n",
-			dev->dev.name);
+			dev->dev.driver->name);
 		pr_info("%s: update your board or re-configure the kernel\n",
-			dev->dev.name);
+			dev->dev.driver->name);
 		return -ENODEV;
 	}
 #endif
