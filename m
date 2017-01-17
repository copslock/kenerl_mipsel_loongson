Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 00:20:31 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35100 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993896AbdAQXPvFZphA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 00:15:51 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 12/13] pwm: jz4740: Let the pinctrl driver configure the pins
Date:   Wed, 18 Jan 2017 00:14:20 +0100
Message-Id: <20170117231421.16310-13-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1484694920; bh=UjYxIjBdnwpO6mFgaQWa4herVB23X4fKNGvnUzwG8xs=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WMGhDSzQLzVgUyd/oT4jUsvvky0U5S0JSlrylA8l6n/LfvlsX6OV/oxhvKxbjPEEK61iuAQz9j5iIWwNrlO0xrxXzR+nQcneVCyBYtnSQjsgxSa2lX1ShV43RNy7fPYXUFl7pNbNCPGkwsm0vvcRMQRWcY6I2iFrFJRz2E/vSWQ=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56382
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

Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
the pins being properly configured before the driver probes.

One inherent problem of this new approach is that the pinctrl framework
does not allow us to configure each pin on demand, when the various PWM
channels are requested or released. For instance, the PWM channels can
be configured from sysfs, which would require all PWM pins to be configured
properly beforehand for the PWM function, eventually causing conflicts
with other platform or board drivers.

The proper solution here would be to modify the pwm-jz4740 driver to
handle only one PWM channel, and create an instance of this driver
for each one of the 8 PWM channels. Then, it could use the pinctrl
framework to dynamically configure the PWM pin it controls.

Until this can be done, the only jz4740 board supported upstream
(Qi lb60) could configure all of its connected PWM pins in PWM function
mode, if those are not used by other drivers nor by GPIOs on the
board.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 76d13150283f..a75ff3622450 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -21,22 +21,10 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
-#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/timer.h>
 
 #define NUM_PWM 8
 
-static const unsigned int jz4740_pwm_gpio_list[NUM_PWM] = {
-	JZ_GPIO_PWM0,
-	JZ_GPIO_PWM1,
-	JZ_GPIO_PWM2,
-	JZ_GPIO_PWM3,
-	JZ_GPIO_PWM4,
-	JZ_GPIO_PWM5,
-	JZ_GPIO_PWM6,
-	JZ_GPIO_PWM7,
-};
-
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
@@ -49,9 +37,6 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	unsigned int gpio = jz4740_pwm_gpio_list[pwm->hwpwm];
-	int ret;
-
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
 	 * for use as PWMs.
@@ -59,15 +44,6 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	ret = gpio_request(gpio, pwm->label);
-	if (ret) {
-		dev_err(chip->dev, "Failed to request GPIO#%u for PWM: %d\n",
-			gpio, ret);
-		return ret;
-	}
-
-	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_PWM);
-
 	jz4740_timer_start(pwm->hwpwm);
 
 	return 0;
@@ -75,13 +51,8 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	unsigned int gpio = jz4740_pwm_gpio_list[pwm->hwpwm];
-
 	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
 
-	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_NONE);
-	gpio_free(gpio);
-
 	jz4740_timer_stop(pwm->hwpwm);
 }
 
-- 
2.11.0
