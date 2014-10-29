Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 01:14:08 +0100 (CET)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:53813 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011799AbaJ2AMzye19k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 01:12:55 +0100
Received: by mail-ob0-f201.google.com with SMTP id nt9so296693obb.0
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 17:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmGGLuEGCM6WA9+GgvzqXTUb/MSUJIT1h3RPiugpXPs=;
        b=BajT0XTuFuEo6vg2Yi35JA9aUcBa2IB1nxnaAJtapHIDNsCScY3a3UgkJALjZcoH9N
         3zKxKQKEZkf5DngR2loSPl0mGEm25m/5RZuRfTltWUB6CEJ2OnxNplKfqZYolD2YrmCk
         oIr5+rilwS7u72GpWDZd1ilL5GkbUv5+VhCPSdMIRK4HqviGhTpEnBhNvBPS6vHiRs3r
         d7hBSGh4XsFHlqMXoDXiF+5TyXzCyFo0Mmc4OKPPlCOAqBpnTXogxKBrWjXpcB62EEsz
         CV+MnkicQ3sAzmRZTpZWxOCe6F77UmEehLRhCuyufu+pfNQgDWZJf0rJY+HEgZxnfwH1
         1nXw==
X-Gm-Message-State: ALoCoQn6tGc4u/kgJB+wAU/3GnGOziJqSKnyaTyZGX98XOhYQFRjCqKOdIZtf7DqQ86OzQnaHb/1
X-Received: by 10.182.130.133 with SMTP id oe5mr4520592obb.37.1414541570131;
        Tue, 28 Oct 2014 17:12:50 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si201725yhd.1.2014.10.28.17.12.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 17:12:50 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id OcxogoiP.1; Tue, 28 Oct 2014 17:12:50 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id AB337220E88; Tue, 28 Oct 2014 17:12:48 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] clocksource: mips-gic: Add device-tree support
Date:   Tue, 28 Oct 2014 17:12:42 -0700
Message-Id: <1414541562-10076-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43669
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

Parse the GIC timer frequency and interrupt from the device-tree.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
New for v3.
---
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/mips-gic-timer.c | 37 +++++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cb7e7f4..89836dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -226,5 +226,6 @@ config CLKSRC_VERSATILE
 config CLKSRC_MIPS_GIC
 	bool
 	depends on MIPS_GIC
+	select CLKSRC_OF
 
 endmenu
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index a749c81..fcdc534 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
 #include <linux/notifier.h>
+#include <linux/of_irq.h>
 #include <linux/percpu.h>
 #include <linux/smp.h>
 #include <linux/time.h>
@@ -101,8 +102,6 @@ static int gic_clockevent_init(void)
 	if (!cpu_has_counter || !gic_frequency)
 		return -ENXIO;
 
-	gic_timer_irq = MIPS_GIC_IRQ_BASE +
-		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
 	setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
 
 	register_cpu_notifier(&gic_cpu_nb);
@@ -123,17 +122,41 @@ static struct clocksource gic_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-void __init gic_clocksource_init(unsigned int frequency)
+static void __init __gic_clocksource_init(void)
 {
-	gic_frequency = frequency;
-
 	/* Set clocksource mask. */
 	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
 
 	/* Calculate a somewhat reasonable rating value. */
-	gic_clocksource.rating = 200 + frequency / 10000000;
+	gic_clocksource.rating = 200 + gic_frequency / 10000000;
 
-	clocksource_register_hz(&gic_clocksource, frequency);
+	clocksource_register_hz(&gic_clocksource, gic_frequency);
 
 	gic_clockevent_init();
 }
+
+void __init gic_clocksource_init(unsigned int frequency)
+{
+	gic_frequency = frequency;
+	gic_timer_irq = MIPS_GIC_IRQ_BASE +
+		GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_COMPARE);
+
+	__gic_clocksource_init();
+}
+
+static void __init gic_clocksource_of_init(struct device_node *node)
+{
+	if (of_property_read_u32(node, "clock-frequency", &gic_frequency)) {
+		pr_err("GIC frequency not specified.\n");
+		return;
+	}
+	gic_timer_irq = irq_of_parse_and_map(node, 0);
+	if (!gic_timer_irq) {
+		pr_err("GIC timer IRQ not specified.\n");
+		return;
+	}
+
+	__gic_clocksource_init();
+}
+CLOCKSOURCE_OF_DECLARE(mips_gic_timer, "mti,interaptiv-gic-timer",
+		       gic_clocksource_of_init);
-- 
2.1.0.rc2.206.gedb03e5
