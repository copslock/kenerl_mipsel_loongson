Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75Ca3Rw006497
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 05:36:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75Ca3kb006496
	for linux-mips-outgoing; Mon, 5 Aug 2002 05:36:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75CZfRw006485
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 05:35:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22694;
	Mon, 5 Aug 2002 14:38:05 +0200 (MET DST)
Date: Mon, 5 Aug 2002 14:38:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@oss.sgi.com
cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: [patch] Provide useful siginfo_t data for integer overflow traps
Message-ID: <Pine.GSO.3.96.1020805140744.18894N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is an update to the overflow trap handler that is used for
add/addi/sub/etc. signed integer operations that trap on the
2's-complement overflow.  With an example test program as follows:

$ cat addi.c
#define _GNU_SOURCE

#include <signal.h>
#include <stdint.h>
#include <stdio.h>

#define y 0x7654

static volatile sig_atomic_t fpe_caught;

static void catch_fpe(int sig, siginfo_t *info, void *ptr)
{
	struct sigcontext *sc;

	fpe_caught = 1;

	sc = ptr;

	printf("SIGFPE caught, info:\n");
	printf("si_code: %i\n", info->si_code);
	printf("si_addr: %08lx\n", (long)info->si_addr);

#if 0	/* Until the kernel is fixed not to advance...  */
	sc->sc_pc += 4;
#endif
}

int main(void)
{
	int32_t x = 0x7fff9876;
	int32_t z;

	printf("Testing 32-bit signed addition:\n");
	{
		struct sigaction sa, osa;
		long __r0;

		sa.sa_flags = SA_SIGINFO;
		sa.sa_sigaction = catch_fpe;
		sigemptyset(&sa.sa_mask);
		sigaction(SIGFPE, &sa, &osa);

		asm volatile(
			"lw	%1,%2\n\t"
			"addi	%1,%1,%3\n\t"
			"sw	%1,%0\n\t"
			: "=m" (z), "=r" (__r0)
			: "m" (x), "i" (y)
			: "memory"
		);

		sigaction(SIGFPE, &osa, NULL);

		if (!fpe_caught) {
			printf("No signal caught, dumping status:\n");
			printf("%08x + %08x = %08x\n",
			       x, (int32_t)y, z);
		}
	}

	return !fpe_caught;
}

I'm getting the following information without the patch:

$ ./addi
Testing 32-bit signed addition:
SIGFPE caught, info:
si_code: 128
si_addr: 00000000

and the following one with the patch:

$ ./addi
Testing 32-bit signed addition:
SIGFPE caught, info:
si_code: 2
si_addr: 0040095c

which is more useful to the userland and corresponds to what do_tr() and
do_bp() already do for explicitly coded multiply/divide overflow traps. 

 Any comments?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020802-ov-0
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020802.macro/arch/mips/kernel/traps.c linux-mips-2.4.19-rc1-20020802/arch/mips/kernel/traps.c
--- linux-mips-2.4.19-rc1-20020802.macro/arch/mips/kernel/traps.c	2002-07-23 03:00:18.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020802/arch/mips/kernel/traps.c	2002-08-04 19:32:38.000000000 +0000
@@ -462,10 +462,16 @@ asmlinkage void do_be(struct pt_regs *re
 
 asmlinkage void do_ov(struct pt_regs *regs)
 {
+	siginfo_t info;
+
 	if (compute_return_epc(regs))
 		return;
 
-	force_sig(SIGFPE, current);
+	info.si_code = FPE_INTOVF;
+	info.si_signo = SIGFPE;
+	info.si_errno = 0;
+	info.si_addr = (void *)regs->cp0_epc;
+	force_sig_info(SIGFPE, &info, current);
 }
 
 /*
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020802.macro/arch/mips64/kernel/traps.c linux-mips-2.4.19-rc1-20020802/arch/mips64/kernel/traps.c
--- linux-mips-2.4.19-rc1-20020802.macro/arch/mips64/kernel/traps.c	2002-07-31 02:58:45.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020802/arch/mips64/kernel/traps.c	2002-08-04 19:36:55.000000000 +0000
@@ -365,9 +365,16 @@ asmlinkage void do_be(struct pt_regs *re
 
 asmlinkage void do_ov(struct pt_regs *regs)
 {
+	siginfo_t info;
+
 	if (compute_return_epc(regs))
 		return;
-	force_sig(SIGFPE, current);
+
+	info.si_code = FPE_INTOVF;
+	info.si_signo = SIGFPE;
+	info.si_errno = 0;
+	info.si_addr = (void *)regs->cp0_epc;
+	force_sig_info(SIGFPE, &info, current);
 }
 
 /*
