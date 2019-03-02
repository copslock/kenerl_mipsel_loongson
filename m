Return-Path: <SRS0=FRkd=RF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0676C00319
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 23:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF4620838
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 23:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rnnAc4Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCBXgB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:36:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34528 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfCBXgB (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 2 Mar 2019 18:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551569757; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T5gM9fNr36oTxFv1YWXbA8rrY8lrYbbD1rX18qV1k78=;
        b=rnnAc4Z9csRKPiG4x9NkmzbqXZ5L7zsGSSmV8buOUWJTfsh4v22a9Qb2FW9u2XVSQLo2gy
        5oZUSeZaM5jkJyT+3zV2Ietg55z4p/5axVVuAKs88B13u1oVHb6YhvpeUzCZWf7hheFZmj
        mia1rOU2tFj1TyheATgXR2XVJBA3hIs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 14/27] pwm: jz4740: Improve algorithm of clock calculation
Date:   Sat,  2 Mar 2019 20:34:00 -0300
Message-Id: <20190302233413.14813-15-paul@crapouillou.net>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The previous algorithm hardcoded details about how the TCU clocks work.
The new algorithm will use clk_round_rate to find the perfect clock rate
for the PWM channel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v9: New patch
    
        v10: - New algorithm. Instead of starting with the maximum clock rate
               and using clk_round_rate(rate - 1) to get the next (smaller)
    	   clock, we compute the maximum rate we can use before the
    	   register overflows, and apply it with clk_set_max_rate.
    	   Then we read the new clock rate and compute the register values
    	   of the period and duty from that.
    	 - Use NSEC_PER_SEC instead of magic 1000000000 value

 drivers/pwm/pwm-jz4740.c | 49 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index c6136bd4434b..f497388fc818 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -110,24 +110,45 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	struct clk *clk = jz4740->clks[pwm->hwpwm],
 		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
+	unsigned long rate, parent_rate, period, duty;
 	unsigned long long tmp;
-	unsigned int prescaler = 0;
+	int ret;
 
-	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
+	parent_rate = clk_get_rate(parent_clk);
+
+	jz4740_pwm_disable(chip, pwm);
+
+	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
+	ret = clk_set_rate(clk, parent_rate);
+	if (ret)
+		return ret;
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	/* Limit the clock to a maximum rate that still gives us a period value
+	 * which fits in 16 bits.
+	 */
+	tmp = 0xffffull * NSEC_PER_SEC;
+	do_div(tmp, state->period);
+
+	ret = clk_set_max_rate(clk, tmp);
+	if (ret) {
+		dev_err(chip->dev, "Unable to set max rate: %i\n", ret);
+		return ret;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	/* Read back the clock rate, as it may have been modified by
+	 * clk_set_max_rate()
+	 */
+	rate = clk_get_rate(clk);
 
+	if (rate != parent_rate)
+		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
+
+	/* Calculate period value */
+	tmp = (unsigned long long)rate * state->period;
+	do_div(tmp, NSEC_PER_SEC);
+	period = (unsigned long)tmp;
+
+	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
 	duty = period - tmp;
@@ -135,14 +156,10 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty >= period)
 		duty = period - 1;
 
-	jz4740_pwm_disable(chip, pwm);
-
 	/* Set abrupt shutdown */
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	clk_set_rate(clk, rate);
-
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-- 
2.11.0

