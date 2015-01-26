Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 11:46:03 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:58362 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010935AbbAZKqBjxQ1U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 11:46:01 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.14.8/8.14.7) with ESMTP id t0QAjXqZ000983;
        Mon, 26 Jan 2015 02:45:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.14.8/8.14.7/Submit) id t0QAjXYm000980;
        Mon, 26 Jan 2015 02:45:33 -0800
Date:   Mon, 26 Jan 2015 02:45:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-d7eb4f2ecccd71f701bc8873bcf07c2d3b0375f6@git.kernel.org>
Cc:     linux-mips@linux-mips.org, abrestic@chromium.org,
        jason@lakedaemon.net, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, qais.yousef@imgtec.com, hpa@zytor.com
Reply-To: abrestic@chromium.org, linux-mips@linux-mips.org,
          jason@lakedaemon.net, linux-kernel@vger.kernel.org,
          qais.yousef@imgtec.com, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <1421668289-828-1-git-send-email-qais.yousef@imgtec.com>
References: <1421668289-828-1-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip: mips-gic:
  Handle pending interrupts once in __gic_irq_dispatch()
Git-Commit-ID: d7eb4f2ecccd71f701bc8873bcf07c2d3b0375f6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org>
  to get blacklisted from these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  d7eb4f2ecccd71f701bc8873bcf07c2d3b0375f6
Gitweb:     http://git.kernel.org/tip/d7eb4f2ecccd71f701bc8873bcf07c2d3b0375f6
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Mon, 19 Jan 2015 11:51:29 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 26 Jan 2015 11:38:23 +0100

irqchip: mips-gic: Handle pending interrupts once in __gic_irq_dispatch()

When an interrupt occurs __gic_irq_dispatch() continuously reads local
and shared pending registers until all is serviced before
returning. The problem with that is that it could introduce a long
delay before returning if a piece of hardware keeps triggering while
in one of these loops.

To ensure fairness and priority doesn't get skewed a lot, read local
and shared pending registers once to service each pending IRQ once.
If another interupt triggers while servicing the current ones, then we
shall re-enter the handler after we return.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: <linux-mips@linux-mips.org>
Link: http://lkml.kernel.org/r/1421668289-828-1-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mips-gic.c | 44 +++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 2b0468e..f3f9873 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -234,9 +234,9 @@ int gic_get_c0_perfcount_int(void)
 				  GIC_LOCAL_TO_HWIRQ(GIC_LOCAL_INT_PERFCTR));
 }
 
-static unsigned int gic_get_int(void)
+static void gic_handle_shared_int(void)
 {
-	unsigned int i;
+	unsigned int i, intr, virq;
 	unsigned long *pcpu_mask;
 	unsigned long pending_reg, intrmask_reg;
 	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
@@ -258,7 +258,16 @@ static unsigned int gic_get_int(void)
 	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
 	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
 
-	return find_first_bit(pending, gic_shared_intrs);
+	intr = find_first_bit(pending, gic_shared_intrs);
+	while (intr != gic_shared_intrs) {
+		virq = irq_linear_revmap(gic_irq_domain,
+					 GIC_SHARED_TO_HWIRQ(intr));
+		do_IRQ(virq);
+
+		/* go to next pending bit */
+		bitmap_clear(pending, intr, 1);
+		intr = find_first_bit(pending, gic_shared_intrs);
+	}
 }
 
 static void gic_mask_irq(struct irq_data *d)
@@ -385,16 +394,26 @@ static struct irq_chip gic_edge_irq_controller = {
 #endif
 };
 
-static unsigned int gic_get_local_int(void)
+static void gic_handle_local_int(void)
 {
 	unsigned long pending, masked;
+	unsigned int intr, virq;
 
 	pending = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_PEND));
 	masked = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_MASK));
 
 	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
 
-	return find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
+	intr = find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
+	while (intr != GIC_NUM_LOCAL_INTRS) {
+		virq = irq_linear_revmap(gic_irq_domain,
+					 GIC_LOCAL_TO_HWIRQ(intr));
+		do_IRQ(virq);
+
+		/* go to next pending bit */
+		bitmap_clear(&pending, intr, 1);
+		intr = find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
+	}
 }
 
 static void gic_mask_local_irq(struct irq_data *d)
@@ -453,19 +472,8 @@ static struct irq_chip gic_all_vpes_local_irq_controller = {
 
 static void __gic_irq_dispatch(void)
 {
-	unsigned int intr, virq;
-
-	while ((intr = gic_get_local_int()) != GIC_NUM_LOCAL_INTRS) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_LOCAL_TO_HWIRQ(intr));
-		do_IRQ(virq);
-	}
-
-	while ((intr = gic_get_int()) != gic_shared_intrs) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_SHARED_TO_HWIRQ(intr));
-		do_IRQ(virq);
-	}
+	gic_handle_local_int();
+	gic_handle_shared_int();
 }
 
 static void gic_irq_dispatch(unsigned int irq, struct irq_desc *desc)
