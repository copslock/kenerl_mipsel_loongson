Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:06:00 +0200 (CEST)
Received: from mail-vc0-f202.google.com ([209.85.220.202]:33689 "EHLO
        mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011968AbaJTTERAO-m5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:17 +0200
Received: by mail-vc0-f202.google.com with SMTP id hy10so471715vcb.5
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dV/QL51tEAUedsDqhafLfZctIpkw59vFg2z7G3pUr78=;
        b=iM6WSV8C8EtPgmpq09e2V95UIEMpYaVm9hK+W2QE4MNLlB8A/qdN+FSpOdRu7cPvca
         tQBEb69Be9iZ57mBXXpIyHnMSTI7KF3GAb7jAQ3C48HB9AoqWpyMBd4UsxFhCzVULEZC
         M4S2GUVlMNpkNpxt9e6kXRVNo5dqRJa+Xem/eKuRWviT87EivFjJl1zKmkt9ECegZ3s3
         selHB9tGAbNm/S24aAq5R17GGMicUMGKvWNxfJDmzH6d6pQyMa7MIGBpf5Aky9c7gZHb
         YrtggsZqxHrHXnhNQGbj/hDpaB1YtQjuL7pdIjmvy2bdX4qQ1nRGfhAfd1AlzcXfv8AH
         XD5g==
X-Gm-Message-State: ALoCoQmvn4utdj7Sukf6YVjyMnJF/aLTtJiAzyZeVltKpnTBjjTNr7c1sn2aOXFnrutosDHkQn/0
X-Received: by 10.236.29.204 with SMTP id i52mr12766618yha.14.1413831851162;
        Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id k66si435341yho.7.2014.10.20.12.04.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id LUNvf60n.2; Mon, 20 Oct 2014 12:04:11 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 34F6A220B02; Mon, 20 Oct 2014 12:04:10 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] irqchip: mips-gic: Clean up header file
Date:   Mon, 20 Oct 2014 12:03:54 -0700
Message-Id: <1413831846-32100-8-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43365
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

Remove duplicate #defines and unnecessary #includes, fix parenthesization,
and re-order register definitions in ascending order.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/irqchip/irq-mips-gic.c   |   4 +-
 include/linux/irqchip/mips-gic.h | 129 ++++++++-------------------------------
 2 files changed, 29 insertions(+), 104 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 64a9729..adcb9b2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -253,8 +253,8 @@ static unsigned int gic_get_int(void)
 	intrmask = intrmask_regs[smp_processor_id()].intrmask;
 	pcpu_mask = pcpu_masks[smp_processor_id()].pcpu_mask;
 
-	pending_reg = GIC_REG(SHARED, GIC_SH_PEND_31_0);
-	intrmask_reg = GIC_REG(SHARED, GIC_SH_MASK_31_0);
+	pending_reg = GIC_REG(SHARED, GIC_SH_PEND);
+	intrmask_reg = GIC_REG(SHARED, GIC_SH_MASK);
 
 	for (i = 0; i < BITS_TO_LONGS(gic_shared_intrs); i++) {
 		pending[i] = gic_read(pending_reg);
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 285944c..0350eff 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -4,17 +4,11 @@
  * for more details.
  *
  * Copyright (C) 2000, 07 MIPS Technologies, Inc.
- *
- * GIC Register Definitions
- *
  */
-#ifndef _ASM_GICREGS_H
-#define _ASM_GICREGS_H
-
-#include <linux/bitmap.h>
-#include <linux/threads.h>
+#ifndef __LINUX_IRQCHIP_MIPS_GIC_H
+#define __LINUX_IRQCHIP_MIPS_GIC_H
 
-#include <irq.h>
+#include <linux/clocksource.h>
 
 #define GIC_MAX_INTRS			256
 
@@ -50,108 +44,42 @@
 #define GIC_SH_COUNTER_63_32_OFS	0x0014
 #define GIC_SH_REVISIONID_OFS		0x0020
 
-/* Interrupt Polarity */
-#define GIC_SH_POL_31_0_OFS		0x0100
-#define GIC_SH_POL_63_32_OFS		0x0104
-#define GIC_SH_POL_95_64_OFS		0x0108
-#define GIC_SH_POL_127_96_OFS		0x010c
-#define GIC_SH_POL_159_128_OFS		0x0110
-#define GIC_SH_POL_191_160_OFS		0x0114
-#define GIC_SH_POL_223_192_OFS		0x0118
-#define GIC_SH_POL_255_224_OFS		0x011c
-
-/* Edge/Level Triggering */
-#define GIC_SH_TRIG_31_0_OFS		0x0180
-#define GIC_SH_TRIG_63_32_OFS		0x0184
-#define GIC_SH_TRIG_95_64_OFS		0x0188
-#define GIC_SH_TRIG_127_96_OFS		0x018c
-#define GIC_SH_TRIG_159_128_OFS		0x0190
-#define GIC_SH_TRIG_191_160_OFS		0x0194
-#define GIC_SH_TRIG_223_192_OFS		0x0198
-#define GIC_SH_TRIG_255_224_OFS		0x019c
-
-/* Dual Edge Triggering */
-#define GIC_SH_DUAL_31_0_OFS		0x0200
-#define GIC_SH_DUAL_63_32_OFS		0x0204
-#define GIC_SH_DUAL_95_64_OFS		0x0208
-#define GIC_SH_DUAL_127_96_OFS		0x020c
-#define GIC_SH_DUAL_159_128_OFS		0x0210
-#define GIC_SH_DUAL_191_160_OFS		0x0214
-#define GIC_SH_DUAL_223_192_OFS		0x0218
-#define GIC_SH_DUAL_255_224_OFS		0x021c
+/* Convert an interrupt number to a byte offset/bit for multi-word registers */
+#define GIC_INTR_OFS(intr)		(((intr) / 32) * 4)
+#define GIC_INTR_BIT(intr)		((intr) % 32)
+
+/* Polarity : Reset Value is always 0 */
+#define GIC_SH_SET_POLARITY_OFS		0x0100
+
+/* Triggering : Reset Value is always 0 */
+#define GIC_SH_SET_TRIGGER_OFS		0x0180
+
+/* Dual edge triggering : Reset Value is always 0 */
+#define GIC_SH_SET_DUAL_OFS		0x0200
 
 /* Set/Clear corresponding bit in Edge Detect Register */
 #define GIC_SH_WEDGE_OFS		0x0280
 
-/* Reset Mask - Disables Interrupt */
-#define GIC_SH_RMASK_31_0_OFS		0x0300
-#define GIC_SH_RMASK_63_32_OFS		0x0304
-#define GIC_SH_RMASK_95_64_OFS		0x0308
-#define GIC_SH_RMASK_127_96_OFS		0x030c
-#define GIC_SH_RMASK_159_128_OFS	0x0310
-#define GIC_SH_RMASK_191_160_OFS	0x0314
-#define GIC_SH_RMASK_223_192_OFS	0x0318
-#define GIC_SH_RMASK_255_224_OFS	0x031c
-
-/* Set Mask (WO) - Enables Interrupt */
-#define GIC_SH_SMASK_31_0_OFS		0x0380
-#define GIC_SH_SMASK_63_32_OFS		0x0384
-#define GIC_SH_SMASK_95_64_OFS		0x0388
-#define GIC_SH_SMASK_127_96_OFS		0x038c
-#define GIC_SH_SMASK_159_128_OFS	0x0390
-#define GIC_SH_SMASK_191_160_OFS	0x0394
-#define GIC_SH_SMASK_223_192_OFS	0x0398
-#define GIC_SH_SMASK_255_224_OFS	0x039c
+/* Mask manipulation */
+#define GIC_SH_RMASK_OFS		0x0300
+#define GIC_SH_SMASK_OFS		0x0380
 
 /* Global Interrupt Mask Register (RO) - Bit Set == Interrupt enabled */
-#define GIC_SH_MASK_31_0_OFS		0x0400
-#define GIC_SH_MASK_63_32_OFS		0x0404
-#define GIC_SH_MASK_95_64_OFS		0x0408
-#define GIC_SH_MASK_127_96_OFS		0x040c
-#define GIC_SH_MASK_159_128_OFS		0x0410
-#define GIC_SH_MASK_191_160_OFS		0x0414
-#define GIC_SH_MASK_223_192_OFS		0x0418
-#define GIC_SH_MASK_255_224_OFS		0x041c
+#define GIC_SH_MASK_OFS			0x0400
 
 /* Pending Global Interrupts (RO) */
-#define GIC_SH_PEND_31_0_OFS		0x0480
-#define GIC_SH_PEND_63_32_OFS		0x0484
-#define GIC_SH_PEND_95_64_OFS		0x0488
-#define GIC_SH_PEND_127_96_OFS		0x048c
-#define GIC_SH_PEND_159_128_OFS		0x0490
-#define GIC_SH_PEND_191_160_OFS		0x0494
-#define GIC_SH_PEND_223_192_OFS		0x0498
-#define GIC_SH_PEND_255_224_OFS		0x049c
-
-#define GIC_SH_INTR_MAP_TO_PIN_BASE_OFS 0x0500
+#define GIC_SH_PEND_OFS			0x0480
 
 /* Maps Interrupt X to a Pin */
+#define GIC_SH_INTR_MAP_TO_PIN_BASE_OFS 0x0500
 #define GIC_SH_MAP_TO_PIN(intr)		(4 * (intr))
 
-#define GIC_SH_INTR_MAP_TO_VPE_BASE_OFS 0x2000
-
 /* Maps Interrupt X to a VPE */
+#define GIC_SH_INTR_MAP_TO_VPE_BASE_OFS 0x2000
 #define GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe) \
 	((32 * (intr)) + (((vpe) / 32) * 4))
 #define GIC_SH_MAP_TO_VPE_REG_BIT(vpe)	(1 << ((vpe) % 32))
 
-/* Convert an interrupt number to a byte offset/bit for multi-word registers */
-#define GIC_INTR_OFS(intr) (((intr) / 32)*4)
-#define GIC_INTR_BIT(intr) ((intr) % 32)
-
-/* Polarity : Reset Value is always 0 */
-#define GIC_SH_SET_POLARITY_OFS		0x0100
-
-/* Triggering : Reset Value is always 0 */
-#define GIC_SH_SET_TRIGGER_OFS		0x0180
-
-/* Dual edge triggering : Reset Value is always 0 */
-#define GIC_SH_SET_DUAL_OFS		0x0200
-
-/* Mask manipulation */
-#define GIC_SH_SMASK_OFS		0x0380
-#define GIC_SH_RMASK_OFS		0x0300
-
 /* Register Map for Local Section */
 #define GIC_VPE_CTL_OFS			0x0000
 #define GIC_VPE_PEND_OFS		0x0004
@@ -200,8 +128,8 @@
 #define GIC_SH_CONFIG_NUMVPES_SHF	0
 #define GIC_SH_CONFIG_NUMVPES_MSK	(MSK(8) << GIC_SH_CONFIG_NUMVPES_SHF)
 
-#define GIC_SH_WEDGE_SET(intr)		(intr | (0x1 << 31))
-#define GIC_SH_WEDGE_CLR(intr)		(intr & ~(0x1 << 31))
+#define GIC_SH_WEDGE_SET(intr)		((intr) | (0x1 << 31))
+#define GIC_SH_WEDGE_CLR(intr)		((intr) & ~(0x1 << 31))
 
 #define GIC_MAP_TO_PIN_SHF		31
 #define GIC_MAP_TO_PIN_MSK		(MSK(1) << GIC_MAP_TO_PIN_SHF)
@@ -278,10 +206,10 @@
 #define GIC_CPU_PIN_OFFSET	2
 
 /* Add 2 to convert non-EIC hardware interrupt to EIC vector number. */
-#define GIC_CPU_TO_VEC_OFFSET	(2)
+#define GIC_CPU_TO_VEC_OFFSET	2
 
 /* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
-#define GIC_PIN_TO_VEC_OFFSET	(1)
+#define GIC_PIN_TO_VEC_OFFSET	1
 
 /* Local GIC interrupts. */
 #define GIC_LOCAL_INT_WD	0 /* GIC watchdog */
@@ -301,9 +229,6 @@
 #define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
 #define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
 
-#include <linux/clocksource.h>
-#include <linux/irq.h>
-
 extern unsigned int gic_present;
 extern unsigned int gic_frequency;
 
@@ -322,4 +247,4 @@ extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern unsigned int gic_get_timer_pending(void);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
-#endif /* _ASM_GICREGS_H */
+#endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.1.0.rc2.206.gedb03e5
