Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 18:03:22 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:6906 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225285AbSLQSDW>;
	Tue, 17 Dec 2002 18:03:22 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBHI37832433;
	Tue, 17 Dec 2002 10:03:07 -0800
Date: Tue, 17 Dec 2002 10:03:07 -0800
From: Jun Sun <jsun@mvista.com>
To: Colin.Helliwell@Zarlink.Com
Cc: linux-mips@linux-mips.org, jsun@mvista.com, rml@mvista.com
Subject: Re: Problems with CONFIG_PREEMPT
Message-ID: <20021217100307.E11575@mvista.com>
References: <OF78526308.B4153FAC-ON80256C92.002B416F@zarlink.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF78526308.B4153FAC-ON80256C92.002B416F@zarlink.com>; from Colin.Helliwell@Zarlink.Com on Tue, Dec 17, 2002 at 08:27:16AM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2002 at 08:27:16AM +0000, Colin.Helliwell@Zarlink.Com wrote:
> 
> NEW_TIME_C is set. URL to the patch is:
> http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-2.patch
>

There are some bits missing.  Not sure if it is related to your problem or not.

Robert, please take the MIPS preemptible kernel update patch.

> We ultimately want to add in real-time support, such as Ingo's O(1)
> scheduler - if this is 'complete' for MIPS. 

O(1) shortens process dispatching time, usually not a big time saver
unless you have *lots* of process and/or you are doing frequent context
switches.

Another patch which is probably more important is the Ingo's breaking
selected big lock patch.  That will preemption work more effectively.

> I don't know if it would be
> better just to go for this in one hit, or if we'd need the preemption
> sorted out anyway first. 

You do have to sort them out one by one.  (Or you get them all by becoming
mvista customer. :-0)

> Or should we just go to a 2.5.x kernel instead?

We'd love to have more people bang on 2.5 MIPS *grin* ...

Jun
 

--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="021217-mips-2.4-prek-update.patch"


Additional patch for MIPS against RML's 2.4.19-2 preemptiable kernel patch.

http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-2.patch

Jun

diff -Nru link/arch/mips/kernel/irq.c.orig link/arch/mips/kernel/irq.c
--- link/arch/mips/kernel/irq.c.orig	Tue Dec 17 09:44:29 2002
+++ link/arch/mips/kernel/irq.c	Tue Dec 17 09:44:45 2002
@@ -507,13 +507,13 @@
 		}
 
 		current->preempt_count ++;
-		sti();
+		__sti();
 		if (user_mode(regs)) {
 			schedule();
 		} else {
 			preempt_schedule();
 		}
-		cli();
+		__cli();
 	}
 #endif
 
diff -Nru link/arch/mips/kernel/time.c.orig link/arch/mips/kernel/time.c
--- link/arch/mips/kernel/time.c.orig	Mon Dec  2 16:56:03 2002
+++ link/arch/mips/kernel/time.c	Tue Dec 17 09:53:37 2002
@@ -416,6 +416,8 @@
 {
 	int cpu = smp_processor_id();
 
+	preempt_disable();
+
 	irq_enter(cpu, irq);
 	kstat.irqs[cpu][irq]++;
 
@@ -426,12 +428,34 @@
 
 	if (softirq_pending(cpu))
 		do_softirq();
+
+#if defined(CONFIG_PREEMPT)
+        while (--current->preempt_count == 0) {
+                db_assert(intr_off());
+                db_assert(!in_interrupt());
+
+                if (current->need_resched == 0) {
+                        break;
+                }
+
+                current->preempt_count ++;
+                __sti();
+                if (user_mode(regs)) {
+                        schedule();
+                } else {
+                        preempt_schedule();
+                }
+                __cli();
+        }
+#endif
 }
 
 asmlinkage void ll_local_timer_interrupt(int irq, struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
+	preempt_disable();
+
 	irq_enter(cpu, irq);
 	kstat.irqs[cpu][irq]++;
 
@@ -442,6 +466,26 @@
 
 	if (softirq_pending(cpu))
 		do_softirq();
+
+#if defined(CONFIG_PREEMPT)
+	while (--current->preempt_count == 0) {
+		db_assert(intr_off());
+		db_assert(!in_interrupt());
+
+		if (current->need_resched == 0) {
+			break;
+		}
+
+		current->preempt_count ++;
+		__sti();
+		if (user_mode(regs)) {
+			schedule();
+		} else {
+			preempt_schedule();
+		}
+		__cli();
+	}
+#endif
 }
 
 /*
diff -Nru link/include/asm-mips/softirq.h.orig link/include/asm-mips/softirq.h
--- link/include/asm-mips/softirq.h.orig	Tue Dec 17 09:44:29 2002
+++ link/include/asm-mips/softirq.h	Tue Dec 17 09:54:13 2002
@@ -10,6 +10,9 @@
 #ifndef _ASM_SOFTIRQ_H
 #define _ASM_SOFTIRQ_H
 
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 

--DIOMP1UsTsWJauNi--
