Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jul 2006 14:10:28 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:56209 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S3561327AbWGLNKS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Jul 2006 14:10:18 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1G0YTH-0005gZ-00; Wed, 12 Jul 2006 08:45:19 +0200
Date:	Wed, 12 Jul 2006 08:45:19 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Cc:	linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] au1100fb.c cursor enable/disable
Message-ID: <20060712064519.GA17240@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch to add cursor enable/disable, very useful if you wish a
full screen boot logo.

Cursor can be disabled from kernel command line:

   video=au1100fb:nocursor,panel:Toppoly_TD035STED4

or from sysfs interface:

   echo 1 > /sys/module/au1100fb/parameters/nocursor

The patch also fixes up some wrong indentation issues.

Ciao,

Rodolfo


Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-nocursor

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index e0b71fe..1b9ad17 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -8,6 +8,7 @@
  *  	<c.pellegrin@exadron.com>
  *
  * PM support added by Rodolfo Giometti <giometti@linux.it>
+ * Cursor enable/disable by Rodolfo Giometti <giometti@linux.it>
  *
  * Copyright 2002 MontaVista Software
  * Author: MontaVista Software, Inc.
@@ -114,6 +115,10 @@ static struct fb_var_screeninfo au1100fb
 
 static struct au1100fb_drv_info drv_info;
 
+static int nocursor = 0;
+module_param(nocursor, int, 0644);
+MODULE_PARM_DESC(nocursor, "cursor enable/disable");
+
 int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi);
 
 /*
@@ -440,6 +445,17 @@ int au1100fb_fb_mmap(struct fb_info *fbi
 	return 0;
 }
 
+/* fb_cursor
+ * Used to disable cursor drawing...
+ */
+int au1100fb_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	if (nocursor)
+		return 0;
+	else
+		return -EINVAL;	/* just to force soft_cursor() call */
+}
+
 static struct fb_ops au1100fb_ops =
 {
 	.owner			= THIS_MODULE,
@@ -451,6 +467,7 @@ static struct fb_ops au1100fb_ops =
 	.fb_imageblit		= cfb_imageblit,
 	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
+	.fb_cursor		= au1100fb_fb_cursor,
 };
 
 
@@ -705,7 +722,7 @@ int au1100fb_setup(char *options)
 	if (options) {
 		while ((this_opt = strsep(&options,",")) != NULL) {
 			/* Panel option */
-		if (!strncmp(this_opt, "panel:", 6)) {
+			if (!strncmp(this_opt, "panel:", 6)) {
 				int i;
 				this_opt += 6;
 				for (i = 0; i < num_panels; i++) {
@@ -713,13 +730,18 @@ int au1100fb_setup(char *options)
 					      	     known_lcd_panels[i].name,
 							strlen(this_opt))) {
 						panel_idx = i;
-					break;
+						break;
+					}
 				}
-			}
 				if (i >= num_panels) {
  					print_warn("Panel %s not supported!", this_opt);
 				}
 			}
+			if (!strncmp(this_opt, "nocursor", 8)) {
+				this_opt += 8;
+				nocursor = 1;
+				print_info("Cursor disabled");
+			}
 			/* Mode option (only option that start with digit) */
 			else if (isdigit(this_opt[0])) {
 				mode = kmalloc(strlen(this_opt) + 1, GFP_KERNEL);
@@ -728,7 +750,7 @@ int au1100fb_setup(char *options)
 			/* Unsupported option */
 			else {
 				print_warn("Unsupported option \"%s\"", this_opt);
-		}
+			}
 		}
 	}
 

--FL5UXtIhxfXey3p5--
