Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:53:31 +0200 (CEST)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:51174 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009225AbaIRVrwTY4j0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:52 +0200
Received: by mail-pd0-f202.google.com with SMTP id ft15so499774pdb.5
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eCmzqys7d3t/hrh13Pe2taJQHcrlw9vC0fzq9JfLzsM=;
        b=j5LRdCuLvzRCasyGfXlqSity1AQusSMTveae2nq7KIB8e1m3r+fbj6a7j9+A5TbNTH
         8vSCaYpW6fztpvBs6ZMpdV54Mpsl1YjF220gizYLN5vP1vvG6Gl53E2mVdfzroVRfTGO
         XgH83s2aE9NPTaBwW3YgmP3AQ0B6nmRcNzttpE00irc21PYzkyZf4mM0VGo1x6+huea9
         sh93OY/WJYe+FUD/26iQ/PbXn52hjLqLzVHGREC+1YcXpE+TGWdKU0Vp2v9OnVF51R+M
         EcwhAFHWInmLjfcUMhJXwRDPrSON1xLedT1rGxO73PjML7NKfCCOAgYgNi6FxSr05GlW
         D9xA==
X-Gm-Message-State: ALoCoQlIfFwlTYKIaqIoN/Qg1Oo0wMVUWmIt+pYXzTSnHXs6iYIf4Ftu4AQ+ZAfx6HIrsF5KnBOx
X-Received: by 10.68.204.97 with SMTP id kx1mr6649388pbc.7.1411076865878;
        Thu, 18 Sep 2014 14:47:45 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si1191yhm.7.2014.09.18.14.47.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:45 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id xE8T9pn4.5; Thu, 18 Sep 2014 14:47:45 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id A7F0D220B91; Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 19/24] irqchip: mips-gic: Probe for number of external interrupts
Date:   Thu, 18 Sep 2014 14:47:25 -0700
Message-Id: <1411076851-28242-20-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42699
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

Instead of requiring platforms to define the correct GIC_NUM_INTRS,
use the value reported in GIC_SH_CONFIG.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/include/asm/gic.h            |  2 ++
 arch/mips/include/asm/mach-malta/irq.h |  1 -
 arch/mips/include/asm/mach-sead3/irq.h |  1 -
 drivers/irqchip/irq-mips-gic.c         | 40 +++++++++++++++++-----------------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index cfbf907..8d1e457 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -18,6 +18,8 @@
 
 #undef	GICISBYTELITTLEENDIAN
 
+#define GIC_MAX_INTRS			256
+
 /* Constants */
 #define GIC_POL_POS			1
 #define GIC_POL_NEG			0
diff --git a/arch/mips/include/asm/mach-malta/irq.h b/arch/mips/include/asm/mach-malta/irq.h
index f2c13d2..47cfe64 100644
--- a/arch/mips/include/asm/mach-malta/irq.h
+++ b/arch/mips/include/asm/mach-malta/irq.h
@@ -2,7 +2,6 @@
 #define __ASM_MACH_MIPS_IRQ_H
 
 
-#define GIC_NUM_INTRS (24 + NR_CPUS * 2)
 #define NR_IRQS 256
 
 #include_next <irq.h>
diff --git a/arch/mips/include/asm/mach-sead3/irq.h b/arch/mips/include/asm/mach-sead3/irq.h
index d8106f7..5d154cf 100644
--- a/arch/mips/include/asm/mach-sead3/irq.h
+++ b/arch/mips/include/asm/mach-sead3/irq.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_MACH_MIPS_IRQ_H
 #define __ASM_MACH_MIPS_IRQ_H
 
-#define GIC_NUM_INTRS (24 + NR_CPUS * 2)
 #define NR_IRQS 256
 
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6c9fcbf..1349427 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -28,15 +28,15 @@ unsigned int gic_irq_flags[GIC_NUM_INTRS];
 unsigned int gic_cpu_pin;
 
 struct gic_pcpu_mask {
-	DECLARE_BITMAP(pcpu_mask, GIC_NUM_INTRS);
+	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
 struct gic_pending_regs {
-	DECLARE_BITMAP(pending, GIC_NUM_INTRS);
+	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
 };
 
 struct gic_intrmask_regs {
-	DECLARE_BITMAP(intrmask, GIC_NUM_INTRS);
+	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
 };
 
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
@@ -44,6 +44,7 @@ static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
+static int gic_shared_intrs;
 
 static void __gic_irq_dispatch(void);
 
@@ -192,26 +193,26 @@ void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
 	intrmask_abs = (unsigned long *) GIC_REG_ABS_ADDR(SHARED,
 							  GIC_SH_MASK_31_0_OFS);
 
-	for (i = 0; i < BITS_TO_LONGS(GIC_NUM_INTRS); i++) {
+	for (i = 0; i < BITS_TO_LONGS(gic_shared_intrs); i++) {
 		GICREAD(*pending_abs, pending[i]);
 		GICREAD(*intrmask_abs, intrmask[i]);
 		pending_abs++;
 		intrmask_abs++;
 	}
 
-	bitmap_and(pending, pending, intrmask, GIC_NUM_INTRS);
-	bitmap_and(pending, pending, pcpu_mask, GIC_NUM_INTRS);
-	bitmap_and(dst, src, pending, GIC_NUM_INTRS);
+	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
+	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
+	bitmap_and(dst, src, pending, gic_shared_intrs);
 }
 
 unsigned int gic_get_int(void)
 {
-	DECLARE_BITMAP(interrupts, GIC_NUM_INTRS);
+	DECLARE_BITMAP(interrupts, GIC_MAX_INTRS);
 
-	bitmap_fill(interrupts, GIC_NUM_INTRS);
+	bitmap_fill(interrupts, gic_shared_intrs);
 	gic_get_int_mask(interrupts, interrupts);
 
-	return find_first_bit(interrupts, GIC_NUM_INTRS);
+	return find_first_bit(interrupts, gic_shared_intrs);
 }
 
 static void gic_mask_irq(struct irq_data *d)
@@ -332,7 +333,7 @@ static void __gic_irq_dispatch(void)
 {
 	unsigned int intr, virq;
 
-	while ((intr = gic_get_int()) != GIC_NUM_INTRS) {
+	while ((intr = gic_get_int()) != gic_shared_intrs) {
 		virq = irq_linear_revmap(gic_irq_domain, intr);
 		do_IRQ(virq);
 	}
@@ -405,7 +406,7 @@ static __init void gic_ipi_init(void)
 	int i;
 
 	/* Use last 2 * NR_CPUS interrupts as IPIs */
-	gic_resched_int_base = GIC_NUM_INTRS - nr_cpu_ids;
+	gic_resched_int_base = gic_shared_intrs - nr_cpu_ids;
 	gic_call_int_base = gic_resched_int_base - nr_cpu_ids;
 
 	for (i = 0; i < nr_cpu_ids; i++) {
@@ -419,19 +420,18 @@ static inline void gic_ipi_init(void)
 }
 #endif
 
-static void __init gic_basic_init(int numintrs, int numvpes)
+static void __init gic_basic_init(int numvpes)
 {
 	unsigned int i;
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
 	/* Setup defaults */
-	for (i = 0; i < numintrs; i++) {
+	for (i = 0; i < gic_shared_intrs; i++) {
 		GIC_SET_POLARITY(i, GIC_POL_POS);
 		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
 		GIC_CLR_INTR_MASK(i);
-		if (i < GIC_NUM_INTRS)
-			gic_irq_flags[i] = 0;
+		gic_irq_flags[i] = 0;
 	}
 
 	vpe_local_setup(numvpes);
@@ -471,9 +471,9 @@ void __init gic_init(unsigned long gic_base_addr,
 						    gic_addrspace_size);
 
 	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), gicconfig);
-	numintrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
+	gic_shared_intrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
 		   GIC_SH_CONFIG_NUMINTRS_SHF;
-	numintrs = ((numintrs + 1) * 8);
+	gic_shared_intrs = ((gic_shared_intrs + 1) * 8);
 
 	numvpes = (gicconfig & GIC_SH_CONFIG_NUMVPES_MSK) >>
 		  GIC_SH_CONFIG_NUMVPES_SHF;
@@ -490,12 +490,12 @@ void __init gic_init(unsigned long gic_base_addr,
 					gic_irq_dispatch);
 	}
 
-	gic_irq_domain = irq_domain_add_simple(NULL, GIC_NUM_INTRS, irqbase,
+	gic_irq_domain = irq_domain_add_simple(NULL, gic_shared_intrs, irqbase,
 					       &gic_irq_domain_ops, NULL);
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
-	gic_basic_init(numintrs, numvpes);
+	gic_basic_init(numvpes);
 
 	gic_ipi_init();
 }
-- 
2.1.0.rc2.206.gedb03e5
