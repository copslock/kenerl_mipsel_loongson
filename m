Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 17:21:17 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:6427 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28573740AbWLARVM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 17:21:12 +0000
Received: by nf-out-0910.google.com with SMTP id l24so3480348nfc
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 09:21:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=GezxrujMy1cscXqmDkF7d6MYQewOxmEZGNHgdaYvcFDDCZUeDZihCQeMTqmxoWGQwGt9xgJDCQEpMC+I5yvvfDx3BE+qwayY63e5pJM9k5zuMctixiW7eSXWxJbX4yM1CJMGD/LiSxwnZ3CfQdaQrRTt7qykbz0qz5qRndi3/sI=
Received: by 10.48.220.12 with SMTP id s12mr9539660nfg.1164993671064;
        Fri, 01 Dec 2006 09:21:11 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id d2sm37682224nfe.2006.12.01.09.21.09;
        Fri, 01 Dec 2006 09:21:10 -0800 (PST)
Message-ID: <457064D3.3030705@innova-card.com>
Date:	Fri, 01 Dec 2006 18:22:27 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, macro@linux-mips.org,
	sshtylyov@ru.mvista.com, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Compile __do_IRQ() when really needed [take #3]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

__do_IRQ() is needed only by irq handlers that can't use
default handlers defined in kernel/irq/chip.c.

For others platforms there's no need to compile this function
since it won't be used. For those platforms this patch defines
GENERIC_HARDIRQS_NO__DO_IRQ symbol which is used exactly for
this purpose.

Futhermore for platforms which do not use __do_IRQ(), end()
method which is part of the 'irq_chip' structure is not used.
This patch simply removes this method in this case.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Thanks for your feedbacks and sorry for the crap I previously
 sent...

 arch/mips/Kconfig                                  |    9 ++++++
 arch/mips/dec/ioasic-irq.c                         |    1 -
 arch/mips/dec/kn02-irq.c                           |    7 -----
 arch/mips/emma2rh/common/irq_emma2rh.c             |    7 -----
 arch/mips/emma2rh/markeins/irq_markeins.c          |    7 -----
 arch/mips/jazz/irq.c                               |    7 -----
 arch/mips/kernel/irq-mv6434x.c                     |   10 -------
 arch/mips/kernel/irq-rm7000.c                      |    7 -----
 arch/mips/kernel/irq-rm9000.c                      |    8 -----
 arch/mips/kernel/irq_cpu.c                         |    7 -----
 arch/mips/lasat/interrupt.c                        |    7 -----
 arch/mips/momentum/ocelot_c/cpci-irq.c             |   10 -------
 arch/mips/momentum/ocelot_c/uart-irq.c             |   10 -------
 arch/mips/philips/pnx8550/common/int.c             |    8 -----
 arch/mips/sgi-ip22/ip22-int.c                      |   28 --------------------
 arch/mips/sgi-ip27/ip27-irq.c                      |    8 -----
 arch/mips/sgi-ip27/ip27-timer.c                    |    5 ---
 arch/mips/tx4927/common/tx4927_irq.c               |   26 ------------------
 .../tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |   21 ---------------
 arch/mips/tx4938/common/irq.c                      |   20 --------------
 arch/mips/tx4938/toshiba_rbtx4938/irq.c            |   10 -------
 arch/mips/vr41xx/Kconfig                           |    5 +++
 arch/mips/vr41xx/common/icu.c                      |   14 ----------
 23 files changed, 14 insertions(+), 228 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5ff94e5..0dfa941 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -233,6 +233,7 @@ config LASAT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config MIPS_ATLAS
 	bool "MIPS Atlas board"
@@ -256,6 +257,7 @@ config MIPS_ATLAS
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MULTITHREADING if EXPERIMENTAL
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This enables support for the MIPS Technologies Atlas evaluation
 	  board.
@@ -410,6 +412,7 @@ config MOMENCO_OCELOT_C
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
@@ -558,6 +561,7 @@ config SGI_IP27
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SMP
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
 	  workstations.  To compile a Linux kernel that runs on these, say Y
@@ -824,6 +828,10 @@ config SCHED_NO_NO_OMIT_FRAME_POINTER
 	bool
 	default y
 
+config GENERIC_HARDIRQS_NO__DO_IRQ
+	bool
+	default n
+
 #
 # Select some configuration options automatically based on user selections.
 #
@@ -985,6 +993,7 @@ config SOC_PNX8550
 	select HW_HAS_PCI
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config SWAP_IO_SPACE
 	bool
diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
index 269b22b..c7391bb 100644
--- a/arch/mips/dec/ioasic-irq.c
+++ b/arch/mips/dec/ioasic-irq.c
@@ -67,7 +67,6 @@ static struct irq_chip ioasic_irq_type =
 	.mask = mask_ioasic_irq,
 	.mask_ack = ack_ioasic_irq,
 	.unmask = unmask_ioasic_irq,
-	.end = end_ioasic_irq,
 };
 
 
diff --git a/arch/mips/dec/kn02-irq.c b/arch/mips/dec/kn02-irq.c
index 5a9be4c..916e46b 100644
--- a/arch/mips/dec/kn02-irq.c
+++ b/arch/mips/dec/kn02-irq.c
@@ -57,19 +57,12 @@ static void ack_kn02_irq(unsigned int ir
 	iob();
 }
 
-static void end_kn02_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_kn02_irq(irq);
-}
-
 static struct irq_chip kn02_irq_type = {
 	.typename = "KN02-CSR",
 	.ack = ack_kn02_irq,
 	.mask = mask_kn02_irq,
 	.mask_ack = ack_kn02_irq,
 	.unmask = unmask_kn02_irq,
-	.end = end_kn02_irq,
 };
 
 
diff --git a/arch/mips/emma2rh/common/irq_emma2rh.c b/arch/mips/emma2rh/common/irq_emma2rh.c
index 59b9829..8d880f0 100644
--- a/arch/mips/emma2rh/common/irq_emma2rh.c
+++ b/arch/mips/emma2rh/common/irq_emma2rh.c
@@ -56,19 +56,12 @@ static void emma2rh_irq_disable(unsigned
 	ll_emma2rh_irq_disable(irq - emma2rh_irq_base);
 }
 
-static void emma2rh_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		ll_emma2rh_irq_enable(irq - emma2rh_irq_base);
-}
-
 struct irq_chip emma2rh_irq_controller = {
 	.typename = "emma2rh_irq",
 	.ack = emma2rh_irq_disable,
 	.mask = emma2rh_irq_disable,
 	.mask_ack = emma2rh_irq_disable,
 	.unmask = emma2rh_irq_enable,
-	.end = emma2rh_irq_end,
 };
 
 void emma2rh_irq_init(u32 irq_base)
diff --git a/arch/mips/emma2rh/markeins/irq_markeins.c b/arch/mips/emma2rh/markeins/irq_markeins.c
index 3ac4e40..2116d9b 100644
--- a/arch/mips/emma2rh/markeins/irq_markeins.c
+++ b/arch/mips/emma2rh/markeins/irq_markeins.c
@@ -48,19 +48,12 @@ static void emma2rh_sw_irq_disable(unsig
 	ll_emma2rh_sw_irq_disable(irq - emma2rh_sw_irq_base);
 }
 
-static void emma2rh_sw_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		ll_emma2rh_sw_irq_enable(irq - emma2rh_sw_irq_base);
-}
-
 struct irq_chip emma2rh_sw_irq_controller = {
 	.typename = "emma2rh_sw_irq",
 	.ack = emma2rh_sw_irq_disable,
 	.mask = emma2rh_sw_irq_disable,
 	.mask_ack = emma2rh_sw_irq_disable,
 	.unmask = emma2rh_sw_irq_enable,
-	.end = emma2rh_sw_irq_end,
 };
 
 void emma2rh_sw_irq_init(u32 irq_base)
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 5c4f50c..f8d417b 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -39,19 +39,12 @@ void disable_r4030_irq(unsigned int irq)
 	spin_unlock_irqrestore(&r4030_lock, flags);
 }
 
-static void end_r4030_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_r4030_irq(irq);
-}
-
 static struct irq_chip r4030_irq_type = {
 	.typename = "R4030",
 	.ack = disable_r4030_irq,
 	.mask = disable_r4030_irq,
 	.mask_ack = disable_r4030_irq,
 	.unmask = enable_r4030_irq,
-	.end = end_r4030_irq,
 };
 
 void __init init_r4030_ints(void)
diff --git a/arch/mips/kernel/irq-mv6434x.c b/arch/mips/kernel/irq-mv6434x.c
index 6cfb31c..efbd219 100644
--- a/arch/mips/kernel/irq-mv6434x.c
+++ b/arch/mips/kernel/irq-mv6434x.c
@@ -67,15 +67,6 @@ static inline void unmask_mv64340_irq(un
 }
 
 /*
- * End IRQ processing
- */
-static void end_mv64340_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		unmask_mv64340_irq(irq);
-}
-
-/*
  * Interrupt handler for interrupts coming from the Marvell chip.
  * It could be built in ethernet ports etc...
  */
@@ -106,7 +97,6 @@ struct irq_chip mv64340_irq_type = {
 	.mask = mask_mv64340_irq,
 	.mask_ack = mask_mv64340_irq,
 	.unmask = unmask_mv64340_irq,
-	.end = end_mv64340_irq,
 };
 
 void __init mv64340_irq_init(unsigned int base)
diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index ddcc2a5..123324b 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -29,19 +29,12 @@ static inline void mask_rm7k_irq(unsigne
 	clear_c0_intcontrol(0x100 << (irq - irq_base));
 }
 
-static void rm7k_cpu_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_rm7k_irq(irq);
-}
-
 static struct irq_chip rm7k_irq_controller = {
 	.typename = "RM7000",
 	.ack = mask_rm7k_irq,
 	.mask = mask_rm7k_irq,
 	.mask_ack = mask_rm7k_irq,
 	.unmask = unmask_rm7k_irq,
-	.end = rm7k_cpu_irq_end,
 };
 
 void __init rm7k_cpu_irq_init(int base)
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index ba6440c..0e6f4c5 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -80,19 +80,12 @@ static void rm9k_perfcounter_irq_shutdow
 	on_each_cpu(local_rm9k_perfcounter_irq_shutdown, (void *) irq, 0, 1);
 }
 
-static void rm9k_cpu_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_rm9k_irq(irq);
-}
-
 static struct irq_chip rm9k_irq_controller = {
 	.typename = "RM9000",
 	.ack = mask_rm9k_irq,
 	.mask = mask_rm9k_irq,
 	.mask_ack = mask_rm9k_irq,
 	.unmask = unmask_rm9k_irq,
-	.end = rm9k_cpu_irq_end,
 };
 
 static struct irq_chip rm9k_perfcounter_irq = {
@@ -103,7 +96,6 @@ static struct irq_chip rm9k_perfcounter_
 	.mask = mask_rm9k_irq,
 	.mask_ack = mask_rm9k_irq,
 	.unmask = unmask_rm9k_irq,
-	.end = rm9k_cpu_irq_end,
 };
 
 unsigned int rm9000_perfcount_irq;
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index be5ac23..7634a66 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -50,12 +50,6 @@ static inline void mask_mips_irq(unsigne
 	irq_disable_hazard();
 }
 
-static void mips_cpu_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		unmask_mips_irq(irq);
-}
-
 static struct irq_chip mips_cpu_irq_controller = {
 	.typename	= "MIPS",
 	.ack		= mask_mips_irq,
@@ -63,7 +57,6 @@ static struct irq_chip mips_cpu_irq_cont
 	.mask_ack	= mask_mips_irq,
 	.unmask		= unmask_mips_irq,
 	.eoi		= unmask_mips_irq,
-	.end		= mips_cpu_irq_end,
 };
 
 /*
diff --git a/arch/mips/lasat/interrupt.c b/arch/mips/lasat/interrupt.c
index 4a84a7b..2affa5f 100644
--- a/arch/mips/lasat/interrupt.c
+++ b/arch/mips/lasat/interrupt.c
@@ -44,19 +44,12 @@ void enable_lasat_irq(unsigned int irq_n
 	*lasat_int_mask |= (1 << irq_nr) << lasat_int_mask_shift;
 }
 
-static void end_lasat_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_lasat_irq(irq);
-}
-
 static struct irq_chip lasat_irq_type = {
 	.typename = "Lasat",
 	.ack = disable_lasat_irq,
 	.mask = disable_lasat_irq,
 	.mask_ack = disable_lasat_irq,
 	.unmask = enable_lasat_irq,
-	.end = end_lasat_irq,
 };
 
 static inline int ls1bit32(unsigned int x)
diff --git a/arch/mips/momentum/ocelot_c/cpci-irq.c b/arch/mips/momentum/ocelot_c/cpci-irq.c
index e5a4a0a..bb11fef 100644
--- a/arch/mips/momentum/ocelot_c/cpci-irq.c
+++ b/arch/mips/momentum/ocelot_c/cpci-irq.c
@@ -66,15 +66,6 @@ static inline void unmask_cpci_irq(unsig
 }
 
 /*
- * End IRQ processing
- */
-static void end_cpci_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		unmask_cpci_irq(irq);
-}
-
-/*
  * Interrupt handler for interrupts coming from the FPGA chip.
  * It could be built in ethernet ports etc...
  */
@@ -98,7 +89,6 @@ struct irq_chip cpci_irq_type = {
 	.mask = mask_cpci_irq,
 	.mask_ack = mask_cpci_irq,
 	.unmask = unmask_cpci_irq,
-	.end = end_cpci_irq,
 };
 
 void cpci_irq_init(void)
diff --git a/arch/mips/momentum/ocelot_c/uart-irq.c b/arch/mips/momentum/ocelot_c/uart-irq.c
index 0029f00..a7a80c0 100644
--- a/arch/mips/momentum/ocelot_c/uart-irq.c
+++ b/arch/mips/momentum/ocelot_c/uart-irq.c
@@ -60,15 +60,6 @@ static inline void unmask_uart_irq(unsig
 }
 
 /*
- * End IRQ processing
- */
-static void end_uart_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		unmask_uart_irq(irq);
-}
-
-/*
  * Interrupt handler for interrupts coming from the FPGA chip.
  */
 void ll_uart_irq(void)
@@ -91,7 +82,6 @@ struct irq_chip uart_irq_type = {
 	.mask = mask_uart_irq,
 	.mask_ack = mask_uart_irq,
 	.unmask = unmask_uart_irq,
-	.end = end_uart_irq,
 };
 
 void uart_irq_init(void)
diff --git a/arch/mips/philips/pnx8550/common/int.c b/arch/mips/philips/pnx8550/common/int.c
index 0dc2393..2c36c10 100644
--- a/arch/mips/philips/pnx8550/common/int.c
+++ b/arch/mips/philips/pnx8550/common/int.c
@@ -158,20 +158,12 @@ int pnx8550_set_gic_priority(int irq, in
 	return prev_priority;
 }
 
-static void end_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
-		unmask_irq(irq);
-	}
-}
-
 static struct irq_chip level_irq_type = {
 	.typename =	"PNX Level IRQ",
 	.ack =		mask_irq,
 	.mask =		mask_irq,
 	.mask_ack =	mask_irq,
 	.unmask =	unmask_irq,
-	.end =		end_irq,
 };
 
 static struct irqaction gic_action = {
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index c7b1380..c44f8be 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -51,19 +51,12 @@ static void disable_local0_irq(unsigned
 	sgint->imask0 &= ~(1 << (irq - SGINT_LOCAL0));
 }
 
-static void end_local0_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_local0_irq(irq);
-}
-
 static struct irq_chip ip22_local0_irq_type = {
 	.typename	= "IP22 local 0",
 	.ack		= disable_local0_irq,
 	.mask		= disable_local0_irq,
 	.mask_ack	= disable_local0_irq,
 	.unmask		= enable_local0_irq,
-	.end		= end_local0_irq,
 };
 
 static void enable_local1_irq(unsigned int irq)
@@ -79,19 +72,12 @@ void disable_local1_irq(unsigned int irq
 	sgint->imask1 &= ~(1 << (irq - SGINT_LOCAL1));
 }
 
-static void end_local1_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_local1_irq(irq);
-}
-
 static struct irq_chip ip22_local1_irq_type = {
 	.typename	= "IP22 local 1",
 	.ack		= disable_local1_irq,
 	.mask		= disable_local1_irq,
 	.mask_ack	= disable_local1_irq,
 	.unmask		= enable_local1_irq,
-	.end		= end_local1_irq,
 };
 
 static void enable_local2_irq(unsigned int irq)
@@ -107,19 +93,12 @@ void disable_local2_irq(unsigned int irq
 		sgint->imask0 &= ~(1 << (SGI_MAP_0_IRQ - SGINT_LOCAL0));
 }
 
-static void end_local2_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_local2_irq(irq);
-}
-
 static struct irq_chip ip22_local2_irq_type = {
 	.typename	= "IP22 local 2",
 	.ack		= disable_local2_irq,
 	.mask		= disable_local2_irq,
 	.mask_ack	= disable_local2_irq,
 	.unmask		= enable_local2_irq,
-	.end		= end_local2_irq,
 };
 
 static void enable_local3_irq(unsigned int irq)
@@ -135,19 +114,12 @@ void disable_local3_irq(unsigned int irq
 		sgint->imask1 &= ~(1 << (SGI_MAP_1_IRQ - SGINT_LOCAL1));
 }
 
-static void end_local3_irq (unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_local3_irq(irq);
-}
-
 static struct irq_chip ip22_local3_irq_type = {
 	.typename	= "IP22 local 3",
 	.ack		= disable_local3_irq,
 	.mask		= disable_local3_irq,
 	.mask_ack	= disable_local3_irq,
 	.unmask		= enable_local3_irq,
-	.end		= end_local3_irq,
 };
 
 static void indy_local0_irqdispatch(void)
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 5f8835b..319f880 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -332,13 +332,6 @@ static inline void disable_bridge_irq(un
 	intr_disconnect_level(cpu, swlevel);
 }
 
-static void end_bridge_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
-	    irq_desc[irq].action)
-		enable_bridge_irq(irq);
-}
-
 static struct irq_chip bridge_irq_type = {
 	.typename	= "bridge",
 	.startup	= startup_bridge_irq,
@@ -347,7 +340,6 @@ static struct irq_chip bridge_irq_type =
 	.mask		= disable_bridge_irq,
 	.mask_ack	= disable_bridge_irq,
 	.unmask		= enable_bridge_irq,
-	.end		= end_bridge_irq,
 };
 
 void __devinit register_bridge_irq(unsigned int irq)
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 7d36172..c20e989 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -180,10 +180,6 @@ static void disable_rt_irq(unsigned int
 {
 }
 
-static void end_rt_irq(unsigned int irq)
-{
-}
-
 static struct irq_chip rt_irq_type = {
 	.typename	= "SN HUB RT timer",
 	.ack		= disable_rt_irq,
@@ -191,7 +187,6 @@ static struct irq_chip rt_irq_type = {
 	.mask_ack	= disable_rt_irq,
 	.unmask		= enable_rt_irq,
 	.eoi		= enable_rt_irq,
-	.end		= end_rt_irq,
 };
 
 static struct irqaction rt_irqaction = {
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index 21873de..ed4a19a 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -66,12 +66,10 @@
 #define TX4927_IRQ_CP0_INIT     ( 1 << 10 )
 #define TX4927_IRQ_CP0_ENABLE   ( 1 << 13 )
 #define TX4927_IRQ_CP0_DISABLE  ( 1 << 14 )
-#define TX4927_IRQ_CP0_ENDIRQ   ( 1 << 16 )
 
 #define TX4927_IRQ_PIC_INIT     ( 1 << 20 )
 #define TX4927_IRQ_PIC_ENABLE   ( 1 << 23 )
 #define TX4927_IRQ_PIC_DISABLE  ( 1 << 24 )
-#define TX4927_IRQ_PIC_ENDIRQ   ( 1 << 26 )
 
 #define TX4927_IRQ_ALL         0xffffffff
 #endif
@@ -82,12 +80,10 @@ static const u32 tx4927_irq_debug_flag =
 					  | TX4927_IRQ_WARN | TX4927_IRQ_EROR
 //                                       | TX4927_IRQ_CP0_INIT
 //                                       | TX4927_IRQ_CP0_ENABLE
-//                                       | TX4927_IRQ_CP0_DISABLE
 //                                       | TX4927_IRQ_CP0_ENDIRQ
 //                                       | TX4927_IRQ_PIC_INIT
 //                                       | TX4927_IRQ_PIC_ENABLE
 //                                       | TX4927_IRQ_PIC_DISABLE
-//                                       | TX4927_IRQ_PIC_ENDIRQ
 //                                       | TX4927_IRQ_INIT
 //                                       | TX4927_IRQ_NEST1
 //                                       | TX4927_IRQ_NEST2
@@ -114,11 +110,9 @@ static const u32 tx4927_irq_debug_flag =
 
 static void tx4927_irq_cp0_enable(unsigned int irq);
 static void tx4927_irq_cp0_disable(unsigned int irq);
-static void tx4927_irq_cp0_end(unsigned int irq);
 
 static void tx4927_irq_pic_enable(unsigned int irq);
 static void tx4927_irq_pic_disable(unsigned int irq);
-static void tx4927_irq_pic_end(unsigned int irq);
 
 /*
  * Kernel structs for all pic's
@@ -131,7 +125,6 @@ static struct irq_chip tx4927_irq_cp0_ty
 	.mask		= tx4927_irq_cp0_disable,
 	.mask_ack	= tx4927_irq_cp0_disable,
 	.unmask		= tx4927_irq_cp0_enable,
-	.end		= tx4927_irq_cp0_end,
 };
 
 #define TX4927_PIC_NAME "TX4927-PIC"
@@ -141,7 +134,6 @@ static struct irq_chip tx4927_irq_pic_ty
 	.mask		= tx4927_irq_pic_disable,
 	.mask_ack	= tx4927_irq_pic_disable,
 	.unmask		= tx4927_irq_pic_enable,
-	.end		= tx4927_irq_pic_end,
 };
 
 #define TX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
@@ -214,15 +206,6 @@ static void tx4927_irq_cp0_disable(unsig
 	tx4927_irq_cp0_modify(CCP0_STATUS, tx4927_irq_cp0_mask(irq), 0);
 }
 
-static void tx4927_irq_cp0_end(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_ENDIRQ, "irq=%d \n", irq);
-
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		tx4927_irq_cp0_enable(irq);
-	}
-}
-
 /*
  * Functions for pic
  */
@@ -376,15 +359,6 @@ static void tx4927_irq_pic_disable(unsig
 			      tx4927_irq_pic_mask(irq), 0);
 }
 
-static void tx4927_irq_pic_end(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_ENDIRQ, "irq=%d\n", irq);
-
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		tx4927_irq_pic_enable(irq);
-	}
-}
-
 /*
  * Main init functions
  */
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index 34cdb2a..5a5ea6c 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -153,7 +153,6 @@ JP7 is not bus master -- do NOT use -- o
 #define TOSHIBA_RBTX4927_IRQ_IOC_INIT      ( 1 << 10 )
 #define TOSHIBA_RBTX4927_IRQ_IOC_ENABLE    ( 1 << 13 )
 #define TOSHIBA_RBTX4927_IRQ_IOC_DISABLE   ( 1 << 14 )
-#define TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ    ( 1 << 16 )
 
 #define TOSHIBA_RBTX4927_IRQ_ISA_INIT      ( 1 << 20 )
 #define TOSHIBA_RBTX4927_IRQ_ISA_ENABLE    ( 1 << 23 )
@@ -172,7 +171,6 @@ static const u32 toshiba_rbtx4927_irq_de
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_INIT
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_ENABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_DISABLE
-//                                                 | TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_INIT
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_ENABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_DISABLE
@@ -223,7 +221,6 @@ extern void mask_and_ack_8259A(unsigned
 
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
-static void toshiba_rbtx4927_irq_ioc_end(unsigned int irq);
 
 #ifdef CONFIG_TOSHIBA_FPCIB0
 static void toshiba_rbtx4927_irq_isa_enable(unsigned int irq);
@@ -239,7 +236,6 @@ static struct irq_chip toshiba_rbtx4927_
 	.mask = toshiba_rbtx4927_irq_ioc_disable,
 	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
 	.unmask = toshiba_rbtx4927_irq_ioc_enable,
-	.end = toshiba_rbtx4927_irq_ioc_end,
 };
 #define TOSHIBA_RBTX4927_IOC_INTR_ENAB 0xbc002000
 #define TOSHIBA_RBTX4927_IOC_INTR_STAT 0xbc002006
@@ -388,23 +384,6 @@ static void toshiba_rbtx4927_irq_ioc_dis
 	TOSHIBA_RBTX4927_WR08(TOSHIBA_RBTX4927_IOC_INTR_ENAB, v);
 }
 
-static void toshiba_rbtx4927_irq_ioc_end(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_IOC_ENDIRQ,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_IOC_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_IOC_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		toshiba_rbtx4927_irq_ioc_enable(irq);
-	}
-}
-
 
 /**********************************************************************************/
 /* Functions for isa                                                              */
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
index 42e1276..a347b42 100644
--- a/arch/mips/tx4938/common/irq.c
+++ b/arch/mips/tx4938/common/irq.c
@@ -39,11 +39,9 @@
 
 static void tx4938_irq_cp0_enable(unsigned int irq);
 static void tx4938_irq_cp0_disable(unsigned int irq);
-static void tx4938_irq_cp0_end(unsigned int irq);
 
 static void tx4938_irq_pic_enable(unsigned int irq);
 static void tx4938_irq_pic_disable(unsigned int irq);
-static void tx4938_irq_pic_end(unsigned int irq);
 
 /**********************************************************************************/
 /* Kernel structs for all pic's                                                   */
@@ -56,7 +54,6 @@ static struct irq_chip tx4938_irq_cp0_ty
 	.mask = tx4938_irq_cp0_disable,
 	.mask_ack = tx4938_irq_cp0_disable,
 	.unmask = tx4938_irq_cp0_enable,
-	.end = tx4938_irq_cp0_end,
 };
 
 #define TX4938_PIC_NAME "TX4938-PIC"
@@ -66,7 +63,6 @@ static struct irq_chip tx4938_irq_pic_ty
 	.mask = tx4938_irq_pic_disable,
 	.mask_ack = tx4938_irq_pic_disable,
 	.unmask = tx4938_irq_pic_enable,
-	.end = tx4938_irq_pic_end,
 };
 
 static struct irqaction tx4938_irq_pic_action = {
@@ -104,14 +100,6 @@ tx4938_irq_cp0_disable(unsigned int irq)
 	clear_c0_status(tx4938_irq_cp0_mask(irq));
 }
 
-static void
-tx4938_irq_cp0_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		tx4938_irq_cp0_enable(irq);
-	}
-}
-
 /**********************************************************************************/
 /* Functions for pic                                                              */
 /**********************************************************************************/
@@ -269,14 +257,6 @@ tx4938_irq_pic_disable(unsigned int irq)
 			      tx4938_irq_pic_mask(irq), 0);
 }
 
-static void
-tx4938_irq_pic_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		tx4938_irq_pic_enable(irq);
-	}
-}
-
 /**********************************************************************************/
 /* Main init functions                                                            */
 /**********************************************************************************/
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index 8c87a35..b6f363d 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -89,7 +89,6 @@ IRQ  Device
 
 static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq);
-static void toshiba_rbtx4938_irq_ioc_end(unsigned int irq);
 
 #define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
 static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
@@ -98,7 +97,6 @@ static struct irq_chip toshiba_rbtx4938_
 	.mask = toshiba_rbtx4938_irq_ioc_disable,
 	.mask_ack = toshiba_rbtx4938_irq_ioc_disable,
 	.unmask = toshiba_rbtx4938_irq_ioc_enable,
-	.end = toshiba_rbtx4938_irq_ioc_end,
 };
 
 #define TOSHIBA_RBTX4938_IOC_INTR_ENAB 0xb7f02000
@@ -167,14 +165,6 @@ toshiba_rbtx4938_irq_ioc_disable(unsigne
 	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
 }
 
-static void
-toshiba_rbtx4938_irq_ioc_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		toshiba_rbtx4938_irq_ioc_enable(irq);
-	}
-}
-
 extern void __init txx9_spi_irqinit(int irc_irq);
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/vr41xx/Kconfig b/arch/mips/vr41xx/Kconfig
index 92f41f6..c8dfd80 100644
--- a/arch/mips/vr41xx/Kconfig
+++ b/arch/mips/vr41xx/Kconfig
@@ -6,6 +6,7 @@ config CASIO_E55
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config IBM_WORKPAD
 	bool "Support for IBM WorkPad z50"
@@ -15,6 +16,7 @@ config IBM_WORKPAD
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config NEC_CMBVR4133
 	bool "Support for NEC CMB-VR4133"
@@ -39,6 +41,7 @@ config TANBAC_TB022X
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  The TANBAC VR4131 multichip module(TB0225) and
 	  the TANBAC VR4131DIMM(TB0229) are MIPS-based platforms
@@ -71,6 +74,7 @@ config VICTOR_MPC30X
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config ZAO_CAPCELLA
 	bool "Support for ZAO Networks Capcella"
@@ -80,6 +84,7 @@ config ZAO_CAPCELLA
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config PCI_VR41XX
 	bool "Add PCI control unit support of NEC VR4100 series"
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index 54b92a7..c075261 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -427,19 +427,12 @@ static void enable_sysint1_irq(unsigned
 	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
-static void end_sysint1_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
-}
-
 static struct irq_chip sysint1_irq_type = {
 	.typename	= "SYSINT1",
 	.ack		= disable_sysint1_irq,
 	.mask		= disable_sysint1_irq,
 	.mask_ack	= disable_sysint1_irq,
 	.unmask		= enable_sysint1_irq,
-	.end		= end_sysint1_irq,
 };
 
 static void disable_sysint2_irq(unsigned int irq)
@@ -452,19 +445,12 @@ static void enable_sysint2_irq(unsigned
 	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
-static void end_sysint2_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
-}
-
 static struct irq_chip sysint2_irq_type = {
 	.typename	= "SYSINT2",
 	.ack		= disable_sysint2_irq,
 	.mask		= disable_sysint2_irq,
 	.mask_ack	= disable_sysint2_irq,
 	.unmask		= enable_sysint2_irq,
-	.end		= end_sysint2_irq,
 };
 
 static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
-- 
1.4.4.1
