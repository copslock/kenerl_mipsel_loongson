Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 09:45:57 +0200 (CEST)
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:33798 "EHLO
        eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491945Ab0I1Hok (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 09:44:40 +0200
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob119.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKGceJENVUyqwiwhrwB8c90VeFE0LSjU@postini.com; Tue, 28 Sep 2010 07:44:39 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9DA8A89;
        Tue, 28 Sep 2010 07:41:20 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B3F121948;
        Tue, 28 Sep 2010 07:41:12 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 88FF224C2AB;
        Tue, 28 Sep 2010 09:40:59 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 28 Sep
 2010 09:41:03 +0200
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
Subject: [PATCH 2/7] backlight:pwm: add an element 'name' to platform data
Date:   Tue, 28 Sep 2010 13:10:43 +0530
Message-ID: <1285659648-21409-3-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 27839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22115

A new element 'name' is added to pwm backlight platform data structure.
This is required to identify the pwm device.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/video/backlight/pwm_bl.c |    4 +++-
 include/linux/pwm_backlight.h    |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 5504435..b0978a8 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -94,7 +94,9 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->notify = data->notify;
 	pb->dev = &pdev->dev;
 
-	pb->pwm = pwm_request(data->pwm_id, "backlight");
+	if (!data->name)
+		data->name = "backlight";
+	pb->pwm = pwm_request(data->pwm_id, data->name);
 	if (IS_ERR(pb->pwm)) {
 		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
 		ret = PTR_ERR(pb->pwm);
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index 01b3d75..c2ce8f8 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -6,6 +6,7 @@
 
 struct platform_pwm_backlight_data {
 	int pwm_id;
+	char *name;
 	unsigned int max_brightness;
 	unsigned int dft_brightness;
 	unsigned int pwm_period_ns;
-- 
1.7.2.dirty
