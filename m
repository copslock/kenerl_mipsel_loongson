Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 22:31:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32793 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816019AbaDFUb3TnHsf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 22:31:29 +0200
Date:   Sun, 6 Apr 2014 21:31:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Theodore Ts'o <tytso@mit.edu>, John Crispin <blogic@openwrt.org>,
        Andrew McGregor <andrewmcgr@gmail.com>,
        Dave Taht <dave.taht@bufferbloat.net>,
        Felix Fietkau <nbd@nbd.name>,
        Simon Kelley <simon@thekelleys.org.uk>,
        Jim Gettys <jg@freedesktop.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: Implement random_get_entropy with CP0 Random
Message-ID: <alpine.LFD.2.11.1404062102130.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Update to commit 9c9b415c50bc298ac61412dff856eae2f54889ee [MIPS: 
Reimplement get_cycles().]

On systems were for whatever reasons we can't use the cycle counter, fall 
back to the c0_random register as an entropy source.  It has however a 
very small range that makes it suitable for random_get_entropy only and 
not get_cycles.

This optimised version compiles to 8 instructions in the fast path even in 
the worst case of all the conditions to check being variable (including a 
MFC0 move delay slot that is only required for very old processors):

     828:	8cf90000 	lw	t9,0(a3)
			828: R_MIPS_LO16	jiffies
     82c:	40057800 	mfc0	a1,c0_prid
     830:	3c0200ff 	lui	v0,0xff
     834:	00a21024 	and	v0,a1,v0
     838:	1040007d 	beqz	v0,a30 <add_interrupt_randomness+0x22c>
     83c:	3c030000 	lui	v1,0x0
			83c: R_MIPS_HI16	cpu_data
     840:	40024800 	mfc0	v0,c0_count
     844:	00000000 	nop
     848:	00409021 	move	s2,v0
     84c:	8ce20000 	lw	v0,0(a3)
			84c: R_MIPS_LO16	jiffies

On most targets the sequence will be shorter and on some it will reduce to 
a single `MFC0 <reg>,c0_count', as all MIPS architecture (i.e. non-legacy 
MIPS) processors require the CP0 Count register to be present.

The only known exception that reports MIPS architecture compliance, but 
contrary to that lacks CP0 Count is the Ingenic JZ4740 thingy.  For broken 
platforms like that this code requires cpu_has_counter to be hardcoded to 
0 (i.e. no variable setting is permitted) so as not to penalise all the 
other good platforms out there.

The asm barrier is required so that the compiler does not pull any 
potentially costly (cold cache!) `cpu_data' variable access into the fast 
path.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Everyone --

 I see the random_get_entropy API got adopted now and we have a handler 
for the M68K architecture already.  Here's a regenerated version of code I 
posted last year to add a version for the MIPS platform too, for 
processors that do not have a (usable) CP0 Count register.  There's no 
functional change compared to the previous version.

  Maciej

linux-mips-cycles.patch
Index: linux-20140404-4maxp64/arch/mips/include/asm/timex.h
===================================================================
--- linux-20140404-4maxp64.orig/arch/mips/include/asm/timex.h
+++ linux-20140404-4maxp64/arch/mips/include/asm/timex.h
@@ -4,15 +4,18 @@
  * for more details.
  *
  * Copyright (C) 1998, 1999, 2003 by Ralf Baechle
+ * Copyright (C) 2014 by Maciej W. Rozycki
  */
 #ifndef _ASM_TIMEX_H
 #define _ASM_TIMEX_H
 
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
+
+#include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
-#include <asm/cpu-type.h>
 
 /*
  * This is the clock rate of the i8253 PIT.  A MIPS system may not have
@@ -45,29 +48,54 @@ typedef unsigned int cycles_t;
  * However for now the implementaton of this function doesn't get these
  * fine details right.
  */
-static inline cycles_t get_cycles(void)
+static inline int can_use_mips_counter(unsigned int prid)
 {
-	switch (boot_cpu_type()) {
-	case CPU_R4400PC:
-	case CPU_R4400SC:
-	case CPU_R4400MC:
-		if ((read_c0_prid() & 0xff) >= 0x0050)
-			return read_c0_count();
-		break;
+	int comp = (prid & PRID_COMP_MASK) != PRID_COMP_LEGACY;
 
-        case CPU_R4000PC:
-        case CPU_R4000SC:
-        case CPU_R4000MC:
-		break;
+	if (__builtin_constant_p(cpu_has_counter) && !cpu_has_counter)
+		return 0;
+	else if (__builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r)
+		return 1;
+	else if (likely(!__builtin_constant_p(cpu_has_mips_r) && comp))
+		return 1;
+	/* Make sure we don't peek at cpu_data[0].options in the fast path! */
+	if (!__builtin_constant_p(cpu_has_counter))
+		asm volatile("" : "=m" (cpu_data[0].options));
+	if (likely(cpu_has_counter &&
+		   prid >= (PRID_IMP_R4000 | PRID_REV_ENCODE_44(5, 0))))
+		return 1;
+	else
+		return 0;
+}
 
-	default:
-		if (cpu_has_counter)
-			return read_c0_count();
-		break;
-	}
+static inline cycles_t get_cycles(void)
+{
+	if (can_use_mips_counter(read_c0_prid()))
+		return read_c0_count();
+	else
+		return 0;	/* no usable counter */
+}
 
-	return 0;	/* no usable counter */
+/*
+ * Like get_cycles - but where c0_count is not available we desperately
+ * use c0_random in an attempt to get at least a little bit of entropy.
+ *
+ * R6000 and R6000A neither have a count register nor a random register.
+ * That leaves no entropy source in the CPU itself.
+ */
+static inline unsigned long random_get_entropy(void)
+{
+	unsigned int prid = read_c0_prid();
+	unsigned int imp = prid & PRID_IMP_MASK;
+
+	if (can_use_mips_counter(prid))
+		return read_c0_count();
+	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
+		return read_c0_random();
+	else
+		return 0;	/* no usable register */
 }
+#define random_get_entropy random_get_entropy
 
 #endif /* __KERNEL__ */
 
Index: linux-20140404-4maxp64/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-20140404-4maxp64.orig/arch/mips/kernel/cpu-probe.c
+++ linux-20140404-4maxp64/arch/mips/kernel/cpu-probe.c
@@ -1041,6 +1041,7 @@ static inline void cpu_probe_ingenic(str
 	decode_configs(c);
 	/* JZRISC does not implement the CP0 counter. */
 	c->options &= ~MIPS_CPU_COUNTER;
+	BUG_ON(!__builtin_constant_p(cpu_has_counter) || cpu_has_counter);
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_JZRISC:
 		c->cputype = CPU_JZRISC;
