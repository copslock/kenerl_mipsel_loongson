Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:41:59 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491181Ab1GWMlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:23 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWF-0003ue-5P; Sat, 23 Jul 2011 14:41:23 +0200
Message-Id: <20110723124015.978127007@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:22 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 1/7] mips: sibyte: Add missing irq_mask function
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline; filename=mips-sibyte-fix-irq-chip.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16784

Crashes on free_irq() otherwise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/sibyte/sb1250/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/mips/sibyte/sb1250/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/sibyte/sb1250/irq.c
+++ linux-2.6/arch/mips/sibyte/sb1250/irq.c
@@ -178,7 +178,7 @@ static void ack_sb1250_irq(struct irq_da
 
 static struct irq_chip sb1250_irq_type = {
 	.name = "SB1250-IMR",
-	.irq_mask_ack = ack_sb1250_irq,
+	.irq_mask = ack_sb1250_irq,
 	.irq_unmask = enable_sb1250_irq,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = sb1250_set_affinity
