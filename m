Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2007 17:47:26 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:39398 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022514AbXIQQrQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Sep 2007 17:47:16 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0E9CC400D0;
	Mon, 17 Sep 2007 18:47:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id t+gB0CUdC536; Mon, 17 Sep 2007 18:47:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CDFE740070;
	Mon, 17 Sep 2007 18:47:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8HGlF37027714;
	Mon, 17 Sep 2007 18:47:15 +0200
Date:	Mon, 17 Sep 2007 17:47:09 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>
cc:	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/video/pmagb-b-fb.c: Improve diagnostics
Message-ID: <Pine.LNX.4.64N.0709171746030.17606@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4310/Mon Sep 17 14:47:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Add error messages to the probe call.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 While they may rarely trigger, they may be useful when something weird is 
going on.  Also this is good style.

 Checked with checkpatch.pl and at the runtime.

 Please apply; don't be worried about the old version number.

  Maciej

patch-mips-2.6.18-20060920-pmagb-b-err-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/pmagb-b-fb.c linux-mips-2.6.18-20060920/drivers/video/pmagb-b-fb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/pmagb-b-fb.c	2006-12-16 16:44:41.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/pmagb-b-fb.c	2006-12-16 16:44:52.000000000 +0000
@@ -254,16 +254,23 @@ static int __init pmagbbfb_probe(struct 
 	struct pmagbbfb_par *par;
 	char freq0[12], freq1[12];
 	u32 vid_base;
+	int err = 0;
 
 	info = framebuffer_alloc(sizeof(struct pmagbbfb_par), dev);
-	if (!info)
+	if (!info) {
+		printk(KERN_ERR "%s: Cannot allocate memory\n", dev->bus_id);
 		return -ENOMEM;
+	}
 
 	par = info->par;
 	dev_set_drvdata(dev, info);
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		printk(KERN_ERR "%s: Cannot allocate color map\n",
+		       dev->bus_id);
+		err = -ENOMEM;
 		goto err_alloc;
+	}
 
 	info->fbops = &pmagbbfb_ops;
 	info->fix = pmagbbfb_fix;
@@ -273,22 +280,31 @@ static int __init pmagbbfb_probe(struct 
 	/* Request the I/O MEM resource.  */
 	start = tdev->resource.start;
 	len = tdev->resource.end - start + 1;
-	if (!request_mem_region(start, len, dev->bus_id))
+	if (!request_mem_region(start, len, dev->bus_id)) {
+		printk(KERN_ERR "%s: Cannot reserve FB region\n", dev->bus_id);
+		err = -EBUSY;
 		goto err_cmap;
+	}
 
 	/* MMIO mapping setup.  */
 	info->fix.mmio_start = start;
 	par->mmio = ioremap_nocache(info->fix.mmio_start, info->fix.mmio_len);
-	if (!par->mmio)
+	if (!par->mmio) {
+		printk(KERN_ERR "%s: Cannot map MMIO\n", dev->bus_id);
+		err = -ENOMEM;
 		goto err_resource;
+	}
 	par->sfb = par->mmio + PMAGB_B_SFB;
 	par->dac = par->mmio + PMAGB_B_BT459;
 
 	/* Frame buffer mapping setup.  */
 	info->fix.smem_start = start + PMAGB_B_FBMEM;
 	par->smem = ioremap_nocache(info->fix.smem_start, info->fix.smem_len);
-	if (!par->smem)
+	if (!par->smem) {
+		printk(KERN_ERR "%s: Cannot map FB\n", dev->bus_id);
+		err = -ENOMEM;
 		goto err_mmio_map;
+	}
 	vid_base = sfb_read(par, SFB_REG_VID_BASE);
 	info->screen_base = (void __iomem *)par->smem + vid_base * 0x1000;
 	info->screen_size = info->fix.smem_len - 2 * vid_base * 0x1000;
@@ -297,8 +313,12 @@ static int __init pmagbbfb_probe(struct 
 	pmagbbfb_screen_setup(info);
 	pmagbbfb_osc_setup(info);
 
-	if (register_framebuffer(info) < 0)
+	err = register_framebuffer(info);
+	if (err < 0) {
+		printk(KERN_ERR "%s: Cannot register framebuffer\n",
+		       dev->bus_id);
 		goto err_smem_map;
+	}
 
 	get_device(dev);
 
