Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:49:30 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57011 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011083AbbGMUqRFkOXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:17 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkcB-0006Wh-Hk; Mon, 13 Jul 2015 22:46:15 +0200
Message-Id: <20150713200715.369024359@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:46:09 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org, Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [patch 11/12] MIPS/netlogic: Prepare ipi handlers for irq argument
 removal
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-netlogic--Prepare-ipi-handlers-for-irq-argument-removal.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/netlogic/common/smp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: tip/arch/mips/netlogic/common/smp.c
===================================================================
--- tip.orig/arch/mips/netlogic/common/smp.c
+++ tip/arch/mips/netlogic/common/smp.c
@@ -82,8 +82,9 @@ void nlm_send_ipi_mask(const struct cpum
 }
 
 /* IRQ_IPI_SMP_FUNCTION Handler */
-void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
+void nlm_smp_function_ipi_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	clear_c0_eimr(irq);
 	ack_c0_eirr(irq);
 	smp_call_function_interrupt();
@@ -91,8 +92,9 @@ void nlm_smp_function_ipi_handler(unsign
 }
 
 /* IRQ_IPI_SMP_RESCHEDULE  handler */
-void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
+void nlm_smp_resched_ipi_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	clear_c0_eimr(irq);
 	ack_c0_eirr(irq);
 	scheduler_ipi();
