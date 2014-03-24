Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:23:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49544 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503AbaCXKVnqPcmp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:21:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 261EFC351266C
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:21:36 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 24 Mar
 2014 10:21:37 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:37 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:37 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/12] MIPS: Malta: GIC IPIs may be used without MT
Date:   Mon, 24 Mar 2014 10:19:32 +0000
Message-ID: <1395656375-9300-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39569
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

It's perfectly valid to use SMP on a non-MT CPU and use the GIC for
IPIs. Set them up conditional upon CONFIG_MIPS_GIC_IPI rather than
CONFIG_MIPS_MT_SMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/mti-malta/malta-int.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 1b90fd8..b71ee80 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -286,10 +286,6 @@ asmlinkage void plat_irq_dispatch(void)
 
 #ifdef CONFIG_MIPS_MT_SMP
 
-
-#define GIC_MIPS_CPU_IPI_RESCHED_IRQ	3
-#define GIC_MIPS_CPU_IPI_CALL_IRQ	4
-
 #define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
 #define C_RESCHED C_SW0
 #define MIPS_CPU_IPI_CALL_IRQ 1		/* SW int 1 for resched */
@@ -306,6 +302,13 @@ static void ipi_call_dispatch(void)
 	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ);
 }
 
+#endif /* CONFIG_MIPS_MT_SMP */
+
+#ifdef CONFIG_MIPS_GIC_IPI
+
+#define GIC_MIPS_CPU_IPI_RESCHED_IRQ	3
+#define GIC_MIPS_CPU_IPI_CALL_IRQ	4
+
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
 #ifdef CONFIG_MIPS_VPE_APSP_API_CMP
@@ -336,7 +339,7 @@ static struct irqaction irq_call = {
 	.flags		= IRQF_PERCPU,
 	.name		= "IPI_call"
 };
-#endif /* CONFIG_MIPS_MT_SMP */
+#endif /* CONFIG_MIPS_GIC_IPI */
 
 static int gic_resched_int_base;
 static int gic_call_int_base;
@@ -416,7 +419,7 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 };
 #undef X
 
-#if defined(CONFIG_MIPS_MT_SMP)
+#ifdef CONFIG_MIPS_GIC_IPI
 static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
 {
 	int intr = baseintr + cpu;
@@ -532,7 +535,7 @@ void __init arch_init_irq(void)
 	if (gic_present) {
 		/* FIXME */
 		int i;
-#if defined(CONFIG_MIPS_MT_SMP)
+#if defined(CONFIG_MIPS_GIC_IPI)
 		gic_call_int_base = GIC_NUM_INTRS -
 			(NR_CPUS - nr_cpu_ids) * 2 - nr_cpu_ids;
 		gic_resched_int_base = gic_call_int_base - nr_cpu_ids;
@@ -547,7 +550,7 @@ void __init arch_init_irq(void)
 				(i | (0x1 << MSC01_SC_CFG_GICENA_SHF));
 			pr_debug("GIC Enabled\n");
 		}
-#if defined(CONFIG_MIPS_MT_SMP)
+#if defined(CONFIG_MIPS_GIC_IPI)
 		/* set up ipi interrupts */
 		if (cpu_has_vint) {
 			set_vi_handler(MIPSCPU_INT_IPI0, malta_ipi_irqdispatch);
-- 
1.8.5.3
