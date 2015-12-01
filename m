Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 14:05:01 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53908 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008078AbbLANE7o4WJd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 14:04:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=6AMI6HgxJWxdrMl4y3RvnLbU5InwfgltO6EL2ev0vjE=;
        b=gq+4UxnL1pn9ek0l3flMYyzSVZRESPV4ggq5XQfEgXYBnkOO1U6v2Vb/S2IZa3VXXA6xPhGl1CAqpTVD1fTu42T0euwHYArnMIKsdLuFY3b/9XkoHW/K+PpVfImHTIcs5x0+ZW4dZtlfeL5qu9MpdGSCYfuJvA5YM7re6mjLwG79TzAhuo2cOBTKoaxFx1fGk1VlG31HUVyts4QAbMW9srgPzKRrc9fyYXs38SHLB/MPndwh6sgN7T7Cnotr+2B4pP13Z6hT0k0pwY76XywNpBrANOzHH9h8FXdbk6XGFckNOQhMEFsCcB/MKxAAjUCcl26xJwRjfRqrqj9Nf5FN9w==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45581 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3kbu-0007hU-Rl (Exim); Tue, 01 Dec 2015 13:04:47 +0000
Subject: [PATCH 04/11] watchdog: bcm63xx_wdt: Handle hardware interrupt and
 remove software timer
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <565D9A40.60409@simon.arlott.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565D9AED.5080508@simon.arlott.org.uk>
Date:   Tue, 1 Dec 2015 13:04:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50255
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

There is a level triggered interrupt for the watchdog timer as part of
the bcm63xx_timer device. The interrupt occurs when the hardware watchdog
timer reaches 50% of the remaining time.

It is not possible to mask the interrupt within the bcm63xx_timer device.
To get around this limitation, handle the interrupt by restarting the
watchdog with the current remaining time (which will be half the previous
timeout) so that the interrupt occurs again at 1/4th, 1/8th, etc. of the
original timeout value until the watchdog forces a reboot.

The software timer was restarting the hardware watchdog with a 85 second
timeout until the software timer expired, and then causing a panic()
about 42.5 seconds later when the hardware interrupt occurred. The
hardware watchdog would not reboot until a further 42.5 seconds had
passed.

Remove the software timer and rely on the hardware timer directly,
reducing the maximum timeout from 256 seconds to 85 seconds
(2^32 / WDT_HZ).

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/watchdog/bcm63xx_wdt.c | 125 ++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 52 deletions(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index ab26fd9..3f55cba 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2007, Miguel Gaio <miguel.gaio@efixo.com>
  *  Copyright (C) 2008, Florian Fainelli <florian@openwrt.org>
+ *  Copyright 2015 Simon Arlott
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -20,11 +21,10 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
-#include <linux/timer.h>
-#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 #include <linux/resource.h>
@@ -37,16 +37,17 @@
 
 #define PFX KBUILD_MODNAME
 
-#define WDT_HZ		50000000 /* Fclk */
-#define WDT_DEFAULT_TIME	30      /* seconds */
-#define WDT_MAX_TIME		256     /* seconds */
+#define WDT_HZ			50000000		/* Fclk */
+#define WDT_DEFAULT_TIME	30			/* seconds */
+#define WDT_MAX_TIME		(0xffffffff / WDT_HZ)	/* seconds */
 
-static struct {
+struct bcm63xx_wdt_hw {
+	raw_spinlock_t lock;
 	void __iomem *regs;
-	struct timer_list timer;
 	unsigned long inuse;
-	atomic_t ticks;
-} bcm63xx_wdt_device;
+	bool running;
+};
+static struct bcm63xx_wdt_hw bcm63xx_wdt_device;
 
 static int expect_close;
 
@@ -59,48 +60,67 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 /* HW functions */
 static void bcm63xx_wdt_hw_start(void)
 {
-	bcm_writel(0xfffffffe, bcm63xx_wdt_device.regs + WDT_DEFVAL_REG);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&bcm63xx_wdt_device.lock, flags);
+	bcm_writel(wdt_time * WDT_HZ, bcm63xx_wdt_device.regs + WDT_DEFVAL_REG);
 	bcm_writel(WDT_START_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
 	bcm_writel(WDT_START_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
+	bcm63xx_wdt_device.running = true;
+	raw_spin_unlock_irqrestore(&bcm63xx_wdt_device.lock, flags);
 }
 
 static void bcm63xx_wdt_hw_stop(void)
 {
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&bcm63xx_wdt_device.lock, flags);
 	bcm_writel(WDT_STOP_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
 	bcm_writel(WDT_STOP_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
+	bcm63xx_wdt_device.running = false;
+	raw_spin_unlock_irqrestore(&bcm63xx_wdt_device.lock, flags);
 }
 
+/* The watchdog interrupt occurs when half the timeout is remaining */
 static void bcm63xx_wdt_isr(void *data)
 {
-	struct pt_regs *regs = get_irq_regs();
-
-	die(PFX " fire", regs);
-}
-
-static void bcm63xx_timer_tick(unsigned long unused)
-{
-	if (!atomic_dec_and_test(&bcm63xx_wdt_device.ticks)) {
-		bcm63xx_wdt_hw_start();
-		mod_timer(&bcm63xx_wdt_device.timer, jiffies + HZ);
-	} else
-		pr_crit("watchdog will restart system\n");
-}
-
-static void bcm63xx_wdt_pet(void)
-{
-	atomic_set(&bcm63xx_wdt_device.ticks, wdt_time);
-}
-
-static void bcm63xx_wdt_start(void)
-{
-	bcm63xx_wdt_pet();
-	bcm63xx_timer_tick(0);
-}
+	struct bcm63xx_wdt_hw *hw = &bcm63xx_wdt_device;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	if (!hw->running) {
+		/* Stop the watchdog as it shouldn't be running */
+		bcm_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
+		bcm_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
+	} else {
+		u32 timeleft = bcm_readl(hw->regs + WDT_CTL_REG);
+		u32 ms;
+
+		if (timeleft >= 2) {
+			/* The only way to clear this level triggered interrupt
+			 * without disrupting the normal running of the watchdog
+			 * is to restart the watchdog with the current remaining
+			 * time value (which will be half the previous timeout)
+			 * so the interrupt occurs again at 1/4th, 1/8th, etc.
+			 * of the original timeout value until we reboot.
+			 *
+			 * This is done with a lock held in case userspace is
+			 * trying to restart the watchdog on another CPU.
+			 */
+			bcm_writel(timeleft, hw->regs + WDT_DEFVAL_REG);
+			bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
+			bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
+		} else {
+			/* The watchdog cannot be started with a time of less
+			 * than 2 ticks (it won't fire).
+			 */
+			die(PFX ": watchdog timer expired\n", get_irq_regs());
+		}
 
-static void bcm63xx_wdt_pause(void)
-{
-	del_timer_sync(&bcm63xx_wdt_device.timer);
-	bcm63xx_wdt_hw_stop();
+		ms = timeleft / (WDT_HZ / 1000);
+		pr_alert("warning timer fired, reboot in %ums\n", ms);
+	}
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
 }
 
 static int bcm63xx_wdt_settimeout(int new_time)
@@ -118,17 +138,17 @@ static int bcm63xx_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(0, &bcm63xx_wdt_device.inuse))
 		return -EBUSY;
 
-	bcm63xx_wdt_start();
+	bcm63xx_wdt_hw_start();
 	return nonseekable_open(inode, file);
 }
 
 static int bcm63xx_wdt_release(struct inode *inode, struct file *file)
 {
 	if (expect_close == 42)
-		bcm63xx_wdt_pause();
+		bcm63xx_wdt_hw_stop();
 	else {
 		pr_crit("Unexpected close, not stopping watchdog!\n");
-		bcm63xx_wdt_start();
+		bcm63xx_wdt_hw_start();
 	}
 	clear_bit(0, &bcm63xx_wdt_device.inuse);
 	expect_close = 0;
@@ -153,7 +173,7 @@ static ssize_t bcm63xx_wdt_write(struct file *file, const char *data,
 					expect_close = 42;
 			}
 		}
-		bcm63xx_wdt_pet();
+		bcm63xx_wdt_hw_start();
 	}
 	return len;
 }
@@ -187,18 +207,18 @@ static long bcm63xx_wdt_ioctl(struct file *file, unsigned int cmd,
 			return -EFAULT;
 
 		if (new_value & WDIOS_DISABLECARD) {
-			bcm63xx_wdt_pause();
+			bcm63xx_wdt_hw_stop();
 			retval = 0;
 		}
 		if (new_value & WDIOS_ENABLECARD) {
-			bcm63xx_wdt_start();
+			bcm63xx_wdt_hw_start();
 			retval = 0;
 		}
 
 		return retval;
 
 	case WDIOC_KEEPALIVE:
-		bcm63xx_wdt_pet();
+		bcm63xx_wdt_hw_start();
 		return 0;
 
 	case WDIOC_SETTIMEOUT:
@@ -208,7 +228,7 @@ static long bcm63xx_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (bcm63xx_wdt_settimeout(new_value))
 			return -EINVAL;
 
-		bcm63xx_wdt_pet();
+		bcm63xx_wdt_hw_start();
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(wdt_time, p);
@@ -240,8 +260,6 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	int ret;
 	struct resource *r;
 
-	setup_timer(&bcm63xx_wdt_device.timer, bcm63xx_timer_tick, 0L);
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "failed to get resources\n");
@@ -255,6 +273,9 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	raw_spin_lock_init(&bcm63xx_wdt_device.lock);
+	bcm63xx_wdt_device.running = false;
+
 	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, NULL);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
@@ -264,8 +285,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 	if (bcm63xx_wdt_settimeout(wdt_time)) {
 		bcm63xx_wdt_settimeout(WDT_DEFAULT_TIME);
 		dev_info(&pdev->dev,
-			": wdt_time value must be 1 <= wdt_time <= 256, using %d\n",
-			wdt_time);
+			": wdt_time value must be 1 <= wdt_time <= %d, using %d\n",
+			WDT_MAX_TIME, wdt_time);
 	}
 
 	ret = misc_register(&bcm63xx_wdt_miscdev);
@@ -287,7 +308,7 @@ unregister_timer:
 static int bcm63xx_wdt_remove(struct platform_device *pdev)
 {
 	if (!nowayout)
-		bcm63xx_wdt_pause();
+		bcm63xx_wdt_hw_stop();
 
 	misc_deregister(&bcm63xx_wdt_miscdev);
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
@@ -296,7 +317,7 @@ static int bcm63xx_wdt_remove(struct platform_device *pdev)
 
 static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 {
-	bcm63xx_wdt_pause();
+	bcm63xx_wdt_hw_stop();
 }
 
 static struct platform_driver bcm63xx_wdt_driver = {
-- 
2.1.4


-- 
Simon Arlott
