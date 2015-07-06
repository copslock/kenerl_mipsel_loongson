Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 13:16:08 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33927 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012934AbbGFLNabexBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 13:13:30 +0200
Received: by pdbep18 with SMTP id ep18so104424919pdb.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 04:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jcRP5L8yW+N7UACDBtTif9nQIXxYWj4M2fh097Z07h4=;
        b=kgOO2ile37J3Gb+/vgHIu+FghBhQfVVc9slxtaMqvulEdOmV6hJ4qBv4ESvUqqP1Sa
         m9mO7bwlyYwczXJvH1Hrp5vfulo75MHVe5FqJVf5vkbdKstF9syNFJVY1lbPJHhq+XPS
         Q+d9XhE1acswZdqJGqCbOk4rsnuQwQyI99DuQP0VJnhhhl1PahkQHsMCvLOMsrDwa5Om
         xbYL1n/o/MPbMdcijBz4I3vGfofgeMBB/UzaL/yk2gFPV2rwYIpibTgSBXqtWMzycAe1
         7UDW3QfwcCxal3WdhEs+Spe/nIufM+artlsXN/gIzlJC+fLCCsI3fWWy++S0ItLboBK9
         ySVA==
X-Gm-Message-State: ALoCoQl8iTMwHCqZNlOq+NwtFslL3hrxEhgrHqDXgtSlRx+HbPBWwadocEYcjz5hIgR3a1L8pw2z
X-Received: by 10.66.66.173 with SMTP id g13mr106479200pat.155.1436181204842;
        Mon, 06 Jul 2015 04:13:24 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id af5sm17866981pbc.90.2015.07.06.04.13.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 04:13:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/14] MIPS/ralink/rt3352: Migrate to new 'set-state' interface
Date:   Mon,  6 Jul 2015 16:42:03 +0530
Message-Id: <8e80bf58a3812f01e10a6a96864d754d9162e690.1436180306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48077
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

Migrate ralink driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/ralink/cevt-rt3352.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index 24bf057a3613..a8e70a9f274b 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -36,8 +36,8 @@ struct systick_device {
 	int freq_scale;
 };
 
-static void systick_set_clock_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt);
+static int systick_set_oneshot(struct clock_event_device *evt);
+static int systick_shutdown(struct clock_event_device *evt);
 
 static int systick_next_event(unsigned long delta,
 				struct clock_event_device *evt)
@@ -73,11 +73,12 @@ static struct systick_device systick = {
 		 * cevt-r4k uses 300, make sure systick
 		 * gets used if available
 		 */
-		.rating		= 310,
-		.features	= CLOCK_EVT_FEAT_ONESHOT,
-		.set_next_event	= systick_next_event,
-		.set_mode	= systick_set_clock_mode,
-		.event_handler	= systick_event_handler,
+		.rating			= 310,
+		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event		= systick_next_event,
+		.set_state_shutdown	= systick_shutdown,
+		.set_state_oneshot	= systick_set_oneshot,
+		.event_handler		= systick_event_handler,
 	},
 };
 
@@ -87,33 +88,33 @@ static struct irqaction systick_irqaction = {
 	.dev_id = &systick.dev,
 };
 
-static void systick_set_clock_mode(enum clock_event_mode mode,
-				struct clock_event_device *evt)
+static int systick_shutdown(struct clock_event_device *evt)
 {
 	struct systick_device *sdev;
 
 	sdev = container_of(evt, struct systick_device, dev);
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		if (!sdev->irq_requested)
-			setup_irq(systick.dev.irq, &systick_irqaction);
-		sdev->irq_requested = 1;
-		iowrite32(CFG_EXT_STK_EN | CFG_CNT_EN,
-				systick.membase + SYSTICK_CONFIG);
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		if (sdev->irq_requested)
-			free_irq(systick.dev.irq, &systick_irqaction);
-		sdev->irq_requested = 0;
-		iowrite32(0, systick.membase + SYSTICK_CONFIG);
-		break;
-
-	default:
-		pr_err("%s: Unhandeled mips clock_mode\n", systick.dev.name);
-		break;
-	}
+	if (sdev->irq_requested)
+		free_irq(systick.dev.irq, &systick_irqaction);
+	sdev->irq_requested = 0;
+	iowrite32(0, systick.membase + SYSTICK_CONFIG);
+
+	return 0;
+}
+
+static int systick_set_oneshot(struct clock_event_device *evt)
+{
+	struct systick_device *sdev;
+
+	sdev = container_of(evt, struct systick_device, dev);
+
+	if (!sdev->irq_requested)
+		setup_irq(systick.dev.irq, &systick_irqaction);
+	sdev->irq_requested = 1;
+	iowrite32(CFG_EXT_STK_EN | CFG_CNT_EN,
+		  systick.membase + SYSTICK_CONFIG);
+
+	return 0;
 }
 
 static void __init ralink_systick_init(struct device_node *np)
-- 
2.4.0
