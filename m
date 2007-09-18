Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 13:14:36 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:11161 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022325AbXIRMO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 13:14:28 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 75BA740070;
	Tue, 18 Sep 2007 14:14:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 6v6EKycqtKMg; Tue, 18 Sep 2007 14:14:21 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3B1FF40097;
	Tue, 18 Sep 2007 14:14:21 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8ICDq5f006580;
	Tue, 18 Sep 2007 14:13:53 +0200
Date:	Tue, 18 Sep 2007 13:13:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>
cc:	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/pmagb-b-fb.c: Improve diagnostics
In-Reply-To: <200709172030.08568.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.64N.0709181306080.9650@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171746030.17606@blysk.ds.pg.gda.pl>
 <200709172030.08568.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4319/Tue Sep 18 11:27:41 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16544
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

On Mon, 17 Sep 2007, Mariusz Kozlowski wrote:

> You added them but probably forgot to return them ;)

 Well, I am just checking whether anybody watches. ;-)

 Good spotting and thanks a lot, of course.  Here is a new version. 
Checked with checkpatch.pl.

 Please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-pmagb-b-err-2
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmagb-b-fb.c linux-mips-2.6.23-rc5-20070904/drivers/video/pmagb-b-fb.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmagb-b-fb.c	2007-02-21 05:56:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/video/pmagb-b-fb.c	2007-09-18 10:57:27.000000000 +0000
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
 
@@ -330,7 +350,7 @@ err_cmap:
 
 err_alloc:
 	framebuffer_release(info);
-	return -ENXIO;
+	return err;
 }
 
 static int __exit pmagbbfb_remove(struct device *dev)
