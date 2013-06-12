Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jun 2013 21:53:24 +0200 (CEST)
Received: from mail-we0-f180.google.com ([74.125.82.180]:36291 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825883Ab3FLTxRtj0eS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Jun 2013 21:53:17 +0200
Received: by mail-we0-f180.google.com with SMTP id w56so7359816wes.11
        for <multiple recipients>; Wed, 12 Jun 2013 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=SVHkmT+Lq+TYN3mFMNM3yNeYWmpnYMTgDPK+N6gTAJM=;
        b=GyePG1pyXH9+FIxA7VzUZD4V5jYFpn585cd+zbmr8QP1suxUr5q+mwrKdqpXVEVzco
         DBR7WQpDTedX7XGGjm68v/+dH12vjmiQTYd3VIadEGFeobZ3mxNodqtj9zZ/uJlZ6GLb
         xiMczX/Jttv7GSkqJ4Tiin4diXxZOszZ3+WIRcvL7Hcc2ipVcbXoSaEMA4S3h/iMgTGE
         3UebjJxnbgZQ8aMYCGhdK3UTxa5PI8oyjb/hScv/lfLh1EWvqFXIIBT0hoYO/R8HoNE2
         y5YOi54S0xWPeuNWF2evJjKNmJZuEPxZXos8k+45AH8LsduOtdEsjK+TvV0XHsrgzbwg
         vtbw==
X-Received: by 10.194.91.194 with SMTP id cg2mr11388419wjb.53.1371066792449;
        Wed, 12 Jun 2013 12:53:12 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id fo10sm9531835wib.8.2013.06.12.12.53.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 12:53:11 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org, blogic@openwrt.org,
        linux-mips@linux-mips.org, mbizon@freebox.fr, jogo@openwrt.org,
        cernekee@gmail.com, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345 Ethernet
Date:   Wed, 12 Jun 2013 20:53:05 +0100
Message-Id: <1371066785-17168-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

This patch adds support for the Broadcom BCM6345 SoC Ethernet. BCM6345
has a slightly different and older DMA engine which requires the
following modifications:

- the width of the DMA channels on BCM6345 is 64 bytes vs 16 bytes,
  which means that the helpers enet_dma{c,s} need to account for this
  channel width and we can no longer use macros

- BCM6345 DMA engine does not have any internal SRAM for transfering
  buffers

- BCM6345 buffer allocation and flow control is not per-channel but
  global (done in RSET_ENETDMA)

- the DMA engine bits are right-shifted by 3 compared to other DMA
  generations

- the DMA enable/interrupt masks are a little different (we need to
  enabled more bits for 6345)

- some register have the same meaning but are offsetted in the ENET_DMAC
  space so a lookup table is required to return the proper offset

The MAC itself is identical and requires no modifications to work.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf, David,

Once again there are MIPS bits that required some changes, but the major
changes are in bcm63xx_enet.c so it would make sense to get them merged
via David's net-next tree.

Thank you!

 arch/mips/bcm63xx/dev-enet.c                       |   65 ++++++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |    3 +-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    |   94 +++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   43 ++++-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |  200 ++++++++++++--------
 drivers/net/ethernet/broadcom/bcm63xx_enet.h       |   15 ++
 6 files changed, 329 insertions(+), 91 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 6cbaee0..52bc01d 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -9,10 +9,44 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/export.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
+#ifdef BCMCPU_RUNTIME_DETECT
+static const unsigned long bcm6348_regs_enetdmac[] = {
+	[ENETDMAC_CHANCFG]	= ENETDMAC_CHANCFG_REG,
+	[ENETDMAC_IR]		= ENETDMAC_IR_REG,
+	[ENETDMAC_IRMASK]	= ENETDMAC_IRMASK_REG,
+	[ENETDMAC_MAXBURST]	= ENETDMAC_MAXBURST_REG,
+};
+
+static const unsigned long bcm6345_regs_enetdmac[] = {
+	[ENETDMAC_CHANCFG]	= ENETDMA_6345_CHANCFG_REG,
+	[ENETDMAC_IR]		= ENETDMA_6345_IR_REG,
+	[ENETDMAC_IRMASK]	= ENETDMA_6345_IRMASK_REG,
+	[ENETDMAC_MAXBURST]	= ENETDMA_6345_MAXBURST_REG,
+	[ENETDMAC_BUFALLOC]	= ENETDMA_6345_BUFALLOC_REG,
+	[ENETDMAC_RSTART]	= ENETDMA_6345_RSTART_REG,
+	[ENETDMAC_FC]		= ENETDMA_6345_FC_REG,
+	[ENETDMAC_LEN]		= ENETDMA_6345_LEN_REG,
+};
+
+const unsigned long *bcm63xx_regs_enetdmac;
+EXPORT_SYMBOL(bcm63xx_regs_enetdmac);
+
+static __init void bcm63xx_enetdmac_regs_init(void)
+{
+	if (BCMCPU_IS_6345())
+		bcm63xx_regs_enetdmac = bcm6345_regs_enetdmac;
+	else
+		bcm63xx_regs_enetdmac = bcm6348_regs_enetdmac;
+}
+#else
+static __init void bcm63xx_enetdmac_regs_init(void) { }
+#endif
+
 static struct resource shared_res[] = {
 	{
 		.start		= -1, /* filled at runtime */
@@ -137,12 +171,19 @@ static int __init register_shared(void)
 	if (shared_device_registered)
 		return 0;
 
+	bcm63xx_enetdmac_regs_init();
+
 	shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
 	shared_res[0].end = shared_res[0].start;
-	shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
+	if (BCMCPU_IS_6345())
+		shared_res[0].end += (RSET_6345_ENETDMA_SIZE) - 1;
+	else
+		shared_res[0].end += (RSET_ENETDMA_SIZE)  - 1;
 
 	if (BCMCPU_IS_6328() || BCMCPU_IS_6362() || BCMCPU_IS_6368())
 		chan_count = 32;
+	else if (BCMCPU_IS_6345())
+		chan_count = 8;
 	else
 		chan_count = 16;
 
@@ -172,7 +213,7 @@ int __init bcm63xx_enet_register(int unit,
 	if (unit > 1)
 		return -ENODEV;
 
-	if (unit == 1 && BCMCPU_IS_6338())
+	if (unit == 1 && (BCMCPU_IS_6338() || BCMCPU_IS_6345()))
 		return -ENODEV;
 
 	ret = register_shared();
@@ -213,6 +254,21 @@ int __init bcm63xx_enet_register(int unit,
 		dpd->phy_interrupt = bcm63xx_get_irq_number(IRQ_ENET_PHY);
 	}
 
+	dpd->dma_chan_en_mask = ENETDMAC_CHANCFG_EN_MASK;
+	dpd->dma_chan_int_mask = ENETDMAC_IR_PKTDONE_MASK;
+	if (BCMCPU_IS_6345()) {
+		dpd->dma_chan_en_mask |= ENETDMAC_CHANCFG_CHAINING_MASK;
+		dpd->dma_chan_en_mask |= ENETDMAC_CHANCFG_WRAP_EN_MASK;
+		dpd->dma_chan_en_mask |= ENETDMAC_CHANCFG_FLOWC_EN_MASK;
+		dpd->dma_chan_int_mask |= ENETDMA_IR_BUFDONE_MASK;
+		dpd->dma_chan_int_mask |= ENETDMA_IR_NOTOWNER_MASK;
+		dpd->dma_chan_width = ENETDMA_6345_CHAN_WIDTH;
+		dpd->dma_desc_shift = ENETDMA_6345_DESC_SHIFT;
+	} else {
+		dpd->dma_has_sram = true;
+		dpd->dma_chan_width = ENETDMA_CHAN_WIDTH;
+	}
+
 	ret = platform_device_register(pdev);
 	if (ret)
 		return ret;
@@ -246,6 +302,11 @@ bcm63xx_enetsw_register(const struct bcm63xx_enetsw_platform_data *pd)
 	else if (BCMCPU_IS_6362() || BCMCPU_IS_6368())
 		enetsw_pd.num_ports = ENETSW_PORTS_6368;
 
+	enetsw_pd.dma_has_sram = true;
+	enetsw_pd.dma_chan_width = ENETDMA_CHAN_WIDTH;
+	enetsw_pd.dma_chan_en_mask = ENETDMAC_CHANCFG_EN_MASK;
+	enetsw_pd.dma_chan_int_mask = ENETDMAC_IR_PKTDONE_MASK;
+
 	ret = platform_device_register(&bcm63xx_enetsw_device);
 	if (ret)
 		return ret;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 9981f4f..e6e65dc 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -174,6 +174,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_RSET_SPI_SIZE		1804
 #define RSET_ENET_SIZE			2048
 #define RSET_ENETDMA_SIZE		256
+#define RSET_6345_ENETDMA_SIZE		64
 #define RSET_ENETDMAC_SIZE(chans)	(16 * (chans))
 #define RSET_ENETDMAS_SIZE(chans)	(16 * (chans))
 #define RSET_ENETSW_SIZE		65536
@@ -300,7 +301,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_USBDMA_BASE		(0xfffe2800)
 #define BCM_6345_ENET0_BASE		(0xfffe1800)
 #define BCM_6345_ENETDMA_BASE		(0xfffe2800)
-#define BCM_6345_ENETDMAC_BASE		(0xfffe2900)
+#define BCM_6345_ENETDMAC_BASE		(0xfffe2840)
 #define BCM_6345_ENETDMAS_BASE		(0xfffe2a00)
 #define BCM_6345_ENETSW_BASE		(0xdeadbeef)
 #define BCM_6345_PCMCIA_BASE		(0xfffe2028)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index 118e3c9..753953e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -4,6 +4,8 @@
 #include <linux/if_ether.h>
 #include <linux/init.h>
 
+#include <bcm63xx_regs.h>
+
 /*
  * on board ethernet platform data
  */
@@ -37,6 +39,21 @@ struct bcm63xx_enet_platform_data {
 					  int phy_id, int reg),
 			  void (*mii_write)(struct net_device *dev,
 					    int phy_id, int reg, int val));
+
+	/* DMA channel enable mask */
+	u32 dma_chan_en_mask;
+
+	/* DMA channel interrupt mask */
+	u32 dma_chan_int_mask;
+
+	/* DMA engine has internal SRAM */
+	bool dma_has_sram;
+
+	/* DMA channel register width */
+	unsigned int dma_chan_width;
+
+	/* DMA descriptor shift */
+	unsigned int dma_desc_shift;
 };
 
 /*
@@ -63,6 +80,18 @@ struct bcm63xx_enetsw_platform_data {
 	char mac_addr[ETH_ALEN];
 	int num_ports;
 	struct bcm63xx_enetsw_port used_ports[ENETSW_MAX_PORT];
+
+	/* DMA channel enable mask */
+	u32 dma_chan_en_mask;
+
+	/* DMA channel interrupt mask */
+	u32 dma_chan_int_mask;
+
+	/* DMA channel register width */
+	unsigned int dma_chan_width;
+
+	/* DMA engine has internal SRAM */
+	bool dma_has_sram;
 };
 
 int __init bcm63xx_enet_register(int unit,
@@ -70,4 +99,69 @@ int __init bcm63xx_enet_register(int unit,
 
 int bcm63xx_enetsw_register(const struct bcm63xx_enetsw_platform_data *pd);
 
+enum bcm63xx_regs_enetdmac {
+	ENETDMAC_CHANCFG,
+	ENETDMAC_IR,
+	ENETDMAC_IRMASK,
+	ENETDMAC_MAXBURST,
+	ENETDMAC_BUFALLOC,
+	ENETDMAC_RSTART,
+	ENETDMAC_FC,
+	ENETDMAC_LEN,
+};
+
+static inline unsigned long bcm63xx_enetdmacreg(enum bcm63xx_regs_enetdmac reg)
+{
+#ifdef BCMCPU_RUNTIME_DETECT
+	extern const unsigned long *bcm63xx_regs_enetdmac;
+
+	return bcm63xx_regs_enetdmac[reg];
+#else
+#ifdef CONFIG_BCM63XX_CPU_6345
+	switch (reg) {
+	case ENETDMAC_CHANCFG:
+		return ENETDMA_6345_CHANCFG_REG;
+	case ENETDMAC_IR:
+		return ENETDMA_6345_IR_REG;
+	case ENETDMAC_IRMASK:
+		return ENETDMA_6345_IRMASK_REG;
+	case ENETDMAC_MAXBURST:
+		return ENETDMA_6345_MAXBURST_REG;
+	case ENETDMAC_BUFALLOC:
+		return ENETDMA_6345_BUFALLOC_REG;
+	case ENETDMAC_RSTART:
+		return ENETDMA_6345_RSTART_REG;
+	case ENETDMAC_FC:
+		return ENETDMA_6345_FC_REG;
+	case ENETDMAC_LEN:
+		return ENETDMA_6345_LEN_REG;
+	}
+#endif
+#if defined(CONFIG_BCM63XX_CPU_6328) || \
+	defined(CONFIG_BCM63XX_CPU_6338) || \
+	defined(CONFIG_BCM63XX_CPU_6348) || \
+	defined(CONFIG_BCM63XX_CPU_6358) || \
+	defined(CONFIG_BCM63XX_CPU_6362) || \
+	defined(CONFIG_BCM63XX_CPU_6368)
+	switch (reg) {
+	case ENETDMAC_CHANCFG:
+		return ENETDMAC_CHANCFG_REG;
+	case ENETDMAC_IR:
+		return ENETDMAC_IR_REG;
+	case ENETDMAC_IRMASK:
+		return ENETDMAC_IRMASK_REG;
+	case ENETDMAC_MAXBURST:
+		return ENETDMAC_MAXBURST_REG;
+	case ENETDMAC_BUFALLOC:
+	case ENETDMAC_RSTART:
+	case ENETDMAC_FC:
+	case ENETDMAC_LEN:
+		return 0;
+	}
+#endif
+#endif
+	return 0;
+}
+
+
 #endif /* ! BCM63XX_DEV_ENET_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 0a2121a..eff7ca7 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -727,6 +727,8 @@
 /*************************************************************************
  * _REG relative to RSET_ENETDMA
  *************************************************************************/
+#define ENETDMA_CHAN_WIDTH		0x10
+#define ENETDMA_6345_CHAN_WIDTH		0x40
 
 /* Controller Configuration Register */
 #define ENETDMA_CFG_REG			(0x0)
@@ -782,31 +784,56 @@
 /* State Ram Word 4 */
 #define ENETDMA_SRAM4_REG(x)		(0x20c + (x) * 0x10)
 
+/* Broadcom 6345 ENET DMA definitions */
+#define ENETDMA_6345_CHANCFG_REG	(0x00)
+
+#define ENETDMA_6345_MAXBURST_REG	(0x40)
+
+#define ENETDMA_6345_RSTART_REG		(0x08)
+
+#define ENETDMA_6345_LEN_REG		(0x0C)
+
+#define ENETDMA_6345_IR_REG		(0x14)
+
+#define ENETDMA_6345_IRMASK_REG		(0x18)
+
+#define ENETDMA_6345_FC_REG		(0x1C)
+
+#define ENETDMA_6345_BUFALLOC_REG	(0x20)
+
+/* Shift down for EOP, SOP and WRAP bits */
+#define ENETDMA_6345_DESC_SHIFT		(3)
 
 /*************************************************************************
  * _REG relative to RSET_ENETDMAC
  *************************************************************************/
 
 /* Channel Configuration register */
-#define ENETDMAC_CHANCFG_REG(x)		((x) * 0x10)
+#define ENETDMAC_CHANCFG_REG		(0x0)
 #define ENETDMAC_CHANCFG_EN_SHIFT	0
 #define ENETDMAC_CHANCFG_EN_MASK	(1 << ENETDMAC_CHANCFG_EN_SHIFT)
 #define ENETDMAC_CHANCFG_PKTHALT_SHIFT	1
 #define ENETDMAC_CHANCFG_PKTHALT_MASK	(1 << ENETDMAC_CHANCFG_PKTHALT_SHIFT)
 #define ENETDMAC_CHANCFG_BUFHALT_SHIFT	2
 #define ENETDMAC_CHANCFG_BUFHALT_MASK	(1 << ENETDMAC_CHANCFG_BUFHALT_SHIFT)
+#define ENETDMAC_CHANCFG_CHAINING_SHIFT	2
+#define ENETDMAC_CHANCFG_CHAINING_MASK	(1 << ENETDMAC_CHANCFG_CHAINING_SHIFT)
+#define ENETDMAC_CHANCFG_WRAP_EN_SHIFT	3
+#define ENETDMAC_CHANCFG_WRAP_EN_MASK	(1 << ENETDMAC_CHANCFG_WRAP_EN_SHIFT)
+#define ENETDMAC_CHANCFG_FLOWC_EN_SHIFT	4
+#define ENETDMAC_CHANCFG_FLOWC_EN_MASK	(1 << ENETDMAC_CHANCFG_FLOWC_EN_SHIFT)
 
 /* Interrupt Control/Status register */
-#define ENETDMAC_IR_REG(x)		(0x4 + (x) * 0x10)
+#define ENETDMAC_IR_REG			(0x4)
 #define ENETDMAC_IR_BUFDONE_MASK	(1 << 0)
 #define ENETDMAC_IR_PKTDONE_MASK	(1 << 1)
 #define ENETDMAC_IR_NOTOWNER_MASK	(1 << 2)
 
 /* Interrupt Mask register */
-#define ENETDMAC_IRMASK_REG(x)		(0x8 + (x) * 0x10)
+#define ENETDMAC_IRMASK_REG		(0x8)
 
 /* Maximum Burst Length */
-#define ENETDMAC_MAXBURST_REG(x)	(0xc + (x) * 0x10)
+#define ENETDMAC_MAXBURST_REG		(0xc)
 
 
 /*************************************************************************
@@ -814,16 +841,16 @@
  *************************************************************************/
 
 /* Ring Start Address register */
-#define ENETDMAS_RSTART_REG(x)		((x) * 0x10)
+#define ENETDMAS_RSTART_REG		(0x0)
 
 /* State Ram Word 2 */
-#define ENETDMAS_SRAM2_REG(x)		(0x4 + (x) * 0x10)
+#define ENETDMAS_SRAM2_REG		(0x4)
 
 /* State Ram Word 3 */
-#define ENETDMAS_SRAM3_REG(x)		(0x8 + (x) * 0x10)
+#define ENETDMAS_SRAM3_REG		(0x8)
 
 /* State Ram Word 4 */
-#define ENETDMAS_SRAM4_REG(x)		(0xc + (x) * 0x10)
+#define ENETDMAS_SRAM4_REG		(0xc)
 
 
 /*************************************************************************
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index fbbfc4a..8f1ac02 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -107,26 +107,28 @@ static inline void enet_dma_writel(struct bcm_enet_priv *priv,
 	bcm_writel(val, bcm_enet_shared_base[0] + off);
 }
 
-static inline u32 enet_dmac_readl(struct bcm_enet_priv *priv, u32 off)
+static inline u32 enet_dmac_readl(struct bcm_enet_priv *priv, u32 off, int chan)
 {
-	return bcm_readl(bcm_enet_shared_base[1] + off);
+	return bcm_readl(bcm_enet_shared_base[1] +
+		bcm63xx_enetdmacreg(off) + chan * priv->dma_chan_width);
 }
 
 static inline void enet_dmac_writel(struct bcm_enet_priv *priv,
-				       u32 val, u32 off)
+				       u32 val, u32 off, int chan)
 {
-	bcm_writel(val, bcm_enet_shared_base[1] + off);
+	bcm_writel(val, bcm_enet_shared_base[1] +
+		bcm63xx_enetdmacreg(off) + chan * priv->dma_chan_width);
 }
 
-static inline u32 enet_dmas_readl(struct bcm_enet_priv *priv, u32 off)
+static inline u32 enet_dmas_readl(struct bcm_enet_priv *priv, u32 off, int chan)
 {
-	return bcm_readl(bcm_enet_shared_base[2] + off);
+	return bcm_readl(bcm_enet_shared_base[2] + off + chan * priv->dma_chan_width);
 }
 
 static inline void enet_dmas_writel(struct bcm_enet_priv *priv,
-				       u32 val, u32 off)
+				       u32 val, u32 off, int chan)
 {
-	bcm_writel(val, bcm_enet_shared_base[2] + off);
+	bcm_writel(val, bcm_enet_shared_base[2] + off + chan * priv->dma_chan_width);
 }
 
 /*
@@ -262,7 +264,7 @@ static int bcm_enet_refill_rx(struct net_device *dev)
 		len_stat = priv->rx_skb_size << DMADESC_LENGTH_SHIFT;
 		len_stat |= DMADESC_OWNER_MASK;
 		if (priv->rx_dirty_desc == priv->rx_ring_size - 1) {
-			len_stat |= DMADESC_WRAP_MASK;
+			len_stat |= (DMADESC_WRAP_MASK >> priv->dma_desc_shift);
 			priv->rx_dirty_desc = 0;
 		} else {
 			priv->rx_dirty_desc++;
@@ -273,7 +275,10 @@ static int bcm_enet_refill_rx(struct net_device *dev)
 		priv->rx_desc_count++;
 
 		/* tell dma engine we allocated one buffer */
-		enet_dma_writel(priv, 1, ENETDMA_BUFALLOC_REG(priv->rx_chan));
+		if (priv->dma_has_sram)
+			enet_dma_writel(priv, 1, ENETDMA_BUFALLOC_REG(priv->rx_chan));
+		else
+			enet_dmac_writel(priv, 1, ENETDMAC_BUFALLOC, priv->rx_chan);
 	}
 
 	/* If rx ring is still empty, set a timer to try allocating
@@ -349,7 +354,8 @@ static int bcm_enet_receive_queue(struct net_device *dev, int budget)
 
 		/* if the packet does not have start of packet _and_
 		 * end of packet flag set, then just recycle it */
-		if ((len_stat & DMADESC_ESOP_MASK) != DMADESC_ESOP_MASK) {
+		if ((len_stat & (DMADESC_ESOP_MASK >> priv->dma_desc_shift)) !=
+			(DMADESC_ESOP_MASK >> priv->dma_desc_shift)) {
 			dev->stats.rx_dropped++;
 			continue;
 		}
@@ -410,8 +416,8 @@ static int bcm_enet_receive_queue(struct net_device *dev, int budget)
 		bcm_enet_refill_rx(dev);
 
 		/* kick rx dma */
-		enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
-				 ENETDMAC_CHANCFG_REG(priv->rx_chan));
+		enet_dmac_writel(priv, priv->dma_chan_en_mask,
+					 ENETDMAC_CHANCFG, priv->rx_chan);
 	}
 
 	return processed;
@@ -486,10 +492,10 @@ static int bcm_enet_poll(struct napi_struct *napi, int budget)
 	dev = priv->net_dev;
 
 	/* ack interrupts */
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IR_REG(priv->rx_chan));
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IR_REG(priv->tx_chan));
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IR, priv->rx_chan);
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IR, priv->tx_chan);
 
 	/* reclaim sent skb */
 	tx_work_done = bcm_enet_tx_reclaim(dev, 0);
@@ -508,10 +514,10 @@ static int bcm_enet_poll(struct napi_struct *napi, int budget)
 	napi_complete(napi);
 
 	/* restore rx/tx interrupt */
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IRMASK, priv->tx_chan);
 
 	return rx_work_done;
 }
@@ -554,8 +560,8 @@ static irqreturn_t bcm_enet_isr_dma(int irq, void *dev_id)
 	priv = netdev_priv(dev);
 
 	/* mask rx/tx interrupts */
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->tx_chan);
 
 	napi_schedule(&priv->napi);
 
@@ -616,14 +622,14 @@ static int bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 				       DMA_TO_DEVICE);
 
 	len_stat = (skb->len << DMADESC_LENGTH_SHIFT) & DMADESC_LENGTH_MASK;
-	len_stat |= DMADESC_ESOP_MASK |
+	len_stat |= (DMADESC_ESOP_MASK >> priv->dma_desc_shift) |
 		DMADESC_APPEND_CRC |
 		DMADESC_OWNER_MASK;
 
 	priv->tx_curr_desc++;
 	if (priv->tx_curr_desc == priv->tx_ring_size) {
 		priv->tx_curr_desc = 0;
-		len_stat |= DMADESC_WRAP_MASK;
+		len_stat |= (DMADESC_WRAP_MASK >> priv->dma_desc_shift);
 	}
 	priv->tx_desc_count--;
 
@@ -634,8 +640,8 @@ static int bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	wmb();
 
 	/* kick tx dma */
-	enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
-			 ENETDMAC_CHANCFG_REG(priv->tx_chan));
+	enet_dmac_writel(priv, priv->dma_chan_en_mask,
+				 ENETDMAC_CHANCFG, priv->tx_chan);
 
 	/* stop queue if no more desc available */
 	if (!priv->tx_desc_count)
@@ -763,6 +769,9 @@ static void bcm_enet_set_flow(struct bcm_enet_priv *priv, int rx_en, int tx_en)
 		val &= ~ENET_RXCFG_ENFLOW_MASK;
 	enet_writel(priv, val, ENET_RXCFG_REG);
 
+	if (!priv->dma_has_sram)
+		return;
+
 	/* tx flow control (pause frame generation) */
 	val = enet_dma_readl(priv, ENETDMA_CFG_REG);
 	if (tx_en)
@@ -910,8 +919,8 @@ static int bcm_enet_open(struct net_device *dev)
 
 	/* mask all interrupts and request them */
 	enet_writel(priv, 0, ENET_IRMASK_REG);
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->tx_chan);
 
 	ret = request_irq(dev->irq, bcm_enet_isr_mac, 0, dev->name, dev);
 	if (ret)
@@ -986,8 +995,12 @@ static int bcm_enet_open(struct net_device *dev)
 	priv->rx_curr_desc = 0;
 
 	/* initialize flow control buffer allocation */
-	enet_dma_writel(priv, ENETDMA_BUFALLOC_FORCE_MASK | 0,
-			ENETDMA_BUFALLOC_REG(priv->rx_chan));
+	if (priv->dma_has_sram)
+		enet_dma_writel(priv, ENETDMA_BUFALLOC_FORCE_MASK | 0,
+				ENETDMA_BUFALLOC_REG(priv->rx_chan));
+	else
+		enet_dmac_writel(priv, ENETDMA_BUFALLOC_FORCE_MASK | 0,
+				ENETDMAC_BUFALLOC, priv->rx_chan);
 
 	if (bcm_enet_refill_rx(dev)) {
 		dev_err(kdev, "cannot allocate rx skb queue\n");
@@ -996,18 +1009,30 @@ static int bcm_enet_open(struct net_device *dev)
 	}
 
 	/* write rx & tx ring addresses */
-	enet_dmas_writel(priv, priv->rx_desc_dma,
-			 ENETDMAS_RSTART_REG(priv->rx_chan));
-	enet_dmas_writel(priv, priv->tx_desc_dma,
-			 ENETDMAS_RSTART_REG(priv->tx_chan));
+	if (priv->dma_has_sram) {
+		enet_dmas_writel(priv, priv->rx_desc_dma,
+				 ENETDMAS_RSTART_REG, priv->rx_chan);
+		enet_dmas_writel(priv, priv->tx_desc_dma,
+			 ENETDMAS_RSTART_REG, priv->tx_chan);
+	} else {
+		enet_dmac_writel(priv, priv->rx_desc_dma,
+				ENETDMAC_RSTART, priv->rx_chan);
+		enet_dmac_writel(priv, priv->tx_desc_dma,
+				ENETDMAC_RSTART, priv->tx_chan);
+	}
 
 	/* clear remaining state ram for rx & tx channel */
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->rx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->tx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->rx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->tx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->rx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->tx_chan));
+	if (priv->dma_has_sram) {
+		enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG, priv->rx_chan);
+		enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG, priv->tx_chan);
+		enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG, priv->rx_chan);
+		enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG, priv->tx_chan);
+		enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG, priv->rx_chan);
+		enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG, priv->tx_chan);
+	} else {
+		enet_dmac_writel(priv, 0, ENETDMAC_FC, priv->rx_chan);
+		enet_dmac_writel(priv, 0, ENETDMAC_FC, priv->tx_chan);
+	}
 
 	/* set max rx/tx length */
 	enet_writel(priv, priv->hw_mtu, ENET_RXMAXLEN_REG);
@@ -1015,18 +1040,24 @@ static int bcm_enet_open(struct net_device *dev)
 
 	/* set dma maximum burst len */
 	enet_dmac_writel(priv, priv->dma_maxburst,
-			 ENETDMAC_MAXBURST_REG(priv->rx_chan));
+			 ENETDMAC_MAXBURST, priv->rx_chan);
 	enet_dmac_writel(priv, priv->dma_maxburst,
-			 ENETDMAC_MAXBURST_REG(priv->tx_chan));
+			 ENETDMAC_MAXBURST, priv->tx_chan);
 
 	/* set correct transmit fifo watermark */
 	enet_writel(priv, BCMENET_TX_FIFO_TRESH, ENET_TXWMARK_REG);
 
 	/* set flow control low/high threshold to 1/3 / 2/3 */
-	val = priv->rx_ring_size / 3;
-	enet_dma_writel(priv, val, ENETDMA_FLOWCL_REG(priv->rx_chan));
-	val = (priv->rx_ring_size * 2) / 3;
-	enet_dma_writel(priv, val, ENETDMA_FLOWCH_REG(priv->rx_chan));
+	if (priv->dma_has_sram) {
+		val = priv->rx_ring_size / 3;
+		enet_dma_writel(priv, val, ENETDMA_FLOWCL_REG(priv->rx_chan));
+		val = (priv->rx_ring_size * 2) / 3;
+		enet_dma_writel(priv, val, ENETDMA_FLOWCH_REG(priv->rx_chan));
+	} else {
+		enet_dmac_writel(priv, 5, ENETDMAC_FC, priv->rx_chan);
+		enet_dmac_writel(priv, priv->rx_ring_size, ENETDMAC_LEN, priv->rx_chan);
+		enet_dmac_writel(priv, priv->tx_ring_size, ENETDMAC_LEN, priv->tx_chan);
+	}
 
 	/* all set, enable mac and interrupts, start dma engine and
 	 * kick rx dma channel */
@@ -1035,26 +1066,26 @@ static int bcm_enet_open(struct net_device *dev)
 	val |= ENET_CTL_ENABLE_MASK;
 	enet_writel(priv, val, ENET_CTL_REG);
 	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
-	enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
-			 ENETDMAC_CHANCFG_REG(priv->rx_chan));
+	enet_dmac_writel(priv, priv->dma_chan_en_mask,
+			 ENETDMAC_CHANCFG, priv->rx_chan);
 
 	/* watch "mib counters about to overflow" interrupt */
 	enet_writel(priv, ENET_IR_MIB, ENET_IR_REG);
 	enet_writel(priv, ENET_IR_MIB, ENET_IRMASK_REG);
 
 	/* watch "packet transferred" interrupt in rx and tx */
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IR_REG(priv->rx_chan));
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IR_REG(priv->tx_chan));
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IR, priv->rx_chan);
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IR, priv->tx_chan);
 
 	/* make sure we enable napi before rx interrupt  */
 	napi_enable(&priv->napi);
 
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, priv->dma_chan_int_mask,
+			 ENETDMAC_IRMASK, priv->tx_chan);
 
 	if (priv->has_phy)
 		phy_start(priv->phydev);
@@ -1134,13 +1165,13 @@ static void bcm_enet_disable_dma(struct bcm_enet_priv *priv, int chan)
 {
 	int limit;
 
-	enet_dmac_writel(priv, 0, ENETDMAC_CHANCFG_REG(chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_CHANCFG, chan);
 
 	limit = 1000;
 	do {
 		u32 val;
 
-		val = enet_dmac_readl(priv, ENETDMAC_CHANCFG_REG(chan));
+		val = enet_dmac_readl(priv, ENETDMAC_CHANCFG, chan);
 		if (!(val & ENETDMAC_CHANCFG_EN_MASK))
 			break;
 		udelay(1);
@@ -1167,8 +1198,8 @@ static int bcm_enet_stop(struct net_device *dev)
 
 	/* mask all interrupts */
 	enet_writel(priv, 0, ENET_IRMASK_REG);
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->tx_chan);
 
 	/* make sure no mib update is scheduled */
 	cancel_work_sync(&priv->mib_update_task);
@@ -1782,6 +1813,11 @@ static int bcm_enet_probe(struct platform_device *pdev)
 		priv->pause_tx = pd->pause_tx;
 		priv->force_duplex_full = pd->force_duplex_full;
 		priv->force_speed_100 = pd->force_speed_100;
+		priv->dma_chan_en_mask = pd->dma_chan_en_mask;
+		priv->dma_chan_int_mask = pd->dma_chan_int_mask;
+		priv->dma_chan_width = pd->dma_chan_width;
+		priv->dma_has_sram = pd->dma_has_sram;
+		priv->dma_desc_shift = pd->dma_desc_shift;
 	}
 
 	if (priv->mac_id == 0 && priv->has_phy && !priv->use_external_mii) {
@@ -2118,8 +2154,8 @@ static int bcm_enetsw_open(struct net_device *dev)
 	kdev = &priv->pdev->dev;
 
 	/* mask all interrupts and request them */
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->tx_chan);
 
 	ret = request_irq(priv->irq_rx, bcm_enet_isr_dma,
 			  IRQF_DISABLED, dev->name, dev);
@@ -2231,23 +2267,23 @@ static int bcm_enetsw_open(struct net_device *dev)
 
 	/* write rx & tx ring addresses */
 	enet_dmas_writel(priv, priv->rx_desc_dma,
-			 ENETDMAS_RSTART_REG(priv->rx_chan));
+			 ENETDMAS_RSTART_REG, priv->rx_chan);
 	enet_dmas_writel(priv, priv->tx_desc_dma,
-			 ENETDMAS_RSTART_REG(priv->tx_chan));
+			 ENETDMAS_RSTART_REG, priv->tx_chan);
 
 	/* clear remaining state ram for rx & tx channel */
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->rx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG(priv->tx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->rx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG(priv->tx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->rx_chan));
-	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG(priv->tx_chan));
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG, priv->rx_chan);
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM2_REG, priv->tx_chan);
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG, priv->rx_chan);
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM3_REG, priv->tx_chan);
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG, priv->rx_chan);
+	enet_dmas_writel(priv, 0, ENETDMAS_SRAM4_REG, priv->tx_chan);
 
 	/* set dma maximum burst len */
 	enet_dmac_writel(priv, priv->dma_maxburst,
-			 ENETDMAC_MAXBURST_REG(priv->rx_chan));
+			 ENETDMAC_MAXBURST, priv->rx_chan);
 	enet_dmac_writel(priv, priv->dma_maxburst,
-			 ENETDMAC_MAXBURST_REG(priv->tx_chan));
+			 ENETDMAC_MAXBURST, priv->tx_chan);
 
 	/* set flow control low/high threshold to 1/3 / 2/3 */
 	val = priv->rx_ring_size / 3;
@@ -2261,21 +2297,21 @@ static int bcm_enetsw_open(struct net_device *dev)
 	wmb();
 	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
 	enet_dmac_writel(priv, ENETDMAC_CHANCFG_EN_MASK,
-			 ENETDMAC_CHANCFG_REG(priv->rx_chan));
+			 ENETDMAC_CHANCFG, priv->rx_chan);
 
 	/* watch "packet transferred" interrupt in rx and tx */
 	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IR_REG(priv->rx_chan));
+			 ENETDMAC_IR, priv->rx_chan);
 	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IR_REG(priv->tx_chan));
+			 ENETDMAC_IR, priv->tx_chan);
 
 	/* make sure we enable napi before rx interrupt  */
 	napi_enable(&priv->napi);
 
 	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IRMASK_REG(priv->rx_chan));
+			 ENETDMAC_IRMASK, priv->rx_chan);
 	enet_dmac_writel(priv, ENETDMAC_IR_PKTDONE_MASK,
-			 ENETDMAC_IRMASK_REG(priv->tx_chan));
+			 ENETDMAC_IRMASK, priv->tx_chan);
 
 	netif_carrier_on(dev);
 	netif_start_queue(dev);
@@ -2377,8 +2413,8 @@ static int bcm_enetsw_stop(struct net_device *dev)
 	del_timer_sync(&priv->rx_timeout);
 
 	/* mask all interrupts */
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->rx_chan));
-	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK_REG(priv->tx_chan));
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->rx_chan);
+	enet_dmac_writel(priv, 0, ENETDMAC_IRMASK, priv->tx_chan);
 
 	/* disable dma & mac */
 	bcm_enet_disable_dma(priv, priv->tx_chan);
@@ -2712,6 +2748,10 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 		memcpy(priv->used_ports, pd->used_ports,
 		       sizeof(pd->used_ports));
 		priv->num_ports = pd->num_ports;
+		priv->dma_has_sram = pd->dma_has_sram;
+		priv->dma_chan_en_mask = pd->dma_chan_en_mask;
+		priv->dma_chan_int_mask = pd->dma_chan_int_mask;
+		priv->dma_chan_width = pd->dma_chan_width;
 	}
 
 	ret = compute_hw_mtu(priv, dev->mtu);
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.h b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
index 721ffba..f55af43 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.h
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.h
@@ -339,6 +339,21 @@ struct bcm_enet_priv {
 	/* used to poll switch port state */
 	struct timer_list swphy_poll;
 	spinlock_t enetsw_mdio_lock;
+
+	/* dma channel enable mask */
+	u32 dma_chan_en_mask;
+
+	/* dma channel interrupt mask */
+	u32 dma_chan_int_mask;
+
+	/* DMA engine has internal SRAM */
+	bool dma_has_sram;
+
+	/* dma channel width */
+	unsigned int dma_chan_width;
+
+	/* dma descriptor shift value */
+	unsigned int dma_desc_shift;
 };
 
 
-- 
1.7.10.4
