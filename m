Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 18:42:22 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:16282 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037137AbXJORmO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 18:42:14 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 228AE400C9;
	Mon, 15 Oct 2007 19:42:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 79o2PeWoUpcJ; Mon, 15 Oct 2007 19:42:08 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 8371740085;
	Mon, 15 Oct 2007 19:42:08 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9FHgDAA011541;
	Mon, 15 Oct 2007 19:42:13 +0200
Date:	Mon, 15 Oct 2007 18:42:07 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net
cc:	Jay Estabrook <Jay.Estabrook@hp.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tgafb: Remove a redundant non-mono test in mono imageblit
Message-ID: <Pine.LNX.4.64N.0710151836490.16262@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 There is a test in tgafb_mono_imageblit() for a colour image with a 
fall-back to cfb_imageblit().  The test is not necessary as the only 
caller, which is tgafb_imageblit(), checks it too and only invokes this 
function for monochrome images.  It looks like a left-over from before 
some changes to tgafb_imageblit().

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Checked with checkpatch.pl and at the run time with an 8-bit TC frame
buffer on a MIPS host.

 Please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-tgafb-mono_imageblit-depth-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/tgafb.c linux-mips-2.6.23-rc5-20070904/drivers/video/tgafb.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/tgafb.c	2007-09-04 04:55:46.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/video/tgafb.c	2007-10-14 20:32:13.000000000 +0000
@@ -636,15 +636,6 @@ tgafb_mono_imageblit(struct fb_info *inf
 
 	is8bpp = info->var.bits_per_pixel == 8;
 
-	/* For copies that aren't pixel expansion, there's little we
-	   can do better than the generic code.  */
-	/* ??? There is a DMA write mode; I wonder if that could be
-	   made to pull the data from the image buffer...  */
-	if (image->depth > 1) {
-		cfb_imageblit(info, image);
-		return;
-	}
-
 	dx = image->dx;
 	dy = image->dy;
 	width = image->width;
