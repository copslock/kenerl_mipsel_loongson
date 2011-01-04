Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 21:32:52 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:48588 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491028Ab1ADU3N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 21:29:13 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id A8E6545C020;
        Tue,  4 Jan 2011 21:29:04 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 4EEAC1F0001;
        Tue,  4 Jan 2011 21:29:04 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v5 07/16] MIPS: ath79: add common watchdog device
Date:   Tue,  4 Jan 2011 21:28:20 +0100
Message-Id: <1294172909-1309-8-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
References: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A108C37BE83 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28833
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

Changes since v1:
    - rebased against 2.6.37-rc7

Changes since v2:
    - don't use __init for function declarations

Changes since v3:
    - rebased against 2.6.37-rc8

Changes since v4: ---

 arch/mips/ath79/dev-common.c |   10 ++++++++++
 arch/mips/ath79/dev-common.h |    1 +
 arch/mips/ath79/setup.c      |    1 +
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 3cfa100..3b82e32 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -65,3 +65,13 @@ void __init ath79_register_uart(void)
 	ath79_uart_data[0].uartclk = clk_get_rate(clk);
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
index 248622c..0f514e1 100644
--- a/arch/mips/ath79/dev-common.h
+++ b/arch/mips/ath79/dev-common.h
@@ -13,5 +13,6 @@
 #define _ATH79_DEV_COMMON_H
 
 void ath79_register_uart(void);
+void ath79_register_wdt(void);
 
 #endif /* _ATH79_DEV_COMMON_H */
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 5e57402..159b42f 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -186,6 +186,7 @@ static int __init ath79_setup(void)
 {
 	ath79_gpio_init();
 	ath79_register_uart();
+	ath79_register_wdt();
 
 	mips_machine_setup();
 
-- 
1.7.2.1
