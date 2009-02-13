Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 15:29:04 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:12779 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21367040AbZBMP27 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2009 15:28:59 +0000
Received: from localhost.localdomain (p6191-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.191])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E856FAA15; Sat, 14 Feb 2009 00:28:52 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] TXx9: Add DMAC support
Date:	Sat, 14 Feb 2009 00:28:58 +0900
Message-Id: <1234538938-23479-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add platform support for DMAC of TXx9 SoCs.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on some mips patches ("TXx9: Add NDFMC support",
"RBTX4939: Add MTD support").
http://www.linux-mips.org/archives/linux-mips/2009-01/msg00109.html
http://www.linux-mips.org/archives/linux-mips/2009-01/msg00107.html

 arch/mips/include/asm/txx9/dmac.h     |    3 +++
 arch/mips/include/asm/txx9/tx4927.h   |    2 ++
 arch/mips/include/asm/txx9/tx4938.h   |    1 +
 arch/mips/include/asm/txx9/tx4939.h   |    1 +
 arch/mips/txx9/generic/setup.c        |   25 +++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4927.c |   12 ++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   21 ++++++++++++++++-----
 arch/mips/txx9/generic/setup_tx4939.c |   21 ++++++++++++++++-----
 arch/mips/txx9/rbtx4927/setup.c       |    4 ++++
 arch/mips/txx9/rbtx4938/setup.c       |    1 +
 arch/mips/txx9/rbtx4939/setup.c       |    1 +
 11 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/txx9/dmac.h b/arch/mips/include/asm/txx9/dmac.h
index 3e1345d..51389c3 100644
--- a/arch/mips/include/asm/txx9/dmac.h
+++ b/arch/mips/include/asm/txx9/dmac.h
@@ -37,4 +37,7 @@ struct txx9dmac_slave {
 	unsigned int	reg_width;
 };
 
+void txx9_dmac_init(int id, unsigned long baseaddr, int irqs,
+		    const struct txx9dmac_platform_data *pdata);
+
 #endif /* __ASM_TXX9_DMAC_H */
diff --git a/arch/mips/include/asm/txx9/tx4927.h b/arch/mips/include/asm/txx9/tx4927.h
index 7d813f1..d92ae07 100644
--- a/arch/mips/include/asm/txx9/tx4927.h
+++ b/arch/mips/include/asm/txx9/tx4927.h
@@ -41,6 +41,7 @@
 
 #define TX4927_SDRAMC_REG	(TX4927_REG_BASE + 0x8000)
 #define TX4927_EBUSC_REG	(TX4927_REG_BASE + 0x9000)
+#define TX4927_DMA_REG		(TX4927_REG_BASE + 0xb000)
 #define TX4927_PCIC_REG		(TX4927_REG_BASE + 0xd000)
 #define TX4927_CCFG_REG		(TX4927_REG_BASE + 0xe000)
 #define TX4927_IRC_REG		(TX4927_REG_BASE + 0xf600)
@@ -265,5 +266,6 @@ int tx4927_pciclk66_setup(void);
 void tx4927_setup_pcierr_irq(void);
 void tx4927_irq_init(void);
 void tx4927_mtd_init(int ch);
+void tx4927_dmac_init(int memcpy_chan);
 
 #endif /* __ASM_TXX9_TX4927_H */
diff --git a/arch/mips/include/asm/txx9/tx4938.h b/arch/mips/include/asm/txx9/tx4938.h
index cd8bc20..0758a0c 100644
--- a/arch/mips/include/asm/txx9/tx4938.h
+++ b/arch/mips/include/asm/txx9/tx4938.h
@@ -305,5 +305,6 @@ struct tx4938ide_platform_info {
 };
 
 void tx4938_ata_init(unsigned int irq, unsigned int shift, int tune);
+void tx4938_dmac_init(int memcpy_chan0, int memcpy_chan1);
 
 #endif
diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index af456c7..697fa93 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -544,5 +544,6 @@ void tx4939_ata_init(void);
 void tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
 		       unsigned char ch_mask, unsigned char wide_mask);
 void tx4939_rtc_init(void);
+void tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1);
 
 #endif /* __ASM_TXX9_TX4939_H */
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 8a266c6..91c4283 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -33,6 +33,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9/ndfmc.h>
+#include <asm/txx9/dmac.h>
 #ifdef CONFIG_CPU_TX49XX
 #include <asm/txx9/tx4938.h>
 #endif
@@ -821,3 +822,27 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 {
 }
 #endif /* CONFIG_LEDS_GPIO */
+
+void __init txx9_dmac_init(int id, unsigned long baseaddr, int irq,
+			   const struct txx9dmac_platform_data *pdata)
+{
+#if defined(CONFIG_TXX9_DMAC) || defined(CONFIG_TXX9_DMAC_MODULE)
+	struct resource res[] = {
+		{
+			.start = baseaddr,
+			.end = baseaddr + 0x800 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irq,
+			.flags = IORESOURCE_IRQ,
+		}
+	};
+	struct platform_device *pdev = platform_device_alloc("txx9dmac", id);
+
+	if (!pdev ||
+	    platform_device_add_resources(pdev, res, ARRAY_SIZE(res)) ||
+	    platform_device_add_data(pdev, pdata, sizeof(*pdata)) ||
+	    platform_device_add(pdev))
+		platform_device_put(pdev);
+#endif
+}
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 914e93c..778078a 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -22,6 +22,7 @@
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
 #include <asm/txx9/generic.h>
+#include <asm/txx9/dmac.h>
 #include <asm/txx9/tx4927.h>
 
 static void __init tx4927_wdr_init(void)
@@ -253,6 +254,17 @@ void __init tx4927_mtd_init(int ch)
 	txx9_physmap_flash_init(ch, start, size, &pdata);
 }
 
+void __init tx4927_dmac_init(int memcpy_chan)
+{
+	struct txx9dmac_platform_data plat_data = {
+		.memcpy_chan = memcpy_chan,
+		.have_64bit_regs = true,
+	};
+
+	txx9_dmac_init(0, TX4927_DMA_REG & 0xfffffffffULL,
+		       TXX9_IRQ_BASE + TX4927_IR_DMA(0), &plat_data);
+}
+
 static void __init tx4927_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index f0844f8..5d2cbbf 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -24,6 +24,7 @@
 #include <asm/txx9pio.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/ndfmc.h>
+#include <asm/txx9/dmac.h>
 #include <asm/txx9/tx4938.h>
 
 static void __init tx4938_wdr_init(void)
@@ -239,11 +240,6 @@ void __init tx4938_setup(void)
 	for (i = 0; i < TX4938_NR_TMR; i++)
 		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
 
-	/* DMA */
-	for (i = 0; i < 2; i++)
-		____raw_writeq(TX4938_DMA_MCR_MSTEN,
-			       (void __iomem *)(TX4938_DMA_REG(i) + 0x50));
-
 	/* PIO */
 	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, TX4938_NUM_PIO);
 	__raw_writel(0, &tx4938_pioptr->maskcpu);
@@ -403,6 +399,21 @@ void __init tx4938_ndfmc_init(unsigned int hold, unsigned int spw)
 		txx9_ndfmc_init(baseaddr, &plat_data);
 }
 
+void __init tx4938_dmac_init(int memcpy_chan0, int memcpy_chan1)
+{
+	struct txx9dmac_platform_data plat_data = {
+		.have_64bit_regs = true,
+	};
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		plat_data.memcpy_chan = i ? memcpy_chan1 : memcpy_chan0;
+		txx9_dmac_init(i, TX4938_DMA_REG(i) & 0xfffffffffULL,
+			       TXX9_IRQ_BASE + TX4938_IR_DMA(i, 0),
+			       &plat_data);
+	}
+}
+
 static void __init tx4938_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index ec56b91..d48eee1 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -28,6 +28,7 @@
 #include <asm/txx9tmr.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/ndfmc.h>
+#include <asm/txx9/dmac.h>
 #include <asm/txx9/tx4939.h>
 
 static void __init tx4939_wdr_init(void)
@@ -259,11 +260,6 @@ void __init tx4939_setup(void)
 	for (i = 0; i < TX4939_NR_TMR; i++)
 		txx9_tmr_init(TX4939_TMR_REG(i) & 0xfffffffffULL);
 
-	/* DMA */
-	for (i = 0; i < 2; i++)
-		____raw_writeq(TX4938_DMA_MCR_MSTEN,
-			       (void __iomem *)(TX4939_DMA_REG(i) + 0x50));
-
 	/* set PCIC1 reset (required to prevent hangup on BIST) */
 	txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1RST);
 	pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
@@ -474,6 +470,21 @@ void __init tx4939_rtc_init(void)
 	platform_device_register(&rtc_dev);
 }
 
+void __init tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1)
+{
+	struct txx9dmac_platform_data plat_data = {
+		.have_64bit_regs = true,
+	};
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		plat_data.memcpy_chan = i ? memcpy_chan1 : memcpy_chan0;
+		txx9_dmac_init(i, TX4939_DMA_REG(i) & 0xfffffffffULL,
+			       TXX9_IRQ_BASE + TX4939_IR_DMA(i, 0),
+			       &plat_data);
+	}
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 01129a9..332cdbc 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -337,6 +337,10 @@ static void __init rbtx4927_device_init(void)
 	rbtx4927_ne_init();
 	tx4927_wdt_init();
 	rbtx4927_mtd_init();
+	if (TX4927_REV_PCODE() == 0x4927)
+		tx4927_dmac_init(2);
+	else
+		tx4938_dmac_init(0, 2);
 	txx9_iocled_init(RBTX4927_LED_ADDR - IO_BASE, -1, 3, 1, "green", NULL);
 	rbtx4927_gpioled_init();
 }
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 65d13df..37c5e3d 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -355,6 +355,7 @@ static void __init rbtx4938_device_init(void)
 	/* TC58DVM82A1FT: tDH=10ns, tWP=tRP=tREADID=35ns */
 	tx4938_ndfmc_init(10, 35);
 	tx4938_ata_init(RBTX4938_IRQ_IOC_ATA, 0, 1);
+	tx4938_dmac_init(0, 2);
 	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
 }
 
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 0f1ce9c..1e28e97 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -498,6 +498,7 @@ static void __init rbtx4939_device_init(void)
 	tx4939_wdt_init();
 	tx4939_ata_init();
 	tx4939_rtc_init();
+	tx4939_dmac_init(0, 2);
 }
 
 static void __init rbtx4939_setup(void)
-- 
1.5.6.3
