Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 15:02:03 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:17025 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225765AbVBTPBl>; Sun, 20 Feb 2005 15:01:41 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D2saZ-0006xJ-00
	for <linux-mips@linux-mips.org>; Sun, 20 Feb 2005 15:01:39 +0000
Date:	Sun, 20 Feb 2005 15:01:39 +0000
To:	linux-mips@linux-mips.org
Subject: [PATCH 2.6] Cobalt fixes [6 of 6]
Message-ID: <20050220150139.GG26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix Qube/RaQ interrupt handling under 2.6.

P.

--- linux-cvs/arch/mips/cobalt/int-handler.S	2003-11-13 14:30:45.000000000 +0000
+++ linux-wip/arch/mips/cobalt/int-handler.S	2005-02-20 13:48:22.000000000 +0000
@@ -18,8 +18,8 @@
 		SAVE_ALL
 		CLI
 
-		la	ra, ret_from_irq
-		move	a1, sp
+		PTR_LA	ra, ret_from_irq
+		move	a0, sp
 		j	cobalt_irq
 
 		END(cobalt_handle_int)
--- linux-cvs/arch/mips/cobalt/irq.c	2004-08-20 10:19:01.000000000 +0100
+++ linux-wip/arch/mips/cobalt/irq.c	2005-02-20 13:48:22.000000000 +0000
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/i8259.h>
 #include <asm/irq_cpu.h>
@@ -25,8 +26,8 @@ extern void cobalt_handle_int(void);
  * the CPU interrupt lines, and ones that come in on the via chip. The CPU
  * mappings are:
  *
- *    16,  - Software interrupt 0 (unused)	IE_SW0
- *    17   - Software interrupt 1 (unused)	IE_SW0
+ *    16   - Software interrupt 0 (unused)	IE_SW0
+ *    17   - Software interrupt 1 (unused)	IE_SW1
  *    18   - Galileo chip (timer)		IE_IRQ0
  *    19   - Tulip 0 + NCR SCSI			IE_IRQ1
  *    20   - Tulip 1				IE_IRQ2
@@ -82,11 +83,15 @@ asmlinkage void cobalt_irq(struct pt_reg
 	}
 
 	if (pending & CAUSEF_IP7) {			/* int 23 */
-		do_IRQ(COBALT_QUBE_SLOT_IRQ, regs);
+		do_IRQ(23, regs);
 		return;
 	}
 }
 
+static struct irqaction irq_via = {
+	no_action, 0, { { 0, } }, "cascade", NULL, NULL
+};
+ 
 void __init arch_init_irq(void)
 {
 	set_except_vector(0, cobalt_handle_int);
@@ -99,4 +104,6 @@ void __init arch_init_irq(void)
 	 *  (except IE4, we already masked those at VIA level)
 	 */
 	change_c0_status(ST0_IM, IE_IRQ4);
+
+	setup_irq(COBALT_VIA_IRQ, &irq_via);
 }
