Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:36:23 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:55360 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133515AbWBWPgF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:36:05 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFh3t16501
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:43:03 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-L/JkbkW/jaOcnCNCoL3K"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:43:03 +0300
Message-Id: <1140709383.5741.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-L/JkbkW/jaOcnCNCoL3K
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-L/JkbkW/jaOcnCNCoL3K
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_serial_fix.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_serial_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc. Sergey Podstavin <spodstavin@ru.mvista.com>
MR: 14908
Type: Defect Fix
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Sergey Podstavin <spodstavin@ru.mvista.com>
Description:
    A large file transfers with errors via UART on 115200 fix

Index: linux-2.6.10/arch/mips/vr5701/vr5701_sg2/irq.c
===================================================================
--- linux-2.6.10.orig/arch/mips/vr5701/vr5701_sg2/irq.c
+++ linux-2.6.10/arch/mips/vr5701/vr5701_sg2/irq.c
@@ -79,18 +79,6 @@ asmlinkage void vr5701_sg2_irq_dispatch(
 	u32 bitmask;
 	u32 i;
 	u32 intPCIStatus;
-	if (ddb_in32(INT1_STAT) != 0) {
-		printk(KERN_CRIT "NMI  = %x\n", ddb_in32(NMI_STAT));
-		printk(KERN_CRIT "INT0 = %x\n", ddb_in32(INT0_STAT));
-		printk(KERN_CRIT "INT1 = %x\n", ddb_in32(INT1_STAT));
-		printk(KERN_CRIT "INT2 = %x\n", ddb_in32(INT2_STAT));
-		printk(KERN_CRIT "INT3 = %x\n", ddb_in32(INT3_STAT));
-		printk(KERN_CRIT "INT4 = %x\n", ddb_in32(INT4_STAT));
-		printk(KERN_CRIT "EPCI_ERR = %x\n", ddb_in32(EPCI_ERR));
-		printk(KERN_CRIT "IPCI_ERR = %x\n", ddb_in32(IPCI_ERR));
-
-		panic("error interrupt has happened.");
-	}
 
 	intStatus = ddb_in32(INT0_STAT);
 
@@ -100,7 +88,6 @@ asmlinkage void vr5701_sg2_irq_dispatch(
 	if (intStatus & 1 << 7)
 		goto IRQ_IPCI;
 
-      IRQ_OTHER:
 	for (i = 0, bitmask = 1; i <= NUM_5701_IRQS; bitmask <<= 1, i++) {
 		/* do we need to "and" with the int mask? */
 		if (intStatus & bitmask) {
@@ -117,26 +104,18 @@ asmlinkage void vr5701_sg2_irq_dispatch(
 			do_IRQ(8 + NUM_5701_IRQS + i, regs);
 		}
 	}
-	if (!intStatus)
-		return;
+	return;
 
       IRQ_IPCI:
 	intStatus &= ~(1 << 7);
 	intPCIStatus = ddb_in32(IPCI_INTS);
-	if (!intPCIStatus)
-		goto IRQ_OTHER;
-
 	for (i = 0, bitmask = 1; i < NUM_5701_IPCI_IRQS; bitmask <<= 1, i++) {
 		if (intPCIStatus & bitmask) {
 			do_IRQ(8 + NUM_5701_IRQS + NUM_5701_EPCI_IRQS + i,
 			       regs);
 		}
 	}
-
-	if (!intStatus)
-		return;
-
-	goto IRQ_OTHER;
+	return;
 }
 
 void __init arch_init_irq(void)

--=-L/JkbkW/jaOcnCNCoL3K--
