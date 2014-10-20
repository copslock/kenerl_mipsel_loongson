Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:07:59 +0200 (CEST)
Received: from mail-ig0-f201.google.com ([209.85.213.201]:64852 "EHLO
        mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011983AbaJTTET4u7DN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:19 +0200
Received: by mail-ig0-f201.google.com with SMTP id h15so853770igd.4
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=re6CzWbGIuadicnnhACrUjlS8PO0RnbJp6npV1vq/A0=;
        b=Z977x/3UBYpj9rSmmzac3LpVhzDO7dt18PqNT/fZ++Pk2vvqp/W7HSQdQFbiKi/g9C
         BcTflX2iFihzO3GOqqw7BIrYJ28SynR/1wWrTZvYCeZ5Wsu4EEBCXwiEcGJJJLzihkLc
         yvUVn6nphMTqRuFNWP3xR0cI332sO3d81AtQfOnlq3JrqAASdKUoqVfXASAt2YuCP5By
         3iSK+11FRpdUBPmkCPRO7Dt2qPGNMlCwiyeqmY0RT/bfF2w2ehNEnsf1/yWQYznfq5cC
         MnZx7oTpbtJiZ+u3OxRHiBxB4ZZj5arg8O9tLIjk3mFV40UiBdm2WdNCrNKTjqhh/GKE
         8U9w==
X-Gm-Message-State: ALoCoQkHpPLBmw9YPic+6u/O6DJiQPYzrXIE8ST8GRAXuktduok//G5Kr4UxjBXr8QzMmbX0m5jF
X-Received: by 10.182.27.193 with SMTP id v1mr19710495obg.40.1413831854140;
        Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t28si436277yhb.4.2014.10.20.12.04.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id LUNvf60n.4; Mon, 20 Oct 2014 12:04:14 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 3C014220D57; Mon, 20 Oct 2014 12:04:13 -0700 (PDT)
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
Subject: [PATCH 13/19] clocksource: mips-gic: Staticize local symbols
Date:   Mon, 20 Oct 2014 12:04:00 -0700
Message-Id: <1413831846-32100-14-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43372
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

There are a number of variables and functions which are unnecessarily
global.  Mark them static.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clocksource/mips-gic-timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 3cf5912..2603f50 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -15,8 +15,8 @@
 
 #include <asm/time.h>
 
-DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
-int gic_timer_irq_installed;
+static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
+static int gic_timer_irq_installed;
 
 static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 {
@@ -30,13 +30,13 @@ static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 	return res;
 }
 
-void gic_set_clock_mode(enum clock_event_mode mode,
+static void gic_set_clock_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
 	/* Nothing to do ...  */
 }
 
-irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
+static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *cd;
 	int cpu = smp_processor_id();
@@ -53,7 +53,7 @@ struct irqaction gic_compare_irqaction = {
 	.name = "timer",
 };
 
-void gic_event_handler(struct clock_event_device *dev)
+static void gic_event_handler(struct clock_event_device *dev)
 {
 }
 
-- 
2.1.0.rc2.206.gedb03e5
