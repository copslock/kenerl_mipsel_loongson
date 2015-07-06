Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:13:42 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34553 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012552AbbGFLMwPF0Ne (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:12:52 +0200
Received: by pdbep18 with SMTP id ep18so104416211pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MzgOT1iBTWWOvxVgfGdblSrqrLYutt1S8AmbGxEc6Nk=;
        b=eDKNfBHosdKaBABWRx9oK68kdcR5de7Km5jhoLbyXgWKGV7sAQhA6FJdTeBL8sxstc
         Oe4GnT5ZqNxSFJokwUrUGDK/xygseWiWi+PXif4FdBtpPHp8yRmvj2B33Kn3MZqGyLUa
         KLwyyEPHNbOJ/ehrZvmFv1y/1xEJDzJK+3zHcR4Qb8Ayed121f3ZW/6RuVeeHxvYjgnM
         EShUyDyT/H7NcwC0ZxKbeKGDlIOs8k5ufoYMJHK+iZHDB4Zw4/iZBsPjYOTO5akrR5J4
         zis6A2uRLsNXCsqPFdQBO0tbojvTIRXWlAZwN0BAi/limfSlAkCys4lP9Q9yo8VI3sfQ
         OPxA==
X-Gm-Message-State: ALoCoQkNimEoxAxTt1MZVbIHECCtRFN+NtgnDp29pZvI5/eAAfkcaBfR3CGtAfN/SEmK2pN/fLJ9
X-Received: by 10.67.4.201 with SMTP id cg9mr104928454pad.53.1436181166550;
        Mon, 06 Jul 2015 04:12:46 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id a7sm5253032pbu.0.2015.07.06.04.12.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:12:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/14] MIPS/cevt-bcm1480: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:55 +0530
Message-Id: <c8e2e8af7e2730e33770d7866d74af2070781027.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48069
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

Migrate cevt-bcm1480 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Read operation on R_SCD_TIMER_CFG and R_SCD_TIMER_INIT registers isn't
performed now for many modes as there returned values aren't used.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/kernel/cevt-bcm1480.c | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/cevt-bcm1480.c b/arch/mips/kernel/cevt-bcm1480.c
index 7976457184b1..940ac00e9129 100644
--- a/arch/mips/kernel/cevt-bcm1480.c
+++ b/arch/mips/kernel/cevt-bcm1480.c
@@ -40,8 +40,8 @@
  * The general purpose timer ticks at 1MHz independent if
  * the rest of the system
  */
-static void sibyte_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *evt)
+
+static int sibyte_set_periodic(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
 	void __iomem *cfg, *init;
@@ -49,24 +49,22 @@ static void sibyte_set_mode(enum clock_event_mode mode,
 	cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
 	init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT));
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		__raw_writeq(0, cfg);
-		__raw_writeq((V_SCD_TIMER_FREQ / HZ) - 1, init);
-		__raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS,
-			     cfg);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Stop the timer until we actually program a shot */
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		__raw_writeq(0, cfg);
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:	/* shuddup gcc */
-	case CLOCK_EVT_MODE_RESUME:
-		;
-	}
+	__raw_writeq(0, cfg);
+	__raw_writeq((V_SCD_TIMER_FREQ / HZ) - 1, init);
+	__raw_writeq(M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS, cfg);
+	return 0;
+}
+
+static int sibyte_shutdown(struct clock_event_device *evt)
+{
+	unsigned int cpu = smp_processor_id();
+	void __iomem *cfg;
+
+	cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
+
+	/* Stop the timer until we actually program a shot */
+	__raw_writeq(0, cfg);
+	return 0;
 }
 
 static int sibyte_next_event(unsigned long delta, struct clock_event_device *cd)
@@ -91,7 +89,7 @@ static irqreturn_t sibyte_counter_handler(int irq, void *dev_id)
 	void __iomem *cfg;
 	unsigned long tmode;
 
-	if (cd->mode == CLOCK_EVT_MODE_PERIODIC)
+	if (clockevent_state_periodic(cd))
 		tmode = M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS;
 	else
 		tmode = 0;
@@ -130,7 +128,9 @@ void sb1480_clockevent_init(void)
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= sibyte_next_event;
-	cd->set_mode		= sibyte_set_mode;
+	cd->set_state_shutdown	= sibyte_shutdown;
+	cd->set_state_periodic	= sibyte_set_periodic;
+	cd->set_state_oneshot	= sibyte_shutdown;
 	clockevents_register_device(cd);
 
 	bcm1480_mask_irq(cpu, irq);
-- 
2.4.0
