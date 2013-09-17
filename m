Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 10:13:43 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:59284 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827363Ab3IQINjfXBev (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 10:13:39 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 9404E28161B;
        Tue, 17 Sep 2013 10:12:45 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Tue, 17 Sep 2013 10:12:45 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: remove ar933x_uart_platform.h header
Date:   Tue, 17 Sep 2013 10:13:29 +0200
Message-Id: <1379405609-1861-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37823
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

In commit 15ef17f622033455dcf03ae96256e474073a7b11
(tty: ar933x_uart: use the clk API to get the uart
clock), the AR933x UART driver for has been converted
to get the uart clock rate via the clock API and it
does not use the platform data anymore.

Remove the ar933x_uart_platform.h header file and get
rid of the superfluous variable and initialization code
in platform setup.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-common.c                         |    6 ------
 .../include/asm/mach-ath79/ar933x_uart_platform.h    |   18 ------------------
 2 files changed, 24 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ath79/ar933x_uart_platform.h

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index c3b04c9..516225d 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -20,7 +20,6 @@
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/ar933x_uart_platform.h>
 #include "common.h"
 #include "dev-common.h"
 
@@ -68,15 +67,11 @@ static struct resource ar933x_uart_resources[] = {
 	},
 };
 
-static struct ar933x_uart_platform_data ar933x_uart_data;
 static struct platform_device ar933x_uart_device = {
 	.name		= "ar933x-uart",
 	.id		= -1,
 	.resource	= ar933x_uart_resources,
 	.num_resources	= ARRAY_SIZE(ar933x_uart_resources),
-	.dev = {
-		.platform_data	= &ar933x_uart_data,
-	},
 };
 
 void __init ath79_register_uart(void)
@@ -93,7 +88,6 @@ void __init ath79_register_uart(void)
 		ath79_uart_data[0].uartclk = uart_clk_rate;
 		platform_device_register(&ath79_uart_device);
 	} else if (soc_is_ar933x()) {
-		ar933x_uart_data.uartclk = uart_clk_rate;
 		platform_device_register(&ar933x_uart_device);
 	} else {
 		BUG();
diff --git a/arch/mips/include/asm/mach-ath79/ar933x_uart_platform.h b/arch/mips/include/asm/mach-ath79/ar933x_uart_platform.h
deleted file mode 100644
index 6cb30f2..0000000
--- a/arch/mips/include/asm/mach-ath79/ar933x_uart_platform.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  Platform data definition for Atheros AR933X UART
- *
- *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _AR933X_UART_PLATFORM_H
-#define _AR933X_UART_PLATFORM_H
-
-struct ar933x_uart_platform_data {
-	unsigned	uartclk;
-};
-
-#endif /* _AR933X_UART_PLATFORM_H */
-- 
1.7.10
