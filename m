Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2017 14:27:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46710 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990924AbdDSM05oiMHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2017 14:26:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A1E4F95CD5686;
        Wed, 19 Apr 2017 13:26:47 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 19 Apr 2017 13:26:50 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/2] MIPS: Malta: Probe gic-timer via devicetree
Date:   Wed, 19 Apr 2017 13:26:45 +0100
Message-ID: <1492604806-23420-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The Malta platform is the only platform remaining to probe the GIC
clocksource via gic_clocksource_init. This route hardcodes an expected
virq number based on MIPS_GIC_IRQ_BASE, which can be fragile to the
eventual virq layout. Instread, probe the driver using the preferred and
more modern devicetree method.

Before the driver is probed, set the "clock-frequency" property of the
devicetree node to the value detected by Malta platform code.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/mti-malta/malta-time.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 1829a9031eec..289edcfadd7c 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -21,6 +21,7 @@
 #include <linux/i8253.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/libfdt.h>
 #include <linux/math64.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
@@ -207,6 +208,33 @@ static void __init init_rtc(void)
 		CMOS_WRITE(ctrl & ~RTC_SET, RTC_CONTROL);
 }
 
+#ifdef CONFIG_CLKSRC_MIPS_GIC
+static u32 gic_frequency_dt;
+
+static struct property gic_frequency_prop = {
+	.name = "clock-frequency",
+	.length = sizeof(u32),
+	.value = &gic_frequency_dt,
+};
+
+static void update_gic_frequency_dt(void)
+{
+	struct device_node *node;
+
+	gic_frequency_dt = cpu_to_be32(gic_frequency);
+
+	node = of_find_compatible_node(NULL, NULL, "mti,gic-timer");
+	if (!node) {
+		pr_err("mti,gic-timer device node not found\n");
+		return;
+	}
+
+	if (of_update_property(node, &gic_frequency_prop) < 0)
+		pr_err("error updating gic frequency property\n");
+}
+
+#endif
+
 void __init plat_time_init(void)
 {
 	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
@@ -236,7 +264,8 @@ void __init plat_time_init(void)
 		printk("GIC frequency %d.%02d MHz\n", freq/1000000,
 		       (freq%1000000)*100/1000000);
 #ifdef CONFIG_CLKSRC_MIPS_GIC
-		gic_clocksource_init(gic_frequency);
+		update_gic_frequency_dt();
+		clocksource_probe();
 #endif
 	}
 #endif
-- 
2.7.4
