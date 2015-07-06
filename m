Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:15:31 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33828 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012726AbbGFLNU5hyae (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:20 +0200
Received: by pdbep18 with SMTP id ep18so104422685pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ex1CDqkhNhoelG7lAA/gIlKslmI/L7O7FwvDSUCzDqk=;
        b=LUNwixPv6Be8by7zQ0zOvq7g99VAc+xON0/J5rM5GTJ6Sunb1nDFjUJ33+87Yl0bfJ
         iXWUbwN4JLTOoLO9rf0UC5UJgnkBKexJzI1ADkrjEaVIuPH0X2yTm65ZB7jACjITPLyh
         gIWQqL0CSikQ5htM3hAHj3+tawRbisMZnq3ftpvABA2+wfwYQ5tEoswW2Y2JfzxfclrB
         hzZUdi9cMBRlg8Ztpfmb6nKNrk/0mw97ULumVIF7O9NfGNxVACZ7quOdLtJETWPRVcy4
         vaEjGeM4wOL7R4o/VK0Y192zYlb1i28c9MRRmBAmHvkjTGOJq+T572nH3SSRvsO10vil
         gQsA==
X-Gm-Message-State: ALoCoQkZCD8FNLvyFcc0BoF8o0VQ4trGjzSp8nBD8Ko6mY3SkgKcvPBzJE3Q7iqNSK9N7+8wwFfI
X-Received: by 10.68.129.134 with SMTP id nw6mr103632362pbb.109.1436181195254;
        Mon, 06 Jul 2015 04:13:15 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id pb6sm17872685pbc.75.2015.07.06.04.13.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Hongliang Tao <taohl@lemote.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 10/14] MIPS/loongson64/timer: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:42:01 +0530
Message-Id: <fc1e2f7d8a257ab03f93a57552de47ac84c1b374.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48075
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

Migrate loongson driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: Hongliang Tao <taohl@lemote.com>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c |  46 ++++-----
 arch/mips/loongson64/loongson-3/hpet.c            | 116 +++++++++++++---------
 2 files changed, 92 insertions(+), 70 deletions(-)

diff --git a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
index 12c75db23420..2f4b30f06b19 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
@@ -51,40 +51,36 @@ void enable_mfgpt0_counter(void)
 }
 EXPORT_SYMBOL(enable_mfgpt0_counter);
 
-static void init_mfgpt_timer(enum clock_event_mode mode,
-			     struct clock_event_device *evt)
+static int mfgpt_timer_set_periodic(struct clock_event_device *evt)
 {
 	raw_spin_lock(&mfgpt_lock);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		outw(COMPARE, MFGPT0_CMP2);	/* set comparator2 */
-		outw(0, MFGPT0_CNT);	/* set counter to 0 */
-		enable_mfgpt0_counter();
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
-		    evt->mode == CLOCK_EVT_MODE_ONESHOT)
-			disable_mfgpt0_counter();
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* The oneshot mode have very high deviation, Not use it! */
-		break;
-
-	case CLOCK_EVT_MODE_RESUME:
-		/* Nothing to do here */
-		break;
-	}
+	outw(COMPARE, MFGPT0_CMP2);	/* set comparator2 */
+	outw(0, MFGPT0_CNT);		/* set counter to 0 */
+	enable_mfgpt0_counter();
+
 	raw_spin_unlock(&mfgpt_lock);
+	return 0;
+}
+
+static int mfgpt_timer_shutdown(struct clock_event_device *evt)
+{
+	if (clockevent_state_periodic(evt) || clockevent_state_oneshot(evt)) {
+		raw_spin_lock(&mfgpt_lock);
+		disable_mfgpt0_counter();
+		raw_spin_unlock(&mfgpt_lock);
+	}
+
+	return 0;
 }
 
 static struct clock_event_device mfgpt_clockevent = {
 	.name = "mfgpt",
 	.features = CLOCK_EVT_FEAT_PERIODIC,
-	.set_mode = init_mfgpt_timer,
+
+	/* The oneshot mode have very high deviation, don't use it! */
+	.set_state_shutdown = mfgpt_timer_shutdown,
+	.set_state_periodic = mfgpt_timer_set_periodic,
 	.irq = CS5536_MFGPT_INTR,
 };
 
diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
index 5c21cd3bd339..950096e8d7cd 100644
--- a/arch/mips/loongson64/loongson-3/hpet.c
+++ b/arch/mips/loongson64/loongson-3/hpet.c
@@ -78,55 +78,77 @@ static void hpet_enable_legacy_int(void)
 	/* Do nothing on Loongson-3 */
 }
 
-static void hpet_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+static int hpet_set_state_periodic(struct clock_event_device *evt)
 {
-	int cfg = 0;
+	int cfg;
 
 	spin_lock(&hpet_lock);
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		pr_info("set clock event to periodic mode!\n");
-		/* stop counter */
-		hpet_stop_counter();
-
-		/* enables the timer0 to generate a periodic interrupt */
-		cfg = hpet_read(HPET_T0_CFG);
-		cfg &= ~HPET_TN_LEVEL;
-		cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
-				HPET_TN_SETVAL | HPET_TN_32BIT;
-		hpet_write(HPET_T0_CFG, cfg);
-
-		/* set the comparator */
-		hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
-		udelay(1);
-		hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
-
-		/* start counter */
-		hpet_start_counter();
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-		cfg = hpet_read(HPET_T0_CFG);
-		cfg &= ~HPET_TN_ENABLE;
-		hpet_write(HPET_T0_CFG, cfg);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		pr_info("set clock event to one shot mode!\n");
-		cfg = hpet_read(HPET_T0_CFG);
-		/* set timer0 type
-		 * 1 : periodic interrupt
-		 * 0 : non-periodic(oneshot) interrupt
-		 */
-		cfg &= ~HPET_TN_PERIODIC;
-		cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
-		hpet_write(HPET_T0_CFG, cfg);
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		hpet_enable_legacy_int();
-		break;
-	}
+
+	pr_info("set clock event to periodic mode!\n");
+	/* stop counter */
+	hpet_stop_counter();
+
+	/* enables the timer0 to generate a periodic interrupt */
+	cfg = hpet_read(HPET_T0_CFG);
+	cfg &= ~HPET_TN_LEVEL;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
+		HPET_TN_32BIT;
+	hpet_write(HPET_T0_CFG, cfg);
+
+	/* set the comparator */
+	hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
+	udelay(1);
+	hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
+
+	/* start counter */
+	hpet_start_counter();
+
+	spin_unlock(&hpet_lock);
+	return 0;
+}
+
+static int hpet_set_state_shutdown(struct clock_event_device *evt)
+{
+	int cfg;
+
+	spin_lock(&hpet_lock);
+
+	cfg = hpet_read(HPET_T0_CFG);
+	cfg &= ~HPET_TN_ENABLE;
+	hpet_write(HPET_T0_CFG, cfg);
+
 	spin_unlock(&hpet_lock);
+	return 0;
+}
+
+static int hpet_set_state_oneshot(struct clock_event_device *evt)
+{
+	int cfg;
+
+	spin_lock(&hpet_lock);
+
+	pr_info("set clock event to one shot mode!\n");
+	cfg = hpet_read(HPET_T0_CFG);
+	/*
+	 * set timer0 type
+	 * 1 : periodic interrupt
+	 * 0 : non-periodic(oneshot) interrupt
+	 */
+	cfg &= ~HPET_TN_PERIODIC;
+	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
+	hpet_write(HPET_T0_CFG, cfg);
+
+	spin_unlock(&hpet_lock);
+	return 0;
+}
+
+static int hpet_tick_resume(struct clock_event_device *evt)
+{
+	spin_lock(&hpet_lock);
+	hpet_enable_legacy_int();
+	spin_unlock(&hpet_lock);
+
+	return 0;
 }
 
 static int hpet_next_event(unsigned long delta,
@@ -207,6 +229,10 @@ void __init setup_hpet_timer(void)
 	cd->rating = 320;
 	cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	cd->set_mode = hpet_set_mode;
+	cd->set_state_shutdown = hpet_set_state_shutdown;
+	cd->set_state_periodic = hpet_set_state_periodic;
+	cd->set_state_oneshot = hpet_set_state_oneshot;
+	cd->tick_resume = hpet_tick_resume;
 	cd->set_next_event = hpet_next_event;
 	cd->irq = HPET_T0_IRQ;
 	cd->cpumask = cpumask_of(cpu);
-- 
2.4.0
