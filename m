Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:17:05 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47464 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491923Ab1CWVJJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:09 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIe-0001wP-32; Wed, 23 Mar 2011 22:09:04 +0100
Message-Id: <20110323210536.562616703@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:03 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 21/38] mips: smtc: Use irq_data in smtc_forward_irq()
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-kernel-smtc.c
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/smtc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-mips-next/arch/mips/kernel/smtc.c
===================================================================
--- linux-mips-next.orig/arch/mips/kernel/smtc.c
+++ linux-mips-next/arch/mips/kernel/smtc.c
@@ -679,6 +679,7 @@ void smtc_set_irq_affinity(unsigned int 
 
 void smtc_forward_irq(unsigned int irq)
 {
+	struct irq_data *d = irq_get_irq_data(irq);
 	int target;
 
 	/*
@@ -692,7 +693,7 @@ void smtc_forward_irq(unsigned int irq)
 	 * and efficiency, we just pick the easiest one to find.
 	 */
 
-	target = cpumask_first(irq_desc[irq].affinity);
+	target = cpumask_first(d->affinity);
 
 	/*
 	 * We depend on the platform code to have correctly processed
