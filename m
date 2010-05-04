Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:59:12 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:46335 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492421Ab0EDJzk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:40 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119707qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.232.137 with SMTP id ju9mr2773326qcb.54.1272966939729; 
        Tue, 04 May 2010 02:55:39 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:39 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:39 +0800
Message-ID: <r2l180e2c241005040255mff483747jcef507aadea0cabd@mail.gmail.com>
Subject: [PATCH 10/12] add the sm501fb option to sm501 fb driver
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com, vince@simtec.co.uk,
        ben@simtec.co.uk
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Currently the sm501 mode can only be fetched from modedb.c.
Unfortunately the modes in modedb.c are not complete. For example it
lacks the resolution of 1024x600. So the sm501 fb driver should have
the ability to accept the mode option from linux command line.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 drivers/video/sm501fb.c |   67 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index b7dc180..f2c69ca 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -43,6 +43,37 @@

 #define NR_PALETTE	256

+static char *mode_option;
+module_param_named(mode, mode_option, charp, 0);
+MODULE_PARM_DESC(mode, "Initial mode");
+
+/*
+ * SM501 Mode
+ *    1024X600 is not defined in default mode(modedb.c).
+ */
+static const struct fb_videomode sm501_modedb[] __initdata = {
+ {
+	/* 1024x600-60 */
+	NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
+  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+ },
+ {
+	 /* 1024x600-70 */
+	 NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
+  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+ },
+ {
+	 /* 1024x600-75 */
+	 NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
+  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+ },
+ {
+	 /* 1024x600-85 */
+	 NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
+  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+ }
+};
+
 enum sm501_controller {
 	HEAD_CRT	= 0,
 	HEAD_PANEL	= 1,
@@ -1729,8 +1760,16 @@ static int sm501fb_init_fb(struct fb_info *fb,
 			fb->var.xres_virtual = fb->var.xres;
 			fb->var.yres_virtual = fb->var.yres;
 		} else {
-			ret = fb_find_mode(&fb->var, fb,
-					   NULL, NULL, 0, NULL, 8);
+			if (mode_option) {
+				dev_info(info->dev, "using user defined mode:"
+						" %s\n", mode_option);
+				ret = fb_find_mode(&fb->var, fb,
+						mode_option, sm501_modedb,
+						ARRAY_SIZE(sm501_modedb),
+						NULL, fb->var.bits_per_pixel);
+			} else
+				ret = fb_find_mode(&fb->var, fb,
+						NULL, NULL, 0, NULL, 8);

 			if (ret == 0 || ret == 4) {
 				dev_err(info->dev,
@@ -2136,8 +2175,32 @@ static struct platform_driver sm501fb_driver = {
 	},
 };

+#ifndef MODULE
+static int  __devinit sm501fb_setup(char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+		mode_option = this_opt;
+	}
+	return 0;
+}
+#endif
+
 static int __devinit sm501fb_init(void)
 {
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("sm501fb", &option))
+		return -ENODEV;
+	sm501fb_setup(option);
+#endif
 	return platform_driver_register(&sm501fb_driver);
 }

-- 
1.5.6.5
