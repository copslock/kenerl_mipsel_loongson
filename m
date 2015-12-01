Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 14:05:51 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53938 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008078AbbLANFtpPO-d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 14:05:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=wpLzqIeK7IAlih0FxyZWzJqigl46huu04mh/wIyXmw8=;
        b=EFchpnUeeM5eK2wtuTEFKiJRV3sFLpAaHv8VOFwOy1iHCvParVgZkRap4OMBInNusmzY6s/zG91usU2opQN8mIA6J3mqliaxUE+lczyz99X4qST7AOu7ee7lFw2NHiZZe4IgIguxhO2KQ/m8l8qYU1uwu8jek0ByfoLhPSZEFAzcm5nxjlxo8RPJCsjUve6F9QAmRWhsxLxNXGfhTQHklT9Ev1Gl6U0bHa2SxpZX0f3h+j6IygLhYUd6tA9AE0Bn/EGfEB+rBMSCHmuXw0H8zrDbGrWrQSL88n2pZrcCV7j92npntUMI+X3RHKB99bRxAx8PI6vPskNDi1hQFF5bzQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45583 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3kci-0007ju-04 (Exim); Tue, 01 Dec 2015 13:05:38 +0000
Subject: [PATCH 05/11] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
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
Message-ID: <565D9B1D.3060009@simon.arlott.org.uk>
Date:   Tue, 1 Dec 2015 13:05:33 +0000
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
X-archive-position: 50256
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

Convert bcm63xx_wdt to use WATCHDOG_CORE.

The default and maximum time constants that are only used once have been
moved to the initialisation of the struct watchdog_device.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/watchdog/Kconfig       |   1 +
 drivers/watchdog/bcm63xx_wdt.c | 259 +++++++++++++----------------------------
 2 files changed, 79 insertions(+), 181 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7a8a6c6..6815b74 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1273,6 +1273,7 @@ config OCTEON_WDT
 config BCM63XX_WDT
 	tristate "Broadcom BCM63xx hardware watchdog"
 	depends on BCM63XX
+	select WATCHDOG_CORE
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
 	  BCM63xx SoC.
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 3f55cba..2257924 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -13,20 +13,15 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/bitops.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <linux/interrupt.h>
-#include <linux/ptrace.h>
 #include <linux/resource.h>
 #include <linux/platform_device.h>
 
@@ -38,53 +33,59 @@
 #define PFX KBUILD_MODNAME
 
 #define WDT_HZ			50000000		/* Fclk */
-#define WDT_DEFAULT_TIME	30			/* seconds */
-#define WDT_MAX_TIME		(0xffffffff / WDT_HZ)	/* seconds */
 
 struct bcm63xx_wdt_hw {
+	struct watchdog_device wdd;
 	raw_spinlock_t lock;
 	void __iomem *regs;
-	unsigned long inuse;
 	bool running;
 };
-static struct bcm63xx_wdt_hw bcm63xx_wdt_device;
 
-static int expect_close;
+#define to_wdt_hw(x) container_of(x, struct bcm63xx_wdt_hw, wdd)
 
-static int wdt_time = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-/* HW functions */
-static void bcm63xx_wdt_hw_start(void)
+static int bcm63xx_wdt_start(struct watchdog_device *wdd)
 {
+	struct bcm63xx_wdt_hw *hw = to_wdt_hw(wdd);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&bcm63xx_wdt_device.lock, flags);
-	bcm_writel(wdt_time * WDT_HZ, bcm63xx_wdt_device.regs + WDT_DEFVAL_REG);
-	bcm_writel(WDT_START_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-	bcm_writel(WDT_START_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-	bcm63xx_wdt_device.running = true;
-	raw_spin_unlock_irqrestore(&bcm63xx_wdt_device.lock, flags);
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	bcm_writel(wdd->timeout * WDT_HZ, hw->regs + WDT_DEFVAL_REG);
+	bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
+	bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
+	hw->running = true;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return 0;
 }
 
-static void bcm63xx_wdt_hw_stop(void)
+static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 {
+	struct bcm63xx_wdt_hw *hw = to_wdt_hw(wdd);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&bcm63xx_wdt_device.lock, flags);
-	bcm_writel(WDT_STOP_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-	bcm_writel(WDT_STOP_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-	bcm63xx_wdt_device.running = false;
-	raw_spin_unlock_irqrestore(&bcm63xx_wdt_device.lock, flags);
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	bcm_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
+	bcm_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
+	hw->running = false;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return 0;
+}
+
+static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
+	unsigned int timeout)
+{
+	wdd->timeout = timeout;
+	return 0;
 }
 
 /* The watchdog interrupt occurs when half the timeout is remaining */
 static void bcm63xx_wdt_isr(void *data)
 {
-	struct bcm63xx_wdt_hw *hw = &bcm63xx_wdt_device;
+	struct bcm63xx_wdt_hw *hw = data;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&hw->lock, flags);
@@ -118,147 +119,36 @@ static void bcm63xx_wdt_isr(void *data)
 		}
 
 		ms = timeleft / (WDT_HZ / 1000);
-		pr_alert("warning timer fired, reboot in %ums\n", ms);
+		dev_alert(hw->wdd.dev,
+			"warning timer fired, reboot in %ums\n", ms);
 	}
 	raw_spin_unlock_irqrestore(&hw->lock, flags);
 }
 
-static int bcm63xx_wdt_settimeout(int new_time)
-{
-	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
-		return -EINVAL;
-
-	wdt_time = new_time;
-
-	return 0;
-}
-
-static int bcm63xx_wdt_open(struct inode *inode, struct file *file)
-{
-	if (test_and_set_bit(0, &bcm63xx_wdt_device.inuse))
-		return -EBUSY;
-
-	bcm63xx_wdt_hw_start();
-	return nonseekable_open(inode, file);
-}
-
-static int bcm63xx_wdt_release(struct inode *inode, struct file *file)
-{
-	if (expect_close == 42)
-		bcm63xx_wdt_hw_stop();
-	else {
-		pr_crit("Unexpected close, not stopping watchdog!\n");
-		bcm63xx_wdt_hw_start();
-	}
-	clear_bit(0, &bcm63xx_wdt_device.inuse);
-	expect_close = 0;
-	return 0;
-}
-
-static ssize_t bcm63xx_wdt_write(struct file *file, const char *data,
-				size_t len, loff_t *ppos)
-{
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			/* In case it was set long ago */
-			expect_close = 0;
-
-			for (i = 0; i != len; i++) {
-				char c;
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_close = 42;
-			}
-		}
-		bcm63xx_wdt_hw_start();
-	}
-	return len;
-}
-
-static struct watchdog_info bcm63xx_wdt_info = {
-	.identity       = PFX,
-	.options        = WDIOF_SETTIMEOUT |
-				WDIOF_KEEPALIVEPING |
-				WDIOF_MAGICCLOSE,
+static struct watchdog_ops bcm63xx_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = bcm63xx_wdt_start,
+	.stop = bcm63xx_wdt_stop,
+	.set_timeout = bcm63xx_wdt_set_timeout,
 };
 
-
-static long bcm63xx_wdt_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int new_value, retval = -EINVAL;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &bcm63xx_wdt_info,
-			sizeof(bcm63xx_wdt_info)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-
-	case WDIOC_SETOPTIONS:
-		if (get_user(new_value, p))
-			return -EFAULT;
-
-		if (new_value & WDIOS_DISABLECARD) {
-			bcm63xx_wdt_hw_stop();
-			retval = 0;
-		}
-		if (new_value & WDIOS_ENABLECARD) {
-			bcm63xx_wdt_hw_start();
-			retval = 0;
-		}
-
-		return retval;
-
-	case WDIOC_KEEPALIVE:
-		bcm63xx_wdt_hw_start();
-		return 0;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_value, p))
-			return -EFAULT;
-
-		if (bcm63xx_wdt_settimeout(new_value))
-			return -EINVAL;
-
-		bcm63xx_wdt_hw_start();
-
-	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_time, p);
-
-	default:
-		return -ENOTTY;
-
-	}
-}
-
-static const struct file_operations bcm63xx_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= bcm63xx_wdt_write,
-	.unlocked_ioctl	= bcm63xx_wdt_ioctl,
-	.open		= bcm63xx_wdt_open,
-	.release	= bcm63xx_wdt_release,
-};
-
-static struct miscdevice bcm63xx_wdt_miscdev = {
-	.minor	= WATCHDOG_MINOR,
-	.name	= "watchdog",
-	.fops	= &bcm63xx_wdt_fops,
+static const struct watchdog_info bcm63xx_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "BCM63xx Watchdog",
 };
 
-
 static int bcm63xx_wdt_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct bcm63xx_wdt_hw *hw;
+	struct watchdog_device *wdd;
 	struct resource *r;
+	int ret;
+
+	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	wdd = &hw->wdd;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -266,58 +156,65 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bcm63xx_wdt_device.regs = devm_ioremap_nocache(&pdev->dev, r->start,
-							resource_size(r));
-	if (!bcm63xx_wdt_device.regs) {
+	hw->regs = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
+	if (!hw->regs) {
 		dev_err(&pdev->dev, "failed to remap I/O resources\n");
 		return -ENXIO;
 	}
 
-	raw_spin_lock_init(&bcm63xx_wdt_device.lock);
-	bcm63xx_wdt_device.running = false;
+	raw_spin_lock_init(&hw->lock);
+	hw->running = false;
 
-	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, NULL);
+	wdd->parent = &pdev->dev;
+	wdd->ops = &bcm63xx_wdt_ops;
+	wdd->info = &bcm63xx_wdt_info;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = 0xffffffff / WDT_HZ;
+	wdd->timeout = min(30U, wdd->max_timeout);
+
+	platform_set_drvdata(pdev, hw);
+
+	watchdog_init_timeout(wdd, 0, &pdev->dev);
+	watchdog_set_nowayout(wdd, nowayout);
+
+	ret = watchdog_register_device(wdd);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
+		dev_err(&pdev->dev, "failed to register watchdog device\n");
 		return ret;
 	}
 
-	if (bcm63xx_wdt_settimeout(wdt_time)) {
-		bcm63xx_wdt_settimeout(WDT_DEFAULT_TIME);
-		dev_info(&pdev->dev,
-			": wdt_time value must be 1 <= wdt_time <= %d, using %d\n",
-			WDT_MAX_TIME, wdt_time);
-	}
-
-	ret = misc_register(&bcm63xx_wdt_miscdev);
+	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, hw);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		goto unregister_timer;
+		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
+		goto unregister_watchdog;
 	}
 
-	dev_info(&pdev->dev, " started, timer margin: %d sec\n",
-						WDT_DEFAULT_TIME);
+	dev_info(&pdev->dev,
+		"%s at MMIO 0x%p (timeout = %us, max_timeout = %us)",
+		dev_name(wdd->dev), hw->regs,
+		wdd->timeout, wdd->max_timeout);
 
 	return 0;
 
-unregister_timer:
-	bcm63xx_timer_unregister(TIMER_WDT_ID);
+unregister_watchdog:
+	watchdog_unregister_device(wdd);
 	return ret;
 }
 
 static int bcm63xx_wdt_remove(struct platform_device *pdev)
 {
-	if (!nowayout)
-		bcm63xx_wdt_hw_stop();
+	struct bcm63xx_wdt_hw *hw = platform_get_drvdata(pdev);
 
-	misc_deregister(&bcm63xx_wdt_miscdev);
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
+	watchdog_unregister_device(&hw->wdd);
 	return 0;
 }
 
 static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 {
-	bcm63xx_wdt_hw_stop();
+	struct bcm63xx_wdt_hw *hw = platform_get_drvdata(pdev);
+
+	bcm63xx_wdt_stop(&hw->wdd);
 }
 
 static struct platform_driver bcm63xx_wdt_driver = {
-- 
2.1.4


-- 
Simon Arlott
