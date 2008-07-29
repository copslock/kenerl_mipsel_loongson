Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 23:12:18 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:13194 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026079AbYG2WMK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 23:12:10 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KNxQO-00065r-00; Wed, 30 Jul 2008 00:12:08 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 25D97C2F34; Wed, 30 Jul 2008 00:12:04 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [REPOST PATCH] gbefb: cmap FIFO timeout
To:	linux-fbdev-devel@lists.sourceforge.net
Cc:	linux-mips@linux-mips.org, adaplas@gmail.com,
	akpm@linux-foundation.org
Message-Id: <20080729221204.25D97C2F34@solo.franken.de>
Date:	Wed, 30 Jul 2008 00:12:04 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Writes to the cmap fifo while the display is blanked caused cmap FIFO
timeout messages and a wrong colormap. To avoid this the driver now
maintains a colormap in memory and updates the colormap after the
display is unblanked.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

It would be really nice to get this bugfix into 2.6.27. It was posted
the first time 26. June 2008 and I didn't get any response at all.

 drivers/video/gbefb.c |   50 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index 2e552d5..f89c3cc 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -87,6 +87,8 @@ static int gbe_revision;
 static int ypan, ywrap;
 
 static uint32_t pseudo_palette[16];
+static uint32_t gbe_cmap[256];
+static int gbe_turned_on; /* 0 turned off, 1 turned on */
 
 static char *mode_option __initdata = NULL;
 
@@ -208,6 +210,8 @@ void gbe_turn_off(void)
 	int i;
 	unsigned int val, x, y, vpixen_off;
 
+	gbe_turned_on = 0;
+
 	/* check if pixel counter is on */
 	val = gbe->vt_xy;
 	if (GET_GBE_FIELD(VT_XY, FREEZE, val) == 1)
@@ -371,6 +375,22 @@ static void gbe_turn_on(void)
 	}
 	if (i == 10000)
 		printk(KERN_ERR "gbefb: turn on DMA timed out\n");
+
+	gbe_turned_on = 1;
+}
+
+static void gbe_loadcmap(void)
+{
+	int i, j;
+
+	for (i = 0; i < 256; i++) {
+		for (j = 0; j < 1000 && gbe->cm_fifo >= 63; j++)
+			udelay(10);
+		if (j == 1000)
+			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
+
+		gbe->cmap[i] = gbe_cmap[i];
+	}
 }
 
 /*
@@ -382,6 +402,7 @@ static int gbefb_blank(int blank, struct fb_info *info)
 	switch (blank) {
 	case FB_BLANK_UNBLANK:		/* unblank */
 		gbe_turn_on();
+		gbe_loadcmap();
 		break;
 
 	case FB_BLANK_NORMAL:		/* blank */
@@ -796,16 +817,10 @@ static int gbefb_set_par(struct fb_info *info)
 		gbe->gmap[i] = (i << 24) | (i << 16) | (i << 8);
 
 	/* Initialize the color map */
-	for (i = 0; i < 256; i++) {
-		int j;
-
-		for (j = 0; j < 1000 && gbe->cm_fifo >= 63; j++)
-			udelay(10);
-		if (j == 1000)
-			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
+	for (i = 0; i < 256; i++)
+		gbe_cmap[i] = (i << 8) | (i << 16) | (i << 24);
 
-		gbe->cmap[i] = (i << 8) | (i << 16) | (i << 24);
-	}
+	gbe_loadcmap();
 
 	return 0;
 }
@@ -855,14 +870,17 @@ static int gbefb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	blue >>= 8;
 
 	if (info->var.bits_per_pixel <= 8) {
-		/* wait for the color map FIFO to have a free entry */
-		for (i = 0; i < 1000 && gbe->cm_fifo >= 63; i++)
-			udelay(10);
-		if (i == 1000) {
-			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
-			return 1;
+		gbe_cmap[regno] = (red << 24) | (green << 16) | (blue << 8);
+		if (gbe_turned_on) {
+			/* wait for the color map FIFO to have a free entry */
+			for (i = 0; i < 1000 && gbe->cm_fifo >= 63; i++)
+				udelay(10);
+			if (i == 1000) {
+				printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
+				return 1;
+			}
+			gbe->cmap[regno] = gbe_cmap[regno];
 		}
-		gbe->cmap[regno] = (red << 24) | (green << 16) | (blue << 8);
 	} else if (regno < 16) {
 		switch (info->var.bits_per_pixel) {
 		case 15:
