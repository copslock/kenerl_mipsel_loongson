Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2008 17:54:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:65014 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S30625421AbYDYQyc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2008 17:54:32 +0100
Received: from localhost (p6035-ipad308funabasi.chiba.ocn.ne.jp [123.217.192.35])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 28EF3B826; Sat, 26 Apr 2008 01:54:28 +0900 (JST)
Date:	Sat, 26 Apr 2008 01:55:30 +0900 (JST)
Message-Id: <20080426.015530.78704907.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix some sparse warnings on traps.c and irq-msc01.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Declare board_bind_eic_interrupt, board_watchpoint_handler in traps.h
* Make msc_bind_eic_interrupt static and fix its argument types.
* Make msc_levelirq_type, msc_edgeirq_type static.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/kernel/irq-msc01.c |   10 ++++------
 include/asm-mips/traps.h     |    2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
index 4edc7e4..963c16d 100644
--- a/arch/mips/kernel/irq-msc01.c
+++ b/arch/mips/kernel/irq-msc01.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/msc01_ic.h>
+#include <asm/traps.h>
 
 static unsigned long _icctrl_msc;
 #define MSC01_IC_REG_BASE	_icctrl_msc
@@ -98,14 +99,13 @@ void ll_msc_irq(void)
 	}
 }
 
-void
-msc_bind_eic_interrupt(unsigned int irq, unsigned int set)
+static void msc_bind_eic_interrupt(int irq, int set)
 {
 	MSCIC_WRITE(MSC01_IC_RAMW,
 		    (irq<<MSC01_IC_RAMW_ADDR_SHF) | (set<<MSC01_IC_RAMW_DATA_SHF));
 }
 
-struct irq_chip msc_levelirq_type = {
+static struct irq_chip msc_levelirq_type = {
 	.name = "SOC-it-Level",
 	.ack = level_mask_and_ack_msc_irq,
 	.mask = mask_msc_irq,
@@ -115,7 +115,7 @@ struct irq_chip msc_levelirq_type = {
 	.end = end_msc_irq,
 };
 
-struct irq_chip msc_edgeirq_type = {
+static struct irq_chip msc_edgeirq_type = {
 	.name = "SOC-it-Edge",
 	.ack = edge_mask_and_ack_msc_irq,
 	.mask = mask_msc_irq,
@@ -128,8 +128,6 @@ struct irq_chip msc_edgeirq_type = {
 
 void __init init_msc_irqs(unsigned long icubase, unsigned int irqbase, msc_irqmap_t *imp, int nirq)
 {
-	extern void (*board_bind_eic_interrupt)(unsigned int irq, unsigned int regset);
-
 	_icctrl_msc = (unsigned long) ioremap(icubase, 0x40000);
 
 	/* Reset interrupt controller - initialises all registers to 0 */
diff --git a/include/asm-mips/traps.h b/include/asm-mips/traps.h
index d02e019..e5dbde6 100644
--- a/include/asm-mips/traps.h
+++ b/include/asm-mips/traps.h
@@ -23,5 +23,7 @@ extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
 extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
+extern void (*board_bind_eic_interrupt)(int irq, int regset);
+extern void (*board_watchpoint_handler)(struct pt_regs *regs);
 
 #endif /* _ASM_TRAPS_H */
