Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 18:50:21 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:38566 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133864AbVLBSuB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 18:50:01 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB2IrSYC030656;
	Fri, 2 Dec 2005 12:53:28 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 02 Dec 2005 12:53:22 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB2IrLTw003922; Fri,
 2 Dec 2005 12:53:21 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 6FAD92026; Fri, 2 Dec 2005
 11:53:21 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB2J18LJ031378; Fri, 2 Dec 2005 12:01:08
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB2J188A031377; Fri, 2 Dec 2005 12:01:08 -0700
Date:	Fri, 2 Dec 2005 12:01:08 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org, drzeus-wbsd@drzeus.cx
Subject: [PATCH] ALCHEMY:  Add SD support to AU1200 MMC/SD driver
Message-ID: <20051202190108.GF28227@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8E47A840G499976-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

Add SD support to the AU1200 MMC driver.  This can
be added post 2.6.15, I'm just sending them out today so the various
maintainers can get them queued up. 

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/mmc/au1xmmc.c |  124 ++++++++++++++++++++++++++++---------------------
 1 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index cb32a08..c8c8f29 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -99,16 +99,24 @@ static inline void IRQ_ON(struct au1xmmc
 	au_sync();
 }
 
-static inline void FLUSH_FIFO(struct au1xmmc_host *host) 
+/* Turn on the FIFO flush - the fifo will be returned to active right
+ * before data transfer
+ */
+
+static inline void FLUSH_FIFO_ON(struct au1xmmc_host *host)
 {
 	u32 val = au_readl(HOST_CONFIG2(host));
+	val |= SD_CONFIG2_FF;
+	au_writel(val, HOST_CONFIG2(host));
+	au_sync();
+}
 
-	au_writel(val | SD_CONFIG2_FF, HOST_CONFIG2(host));
-	au_sync_delay(1);
-	
-	/* SEND_STOP will turn off clock control - this re-enables it */
-	val &= ~SD_CONFIG2_DF;
+static inline void FIFO_ACTIVE(struct au1xmmc_host *host)
+{
+	u32 val = au_readl(HOST_CONFIG2(host));
 
+	/* SEND_STOP will turn off clock control - this re-enables it */
+	val &= ~(SD_CONFIG2_DF | SD_CONFIG2_FF);
 	au_writel(val, HOST_CONFIG2(host));
 	au_sync();
 }
@@ -124,8 +132,8 @@ static inline void IRQ_OFF(struct au1xmm
 static inline void SEND_STOP(struct au1xmmc_host *host) 
 {
 
-	/* We know the value of CONFIG2, so avoid a read we don't need */
-	u32 mask = SD_CONFIG2_EN;
+	/* Penalty box for Jordan - NEVER ASSUME! */
+	u32 mask = au_readl(HOST_CONFIG2(host));
 
 	WARN_ON(host->status != HOST_S_DATA);
 	host->status = HOST_S_STOP;
@@ -169,7 +177,7 @@ static void au1xmmc_finish_request(struc
 	host->flags &= HOST_F_ACTIVE; 
 
 	host->dma.len = 0;
-	host->dma.dir = 0;
+	host->dma.dir = DMA_BIDIRECTIONAL;
 
 	host->pio.index  = 0;
 	host->pio.offset = 0;
@@ -179,6 +187,9 @@ static void au1xmmc_finish_request(struc
 
 	bcsr->disk_leds |= (1 << 8);
 
+	/* Flush the FIFO until our next request */
+	FLUSH_FIFO_ON(host);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -196,7 +207,11 @@ static int au1xmmc_send_command(struct a
 
 	switch(cmd->flags) {
 	case MMC_RSP_R1:
-		mmccmd |= SD_CMD_RT_1;
+		if (cmd->opcode == 0x03 && host->mmc->mode == MMC_MODE_SD)
+			mmccmd |= SD_CMD_RT_6;
+		else
+			mmccmd |= SD_CMD_RT_1;
+
 		break;
 	case MMC_RSP_R1B:
 		mmccmd |= SD_CMD_RT_1B;
@@ -504,8 +519,8 @@ static void au1xmmc_cmd_complete(struct 
 		r[3] = au_readl(host->iobase + SD_RESP0);
 		
 		/* The CRC is omitted from the response, so really we only got
-		 * 120 bytes, but the engine expects 128 bits, so we have to shift
-		 * things up 
+		 * 120 bytes, but the engine expects 128 bits, so we have to 
+		 * shift things up 
 		 */
 		
 		for(i = 0; i < 4; i++) {
@@ -576,9 +591,8 @@ au1xmmc_prepare_data(struct au1xmmc_host
 {
 
 	int datalen = data->blocks * (1 << data->blksz_bits);
-
-	if (dma != 0) 
-		host->flags |= HOST_F_DMA;
+	int i = 0;
+	u32 channel;
 
 	if (data->flags & MMC_DATA_READ)
 		host->flags |= HOST_F_RECV;
@@ -588,8 +602,6 @@ au1xmmc_prepare_data(struct au1xmmc_host
 	if (host->mrq->stop) 
 		host->flags |= HOST_F_STOP;
 		
-	host->dma.dir = DMA_BIDIRECTIONAL;
-
 	host->dma.len = dma_map_sg(mmc_dev(host->mmc), data->sg,
 				   data->sg_len, host->dma.dir);
 
@@ -598,9 +610,21 @@ au1xmmc_prepare_data(struct au1xmmc_host
 
 	au_writel((1 << data->blksz_bits) - 1, HOST_BLKSIZE(host));	
 
-	if (host->flags & HOST_F_DMA) {
-		int i;
-		u32 channel = DMA_CHANNEL(host);
+	if (dma == 0) {
+		host->pio.index = 0;
+		host->pio.offset = 0;
+		host->pio.len = datalen;
+		
+		if (host->flags & HOST_F_XMIT)
+			IRQ_ON(host, SD_CONFIG_TH);
+		else 
+			IRQ_ON(host, SD_CONFIG_NE);
+
+		return MMC_ERR_NONE;
+	}
+
+	host->flags |= HOST_F_DMA;
+	channel = DMA_CHANNEL(host);
 
 		au1xxx_dbdma_stop(channel);
 
@@ -611,7 +635,7 @@ au1xmmc_prepare_data(struct au1xmmc_host
 			
 			int len = (datalen > sg_len) ? sg_len : datalen;
 
-			if (i == host->dma.len - 1)
+		if (i == (host->dma.len - 1))
 				flags = DDMA_FLAGS_IE;
 
     			if (host->flags & HOST_F_XMIT){
@@ -627,23 +651,11 @@ au1xmmc_prepare_data(struct au1xmmc_host
 					len, flags);
 			}
 
-    			if (!ret) 
+    		if (ret == 0) 
 				goto dataerr;
 
 			datalen -= len;
 		}
-	}
-	else {
-		host->pio.index = 0;
-		host->pio.offset = 0;
-		host->pio.len = datalen;
-		
-		if (host->flags & HOST_F_XMIT)
-			IRQ_ON(host, SD_CONFIG_TH);
-		else 
-			IRQ_ON(host, SD_CONFIG_NE);
-			//IRQ_ON(host, SD_CONFIG_RA|SD_CONFIG_RF);
-	}
 
 	return MMC_ERR_NONE;
 
@@ -671,7 +683,7 @@ static void au1xmmc_request(struct mmc_h
 	bcsr->disk_leds &= ~(1 << 8);
 
 	if (mrq->data) {
-		FLUSH_FIFO(host);
+		FIFO_ACTIVE(host);
 		ret = au1xmmc_prepare_data(host, mrq->data);
 	}
 
@@ -734,6 +746,20 @@ static void au1xmmc_set_ios(struct mmc_h
 		au1xmmc_set_clock(host, ios->clock);
 		host->clock = ios->clock;
 	}
+
+	/* Set the bus width for SD */
+
+	if (ios->bus_width != host->bus_width) {
+		u32 val;
+		val = au_readl(HOST_CONFIG2(host));
+		val &= ~(SD_CONFIG2_WB);
+		val |= (ios->bus_width == MMC_BUS_WIDTH_4) ? SD_CONFIG2_WB : 0;
+
+		au_writel(val, HOST_CONFIG2(host));
+		au_sync();
+
+		host->bus_width = ios->bus_width;
+	}
 }
 
 static void au1xmmc_dma_callback(int irq, void *dev_id, struct pt_regs *regs) 
@@ -778,24 +804,8 @@ static irqreturn_t au1xmmc_irq(int irq, 
 		
 			/* In PIO mode, interrupts might still be enabled */
 			IRQ_OFF(host, SD_CONFIG_NE | SD_CONFIG_TH);
-
-			//IRQ_OFF(host, SD_CONFIG_TH|SD_CONFIG_RA|SD_CONFIG_RF);
 			tasklet_schedule(&host->finish_task);
 		}
-#if 0
-		else if (status & SD_STATUS_DD) {
-
-			/* Sometimes we get a DD before a NE in PIO mode */
-
-			if (!(host->flags & HOST_F_DMA) && 
-					(status & SD_STATUS_NE))
-				au1xmmc_receive_pio(host);
-			else {
-				au1xmmc_data_complete(host, status);
-				//tasklet_schedule(&host->data_task);
-			}
-		}
-#endif
 		else if (status & (SD_STATUS_CR)) {
 			if (host->status == HOST_S_CMD)
 				au1xmmc_cmd_complete(host,status);
@@ -875,9 +885,15 @@ static void au1xmmc_init_dma(struct au1x
 	host->rx_chan = rxchan;
 }
 
+static int au1xmmc_get_ro(struct mmc_host *mmc) {
+	struct au1xmmc_host *host = mmc_priv(mmc);
+	return au1xmmc_card_readonly(host);
+}
+
 struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
+	.get_ro		= au1xmmc_get_ro, 
 };
 
 static int au1xmmc_probe(struct device *dev) 
@@ -914,6 +930,7 @@ static int au1xmmc_probe(struct device *
 		mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
 		mmc->max_phys_segs = AU1XMMC_DESCRIPTOR_COUNT; 
 
+		mmc->caps = MMC_CAP_4_BIT_DATA;
 		mmc->ocr_avail = AU1XMMC_OCR;
 
 		host = mmc_priv(mmc);
@@ -923,7 +940,9 @@ static int au1xmmc_probe(struct device *
 		host->iobase = au1xmmc_card_table[host->id].iobase;
 		host->clock = 0;
 		host->power_mode = MMC_POWER_OFF;
-		
+
+		host->bus_width = MMC_BUS_WIDTH_1;
+
 		host->flags = au1xmmc_card_inserted(host) ? HOST_F_ACTIVE : 0;
 		host->status = HOST_S_IDLE;
 
@@ -1017,4 +1036,3 @@ MODULE_AUTHOR("Advanced Micro Devices, I
 MODULE_DESCRIPTION("MMC/SD driver for the Alchemy Au1XXX");
 MODULE_LICENSE("GPL");
 #endif
-
