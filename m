Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:34:54 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:52040 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025908AbaIERaphIGV0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:45 +0200
Received: by mail-pa0-f73.google.com with SMTP id kx10so3542990pab.0
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2V1kT88ylxwKA0Oi46b4c0FcstE4LHNaQPrPX4rprIw=;
        b=LlmmjVKuRzj+hm8Pf30XPrOJPWQXYZ1EguMg4hD6ZlnCN76CGByXdbGJOethfNVL4h
         WgIpAeBgWLWzkZ6r5ye5dOmOUMtroSyi2RH8nrM0TQgnApRXCT67l/wnHbz4OtO1a5nv
         /Edy0zfH5qi6HqFmvk8ShAEFORWB1DYlx9INcqzkie8LqAcBtX3GVaCcFRf1eZm6s+he
         kH32mfvEktWXJdAEREKhc/yBjdKv7JIWEcuBdf1vkSK7+lZi1SwdJZaK38z1vxKdO0TY
         mhBEiT7p1tAH8Fz3GadkKb0oflD27cz0vDq8Q7EPNhIvdhbZ5Virn+cQ0AX4XJj8TdD0
         craQ==
X-Gm-Message-State: ALoCoQmSuaYHXSIEcRHul2q4g4gHyyI7Z1Bkcgv6aA7b+o0gPltvradX2NvSy/VjkNvekySC5b70
X-Received: by 10.66.190.67 with SMTP id go3mr7636803pac.10.1409938239522;
        Fri, 05 Sep 2014 10:30:39 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id d7si508249yho.2.2014.09.05.10.30.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:39 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3DC9C31C285;
        Fri,  5 Sep 2014 10:30:39 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 019052209EA; Fri,  5 Sep 2014 10:30:38 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/16] irqchip: mips-gic: Support local interrupts
Date:   Fri,  5 Sep 2014 10:30:16 -0700
Message-Id: <1409938218-9026-15-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42444
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

The MIPS GIC supports 7 local interrupts, 5 of which are just core
interrupts which can be re-routed through the GIC.  This patch adds
support for mapping and handling the remaining two: the GIC timer
and watchdog.  GIC interrupts from 0 to GIC_NUM_INTRS are still the
shared external interrupts while interrupts from GIC_NUM_INTRS to
GIC_NUM_INTRS + GIC_NUM_LOCAL_INTRS are local interrupts.

With device-tree based probing, the GIC local interrupts will be routed
to the first GIC-to-CPU pin.  For platforms using a static mapping, the
local interrupts can be initialized by extending the interrupt mapping
table passed to gic_init.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v1.
---
 arch/mips/include/asm/gic.h              |  12 +++
 arch/mips/include/asm/mach-generic/irq.h |   1 +
 drivers/irqchip/irq-mips-gic.c           | 180 +++++++++++++++++++++++++++----
 3 files changed, 171 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 3853c15..d5b2d84 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -217,6 +217,10 @@
 #define GIC_VPE_COMPARE_LO_OFS		0x00a0
 #define GIC_VPE_COMPARE_HI_OFS		0x00a4
 
+#define GIC_VPE_MAP_OFS			0x0040
+#define GIC_VPE_MAP_TO_PIN(intr) \
+	(GIC_VPE_MAP_OFS + 4 * (intr))
+
 #define GIC_VPE_EIC_SHADOW_SET_BASE	0x0100
 #define GIC_VPE_EIC_SS(intr) \
 	(GIC_VPE_EIC_SHADOW_SET_BASE + (4 * intr))
@@ -354,6 +358,11 @@ struct gic_shared_intr_map {
 #define GIC_CPU_PIN_OFFSET	2
 
 /* Local GIC interrupts. */
+#define GIC_LOCAL_INTR_WD	0 /* GIC watchdog timer */
+#define GIC_LOCAL_INTR_COMPARE	1 /* GIC count/compare timer */
+#define GIC_NUM_LOCAL_INTRS	2
+
+/* Pin mapping for CPU interrupts routable through the GIC. */
 #define GIC_INT_TMR		(GIC_CPU_INT5)
 #define GIC_INT_PERFCTR		(GIC_CPU_INT5)
 
@@ -389,6 +398,9 @@ extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
 extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
 extern unsigned int gic_get_int(void);
+extern void gic_get_local_int_mask(unsigned long *dst,
+				   const unsigned long *src);
+extern unsigned int gic_get_local_int(void);
 extern void gic_enable_interrupt(int irq_vec);
 extern void gic_disable_interrupt(int irq_vec);
 extern void gic_irq_ack(struct irq_data *d);
diff --git a/arch/mips/include/asm/mach-generic/irq.h b/arch/mips/include/asm/mach-generic/irq.h
index 050e18b..9233df6 100644
--- a/arch/mips/include/asm/mach-generic/irq.h
+++ b/arch/mips/include/asm/mach-generic/irq.h
@@ -40,6 +40,7 @@
 #ifndef MIPS_GIC_IRQ_BASE
 #define MIPS_GIC_IRQ_BASE (MIPS_CPU_IRQ_BASE + 8)
 #endif
+#define MIPS_GIC_LOCAL_IRQ_BASE (MIPS_GIC_IRQ_BASE + GIC_NUM_INTRS)
 #endif /* CONFIG_MIPS_GIC */
 
 #endif /* __ASM_MACH_GENERIC_IRQ_H */
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 82a35cf..638b75c 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -53,6 +53,21 @@ static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 
 static struct irq_chip gic_irq_controller;
 
+static inline bool gic_is_local_irq(unsigned int hwirq)
+{
+	return hwirq >= GIC_NUM_INTRS;
+}
+
+static inline unsigned int gic_hw_to_local_irq(unsigned int hwirq)
+{
+	return hwirq - GIC_NUM_INTRS;
+}
+
+static inline unsigned int gic_local_to_hw_irq(unsigned int irq)
+{
+	return irq + GIC_NUM_INTRS;
+}
+
 #if defined(CONFIG_CSRC_GIC) || defined(CONFIG_CEVT_GIC)
 cycle_t gic_read_count(void)
 {
@@ -236,28 +251,77 @@ unsigned int gic_get_int(void)
 	return find_first_bit(interrupts, GIC_NUM_INTRS);
 }
 
+void gic_get_local_int_mask(unsigned long *dst, const unsigned long *src)
+{
+	unsigned long pending, intrmask;
+
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_PEND), pending);
+	GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_MASK), intrmask);
+
+	bitmap_and(&pending, &pending, &intrmask, GIC_NUM_LOCAL_INTRS);
+	bitmap_and(dst, src, &pending, GIC_NUM_LOCAL_INTRS);
+}
+
+unsigned int gic_get_local_int(void)
+{
+	unsigned long interrupts;
+
+	bitmap_fill(&interrupts, GIC_NUM_LOCAL_INTRS);
+	gic_get_local_int_mask(&interrupts, &interrupts);
+
+	return find_first_bit(&interrupts, GIC_NUM_LOCAL_INTRS);
+}
+
 static void gic_mask_irq(struct irq_data *d)
 {
-	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
+	unsigned int irq = d->irq - gic_irq_base;
+
+	if (gic_is_local_irq(irq)) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK),
+			 1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
+	} else {
+		GIC_CLR_INTR_MASK(irq);
+	}
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
+	unsigned int irq = d->irq - gic_irq_base;
+
+	if (gic_is_local_irq(irq)) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK),
+			 1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
+	} else {
+		GIC_SET_INTR_MASK(irq);
+	}
 }
 
 void __weak gic_irq_ack(struct irq_data *d)
 {
-	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
+	unsigned int irq = d->irq - gic_irq_base;
 
-	/* Clear edge detector */
-	if (gic_irq_flags[d->irq - gic_irq_base] & GIC_TRIG_EDGE)
-		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq - gic_irq_base);
+	if (gic_is_local_irq(irq)) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK),
+			 1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
+	} else {
+		GIC_CLR_INTR_MASK(irq);
+
+		/* Clear edge detector */
+		if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
+			GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
+	}
 }
 
 void __weak gic_finish_irq(struct irq_data *d)
 {
-	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
+	unsigned int irq = d->irq - gic_irq_base;
+
+	if (gic_is_local_irq(irq)) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK),
+			 1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
+	} else {
+		GIC_SET_INTR_MASK(irq);
+	}
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -265,6 +329,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	unsigned int irq = d->irq - gic_irq_base;
 	bool is_edge;
 
+	if (gic_is_local_irq(irq))
+		return -EINVAL;
+
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		GIC_SET_POLARITY(irq, GIC_POL_NEG);
@@ -321,6 +388,9 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	unsigned long	flags;
 	int		i;
 
+	if (gic_is_local_irq(irq))
+		return -EINVAL;
+
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
 		return -EINVAL;
@@ -406,6 +476,42 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 		gic_irq_flags[intr] |= GIC_TRIG_EDGE;
 }
 
+static void __init gic_setup_local_intr(unsigned int intr, unsigned int pin,
+				unsigned int flags)
+{
+	struct gic_shared_intr_map *map_ptr;
+	unsigned int local_irq = gic_hw_to_local_irq(intr);
+	int i;
+
+	/* Setup Intr to Pin mapping */
+	for (i = 0; i < nr_cpu_ids; i++) {
+		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
+		if (pin & GIC_MAP_TO_NMI_MSK) {
+			GICWRITE(GIC_REG_ADDR(VPE_OTHER,
+					GIC_VPE_MAP_TO_PIN(local_irq)), pin);
+		} else {
+			GICWRITE(GIC_REG_ADDR(VPE_OTHER,
+					GIC_VPE_MAP_TO_PIN(local_irq)),
+				 GIC_MAP_TO_PIN_MSK | pin);
+		}
+	}
+
+	if (!(pin & GIC_MAP_TO_NMI_MSK) && cpu_has_veic) {
+		set_vi_handler(pin + GIC_PIN_TO_VEC_OFFSET,
+			       gic_eic_irq_dispatch);
+		map_ptr = &gic_shared_intr_map[pin + GIC_PIN_TO_VEC_OFFSET];
+		if (map_ptr->num_shared_intr >= GIC_MAX_SHARED_INTR)
+			BUG();
+		map_ptr->intr_list[map_ptr->num_shared_intr++] = intr;
+	}
+
+	/* Init Intr Masks */
+	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK),
+		 1 << GIC_INTR_BIT(local_irq));
+
+	irq_set_percpu_devid(gic_irq_base + intr);
+}
+
 static void __init gic_basic_init(int numintrs, int numvpes,
 			struct gic_intr_map *intrmap, int mapsize)
 {
@@ -438,12 +544,17 @@ static void __init gic_basic_init(int numintrs, int numvpes,
 		cpu = intrmap[i].cpunum;
 		if (cpu == GIC_UNUSED)
 			continue;
-		gic_setup_intr(i,
-			intrmap[i].cpunum,
-			intrmap[i].pin + pin_offset,
-			intrmap[i].polarity,
-			intrmap[i].trigtype,
-			intrmap[i].flags);
+		if (gic_is_local_irq(i))
+			gic_setup_local_intr(i,
+				intrmap[i].pin + pin_offset,
+				intrmap[i].flags);
+		else
+			gic_setup_intr(i,
+				intrmap[i].cpunum,
+				intrmap[i].pin + pin_offset,
+				intrmap[i].polarity,
+				intrmap[i].trigtype,
+				intrmap[i].flags);
 	}
 
 	vpe_local_setup(numvpes);
@@ -472,7 +583,8 @@ void __init gic_init(unsigned long gic_base_addr,
 
 	gic_basic_init(numintrs, numvpes, intr_map, intr_map_size);
 
-	gic_platform_init(numintrs, &gic_irq_controller);
+	gic_platform_init(GIC_NUM_INTRS + GIC_NUM_LOCAL_INTRS,
+			  &gic_irq_controller);
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
@@ -563,13 +675,30 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	int pin = gic_cpu_pin[0] - GIC_CPU_PIN_OFFSET;
 
-	irq_set_chip_and_handler(irq, &gic_irq_controller, handle_level_irq);
+	if (gic_is_local_irq(hw)) {
+		int i;
+		int local_irq = gic_hw_to_local_irq(hw);
+
+		irq_set_chip_and_handler(irq, &gic_irq_controller,
+					 handle_percpu_irq);
+		irq_set_percpu_devid(irq);
 
-	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
-		 GIC_MAP_TO_PIN_MSK | pin);
-	/* Map to VPE 0 by default */
-	GIC_SH_MAP_TO_VPE_SMASK(hw, 0);
-	set_bit(hw, pcpu_masks[0].pcpu_mask);
+		for (i = 0; i < nr_cpu_ids; i++) {
+			GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
+			GICWRITE(GIC_REG_ADDR(VPE_OTHER,
+					      GIC_VPE_MAP_TO_PIN(local_irq)),
+				 GIC_MAP_TO_PIN_MSK | pin);
+		}
+	} else {
+		irq_set_chip_and_handler(irq, &gic_irq_controller,
+					 handle_level_irq);
+
+		GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
+			 GIC_MAP_TO_PIN_MSK | pin);
+		/* Map to VPE 0 by default */
+		GIC_SH_MAP_TO_VPE_SMASK(hw, 0);
+		set_bit(hw, pcpu_masks[0].pcpu_mask);
+	}
 
 	return 0;
 }
@@ -584,6 +713,11 @@ static void gic_irq_dispatch(unsigned int irq, struct irq_desc *desc)
 	struct irq_domain *domain = irq_get_handler_data(irq);
 	unsigned int hwirq;
 
+	while ((hwirq = gic_get_local_int()) != GIC_NUM_LOCAL_INTRS) {
+		irq = irq_linear_revmap(domain, gic_local_to_hw_irq(hwirq));
+		generic_handle_irq(irq);
+	}
+
 	while ((hwirq = gic_get_int()) != GIC_NUM_INTRS) {
 		irq = irq_linear_revmap(domain, hwirq);
 		generic_handle_irq(irq);
@@ -627,8 +761,10 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 
 	gic_init(res.start, resource_size(&res), NULL, 0, MIPS_GIC_IRQ_BASE);
 
-	domain = irq_domain_add_legacy(node, GIC_NUM_INTRS, MIPS_GIC_IRQ_BASE,
-				       0, &gic_irq_domain_ops, NULL);
+	domain = irq_domain_add_legacy(node,
+				       GIC_NUM_INTRS + GIC_NUM_LOCAL_INTRS,
+				       MIPS_GIC_IRQ_BASE, 0,
+				       &gic_irq_domain_ops, NULL);
 	if (!domain) {
 		pr_err("Failed to add GIC IRQ domain\n");
 		return -ENOMEM;
-- 
2.1.0.rc2.206.gedb03e5
