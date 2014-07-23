Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:40:37 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38989 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842529AbaGWOhAERUin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:00 +0200
Received: by mail-wi0-f178.google.com with SMTP id hi2so2345943wib.17
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2OaZi5YrtLdpck4DdywogEou1bOcntlGPHze891Wcco=;
        b=ZdlnGddKl0ftj3yBNZoY9xh54xIoZXRnIYeGwKJG2/O4RrC1wM45pv67rb7yKAH036
         jvMsBy2+ICt6gp6IspP2OqNAreftPNe96mhkF0mvfTIYVXI1f4IefHjw5KttWAys+LRO
         QcpkqGfudTFBwc+vKupPV268mPuqdRtA25d5rXxAwVT7jD/eDgqvMJdmElVV3FUtVS0b
         UIrik7hkmwn6ChmUibnHKhcR9Pvr9C1/Qw0FRzx8lVnbke2dBp6vooeiowrYnIi+yPGN
         2g7T32FTs2YjqzmC7Zmtt3G5FPl3AO+av/8ayggteZUDXqHZUxNkmfbHb/74aHBwdeWf
         ATdw==
X-Received: by 10.194.5.103 with SMTP id r7mr2424878wjr.41.1406126212608;
        Wed, 23 Jul 2014 07:36:52 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id h3sm6717751wjz.48.2014.07.23.07.36.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:36:51 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 6/6] MIPS: Alchemy: remove au_read/write/sync
Date:   Wed, 23 Jul 2014 16:36:26 +0200
Message-Id: <1406126186-471228-7-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

replace au_read/write/sync with __raw_read/write and wmb.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/dbdma.c               |  22 ++--
 arch/mips/alchemy/common/dma.c                 |  15 +--
 arch/mips/include/asm/mach-au1x00/au1000.h     |  48 -------
 arch/mips/include/asm/mach-au1x00/au1000_dma.h |  50 ++++----
 drivers/mmc/host/au1xmmc.c                     | 167 +++++++++++++------------
 drivers/mtd/nand/au1550nd.c                    |  21 ++--
 drivers/net/ethernet/amd/au1000_eth.c          |  31 +++--
 drivers/spi/spi-au1550.c                       |  66 +++++-----
 drivers/video/fbdev/au1100fb.c                 |   4 +-
 drivers/video/fbdev/au1200fb.c                 |  31 +++--
 sound/soc/au1x/psc-ac97.c                      | 140 ++++++++++-----------
 sound/soc/au1x/psc-i2s.c                       | 100 +++++++--------
 sound/soc/au1x/psc.h                           |  22 ++--
 13 files changed, 340 insertions(+), 377 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 19d5642..745695d 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -341,7 +341,7 @@ u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
 			(dtp->dev_flags & DEV_FLAGS_SYNC))
 				i |= DDMA_CFG_SYNC;
 		cp->ddma_cfg = i;
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		/*
 		 * Return a non-zero value that can be used to find the channel
@@ -631,7 +631,7 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 	 */
 	dma_cache_wback_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
-	au_sync();
+	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
 
@@ -693,7 +693,7 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 	 */
 	dma_cache_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
-	au_sync();
+	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
 
@@ -760,7 +760,7 @@ void au1xxx_dbdma_stop(u32 chanid)
 
 	cp = ctp->chan_ptr;
 	cp->ddma_cfg &= ~DDMA_CFG_EN;	/* Disable channel */
-	au_sync();
+	wmb(); /* drain writebuffer */
 	while (!(cp->ddma_stat & DDMA_STAT_H)) {
 		udelay(1);
 		halt_timeout++;
@@ -771,7 +771,7 @@ void au1xxx_dbdma_stop(u32 chanid)
 	}
 	/* clear current desc valid and doorbell */
 	cp->ddma_stat |= (DDMA_STAT_DB | DDMA_STAT_V);
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 EXPORT_SYMBOL(au1xxx_dbdma_stop);
 
@@ -789,9 +789,9 @@ void au1xxx_dbdma_start(u32 chanid)
 	cp = ctp->chan_ptr;
 	cp->ddma_desptr = virt_to_phys(ctp->cur_ptr);
 	cp->ddma_cfg |= DDMA_CFG_EN;	/* Enable channel */
-	au_sync();
+	wmb(); /* drain writebuffer */
 	cp->ddma_dbell = 0;
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 EXPORT_SYMBOL(au1xxx_dbdma_start);
 
@@ -832,7 +832,7 @@ u32 au1xxx_get_dma_residue(u32 chanid)
 
 	/* This is only valid if the channel is stopped. */
 	rv = cp->ddma_bytecnt;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	return rv;
 }
@@ -868,7 +868,7 @@ static irqreturn_t dbdma_interrupt(int irq, void *dev_id)
 	au1x_dma_chan_t *cp;
 
 	intstat = dbdma_gptr->ddma_intstat;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	chan_index = __ffs(intstat);
 
 	ctp = chan_tab_ptr[chan_index];
@@ -877,7 +877,7 @@ static irqreturn_t dbdma_interrupt(int irq, void *dev_id)
 
 	/* Reset interrupt. */
 	cp->ddma_irq = 0;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	if (ctp->chan_callback)
 		ctp->chan_callback(irq, ctp->chan_callparam);
@@ -1061,7 +1061,7 @@ static int __init dbdma_setup(unsigned int irq, dbdev_tab_t *idtable)
 	dbdma_gptr->ddma_config = 0;
 	dbdma_gptr->ddma_throttle = 0;
 	dbdma_gptr->ddma_inten = 0xffff;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	ret = request_irq(irq, dbdma_interrupt, 0, "dbdma", (void *)dbdma_gptr);
 	if (ret)
diff --git a/arch/mips/alchemy/common/dma.c b/arch/mips/alchemy/common/dma.c
index 9b624e2..4fb6207 100644
--- a/arch/mips/alchemy/common/dma.c
+++ b/arch/mips/alchemy/common/dma.c
@@ -141,17 +141,17 @@ void dump_au1000_dma_channel(unsigned int dmanr)
 
 	printk(KERN_INFO "Au1000 DMA%d Register Dump:\n", dmanr);
 	printk(KERN_INFO "  mode = 0x%08x\n",
-	       au_readl(chan->io + DMA_MODE_SET));
+	       __raw_readl(chan->io + DMA_MODE_SET));
 	printk(KERN_INFO "  addr = 0x%08x\n",
-	       au_readl(chan->io + DMA_PERIPHERAL_ADDR));
+	       __raw_readl(chan->io + DMA_PERIPHERAL_ADDR));
 	printk(KERN_INFO "  start0 = 0x%08x\n",
-	       au_readl(chan->io + DMA_BUFFER0_START));
+	       __raw_readl(chan->io + DMA_BUFFER0_START));
 	printk(KERN_INFO "  start1 = 0x%08x\n",
-	       au_readl(chan->io + DMA_BUFFER1_START));
+	       __raw_readl(chan->io + DMA_BUFFER1_START));
 	printk(KERN_INFO "  count0 = 0x%08x\n",
-	       au_readl(chan->io + DMA_BUFFER0_COUNT));
+	       __raw_readl(chan->io + DMA_BUFFER0_COUNT));
 	printk(KERN_INFO "  count1 = 0x%08x\n",
-	       au_readl(chan->io + DMA_BUFFER1_COUNT));
+	       __raw_readl(chan->io + DMA_BUFFER1_COUNT));
 }
 
 /*
@@ -204,7 +204,8 @@ int request_au1000_dma(int dev_id, const char *dev_str,
 	}
 
 	/* fill it in */
-	chan->io = KSEG1ADDR(AU1000_DMA_PHYS_ADDR) + i * DMA_CHANNEL_LEN;
+	chan->io = (void __iomem *)(KSEG1ADDR(AU1000_DMA_PHYS_ADDR) +
+			i * DMA_CHANNEL_LEN);
 	chan->dev_id = dev_id;
 	chan->dev_str = dev_str;
 	chan->fifo_addr = dev->fifo_addr;
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index d664b11..7542070 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -645,54 +645,6 @@
 
 #include <asm/cpu.h>
 
-/* cpu pipeline flush */
-void static inline au_sync(void)
-{
-	__asm__ volatile ("sync");
-}
-
-void static inline au_sync_udelay(int us)
-{
-	__asm__ volatile ("sync");
-	udelay(us);
-}
-
-void static inline au_sync_delay(int ms)
-{
-	__asm__ volatile ("sync");
-	mdelay(ms);
-}
-
-void static inline au_writeb(u8 val, unsigned long reg)
-{
-	*(volatile u8 *)reg = val;
-}
-
-void static inline au_writew(u16 val, unsigned long reg)
-{
-	*(volatile u16 *)reg = val;
-}
-
-void static inline au_writel(u32 val, unsigned long reg)
-{
-	*(volatile u32 *)reg = val;
-}
-
-static inline u8 au_readb(unsigned long reg)
-{
-	return *(volatile u8 *)reg;
-}
-
-static inline u16 au_readw(unsigned long reg)
-{
-	return *(volatile u16 *)reg;
-}
-
-static inline u32 au_readl(unsigned long reg)
-{
-	return *(volatile u32 *)reg;
-}
-
 /* helpers to access the SYS_* registers */
 static inline unsigned long alchemy_rdsys(int regofs)
 {
diff --git a/arch/mips/include/asm/mach-au1x00/au1000_dma.h b/arch/mips/include/asm/mach-au1x00/au1000_dma.h
index 7cedca5..0a0cd42 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000_dma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000_dma.h
@@ -106,7 +106,7 @@ enum {
 struct dma_chan {
 	int dev_id;		/* this channel is allocated if >= 0, */
 				/* free otherwise */
-	unsigned int io;
+	void __iomem *io;
 	const char *dev_str;
 	int irq;
 	void *irq_dev;
@@ -157,7 +157,7 @@ static inline void enable_dma_buffer0(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_BE0, chan->io + DMA_MODE_SET);
+	__raw_writel(DMA_BE0, chan->io + DMA_MODE_SET);
 }
 
 static inline void enable_dma_buffer1(unsigned int dmanr)
@@ -166,7 +166,7 @@ static inline void enable_dma_buffer1(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_BE1, chan->io + DMA_MODE_SET);
+	__raw_writel(DMA_BE1, chan->io + DMA_MODE_SET);
 }
 static inline void enable_dma_buffers(unsigned int dmanr)
 {
@@ -174,7 +174,7 @@ static inline void enable_dma_buffers(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_BE0 | DMA_BE1, chan->io + DMA_MODE_SET);
+	__raw_writel(DMA_BE0 | DMA_BE1, chan->io + DMA_MODE_SET);
 }
 
 static inline void start_dma(unsigned int dmanr)
@@ -183,7 +183,7 @@ static inline void start_dma(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_GO, chan->io + DMA_MODE_SET);
+	__raw_writel(DMA_GO, chan->io + DMA_MODE_SET);
 }
 
 #define DMA_HALT_POLL 0x5000
@@ -195,11 +195,11 @@ static inline void halt_dma(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_GO, chan->io + DMA_MODE_CLEAR);
+	__raw_writel(DMA_GO, chan->io + DMA_MODE_CLEAR);
 
 	/* Poll the halt bit */
 	for (i = 0; i < DMA_HALT_POLL; i++)
-		if (au_readl(chan->io + DMA_MODE_READ) & DMA_HALT)
+		if (__raw_readl(chan->io + DMA_MODE_READ) & DMA_HALT)
 			break;
 	if (i == DMA_HALT_POLL)
 		printk(KERN_INFO "halt_dma: HALT poll expired!\n");
@@ -215,7 +215,7 @@ static inline void disable_dma(unsigned int dmanr)
 	halt_dma(dmanr);
 
 	/* Now we can disable the buffers */
-	au_writel(~DMA_GO, chan->io + DMA_MODE_CLEAR);
+	__raw_writel(~DMA_GO, chan->io + DMA_MODE_CLEAR);
 }
 
 static inline int dma_halted(unsigned int dmanr)
@@ -224,7 +224,7 @@ static inline int dma_halted(unsigned int dmanr)
 
 	if (!chan)
 		return 1;
-	return (au_readl(chan->io + DMA_MODE_READ) & DMA_HALT) ? 1 : 0;
+	return (__raw_readl(chan->io + DMA_MODE_READ) & DMA_HALT) ? 1 : 0;
 }
 
 /* Initialize a DMA channel. */
@@ -239,14 +239,14 @@ static inline void init_dma(unsigned int dmanr)
 	disable_dma(dmanr);
 
 	/* Set device FIFO address */
-	au_writel(CPHYSADDR(chan->fifo_addr), chan->io + DMA_PERIPHERAL_ADDR);
+	__raw_writel(CPHYSADDR(chan->fifo_addr), chan->io + DMA_PERIPHERAL_ADDR);
 
 	mode = chan->mode | (chan->dev_id << DMA_DID_BIT);
 	if (chan->irq)
 		mode |= DMA_IE;
 
-	au_writel(~mode, chan->io + DMA_MODE_CLEAR);
-	au_writel(mode,	 chan->io + DMA_MODE_SET);
+	__raw_writel(~mode, chan->io + DMA_MODE_CLEAR);
+	__raw_writel(mode,	 chan->io + DMA_MODE_SET);
 }
 
 /*
@@ -283,7 +283,7 @@ static inline int get_dma_active_buffer(unsigned int dmanr)
 
 	if (!chan)
 		return -1;
-	return (au_readl(chan->io + DMA_MODE_READ) & DMA_AB) ? 1 : 0;
+	return (__raw_readl(chan->io + DMA_MODE_READ) & DMA_AB) ? 1 : 0;
 }
 
 /*
@@ -304,7 +304,7 @@ static inline void set_dma_fifo_addr(unsigned int dmanr, unsigned int a)
 	if (chan->dev_id != DMA_ID_GP04 && chan->dev_id != DMA_ID_GP05)
 		return;
 
-	au_writel(CPHYSADDR(a), chan->io + DMA_PERIPHERAL_ADDR);
+	__raw_writel(CPHYSADDR(a), chan->io + DMA_PERIPHERAL_ADDR);
 }
 
 /*
@@ -316,7 +316,7 @@ static inline void clear_dma_done0(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_D0, chan->io + DMA_MODE_CLEAR);
+	__raw_writel(DMA_D0, chan->io + DMA_MODE_CLEAR);
 }
 
 static inline void clear_dma_done1(unsigned int dmanr)
@@ -325,7 +325,7 @@ static inline void clear_dma_done1(unsigned int dmanr)
 
 	if (!chan)
 		return;
-	au_writel(DMA_D1, chan->io + DMA_MODE_CLEAR);
+	__raw_writel(DMA_D1, chan->io + DMA_MODE_CLEAR);
 }
 
 /*
@@ -344,7 +344,7 @@ static inline void set_dma_addr0(unsigned int dmanr, unsigned int a)
 
 	if (!chan)
 		return;
-	au_writel(a, chan->io + DMA_BUFFER0_START);
+	__raw_writel(a, chan->io + DMA_BUFFER0_START);
 }
 
 /*
@@ -356,7 +356,7 @@ static inline void set_dma_addr1(unsigned int dmanr, unsigned int a)
 
 	if (!chan)
 		return;
-	au_writel(a, chan->io + DMA_BUFFER1_START);
+	__raw_writel(a, chan->io + DMA_BUFFER1_START);
 }
 
 
@@ -370,7 +370,7 @@ static inline void set_dma_count0(unsigned int dmanr, unsigned int count)
 	if (!chan)
 		return;
 	count &= DMA_COUNT_MASK;
-	au_writel(count, chan->io + DMA_BUFFER0_COUNT);
+	__raw_writel(count, chan->io + DMA_BUFFER0_COUNT);
 }
 
 /*
@@ -383,7 +383,7 @@ static inline void set_dma_count1(unsigned int dmanr, unsigned int count)
 	if (!chan)
 		return;
 	count &= DMA_COUNT_MASK;
-	au_writel(count, chan->io + DMA_BUFFER1_COUNT);
+	__raw_writel(count, chan->io + DMA_BUFFER1_COUNT);
 }
 
 /*
@@ -396,8 +396,8 @@ static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 	if (!chan)
 		return;
 	count &= DMA_COUNT_MASK;
-	au_writel(count, chan->io + DMA_BUFFER0_COUNT);
-	au_writel(count, chan->io + DMA_BUFFER1_COUNT);
+	__raw_writel(count, chan->io + DMA_BUFFER0_COUNT);
+	__raw_writel(count, chan->io + DMA_BUFFER1_COUNT);
 }
 
 /*
@@ -410,7 +410,7 @@ static inline unsigned int get_dma_buffer_done(unsigned int dmanr)
 
 	if (!chan)
 		return 0;
-	return au_readl(chan->io + DMA_MODE_READ) & (DMA_D0 | DMA_D1);
+	return __raw_readl(chan->io + DMA_MODE_READ) & (DMA_D0 | DMA_D1);
 }
 
 
@@ -437,10 +437,10 @@ static inline int get_dma_residue(unsigned int dmanr)
 	if (!chan)
 		return 0;
 
-	curBufCntReg = (au_readl(chan->io + DMA_MODE_READ) & DMA_AB) ?
+	curBufCntReg = (__raw_readl(chan->io + DMA_MODE_READ) & DMA_AB) ?
 	    DMA_BUFFER1_COUNT : DMA_BUFFER0_COUNT;
 
-	count = au_readl(chan->io + curBufCntReg) & DMA_COUNT_MASK;
+	count = __raw_readl(chan->io + curBufCntReg) & DMA_COUNT_MASK;
 
 	if ((chan->mode & DMA_DW_MASK) == DMA_DW16)
 		count <<= 1;
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 0ea43c0..2988e9d 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -90,7 +90,7 @@ struct au1xmmc_host {
 	struct mmc_request *mrq;
 
 	u32 flags;
-	u32 iobase;
+	void __iomem *iobase;
 	u32 clock;
 	u32 bus_width;
 	u32 power_mode;
@@ -162,32 +162,33 @@ static inline int has_dbdma(void)
 
 static inline void IRQ_ON(struct au1xmmc_host *host, u32 mask)
 {
-	u32 val = au_readl(HOST_CONFIG(host));
+	u32 val = __raw_readl(HOST_CONFIG(host));
 	val |= mask;
-	au_writel(val, HOST_CONFIG(host));
-	au_sync();
+	__raw_writel(val, HOST_CONFIG(host));
+	wmb(); /* drain writebuffer */
 }
 
 static inline void FLUSH_FIFO(struct au1xmmc_host *host)
 {
-	u32 val = au_readl(HOST_CONFIG2(host));
+	u32 val = __raw_readl(HOST_CONFIG2(host));
 
-	au_writel(val | SD_CONFIG2_FF, HOST_CONFIG2(host));
-	au_sync_delay(1);
+	__raw_writel(val | SD_CONFIG2_FF, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
+	mdelay(1);
 
 	/* SEND_STOP will turn off clock control - this re-enables it */
 	val &= ~SD_CONFIG2_DF;
 
-	au_writel(val, HOST_CONFIG2(host));
-	au_sync();
+	__raw_writel(val, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
 }
 
 static inline void IRQ_OFF(struct au1xmmc_host *host, u32 mask)
 {
-	u32 val = au_readl(HOST_CONFIG(host));
+	u32 val = __raw_readl(HOST_CONFIG(host));
 	val &= ~mask;
-	au_writel(val, HOST_CONFIG(host));
-	au_sync();
+	__raw_writel(val, HOST_CONFIG(host));
+	wmb(); /* drain writebuffer */
 }
 
 static inline void SEND_STOP(struct au1xmmc_host *host)
@@ -197,12 +198,13 @@ static inline void SEND_STOP(struct au1xmmc_host *host)
 	WARN_ON(host->status != HOST_S_DATA);
 	host->status = HOST_S_STOP;
 
-	config2 = au_readl(HOST_CONFIG2(host));
-	au_writel(config2 | SD_CONFIG2_DF, HOST_CONFIG2(host));
-	au_sync();
+	config2 = __raw_readl(HOST_CONFIG2(host));
+	__raw_writel(config2 | SD_CONFIG2_DF, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
 
 	/* Send the stop command */
-	au_writel(STOP_CMD, HOST_CMD(host));
+	__raw_writel(STOP_CMD, HOST_CMD(host));
+	wmb(); /* drain writebuffer */
 }
 
 static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
@@ -296,28 +298,28 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
 		}
 	}
 
-	au_writel(cmd->arg, HOST_CMDARG(host));
-	au_sync();
+	__raw_writel(cmd->arg, HOST_CMDARG(host));
+	wmb(); /* drain writebuffer */
 
 	if (wait)
 		IRQ_OFF(host, SD_CONFIG_CR);
 
-	au_writel((mmccmd | SD_CMD_GO), HOST_CMD(host));
-	au_sync();
+	__raw_writel((mmccmd | SD_CMD_GO), HOST_CMD(host));
+	wmb(); /* drain writebuffer */
 
 	/* Wait for the command to go on the line */
-	while (au_readl(HOST_CMD(host)) & SD_CMD_GO)
+	while (__raw_readl(HOST_CMD(host)) & SD_CMD_GO)
 		/* nop */;
 
 	/* Wait for the command to come back */
 	if (wait) {
-		u32 status = au_readl(HOST_STATUS(host));
+		u32 status = __raw_readl(HOST_STATUS(host));
 
 		while (!(status & SD_STATUS_CR))
-			status = au_readl(HOST_STATUS(host));
+			status = __raw_readl(HOST_STATUS(host));
 
 		/* Clear the CR status */
-		au_writel(SD_STATUS_CR, HOST_STATUS(host));
+		__raw_writel(SD_STATUS_CR, HOST_STATUS(host));
 
 		IRQ_ON(host, SD_CONFIG_CR);
 	}
@@ -339,11 +341,11 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 	data = mrq->cmd->data;
 
 	if (status == 0)
-		status = au_readl(HOST_STATUS(host));
+		status = __raw_readl(HOST_STATUS(host));
 
 	/* The transaction is really over when the SD_STATUS_DB bit is clear */
 	while ((host->flags & HOST_F_XMIT) && (status & SD_STATUS_DB))
-		status = au_readl(HOST_STATUS(host));
+		status = __raw_readl(HOST_STATUS(host));
 
 	data->error = 0;
 	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len, host->dma.dir);
@@ -357,7 +359,7 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 		data->error = -EILSEQ;
 
 	/* Clear the CRC bits */
-	au_writel(SD_STATUS_WC | SD_STATUS_RC, HOST_STATUS(host));
+	__raw_writel(SD_STATUS_WC | SD_STATUS_RC, HOST_STATUS(host));
 
 	data->bytes_xfered = 0;
 
@@ -380,7 +382,7 @@ static void au1xmmc_tasklet_data(unsigned long param)
 {
 	struct au1xmmc_host *host = (struct au1xmmc_host *)param;
 
-	u32 status = au_readl(HOST_STATUS(host));
+	u32 status = __raw_readl(HOST_STATUS(host));
 	au1xmmc_data_complete(host, status);
 }
 
@@ -412,15 +414,15 @@ static void au1xmmc_send_pio(struct au1xmmc_host *host)
 		max = AU1XMMC_MAX_TRANSFER;
 
 	for (count = 0; count < max; count++) {
-		status = au_readl(HOST_STATUS(host));
+		status = __raw_readl(HOST_STATUS(host));
 
 		if (!(status & SD_STATUS_TH))
 			break;
 
 		val = *sg_ptr++;
 
-		au_writel((unsigned long)val, HOST_TXPORT(host));
-		au_sync();
+		__raw_writel((unsigned long)val, HOST_TXPORT(host));
+		wmb(); /* drain writebuffer */
 	}
 
 	host->pio.len -= count;
@@ -472,7 +474,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 		max = AU1XMMC_MAX_TRANSFER;
 
 	for (count = 0; count < max; count++) {
-		status = au_readl(HOST_STATUS(host));
+		status = __raw_readl(HOST_STATUS(host));
 
 		if (!(status & SD_STATUS_NE))
 			break;
@@ -494,7 +496,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 			break;
 		}
 
-		val = au_readl(HOST_RXPORT(host));
+		val = __raw_readl(HOST_RXPORT(host));
 
 		if (sg_ptr)
 			*sg_ptr++ = (unsigned char)(val & 0xFF);
@@ -537,10 +539,10 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
-			r[0] = au_readl(host->iobase + SD_RESP3);
-			r[1] = au_readl(host->iobase + SD_RESP2);
-			r[2] = au_readl(host->iobase + SD_RESP1);
-			r[3] = au_readl(host->iobase + SD_RESP0);
+			r[0] = __raw_readl(host->iobase + SD_RESP3);
+			r[1] = __raw_readl(host->iobase + SD_RESP2);
+			r[2] = __raw_readl(host->iobase + SD_RESP1);
+			r[3] = __raw_readl(host->iobase + SD_RESP0);
 
 			/* The CRC is omitted from the response, so really
 			 * we only got 120 bytes, but the engine expects
@@ -559,7 +561,7 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 			 * that means that the OSR data starts at bit 31,
 			 * so we can just read RESP0 and return that.
 			 */
-			cmd->resp[0] = au_readl(host->iobase + SD_RESP0);
+			cmd->resp[0] = __raw_readl(host->iobase + SD_RESP0);
 		}
 	}
 
@@ -586,7 +588,7 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 			u32 mask = SD_STATUS_DB | SD_STATUS_NE;
 
 			while((status & mask) != mask)
-				status = au_readl(HOST_STATUS(host));
+				status = __raw_readl(HOST_STATUS(host));
 		}
 
 		au1xxx_dbdma_start(channel);
@@ -606,13 +608,13 @@ static void au1xmmc_set_clock(struct au1xmmc_host *host, int rate)
 	pbus /= 2;
 	divisor = ((pbus / rate) / 2) - 1;
 
-	config = au_readl(HOST_CONFIG(host));
+	config = __raw_readl(HOST_CONFIG(host));
 
 	config &= ~(SD_CONFIG_DIV);
 	config |= (divisor & SD_CONFIG_DIV) | SD_CONFIG_DE;
 
-	au_writel(config, HOST_CONFIG(host));
-	au_sync();
+	__raw_writel(config, HOST_CONFIG(host));
+	wmb(); /* drain writebuffer */
 }
 
 static int au1xmmc_prepare_data(struct au1xmmc_host *host,
@@ -636,7 +638,7 @@ static int au1xmmc_prepare_data(struct au1xmmc_host *host,
 	if (host->dma.len == 0)
 		return -ETIMEDOUT;
 
-	au_writel(data->blksz - 1, HOST_BLKSIZE(host));
+	__raw_writel(data->blksz - 1, HOST_BLKSIZE(host));
 
 	if (host->flags & (HOST_F_DMA | HOST_F_DBDMA)) {
 		int i;
@@ -723,31 +725,34 @@ static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
 static void au1xmmc_reset_controller(struct au1xmmc_host *host)
 {
 	/* Apply the clock */
-	au_writel(SD_ENABLE_CE, HOST_ENABLE(host));
-        au_sync_delay(1);
+	__raw_writel(SD_ENABLE_CE, HOST_ENABLE(host));
+	wmb(); /* drain writebuffer */
+	mdelay(1);
 
-	au_writel(SD_ENABLE_R | SD_ENABLE_CE, HOST_ENABLE(host));
-	au_sync_delay(5);
+	__raw_writel(SD_ENABLE_R | SD_ENABLE_CE, HOST_ENABLE(host));
+	wmb(); /* drain writebuffer */
+	mdelay(5);
 
-	au_writel(~0, HOST_STATUS(host));
-	au_sync();
+	__raw_writel(~0, HOST_STATUS(host));
+	wmb(); /* drain writebuffer */
 
-	au_writel(0, HOST_BLKSIZE(host));
-	au_writel(0x001fffff, HOST_TIMEOUT(host));
-	au_sync();
+	__raw_writel(0, HOST_BLKSIZE(host));
+	__raw_writel(0x001fffff, HOST_TIMEOUT(host));
+	wmb(); /* drain writebuffer */
 
-	au_writel(SD_CONFIG2_EN, HOST_CONFIG2(host));
-        au_sync();
+	__raw_writel(SD_CONFIG2_EN, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
 
-	au_writel(SD_CONFIG2_EN | SD_CONFIG2_FF, HOST_CONFIG2(host));
-	au_sync_delay(1);
+	__raw_writel(SD_CONFIG2_EN | SD_CONFIG2_FF, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
+	mdelay(1);
 
-	au_writel(SD_CONFIG2_EN, HOST_CONFIG2(host));
-	au_sync();
+	__raw_writel(SD_CONFIG2_EN, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
 
 	/* Configure interrupts */
-	au_writel(AU1XMMC_INTERRUPTS, HOST_CONFIG(host));
-	au_sync();
+	__raw_writel(AU1XMMC_INTERRUPTS, HOST_CONFIG(host));
+	wmb(); /* drain writebuffer */
 }
 
 
@@ -767,7 +772,7 @@ static void au1xmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->clock = ios->clock;
 	}
 
-	config2 = au_readl(HOST_CONFIG2(host));
+	config2 = __raw_readl(HOST_CONFIG2(host));
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_8:
 		config2 |= SD_CONFIG2_BB;
@@ -780,8 +785,8 @@ static void au1xmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		config2 &= ~(SD_CONFIG2_WB | SD_CONFIG2_BB);
 		break;
 	}
-	au_writel(config2, HOST_CONFIG2(host));
-	au_sync();
+	__raw_writel(config2, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
 }
 
 #define STATUS_TIMEOUT (SD_STATUS_RAT | SD_STATUS_DT)
@@ -793,7 +798,7 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 	struct au1xmmc_host *host = dev_id;
 	u32 status;
 
-	status = au_readl(HOST_STATUS(host));
+	status = __raw_readl(HOST_STATUS(host));
 
 	if (!(status & SD_STATUS_I))
 		return IRQ_NONE;	/* not ours */
@@ -839,8 +844,8 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 				status);
 	}
 
-	au_writel(status, HOST_STATUS(host));
-	au_sync();
+	__raw_writel(status, HOST_STATUS(host));
+	wmb(); /* drain writebuffer */
 
 	return IRQ_HANDLED;
 }
@@ -976,7 +981,7 @@ static int au1xmmc_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
-	host->iobase = (unsigned long)ioremap(r->start, 0x3c);
+	host->iobase = ioremap(r->start, 0x3c);
 	if (!host->iobase) {
 		dev_err(&pdev->dev, "cannot remap mmio\n");
 		goto out2;
@@ -1075,7 +1080,7 @@ static int au1xmmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	pr_info(DRIVER_NAME ": MMC Controller %d set up at %8.8X"
+	pr_info(DRIVER_NAME ": MMC Controller %d set up at %p"
 		" (mode=%s)\n", pdev->id, host->iobase,
 		host->flags & HOST_F_DMA ? "dma" : "pio");
 
@@ -1087,10 +1092,10 @@ out6:
 		led_classdev_unregister(host->platdata->led);
 out5:
 #endif
-	au_writel(0, HOST_ENABLE(host));
-	au_writel(0, HOST_CONFIG(host));
-	au_writel(0, HOST_CONFIG2(host));
-	au_sync();
+	__raw_writel(0, HOST_ENABLE(host));
+	__raw_writel(0, HOST_CONFIG(host));
+	__raw_writel(0, HOST_CONFIG2(host));
+	wmb(); /* drain writebuffer */
 
 	if (host->flags & HOST_F_DBDMA)
 		au1xmmc_dbdma_shutdown(host);
@@ -1130,10 +1135,10 @@ static int au1xmmc_remove(struct platform_device *pdev)
 		    !(host->mmc->caps & MMC_CAP_NEEDS_POLL))
 			host->platdata->cd_setup(host->mmc, 0);
 
-		au_writel(0, HOST_ENABLE(host));
-		au_writel(0, HOST_CONFIG(host));
-		au_writel(0, HOST_CONFIG2(host));
-		au_sync();
+		__raw_writel(0, HOST_ENABLE(host));
+		__raw_writel(0, HOST_CONFIG(host));
+		__raw_writel(0, HOST_CONFIG2(host));
+		wmb(); /* drain writebuffer */
 
 		tasklet_kill(&host->data_task);
 		tasklet_kill(&host->finish_task);
@@ -1158,11 +1163,11 @@ static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
-	au_writel(0, HOST_CONFIG2(host));
-	au_writel(0, HOST_CONFIG(host));
-	au_writel(0xffffffff, HOST_STATUS(host));
-	au_writel(0, HOST_ENABLE(host));
-	au_sync();
+	__raw_writel(0, HOST_CONFIG2(host));
+	__raw_writel(0, HOST_CONFIG(host));
+	__raw_writel(0xffffffff, HOST_STATUS(host));
+	__raw_writel(0, HOST_ENABLE(host));
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 6cece6e..77d6c17 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -41,7 +41,7 @@ static u_char au_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd->priv;
 	u_char ret = readb(this->IO_ADDR_R);
-	au_sync();
+	wmb(); /* drain writebuffer */
 	return ret;
 }
 
@@ -56,7 +56,7 @@ static void au_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd->priv;
 	writeb(byte, this->IO_ADDR_W);
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 /**
@@ -69,7 +69,7 @@ static u_char au_read_byte16(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd->priv;
 	u_char ret = (u_char) cpu_to_le16(readw(this->IO_ADDR_R));
-	au_sync();
+	wmb(); /* drain writebuffer */
 	return ret;
 }
 
@@ -84,7 +84,7 @@ static void au_write_byte16(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd->priv;
 	writew(le16_to_cpu((u16) byte), this->IO_ADDR_W);
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 /**
@@ -97,7 +97,7 @@ static u16 au_read_word(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd->priv;
 	u16 ret = readw(this->IO_ADDR_R);
-	au_sync();
+	wmb(); /* drain writebuffer */
 	return ret;
 }
 
@@ -116,7 +116,7 @@ static void au_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
 
 	for (i = 0; i < len; i++) {
 		writeb(buf[i], this->IO_ADDR_W);
-		au_sync();
+		wmb(); /* drain writebuffer */
 	}
 }
 
@@ -135,7 +135,7 @@ static void au_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 
 	for (i = 0; i < len; i++) {
 		buf[i] = readb(this->IO_ADDR_R);
-		au_sync();
+		wmb(); /* drain writebuffer */
 	}
 }
 
@@ -156,7 +156,7 @@ static void au_write_buf16(struct mtd_info *mtd, const u_char *buf, int len)
 
 	for (i = 0; i < len; i++) {
 		writew(p[i], this->IO_ADDR_W);
-		au_sync();
+		wmb(); /* drain writebuffer */
 	}
 
 }
@@ -178,7 +178,7 @@ static void au_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 
 	for (i = 0; i < len; i++) {
 		p[i] = readw(this->IO_ADDR_R);
-		au_sync();
+		wmb(); /* drain writebuffer */
 	}
 }
 
@@ -234,8 +234,7 @@ static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 
 	this->IO_ADDR_R = this->IO_ADDR_W;
 
-	/* Drain the writebuffer */
-	au_sync();
+	wmb(); /* Drain the writebuffer */
 }
 
 int au1550_device_ready(struct mtd_info *mtd)
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index ad8b058..31c48a7 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -270,10 +270,12 @@ static void au1000_enable_mac(struct net_device *dev, int force_reset)
 
 	if (force_reset || (!aup->mac_enabled)) {
 		writel(MAC_EN_CLOCK_ENABLE, aup->enable);
-		au_sync_delay(2);
+		wmb(); /* drain writebuffer */
+		mdelay(2);
 		writel((MAC_EN_RESET0 | MAC_EN_RESET1 | MAC_EN_RESET2
 				| MAC_EN_CLOCK_ENABLE), aup->enable);
-		au_sync_delay(2);
+		wmb(); /* drain writebuffer */
+		mdelay(2);
 
 		aup->mac_enabled = 1;
 	}
@@ -391,7 +393,8 @@ static void au1000_hard_stop(struct net_device *dev)
 	reg = readl(&aup->mac->control);
 	reg &= ~(MAC_RX_ENABLE | MAC_TX_ENABLE);
 	writel(reg, &aup->mac->control);
-	au_sync_delay(10);
+	wmb(); /* drain writebuffer */
+	mdelay(10);
 }
 
 static void au1000_enable_rx_tx(struct net_device *dev)
@@ -404,7 +407,8 @@ static void au1000_enable_rx_tx(struct net_device *dev)
 	reg = readl(&aup->mac->control);
 	reg |= (MAC_RX_ENABLE | MAC_TX_ENABLE);
 	writel(reg, &aup->mac->control);
-	au_sync_delay(10);
+	wmb(); /* drain writebuffer */
+	mdelay(10);
 }
 
 static void
@@ -454,7 +458,8 @@ au1000_adjust_link(struct net_device *dev)
 			reg |= MAC_DISABLE_RX_OWN;
 		}
 		writel(reg, &aup->mac->control);
-		au_sync_delay(1);
+		wmb(); /* drain writebuffer */
+		mdelay(1);
 
 		au1000_enable_rx_tx(dev);
 		aup->old_duplex = phydev->duplex;
@@ -618,9 +623,11 @@ static void au1000_reset_mac_unlocked(struct net_device *dev)
 	au1000_hard_stop(dev);
 
 	writel(MAC_EN_CLOCK_ENABLE, aup->enable);
-	au_sync_delay(2);
+	wmb(); /* drain writebuffer */
+	mdelay(2);
 	writel(0, aup->enable);
-	au_sync_delay(2);
+	wmb(); /* drain writebuffer */
+	mdelay(2);
 
 	aup->tx_full = 0;
 	for (i = 0; i < NUM_RX_DMA; i++) {
@@ -770,7 +777,7 @@ static int au1000_init(struct net_device *dev)
 	for (i = 0; i < NUM_RX_DMA; i++)
 		aup->rx_dma_ring[i]->buff_stat |= RX_DMA_ENABLE;
 
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	control = MAC_RX_ENABLE | MAC_TX_ENABLE;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
@@ -787,7 +794,7 @@ static int au1000_init(struct net_device *dev)
 
 	writel(control, &aup->mac->control);
 	writel(0x8100, &aup->mac->vlan1_tag); /* activate vlan support */
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	spin_unlock_irqrestore(&aup->lock, flags);
 	return 0;
@@ -878,7 +885,7 @@ static int au1000_rx(struct net_device *dev)
 		}
 		prxd->buff_stat = (u32)(pDB->dma_addr | RX_DMA_ENABLE);
 		aup->rx_head = (aup->rx_head + 1) & (NUM_RX_DMA - 1);
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		/* next descriptor */
 		prxd = aup->rx_dma_ring[aup->rx_head];
@@ -926,7 +933,7 @@ static void au1000_tx_ack(struct net_device *dev)
 		au1000_update_tx_stats(dev, ptxd->status);
 		ptxd->buff_stat &= ~TX_T_DONE;
 		ptxd->len = 0;
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		aup->tx_tail = (aup->tx_tail + 1) & (NUM_TX_DMA - 1);
 		ptxd = aup->tx_dma_ring[aup->tx_tail];
@@ -1057,7 +1064,7 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
 	ps->tx_bytes += ptxd->len;
 
 	ptxd->buff_stat = pDB->dma_addr | TX_DMA_ENABLE;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	dev_kfree_skb(skb);
 	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);
 	return NETDEV_TX_OK;
diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 67375a1..ffb42f1 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -141,13 +141,13 @@ static inline void au1550_spi_mask_ack_all(struct au1550_spi *hw)
 		  PSC_SPIMSK_MM | PSC_SPIMSK_RR | PSC_SPIMSK_RO
 		| PSC_SPIMSK_RU | PSC_SPIMSK_TR | PSC_SPIMSK_TO
 		| PSC_SPIMSK_TU | PSC_SPIMSK_SD | PSC_SPIMSK_MD;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	hw->regs->psc_spievent =
 		  PSC_SPIEVNT_MM | PSC_SPIEVNT_RR | PSC_SPIEVNT_RO
 		| PSC_SPIEVNT_RU | PSC_SPIEVNT_TR | PSC_SPIEVNT_TO
 		| PSC_SPIEVNT_TU | PSC_SPIEVNT_SD | PSC_SPIEVNT_MD;
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 static void au1550_spi_reset_fifos(struct au1550_spi *hw)
@@ -155,10 +155,10 @@ static void au1550_spi_reset_fifos(struct au1550_spi *hw)
 	u32 pcr;
 
 	hw->regs->psc_spipcr = PSC_SPIPCR_RC | PSC_SPIPCR_TC;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	do {
 		pcr = hw->regs->psc_spipcr;
-		au_sync();
+		wmb(); /* drain writebuffer */
 	} while (pcr != 0);
 }
 
@@ -188,9 +188,9 @@ static void au1550_spi_chipsel(struct spi_device *spi, int value)
 		au1550_spi_bits_handlers_set(hw, spi->bits_per_word);
 
 		cfg = hw->regs->psc_spicfg;
-		au_sync();
+		wmb(); /* drain writebuffer */
 		hw->regs->psc_spicfg = cfg & ~PSC_SPICFG_DE_ENABLE;
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		if (spi->mode & SPI_CPOL)
 			cfg |= PSC_SPICFG_BI;
@@ -218,10 +218,10 @@ static void au1550_spi_chipsel(struct spi_device *spi, int value)
 		cfg |= au1550_spi_baudcfg(hw, spi->max_speed_hz);
 
 		hw->regs->psc_spicfg = cfg | PSC_SPICFG_DE_ENABLE;
-		au_sync();
+		wmb(); /* drain writebuffer */
 		do {
 			stat = hw->regs->psc_spistat;
-			au_sync();
+			wmb(); /* drain writebuffer */
 		} while ((stat & PSC_SPISTAT_DR) == 0);
 
 		if (hw->pdata->activate_cs)
@@ -252,9 +252,9 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	au1550_spi_bits_handlers_set(hw, spi->bits_per_word);
 
 	cfg = hw->regs->psc_spicfg;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	hw->regs->psc_spicfg = cfg & ~PSC_SPICFG_DE_ENABLE;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	if (hw->usedma && bpw <= 8)
 		cfg &= ~PSC_SPICFG_DD_DISABLE;
@@ -268,12 +268,12 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	cfg |= au1550_spi_baudcfg(hw, hz);
 
 	hw->regs->psc_spicfg = cfg;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	if (cfg & PSC_SPICFG_DE_ENABLE) {
 		do {
 			stat = hw->regs->psc_spistat;
-			au_sync();
+			wmb(); /* drain writebuffer */
 		} while ((stat & PSC_SPISTAT_DR) == 0);
 	}
 
@@ -396,11 +396,11 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 
 	/* by default enable nearly all events interrupt */
 	hw->regs->psc_spimsk = PSC_SPIMSK_SD;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	/* start the transfer */
 	hw->regs->psc_spipcr = PSC_SPIPCR_MS;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	wait_for_completion(&hw->master_done);
 
@@ -429,7 +429,7 @@ static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
 
 	stat = hw->regs->psc_spistat;
 	evnt = hw->regs->psc_spievent;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	if ((stat & PSC_SPISTAT_DI) == 0) {
 		dev_err(hw->dev, "Unexpected IRQ!\n");
 		return IRQ_NONE;
@@ -484,7 +484,7 @@ static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
 static void au1550_spi_rx_word_##size(struct au1550_spi *hw)		\
 {									\
 	u32 fifoword = hw->regs->psc_spitxrx & (u32)(mask);		\
-	au_sync();							\
+	wmb(); /* drain writebuffer */					\
 	if (hw->rx) {							\
 		*(u##size *)hw->rx = (u##size)fifoword;			\
 		hw->rx += (size) / 8;					\
@@ -504,7 +504,7 @@ static void au1550_spi_tx_word_##size(struct au1550_spi *hw)		\
 	if (hw->tx_count >= hw->len)					\
 		fifoword |= PSC_SPITXRX_LC;				\
 	hw->regs->psc_spitxrx = fifoword;				\
-	au_sync();							\
+	wmb(); /* drain writebuffer */					\
 }
 
 AU1550_SPI_RX_WORD(8,0xff)
@@ -539,18 +539,18 @@ static int au1550_spi_pio_txrxb(struct spi_device *spi, struct spi_transfer *t)
 		}
 
 		stat = hw->regs->psc_spistat;
-		au_sync();
+		wmb(); /* drain writebuffer */
 		if (stat & PSC_SPISTAT_TF)
 			break;
 	}
 
 	/* enable event interrupts */
 	hw->regs->psc_spimsk = mask;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	/* start the transfer */
 	hw->regs->psc_spipcr = PSC_SPIPCR_MS;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	wait_for_completion(&hw->master_done);
 
@@ -564,7 +564,7 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 
 	stat = hw->regs->psc_spistat;
 	evnt = hw->regs->psc_spievent;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	if ((stat & PSC_SPISTAT_DI) == 0) {
 		dev_err(hw->dev, "Unexpected IRQ!\n");
 		return IRQ_NONE;
@@ -594,7 +594,7 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 	do {
 		busy = 0;
 		stat = hw->regs->psc_spistat;
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		/*
 		 * Take care to not let the Rx FIFO overflow.
@@ -615,7 +615,7 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 	} while (busy);
 
 	hw->regs->psc_spievent = PSC_SPIEVNT_RR | PSC_SPIEVNT_TR;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	/*
 	 * Restart the SPI transmission in case of a transmit underflow.
@@ -634,9 +634,9 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 	 */
 	if (evnt & PSC_SPIEVNT_TU) {
 		hw->regs->psc_spievent = PSC_SPIEVNT_TU | PSC_SPIEVNT_MD;
-		au_sync();
+		wmb(); /* drain writebuffer */
 		hw->regs->psc_spipcr = PSC_SPIPCR_MS;
-		au_sync();
+		wmb(); /* drain writebuffer */
 	}
 
 	if (hw->rx_count >= hw->len) {
@@ -690,19 +690,19 @@ static void au1550_spi_setup_psc_as_spi(struct au1550_spi *hw)
 
 	/* set up the PSC for SPI mode */
 	hw->regs->psc_ctrl = PSC_CTRL_DISABLE;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	hw->regs->psc_sel = PSC_SEL_PS_SPIMODE;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	hw->regs->psc_spicfg = 0;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	hw->regs->psc_ctrl = PSC_CTRL_ENABLE;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	do {
 		stat = hw->regs->psc_spistat;
-		au_sync();
+		wmb(); /* drain writebuffer */
 	} while ((stat & PSC_SPISTAT_SR) == 0);
 
 
@@ -717,16 +717,16 @@ static void au1550_spi_setup_psc_as_spi(struct au1550_spi *hw)
 #endif
 
 	hw->regs->psc_spicfg = cfg;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	au1550_spi_mask_ack_all(hw);
 
 	hw->regs->psc_spicfg |= PSC_SPICFG_DE_ENABLE;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	do {
 		stat = hw->regs->psc_spistat;
-		au_sync();
+		wmb(); /* drain writebuffer */
 	} while ((stat & PSC_SPISTAT_DR) == 0);
 
 	au1550_spi_reset_fifos(hw);
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index c0832ea..c163424 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -113,7 +113,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 	case VESA_NO_BLANKING:
 		/* Turn on panel */
 		fbdev->regs->lcd_control |= LCD_CONTROL_GO;
-		au_sync();
+		wmb(); /* drain writebuffer */
 		break;
 
 	case VESA_VSYNC_SUSPEND:
@@ -121,7 +121,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 	case VESA_POWERDOWN:
 		/* Turn off panel */
 		fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
-		au_sync();
+		wmb(); /* drain writebuffer */
 		break;
 	default:
 		break;
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 2d77334..1c8e106 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -764,7 +764,7 @@ static int au1200_setlocation (struct au1200fb_device *fbdev, int plane,
 
 	/* Disable the window while making changes, then restore WINEN */
 	winenable = lcd->winenable & (1 << plane);
-	au_sync();
+	wmb(); /* drain writebuffer */
 	lcd->winenable &= ~(1 << plane);
 	lcd->window[plane].winctrl0 = winctrl0;
 	lcd->window[plane].winctrl1 = winctrl1;
@@ -772,7 +772,7 @@ static int au1200_setlocation (struct au1200fb_device *fbdev, int plane,
 	lcd->window[plane].winbuf1 = fbdev->fb_phys;
 	lcd->window[plane].winbufctrl = 0; /* select winbuf0 */
 	lcd->winenable |= winenable;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
@@ -788,22 +788,21 @@ static void au1200_setpanel(struct panel_settings *newpanel,
 	/* Make sure all windows disabled */
 	winenable = lcd->winenable;
 	lcd->winenable = 0;
-	au_sync();
+	wmb(); /* drain writebuffer */
 	/*
 	 * Ensure everything is disabled before reconfiguring
 	 */
 	if (lcd->screen & LCD_SCREEN_SEN) {
 		/* Wait for vertical sync period */
 		lcd->intstatus = LCD_INT_SS;
-		while ((lcd->intstatus & LCD_INT_SS) == 0) {
-			au_sync();
-		}
+		while ((lcd->intstatus & LCD_INT_SS) == 0)
+			;
 
 		lcd->screen &= ~LCD_SCREEN_SEN;	/*disable the controller*/
 
 		do {
 			lcd->intstatus = lcd->intstatus; /*clear interrupts*/
-			au_sync();
+			wmb(); /* drain writebuffer */
 		/*wait for controller to shut down*/
 		} while ((lcd->intstatus & LCD_INT_SD) == 0);
 
@@ -847,7 +846,7 @@ static void au1200_setpanel(struct panel_settings *newpanel,
 	lcd->pwmhi = panel->mode_pwmhi;
 	lcd->outmask = panel->mode_outmask;
 	lcd->fifoctrl = panel->mode_fifoctrl;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	/* fixme: Check window settings to make sure still valid
 	 * for new geometry */
@@ -863,7 +862,7 @@ static void au1200_setpanel(struct panel_settings *newpanel,
 	 * Re-enable screen now that it is configured
 	 */
 	lcd->screen |= LCD_SCREEN_SEN;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	/* Call init of panel */
 	if (pd->panel_init)
@@ -956,7 +955,7 @@ static void au1200_setmode(struct au1200fb_device *fbdev)
 		| LCD_WINCTRL2_SCY_1
 		) ;
 	lcd->winenable |= win->w[plane].mode_winenable;
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 
@@ -1270,7 +1269,7 @@ static void set_global(u_int cmd, struct au1200_lcd_global_regs_t *pdata)
 
 	if (pdata->flags & SCREEN_MASK)
 		lcd->colorkeymsk = pdata->mask;
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 static void get_global(u_int cmd, struct au1200_lcd_global_regs_t *pdata)
@@ -1288,7 +1287,7 @@ static void get_global(u_int cmd, struct au1200_lcd_global_regs_t *pdata)
 	hi1 = (lcd->pwmhi >> 16) + 1;
 	divider = (lcd->pwmdiv & 0x3FFFF) + 1;
 	pdata->brightness = ((hi1 << 8) / divider) - 1;
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 static void set_window(unsigned int plane,
@@ -1387,7 +1386,7 @@ static void set_window(unsigned int plane,
 		val |= (pdata->enable & 1) << plane;
 		lcd->winenable = val;
 	}
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 static void get_window(unsigned int plane,
@@ -1414,7 +1413,7 @@ static void get_window(unsigned int plane,
 	pdata->ram_array_mode = (lcd->window[plane].winctrl2 & LCD_WINCTRL2_RAM) >> 21;
 
 	pdata->enable = (lcd->winenable >> plane) & 1;
-	au_sync();
+	wmb(); /* drain writebuffer */
 }
 
 static int au1200fb_ioctl(struct fb_info *info, unsigned int cmd,
@@ -1511,7 +1510,7 @@ static irqreturn_t au1200fb_handle_irq(int irq, void* dev_id)
 {
 	/* Nothing to do for now, just clear any pending interrupt */
 	lcd->intstatus = lcd->intstatus;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	return IRQ_HANDLED;
 }
@@ -1809,7 +1808,7 @@ static int au1200fb_drv_suspend(struct device *dev)
 	au1200_setpanel(NULL, pd);
 
 	lcd->outmask = 0;
-	au_sync();
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 986dcec..84f31e1 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -79,28 +79,28 @@ static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 	unsigned short retry, tmo;
 	unsigned long data;
 
-	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
-	au_sync();
+	__raw_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
+	wmb(); /* drain writebuffer */
 
 	retry = AC97_RW_RETRIES;
 	do {
 		mutex_lock(&pscdata->lock);
 
-		au_writel(PSC_AC97CDC_RD | PSC_AC97CDC_INDX(reg),
+		__raw_writel(PSC_AC97CDC_RD | PSC_AC97CDC_INDX(reg),
 			  AC97_CDC(pscdata));
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		tmo = 20;
 		do {
 			udelay(21);
-			if (au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)
+			if (__raw_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)
 				break;
 		} while (--tmo);
 
-		data = au_readl(AC97_CDC(pscdata));
+		data = __raw_readl(AC97_CDC(pscdata));
 
-		au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
-		au_sync();
+		__raw_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
+		wmb(); /* drain writebuffer */
 
 		mutex_unlock(&pscdata->lock);
 
@@ -119,26 +119,26 @@ static void au1xpsc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	struct au1xpsc_audio_data *pscdata = ac97_to_pscdata(ac97);
 	unsigned int tmo, retry;
 
-	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
-	au_sync();
+	__raw_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
+	wmb(); /* drain writebuffer */
 
 	retry = AC97_RW_RETRIES;
 	do {
 		mutex_lock(&pscdata->lock);
 
-		au_writel(PSC_AC97CDC_INDX(reg) | (val & 0xffff),
+		__raw_writel(PSC_AC97CDC_INDX(reg) | (val & 0xffff),
 			  AC97_CDC(pscdata));
-		au_sync();
+		wmb(); /* drain writebuffer */
 
 		tmo = 20;
 		do {
 			udelay(21);
-			if (au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)
+			if (__raw_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)
 				break;
 		} while (--tmo);
 
-		au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
-		au_sync();
+		__raw_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
+		wmb(); /* drain writebuffer */
 
 		mutex_unlock(&pscdata->lock);
 	} while (--retry && !tmo);
@@ -149,11 +149,11 @@ static void au1xpsc_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	struct au1xpsc_audio_data *pscdata = ac97_to_pscdata(ac97);
 
-	au_writel(PSC_AC97RST_SNC, AC97_RST(pscdata));
-	au_sync();
+	__raw_writel(PSC_AC97RST_SNC, AC97_RST(pscdata));
+	wmb(); /* drain writebuffer */
 	msleep(10);
-	au_writel(0, AC97_RST(pscdata));
-	au_sync();
+	__raw_writel(0, AC97_RST(pscdata));
+	wmb(); /* drain writebuffer */
 }
 
 static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
@@ -162,25 +162,25 @@ static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 	int i;
 
 	/* disable PSC during cold reset */
-	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
-	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(pscdata));
-	au_sync();
+	__raw_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* issue cold reset */
-	au_writel(PSC_AC97RST_RST, AC97_RST(pscdata));
-	au_sync();
+	__raw_writel(PSC_AC97RST_RST, AC97_RST(pscdata));
+	wmb(); /* drain writebuffer */
 	msleep(500);
-	au_writel(0, AC97_RST(pscdata));
-	au_sync();
+	__raw_writel(0, AC97_RST(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* enable PSC */
-	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(pscdata));
-	au_sync();
+	__raw_writel(PSC_CTRL_ENABLE, PSC_CTRL(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* wait for PSC to indicate it's ready */
 	i = 1000;
-	while (!((au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_SR)) && (--i))
+	while (!((__raw_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_SR)) && (--i))
 		msleep(1);
 
 	if (i == 0) {
@@ -189,12 +189,12 @@ static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 	}
 
 	/* enable the ac97 function */
-	au_writel(pscdata->cfg | PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
-	au_sync();
+	__raw_writel(pscdata->cfg | PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* wait for AC97 core to become ready */
 	i = 1000;
-	while (!((au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)) && (--i))
+	while (!((__raw_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)) && (--i))
 		msleep(1);
 	if (i == 0)
 		printk(KERN_ERR "au1xpsc-ac97: AC97 ctrl not ready\n");
@@ -218,8 +218,8 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 
 	chans = params_channels(params);
 
-	r = ro = au_readl(AC97_CFG(pscdata));
-	stat = au_readl(AC97_STAT(pscdata));
+	r = ro = __raw_readl(AC97_CFG(pscdata));
+	stat = __raw_readl(AC97_STAT(pscdata));
 
 	/* already active? */
 	if (stat & (PSC_AC97STAT_TB | PSC_AC97STAT_RB)) {
@@ -252,28 +252,28 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 		mutex_lock(&pscdata->lock);
 
 		/* disable AC97 device controller first... */
-		au_writel(r & ~PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
-		au_sync();
+		__raw_writel(r & ~PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
+		wmb(); /* drain writebuffer */
 
 		/* ...wait for it... */
 		t = 100;
-		while ((au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR) && --t)
+		while ((__raw_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR) && --t)
 			msleep(1);
 
 		if (!t)
 			printk(KERN_ERR "PSC-AC97: can't disable!\n");
 
 		/* ...write config... */
-		au_writel(r, AC97_CFG(pscdata));
-		au_sync();
+		__raw_writel(r, AC97_CFG(pscdata));
+		wmb(); /* drain writebuffer */
 
 		/* ...enable the AC97 controller again... */
-		au_writel(r | PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
-		au_sync();
+		__raw_writel(r | PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
+		wmb(); /* drain writebuffer */
 
 		/* ...and wait for ready bit */
 		t = 100;
-		while ((!(au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)) && --t)
+		while ((!(__raw_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)) && --t)
 			msleep(1);
 
 		if (!t)
@@ -300,21 +300,21 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		au_writel(AC97PCR_CLRFIFO(stype), AC97_PCR(pscdata));
-		au_sync();
-		au_writel(AC97PCR_START(stype), AC97_PCR(pscdata));
-		au_sync();
+		__raw_writel(AC97PCR_CLRFIFO(stype), AC97_PCR(pscdata));
+		wmb(); /* drain writebuffer */
+		__raw_writel(AC97PCR_START(stype), AC97_PCR(pscdata));
+		wmb(); /* drain writebuffer */
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		au_writel(AC97PCR_STOP(stype), AC97_PCR(pscdata));
-		au_sync();
+		__raw_writel(AC97PCR_STOP(stype), AC97_PCR(pscdata));
+		wmb(); /* drain writebuffer */
 
-		while (au_readl(AC97_STAT(pscdata)) & AC97STAT_BUSY(stype))
+		while (__raw_readl(AC97_STAT(pscdata)) & AC97STAT_BUSY(stype))
 			asm volatile ("nop");
 
-		au_writel(AC97PCR_CLRFIFO(stype), AC97_PCR(pscdata));
-		au_sync();
+		__raw_writel(AC97PCR_CLRFIFO(stype), AC97_PCR(pscdata));
+		wmb(); /* drain writebuffer */
 
 		break;
 	default:
@@ -398,13 +398,13 @@ static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 		  PSC_AC97CFG_DE_ENABLE;
 
 	/* preserve PSC clock source set up by platform	 */
-	sel = au_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
-	au_writel(0, PSC_SEL(wd));
-	au_sync();
-	au_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(wd));
-	au_sync();
+	sel = __raw_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(0, PSC_SEL(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(wd));
+	wmb(); /* drain writebuffer */
 
 	/* name the DAI like this device instance ("au1xpsc-ac97.PSCINDEX") */
 	memcpy(&wd->dai_drv, &au1xpsc_ac97_dai_template,
@@ -433,10 +433,10 @@ static int au1xpsc_ac97_drvremove(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 
 	/* disable PSC completely */
-	au_writel(0, AC97_CFG(wd));
-	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
+	__raw_writel(0, AC97_CFG(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
 
 	au1xpsc_ac97_workdata = NULL;	/* MDEV */
 
@@ -449,12 +449,12 @@ static int au1xpsc_ac97_drvsuspend(struct device *dev)
 	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
 
 	/* save interesting registers and disable PSC */
-	wd->pm[0] = au_readl(PSC_SEL(wd));
+	wd->pm[0] = __raw_readl(PSC_SEL(wd));
 
-	au_writel(0, AC97_CFG(wd));
-	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
+	__raw_writel(0, AC97_CFG(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
@@ -464,8 +464,8 @@ static int au1xpsc_ac97_drvresume(struct device *dev)
 	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
 
 	/* restore PSC clock config */
-	au_writel(wd->pm[0] | PSC_SEL_PS_AC97MODE, PSC_SEL(wd));
-	au_sync();
+	__raw_writel(wd->pm[0] | PSC_SEL_PS_AC97MODE, PSC_SEL(wd));
+	wmb(); /* drain writebuffer */
 
 	/* after this point the ac97 core will cold-reset the codec.
 	 * During cold-reset the PSC is reinitialized and the last
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index fe923a7..814beff 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -120,10 +120,10 @@ static int au1xpsc_i2s_hw_params(struct snd_pcm_substream *substream,
 	unsigned long stat;
 
 	/* check if the PSC is already streaming data */
-	stat = au_readl(I2S_STAT(pscdata));
+	stat = __raw_readl(I2S_STAT(pscdata));
 	if (stat & (PSC_I2SSTAT_TB | PSC_I2SSTAT_RB)) {
 		/* reject parameters not currently set up in hardware */
-		cfgbits = au_readl(I2S_CFG(pscdata));
+		cfgbits = __raw_readl(I2S_CFG(pscdata));
 		if ((PSC_I2SCFG_GET_LEN(cfgbits) != params->msbits) ||
 		    (params_rate(params) != pscdata->rate))
 			return -EINVAL;
@@ -149,33 +149,33 @@ static int au1xpsc_i2s_configure(struct au1xpsc_audio_data *pscdata)
 	unsigned long tmo;
 
 	/* bring PSC out of sleep, and configure I2S unit */
-	au_writel(PSC_CTRL_ENABLE, PSC_CTRL(pscdata));
-	au_sync();
+	__raw_writel(PSC_CTRL_ENABLE, PSC_CTRL(pscdata));
+	wmb(); /* drain writebuffer */
 
 	tmo = 1000000;
-	while (!(au_readl(I2S_STAT(pscdata)) & PSC_I2SSTAT_SR) && tmo)
+	while (!(__raw_readl(I2S_STAT(pscdata)) & PSC_I2SSTAT_SR) && tmo)
 		tmo--;
 
 	if (!tmo)
 		goto psc_err;
 
-	au_writel(0, I2S_CFG(pscdata));
-	au_sync();
-	au_writel(pscdata->cfg | PSC_I2SCFG_DE_ENABLE, I2S_CFG(pscdata));
-	au_sync();
+	__raw_writel(0, I2S_CFG(pscdata));
+	wmb(); /* drain writebuffer */
+	__raw_writel(pscdata->cfg | PSC_I2SCFG_DE_ENABLE, I2S_CFG(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* wait for I2S controller to become ready */
 	tmo = 1000000;
-	while (!(au_readl(I2S_STAT(pscdata)) & PSC_I2SSTAT_DR) && tmo)
+	while (!(__raw_readl(I2S_STAT(pscdata)) & PSC_I2SSTAT_DR) && tmo)
 		tmo--;
 
 	if (tmo)
 		return 0;
 
 psc_err:
-	au_writel(0, I2S_CFG(pscdata));
-	au_writel(PSC_CTRL_SUSPEND, PSC_CTRL(pscdata));
-	au_sync();
+	__raw_writel(0, I2S_CFG(pscdata));
+	__raw_writel(PSC_CTRL_SUSPEND, PSC_CTRL(pscdata));
+	wmb(); /* drain writebuffer */
 	return -ETIMEDOUT;
 }
 
@@ -187,26 +187,26 @@ static int au1xpsc_i2s_start(struct au1xpsc_audio_data *pscdata, int stype)
 	ret = 0;
 
 	/* if both TX and RX are idle, configure the PSC  */
-	stat = au_readl(I2S_STAT(pscdata));
+	stat = __raw_readl(I2S_STAT(pscdata));
 	if (!(stat & (PSC_I2SSTAT_TB | PSC_I2SSTAT_RB))) {
 		ret = au1xpsc_i2s_configure(pscdata);
 		if (ret)
 			goto out;
 	}
 
-	au_writel(I2SPCR_CLRFIFO(stype), I2S_PCR(pscdata));
-	au_sync();
-	au_writel(I2SPCR_START(stype), I2S_PCR(pscdata));
-	au_sync();
+	__raw_writel(I2SPCR_CLRFIFO(stype), I2S_PCR(pscdata));
+	wmb(); /* drain writebuffer */
+	__raw_writel(I2SPCR_START(stype), I2S_PCR(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* wait for start confirmation */
 	tmo = 1000000;
-	while (!(au_readl(I2S_STAT(pscdata)) & I2SSTAT_BUSY(stype)) && tmo)
+	while (!(__raw_readl(I2S_STAT(pscdata)) & I2SSTAT_BUSY(stype)) && tmo)
 		tmo--;
 
 	if (!tmo) {
-		au_writel(I2SPCR_STOP(stype), I2S_PCR(pscdata));
-		au_sync();
+		__raw_writel(I2SPCR_STOP(stype), I2S_PCR(pscdata));
+		wmb(); /* drain writebuffer */
 		ret = -ETIMEDOUT;
 	}
 out:
@@ -217,21 +217,21 @@ static int au1xpsc_i2s_stop(struct au1xpsc_audio_data *pscdata, int stype)
 {
 	unsigned long tmo, stat;
 
-	au_writel(I2SPCR_STOP(stype), I2S_PCR(pscdata));
-	au_sync();
+	__raw_writel(I2SPCR_STOP(stype), I2S_PCR(pscdata));
+	wmb(); /* drain writebuffer */
 
 	/* wait for stop confirmation */
 	tmo = 1000000;
-	while ((au_readl(I2S_STAT(pscdata)) & I2SSTAT_BUSY(stype)) && tmo)
+	while ((__raw_readl(I2S_STAT(pscdata)) & I2SSTAT_BUSY(stype)) && tmo)
 		tmo--;
 
 	/* if both TX and RX are idle, disable PSC */
-	stat = au_readl(I2S_STAT(pscdata));
+	stat = __raw_readl(I2S_STAT(pscdata));
 	if (!(stat & (PSC_I2SSTAT_TB | PSC_I2SSTAT_RB))) {
-		au_writel(0, I2S_CFG(pscdata));
-		au_sync();
-		au_writel(PSC_CTRL_SUSPEND, PSC_CTRL(pscdata));
-		au_sync();
+		__raw_writel(0, I2S_CFG(pscdata));
+		wmb(); /* drain writebuffer */
+		__raw_writel(PSC_CTRL_SUSPEND, PSC_CTRL(pscdata));
+		wmb(); /* drain writebuffer */
 	}
 	return 0;
 }
@@ -332,12 +332,12 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 	/* preserve PSC clock source set up by platform (dev.platform_data
 	 * is already occupied by soc layer)
 	 */
-	sel = au_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
-	au_writel(PSC_SEL_PS_I2SMODE | sel, PSC_SEL(wd));
-	au_writel(0, I2S_CFG(wd));
-	au_sync();
+	sel = __raw_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_SEL_PS_I2SMODE | sel, PSC_SEL(wd));
+	__raw_writel(0, I2S_CFG(wd));
+	wmb(); /* drain writebuffer */
 
 	/* preconfigure: set max rx/tx fifo depths */
 	wd->cfg |= PSC_I2SCFG_RT_FIFO8 | PSC_I2SCFG_TT_FIFO8;
@@ -364,10 +364,10 @@ static int au1xpsc_i2s_drvremove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 
-	au_writel(0, I2S_CFG(wd));
-	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
+	__raw_writel(0, I2S_CFG(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
@@ -378,12 +378,12 @@ static int au1xpsc_i2s_drvsuspend(struct device *dev)
 	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
 
 	/* save interesting register and disable PSC */
-	wd->pm[0] = au_readl(PSC_SEL(wd));
+	wd->pm[0] = __raw_readl(PSC_SEL(wd));
 
-	au_writel(0, I2S_CFG(wd));
-	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
+	__raw_writel(0, I2S_CFG(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
@@ -393,12 +393,12 @@ static int au1xpsc_i2s_drvresume(struct device *dev)
 	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
 
 	/* select I2S mode and PSC clock */
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-	au_sync();
-	au_writel(0, PSC_SEL(wd));
-	au_sync();
-	au_writel(wd->pm[0], PSC_SEL(wd));
-	au_sync();
+	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(0, PSC_SEL(wd));
+	wmb(); /* drain writebuffer */
+	__raw_writel(wd->pm[0], PSC_SEL(wd));
+	wmb(); /* drain writebuffer */
 
 	return 0;
 }
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index b16b2e0..74dffeb 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -27,16 +27,16 @@ struct au1xpsc_audio_data {
 };
 
 /* easy access macros */
-#define PSC_CTRL(x)	((unsigned long)((x)->mmio) + PSC_CTRL_OFFSET)
-#define PSC_SEL(x)	((unsigned long)((x)->mmio) + PSC_SEL_OFFSET)
-#define I2S_STAT(x)	((unsigned long)((x)->mmio) + PSC_I2SSTAT_OFFSET)
-#define I2S_CFG(x)	((unsigned long)((x)->mmio) + PSC_I2SCFG_OFFSET)
-#define I2S_PCR(x)	((unsigned long)((x)->mmio) + PSC_I2SPCR_OFFSET)
-#define AC97_CFG(x)	((unsigned long)((x)->mmio) + PSC_AC97CFG_OFFSET)
-#define AC97_CDC(x)	((unsigned long)((x)->mmio) + PSC_AC97CDC_OFFSET)
-#define AC97_EVNT(x)	((unsigned long)((x)->mmio) + PSC_AC97EVNT_OFFSET)
-#define AC97_PCR(x)	((unsigned long)((x)->mmio) + PSC_AC97PCR_OFFSET)
-#define AC97_RST(x)	((unsigned long)((x)->mmio) + PSC_AC97RST_OFFSET)
-#define AC97_STAT(x)	((unsigned long)((x)->mmio) + PSC_AC97STAT_OFFSET)
+#define PSC_CTRL(x)	((x)->mmio + PSC_CTRL_OFFSET)
+#define PSC_SEL(x)	((x)->mmio + PSC_SEL_OFFSET)
+#define I2S_STAT(x)	((x)->mmio + PSC_I2SSTAT_OFFSET)
+#define I2S_CFG(x)	((x)->mmio + PSC_I2SCFG_OFFSET)
+#define I2S_PCR(x)	((x)->mmio + PSC_I2SPCR_OFFSET)
+#define AC97_CFG(x)	((x)->mmio + PSC_AC97CFG_OFFSET)
+#define AC97_CDC(x)	((x)->mmio + PSC_AC97CDC_OFFSET)
+#define AC97_EVNT(x)	((x)->mmio + PSC_AC97EVNT_OFFSET)
+#define AC97_PCR(x)	((x)->mmio + PSC_AC97PCR_OFFSET)
+#define AC97_RST(x)	((x)->mmio + PSC_AC97RST_OFFSET)
+#define AC97_STAT(x)	((x)->mmio + PSC_AC97STAT_OFFSET)
 
 #endif
-- 
2.0.1
