Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2005 00:12:23 +0000 (GMT)
Received: from www.clearcore.com ([IPv6:::ffff:69.20.152.109]:3747 "EHLO
	sam.clearcore.com") by linux-mips.org with ESMTP
	id <S8225253AbVCWAMI>; Wed, 23 Mar 2005 00:12:08 +0000
Received: by sam.clearcore.com (Postfix, from userid 501)
	id 521027E68; Tue, 22 Mar 2005 17:12:05 -0700 (MST)
From:	joeg <joeg@sam.clearcore.com>
To:	linux-mips@linux-mips.org, ppopov@embeddedalley.com,
	eckhardt@satorlaser.com
Subject: Re: ohci-au1xxx.c breakage
Message-Id: <20050323001205.521027E68@sam.clearcore.com>
Date:	Tue, 22 Mar 2005 17:12:05 -0700 (MST)
Return-Path: <joeg@clearcore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joeg@sam.clearcore.com
Precedence: bulk
X-list: linux-mips


This patch works for me on an Au1550 little endian.

Joe

--- linux-2.6.11-3/drivers/usb/host/ohci-au1xxx.c	2005-03-18 10:37:49.000000000 -0700
+++ test_2.6.11_3_tree/drivers/usb/host/ohci-au1xxx.c	2005-03-22 15:29:14.376513351 -0700
@@ -84,97 +84,48 @@ static void au1xxx_stop_hc(struct platfo
  *
  */
 int usb_hcd_au1xxx_probe (const struct hc_driver *driver,
-			  struct usb_hcd **hcd_out,
 			  struct platform_device *dev)
 {
 	int retval;
-	struct usb_hcd *hcd = 0;
-
-	unsigned int *addr = NULL;
-
-	if (!request_mem_region(dev->resource[0].start,
-				dev->resource[0].end
-				- dev->resource[0].start + 1, hcd_name)) {
-		pr_debug("request_mem_region failed");
-		return -EBUSY;
-	}
-	
-	au1xxx_start_hc(dev);
-	
-	addr = ioremap(dev->resource[0].start,
-		       dev->resource[0].end
-		       - dev->resource[0].start + 1);
-	if (!addr) {
-		pr_debug("ioremap failed");
-		retval = -ENOMEM;
-		goto out_release;
-	}
+	struct usb_hcd *hcd;
 
 	if (dev->resource[1].flags != IORESOURCE_IRQ) {
 		pr_debug ("resource[1] is not IORESOURCE_IRQ");
 		retval = -ENOMEM;
-		goto out_iounmap;
 	}
 
-	hcd = usb_create_hcd(driver);
-	if (hcd == NULL) {
-		pr_debug ("usb_create_hcd failed");
-		retval = -ENOMEM;
-		goto out_iounmap;
-	}
-	ohci_hcd_init(hcd_to_ohci(hcd));
+	hcd = usb_create_hcd(driver, &dev->dev, "Au1xxx");
+	if (!hcd)
+		return -ENOMEM;
+	hcd->rsrc_start = dev->resource[0].start;
+	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
 
-	hcd->irq = dev->resource[1].start;
-	hcd->regs = addr;
-	hcd->self.controller = &dev->dev;
-
-	retval = hcd_buffer_create (hcd);
-	if (retval != 0) {
-		pr_debug ("pool alloc fail");
-		goto out_put_hcd;
-	}
-
-	retval = request_irq (hcd->irq, usb_hcd_au1xxx_hcim_irq, SA_INTERRUPT,
-			      hcd->driver->description, hcd);
-	if (retval != 0) {
-		pr_debug("request_irq failed");
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed");
 		retval = -EBUSY;
-		goto out_free_buffer;
+		goto err1;
 	}
 
-	pr_debug ("%s (Au1xxx) at 0x%p, irq %d",
-	     hcd->driver->description, hcd->regs, hcd->irq);
-
-	hcd->self.bus_name = "au1xxx";
-
-	if ((retval = usb_register_bus(&hcd->self)))
-		goto out_free_irq;
-
-	if ((retval = driver->start(hcd)) < 0) {
-		usb_hcd_au1xxx_remove(hcd, dev);
-		printk("bad driver->start\n");
-		return retval;
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		retval = -ENOMEM;
+		goto err2;
 	}
 
-	*hcd_out = hcd;
+	au1xxx_start_hc(dev);
+	ohci_hcd_init(hcd_to_ohci(hcd));
 
-	return 0;
+	retval = usb_add_hcd(hcd, dev->resource[1].start, SA_INTERRUPT);
+	if (retval == 0)
+		return retval;
 
-out_unregister_bus:
-	usb_deregister_bus(&hcd->self);
-out_free_irq:
-	free_irq(hcd->irq, hcd);
-out_free_buffer:
-	hcd_buffer_destroy (hcd);
-out_put_hcd:
-	usb_put_hcd(hcd);
-out_iounmap:
-	iounmap(addr);
-out_release:
 	au1xxx_stop_hc(dev);
-	release_mem_region(dev->resource[0].start,
-				dev->resource[0].end
-			   - dev->resource[0].start + 1);
+	iounmap(hcd->regs);
+ err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+ err1:
+	usb_put_hcd(hcd);
 	return retval;
 }
 
