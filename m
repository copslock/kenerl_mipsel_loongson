Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6EJomRw013596
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Jul 2002 12:50:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6EJomDH013595
	for linux-mips-outgoing; Sun, 14 Jul 2002 12:50:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6EJoZRw013585;
	Sun, 14 Jul 2002 12:50:36 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6EJtFC10297;
	Sun, 14 Jul 2002 21:55:15 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6EJtGTF018325;
	Sun, 14 Jul 2002 21:55:16 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17TpSd-0002AB-00; Sun, 14 Jul 2002 21:55:15 +0200
Date: Sun, 14 Jul 2002 21:55:15 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] O2 irq handling
Message-ID: <Pine.LNX.4.21.0207142149330.8121-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	Here is a patch for the SGI O2 that fixes a typo in the edge
interrupt range checking and protects the irq handler from reentrancy.

Vivien.

================================================================================

--- linux/arch/mips64/sgi-ip32/ip32-irq.c	Thu Jan  3 21:24:55 2002
+++ linux.build/arch/mips64/sgi-ip32/ip32-irq.c	Tue Jan 22 13:01:30 2002
@@ -199,9 +201,9 @@
 	unsigned long flags;
 
 	/* Edge triggered interrupts must be cleared. */
-	if ((irq <= CRIME_GBE0_IRQ && irq >= CRIME_GBE3_IRQ)
-	    || (irq <= CRIME_RE_EMPTY_E_IRQ && irq >= CRIME_RE_IDLE_E_IRQ)
-	    || (irq <= CRIME_SOFT0_IRQ && irq >= CRIME_SOFT2_IRQ)) {
+	if ((irq >= CRIME_GBE0_IRQ && irq <= CRIME_GBE3_IRQ)
+	    || (irq >= CRIME_RE_EMPTY_E_IRQ && irq <= CRIME_RE_IDLE_E_IRQ)
+	    || (irq >= CRIME_SOFT0_IRQ && irq <= CRIME_SOFT2_IRQ)) {
 		save_and_cli(flags);
 		crime_mask = crime_read_64(CRIME_HARD_INT);
 		crime_mask &= ~(1 << (irq - 1));
@@ -473,9 +475,18 @@
 /* CRIME 1.1 appears to deliver all interrupts to this one pin. */
 void ip32_irq0(struct pt_regs *regs)
 {
-	u64 crime_int = crime_read_64 (CRIME_INT_STAT);
+	u64 crime_int;
+	u64 crime_mask;
 	int irq = 0;
-	
+	unsigned long flags;
+
+	save_and_cli (flags);
+	/* disable crime interrupts */
+	crime_mask = crime_read_64(CRIME_INT_MASK);
+	crime_write_64(CRIME_INT_MASK, 0);
+
+	crime_int = crime_read_64(CRIME_INT_STAT);
+
 	if (crime_int & CRIME_MACE_INT_MASK) {
		crime_int &= CRIME_MACE_INT_MASK;
		irq = ffs (crime_int);
@@ -498,6 +510,10 @@
		ip32_unknown_interrupt(regs);
 	DBG("*irq %u*\n", irq);
 	do_IRQ(irq, regs);
+
+	/* enable crime interrupts */
+	crime_write_64(CRIME_INT_MASK, crime_mask);
+	restore_flags (flags);
 }
 
 void ip32_irq1(struct pt_regs *regs)
