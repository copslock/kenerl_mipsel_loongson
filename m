Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 18:36:15 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:45281 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20036977AbXJORgH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 18:36:07 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1B2E8400DE;
	Mon, 15 Oct 2007 19:36:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id KcPnO8ankflL; Mon, 15 Oct 2007 19:36:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 61E1C40085;
	Mon, 15 Oct 2007 19:36:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9FHa67w009959;
	Mon, 15 Oct 2007 19:36:06 +0200
Date:	Mon, 15 Oct 2007 18:36:00 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net
cc:	Jay Estabrook <Jay.Estabrook@hp.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tgafb: Fix an out-of-range shift in mono imageblit
Message-ID: <Pine.LNX.4.64N.0710151812540.16262@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The pixel mask calculation in tgafb_mono_imageblit() uses a variable 
left-shift on a 32-bit data type by up to 32.  Shifting by the width of a 
data type or more produces an unpredictable result according to the C 
standard.

 Rather than widening the data type this fix makes sure the count is 
between 0 and 31.  The reason is not to penalise 32-bit platforms with 
operation on a "long long" type for a marginal case that is meant not to 
happen (blitting an image of a zero width).

 The reason it has escaped for so long is the Alpha, being purely 64-bit, 
:-) does not mask the shift out to 32 bits.  This is a valid 
implementation -- producing the correct result certainly falls within 
"unpredictable behaviour".  It does trigger on MIPS though and it is the 
recent merge of the TC support which only enabled the driver for use on 
anything other than the Alpha.  For MIPS when the width is 32 the mask 
ends up being 0 rather than 0xffffffff as it should be and the frame 
buffer is not updated.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Checked with checkpatch.pl and at the run time with an 8-bit TC frame 
buffer on a MIPS host.  It fixes scrolling corruption.

 Please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-tgafb-mono_imageblit-width-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/tgafb.c linux-mips-2.6.23-rc5-20070904/drivers/video/tgafb.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/tgafb.c	2007-09-04 04:55:46.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/video/tgafb.c	2007-10-14 20:32:13.000000000 +0000
@@ -5,7 +5,7 @@
  *	Copyright (C) 1997 Geert Uytterhoeven
  *	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
  *	Copyright (C) 2002 Richard Henderson
- *	Copyright (C) 2006 Maciej W. Rozycki
+ *	Copyright (C) 2006, 2007  Maciej W. Rozycki
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
@@ -13,6 +13,7 @@
  */
 
 #include <linux/bitrev.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -654,6 +655,9 @@ tgafb_mono_imageblit(struct fb_info *inf
 	line_length = info->fix.line_length;
 	rincr = (width + 7) / 8;
 
+	/* A shift below cannot cope with.  */
+	if (unlikely(width == 0))
+		return;
 	/* Crop the image to the screen.  */
 	if (dx > vxres || dy > vyres)
 		return;
@@ -709,9 +713,10 @@ tgafb_mono_imageblit(struct fb_info *inf
 		unsigned long bwidth;
 
 		/* Handle common case of imaging a single character, in
-		   a font less than 32 pixels wide.  */
+		   a font less than or 32 pixels wide.  */
 
-		pixelmask = (1 << width) - 1;
+		/* Avoid a shift by 32; width > 0 implied.  */
+		pixelmask = (2ul << (width - 1)) - 1;
 		pixelmask <<= shift;
 		__raw_writel(pixelmask, regs_base + TGA_PIXELMASK_REG);
 		wmb();
