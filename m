Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 14:12:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52016 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024583AbZESNM2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 14:12:28 +0100
Received: from localhost.localdomain (p4136-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.136])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D4296A990; Tue, 19 May 2009 22:12:22 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] TXx9: Add ACLC support (v2)
Date:	Tue, 19 May 2009 22:12:22 +0900
Message-Id: <1242738742-8432-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add platform support for ACLC of TXx9 SoCs.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Changes since v1:
* use one platform device to provide irq/mem/dma resources and
  another platform device for machine driver.

 arch/mips/include/asm/txx9/generic.h  |    5 ++++
 arch/mips/include/asm/txx9/tx4927.h   |    2 +
 arch/mips/include/asm/txx9/tx4938.h   |    1 +
 arch/mips/include/asm/txx9/tx4939.h   |    1 +
 arch/mips/txx9/Kconfig                |    3 ++
 arch/mips/txx9/generic/setup.c        |   36 +++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4927.c |   43 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   11 ++++++++
 arch/mips/txx9/generic/setup_tx4939.c |    9 +++++++
 arch/mips/txx9/rbtx4927/setup.c       |    8 ++++-
 arch/mips/txx9/rbtx4938/setup.c       |    2 +
 arch/mips/txx9/rbtx4939/setup.c       |    2 +
 12 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 9cde009..8169477 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -91,4 +91,9 @@ void txx9_7segled_init(unsigned int num,
 		       void (*putc)(unsigned int pos, unsigned char val));
 int txx9_7segled_putc(unsigned int pos, char c);
 
+void __init txx9_aclc_init(unsigned long baseaddr, int irq,
+			   unsigned int dmac_id,
+			   unsigned int dma_chan_out,
+			   unsigned int dma_chan_in);
+
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/arch/mips/include/asm/txx9/tx4927.h b/arch/mips/include/asm/txx9/tx4927.h
index d92ae07..18c98c5 100644
--- a/arch/mips/include/asm/txx9/tx4927.h
+++ b/arch/mips/include/asm/txx9/tx4927.h
@@ -50,6 +50,7 @@
 #define TX4927_NR_SIO	2
 #define TX4927_SIO_REG(ch)	(TX4927_REG_BASE + 0xf300 + (ch) * 0x100)
 #define TX4927_PIO_REG		(TX4927_REG_BASE + 0xf500)
+#define TX4927_ACLC_REG		(TX4927_REG_BASE + 0xf700)
 
 #define TX4927_IR_ECCERR	0
 #define TX4927_IR_WTOERR	1
@@ -267,5 +268,6 @@ void tx4927_setup_pcierr_irq(void);
 void tx4927_irq_init(void);
 void tx4927_mtd_init(int ch);
 void tx4927_dmac_init(int memcpy_chan);
+void tx4927_aclc_init(unsigned int dma_chan_out, unsigned int dma_chan_in);
 
 #endif /* __ASM_TXX9_TX4927_H */
diff --git a/arch/mips/include/asm/txx9/tx4938.h b/arch/mips/include/asm/txx9/tx4938.h
index 0758a0c..54e4674 100644
--- a/arch/mips/include/asm/txx9/tx4938.h
+++ b/arch/mips/include/asm/txx9/tx4938.h
@@ -306,5 +306,6 @@ struct tx4938ide_platform_info {
 
 void tx4938_ata_init(unsigned int irq, unsigned int shift, int tune);
 void tx4938_dmac_init(int memcpy_chan0, int memcpy_chan1);
+void tx4938_aclc_init(void);
 
 #endif
diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index 1be9798..f13b708 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -545,5 +545,6 @@ void tx4939_rtc_init(void);
 void tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
 		       unsigned char ch_mask, unsigned char wide_mask);
 void tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1);
+void tx4939_aclc_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 0db7cf3..852ae4b 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -69,6 +69,7 @@ config SOC_TX4927
 	select IRQ_TXX9
 	select PCI_TX4927
 	select GPIO_TXX9
+	select HAS_TXX9_ACLC
 
 config SOC_TX4938
 	bool
@@ -78,6 +79,7 @@ config SOC_TX4938
 	select IRQ_TXX9
 	select PCI_TX4927
 	select GPIO_TXX9
+	select HAS_TXX9_ACLC
 
 config SOC_TX4939
 	bool
@@ -85,6 +87,7 @@ config SOC_TX4939
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
 	select PCI_TX4927
+	select HAS_TXX9_ACLC
 
 config TXX9_7SEGLED
 	bool
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 369d863..7f91012 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -876,3 +876,39 @@ void __init txx9_dmac_init(int id, unsigned long baseaddr, int irq,
 	}
 #endif
 }
+
+void __init txx9_aclc_init(unsigned long baseaddr, int irq,
+			   unsigned int dmac_id,
+			   unsigned int dma_chan_out,
+			   unsigned int dma_chan_in)
+{
+#if defined(CONFIG_SND_SOC_TXX9ACLC) || \
+	defined(CONFIG_SND_SOC_TXX9ACLC_MODULE)
+	unsigned int dma_base = dmac_id * TXX9_DMA_MAX_NR_CHANNELS;
+	struct resource res[] = {
+		{
+			.start = baseaddr,
+			.end = baseaddr + 0x100 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irq,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.name = "txx9dmac-chan",
+			.start = dma_base + dma_chan_out,
+			.flags = IORESOURCE_DMA,
+		}, {
+			.name = "txx9dmac-chan",
+			.start = dma_base + dma_chan_in,
+			.flags = IORESOURCE_DMA,
+		}
+	};
+	struct platform_device *pdev =
+		platform_device_alloc("txx9aclc-ac97", -1);
+
+	if (!pdev ||
+	    platform_device_add_resources(pdev, res, ARRAY_SIZE(res)) ||
+	    platform_device_add(pdev))
+		platform_device_put(pdev);
+#endif
+}
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 6b681cd..3418b2a 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -265,6 +265,49 @@ void __init tx4927_dmac_init(int memcpy_chan)
 		       TXX9_IRQ_BASE + TX4927_IR_DMA(0), &plat_data);
 }
 
+void __init tx4927_aclc_init(unsigned int dma_chan_out,
+			     unsigned int dma_chan_in)
+{
+	u64 pcfg = __raw_readq(&tx4927_ccfgptr->pcfg);
+	__u64 dmasel_mask = 0, dmasel = 0;
+	unsigned long flags;
+
+	if (!(pcfg & TX4927_PCFG_SEL2))
+		return;
+	/* setup DMASEL (playback:ACLC ch0, capture:ACLC ch1) */
+	switch (dma_chan_out) {
+	case 0:
+		dmasel_mask |= TX4927_PCFG_DMASEL0_MASK;
+		dmasel |= TX4927_PCFG_DMASEL0_ACL0;
+		break;
+	case 2:
+		dmasel_mask |= TX4927_PCFG_DMASEL2_MASK;
+		dmasel |= TX4927_PCFG_DMASEL2_ACL0;
+		break;
+	default:
+		return;
+	}
+	switch (dma_chan_in) {
+	case 1:
+		dmasel_mask |= TX4927_PCFG_DMASEL1_MASK;
+		dmasel |= TX4927_PCFG_DMASEL1_ACL1;
+		break;
+	case 3:
+		dmasel_mask |= TX4927_PCFG_DMASEL3_MASK;
+		dmasel |= TX4927_PCFG_DMASEL3_ACL1;
+		break;
+	default:
+		return;
+	}
+	local_irq_save(flags);
+	txx9_clear64(&tx4927_ccfgptr->pcfg, dmasel_mask);
+	txx9_set64(&tx4927_ccfgptr->pcfg, dmasel);
+	local_irq_restore(flags);
+	txx9_aclc_init(TX4927_ACLC_REG & 0xfffffffffULL,
+		       TXX9_IRQ_BASE + TX4927_IR_ACLC,
+		       0, dma_chan_out, dma_chan_in);
+}
+
 static void __init tx4927_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index b2b8529..4dfdb52 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -414,6 +414,17 @@ void __init tx4938_dmac_init(int memcpy_chan0, int memcpy_chan1)
 	}
 }
 
+void __init tx4938_aclc_init(void)
+{
+	u64 pcfg = __raw_readq(&tx4938_ccfgptr->pcfg);
+
+	if ((pcfg & TX4938_PCFG_SEL2) &&
+	    !(pcfg & TX4938_PCFG_ETH0_SEL))
+		txx9_aclc_init(TX4938_ACLC_REG & 0xfffffffffULL,
+			       TXX9_IRQ_BASE + TX4938_IR_ACLC,
+			       1, 0, 1);
+}
+
 static void __init tx4938_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index 98effef..7139686 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -485,6 +485,15 @@ void __init tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1)
 	}
 }
 
+void __init tx4939_aclc_init(void)
+{
+	u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
+
+	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) == TX4939_PCFG_I2SMODE_ACLC)
+		txx9_aclc_init(TX4939_ACLC_REG & 0xfffffffffULL,
+			       TXX9_IRQ_BASE + TX4939_IR_ACLC, 1, 0, 1);
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 332cdbc..ee468ea 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -337,10 +337,14 @@ static void __init rbtx4927_device_init(void)
 	rbtx4927_ne_init();
 	tx4927_wdt_init();
 	rbtx4927_mtd_init();
-	if (TX4927_REV_PCODE() == 0x4927)
+	if (TX4927_REV_PCODE() == 0x4927) {
 		tx4927_dmac_init(2);
-	else
+		tx4927_aclc_init(0, 1);
+	} else {
 		tx4938_dmac_init(0, 2);
+		tx4938_aclc_init();
+	}
+	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 	txx9_iocled_init(RBTX4927_LED_ADDR - IO_BASE, -1, 3, 1, "green", NULL);
 	rbtx4927_gpioled_init();
 }
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 37c5e3d..8da66e9 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -356,6 +356,8 @@ static void __init rbtx4938_device_init(void)
 	tx4938_ndfmc_init(10, 35);
 	tx4938_ata_init(RBTX4938_IRQ_IOC_ATA, 0, 1);
 	tx4938_dmac_init(0, 2);
+	tx4938_aclc_init();
+	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
 }
 
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 91f2ec8..d5ad5ab 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -499,6 +499,8 @@ static void __init rbtx4939_device_init(void)
 	tx4939_ata_init();
 	tx4939_rtc_init();
 	tx4939_dmac_init(0, 2);
+	tx4939_aclc_init();
+	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 }
 
 static void __init rbtx4939_setup(void)
-- 
1.5.6.5
