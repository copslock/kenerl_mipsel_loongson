Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:09:40 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:37409 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011992AbaJTTEX1h3ZL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:23 +0200
Received: by mail-pd0-f201.google.com with SMTP id y10so953840pdj.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdT+Nb14wqoxqZ3n1m79uI6eLy5vXM7Z17lekVNF+C4=;
        b=PimSRGpqnqFxsrEJPMVV6RnM753+/qiH/NVzHwrYP15kWs3FPSr5way34Spt2WbGtH
         p7FPs8VbtuGIchGcqzCK0h3yl4MpSa9cu9lvkpH8UjKKcM99E6a7fknW30qOQi/hNn4r
         zw3XlyhnxId51AOa2xJE8Z6Nz8qEYDmwte6+40SUUfJ4Zk+x/R7xSvSe2oYKPpbJ0Bn+
         1JuEqyS93BxkJTZxHsCFVVsWLcHerC6KE+u7HYKuuXY+bdCuKJGOY1xNFiCxVNSQotQe
         Sby2WiLlDObwCAytG7PSH0f+12KywMgG9+qskacKB/lJpTJrJTVxDf6HxHJzlz3rVJqR
         6v9g==
X-Gm-Message-State: ALoCoQkW/Px60MWdOvX5ufpCSq69xVQqQt60+X39rLk3CCR4koDLwrbknur5GASlBj3G2/1hyFEs
X-Received: by 10.67.30.169 with SMTP id kf9mr12949534pad.28.1413831857522;
        Mon, 20 Oct 2014 12:04:17 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si437688yhd.1.2014.10.20.12.04.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:17 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id LUNvf60n.6; Mon, 20 Oct 2014 12:04:17 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 92AAA220B02; Mon, 20 Oct 2014 12:04:16 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] clocksource: mips-gic: Bump up rating of GIC timer
Date:   Mon, 20 Oct 2014 12:04:06 -0700
Message-Id: <1413831846-32100-20-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Bump up the rating of the GIC timer so that it gets prioritized
over the CP0 timer.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 84fbb7a..a749c81 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -61,7 +61,7 @@ static void gic_clockevent_cpu_init(struct clock_event_device *cd)
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_C3STOP;
 
-	cd->rating		= 300;
+	cd->rating		= 350;
 	cd->irq			= gic_timer_irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= gic_next_event;
-- 
2.1.0.rc2.206.gedb03e5
