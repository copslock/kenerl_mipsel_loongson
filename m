Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:44:30 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34332 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014893AbcBEAnVPPO0l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:21 +0100
Received: by mail-pa0-f66.google.com with SMTP id yy13so1730232pab.1;
        Thu, 04 Feb 2016 16:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7YxLBH8aZKHdkxurjRdSBa8n/6rNb9aqU0JyYXTmijE=;
        b=UkccZ0J8UFrBE3gxe5sJ/S0lcV2tHdtAjYiFrcyME7O4jfYWz5PpSaOXLyZJDST3gb
         xHHA48g0+KnqOTQtvil3Y4UfJojNjQeV8ycw23EymxwdZE365nbQbZs9JAML3pOqD2bs
         dWzbcJ01osZbkF1qptPT7bbfIDynGee8Z+cV4D4KroM2TzCM+QSb4TAX3uSIJoM8idk9
         UEwtTtKL7pv7eN7WxMOWk+LSIESKBMAMG9BWAKBDld+O5BnkS4BMNir248OTHyBAgZLA
         Y7oNrFSpGgeycF5RpD91lXLklKuSm/Ojq5YsEz7NjsWxNkFFkIVBEBBnSX/QRX0BFnfA
         jUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7YxLBH8aZKHdkxurjRdSBa8n/6rNb9aqU0JyYXTmijE=;
        b=iyGfJHVC6Eg2UhgJLvJ1hx9SZetvMiJrodIqC3Ihy3w5Jk/P0yTpRMYnrOnSUxZ56h
         CQwJJMbDhLB5qRMM5DSX5lWxAMYX0ZW977IXxBw8zNGDFsazQWP/cCY8yTE82Z8QBEuk
         aRlTdqiyMFnWRg0QSJZXxbuqBFscxIkFIe8DPftQBk2VMNBbwWp2z2aGDLR769d5TyMR
         jHecF0lRwYtSYW7qhtATAplM+AF81efoAl8hh4PbPFbdFhqh0UuimQkTN8oAJp+drjki
         zCdioEZvfpq1C0xuv5s7zgSaF1WlGMX1uiqMS31acG36YDrlCj1yqUA39XILocp+oDzx
         Wl6Q==
X-Gm-Message-State: AG10YOTcXFJTTn8KpH/8DcaOqPth99ufYgp6bW2xg/c6/5yYAFRDYcTwRKEwo6aBleY5gQ==
X-Received: by 10.66.147.165 with SMTP id tl5mr15721654pab.88.1454632995382;
        Thu, 04 Feb 2016 16:43:15 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id xv2sm19840728pab.10.2016.02.04.16.43.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:08 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h5cb007751;
        Thu, 4 Feb 2016 16:43:05 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150h5tU007750;
        Thu, 4 Feb 2016 16:43:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6/7] [PATCH] MIPS: OCTEON: Add support for OCTEON III interrupt  controller.
Date:   Thu,  4 Feb 2016 16:42:53 -0800
Message-Id: <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Add irq_chip support for both IPI and "normal" interrupts of the CIU3
controller.  Document the device tree binding for the CIU3.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 .../devicetree/bindings/mips/cavium/ciu3.txt       |  27 +
 arch/mips/cavium-octeon/octeon-irq.c               | 651 ++++++++++++++++++++-
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 3 files changed, 679 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu3.txt

diff --git a/Documentation/devicetree/bindings/mips/cavium/ciu3.txt b/Documentation/devicetree/bindings/mips/cavium/ciu3.txt
new file mode 100644
index 0000000..616862a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/ciu3.txt
@@ -0,0 +1,27 @@
+* Central Interrupt Unit v3
+
+Properties:
+- compatible: "cavium,octeon-7890-ciu3"
+
+  Compatibility with 78XX and 73XX SOCs.
+
+- interrupt-controller:  This is an interrupt controller.
+
+- reg: The base address of the CIU's register bank.
+
+- #interrupt-cells: Must be <2>.  The first cell is source number.
+  The second cell indicates the triggering semantics, and may have a
+  value of either 4 for level semantics, or 1 for edge semantics.
+
+Example:
+	interrupt-controller@1010000000000 {
+		compatible = "cavium,octeon-7890-ciu3";
+		interrupt-controller;
+		/* Interrupts are specified by two parts:
+		 * 1) Source number (20 significant bits)
+		 * 2) Trigger type: (4 == level, 1 == edge)
+		 */
+		#address-cells = <0>;
+		#interrupt-cells = <2>;
+		reg = <0x10100 0x00000000 0x0 0xb0000000>;
+	};
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index bc30d3a..2fbae41 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -19,15 +19,52 @@
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-ciu2-defs.h>
+#include <asm/octeon/cvmx-ciu3-defs.h>
 
 static DEFINE_PER_CPU(unsigned long, octeon_irq_ciu0_en_mirror);
 static DEFINE_PER_CPU(unsigned long, octeon_irq_ciu1_en_mirror);
 static DEFINE_PER_CPU(raw_spinlock_t, octeon_irq_ciu_spinlock);
+static DEFINE_PER_CPU(unsigned int, octeon_irq_ciu3_idt_ip2);
+
+static DEFINE_PER_CPU(unsigned int, octeon_irq_ciu3_idt_ip3);
+static DEFINE_PER_CPU(struct octeon_ciu3_info *, octeon_ciu3_info);
+#define CIU3_MBOX_PER_CORE 10
+
+/*
+ * The 8 most significant bits of the intsn identify the interrupt major block.
+ * Each major block might use its own interrupt domain. Thus 256 domains are
+ * needed.
+ */
+#define MAX_CIU3_DOMAINS		256
+
+typedef irq_hw_number_t (*octeon_ciu3_intsn2hw_t)(struct irq_domain *, unsigned int);
+
+/* Information for each ciu3 in the system */
+struct octeon_ciu3_info {
+	u64			ciu3_addr;
+	int			node;
+	struct irq_domain	*domain[MAX_CIU3_DOMAINS];
+	octeon_ciu3_intsn2hw_t	intsn2hw[MAX_CIU3_DOMAINS];
+};
+
+/* Each ciu3 in the system uses its own data (one ciu3 per node) */
+static struct octeon_ciu3_info	*octeon_ciu3_info_per_node[4];
 
 struct octeon_irq_ciu_domain_data {
 	int num_sum;  /* number of sum registers (2 or 3). */
 };
 
+/* Register offsets from ciu3_addr */
+#define CIU3_CONST		0x220
+#define CIU3_IDT_CTL(_idt)	((_idt) * 8 + 0x110000)
+#define CIU3_IDT_PP(_idt, _idx)	((_idt) * 32 + (_idx) * 8 + 0x120000)
+#define CIU3_IDT_IO(_idt)	((_idt) * 8 + 0x130000)
+#define CIU3_DEST_PP_INT(_pp_ip) ((_pp_ip) * 8 + 0x200000)
+#define CIU3_DEST_IO_INT(_io)	((_io) * 8 + 0x210000)
+#define CIU3_ISC_CTL(_intsn)	((_intsn) * 8 + 0x80000000)
+#define CIU3_ISC_W1C(_intsn)	((_intsn) * 8 + 0x90000000)
+#define CIU3_ISC_W1S(_intsn)	((_intsn) * 8 + 0xa0000000)
+
 static __read_mostly int octeon_irq_ciu_to_irq[8][64];
 
 struct octeon_ciu_chip_data {
@@ -39,10 +76,11 @@ struct octeon_ciu_chip_data {
 		struct {		/* only used for ciu/ciu2 */
 			u8 line;
 			u8 bit;
-			u8 gpio_line;
 		};
 	};
+	int gpio_line;
 	int current_cpu;	/* Next CPU expected to take this irq */
+	int ciu_node; /* NUMA node number of the CIU */
 };
 
 struct octeon_core_chip_data {
@@ -626,6 +664,18 @@ static void octeon_irq_ciu_enable_all_v2(struct irq_data *data)
 	}
 }
 
+static int octeon_irq_ciu_set_type(struct irq_data *data, unsigned int t)
+{
+	irqd_set_trigger_type(data, t);
+
+	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(data, handle_edge_irq);
+	else
+		irq_set_handler_locked(data, handle_level_irq);
+
+	return IRQ_SET_MASK_OK;
+}
+
 static void octeon_irq_gpio_setup(struct irq_data *data)
 {
 	union cvmx_gpio_bit_cfgx cfg;
@@ -863,6 +913,16 @@ static int octeon_irq_ciu_set_affinity_sum2(struct irq_data *data,
 }
 #endif
 
+static unsigned int edge_startup(struct irq_data *data)
+{
+	/* ack any pending edge-irq at startup, so there is
+	 * an _edge_ to fire on when the event reappears.
+	 */
+	data->chip->irq_ack(data);
+	data->chip->irq_enable(data);
+	return 0;
+}
+
 /*
  * Newer octeon chips have support for lockless CIU operation.
  */
@@ -2271,10 +2331,599 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 	return 0;
 }
 
+int octeon_irq_ciu3_xlat(struct irq_domain *d,
+			 struct device_node *node,
+			 const u32 *intspec,
+			 unsigned int intsize,
+			 unsigned long *out_hwirq,
+			 unsigned int *out_type)
+{
+	struct octeon_ciu3_info *ciu3_info = d->host_data;
+	unsigned int hwirq, type, intsn_major;
+	union cvmx_ciu3_iscx_ctl isc;
+
+	if (intsize < 2)
+		return -EINVAL;
+	hwirq = intspec[0];
+	type = intspec[1];
+
+	if (hwirq >= (1 << 20))
+		return -EINVAL;
+
+	intsn_major = hwirq >> 12;
+	switch (intsn_major) {
+	case 0x04: /* Software handled separately. */
+		return -EINVAL;
+	default:
+		break;
+	}
+
+	isc.u64 =  cvmx_read_csr(ciu3_info->ciu3_addr + CIU3_ISC_CTL(hwirq));
+	if (!isc.s.imp)
+		return -EINVAL;
+
+	switch (type) {
+	case 4: /* official value for level triggering. */
+		*out_type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case 0: /* unofficial value, but we might as well let it work. */
+	case 1: /* official value for edge triggering. */
+		*out_type = IRQ_TYPE_EDGE_RISING;
+		break;
+	default: /* Nothing else is acceptable. */
+		return -EINVAL;
+	}
+
+	*out_hwirq = hwirq;
+
+	return 0;
+}
+
+void octeon_irq_ciu3_enable(struct irq_data *data)
+{
+	int cpu;
+	union cvmx_ciu3_iscx_ctl isc_ctl;
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+	u64 isc_ctl_addr;
+
+	struct octeon_ciu_chip_data *cd;
+
+	cpu = next_cpu_for_irq(data);
+
+	cd = irq_data_get_irq_chip_data(data);
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.en = 1;
+	cvmx_write_csr(cd->ciu3_addr + CIU3_ISC_W1C(cd->intsn), isc_w1c.u64);
+
+	isc_ctl_addr = cd->ciu3_addr + CIU3_ISC_CTL(cd->intsn);
+	isc_ctl.u64 = 0;
+	isc_ctl.s.en = 1;
+	isc_ctl.s.idt = per_cpu(octeon_irq_ciu3_idt_ip2, cpu);
+	cvmx_write_csr(isc_ctl_addr, isc_ctl.u64);
+	cvmx_read_csr(isc_ctl_addr);
+}
+
+void octeon_irq_ciu3_disable(struct irq_data *data)
+{
+	u64 isc_ctl_addr;
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+
+	struct octeon_ciu_chip_data *cd;
+
+	cd = irq_data_get_irq_chip_data(data);
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.en = 1;
+
+	isc_ctl_addr = cd->ciu3_addr + CIU3_ISC_CTL(cd->intsn);
+	cvmx_write_csr(cd->ciu3_addr + CIU3_ISC_W1C(cd->intsn), isc_w1c.u64);
+	cvmx_write_csr(isc_ctl_addr, 0);
+	cvmx_read_csr(isc_ctl_addr);
+}
+
+void octeon_irq_ciu3_ack(struct irq_data *data)
+{
+	u64 isc_w1c_addr;
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+	struct octeon_ciu_chip_data *cd;
+	u32 trigger_type = irqd_get_trigger_type(data);
+
+	/*
+	 * We use a single irq_chip, so we have to do nothing to ack a
+	 * level interrupt.
+	 */
+	if (!(trigger_type & IRQ_TYPE_EDGE_BOTH))
+		return;
+
+	cd = irq_data_get_irq_chip_data(data);
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.raw = 1;
+
+	isc_w1c_addr = cd->ciu3_addr + CIU3_ISC_W1C(cd->intsn);
+	cvmx_write_csr(isc_w1c_addr, isc_w1c.u64);
+	cvmx_read_csr(isc_w1c_addr);
+}
+
+void octeon_irq_ciu3_mask(struct irq_data *data)
+{
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+	u64 isc_w1c_addr;
+	struct octeon_ciu_chip_data *cd;
+
+	cd = irq_data_get_irq_chip_data(data);
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.en = 1;
+
+	isc_w1c_addr = cd->ciu3_addr + CIU3_ISC_W1C(cd->intsn);
+	cvmx_write_csr(isc_w1c_addr, isc_w1c.u64);
+	cvmx_read_csr(isc_w1c_addr);
+}
+
+void octeon_irq_ciu3_mask_ack(struct irq_data *data)
+{
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+	u64 isc_w1c_addr;
+	struct octeon_ciu_chip_data *cd;
+	u32 trigger_type = irqd_get_trigger_type(data);
+
+	cd = irq_data_get_irq_chip_data(data);
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.en = 1;
+
+	/*
+	 * We use a single irq_chip, so only ack an edge (!level)
+	 * interrupt.
+	 */
+	if (trigger_type & IRQ_TYPE_EDGE_BOTH)
+		isc_w1c.s.raw = 1;
+
+	isc_w1c_addr = cd->ciu3_addr + CIU3_ISC_W1C(cd->intsn);
+	cvmx_write_csr(isc_w1c_addr, isc_w1c.u64);
+	cvmx_read_csr(isc_w1c_addr);
+}
+
+#ifdef CONFIG_SMP
+int octeon_irq_ciu3_set_affinity(struct irq_data *data,
+				 const struct cpumask *dest, bool force)
+{
+	union cvmx_ciu3_iscx_ctl isc_ctl;
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+	u64 isc_ctl_addr;
+	int cpu;
+	bool enable_one = !irqd_irq_disabled(data) && !irqd_irq_masked(data);
+	struct octeon_ciu_chip_data *cd = irq_data_get_irq_chip_data(data);
+
+	if (!cpumask_subset(dest, cpumask_of_node(cd->ciu_node)))
+		return -EINVAL;
+
+	if (!enable_one)
+		return IRQ_SET_MASK_OK;
+
+	cd = irq_data_get_irq_chip_data(data);
+	cpu = cpumask_first(dest);
+	if (cpu >= nr_cpu_ids)
+		cpu = smp_processor_id();
+	cd->current_cpu = cpu;
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.en = 1;
+	cvmx_write_csr(cd->ciu3_addr + CIU3_ISC_W1C(cd->intsn), isc_w1c.u64);
+
+	isc_ctl_addr = cd->ciu3_addr + CIU3_ISC_CTL(cd->intsn);
+	isc_ctl.u64 = 0;
+	isc_ctl.s.en = 1;
+	isc_ctl.s.idt = per_cpu(octeon_irq_ciu3_idt_ip2, cpu);
+	cvmx_write_csr(isc_ctl_addr, isc_ctl.u64);
+	cvmx_read_csr(isc_ctl_addr);
+
+	return IRQ_SET_MASK_OK;
+}
+#endif
+
+static struct irq_chip octeon_irq_chip_ciu3 = {
+	.name = "CIU3",
+	.irq_startup = edge_startup,
+	.irq_enable = octeon_irq_ciu3_enable,
+	.irq_disable = octeon_irq_ciu3_disable,
+	.irq_ack = octeon_irq_ciu3_ack,
+	.irq_mask = octeon_irq_ciu3_mask,
+	.irq_mask_ack = octeon_irq_ciu3_mask_ack,
+	.irq_unmask = octeon_irq_ciu3_enable,
+	.irq_set_type = octeon_irq_ciu_set_type,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu3_set_affinity,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+int octeon_irq_ciu3_mapx(struct irq_domain *d, unsigned int virq,
+			 irq_hw_number_t hw, struct irq_chip *chip)
+{
+	struct octeon_ciu3_info *ciu3_info = d->host_data;
+	struct octeon_ciu_chip_data *cd = kzalloc_node(sizeof(*cd), GFP_KERNEL,
+						       ciu3_info->node);
+	if (!cd)
+		return -ENOMEM;
+	cd->intsn = hw;
+	cd->current_cpu = -1;
+	cd->ciu3_addr = ciu3_info->ciu3_addr;
+	cd->ciu_node = ciu3_info->node;
+	irq_set_chip_and_handler(virq, chip, handle_edge_irq);
+	irq_set_chip_data(virq, cd);
+
+	return 0;
+}
+
+static int octeon_irq_ciu3_map(struct irq_domain *d,
+			       unsigned int virq, irq_hw_number_t hw)
+{
+	return octeon_irq_ciu3_mapx(d, virq, hw, &octeon_irq_chip_ciu3);
+}
+
+static struct irq_domain_ops octeon_dflt_domain_ciu3_ops = {
+	.map = octeon_irq_ciu3_map,
+	.unmap = octeon_irq_free_cd,
+	.xlate = octeon_irq_ciu3_xlat,
+};
+
+static void octeon_irq_ciu3_ip2(void)
+{
+	union cvmx_ciu3_destx_pp_int dest_pp_int;
+	struct octeon_ciu3_info *ciu3_info;
+	u64 ciu3_addr;
+
+	ciu3_info = __this_cpu_read(octeon_ciu3_info);
+	ciu3_addr = ciu3_info->ciu3_addr;
+
+	dest_pp_int.u64 = cvmx_read_csr(ciu3_addr + CIU3_DEST_PP_INT(3 * cvmx_get_local_core_num()));
+
+	if (likely(dest_pp_int.s.intr)) {
+		irq_hw_number_t intsn = dest_pp_int.s.intsn;
+		irq_hw_number_t hw;
+		struct irq_domain *domain;
+		/* Get the domain to use from the major block */
+		int block = intsn >> 12;
+		int ret;
+
+		domain = ciu3_info->domain[block];
+		if (ciu3_info->intsn2hw[block])
+			hw = ciu3_info->intsn2hw[block](domain, intsn);
+		else
+			hw = intsn;
+
+		ret = handle_domain_irq(domain, hw, NULL);
+		if (ret < 0) {
+			union cvmx_ciu3_iscx_w1c isc_w1c;
+			u64 isc_w1c_addr = ciu3_addr + CIU3_ISC_W1C(intsn);
+
+			isc_w1c.u64 = 0;
+			isc_w1c.s.en = 1;
+			cvmx_write_csr(isc_w1c_addr, isc_w1c.u64);
+			cvmx_read_csr(isc_w1c_addr);
+			spurious_interrupt();
+		}
+	} else {
+		spurious_interrupt();
+	}
+}
+
+/*
+ * 10 mbox per core starting from zero.
+ * Base mbox is core * 10
+ */
+static unsigned int octeon_irq_ciu3_base_mbox_intsn(int core)
+{
+	/* SW (mbox) are 0x04 in bits 12..19 */
+	return 0x04000 + CIU3_MBOX_PER_CORE * core;
+}
+
+static unsigned int octeon_irq_ciu3_mbox_intsn_for_core(int core, unsigned int mbox)
+{
+	return octeon_irq_ciu3_base_mbox_intsn(core) + mbox;
+}
+
+static unsigned int octeon_irq_ciu3_mbox_intsn_for_cpu(int cpu, unsigned int mbox)
+{
+	int local_core = octeon_coreid_for_cpu(cpu) & 0x3f;
+
+	return octeon_irq_ciu3_mbox_intsn_for_core(local_core, mbox);
+}
+
+static void octeon_irq_ciu3_mbox(void)
+{
+	union cvmx_ciu3_destx_pp_int dest_pp_int;
+	struct octeon_ciu3_info *ciu3_info;
+	u64 ciu3_addr;
+	int core = cvmx_get_local_core_num();
+
+	ciu3_info = __this_cpu_read(octeon_ciu3_info);
+	ciu3_addr = ciu3_info->ciu3_addr;
+
+	dest_pp_int.u64 = cvmx_read_csr(ciu3_addr + CIU3_DEST_PP_INT(1 + 3 * core));
+
+	if (likely(dest_pp_int.s.intr)) {
+		irq_hw_number_t intsn = dest_pp_int.s.intsn;
+		int mbox = intsn - octeon_irq_ciu3_base_mbox_intsn(core);
+
+		if (likely(mbox >= 0 && mbox < CIU3_MBOX_PER_CORE)) {
+			do_IRQ(mbox + OCTEON_IRQ_MBOX0);
+		} else {
+			union cvmx_ciu3_iscx_w1c isc_w1c;
+			u64 isc_w1c_addr = ciu3_addr + CIU3_ISC_W1C(intsn);
+
+			isc_w1c.u64 = 0;
+			isc_w1c.s.en = 1;
+			cvmx_write_csr(isc_w1c_addr, isc_w1c.u64);
+			cvmx_read_csr(isc_w1c_addr);
+			spurious_interrupt();
+		}
+	} else {
+		spurious_interrupt();
+	}
+}
+
+void octeon_ciu3_mbox_send(int cpu, unsigned int mbox)
+{
+	struct octeon_ciu3_info *ciu3_info;
+	unsigned int intsn;
+	union cvmx_ciu3_iscx_w1s isc_w1s;
+	u64 isc_w1s_addr;
+
+	if (WARN_ON_ONCE(mbox >= CIU3_MBOX_PER_CORE))
+		return;
+
+	intsn = octeon_irq_ciu3_mbox_intsn_for_cpu(cpu, mbox);
+	ciu3_info = per_cpu(octeon_ciu3_info, cpu);
+	isc_w1s_addr = ciu3_info->ciu3_addr + CIU3_ISC_W1S(intsn);
+
+	isc_w1s.u64 = 0;
+	isc_w1s.s.raw = 1;
+
+	cvmx_write_csr(isc_w1s_addr, isc_w1s.u64);
+	cvmx_read_csr(isc_w1s_addr);
+}
+EXPORT_SYMBOL(octeon_ciu3_mbox_send);
+
+static void octeon_irq_ciu3_mbox_set_enable(struct irq_data *data, int cpu, bool en)
+{
+	struct octeon_ciu3_info *ciu3_info;
+	unsigned int intsn;
+	u64 isc_ctl_addr, isc_w1c_addr;
+	union cvmx_ciu3_iscx_ctl isc_ctl;
+	unsigned int mbox = data->irq - OCTEON_IRQ_MBOX0;
+
+	intsn = octeon_irq_ciu3_mbox_intsn_for_cpu(cpu, mbox);
+	ciu3_info = per_cpu(octeon_ciu3_info, cpu);
+	isc_w1c_addr = ciu3_info->ciu3_addr + CIU3_ISC_W1C(intsn);
+	isc_ctl_addr = ciu3_info->ciu3_addr + CIU3_ISC_CTL(intsn);
+
+	isc_ctl.u64 = 0;
+	isc_ctl.s.en = 1;
+
+	cvmx_write_csr(isc_w1c_addr, isc_ctl.u64);
+	cvmx_write_csr(isc_ctl_addr, 0);
+	if (en) {
+		unsigned int idt = per_cpu(octeon_irq_ciu3_idt_ip3, cpu);
+
+		isc_ctl.u64 = 0;
+		isc_ctl.s.en = 1;
+		isc_ctl.s.idt = idt;
+		cvmx_write_csr(isc_ctl_addr, isc_ctl.u64);
+	}
+	cvmx_read_csr(isc_ctl_addr);
+}
+
+static void octeon_irq_ciu3_mbox_enable(struct irq_data *data)
+{
+	int cpu;
+	unsigned int mbox = data->irq - OCTEON_IRQ_MBOX0;
+
+	WARN_ON(mbox >= CIU3_MBOX_PER_CORE);
+
+	for_each_online_cpu(cpu)
+		octeon_irq_ciu3_mbox_set_enable(data, cpu, true);
+}
+
+static void octeon_irq_ciu3_mbox_disable(struct irq_data *data)
+{
+	int cpu;
+	unsigned int mbox = data->irq - OCTEON_IRQ_MBOX0;
+
+	WARN_ON(mbox >= CIU3_MBOX_PER_CORE);
+
+	for_each_online_cpu(cpu)
+		octeon_irq_ciu3_mbox_set_enable(data, cpu, false);
+}
+
+static void octeon_irq_ciu3_mbox_ack(struct irq_data *data)
+{
+	struct octeon_ciu3_info *ciu3_info;
+	unsigned int intsn;
+	u64 isc_w1c_addr;
+	union cvmx_ciu3_iscx_w1c isc_w1c;
+	unsigned int mbox = data->irq - OCTEON_IRQ_MBOX0;
+
+	intsn = octeon_irq_ciu3_mbox_intsn_for_core(cvmx_get_local_core_num(), mbox);
+
+	isc_w1c.u64 = 0;
+	isc_w1c.s.raw = 1;
+
+	ciu3_info = __this_cpu_read(octeon_ciu3_info);
+	isc_w1c_addr = ciu3_info->ciu3_addr + CIU3_ISC_W1C(intsn);
+	cvmx_write_csr(isc_w1c_addr, isc_w1c.u64);
+	cvmx_read_csr(isc_w1c_addr);
+}
+
+static void octeon_irq_ciu3_mbox_cpu_online(struct irq_data *data)
+{
+	octeon_irq_ciu3_mbox_set_enable(data, smp_processor_id(), true);
+}
+
+static void octeon_irq_ciu3_mbox_cpu_offline(struct irq_data *data)
+{
+	octeon_irq_ciu3_mbox_set_enable(data, smp_processor_id(), false);
+}
+
+static int octeon_irq_ciu3_alloc_resources(struct octeon_ciu3_info *ciu3_info)
+{
+	u64 b = ciu3_info->ciu3_addr;
+	int idt_ip2, idt_ip3, idt_ip4;
+	int unused_idt2;
+	int core = cvmx_get_local_core_num();
+	int i;
+
+	__this_cpu_write(octeon_ciu3_info, ciu3_info);
+
+	/*
+	 * 4 idt per core starting from 1 because zero is reserved.
+	 * Base idt per core is 4 * core + 1
+	 */
+	idt_ip2 = core * 4 + 1;
+	idt_ip3 = core * 4 + 2;
+	idt_ip4 = core * 4 + 3;
+	unused_idt2 = core * 4 + 4;
+	__this_cpu_write(octeon_irq_ciu3_idt_ip2, idt_ip2);
+	__this_cpu_write(octeon_irq_ciu3_idt_ip3, idt_ip3);
+
+	/* ip2 interrupts for this CPU */
+	cvmx_write_csr(b + CIU3_IDT_CTL(idt_ip2), 0);
+	cvmx_write_csr(b + CIU3_IDT_PP(idt_ip2, 0), 1ull << core);
+	cvmx_write_csr(b + CIU3_IDT_IO(idt_ip2), 0);
+
+	/* ip3 interrupts for this CPU */
+	cvmx_write_csr(b + CIU3_IDT_CTL(idt_ip3), 1);
+	cvmx_write_csr(b + CIU3_IDT_PP(idt_ip3, 0), 1ull << core);
+	cvmx_write_csr(b + CIU3_IDT_IO(idt_ip3), 0);
+
+	/* ip4 interrupts for this CPU */
+	cvmx_write_csr(b + CIU3_IDT_CTL(idt_ip4), 2);
+	cvmx_write_csr(b + CIU3_IDT_PP(idt_ip4, 0), 0);
+	cvmx_write_csr(b + CIU3_IDT_IO(idt_ip4), 0);
+
+	cvmx_write_csr(b + CIU3_IDT_CTL(unused_idt2), 0);
+	cvmx_write_csr(b + CIU3_IDT_PP(unused_idt2, 0), 0);
+	cvmx_write_csr(b + CIU3_IDT_IO(unused_idt2), 0);
+
+	for (i = 0; i < CIU3_MBOX_PER_CORE; i++) {
+		unsigned int intsn = octeon_irq_ciu3_mbox_intsn_for_core(core, i);
+
+		cvmx_write_csr(b + CIU3_ISC_W1C(intsn), 2);
+		cvmx_write_csr(b + CIU3_ISC_CTL(intsn), 0);
+	}
+
+	return 0;
+}
+
+static void octeon_irq_setup_secondary_ciu3(void)
+{
+	struct octeon_ciu3_info *ciu3_info;
+
+	ciu3_info = octeon_ciu3_info_per_node[cvmx_get_node_num()];
+	octeon_irq_ciu3_alloc_resources(ciu3_info);
+	irq_cpu_online();
+
+	/* Enable the CIU lines */
+	set_c0_status(STATUSF_IP3 | STATUSF_IP2);
+	if (octeon_irq_use_ip4)
+		set_c0_status(STATUSF_IP4);
+	else
+		clear_c0_status(STATUSF_IP4);
+}
+
+static struct irq_chip octeon_irq_chip_ciu3_mbox = {
+	.name = "CIU3-M",
+	.irq_enable = octeon_irq_ciu3_mbox_enable,
+	.irq_disable = octeon_irq_ciu3_mbox_disable,
+	.irq_ack = octeon_irq_ciu3_mbox_ack,
+
+	.irq_cpu_online = octeon_irq_ciu3_mbox_cpu_online,
+	.irq_cpu_offline = octeon_irq_ciu3_mbox_cpu_offline,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
+};
+
+static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
+				       struct device_node *parent)
+{
+	int i;
+	int node;
+	struct irq_domain *domain;
+	struct octeon_ciu3_info *ciu3_info;
+	const __be32 *zero_addr;
+	u64 base_addr;
+	union cvmx_ciu3_const consts;
+
+	node = 0; /* of_node_to_nid(ciu_node); */
+	ciu3_info = kzalloc_node(sizeof(*ciu3_info), GFP_KERNEL, node);
+
+	if (!ciu3_info)
+		return -ENOMEM;
+
+	zero_addr = of_get_address(ciu_node, 0, NULL, NULL);
+	if (WARN_ON(!zero_addr))
+		return -EINVAL;
+
+	base_addr = of_translate_address(ciu_node, zero_addr);
+	base_addr = (u64)phys_to_virt(base_addr);
+
+	ciu3_info->ciu3_addr = base_addr;
+	ciu3_info->node = node;
+
+	consts.u64 = cvmx_read_csr(base_addr + CIU3_CONST);
+
+	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu3;
+
+	octeon_irq_ip2 = octeon_irq_ciu3_ip2;
+	octeon_irq_ip3 = octeon_irq_ciu3_mbox;
+	octeon_irq_ip4 = octeon_irq_ip4_mask;
+
+	if (node == cvmx_get_node_num()) {
+		/* Mips internal */
+		octeon_irq_init_core();
+
+		/* Only do per CPU things if it is the CIU of the boot node. */
+		i = irq_alloc_descs_from(OCTEON_IRQ_MBOX0, 8, node);
+		WARN_ON(i < 0);
+
+		for (i = 0; i < 8; i++)
+			irq_set_chip_and_handler(i + OCTEON_IRQ_MBOX0,
+						 &octeon_irq_chip_ciu3_mbox, handle_percpu_irq);
+	}
+
+	/*
+	 * Initialize all domains to use the default domain. Specific major
+	 * blocks will overwrite the default domain as needed.
+	 */
+	domain = irq_domain_add_tree(ciu_node, &octeon_dflt_domain_ciu3_ops,
+				     ciu3_info);
+	for (i = 0; i < MAX_CIU3_DOMAINS; i++)
+		ciu3_info->domain[i] = domain;
+
+	octeon_ciu3_info_per_node[node] = ciu3_info;
+
+	if (node == cvmx_get_node_num()) {
+		/* Only do per CPU things if it is the CIU of the boot node. */
+		octeon_irq_ciu3_alloc_resources(ciu3_info);
+		if (node == 0)
+			irq_set_default_host(domain);
+
+		octeon_irq_use_ip4 = false;
+		/* Enable the CIU lines */
+		set_c0_status(STATUSF_IP2 | STATUSF_IP3);
+		clear_c0_status(STATUSF_IP4);
+	}
+
+	return 0;
+}
+
 static struct of_device_id ciu_types[] __initdata = {
 	{.compatible = "cavium,octeon-3860-ciu", .data = octeon_irq_init_ciu},
 	{.compatible = "cavium,octeon-3860-gpio", .data = octeon_irq_init_gpio},
 	{.compatible = "cavium,octeon-6880-ciu2", .data = octeon_irq_init_ciu2},
+	{.compatible = "cavium,octeon-7890-ciu3", .data = octeon_irq_init_ciu3},
 	{.compatible = "cavium,octeon-7130-cib", .data = octeon_irq_init_cib},
 	{}
 };
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index de9f74e..780ca6b 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -299,6 +299,8 @@ static inline void octeon_npi_write32(uint64_t address, uint32_t val)
 	cvmx_read64_uint32(address ^ 4);
 }
 
+void octeon_ciu3_mbox_send(int cpu, unsigned int mbox);
+
 /* Octeon multiplier save/restore routines from octeon_switch.S */
 void octeon_mult_save(void);
 void octeon_mult_restore(void);
-- 
1.7.11.7
