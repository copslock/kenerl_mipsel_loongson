Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 20:23:14 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:48512 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493540AbZJMSWp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 20:22:45 +0200
Received: by ewy12 with SMTP id 12so2845279ewy.0
        for <multiple recipients>; Tue, 13 Oct 2009 11:22:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0Vgx6sRUsDu7WyngW6ev8H1o00+wo2rYQw/lgmnmCm8=;
        b=ELuS+5Q8IN8SQZ5D5AA8RriUIhcw3L4QQAhbb/wLkJIUdzOirYhpXpad/aD0zq22WF
         KP/AnPtV9CKkPF5st516HPTy42gL+IQK8Yi1+mwzybDNUM1OwtrkHM3EP75CdqGUiSnQ
         3sbrrx1++VLvnVLMfFUsWk9sRsMAfDOQgk73c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NPPmNq+iGbqtwMuS/DywkAEd4qyHVYf4UgnIHfdbqz93HzjahNYQXd/hMxfcvSmqV+
         Bz2R2HyWyjgfkd4nNSX2RMY9NnzzWu2/lWxeBwOlU78MzbKhALXYCI0msdG/zhHvkvkf
         3q+yiE0w6USbMCTgJY6IQudaZucimncudVNkg=
Received: by 10.216.85.68 with SMTP id t46mr2508847wee.114.1255458159462;
        Tue, 13 Oct 2009 11:22:39 -0700 (PDT)
Received: from localhost.localdomain (p5496C133.dip.t-dialin.net [84.150.193.51])
        by mx.google.com with ESMTPS id t12sm3354672gvd.7.2009.10.13.11.22.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 11:22:38 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: change dbdma to accept physical memory addresses
Date:	Tue, 13 Oct 2009 20:22:35 +0200
Message-Id: <1255458155-14469-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1255458155-14469-1-git-send-email-manuel.lauss@gmail.com>
References: <1255458155-14469-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

DMA can only be done from physical addresses;
move the "virt_to_phys" source/destination buffer address translation
from the dbdma queueing functions (since the hardware can only DMA
to/from physical addresses) to their respective users.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
All affected drivers still run fine on the DB1200, so I assume it's
working right (au1550_ac97.c is untested).

 arch/mips/alchemy/common/dbdma.c                 |    8 ++++----
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    4 ++--
 drivers/ide/au1xxx-ide.c                         |    8 ++++----
 drivers/mmc/host/au1xmmc.c                       |    4 ++--
 drivers/spi/au1550_spi.c                         |    4 ++--
 sound/oss/au1550_ac97.c                          |   12 +++++++-----
 sound/soc/au1x/dbdma2.c                          |   12 +++++-------
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 59ebe01..4851308 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -568,7 +568,7 @@ EXPORT_SYMBOL(au1xxx_dbdma_ring_alloc);
  * This updates the source pointer and byte count.  Normally used
  * for memory to fifo transfers.
  */
-u32 au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
+u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
@@ -594,7 +594,7 @@ u32 au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
 		return 0;
 
 	/* Load up buffer address and byte count. */
-	dp->dscr_source0 = virt_to_phys(buf);
+	dp->dscr_source0 = buf & ~0UL;
 	dp->dscr_cmd1 = nbytes;
 	/* Check flags */
 	if (flags & DDMA_FLAGS_IE)
@@ -627,7 +627,7 @@ EXPORT_SYMBOL(au1xxx_dbdma_put_source);
  * This updates the destination pointer and byte count.  Normally used
  * to place an empty buffer into the ring for fifo to memory transfers.
  */
-u32 au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags)
+u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
@@ -657,7 +657,7 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags)
 	if (flags & DDMA_FLAGS_NOIE)
 		dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 
-	dp->dscr_dest0 = virt_to_phys(buf);
+	dp->dscr_dest0 = buf & ~0UL;
 	dp->dscr_cmd1 = nbytes;
 #if 0
 	printk(KERN_DEBUG "cmd0:%x cmd1:%x source0:%x source1:%x dest0:%x dest1:%x\n",
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index 626c4f8..c098b45 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -338,8 +338,8 @@ u32 au1xxx_dbdma_set_devwidth(u32 chanid, int bits);
 u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries);
 
 /* Put buffers on source/destination descriptors. */
-u32 au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags);
-u32 au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags);
+u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags);
+u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags);
 
 /* Get a buffer from the destination descriptor. */
 u32 au1xxx_dbdma_get_dest(u32 chanid, void **buf, int *nbytes);
diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index dc44e62..bcf4176 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -56,7 +56,7 @@ static inline void auide_insw(unsigned long port, void *addr, u32 count)
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
 
-	if (!au1xxx_dbdma_put_dest(ahwif->rx_chan, (void*)addr,
+	if (!au1xxx_dbdma_put_dest(ahwif->rx_chan, virt_to_phys(addr),
 				   count << 1, DDMA_FLAGS_NOIE)) {
 		printk(KERN_ERR "%s failed %d\n", __func__, __LINE__);
 		return;
@@ -74,7 +74,7 @@ static inline void auide_outsw(unsigned long port, void *addr, u32 count)
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
 
-	if (!au1xxx_dbdma_put_source(ahwif->tx_chan, (void*)addr,
+	if (!au1xxx_dbdma_put_source(ahwif->tx_chan, virt_to_phys(addr),
 				     count << 1, DDMA_FLAGS_NOIE)) {
 		printk(KERN_ERR "%s failed %d\n", __func__, __LINE__);
 		return;
@@ -247,13 +247,13 @@ static int auide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 
 			if (iswrite) {
 				if (!au1xxx_dbdma_put_source(ahwif->tx_chan,
-					(void *)sg_virt(sg), tc, flags)) {
+					sg_phys(sg), tc, flags)) {
 					printk(KERN_ERR "%s failed %d\n", 
 					       __func__, __LINE__);
 				}
 			} else  {
 				if (!au1xxx_dbdma_put_dest(ahwif->rx_chan,
-					(void *)sg_virt(sg), tc, flags)) {
+					sg_phys(sg), tc, flags)) {
 					printk(KERN_ERR "%s failed %d\n", 
 					       __func__, __LINE__);
 				}
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d295dc5..c8649df 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -651,10 +651,10 @@ static int au1xmmc_prepare_data(struct au1xmmc_host *host,
 
 			if (host->flags & HOST_F_XMIT) {
 				ret = au1xxx_dbdma_put_source(channel,
-					(void *)sg_virt(sg), len, flags);
+					sg_phys(sg), len, flags);
 			} else {
 				ret = au1xxx_dbdma_put_dest(channel,
-					(void *)sg_virt(sg), len, flags);
+					sg_phys(sg), len, flags);
 			}
 
 			if (!ret)
diff --git a/drivers/spi/au1550_spi.c b/drivers/spi/au1550_spi.c
index 67cfb08..c343f00 100644
--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -406,12 +406,12 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	/* put buffers on the ring */
-	res = au1xxx_dbdma_put_dest(hw->dma_rx_ch, hw->rx,
+	res = au1xxx_dbdma_put_dest(hw->dma_rx_ch, virt_to_phys(hw->rx),
 				    t->len, DDMA_FLAGS_IE);
 	if (!res)
 		dev_err(hw->dev, "rx dma put dest error\n");
 
-	res = au1xxx_dbdma_put_source(hw->dma_tx_ch, (void *)hw->tx,
+	res = au1xxx_dbdma_put_source(hw->dma_tx_ch, virt_to_phys(hw->tx),
 				      t->len, DDMA_FLAGS_IE);
 	if (!res)
 		dev_err(hw->dev, "tx dma put source error\n");
diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index b9ff0b7..c1070e3 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -614,7 +614,7 @@ start_adc(struct au1550_state *s)
 	/* Put two buffers on the ring to get things started.
 	*/
 	for (i=0; i<2; i++) {
-		au1xxx_dbdma_put_dest(db->dmanr, db->nextIn,
+		au1xxx_dbdma_put_dest(db->dmanr, virt_to_phys(db->nextIn),
 				db->dma_fragsize, DDMA_FLAGS_IE);
 
 		db->nextIn += db->dma_fragsize;
@@ -733,8 +733,9 @@ static void dac_dma_interrupt(int irq, void *dev_id)
 	db->dma_qcount--;
 
 	if (db->count >= db->fragsize) {
-		if (au1xxx_dbdma_put_source(db->dmanr, db->nextOut,
-				db->fragsize, DDMA_FLAGS_IE) == 0) {
+		if (au1xxx_dbdma_put_source(db->dmanr,
+				virt_to_phys(db->nextOut), db->fragsize,
+				DDMA_FLAGS_IE) == 0) {
 			err("qcount < 2 and no ring room!");
 		}
 		db->nextOut += db->fragsize;
@@ -778,7 +779,7 @@ static void adc_dma_interrupt(int irq, void *dev_id)
 
 	/* Put a new empty buffer on the destination DMA.
 	*/
-	au1xxx_dbdma_put_dest(dp->dmanr, dp->nextIn,
+	au1xxx_dbdma_put_dest(dp->dmanr, virt_to_phys(dp->nextIn),
 			      dp->dma_fragsize, DDMA_FLAGS_IE);
 
 	dp->nextIn += dp->dma_fragsize;
@@ -1180,7 +1181,8 @@ au1550_write(struct file *file, const char *buffer, size_t count, loff_t * ppos)
 		 */
 		while ((db->dma_qcount < 2) && (db->count >= db->fragsize)) {
 			if (au1xxx_dbdma_put_source(db->dmanr,
-				db->nextOut, db->fragsize, DDMA_FLAGS_IE) == 0) {
+				virt_to_phys(db->nextOut), db->fragsize,
+				DDMA_FLAGS_IE) == 0) {
 				err("qcount < 2 and no ring room!");
 			}
 			db->nextOut += db->fragsize;
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index d291140..72617d7 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -51,8 +51,8 @@ struct au1xpsc_audio_dmadata {
 	struct snd_pcm_substream *substream;
 	unsigned long curr_period;	/* current segment DDMA is working on */
 	unsigned long q_period;		/* queue period(s) */
-	unsigned long dma_area;		/* address of queued DMA area */
-	unsigned long dma_area_s;	/* start address of DMA area */
+	dma_addr_t dma_area;		/* address of queued DMA area */
+	dma_addr_t dma_area_s;		/* start address of DMA area */
 	unsigned long pos;		/* current byte position being played */
 	unsigned long periods;		/* number of SG segments in total */
 	unsigned long period_bytes;	/* size in bytes of one SG segment */
@@ -94,8 +94,7 @@ static const struct snd_pcm_hardware au1xpsc_pcm_hardware = {
 
 static void au1x_pcm_queue_tx(struct au1xpsc_audio_dmadata *cd)
 {
-	au1xxx_dbdma_put_source(cd->ddma_chan,
-				(void *)phys_to_virt(cd->dma_area),
+	au1xxx_dbdma_put_source(cd->ddma_chan, cd->dma_area,
 				cd->period_bytes, DDMA_FLAGS_IE);
 
 	/* update next-to-queue period */
@@ -109,8 +108,7 @@ static void au1x_pcm_queue_tx(struct au1xpsc_audio_dmadata *cd)
 
 static void au1x_pcm_queue_rx(struct au1xpsc_audio_dmadata *cd)
 {
-	au1xxx_dbdma_put_dest(cd->ddma_chan,
-			      (void *)phys_to_virt(cd->dma_area),
+	au1xxx_dbdma_put_dest(cd->ddma_chan, cd->dma_area,
 			      cd->period_bytes, DDMA_FLAGS_IE);
 
 	/* update next-to-queue period */
@@ -233,7 +231,7 @@ static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
 	pcd->substream = substream;
 	pcd->period_bytes = params_period_bytes(params);
 	pcd->periods = params_periods(params);
-	pcd->dma_area_s = pcd->dma_area = (unsigned long)runtime->dma_addr;
+	pcd->dma_area_s = pcd->dma_area = runtime->dma_addr;
 	pcd->q_period = 0;
 	pcd->curr_period = 0;
 	pcd->pos = 0;
-- 
1.6.5.rc2
