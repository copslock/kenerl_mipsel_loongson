Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:14:17 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34651 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012612AbbGFLNByufze (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:01 +0200
Received: by pdbep18 with SMTP id ep18so104418314pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EooNiQE3iRZCWJ7fJueBtbNOIAjjZ2vkYygJr+DSxTI=;
        b=Rkgzsfh8iRxe9yt0ehk72kIzP4npZRyaF0LhDBFad90OnSm8xflg8KrC1gEu8gFeu/
         wsx376M+jsxxef09MXs2Fb3wPnih6MDI+2xek/OU3BbxyjkFW6W5B2Msv2cm3u7bt1qk
         j7Y3Ma2LpSdqCbsih9NFiomP9p37G8QMpgfO54ObZngCIYTTn9C262uWIAZm/M4hp2jm
         OQAhFSeWWeOnx0ocrd2SIJWSbBz75XwDM/Po9Y+o58KWYiyf5VSKOllMhh0THshBpVyY
         IxVg9bd791u/4uArnmrRtY6GTuWWVio1itV2jixxw4P6l3h3YUyeQDV0gSvaHERnlxgs
         NmZA==
X-Gm-Message-State: ALoCoQmlHx5Pi4PHay3K3yosGd/BMfDUxDqpTjixTP/DRBRZAo/9NNVGLfVjbDWr2A95IY0OU9Ak
X-Received: by 10.68.241.69 with SMTP id wg5mr2251736pbc.120.1436181176249;
        Mon, 06 Jul 2015 04:12:56 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id hf7sm17873595pbc.66.2015.07.06.04.12.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:55 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/14] MIPS/cevt-gt641xx: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:57 +0530
Message-Id: <88ca9bdbc1fe5723807f8e61333f455af18694de.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48071
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

Migrate cevt-gt641xx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/kernel/cevt-gt641xx.c | 57 ++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/arch/mips/kernel/cevt-gt641xx.c b/arch/mips/kernel/cevt-gt641xx.c
index f069460751ab..66040051151d 100644
--- a/arch/mips/kernel/cevt-gt641xx.c
+++ b/arch/mips/kernel/cevt-gt641xx.c
@@ -64,8 +64,7 @@ static int gt641xx_timer0_set_next_event(unsigned long delta,
 	return 0;
 }
 
-static void gt641xx_timer0_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
+static int gt641xx_timer0_shutdown(struct clock_event_device *evt)
 {
 	u32 ctrl;
 
@@ -73,21 +72,39 @@ static void gt641xx_timer0_set_mode(enum clock_event_mode mode,
 
 	ctrl = GT_READ(GT_TC_CONTROL_OFS);
 	ctrl &= ~(GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
+	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
+
+	raw_spin_unlock(&gt641xx_timer_lock);
+	return 0;
+}
+
+static int gt641xx_timer0_set_oneshot(struct clock_event_device *evt)
+{
+	u32 ctrl;
+
+	raw_spin_lock(&gt641xx_timer_lock);
+
+	ctrl = GT_READ(GT_TC_CONTROL_OFS);
+	ctrl &= ~GT_TC_CONTROL_SELTC0_MSK;
+	ctrl |= GT_TC_CONTROL_ENTC0_MSK;
+	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
+
+	raw_spin_unlock(&gt641xx_timer_lock);
+	return 0;
+}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		ctrl |= GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK;
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		ctrl |= GT_TC_CONTROL_ENTC0_MSK;
-		break;
-	default:
-		break;
-	}
+static int gt641xx_timer0_set_periodic(struct clock_event_device *evt)
+{
+	u32 ctrl;
+
+	raw_spin_lock(&gt641xx_timer_lock);
 
+	ctrl = GT_READ(GT_TC_CONTROL_OFS);
+	ctrl |= GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK;
 	GT_WRITE(GT_TC_CONTROL_OFS, ctrl);
 
 	raw_spin_unlock(&gt641xx_timer_lock);
+	return 0;
 }
 
 static void gt641xx_timer0_event_handler(struct clock_event_device *dev)
@@ -95,12 +112,16 @@ static void gt641xx_timer0_event_handler(struct clock_event_device *dev)
 }
 
 static struct clock_event_device gt641xx_timer0_clockevent = {
-	.name		= "gt641xx-timer0",
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.irq		= GT641XX_TIMER0_IRQ,
-	.set_next_event = gt641xx_timer0_set_next_event,
-	.set_mode	= gt641xx_timer0_set_mode,
-	.event_handler	= gt641xx_timer0_event_handler,
+	.name			= "gt641xx-timer0",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.irq			= GT641XX_TIMER0_IRQ,
+	.set_next_event		= gt641xx_timer0_set_next_event,
+	.set_state_shutdown	= gt641xx_timer0_shutdown,
+	.set_state_periodic	= gt641xx_timer0_set_periodic,
+	.set_state_oneshot	= gt641xx_timer0_set_oneshot,
+	.tick_resume		= gt641xx_timer0_shutdown,
+	.event_handler		= gt641xx_timer0_event_handler,
 };
 
 static irqreturn_t gt641xx_timer0_interrupt(int irq, void *dev_id)
-- 
2.4.0
