Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:08:15 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:58451 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011986AbaJTTEVVcdFL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:21 +0200
Received: by mail-pd0-f201.google.com with SMTP id y10so952608pdj.4
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkSf8a8ZN2npN3EMHqDtIZoQwHwz4fKHvmyvV8i2mM0=;
        b=MZFilXPhGXh7/e0wXtpBXGC6syhR/MHFB2fwCc9zCftY1pm48O05vUAaMzQGsYD7Ex
         zefl4UvzL4Jv1O2Hv/f36X+F7U4H+VC7sEIVlwmgkBQOqArfjq21kdNn2dgW4fVGYbb7
         Y6pPbAfTYmbkp3VcjGgz2Og2AHDQygBBXLhPArtH6E8ZIyjp69/OzTvCwourmkoV2nFo
         GBCWKmoqihY2xgr9HofgTxTjEeYd8ejJFzrxF6OkvYQp56ombt0/duxihoCnANYG7PDk
         WPWuM61QnC6SnWSbepiEjF/prPWt1r065mJ5ojICFI8qrkuuOgma7gvjr7Qj2igrwm7W
         NMNg==
X-Gm-Message-State: ALoCoQl22ZRaPRI1OuZoLb52QMzIGTP8G29L/5YtyLyRD64cxt8mMX2iFEcQLYbc2AYZzz8NaQjC
X-Received: by 10.66.66.40 with SMTP id c8mr6254676pat.44.1413831855145;
        Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si435940yho.5.2014.10.20.12.04.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id ezN2XdvX.5; Mon, 20 Oct 2014 12:04:15 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 32708220B02; Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
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
Subject: [PATCH 15/19] clocksource: mips-gic: Remove gic_event_handler
Date:   Mon, 20 Oct 2014 12:04:02 -0700
Message-Id: <1413831846-32100-16-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43373
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

Remove gic_event_handler since it is completely unnecessary.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clocksource/mips-gic-timer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index bced17d..763aa1c 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -54,10 +54,6 @@ struct irqaction gic_compare_irqaction = {
 	.name = "timer",
 };
 
-static void gic_event_handler(struct clock_event_device *dev)
-{
-}
-
 int gic_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -86,7 +82,6 @@ int gic_clockevent_init(void)
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= gic_next_event;
 	cd->set_mode		= gic_set_clock_mode;
-	cd->event_handler	= gic_event_handler;
 
 	clockevents_register_device(cd);
 
-- 
2.1.0.rc2.206.gedb03e5
