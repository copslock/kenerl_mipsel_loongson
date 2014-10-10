Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 22:56:44 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:34957
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011001AbaJJUzcwgb4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 22:55:32 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: [PATCH 5/5] MIPS: ralink: we require gpiolib
Date:   Fri, 10 Oct 2014 22:28:50 +0200
Message-Id: <1412972930-16777-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Select ARCH_REQUIRE_GPIOLIB by default when building a kernel for RALINK.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig                        |    1 +
 arch/mips/include/asm/mach-ralink/gpio.h |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ralink/gpio.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2d255e8..380cce3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -453,6 +453,7 @@ config RALINK
 	select RESET_CONTROLLER
 	select PINCTRL
 	select PINCTRL_RT2880
+	select ARCH_REQUIRE_GPIOLIB
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
diff --git a/arch/mips/include/asm/mach-ralink/gpio.h b/arch/mips/include/asm/mach-ralink/gpio.h
new file mode 100644
index 0000000..f68ee16
--- /dev/null
+++ b/arch/mips/include/asm/mach-ralink/gpio.h
@@ -0,0 +1,24 @@
+/*
+ *  Ralink SoC GPIO API support
+ *
+ *  Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_MACH_RALINK_GPIO_H
+#define __ASM_MACH_RALINK_GPIO_H
+
+#define ARCH_NR_GPIOS	128
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+#endif /* __ASM_MACH_RALINK_GPIO_H */
-- 
1.7.10.4
