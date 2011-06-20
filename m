Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:32:10 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35946 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id BF86114022B;
        Mon, 20 Jun 2011 21:27:08 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 49581140209;
        Mon, 20 Jun 2011 21:27:08 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 12/13] MIPS: ath79: register UART device for the AR933X SoCs
Date:   Mon, 20 Jun 2011 21:26:12 +0200
Message-Id: <1308597973-6037-13-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A131A26D91D | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16502

The AR933X SoCs does not have a 8250 compatible UART, they
are using a different UART core. Register a different platform
device for the different UART.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-common.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 3b82e32..f4956f8 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -20,6 +20,7 @@
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ar933x_uart_platform.h>
 #include "common.h"
 #include "dev-common.h"
 
@@ -54,6 +55,30 @@ static struct platform_device ath79_uart_device = {
 	},
 };
 
+static struct resource ar933x_uart_resources[] = {
+	{
+		.start	= AR933X_UART_BASE,
+		.end	= AR933X_UART_BASE + AR71XX_UART_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= ATH79_MISC_IRQ_UART,
+		.end	= ATH79_MISC_IRQ_UART,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct ar933x_uart_platform_data ar933x_uart_data;
+static struct platform_device ar933x_uart_device = {
+	.name		= "ar933x-uart",
+	.id		= -1,
+	.resource	= ar933x_uart_resources,
+	.num_resources	= ARRAY_SIZE(ar933x_uart_resources),
+	.dev = {
+		.platform_data	= &ar933x_uart_data,
+	},
+};
+
 void __init ath79_register_uart(void)
 {
 	struct clk *clk;
@@ -62,8 +87,17 @@ void __init ath79_register_uart(void)
 	if (IS_ERR(clk))
 		panic("unable to get UART clock, err=%ld", PTR_ERR(clk));
 
-	ath79_uart_data[0].uartclk = clk_get_rate(clk);
-	platform_device_register(&ath79_uart_device);
+	if (soc_is_ar71xx() ||
+	    soc_is_ar724x() ||
+	    soc_is_ar913x()) {
+		ath79_uart_data[0].uartclk = clk_get_rate(clk);
+		platform_device_register(&ath79_uart_device);
+	} else if (soc_is_ar933x()) {
+		ar933x_uart_data.uartclk = clk_get_rate(clk);
+		platform_device_register(&ar933x_uart_device);
+	} else {
+		BUG();
+	}
 }
 
 static struct platform_device ath79_wdt_device = {
-- 
1.7.2.1
