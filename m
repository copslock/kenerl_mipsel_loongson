Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:09:23 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:56468 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011991AbaJTTEXQvAv3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:23 +0200
Received: by mail-pa0-f73.google.com with SMTP id et14so952977pad.4
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FgXVRN9RxUK1xjk7h6ef6afItcXro2Nbx6ewhUQtn48=;
        b=B9Aeu1khFzshiKFeKriMBo1zB7p9MCd6LkthqEXhE4ZMz9A8PmnmNsHr4ky93TiwLL
         c+vbK3n9zxKDI7haBarYUz6OZkANQcHwGKHDkd68ZAGPHpcV81ILiWsydbv2P1k4LySb
         cYf57bd2FY7Y0ngtFowQwWmdkspGnl7qz7gHO1R98+k6hGIGVCo9HfqtiUTNPu4j7OoT
         dHKpzM9V/GBgpGtMXDoJtLEi0Qc8cB9NVb+3Y818VmuUbefhNmfIOa1DKVUvY6dBkimM
         qRicgUkGgmwbCsQuc0KQpE+aLomNFt5yy0y+CQOaeeGUCxiulgjxHTvdB//+X+cZu/wO
         9upQ==
X-Gm-Message-State: ALoCoQlRuQfZtDhHG6dyczqRcOwIRTiWxNPsRjkU8txwciV6WLj+GzQnagotmCR1e+o5NAceaqor
X-Received: by 10.66.183.80 with SMTP id ek16mr19299923pac.7.1413831856951;
        Mon, 20 Oct 2014 12:04:16 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l45si437911yha.2.2014.10.20.12.04.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:16 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ezN2XdvX.6; Mon, 20 Oct 2014 12:04:16 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 061BE220B55; Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
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
Subject: [PATCH 18/19] clocksource: mips-gic: Use clockevents_config_and_register
Date:   Mon, 20 Oct 2014 12:04:05 -0700
Message-Id: <1413831846-32100-19-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43377
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

Use clockevents_config_and_register to setup the clock_event_device
based on frequency and min/max ticks instead of doing it ourselves.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clocksource/mips-gic-timer.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 3ce992b..84fbb7a 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -15,8 +15,6 @@
 #include <linux/smp.h>
 #include <linux/time.h>
 
-#include <asm/time.h>
-
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq;
 static unsigned int gic_frequency;
@@ -63,19 +61,13 @@ static void gic_clockevent_cpu_init(struct clock_event_device *cd)
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_C3STOP;
 
-	clockevent_set_clock(cd, gic_frequency);
-
-	/* Calculate the min / max delta */
-	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
-	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
-
 	cd->rating		= 300;
 	cd->irq			= gic_timer_irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= gic_next_event;
 	cd->set_mode		= gic_set_clock_mode;
 
-	clockevents_register_device(cd);
+	clockevents_config_and_register(cd, gic_frequency, 0x300, 0x7fffffff);
 
 	enable_percpu_irq(gic_timer_irq, IRQ_TYPE_NONE);
 }
-- 
2.1.0.rc2.206.gedb03e5
