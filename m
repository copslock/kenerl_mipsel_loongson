Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g56F4HnC025544
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 08:04:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g56F4Hm6025543
	for linux-mips-outgoing; Thu, 6 Jun 2002 08:04:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from coplin19.mips.com ([80.63.7.130])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g56F48nC025538
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 08:04:09 -0700
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g56F65n25669
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 17:06:05 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Thu, 6 Jun 2002 17:06:05 +0200 (MEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Float crash. Fix in exit_thread()
Message-ID: <Pine.LNX.4.44.0206061657510.25647-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm running on a system with no FPU. Now, I've got a program do_float 
which seems to work fine. But if I enter:

/bin/echo hello; ./do_float

it terminates with a bus error or FP error. The bug is in exit_thread(). 
Can anyone explain to me, what good the "cfc1 $0,$31" does?


Here is the patch:

RCS file: /cvs/linux/arch/mips/kernel/process.c,v
retrieving revision 1.36
diff -u -r1.36 process.c
--- process.c   2002/05/29 18:36:28     1.36
+++ process.c   2002/06/06 14:51:32
@@ -54,9 +54,11 @@
 void exit_thread(void)
 {
        /* Forget lazy fpu state */
-       if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-               __enable_fpu();
-               __asm__ __volatile__("cfc1\t$0,$31");
+       if (last_task_used_math == current) {
+               if (mips_cpu.options & MIPS_CPU_FPU) {
+                       __enable_fpu();
+                       __asm__ __volatile__("cfc1\t$0,$31");
+               }
                last_task_used_math = NULL;
        }
 }
@@ -64,9 +66,11 @@
 void flush_thread(void)
 {
        /* Forget lazy fpu state */
-       if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
-               __enable_fpu();
-               __asm__ __volatile__("cfc1\t$0,$31");
+       if (last_task_used_math == current) {
+               if (mips_cpu.options & MIPS_CPU_FPU) {
+                       __enable_fpu();
+                       __asm__ __volatile__("cfc1\t$0,$31");
+               }
                last_task_used_math = NULL;
        }
 }



/Kjeld


-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
