Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:30:49 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46124 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903777Ab1LWS0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:19 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1EB9423C008B;
        Fri, 23 Dec 2011 19:26:19 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 11/16] MIPS: ath79: add USB platform setup code for AR934X
Date:   Fri, 23 Dec 2011 19:25:37 +0100
Message-Id: <1324664742-3648-12-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19099

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/dev-usb.c                      |   28 +++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   35 ++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 002d6d2..08ca26c 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -180,6 +180,32 @@ static void __init ar933x_usb_setup(void)
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
+	ath79_device_reset_clear(AR934X_RESET_USBSUS_OVERRIDE);
+	udelay(1000);
+
+	ath79_device_reset_set(AR934X_RESET_USB_PHY);
+	udelay(1000);
+
+	ath79_device_reset_set(AR934X_RESET_USB_PHY_ANALOG);
+	udelay(1000);
+
+	ath79_device_reset_set(AR934X_RESET_USB_HOST);
+	udelay(1000);
+
+	ath79_ehci_resources[0].start = AR934X_EHCI_BASE;
+	ath79_ehci_resources[0].end = AR934X_EHCI_BASE + AR934X_EHCI_SIZE - 1;
+	ath79_ehci_device.name = "ar934x-ehci";
+	platform_device_register(&ath79_ehci_device);
+}
+
 void __init ath79_register_usb(void)
 {
 	if (soc_is_ar71xx())
@@ -192,6 +218,8 @@ void __init ath79_register_usb(void)
 		ar913x_usb_setup();
 	else if (soc_is_ar933x())
 		ar933x_usb_setup();
+	else if (soc_is_ar934x())
+		ar934x_usb_setup();
 	else
 		BUG();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 1caa78a..4d64b88 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -63,6 +63,8 @@
 
 #define AR934X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
 #define AR934X_WMAC_SIZE	0x20000
+#define AR934X_EHCI_BASE	0x1b000000
+#define AR934X_EHCI_SIZE	0x1000
 
 /*
  * DDR_CTRL block
@@ -288,6 +290,39 @@
 #define AR933X_RESET_USB_PHY		BIT(4)
 #define AR933X_RESET_USBSUS_OVERRIDE	BIT(3)
 
+#define AR934X_RESET_HOST		BIT(31)
+#define AR934X_RESET_SLIC		BIT(30)
+#define AR934X_RESET_HDMA		BIT(29)
+#define AR934X_RESET_EXTERNAL		BIT(28)
+#define AR934X_RESET_RTC		BIT(27)
+#define AR934X_RESET_PCIE_EP_INT	BIT(26)
+#define AR934X_RESET_CHKSUM_ACC		BIT(25)
+#define AR934X_RESET_FULL_CHIP		BIT(24)
+#define AR934X_RESET_GE1_MDIO		BIT(23)
+#define AR934X_RESET_GE0_MDIO		BIT(22)
+#define AR934X_RESET_CPU_NMI		BIT(21)
+#define AR934X_RESET_CPU_COLD		BIT(20)
+#define AR934X_RESET_HOST_RESET_INT	BIT(19)
+#define AR934X_RESET_PCIE_EP		BIT(18)
+#define AR934X_RESET_UART1		BIT(17)
+#define AR934X_RESET_DDR		BIT(16)
+#define AR934X_RESET_USB_PHY_PLL_PWD_EXT BIT(15)
+#define AR934X_RESET_NANDF		BIT(14)
+#define AR934X_RESET_GE1_MAC		BIT(13)
+#define AR934X_RESET_ETH_SWITCH_ANALOG	BIT(12)
+#define AR934X_RESET_USB_PHY_ANALOG	BIT(11)
+#define AR934X_RESET_HOST_DMA_INT	BIT(10)
+#define AR934X_RESET_GE0_MAC		BIT(9)
+#define AR934X_RESET_ETH_SIWTCH		BIT(8)
+#define AR934X_RESET_PCIE_PHY		BIT(7)
+#define AR934X_RESET_PCIE		BIT(6)
+#define AR934X_RESET_USB_HOST		BIT(5)
+#define AR934X_RESET_USB_PHY		BIT(4)
+#define AR934X_RESET_USBSUS_OVERRIDE	BIT(3)
+#define AR934X_RESET_LUT		BIT(2)
+#define AR934X_RESET_MBOX		BIT(1)
+#define AR934X_RESET_I2S		BIT(0)
+
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
 #define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
-- 
1.7.2.1
