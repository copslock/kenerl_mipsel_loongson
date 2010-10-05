Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 14:03:34 +0200 (CEST)
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:34338 "EHLO
        eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491029Ab0JEMBw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Oct 2010 14:01:52 +0200
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob111.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKsTjKhzvIHmAmGxcHAo6B09ufo9CHfV@postini.com; Tue, 05 Oct 2010 12:01:52 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 98A34121;
        Tue,  5 Oct 2010 12:00:16 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 32870997;
        Tue,  5 Oct 2010 12:00:16 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 9EC17A8093;
        Tue,  5 Oct 2010 14:00:09 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 5 Oct
 2010 14:00:14 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <lars@metafoo.de>, <akpm@linux-foundation.org>,
        <kernel@pengutronix.de>, <philipp.zabel@gmail.com>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <eric.y.miao@gmail.com>, <rpurdie@rpsys.net>,
        <sameo@linux.intel.com>, <kgene.kim@samsung.com>,
        <linux-omap@vger.kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <STEricsson_nomadik_linux@list.st.com>,
        <arun.murthy@stericsson.com>, <bgat@billgatliff.com>
Subject: [PATCHv2 3/7] leds: pwm: add a new element 'name' to platform data
Date:   Tue, 5 Oct 2010 17:29:58 +0530
Message-ID: <1286280002-1636-4-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

A new element 'name' is added to pwm led platform data structure.
This is required to identify the pwm device.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/leds/leds-pwm.c  |    4 +++-
 include/linux/leds_pwm.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index da3fa8d..8da2be6 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -66,8 +66,10 @@ static int led_pwm_probe(struct platform_device *pdev)
 		cur_led = &pdata->leds[i];
 		led_dat = &leds_data[i];
 
+		if (!pdata->name)
+			pdata->name = cur_led->name;
 		led_dat->pwm = pwm_request(cur_led->pwm_id,
-				cur_led->name);
+				pdata->name);
 		if (IS_ERR(led_dat->pwm)) {
 			dev_err(&pdev->dev, "unable to request PWM %d\n",
 					cur_led->pwm_id);
diff --git a/include/linux/leds_pwm.h b/include/linux/leds_pwm.h
index 33a0711..dbc925a 100644
--- a/include/linux/leds_pwm.h
+++ b/include/linux/leds_pwm.h
@@ -14,8 +14,9 @@ struct led_pwm {
 };
 
 struct led_pwm_platform_data {
-	int			num_leds;
+	int		num_leds;
 	struct led_pwm	*leds;
+	char		*name;
 };
 
 #endif
-- 
1.7.2.dirty
