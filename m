Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NC2CRw022943
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 05:02:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NC2CMT022942
	for linux-mips-outgoing; Tue, 23 Jul 2002 05:02:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NC1hRw022913
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 05:01:43 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA06236
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 05:03:08 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA26838;
	Tue, 23 Jul 2002 13:55:14 +0200 (MET DST)
Date: Tue, 23 Jul 2002 13:55:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>
Subject: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Message-ID: <Pine.GSO.3.96.1020722222909.2373P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 There is no need to carry support for pure 32-bit CPUs around in
cpu_probe() in arch/mips64/kernel/setup.c, since such CPUs are not
supported by the port and likely won't ever reach that code due to a
reserved instruction exception earlier.  The code is misleading and a
possible cause of troubles, e.g. the 2.4 branch doesn't link now because
of an unresolved reference to cpu_has_fpu() which is only needed for
R2000/R3000. 

 The following patch removes the code for 2.4.  For the trunk
cpu_has_fpu() would be removed as well.  Any objections?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020719-mips64-cpu-2
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/setup.c linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/setup.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/setup.c	2002-07-15 02:57:48.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/setup.c	2002-07-22 23:44:00.000000000 +0000
@@ -123,16 +123,6 @@ static inline void check_wait(void)
 {
 	printk("Checking for 'wait' instruction... ");
 	switch(mips_cpu.cputype) {
-	case CPU_R3081:
-	case CPU_R3081E:
-		cpu_wait = r3081_wait;
-		printk(" available.\n");
-		break;
-	case CPU_TX3927:
-	case CPU_TX39XX:
-		cpu_wait = r39xx_wait;
-		printk(" available.\n");
-		break;
 	case CPU_R4200: 
 /*	case CPU_R4300: */
 	case CPU_R4600: 
@@ -143,9 +133,6 @@ static inline void check_wait(void)
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_TX49XX:
-	case CPU_4KC:
-	case CPU_4KEC:
-	case CPU_4KSC:
 	case CPU_5KC:
 /*	case CPU_20KC:*/
 		cpu_wait = r4k_wait;
@@ -163,28 +150,6 @@ void __init check_bugs(void)
 }
 
 /*
- * Probe whether cpu has config register by trying to play with
- * alternate cache bit and see whether it matters.
- * It's used by cpu_probe to distinguish between R3000A and R3081.
- */
-static inline int cpu_has_confreg(void)
-{
-#ifdef CONFIG_CPU_R3000
-	extern unsigned long r3k_cache_size(unsigned long);
-	unsigned long size1, size2;
-	unsigned long cfg = read_32bit_cp0_register(CP0_CONF);
-
-	size1 = r3k_cache_size(ST0_ISC);
-	write_32bit_cp0_register(CP0_CONF, cfg^CONF_AC);
-	size2 = r3k_cache_size(ST0_ISC);
-	write_32bit_cp0_register(CP0_CONF, cfg);
-	return size1 != size2;
-#else
-	return 0;
-#endif
-}
-
-/*
  * Get the FPU Implementation/Revision.
  */
 static inline unsigned long cpu_get_fpu_id(void)
@@ -235,28 +200,6 @@ static inline void cpu_probe(void)
 	switch (mips_cpu.processor_id & 0xff0000) {
 	case PRID_COMP_LEGACY:
 		switch (mips_cpu.processor_id & 0xff00) {
-		case PRID_IMP_R2000:
-			mips_cpu.cputype = CPU_R2000;
-			mips_cpu.isa_level = MIPS_CPU_ISA_I;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX;
-			if (cpu_has_fpu())
-				mips_cpu.options |= MIPS_CPU_FPU;
-			mips_cpu.tlbsize = 64;
-			break;
-		case PRID_IMP_R3000:
-			if ((mips_cpu.processor_id & 0xff) == PRID_REV_R3000A)
-				if (cpu_has_confreg())
-					mips_cpu.cputype = CPU_R3081E;
-				else
-					mips_cpu.cputype = CPU_R3000A;
-			else
-				mips_cpu.cputype = CPU_R3000;
-			mips_cpu.isa_level = MIPS_CPU_ISA_I;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX;
-			if (cpu_has_fpu())
-				mips_cpu.options |= MIPS_CPU_FPU;
-			mips_cpu.tlbsize = 64;
-			break;
 		case PRID_IMP_R4000:
 			if ((mips_cpu.processor_id & 0xff) == PRID_REV_R4400)
 				mips_cpu.cputype = CPU_R4400SC;
@@ -329,32 +272,6 @@ static inline void cpu_probe(void)
 		        mips_cpu.tlbsize = 48;
 			break;
 		#endif
-		case PRID_IMP_TX39:
-			mips_cpu.isa_level = MIPS_CPU_ISA_I;
-			mips_cpu.options = MIPS_CPU_TLB;
-
-			if ((mips_cpu.processor_id & 0xf0) ==
-			    (PRID_REV_TX3927 & 0xf0)) {
-				mips_cpu.cputype = CPU_TX3927;
-				mips_cpu.tlbsize = 64;
-				mips_cpu.icache.ways = 2;
-				mips_cpu.dcache.ways = 2;
-			} else {
-				switch (mips_cpu.processor_id & 0xff) {
-				case PRID_REV_TX3912:
-					mips_cpu.cputype = CPU_TX3912;
-					mips_cpu.tlbsize = 32;
-					break;
-				case PRID_REV_TX3922:
-					mips_cpu.cputype = CPU_TX3922;
-					mips_cpu.tlbsize = 64;
-					break;
-				default:
-					mips_cpu.cputype = CPU_UNKNOWN;
-					break;
-				}
-			}
-			break;
 		case PRID_IMP_R4700:
 			mips_cpu.cputype = CPU_R4700;
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
@@ -401,18 +318,6 @@ static inline void cpu_probe(void)
 			mips_cpu.icache.ways = 2;
 			mips_cpu.dcache.ways = 2;
 			break;
-		case PRID_IMP_R6000:
-			mips_cpu.cputype = CPU_R6000;
-			mips_cpu.isa_level = MIPS_CPU_ISA_II;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_FPU;
-			mips_cpu.tlbsize = 32;
-			break;
-		case PRID_IMP_R6000A:
-			mips_cpu.cputype = CPU_R6000A;
-			mips_cpu.isa_level = MIPS_CPU_ISA_II;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_FPU;
-			mips_cpu.tlbsize = 32;
-			break;
 		case PRID_IMP_RM7000:
 			mips_cpu.cputype = CPU_RM7000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV;
@@ -459,15 +364,6 @@ static inline void cpu_probe(void)
 #ifdef CONFIG_CPU_MIPS32
 	case PRID_COMP_MIPS:
 		switch (mips_cpu.processor_id & 0xff00) {
-		case PRID_IMP_4KC:
-			mips_cpu.cputype = CPU_4KC;
-			break;
-		case PRID_IMP_4KEC:
-			mips_cpu.cputype = CPU_4KEC;
-			break;
-		case PRID_IMP_4KSC:
-			mips_cpu.cputype = CPU_4KSC;
-			break;
 		case PRID_IMP_5KC:
 			mips_cpu.cputype = CPU_5KC;
 			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
@@ -481,20 +377,6 @@ static inline void cpu_probe(void)
 			break;
 		}		
 		break;
-	case PRID_COMP_ALCHEMY:
-		switch (mips_cpu.processor_id & 0xff00) {
-		case PRID_IMP_AU1_REV1:
-		case PRID_IMP_AU1_REV2:
-			if (mips_cpu.processor_id & 0xff000000)
-				mips_cpu.cputype = CPU_AU1500;
-			else
-				mips_cpu.cputype = CPU_AU1000;
-			break;
-		default:
-			mips_cpu.cputype = CPU_UNKNOWN;
-			break;
-		}
-		break;
 #endif /* CONFIG_CPU_MIPS32 */
 	case PRID_COMP_SIBYTE:
 		switch (mips_cpu.processor_id & 0xff00) {
@@ -793,18 +675,6 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 }
 
-void r3081_wait(void) 
-{
-	unsigned long cfg = read_32bit_cp0_register(CP0_CONF);
-	write_32bit_cp0_register(CP0_CONF, cfg|CONF_HALT);
-}
-
-void r39xx_wait(void)
-{
-	unsigned long cfg = read_32bit_cp0_register(CP0_CONF);
-	write_32bit_cp0_register(CP0_CONF, cfg|TX39_CONF_HALT);
-}
-
 void r4k_wait(void)
 {
 	__asm__(".set\tmips3\n\t"
