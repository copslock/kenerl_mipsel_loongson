Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 14:07:02 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:53876 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903467Ab2IJMFm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2012 14:05:42 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0Mao5W-1SrjTG1rhK-00KhcH; Mon, 10 Sep 2012 14:05:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id C396A2A28267;
        Mon, 10 Sep 2012 14:05:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XGs+E21HWE61; Mon, 10 Sep 2012 14:05:24 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 3292B2A282DF;
        Mon, 10 Sep 2012 14:05:24 +0200 (CEST)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH v2 3/3] pwm: Add Ingenic JZ4740 support
Date:   Mon, 10 Sep 2012 14:05:19 +0200
Message-Id: <1347278719-15276-4-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
X-Provags-ID: V02:K0:uKUgEID/Ix1bZoNHsIy0m2Rvmq6uGYdLYyVtS42fKP6
 B89MC2Rf5J9rlsxnWbJ5Aw0kIIvJsqYVfC6ra5iMVSW935Ginj
 P5o+LvRPhmFfX/hGXH/0peTbZ2IzOu+VB1q63e4bWLwEGMXnsn
 umh7KBiVdZ73UJDXGhrR4fuHr6DzTeiuFQXaEb4rrFV4YgNXXR
 aVsMdmYvownCTLWTItAtF8td/5NPXfVR4rk4w4SeGO72HtYzAq
 PUhL+buMgEPy89avmJzBzn00RXprfhv8jf0BrmuMz3nJWqgiKq
 gL4pvygxTYdReizJypSVnWygxgmXQUG9Uy3KWc3a7bWgAuVgIZ
 jByLfzYlcpZGH47yaJEp1r+Cefwy6mNAHOGgbyN/GKZc0thXKj
 EXj+0MqIgj6n4Mre+EhaFKF8Hs3MLDFp4HPI7P+leNCN+5IA03
 sjL4a
X-archive-position: 34450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This commit moves the driver to drivers/pwm and converts it to the new
PWM framework.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- remove PWM core hunk that slipped in by mistake
- change pwm-beeper platform data back to 4
- refer to timer.h by full path
- register PWMs 0 and 1 but reserve them for system tasks
- replace printk by dev_err now that a proper device is available
- use jz4740_pwm_{enable,disable}() instead of pwm_{enable,disable}()
  internally
- make THIS_MODULE the owner of jz4740_pwm_ops and jz4740_pwm_driver
- add __devinit and __devexit annotations to jz4740_pwm_probe() and
  jz4740_pwm_remove() respectively
- add MODULE_AUTHOR(), MODULE_DESCRIPTION(), MODULE_ALIAS() and
  MODULE_LICENSE()

 arch/mips/include/asm/mach-jz4740/platform.h |   1 +
 arch/mips/jz4740/Kconfig                     |   3 -
 arch/mips/jz4740/Makefile                    |   2 +-
 arch/mips/jz4740/board-qi_lb60.c             |   1 +
 arch/mips/jz4740/platform.c                  |   6 +
 arch/mips/jz4740/pwm.c                       | 177 ---------------------
 drivers/pwm/Kconfig                          |  12 +-
 drivers/pwm/Makefile                         |   1 +
 drivers/pwm/pwm-jz4740.c                     | 221 +++++++++++++++++++++++++++
 9 files changed, 242 insertions(+), 182 deletions(-)
 delete mode 100644 arch/mips/jz4740/pwm.c
 create mode 100644 drivers/pwm/pwm-jz4740.c

diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
index 564ab81..163e81d 100644
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -31,6 +31,7 @@ extern struct platform_device jz4740_pcm_device;
 extern struct platform_device jz4740_codec_device;
 extern struct platform_device jz4740_adc_device;
 extern struct platform_device jz4740_wdt_device;
+extern struct platform_device jz4740_pwm_device;
 
 void jz4740_serial_device_register(void);
 
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 3e7141f..4689030 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -7,6 +7,3 @@ config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
 
 endchoice
-
-config HAVE_PWM
-	bool
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index e44abea..63bad0e 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y += prom.o irq.o time.o reset.o setup.o dma.o \
-	gpio.o clock.o platform.o timer.o pwm.o serial.o
+	gpio.o clock.o platform.o timer.o serial.o
 
 obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
 
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 9a3d9de..43d964d 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -437,6 +437,7 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_codec_device,
 	&jz4740_rtc_device,
 	&jz4740_adc_device,
+	&jz4740_pwm_device,
 	&qi_lb60_gpio_keys,
 	&qi_lb60_pwm_beeper,
 	&qi_lb60_charger_device,
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index e342ed4..6d14dcd 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -323,3 +323,9 @@ struct platform_device jz4740_wdt_device = {
 	.num_resources = ARRAY_SIZE(jz4740_wdt_resources),
 	.resource      = jz4740_wdt_resources,
 };
+
+/* PWM */
+struct platform_device jz4740_pwm_device = {
+	.name = "jz4740-pwm",
+	.id   = -1,
+};
diff --git a/arch/mips/jz4740/pwm.c b/arch/mips/jz4740/pwm.c
deleted file mode 100644
index a26a6fa..0000000
--- a/arch/mips/jz4740/pwm.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform PWM support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/pwm.h>
-#include <linux/gpio.h>
-
-#include <asm/mach-jz4740/gpio.h>
-#include "timer.h"
-
-static struct clk *jz4740_pwm_clk;
-
-DEFINE_MUTEX(jz4740_pwm_mutex);
-
-struct pwm_device {
-	unsigned int id;
-	unsigned int gpio;
-	bool used;
-};
-
-static struct pwm_device jz4740_pwm_list[] = {
-	{ 2, JZ_GPIO_PWM2, false },
-	{ 3, JZ_GPIO_PWM3, false },
-	{ 4, JZ_GPIO_PWM4, false },
-	{ 5, JZ_GPIO_PWM5, false },
-	{ 6, JZ_GPIO_PWM6, false },
-	{ 7, JZ_GPIO_PWM7, false },
-};
-
-struct pwm_device *pwm_request(int id, const char *label)
-{
-	int ret = 0;
-	struct pwm_device *pwm;
-
-	if (id < 2 || id > 7 || !jz4740_pwm_clk)
-		return ERR_PTR(-ENODEV);
-
-	mutex_lock(&jz4740_pwm_mutex);
-
-	pwm = &jz4740_pwm_list[id - 2];
-	if (pwm->used)
-		ret = -EBUSY;
-	else
-		pwm->used = true;
-
-	mutex_unlock(&jz4740_pwm_mutex);
-
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = gpio_request(pwm->gpio, label);
-
-	if (ret) {
-		printk(KERN_ERR "Failed to request pwm gpio: %d\n", ret);
-		pwm->used = false;
-		return ERR_PTR(ret);
-	}
-
-	jz_gpio_set_function(pwm->gpio, JZ_GPIO_FUNC_PWM);
-
-	jz4740_timer_start(id);
-
-	return pwm;
-}
-
-void pwm_free(struct pwm_device *pwm)
-{
-	pwm_disable(pwm);
-	jz4740_timer_set_ctrl(pwm->id, 0);
-
-	jz_gpio_set_function(pwm->gpio, JZ_GPIO_FUNC_NONE);
-	gpio_free(pwm->gpio);
-
-	jz4740_timer_stop(pwm->id);
-
-	pwm->used = false;
-}
-
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	unsigned long long tmp;
-	unsigned long period, duty;
-	unsigned int prescaler = 0;
-	unsigned int id = pwm->id;
-	uint16_t ctrl;
-	bool is_enabled;
-
-	if (duty_ns < 0 || duty_ns > period_ns)
-		return -EINVAL;
-
-	tmp = (unsigned long long)clk_get_rate(jz4740_pwm_clk) * period_ns;
-	do_div(tmp, 1000000000);
-	period = tmp;
-
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		++prescaler;
-	}
-
-	if (prescaler == 6)
-		return -EINVAL;
-
-	tmp = (unsigned long long)period * duty_ns;
-	do_div(tmp, period_ns);
-	duty = period - tmp;
-
-	if (duty >= period)
-		duty = period - 1;
-
-	is_enabled = jz4740_timer_is_enabled(id);
-	if (is_enabled)
-		pwm_disable(pwm);
-
-	jz4740_timer_set_count(id, 0);
-	jz4740_timer_set_duty(id, duty);
-	jz4740_timer_set_period(id, period);
-
-	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
-		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
-
-	jz4740_timer_set_ctrl(id, ctrl);
-
-	if (is_enabled)
-		pwm_enable(pwm);
-
-	return 0;
-}
-
-int pwm_enable(struct pwm_device *pwm)
-{
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->id);
-
-	ctrl |= JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->id, ctrl);
-	jz4740_timer_enable(pwm->id);
-
-	return 0;
-}
-
-void pwm_disable(struct pwm_device *pwm)
-{
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->id);
-
-	ctrl &= ~JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_disable(pwm->id);
-	jz4740_timer_set_ctrl(pwm->id, ctrl);
-}
-
-static int __init jz4740_pwm_init(void)
-{
-	int ret = 0;
-
-	jz4740_pwm_clk = clk_get(NULL, "ext");
-
-	if (IS_ERR(jz4740_pwm_clk)) {
-		ret = PTR_ERR(jz4740_pwm_clk);
-		jz4740_pwm_clk = NULL;
-	}
-
-	return ret;
-}
-subsys_initcall(jz4740_pwm_init);
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 90c5c73..5c663df 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -1,6 +1,6 @@
 menuconfig PWM
 	bool "Pulse-Width Modulation (PWM) Support"
-	depends on !MACH_JZ4740 && !PUV3_PWM
+	depends on !PUV3_PWM
 	help
 	  Generic Pulse-Width Modulation (PWM) support.
 
@@ -47,6 +47,16 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
 
+config PWM_JZ4740
+	tristate "Ingenic JZ4740 PWM support"
+	depends on MACH_JZ4740
+	help
+	  Generic PWM framework driver for Ingenic JZ4740 based
+	  machines.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-jz4740.
+
 config PWM_LPC32XX
 	tristate "LPC32XX PWM support"
 	depends on ARCH_LPC32XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index e4b2c89..a1d6169 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
+obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
new file mode 100644
index 0000000..10250fc
--- /dev/null
+++ b/drivers/pwm/pwm-jz4740.c
@@ -0,0 +1,221 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform PWM support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#include <asm/mach-jz4740/gpio.h>
+#include <asm/mach-jz4740/timer.h>
+
+#define NUM_PWM 8
+
+static const unsigned int jz4740_pwm_gpio_list[NUM_PWM] = {
+	JZ_GPIO_PWM0,
+	JZ_GPIO_PWM1,
+	JZ_GPIO_PWM2,
+	JZ_GPIO_PWM3,
+	JZ_GPIO_PWM4,
+	JZ_GPIO_PWM5,
+	JZ_GPIO_PWM6,
+	JZ_GPIO_PWM7,
+};
+
+struct jz4740_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+};
+
+static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
+{
+	return container_of(chip, struct jz4740_pwm_chip, chip);
+}
+
+static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	unsigned int gpio = jz4740_pwm_gpio_list[pwm->hwpwm];
+	int ret;
+
+	/*
+	 * Timers 0 and 1 are used for system tasks, so they are unavailable
+	 * for use as PWMs.
+	 */
+	if (pwm->hwpwm < 2)
+		return -EBUSY;
+
+	ret = gpio_request(gpio, pwm->label);
+	if (ret) {
+		dev_err(chip->dev, "Failed to request GPIO#%u for PWM: %d\n",
+			gpio, ret);
+		return ret;
+	}
+
+	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_PWM);
+
+	jz4740_timer_start(pwm->hwpwm);
+
+	return 0;
+}
+
+static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	unsigned int gpio = jz4740_pwm_gpio_list[pwm->hwpwm];
+
+	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
+
+	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_NONE);
+	gpio_free(gpio);
+
+	jz4740_timer_stop(pwm->hwpwm);
+}
+
+static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
+
+	ctrl |= JZ_TIMER_CTRL_PWM_ENABLE;
+	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	jz4740_timer_enable(pwm->hwpwm);
+
+	return 0;
+}
+
+static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
+
+	ctrl &= ~JZ_TIMER_CTRL_PWM_ENABLE;
+	jz4740_timer_disable(pwm->hwpwm);
+	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+}
+
+static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			     int duty_ns, int period_ns)
+{
+	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	unsigned long long tmp;
+	unsigned long period, duty;
+	unsigned int prescaler = 0;
+	uint16_t ctrl;
+	bool is_enabled;
+
+	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
+	do_div(tmp, 1000000000);
+	period = tmp;
+
+	while (period > 0xffff && prescaler < 6) {
+		period >>= 2;
+		++prescaler;
+	}
+
+	if (prescaler == 6)
+		return -EINVAL;
+
+	tmp = (unsigned long long)period * duty_ns;
+	do_div(tmp, period_ns);
+	duty = period - tmp;
+
+	if (duty >= period)
+		duty = period - 1;
+
+	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
+	if (is_enabled)
+		jz4740_pwm_disable(chip, pwm);
+
+	jz4740_timer_set_count(pwm->hwpwm, 0);
+	jz4740_timer_set_duty(pwm->hwpwm, duty);
+	jz4740_timer_set_period(pwm->hwpwm, period);
+
+	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
+		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
+
+	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+
+	if (is_enabled)
+		jz4740_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
+static const struct pwm_ops jz4740_pwm_ops = {
+	.request = jz4740_pwm_request,
+	.free = jz4740_pwm_free,
+	.config = jz4740_pwm_config,
+	.enable = jz4740_pwm_enable,
+	.disable = jz4740_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int __devinit jz4740_pwm_probe(struct platform_device *pdev)
+{
+	struct jz4740_pwm_chip *jz4740;
+	int ret;
+
+	jz4740 = devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
+	if (!jz4740)
+		return -ENOMEM;
+
+	jz4740->clk = clk_get(NULL, "ext");
+	if (IS_ERR(jz4740->clk))
+		return PTR_ERR(jz4740->clk);
+
+	jz4740->chip.dev = &pdev->dev;
+	jz4740->chip.ops = &jz4740_pwm_ops;
+	jz4740->chip.npwm = NUM_PWM;
+	jz4740->chip.base = -1;
+
+	ret = pwmchip_add(&jz4740->chip);
+	if (ret < 0) {
+		clk_put(jz4740->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, jz4740);
+
+	return 0;
+}
+
+static int __devexit jz4740_pwm_remove(struct platform_device *pdev)
+{
+	struct jz4740_pwm_chip *jz4740 = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&jz4740->chip);
+	if (ret < 0)
+		return ret;
+
+	clk_put(jz4740->clk);
+
+	return 0;
+}
+
+static struct platform_driver jz4740_pwm_driver = {
+	.driver = {
+		.name = "jz4740-pwm",
+		.owner = THIS_MODULE,
+	},
+	.probe = jz4740_pwm_probe,
+	.remove = __devexit_p(jz4740_pwm_remove),
+};
+module_platform_driver(jz4740_pwm_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("Ingenic JZ4740 PWM driver");
+MODULE_ALIAS("platform:jz4740-pwm");
+MODULE_LICENSE("GPL");
-- 
1.7.12
