Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JLMERw029142
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 14:22:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JLME1k029141
	for linux-mips-outgoing; Fri, 19 Jul 2002 14:22:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JLM4Rw029132
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 14:22:04 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA01965;
	Fri, 19 Jul 2002 14:22:39 -0700
Message-ID: <3D388136.2050502@mvista.com>
Date: Fri, 19 Jul 2002 14:14:30 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>
Subject: [PATCH]  Let Malta and its friends use common timer interrupt code
Content-Type: multipart/mixed;
 boundary="------------050706020400080501030203"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------050706020400080501030203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch let Malta and other MIPS boards use the common timer interrupt 
code.  Not only it reduces maintainance, but also it lets Malta benefit from 
common improvement (such as Preemptible kernel).

Jun


--------------050706020400080501030203
Content-Type: text/plain;
 name="020719.a.mips-boards-use-ll_timer_interrupt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="020719.a.mips-boards-use-ll_timer_interrupt.patch"

diff -Nru linux/arch/mips/mips-boards/generic/time.c.orig linux/arch/mips/mips-boards/generic/time.c
--- linux/arch/mips/mips-boards/generic/time.c.orig	Tue May  7 20:05:01 2002
+++ linux/arch/mips/mips-boards/generic/time.c	Fri Jul 19 13:55:42 2002
@@ -35,6 +35,7 @@
 #include <asm/hardirq.h>
 #include <asm/div64.h>
 #include <asm/cpu.h>
+#include <asm/time.h>
 
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
@@ -46,8 +47,6 @@
 static unsigned int r4k_offset; /* Amount to increment compare reg each time */
 static unsigned int r4k_cur;    /* What counter should be at next timer irq */
 
-extern unsigned int mips_counter_frequency;
-
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
 #if defined(CONFIG_MIPS_ATLAS)
@@ -71,13 +70,6 @@
 
 void mips_timer_interrupt(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
-	int irq = MIPS_CPU_TIMER_IRQ;
-
-	irq_enter(cpu, irq);
-	kstat.irqs[cpu][irq]++;
-	timer_interrupt(irq, NULL, regs);
-
 	if ((timer_tick_count++ % HZ) == 0) {
 		mips_display_message(&display_string[display_count++]);
 		if (display_count == MAX_DISPLAY_COUNT)
@@ -85,10 +77,7 @@
 
 	}
 
-	irq_exit(cpu, irq);
-
-	if (softirq_pending(cpu))
-		do_softirq();
+	ll_timer_interrupt(MIPS_CPU_TIMER_IRQ, regs);
 }
 
 /* 

--------------050706020400080501030203--
