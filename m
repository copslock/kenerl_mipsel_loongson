Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:23:41 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40554 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990463AbeENGWYpFmJO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:22:24 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 8/8] MIPS: jz4740: Drop old platform reset code
Date:   Thu, 10 May 2018 20:47:51 +0200
Message-Id: <20180510184751.13416-8-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1525978126; bh=K4SH/91bCWbSUqMei4q5WWvwS0k4RfsaHm/mzELO95Q=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DYx+uuFBhl/qolhXKSp6RvHOeIvowKzXTlHnSILm44a4a2xxlO7Nfdocv73Obo2uMCU+OUHzxA3A4knwh76EF+NFvt1pUUInEurPDxbUPCcmBvlyzESFtT+6EHcOcSL9dMhFHZR0LqP+CUPLJM6l17vPq8mLF5QwD/YhAi2kWfg=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This work is now performed by the watchdog driver directly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: James Hogan <jhogan@kernel.org>
---
 arch/mips/jz4740/reset.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

 v2: No change
 v3: No change

diff --git a/arch/mips/jz4740/reset.c b/arch/mips/jz4740/reset.c
index 67780c4b6573..5bf0cf44b55f 100644
--- a/arch/mips/jz4740/reset.c
+++ b/arch/mips/jz4740/reset.c
@@ -12,18 +12,9 @@
  *
  */
 
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/pm.h>
-
 #include <asm/reboot.h>
 
-#include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/timer.h>
-
 #include "reset.h"
-#include "clock.h"
 
 static void jz4740_halt(void)
 {
@@ -36,29 +27,7 @@ static void jz4740_halt(void)
 	}
 }
 
-#define JZ_REG_WDT_DATA 0x00
-#define JZ_REG_WDT_COUNTER_ENABLE 0x04
-#define JZ_REG_WDT_COUNTER 0x08
-#define JZ_REG_WDT_CTRL 0x0c
-
-static void jz4740_restart(char *command)
-{
-	void __iomem *wdt_base = ioremap(JZ4740_WDT_BASE_ADDR, 0x0f);
-
-	jz4740_timer_enable_watchdog();
-
-	writeb(0, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-
-	writew(0, wdt_base + JZ_REG_WDT_COUNTER);
-	writew(0, wdt_base + JZ_REG_WDT_DATA);
-	writew(BIT(2), wdt_base + JZ_REG_WDT_CTRL);
-
-	writeb(1, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
-	jz4740_halt();
-}
-
 void jz4740_reset_init(void)
 {
-	_machine_restart = jz4740_restart;
 	_machine_halt = jz4740_halt;
 }
-- 
2.11.0
