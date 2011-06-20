Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:31:43 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35944 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491157Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 3F56A14021A;
        Mon, 20 Jun 2011 21:27:08 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id C56D7140209;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 10/13] MIPS: ath79: add AR933X specific USB platform device registration
Date:   Mon, 20 Jun 2011 21:26:10 +0200
Message-Id: <1308597973-6037-11-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A13198EB4F6 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16501

Also select the USB_ARCH_HAS_EHCI symbol in order to make the
EHCI driver available.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig                        |    1 +
 arch/mips/ath79/dev-usb.c                      |   19 +++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    7 +++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 90edf276..c3680c8 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -42,6 +42,7 @@ config SOC_AR913X
 	def_bool n
 
 config SOC_AR933X
+	select USB_ARCH_HAS_EHCI
 	def_bool n
 
 config ATH79_DEV_AR913X_WMAC
diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index c3f1999..002d6d2 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -163,6 +163,23 @@ static void __init ar913x_usb_setup(void)
 	platform_device_register(&ath79_ehci_device);
 }
 
+static void __init ar933x_usb_setup(void)
+{
+	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
+	mdelay(10);
+
+	ath79_device_reset_clear(AR933X_RESET_USB_HOST);
+	mdelay(10);
+
+	ath79_device_reset_clear(AR933X_RESET_USB_PHY);
+	mdelay(10);
+
+	ath79_ehci_resources[0].start = AR933X_EHCI_BASE;
+	ath79_ehci_resources[0].end = AR933X_EHCI_BASE + AR933X_EHCI_SIZE - 1;
+	ath79_ehci_device.name = "ar933x-ehci";
+	platform_device_register(&ath79_ehci_device);
+}
+
 void __init ath79_register_usb(void)
 {
 	if (soc_is_ar71xx())
@@ -173,6 +190,8 @@ void __init ath79_register_usb(void)
 		ar724x_usb_setup();
 	else if (soc_is_ar913x())
 		ar913x_usb_setup();
+	else if (soc_is_ar933x())
+		ar933x_usb_setup();
 	else
 		BUG();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index e65c10d..733baca 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -56,6 +56,9 @@
 #define AR933X_UART_BASE	(AR71XX_APB_BASE + 0x00020000)
 #define AR933X_UART_SIZE	0x14
 
+#define AR933X_EHCI_BASE	0x1b000000
+#define AR933X_EHCI_SIZE	0x1000
+
 /*
  * DDR_CTRL block
  */
@@ -230,6 +233,10 @@
 #define AR913X_RESET_USB_HOST		BIT(5)
 #define AR913X_RESET_USB_PHY		BIT(4)
 
+#define AR933X_RESET_USB_HOST		BIT(5)
+#define AR933X_RESET_USB_PHY		BIT(4)
+#define AR933X_RESET_USBSUS_OVERRIDE	BIT(3)
+
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
 #define REV_ID_MAJOR_MASK		0xfff0
-- 
1.7.2.1
