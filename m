Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2015 11:41:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29230 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009330AbbJLJk6W2UST (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2015 11:40:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DFAD31585C4A9;
        Mon, 12 Oct 2015 10:40:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 12 Oct 2015 10:40:51 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.37) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 12 Oct 2015 10:40:50 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alex Smith <alex.smith@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 2/3] irqchip: irq-mips-gic: Provide function to map GIC user section
Date:   Mon, 12 Oct 2015 10:40:43 +0100
Message-ID: <1444642843-16375-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com>
References: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.37]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49486
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

[markos.chandras@imgtec.com:
- Move mapping code to arch/mips/kernel/vdso.c and use a resource
type to get the GIC usermode information
- Avoid renaming function arguments and use __gic_base_addr to hold
the base GIC address prior to ioremap.]

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- Move mapping code to arch/mips/kernel/vdso.c and use a resource
type to get the GIC usermode information
- Avoid renaming function arguments and use __gic_base_addr to hold
the base GIC address prior to ioremap.

http://www.linux-mips.org/archives/linux-mips/2015-09/msg00316.html
---
 drivers/irqchip/irq-mips-gic.c   | 14 ++++++++++++++
 include/linux/irqchip/mips-gic.h | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index af2f16bb8a94..392beebb81ee 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -29,6 +29,7 @@ struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
+static unsigned long __gic_base_addr;
 static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
@@ -301,6 +302,17 @@ int gic_get_c0_fdc_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
 }
 
+int gic_get_usm_range(struct resource *gic_usm_res)
+{
+	if (!gic_present)
+		return -1;
+
+	gic_usm_res->start = __gic_base_addr + USM_VISIBLE_SECTION_OFS;
+	gic_usm_res->end = gic_usm_res->start + (USM_VISIBLE_SECTION_SIZE - 1);
+
+	return 0;
+}
+
 static void gic_handle_shared_int(bool chained)
 {
 	unsigned int i, intr, virq, gic_reg_step = mips_cm_is64 ? 8 : 4;
@@ -790,6 +802,8 @@ static void __init __gic_init(unsigned long gic_base_addr,
 {
 	unsigned int gicconfig;
 
+	__gic_base_addr = gic_base_addr;
+
 	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
 
 	gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 4e6861605050..71ab7c548550 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -9,6 +9,7 @@
 #define __LINUX_IRQCHIP_MIPS_GIC_H
 
 #include <linux/clocksource.h>
+#include <linux/ioport.h>
 
 #define GIC_MAX_INTRS			256
 
@@ -245,6 +246,8 @@
 #define GIC_SHARED_TO_HWIRQ(x)	(GIC_SHARED_HWIRQ_BASE + (x))
 #define GIC_HWIRQ_TO_SHARED(x)	((x) - GIC_SHARED_HWIRQ_BASE)
 
+#ifdef CONFIG_MIPS_GIC
+
 extern unsigned int gic_present;
 
 extern void gic_init(unsigned long gic_base_addr,
@@ -264,4 +267,18 @@ extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 extern int gic_get_c0_fdc_int(void);
+extern int gic_get_usm_range(struct resource *gic_usm_res);
+
+#else /* CONFIG_MIPS_GIC */
+
+#define gic_present	0
+
+static int gic_get_usm_range(struct resource *gic_usm_res)
+{
+	/* Shouldn't be called. */
+	return -1
+}
+
+#endif /* CONFIG_MIPS_GIC */
+
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.6.1
