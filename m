Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:16:35 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46701 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904068Ab1KQWOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id CBA671404EF;
        Thu, 17 Nov 2011 23:14:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xo5bjnHiwy5N; Thu, 17 Nov 2011 23:14:16 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 1AE6A1403E1;
        Thu, 17 Nov 2011 23:14:15 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 5/6] MIPS: ath79: rename ATH79_DEV_AR913X_WMAC option to ATH79_DEV_WMAC
Date:   Thu, 17 Nov 2011 23:13:46 +0100
Message-Id: <1321568027-32066-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14885

The ATH79_DEV_AR913X_WMAC option was used to select
the AR913x specific wireless MAC registration code.
The registration code now supports the AR933X SoCs
as well. Rename the option to reflect the changes.

Also make the new option depends on SOC_AR933X.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig  |   11 ++++++-----
 arch/mips/ath79/Makefile |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 4a7e0e8..4fc697d 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -9,6 +9,7 @@ config ATH79_MACH_AP121
 	select ATH79_DEV_LEDS_GPIO
 	select ATH79_DEV_SPI
 	select ATH79_DEV_USB
+	select ATH79_DEV_WMAC
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros AP121 reference board.
@@ -16,11 +17,11 @@ config ATH79_MACH_AP121
 config ATH79_MACH_AP81
 	bool "Atheros AP81 reference board"
 	select SOC_AR913X
-	select ATH79_DEV_AR913X_WMAC
 	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
 	select ATH79_DEV_SPI
 	select ATH79_DEV_USB
+	select ATH79_DEV_WMAC
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros AP81 reference board.
@@ -56,10 +57,6 @@ config SOC_AR933X
 	select USB_ARCH_HAS_EHCI
 	def_bool n
 
-config ATH79_DEV_AR913X_WMAC
-	depends on SOC_AR913X
-	def_bool n
-
 config ATH79_DEV_GPIO_BUTTONS
 	def_bool n
 
@@ -72,4 +69,8 @@ config ATH79_DEV_SPI
 config ATH79_DEV_USB
 	def_bool n
 
+config ATH79_DEV_WMAC
+	depends on (SOC_AR913X || SOC_AR933X)
+	def_bool n
+
 endif
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 8933d18..ac159e6 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -16,11 +16,11 @@ obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 # Devices
 #
 obj-y					+= dev-common.o
-obj-$(CONFIG_ATH79_DEV_AR913X_WMAC)	+= dev-ar913x-wmac.o
 obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
+obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-ar913x-wmac.o
 
 #
 # Machines
-- 
1.7.2.1
