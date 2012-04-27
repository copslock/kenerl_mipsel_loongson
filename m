Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 19:12:12 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55992 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903683Ab2D0RLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2012 19:11:37 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1D81C23C0072;
        Fri, 27 Apr 2012 19:11:35 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/3] MIPS: ath79: use a helper function for USB resource initialization
Date:   Fri, 27 Apr 2012 19:11:25 +0200
Message-Id: <1335546687-32179-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1335546687-32179-1-git-send-email-juhosg@openwrt.org>
References: <1335546687-32179-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 33033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This improves code readability, and ensures that
all resource fields will be initialized correctly.
Additionally, it helps to reduce the size of the
kernel image by using uninitialized resource
variables.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

 arch/mips/ath79/dev-usb.c |   64 +++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index b2a2311..87fe48e 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -25,17 +25,7 @@
 #include "common.h"
 #include "dev-usb.h"
 
-static struct resource ath79_ohci_resources[] = {
-	[0] = {
-		/* .start and .end fields are filled dynamically */
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= ATH79_MISC_IRQ_OHCI,
-		.end	= ATH79_MISC_IRQ_OHCI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
+static struct resource ath79_ohci_resources[2];
 
 static u64 ath79_ohci_dmamask = DMA_BIT_MASK(32);
 
@@ -54,17 +44,7 @@ static struct platform_device ath79_ohci_device = {
 	},
 };
 
-static struct resource ath79_ehci_resources[] = {
-	[0] = {
-		/* .start and .end fields are filled dynamically */
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= ATH79_CPU_IRQ_USB,
-		.end	= ATH79_CPU_IRQ_USB,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
+static struct resource ath79_ehci_resources[2];
 
 static u64 ath79_ehci_dmamask = DMA_BIT_MASK(32);
 
@@ -90,6 +70,20 @@ static struct platform_device ath79_ehci_device = {
 	},
 };
 
+static void __init ath79_usb_init_resource(struct resource res[2],
+					   unsigned long base,
+					   unsigned long size,
+					   int irq)
+{
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = base;
+	res[0].end = base + size - 1;
+
+	res[1].flags = IORESOURCE_IRQ;
+	res[1].start = irq;
+	res[1].end = irq;
+}
+
 #define AR71XX_USB_RESET_MASK	(AR71XX_RESET_USB_HOST | \
 				 AR71XX_RESET_USB_PHY | \
 				 AR71XX_RESET_USB_OHCI_DLL)
@@ -114,12 +108,12 @@ static void __init ath79_usb_setup(void)
 
 	mdelay(900);
 
-	ath79_ohci_resources[0].start = AR71XX_OHCI_BASE;
-	ath79_ohci_resources[0].end = AR71XX_OHCI_BASE + AR71XX_OHCI_SIZE - 1;
+	ath79_usb_init_resource(ath79_ohci_resources, AR71XX_OHCI_BASE,
+				AR71XX_OHCI_SIZE, ATH79_MISC_IRQ_OHCI);
 	platform_device_register(&ath79_ohci_device);
 
-	ath79_ehci_resources[0].start = AR71XX_EHCI_BASE;
-	ath79_ehci_resources[0].end = AR71XX_EHCI_BASE + AR71XX_EHCI_SIZE - 1;
+	ath79_usb_init_resource(ath79_ehci_resources, AR71XX_EHCI_BASE,
+				AR71XX_EHCI_SIZE, ATH79_CPU_IRQ_USB);
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v1;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -143,10 +137,8 @@ static void __init ar7240_usb_setup(void)
 
 	iounmap(usb_ctrl_base);
 
-	ath79_ohci_resources[0].start = AR7240_OHCI_BASE;
-	ath79_ohci_resources[0].end = AR7240_OHCI_BASE + AR7240_OHCI_SIZE - 1;
-	ath79_ohci_resources[1].start = ATH79_CPU_IRQ_USB;
-	ath79_ohci_resources[1].end = ATH79_CPU_IRQ_USB;
+	ath79_usb_init_resource(ath79_ohci_resources, AR7240_OHCI_BASE,
+				AR7240_OHCI_SIZE, ATH79_CPU_IRQ_USB);
 	platform_device_register(&ath79_ohci_device);
 }
 
@@ -161,8 +153,8 @@ static void __init ar724x_usb_setup(void)
 	ath79_device_reset_clear(AR724X_RESET_USB_PHY);
 	mdelay(10);
 
-	ath79_ehci_resources[0].start = AR724X_EHCI_BASE;
-	ath79_ehci_resources[0].end = AR724X_EHCI_BASE + AR724X_EHCI_SIZE - 1;
+	ath79_usb_init_resource(ath79_ehci_resources, AR724X_EHCI_BASE,
+				AR724X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -178,8 +170,8 @@ static void __init ar913x_usb_setup(void)
 	ath79_device_reset_clear(AR913X_RESET_USB_PHY);
 	mdelay(10);
 
-	ath79_ehci_resources[0].start = AR913X_EHCI_BASE;
-	ath79_ehci_resources[0].end = AR913X_EHCI_BASE + AR913X_EHCI_SIZE - 1;
+	ath79_usb_init_resource(ath79_ehci_resources, AR913X_EHCI_BASE,
+				AR913X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
@@ -195,8 +187,8 @@ static void __init ar933x_usb_setup(void)
 	ath79_device_reset_clear(AR933X_RESET_USB_PHY);
 	mdelay(10);
 
-	ath79_ehci_resources[0].start = AR933X_EHCI_BASE;
-	ath79_ehci_resources[0].end = AR933X_EHCI_BASE + AR933X_EHCI_SIZE - 1;
+	ath79_usb_init_resource(ath79_ehci_resources, AR933X_EHCI_BASE,
+				AR933X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
 	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
 	platform_device_register(&ath79_ehci_device);
 }
-- 
1.7.2.1
