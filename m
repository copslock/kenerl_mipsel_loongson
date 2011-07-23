Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:44:09 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491196Ab1GWMlZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:25 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWH-0003uw-7K; Sat, 23 Jul 2011 14:41:25 +0200
Message-Id: <20110723124016.317419770@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:24 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [patch 6/7] MIPS: Loongson: Mark cascade interrupts IRQF_NO_THREAD
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline;
 filename=mips-loongson-mark-cascade-interrupts-non-thread.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16789

From: Wu Zhangjin <wuzhangjin@gmail.com>

There are two cascade interrupts in Loongson machines, one for bonito
northbridge, another for the 8259A controller in the southbridge. Both
want to be non threaded.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/mips/loongson/fuloong-2e/irq.c |    1 +
 arch/mips/loongson/lemote-2f/irq.c  |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6-tip/arch/mips/loongson/fuloong-2e/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/loongson/fuloong-2e/irq.c
+++ linux-2.6-tip/arch/mips/loongson/fuloong-2e/irq.c
@@ -42,6 +42,7 @@ asmlinkage void mach_irq_dispatch(unsign
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
 };
 
 void __init mach_init_irq(void)
Index: linux-2.6-tip/arch/mips/loongson/lemote-2f/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/loongson/lemote-2f/irq.c
+++ linux-2.6-tip/arch/mips/loongson/lemote-2f/irq.c
@@ -96,12 +96,13 @@ static irqreturn_t ip6_action(int cpl, v
 struct irqaction ip6_irqaction = {
 	.handler = ip6_action,
 	.name = "cascade",
-	.flags = IRQF_SHARED,
+	.flags = IRQF_SHARED | IRQF_NO_THREAD,
 };
 
 struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
 };
 
 void __init mach_init_irq(void)
