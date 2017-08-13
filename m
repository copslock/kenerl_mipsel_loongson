Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:44:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59103 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993898AbdHMEnN5G3pd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:43:13 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A7BA6A7547A78;
        Sun, 13 Aug 2017 05:43:05 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:43:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 19/38] MIPS: GIC: Move GIC_LOCAL_INT_* to asm/mips-gic.h
Date:   Sat, 12 Aug 2017 21:36:27 -0700
Message-ID: <20170813043646.25821-20-paul.burton@imgtec.com>
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
X-archive-position: 59535
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

Move the definition of VP-local interrupts provided by the MIPS Global
Interrupt Controller to the new asm/mips-gic.h header to be alongside
the new accessor functions. Whilst at it, convert to an enum which lends
itself more easily to expansion & documentation.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-gic.h | 24 ++++++++++++++++++++++++
 include/linux/irqchip/mips-gic.h | 10 ----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
index 8cf4bdc1a059..27736d7f4aba 100644
--- a/arch/mips/include/asm/mips-gic.h
+++ b/arch/mips/include/asm/mips-gic.h
@@ -277,6 +277,30 @@ GIC_VX_ACCESSOR_RW(64, 0x0a0, compare)
 /* GIC_Vx_EIC_SHADOW_SET_BASE - Set shadow register set for each interrupt */
 GIC_VX_ACCESSOR_RW_INTR_REG(32, 0x100, 0x4, eic_shadow_set)
 
+/**
+ * enum mips_gic_local_interrupt - GIC local interrupts
+ * @GIC_LOCAL_INT_WD: GIC watchdog timer interrupt
+ * @GIC_LOCAL_INT_COMPARE: GIC count/compare interrupt
+ * @GIC_LOCAL_INT_TIMER: CP0 count/compare interrupt
+ * @GIC_LOCAL_INT_PERFCTR: Performance counter interrupt
+ * @GIC_LOCAL_INT_SWINT0: Software interrupt 0
+ * @GIC_LOCAL_INT_SWINT1: Software interrupt 1
+ * @GIC_LOCAL_INT_FDC: Fast debug channel interrupt
+ * @GIC_NUM_LOCAL_INTRS: The number of local interrupts
+ *
+ * Enumerates interrupts provided by the GIC that are local to a VP.
+ */
+enum mips_gic_local_interrupt {
+	GIC_LOCAL_INT_WD,
+	GIC_LOCAL_INT_COMPARE,
+	GIC_LOCAL_INT_TIMER,
+	GIC_LOCAL_INT_PERFCTR,
+	GIC_LOCAL_INT_SWINT0,
+	GIC_LOCAL_INT_SWINT1,
+	GIC_LOCAL_INT_FDC,
+	GIC_NUM_LOCAL_INTRS
+};
+
 /**
  * mips_gic_present() - Determine whether a GIC is present
  *
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index b7a3ce1da9a7..9546947d1842 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -38,16 +38,6 @@
 /* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
 #define GIC_PIN_TO_VEC_OFFSET	1
 
-/* Local GIC interrupts. */
-#define GIC_LOCAL_INT_WD	0 /* GIC watchdog */
-#define GIC_LOCAL_INT_COMPARE	1 /* GIC count and compare timer */
-#define GIC_LOCAL_INT_TIMER	2 /* CPU timer interrupt */
-#define GIC_LOCAL_INT_PERFCTR	3 /* CPU performance counter */
-#define GIC_LOCAL_INT_SWINT0	4 /* CPU software interrupt 0 */
-#define GIC_LOCAL_INT_SWINT1	5 /* CPU software interrupt 1 */
-#define GIC_LOCAL_INT_FDC	6 /* CPU fast debug channel */
-#define GIC_NUM_LOCAL_INTRS	7
-
 /* Convert between local/shared IRQ number and GIC HW IRQ number. */
 #define GIC_LOCAL_HWIRQ_BASE	0
 #define GIC_LOCAL_TO_HWIRQ(x)	(GIC_LOCAL_HWIRQ_BASE + (x))
-- 
2.14.0
