Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:24:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21003 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861310AbaGQIV7J-qgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:21:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 17FDB6B1AE3BF
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:21:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:52 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:51 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 6/7] MIPS: Malta: Fix dispatching of GIC interrupts
Date:   Thu, 17 Jul 2014 09:20:58 +0100
Message-ID: <1405585259-24941-7-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41263
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

From: Jeffrey Deans <jeffrey.deans@imgtec.com>

The Malta malta_ipi_irqdispatch() routine now checks only IPI interrupts
when handling IPIs. It could previously call do_IRQ() for non-IPIs, and
also call do_IRQ() with an invalid IRQ number if there were no pending
GIC interrupts when gic_get_int() was called.

Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-int.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 4ab919141737..e4f43baa8f67 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -42,6 +42,10 @@ static unsigned int ipi_map[NR_CPUS];
 
 static DEFINE_RAW_SPINLOCK(mips_irq_lock);
 
+#ifdef CONFIG_MIPS_GIC_IPI
+DECLARE_BITMAP(ipi_ints, GIC_NUM_INTRS);
+#endif
+
 static inline int mips_pcibios_iack(void)
 {
 	int irq;
@@ -125,16 +129,22 @@ static void malta_hw0_irqdispatch(void)
 
 static void malta_ipi_irqdispatch(void)
 {
-	int irq;
+#ifdef CONFIG_MIPS_GIC_IPI
+	unsigned long irq;
+	DECLARE_BITMAP(pending, GIC_NUM_INTRS);
 
-	if (gic_compare_int())
-		do_IRQ(MIPS_GIC_IRQ_BASE);
+	gic_get_int_mask(pending, ipi_ints);
+
+	irq = find_first_bit(pending, GIC_NUM_INTRS);
 
-	irq = gic_get_int();
-	if (irq < 0)
-		return;	 /* interrupt has already been cleared */
+	while (irq < GIC_NUM_INTRS) {
+		do_IRQ(MIPS_GIC_IRQ_BASE + irq);
 
-	do_IRQ(MIPS_GIC_IRQ_BASE + irq);
+		irq = find_next_bit(pending, GIC_NUM_INTRS, irq + 1);
+	}
+#endif
+	if (gic_compare_int())
+		do_IRQ(MIPS_GIC_IRQ_BASE);
 }
 
 static void corehi_irqdispatch(void)
@@ -429,6 +439,7 @@ static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
 	gic_intr_map[intr].trigtype = GIC_TRIG_EDGE;
 	gic_intr_map[intr].flags = 0;
 	ipi_map[cpu] |= (1 << (cpupin + 2));
+	bitmap_set(ipi_ints, intr, 1);
 }
 
 static void __init fill_ipi_map(void)
-- 
2.0.0
