Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:25:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:30698 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577900AbYGWPXh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:37 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2CE4FA8D0; Thu, 24 Jul 2008 00:23:31 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 09/10] txx9: Make tx4938-specific code more independent
Date:	Thu, 24 Jul 2008 00:25:20 +0900
Message-Id: <1216826721-28259-9-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make some TX4938 SoC specific code independent from board specific code.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |   27 ++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   16 +++++++++++++++
 arch/mips/txx9/rbtx4938/setup.c       |   34 +-------------------------------
 include/asm-mips/txx9/generic.h       |    2 +
 include/asm-mips/txx9/tx4938.h        |    2 +
 5 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 7b5705d..b136c66 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -220,6 +220,33 @@ void __init txx9_wdt_init(unsigned long base)
 	platform_device_register_simple("txx9wdt", -1, &res, 1);
 }
 
+/* SPI support */
+void __init txx9_spi_init(int busid, unsigned long base, int irq)
+{
+	struct resource res[] = {
+		{
+			.start	= base,
+			.end	= base + 0x20 - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= irq,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+	platform_device_register_simple("spi_txx9", busid,
+					res, ARRAY_SIZE(res));
+}
+
+void __init txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr)
+{
+	struct platform_device *pdev =
+		platform_device_alloc("tc35815-mac", id);
+	if (!pdev ||
+	    platform_device_add_data(pdev, ethaddr, 6) ||
+	    platform_device_add(pdev))
+		platform_device_put(pdev);
+}
+
 /* wrappers */
 void __init plat_mem_setup(void)
 {
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index b0a3dc8..1ceace4 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -262,3 +262,19 @@ void __init tx4938_setup_serial(void)
 	}
 #endif /* CONFIG_SERIAL_TXX9 */
 }
+
+void __init tx4938_spi_init(int busid)
+{
+	txx9_spi_init(busid, TX4938_SPI_REG & 0xfffffffffULL,
+		      TXX9_IRQ_BASE + TX4938_IR_SPI);
+}
+
+void __init tx4938_ethaddr_init(unsigned char *addr0, unsigned char *addr1)
+{
+	u64 pcfg = __raw_readq(&tx4938_ccfgptr->pcfg);
+
+	if (addr0 && (pcfg & TX4938_PCFG_ETH0_SEL))
+		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4938_IR_ETH0, addr0);
+	if (addr1 && (pcfg & TX4938_PCFG_ETH1_SEL))
+		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4938_IR_ETH1, addr1);
+}
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index ff5fda2..3324a70 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -132,19 +132,7 @@ static int __init rbtx4938_ethaddr_init(void)
 		if (sum)
 			printk(KERN_WARNING "seeprom: bad checksum.\n");
 	}
-	for (i = 0; i < 2; i++) {
-		unsigned int id =
-			TXX9_IRQ_BASE + (i ? TX4938_IR_ETH1 : TX4938_IR_ETH0);
-		struct platform_device *pdev;
-		if (!(__raw_readq(&tx4938_ccfgptr->pcfg) &
-		      (i ? TX4938_PCFG_ETH1_SEL : TX4938_PCFG_ETH0_SEL)))
-			continue;
-		pdev = platform_device_alloc("tc35815-mac", id);
-		if (!pdev ||
-		    platform_device_add_data(pdev, &dat[4 + 6 * i], 6) ||
-		    platform_device_add(pdev))
-			platform_device_put(pdev);
-	}
+	tx4938_ethaddr_init(&dat[4], &dat[4 + 6]);
 #endif /* CONFIG_PCI */
 	return 0;
 }
@@ -301,24 +289,6 @@ static struct gpio_chip rbtx4938_spi_gpio_chip = {
 	.ngpio = 3,
 };
 
-/* SPI support */
-
-static void __init txx9_spi_init(unsigned long base, int irq)
-{
-	struct resource res[] = {
-		{
-			.start	= base,
-			.end	= base + 0x20 - 1,
-			.flags	= IORESOURCE_MEM,
-		}, {
-			.start	= irq,
-			.flags	= IORESOURCE_IRQ,
-		},
-	};
-	platform_device_register_simple("spi_txx9", 0,
-					res, ARRAY_SIZE(res));
-}
-
 static int __init rbtx4938_spi_init(void)
 {
 	struct spi_board_info srtc_info = {
@@ -341,7 +311,7 @@ static int __init rbtx4938_spi_init(void)
 	gpio_direction_output(16 + SEEPROM2_CS, 1);
 	gpio_request(16 + SEEPROM3_CS, "seeprom3");
 	gpio_direction_output(16 + SEEPROM3_CS, 1);
-	txx9_spi_init(TX4938_SPI_REG & 0xfffffffffULL, RBTX4938_IRQ_IRC_SPI);
+	tx4938_spi_init(0);
 	return 0;
 }
 
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 2b34d09..c6b5cd6 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -45,5 +45,7 @@ extern int (*txx9_irq_dispatch)(int pending);
 void prom_init_cmdline(void);
 char *prom_getcmdline(void);
 void txx9_wdt_init(unsigned long base);
+void txx9_spi_init(int busid, unsigned long base, int irq);
+void txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr);
 
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index d5d7cef..26f9d4a 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -280,6 +280,8 @@ void tx4938_wdt_init(void);
 void tx4938_setup(void);
 void tx4938_time_init(unsigned int tmrnr);
 void tx4938_setup_serial(void);
+void tx4938_spi_init(int busid);
+void tx4938_ethaddr_init(unsigned char *addr0, unsigned char *addr1);
 int tx4938_report_pciclk(void);
 void tx4938_report_pci1clk(void);
 int tx4938_pciclk66_setup(void);
-- 
1.5.5.5
