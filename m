Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 15:11:52 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:54597 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007233AbbKVOLvIlQts (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 15:11:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=EyPBr+lhgUk1qrzP59ElTzaqASH3uL4r7iCFgenCIBk=;
        b=LQWbZc8oaGbnv/g6sBSR3H4jb5d48MF+t+A9hFYaNehTD1lIY+YNwA/vA/z2GbBtlYz34J2lLDOSagqydkn2joWnwdTaoBTUcfOUfT9MTD3cBGxSnQ7dSq4GL8iYs73m/jCtkGCIStRlC+naeIojI3Ud6cPK2/sjjpa9NNkSIUuPPhjAzyUeGzWAbhbj3gQ95wnVj3XM6X3WDk458S2QvDUr8bABunFL/2YHw2ZQtknQMtchB9JkZZ7sU5wWHZsSOkEeb6pN4Hs6zpzJDJtCpT8aozY8Vz4jYTDeRjQcxm8WlaVloeVhGErEnnTknmFfCoJsDgyJfwr6CldKExEsDg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60500 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0VMi-0001aR-EE (Exim); Sun, 22 Nov 2015 14:11:41 +0000
Subject: [PATCH 8/10] watchdog: bcm63xx_wdt: Remove dependency on mach-bcm63xx
 functions/defines
To:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5651CD1B.1000600@simon.arlott.org.uk>
Date:   Sun, 22 Nov 2015 14:11:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5651CB13.4090704@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

The bcm_readl() and bcm_writel() functions are only defined for
mach-bcm63xx, replace them with __raw_readl() and raw_writel().

The register defines required for the watchdog are in a mach-bcm63xx
header file. Move them to include/linux/bcm63xx_wdt.h so that they are
also available on other machine types.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 MAINTAINERS                                       |  1 +
 arch/mips/bcm63xx/prom.c                          |  1 +
 arch/mips/bcm63xx/setup.c                         |  1 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 22 --------------------
 drivers/watchdog/bcm63xx_wdt.c                    | 25 +++++++++++------------
 include/linux/bcm63xx_wdt.h                       | 22 ++++++++++++++++++++
 6 files changed, 37 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/bcm63xx_wdt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 63bf54a..a27b99f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2376,6 +2376,7 @@ F:	arch/mips/boot/dts/brcm/bcm*.dts*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
+F:	include/linux/bcm63xx_wdt.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 7019e29..d2800fb 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
  */
 
+#include <linux/bcm63xx_wdt.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/smp.h>
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 240fb4f..d1d666d 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
  */
 
+#include <linux/bcm63xx_wdt.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 5035f09..16a745b 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -441,28 +441,6 @@
 
 
 /*************************************************************************
- * _REG relative to RSET_WDT
- *************************************************************************/
-
-/* Watchdog default count register */
-#define WDT_DEFVAL_REG			0x0
-
-/* Watchdog control register */
-#define WDT_CTL_REG			0x4
-
-/* Watchdog control register constants */
-#define WDT_START_1			(0xff00)
-#define WDT_START_2			(0x00ff)
-#define WDT_STOP_1			(0xee00)
-#define WDT_STOP_2			(0x00ee)
-
-/* Watchdog reset length register */
-#define WDT_RSTLEN_REG			0x8
-
-/* Watchdog soft reset register (BCM6328 only) */
-#define WDT_SOFTRESET_REG		0xc
-
-/*************************************************************************
  * _REG relative to RSET_GPIO
  *************************************************************************/
 
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 7109eb4..7522624 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bcm63xx_wdt.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -27,8 +28,6 @@
 #include <linux/resource.h>
 #include <linux/platform_device.h>
 
-#include <bcm63xx_cpu.h>
-#include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_timer.h>
 
@@ -55,9 +54,9 @@ static int bcm63xx_wdt_start(struct watchdog_device *wdd)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&hw->lock, flags);
-	bcm_writel(wdd->timeout * hw->clock_hz, hw->regs + WDT_DEFVAL_REG);
-	bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
-	bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
+	__raw_writel(wdd->timeout * hw->clock_hz, hw->regs + WDT_DEFVAL_REG);
+	__raw_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
+	__raw_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
 	hw->running = true;
 	raw_spin_unlock_irqrestore(&hw->lock, flags);
 	return 0;
@@ -69,8 +68,8 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&hw->lock, flags);
-	bcm_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
-	bcm_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
+	__raw_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
+	__raw_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
 	hw->running = false;
 	raw_spin_unlock_irqrestore(&hw->lock, flags);
 	return 0;
@@ -106,10 +105,10 @@ static void bcm63xx_wdt_isr(void *data)
 	raw_spin_lock_irqsave(&hw->lock, flags);
 	if (!hw->running) {
 		/* Stop the watchdog as it shouldn't be running */
-		bcm_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
-		bcm_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
+		__raw_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
+		__raw_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
 	} else {
-		u32 timeleft = bcm_readl(hw->regs + WDT_CTL_REG);
+		u32 timeleft = __raw_readl(hw->regs + WDT_CTL_REG);
 		u32 ms;
 
 		if (timeleft >= 2) {
@@ -123,9 +122,9 @@ static void bcm63xx_wdt_isr(void *data)
 			 * This is done with a lock held in case userspace is
 			 * trying to restart the watchdog on another CPU.
 			 */
-			bcm_writel(timeleft, hw->regs + WDT_DEFVAL_REG);
-			bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
-			bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
+			__raw_writel(timeleft, hw->regs + WDT_DEFVAL_REG);
+			__raw_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
+			__raw_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
 		} else {
 			/* The watchdog cannot be started with a time of less
 			 * than 2 ticks (it won't fire).
diff --git a/include/linux/bcm63xx_wdt.h b/include/linux/bcm63xx_wdt.h
new file mode 100644
index 0000000..2e9210b
--- /dev/null
+++ b/include/linux/bcm63xx_wdt.h
@@ -0,0 +1,22 @@
+#ifndef LINUX_BCM63XX_WDT_H_
+#define LINUX_BCM63XX_WDT_H_
+
+/* Watchdog default count register */
+#define WDT_DEFVAL_REG                  0x0
+
+/* Watchdog control register */
+#define WDT_CTL_REG                     0x4
+
+/* Watchdog control register constants */
+#define WDT_START_1                     (0xff00)
+#define WDT_START_2                     (0x00ff)
+#define WDT_STOP_1                      (0xee00)
+#define WDT_STOP_2                      (0x00ee)
+
+/* Watchdog reset length register */
+#define WDT_RSTLEN_REG                  0x8
+
+/* Watchdog soft reset register (BCM6328 only) */
+#define WDT_SOFTRESET_REG               0xc
+
+#endif
-- 
2.1.4

-- 
Simon Arlott
