Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jan 2007 17:14:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:46275 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20042615AbXAGROd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jan 2007 17:14:33 +0000
Received: from localhost (p2249-ipad204funabasi.chiba.ocn.ne.jp [222.146.89.249])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3BE3AE5E2; Mon,  8 Jan 2007 02:14:28 +0900 (JST)
Date:	Mon, 08 Jan 2007 02:14:29 +0900 (JST)
Message-Id: <20070108.021429.78706014.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Define MIPS_CPU_IRQ_BASE in generic header
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
X-archive-position: 13551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The irq_base for {mips,rm7k,rm9k}_cpu_irq_init() are constant on all
platforms and are same value on most platforms (0 or 16, depends on
CONFIG_I8259).  Define them in asm-mips/mach-generic/irq.h and make
them customizable.  This will save a few cycle on each CPU interrupt.

A good side effect is removing some dependencies to MALTA in generic
SMTC code.

Although MIPS_CPU_IRQ_BASE is customizable, this patch changes irq
mappings on DDB5477, EMMA2RH and MIPS_SIM, since really customizing
them might cause some header dependency problem and there seems no
good reason to customize it.  So currently only VR41XX is using custom
MIPS_CPU_IRQ_BASE value, which is 0 regardless of CONFIG_I8259.

Testing this patch on those platforms is greatly appreciated.  Thank
you.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/basler/excite/excite_irq.c    |    6 +++---
 arch/mips/cobalt/irq.c                  |    2 +-
 arch/mips/ddb5xxx/ddb5477/irq.c         |    4 ++--
 arch/mips/dec/setup.c                   |   12 ++++++------
 arch/mips/emma2rh/markeins/irq.c        |    2 +-
 arch/mips/gt64120/momenco_ocelot/irq.c  |    4 ++--
 arch/mips/gt64120/wrppmc/irq.c          |    2 +-
 arch/mips/kernel/irq-rm7000.c           |   11 ++++-------
 arch/mips/kernel/irq-rm9000.c           |   11 ++++-------
 arch/mips/kernel/irq_cpu.c              |   17 +++++++----------
 arch/mips/kernel/rtlx.c                 |    4 ++--
 arch/mips/kernel/smp-mt.c               |    9 ++++-----
 arch/mips/kernel/smtc.c                 |   12 +-----------
 arch/mips/mips-boards/atlas/atlas_int.c |    2 +-
 arch/mips/mips-boards/malta/malta_int.c |    2 +-
 arch/mips/mips-boards/sead/sead_int.c   |    2 +-
 arch/mips/mips-boards/sim/sim_int.c     |    6 ++----
 arch/mips/momentum/jaguar_atx/irq.c     |    4 ++--
 arch/mips/momentum/ocelot_3/irq.c       |    2 +-
 arch/mips/momentum/ocelot_c/irq.c       |    2 +-
 arch/mips/momentum/ocelot_g/irq.c       |    4 ++--
 arch/mips/pmc-sierra/yosemite/irq.c     |    6 +++---
 arch/mips/sgi-ip22/ip22-int.c           |    5 ++---
 arch/mips/vr41xx/common/irq.c           |    2 +-
 include/asm-mips/ddb5xxx/ddb5477.h      |    5 +++--
 include/asm-mips/dec/interrupts.h       |    3 ++-
 include/asm-mips/emma2rh/emma2rh.h      |    5 ++++-
 include/asm-mips/emma2rh/markeins.h     |    1 -
 include/asm-mips/irq_cpu.h              |    6 +++---
 include/asm-mips/mach-cobalt/cobalt.h   |    4 +++-
 include/asm-mips/mach-emma2rh/irq.h     |    2 ++
 include/asm-mips/mach-generic/irq.h     |   26 ++++++++++++++++++++++++++
 include/asm-mips/mach-mips/irq.h        |    2 ++
 include/asm-mips/mach-vr41xx/irq.h      |    8 ++++++++
 include/asm-mips/mips-boards/atlasint.h |    4 +++-
 include/asm-mips/mips-boards/maltaint.h |    4 +++-
 include/asm-mips/mips-boards/seadint.h  |    4 +++-
 include/asm-mips/mips-boards/simint.h   |    3 ++-
 include/asm-mips/rtlx.h                 |    3 ++-
 include/asm-mips/sgi/ip22.h             |   13 +++++++------
 40 files changed, 128 insertions(+), 98 deletions(-)

diff --git a/arch/mips/basler/excite/excite_irq.c b/arch/mips/basler/excite/excite_irq.c
index 2e2061a..1ecab63 100644
--- a/arch/mips/basler/excite/excite_irq.c
+++ b/arch/mips/basler/excite/excite_irq.c
@@ -47,9 +47,9 @@ extern asmlinkage void excite_handle_int
  */
 void __init arch_init_irq(void)
 {
-	mips_cpu_irq_init(0);
-	rm7k_cpu_irq_init(8);
-	rm9k_cpu_irq_init(12);
+	mips_cpu_irq_init();
+	rm7k_cpu_irq_init();
+	rm9k_cpu_irq_init();
 
 #ifdef CONFIG_KGDB
 	excite_kgdb_init();
diff --git a/arch/mips/cobalt/irq.c b/arch/mips/cobalt/irq.c
index 4c46f0e..fe93b84 100644
--- a/arch/mips/cobalt/irq.c
+++ b/arch/mips/cobalt/irq.c
@@ -104,7 +104,7 @@ void __init arch_init_irq(void)
 	GT_WRITE(GT_INTRMASK_OFS, 0);
 
 	init_i8259_irqs();				/*  0 ... 15 */
-	mips_cpu_irq_init(COBALT_CPU_IRQ);		/* 16 ... 23 */
+	mips_cpu_irq_init();		/* 16 ... 23 */
 
 	/*
 	 * Mask all cpu interrupts
diff --git a/arch/mips/ddb5xxx/ddb5477/irq.c b/arch/mips/ddb5xxx/ddb5477/irq.c
index a8bd2e6..bd7cd7c 100644
--- a/arch/mips/ddb5xxx/ddb5477/irq.c
+++ b/arch/mips/ddb5xxx/ddb5477/irq.c
@@ -17,6 +17,7 @@
 #include <linux/ptrace.h>
 
 #include <asm/i8259.h>
+#include <asm/irq_cpu.h>
 #include <asm/system.h>
 #include <asm/mipsregs.h>
 #include <asm/debug.h>
@@ -73,7 +74,6 @@ set_pci_int_attr(u32 pci, u32 intn, u32
 }
 
 extern void vrc5477_irq_init(u32 base);
-extern void mips_cpu_irq_init(u32 base);
 static struct irqaction irq_cascade = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL };
 
 void __init arch_init_irq(void)
@@ -125,7 +125,7 @@ void __init arch_init_irq(void)
 
 	/* init all controllers */
 	init_i8259_irqs();
-	mips_cpu_irq_init(CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 	vrc5477_irq_init(VRC5477_IRQ_BASE);
 
 
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index d34032a..1058e2f 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -234,7 +234,7 @@ static void __init dec_init_kn01(void)
 	memcpy(&cpu_mask_nr_tbl, &kn01_cpu_mask_nr_tbl,
 		sizeof(kn01_cpu_mask_nr_tbl));
 
-	mips_cpu_irq_init(DEC_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 
 }				/* dec_init_kn01 */
 
@@ -309,7 +309,7 @@ static void __init dec_init_kn230(void)
 	memcpy(&cpu_mask_nr_tbl, &kn230_cpu_mask_nr_tbl,
 		sizeof(kn230_cpu_mask_nr_tbl));
 
-	mips_cpu_irq_init(DEC_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 
 }				/* dec_init_kn230 */
 
@@ -403,7 +403,7 @@ static void __init dec_init_kn02(void)
 	memcpy(&asic_mask_nr_tbl, &kn02_asic_mask_nr_tbl,
 		sizeof(kn02_asic_mask_nr_tbl));
 
-	mips_cpu_irq_init(DEC_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 	init_kn02_irqs(KN02_IRQ_BASE);
 
 }				/* dec_init_kn02 */
@@ -504,7 +504,7 @@ static void __init dec_init_kn02ba(void)
 	memcpy(&asic_mask_nr_tbl, &kn02ba_asic_mask_nr_tbl,
 		sizeof(kn02ba_asic_mask_nr_tbl));
 
-	mips_cpu_irq_init(DEC_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 	init_ioasic_irqs(IO_IRQ_BASE);
 
 }				/* dec_init_kn02ba */
@@ -601,7 +601,7 @@ static void __init dec_init_kn02ca(void)
 	memcpy(&asic_mask_nr_tbl, &kn02ca_asic_mask_nr_tbl,
 		sizeof(kn02ca_asic_mask_nr_tbl));
 
-	mips_cpu_irq_init(DEC_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 	init_ioasic_irqs(IO_IRQ_BASE);
 
 }				/* dec_init_kn02ca */
@@ -702,7 +702,7 @@ static void __init dec_init_kn03(void)
 	memcpy(&asic_mask_nr_tbl, &kn03_asic_mask_nr_tbl,
 		sizeof(kn03_asic_mask_nr_tbl));
 
-	mips_cpu_irq_init(DEC_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 	init_ioasic_irqs(IO_IRQ_BASE);
 
 }				/* dec_init_kn03 */
diff --git a/arch/mips/emma2rh/markeins/irq.c b/arch/mips/emma2rh/markeins/irq.c
index c93369c..3299b6d 100644
--- a/arch/mips/emma2rh/markeins/irq.c
+++ b/arch/mips/emma2rh/markeins/irq.c
@@ -106,7 +106,7 @@ void __init arch_init_irq(void)
 	emma2rh_irq_init(EMMA2RH_IRQ_BASE);
 	emma2rh_sw_irq_init(EMMA2RH_SW_IRQ_BASE);
 	emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE);
-	mips_cpu_irq_init(CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 
 	/* setup cascade interrupts */
 	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_SW_CASCADE, &irq_cascade);
diff --git a/arch/mips/gt64120/momenco_ocelot/irq.c b/arch/mips/gt64120/momenco_ocelot/irq.c
index d929440..2585d9d 100644
--- a/arch/mips/gt64120/momenco_ocelot/irq.c
+++ b/arch/mips/gt64120/momenco_ocelot/irq.c
@@ -90,6 +90,6 @@ void __init arch_init_irq(void)
 	clear_c0_status(ST0_IM);
 	local_irq_disable();
 
-	mips_cpu_irq_init(0);
-	rm7k_cpu_irq_init(8);
+	mips_cpu_irq_init();
+	rm7k_cpu_irq_init();
 }
diff --git a/arch/mips/gt64120/wrppmc/irq.c b/arch/mips/gt64120/wrppmc/irq.c
index eedfc24..d3d9659 100644
--- a/arch/mips/gt64120/wrppmc/irq.c
+++ b/arch/mips/gt64120/wrppmc/irq.c
@@ -63,7 +63,7 @@ void gt64120_init_pic(void)
 void __init arch_init_irq(void)
 {
 	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
-	mips_cpu_irq_init(0);
+	mips_cpu_irq_init();
 
 	gt64120_init_pic();
 }
diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index 123324b..a60cfe5 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -17,16 +17,14 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
-static int irq_base;
-
 static inline void unmask_rm7k_irq(unsigned int irq)
 {
-	set_c0_intcontrol(0x100 << (irq - irq_base));
+	set_c0_intcontrol(0x100 << (irq - RM7K_CPU_IRQ_BASE));
 }
 
 static inline void mask_rm7k_irq(unsigned int irq)
 {
-	clear_c0_intcontrol(0x100 << (irq - irq_base));
+	clear_c0_intcontrol(0x100 << (irq - RM7K_CPU_IRQ_BASE));
 }
 
 static struct irq_chip rm7k_irq_controller = {
@@ -37,8 +35,9 @@ static struct irq_chip rm7k_irq_controll
 	.unmask = unmask_rm7k_irq,
 };
 
-void __init rm7k_cpu_irq_init(int base)
+void __init rm7k_cpu_irq_init(void)
 {
+	int base = RM7K_CPU_IRQ_BASE;
 	int i;
 
 	clear_c0_intcontrol(0x00000f00);		/* Mask all */
@@ -46,6 +45,4 @@ void __init rm7k_cpu_irq_init(int base)
 	for (i = base; i < base + 4; i++)
 		set_irq_chip_and_handler(i, &rm7k_irq_controller,
 					 handle_level_irq);
-
-	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 0e6f4c5..6df072b 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -18,16 +18,14 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
-static int irq_base;
-
 static inline void unmask_rm9k_irq(unsigned int irq)
 {
-	set_c0_intcontrol(0x1000 << (irq - irq_base));
+	set_c0_intcontrol(0x1000 << (irq - RM9K_CPU_IRQ_BASE));
 }
 
 static inline void mask_rm9k_irq(unsigned int irq)
 {
-	clear_c0_intcontrol(0x1000 << (irq - irq_base));
+	clear_c0_intcontrol(0x1000 << (irq - RM9K_CPU_IRQ_BASE));
 }
 
 static inline void rm9k_cpu_irq_enable(unsigned int irq)
@@ -102,8 +100,9 @@ unsigned int rm9000_perfcount_irq;
 
 EXPORT_SYMBOL(rm9000_perfcount_irq);
 
-void __init rm9k_cpu_irq_init(int base)
+void __init rm9k_cpu_irq_init(void)
 {
+	int base = RM9K_CPU_IRQ_BASE;
 	int i;
 
 	clear_c0_intcontrol(0x0000f000);		/* Mask all */
@@ -115,6 +114,4 @@ void __init rm9k_cpu_irq_init(int base)
 	rm9000_perfcount_irq = base + 1;
 	set_irq_chip_and_handler(rm9000_perfcount_irq, &rm9k_perfcounter_irq,
 				 handle_level_irq);
-
-	irq_base = base;
 }
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index fcc86b9..6e73dda 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -25,7 +25,7 @@
  * Don't even think about using this on SMP.  You have been warned.
  *
  * This file exports one global function:
- *	void mips_cpu_irq_init(int irq_base);
+ *	void mips_cpu_irq_init(void);
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -36,17 +36,15 @@
 #include <asm/mipsmtregs.h>
 #include <asm/system.h>
 
-static int mips_cpu_irq_base;
-
 static inline void unmask_mips_irq(unsigned int irq)
 {
-	set_c0_status(0x100 << (irq - mips_cpu_irq_base));
+	set_c0_status(0x100 << (irq - MIPS_CPU_IRQ_BASE));
 	irq_enable_hazard();
 }
 
 static inline void mask_mips_irq(unsigned int irq)
 {
-	clear_c0_status(0x100 << (irq - mips_cpu_irq_base));
+	clear_c0_status(0x100 << (irq - MIPS_CPU_IRQ_BASE));
 	irq_disable_hazard();
 }
 
@@ -70,7 +68,7 @@ static unsigned int mips_mt_cpu_irq_star
 {
 	unsigned int vpflags = dvpe();
 
-	clear_c0_cause(0x100 << (irq - mips_cpu_irq_base));
+	clear_c0_cause(0x100 << (irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
 	unmask_mips_mt_irq(irq);
 
@@ -84,7 +82,7 @@ static unsigned int mips_mt_cpu_irq_star
 static void mips_mt_cpu_irq_ack(unsigned int irq)
 {
 	unsigned int vpflags = dvpe();
-	clear_c0_cause(0x100 << (irq - mips_cpu_irq_base));
+	clear_c0_cause(0x100 << (irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
 	mask_mips_mt_irq(irq);
 }
@@ -99,8 +97,9 @@ static struct irq_chip mips_mt_cpu_irq_c
 	.eoi		= unmask_mips_mt_irq,
 };
 
-void __init mips_cpu_irq_init(int irq_base)
+void __init mips_cpu_irq_init(void)
 {
+	int irq_base = MIPS_CPU_IRQ_BASE;
 	int i;
 
 	/* Mask interrupts. */
@@ -118,6 +117,4 @@ void __init mips_cpu_irq_init(int irq_ba
 	for (i = irq_base + 2; i < irq_base + 8; i++)
 		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
 					 handle_level_irq);
-
-	mips_cpu_irq_base = irq_base;
 }
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 5a99e3e..8610f4a 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -63,7 +63,7 @@ extern void *vpe_get_shared(int index);
 
 static void rtlx_dispatch(void)
 {
-	do_IRQ(MIPSCPU_INT_BASE + MIPS_CPU_RTLX_IRQ);
+	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
 }
 
 
@@ -491,7 +491,7 @@ static struct irqaction rtlx_irq = {
 	.name		= "RTLX",
 };
 
-static int rtlx_irq_num = MIPSCPU_INT_BASE + MIPS_CPU_RTLX_IRQ;
+static int rtlx_irq_num = MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ;
 
 static char register_chrdev_failed[] __initdata =
 	KERN_ERR "rtlx_module_init: unable to register device\n";
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 1ee689c..64b62bd 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -35,7 +35,6 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
-#include <asm/mips-boards/maltaint.h>  /* This is f*cking wrong */
 
 #define MIPS_CPU_IPI_RESCHED_IRQ 0
 #define MIPS_CPU_IPI_CALL_IRQ 1
@@ -108,12 +107,12 @@ void __init sanitize_tlb_entries(void)
 
 static void ipi_resched_dispatch(void)
 {
-	do_IRQ(MIPSCPU_INT_BASE + MIPS_CPU_IPI_RESCHED_IRQ);
+	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ);
 }
 
 static void ipi_call_dispatch(void)
 {
-	do_IRQ(MIPSCPU_INT_BASE + MIPS_CPU_IPI_CALL_IRQ);
+	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ);
 }
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
@@ -270,8 +269,8 @@ void __init plat_prepare_cpus(unsigned i
 		set_vi_handler(MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);
 	}
 
-	cpu_ipi_resched_irq = MIPSCPU_INT_BASE + MIPS_CPU_IPI_RESCHED_IRQ;
-	cpu_ipi_call_irq = MIPSCPU_INT_BASE + MIPS_CPU_IPI_CALL_IRQ;
+	cpu_ipi_resched_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_RESCHED_IRQ;
+	cpu_ipi_call_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_CALL_IRQ;
 
 	setup_irq(cpu_ipi_resched_irq, &irq_resched);
 	setup_irq(cpu_ipi_call_irq, &irq_call);
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 802febe..36d33d3 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -25,16 +25,6 @@
  * This file should be built into the kernel only if CONFIG_MIPS_MT_SMTC is set.
  */
 
-/*
- * MIPSCPU_INT_BASE is identically defined in both
- * asm-mips/mips-boards/maltaint.h and asm-mips/mips-boards/simint.h,
- * but as yet there's no properly organized include structure that
- * will ensure that the right *int.h file will be included for a
- * given platform build.
- */
-
-#define MIPSCPU_INT_BASE	16
-
 #define MIPS_CPU_IPI_IRQ	1
 
 #define LOCK_MT_PRA() \
@@ -916,7 +906,7 @@ void smtc_timer_broadcast(int vpe)
  * interrupts.
  */
 
-static int cpu_ipi_irq = MIPSCPU_INT_BASE + MIPS_CPU_IPI_IRQ;
+static int cpu_ipi_irq = MIPS_CPU_IRQ_BASE + MIPS_CPU_IPI_IRQ;
 
 static irqreturn_t ipi_interrupt(int irq, void *dev_idm)
 {
diff --git a/arch/mips/mips-boards/atlas/atlas_int.c b/arch/mips/mips-boards/atlas/atlas_int.c
index 43dba6c..85482a6 100644
--- a/arch/mips/mips-boards/atlas/atlas_int.c
+++ b/arch/mips/mips-boards/atlas/atlas_int.c
@@ -238,7 +238,7 @@ void __init arch_init_irq(void)
 	init_atlas_irqs(ATLAS_INT_BASE);
 
 	if (!cpu_has_veic)
-		mips_cpu_irq_init(MIPSCPU_INT_BASE);
+		mips_cpu_irq_init();
 
 	switch(mips_revision_corid) {
 	case MIPS_REVISION_CORID_CORE_MSC:
diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index 90ad5bf..d9ddb17 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -310,7 +310,7 @@ void __init arch_init_irq(void)
 	init_i8259_irqs();
 
 	if (!cpu_has_veic)
-		mips_cpu_irq_init (MIPSCPU_INT_BASE);
+		mips_cpu_irq_init();
 
         switch(mips_revision_corid) {
         case MIPS_REVISION_CORID_CORE_MSC:
diff --git a/arch/mips/mips-boards/sead/sead_int.c b/arch/mips/mips-boards/sead/sead_int.c
index f445fcd..2f79a70 100644
--- a/arch/mips/mips-boards/sead/sead_int.c
+++ b/arch/mips/mips-boards/sead/sead_int.c
@@ -113,5 +113,5 @@ asmlinkage void plat_irq_dispatch(void)
 
 void __init arch_init_irq(void)
 {
-	mips_cpu_irq_init(MIPSCPU_INT_BASE);
+	mips_cpu_irq_init();
 }
diff --git a/arch/mips/mips-boards/sim/sim_int.c b/arch/mips/mips-boards/sim/sim_int.c
index 2ce449d..15ac065 100644
--- a/arch/mips/mips-boards/sim/sim_int.c
+++ b/arch/mips/mips-boards/sim/sim_int.c
@@ -21,9 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <asm/mips-boards/simint.h>
-
-
-extern void mips_cpu_irq_init(int);
+#include <asm/irq_cpu.h>
 
 static inline int clz(unsigned long x)
 {
@@ -86,5 +84,5 @@ asmlinkage void plat_irq_dispatch(void)
 
 void __init arch_init_irq(void)
 {
-	mips_cpu_irq_init(MIPSCPU_INT_BASE);
+	mips_cpu_irq_init();
 }
diff --git a/arch/mips/momentum/jaguar_atx/irq.c b/arch/mips/momentum/jaguar_atx/irq.c
index 2efb25a..f2b4325 100644
--- a/arch/mips/momentum/jaguar_atx/irq.c
+++ b/arch/mips/momentum/jaguar_atx/irq.c
@@ -82,8 +82,8 @@ void __init arch_init_irq(void)
 	 */
 	clear_c0_status(ST0_IM);
 
-	mips_cpu_irq_init(0);
-	rm7k_cpu_irq_init(8);
+	mips_cpu_irq_init();
+	rm7k_cpu_irq_init();
 
 	/* set up the cascading interrupts */
 	setup_irq(8, &cascade_mv64340);
diff --git a/arch/mips/momentum/ocelot_3/irq.c b/arch/mips/momentum/ocelot_3/irq.c
index cea0e5d..3862d1d 100644
--- a/arch/mips/momentum/ocelot_3/irq.c
+++ b/arch/mips/momentum/ocelot_3/irq.c
@@ -65,7 +65,7 @@ void __init arch_init_irq(void)
 	 */
 	clear_c0_status(ST0_IM | ST0_BEV);
 
-	rm7k_cpu_irq_init(8);
+	rm7k_cpu_irq_init();
 
 	/* set up the cascading interrupts */
 	setup_irq(8, &cascade_mv64340);		/* unmask intControl IM8, IRQ 9 */
diff --git a/arch/mips/momentum/ocelot_c/irq.c b/arch/mips/momentum/ocelot_c/irq.c
index ea65223..40472f7 100644
--- a/arch/mips/momentum/ocelot_c/irq.c
+++ b/arch/mips/momentum/ocelot_c/irq.c
@@ -94,7 +94,7 @@ void __init arch_init_irq(void)
 	 */
 	clear_c0_status(ST0_IM);
 
-	mips_cpu_irq_init(0);
+	mips_cpu_irq_init();
 
 	/* set up the cascading interrupts */
 	setup_irq(3, &cascade_fpga);
diff --git a/arch/mips/momentum/ocelot_g/irq.c b/arch/mips/momentum/ocelot_g/irq.c
index da46524..273541f 100644
--- a/arch/mips/momentum/ocelot_g/irq.c
+++ b/arch/mips/momentum/ocelot_g/irq.c
@@ -94,8 +94,8 @@ void __init arch_init_irq(void)
 	clear_c0_status(ST0_IM);
 	local_irq_disable();
 
-	mips_cpu_irq_init(0);
-	rm7k_cpu_irq_init(8);
+	mips_cpu_irq_init();
+	rm7k_cpu_irq_init();
 
 	gt64240_irq_init();
 }
diff --git a/arch/mips/pmc-sierra/yosemite/irq.c b/arch/mips/pmc-sierra/yosemite/irq.c
index adb0485..428d1f4 100644
--- a/arch/mips/pmc-sierra/yosemite/irq.c
+++ b/arch/mips/pmc-sierra/yosemite/irq.c
@@ -148,9 +148,9 @@ void __init arch_init_irq(void)
 {
 	clear_c0_status(ST0_IM);
 
-	mips_cpu_irq_init(0);
-	rm7k_cpu_irq_init(8);
-	rm9k_cpu_irq_init(12);
+	mips_cpu_irq_init();
+	rm7k_cpu_irq_init();
+	rm9k_cpu_irq_init();
 
 #ifdef CONFIG_KGDB
 	/* At this point, initialize the second serial port */
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index c44f8be..f3d2ae3 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -19,6 +19,7 @@
 
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
+#include <asm/irq_cpu.h>
 
 #include <asm/sgi/ioc.h>
 #include <asm/sgi/hpc3.h>
@@ -253,8 +254,6 @@ asmlinkage void plat_irq_dispatch(void)
 		indy_8254timer_irq();
 }
 
-extern void mips_cpu_irq_init(unsigned int irq_base);
-
 void __init arch_init_irq(void)
 {
 	int i;
@@ -316,7 +315,7 @@ void __init arch_init_irq(void)
 	sgint->cmeimask1 = 0;
 
 	/* init CPU irqs */
-	mips_cpu_irq_init(SGINT_CPU);
+	mips_cpu_irq_init();
 
 	for (i = SGINT_LOCAL0; i < SGI_INTERRUPTS; i++) {
 		struct irq_chip *handler;
diff --git a/arch/mips/vr41xx/common/irq.c b/arch/mips/vr41xx/common/irq.c
index 397ba94..70b5beb 100644
--- a/arch/mips/vr41xx/common/irq.c
+++ b/arch/mips/vr41xx/common/irq.c
@@ -111,5 +111,5 @@ asmlinkage void plat_irq_dispatch(void)
 
 void __init arch_init_irq(void)
 {
-	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
+	mips_cpu_irq_init();
 }
diff --git a/include/asm-mips/ddb5xxx/ddb5477.h b/include/asm-mips/ddb5xxx/ddb5477.h
index c5af4b7..27655db 100644
--- a/include/asm-mips/ddb5xxx/ddb5477.h
+++ b/include/asm-mips/ddb5xxx/ddb5477.h
@@ -17,6 +17,7 @@
 #ifndef __ASM_DDB5XXX_DDB5477_H
 #define __ASM_DDB5XXX_DDB5477_H
 
+#include <irq.h>
 
 /*
  * This contains macros that are specific to DDB5477 or renamed from
@@ -257,8 +258,8 @@ extern void ll_vrc5477_irq_disable(int v
 #define	DDB_IRQ_BASE		0
 
 #define	I8259_IRQ_BASE		DDB_IRQ_BASE
-#define	VRC5477_IRQ_BASE	(I8259_IRQ_BASE + NUM_I8259_IRQ)
-#define	CPU_IRQ_BASE		(VRC5477_IRQ_BASE + NUM_VRC5477_IRQ)
+#define	CPU_IRQ_BASE		MIPS_CPU_IRQ_BASE
+#define	VRC5477_IRQ_BASE	(CPU_IRQ_BASE + NUM_CPU_IRQ)
 
 /*
  * vrc5477 irq defs
diff --git a/include/asm-mips/dec/interrupts.h b/include/asm-mips/dec/interrupts.h
index 273e4d6..e10d341 100644
--- a/include/asm-mips/dec/interrupts.h
+++ b/include/asm-mips/dec/interrupts.h
@@ -14,6 +14,7 @@
 #ifndef __ASM_DEC_INTERRUPTS_H
 #define __ASM_DEC_INTERRUPTS_H
 
+#include <irq.h>
 #include <asm/mipsregs.h>
 
 
@@ -87,7 +88,7 @@
 #define DEC_CPU_INR_SW1		1	/* software #1 */
 #define DEC_CPU_INR_SW0		0	/* software #0 */
 
-#define DEC_CPU_IRQ_BASE	0	/* first IRQ assigned to CPU */
+#define DEC_CPU_IRQ_BASE	MIPS_CPU_IRQ_BASE	/* first IRQ assigned to CPU */
 
 #define DEC_CPU_IRQ_NR(n)	((n) + DEC_CPU_IRQ_BASE)
 #define DEC_CPU_IRQ_MASK(n)	(1 << ((n) + CAUSEB_IP))
diff --git a/include/asm-mips/emma2rh/emma2rh.h b/include/asm-mips/emma2rh/emma2rh.h
index 4fb8df7..6a1af0a 100644
--- a/include/asm-mips/emma2rh/emma2rh.h
+++ b/include/asm-mips/emma2rh/emma2rh.h
@@ -24,6 +24,8 @@
 #ifndef __ASM_EMMA2RH_EMMA2RH_H
 #define __ASM_EMMA2RH_EMMA2RH_H
 
+#include <irq.h>
+
 /*
  * EMMA2RH registers
  */
@@ -104,7 +106,8 @@
 #define NUM_EMMA2RH_IRQ		96
 
 #define CPU_EMMA2RH_CASCADE	2
-#define EMMA2RH_IRQ_BASE	0
+#define CPU_IRQ_BASE		MIPS_CPU_IRQ_BASE
+#define EMMA2RH_IRQ_BASE	(CPU_IRQ_BASE + NUM_CPU_IRQ)
 
 /*
  * emma2rh irq defs
diff --git a/include/asm-mips/emma2rh/markeins.h b/include/asm-mips/emma2rh/markeins.h
index 8fa7667..973b062 100644
--- a/include/asm-mips/emma2rh/markeins.h
+++ b/include/asm-mips/emma2rh/markeins.h
@@ -33,7 +33,6 @@
 
 #define EMMA2RH_SW_IRQ_BASE	(EMMA2RH_IRQ_BASE + NUM_EMMA2RH_IRQ)
 #define EMMA2RH_GPIO_IRQ_BASE	(EMMA2RH_SW_IRQ_BASE + NUM_EMMA2RH_IRQ_SW)
-#define CPU_IRQ_BASE		(EMMA2RH_GPIO_IRQ_BASE + NUM_EMMA2RH_IRQ_GPIO)
 
 #define EMMA2RH_SW_IRQ_INT0	(0+EMMA2RH_SW_IRQ_BASE)
 #define EMMA2RH_SW_IRQ_INT1	(1+EMMA2RH_SW_IRQ_BASE)
diff --git a/include/asm-mips/irq_cpu.h b/include/asm-mips/irq_cpu.h
index ed3d1e3..ef6a07c 100644
--- a/include/asm-mips/irq_cpu.h
+++ b/include/asm-mips/irq_cpu.h
@@ -13,8 +13,8 @@
 #ifndef _ASM_IRQ_CPU_H
 #define _ASM_IRQ_CPU_H
 
-extern void mips_cpu_irq_init(int irq_base);
-extern void rm7k_cpu_irq_init(int irq_base);
-extern void rm9k_cpu_irq_init(int irq_base);
+extern void mips_cpu_irq_init(void);
+extern void rm7k_cpu_irq_init(void);
+extern void rm9k_cpu_irq_init(void);
 
 #endif /* _ASM_IRQ_CPU_H */
diff --git a/include/asm-mips/mach-cobalt/cobalt.h b/include/asm-mips/mach-cobalt/cobalt.h
index 00b0fc6..24a8d51 100644
--- a/include/asm-mips/mach-cobalt/cobalt.h
+++ b/include/asm-mips/mach-cobalt/cobalt.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_COBALT_H
 #define __ASM_COBALT_H
 
+#include <irq.h>
+
 /*
  * i8259 legacy interrupts used on Cobalt:
  *
@@ -25,7 +27,7 @@
 /*
  * CPU IRQs  are 16 ... 23
  */
-#define COBALT_CPU_IRQ		16
+#define COBALT_CPU_IRQ		MIPS_CPU_IRQ_BASE
 
 #define COBALT_GALILEO_IRQ	(COBALT_CPU_IRQ + 2)
 #define COBALT_SCC_IRQ          (COBALT_CPU_IRQ + 3)	/* pre-production has 85C30 */
diff --git a/include/asm-mips/mach-emma2rh/irq.h b/include/asm-mips/mach-emma2rh/irq.h
index bce6424..5439eb8 100644
--- a/include/asm-mips/mach-emma2rh/irq.h
+++ b/include/asm-mips/mach-emma2rh/irq.h
@@ -10,4 +10,6 @@
 
 #define NR_IRQS	256
 
+#include_next <irq.h>
+
 #endif /* __ASM_MACH_EMMA2RH_IRQ_H */
diff --git a/include/asm-mips/mach-generic/irq.h b/include/asm-mips/mach-generic/irq.h
index 500e10f..91e6778 100644
--- a/include/asm-mips/mach-generic/irq.h
+++ b/include/asm-mips/mach-generic/irq.h
@@ -8,6 +8,32 @@
 #ifndef __ASM_MACH_GENERIC_IRQ_H
 #define __ASM_MACH_GENERIC_IRQ_H
 
+#ifndef NR_IRQS
 #define NR_IRQS	128
+#endif
+
+#ifdef CONFIG_IRQ_CPU
+
+#ifndef MIPS_CPU_IRQ_BASE
+#ifdef CONFIG_I8259
+#define MIPS_CPU_IRQ_BASE 16
+#else
+#define MIPS_CPU_IRQ_BASE 0
+#endif /* CONFIG_I8259 */
+#endif
+
+#ifdef CONFIG_IRQ_CPU_RM7K
+#ifndef RM7K_CPU_IRQ_BASE
+#define RM7K_CPU_IRQ_BASE (MIPS_CPU_IRQ_BASE+8)
+#endif
+#endif
+
+#ifdef CONFIG_IRQ_CPU_RM9K
+#ifndef RM9K_CPU_IRQ_BASE
+#define RM9K_CPU_IRQ_BASE (MIPS_CPU_IRQ_BASE+12)
+#endif
+#endif
+
+#endif /* CONFIG_IRQ_CPU */
 
 #endif /* __ASM_MACH_GENERIC_IRQ_H */
diff --git a/include/asm-mips/mach-mips/irq.h b/include/asm-mips/mach-mips/irq.h
index e994b0c..9b9da26 100644
--- a/include/asm-mips/mach-mips/irq.h
+++ b/include/asm-mips/mach-mips/irq.h
@@ -4,4 +4,6 @@
 
 #define NR_IRQS	256
 
+#include_next <irq.h>
+
 #endif /* __ASM_MACH_MIPS_IRQ_H */
diff --git a/include/asm-mips/mach-vr41xx/irq.h b/include/asm-mips/mach-vr41xx/irq.h
new file mode 100644
index 0000000..862058d
--- /dev/null
+++ b/include/asm-mips/mach-vr41xx/irq.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_MACH_VR41XX_IRQ_H
+#define __ASM_MACH_VR41XX_IRQ_H
+
+#include <asm/vr41xx/irq.h> /* for MIPS_CPU_IRQ_BASE */
+
+#include_next <irq.h>
+
+#endif /* __ASM_MACH_VR41XX_IRQ_H */
diff --git a/include/asm-mips/mips-boards/atlasint.h b/include/asm-mips/mips-boards/atlasint.h
index b15e4ea..76add42 100644
--- a/include/asm-mips/mips-boards/atlasint.h
+++ b/include/asm-mips/mips-boards/atlasint.h
@@ -26,10 +26,12 @@
 #ifndef _MIPS_ATLASINT_H
 #define _MIPS_ATLASINT_H
 
+#include <irq.h>
+
 /*
  * Interrupts 0..7 are used for Atlas CPU interrupts (nonEIC mode)
  */
-#define MIPSCPU_INT_BASE	0
+#define MIPSCPU_INT_BASE	MIPS_CPU_IRQ_BASE
 
 /* CPU interrupt offsets */
 #define MIPSCPU_INT_SW0		0
diff --git a/include/asm-mips/mips-boards/maltaint.h b/include/asm-mips/mips-boards/maltaint.h
index da6cc2f..9180d64 100644
--- a/include/asm-mips/mips-boards/maltaint.h
+++ b/include/asm-mips/mips-boards/maltaint.h
@@ -25,6 +25,8 @@
 #ifndef _MIPS_MALTAINT_H
 #define _MIPS_MALTAINT_H
 
+#include <irq.h>
+
 /*
  * Interrupts 0..15 are used for Malta ISA compatible interrupts
  */
@@ -33,7 +35,7 @@
 /*
  * Interrupts 16..23 are used for Malta CPU interrupts (nonEIC mode)
  */
-#define MIPSCPU_INT_BASE	16
+#define MIPSCPU_INT_BASE	MIPS_CPU_IRQ_BASE
 
 /* CPU interrupt offsets */
 #define MIPSCPU_INT_SW0		0
diff --git a/include/asm-mips/mips-boards/seadint.h b/include/asm-mips/mips-boards/seadint.h
index 365c2a3..4f6a393 100644
--- a/include/asm-mips/mips-boards/seadint.h
+++ b/include/asm-mips/mips-boards/seadint.h
@@ -20,10 +20,12 @@
 #ifndef _MIPS_SEADINT_H
 #define _MIPS_SEADINT_H
 
+#include <irq.h>
+
 /*
  * Interrupts 0..7 are used for SEAD CPU interrupts
  */
-#define MIPSCPU_INT_BASE	0
+#define MIPSCPU_INT_BASE	MIPS_CPU_IRQ_BASE
 
 #define MIPSCPU_INT_UART0	2
 #define MIPSCPU_INT_UART1	3
diff --git a/include/asm-mips/mips-boards/simint.h b/include/asm-mips/mips-boards/simint.h
index 4952e0b..54f2fe6 100644
--- a/include/asm-mips/mips-boards/simint.h
+++ b/include/asm-mips/mips-boards/simint.h
@@ -17,10 +17,11 @@
 #ifndef _MIPS_SIMINT_H
 #define _MIPS_SIMINT_H
 
+#include <irq.h>
 
 #define SIM_INT_BASE		0
 #define MIPSCPU_INT_MB0		2
-#define MIPSCPU_INT_BASE	16
+#define MIPSCPU_INT_BASE	MIPS_CPU_IRQ_BASE
 #define MIPS_CPU_TIMER_IRQ	7
 
 
diff --git a/include/asm-mips/rtlx.h b/include/asm-mips/rtlx.h
index 76cd51c..59162f7 100644
--- a/include/asm-mips/rtlx.h
+++ b/include/asm-mips/rtlx.h
@@ -6,9 +6,10 @@
 #ifndef __ASM_RTLX_H
 #define __ASM_RTLX_H_
 
+#include <irq.h>
+
 #define LX_NODE_BASE 10
 
-#define MIPSCPU_INT_BASE       16
 #define MIPS_CPU_RTLX_IRQ 0
 
 #define RTLX_VERSION 2
diff --git a/include/asm-mips/sgi/ip22.h b/include/asm-mips/sgi/ip22.h
index bbfc05c..6592f3b 100644
--- a/include/asm-mips/sgi/ip22.h
+++ b/include/asm-mips/sgi/ip22.h
@@ -21,15 +21,16 @@
  * HAL2 driver). This will prevent many complications, trust me ;-)
  */
 
+#include <irq.h>
 #include <asm/sgi/ioc.h>
 
 #define SGINT_EISA	0	/* 16 EISA irq levels (Indigo2) */
-#define SGINT_CPU	16	/* MIPS CPU define 8 interrupt sources */
-#define SGINT_LOCAL0	24	/* 8 local0 irq levels */
-#define SGINT_LOCAL1	32	/* 8 local1 irq levels */
-#define SGINT_LOCAL2	40	/* 8 local2 vectored irq levels */
-#define SGINT_LOCAL3	48	/* 8 local3 vectored irq levels */
-#define SGINT_END	56	/* End of 'spaces' */
+#define SGINT_CPU	MIPS_CPU_IRQ_BASE	/* MIPS CPU define 8 interrupt sources */
+#define SGINT_LOCAL0	(SGINT_CPU+8)	/* 8 local0 irq levels */
+#define SGINT_LOCAL1	(SGINT_CPU+16)	/* 8 local1 irq levels */
+#define SGINT_LOCAL2	(SGINT_CPU+24)	/* 8 local2 vectored irq levels */
+#define SGINT_LOCAL3	(SGINT_CPU+32)	/* 8 local3 vectored irq levels */
+#define SGINT_END	(SGINT_CPU+40)	/* End of 'spaces' */
 
 /*
  * Individual interrupt definitions for the Indy and Indigo2
