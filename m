Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:10:07 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:5004 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022720AbXJBUJ7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 21:09:59 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1Ico0y-0005uU-Lc; Tue, 02 Oct 2007 22:06:44 +0200
Date:	Tue, 2 Oct 2007 22:06:44 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org, qemu-devel@nongnu.org
Subject: QEMU/MIPS & dyntick kernel
Message-ID: <20071002200644.GA19140@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

As announced by Ralf Baechle, dyntick is now available on MIPS. I gave a
try on QEMU/MIPS, and unfortunately it doesn't work correctly.

In some cases the kernel schedules an event very near in the future, 
which means the timer is scheduled a few cycles only from its current
value. Unfortunately under QEMU, the timer runs too fast compared to the
speed at which instructions are execution. This causes a lockup of the
kernel. This can be triggered by running hwclock --hctosys in the guest
(which is run at boot time by most distributions). Until now, I haven't 
found any other way to trigger the bug.

The problematic code in the kernel from arch/mips/kernel/time.c is the
following:

        cnt = read_c0_count();
        cnt += delta;
        write_c0_compare(cnt);
        res = ((long)(read_c0_count() - cnt ) > 0) ? -ETIME : 0;

Note that there is a minimum value for delta (currently set to 48) to 
avoid lockup.

In QEMU, the emulated kernel runs at 100 MHz, ie very fast, which means
that more than 48 timer cycles happen between the two calls of
read_c0_count(). The code returns -ETIME, and the routine is called
again with 48 and so on.

I have tried to reduce the speed of the timer, the problem disappears
when running at 1MHz (on my machine).

Here are a few proposed ways to fix the problem (they are not exclusive):

1) Improve the emulation speed for timer instructions. This is what I
did with the attached patch. I see no obvious reason of stopping the
translation after a write to CP0_Compare, so I removed that part. I also
reduced the code that emulates timer accesses.

That helps but that is clearly not enough. With this patch the maximum
timer speed is 5MHz.

2) Increase the minimum value for delta. For a 100MHz timer 48 cycles 
means 480ns. On the other side a kernel running at 250Hz (default on 
MIPS) is scheduling tasks with a 4ms resolution.

Increasing it to about 10 microseconds should have no impact on the
scheduling, even on real hardware.

3) Reduce the timer speed. As the timer is supposed to run at half the
speed of the CPU, that would mean the kernel would see a 2 to 10MHz 
CPU.

4) Add a hack to QEMU to make the timer slower within a translation
block (like increasing it by 1 at each access), without changing the
overall speed. This might break other parts or other OSeS.


Any thoughts or other ideas?

Bye,
Aurelien

[1] http://www.linux-mips.org/archives/linux-mips/2007-09/msg00372.html

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

--Dxnq1zWXvFF0Q93v
Content-Type: text/x-diff; charset=iso-8859-15
Content-Disposition: attachment; filename="mips-qemu-timer.diff"

Index: hw/mips_timer.c
===================================================================
RCS file: /sources/qemu/qemu/hw/mips_timer.c,v
retrieving revision 1.8
diff -u -d -p -r1.8 mips_timer.c
--- hw/mips_timer.c	25 Sep 2007 16:53:15 -0000	1.8
+++ hw/mips_timer.c	2 Oct 2007 10:20:37 -0000
@@ -1,5 +1,7 @@
 #include "vl.h"
 
+#define TIMER_FREQ	100 * 1000 * 1000
+
 void cpu_mips_irqctrl_init (void)
 {
 }
@@ -22,49 +24,41 @@ uint32_t cpu_mips_get_count (CPUState *e
     else
         return env->CP0_Count +
             (uint32_t)muldiv64(qemu_get_clock(vm_clock),
-                               100 * 1000 * 1000, ticks_per_sec);
+                               TIMER_FREQ, ticks_per_sec);
 }
 
-void cpu_mips_store_count (CPUState *env, uint32_t count)
+static void cpu_mips_timer_update(CPUState *env)
 {
     uint64_t now, next;
-    uint32_t tmp;
-    uint32_t compare = env->CP0_Compare;
+    uint32_t wait;
 
-    tmp = count;
-    if (count == compare)
-        tmp++;
     now = qemu_get_clock(vm_clock);
-    next = now + muldiv64(compare - tmp, ticks_per_sec, 100 * 1000 * 1000);
-    if (next == now)
-	next++;
-#if 0
-    if (logfile) {
-        fprintf(logfile, "%s: 0x%08" PRIx64 " %08x %08x => 0x%08" PRIx64 "\n",
-                __func__, now, count, compare, next - now);
-    }
-#endif
-    /* Store new count and compare registers */
-    env->CP0_Compare = compare;
-    env->CP0_Count =
-        count - (uint32_t)muldiv64(now, 100 * 1000 * 1000, ticks_per_sec);
-    /* Adjust timer */
+    wait = env->CP0_Compare - env->CP0_Count - 
+	    (uint32_t)muldiv64(now, TIMER_FREQ, ticks_per_sec);
+    next = now + muldiv64(wait, ticks_per_sec, TIMER_FREQ);
     qemu_mod_timer(env->timer, next);
 }
 
-static void cpu_mips_update_count (CPUState *env, uint32_t count)
+void cpu_mips_store_count (CPUState *env, uint32_t count)
 {
     if (env->CP0_Cause & (1 << CP0Ca_DC))
-        return;
-
-    cpu_mips_store_count(env, count);
+        env->CP0_Count = count;
+    else {
+        /* Store new count register */
+        env->CP0_Count =
+            count - (uint32_t)muldiv64(qemu_get_clock(vm_clock), 
+                                       TIMER_FREQ, ticks_per_sec);
+        /* Update timer timer */
+        cpu_mips_timer_update(env);
+    }
 }
 
 void cpu_mips_store_compare (CPUState *env, uint32_t value)
 {
     env->CP0_Compare = value;
-    cpu_mips_update_count(env, cpu_mips_get_count(env));
-    if ((env->CP0_Config0 & (0x7 << CP0C0_AR)) == (1 << CP0C0_AR))
+    if (!(env->CP0_Cause & (1 << CP0Ca_DC)))
+        cpu_mips_timer_update(env);
+    if (env->insn_flags & ISA_MIPS32R2)
         env->CP0_Cause &= ~(1 << CP0Ca_TI);
     qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
@@ -78,7 +72,7 @@ void cpu_mips_stop_count(CPUState *env)
 {
     /* Store the current value */
     env->CP0_Count += (uint32_t)muldiv64(qemu_get_clock(vm_clock),
-                                         100 * 1000 * 1000, ticks_per_sec);
+                                         TIMER_FREQ, ticks_per_sec);
 }
 
 static void mips_timer_cb (void *opaque)
@@ -95,8 +89,8 @@ static void mips_timer_cb (void *opaque)
     if (env->CP0_Cause & (1 << CP0Ca_DC))
         return;
 
-    cpu_mips_update_count(env, cpu_mips_get_count(env));
-    if ((env->CP0_Config0 & (0x7 << CP0C0_AR)) == (1 << CP0C0_AR))
+    cpu_mips_timer_update(env);
+    if (env->insn_flags & ISA_MIPS32R2)
         env->CP0_Cause |= 1 << CP0Ca_TI;
     qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
@@ -105,5 +99,5 @@ void cpu_mips_clock_init (CPUState *env)
 {
     env->timer = qemu_new_timer(vm_clock, &mips_timer_cb, env);
     env->CP0_Compare = 0;
-    cpu_mips_update_count(env, 1);
+    cpu_mips_store_count(env, 1);
 }
Index: target-mips/translate.c
===================================================================
RCS file: /sources/qemu/qemu/target-mips/translate.c,v
retrieving revision 1.104
diff -u -d -p -r1.104 translate.c
--- target-mips/translate.c	30 Sep 2007 01:58:33 -0000	1.104
+++ target-mips/translate.c	2 Oct 2007 10:20:38 -0000
@@ -2763,8 +2763,6 @@ static void gen_mtc0 (CPUState *env, Dis
         default:
             goto die;
         }
-        /* Stop translation as we may have switched the execution mode */
-        ctx->bstate = BS_STOP;
         break;
     case 12:
         switch (sel) {

--Dxnq1zWXvFF0Q93v--
