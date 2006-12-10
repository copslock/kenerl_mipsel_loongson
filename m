Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Dec 2006 19:41:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15267 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039327AbWLJTlt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 10 Dec 2006 19:41:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kBAJfkrW000535;
	Sun, 10 Dec 2006 19:41:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kBAJfiHj000534;
	Sun, 10 Dec 2006 19:41:44 GMT
Date:	Sun, 10 Dec 2006 19:41:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, mchehab@infradead.org,
	luca.risolia@studio.unibo.it
Subject: [PATCH] Fix namespace conflict between w9968cf.c on MIPS
Message-ID: <20061210194144.GA423@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Both use __SC.  Since __* is sort of private namespace I've choosen to
fix this in the driver.  For consistency I decieded to also change
__UNSC to UNSC.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/media/video/w9968cf.c b/drivers/media/video/w9968cf.c
index ddce2fb..9f403af 100644
--- a/drivers/media/video/w9968cf.c
+++ b/drivers/media/video/w9968cf.c
@@ -1827,8 +1827,8 @@ w9968cf_set_window(struct w9968cf_device
 	int err = 0;
 
 	/* Work around to avoid FP arithmetics */
-	#define __SC(x) ((x) << 10)
-	#define __UNSC(x) ((x) >> 10)
+	#define SC(x) ((x) << 10)
+	#define UNSC(x) ((x) >> 10)
 
 	/* Make sure we are using a supported resolution */
 	if ((err = w9968cf_adjust_window_size(cam, (u16*)&win.width,
@@ -1836,15 +1836,15 @@ w9968cf_set_window(struct w9968cf_device
 		goto error;
 
 	/* Scaling factors */
-	fw = __SC(win.width) / cam->maxwidth;
-	fh = __SC(win.height) / cam->maxheight;
+	fw = SC(win.width) / cam->maxwidth;
+	fh = SC(win.height) / cam->maxheight;
 
 	/* Set up the width and height values used by the chip */
 	if ((win.width > cam->maxwidth) || (win.height > cam->maxheight)) {
 		cam->vpp_flag |= VPP_UPSCALE;
 		/* Calculate largest w,h mantaining the same w/h ratio */
-		w = (fw >= fh) ? cam->maxwidth : __SC(win.width)/fh;
-		h = (fw >= fh) ? __SC(win.height)/fw : cam->maxheight;
+		w = (fw >= fh) ? cam->maxwidth : SC(win.width)/fh;
+		h = (fw >= fh) ? SC(win.height)/fw : cam->maxheight;
 		if (w < cam->minwidth) /* just in case */
 			w = cam->minwidth;
 		if (h < cam->minheight) /* just in case */
@@ -1861,8 +1861,8 @@ w9968cf_set_window(struct w9968cf_device
 
 	/* Calculate cropped area manteining the right w/h ratio */
 	if (cam->largeview && !(cam->vpp_flag & VPP_UPSCALE)) {
-		cw = (fw >= fh) ? cam->maxwidth : __SC(win.width)/fh;
-		ch = (fw >= fh) ? __SC(win.height)/fw : cam->maxheight;
+		cw = (fw >= fh) ? cam->maxwidth : SC(win.width)/fh;
+		ch = (fw >= fh) ? SC(win.height)/fw : cam->maxheight;
 	} else {
 		cw = w;
 		ch = h;
@@ -1901,8 +1901,8 @@ w9968cf_set_window(struct w9968cf_device
 	/* We have to scale win.x and win.y offsets */
 	if ( (cam->largeview && !(cam->vpp_flag & VPP_UPSCALE))
 	     || (cam->vpp_flag & VPP_UPSCALE) ) {
-		ax = __SC(win.x)/fw;
-		ay = __SC(win.y)/fh;
+		ax = SC(win.x)/fw;
+		ay = SC(win.y)/fh;
 	} else {
 		ax = win.x;
 		ay = win.y;
@@ -1917,8 +1917,8 @@ w9968cf_set_window(struct w9968cf_device
 	/* Adjust win.x, win.y */
 	if ( (cam->largeview && !(cam->vpp_flag & VPP_UPSCALE))
 	     || (cam->vpp_flag & VPP_UPSCALE) ) {
-		win.x = __UNSC(ax*fw);
-		win.y = __UNSC(ay*fh);
+		win.x = UNSC(ax*fw);
+		win.y = UNSC(ay*fh);
 	} else {
 		win.x = ax;
 		win.y = ay;
