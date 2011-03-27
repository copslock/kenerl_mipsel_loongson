Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 18:24:21 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40562 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491925Ab1C0QWN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Mar 2011 18:22:13 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q3sj8-000554-Ht; Sun, 27 Mar 2011 18:22:07 +0200
Message-Id: <20110327161118.928261230@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sun, 27 Mar 2011 16:22:06 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: [patch 5/5] MIPS: Convert the irq functions to the new names
References: <20110327155637.623706071@linutronix.de>
Content-Disposition: inline; filename=mips-namespace.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Scripted with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/alchemy/devboards/bcsr.c               |    6 +-
 arch/mips/alchemy/devboards/db1200/setup.c       |    2 
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   50 +++++++++++------------
 arch/mips/alchemy/devboards/pb1000/board_setup.c |    2 
 arch/mips/alchemy/devboards/pb1100/board_setup.c |    8 +--
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    2 
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   16 +++----
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    6 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   10 ++--
 arch/mips/alchemy/xxs1500/board_setup.c          |   24 +++++------
 arch/mips/ar7/irq.c                              |    4 -
 arch/mips/ath79/irq.c                            |    4 -
 arch/mips/bcm63xx/irq.c                          |    4 -
 arch/mips/dec/ioasic-irq.c                       |    4 -
 arch/mips/dec/kn02-irq.c                         |    2 
 arch/mips/emma/markeins/irq.c                    |    6 +-
 arch/mips/jazz/irq.c                             |    2 
 arch/mips/jz4740/gpio.c                          |   14 +++---
 arch/mips/jz4740/irq.c                           |    4 -
 arch/mips/kernel/i8259.c                         |    6 +-
 arch/mips/kernel/irq-gic.c                       |    2 
 arch/mips/kernel/irq-gt641xx.c                   |    4 -
 arch/mips/kernel/irq-msc01.c                     |   12 +++--
 arch/mips/kernel/irq-rm7000.c                    |    2 
 arch/mips/kernel/irq-rm9000.c                    |    4 -
 arch/mips/kernel/irq.c                           |    2 
 arch/mips/kernel/irq_cpu.c                       |    4 -
 arch/mips/kernel/irq_txx9.c                      |    4 -
 arch/mips/kernel/smtc.c                          |    2 
 arch/mips/lasat/interrupt.c                      |    2 
 arch/mips/loongson/common/bonito-irq.c           |    3 -
 arch/mips/mti-malta/malta-int.c                  |    2 
 arch/mips/mti-malta/malta-time.c                 |    2 
 arch/mips/pci/msi-octeon.c                       |    4 -
 arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c       |    2 
 arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c       |    2 
 arch/mips/pmc-sierra/msp71xx/msp_smp.c           |    2 
 arch/mips/pnx833x/common/interrupts.c            |    6 +-
 arch/mips/pnx8550/common/int.c                   |   10 ++--
 arch/mips/powertv/asic/irq_asic.c                |    2 
 arch/mips/rb532/irq.c                            |    4 -
 arch/mips/sgi-ip22/ip22-int.c                    |    2 
 arch/mips/sgi-ip27/ip27-irq.c                    |    2 
 arch/mips/sgi-ip27/ip27-timer.c                  |    2 
 arch/mips/sgi-ip32/ip32-irq.c                    |   40 +++++++++++-------
 arch/mips/sibyte/bcm1480/irq.c                   |    3 -
 arch/mips/sibyte/sb1250/irq.c                    |    3 -
 arch/mips/sni/a20r.c                             |    2 
 arch/mips/sni/pcimt.c                            |    2 
 arch/mips/sni/pcit.c                             |    4 -
 arch/mips/sni/rm200.c                            |    4 -
 arch/mips/txx9/generic/irq_tx4927.c              |    2 
 arch/mips/txx9/generic/irq_tx4938.c              |    2 
 arch/mips/txx9/generic/irq_tx4939.c              |    6 +-
 arch/mips/txx9/jmr3927/irq.c                     |    5 +-
 arch/mips/txx9/rbtx4927/irq.c                    |    6 +-
 arch/mips/txx9/rbtx4938/irq.c                    |    6 +-
 arch/mips/txx9/rbtx4939/irq.c                    |    4 -
 arch/mips/vr41xx/common/icu.c                    |    4 -
 59 files changed, 185 insertions(+), 167 deletions(-)

Index: linux-2.6-tip/arch/mips/alchemy/devboards/bcsr.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/bcsr.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/bcsr.c
@@ -142,8 +142,8 @@ void __init bcsr_init_irq(int csc_start,
 	bcsr_csc_base = csc_start;
 
 	for (irq = csc_start; irq <= csc_end; irq++)
-		set_irq_chip_and_handler_name(irq, &bcsr_irq_type,
-			handle_level_irq, "level");
+		irq_set_chip_and_handler_name(irq, &bcsr_irq_type,
+					      handle_level_irq, "level");
 
-	set_irq_chained_handler(hook_irq, bcsr_csc_handler);
+	irq_set_chained_handler(hook_irq, bcsr_csc_handler);
 }
Index: linux-2.6-tip/arch/mips/alchemy/devboards/db1200/setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/db1200/setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/db1200/setup.c
@@ -63,7 +63,7 @@ void __init board_setup(void)
 static int __init db1200_arch_init(void)
 {
 	/* GPIO7 is low-level triggered CPLD cascade */
-	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
 	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
 
 	/* insert/eject pairs: one of both is always screaming.  To avoid
Index: linux-2.6-tip/arch/mips/alchemy/devboards/db1x00/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -215,35 +215,35 @@ void __init board_setup(void)
 static int __init db1x00_init_irq(void)
 {
 #if defined(CONFIG_MIPS_MIRAGE)
-	set_irq_type(AU1500_GPIO7_INT, IRQF_TRIGGER_RISING); /* TS pendown */
+	irq_set_irq_type(AU1500_GPIO7_INT, IRQF_TRIGGER_RISING); /* TS pendown */
 #elif defined(CONFIG_MIPS_DB1550)
-	set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);  /* CD0# */
-	set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);  /* CD1# */
-	set_irq_type(AU1550_GPIO3_INT, IRQF_TRIGGER_LOW);  /* CARD0# */
-	set_irq_type(AU1550_GPIO5_INT, IRQF_TRIGGER_LOW);  /* CARD1# */
-	set_irq_type(AU1550_GPIO21_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	set_irq_type(AU1550_GPIO22_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);  /* CD0# */
+	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);  /* CD1# */
+	irq_set_irq_type(AU1550_GPIO3_INT, IRQF_TRIGGER_LOW);  /* CARD0# */
+	irq_set_irq_type(AU1550_GPIO5_INT, IRQF_TRIGGER_LOW);  /* CARD1# */
+	irq_set_irq_type(AU1550_GPIO21_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	irq_set_irq_type(AU1550_GPIO22_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
 #elif defined(CONFIG_MIPS_DB1500)
-	set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
-	set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
-	set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
-	set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
-	set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+	irq_set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
+	irq_set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
+	irq_set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
+	irq_set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
+	irq_set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	irq_set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
 #elif defined(CONFIG_MIPS_DB1100)
-	set_irq_type(AU1100_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
-	set_irq_type(AU1100_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
-	set_irq_type(AU1100_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
-	set_irq_type(AU1100_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
-	set_irq_type(AU1100_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	set_irq_type(AU1100_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+	irq_set_irq_type(AU1100_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
+	irq_set_irq_type(AU1100_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
+	irq_set_irq_type(AU1100_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
+	irq_set_irq_type(AU1100_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
+	irq_set_irq_type(AU1100_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	irq_set_irq_type(AU1100_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
 #elif defined(CONFIG_MIPS_DB1000)
-	set_irq_type(AU1000_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
-	set_irq_type(AU1000_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
-	set_irq_type(AU1000_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
-	set_irq_type(AU1000_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
-	set_irq_type(AU1000_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	set_irq_type(AU1000_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
+	irq_set_irq_type(AU1000_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
+	irq_set_irq_type(AU1000_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
+	irq_set_irq_type(AU1000_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
+	irq_set_irq_type(AU1000_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
+	irq_set_irq_type(AU1000_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
+	irq_set_irq_type(AU1000_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
 #endif
 	return 0;
 }
Index: linux-2.6-tip/arch/mips/alchemy/devboards/pb1000/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -197,7 +197,7 @@ void __init board_setup(void)
 
 static int __init pb1000_init_irq(void)
 {
-	set_irq_type(AU1000_GPIO15_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1000_GPIO15_INT, IRQF_TRIGGER_LOW);
 	return 0;
 }
 arch_initcall(pb1000_init_irq);
Index: linux-2.6-tip/arch/mips/alchemy/devboards/pb1100/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -117,10 +117,10 @@ void __init board_setup(void)
 
 static int __init pb1100_init_irq(void)
 {
-	set_irq_type(AU1100_GPIO9_INT,  IRQF_TRIGGER_LOW); /* PCCD# */
-	set_irq_type(AU1100_GPIO10_INT, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
-	set_irq_type(AU1100_GPIO11_INT, IRQF_TRIGGER_LOW); /* PCCard# */
-	set_irq_type(AU1100_GPIO13_INT, IRQF_TRIGGER_LOW); /* DC_IRQ# */
+	irq_set_irq_type(AU1100_GPIO9_INT, IRQF_TRIGGER_LOW); /* PCCD# */
+	irq_set_irq_type(AU1100_GPIO10_INT, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
+	irq_set_irq_type(AU1100_GPIO11_INT, IRQF_TRIGGER_LOW); /* PCCard# */
+	irq_set_irq_type(AU1100_GPIO13_INT, IRQF_TRIGGER_LOW); /* DC_IRQ# */
 
 	return 0;
 }
Index: linux-2.6-tip/arch/mips/alchemy/devboards/pb1200/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -142,7 +142,7 @@ static int __init pb1200_init_irq(void)
 		panic("Game over.  Your score is 0.");
 	}
 
-	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
 	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1200_GPIO7_INT);
 
 	return 0;
Index: linux-2.6-tip/arch/mips/alchemy/devboards/pb1500/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -134,14 +134,14 @@ void __init board_setup(void)
 
 static int __init pb1500_init_irq(void)
 {
-	set_irq_type(AU1500_GPIO9_INT, IRQF_TRIGGER_LOW);   /* CD0# */
-	set_irq_type(AU1500_GPIO10_INT, IRQF_TRIGGER_LOW);  /* CARD0 */
-	set_irq_type(AU1500_GPIO11_INT, IRQF_TRIGGER_LOW);  /* STSCHG0# */
-	set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO9_INT, IRQF_TRIGGER_LOW);   /* CD0# */
+	irq_set_irq_type(AU1500_GPIO10_INT, IRQF_TRIGGER_LOW);  /* CARD0 */
+	irq_set_irq_type(AU1500_GPIO11_INT, IRQF_TRIGGER_LOW);  /* STSCHG0# */
+	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/mips/alchemy/devboards/pb1550/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -73,9 +73,9 @@ void __init board_setup(void)
 
 static int __init pb1550_init_irq(void)
 {
-	set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1550_GPIO201_205_INT, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1550_GPIO201_205_INT, IRQF_TRIGGER_HIGH);
 
 	/* enable both PCMCIA card irqs in the shared line */
 	alchemy_gpio2_enable_int(201);
Index: linux-2.6-tip/arch/mips/alchemy/mtx-1/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/mtx-1/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/mtx-1/board_setup.c
@@ -123,11 +123,11 @@ mtx1_pci_idsel(unsigned int devsel, int 
 
 static int __init mtx1_init_irq(void)
 {
-	set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/mips/alchemy/xxs1500/board_setup.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/alchemy/xxs1500/board_setup.c
+++ linux-2.6-tip/arch/mips/alchemy/xxs1500/board_setup.c
@@ -85,19 +85,19 @@ void __init board_setup(void)
 
 static int __init xxs1500_init_irq(void)
 {
-	set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO207_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO207_INT, IRQF_TRIGGER_LOW);
 
-	set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW);
-	set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* CF irq */
-	set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* CF irq */
+	irq_set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW);
 
 	return 0;
 }
Index: linux-2.6-tip/arch/mips/ar7/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/ar7/irq.c
+++ linux-2.6-tip/arch/mips/ar7/irq.c
@@ -119,11 +119,11 @@ static void __init ar7_irq_init(int base
 	for (i = 0; i < 40; i++) {
 		writel(i, REG(CHNL_OFFSET(i)));
 		/* Primary IRQ's */
-		set_irq_chip_and_handler(base + i, &ar7_irq_type,
+		irq_set_chip_and_handler(base + i, &ar7_irq_type,
 					 handle_level_irq);
 		/* Secondary IRQ's */
 		if (i < 32)
-			set_irq_chip_and_handler(base + i + 40,
+			irq_set_chip_and_handler(base + i + 40,
 						 &ar7_sec_irq_type,
 						 handle_level_irq);
 	}
Index: linux-2.6-tip/arch/mips/ath79/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/ath79/irq.c
+++ linux-2.6-tip/arch/mips/ath79/irq.c
@@ -124,11 +124,11 @@ static void __init ath79_misc_irq_init(v
 
 	for (i = ATH79_MISC_IRQ_BASE;
 	     i < ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT; i++) {
-		set_irq_chip_and_handler(i, &ath79_misc_irq_chip,
+		irq_set_chip_and_handler(i, &ath79_misc_irq_chip,
 					 handle_level_irq);
 	}
 
-	set_irq_chained_handler(ATH79_CPU_IRQ_MISC, ath79_misc_irq_handler);
+	irq_set_chained_handler(ATH79_CPU_IRQ_MISC, ath79_misc_irq_handler);
 }
 
 asmlinkage void plat_irq_dispatch(void)
Index: linux-2.6-tip/arch/mips/bcm63xx/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/bcm63xx/irq.c
+++ linux-2.6-tip/arch/mips/bcm63xx/irq.c
@@ -230,11 +230,11 @@ void __init arch_init_irq(void)
 
 	mips_cpu_irq_init();
 	for (i = IRQ_INTERNAL_BASE; i < NR_IRQS; ++i)
-		set_irq_chip_and_handler(i, &bcm63xx_internal_irq_chip,
+		irq_set_chip_and_handler(i, &bcm63xx_internal_irq_chip,
 					 handle_level_irq);
 
 	for (i = IRQ_EXT_BASE; i < IRQ_EXT_BASE + 4; ++i)
-		set_irq_chip_and_handler(i, &bcm63xx_external_irq_chip,
+		irq_set_chip_and_handler(i, &bcm63xx_external_irq_chip,
 					 handle_edge_irq);
 
 	setup_irq(IRQ_MIPS_BASE + 2, &cpu_ip2_cascade_action);
Index: linux-2.6-tip/arch/mips/dec/ioasic-irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/dec/ioasic-irq.c
+++ linux-2.6-tip/arch/mips/dec/ioasic-irq.c
@@ -68,10 +68,10 @@ void __init init_ioasic_irqs(int base)
 	fast_iob();
 
 	for (i = base; i < base + IO_INR_DMA; i++)
-		set_irq_chip_and_handler(i, &ioasic_irq_type,
+		irq_set_chip_and_handler(i, &ioasic_irq_type,
 					 handle_level_irq);
 	for (; i < base + IO_IRQ_LINES; i++)
-		set_irq_chip(i, &ioasic_dma_irq_type);
+		irq_set_chip(i, &ioasic_dma_irq_type);
 
 	ioasic_irq_base = base;
 }
Index: linux-2.6-tip/arch/mips/dec/kn02-irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/dec/kn02-irq.c
+++ linux-2.6-tip/arch/mips/dec/kn02-irq.c
@@ -73,7 +73,7 @@ void __init init_kn02_irqs(int base)
 	iob();
 
 	for (i = base; i < base + KN02_IRQ_LINES; i++)
-		set_irq_chip_and_handler(i, &kn02_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &kn02_irq_type, handle_level_irq);
 
 	kn02_irq_base = base;
 }
Index: linux-2.6-tip/arch/mips/emma/markeins/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/emma/markeins/irq.c
+++ linux-2.6-tip/arch/mips/emma/markeins/irq.c
@@ -69,7 +69,7 @@ void emma2rh_irq_init(void)
 	u32 i;
 
 	for (i = 0; i < NUM_EMMA2RH_IRQ; i++)
-		set_irq_chip_and_handler_name(EMMA2RH_IRQ_BASE + i,
+		irq_set_chip_and_handler_name(EMMA2RH_IRQ_BASE + i,
 					      &emma2rh_irq_controller,
 					      handle_level_irq, "level");
 }
@@ -105,7 +105,7 @@ void emma2rh_sw_irq_init(void)
 	u32 i;
 
 	for (i = 0; i < NUM_EMMA2RH_IRQ_SW; i++)
-		set_irq_chip_and_handler_name(EMMA2RH_SW_IRQ_BASE + i,
+		irq_set_chip_and_handler_name(EMMA2RH_SW_IRQ_BASE + i,
 					      &emma2rh_sw_irq_controller,
 					      handle_level_irq, "level");
 }
@@ -162,7 +162,7 @@ void emma2rh_gpio_irq_init(void)
 	u32 i;
 
 	for (i = 0; i < NUM_EMMA2RH_IRQ_GPIO; i++)
-		set_irq_chip_and_handler_name(EMMA2RH_GPIO_IRQ_BASE + i,
+		irq_set_chip_and_handler_name(EMMA2RH_GPIO_IRQ_BASE + i,
 					      &emma2rh_gpio_irq_controller,
 					      handle_edge_irq, "edge");
 }
Index: linux-2.6-tip/arch/mips/jazz/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/jazz/irq.c
+++ linux-2.6-tip/arch/mips/jazz/irq.c
@@ -56,7 +56,7 @@ void __init init_r4030_ints(void)
 	int i;
 
 	for (i = JAZZ_IRQ_START; i <= JAZZ_IRQ_END; i++)
-		set_irq_chip_and_handler(i, &r4030_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &r4030_irq_type, handle_level_irq);
 
 	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE, 0);
 	r4030_read_reg16(JAZZ_IO_IRQ_SOURCE);		/* clear pending IRQs */
Index: linux-2.6-tip/arch/mips/jz4740/gpio.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/jz4740/gpio.c
+++ linux-2.6-tip/arch/mips/jz4740/gpio.c
@@ -306,7 +306,7 @@ static void jz_gpio_irq_demux_handler(un
 	uint32_t flag;
 	unsigned int gpio_irq;
 	unsigned int gpio_bank;
-	struct jz_gpio_chip *chip = get_irq_desc_data(desc);
+	struct jz_gpio_chip *chip = irq_desc_get_handler_data(desc);
 
 	gpio_bank = JZ4740_IRQ_GPIO0 - irq;
 
@@ -416,7 +416,7 @@ static int jz_gpio_irq_set_wake(struct i
 		chip->wakeup &= ~IRQ_TO_BIT(data->irq);
 	spin_unlock(&chip->lock);
 
-	set_irq_wake(chip->irq, on);
+	irq_set_irq_wake(chip->irq, on);
 	return 0;
 }
 
@@ -510,14 +510,14 @@ static int jz4740_gpio_chip_init(struct 
 	gpiochip_add(&chip->gpio_chip);
 
 	chip->irq = JZ4740_IRQ_INTC_GPIO(id);
-	set_irq_data(chip->irq, chip);
-	set_irq_chained_handler(chip->irq, jz_gpio_irq_demux_handler);
+	irq_set_handler_data(chip->irq, chip);
+	irq_set_chained_handler(chip->irq, jz_gpio_irq_demux_handler);
 
 	for (irq = chip->irq_base; irq < chip->irq_base + chip->gpio_chip.ngpio; ++irq) {
 		irq_set_lockdep_class(irq, &gpio_lock_class);
-		set_irq_chip_data(irq, chip);
-		set_irq_chip_and_handler(irq, &jz_gpio_irq_chip,
-			handle_level_irq);
+		irq_set_chip_data(irq, chip);
+		irq_set_chip_and_handler(irq, &jz_gpio_irq_chip,
+					 handle_level_irq);
 	}
 
 	return 0;
Index: linux-2.6-tip/arch/mips/jz4740/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/jz4740/irq.c
+++ linux-2.6-tip/arch/mips/jz4740/irq.c
@@ -104,8 +104,8 @@ void __init arch_init_irq(void)
 	writel(0xffffffff, jz_intc_base + JZ_REG_INTC_SET_MASK);
 
 	for (i = JZ4740_IRQ_BASE; i < JZ4740_IRQ_BASE + 32; i++) {
-		set_irq_chip_data(i, (void *)IRQ_BIT(i));
-		set_irq_chip_and_handler(i, &intc_irq_type, handle_level_irq);
+		irq_set_chip_data(i, (void *)IRQ_BIT(i));
+		irq_set_chip_and_handler(i, &intc_irq_type, handle_level_irq);
 	}
 
 	setup_irq(2, &jz4740_cascade_action);
Index: linux-2.6-tip/arch/mips/kernel/i8259.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/i8259.c
+++ linux-2.6-tip/arch/mips/kernel/i8259.c
@@ -110,7 +110,7 @@ int i8259A_irq_pending(unsigned int irq)
 void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	set_irq_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
 	enable_irq(irq);
 }
 
@@ -336,8 +336,8 @@ void __init init_i8259_irqs(void)
 	init_8259A(0);
 
 	for (i = I8259A_IRQ_BASE; i < I8259A_IRQ_BASE + 16; i++) {
-		set_irq_chip_and_handler(i, &i8259A_chip, handle_level_irq);
-		set_irq_probe(i);
+		irq_set_chip_and_handler(i, &i8259A_chip, handle_level_irq);
+		irq_set_probe(i);
 	}
 
 	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
Index: linux-2.6-tip/arch/mips/kernel/irq-gic.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq-gic.c
+++ linux-2.6-tip/arch/mips/kernel/irq-gic.c
@@ -229,7 +229,7 @@ static void __init gic_basic_init(int nu
 	vpe_local_setup(numvpes);
 
 	for (i = _irqbase; i < (_irqbase + numintrs); i++)
-		set_irq_chip(i, &gic_irq_controller);
+		irq_set_chip(i, &gic_irq_controller);
 }
 
 void __init gic_init(unsigned long gic_base_addr,
Index: linux-2.6-tip/arch/mips/kernel/irq-gt641xx.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq-gt641xx.c
+++ linux-2.6-tip/arch/mips/kernel/irq-gt641xx.c
@@ -126,6 +126,6 @@ void __init gt641xx_irq_init(void)
 	 * bit31: logical or of bits[25:1].
 	 */
 	for (i = 1; i < 30; i++)
-		set_irq_chip_and_handler(GT641XX_IRQ_BASE + i,
-		                         &gt641xx_irq_chip, handle_level_irq);
+		irq_set_chip_and_handler(GT641XX_IRQ_BASE + i,
+					 &gt641xx_irq_chip, handle_level_irq);
 }
Index: linux-2.6-tip/arch/mips/kernel/irq-msc01.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq-msc01.c
+++ linux-2.6-tip/arch/mips/kernel/irq-msc01.c
@@ -137,16 +137,20 @@ void __init init_msc_irqs(unsigned long 
 
 		switch (imp->im_type) {
 		case MSC01_IRQ_EDGE:
-			set_irq_chip_and_handler_name(irqbase + n,
-				&msc_edgeirq_type, handle_edge_irq, "edge");
+			irq_set_chip_and_handler_name(irqbase + n,
+						      &msc_edgeirq_type,
+						      handle_edge_irq,
+						      "edge");
 			if (cpu_has_veic)
 				MSCIC_WRITE(MSC01_IC_SUP+n*8, MSC01_IC_SUP_EDGE_BIT);
 			else
 				MSCIC_WRITE(MSC01_IC_SUP+n*8, MSC01_IC_SUP_EDGE_BIT | imp->im_lvl);
 			break;
 		case MSC01_IRQ_LEVEL:
-			set_irq_chip_and_handler_name(irqbase+n,
-				&msc_levelirq_type, handle_level_irq, "level");
+			irq_set_chip_and_handler_name(irqbase + n,
+						      &msc_levelirq_type,
+						      handle_level_irq,
+						      "level");
 			if (cpu_has_veic)
 				MSCIC_WRITE(MSC01_IC_SUP+n*8, 0);
 			else
Index: linux-2.6-tip/arch/mips/kernel/irq-rm7000.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq-rm7000.c
+++ linux-2.6-tip/arch/mips/kernel/irq-rm7000.c
@@ -45,6 +45,6 @@ void __init rm7k_cpu_irq_init(void)
 	clear_c0_intcontrol(0x00000f00);		/* Mask all */
 
 	for (i = base; i < base + 4; i++)
-		set_irq_chip_and_handler(i, &rm7k_irq_controller,
+		irq_set_chip_and_handler(i, &rm7k_irq_controller,
 					 handle_percpu_irq);
 }
Index: linux-2.6-tip/arch/mips/kernel/irq-rm9000.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq-rm9000.c
+++ linux-2.6-tip/arch/mips/kernel/irq-rm9000.c
@@ -98,10 +98,10 @@ void __init rm9k_cpu_irq_init(void)
 	clear_c0_intcontrol(0x0000f000);		/* Mask all */
 
 	for (i = base; i < base + 4; i++)
-		set_irq_chip_and_handler(i, &rm9k_irq_controller,
+		irq_set_chip_and_handler(i, &rm9k_irq_controller,
 					 handle_level_irq);
 
 	rm9000_perfcount_irq = base + 1;
-	set_irq_chip_and_handler(rm9000_perfcount_irq, &rm9k_perfcounter_irq,
+	irq_set_chip_and_handler(rm9000_perfcount_irq, &rm9k_perfcounter_irq,
 				 handle_percpu_irq);
 }
Index: linux-2.6-tip/arch/mips/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq.c
+++ linux-2.6-tip/arch/mips/kernel/irq.c
@@ -102,7 +102,7 @@ void __init init_IRQ(void)
 #endif
 
 	for (i = 0; i < NR_IRQS; i++)
-		set_irq_noprobe(i);
+		irq_set_noprobe(i);
 
 	arch_init_irq();
 
Index: linux-2.6-tip/arch/mips/kernel/irq_cpu.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq_cpu.c
+++ linux-2.6-tip/arch/mips/kernel/irq_cpu.c
@@ -109,10 +109,10 @@ void __init mips_cpu_irq_init(void)
 	 */
 	if (cpu_has_mipsmt)
 		for (i = irq_base; i < irq_base + 2; i++)
-			set_irq_chip_and_handler(i, &mips_mt_cpu_irq_controller,
+			irq_set_chip_and_handler(i, &mips_mt_cpu_irq_controller,
 						 handle_percpu_irq);
 
 	for (i = irq_base + 2; i < irq_base + 8; i++)
-		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
+		irq_set_chip_and_handler(i, &mips_cpu_irq_controller,
 					 handle_percpu_irq);
 }
Index: linux-2.6-tip/arch/mips/kernel/irq_txx9.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/irq_txx9.c
+++ linux-2.6-tip/arch/mips/kernel/irq_txx9.c
@@ -154,8 +154,8 @@ void __init txx9_irq_init(unsigned long 
 	for (i = 0; i < TXx9_MAX_IR; i++) {
 		txx9irq[i].level = 4; /* middle level */
 		txx9irq[i].mode = TXx9_IRCR_LOW;
-		set_irq_chip_and_handler(TXX9_IRQ_BASE + i,
-					 &txx9_irq_chip, handle_level_irq);
+		irq_set_chip_and_handler(TXX9_IRQ_BASE + i, &txx9_irq_chip,
+					 handle_level_irq);
 	}
 
 	/* mask all IRC interrupts */
Index: linux-2.6-tip/arch/mips/kernel/smtc.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/kernel/smtc.c
+++ linux-2.6-tip/arch/mips/kernel/smtc.c
@@ -1146,7 +1146,7 @@ static void setup_cross_vpe_interrupts(u
 
 	setup_irq_smtc(cpu_ipi_irq, &irq_ipi, (0x100 << MIPS_CPU_IPI_IRQ));
 
-	set_irq_handler(cpu_ipi_irq, handle_percpu_irq);
+	irq_set_handler(cpu_ipi_irq, handle_percpu_irq);
 }
 
 /*
Index: linux-2.6-tip/arch/mips/lasat/interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/lasat/interrupt.c
+++ linux-2.6-tip/arch/mips/lasat/interrupt.c
@@ -128,7 +128,7 @@ void __init arch_init_irq(void)
 	mips_cpu_irq_init();
 
 	for (i = LASAT_IRQ_BASE; i <= LASAT_IRQ_END; i++)
-		set_irq_chip_and_handler(i, &lasat_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &lasat_irq_type, handle_level_irq);
 
 	setup_irq(LASAT_CASCADE_IRQ, &cascade);
 }
Index: linux-2.6-tip/arch/mips/loongson/common/bonito-irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/loongson/common/bonito-irq.c
+++ linux-2.6-tip/arch/mips/loongson/common/bonito-irq.c
@@ -44,7 +44,8 @@ void bonito_irq_init(void)
 	u32 i;
 
 	for (i = LOONGSON_IRQ_BASE; i < LOONGSON_IRQ_BASE + 32; i++)
-		set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &bonito_irq_type,
+					 handle_level_irq);
 
 #ifdef CONFIG_CPU_LOONGSON2E
 	setup_irq(LOONGSON_IRQ_BASE + 10, &dma_timeout_irqaction);
Index: linux-2.6-tip/arch/mips/mti-malta/malta-int.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/mti-malta/malta-int.c
+++ linux-2.6-tip/arch/mips/mti-malta/malta-int.c
@@ -472,7 +472,7 @@ static void __init fill_ipi_map(void)
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
 {
 	setup_irq(irq, action);
-	set_irq_handler(irq, handle_percpu_irq);
+	irq_set_handler(irq, handle_percpu_irq);
 }
 
 void __init arch_init_irq(void)
Index: linux-2.6-tip/arch/mips/mti-malta/malta-time.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/mti-malta/malta-time.c
+++ linux-2.6-tip/arch/mips/mti-malta/malta-time.c
@@ -119,7 +119,7 @@ static void __init plat_perf_setup(void)
 			set_vi_handler(cp0_perfcount_irq, mips_perf_dispatch);
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 #ifdef CONFIG_SMP
-		set_irq_handler(mips_cpu_perf_irq, handle_percpu_irq);
+		irq_set_handler(mips_cpu_perf_irq, handle_percpu_irq);
 #endif
 	}
 }
Index: linux-2.6-tip/arch/mips/pci/msi-octeon.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/pci/msi-octeon.c
+++ linux-2.6-tip/arch/mips/pci/msi-octeon.c
@@ -172,7 +172,7 @@ msi_irq_allocated:
 	pci_write_config_word(dev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
 			      control);
 
-	set_irq_msi(irq, desc);
+	irq_set_msi_desc(irq, desc);
 	write_msi_msg(irq, &msg);
 	return 0;
 }
@@ -388,7 +388,7 @@ int __init octeon_msi_initialize(void)
 	}
 
 	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_LAST; irq++)
-		set_irq_chip_and_handler(irq, msi, handle_simple_irq);
+		irq_set_chip_and_handler(irq, msi, handle_simple_irq);
 
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE)) {
 		if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
Index: linux-2.6-tip/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
+++ linux-2.6-tip/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
@@ -182,7 +182,7 @@ void __init msp_cic_irq_init(void)
 
 	/* initialize all the IRQ descriptors */
 	for (i = MSP_CIC_INTBASE ; i < MSP_CIC_INTBASE + 32 ; i++) {
-		set_irq_chip_and_handler(i, &msp_cic_irq_controller,
+		irq_set_chip_and_handler(i, &msp_cic_irq_controller,
 					 handle_level_irq);
 #ifdef CONFIG_MIPS_MT_SMTC
 		/* Mask of CIC interrupt */
Index: linux-2.6-tip/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
+++ linux-2.6-tip/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
@@ -77,7 +77,7 @@ void __init msp_slp_irq_init(void)
 
 	/* initialize all the IRQ descriptors */
 	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++)
-		set_irq_chip_and_handler(i, &msp_slp_irq_controller,
+		irq_set_chip_and_handler(i, &msp_slp_irq_controller,
 					 handle_level_irq);
 }
 
Index: linux-2.6-tip/arch/mips/pmc-sierra/msp71xx/msp_smp.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/pmc-sierra/msp71xx/msp_smp.c
+++ linux-2.6-tip/arch/mips/pmc-sierra/msp71xx/msp_smp.c
@@ -64,7 +64,7 @@ static struct irqaction irq_call = {
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
 {
 	setup_irq(irq, action);
-	set_irq_handler(irq, handle_percpu_irq);
+	irq_set_handler(irq, handle_percpu_irq);
 }
 
 void __init msp_vsmp_int_init(void)
Index: linux-2.6-tip/arch/mips/pnx833x/common/interrupts.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/pnx833x/common/interrupts.c
+++ linux-2.6-tip/arch/mips/pnx833x/common/interrupts.c
@@ -259,11 +259,13 @@ void __init arch_init_irq(void)
 	/* Set IRQ information in irq_desc */
 	for (irq = PNX833X_PIC_IRQ_BASE; irq < (PNX833X_PIC_IRQ_BASE + PNX833X_PIC_NUM_IRQ); irq++) {
 		pnx833x_hard_disable_pic_irq(irq);
-		set_irq_chip_and_handler(irq, &pnx833x_pic_irq_type, handle_simple_irq);
+		irq_set_chip_and_handler(irq, &pnx833x_pic_irq_type,
+					 handle_simple_irq);
 	}
 
 	for (irq = PNX833X_GPIO_IRQ_BASE; irq < (PNX833X_GPIO_IRQ_BASE + PNX833X_GPIO_NUM_IRQ); irq++)
-		set_irq_chip_and_handler(irq, &pnx833x_gpio_irq_type, handle_simple_irq);
+		irq_set_chip_and_handler(irq, &pnx833x_gpio_irq_type,
+					 handle_simple_irq);
 
 	/* Set PIC priority limiter register to 0 */
 	PNX833X_PIC_INT_PRIORITY = 0;
Index: linux-2.6-tip/arch/mips/pnx8550/common/int.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/pnx8550/common/int.c
+++ linux-2.6-tip/arch/mips/pnx8550/common/int.c
@@ -183,7 +183,7 @@ void __init arch_init_irq(void)
 	int configPR;
 
 	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++)
-		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &level_irq_type, handle_level_irq);
 
 	/* init of GIC/IPC interrupts */
 	/* should be done before cp0 since cp0 init enables the GIC int */
@@ -206,7 +206,7 @@ void __init arch_init_irq(void)
 		/* mask/priority is still 0 so we will not get any
 		 * interrupts until it is unmasked */
 
-		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &level_irq_type, handle_level_irq);
 	}
 
 	/* Priority level 0 */
@@ -215,20 +215,20 @@ void __init arch_init_irq(void)
 	/* Set int vector table address */
 	PNX8550_GIC_VECTOR_0 = PNX8550_GIC_VECTOR_1 = 0;
 
-	set_irq_chip_and_handler(MIPS_CPU_GIC_IRQ, &level_irq_type,
+	irq_set_chip_and_handler(MIPS_CPU_GIC_IRQ, &level_irq_type,
 				 handle_level_irq);
 	setup_irq(MIPS_CPU_GIC_IRQ, &gic_action);
 
 	/* init of Timer interrupts */
 	for (i = PNX8550_INT_TIMER_MIN; i <= PNX8550_INT_TIMER_MAX; i++)
-		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &level_irq_type, handle_level_irq);
 
 	/* Stop Timer 1-3 */
 	configPR = read_c0_config7();
 	configPR |= 0x00000038;
 	write_c0_config7(configPR);
 
-	set_irq_chip_and_handler(MIPS_CPU_TIMER_IRQ, &level_irq_type,
+	irq_set_chip_and_handler(MIPS_CPU_TIMER_IRQ, &level_irq_type,
 				 handle_level_irq);
 	setup_irq(MIPS_CPU_TIMER_IRQ, &timer_action);
 }
Index: linux-2.6-tip/arch/mips/powertv/asic/irq_asic.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/powertv/asic/irq_asic.c
+++ linux-2.6-tip/arch/mips/powertv/asic/irq_asic.c
@@ -112,5 +112,5 @@ void __init asic_irq_init(void)
 	 * Initialize interrupt handlers.
 	 */
 	for (i = 0; i < NR_IRQS; i++)
-		set_irq_chip_and_handler(i, &asic_irq_chip, handle_level_irq);
+		irq_set_chip_and_handler(i, &asic_irq_chip, handle_level_irq);
 }
Index: linux-2.6-tip/arch/mips/rb532/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/rb532/irq.c
+++ linux-2.6-tip/arch/mips/rb532/irq.c
@@ -207,8 +207,8 @@ void __init arch_init_irq(void)
 	pr_info("Initializing IRQ's: %d out of %d\n", RC32434_NR_IRQS, NR_IRQS);
 
 	for (i = 0; i < RC32434_NR_IRQS; i++)
-		set_irq_chip_and_handler(i,  &rc32434_irq_type,
-					handle_level_irq);
+		irq_set_chip_and_handler(i, &rc32434_irq_type,
+					 handle_level_irq);
 }
 
 /* Main Interrupt dispatcher */
Index: linux-2.6-tip/arch/mips/sgi-ip22/ip22-int.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sgi-ip22/ip22-int.c
+++ linux-2.6-tip/arch/mips/sgi-ip22/ip22-int.c
@@ -312,7 +312,7 @@ void __init arch_init_irq(void)
 		else
 			handler		= &ip22_local3_irq_type;
 
-		set_irq_chip_and_handler(i, handler, handle_level_irq);
+		irq_set_chip_and_handler(i, handler, handle_level_irq);
 	}
 
 	/* vector handler. this register the IRQ as non-sharable */
Index: linux-2.6-tip/arch/mips/sgi-ip27/ip27-irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sgi-ip27/ip27-irq.c
+++ linux-2.6-tip/arch/mips/sgi-ip27/ip27-irq.c
@@ -337,7 +337,7 @@ static struct irq_chip bridge_irq_type =
 
 void __devinit register_bridge_irq(unsigned int irq)
 {
-	set_irq_chip_and_handler(irq, &bridge_irq_type, handle_level_irq);
+	irq_set_chip_and_handler(irq, &bridge_irq_type, handle_level_irq);
 }
 
 int __devinit request_bridge_irq(struct bridge_controller *bc)
Index: linux-2.6-tip/arch/mips/sgi-ip27/ip27-timer.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sgi-ip27/ip27-timer.c
+++ linux-2.6-tip/arch/mips/sgi-ip27/ip27-timer.c
@@ -153,7 +153,7 @@ static void __init hub_rt_clock_event_gl
 			panic("Allocation of irq number for timer failed");
 	} while (xchg(&rt_timer_irq, irq));
 
-	set_irq_chip_and_handler(irq, &rt_irq_type, handle_percpu_irq);
+	irq_set_chip_and_handler(irq, &rt_irq_type, handle_percpu_irq);
 	setup_irq(irq, &hub_rt_irqaction);
 }
 
Index: linux-2.6-tip/arch/mips/sgi-ip32/ip32-irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sgi-ip32/ip32-irq.c
+++ linux-2.6-tip/arch/mips/sgi-ip32/ip32-irq.c
@@ -451,43 +451,51 @@ void __init arch_init_irq(void)
 	for (irq = CRIME_IRQ_BASE; irq <= IP32_IRQ_MAX; irq++) {
 		switch (irq) {
 		case MACE_VID_IN1_IRQ ... MACE_PCI_BRIDGE_IRQ:
-			set_irq_chip_and_handler_name(irq,&ip32_mace_interrupt,
-				handle_level_irq, "level");
+			irq_set_chip_and_handler_name(irq,
+						      &ip32_mace_interrupt,
+						      handle_level_irq,
+						      "level");
 			break;
 
 		case MACEPCI_SCSI0_IRQ ...  MACEPCI_SHARED2_IRQ:
-			set_irq_chip_and_handler_name(irq,
-				&ip32_macepci_interrupt, handle_level_irq,
-				"level");
+			irq_set_chip_and_handler_name(irq,
+						      &ip32_macepci_interrupt,
+						      handle_level_irq,
+						      "level");
 			break;
 
 		case CRIME_CPUERR_IRQ:
 		case CRIME_MEMERR_IRQ:
-			set_irq_chip_and_handler_name(irq,
-				&crime_level_interrupt, handle_level_irq,
-				"level");
+			irq_set_chip_and_handler_name(irq,
+						      &crime_level_interrupt,
+						      handle_level_irq,
+						      "level");
 			break;
 
 		case CRIME_GBE0_IRQ ... CRIME_GBE3_IRQ:
 		case CRIME_RE_EMPTY_E_IRQ ... CRIME_RE_IDLE_E_IRQ:
 		case CRIME_SOFT0_IRQ ... CRIME_SOFT2_IRQ:
 		case CRIME_VICE_IRQ:
-			set_irq_chip_and_handler_name(irq,
-				&crime_edge_interrupt, handle_edge_irq, "edge");
+			irq_set_chip_and_handler_name(irq,
+						      &crime_edge_interrupt,
+						      handle_edge_irq,
+						      "edge");
 			break;
 
 		case MACEISA_PARALLEL_IRQ:
 		case MACEISA_SERIAL1_TDMAPR_IRQ:
 		case MACEISA_SERIAL2_TDMAPR_IRQ:
-			set_irq_chip_and_handler_name(irq,
-				&ip32_maceisa_edge_interrupt, handle_edge_irq,
-				"edge");
+			irq_set_chip_and_handler_name(irq,
+						      &ip32_maceisa_edge_interrupt,
+						      handle_edge_irq,
+						      "edge");
 			break;
 
 		default:
-			set_irq_chip_and_handler_name(irq,
-				&ip32_maceisa_level_interrupt, handle_level_irq,
-				"level");
+			irq_set_chip_and_handler_name(irq,
+						      &ip32_maceisa_level_interrupt,
+						      handle_level_irq,
+						      "level");
 			break;
 		}
 	}
Index: linux-2.6-tip/arch/mips/sibyte/bcm1480/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sibyte/bcm1480/irq.c
+++ linux-2.6-tip/arch/mips/sibyte/bcm1480/irq.c
@@ -216,7 +216,8 @@ void __init init_bcm1480_irqs(void)
 	int i;
 
 	for (i = 0; i < BCM1480_NR_IRQS; i++) {
-		set_irq_chip_and_handler(i, &bcm1480_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &bcm1480_irq_type,
+					 handle_level_irq);
 		bcm1480_irq_owner[i] = 0;
 	}
 }
Index: linux-2.6-tip/arch/mips/sibyte/sb1250/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sibyte/sb1250/irq.c
+++ linux-2.6-tip/arch/mips/sibyte/sb1250/irq.c
@@ -190,7 +190,8 @@ void __init init_sb1250_irqs(void)
 	int i;
 
 	for (i = 0; i < SB1250_NR_IRQS; i++) {
-		set_irq_chip_and_handler(i, &sb1250_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &sb1250_irq_type,
+					 handle_level_irq);
 		sb1250_irq_owner[i] = 0;
 	}
 }
Index: linux-2.6-tip/arch/mips/sni/a20r.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sni/a20r.c
+++ linux-2.6-tip/arch/mips/sni/a20r.c
@@ -209,7 +209,7 @@ void __init sni_a20r_irq_init(void)
 	int i;
 
 	for (i = SNI_A20R_IRQ_BASE + 2 ; i < SNI_A20R_IRQ_BASE + 8; i++)
-		set_irq_chip_and_handler(i, &a20r_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &a20r_irq_type, handle_level_irq);
 	sni_hwint = a20r_hwint;
 	change_c0_status(ST0_IM, IE_IRQ0);
 	setup_irq(SNI_A20R_IRQ_BASE + 3, &sni_isa_irq);
Index: linux-2.6-tip/arch/mips/sni/pcimt.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sni/pcimt.c
+++ linux-2.6-tip/arch/mips/sni/pcimt.c
@@ -296,7 +296,7 @@ void __init sni_pcimt_irq_init(void)
 	mips_cpu_irq_init();
 	/* Actually we've got more interrupts to handle ...  */
 	for (i = PCIMT_IRQ_INT2; i <= PCIMT_IRQ_SCSI; i++)
-		set_irq_chip_and_handler(i, &pcimt_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &pcimt_irq_type, handle_level_irq);
 	sni_hwint = sni_pcimt_hwint;
 	change_c0_status(ST0_IM, IE_IRQ1|IE_IRQ3);
 }
Index: linux-2.6-tip/arch/mips/sni/pcit.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sni/pcit.c
+++ linux-2.6-tip/arch/mips/sni/pcit.c
@@ -238,7 +238,7 @@ void __init sni_pcit_irq_init(void)
 
 	mips_cpu_irq_init();
 	for (i = SNI_PCIT_INT_START; i <= SNI_PCIT_INT_END; i++)
-		set_irq_chip_and_handler(i, &pcit_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &pcit_irq_type, handle_level_irq);
 	*(volatile u32 *)SNI_PCIT_INT_REG = 0;
 	sni_hwint = sni_pcit_hwint;
 	change_c0_status(ST0_IM, IE_IRQ1);
@@ -251,7 +251,7 @@ void __init sni_pcit_cplus_irq_init(void
 
 	mips_cpu_irq_init();
 	for (i = SNI_PCIT_INT_START; i <= SNI_PCIT_INT_END; i++)
-		set_irq_chip_and_handler(i, &pcit_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &pcit_irq_type, handle_level_irq);
 	*(volatile u32 *)SNI_PCIT_INT_REG = 0x40000000;
 	sni_hwint = sni_pcit_hwint_cplus;
 	change_c0_status(ST0_IM, IE_IRQ0);
Index: linux-2.6-tip/arch/mips/sni/rm200.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/sni/rm200.c
+++ linux-2.6-tip/arch/mips/sni/rm200.c
@@ -413,7 +413,7 @@ void __init sni_rm200_i8259_irqs(void)
 	sni_rm200_init_8259A();
 
 	for (i = RM200_I8259A_IRQ_BASE; i < RM200_I8259A_IRQ_BASE + 16; i++)
-		set_irq_chip_and_handler(i, &sni_rm200_i8259A_chip,
+		irq_set_chip_and_handler(i, &sni_rm200_i8259A_chip,
 					 handle_level_irq);
 
 	setup_irq(RM200_I8259A_IRQ_BASE + PIC_CASCADE_IR, &sni_rm200_irq2);
@@ -477,7 +477,7 @@ void __init sni_rm200_irq_init(void)
 	mips_cpu_irq_init();
 	/* Actually we've got more interrupts to handle ...  */
 	for (i = SNI_RM200_INT_START; i <= SNI_RM200_INT_END; i++)
-		set_irq_chip_and_handler(i, &rm200_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &rm200_irq_type, handle_level_irq);
 	sni_hwint = sni_rm200_hwint;
 	change_c0_status(ST0_IM, IE_IRQ0);
 	setup_irq(SNI_RM200_INT_START + 0, &sni_rm200_i8259A_irq);
Index: linux-2.6-tip/arch/mips/txx9/generic/irq_tx4927.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/generic/irq_tx4927.c
+++ linux-2.6-tip/arch/mips/txx9/generic/irq_tx4927.c
@@ -35,7 +35,7 @@ void __init tx4927_irq_init(void)
 
 	mips_cpu_irq_init();
 	txx9_irq_init(TX4927_IRC_REG & 0xfffffffffULL);
-	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4927_IRC_INT,
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + TX4927_IRC_INT,
 				handle_simple_irq);
 	/* raise priority for errors, timers, SIO */
 	txx9_irq_set_pri(TX4927_IR_ECCERR, 7);
Index: linux-2.6-tip/arch/mips/txx9/generic/irq_tx4938.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/generic/irq_tx4938.c
+++ linux-2.6-tip/arch/mips/txx9/generic/irq_tx4938.c
@@ -23,7 +23,7 @@ void __init tx4938_irq_init(void)
 
 	mips_cpu_irq_init();
 	txx9_irq_init(TX4938_IRC_REG & 0xfffffffffULL);
-	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4938_IRC_INT,
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + TX4938_IRC_INT,
 				handle_simple_irq);
 	/* raise priority for errors, timers, SIO */
 	txx9_irq_set_pri(TX4938_IR_ECCERR, 7);
Index: linux-2.6-tip/arch/mips/txx9/generic/irq_tx4939.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/generic/irq_tx4939.c
+++ linux-2.6-tip/arch/mips/txx9/generic/irq_tx4939.c
@@ -176,8 +176,8 @@ void __init tx4939_irq_init(void)
 	for (i = 1; i < TX4939_NUM_IR; i++) {
 		tx4939irq[i].level = 4; /* middle level */
 		tx4939irq[i].mode = TXx9_IRCR_LOW;
-		set_irq_chip_and_handler(TXX9_IRQ_BASE + i,
-					 &tx4939_irq_chip, handle_level_irq);
+		irq_set_chip_and_handler(TXX9_IRQ_BASE + i, &tx4939_irq_chip,
+					 handle_level_irq);
 	}
 
 	/* mask all IRC interrupts */
@@ -193,7 +193,7 @@ void __init tx4939_irq_init(void)
 	__raw_writel(TXx9_IRCER_ICE, &tx4939_ircptr->den.r);
 	__raw_writel(irc_elevel, &tx4939_ircptr->msk.r);
 
-	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4939_IRC_INT,
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + TX4939_IRC_INT,
 				handle_simple_irq);
 
 	/* raise priority for errors, timers, sio */
Index: linux-2.6-tip/arch/mips/txx9/jmr3927/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/jmr3927/irq.c
+++ linux-2.6-tip/arch/mips/txx9/jmr3927/irq.c
@@ -120,8 +120,9 @@ void __init jmr3927_irq_setup(void)
 
 	tx3927_irq_init();
 	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
+		irq_set_chip_and_handler(i, &jmr3927_irq_ioc,
+					 handle_level_irq);
 
 	/* setup IOC interrupt 1 (PCI, MODEM) */
-	set_irq_chained_handler(JMR3927_IRQ_IOCINT, handle_simple_irq);
+	irq_set_chained_handler(JMR3927_IRQ_IOCINT, handle_simple_irq);
 }
Index: linux-2.6-tip/arch/mips/txx9/rbtx4927/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/rbtx4927/irq.c
+++ linux-2.6-tip/arch/mips/txx9/rbtx4927/irq.c
@@ -164,9 +164,9 @@ static void __init toshiba_rbtx4927_irq_
 
 	for (i = RBTX4927_IRQ_IOC;
 	     i < RBTX4927_IRQ_IOC + RBTX4927_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
+		irq_set_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
 					 handle_level_irq);
-	set_irq_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);
+	irq_set_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);
 }
 
 static int rbtx4927_irq_dispatch(int pending)
@@ -194,5 +194,5 @@ void __init rbtx4927_irq_setup(void)
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
 	/* Onboard 10M Ether: High Active */
-	set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
 }
Index: linux-2.6-tip/arch/mips/txx9/rbtx4938/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/rbtx4938/irq.c
+++ linux-2.6-tip/arch/mips/txx9/rbtx4938/irq.c
@@ -132,10 +132,10 @@ static void __init toshiba_rbtx4938_irq_
 
 	for (i = RBTX4938_IRQ_IOC;
 	     i < RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
+		irq_set_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
 					 handle_level_irq);
 
-	set_irq_chained_handler(RBTX4938_IRQ_IOCINT, handle_simple_irq);
+	irq_set_chained_handler(RBTX4938_IRQ_IOCINT, handle_simple_irq);
 }
 
 void __init rbtx4938_irq_setup(void)
@@ -153,5 +153,5 @@ void __init rbtx4938_irq_setup(void)
 	tx4938_irq_init();
 	toshiba_rbtx4938_irq_ioc_init();
 	/* Onboard 10M Ether: High Active */
-	set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
 }
Index: linux-2.6-tip/arch/mips/txx9/rbtx4939/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/txx9/rbtx4939/irq.c
+++ linux-2.6-tip/arch/mips/txx9/rbtx4939/irq.c
@@ -88,8 +88,8 @@ void __init rbtx4939_irq_setup(void)
 	tx4939_irq_init();
 	for (i = RBTX4939_IRQ_IOC;
 	     i < RBTX4939_IRQ_IOC + RBTX4939_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &rbtx4939_ioc_irq_chip,
+		irq_set_chip_and_handler(i, &rbtx4939_ioc_irq_chip,
 					 handle_level_irq);
 
-	set_irq_chained_handler(RBTX4939_IRQ_IOCINT, handle_simple_irq);
+	irq_set_chained_handler(RBTX4939_IRQ_IOCINT, handle_simple_irq);
 }
Index: linux-2.6-tip/arch/mips/vr41xx/common/icu.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/vr41xx/common/icu.c
+++ linux-2.6-tip/arch/mips/vr41xx/common/icu.c
@@ -710,11 +710,11 @@ static int __init vr41xx_icu_init(void)
 	icu2_write(MGIUINTHREG, 0xffff);
 
 	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
-		set_irq_chip_and_handler(i, &sysint1_irq_type,
+		irq_set_chip_and_handler(i, &sysint1_irq_type,
 					 handle_level_irq);
 
 	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
-		set_irq_chip_and_handler(i, &sysint2_irq_type,
+		irq_set_chip_and_handler(i, &sysint2_irq_type,
 					 handle_level_irq);
 
 	cascade_irq(INT0_IRQ, icu_get_irq);
