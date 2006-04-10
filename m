Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2006 21:14:03 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:36053 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133481AbWDJUNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Apr 2006 21:13:54 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FT2uW-0005Vs-If; Mon, 10 Apr 2006 22:22:58 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FT2xS-0005c8-Qg; Mon, 10 Apr 2006 22:25:58 +0200
Date:	Mon, 10 Apr 2006 22:25:58 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Cc:	source@embeddedalley.com
Message-ID: <20060410202558.GS23424@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f4arffV+Mc+T1KhS"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] au1100fb suspend/resume support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--f4arffV+Mc+T1KhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch for au1100fb.c in order to add suspend/resume support.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--f4arffV+Mc+T1KhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-pm

Index: drivers/video/au1100fb.c
===================================================================
RCS file: /home/develop/cvs_private/linux-mips-exadron/drivers/video/au1100fb.c,v
retrieving revision 1.7
diff -u -r1.7 au1100fb.c
--- a/drivers/video/au1100fb.c	2 Jan 2006 16:53:11 -0000	1.7
+++ b/drivers/video/au1100fb.c	10 Apr 2006 20:18:40 -0000
@@ -7,6 +7,8 @@
  *  	Karl Lessard <klessard@sunrisetelecom.com>
  *  	<c.pellegrin@exadron.com>
  *
+ * PM support added by Rodolfo Giometti <giometti@linux.it>
+ *
  * Copyright 2002 MontaVista Software
  * Author: MontaVista Software, Inc.
  *		ppopov@mvista.com or source@mvista.com
@@ -648,17 +650,66 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static u32 sys_clksrc;
+static struct au1100fb_regs fbregs;
 int au1100fb_drv_suspend(struct device *dev, u32 state, u32 level)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
+
+	if (!fbdev)
+		return 0;
+
+	switch (level) {
+	case SUSPEND_DISABLE :
+		/* Save the clock source state */
+		sys_clksrc = au_readl(SYS_CLKSRC);
+
+		/* Blank the LCD */
+		au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
+
+		/* Stop LCD clocking */
+		au_writel(sys_clksrc & ~SYS_CS_MUD_MASK, SYS_CLKSRC);
+
+		break;
+
+	case SUSPEND_SAVE_STATE :
+		memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
+
+		break;
+
+	case SUSPEND_POWER_DOWN :
+
+		break;
+	}
+
 	return 0;
 }
 
 int au1100fb_drv_resume(struct device *dev, u32 level)
 {
-	/* TODO */
+	struct au1100fb_device *fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
+
+	if (!fbdev)
+		return 0;
+
+	switch (level) {
+	case RESUME_RESTORE_STATE :
+		memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
+
+		break;
+
+	case RESUME_ENABLE :
+		au_writel(sys_clksrc, SYS_CLKSRC);
+
+		au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
+
+		break;
+	}
+
 	return 0;
 }
+#endif
 
 static struct device_driver au1100fb_driver = {
 	.name		= "au1100-lcd",
@@ -666,8 +717,10 @@
 
 	.probe		= au1100fb_drv_probe,
         .remove		= au1100fb_drv_remove,
+#ifdef CONFIG_PM
 	.suspend	= au1100fb_drv_suspend,
         .resume		= au1100fb_drv_resume,
+#endif
 };
     
 /*-------------------------------------------------------------------------*/

--f4arffV+Mc+T1KhS--
