Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Feb 2013 19:58:06 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:52492 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827458Ab3BIS6FH9Rn1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Feb 2013 19:58:05 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id ACDD925E6D7;
        Sat,  9 Feb 2013 19:57:58 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FVuFozMAtQhN; Sat,  9 Feb 2013 19:57:58 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 4ED7225DC0A;
        Sat,  9 Feb 2013 19:57:58 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: use dynamically allocated USB platform devices
Date:   Sat,  9 Feb 2013 19:57:52 +0100
Message-Id: <1360436272-10854-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35731
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

The current code uses static resources and static platform
device instances for the possible USB controllers in the
system. These static variables contains initial values which
leads to data segment pollution.

Remove the static variables and use dynamically allocated
structures instead.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-usb.c |  111 +++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index bcb165b..02124d0 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -25,29 +25,11 @@
 #include "common.h"
 #include "dev-usb.h"
 
-static struct resource ath79_ohci_resources[2];
-
-static u64 ath79_ohci_dmamask = DMA_BIT_MASK(32);
+static u64 ath79_usb_dmamask = DMA_BIT_MASK(32);
 
 static struct usb_ohci_pdata ath79_ohci_pdata = {
 };
 
-static struct platform_device ath79_ohci_device = {
-	.name		= "ohci-platform",
-	.id		= -1,
-	.resource	= ath79_ohci_resources,
-	.num_resources	= ARRAY_SIZE(ath79_ohci_resources),
-	.dev = {
-		.dma_mask		= &ath79_ohci_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &ath79_ohci_pdata,
-	},
-};
-
-static struct resource ath79_ehci_resources[2];
-
-static u64 ath79_ehci_dmamask = DMA_BIT_MASK(32);
-
 static struct usb_ehci_pdata ath79_ehci_pdata_v1 = {
 	.has_synopsys_hc_bug	= 1,
 };
@@ -57,22 +39,16 @@ static struct usb_ehci_pdata ath79_ehci_pdata_v2 = {
 	.has_tt			= 1,
 };
 
-static struct platform_device ath79_ehci_device = {
-	.name		= "ehci-platform",
-	.id		= -1,
-	.resource	= ath79_ehci_resources,
-	.num_resources	= ARRAY_SIZE(ath79_ehci_resources),
-	.dev = {
-		.dma_mask		= &ath79_ehci_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-static void __init ath79_usb_init_resource(struct resource res[2],
-					   unsigned long base,
-					   unsigned long size,
-					   int irq)
+static void __init ath79_usb_register(const char *name, int id,
+				      unsigned long base, unsigned long size,
+				      int irq, const void *data,
+				      size_t data_size)
 {
+	struct resource res[2];
+	struct platform_device *pdev;
+
+	memset(res, 0, sizeof(res));
+
 	res[0].flags = IORESOURCE_MEM;
 	res[0].start = base;
 	res[0].end = base + size - 1;
@@ -80,6 +56,19 @@ static void __init ath79_usb_init_resource(struct resource res[2],
 	res[1].flags = IORESOURCE_IRQ;
 	res[1].start = irq;
 	res[1].end = irq;
+
+	pdev = platform_device_register_resndata(NULL, name, id,
+						 res, ARRAY_SIZE(res),
+						 data, data_size);
+
+	if (IS_ERR(pdev)) {
+		pr_err("ath79: unable to register USB at %08lx, err=%d\n",
+		       base, (int) PTR_ERR(pdev));
+		return;
+	}
+
+	pdev->dev.dma_mask = &ath79_usb_dmamask;
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 }
 
 #define AR71XX_USB_RESET_MASK	(AR71XX_RESET_USB_HOST | \
@@ -106,14 +95,15 @@ static void __init ath79_usb_setup(void)
 
 	mdelay(900);
 
-	ath79_usb_init_resource(ath79_ohci_resources, AR71XX_OHCI_BASE,
-				AR71XX_OHCI_SIZE, ATH79_MISC_IRQ(6));
-	platform_device_register(&ath79_ohci_device);
+	ath79_usb_register("ohci-platform", -1,
+			   AR71XX_OHCI_BASE, AR71XX_OHCI_SIZE,
+			   ATH79_MISC_IRQ(6),
+			   &ath79_ohci_pdata, sizeof(ath79_ohci_pdata));
 
-	ath79_usb_init_resource(ath79_ehci_resources, AR71XX_EHCI_BASE,
-				AR71XX_EHCI_SIZE, ATH79_CPU_IRQ(3));
-	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v1;
-	platform_device_register(&ath79_ehci_device);
+	ath79_usb_register("ehci-platform", -1,
+			   AR71XX_EHCI_BASE, AR71XX_EHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ath79_ehci_pdata_v1, sizeof(ath79_ehci_pdata_v1));
 }
 
 static void __init ar7240_usb_setup(void)
@@ -135,9 +125,10 @@ static void __init ar7240_usb_setup(void)
 
 	iounmap(usb_ctrl_base);
 
-	ath79_usb_init_resource(ath79_ohci_resources, AR7240_OHCI_BASE,
-				AR7240_OHCI_SIZE, ATH79_CPU_IRQ(3));
-	platform_device_register(&ath79_ohci_device);
+	ath79_usb_register("ohci-platform", -1,
+			   AR7240_OHCI_BASE, AR7240_OHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ath79_ohci_pdata, sizeof(ath79_ohci_pdata));
 }
 
 static void __init ar724x_usb_setup(void)
@@ -151,10 +142,10 @@ static void __init ar724x_usb_setup(void)
 	ath79_device_reset_clear(AR724X_RESET_USB_PHY);
 	mdelay(10);
 
-	ath79_usb_init_resource(ath79_ehci_resources, AR724X_EHCI_BASE,
-				AR724X_EHCI_SIZE, ATH79_CPU_IRQ(3));
-	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
-	platform_device_register(&ath79_ehci_device);
+	ath79_usb_register("ehci-platform", -1,
+			   AR724X_EHCI_BASE, AR724X_EHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
 }
 
 static void __init ar913x_usb_setup(void)
@@ -168,10 +159,10 @@ static void __init ar913x_usb_setup(void)
 	ath79_device_reset_clear(AR913X_RESET_USB_PHY);
 	mdelay(10);
 
-	ath79_usb_init_resource(ath79_ehci_resources, AR913X_EHCI_BASE,
-				AR913X_EHCI_SIZE, ATH79_CPU_IRQ(3));
-	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
-	platform_device_register(&ath79_ehci_device);
+	ath79_usb_register("ehci-platform", -1,
+			   AR913X_EHCI_BASE, AR913X_EHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
 }
 
 static void __init ar933x_usb_setup(void)
@@ -185,10 +176,10 @@ static void __init ar933x_usb_setup(void)
 	ath79_device_reset_clear(AR933X_RESET_USB_PHY);
 	mdelay(10);
 
-	ath79_usb_init_resource(ath79_ehci_resources, AR933X_EHCI_BASE,
-				AR933X_EHCI_SIZE, ATH79_CPU_IRQ(3));
-	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
-	platform_device_register(&ath79_ehci_device);
+	ath79_usb_register("ehci-platform", -1,
+			   AR933X_EHCI_BASE, AR933X_EHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
 }
 
 static void __init ar934x_usb_setup(void)
@@ -211,10 +202,10 @@ static void __init ar934x_usb_setup(void)
 	ath79_device_reset_clear(AR934X_RESET_USB_HOST);
 	udelay(1000);
 
-	ath79_usb_init_resource(ath79_ehci_resources, AR934X_EHCI_BASE,
-				AR934X_EHCI_SIZE, ATH79_CPU_IRQ(3));
-	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
-	platform_device_register(&ath79_ehci_device);
+	ath79_usb_register("ehci-platform", -1,
+			   AR934X_EHCI_BASE, AR934X_EHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
 }
 
 void __init ath79_register_usb(void)
-- 
1.7.10
