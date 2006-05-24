Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 19:36:42 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:9904 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133767AbWEXRgf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 19:36:35 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FixDs-0006EC-BT
	for linux-mips@linux-mips.org; Wed, 24 May 2006 19:32:40 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FixHa-0002sl-JC
	for linux-mips@linux-mips.org; Wed, 24 May 2006 19:36:30 +0200
Date:	Wed, 24 May 2006 19:36:30 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060524173630.GB27426@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Power management support for au1100fb.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached a patch for power management on au1100fb.c. The patch is
against 2.6.17-rc4 and has been tested with an au1100 based board.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-pm

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 1f401a9..0be2d55 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -7,6 +7,8 @@
  *  	Karl Lessard <klessard@sunrisetelecom.com>
  *  	<c.pellegrin@exadron.com>
  *
+ * PM support added by Rodolfo Giometti <giometti@linux.it>
+ *
  * Copyright 2002 MontaVista Software
  * Author: MontaVista Software, Inc.
  *		ppopov@mvista.com or source@mvista.com
@@ -657,17 +659,49 @@ int au1100fb_drv_remove(struct device *d
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static u32 sys_clksrc;
+static struct au1100fb_regs fbregs;
+
 int au1100fb_drv_suspend(struct device *dev, pm_message_t state)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
+
+	if (!fbdev)
+		return 0;
+
+	/* Save the clock source state */
+	sys_clksrc = au_readl(SYS_CLKSRC);
+
+	/* Blank the LCD */
+	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
+
+	/* Stop LCD clocking */
+	au_writel(sys_clksrc & ~SYS_CS_ML_MASK, SYS_CLKSRC);
+
+	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
+
 	return 0;
 }
 
 int au1100fb_drv_resume(struct device *dev)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
+
+	if (!fbdev)
+		return 0;
+
+	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
+
+	/* Restart LCD clocking */
+	au_writel(sys_clksrc, SYS_CLKSRC);
+
+	/* Unblank the LCD */
+	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
+
 	return 0;
 }
+#endif
 
 static struct device_driver au1100fb_driver = {
 	.name		= "au1100-lcd",
@@ -675,8 +709,10 @@ static struct device_driver au1100fb_dri
 
 	.probe		= au1100fb_drv_probe,
         .remove		= au1100fb_drv_remove,
+#ifdef CONFIG_PM
 	.suspend	= au1100fb_drv_suspend,
         .resume		= au1100fb_drv_resume,
+#endif
 };
 
 /*-------------------------------------------------------------------------*/

--ZfOjI3PrQbgiZnxM--
