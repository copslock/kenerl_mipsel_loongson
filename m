Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:11:06 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:30138 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVLD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:11:03 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuL2-0002di-SD
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:07:37 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvLQ-0000mC-V1
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:12:04 +0200
Date:	Wed, 9 Aug 2006 23:12:04 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809211204.GG13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 6/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Support for AU1100 (PIO mode) added.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-au1100

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index a77be4f..79cb2cf 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -305,7 +305,9 @@ static struct platform_device au1200_ide
 	.num_resources = ARRAY_SIZE(au1200_ide0_resources),
 	.resource	= au1200_ide0_resources,
 };
+#endif /* #ifdef CONFIG_SOC_AU1200 */
 
+#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1200) 
 static u64 au1xxx_mmc_dmamask =  ~(u32)0;
 
 static struct resource au1xxx_mmc0_resources[] = {
@@ -317,16 +319,23 @@ static struct resource au1xxx_mmc0_resou
 	},
 	[1] = {
 		.name		= "mmc-irq",
+#if defined(CONFIG_SOC_AU1100)
+		.start          = AU1100_SD_INT,
+		.end            = AU1100_SD_INT,
+#else /* AU1200 */
 		.start          = AU1200_SD_INT,
 		.end            = AU1200_SD_INT,
+#endif
 		.flags          = IORESOURCE_IRQ,
 	},
+#if defined(CONFIG_SOC_AU1200)
 	[2] = {
 		.name		= "mmc-dma",
 		.start          = DSCR_CMD0_SDMS_TX0,
 		.end            = DSCR_CMD0_SDMS_RX0,
 		.flags          = IORESOURCE_DMA,
 	},
+#endif
 };
 
 static struct platform_device au1xxx_mmc0_device = {
@@ -349,16 +358,23 @@ static struct resource au1xxx_mmc1_resou
 	},
 	[1] = {
 		.name		= "mmc-irq",
+#if defined(CONFIG_SOC_AU1100)
+		.start          = AU1100_SD_INT,
+		.end            = AU1100_SD_INT,
+#else /* AU1200 */
 		.start          = AU1200_SD_INT,
 		.end            = AU1200_SD_INT,
+#endif
 		.flags          = IORESOURCE_IRQ,
 	},
+#if defined(CONFIG_SOC_AU1200)
 	[2] = {
 		.name		= "mmc-dma",
 		.start          = DSCR_CMD0_SDMS_TX1,
 		.end            = DSCR_CMD0_SDMS_RX1,
 		.flags          = IORESOURCE_DMA,
 	},
+#endif
 };
 
 static struct platform_device au1xxx_mmc1_device = {
@@ -371,7 +387,7 @@ static struct platform_device au1xxx_mmc
 	.num_resources  = ARRAY_SIZE(au1xxx_mmc1_resources),
 	.resource       = au1xxx_mmc1_resources,
 };
-#endif /* #ifdef CONFIG_SOC_AU1200 */
+#endif /* defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1200) */
 
 static struct platform_device au1x00_pcmcia_device = {
 	.name 		= "au1x00-pcmcia",
@@ -450,6 +466,8 @@ #ifdef CONFIG_SOC_AU1200
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
 	&au1200_ide0_device,
+#endif
+#if defined(CONFIG_SOC_AU1100) || defined(CONFIG_SOC_AU1200)
 	&au1xxx_mmc0_device,
 	&au1xxx_mmc1_device,
 #endif
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 45bcf09..d7c455c 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -84,7 +84,7 @@ config MMC_WBSD
 
 config MMC_AU1X
 	tristate "Alchemy AU1XX0 MMC Card Interface support"
-	depends on MMC && SOC_AU1200
+	depends on MMC && (SOC_AU1100 || SOC_AU1200)
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
 	  If you have a Alchemy platform with a MMC slot, say Y or M here.
diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index f2d44cd..801024b 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -14,7 +14,10 @@
  *     All Rights Reserved.
  *     (drivers/mmc/pxa.c) Copyright (C) 2003 Russell King,
  *     All Rights Reserved.
- *
+
+ *  Support for AU1100 in PIO mode by:
+ *     Rodolfo Giometti <giometti@linux.it>
+ *     Eurotech S.p.A. <info@eurotech.it>
 
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -75,7 +78,11 @@ #ifndef CONFIG_MIPS_DB1200
 #endif
 };
 
+#if defined(CONFIG_SOC_AU1100)
+static int dma = 0;		/* no DMA support for AU1100 :'( */
+#else /* AU1200 */
 static int dma = 1;
+#endif
 
 #ifdef MODULE
 module_param(dma, bool, 0);
@@ -317,11 +324,15 @@ static void au1xmmc_data_complete(struct
 
 	if (data->error == MMC_ERR_NONE) {
 		if (host->flags & HOST_F_DMA) {
+#if defined(CONFIG_SOC_AU1100)
+			err("no DMA support for AU1100 CPUs!\n", host->id);
+#else /* AU1200 */
 			u32 chan = DMA_CHANNEL(host);
 
 			chan_tab_t *c = *((chan_tab_t **) chan);
 			au1x_dma_chan_t *cp = c->chan_ptr;
 			data->bytes_xfered = cp->ddma_bytecnt;
+#endif
 		}
 		else
 			data->bytes_xfered =
@@ -546,6 +557,9 @@ static void au1xmmc_cmd_complete(struct 
 	host->status = HOST_S_DATA;
 
 	if (host->flags & HOST_F_DMA) {
+#if defined(CONFIG_SOC_AU1100)
+		err("no DMA support for AU1100 CPUs!\n", host->id);
+#else /* AU1200 */
 		u32 channel = DMA_CHANNEL(host);
 
 		/* Start the DMA as soon as the buffer gets something in it */
@@ -558,6 +572,7 @@ static void au1xmmc_cmd_complete(struct 
 		}
 
 		au1xxx_dbdma_start(channel);
+#endif
 	}
 }
 
@@ -614,6 +629,9 @@ au1xmmc_prepare_data(struct au1xmmc_host
 	au_writel(data->blksz - 1, HOST_BLKSIZE(host));
 
 	if (host->flags & HOST_F_DMA) {
+#if defined(CONFIG_SOC_AU1100)
+		err("no DMA support for AU1100 CPUs!\n", host->id);
+#else /* AU1200 */
 		int i;
 		u32 channel = DMA_CHANNEL(host);
 
@@ -647,6 +665,7 @@ au1xmmc_prepare_data(struct au1xmmc_host
 
 			datalen -= len;
 		}
+#endif
 	}
 	else {
 		host->pio.index = 0;
@@ -662,9 +681,11 @@ au1xmmc_prepare_data(struct au1xmmc_host
 
 	return MMC_ERR_NONE;
 
+#if !defined(CONFIG_SOC_AU1100)
  dataerr:
 	dma_unmap_sg(mmc_dev(host->mmc),data->sg,data->sg_len,host->dma.dir);
 	return MMC_ERR_TIMEOUT;
+#endif
 }
 
 /* static void au1xmmc_request
@@ -749,6 +770,7 @@ static void au1xmmc_set_ios(struct mmc_h
 	}
 }
 
+#if !defined(CONFIG_SOC_AU1100)
 static void au1xmmc_dma_callback(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct au1xmmc_host *host = (struct au1xmmc_host *) dev_id;
@@ -763,6 +785,7 @@ static void au1xmmc_dma_callback(int irq
 
 	tasklet_schedule(&host->data_task);
 }
+#endif
 
 #define STATUS_TIMEOUT (SD_STATUS_RAT | SD_STATUS_DT)
 #define STATUS_DATA_IN  (SD_STATUS_NE)
@@ -845,6 +868,7 @@ static void au1xmmc_poll_event(unsigned 
 	mod_timer(&host->timer, jiffies + AU1XMMC_DETECT_TIMEOUT);
 }
 
+#if !defined(CONFIG_SOC_AU1100)
 static dbdev_tab_t au1xmmc_mem_dbdev =
 {
 	DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 8, 0x00000000, 0, 0
@@ -880,6 +904,7 @@ static void au1xmmc_init_dma(struct au1x
 	host->tx_chan = txchan;
 	host->rx_chan = rxchan;
 }
+#endif
 
 struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
@@ -911,11 +936,13 @@ static int __devinit au1xmmc_probe(struc
 		return -ENODEV;
 	irq = res->start;
 
+#if !defined(CONFIG_SOC_AU1100)
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "mmc-dma");
 	if (!res)
 		return -ENODEV;
 	tx_devid = res->start;
 	rx_devid = res->end;
+#endif
 
 	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
 	if (!mmc) {
@@ -961,8 +988,15 @@ static int __devinit au1xmmc_probe(struc
 
 	spin_lock_init(&host->lock);
 
-	if (dma != 0)
+	if (dma != 0) {
+#if defined(CONFIG_SOC_AU1100)
+		err("no DMA support for AU1100 CPUs!\n", host->id);
+		ret = -EINVAL;
+		goto no_dma;
+#else /* AU1200 */
 		au1xmmc_init_dma(host);
+#endif
+	}
 
 	au1xmmc_reset_controller(host);
 
@@ -985,20 +1019,25 @@ static int __devinit au1xmmc_probe(struc
 	return 0;
 
 exit :
-	iounmap(base_addr);
+	del_timer_sync(&host->timer);
+	mmc_remove_host(mmc);
+
+no_dma :
+	au1xmmc_set_power(host, 0);
 
 	tasklet_kill(&host->data_task);
 	tasklet_kill(&host->finish_task);
 
-	del_timer_sync(&host->timer);
-	au1xmmc_set_power(host, 0);
-
-	mmc_remove_host(mmc);
+	au_writel(0x0, HOST_ENABLE(host));
 
+#if !defined(CONFIG_SOC_AU1100)
 	au1xxx_dbdma_chan_free(host->tx_chan);
 	au1xxx_dbdma_chan_free(host->rx_chan);
+#endif
+
+	mmc_free_host(mmc);
+	iounmap(base_addr);
 
-	au_writel(0x0, HOST_ENABLE(host));
 	au_sync();
 
 	return ret;
@@ -1013,22 +1052,27 @@ static int __devexit au1xmmc_remove(stru
 	if (!host)
 		return 0;
 
+	del_timer_sync(&host->timer);
+
 	tasklet_kill(&host->data_task);
 	tasklet_kill(&host->finish_task);
 
-	del_timer_sync(&host->timer);
 	au1xmmc_set_power(host, 0);
 
+	au_writel(0x0, HOST_ENABLE(host));
 	mmc_remove_host(mmc);
 
+#if !defined(CONFIG_SOC_AU1100)
 	au1xxx_dbdma_chan_free(host->tx_chan);
 	au1xxx_dbdma_chan_free(host->rx_chan);
+#endif
 
 	au_writel(0x0, HOST_ENABLE(host));
 	au_sync();
 
 	free_irq(host->irq, host);
 
+	mmc_free_host(mmc);
 	iounmap(base_addr);
 
 	return 0;

--qftxBdZWiueWNAVY--
