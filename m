Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2015 10:02:22 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:34163 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007004AbbFLICTY0HIW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2015 10:02:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D07A1180A2;
        Fri, 12 Jun 2015 10:02:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id bGE9S8hDIktK; Fri, 12 Jun 2015 10:02:12 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 864F718125;
        Fri, 12 Jun 2015 10:02:11 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 6D21612C6;
        Fri, 12 Jun 2015 10:02:11 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 61C3CC8D;
        Fri, 12 Jun 2015 10:02:11 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id 5C36A34005;
        Fri, 12 Jun 2015 10:02:11 +0200 (CEST)
Received: from lnxrabinv.se.axis.com (10.88.144.1) by xmail2.se.axis.com
 (10.0.5.74) with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 12 Jun 2015
 10:02:11 +0200
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <abrestic@chromium.org>,
        Rabin Vincent <rabinv@axis.com>
Subject: [PATCH] irqchip: mips-gic: don't nest calls to do_IRQ()
Date:   Fri, 12 Jun 2015 10:01:56 +0200
Message-ID: <1434096116-16750-1-git-send-email-rabin.vincent@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin.vincent@axis.com
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

The GIC chained handlers use do_IRQ() to call the subhandlers.  This
means that irq_enter() calls get nested, which leads to preempt count
looking like we're in nested interrupts, which in turn leads to all
system time being accounted as IRQ time in account_system_time().

Fix it by using generic_handle_irq().  Since these same functions are
used in some systems (if cpu_has_veic) from a low-level vectored
interrupt handler which does not go throught do_IRQ(), we need to do it
conditionally.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 drivers/irqchip/irq-mips-gic.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 57f09cb..269c235 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -271,7 +271,7 @@ int gic_get_c0_fdc_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_FDC));
 }
 
-static void gic_handle_shared_int(void)
+static void gic_handle_shared_int(bool chained)
 {
 	unsigned int i, intr, virq;
 	unsigned long *pcpu_mask;
@@ -299,7 +299,10 @@ static void gic_handle_shared_int(void)
 	while (intr != gic_shared_intrs) {
 		virq = irq_linear_revmap(gic_irq_domain,
 					 GIC_SHARED_TO_HWIRQ(intr));
-		do_IRQ(virq);
+		if (chained)
+			generic_handle_irq(virq);
+		else
+			do_IRQ(virq);
 
 		/* go to next pending bit */
 		bitmap_clear(pending, intr, 1);
@@ -431,7 +434,7 @@ static struct irq_chip gic_edge_irq_controller = {
 #endif
 };
 
-static void gic_handle_local_int(void)
+static void gic_handle_local_int(bool chained)
 {
 	unsigned long pending, masked;
 	unsigned int intr, virq;
@@ -445,7 +448,10 @@ static void gic_handle_local_int(void)
 	while (intr != GIC_NUM_LOCAL_INTRS) {
 		virq = irq_linear_revmap(gic_irq_domain,
 					 GIC_LOCAL_TO_HWIRQ(intr));
-		do_IRQ(virq);
+		if (chained)
+			generic_handle_irq(virq);
+		else
+			do_IRQ(virq);
 
 		/* go to next pending bit */
 		bitmap_clear(&pending, intr, 1);
@@ -509,13 +515,14 @@ static struct irq_chip gic_all_vpes_local_irq_controller = {
 
 static void __gic_irq_dispatch(void)
 {
-	gic_handle_local_int();
-	gic_handle_shared_int();
+	gic_handle_local_int(false);
+	gic_handle_shared_int(false);
 }
 
 static void gic_irq_dispatch(unsigned int irq, struct irq_desc *desc)
 {
-	__gic_irq_dispatch();
+	gic_handle_local_int(true);
+	gic_handle_shared_int(true);
 }
 
 #ifdef CONFIG_MIPS_GIC_IPI
-- 
1.7.10.4
