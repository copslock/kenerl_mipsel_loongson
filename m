Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 20:22:47 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.149]:53322 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493408AbZJMSWk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 20:22:40 +0200
Received: by ey-out-1920.google.com with SMTP id 3so1285677eyh.0
        for <multiple recipients>; Tue, 13 Oct 2009 11:22:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RXm7dDBcZNFf2rHpInUejC4/UY5BZpXXbeGzr9H4dsU=;
        b=vMFiKP4pE0nt/E5ywXsidB/QHM4hnEBOG3SbhwipWTu9fTKjmj/H6EoNbbfx/Yq5jZ
         iS524ua2juDqBOFnpzf7jAMVQ5Xh8TFGBmt+s2VggyPXULXp/42XldtydUfkuo4CpQJ7
         oDzDF4aYLiDDGbCZnBfkAFKJAoavfHwohctYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=R4sUXgoNVf19ZU/x8rGJqE9KdvRZulNv1il9VDP7jBExH2jwlZh6gu/eoAM/YbRYYp
         EXNHUCS9iBpE2+Z7DftG7uzkHx2R+Cm+t+zj3LJFk/n6S0ZYu8YWp1Akx0fLHsVj2kJm
         BcgV48qbVtDv5LkxrHmusXJwLK2ND/t9idZ2g=
Received: by 10.216.93.70 with SMTP id k48mr2436366wef.134.1255458157667;
        Tue, 13 Oct 2009 11:22:37 -0700 (PDT)
Received: from localhost.localdomain (p5496C133.dip.t-dialin.net [84.150.193.51])
        by mx.google.com with ESMTPS id t12sm3354672gvd.7.2009.10.13.11.22.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 11:22:36 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/2] MIPS: Alchemy: remove dbdma compat macros
Date:	Tue, 13 Oct 2009 20:22:34 +0200
Message-Id: <1255458155-14469-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Remove dbdma compat macros, move remaining users over to default
queueing functions and -flags.

(Queueing function signature has changed in order to give
 a build failure instead of silent functional changes due
 to the no longer implicitly specified DDMA_FLAGS_IE flag)

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/dbdma.c                 |    9 +++----
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |   23 +--------------------
 drivers/ide/au1xxx-ide.c                         |   21 ++++++++-----------
 drivers/mmc/host/au1xmmc.c                       |    4 +-
 drivers/spi/au1550_spi.c                         |    6 +++-
 sound/oss/au1550_ac97.c                          |   12 ++++++----
 sound/soc/au1x/dbdma2.c                          |    8 +++---
 7 files changed, 32 insertions(+), 51 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index fb09489..59ebe01 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -568,7 +568,7 @@ EXPORT_SYMBOL(au1xxx_dbdma_ring_alloc);
  * This updates the source pointer and byte count.  Normally used
  * for memory to fifo transfers.
  */
-u32 _au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
+u32 au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
@@ -621,14 +621,13 @@ u32 _au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags)
 	/* Return something non-zero. */
 	return nbytes;
 }
-EXPORT_SYMBOL(_au1xxx_dbdma_put_source);
+EXPORT_SYMBOL(au1xxx_dbdma_put_source);
 
 /* Put a destination buffer into the DMA ring.
  * This updates the destination pointer and byte count.  Normally used
  * to place an empty buffer into the ring for fifo to memory transfers.
  */
-u32
-_au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags)
+u32 au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags)
 {
 	chan_tab_t		*ctp;
 	au1x_ddma_desc_t	*dp;
@@ -684,7 +683,7 @@ _au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags)
 	/* Return something non-zero. */
 	return nbytes;
 }
-EXPORT_SYMBOL(_au1xxx_dbdma_put_dest);
+EXPORT_SYMBOL(au1xxx_dbdma_put_dest);
 
 /*
  * Get a destination buffer into the DMA ring.
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index 06f68f4..626c4f8 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -338,8 +338,8 @@ u32 au1xxx_dbdma_set_devwidth(u32 chanid, int bits);
 u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries);
 
 /* Put buffers on source/destination descriptors. */
-u32 _au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags);
-u32 _au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags);
+u32 au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags);
+u32 au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags);
 
 /* Get a buffer from the destination descriptor. */
 u32 au1xxx_dbdma_get_dest(u32 chanid, void **buf, int *nbytes);
@@ -362,25 +362,6 @@ void au1xxx_dbdma_suspend(void);
 void au1xxx_dbdma_resume(void);
 #endif
 
-
-/*
- * Some compatibilty macros -- needed to make changes to API
- * without breaking existing drivers.
- */
-#define au1xxx_dbdma_put_source(chanid, buf, nbytes)			\
-	_au1xxx_dbdma_put_source(chanid, buf, nbytes, DDMA_FLAGS_IE)
-#define au1xxx_dbdma_put_source_flags(chanid, buf, nbytes, flags)	\
-	_au1xxx_dbdma_put_source(chanid, buf, nbytes, flags)
-#define put_source_flags(chanid, buf, nbytes, flags)			\
-	au1xxx_dbdma_put_source_flags(chanid, buf, nbytes, flags)
-
-#define au1xxx_dbdma_put_dest(chanid, buf, nbytes)			\
-	_au1xxx_dbdma_put_dest(chanid, buf, nbytes, DDMA_FLAGS_IE)
-#define au1xxx_dbdma_put_dest_flags(chanid, buf, nbytes, flags) 	\
-	_au1xxx_dbdma_put_dest(chanid, buf, nbytes, flags)
-#define put_dest_flags(chanid, buf, nbytes, flags)			\
-	au1xxx_dbdma_put_dest_flags(chanid, buf, nbytes, flags)
-
 /*
  *	Flags for the put_source/put_dest functions.
  */
diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index 58121bd..dc44e62 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -56,8 +56,8 @@ static inline void auide_insw(unsigned long port, void *addr, u32 count)
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
 
-	if(!put_dest_flags(ahwif->rx_chan, (void*)addr, count << 1, 
-			   DDMA_FLAGS_NOIE)) {
+	if (!au1xxx_dbdma_put_dest(ahwif->rx_chan, (void*)addr,
+				   count << 1, DDMA_FLAGS_NOIE)) {
 		printk(KERN_ERR "%s failed %d\n", __func__, __LINE__);
 		return;
 	}
@@ -74,8 +74,8 @@ static inline void auide_outsw(unsigned long port, void *addr, u32 count)
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
 
-	if(!put_source_flags(ahwif->tx_chan, (void*)addr,
-			     count << 1, DDMA_FLAGS_NOIE)) {
+	if (!au1xxx_dbdma_put_source(ahwif->tx_chan, (void*)addr,
+				     count << 1, DDMA_FLAGS_NOIE)) {
 		printk(KERN_ERR "%s failed %d\n", __func__, __LINE__);
 		return;
 	}
@@ -246,17 +246,14 @@ static int auide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 				flags = DDMA_FLAGS_NOIE;
 
 			if (iswrite) {
-				if(!put_source_flags(ahwif->tx_chan, 
-						     (void*) sg_virt(sg),
-						     tc, flags)) { 
+				if (!au1xxx_dbdma_put_source(ahwif->tx_chan,
+					(void *)sg_virt(sg), tc, flags)) {
 					printk(KERN_ERR "%s failed %d\n", 
 					       __func__, __LINE__);
 				}
-			} else 
-			{
-				if(!put_dest_flags(ahwif->rx_chan, 
-						   (void*) sg_virt(sg),
-						   tc, flags)) { 
+			} else  {
+				if (!au1xxx_dbdma_put_dest(ahwif->rx_chan,
+					(void *)sg_virt(sg), tc, flags)) {
 					printk(KERN_ERR "%s failed %d\n", 
 					       __func__, __LINE__);
 				}
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d3f5561..d295dc5 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -650,10 +650,10 @@ static int au1xmmc_prepare_data(struct au1xmmc_host *host,
 				flags = DDMA_FLAGS_IE;
 
 			if (host->flags & HOST_F_XMIT) {
-				ret = au1xxx_dbdma_put_source_flags(channel,
+				ret = au1xxx_dbdma_put_source(channel,
 					(void *)sg_virt(sg), len, flags);
 			} else {
-				ret = au1xxx_dbdma_put_dest_flags(channel,
+				ret = au1xxx_dbdma_put_dest(channel,
 					(void *)sg_virt(sg), len, flags);
 			}
 
diff --git a/drivers/spi/au1550_spi.c b/drivers/spi/au1550_spi.c
index 76cbc1a..67cfb08 100644
--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -406,11 +406,13 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	/* put buffers on the ring */
-	res = au1xxx_dbdma_put_dest(hw->dma_rx_ch, hw->rx, t->len);
+	res = au1xxx_dbdma_put_dest(hw->dma_rx_ch, hw->rx,
+				    t->len, DDMA_FLAGS_IE);
 	if (!res)
 		dev_err(hw->dev, "rx dma put dest error\n");
 
-	res = au1xxx_dbdma_put_source(hw->dma_tx_ch, (void *)hw->tx, t->len);
+	res = au1xxx_dbdma_put_source(hw->dma_tx_ch, (void *)hw->tx,
+				      t->len, DDMA_FLAGS_IE);
 	if (!res)
 		dev_err(hw->dev, "tx dma put source error\n");
 
diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index 4191acc..b9ff0b7 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -614,7 +614,8 @@ start_adc(struct au1550_state *s)
 	/* Put two buffers on the ring to get things started.
 	*/
 	for (i=0; i<2; i++) {
-		au1xxx_dbdma_put_dest(db->dmanr, db->nextIn, db->dma_fragsize);
+		au1xxx_dbdma_put_dest(db->dmanr, db->nextIn,
+				db->dma_fragsize, DDMA_FLAGS_IE);
 
 		db->nextIn += db->dma_fragsize;
 		if (db->nextIn >= db->rawbuf + db->dmasize)
@@ -733,7 +734,7 @@ static void dac_dma_interrupt(int irq, void *dev_id)
 
 	if (db->count >= db->fragsize) {
 		if (au1xxx_dbdma_put_source(db->dmanr, db->nextOut,
-							db->fragsize) == 0) {
+				db->fragsize, DDMA_FLAGS_IE) == 0) {
 			err("qcount < 2 and no ring room!");
 		}
 		db->nextOut += db->fragsize;
@@ -777,7 +778,8 @@ static void adc_dma_interrupt(int irq, void *dev_id)
 
 	/* Put a new empty buffer on the destination DMA.
 	*/
-	au1xxx_dbdma_put_dest(dp->dmanr, dp->nextIn, dp->dma_fragsize);
+	au1xxx_dbdma_put_dest(dp->dmanr, dp->nextIn,
+			      dp->dma_fragsize, DDMA_FLAGS_IE);
 
 	dp->nextIn += dp->dma_fragsize;
 	if (dp->nextIn >= dp->rawbuf + dp->dmasize)
@@ -1177,8 +1179,8 @@ au1550_write(struct file *file, const char *buffer, size_t count, loff_t * ppos)
 		 * we know the dma has stopped.
 		 */
 		while ((db->dma_qcount < 2) && (db->count >= db->fragsize)) {
-			if (au1xxx_dbdma_put_source(db->dmanr, db->nextOut,
-							db->fragsize) == 0) {
+			if (au1xxx_dbdma_put_source(db->dmanr,
+				db->nextOut, db->fragsize, DDMA_FLAGS_IE) == 0) {
 				err("qcount < 2 and no ring room!");
 			}
 			db->nextOut += db->fragsize;
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 594c6c5..d291140 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -94,7 +94,7 @@ static const struct snd_pcm_hardware au1xpsc_pcm_hardware = {
 
 static void au1x_pcm_queue_tx(struct au1xpsc_audio_dmadata *cd)
 {
-	au1xxx_dbdma_put_source_flags(cd->ddma_chan,
+	au1xxx_dbdma_put_source(cd->ddma_chan,
 				(void *)phys_to_virt(cd->dma_area),
 				cd->period_bytes, DDMA_FLAGS_IE);
 
@@ -109,9 +109,9 @@ static void au1x_pcm_queue_tx(struct au1xpsc_audio_dmadata *cd)
 
 static void au1x_pcm_queue_rx(struct au1xpsc_audio_dmadata *cd)
 {
-	au1xxx_dbdma_put_dest_flags(cd->ddma_chan,
-				(void *)phys_to_virt(cd->dma_area),
-				cd->period_bytes, DDMA_FLAGS_IE);
+	au1xxx_dbdma_put_dest(cd->ddma_chan,
+			      (void *)phys_to_virt(cd->dma_area),
+			      cd->period_bytes, DDMA_FLAGS_IE);
 
 	/* update next-to-queue period */
 	++cd->q_period;
-- 
1.6.5.rc2
