Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 16:55:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:64991 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037690AbWLGQzM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 16:55:12 +0000
Received: from localhost (p8245-ipad29funabasi.chiba.ocn.ne.jp [221.184.75.245])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E8014B8B9; Fri,  8 Dec 2006 01:55:07 +0900 (JST)
Date:	Fri, 08 Dec 2006 01:55:07 +0900 (JST)
Message-Id: <20061208.015507.82088245.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, vagabon.xyz@gmail.com
Subject: [PATCH] add GENERIC_HARDIRQS_NO__DO_IRQ for i8259 users
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
X-archive-position: 13407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now i8259A_chip uses new irq flow handler.  Select
GENERIC_HARDIRQS_NO__DO_IRQ on some more platforms.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                                        |    6 ++
 arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |   27 -------------
 arch/mips/vr41xx/Kconfig                                 |    5 --
 arch/mips/vr41xx/nec-cmbvr4133/irq.c                     |    9 ----
 4 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1afc890..78e70f2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -165,6 +165,7 @@ config MIPS_COBALT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config MACH_DECSTATION
 	bool "DECstations"
@@ -225,6 +226,7 @@ config MACH_JAZZ
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_100HZ
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	 This a family of machines based on the MIPS R4030 chipset which was
 	 used by several vendors to build RISC/os and Windows NT workstations.
@@ -480,6 +482,7 @@ config DDB5477
 config MACH_VR41XX
 	bool "NEC VR41XX-based machines"
 	select SYS_HAS_CPU_VR41XX
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config PMC_YOSEMITE
 	bool "PMC-Sierra Yosemite eval board"
@@ -513,6 +516,7 @@ config QEMU
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ARCH_SPARSEMEM_ENABLE
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  Qemu is a software emulator which among other architectures also
 	  can simulate a MIPS32 4Kc system.  This patch adds support for the
@@ -752,6 +756,7 @@ config TOSHIBA_RBTX4927
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select TOSHIBA_BOARDS
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
@@ -771,6 +776,7 @@ config TOSHIBA_RBTX4938
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select TOSHIBA_BOARDS
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
 	  support this machine type
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index 5a5ea6c..b54b529 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -158,7 +158,6 @@ #define TOSHIBA_RBTX4927_IRQ_ISA_INIT   
 #define TOSHIBA_RBTX4927_IRQ_ISA_ENABLE    ( 1 << 23 )
 #define TOSHIBA_RBTX4927_IRQ_ISA_DISABLE   ( 1 << 24 )
 #define TOSHIBA_RBTX4927_IRQ_ISA_MASK      ( 1 << 25 )
-#define TOSHIBA_RBTX4927_IRQ_ISA_ENDIRQ    ( 1 << 26 )
 
 #define TOSHIBA_RBTX4927_SETUP_ALL         0xffffffff
 #endif
@@ -175,7 +174,6 @@ static const u32 toshiba_rbtx4927_irq_de
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_ENABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_DISABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_ISA_MASK
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_ENDIRQ
     );
 #endif
 
@@ -226,7 +224,6 @@ #ifdef CONFIG_TOSHIBA_FPCIB0
 static void toshiba_rbtx4927_irq_isa_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_isa_disable(unsigned int irq);
 static void toshiba_rbtx4927_irq_isa_mask_and_ack(unsigned int irq);
-static void toshiba_rbtx4927_irq_isa_end(unsigned int irq);
 #endif
 
 #define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
@@ -249,7 +246,6 @@ static struct irq_chip toshiba_rbtx4927_
 	.mask = toshiba_rbtx4927_irq_isa_disable,
 	.mask_ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
 	.unmask = toshiba_rbtx4927_irq_isa_enable,
-	.end = toshiba_rbtx4927_irq_isa_end,
 };
 #endif
 
@@ -402,7 +398,8 @@ static void __init toshiba_rbtx4927_irq_
 
 	for (i = TOSHIBA_RBTX4927_IRQ_ISA_BEG;
 	     i <= TOSHIBA_RBTX4927_IRQ_ISA_END; i++)
-		set_irq_chip(i, &toshiba_rbtx4927_irq_isa_type);
+		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_isa_type,
+					 handle_level_irq);
 
 	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC,
 		  &toshiba_rbtx4927_irq_isa_master);
@@ -470,26 +467,6 @@ static void toshiba_rbtx4927_irq_isa_mas
 #endif
 
 
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void toshiba_rbtx4927_irq_isa_end(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_ENDIRQ,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_ISA_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_ISA_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		toshiba_rbtx4927_irq_isa_enable(irq);
-	}
-}
-#endif
-
-
 void __init arch_init_irq(void)
 {
 	extern void tx4927_irq_init(void);
diff --git a/arch/mips/vr41xx/Kconfig b/arch/mips/vr41xx/Kconfig
index c8dfd80..92f41f6 100644
--- a/arch/mips/vr41xx/Kconfig
+++ b/arch/mips/vr41xx/Kconfig
@@ -6,7 +6,6 @@ config CASIO_E55
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config IBM_WORKPAD
 	bool "Support for IBM WorkPad z50"
@@ -16,7 +15,6 @@ config IBM_WORKPAD
 	select ISA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config NEC_CMBVR4133
 	bool "Support for NEC CMB-VR4133"
@@ -41,7 +39,6 @@ config TANBAC_TB022X
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  The TANBAC VR4131 multichip module(TB0225) and
 	  the TANBAC VR4131DIMM(TB0229) are MIPS-based platforms
@@ -74,7 +71,6 @@ config VICTOR_MPC30X
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config ZAO_CAPCELLA
 	bool "Support for ZAO Networks Capcella"
@@ -84,7 +80,6 @@ config ZAO_CAPCELLA
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config PCI_VR41XX
 	bool "Add PCI control unit support of NEC VR4100 series"
diff --git a/arch/mips/vr41xx/nec-cmbvr4133/irq.c b/arch/mips/vr41xx/nec-cmbvr4133/irq.c
index a039bb7..128ed8d 100644
--- a/arch/mips/vr41xx/nec-cmbvr4133/irq.c
+++ b/arch/mips/vr41xx/nec-cmbvr4133/irq.c
@@ -45,19 +45,12 @@ static void ack_i8259_irq(unsigned int i
 	mask_and_ack_8259A(irq - I8259_IRQ_BASE);
 }
 
-static void end_i8259_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_8259A_irq(irq - I8259_IRQ_BASE);
-}
-
 static struct irq_chip i8259_irq_type = {
 	.typename       = "XT-PIC",
 	.ack            = ack_i8259_irq,
 	.mask		= disable_i8259_irq,
 	.mask_ack	= ack_i8259_irq,
 	.unmask		= enable_i8259_irq,
-	.end            = end_i8259_irq,
 };
 
 static int i8259_get_irq_number(int irq)
@@ -92,7 +85,7 @@ void __init rockhopper_init_irq(void)
 	}
 
 	for (i = I8259_IRQ_BASE; i <= I8259_IRQ_LAST; i++)
-		set_irq_chip(i, &i8259_irq_type);
+		set_irq_chip_and_handler(i, &i8259_irq_type, handle_level_irq);
 
 	setup_irq(I8259_SLAVE_IRQ, &i8259_slave_cascade);
 
