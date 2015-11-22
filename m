Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 15:13:12 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:54674 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007233AbbKVONIrFras (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 15:13:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=tE3ABcFwxtu9g1AIrXG8vny/GHK49c3SptP2izby8Wc=;
        b=VzHoqMbfSR8oxsRDOrpBUz/Thx0/+tlkuTP/6DHUCkO0bJf0LV0+YrmxmSt1Fszvcc1OyNZnsZzsfdJceV7YzyBhdmscz+0EyMFTibZG5gTp6Qy2ehsB5tMxuaGQV4N7Ke7fry4lOE/IhIHPg0EJvSmeqnG5TRXzUtKNglc0ID/tV+JdVKcDvNz48aUjsEm4pFYzeEbHCA5aS3gEM/0nsSkwd1fjz3SlYKxO6WfEUQOJ0Pbbu0Iy2J4tOkcnTmVczXafNvYmHbwrvGAl8s9E02FWSO2p4qNrBSxzx+FCKpmvLD4s5tGPbIXEGOiaF9KDV0XJTFN13qwJ4GnxEnlsvw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60504 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0VNy-0001dE-Ct (Exim); Sun, 22 Nov 2015 14:12:59 +0000
Subject: [PATCH 9/10] watchdog: bcm63xx_wdt: Use bcm63xx_timer interrupt
 directly
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
Message-ID: <5651CD67.6090507@simon.arlott.org.uk>
Date:   Sun, 22 Nov 2015 14:12:55 +0000
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
X-archive-position: 50046
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

There is only one user of bcm63xx_timer and that is the watchdog.
To allow the watchdog driver to be used on machine types other than
mach-bcm63xx, it needs to use an interrupt instead of a custom register
function.

Modify bcm63xx_timer to only disable the timers (so that they don't
interfere with the watchdog if an interrupt occurs) and remove its
exported functions.

Use the timer interrupt directly in bcm63xx_wdt.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 arch/mips/bcm63xx/dev-wdt.c                        |   7 +
 arch/mips/bcm63xx/timer.c                          | 181 +--------------------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h |  11 --
 drivers/watchdog/bcm63xx_wdt.c                     |  45 +++--
 4 files changed, 38 insertions(+), 206 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h

diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
index 2a2346a..a7a5497 100644
--- a/arch/mips/bcm63xx/dev-wdt.c
+++ b/arch/mips/bcm63xx/dev-wdt.c
@@ -17,6 +17,11 @@ static struct resource wdt_resources[] = {
 		.end		= -1, /* filled at runtime */
 		.flags		= IORESOURCE_MEM,
 	},
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device bcm63xx_wdt_device = {
@@ -32,6 +37,8 @@ int __init bcm63xx_wdt_register(void)
 	wdt_resources[0].end = wdt_resources[0].start;
 	wdt_resources[0].end += RSET_WDT_SIZE - 1;
 
+	wdt_resources[1].start = bcm63xx_get_irq_number(IRQ_TIMER);
+
 	return platform_device_register(&bcm63xx_wdt_device);
 }
 arch_initcall(bcm63xx_wdt_register);
diff --git a/arch/mips/bcm63xx/timer.c b/arch/mips/bcm63xx/timer.c
index 5f11359..9c7b41a6 100644
--- a/arch/mips/bcm63xx/timer.c
+++ b/arch/mips/bcm63xx/timer.c
@@ -9,196 +9,23 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/clk.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
-#include <bcm63xx_timer.h>
 #include <bcm63xx_regs.h>
 
-static DEFINE_RAW_SPINLOCK(timer_reg_lock);
-static DEFINE_RAW_SPINLOCK(timer_data_lock);
-static struct clk *periph_clk;
-
-static struct timer_data {
-	void	(*cb)(void *);
-	void	*data;
-} timer_data[BCM63XX_TIMER_COUNT];
-
-static irqreturn_t timer_interrupt(int irq, void *dev_id)
-{
-	u32 stat;
-	int i;
-
-	raw_spin_lock(&timer_reg_lock);
-	stat = bcm_timer_readl(TIMER_IRQSTAT_REG);
-	bcm_timer_writel(stat, TIMER_IRQSTAT_REG);
-	raw_spin_unlock(&timer_reg_lock);
-
-	for (i = 0; i < BCM63XX_TIMER_COUNT; i++) {
-		if (!(stat & TIMER_IRQSTAT_TIMER_CAUSE(i)))
-			continue;
-
-		raw_spin_lock(&timer_data_lock);
-		if (!timer_data[i].cb) {
-			raw_spin_unlock(&timer_data_lock);
-			continue;
-		}
-
-		timer_data[i].cb(timer_data[i].data);
-		raw_spin_unlock(&timer_data_lock);
-	}
-
-	return IRQ_HANDLED;
-}
-
-int bcm63xx_timer_enable(int id)
-{
-	u32 reg;
-	unsigned long flags;
-
-	if (id >= BCM63XX_TIMER_COUNT)
-		return -EINVAL;
-
-	raw_spin_lock_irqsave(&timer_reg_lock, flags);
-
-	reg = bcm_timer_readl(TIMER_CTLx_REG(id));
-	reg |= TIMER_CTL_ENABLE_MASK;
-	bcm_timer_writel(reg, TIMER_CTLx_REG(id));
-
-	reg = bcm_timer_readl(TIMER_IRQSTAT_REG);
-	reg |= TIMER_IRQSTAT_TIMER_IR_EN(id);
-	bcm_timer_writel(reg, TIMER_IRQSTAT_REG);
-
-	raw_spin_unlock_irqrestore(&timer_reg_lock, flags);
-	return 0;
-}
-
-EXPORT_SYMBOL(bcm63xx_timer_enable);
-
-int bcm63xx_timer_disable(int id)
+static int bcm63xx_timer_init(void)
 {
 	u32 reg;
-	unsigned long flags;
-
-	if (id >= BCM63XX_TIMER_COUNT)
-		return -EINVAL;
-
-	raw_spin_lock_irqsave(&timer_reg_lock, flags);
-
-	reg = bcm_timer_readl(TIMER_CTLx_REG(id));
-	reg &= ~TIMER_CTL_ENABLE_MASK;
-	bcm_timer_writel(reg, TIMER_CTLx_REG(id));
-
-	reg = bcm_timer_readl(TIMER_IRQSTAT_REG);
-	reg &= ~TIMER_IRQSTAT_TIMER_IR_EN(id);
-	bcm_timer_writel(reg, TIMER_IRQSTAT_REG);
-
-	raw_spin_unlock_irqrestore(&timer_reg_lock, flags);
-	return 0;
-}
-
-EXPORT_SYMBOL(bcm63xx_timer_disable);
-
-int bcm63xx_timer_register(int id, void (*callback)(void *data), void *data)
-{
-	unsigned long flags;
-	int ret;
-
-	if (id >= BCM63XX_TIMER_COUNT || !callback)
-		return -EINVAL;
-
-	ret = 0;
-	raw_spin_lock_irqsave(&timer_data_lock, flags);
-	if (timer_data[id].cb) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	timer_data[id].cb = callback;
-	timer_data[id].data = data;
-
-out:
-	raw_spin_unlock_irqrestore(&timer_data_lock, flags);
-	return ret;
-}
-
-EXPORT_SYMBOL(bcm63xx_timer_register);
-
-void bcm63xx_timer_unregister(int id)
-{
-	unsigned long flags;
-
-	if (id >= BCM63XX_TIMER_COUNT)
-		return;
-
-	raw_spin_lock_irqsave(&timer_data_lock, flags);
-	timer_data[id].cb = NULL;
-	raw_spin_unlock_irqrestore(&timer_data_lock, flags);
-}
-
-EXPORT_SYMBOL(bcm63xx_timer_unregister);
-
-unsigned int bcm63xx_timer_countdown(unsigned int countdown_us)
-{
-	return (clk_get_rate(periph_clk) / (1000 * 1000)) * countdown_us;
-}
-
-EXPORT_SYMBOL(bcm63xx_timer_countdown);
-
-int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us)
-{
-	u32 reg, countdown;
-	unsigned long flags;
-
-	if (id >= BCM63XX_TIMER_COUNT)
-		return -EINVAL;
-
-	countdown = bcm63xx_timer_countdown(countdown_us);
-	if (countdown & ~TIMER_CTL_COUNTDOWN_MASK)
-		return -EINVAL;
-
-	raw_spin_lock_irqsave(&timer_reg_lock, flags);
-	reg = bcm_timer_readl(TIMER_CTLx_REG(id));
-
-	if (monotonic)
-		reg &= ~TIMER_CTL_MONOTONIC_MASK;
-	else
-		reg |= TIMER_CTL_MONOTONIC_MASK;
-
-	reg &= ~TIMER_CTL_COUNTDOWN_MASK;
-	reg |= countdown;
-	bcm_timer_writel(reg, TIMER_CTLx_REG(id));
-
-	raw_spin_unlock_irqrestore(&timer_reg_lock, flags);
-	return 0;
-}
-
-EXPORT_SYMBOL(bcm63xx_timer_set);
-
-int bcm63xx_timer_init(void)
-{
-	int ret, irq;
-	u32 reg;
 
+	/* Disable all timers so that they won't interfere with use of the
+	 * timer interrupt by the watchdog.
+	 */
 	reg = bcm_timer_readl(TIMER_IRQSTAT_REG);
 	reg &= ~TIMER_IRQSTAT_TIMER0_IR_EN;
 	reg &= ~TIMER_IRQSTAT_TIMER1_IR_EN;
 	reg &= ~TIMER_IRQSTAT_TIMER2_IR_EN;
 	bcm_timer_writel(reg, TIMER_IRQSTAT_REG);
 
-	periph_clk = clk_get(NULL, "periph");
-	if (IS_ERR(periph_clk))
-		return -ENODEV;
-
-	irq = bcm63xx_get_irq_number(IRQ_TIMER);
-	ret = request_irq(irq, timer_interrupt, 0, "bcm63xx_timer", NULL);
-	if (ret) {
-		printk(KERN_ERR "bcm63xx_timer: failed to register irq\n");
-		return ret;
-	}
-
 	return 0;
 }
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
deleted file mode 100644
index c0fce83..0000000
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef BCM63XX_TIMER_H_
-#define BCM63XX_TIMER_H_
-
-int bcm63xx_timer_register(int id, void (*callback)(void *data), void *data);
-void bcm63xx_timer_unregister(int id);
-int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us);
-int bcm63xx_timer_enable(int id);
-int bcm63xx_timer_disable(int id);
-unsigned int bcm63xx_timer_countdown(unsigned int countdown_us);
-
-#endif /* !BCM63XX_TIMER_H_ */
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 7522624..9989efe 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -28,9 +29,6 @@
 #include <linux/resource.h>
 #include <linux/platform_device.h>
 
-#include <bcm63xx_regs.h>
-#include <bcm63xx_timer.h>
-
 #define PFX KBUILD_MODNAME
 
 #define WDT_CLK_NAME		"periph"
@@ -40,6 +38,7 @@ struct bcm63xx_wdt_hw {
 	void __iomem *regs;
 	struct clk *clk;
 	unsigned long clock_hz;
+	int irq;
 	bool running;
 };
 
@@ -96,7 +95,7 @@ static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
 }
 
 /* The watchdog interrupt occurs when half the timeout is remaining */
-static void bcm63xx_wdt_isr(void *data)
+static irqreturn_t bcm63xx_wdt_interrupt(int irq, void *data)
 {
 	struct watchdog_device *wdd = data;
 	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
@@ -137,6 +136,7 @@ static void bcm63xx_wdt_isr(void *data)
 			"warning timer fired, reboot in %ums\n", ms);
 	}
 	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return IRQ_HANDLED;
 }
 
 static struct watchdog_ops bcm63xx_wdt_ops = {
@@ -229,30 +229,37 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		timeleft = 0;
 	}
 
-	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, wdd);
+	ret = watchdog_register_device(wdd);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
+		dev_err(&pdev->dev, "failed to register watchdog device\n");
 		goto disable_clk;
 	}
 
-	ret = watchdog_register_device(wdd);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		goto unregister_timer;
+	hw->irq = platform_get_irq(pdev, 0);
+	if (hw->irq >= 0) {
+		ret = devm_request_irq(&pdev->dev, hw->irq,
+			bcm63xx_wdt_interrupt, IRQF_TIMER,
+			dev_name(&pdev->dev), wdd);
+		if (ret)
+			hw->irq = -1;
 	}
 
-	dev_info(&pdev->dev,
-		"%s at MMIO 0x%p (timeout = %us, max_timeout = %us)",
-		dev_name(wdd->dev), hw->regs,
-		wdd->timeout, wdd->max_timeout);
+	if (hw->irq >= 0) {
+		dev_info(&pdev->dev,
+			"%s at MMIO 0x%p (irq = %d, timeout = %us, max_timeout = %us)",
+			dev_name(wdd->dev), hw->regs, hw->irq,
+			wdd->timeout, wdd->max_timeout);
+	} else {
+		dev_info(&pdev->dev,
+			"%s at MMIO 0x%p (timeout = %us, max_timeout = %us)",
+			dev_name(wdd->dev), hw->regs,
+			wdd->timeout, wdd->max_timeout);
+	}
 
 	if (timeleft > 0)
 		dev_alert(wdd->dev, "running, reboot in %us\n", timeleft);
 	return 0;
 
-unregister_timer:
-	bcm63xx_timer_unregister(TIMER_WDT_ID);
-
 disable_clk:
 	clk_disable_unprepare(hw->clk);
 	return ret;
@@ -263,7 +270,9 @@ static int bcm63xx_wdt_remove(struct platform_device *pdev)
 	struct watchdog_device *wdd = platform_get_drvdata(pdev);
 	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
 
-	bcm63xx_timer_unregister(TIMER_WDT_ID);
+	if (hw->irq >= 0)
+		devm_free_irq(&pdev->dev, hw->irq, wdd);
+
 	watchdog_unregister_device(wdd);
 	clk_disable_unprepare(hw->clk);
 	return 0;
-- 
2.1.4

-- 
Simon Arlott
