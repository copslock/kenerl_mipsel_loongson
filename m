Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:43:04 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:57554 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574328AbYHAJk3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:29 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 6C009C806D;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id Os5S+5nNdNz3; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 13949C8084;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id D104F108071; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 5/7] [MIPS] Remove dead code in excite_device.c
Date:	Fri,  1 Aug 2008 12:40:19 +0300
Message-Id: <1217583621-4772-6-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The code under the following conditional compilation construct

 #if defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE)
 #endif

does not have any chances to be compiled, since the relevant config
options do not exist. This patch removes the dead code.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/basler/excite/excite_device.c |   69 -------------------------------
 1 files changed, 0 insertions(+), 69 deletions(-)

diff --git a/arch/mips/basler/excite/excite_device.c b/arch/mips/basler/excite/excite_device.c
index e00bc2d..479a0f7 100644
--- a/arch/mips/basler/excite/excite_device.c
+++ b/arch/mips/basler/excite/excite_device.c
@@ -159,75 +159,6 @@ static void adjust_resources(struct resource *res, unsigned int n)
 	}
 }
 
-
-
-#if defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE)
-static struct resource xicap_rsrc[] = {
-	RINIT(0x4840, 0x486f, XICAP_RESOURCE_FIFO_RX, &excite_titan_resource),
-	RINIT(0x4940, 0x494b, XICAP_RESOURCE_FIFO_TX, &excite_titan_resource),
-	RINIT(0x5040, 0x5127, XICAP_RESOURCE_XDMA, &excite_titan_resource),
-	RINIT(0x1000, 0x112f, XICAP_RESOURCE_PKTPROC, &excite_titan_resource),
-	RINIT(0x1100, 0x110f, XICAP_RESOURCE_PKT_STREAM, &excite_fpga_resource),
-	RINIT(0x0800, 0x0bff, XICAP_RESOURCE_DMADESC, &excite_scram_resource),
-	RINIT(slice_xicap, slice_xicap, XICAP_RESOURCE_GPI_SLICE, &excite_gpislice_resource),
-	RINIT(0x0100, 0x02ff, XICAP_RESOURCE_FIFO_BLK, &excite_fifomem_resource),
-	RINIT_IRQ(TITAN_IRQ,  XICAP_RESOURCE_IRQ)
-};
-
-static struct platform_device xicap_pdev = {
-	.name		= XICAP_NAME,
-	.id		= XICAP_UNIT,
-	.num_resources	= ARRAY_SIZE(xicap_rsrc),
-	.resource	= xicap_rsrc
-};
-
-/*
- * Create a platform device for the GPI port that receives the
- * image data from the embedded camera.
- */
-static int __init xicap_devinit(void)
-{
-	unsigned long tend;
-	u32 reg;
-	int retval;
-
-	adjust_resources(xicap_rsrc, ARRAY_SIZE(xicap_rsrc));
-
-	/* Power up the slice and configure it. */
-	reg = titan_readl(CPTC1R);
-	reg &= ~(0x11100 << slice_xicap);
-	titan_writel(reg, CPTC1R);
-
-	/* Enable slice & DLL. */
-	reg= titan_readl(CPRR);
-	reg &= ~(0x00030003 << (slice_xicap * 2));
-	titan_writel(reg, CPRR);
-
-	/* Wait for DLLs to lock */
-	tend = jiffies + DLL_TIMEOUT * HZ;
-	while (time_before(jiffies, tend)) {
-		if (!(~titan_readl(CPDSR) & (0x1 << (slice_xicap * 4))))
-			break;
-		yield();
-	}
-
-	if (~titan_readl(CPDSR) & (0x1 << (slice_xicap * 4))) {
-		printk(KERN_ERR "%s: DLL not locked after %u seconds\n",
-		       xicap_pdev.name, DLL_TIMEOUT);
-		retval = -ETIME;
-	} else {
-		/* Register platform device */
-		retval = platform_device_register(&xicap_pdev);
-	}
-
-	return retval;
-}
-
-device_initcall(xicap_devinit);
-#endif /* defined(CONFIG_EXCITE_FCAP_GPI) || defined(CONFIG_EXCITE_FCAP_GPI_MODULE) */
-
-
-
 #if defined(CONFIG_WDT_RM9K_GPI) || defined(CONFIG_WDT_RM9K_GPI_MODULE)
 static struct resource wdt_rsrc[] = {
 	RINIT(0, 0, WDT_RESOURCE_COUNTER, &excite_ctr_resource),
-- 
1.5.6
