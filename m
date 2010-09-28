Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 09:46:44 +0200 (CEST)
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:34106 "EHLO
        eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491950Ab0I1Hql (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 09:46:41 +0200
Received: from source ([167.4.1.35]) (using TLSv1) by eu1sys200aob107.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKGc+HOiAQ16kf1JvFtQBNKuJo7VSCZU@postini.com; Tue, 28 Sep 2010 07:46:40 UTC
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 0C2DDBB;
        Tue, 28 Sep 2010 07:37:54 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 4C26631F;
        Tue, 28 Sep 2010 07:41:09 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 6D46624C2FA;
        Tue, 28 Sep 2010 09:41:04 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 28 Sep
 2010 09:41:08 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <eric.y.miao@gmail.com>, <linux@arm.linux.org.uk>,
        <grinberg@compulab.co.il>, <mike@compulab.co.il>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <drwyrm@gmail.com>, <stefan@openezx.org>, <laforge@openezx.org>,
        <ospite@studenti.unina.it>, <philipp.zabel@gmail.com>,
        <mad_soft@inbox.ru>, <maz@misterjones.org>, <daniel@caiaq.de>,
        <haojian.zhuang@marvell.com>, <timur@freescale.com>,
        <ben-linux@fluff.org>, <support@simtec.co.uk>,
        <arnaud.patard@rtp-net.org>, <dgreenday@gmail.com>,
        <anarsoul@gmail.com>, <akpm@linux-foundation.org>,
        <mcuelenaere@gmail.com>, <kernel@pengutronix.de>,
        <andre.goddard@gmail.com>, <jkosina@suse.cz>, <tj@kernel.org>,
        <hsweeten@visionengravers.com>, <u.kleine-koenig@pengutronix.de>,
        <kgene.kim@samsung.com>, <ralf@linux-mips.org>, <lars@metafoo.de>,
        <dilinger@collabora.co.uk>, <mroth@nessie.de>,
        <randy.dunlap@oracle.com>, <lethal@linux-sh.org>,
        <rusty@rustcorp.com.au>, <damm@opensource.se>, <mst@redhat.com>,
        <rpurdie@rpsys.net>, <sguinot@lacie.co>, <sameo@linux.intel.com>,
        <broonie@opensource.wolfsonmicro.com>, <balajitk@ti.com>,
        <rnayak@ti.com>, <santosh.shilimkar@ti.com>, <hemanthv@ti.com>,
        <michael.hennerich@analog.com>, <vapier@gentoo.org>,
        <khali@linux-fr.org>, <jic23@cam.ac.uk>, <re.emese@gmail.com>,
        <linux@simtec.co.uk>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <arun.murthy@stericsson.com>, <linus.walleij@stericsson.com>,
        <mattias.wallin@stericsson.com>
Subject: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
Date:   Tue, 28 Sep 2010 13:10:44 +0530
Message-ID: <1285659648-21409-4-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 27840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22117

A new element 'name' is added to pwm led platform data structure.
This is required to identify the pwm device.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/leds/leds-pwm.c  |    4 +++-
 include/linux/leds_pwm.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

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
index 33a0711..7a847a0 100644
--- a/include/linux/leds_pwm.h
+++ b/include/linux/leds_pwm.h
@@ -16,6 +16,7 @@ struct led_pwm {
 struct led_pwm_platform_data {
 	int			num_leds;
 	struct led_pwm	*leds;
+	char *name;
 };
 
 #endif
-- 
1.7.2.dirty
