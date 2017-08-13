Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:48:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1876 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993913AbdHMEp6pmCpd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:45:58 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 215587375ED34;
        Sun, 13 Aug 2017 05:45:50 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:45:51 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 28/38] irqchip: mips-gic: Move gic_get_c0_*_int() to asm/mips-gic.h
Date:   Sat, 12 Aug 2017 21:36:36 -0700
Message-ID: <20170813043646.25821-29-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The linux/irqchip/mips-gic.h header is now almost empty. Move the
declarations of gic_get_c0_compare_int(), gic_get_c0_perfcount_int() &
gic_get_c0_fdc_int() to asm/mips-gic.h in order to close in on being
able to delete the former header.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/irq.c          |  1 -
 arch/mips/include/asm/mips-gic.h | 30 ++++++++++++++++++++++++++++++
 arch/mips/mti-malta/malta-time.c |  1 -
 arch/mips/pistachio/time.c       |  2 +-
 arch/mips/ralink/irq-gic.c       |  2 +-
 drivers/irqchip/irq-mips-gic.c   |  1 -
 include/linux/irqchip/mips-gic.h |  8 --------
 7 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
index a05fcb328e2e..b193fbf4a6eb 100644
--- a/arch/mips/generic/irq.c
+++ b/arch/mips/generic/irq.c
@@ -12,7 +12,6 @@
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/types.h>
 
 #include <asm/irq.h>
diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
index 27736d7f4aba..a2badf572632 100644
--- a/arch/mips/include/asm/mips-gic.h
+++ b/arch/mips/include/asm/mips-gic.h
@@ -314,4 +314,34 @@ static inline bool mips_gic_present(void)
 	return IS_ENABLED(CONFIG_MIPS_GIC) && mips_gic_base;
 }
 
+/**
+ * gic_get_c0_compare_int() - Return cp0 count/compare interrupt virq
+ *
+ * Determine the virq number to use for the coprocessor 0 count/compare
+ * interrupt, which may be routed via the GIC.
+ *
+ * Returns the virq number or a negative error number.
+ */
+extern int gic_get_c0_compare_int(void);
+
+/**
+ * gic_get_c0_perfcount_int() - Return performance counter interrupt virq
+ *
+ * Determine the virq number to use for CPU performance counter interrupts,
+ * which may be routed via the GIC.
+ *
+ * Returns the virq number or a negative error number.
+ */
+extern int gic_get_c0_perfcount_int(void);
+
+/**
+ * gic_get_c0_fdc_int() - Return fast debug channel interrupt virq
+ *
+ * Determine the virq number to use for fast debug channel (FDC) interrupts,
+ * which may be routed via the GIC.
+ *
+ * Returns the virq number or a negative error number.
+ */
+extern int gic_get_c0_fdc_int(void);
+
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 7db872be01c0..59fb3ce17c71 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -26,7 +26,6 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/timex.h>
 #include <linux/mc146818rtc.h>
 
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
index 17a0f1dec05b..8a6af9b76202 100644
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -12,9 +12,9 @@
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/of.h>
 
+#include <asm/mips-cps.h>
 #include <asm/time.h>
 
 unsigned int get_c0_compare_int(void)
diff --git a/arch/mips/ralink/irq-gic.c b/arch/mips/ralink/irq-gic.c
index 2058280450b5..bda576f2cad8 100644
--- a/arch/mips/ralink/irq-gic.c
+++ b/arch/mips/ralink/irq-gic.c
@@ -11,7 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/mips-gic.h>
+#include <asm/mips-cps.h>
 
 int get_c0_perfcount_int(void)
 {
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 5e1966777ab7..e77e194740a9 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -12,7 +12,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/of_address.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 113010c8dd8b..277d5be03a57 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -15,12 +15,4 @@
 #define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
-#ifdef CONFIG_MIPS_GIC
-
-extern int gic_get_c0_compare_int(void);
-extern int gic_get_c0_perfcount_int(void);
-extern int gic_get_c0_fdc_int(void);
-
-#endif /* CONFIG_MIPS_GIC */
-
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.14.0
