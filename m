Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 09:10:38 +0000 (GMT)
Received: from fri.itea.ntnu.no ([IPv6:::ffff:129.241.7.60]:27520 "EHLO
	fri.itea.ntnu.no") by linux-mips.org with ESMTP id <S8225275AbVANJKd>;
	Fri, 14 Jan 2005 09:10:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id 827308521
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 10:10:25 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.179.15])
	by fri.itea.ntnu.no (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 10:10:24 +0100 (CET)
Received: from invalid.ed.ntnu.no (localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9) with ESMTP id j0E9AO18094487
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 10:10:24 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9/Submit) with ESMTP id j0E9AOuA094484
	for <linux-mips@linux-mips.org>; Fri, 14 Jan 2005 10:10:24 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date: Fri, 14 Jan 2005 10:10:24 +0100 (CET)
From: Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To: linux-mips@linux-mips.org
Subject: [PATCH] Au1xxx USB ohci-au1xxx fix for api changes done in 2.6.11-rc1
Message-ID: <20050114100904.E94466@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

Just a blue copy of the changes done to ohci-lh7a404.c


Index: linux/drivers/usb/host/ohci-au1xxx.c
===================================================================
RCS file: /home/cvs/linux/drivers/usb/host/ohci-au1xxx.c,v
retrieving revision 1.2
diff -u -r1.2 ohci-au1xxx.c
--- linux/drivers/usb/host/ohci-au1xxx.c	22 Nov 2004 00:44:19 -0000	1.2
+++ linux/drivers/usb/host/ohci-au1xxx.c	13 Jan 2005 15:26:24 -0000
@@ -122,23 +122,21 @@
  		retval = -ENOMEM;
  		goto err1;
  	}
-

-	hcd = driver->hcd_alloc ();
-	if (hcd == NULL){
-		pr_debug ("hcd_alloc failed");
+	if(dev->resource[1].flags != IORESOURCE_IRQ){
+		pr_debug ("resource[1] is not IORESOURCE_IRQ");
  		retval = -ENOMEM;
  		goto err1;
  	}

-	if(dev->resource[1].flags != IORESOURCE_IRQ){
-		pr_debug ("resource[1] is not IORESOURCE_IRQ");
+	hcd = usb_create_hcd(driver);
+	if (hcd == NULL){
+		pr_debug ("usb_create_hcd failed");
  		retval = -ENOMEM;
  		goto err1;
  	}
+	ohci_hcd_init(hcd_to_ohci(hcd));

-	hcd->driver = (struct hc_driver *) driver;
-	hcd->description = driver->description;
  	hcd->irq = dev->resource[1].start;
  	hcd->regs = addr;
  	hcd->self.controller = &dev->dev;
@@ -146,28 +144,21 @@
  	retval = hcd_buffer_create (hcd);
  	if (retval != 0) {
  		pr_debug ("pool alloc fail");
-		goto err1;
+		goto err2;
  	}

  	retval = request_irq (hcd->irq, usb_hcd_au1xxx_hcim_irq, SA_INTERRUPT,
-			      hcd->description, hcd);
+			      hcd->driver->description, hcd);
  	if (retval != 0) {
  		pr_debug("request_irq failed");
  		retval = -EBUSY;
-		goto err2;
+		goto err3;
  	}

  	pr_debug ("%s (Au1xxx) at 0x%p, irq %d",
-	     hcd->description, hcd->regs, hcd->irq);
+		hcd->driver->description, hcd->regs, hcd->irq);

-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.hcpriv = (void *) hcd;
  	hcd->self.bus_name = "au1xxx";
-	hcd->product_desc = "Au1xxx OHCI";
-
-	INIT_LIST_HEAD (&hcd->dev_list);
-
  	usb_register_bus (&hcd->self);

  	if ((retval = driver->start (hcd)) < 0)
@@ -180,10 +171,11 @@
  	*hcd_out = hcd;
  	return 0;

- err2:
+ err3:
  	hcd_buffer_destroy (hcd);
+ err2:
+	usb_put_hcd(hcd);
   err1:
-	kfree(hcd);
  	au1xxx_stop_hc(dev);
  	release_mem_region(dev->resource[0].start,
  				dev->resource[0].end
@@ -245,7 +237,7 @@
  		return ret;

  	if ((ret = ohci_run (ohci)) < 0) {
-		err ("can't start %s", ohci->hcd.self.bus_name);
+		err ("can't start %s", hcd->self.bus_name);
  		ohci_stop (hcd);
  		return ret;
  	}
@@ -257,6 +249,8 @@

  static const struct hc_driver ohci_au1xxx_hc_driver = {
  	.description =		hcd_name,
+	.product_desc =		"Au1xxx OHCD",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),

  	/*
  	 * generic hardware linkage
@@ -275,11 +269,6 @@
  	.stop =			ohci_stop,

  	/*
-	 * memory lifecycle (except per-request)
-	 */
-	.hcd_alloc =		ohci_hcd_alloc,
-
-	/*
  	 * managing i/o requests and associated device resources
  	 */
  	.urb_enqueue =		ohci_urb_enqueue,
