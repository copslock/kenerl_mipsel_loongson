Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:13:24 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36119 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010032AbbGFLMrZWGZe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:12:47 +0200
Received: by pacgz10 with SMTP id gz10so20271711pac.3
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QbLwsHDzJT7bzJAoZy//DvH/bBFUDIZ6XMYatWEIrKc=;
        b=Yq35+4xI3FOiqfFXOSeus7pUN5HJnETO7czHXvZp+WiTrJvFDiF4MbcJ3fE7v4BrHQ
         0NF2rhBNvF7ZyrRXC0OWL1rQ9ByoPsTILnkeDmWQRDmq/yoCuGwa1Ghma2vsoMgApN2W
         n4W88zDxdR0oKtwV7+DHMNBD6MFnZ6i9hfnMzlAMdf+iTXcVumikstyonfCtV1U8enX5
         sATNnlUHneARoNUJgLGMVoUa4Co17QUple0OtkMJu9/1tCtcSQomBPsDj/F6fu0GHuX2
         5Ou7HtJMILa+Tetu6MpTFa3MetviBl8JDlkNJo93F5VhMRreM/mcl7QeE7A9v3AksHnp
         vCVg==
X-Gm-Message-State: ALoCoQlkYmq4hegdfdHkEPnhwT27de/iK+aHu/+n+qwqkIWzphSjb1VwShRa3GPoOMJLDKpzw4HX
X-Received: by 10.68.88.33 with SMTP id bd1mr77891141pbb.124.1436181161755;
        Mon, 06 Jul 2015 04:12:41 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id g2sm17914454pdh.11.2015.07.06.04.12.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 03/14] MIPS/jz4740/time: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:54 +0530
Message-Id: <1580bd7bee1421df874884198e3a7c85f778e319.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48068
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

Migrate jz4740 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/jz4740/time.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 7ab47fee1be8..1f7ca2c9f262 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -58,7 +58,7 @@ static irqreturn_t jz4740_clockevent_irq(int irq, void *devid)
 
 	jz4740_timer_ack_full(TIMER_CLOCKEVENT);
 
-	if (cd->mode != CLOCK_EVT_MODE_PERIODIC)
+	if (!clockevent_state_periodic(cd))
 		jz4740_timer_disable(TIMER_CLOCKEVENT);
 
 	cd->event_handler(cd);
@@ -66,24 +66,29 @@ static irqreturn_t jz4740_clockevent_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static void jz4740_clockevent_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *cd)
+static int jz4740_clockevent_set_periodic(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		jz4740_timer_set_count(TIMER_CLOCKEVENT, 0);
-		jz4740_timer_set_period(TIMER_CLOCKEVENT, jz4740_jiffies_per_tick);
-	case CLOCK_EVT_MODE_RESUME:
-		jz4740_timer_irq_full_enable(TIMER_CLOCKEVENT);
-		jz4740_timer_enable(TIMER_CLOCKEVENT);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		jz4740_timer_disable(TIMER_CLOCKEVENT);
-		break;
-	default:
-		break;
-	}
+	jz4740_timer_set_count(TIMER_CLOCKEVENT, 0);
+	jz4740_timer_set_period(TIMER_CLOCKEVENT, jz4740_jiffies_per_tick);
+	jz4740_timer_irq_full_enable(TIMER_CLOCKEVENT);
+	jz4740_timer_enable(TIMER_CLOCKEVENT);
+
+	return 0;
+}
+
+static int jz4740_clockevent_resume(struct clock_event_device *evt)
+{
+	jz4740_timer_irq_full_enable(TIMER_CLOCKEVENT);
+	jz4740_timer_enable(TIMER_CLOCKEVENT);
+
+	return 0;
+}
+
+static int jz4740_clockevent_shutdown(struct clock_event_device *evt)
+{
+	jz4740_timer_disable(TIMER_CLOCKEVENT);
+
+	return 0;
 }
 
 static int jz4740_clockevent_set_next(unsigned long evt,
@@ -100,7 +105,10 @@ static struct clock_event_device jz4740_clockevent = {
 	.name = "jz4740-timer",
 	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_next_event = jz4740_clockevent_set_next,
-	.set_mode = jz4740_clockevent_set_mode,
+	.set_state_shutdown = jz4740_clockevent_shutdown,
+	.set_state_periodic = jz4740_clockevent_set_periodic,
+	.set_state_oneshot = jz4740_clockevent_shutdown,
+	.tick_resume = jz4740_clockevent_resume,
 	.rating = 200,
 #ifdef CONFIG_MACH_JZ4740
 	.irq = JZ4740_IRQ_TCU0,
-- 
2.4.0
