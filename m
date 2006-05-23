Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 18:46:56 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:34976 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133928AbWEWQqs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 May 2006 18:46:48 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FiZyE-0008Dx-KG
	for linux-mips@linux-mips.org; Tue, 23 May 2006 18:42:59 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1Fia2B-00039q-Pv
	for linux-mips@linux-mips.org; Tue, 23 May 2006 18:47:03 +0200
Date:	Tue, 23 May 2006 18:47:03 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060523164703.GD28124@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Power management support for OHCI on au1x00
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here:

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-ohci_au1xxx_pm_support

and attached my patch for power management support for OHCI on au1x00.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ohci_au1xxx_pm_support

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index a1c8b3b..ed4f783 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -14,6 +14,8 @@
  *  by Durgesh Pattamatta <pattamattad@sharpsec.com>
  * Modified for AMD Alchemy Au1xxx
  *  by Matt Porter <mporter@kernel.crashing.org>
+ * Modified to add PM support
+ *  by Rodolfo Giometti <giometti@linux.it> on May 2006
  *
  * This file is licenced under the GPL.
  */
@@ -229,6 +231,15 @@ static void usb_ohci_au1xxx_remove(struc
 
 /*-------------------------------------------------------------------------*/
 
+static int
+ohci_au1xxx_reset (struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci (hcd);
+
+	ohci_hcd_init (ohci);
+	return ohci_init (ohci);
+}
+
 static int __devinit
 ohci_au1xxx_start (struct usb_hcd *hcd)
 {
@@ -249,6 +260,37 @@ ohci_au1xxx_start (struct usb_hcd *hcd)
 	return 0;
 }
 
+#ifdef	CONFIG_PM
+static int ohci_au1xxx_suspend (struct usb_hcd *hcd, pm_message_t message)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+	unsigned long	flags;
+	int		rc = 0;
+
+	spin_lock_irqsave (&ohci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		rc = -EINVAL;
+		goto exit;
+	}
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
+	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+exit:
+	spin_unlock_irqrestore (&ohci->lock, flags);
+
+	return rc;
+}
+
+static int ohci_au1xxx_resume (struct usb_hcd *hcd)
+{
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	usb_hcd_resume_root_hub(hcd);
+	return 0;
+}
+#endif	/* CONFIG_PM */
+
+
 /*-------------------------------------------------------------------------*/
 
 static const struct hc_driver ohci_au1xxx_hc_driver = {
@@ -265,11 +307,12 @@ static const struct hc_driver ohci_au1xx
 	/*
 	 * basic lifecycle operations
 	 */
+	.reset =		ohci_au1xxx_reset,
 	.start =		ohci_au1xxx_start,
-#ifdef	CONFIG_PM
-	/* suspend:		ohci_au1xxx_suspend,  -- tbd */
-	/* resume:		ohci_au1xxx_resume,   -- tbd */
-#endif /*CONFIG_PM*/
+#ifdef  CONFIG_PM
+	.suspend =		ohci_au1xxx_suspend,
+	.resume =		ohci_au1xxx_resume,
+#endif
 	.stop =			ohci_stop,
 
 	/*
@@ -318,26 +361,77 @@ static int ohci_hcd_au1xxx_drv_remove(st
 	usb_ohci_au1xxx_remove(hcd, pdev);
 	return 0;
 }
-	/*TBD*/
-/*static int ohci_hcd_au1xxx_drv_suspend(struct platform_device *dev)
+
+#ifdef CONFIG_PM
+static int ohci_hcd_au1xxx_drv_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	int ret = 0;
 
-	return 0;
+	if (hcd->self.root_hub->dev.power.power_state.event == PM_EVENT_ON)
+		return -EBUSY;
+
+	if (hcd->driver->suspend) {
+		ret = hcd->driver->suspend(hcd, state);
+		suspend_report_result(hcd->driver->suspend, ret);
+		if (ret)
+			goto done;
+	}
+	synchronize_irq(dev->irq);
+
+	if (hcd->state == HC_STATE_SUSPENDED)
+		au1xxx_stop_ohc(pdev);
+	else {
+		dev_dbg (hcd->self.controller, "hcd state %d; not suspended\n",
+			hcd->state);
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+done:
+	if (ret == 0)
+		pdev->dev.power.power_state = PMSG_SUSPEND;
+
+	return ret;
 }
-static int ohci_hcd_au1xxx_drv_resume(struct platform_device *dev)
+
+static int ohci_hcd_au1xxx_drv_resume(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	int ret = 0;
 
-	return 0;
+	if (hcd->state != HC_STATE_SUSPENDED) {
+		dev_dbg (hcd->self.controller,
+				"can't resume, not suspended!\n");
+		return 0;
+	}
+
+	au1xxx_start_ohc(pdev);
+
+	pdev->dev.power.power_state = PMSG_ON;
+
+	clear_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
+
+	if (hcd->driver->resume) {
+		ret = hcd->driver->resume(hcd);
+			if (ret) {
+				dev_err (hcd->self.controller,
+					"hcd post-resume error %d!\n", ret);
+	                        usb_hc_died (hcd);
+                }
+	}
+
+	return ret;
 }
-*/
+#endif
 
 static struct platform_driver ohci_hcd_au1xxx_driver = {
 	.probe		= ohci_hcd_au1xxx_drv_probe,
 	.remove		= ohci_hcd_au1xxx_drv_remove,
-	/*.suspend	= ohci_hcd_au1xxx_drv_suspend, */
-	/*.resume	= ohci_hcd_au1xxx_drv_resume, */
+#ifdef CONFIG_PM
+	.suspend	= ohci_hcd_au1xxx_drv_suspend,
+	.resume		= ohci_hcd_au1xxx_drv_resume,
+#endif
 	.driver		= {
 		.name	= "au1xxx-ohci",
 		.owner	= THIS_MODULE,

--OwLcNYc0lM97+oe1--
