Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 19:19:16 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:47434 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994711AbeHURRKNyiMD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 19:17:10 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 12/24] pwm: jz4740: Use regmap and clocks from TCU driver
Date:   Tue, 21 Aug 2018 19:16:23 +0200
Message-Id: <20180821171635.22740-13-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871829; bh=ktB1EeGpjchjGdpncTBFuSwlmFS2rxjeXBqXIWvOXGM=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f1ece8B96h3OaDLxUih8aP4n9VssCZ8jnNPbOOcpOmpTII3R4nepr35e9BXB0hDeko6odOHwu+X2IV+IFFLP0mtUSFeO+aKsQAln/eZMFRL3PGrCbNKKKUgTTd35aW+Cn/1kipmldNwcvoNXs+UEx0DHrD61SBGEhqLFXhL6eCU=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65694
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

The ingenic-timer "TCU" driver provides us with a regmap, that we can
use to safely access the TCU registers.

It also provides us with clocks, that can be (un)gated, reparented or
reclocked from devicetree, instead of having these settings hardcoded in
this driver.

While this driver is devicetree-compatible, it is never (as of now)
probed from devicetree, so this change does not introduce a ABI problem
with current devicetree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: Drop requirement of probing from devicetree
    
     v7: No change

 drivers/pwm/Kconfig      |   2 +
 drivers/pwm/pwm-jz4740.c | 124 +++++++++++++++++++++++++++++++----------------
 2 files changed, 83 insertions(+), 43 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a4d262db9945..58359bf22b96 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -202,6 +202,8 @@ config PWM_IMX
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
+	depends on COMMON_CLK
+	select INGENIC_TIMER
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a7b134af5e04..1bda8d8e9865 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -14,21 +14,21 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/kernel.h>
+#include <linux/mfd/ingenic-tcu.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
-
-#include <asm/mach-jz4740/timer.h>
+#include <linux/regmap.h>
 
 #define NUM_PWM 8
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
-	struct clk *clk;
+	struct clk *clks[NUM_PWM];
+	struct regmap *map;
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -38,6 +38,11 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk;
+	char clk_name[16];
+	int ret;
+
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
 	 * for use as PWMs.
@@ -45,65 +50,89 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	jz4740_timer_start(pwm->hwpwm);
+	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
+
+	clk = clk_get(chip->dev, clk_name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		clk_put(clk);
+		return ret;
+	}
+
+	jz->clks[pwm->hwpwm] = clk;
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk = jz->clks[pwm->hwpwm];
 
-	jz4740_timer_stop(pwm->hwpwm);
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
-	ctrl |= JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
-	jz4740_timer_enable(pwm->hwpwm);
+	/* Enable PWM output */
+	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+				TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);
 
+	/* Start counter */
+	regmap_write(jz->map, TCU_REG_TESR, BIT(pwm->hwpwm));
 	return 0;
 }
 
 static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
 	/* Disable PWM output.
 	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
 	 * counter is stopped, while in TCU1 mode the order does not matter.
 	 */
-	ctrl &= ~JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+				TCU_TCSR_PWM_EN, 0);
 
 	/* Stop counter */
-	jz4740_timer_disable(pwm->hwpwm);
+	regmap_write(jz->map, TCU_REG_TECR, BIT(pwm->hwpwm));
 }
 
 static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			     int duty_ns, int period_ns)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	struct clk *clk = jz4740->clks[pwm->hwpwm];
+	unsigned long rate, new_rate, period, duty;
 	unsigned long long tmp;
-	unsigned long period, duty;
-	unsigned int prescaler = 0;
-	uint16_t ctrl;
+	unsigned int tcsr;
 	bool is_enabled;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
-	do_div(tmp, 1000000000);
-	period = tmp;
+	rate = clk_get_rate(clk);
+
+	for (;;) {
+		tmp = (unsigned long long) rate * period_ns;
+		do_div(tmp, 1000000000);
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		++prescaler;
+		if (tmp <= 0xffff)
+			break;
+
+		new_rate = clk_round_rate(clk, rate / 2);
+
+		if (new_rate < rate)
+			rate = new_rate;
+		else
+			return -EINVAL;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	clk_set_rate(clk, rate);
+
+	period = tmp;
 
 	tmp = (unsigned long long)period * duty_ns;
 	do_div(tmp, period_ns);
@@ -112,18 +141,23 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty >= period)
 		duty = period - 1;
 
-	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
+	regmap_read(jz4740->map, TCU_REG_TER, &tcsr);
+	is_enabled = tcsr & BIT(pwm->hwpwm);
 	if (is_enabled)
 		jz4740_pwm_disable(chip, pwm);
 
-	jz4740_timer_set_count(pwm->hwpwm, 0);
-	jz4740_timer_set_duty(pwm->hwpwm, duty);
-	jz4740_timer_set_period(pwm->hwpwm, period);
+	/* Set abrupt shutdown */
+	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+				TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
+
+	/* Reset counter to 0 */
+	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
-		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
+	/* Set duty */
+	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
 
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	/* Set period */
+	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
 
 	if (is_enabled)
 		jz4740_pwm_enable(chip, pwm);
@@ -134,18 +168,19 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
 		struct pwm_device *pwm, enum pwm_polarity polarity)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
 	switch (polarity) {
 	case PWM_POLARITY_NORMAL:
-		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+				TCU_TCSR_PWM_INITL_HIGH, 0);
 		break;
 	case PWM_POLARITY_INVERSED:
-		ctrl |= JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+			TCU_TCSR_PWM_INITL_HIGH, TCU_TCSR_PWM_INITL_HIGH);
 		break;
 	}
 
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
 	return 0;
 }
 
@@ -162,16 +197,19 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740;
+	struct device *dev = &pdev->dev;
 
-	jz4740 = devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
+	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
-	if (IS_ERR(jz4740->clk))
-		return PTR_ERR(jz4740->clk);
+	jz4740->map = dev_get_regmap(dev->parent, NULL);
+	if (!jz4740->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
 
-	jz4740->chip.dev = &pdev->dev;
+	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
 	jz4740->chip.base = -1;
-- 
2.11.0
