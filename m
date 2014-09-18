Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:51:41 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:34065 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009259AbaIRVruehszv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:50 +0200
Received: by mail-oa0-f73.google.com with SMTP id eb12so181830oac.2
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q1mk4ftdWvy9bNFv0myF9CagmQLFcl9QzaHSa+tLfFM=;
        b=bdmucQhED/5139wDW2uJ3IC0LXa7Hbmq+oF5Soc+TbB2JnnQrf293BhadVuTOkRnGG
         MyiOTNtWU/VZ1bAVtHzBfaOzqYTboxwU1HAxItoY7zvXlTycLp6p86on9ANWEeTAMSt/
         ose7YBF9Ifd5Es9aFfG90qB9YAa8qq+vcmn6UP6z3XKczvfw/PDE/u1hrqThQH7wrpX1
         pSjR2lcXSqB5lQMeG4fdT4iwYz+hVIgyI4C9NmihHvOo/ot+A5aCM1eUxTo+2bAk36SQ
         ZqLpqqh9oh4GTnQYexiLYhxhkuLH8QmrgnPHfnMYo8sU6CIAA3y+lgCC9BKZIbA11OKN
         KZGA==
X-Gm-Message-State: ALoCoQlhD8qs5/7YqhCtCa/ouZiZxIYkXggeqpqk1DY/mMJYGOgshqhGsx36lsmBuO2eEtJzljCU
X-Received: by 10.182.213.105 with SMTP id nr9mr1217968obc.36.1411076864714;
        Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l45si4220yha.2.2014.09.18.14.47.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id lBwURzVy.5; Thu, 18 Sep 2014 14:47:44 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 8716E220D1A; Thu, 18 Sep 2014 14:47:43 -0700 (PDT)
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
Subject: [PATCH V2 17/24] irqchip: mips-gic: Use IRQ domains
Date:   Thu, 18 Sep 2014 14:47:23 -0700
Message-Id: <1411076851-28242-18-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42693
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

Use a simple IRQ domain for the MIPS GIC.  Remove the gic_platform_init
callback as it's no longer necessary for it to set the irqchip.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
Changes from v1:
 - hold spinlock across gic_irq_domain_map because of r-m-w ops
---
 arch/mips/include/asm/gic.h     |  1 -
 arch/mips/mti-malta/malta-int.c |  8 -------
 arch/mips/mti-sead3/sead3-int.c | 15 -------------
 drivers/irqchip/irq-mips-gic.c  | 48 ++++++++++++++++++++++++++++++++++-------
 4 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 662b567..efcf4de 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -385,5 +385,4 @@ extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
 extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
 extern unsigned int gic_get_int(void);
-extern void gic_platform_init(int irqs, struct irq_chip *irq_controller);
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index b60adfd..e56563c 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -714,11 +714,3 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 
 	return retval;
 }
-
-void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
-{
-	int i;
-
-	for (i = gic_irq_base; i < (gic_irq_base + irqs); i++)
-		irq_set_chip(i, irq_controller);
-}
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index 03f9865..8f36342 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -85,18 +85,3 @@ void __init arch_init_irq(void)
 			ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 }
 
-void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
-{
-	int i;
-
-	/*
-	 * For non-EIC mode, we want to setup the GIC in pass-through
-	 * mode, as if the GIC didn't exist. Do not map any interrupts
-	 * for an external interrupt controller.
-	 */
-	if (!cpu_has_veic)
-		return;
-
-	for (i = gic_irq_base; i < (gic_irq_base + irqs); i++)
-		irq_set_chip_and_handler(i, irq_controller, handle_percpu_irq);
-}
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 5e12777..64dc5a9 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -44,6 +44,7 @@ static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
+static struct irq_domain *gic_irq_domain;
 
 #if defined(CONFIG_CSRC_GIC) || defined(CONFIG_CEVT_GIC)
 cycle_t gic_read_count(void)
@@ -230,24 +231,26 @@ unsigned int gic_get_int(void)
 
 static void gic_mask_irq(struct irq_data *d)
 {
-	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
+	GIC_CLR_INTR_MASK(d->hwirq);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
+	GIC_SET_INTR_MASK(d->hwirq);
 }
 
 static void gic_ack_irq(struct irq_data *d)
 {
+	unsigned int irq = d->hwirq;
+
 	/* Clear edge detector */
-	if (gic_irq_flags[d->irq - gic_irq_base] & GIC_TRIG_EDGE)
-		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq - gic_irq_base);
+	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
+		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int irq = d->irq - gic_irq_base;
+	unsigned int irq = d->hwirq;
 	unsigned long flags;
 	bool is_edge;
 
@@ -302,7 +305,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
-	unsigned int irq = (d->irq - gic_irq_base);
+	unsigned int irq = d->hwirq;
 	cpumask_t	tmp = CPU_MASK_NONE;
 	unsigned long	flags;
 	int		i;
@@ -345,6 +348,7 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 	unsigned int flags)
 {
 	struct gic_shared_intr_map *map_ptr;
+	int i;
 
 	/* Setup Intr to Pin mapping */
 	if (pin & GIC_MAP_TO_NMI_MSK) {
@@ -382,6 +386,8 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 	GIC_CLR_INTR_MASK(intr);
 
 	/* Initialise per-cpu Interrupt software masks */
+	for (i = 0; i < NR_CPUS; i++)
+		clear_bit(intr, pcpu_masks[i].pcpu_mask);
 	set_bit(intr, pcpu_masks[cpu].pcpu_mask);
 
 	if ((flags & GIC_FLAG_TRANSPARENT) && (cpu_has_veic == 0))
@@ -433,6 +439,29 @@ static void __init gic_basic_init(int numintrs, int numvpes,
 	vpe_local_setup(numvpes);
 }
 
+static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	unsigned long flags;
+
+	irq_set_chip_and_handler(virq, &gic_irq_controller, handle_level_irq);
+
+	spin_lock_irqsave(&gic_lock, flags);
+	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
+		 GIC_MAP_TO_PIN_MSK | 0);
+	/* Map to VPE 0 by default */
+	GIC_SH_MAP_TO_VPE_SMASK(hw, 0);
+	set_bit(hw, pcpu_masks[0].pcpu_mask);
+	spin_unlock_irqrestore(&gic_lock, flags);
+
+	return 0;
+}
+
+static struct irq_domain_ops gic_irq_domain_ops = {
+	.map = gic_irq_domain_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
 void __init gic_init(unsigned long gic_base_addr,
 		     unsigned long gic_addrspace_size,
 		     struct gic_intr_map *intr_map, unsigned int intr_map_size,
@@ -454,7 +483,10 @@ void __init gic_init(unsigned long gic_base_addr,
 		  GIC_SH_CONFIG_NUMVPES_SHF;
 	numvpes = numvpes + 1;
 
-	gic_basic_init(numintrs, numvpes, intr_map, intr_map_size);
+	gic_irq_domain = irq_domain_add_simple(NULL, GIC_NUM_INTRS, irqbase,
+					       &gic_irq_domain_ops, NULL);
+	if (!gic_irq_domain)
+		panic("Failed to add GIC IRQ domain");
 
-	gic_platform_init(numintrs, &gic_irq_controller);
+	gic_basic_init(numintrs, numvpes, intr_map, intr_map_size);
 }
-- 
2.1.0.rc2.206.gedb03e5
