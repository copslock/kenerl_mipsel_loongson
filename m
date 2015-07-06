Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:14:53 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34744 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010435AbbGFLNLWTfOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:11 +0200
Received: by pdbep18 with SMTP id ep18so104420331pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EtsSkvl+S6G3ukhWlZC59pYx8QRVr2xZwzzjz3rH+Cg=;
        b=NPnsljyXp8gbz1H7lk8HG45Cff8ECIwlEGOR1nkQ9VBPZ5aK4paAr/OD50rQzTUCzi
         XQR3z8ar/itkKuQqONyu6tMZ4IMFartn2a2zDUy9Ub/zOicYEFiqkIuMH8n7MsEAoNoT
         TR/PwxWNwPIvuGHJ+ThaiNLdI0jeBz5uC6FqeHyuOmXn+pTIF61ef0cp6R7p+mcGXJYD
         /sYVo78m6WLr1yqxhEeUY0059pHwXNIQjirdwDxXRG1c2MMzsbwEoidnEWoBqjG8R5Jy
         NXxCb4T879IliKIRiX0s1h92qvso7Ipu7ywTilXBHpvfB/9ygtHPHDEUPwoV1MIWjJzp
         olQA==
X-Gm-Message-State: ALoCoQkk9kX21xzCPoxbXajA+vtW0CXbFQq7oiWFGm6UJ6di1gFloatkO9AQAqaSJ9FKue+GvTq9
X-Received: by 10.66.139.168 with SMTP id qz8mr79172483pab.135.1436181185717;
        Mon, 06 Jul 2015 04:13:05 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id fr2sm17912921pdb.22.2015.07.06.04.13.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/14] MIPS/cevt-sb1250: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:41:59 +0530
Message-Id: <0d402cc83d2f09787dc0e43f4248f11b0def6558.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48073
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

Migrate cevt-rsb1250 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/kernel/cevt-sb1250.c | 45 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/cevt-sb1250.c b/arch/mips/kernel/cevt-sb1250.c
index 5ea6d6b1de15..3d860efd63b9 100644
--- a/arch/mips/kernel/cevt-sb1250.c
+++ b/arch/mips/kernel/cevt-sb1250.c
@@ -38,8 +38,20 @@
  * The general purpose timer ticks at 1MHz independent if
  * the rest of the system
  */
-static void sibyte_set_mode(enum clock_event_mode mode,
-			   struct clock_event_device *evt)
+
+static int sibyte_shutdown(struct clock_event_device *evt)
+{
+	void __iomem *cfg;
+
+	cfg = IOADDR(A_SCD_TIMER_REGISTER(smp_processor_id(), R_SCD_TIMER_CFG));
+
+	/* Stop the timer until we actually program a shot */
+	__raw_writeq(0, cfg);
+
+	return 0;
+}
+
+static int sibyte_set_periodic(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
 	void __iomem *cfg, *init;
@@ -47,24 +59,11 @@ static void sibyte_set_mode(enum clock_event_mode mode,
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
+
+	return 0;
 }
 
 static int sibyte_next_event(unsigned long delta, struct clock_event_device *cd)
@@ -89,7 +88,7 @@ static irqreturn_t sibyte_counter_handler(int irq, void *dev_id)
 	void __iomem *cfg;
 	unsigned long tmode;
 
-	if (cd->mode == CLOCK_EVT_MODE_PERIODIC)
+	if (clockevent_state_periodic(cd))
 		tmode = M_SCD_TIMER_ENABLE | M_SCD_TIMER_MODE_CONTINUOUS;
 	else
 		tmode = 0;
@@ -129,7 +128,9 @@ void sb1250_clockevent_init(void)
 	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= sibyte_next_event;
-	cd->set_mode		= sibyte_set_mode;
+	cd->set_state_shutdown	= sibyte_shutdown;
+	cd->set_state_periodic	= sibyte_set_periodic;
+	cd->set_state_oneshot	= sibyte_shutdown;
 	clockevents_register_device(cd);
 
 	sb1250_mask_irq(cpu, irq);
-- 
2.4.0
