Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FDqw8d024209
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 06:52:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FDqvLM024208
	for linux-mips-outgoing; Mon, 15 Apr 2002 06:52:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FDqT8d024180
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 06:52:30 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23063;
	Mon, 15 Apr 2002 15:53:25 +0200 (MET DST)
Date: Mon, 15 Apr 2002 15:53:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4: FPU exception updates
Message-ID: <Pine.GSO.3.96.1020415154230.19735J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here are updates to negate the FPU exception presence flag.  Tested on an
R3400 and an R4400SC.  FPU-less configurations not tested but they should
work as the changes are straightforward.  Ralf, please apply. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.18-20020412-irq-49
diff -up --recursive --new-file linux-mips-2.4.18-20020412.macro/arch/mips/dec/setup.c linux-mips-2.4.18-20020412/arch/mips/dec/setup.c
--- linux-mips-2.4.18-20020412.macro/arch/mips/dec/setup.c	2002-04-10 02:58:33.000000000 +0000
+++ linux-mips-2.4.18-20020412/arch/mips/dec/setup.c	2002-04-13 01:42:32.000000000 +0000
@@ -733,7 +733,7 @@ void __init init_IRQ(void)
 	set_except_vector(0, decstation_handle_int);
 
 	/* Free the FPU interrupt if the exception is present. */
-	if (mips_cpu.options & MIPS_CPU_FPUEX) {
+	if (!(mips_cpu.options & MIPS_CPU_NOFPUEX)) {
 		cpu_fpu_mask = 0;
 		dec_interrupt[DEC_IRQ_FPU] = -1;
 	}
diff -up --recursive --new-file linux-mips-2.4.18-20020412.macro/arch/mips/kernel/setup.c linux-mips-2.4.18-20020412/arch/mips/kernel/setup.c
--- linux-mips-2.4.18-20020412.macro/arch/mips/kernel/setup.c	2002-04-10 02:58:36.000000000 +0000
+++ linux-mips-2.4.18-20020412/arch/mips/kernel/setup.c	2002-04-13 01:47:38.000000000 +0000
@@ -234,7 +234,7 @@ static inline void cpu_probe(void)
 		case PRID_IMP_R2000:
 			mips_cpu.cputype = CPU_R2000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_I;
-			mips_cpu.options = MIPS_CPU_TLB;
+			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX;
 			if (cpu_has_fpu())
 				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 64;
@@ -248,7 +248,7 @@ static inline void cpu_probe(void)
 			else
 				mips_cpu.cputype = CPU_R3000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_I;
-			mips_cpu.options = MIPS_CPU_TLB;
+			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX;
 			if (cpu_has_fpu())
 				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 64;
@@ -261,7 +261,7 @@ static inline void cpu_probe(void)
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
 			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH |
-			                   MIPS_CPU_VCE | MIPS_CPU_FPUEX;
+			                   MIPS_CPU_VCE;
 			mips_cpu.tlbsize = 48;
 			break;
                 case PRID_IMP_VR41XX:
@@ -274,14 +274,13 @@ static inline void cpu_probe(void)
 			mips_cpu.cputype = CPU_R4300;
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-					   MIPS_CPU_32FPR | MIPS_CPU_FPUEX;
+					   MIPS_CPU_32FPR;
 			mips_cpu.tlbsize = 32;
 			break;
 		case PRID_IMP_R4600:
 			mips_cpu.cputype = CPU_R4600;
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
-			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-					   MIPS_CPU_FPUEX;
+			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 48;
 			break;
 		#if 0
@@ -294,8 +293,7 @@ static inline void cpu_probe(void)
 			 */
 	 		mips_cpu.cputype = CPU_R4650;
 		 	mips_cpu.isa_level = MIPS_CPU_ISA_III;
-			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-					   MIPS_CPU_FPUEX;
+			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU;
 		        mips_cpu.tlbsize = 48;
 			break;
 		#endif
@@ -329,14 +327,14 @@ static inline void cpu_probe(void)
 			mips_cpu.cputype = CPU_R4700;
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR;
 			mips_cpu.tlbsize = 48;
 			break;
 		case PRID_IMP_TX49:
 			mips_cpu.cputype = CPU_TX49XX;
 			mips_cpu.isa_level = MIPS_CPU_ISA_III;
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR;
 			mips_cpu.tlbsize = 48;
 			mips_cpu.icache.ways = 4;
 			mips_cpu.dcache.ways = 4;
@@ -345,31 +343,28 @@ static inline void cpu_probe(void)
 			mips_cpu.cputype = CPU_R5000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV; 
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR;
 			mips_cpu.tlbsize = 48;
 			break;
 		case PRID_IMP_R5432:
 			mips_cpu.cputype = CPU_R5432;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV; 
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH |
-					   MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH;
 			mips_cpu.tlbsize = 48;
 			break;
 		case PRID_IMP_R5500:
 			mips_cpu.cputype = CPU_R5500;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV; 
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH |
-					   MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH;
 			mips_cpu.tlbsize = 48;
 			break;
 		case PRID_IMP_NEVADA:
 			mips_cpu.cputype = CPU_NEVADA;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV; 
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_DIVEC |
-					   MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR | MIPS_CPU_DIVEC;
 			mips_cpu.tlbsize = 48;
 			mips_cpu.icache.ways = 2;
 			mips_cpu.dcache.ways = 2;
@@ -377,22 +372,20 @@ static inline void cpu_probe(void)
 		case PRID_IMP_R6000:
 			mips_cpu.cputype = CPU_R6000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_II;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-					   MIPS_CPU_FPUEX;
+			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 32;
 			break;
 		case PRID_IMP_R6000A:
 			mips_cpu.cputype = CPU_R6000A;
 			mips_cpu.isa_level = MIPS_CPU_ISA_II;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-					   MIPS_CPU_FPUEX;
+			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_FPU;
 			mips_cpu.tlbsize = 32;
 			break;
 		case PRID_IMP_RM7000:
 			mips_cpu.cputype = CPU_RM7000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV;
 			mips_cpu.options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_FPUEX;
+			                   MIPS_CPU_32FPR;
 			/*
 			 * Undocumented RM7000:  Bit 29 in the info register of
 			 * the RM7000 v2.0 indicates if the TLB has 48 or 64
@@ -407,8 +400,7 @@ static inline void cpu_probe(void)
 			mips_cpu.cputype = CPU_R8000;
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV;
 			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
-				           MIPS_CPU_FPU | MIPS_CPU_32FPR |
-					   MIPS_CPU_FPUEX;
+				           MIPS_CPU_FPU | MIPS_CPU_32FPR;
 			mips_cpu.tlbsize = 384;      /* has wierd TLB: 3-way x 128 */
 			break;
 		case PRID_IMP_R10000:
@@ -416,8 +408,7 @@ static inline void cpu_probe(void)
 			mips_cpu.isa_level = MIPS_CPU_ISA_IV;
 			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX | 
 				           MIPS_CPU_FPU | MIPS_CPU_32FPR | 
-				           MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
-					   MIPS_CPU_FPUEX;
+				           MIPS_CPU_COUNTER | MIPS_CPU_WATCH;
 			mips_cpu.tlbsize = 64;
 			break;
 		default:
@@ -452,8 +443,7 @@ cpu_4kc:
 			if (config1 & (1 << 2))
 				mips_cpu.options |= MIPS_CPU_MIPS16;
 			if (config1 & 1)
-				mips_cpu.options |= MIPS_CPU_FPU |
-						    MIPS_CPU_FPUEX;
+				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.scache.flags = MIPS_CACHE_NOT_PRESENT;
 			break;
 		case PRID_IMP_5KC:
@@ -470,8 +460,7 @@ cpu_4kc:
 			if (config1 & (1 << 2))
 				mips_cpu.options |= MIPS_CPU_MIPS16;
 			if (config1 & 1)
-				mips_cpu.options |= MIPS_CPU_FPU |
-						    MIPS_CPU_FPUEX;
+				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.scache.flags = MIPS_CACHE_NOT_PRESENT;
 			break;
 		default:
@@ -497,8 +486,7 @@ cpu_4kc:
 			if (config1 & (1 << 2))
 				mips_cpu.options |= MIPS_CPU_MIPS16;
 			if (config1 & 1)
-				mips_cpu.options |= MIPS_CPU_FPU |
-						    MIPS_CPU_FPUEX;
+				mips_cpu.options |= MIPS_CPU_FPU;
 			mips_cpu.scache.flags = MIPS_CACHE_NOT_PRESENT;
 			break;
 		default:
@@ -517,8 +505,7 @@ cpu_4kc:
 			                   MIPS_CPU_MCHECK;
 #ifndef CONFIG_SB1_PASS_1_WORKAROUNDS
 			/* FPU in pass1 is known to have issues. */
-			mips_cpu.options |= MIPS_CPU_FPU |
-					    MIPS_CPU_FPUEX;
+			mips_cpu.options |= MIPS_CPU_FPU;
 #endif
 			break;
 		default:
diff -up --recursive --new-file linux-mips-2.4.18-20020412.macro/arch/mips/kernel/traps.c linux-mips-2.4.18-20020412/arch/mips/kernel/traps.c
--- linux-mips-2.4.18-20020412.macro/arch/mips/kernel/traps.c	2002-04-10 02:58:40.000000000 +0000
+++ linux-mips-2.4.18-20020412/arch/mips/kernel/traps.c	2002-04-13 02:01:40.000000000 +0000
@@ -916,7 +916,8 @@ void __init trap_init(void)
 	set_except_vector(12, handle_ov);
 	set_except_vector(13, handle_tr);
 
-	if (mips_cpu.options & MIPS_CPU_FPUEX)
+	if ((mips_cpu.options & MIPS_CPU_FPU) &&
+	    !(mips_cpu.options & MIPS_CPU_NOFPUEX))
 		set_except_vector(15, handle_fpe);
 	if (mips_cpu.options & MIPS_CPU_MCHECK)
 		set_except_vector(24, handle_mcheck);
diff -up --recursive --new-file linux-mips-2.4.18-20020412.macro/include/asm-mips/cpu.h linux-mips-2.4.18-20020412/include/asm-mips/cpu.h
--- linux-mips-2.4.18-20020412.macro/include/asm-mips/cpu.h	2002-04-10 02:59:00.000000000 +0000
+++ linux-mips-2.4.18-20020412/include/asm-mips/cpu.h	2002-04-13 01:51:39.000000000 +0000
@@ -159,6 +159,6 @@ enum cputype {
 #define MIPS_CPU_CACHE_CDEX	0x00000800 /* Create_Dirty_Exclusive CACHE op */
 #define MIPS_CPU_MCHECK		0x00001000 /* Machine check exception */
 #define MIPS_CPU_EJTAG		0x00002000 /* EJTAG exception */
-#define MIPS_CPU_FPUEX		0x00004000 /* FPU exception */
+#define MIPS_CPU_NOFPUEX	0x00004000 /* no FPU exception */
 
 #endif /* _ASM_CPU_H */
