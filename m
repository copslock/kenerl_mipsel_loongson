Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 15:14:11 +0100 (BST)
Received: from ftp.ckdenergo.cz ([IPv6:::ffff:80.95.97.155]:17358 "EHLO simek")
	by linux-mips.org with ESMTP id <S8225233AbTFPOOI>;
	Mon, 16 Jun 2003 15:14:08 +0100
Received: from ladis by simek with local (Exim 3.36 #1 (Debian))
	id 19RujV-0004Lz-00
	for <linux-mips@linux-mips.org>; Mon, 16 Jun 2003 16:13:17 +0200
Date: Mon, 16 Jun 2003 16:13:07 +0200
To: linux-mips@linux-mips.org
Subject: [PATCH] cpu-probe compile fix
Message-ID: <20030616141307.GA16721@simek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

I was told that Ralf is off till Friday, so I'm sending this to the list
to allow someone fix the problem. patch applies against 2.4 and 2.5
branch. once there I did also some indentation changes.


Index: arch/mips/kernel/cpu-probe.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/cpu-probe.c,v
retrieving revision 1.1.2.21
diff -u -r1.1.2.21 cpu-probe.c
--- arch/mips/kernel/cpu-probe.c	15 Jun 2003 23:35:54 -0000	1.1.2.21
+++ arch/mips/kernel/cpu-probe.c	16 Jun 2003 11:18:49 -0000
@@ -161,8 +161,8 @@
         if (config0 & (1 << 31)) {
 		/* MIPS32 or MIPS64 compliant CPU. Read Config 1 register. */
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
-			MIPS_CPU_4KTLB | MIPS_CPU_COUNTER | MIPS_CPU_DIVEC |
-			MIPS_CPU_LLSC;
+			     MIPS_CPU_4KTLB | MIPS_CPU_COUNTER |
+			     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 		config1 = read_c0_config1();
 		if (config1 & (1 << 3))
 			c->options |= MIPS_CPU_WATCH;
@@ -186,9 +186,8 @@
 		case PRID_IMP_R2000:
 			c->cputype = CPU_R2000;
 			c->isa_level = MIPS_CPU_ISA_I;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_NOFPUEX |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB |MIPS_CPU_NOFPUEX |
+				     MIPS_CPU_LLSC;
 			if (__cpu_has_fpu())
 				c->options |= MIPS_CPU_FPU;
 			c->tlbsize = 64;
@@ -202,9 +201,8 @@
 			else
 				c->cputype = CPU_R3000;
 			c->isa_level = MIPS_CPU_ISA_I;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_NOFPUEX |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX |
+				     MIPS_CPU_LLSC;
 			if (__cpu_has_fpu())
 				c->options |= MIPS_CPU_FPU;
 			c->tlbsize = 64;
@@ -216,8 +214,8 @@
 				c->cputype = CPU_R4000SC;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH |
-			                   MIPS_CPU_VCE | MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_WATCH |
+				     MIPS_CPU_VCE | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
                 case PRID_IMP_VR41XX:
@@ -256,14 +254,13 @@
 			c->cputype = CPU_R4300;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-					   MIPS_CPU_32FPR | MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 32;
 			break;
 		case PRID_IMP_R4600:
 			c->cputype = CPU_R4600;
 			c->isa_level = MIPS_CPU_ISA_III;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		#if 0
@@ -276,8 +273,7 @@
 			 */
 	 		c->cputype = CPU_R4650;
 		 	c->isa_level = MIPS_CPU_ISA_III;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
 		        c->tlbsize = 48;
 			break;
 		#endif
@@ -309,75 +305,63 @@
 			c->cputype = CPU_R4700;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_TX49:
 			c->cputype = CPU_TX49XX;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5000:
 			c->cputype = CPU_R5000;
 			c->isa_level = MIPS_CPU_ISA_IV;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5432:
 			c->cputype = CPU_R5432;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5500:
 			c->cputype = CPU_R5500;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_NEVADA:
 			c->cputype = CPU_NEVADA;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_DIVEC |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R6000:
 			c->cputype = CPU_R6000;
 			c->isa_level = MIPS_CPU_ISA_II;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 32;
 			break;
 		case PRID_IMP_R6000A:
 			c->cputype = CPU_R6000A;
 			c->isa_level = MIPS_CPU_ISA_II;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 32;
 			break;
 		case PRID_IMP_RM7000:
 			c->cputype = CPU_RM7000;
 			c->isa_level = MIPS_CPU_ISA_IV;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			/*
 			 * Undocumented RM7000:  Bit 29 in the info register of
 			 * the RM7000 v2.0 indicates if the TLB has 48 or 64
@@ -391,35 +375,27 @@
 		case PRID_IMP_R8000:
 			c->cputype = CPU_R8000;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-				                   MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 384;      /* has weird TLB: 3-way x 128 */
 			break;
 		case PRID_IMP_R10000:
 			c->cputype = CPU_R10000;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-				                   MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-				                   MIPS_CPU_COUNTER |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 64;
 			break;
 		case PRID_IMP_R12000:
 			c->cputype = CPU_R12000;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-				                   MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-				                   MIPS_CPU_COUNTER |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 64;
 			break;
 		default:
@@ -484,35 +460,31 @@
 		case PRID_IMP_SB1:
 			c->cputype = CPU_SB1;
 			c->isa_level = MIPS_CPU_ISA_M64;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-			                           MIPS_CPU_COUNTER |
-			                           MIPS_CPU_DIVEC |
-			                           MIPS_CPU_MCHECK |
-			                           MIPS_CPU_EJTAG |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_COUNTER | MIPS_CPU_DIVEC |
+				     MIPS_CPU_MCHECK | MIPS_CPU_EJTAG |
+				     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 #ifndef CONFIG_SB1_PASS_1_WORKAROUNDS
 			/* FPU in pass1 is known to have issues. */
 			c->options |= MIPS_CPU_FPU | MIPS_CPU_32FPR;
 #endif
 			break;
 		default:
-			mips_cpu.cputype = CPU_UNKNOWN;
+			c->cputype = CPU_UNKNOWN;
 			break;
 		}
 		break;
 
 	case PRID_COMP_SANDCRAFT:
-		switch (mips_cpu.processor_id & 0xff00) {
+		switch (c->processor_id & 0xff00) {
 		case PRID_IMP_SR71000:
-			mips_cpu.cputype = CPU_SR71000;
-			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
-                                           MIPS_CPU_4KTLB | MIPS_CPU_FPU |
-			                   MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;
-			mips_cpu.scache.ways = 8;
-			mips_cpu.tlbsize = 64;
+			c->cputype = CPU_SR71000;
+			c->isa_level = MIPS_CPU_ISA_M64;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_4KTLB | MIPS_CPU_FPU |
+				     MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;
+			c->scache.ways = 8;
+			c->tlbsize = 64;
 			break;
 		default:
 			c->cputype = CPU_UNKNOWN;
@@ -531,7 +503,7 @@
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	printk("CPU revision is: %08x\n", c->processor_id);
+	printk(KERN_INFO "CPU revision is: %08x\n", c->processor_id);
 	if (c->options & MIPS_CPU_FPU)
-		printk("FPU revision is: %08x\n", c->fpu_id);
+		printk(KERN_INFO "FPU revision is: %08x\n", c->fpu_id);
 }
Index: arch/mips64/kernel/cpu-probe.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/cpu-probe.c,v
retrieving revision 1.1.2.25
diff -u -r1.1.2.25 cpu-probe.c
--- arch/mips64/kernel/cpu-probe.c	15 Jun 2003 23:35:54 -0000	1.1.2.25
+++ arch/mips64/kernel/cpu-probe.c	16 Jun 2003 11:18:49 -0000
@@ -398,8 +398,8 @@
         if (config0 & (1 << 31)) {
 		/* MIPS32 or MIPS64 compliant CPU. Read Config 1 register. */
 		c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
-			MIPS_CPU_4KTLB | MIPS_CPU_COUNTER | MIPS_CPU_DIVEC |
-			MIPS_CPU_LLSC;
+			     MIPS_CPU_4KTLB | MIPS_CPU_COUNTER |
+			     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 		config1 = read_c0_config1();
 		if (config1 & (1 << 3))
 			c->options |= MIPS_CPU_WATCH;
@@ -423,9 +423,8 @@
 		case PRID_IMP_R2000:
 			c->cputype = CPU_R2000;
 			c->isa_level = MIPS_CPU_ISA_I;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_NOFPUEX |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB |MIPS_CPU_NOFPUEX |
+				     MIPS_CPU_LLSC;
 			if (__cpu_has_fpu())
 				c->options |= MIPS_CPU_FPU;
 			c->tlbsize = 64;
@@ -439,9 +438,8 @@
 			else
 				c->cputype = CPU_R3000;
 			c->isa_level = MIPS_CPU_ISA_I;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_NOFPUEX |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_NOFPUEX |
+				     MIPS_CPU_LLSC;
 			if (__cpu_has_fpu())
 				c->options |= MIPS_CPU_FPU;
 			c->tlbsize = 64;
@@ -453,8 +451,8 @@
 				c->cputype = CPU_R4000SC;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                   MIPS_CPU_32FPR | MIPS_CPU_WATCH |
-			                   MIPS_CPU_VCE | MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_WATCH |
+				     MIPS_CPU_VCE | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
                 case PRID_IMP_VR41XX:
@@ -493,14 +491,13 @@
 			c->cputype = CPU_R4300;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-					   MIPS_CPU_32FPR | MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 32;
 			break;
 		case PRID_IMP_R4600:
 			c->cputype = CPU_R4600;
 			c->isa_level = MIPS_CPU_ISA_III;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		#if 0
@@ -513,8 +510,7 @@
 			 */
 	 		c->cputype = CPU_R4650;
 		 	c->isa_level = MIPS_CPU_ISA_III;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_LLSC;
 		        c->tlbsize = 48;
 			break;
 		#endif
@@ -546,75 +542,63 @@
 			c->cputype = CPU_R4700;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_TX49:
 			c->cputype = CPU_TX49XX;
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5000:
 			c->cputype = CPU_R5000;
 			c->isa_level = MIPS_CPU_ISA_IV;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5432:
 			c->cputype = CPU_R5432;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5500:
 			c->cputype = CPU_R5500;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_NEVADA:
 			c->cputype = CPU_NEVADA;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_DIVEC |
-			                           MIPS_CPU_LLSC;
+			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R6000:
 			c->cputype = CPU_R6000;
 			c->isa_level = MIPS_CPU_ISA_II;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 32;
 			break;
 		case PRID_IMP_R6000A:
 			c->cputype = CPU_R6000A;
 			c->isa_level = MIPS_CPU_ISA_II;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_FPU |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 32;
 			break;
 		case PRID_IMP_RM7000:
 			c->cputype = CPU_RM7000;
 			c->isa_level = MIPS_CPU_ISA_IV;
 			c->options = R4K_OPTS | MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+				     MIPS_CPU_32FPR | MIPS_CPU_LLSC;
 			/*
 			 * Undocumented RM7000:  Bit 29 in the info register of
 			 * the RM7000 v2.0 indicates if the TLB has 48 or 64
@@ -628,35 +612,27 @@
 		case PRID_IMP_R8000:
 			c->cputype = CPU_R8000;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-				                   MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 384;      /* has weird TLB: 3-way x 128 */
 			break;
 		case PRID_IMP_R10000:
 			c->cputype = CPU_R10000;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-				                   MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-				                   MIPS_CPU_COUNTER |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 64;
 			break;
 		case PRID_IMP_R12000:
 			c->cputype = CPU_R12000;
 			c->isa_level = MIPS_CPU_ISA_IV;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-				                   MIPS_CPU_FPU |
-			                           MIPS_CPU_32FPR |
-				                   MIPS_CPU_COUNTER |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_FPU | MIPS_CPU_32FPR |
+				     MIPS_CPU_COUNTER | MIPS_CPU_WATCH |
+				     MIPS_CPU_LLSC;
 			c->tlbsize = 64;
 			break;
 		default:
@@ -721,35 +697,31 @@
 		case PRID_IMP_SB1:
 			c->cputype = CPU_SB1;
 			c->isa_level = MIPS_CPU_ISA_M64;
-			c->options = MIPS_CPU_TLB |
-			                           MIPS_CPU_4KEX |
-			                           MIPS_CPU_COUNTER |
-			                           MIPS_CPU_DIVEC |
-			                           MIPS_CPU_MCHECK |
-			                           MIPS_CPU_EJTAG |
-			                           MIPS_CPU_WATCH |
-			                           MIPS_CPU_LLSC;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_COUNTER | MIPS_CPU_DIVEC |
+				     MIPS_CPU_MCHECK | MIPS_CPU_EJTAG |
+				     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
 #ifndef CONFIG_SB1_PASS_1_WORKAROUNDS
 			/* FPU in pass1 is known to have issues. */
 			c->options |= MIPS_CPU_FPU | MIPS_CPU_32FPR;
 #endif
 			break;
 		default:
-			mips_cpu.cputype = CPU_UNKNOWN;
+			c->cputype = CPU_UNKNOWN;
 			break;
 		}
 		break;
 
 	case PRID_COMP_SANDCRAFT:
-		switch (mips_cpu.processor_id & 0xff00) {
+		switch (c->processor_id & 0xff00) {
 		case PRID_IMP_SR71000:
-			mips_cpu.cputype = CPU_SR71000;
-			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
-			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
-                                           MIPS_CPU_4KTLB | MIPS_CPU_FPU |
-			                   MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;
-			mips_cpu.scache.ways = 8;
-			mips_cpu.tlbsize = 64;
+			c->cputype = CPU_SR71000;
+			c->isa_level = MIPS_CPU_ISA_M64;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
+				     MIPS_CPU_4KTLB | MIPS_CPU_FPU |
+				     MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;
+			c->scache.ways = 8;
+			c->tlbsize = 64;
 			break;
 		default:
 			c->cputype = CPU_UNKNOWN;
@@ -768,7 +740,7 @@
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	printk("CPU revision is: %08x\n", c->processor_id);
+	printk(KERN_INFO "CPU revision is: %08x\n", c->processor_id);
 	if (c->options & MIPS_CPU_FPU)
-		printk("FPU revision is: %08x\n", c->fpu_id);
+		printk(KERN_INFO "FPU revision is: %08x\n", c->fpu_id);
 }
