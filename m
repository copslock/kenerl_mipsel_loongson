Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1M3nKF19212
	for linux-mips-outgoing; Thu, 21 Feb 2002 19:49:20 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1M3nE919209
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 19:49:14 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g1M2kRB10028;
	Thu, 21 Feb 2002 18:46:27 -0800
Message-ID: <3C75B181.C5A065A1@mvista.com>
Date: Thu, 21 Feb 2002 18:48:33 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: lazy fpu switch irrelavant to no-fpu case?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


It appears to me that lazy fpu switch has no relevancy to CPUs that don't have
FPU.

If you do a scan, you will see last_task_used_math are used in four kernel
files:

ptrace.c
process.c
signal.c
traps.c

In the case of ptrace.c and process.c, the variable is used only when CPU has
FPU.

In the case of traps.c (do_cpu()), it used redaundantly with another condition
checking.

In the case of signal.c, no matter what last_task_used_math is, the same code
will be executed anyway.

Now think about it, it actually makes sense - if we don't have hardware FPU,
why do we care of fpu context switch.

Anyhow, the problem I am seeing with FPU/SMP case seems to be caused by FPU
emulation code itself, if we can assume it is not caused by fpu context
switch.  Right now the FPU is not turned on on the box.

The following patch cleans it up a little based on the above observation. 
Make sense?

Jun

diff -Nru linux/arch/mips/kernel/traps.c.orig linux/arch/mips/kernel/traps.c
--- linux/arch/mips/kernel/traps.c.orig Wed Jan 30 15:17:12 2002
+++ linux/arch/mips/kernel/traps.c      Thu Feb 21 18:46:28 2002
@@ -678,14 +678,11 @@
        return;
 
 fp_emul:
-       if (last_task_used_math != current) {
-               if (!current->used_math) {
-                       fpu_emulator_init_fpu();
-                       current->used_math = 1;
-               }
+       if (!current->used_math) {
+               fpu_emulator_init_fpu();
+               current->used_math = 1;
        }
        sig = fpu_emulator_cop1Handler(regs);
-       last_task_used_math = current;
        if (sig)
                force_sig(sig, current);
        return;
