Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2005 11:26:08 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:43283 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224988AbVADL0C>;
	Tue, 4 Jan 2005 11:26:02 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j04A43429095
	for <linux-mips@linux-mips.org>; Tue, 4 Jan 2005 11:04:43 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j04A43i04529
	for <linux-mips@linux-mips.org>; Tue, 4 Jan 2005 11:04:03 +0100
Message-ID: <41DA6A13.7090703@schenk.isar.de>
Date: Tue, 04 Jan 2005 11:04:03 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: SMP on Yosemite
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060407020406040509080707"
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060407020406040509080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I noticed that on the Yosemite board in SMP mode
local_timer_interrupt is never called on the CPU
which does not handle the timer IRQ in the first
place. Therefore process accounting does not work
for at least one CPU. I have attached a patch that
sends an inter-processor interrupt to the other
CPU every time a timer interrupt occurs. I have
used SMP_RESCHEDULE_YOURSELF since it is obviously
unused. If this is not the way it's supposed to
be done, please let me know.

Thanks
Rojhalat Ibrahim


--------------060407020406040509080707
Content-Type: text/plain;
 name="yosemite_smp_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="yosemite_smp_patch"

Index: setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pmc-sierra/yosemite/setup.c,v
retrieving revision 1.12
diff -u -r1.12 setup.c
--- setup.c	19 Dec 2004 02:38:44 -0000	1.12
+++ setup.c	4 Jan 2005 09:46:17 -0000
@@ -127,8 +127,22 @@
 	return 0;
 }
 
+irqreturn_t yosemite_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+#ifdef CONFIG_SMP
+	int cpu = smp_processor_id();
+	
+	if (ocd_base) {
+	   if (cpu == 0) core_send_ipi(1,SMP_RESCHEDULE_YOURSELF);
+	   else core_send_ipi(0,SMP_RESCHEDULE_YOURSELF);
+	}
+#endif
+	return timer_interrupt(irq,dev_id,regs);
+}
+
 void yosemite_timer_setup(struct irqaction *irq)
 {
+	irq->handler = yosemite_timer_interrupt;
 	setup_irq(7, irq);
 }
 
@@ -136,13 +150,13 @@
 {
 	board_timer_setup = yosemite_timer_setup;
 	mips_hpt_frequency = cpu_clock / 2;
-mips_hpt_frequency = 33000000 * 3 * 5;
+	mips_hpt_frequency = 100000000 * 5;
 }
 
 /* No other usable initialization hook than this ...  */
 extern void (*late_time_init)(void);
 
-unsigned long ocd_base;
+unsigned long ocd_base = 0;
 
 EXPORT_SYMBOL(ocd_base);
 
Index: smp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pmc-sierra/yosemite/smp.c,v
retrieving revision 1.11
diff -u -r1.11 smp.c
--- smp.c	15 Dec 2004 20:04:59 -0000	1.11
+++ smp.c	4 Jan 2005 09:46:17 -0000
@@ -1,5 +1,6 @@
 #include <linux/linkage.h>
 #include <linux/sched.h>
+#include <linux/interrupt.h>
 
 #include <asm/pmon.h>
 #include <asm/titan_dep.h>
@@ -7,6 +8,8 @@
 extern unsigned int (*mips_hpt_read)(void);
 extern void (*mips_hpt_init)(unsigned int);
 
+extern void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
 #define LAUNCHSTACK_SIZE 256
 
 static spinlock_t launch_lock __initdata;
@@ -122,10 +125,10 @@
 {
 }
 
-asmlinkage void titan_mailbox_irq(struct pt_regs *regs)
+asmlinkage void titan_mailbox_irq(int irq, struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
-	unsigned long status;
+	unsigned long status = 0;
 
 	if (cpu == 0) {
 		status = OCD_READ(RM9000x2_OCD_INTP0STATUS3);
@@ -139,6 +142,13 @@
 
 	if (status & 0x2)
 		smp_call_function_interrupt();
+	
+	if (status & 0x4)
+	{
+		irq_enter();
+		local_timer_interrupt(irq, NULL, regs);
+		irq_exit();
+	}
 }
 
 /*

--------------060407020406040509080707--
