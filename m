Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:46:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29546 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993911AbdHMEo0hIeid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:44:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5AE25D379277F;
        Sun, 13 Aug 2017 05:44:18 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:44:19 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 23/38] irqchip: mips-gic: Remove gic_get_usm_range()
Date:   Sat, 12 Aug 2017 21:36:31 -0700
Message-ID: <20170813043646.25821-24-paul.burton@imgtec.com>
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
X-archive-position: 59539
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

The MIPS VDSO code is no longer reliant upon the irqchip driver to
provide the address of the GIC's user-visible section via
gic_get_usm_range(). Remove the now-dead code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 14 --------------
 include/linux/irqchip/mips-gic.h | 11 -----------
 2 files changed, 25 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d6fbc5d6e8e2..6086747f02bf 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -46,7 +46,6 @@ struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
-static unsigned long __gic_base_addr;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
@@ -134,17 +133,6 @@ int gic_get_c0_fdc_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
 }
 
-int gic_get_usm_range(struct resource *gic_usm_res)
-{
-	if (!gic_present)
-		return -1;
-
-	gic_usm_res->start = __gic_base_addr + USM_VISIBLE_SECTION_OFS;
-	gic_usm_res->end = gic_usm_res->start + (USM_VISIBLE_SECTION_SIZE - 1);
-
-	return 0;
-}
-
 static void gic_handle_shared_int(bool chained)
 {
 	unsigned int intr, virq;
@@ -672,8 +660,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	unsigned int gicconfig, cpu;
 	unsigned int v[2];
 
-	__gic_base_addr = gic_base_addr;
-
 	mips_gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
 
 	gicconfig = read_gic_config();
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index da02a146b292..843e1bb49767 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -11,10 +11,6 @@
 #include <linux/clocksource.h>
 #include <linux/ioport.h>
 
-/* GIC Address Space */
-#define USM_VISIBLE_SECTION_OFS		0x10000
-#define USM_VISIBLE_SECTION_SIZE	0x10000
-
 /* User Mode Visible Section Register Map */
 #define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
@@ -29,18 +25,11 @@ extern void gic_init(unsigned long gic_base_addr,
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 extern int gic_get_c0_fdc_int(void);
-extern int gic_get_usm_range(struct resource *gic_usm_res);
 
 #else /* CONFIG_MIPS_GIC */
 
 #define gic_present	0
 
-static inline int gic_get_usm_range(struct resource *gic_usm_res)
-{
-	/* Shouldn't be called. */
-	return -1;
-}
-
 #endif /* CONFIG_MIPS_GIC */
 
 #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
-- 
2.14.0
