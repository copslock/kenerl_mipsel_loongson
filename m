Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:15:47 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36471 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbbGFLNZpXxle (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:25 +0200
Received: by pacgz10 with SMTP id gz10so20279567pac.3
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oE8rhY97JcLdZi5OhZ4S9+wIzAGeAJVw8p+PhBxiGlQ=;
        b=OT4n2crk0gOacx8vNIrDAmWKA/dJrJZXxdy12ULkoXS4bDZn5FYuLGcLh9HDxXsZlk
         /2SapUpl7FCyOadwO7bhXRo4U7QGJ0kv8NocJear5WsSpnsISWZ1+dG6kvqVxQHGvtoQ
         Kf3h8XfjcrWRNbtvPK3KLq0VCzwYZczcpTdoHWkRDDnj0sUVFFT8nrBYrfsenyAAS1QG
         cHmSbFuEViDT/qgAbTFTwqvKNWAaCm/Iecb4zVNbBsPnNMBTWrenCTcoqSTtSY1x6+z8
         2sTmGDSv7g7E7d+Bp+ZyQl2KOPMn9kabwgARB6mOJJ7PX1RdZfThTQWDzCwG/x9eeS+C
         /81A==
X-Gm-Message-State: ALoCoQnOnbXZlFzEvHWwk8HHqcvBSsWylRYoBRt+1bYzMmZzdcf6poxyIzAePGsBcB/TXtkmG7dE
X-Received: by 10.66.236.70 with SMTP id us6mr104174284pac.39.1436181200091;
        Mon, 06 Jul 2015 04:13:20 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id a10sm17902912pdn.57.2015.07.06.04.13.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 11/14] MIPS/loongsoon32/time: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:42:02 +0530
Message-Id: <ae6c62c9e355d50f2fe0a7c9ba1c0fe65f7c6325.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

Migrate loongsoon32 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kelvin Cheung <keguang.zhang@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/loongson32/common/time.c | 57 +++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index df0f850d6a5f..0996b025eeef 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -126,26 +126,34 @@ static irqreturn_t ls1x_clockevent_isr(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static void ls1x_clockevent_set_mode(enum clock_event_mode mode,
-				     struct clock_event_device *cd)
+static int ls1x_clockevent_set_state_periodic(struct clock_event_device *cd)
 {
 	raw_spin_lock(&ls1x_timer_lock);
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
-		ls1x_pwmtimer_restart();
-	case CLOCK_EVT_MODE_RESUME:
-		__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		__raw_writel(__raw_readl(timer_base + PWM_CTRL) & ~CNT_EN,
-			     timer_base + PWM_CTRL);
-		break;
-	default:
-		break;
-	}
+	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
+	ls1x_pwmtimer_restart();
+	__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
 	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_tick_resume(struct clock_event_device *cd)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static int ls1x_clockevent_set_state_shutdown(struct clock_event_device *cd)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	__raw_writel(__raw_readl(timer_base + PWM_CTRL) & ~CNT_EN,
+		     timer_base + PWM_CTRL);
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
 }
 
 static int ls1x_clockevent_set_next(unsigned long evt,
@@ -160,12 +168,15 @@ static int ls1x_clockevent_set_next(unsigned long evt,
 }
 
 static struct clock_event_device ls1x_clockevent = {
-	.name		= "ls1x-pwmtimer",
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.rating		= 300,
-	.irq		= LS1X_TIMER_IRQ,
-	.set_next_event	= ls1x_clockevent_set_next,
-	.set_mode	= ls1x_clockevent_set_mode,
+	.name			= "ls1x-pwmtimer",
+	.features		= CLOCK_EVT_FEAT_PERIODIC,
+	.rating			= 300,
+	.irq			= LS1X_TIMER_IRQ,
+	.set_next_event		= ls1x_clockevent_set_next,
+	.set_state_shutdown	= ls1x_clockevent_set_state_shutdown,
+	.set_state_periodic	= ls1x_clockevent_set_state_periodic,
+	.set_state_oneshot	= ls1x_clockevent_set_state_shutdown,
+	.tick_resume		= ls1x_clockevent_tick_resume,
 };
 
 static struct irqaction ls1x_pwmtimer_irqaction = {
-- 
2.4.0
