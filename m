Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2005 07:51:01 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:42518 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224925AbVAEHuy>;
	Wed, 5 Jan 2005 07:50:54 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j057oY404362
	for <linux-mips@linux-mips.org>; Wed, 5 Jan 2005 08:50:34 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j057oXi10526
	for <linux-mips@linux-mips.org>; Wed, 5 Jan 2005 08:50:33 +0100
Message-ID: <41DB9C49.4050105@schenk.isar.de>
Date: Wed, 05 Jan 2005 08:50:33 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: SMP on Yosemite
References: <41DA6A13.7090703@schenk.isar.de> <20050104155651.GB12031@gw.junsun.net>
In-Reply-To: <20050104155651.GB12031@gw.junsun.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010807060600000001090704"
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010807060600000001090704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jun Sun wrote:
> In earlier version time.c file, I introduced something like 
> "smp_emulate_local_timer" variable.  When it is set, cpu 0 sends
> "EMULATE_LOCAL_TIMER" IPI to other CPUs.  Sending IPI is done
> inside timer_interrupt().
> 
> I think that is a better approach, where implementation can be shared
> by other SMP machines.
> 
> I would just rename RESCHEDULE_YOURSELF to EMULATE_LOCAL_TIMER.
> 
> Jun
> 

Ok. Second try. Attached is the revised patch.




--------------010807060600000001090704
Content-Type: text/plain;
 name="yosemite_smp_patch_2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="yosemite_smp_patch_2"

Index: smp.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/smp.h,v
retrieving revision 1.31
diff -u -r1.31 smp.h
--- smp.h       26 Nov 2004 10:06:36 -0000      1.31
+++ smp.h       5 Jan 2005 07:46:31 -0000
@@ -46,6 +46,7 @@

 #define SMP_RESCHEDULE_YOURSELF        0x1     /* XXX braindead */
 #define SMP_CALL_FUNCTION      0x2
+#define SMP_EMULATE_LOCAL_TIMER 0x3

 extern cpumask_t phys_cpu_present_map;
 extern cpumask_t cpu_online_map;

Index: setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pmc-sierra/yosemite/setup.c,v
retrieving revision 1.12
diff -u -r1.12 setup.c
--- setup.c	19 Dec 2004 02:38:44 -0000	1.12
+++ setup.c	5 Jan 2005 07:45:48 -0000
@@ -127,8 +127,22 @@
 	return 0;
 }
 
+irqreturn_t yosemite_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+#ifdef CONFIG_SMP
+	int cpu = smp_processor_id();
+	
+	if (ocd_base) {
+	   if (cpu == 0) core_send_ipi(1,SMP_EMULATE_LOCAL_TIMER);
+	   else core_send_ipi(0,SMP_EMULATE_LOCAL_TIMER);
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
+++ smp.c	5 Jan 2005 07:45:48 -0000
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
+	if (status & 0x8)
+	{
+		irq_enter();
+		local_timer_interrupt(irq, NULL, regs);
+		irq_exit();
+	}
 }
 
 /*
@@ -168,5 +178,11 @@
 		else
 			OCD_WRITE(RM9000x2_OCD_INTP0SET3, 2);
 		break;
+	case SMP_EMULATE_LOCAL_TIMER:
+		if (cpu == 1)
+			OCD_WRITE(RM9000x2_OCD_INTP1SET3, 8);
+		else
+			OCD_WRITE(RM9000x2_OCD_INTP0SET3, 8);
+		break;
 	}
 }

--------------010807060600000001090704--
