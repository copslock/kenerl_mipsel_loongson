Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2003 18:02:47 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:44843
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8224802AbTFTRCp>; Fri, 20 Jun 2003 18:02:45 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19TPHY-0002ih-00; Fri, 20 Jun 2003 19:02:36 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.4] cpu-probe.c error
Cc: linux-mips@linux-mips.org
Message-Id: <E19TPHY-0002ih-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Fri, 20 Jun 2003 19:02:36 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	the latest change to cpu-probe.c requires a mips_cpu
variable which no longer exists. I presume you meant the following.

/Brian

Index: arch/mips/kernel/cpu-probe.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/cpu-probe.c,v
retrieving revision 1.1.2.21
diff -u -r1.1.2.21 cpu-probe.c
--- arch/mips/kernel/cpu-probe.c	15 Jun 2003 23:35:54 -0000	1.1.2.21
+++ arch/mips/kernel/cpu-probe.c	20 Jun 2003 16:59:16 -0000
@@ -498,21 +498,21 @@
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
+			c->cputype = CPU_SR71000;
+			c->isa_level = MIPS_CPU_ISA_M64;
+			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
                                            MIPS_CPU_4KTLB | MIPS_CPU_FPU |
 			                   MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;
-			mips_cpu.scache.ways = 8;
-			mips_cpu.tlbsize = 64;
+			c->scache.ways = 8;
+			c->tlbsize = 64;
 			break;
 		default:
 			c->cputype = CPU_UNKNOWN;
