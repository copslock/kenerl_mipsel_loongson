Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 08:17:43 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:10422 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20025135AbYFRHRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 08:17:14 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 50251C80D3;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id HWN2lcfy-OFi; Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 2F08EC801D;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id A8A0DB404A; Wed, 18 Jun 2008 10:18:23 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 3/5] [MIPS] A few cleanups in malta_int.c
Date:	Wed, 18 Jun 2008 10:18:21 +0300
Message-Id: <1213773503-23536-4-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Both the fill_ipi_map() routine and the gic_intr_map array defined
in arch/mips/mips-boards/malta/malta_int.c are not used outside of
the latter file. Thus, these objects can become static. Moreover,
these two objects are used by the MT code only, which is why this
patch adds the appropriate ifdef.

While at it, this patch removes an unnecessary preprocessing macro
in favor of the commonly used ARRAY_SIZE.

Successfully tested using a Qemu-emulated Malta board for both SMP
and UP kernels.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/mips-boards/malta/malta_int.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index 8c49510..b393982 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -363,6 +363,7 @@ static msc_irqmap_t __initdata msc_eicirqmap[] = {
 
 static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
 
+#if defined(CONFIG_MIPS_MT_SMP)
 /*
  * This GIC specific tabular array defines the association between External
  * Interrupts and CPUs/Core Interrupts. The nature of the External
@@ -394,6 +395,7 @@ static struct gic_intr_map gic_intr_map[] = {
 	{ GIC_EXT_INTR(22), 	3,	GIC_CPU_INT1,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
 	{ GIC_EXT_INTR(23), 	3,	GIC_CPU_INT2,	GIC_POL_POS, GIC_TRIG_EDGE,	1 },
 };
+#endif
 
 /*
  * GCMP needs to be detected before any SMP initialisation
@@ -412,7 +414,8 @@ int __init gcmp_probe(unsigned long addr, unsigned long size)
 	return gcmp_present;
 }
 
-void __init fill_ipi_map(void)
+#if defined(CONFIG_MIPS_MT_SMP)
+static void __init fill_ipi_map(void)
 {
 	int i;
 
@@ -422,6 +425,7 @@ void __init fill_ipi_map(void)
 				(1 << (gic_intr_map[i].pin + 2));
 	}
 }
+#endif
 
 void __init arch_init_irq(void)
 {
@@ -527,7 +531,6 @@ void __init arch_init_irq(void)
 				.call =  GIC_IPI_EXT_INTR_CALLFNC_VPE3
 			}
 		};
-#define NIPI (sizeof(ipiirq)/sizeof(ipiirq[0]))
 		fill_ipi_map();
 		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map, ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 		if (!gcmp_present) {
@@ -549,7 +552,7 @@ void __init arch_init_irq(void)
 		printk("CPU%d: status register now %08x\n", smp_processor_id(), read_c0_status());
 		write_c0_status(0x1100dc00);
 		printk("CPU%d: status register frc %08x\n", smp_processor_id(), read_c0_status());
-		for (i = 0; i < NIPI; i++) {
+		for (i = 0; i < ARRAY_SIZE(ipiirq); i++) {
 			setup_irq(MIPS_GIC_IRQ_BASE + ipiirq[i].resched, &irq_resched);
 			setup_irq(MIPS_GIC_IRQ_BASE + ipiirq[i].call, &irq_call);
 
-- 
1.5.5.GIT
