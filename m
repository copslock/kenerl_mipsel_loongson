Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQGUhZ10333
	for linux-mips-outgoing; Mon, 26 Nov 2001 08:30:43 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQGURo10305
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 08:30:33 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA01718;
	Mon, 26 Nov 2001 16:28:36 +0100 (MET)
Date: Mon, 26 Nov 2001 16:28:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: Report the faulting FPU instruction
Message-ID: <Pine.GSO.3.96.1011126160822.21598N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 I believe it's desireable to point to the faulting instruction upon an
FPU trap and not the following one.  Why?  First, the FPU restores the
state from before attempting to exectute the instruction.  Second, with
the current approach state is lost -- consider instructions in branch/jump
delay slots.  Third, erroneous execution is possible if SIG_FPE's handler
is set to "ignore" by mistake.

 The following patch implements the described approach.  It should not
affect standard handlers which use setjmp()/longjmp(), but it should
enable a smarter interpreting handler or just better diagnostics.  Both
the hardware and the emulator are handled.  Tested successfully with gdb
on an R3k, an R4k and the emulator. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.14-20011123-fpu-epc-0
diff -up --recursive --new-file linux-mips-2.4.14-20011123.macro/arch/mips/kernel/traps.c linux-mips-2.4.14-20011123/arch/mips/kernel/traps.c
--- linux-mips-2.4.14-20011123.macro/arch/mips/kernel/traps.c	Wed Nov 21 05:26:46 2001
+++ linux-mips-2.4.14-20011123/arch/mips/kernel/traps.c	Sun Nov 25 13:25:06 2001
@@ -497,9 +497,6 @@ asmlinkage void do_fpe(struct pt_regs *r
 		return;
 	}
 
-	if (compute_return_epc(regs))
-		return;
-
 	force_sig(SIGFPE, current);
 	printk(KERN_DEBUG "Sent send SIGFPE to %s\n", current->comm);
 }
diff -up --recursive --new-file linux-mips-2.4.14-20011123.macro/arch/mips/math-emu/cp1emu.c linux-mips-2.4.14-20011123/arch/mips/math-emu/cp1emu.c
--- linux-mips-2.4.14-20011123.macro/arch/mips/math-emu/cp1emu.c	Sun Oct 14 04:26:36 2001
+++ linux-mips-2.4.14-20011123/arch/mips/math-emu/cp1emu.c	Sun Nov 25 13:29:30 2001
@@ -1721,6 +1721,9 @@ int fpu_emulator_cop1Handler(struct pt_r
 		/* but if epc has advanced, then ignore it */
 		sig = 0;
 
+	if (sig)
+		xcp->cp0_epc = prevepc;
+
 	return sig;
 }
 
