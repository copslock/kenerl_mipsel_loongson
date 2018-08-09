Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 23:47:15 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:48398 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994780AbeHIVpMrCkOJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 23:45:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 13/24] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date:   Thu,  9 Aug 2018 23:44:03 +0200
Message-Id: <20180809214414.20905-14-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851112; bh=3vYNuHpyzRB2JnMMYKKnCUgTu6dUaN7N0Z2NkSwih2Y=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LoNbRO4t8Y0JJcj9t7D3JDROjdHMpOnVYNTjLI0+48RyAMIa1jFFIAet2l4/jo37zTmPXRqwycSOx5m896QGsOXN9uu2idxjNoJFTzFU4YqRb4tBmdML4B75hbAx8xb8GJrscg6MWreB038nZM9b+OnNj596VYtWE5W4fOH94Bc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65520
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

The TCU channels 0 and 1 were previously reserved for system tasks, and
thus unavailable for PWM.

This commit uses the newly introduced API functions of the ingenic-timer
driver to request/release the TCU channels that should be used as PWM.
This allows all the TCU channels to be used as PWM.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

 v6: New patch

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 1bda8d8e9865..d08274ec007f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -43,27 +43,30 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char clk_name[16];
 	int ret;
 
-	/*
-	 * Timers 0 and 1 are used for system tasks, so they are unavailable
-	 * for use as PWMs.
-	 */
-	if (pwm->hwpwm < 2)
-		return -EBUSY;
+	ret = ingenic_tcu_request_channel(pwm->hwpwm);
+	if (ret)
+		return ret;
 
 	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
 
 	clk = clk_get(chip->dev, clk_name);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err_free_channel;
+	}
 
 	ret = clk_prepare_enable(clk);
-	if (ret) {
-		clk_put(clk);
-		return ret;
-	}
+	if (ret)
+		goto err_clk_put;
 
 	jz->clks[pwm->hwpwm] = clk;
 	return 0;
+
+err_clk_put:
+	clk_put(clk);
+err_free_channel:
+	ingenic_tcu_release_channel(pwm->hwpwm);
+	return ret;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -73,6 +76,7 @@ static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+	ingenic_tcu_release_channel(pwm->hwpwm);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.11.0
