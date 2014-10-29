Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 00:21:11 +0100 (CET)
Received: from mail-qc0-f201.google.com ([209.85.216.201]:62195 "EHLO
        mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012224AbaJ2XUBtbQsv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 00:20:01 +0100
Received: by mail-qc0-f201.google.com with SMTP id l6so285221qcy.2
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2014 16:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJF9KpjLw3SHIWiQ2conhJ3NtLzhC8/BWuJgjraZSL4=;
        b=HfHdU/UsHHSPxrMkEhXHXsup695pqPKcCl4TGagHATkWMTs5XnxwfLqSJpp2wp7APz
         VhrmT47IuGrsNEDM0hbP1RTiq9ufcCn/K42b6OGI0Yf1GiCWN/7AVcfwXy4W578qItGe
         ded8xStwy1jH+ckeBwKFctinmo+CZtd3w6GEQlIlNV5pz7l+JWavL8H8lTDDKfNcoINg
         S9/pQkwkQKCUjWVH1JRtT0uZK6iDgxbzkhzCfVmrqY0U8PbxZIkUXfLhebGKRQJHyscK
         GTrlOon2eUOAjMsuiRIxEBgQrrGRh5wdglS0tQcYNVQvTc7Tmb5wHZB8oEMWI4OfZzgF
         dx9Q==
X-Gm-Message-State: ALoCoQm6yYWsUzqnu8e3wqdqv2lY+fKFekHDni6e2dl5wzHYsP8ydjsP+lZSVY35Lm4C8IUNY5ro
X-Received: by 10.236.13.105 with SMTP id a69mr3835532yha.16.1414624795871;
        Wed, 29 Oct 2014 16:19:55 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si350859yhd.1.2014.10.29.16.19.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 16:19:55 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id xM7nvPus.1; Wed, 29 Oct 2014 16:19:55 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 32BCC2205C1; Wed, 29 Oct 2014 16:19:54 -0700 (PDT)
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
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] clocksource: mips-gic: Add device-tree support
Date:   Wed, 29 Oct 2014 16:19:50 -0700
Message-Id: <1414624790-15690-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
References: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43735
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
Since the GIC timer requires the GIC irqchip to have been set up
already and is a sub-node of the GIC, probe the GIC timer from the
GIC irqchip.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes from v3:
 - probe from GIC irqchip
New for v3.
---
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/mips-gic-timer.c | 35 ++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-mips-gic.c       |  7 +++++++
 include/linux/irqchip/mips-gic.h     |  3 +++
 4 files changed, 39 insertions(+), 7 deletions(-)

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
index a749c81..b59f04b 100644
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
@@ -123,17 +122,39 @@ static struct clocksource gic_clocksource = {
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
+void __init gic_clocksource_of_init(struct device_node *node)
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
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 8a9ef74..3145e87 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -742,6 +742,7 @@ void __init gic_init(unsigned long gic_base_addr,
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
+	struct device_node *child;
 	struct resource res;
 	unsigned int cpu_vec, i = 0, reserved = 0;
 	phys_addr_t gic_base;
@@ -784,6 +785,12 @@ static int __init gic_of_init(struct device_node *node,
 
 	__gic_init(gic_base, gic_len, cpu_vec, 0, node);
 
+	/* Set up the GIC timer, if present. */
+	for_each_child_of_node(node, child) {
+		if (of_device_is_compatible(child, "mti,gic-timer"))
+			gic_clocksource_of_init(child);
+	}
+
 	return 0;
 }
 IRQCHIP_DECLARE(mips_gic, "mti,gic", gic_of_init);
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 420f77b..7b383b2 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -229,12 +229,15 @@
 #define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
 #define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
 
+struct device_node;
+
 extern unsigned int gic_present;
 
 extern void gic_init(unsigned long gic_base_addr,
 	unsigned long gic_addrspace_size, unsigned int cpu_vec,
 	unsigned int irqbase);
 extern void gic_clocksource_init(unsigned int);
+extern void gic_clocksource_of_init(struct device_node *node);
 extern cycle_t gic_read_count(void);
 extern unsigned int gic_get_count_width(void);
 extern cycle_t gic_read_compare(void);
-- 
2.1.0.rc2.206.gedb03e5
