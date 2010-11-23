Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 16:11:33 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:43991 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492058Ab0KWPHB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 16:07:01 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 467134DC018;
        Tue, 23 Nov 2010 16:06:53 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E75661F0001;
        Tue, 23 Nov 2010 16:06:52 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, kaloz@openwrt.org,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 08/18] MIPS: ath79: add common watchdog device
Date:   Tue, 23 Nov 2010 16:06:30 +0100
Message-Id: <1290524800-21419-9-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A14B431E47E | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

All supported SoCs have a built-in hardware watchdog driver. This patch
registers a platform_device for that to make it usable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---

Changes since RFC:
    - remove the ATH79_DEV_WDT Kconfig option, and move the watchdog platform
      code into dev-common.[ch]

 arch/mips/ath79/dev-common.c |   10 ++++++++++
 arch/mips/ath79/dev-common.h |    1 +
 arch/mips/ath79/setup.c      |    1 +
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 897522c..74b1e3b 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -57,3 +57,13 @@ void __init ath79_register_uart(void)
 	ath79_uart_data[0].uartclk = ath79_ahb_freq;
 	platform_device_register(&ath79_uart_device);
 }
+
+static struct platform_device ath79_wdt_device = {
+	.name		= "ath79-wdt",
+	.id		= -1,
+};
+
+void __init ath79_register_wdt(void)
+{
+	platform_device_register(&ath79_wdt_device);
+}
diff --git a/arch/mips/ath79/dev-common.h b/arch/mips/ath79/dev-common.h
index 1cec894..65bf400 100644
--- a/arch/mips/ath79/dev-common.h
+++ b/arch/mips/ath79/dev-common.h
@@ -13,5 +13,6 @@
 #define _ATH79_DEV_COMMON_H
 
 void ath79_register_uart(void) __init;
+void ath79_register_wdt(void) __init;
 
 #endif /* _ATH79_DEV_COMMON_H */
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 8600044..5abe56c 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -259,6 +259,7 @@ static int __init ath79_setup(void)
 {
 	ath79_gpio_init();
 	ath79_register_uart();
+	ath79_register_wdt();
 
 	mips_machine_setup();
 
-- 
1.7.2.1
