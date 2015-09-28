Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 12:12:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4176 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007052AbbI1KMVZ9vRf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2015 12:12:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8201D242550B9;
        Mon, 28 Sep 2015 11:12:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 28 Sep 2015 11:12:15 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.88) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 28 Sep 2015 11:12:14 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <alex@alex-smith.me.uk>, Alex Smith <alex.smith@imgtec.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] irqchip: irq-mips-gic: Provide function to map GIC user section
Date:   Mon, 28 Sep 2015 11:11:57 +0100
Message-ID: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Alex Smith <alex.smith@imgtec.com>

The GIC provides a "user-mode visible" section containing a mirror of
the counter registers which can be mapped into user memory. This will
be used by the VDSO time function implementations, so provide a
function to map it in.

When the GIC is not enabled in Kconfig a dummy inline version of this
function is provided, along with "#define gic_present 0", so that we
don't have to litter the VDSO code with ifdefs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c   | 27 +++++++++++++++++++++------
 include/linux/irqchip/mips-gic.h | 24 ++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index af2f16bb8a94..c995b199ca32 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/mm.h>
 #include <linux/of_address.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -29,6 +30,7 @@ struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
+static unsigned long gic_base_addr;
 static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
@@ -301,6 +303,19 @@ int gic_get_c0_fdc_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
 }
 
+int gic_map_user_section(struct vm_area_struct *vma, unsigned long base,
+			 unsigned long size)
+{
+	unsigned long pfn;
+
+	BUG_ON(!gic_present);
+	BUG_ON(size > USM_VISIBLE_SECTION_SIZE);
+
+	pfn = (gic_base_addr + USM_VISIBLE_SECTION_OFS) >> PAGE_SHIFT;
+	return io_remap_pfn_range(vma, base, pfn, size,
+				  pgprot_noncached(PAGE_READONLY));
+}
+
 static void gic_handle_shared_int(bool chained)
 {
 	unsigned int i, intr, virq, gic_reg_step = mips_cm_is64 ? 8 : 4;
@@ -783,14 +798,15 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
-static void __init __gic_init(unsigned long gic_base_addr,
-			      unsigned long gic_addrspace_size,
+static void __init __gic_init(unsigned long base_addr,
+			      unsigned long addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
 			      struct device_node *node)
 {
 	unsigned int gicconfig;
 
-	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
+	gic_base_addr = base_addr;
+	gic_base = ioremap_nocache(base_addr, addrspace_size);
 
 	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
 	gic_shared_intrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
@@ -847,11 +863,10 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	gic_ipi_init();
 }
 
-void __init gic_init(unsigned long gic_base_addr,
-		     unsigned long gic_addrspace_size,
+void __init gic_init(unsigned long base_addr, unsigned long addrspace_size,
 		     unsigned int cpu_vec, unsigned int irqbase)
 {
-	__gic_init(gic_base_addr, gic_addrspace_size, cpu_vec, irqbase, NULL);
+	__gic_init(base_addr, addrspace_size, cpu_vec, irqbase, NULL);
 }
 
 static int __init gic_of_init(struct device_node *node,
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 4e6861605050..68f2e9539204 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -245,10 +245,14 @@
 #define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
 #define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
 
+struct vm_area_struct;
+
+#ifdef CONFIG_MIPS_GIC
+
 extern unsigned int gic_present;
 
-extern void gic_init(unsigned long gic_base_addr,
-	unsigned long gic_addrspace_size, unsigned int cpu_vec,
+extern void gic_init(unsigned long base_addr,
+	unsigned long addrspace_size, unsigned int cpu_vec,
 	unsigned int irqbase);
 extern void gic_clocksource_init(unsigned int);
 extern cycle_t gic_read_count(void);
@@ -264,4 +268,20 @@ extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 extern int gic_get_c0_fdc_int(void);
+extern int gic_map_user_section(struct vm_area_struct *vma, unsigned long base,
+				unsigned long size);
+
+#else /* CONFIG_MIPS_GIC */
+
+#define gic_present	0
+
+static inline int gic_map_user_section(struct vm_area_struct *vma,
+				       unsigned long base, unsigned long size)
+{
+	/* Shouldn't be called. */
+	return -1;
+}
+
+#endif /* CONFIG_MIPS_GIC */
+
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.5.3
