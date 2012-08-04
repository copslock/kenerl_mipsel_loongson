Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:04:57 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:34719 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903524Ab2HDQEI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:04:08 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F1C4323C009F;
        Sat,  4 Aug 2012 18:04:04 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 2/3] MIPS: ath79: add USB platform setup code for AR934X
Date:   Sat,  4 Aug 2012 18:03:56 +0200
Message-Id: <1344096237-25221-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
References: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 34060
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

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-usb.c                      |   28 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    7 ++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 87fe48e..072bb9b 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -193,6 +193,32 @@ static void __init ar933x_usb_setup(void)
 	platform_device_register(&ath79_ehci_device);
 }
 
+static void __init ar934x_usb_setup(void)
+{
+	u32 bootstrap;
+
+	bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
+	if (bootstrap & AR934X_BOOTSTRAP_USB_MODE_DEVICE)
+		return;
+
+	ath79_device_reset_set(AR934X_RESET_USBSUS_OVERRIDE);
+	udelay(1000);
+
+	ath79_device_reset_clear(AR934X_RESET_USB_PHY);
+	udelay(1000);
+
+	ath79_device_reset_clear(AR934X_RESET_USB_PHY_ANALOG);
+	udelay(1000);
+
+	ath79_device_reset_clear(AR934X_RESET_USB_HOST);
+	udelay(1000);
+
+	ath79_usb_init_resource(ath79_ehci_resources, AR934X_EHCI_BASE,
+				AR934X_EHCI_SIZE, ATH79_CPU_IRQ_USB);
+	ath79_ehci_device.dev.platform_data = &ath79_ehci_pdata_v2;
+	platform_device_register(&ath79_ehci_device);
+}
+
 void __init ath79_register_usb(void)
 {
 	if (soc_is_ar71xx())
@@ -205,6 +231,8 @@ void __init ath79_register_usb(void)
 		ar913x_usb_setup();
 	else if (soc_is_ar933x())
 		ar933x_usb_setup();
+	else if (soc_is_ar934x())
+		ar934x_usb_setup();
 	else
 		BUG();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index dde5044..3ccae12 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -63,6 +63,8 @@
 
 #define AR934X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
 #define AR934X_WMAC_SIZE	0x20000
+#define AR934X_EHCI_BASE	0x1b000000
+#define AR934X_EHCI_SIZE	0x200
 
 /*
  * DDR_CTRL block
@@ -288,6 +290,11 @@
 #define AR933X_RESET_USB_PHY		BIT(4)
 #define AR933X_RESET_USBSUS_OVERRIDE	BIT(3)
 
+#define AR934X_RESET_USB_PHY_ANALOG	BIT(11)
+#define AR934X_RESET_USB_HOST		BIT(5)
+#define AR934X_RESET_USB_PHY		BIT(4)
+#define AR934X_RESET_USBSUS_OVERRIDE	BIT(3)
+
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
 #define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
-- 
1.7.10
