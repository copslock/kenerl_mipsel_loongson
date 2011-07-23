Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:43:46 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60699 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491191Ab1GWMlZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:25 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWG-0003uq-Oj; Sat, 23 Jul 2011 14:41:24 +0200
Message-Id: <20110723124016.245033649@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:24 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [patch 5/7] MIPS: Mark cascade and low level interrupts IRQF_NO_THREAD
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline;
 filename=mips-mark-cascade-interrupts-nothread.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16788

From: Wu Zhangjin <wuzhangjin@gmail.com>

Mark interrupts with no_action handler, cascade interrupts, low level
interrupts (bus error, halt ..) with IRQF_NO_THREAD to exclude them
from forced threading.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/mips/ar7/irq.c                    |    3 ++-
 arch/mips/bcm63xx/irq.c                |    1 +
 arch/mips/cobalt/irq.c                 |    1 +
 arch/mips/dec/setup.c                  |    4 ++++
 arch/mips/emma/markeins/irq.c          |    2 +-
 arch/mips/lasat/interrupt.c            |    1 +
 arch/mips/mti-malta/malta-int.c        |    6 ++++--
 arch/mips/pmc-sierra/msp71xx/msp_irq.c |    2 ++
 arch/mips/pnx8550/common/int.c         |    2 +-
 arch/mips/sgi-ip22/ip22-int.c          |   10 +++++-----
 arch/mips/sni/rm200.c                  |    1 +
 arch/mips/vr41xx/common/irq.c          |    1 +
 12 files changed, 24 insertions(+), 10 deletions(-)

Index: linux-2.6/arch/mips/ar7/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/ar7/irq.c
+++ linux-2.6/arch/mips/ar7/irq.c
@@ -98,7 +98,8 @@ static struct irq_chip ar7_sec_irq_type 
 
 static struct irqaction ar7_cascade_action = {
 	.handler = no_action,
-	.name = "AR7 cascade interrupt"
+	.name = "AR7 cascade interrupt",
+	.flags = IRQF_NO_THREAD,
 };
 
 static void __init ar7_irq_init(int base)
Index: linux-2.6/arch/mips/bcm63xx/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/bcm63xx/irq.c
+++ linux-2.6/arch/mips/bcm63xx/irq.c
@@ -222,6 +222,7 @@ static struct irq_chip bcm63xx_external_
 static struct irqaction cpu_ip2_cascade_action = {
 	.handler	= no_action,
 	.name		= "cascade_ip2",
+	.flags		= IRQF_NO_THREAD,
 };
 
 void __init arch_init_irq(void)
Index: linux-2.6/arch/mips/cobalt/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/cobalt/irq.c
+++ linux-2.6/arch/mips/cobalt/irq.c
@@ -48,6 +48,7 @@ asmlinkage void plat_irq_dispatch(void)
 static struct irqaction cascade = {
 	.handler	= no_action,
 	.name		= "cascade",
+	.flags		= IRQF_NO_THREAD,
 };
 
 void __init arch_init_irq(void)
Index: linux-2.6/arch/mips/dec/setup.c
===================================================================
--- linux-2.6.orig/arch/mips/dec/setup.c
+++ linux-2.6/arch/mips/dec/setup.c
@@ -101,20 +101,24 @@ int cpu_fpu_mask = DEC_CPU_IRQ_MASK(DEC_
 static struct irqaction ioirq = {
 	.handler = no_action,
 	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
 };
 static struct irqaction fpuirq = {
 	.handler = no_action,
 	.name = "fpu",
+	.flags = IRQF_NO_THREAD,
 };
 
 static struct irqaction busirq = {
 	.flags = IRQF_DISABLED,
 	.name = "bus error",
+	.flags = IRQF_NO_THREAD,
 };
 
 static struct irqaction haltirq = {
 	.handler = dec_intr_halt,
 	.name = "halt",
+	.flags = IRQF_NO_THREAD,
 };
 
 
Index: linux-2.6/arch/mips/emma/markeins/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/emma/markeins/irq.c
+++ linux-2.6/arch/mips/emma/markeins/irq.c
@@ -169,7 +169,7 @@ void emma2rh_gpio_irq_init(void)
 
 static struct irqaction irq_cascade = {
 	   .handler = no_action,
-	   .flags = 0,
+	   .flags = IRQF_NO_THREAD,
 	   .name = "cascade",
 	   .dev_id = NULL,
 	   .next = NULL,
Index: linux-2.6/arch/mips/lasat/interrupt.c
===================================================================
--- linux-2.6.orig/arch/mips/lasat/interrupt.c
+++ linux-2.6/arch/mips/lasat/interrupt.c
@@ -105,6 +105,7 @@ asmlinkage void plat_irq_dispatch(void)
 static struct irqaction cascade = {
 	.handler	= no_action,
 	.name		= "cascade",
+	.flags		= IRQF_NO_THREAD,
 };
 
 void __init arch_init_irq(void)
Index: linux-2.6/arch/mips/mti-malta/malta-int.c
===================================================================
--- linux-2.6.orig/arch/mips/mti-malta/malta-int.c
+++ linux-2.6/arch/mips/mti-malta/malta-int.c
@@ -350,12 +350,14 @@ unsigned int plat_ipi_resched_int_xlate(
 
 static struct irqaction i8259irq = {
 	.handler = no_action,
-	.name = "XT-PIC cascade"
+	.name = "XT-PIC cascade",
+	.flags = IRQF_NO_THREAD,
 };
 
 static struct irqaction corehi_irqaction = {
 	.handler = no_action,
-	.name = "CoreHi"
+	.name = "CoreHi",
+	.flags = IRQF_NO_THREAD,
 };
 
 static msc_irqmap_t __initdata msc_irqmap[] = {
Index: linux-2.6/arch/mips/pmc-sierra/msp71xx/msp_irq.c
===================================================================
--- linux-2.6.orig/arch/mips/pmc-sierra/msp71xx/msp_irq.c
+++ linux-2.6/arch/mips/pmc-sierra/msp71xx/msp_irq.c
@@ -109,11 +109,13 @@ asmlinkage void plat_irq_dispatch(struct
 static struct irqaction cic_cascade_msp = {
 	.handler = no_action,
 	.name	 = "MSP CIC cascade"
+	.flags	 = IRQF_NO_THREAD,
 };
 
 static struct irqaction per_cascade_msp = {
 	.handler = no_action,
 	.name	 = "MSP PER cascade"
+	.flags	 = IRQF_NO_THREAD,
 };
 
 void __init arch_init_irq(void)
Index: linux-2.6/arch/mips/pnx8550/common/int.c
===================================================================
--- linux-2.6.orig/arch/mips/pnx8550/common/int.c
+++ linux-2.6/arch/mips/pnx8550/common/int.c
@@ -167,7 +167,7 @@ static struct irq_chip level_irq_type = 
 
 static struct irqaction gic_action = {
 	.handler =	no_action,
-	.flags =	IRQF_DISABLED,
+	.flags =	IRQF_DISABLED | IRQF_NO_THREAD,
 	.name =		"GIC",
 };
 
Index: linux-2.6/arch/mips/sgi-ip22/ip22-int.c
===================================================================
--- linux-2.6.orig/arch/mips/sgi-ip22/ip22-int.c
+++ linux-2.6/arch/mips/sgi-ip22/ip22-int.c
@@ -155,32 +155,32 @@ static void __irq_entry indy_buserror_ir
 
 static struct irqaction local0_cascade = {
 	.handler	= no_action,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_NO_THREAD,
 	.name		= "local0 cascade",
 };
 
 static struct irqaction local1_cascade = {
 	.handler	= no_action,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_NO_THREAD,
 	.name		= "local1 cascade",
 };
 
 static struct irqaction buserr = {
 	.handler	= no_action,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_NO_THREAD,
 	.name		= "Bus Error",
 };
 
 static struct irqaction map0_cascade = {
 	.handler	= no_action,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_NO_THREAD,
 	.name		= "mapable0 cascade",
 };
 
 #ifdef USE_LIO3_IRQ
 static struct irqaction map1_cascade = {
 	.handler	= no_action,
-	.flags		= IRQF_DISABLED,
+	.flags		= IRQF_DISABLED | IRQF_NO_THREAD,
 	.name		= "mapable1 cascade",
 };
 #define SGI_INTERRUPTS	SGINT_END
Index: linux-2.6/arch/mips/sni/rm200.c
===================================================================
--- linux-2.6.orig/arch/mips/sni/rm200.c
+++ linux-2.6/arch/mips/sni/rm200.c
@@ -359,6 +359,7 @@ void sni_rm200_init_8259A(void)
 static struct irqaction sni_rm200_irq2 = {
 	.handler = no_action,
 	.name = "cascade",
+	.flags = IRQF_NO_THREAD,
 };
 
 static struct resource sni_rm200_pic1_resource = {
Index: linux-2.6/arch/mips/vr41xx/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/vr41xx/common/irq.c
+++ linux-2.6/arch/mips/vr41xx/common/irq.c
@@ -34,6 +34,7 @@ static irq_cascade_t irq_cascade[NR_IRQS
 static struct irqaction cascade_irqaction = {
 	.handler	= no_action,
 	.name		= "cascade",
+	.flags		= IRQF_NO_THREAD,
 };
 
 int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int))
