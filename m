Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:45:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52718 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993913AbdHMEnuXA3Rd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:43:50 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id F415897B94186;
        Sun, 13 Aug 2017 05:43:41 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:43:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 21/38] irqchip: mips-gic: Move various definitions to the driver
Date:   Sat, 12 Aug 2017 21:36:29 -0700
Message-ID: <20170813043646.25821-22-paul.burton@imgtec.com>
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
X-archive-position: 59537
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

Move the definitions of macros used to convert between hardware IRQ
numbers & shared or local interrupt numbers into the irqchip driver,
which is all that should ever need to care about them.

Remove GIC_CPU_TO_VEC_OFFSET() in the process since it's never used.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-boards/maltaint.h |  5 -----
 drivers/irqchip/irq-mips-gic.c               | 16 ++++++++++++++++
 include/linux/irqchip/mips-gic.h             | 19 -------------------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index 987ff580466b..817698abf2eb 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -10,8 +10,6 @@
 #ifndef _MIPS_MALTAINT_H
 #define _MIPS_MALTAINT_H
 
-#include <linux/irqchip/mips-gic.h>
-
 /*
  * Interrupts 0..15 are used for Malta ISA compatible interrupts
  */
@@ -62,7 +60,4 @@
 #define MSC01E_INT_PERFCTR	10
 #define MSC01E_INT_CPUCTR	11
 
-/* GIC external interrupts */
-#define GIC_INT_I8259A		GIC_SHARED_TO_HWIRQ(3)
-
 #endif /* !(_MIPS_MALTAINT_H) */
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 5b282a7fd7e0..d6fbc5d6e8e2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -23,6 +23,22 @@
 
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 
+#define GIC_MAX_INTRS		256
+
+/* Add 2 to convert GIC CPU pin to core interrupt */
+#define GIC_CPU_PIN_OFFSET	2
+
+/* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
+#define GIC_PIN_TO_VEC_OFFSET	1
+
+/* Convert between local/shared IRQ number and GIC HW IRQ number. */
+#define GIC_LOCAL_HWIRQ_BASE	0
+#define GIC_LOCAL_TO_HWIRQ(x)	(GIC_LOCAL_HWIRQ_BASE + (x))
+#define GIC_HWIRQ_TO_LOCAL(x)	((x) - GIC_LOCAL_HWIRQ_BASE)
+#define GIC_SHARED_HWIRQ_BASE	GIC_NUM_LOCAL_INTRS
+#define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
+#define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
+
 unsigned int gic_present;
 void __iomem *mips_gic_base;
 
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index e93aaf529baa..da02a146b292 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -11,8 +11,6 @@
 #include <linux/clocksource.h>
 #include <linux/ioport.h>
 
-#define GIC_MAX_INTRS			256
-
 /* GIC Address Space */
 #define USM_VISIBLE_SECTION_OFS		0x10000
 #define USM_VISIBLE_SECTION_SIZE	0x10000
@@ -21,23 +19,6 @@
 #define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
-/* Add 2 to convert GIC CPU pin to core interrupt */
-#define GIC_CPU_PIN_OFFSET	2
-
-/* Add 2 to convert non-EIC hardware interrupt to EIC vector number. */
-#define GIC_CPU_TO_VEC_OFFSET	2
-
-/* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
-#define GIC_PIN_TO_VEC_OFFSET	1
-
-/* Convert between local/shared IRQ number and GIC HW IRQ number. */
-#define GIC_LOCAL_HWIRQ_BASE	0
-#define GIC_LOCAL_TO_HWIRQ(x)	(GIC_LOCAL_HWIRQ_BASE + (x))
-#define GIC_HWIRQ_TO_LOCAL(x)	((x) - GIC_LOCAL_HWIRQ_BASE)
-#define GIC_SHARED_HWIRQ_BASE	GIC_NUM_LOCAL_INTRS
-#define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
-#define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
-
 #ifdef CONFIG_MIPS_GIC
 
 extern unsigned int gic_present;
-- 
2.14.0
