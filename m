Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 21:00:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45537 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039106AbWKMQKw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2006 16:10:52 +0000
Received: from localhost (p3040-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EB736AE71; Tue, 14 Nov 2006 01:10:40 +0900 (JST)
Date:	Tue, 14 Nov 2006 01:13:18 +0900 (JST)
Message-Id: <20061114.011318.99611303.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use generic_handle_irq, handle_level_irq, handle_percpu_irq
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Note: This patch can be applied after the patch titled:
"[PATCH] mips irq cleanups"
in lmo linux-queue tree (or 2.6.19-rc5-mm1) and the patch titled:
"[PATCH] do_IRQ cleanup"
(http://www.linux-mips.org/archives/linux-mips/2006-10/msg00348.html)


Further incorporation of generic irq framework.  Replacing __do_IRQ()
by proper flow handler would make the irq handling path a bit simpler
and faster.

* use generic_handle_irq() instead of __do_IRQ().
* use handle_level_irq for obvious level-type irq chips.
* use handle_percpu_irq for irqs marked as IRQ_PER_CPU.
* setup .eoi routine for irq chips possibly used with handle_percpu_irq.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/dec/ioasic-irq.c                               |    6 ++++--
 arch/mips/dec/kn02-irq.c                                 |    2 +-
 arch/mips/emma2rh/common/irq_emma2rh.c                   |    3 ++-
 arch/mips/emma2rh/markeins/irq_markeins.c                |    3 ++-
 arch/mips/jazz/irq.c                                     |    2 +-
 arch/mips/kernel/irq-msc01.c                             |    2 ++
 arch/mips/kernel/irq-mv6434x.c                           |    3 ++-
 arch/mips/kernel/irq-rm7000.c                            |    3 ++-
 arch/mips/kernel/irq-rm9000.c                            |    6 ++++--
 arch/mips/kernel/irq_cpu.c                               |    5 ++++-
 arch/mips/kernel/smp-mt.c                                |    2 ++
 arch/mips/kernel/smtc.c                                  |    1 +
 arch/mips/lasat/interrupt.c                              |    2 +-
 arch/mips/mips-boards/atlas/atlas_int.c                  |    3 ++-
 arch/mips/mips-boards/generic/time.c                     |    3 ++-
 arch/mips/mips-boards/sim/sim_time.c                     |    3 ++-
 arch/mips/momentum/ocelot_c/cpci-irq.c                   |    2 +-
 arch/mips/momentum/ocelot_c/uart-irq.c                   |    4 ++--
 arch/mips/philips/pnx8550/common/int.c                   |   12 +++++++-----
 arch/mips/sgi-ip22/ip22-int.c                            |    2 +-
 arch/mips/sgi-ip27/ip27-irq.c                            |    2 +-
 arch/mips/sgi-ip27/ip27-timer.c                          |    3 ++-
 arch/mips/tx4927/common/tx4927_irq.c                     |    6 ++++--
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |    3 ++-
 arch/mips/tx4938/common/irq.c                            |    6 ++++--
 arch/mips/tx4938/toshiba_rbtx4938/irq.c                  |    3 ++-
 arch/mips/vr41xx/common/icu.c                            |    6 ++++--
 include/asm-mips/irq.h                                   |    2 +-
 28 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
index d0af08b..269b22b 100644
--- a/arch/mips/dec/ioasic-irq.c
+++ b/arch/mips/dec/ioasic-irq.c
@@ -103,9 +103,11 @@ void __init init_ioasic_irqs(int base)
 	fast_iob();
 
 	for (i = base; i < base + IO_INR_DMA; i++)
-		set_irq_chip(i, &ioasic_irq_type);
+		set_irq_chip_and_handler(i, &ioasic_irq_type,
+					 handle_level_irq);
 	for (; i < base + IO_IRQ_LINES; i++)
-		set_irq_chip(i, &ioasic_dma_irq_type);
+		set_irq_chip_and_handler(i, &ioasic_dma_irq_type,
+					 handle_level_irq);
 
 	ioasic_irq_base = base;
 }
diff --git a/arch/mips/dec/kn02-irq.c b/arch/mips/dec/kn02-irq.c
index c761d97..5a9be4c 100644
--- a/arch/mips/dec/kn02-irq.c
+++ b/arch/mips/dec/kn02-irq.c
@@ -85,7 +85,7 @@ void __init init_kn02_irqs(int base)
 	iob();
 
 	for (i = base; i < base + KN02_IRQ_LINES; i++)
-		set_irq_chip(i, &kn02_irq_type);
+		set_irq_chip_and_handler(i, &kn02_irq_type, handle_level_irq);
 
 	kn02_irq_base = base;
 }
diff --git a/arch/mips/emma2rh/common/irq_emma2rh.c b/arch/mips/emma2rh/common/irq_emma2rh.c
index bf1b83b..59b9829 100644
--- a/arch/mips/emma2rh/common/irq_emma2rh.c
+++ b/arch/mips/emma2rh/common/irq_emma2rh.c
@@ -76,7 +76,8 @@ void emma2rh_irq_init(u32 irq_base)
 	u32 i;
 
 	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ; i++)
-		set_irq_chip(i, &emma2rh_irq_controller);
+		set_irq_chip_and_handler(i, &emma2rh_irq_controller,
+					 handle_level_irq);
 
 	emma2rh_irq_base = irq_base;
 }
diff --git a/arch/mips/emma2rh/markeins/irq_markeins.c b/arch/mips/emma2rh/markeins/irq_markeins.c
index 8e5f08a..3ac4e40 100644
--- a/arch/mips/emma2rh/markeins/irq_markeins.c
+++ b/arch/mips/emma2rh/markeins/irq_markeins.c
@@ -68,7 +68,8 @@ void emma2rh_sw_irq_init(u32 irq_base)
 	u32 i;
 
 	for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_SW; i++)
-		set_irq_chip(i, &emma2rh_sw_irq_controller);
+		set_irq_chip_and_handler(i, &emma2rh_sw_irq_controller,
+					 handle_level_irq);
 
 	emma2rh_sw_irq_base = irq_base;
 }
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 4bbb6cb..5c4f50c 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -59,7 +59,7 @@ void __init init_r4030_ints(void)
 	int i;
 
 	for (i = JAZZ_PARALLEL_IRQ; i <= JAZZ_TIMER_IRQ; i++)
-		set_irq_chip(i, &r4030_irq_type);
+		set_irq_chip_and_handler(i, &r4030_irq_type, handle_level_irq);
 
 	r4030_write_reg16(JAZZ_IO_IRQ_ENABLE, 0);
 	r4030_read_reg16(JAZZ_IO_IRQ_SOURCE);		/* clear pending IRQs */
diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index e1880b2..bcaad66 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -117,6 +117,7 @@ struct irq_chip msc_levelirq_type = {
 	.mask = mask_msc_irq,
 	.mask_ack = level_mask_and_ack_msc_irq,
 	.unmask = unmask_msc_irq,
+	.eoi = unmask_msc_irq,
 	.end = end_msc_irq,
 };
 
@@ -126,6 +127,7 @@ struct irq_chip msc_edgeirq_type = {
 	.mask = mask_msc_irq,
 	.mask_ack = edge_mask_and_ack_msc_irq,
 	.unmask = unmask_msc_irq,
+	.eoi = unmask_msc_irq,
 	.end = end_msc_irq,
 };
 
diff --git a/arch/mips/kernel/irq-mv6434x.c b/arch/mips/kernel/irq-mv6434x.c
index 5012b9d..6cfb31c 100644
--- a/arch/mips/kernel/irq-mv6434x.c
+++ b/arch/mips/kernel/irq-mv6434x.c
@@ -114,7 +114,8 @@ void __init mv64340_irq_init(unsigned in
 	int i;
 
 	for (i = base; i < base + 64; i++)
-		set_irq_chip(i, &mv64340_irq_type);
+		set_irq_chip_and_handler(i, &mv64340_irq_type,
+					 handle_level_irq);
 
 	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index 6a297e3..ddcc2a5 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -51,7 +51,8 @@ void __init rm7k_cpu_irq_init(int base)
 	clear_c0_intcontrol(0x00000f00);		/* Mask all */
 
 	for (i = base; i < base + 4; i++)
-		set_irq_chip(i, &rm7k_irq_controller);
+		set_irq_chip_and_handler(i, &rm7k_irq_controller,
+					 handle_level_irq);
 
 	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 9775384..ba6440c 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -117,10 +117,12 @@ void __init rm9k_cpu_irq_init(int base)
 	clear_c0_intcontrol(0x0000f000);		/* Mask all */
 
 	for (i = base; i < base + 4; i++)
-		set_irq_chip(i, &rm9k_irq_controller);
+		set_irq_chip_and_handler(i, &rm9k_irq_controller,
+					 handle_level_irq);
 
 	rm9000_perfcount_irq = base + 1;
-	set_irq_chip(rm9000_perfcount_irq, &rm9k_perfcounter_irq);
+	set_irq_chip_and_handler(rm9000_perfcount_irq, &rm9k_perfcounter_irq,
+				 handle_level_irq);
 
 	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 3b7cfa4..be5ac23 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -62,6 +62,7 @@ static struct irq_chip mips_cpu_irq_cont
 	.mask		= mask_mips_irq,
 	.mask_ack	= mask_mips_irq,
 	.unmask		= unmask_mips_irq,
+	.eoi		= unmask_mips_irq,
 	.end		= mips_cpu_irq_end,
 };
 
@@ -104,6 +105,7 @@ static struct irq_chip mips_mt_cpu_irq_c
 	.mask		= mask_mips_mt_irq,
 	.mask_ack	= mips_mt_cpu_irq_ack,
 	.unmask		= unmask_mips_mt_irq,
+	.eoi		= unmask_mips_mt_irq,
 	.end		= mips_mt_cpu_irq_end,
 };
 
@@ -124,7 +126,8 @@ void __init mips_cpu_irq_init(int irq_ba
 			set_irq_chip(i, &mips_mt_cpu_irq_controller);
 
 	for (i = irq_base + 2; i < irq_base + 8; i++)
-		set_irq_chip(i, &mips_cpu_irq_controller);
+		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
+					 handle_level_irq);
 
 	mips_cpu_irq_base = irq_base;
 }
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 2ac19a6..1ee689c 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -278,7 +278,9 @@ void __init plat_prepare_cpus(unsigned i
 
 	/* need to mark IPI's as IRQ_PER_CPU */
 	irq_desc[cpu_ipi_resched_irq].status |= IRQ_PER_CPU;
+	set_irq_handler(cpu_ipi_resched_irq, handle_percpu_irq);
 	irq_desc[cpu_ipi_call_irq].status |= IRQ_PER_CPU;
+	set_irq_handler(cpu_ipi_call_irq, handle_percpu_irq);
 }
 
 /*
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 3b78caf..802febe 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -1009,6 +1009,7 @@ void setup_cross_vpe_interrupts(void)
 	setup_irq_smtc(cpu_ipi_irq, &irq_ipi, (0x100 << MIPS_CPU_IPI_IRQ));
 
 	irq_desc[cpu_ipi_irq].status |= IRQ_PER_CPU;
+	set_irq_handler(cpu_ipi_irq, handle_percpu_irq);
 }
 
 /*
diff --git a/arch/mips/lasat/interrupt.c b/arch/mips/lasat/interrupt.c
index cac82af..4a84a7b 100644
--- a/arch/mips/lasat/interrupt.c
+++ b/arch/mips/lasat/interrupt.c
@@ -133,5 +133,5 @@ void __init arch_init_irq(void)
 	}
 
 	for (i = 0; i <= LASATINT_END; i++)
-		set_irq_chip(i, &lasat_irq_type);
+		set_irq_chip_and_handler(i, &lasat_irq_type, handle_level_irq);
 }
diff --git a/arch/mips/mips-boards/atlas/atlas_int.c b/arch/mips/mips-boards/atlas/atlas_int.c
index 7c71004..43dba6c 100644
--- a/arch/mips/mips-boards/atlas/atlas_int.c
+++ b/arch/mips/mips-boards/atlas/atlas_int.c
@@ -74,6 +74,7 @@ static struct irq_chip atlas_irq_type = 
 	.mask = disable_atlas_irq,
 	.mask_ack = disable_atlas_irq,
 	.unmask = enable_atlas_irq,
+	.eoi = enable_atlas_irq,
 	.end = end_atlas_irq,
 };
 
@@ -207,7 +208,7 @@ static inline void init_atlas_irqs (int 
 	atlas_hw0_icregs->intrsten = 0xffffffff;
 
 	for (i = ATLAS_INT_BASE; i <= ATLAS_INT_END; i++)
-		set_irq_chip(i, &atlas_irq_type);
+		set_irq_chip_and_handler(i, &atlas_irq_type, handle_level_irq);
 }
 
 static struct irqaction atlasirq = {
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index d817c60..5249a88 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -287,7 +287,8 @@ #ifdef CONFIG_SMP
 	   on seperate cpu's the first one tries to handle the second interrupt.
 	   The effect is that the int remains disabled on the second cpu.
 	   Mark the interrupt with IRQ_PER_CPU to avoid any confusion */
-	irq_desc[mips_cpu_timer_irq].status |= IRQ_PER_CPU;
+	irq_desc[mips_cpu_timer_irq].flags |= IRQ_PER_CPU;
+	set_irq_handler(mips_cpu_timer_irq, handle_percpu_irq);
 #endif
 
         /* to generate the first timer interrupt */
diff --git a/arch/mips/mips-boards/sim/sim_time.c b/arch/mips/mips-boards/sim/sim_time.c
index 24a4ed0..f2d998d 100644
--- a/arch/mips/mips-boards/sim/sim_time.c
+++ b/arch/mips/mips-boards/sim/sim_time.c
@@ -203,7 +203,8 @@ #ifdef CONFIG_SMP
 	   on seperate cpu's the first one tries to handle the second interrupt.
 	   The effect is that the int remains disabled on the second cpu.
 	   Mark the interrupt with IRQ_PER_CPU to avoid any confusion */
-	irq_desc[mips_cpu_timer_irq].status |= IRQ_PER_CPU;
+	irq_desc[mips_cpu_timer_irq].flags |= IRQ_PER_CPU;
+	set_irq_handler(mips_cpu_timer_irq, handle_percpu_irq);
 #endif
 
 	/* to generate the first timer interrupt */
diff --git a/arch/mips/momentum/ocelot_c/cpci-irq.c b/arch/mips/momentum/ocelot_c/cpci-irq.c
index 7723f09..e5a4a0a 100644
--- a/arch/mips/momentum/ocelot_c/cpci-irq.c
+++ b/arch/mips/momentum/ocelot_c/cpci-irq.c
@@ -106,5 +106,5 @@ void cpci_irq_init(void)
 	int i;
 
 	for (i = CPCI_IRQ_BASE; i < (CPCI_IRQ_BASE + 8); i++)
-		set_irq_chip(i, &cpci_irq_type);
+		set_irq_chip_and_handler(i, &cpci_irq_type, handle_level_irq);
 }
diff --git a/arch/mips/momentum/ocelot_c/uart-irq.c b/arch/mips/momentum/ocelot_c/uart-irq.c
index 72faf81..0029f00 100644
--- a/arch/mips/momentum/ocelot_c/uart-irq.c
+++ b/arch/mips/momentum/ocelot_c/uart-irq.c
@@ -96,6 +96,6 @@ struct irq_chip uart_irq_type = {
 
 void uart_irq_init(void)
 {
-	set_irq_chip(80, &uart_irq_type);
-	set_irq_chip(81, &uart_irq_type);
+	set_irq_chip_and_handler(80, &uart_irq_type, handle_level_irq);
+	set_irq_chip_and_handler(81, &uart_irq_type, handle_level_irq);
 }
diff --git a/arch/mips/philips/pnx8550/common/int.c b/arch/mips/philips/pnx8550/common/int.c
index e4bf494..0dc2393 100644
--- a/arch/mips/philips/pnx8550/common/int.c
+++ b/arch/mips/philips/pnx8550/common/int.c
@@ -192,7 +192,7 @@ void __init arch_init_irq(void)
 	int configPR;
 
 	for (i = 0; i < PNX8550_INT_CP0_TOTINT; i++) {
-		set_irq_chip(i, &level_irq_type);
+		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
 		mask_irq(i);	/* mask the irq just in case  */
 	}
 
@@ -229,7 +229,7 @@ #endif
 		/* mask/priority is still 0 so we will not get any
 		 * interrupts until it is unmasked */
 
-		set_irq_chip(i, &level_irq_type);
+		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
 	}
 
 	/* Priority level 0 */
@@ -238,19 +238,21 @@ #endif
 	/* Set int vector table address */
 	PNX8550_GIC_VECTOR_0 = PNX8550_GIC_VECTOR_1 = 0;
 
-	set_irq_chip(MIPS_CPU_GIC_IRQ, &level_irq_type);
+	set_irq_chip_and_handler(MIPS_CPU_GIC_IRQ, &level_irq_type,
+				 handle_level_irq);
 	setup_irq(MIPS_CPU_GIC_IRQ, &gic_action);
 
 	/* init of Timer interrupts */
 	for (i = PNX8550_INT_TIMER_MIN; i <= PNX8550_INT_TIMER_MAX; i++)
-		set_irq_chip(i, &level_irq_type);
+		set_irq_chip_and_handler(i, &level_irq_type, handle_level_irq);
 
 	/* Stop Timer 1-3 */
 	configPR = read_c0_config7();
 	configPR |= 0x00000038;
 	write_c0_config7(configPR);
 
-	set_irq_chip(MIPS_CPU_TIMER_IRQ, &level_irq_type);
+	set_irq_chip_and_handler(MIPS_CPU_TIMER_IRQ, &level_irq_type,
+				 handle_level_irq);
 	setup_irq(MIPS_CPU_TIMER_IRQ, &timer_action);
 }
 
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index 8e2074b..c7b1380 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -358,7 +358,7 @@ void __init arch_init_irq(void)
 		else
 			handler		= &ip22_local3_irq_type;
 
-		set_irq_chip(i, handler);
+		set_irq_chip_and_handler(i, handler, handle_level_irq);
 	}
 
 	/* vector handler. this register the IRQ as non-sharable */
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 8243202..5f8835b 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -352,7 +352,7 @@ static struct irq_chip bridge_irq_type =
 
 void __devinit register_bridge_irq(unsigned int irq)
 {
-	set_irq_chip(irq, &bridge_irq_type);
+	set_irq_chip_and_handler(irq, &bridge_irq_type, handle_level_irq);
 }
 
 int __devinit request_bridge_irq(struct bridge_controller *bc)
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 86ba7fc..e5441c3 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -190,6 +190,7 @@ static struct irq_chip rt_irq_type = {
 	.mask		= disable_rt_irq,
 	.mask_ack	= disable_rt_irq,
 	.unmask		= enable_rt_irq,
+	.eoi		= enable_rt_irq,
 	.end		= end_rt_irq,
 };
 
@@ -207,7 +208,7 @@ void __init plat_timer_setup(struct irqa
 	if (irqno < 0)
 		panic("Can't allocate interrupt number for timer interrupt");
 
-	set_irq_chip(irqno, &rt_irq_type);
+	set_irq_chip_and_handler(irqno, &rt_irq_type, handle_percpu_irq);
 
 	/* over-write the handler, we use our own way */
 	irq->handler = no_action;
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index 2c57ced..21873de 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -196,7 +196,8 @@ static void __init tx4927_irq_cp0_init(v
 			   TX4927_IRQ_CP0_BEG, TX4927_IRQ_CP0_END);
 
 	for (i = TX4927_IRQ_CP0_BEG; i <= TX4927_IRQ_CP0_END; i++)
-		set_irq_chip(i, &tx4927_irq_cp0_type);
+		set_irq_chip_and_handler(i, &tx4927_irq_cp0_type,
+					 handle_level_irq);
 }
 
 static void tx4927_irq_cp0_enable(unsigned int irq)
@@ -350,7 +351,8 @@ static void __init tx4927_irq_pic_init(v
 			   TX4927_IRQ_PIC_BEG, TX4927_IRQ_PIC_END);
 
 	for (i = TX4927_IRQ_PIC_BEG; i <= TX4927_IRQ_PIC_END; i++)
-		set_irq_chip(i, &tx4927_irq_pic_type);
+		set_irq_chip_and_handler(i, &tx4927_irq_pic_type,
+					 handle_level_irq);
 
 	setup_irq(TX4927_IRQ_NEST_PIC_ON_CP0, &tx4927_irq_pic_action);
 
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index 1040ab3..85c8493 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -342,7 +342,8 @@ static void __init toshiba_rbtx4927_irq_
 
 	for (i = TOSHIBA_RBTX4927_IRQ_IOC_BEG;
 	     i <= TOSHIBA_RBTX4927_IRQ_IOC_END; i++)
-		set_irq_chip(i, &toshiba_rbtx4927_irq_ioc_type);
+		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
+					 handle_level_irq);
 
 	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC,
 		  &toshiba_rbtx4927_irq_ioc_action);
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
index 19c9ee9..42e1276 100644
--- a/arch/mips/tx4938/common/irq.c
+++ b/arch/mips/tx4938/common/irq.c
@@ -88,7 +88,8 @@ tx4938_irq_cp0_init(void)
 	int i;
 
 	for (i = TX4938_IRQ_CP0_BEG; i <= TX4938_IRQ_CP0_END; i++)
-		set_irq_chip(i, &tx4938_irq_cp0_type);
+		set_irq_chip_and_handler(i, &tx4938_irq_cp0_type,
+					 handle_level_irq);
 }
 
 static void
@@ -245,7 +246,8 @@ tx4938_irq_pic_init(void)
 	int i;
 
 	for (i = TX4938_IRQ_PIC_BEG; i <= TX4938_IRQ_PIC_END; i++)
-		set_irq_chip(i, &tx4938_irq_pic_type);
+		set_irq_chip_and_handler(i, &tx4938_irq_pic_type,
+					 handle_level_irq);
 
 	setup_irq(TX4938_IRQ_NEST_PIC_ON_CP0, &tx4938_irq_pic_action);
 
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index 2735ffe..8c87a35 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -136,7 +136,8 @@ toshiba_rbtx4938_irq_ioc_init(void)
 
 	for (i = TOSHIBA_RBTX4938_IRQ_IOC_BEG;
 	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++)
-		set_irq_chip(i, &toshiba_rbtx4938_irq_ioc_type);
+		set_irq_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
+					 handle_level_irq);
 
 	setup_irq(RBTX4938_IRQ_IOCINT,
 		  &toshiba_rbtx4938_irq_ioc_action);
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index 33d70a6..54b92a7 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -701,10 +701,12 @@ static int __init vr41xx_icu_init(void)
 	icu2_write(MGIUINTHREG, 0xffff);
 
 	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
-		set_irq_chip(i, &sysint1_irq_type);
+		set_irq_chip_and_handler(i, &sysint1_irq_type,
+					 handle_level_irq);
 
 	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
-		set_irq_chip(i, &sysint2_irq_type);
+		set_irq_chip_and_handler(i, &sysint2_irq_type,
+					 handle_level_irq);
 
 	cascade_irq(INT0_IRQ, icu_get_irq);
 	cascade_irq(INT1_IRQ, icu_get_irq);
diff --git a/include/asm-mips/irq.h b/include/asm-mips/irq.h
index 4724d3f..6765708 100644
--- a/include/asm-mips/irq.h
+++ b/include/asm-mips/irq.h
@@ -53,7 +53,7 @@ #define do_IRQ(irq)							\
 do {									\
 	irq_enter();							\
 	__DO_IRQ_SMTC_HOOK();						\
-	__do_IRQ((irq));						\
+	generic_handle_irq(irq);					\
 	irq_exit();							\
 } while (0)
 
