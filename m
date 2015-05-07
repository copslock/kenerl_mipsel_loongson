Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 00:02:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41588 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012797AbbEGWCnXlNtF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 00:02:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 972E0BB618302;
        Thu,  7 May 2015 23:02:33 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 7 May
 2015 23:02:37 +0100
Received: from laptop.hh.imgtec.org (10.100.200.189) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 7 May
 2015 23:02:35 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Naidu Tellapati <naidu.tellapati@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        <linux-mips@linux-mips.org>, <sai.masarapu@imgtec.com>,
        <arul.ramasamy@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH] pwm: img: Change min and max timebase steps value
Date:   Thu, 7 May 2015 18:59:21 -0300
Message-ID: <1431035961-2008-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.189]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

The PWM hardware on Pistachio platform has a maximum timebase steps
value to 255. To fix it, let's introduce a compatible-specific
data structure to contain the SoC-specific details and use it to
specify a maximum timebase.

Also, the design team, suggested to use a minimum timebase steps
value of 16.

Fixes: 277bb6a29e00 ("pwm: Imagination Technologies PWM DAC driver")
Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
This patch is needed for the pwm-img to work properly, so it should be
pushed as a v4.1-rc fix.

 drivers/pwm/pwm-img.c | 64 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 476171a..25b6555 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
@@ -38,15 +39,22 @@
 #define PERIP_PWM_PDM_CONTROL_CH_MASK		0x1
 #define PERIP_PWM_PDM_CONTROL_CH_SHIFT(ch)	((ch) * 4)
 
-#define MAX_TMBASE_STEPS			65536
+#define MIN_TMBASE_STEPS			16
+
+struct img_pwm_soc_data {
+	u32 max_timebase;
+};
 
 struct img_pwm_chip {
+	u32		max_period_ns;
+	u32		min_period_ns;
 	struct device	*dev;
 	struct pwm_chip	chip;
 	struct clk	*pwm_clk;
 	struct clk	*sys_clk;
 	void __iomem	*base;
 	struct regmap	*periph_regs;
+	const struct img_pwm_soc_data   *data;
 };
 
 static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
@@ -72,24 +80,30 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 val, div, duty, timebase;
 	unsigned long mul, output_clk_hz, input_clk_hz;
 	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
+	unsigned int max_timebase = pwm_chip->data->max_timebase;
 
 	input_clk_hz = clk_get_rate(pwm_chip->pwm_clk);
 	output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
+	if (period_ns < pwm_chip->min_period_ns ||
+	    period_ns > pwm_chip->max_period_ns) {
+		dev_err(chip->dev, "configured period not in range\n");
+		return -ERANGE;
+	}
 
 	mul = DIV_ROUND_UP(input_clk_hz, output_clk_hz);
-	if (mul <= MAX_TMBASE_STEPS) {
+	if (mul <= max_timebase) {
 		div = PWM_CTRL_CFG_NO_SUB_DIV;
 		timebase = DIV_ROUND_UP(mul, 1);
-	} else if (mul <= MAX_TMBASE_STEPS * 8) {
+	} else if (mul <= max_timebase * 8) {
 		div = PWM_CTRL_CFG_SUB_DIV0;
 		timebase = DIV_ROUND_UP(mul, 8);
-	} else if (mul <= MAX_TMBASE_STEPS * 64) {
+	} else if (mul <= max_timebase * 64) {
 		div = PWM_CTRL_CFG_SUB_DIV1;
 		timebase = DIV_ROUND_UP(mul, 64);
-	} else if (mul <= MAX_TMBASE_STEPS * 512) {
+	} else if (mul <= max_timebase * 512) {
 		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
 		timebase = DIV_ROUND_UP(mul, 512);
-	} else if (mul > MAX_TMBASE_STEPS * 512) {
+	} else if (mul > max_timebase * 512) {
 		dev_err(chip->dev,
 			"failed to configure timebase steps/divider value\n");
 		return -EINVAL;
@@ -143,11 +157,27 @@ static const struct pwm_ops img_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static const struct img_pwm_soc_data pistachio_pwm = {
+	.max_timebase = 255,
+};
+
+static const struct of_device_id img_pwm_of_match[] = {
+	{
+		.compatible = "img,pistachio-pwm",
+		.data = &pistachio_pwm,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, img_pwm_of_match);
+
 static int img_pwm_probe(struct platform_device *pdev)
 {
 	int ret;
+	u64 val;
+	u32 input_rate;
 	struct resource *res;
 	struct img_pwm_chip *pwm;
+	const struct of_device_id *of_dev_id;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
@@ -160,6 +190,11 @@ static int img_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
+	of_dev_id = of_match_device(img_pwm_of_match, &pdev->dev);
+	if (!of_dev_id)
+		return -ENODEV;
+	pwm->data = of_dev_id->data;
+
 	pwm->periph_regs = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 							   "img,cr-periph");
 	if (IS_ERR(pwm->periph_regs))
@@ -189,6 +224,17 @@ static int img_pwm_probe(struct platform_device *pdev)
 		goto disable_sysclk;
 	}
 
+	input_rate = clk_get_rate(pwm->pwm_clk);
+
+	/* The maximum input clock divider is 512 */
+	val = (u64)NSEC_PER_SEC * 512 * pwm->data->max_timebase;
+	do_div(val, input_rate);
+	pwm->max_period_ns = val;
+
+	val = (u64)NSEC_PER_SEC * MIN_TMBASE_STEPS;
+	do_div(val, input_rate);
+	pwm->min_period_ns = val;
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &img_pwm_ops;
 	pwm->chip.base = -1;
@@ -228,12 +274,6 @@ static int img_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pwm_chip->chip);
 }
 
-static const struct of_device_id img_pwm_of_match[] = {
-	{ .compatible = "img,pistachio-pwm", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, img_pwm_of_match);
-
 static struct platform_driver img_pwm_driver = {
 	.driver = {
 		.name = "img-pwm",
-- 
2.3.3
