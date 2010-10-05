Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 14:01:23 +0200 (CEST)
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:52753 "EHLO
        eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab0JEMBT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Oct 2010 14:01:19 +0200
Received: from source ([167.4.1.35]) (using TLSv1) by eu1sys200aob104.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKsTcXgsmLcncKc9Huf/CeW3PqxAYiXU@postini.com; Tue, 05 Oct 2010 12:01:19 UTC
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id B1E0A117;
        Tue,  5 Oct 2010 11:56:56 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 5B1356DA;
        Tue,  5 Oct 2010 12:00:13 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 226E9A8074;
        Tue,  5 Oct 2010 14:00:07 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 5 Oct
 2010 14:00:12 +0200
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
Subject: [PATCHv2 2/7] backlight:pwm: add an element 'name' to platform data
Date:   Tue, 5 Oct 2010 17:29:57 +0530
Message-ID: <1286280002-1636-3-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <arun.murthy@stericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips

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
