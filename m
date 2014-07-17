Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 10:23:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861309AbaGQIV6ENmMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 10:21:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2918445219B19
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:21:49 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 09:21:51 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:51 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 09:21:50 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 5/7] MIPS: GIC: Generalise check for pending interrupts
Date:   Thu, 17 Jul 2014 09:20:57 +0100
Message-ID: <1405585259-24941-6-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 41262
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

Move most of the functionality of gic_get_int() into a new function
gic_get_int_mask() which takes a bitmask of interrupts in which the
caller is interested, and returns the subset which are pending for the
current CPU.

This allows CP0 IRQ dispatch routines to check only the GIC interrupts
which are routed to a particular CPU interrupt input.

gic_get_int() is reimplemented using gic_get_int_mask() and is retained
for use by any platforms for which gic_get_int() is sufficient.

Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/gic.h |  1 +
 arch/mips/kernel/irq-gic.c  | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 394d366b8fc1..8b30befd99d6 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -373,6 +373,7 @@ extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
+extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
 extern unsigned int gic_get_int(void);
 extern void gic_enable_interrupt(int irq_vec);
 extern void gic_disable_interrupt(int irq_vec);
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 9932aef91abb..9e9d8b9a5b97 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -189,7 +189,7 @@ unsigned int gic_compare_int(void)
 		return 0;
 }
 
-unsigned int gic_get_int(void)
+void gic_get_int_mask(unsigned long *dst, const unsigned long *src)
 {
 	unsigned int i;
 	unsigned long *pending, *intrmask, *pcpu_mask;
@@ -214,8 +214,17 @@ unsigned int gic_get_int(void)
 
 	bitmap_and(pending, pending, intrmask, GIC_NUM_INTRS);
 	bitmap_and(pending, pending, pcpu_mask, GIC_NUM_INTRS);
+	bitmap_and(dst, src, pending, GIC_NUM_INTRS);
+}
+
+unsigned int gic_get_int(void)
+{
+	DECLARE_BITMAP(interrupts, GIC_NUM_INTRS);
+
+	bitmap_fill(interrupts, GIC_NUM_INTRS);
+	gic_get_int_mask(interrupts, interrupts);
 
-	return find_first_bit(pending, GIC_NUM_INTRS);
+	return find_first_bit(interrupts, GIC_NUM_INTRS);
 }
 
 static void gic_mask_irq(struct irq_data *d)
-- 
2.0.0
