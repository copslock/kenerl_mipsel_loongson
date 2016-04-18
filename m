Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 20:59:38 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47881 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026938AbcDRS7YLFlBg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 20:59:24 +0200
Received: from starbug-2.treewalker.org (unknown [IPv6:2a01:670:6a22:7000::1])
        (Authenticated sender: relay@treewalker.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 360BAA80C6;
        Mon, 18 Apr 2016 20:59:21 +0200 (CEST)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id D81294319F;
        Mon, 18 Apr 2016 20:59:20 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH 2/3] MIPS: JZ4740: Probe OHCI platform device via DT
Date:   Mon, 18 Apr 2016 20:58:52 +0200
Message-Id: <1461005933-24876-2-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
References: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

The DT fragment will select the ohci-platform driver, since that can
handle the JZ4740 OHCI just fine. While I don't have a JZ4740-based
board with anything connected to the USB host controller, I did test
the generic OHCI driver successfully on a JZ4770-based board.

The device is disabled by default; boards that want to use it can
override the "status" property. The mass-production Qi LB60 boards
don't use the USB host controller.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi       | 14 ++++++++++++++
 arch/mips/include/asm/mach-jz4740/platform.h |  1 -
 arch/mips/jz4740/platform.c                  | 25 -------------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 8b2437c..4a9c8f2 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -65,4 +65,18 @@
 		clocks = <&ext>, <&cgu JZ4740_CLK_UART1>;
 		clock-names = "baud", "module";
 	};
+
+	uhc: uhc@13030000 {
+		compatible = "ingenic,jz4740-ohci", "generic-ohci";
+		reg = <0x13030000 0x1000>;
+
+		clocks = <&cgu JZ4740_CLK_UHC>;
+		assigned-clocks = <&cgu JZ4740_CLK_UHC>;
+		assigned-clock-rates = <48000000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <3>;
+
+		status = "disabled";
+	};
 };
diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
index 32cfbe6..073b8bf 100644
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -19,7 +19,6 @@
 
 #include <linux/platform_device.h>
 
-extern struct platform_device jz4740_usb_ohci_device;
 extern struct platform_device jz4740_udc_device;
 extern struct platform_device jz4740_udc_xceiv_device;
 extern struct platform_device jz4740_mmc_device;
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index e8a463b..2f1dab3 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -32,31 +32,6 @@
 
 #include "clock.h"
 
-/* OHCI controller */
-static struct resource jz4740_usb_ohci_resources[] = {
-	{
-		.start	= JZ4740_UHC_BASE_ADDR,
-		.end	= JZ4740_UHC_BASE_ADDR + 0x1000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= JZ4740_IRQ_UHC,
-		.end	= JZ4740_IRQ_UHC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device jz4740_usb_ohci_device = {
-	.name		= "jz4740-ohci",
-	.id		= -1,
-	.dev = {
-		.dma_mask = &jz4740_usb_ohci_device.dev.coherent_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(jz4740_usb_ohci_resources),
-	.resource	= jz4740_usb_ohci_resources,
-};
-
 /* USB Device Controller */
 struct platform_device jz4740_udc_xceiv_device = {
 	.name = "usb_phy_generic",
-- 
2.6.6
