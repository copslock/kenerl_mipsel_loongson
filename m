Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 04:50:28 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:38671 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133385AbWBTEuS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 04:50:18 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4AC5B64D3D; Mon, 20 Feb 2006 04:57:08 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0C0E78DB3; Mon, 20 Feb 2006 04:57:00 +0000 (GMT)
Date:	Mon, 20 Feb 2006 04:57:00 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, mark.e.mason@broadcom.com
Subject: [MIPS] Fix compiler warnings in arch/mips/sibyte/bcm1480/irq.c
Message-ID: <20060220045700.GA2519@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Fix the following compiler warnings:

  CC      arch/mips/sibyte/bcm1480/irq.o
arch/mips/sibyte/bcm1480/irq.c: In function ‘bcm1480_set_affinity’:
arch/mips/sibyte/bcm1480/irq.c:168: warning: ISO C90 forbids mixed declarations and code
arch/mips/sibyte/bcm1480/irq.c: In function ‘ack_bcm1480_irq’:
arch/mips/sibyte/bcm1480/irq.c:230: warning: ISO C90 forbids mixed declarations and code

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/arch/mips/sibyte/bcm1480/irq.c	2006-02-20 04:51:41.000000000 +0000
+++ b/arch/mips/sibyte/bcm1480/irq.c	2006-02-20 04:52:39.000000000 +0000
@@ -139,7 +139,7 @@
 #ifdef CONFIG_SMP
 static void bcm1480_set_affinity(unsigned int irq, cpumask_t mask)
 {
-	int i = 0, old_cpu, cpu, int_on;
+	int i = 0, old_cpu, cpu, int_on, k;
 	u64 cur_ints;
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
@@ -165,7 +165,6 @@
 		irq_dirty -= BCM1480_NR_IRQS_HALF;
 	}
 
-	int k;
 	for (k=0; k<2; k++) { /* Loop through high and low interrupt mask register */
 		cur_ints = ____raw_readq(IOADDR(A_BCM1480_IMR_MAPPER(old_cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + (k*BCM1480_IMR_HL_SPACING)));
 		int_on = !(cur_ints & (((u64) 1) << irq_dirty));
@@ -216,6 +215,7 @@
 {
 	u64 pending;
 	unsigned int irq_dirty;
+	int k;
 
 	/*
 	 * If the interrupt was an HT interrupt, now is the time to
@@ -227,7 +227,6 @@
 	if ((irq_dirty >= BCM1480_NR_IRQS_HALF) && (irq_dirty <= BCM1480_NR_IRQS)) {
 		irq_dirty -= BCM1480_NR_IRQS_HALF;
 	}
-	int k;
 	for (k=0; k<2; k++) { /* Loop through high and low LDT interrupts */
 		pending = __raw_readq(IOADDR(A_BCM1480_IMR_REGISTER(bcm1480_irq_owner[irq],
 						R_BCM1480_IMR_LDT_INTERRUPT_H + (k*BCM1480_IMR_HL_SPACING))));


-- 
Martin Michlmayr
http://www.cyrius.com/
