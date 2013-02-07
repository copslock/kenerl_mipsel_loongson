Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 21:32:43 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53331 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827522Ab3BGUcmYV-pa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 21:32:42 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 4EB1525E201;
        Thu,  7 Feb 2013 21:32:37 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kq2WZx28m1mr; Thu,  7 Feb 2013 21:32:37 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id C57C025E1F1;
        Thu,  7 Feb 2013 21:32:36 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/2] ath79: add ATH79_CPU_IRQ() macro
Date:   Thu,  7 Feb 2013 21:32:23 +0100
Message-Id: <1360269144-13853-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove the individual ATH79_CPU_IRQ_* constants and
use the new macro instead of those.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-usb.c              |   12 ++++++------
 arch/mips/ath79/dev-wmac.c             |    8 ++++----
 arch/mips/ath79/irq.c                  |   32 ++++++++++++++++----------------
 arch/mips/ath79/pci.c                  |    6 +++---
 arch/mips/include/asm/mach-ath79/irq.h |    9 ++-------
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index bd2bc10..2e04197 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -111,7 +111,7 @@ static void __init ath79_usb_setup(void)
 	platform_device_register(&ath79_ohci_device);
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR71XX_EHCI_BASE,
-				AR71XX_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+				AR71XX_EHCI_SIZE, ATH79_CPU_IRQ(3));
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v1;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -136,7 +136,7 @@ static void __init ar7240_usb_setup(void)
 	iounmap(usb_ctrl_base);
 
 	ath79_usb_init_resource(ath79_ohci_resources, AR7240_OHCI_BASE,
-				AR7240_OHCI_SIZE, ATH79_CPU_IRQ_USB);
+				AR7240_OHCI_SIZE, ATH79_CPU_IRQ(3));
 	platform_device_register(&ath79_ohci_device);
 }
 
@@ -152,7 +152,7 @@ static void __init ar724x_usb_setup(void)
 	mdelay(10);
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR724X_EHCI_BASE,
-				AR724X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+				AR724X_EHCI_SIZE, ATH79_CPU_IRQ(3));
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -169,7 +169,7 @@ static void __init ar913x_usb_setup(void)
 	mdelay(10);
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR913X_EHCI_BASE,
-				AR913X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+				AR913X_EHCI_SIZE, ATH79_CPU_IRQ(3));
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -186,7 +186,7 @@ static void __init ar933x_usb_setup(void)
 	mdelay(10);
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR933X_EHCI_BASE,
-				AR933X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+				AR933X_EHCI_SIZE, ATH79_CPU_IRQ(3));
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -212,7 +212,7 @@ static void __init ar934x_usb_setup(void)
 	udelay(1000);
 
 	ath79_usb_init_resource(ath79_ehci_resources, AR934X_EHCI_BASE,
-				AR934X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+				AR934X_EHCI_SIZE, ATH79_CPU_IRQ(3));
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index d6d893c..4f6c4e3 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -55,8 +55,8 @@ static void __init ar913x_wmac_setup(void)
 
 	ath79_wmac_resources[0].start = AR913X_WMAC_BASE;
 	ath79_wmac_resources[0].end = AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1;
-	ath79_wmac_resources[1].start = ATH79_CPU_IRQ_IP2;
-	ath79_wmac_resources[1].end = ATH79_CPU_IRQ_IP2;
+	ath79_wmac_resources[1].start = ATH79_CPU_IRQ(2);
+	ath79_wmac_resources[1].end = ATH79_CPU_IRQ(2);
 }
 
 
@@ -83,8 +83,8 @@ static void __init ar933x_wmac_setup(void)
 
 	ath79_wmac_resources[0].start = AR933X_WMAC_BASE;
 	ath79_wmac_resources[0].end = AR933X_WMAC_BASE + AR933X_WMAC_SIZE - 1;
-	ath79_wmac_resources[1].start = ATH79_CPU_IRQ_IP2;
-	ath79_wmac_resources[1].end = ATH79_CPU_IRQ_IP2;
+	ath79_wmac_resources[1].start = ATH79_CPU_IRQ(2);
+	ath79_wmac_resources[1].end = ATH79_CPU_IRQ(2);
 
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
 	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 219cfa1..2934895 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -114,7 +114,7 @@ static void __init ath79_misc_irq_init(void)
 					 handle_level_irq);
 	}
 
-	irq_set_chained_handler(ATH79_CPU_IRQ_MISC, ath79_misc_irq_handler);
+	irq_set_chained_handler(ATH79_CPU_IRQ(6), ath79_misc_irq_handler);
 }
 
 static void ar934x_ip2_irq_dispatch(unsigned int irq, struct irq_desc *desc)
@@ -147,7 +147,7 @@ static void ar934x_ip2_irq_init(void)
 		irq_set_chip_and_handler(i, &dummy_irq_chip,
 					 handle_level_irq);
 
-	irq_set_chained_handler(ATH79_CPU_IRQ_IP2, ar934x_ip2_irq_dispatch);
+	irq_set_chained_handler(ATH79_CPU_IRQ(2), ar934x_ip2_irq_dispatch);
 }
 
 asmlinkage void plat_irq_dispatch(void)
@@ -157,22 +157,22 @@ asmlinkage void plat_irq_dispatch(void)
 	pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP7)
-		do_IRQ(ATH79_CPU_IRQ_TIMER);
+		do_IRQ(ATH79_CPU_IRQ(7));
 
 	else if (pending & STATUSF_IP2)
 		ath79_ip2_handler();
 
 	else if (pending & STATUSF_IP4)
-		do_IRQ(ATH79_CPU_IRQ_GE0);
+		do_IRQ(ATH79_CPU_IRQ(4));
 
 	else if (pending & STATUSF_IP5)
-		do_IRQ(ATH79_CPU_IRQ_GE1);
+		do_IRQ(ATH79_CPU_IRQ(5));
 
 	else if (pending & STATUSF_IP3)
 		ath79_ip3_handler();
 
 	else if (pending & STATUSF_IP6)
-		do_IRQ(ATH79_CPU_IRQ_MISC);
+		do_IRQ(ATH79_CPU_IRQ(6));
 
 	else
 		spurious_interrupt();
@@ -188,60 +188,60 @@ asmlinkage void plat_irq_dispatch(void)
 static void ar71xx_ip2_handler(void)
 {
 	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_PCI);
-	do_IRQ(ATH79_CPU_IRQ_IP2);
+	do_IRQ(ATH79_CPU_IRQ(2));
 }
 
 static void ar724x_ip2_handler(void)
 {
 	ath79_ddr_wb_flush(AR724X_DDR_REG_FLUSH_PCIE);
-	do_IRQ(ATH79_CPU_IRQ_IP2);
+	do_IRQ(ATH79_CPU_IRQ(2));
 }
 
 static void ar913x_ip2_handler(void)
 {
 	ath79_ddr_wb_flush(AR913X_DDR_REG_FLUSH_WMAC);
-	do_IRQ(ATH79_CPU_IRQ_IP2);
+	do_IRQ(ATH79_CPU_IRQ(2));
 }
 
 static void ar933x_ip2_handler(void)
 {
 	ath79_ddr_wb_flush(AR933X_DDR_REG_FLUSH_WMAC);
-	do_IRQ(ATH79_CPU_IRQ_IP2);
+	do_IRQ(ATH79_CPU_IRQ(2));
 }
 
 static void ar934x_ip2_handler(void)
 {
-	do_IRQ(ATH79_CPU_IRQ_IP2);
+	do_IRQ(ATH79_CPU_IRQ(2));
 }
 
 static void ar71xx_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ_USB);
+	do_IRQ(ATH79_CPU_IRQ(3));
 }
 
 static void ar724x_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR724X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ_USB);
+	do_IRQ(ATH79_CPU_IRQ(3));
 }
 
 static void ar913x_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR913X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ_USB);
+	do_IRQ(ATH79_CPU_IRQ(3));
 }
 
 static void ar933x_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR933X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ_USB);
+	do_IRQ(ATH79_CPU_IRQ(3));
 }
 
 static void ar934x_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ_USB);
+	do_IRQ(ATH79_CPU_IRQ(3));
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index ea8aa10..4350c25 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -127,8 +127,8 @@ ath79_register_pci_ar71xx(void)
 	res[0].end = AR71XX_PCI_CFG_BASE + AR71XX_PCI_CFG_SIZE - 1;
 
 	res[1].flags = IORESOURCE_IRQ;
-	res[1].start = ATH79_CPU_IRQ_IP2;
-	res[1].end = ATH79_CPU_IRQ_IP2;
+	res[1].start = ATH79_CPU_IRQ(2);
+	res[1].end = ATH79_CPU_IRQ(2);
 
 	res[2].name = "io_base";
 	res[2].flags = IORESOURCE_IO;
@@ -208,7 +208,7 @@ int __init ath79_register_pci(void)
 						 AR724X_PCI_MEM_BASE,
 						 AR724X_PCI_MEM_SIZE,
 						 0,
-						 ATH79_CPU_IRQ_IP2);
+						 ATH79_CPU_IRQ(2));
 	} else if (soc_is_ar9342() ||
 		   soc_is_ar9344()) {
 		u32 bootstrap;
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 158ad7f..3dda4c2 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -12,6 +12,8 @@
 #define MIPS_CPU_IRQ_BASE	0
 #define NR_IRQS			48
 
+#define ATH79_CPU_IRQ(_x)	(MIPS_CPU_IRQ_BASE + (_x))
+
 #define ATH79_MISC_IRQ_BASE	8
 #define ATH79_MISC_IRQ_COUNT	32
 #define ATH79_MISC_IRQ(_x)	(ATH79_MISC_IRQ_BASE + (_x))
@@ -24,13 +26,6 @@
 #define ATH79_IP2_IRQ_COUNT	2
 #define ATH79_IP2_IRQ(_x)	(ATH79_IP2_IRQ_BASE + (_x))
 
-#define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
-#define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
-#define ATH79_CPU_IRQ_GE0	(MIPS_CPU_IRQ_BASE + 4)
-#define ATH79_CPU_IRQ_GE1	(MIPS_CPU_IRQ_BASE + 5)
-#define ATH79_CPU_IRQ_MISC	(MIPS_CPU_IRQ_BASE + 6)
-#define ATH79_CPU_IRQ_TIMER	(MIPS_CPU_IRQ_BASE + 7)
-
 #define ATH79_MISC_IRQ_TIMER	(ATH79_MISC_IRQ_BASE + 0)
 #define ATH79_MISC_IRQ_ERROR	(ATH79_MISC_IRQ_BASE + 1)
 #define ATH79_MISC_IRQ_GPIO	(ATH79_MISC_IRQ_BASE + 2)
-- 
1.7.10
