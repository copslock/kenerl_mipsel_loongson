Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 06:26:15 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:16561 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225223AbTBDG0O>;
	Tue, 4 Feb 2003 06:26:14 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h145X4Kp029395
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Mon, 3 Feb 2003 21:33:06 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA17521 for <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 17:26:06 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h146PdMd027333
	for <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 17:25:40 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h146PcGE027331
	for linux-mips@linux-mips.org; Tue, 4 Feb 2003 17:25:38 +1100
Date: Tue, 4 Feb 2003 17:25:38 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: [patch] ip27-timer irq fix
Message-ID: <20030204062538.GB27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

This patch sets up irq's properly.  The author of this code
apparently didn't understand the ugly hacks that are going on
in bridge_irq_type.* (startup_bridge_irq() and friends).
So, they were:
	(a) allocating a stupid IRQ number (that collided with
	something else in my case).  This doesn't matter at all,
	since the timer interrupt comes through different channels
	to PCI device interrupts.

	(b) not calling setup_irq(), which meant, among other things,
	it wasn't appearing in /proc/interrupts.  setup_irq()
	was crashing on them on startup, because startup_bridge_irq()
	was trying to do all kinds of PCI initialization on it (IIRC).

Basically, if you pick an IRQ number less than BASE_PCI,
startup_bridge_irq() will ignore it, and all works dandy :)

The Right Solution TM would probably involve some other
hw_interrupt_type like cpu_irq_type, or something.

Cheers,
Andrew


Index: arch/mips/sgi-ip27/ip27-timer.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip27/ip27-timer.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 ip27-timer.c
--- arch/mips/sgi-ip27/ip27-timer.c	2 Dec 2002 00:24:51 -0000	1.1.2.4
+++ arch/mips/sgi-ip27/ip27-timer.c	30 Jan 2003 22:38:48 -0000
@@ -90,13 +90,11 @@
 	return retval;
 }
 
-#define IP27_TIMER_IRQ	9			/* XXX Assign number */
-
 void rt_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 	int cpuA = ((cputoslice(cpu)) == 0);
-	int irq = IP27_TIMER_IRQ;
+	int irq = CPU_TIMER_IRQ;
 
 	irq_enter(cpu, irq);
 	write_lock(&xtime_lock);
@@ -198,7 +196,7 @@
 	irq->handler = no_action;
 
 	/* setup irqaction */
-//	setup_irq(IP27_TIMER_IRQ, irq);		/* XXX Can't do this yet.  */
+	setup_irq(CPU_TIMER_IRQ, irq);
 }
 
 void __init ip27_time_init(void)
Index: include/asm-mips64/sn/sn0/ip27.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/sn/sn0/ip27.h,v
retrieving revision 1.9.2.1
diff -u -r1.9.2.1 ip27.h
--- include/asm-mips64/sn/sn0/ip27.h	27 Jun 2002 14:21:24 -0000	1.9.2.1
+++ include/asm-mips64/sn/sn0/ip27.h	30 Jan 2003 22:39:00 -0000
@@ -88,7 +88,8 @@
 #define CPU_RESCHED_B_IRQ	1
 #define CPU_CALL_A_IRQ		2
 #define CPU_CALL_B_IRQ		3
-#define BASE_PCI_IRQ		4
+#define CPU_TIMER_IRQ		4
+#define BASE_PCI_IRQ		5
 
 #define SN00_BRIDGE		0x9200000008000000
 #define SN00I_BRIDGE0		0x920000000b000000
