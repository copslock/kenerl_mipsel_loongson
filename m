Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 04:13:43 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:57985
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8224802AbTF3DNl>; Mon, 30 Jun 2003 04:13:41 +0100
Received: (qmail 19180 invoked from network); 29 Jun 2003 20:07:58 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 29 Jun 2003 20:07:58 -0000
Received: (qmail 24800 invoked by uid 502); 30 Jun 2003 03:13:38 -0000
Date: Sun, 29 Jun 2003 20:13:38 -0700
From: ilya@theIlya.com
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: ip32 timer setup fix
Message-ID: <20030630031338.GK13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C01fF7hLGvN0zd9s"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--C01fF7hLGvN0zd9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is patch to fix timer setup on IP32.


--C01fF7hLGvN0zd9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ip32-timer.diff"

Index: arch/mips/sgi-ip32/ip32-timer.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-timer.c,v
retrieving revision 1.12
diff -u -r1.12 ip32-timer.c
--- arch/mips/sgi-ip32/ip32-timer.c	29 Jun 2003 21:59:13 -0000	1.12
+++ arch/mips/sgi-ip32/ip32-timer.c	30 Jun 2003 03:07:47 -0000
@@ -45,11 +45,17 @@
 #define USECS_PER_JIFFY (1000000/HZ)
 
 
+static irqreturn_t cc_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs);
+
 void __init ip32_timer_setup (struct irqaction *irq)
 {
 	u64 crime_time;
 	u32 cc_tick;
 
+
+	write_c0_count(0);
+	irq->handler = cc_timer_interrupt;
+
 	printk("Calibrating system timer... ");
 
 	crime_time = crime_read_64(CRIME_TIME) & CRIME_TIME_MASK;
@@ -70,12 +76,14 @@
 	printk("%d MHz CPU detected\n", (int) (cc_interval / PER_MHZ));
 
 	setup_irq (CLOCK_IRQ, irq);
+#define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
+	/* Set ourselves up for future interrupts */
+	write_c0_compare(read_c0_count() + cc_interval);
+        change_c0_status(ST0_IM, ALLINTS);
+	local_irq_enable();
 }
 
-struct irqaction irq0  = { NULL, SA_INTERRUPT, 0,
-			   "timer", NULL, NULL};
-
-irqreturn_t cc_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t cc_timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	u32 count;
 
@@ -150,15 +158,4 @@
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
 	xtime.tv_nsec = 0;
 	write_sequnlock_irq(&xtime_lock);
-
-	write_c0_count(0);
-	irq0.handler = cc_timer_interrupt;
-
-	ip32_timer_setup (&irq0);
-
-#define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
-	/* Set ourselves up for future interrupts */
-	write_c0_compare(read_c0_count() + cc_interval);
-        change_c0_status(ST0_IM, ALLINTS);
-	local_irq_enable();
 }
Index: arch/mips/sgi-ip32/ip32-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
retrieving revision 1.4
diff -u -r1.4 ip32-setup.c
--- arch/mips/sgi-ip32/ip32-setup.c	14 Apr 2003 16:33:24 -0000	1.4
+++ arch/mips/sgi-ip32/ip32-setup.c	30 Jun 2003 03:11:05 -0000
@@ -94,6 +94,7 @@
 	rtc_ops = &ip32_rtc_ops;
 	board_be_init = ip32_be_init;
 	board_time_init = ip32_time_init;
+	board_timer_setup = ip32_timer_setup();
 
 	crime_init ();
 }

--C01fF7hLGvN0zd9s--
