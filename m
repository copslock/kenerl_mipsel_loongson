Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 15:56:09 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:4002 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225532AbUDBO4I>; Fri, 2 Apr 2004 15:56:08 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 21B1349C2F; Fri,  2 Apr 2004 16:56:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 018904787C; Fri,  2 Apr 2004 16:56:01 +0200 (CEST)
Date: Fri, 2 Apr 2004 16:56:01 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] SMP bootstrap for SB1250
Message-ID: <Pine.LNX.4.55.0404021633280.4735@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 smp_boot_cpus() in arch/mips/sibyte/sb1250/smp.c does CPU enumeration in
an awkward way -- resulting in physical IDs different from what they
really are.  Additionally the code breaks for more than two processors
present -- subsequent CPUs get assigned numbers beyond NR_CPUS.  While
this may not bite for current SB1250 implementations, it need not
necessarily always be the case and the code seems to be intended to handle
such configurations.

 Here's a proposed fix.  It requires an API change for
prom_boot_secondary() to return a status, but I think it's desirable as it
lets the invoker know if the call failed for some reason.  Some code
elsewhere already defines the function this way. ;-)  OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.25-20040322-swarm-smpboot-1
diff -up --recursive --new-file linux-mips-2.4.25-20040322.macro/arch/mips/sibyte/cfe/smp.c linux-mips-2.4.25-20040322/arch/mips/sibyte/cfe/smp.c
--- linux-mips-2.4.25-20040322.macro/arch/mips/sibyte/cfe/smp.c	2004-01-06 03:56:57.000000000 +0000
+++ linux-mips-2.4.25-20040322/arch/mips/sibyte/cfe/smp.c	2004-04-02 08:41:08.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
+ * Copyright (C) 2004  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -26,7 +27,7 @@
 
 /* Boot all other cpus in the system, initialize them, and
    bring them into the boot fn */
-void prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp)
+int prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp)
 {
 	int retval;
 	
@@ -34,6 +35,8 @@ void prom_boot_secondary(int cpu, unsign
 	if (retval != 0) {
 		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
 	}
+
+	return retval;
 }
 
 void prom_init_secondary(void)
diff -up --recursive --new-file linux-mips-2.4.25-20040322.macro/arch/mips/sibyte/sb1250/smp.c linux-mips-2.4.25-20040322/arch/mips/sibyte/sb1250/smp.c
--- linux-mips-2.4.25-20040322.macro/arch/mips/sibyte/sb1250/smp.c	2004-01-28 03:56:49.000000000 +0000
+++ linux-mips-2.4.25-20040322/arch/mips/sibyte/sb1250/smp.c	2004-04-02 14:27:08.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001 Broadcom Corporation
+ * Copyright (C) 2004  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -138,7 +139,7 @@ void __init smp_boot_cpus(void)
 	 * This loop attempts to compensate for "holes" in the CPU
 	 * numbering.  It's overkill, but general.
 	 */
-	for (i = 1; i < smp_num_cpus; ) {
+	for (i = 1; i < smp_num_cpus && cur_cpu < NR_CPUS; i++) {
 		struct task_struct *p;
 		struct pt_regs regs;
 		printk("Starting CPU %d... ", i);
@@ -158,15 +159,20 @@ void __init smp_boot_cpus(void)
 		unhash_process(p);
 
 		do {
+			int status;
+
 			/* Iterate until we find a CPU that comes up */
 			cur_cpu++;
-			prom_boot_secondary(cur_cpu,
-					    (unsigned long)p + KERNEL_STACK_SIZE - 32,
-					    (unsigned long)p);
-		} while (cur_cpu < smp_num_cpus - 1);
-		__cpu_number_map[cur_cpu] = i;
-		__cpu_logical_map[i] = cur_cpu;
-		i++;
+			status = prom_boot_secondary(cur_cpu,
+						    (unsigned long)p +
+						    KERNEL_STACK_SIZE - 32,
+						    (unsigned long)p);
+			if (status == 0) {
+				__cpu_number_map[cur_cpu] = i;
+				__cpu_logical_map[i] = cur_cpu;
+				break;
+			}
+		} while (cur_cpu < NR_CPUS);
 	}
 
 	/* Wait for everyone to come up */
diff -up --recursive --new-file linux-mips-2.4.25-20040322.macro/include/asm-mips/smp.h linux-mips-2.4.25-20040322/include/asm-mips/smp.h
--- linux-mips-2.4.25-20040322.macro/include/asm-mips/smp.h	2003-12-31 03:57:06.000000000 +0000
+++ linux-mips-2.4.25-20040322/include/asm-mips/smp.h	2004-04-02 14:27:08.000000000 +0000
@@ -106,7 +106,7 @@ void core_send_ipi(int cpu, unsigned int
  * Clear all undefined state in the cpu, set up sp and gp to the passed
  * values, and kick the cpu into smp_bootstrap();
  */
-void prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp);
+int prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp);
 
 /*
  *  After we've done initial boot, this function is called to allow the
diff -up --recursive --new-file linux-mips-2.4.25-20040322.macro/include/asm-mips64/smp.h linux-mips-2.4.25-20040322/include/asm-mips64/smp.h
--- linux-mips-2.4.25-20040322.macro/include/asm-mips64/smp.h	2003-12-31 03:57:06.000000000 +0000
+++ linux-mips-2.4.25-20040322/include/asm-mips64/smp.h	2004-04-02 14:27:08.000000000 +0000
@@ -106,7 +106,7 @@ void core_send_ipi(int cpu, unsigned int
  * Clear all undefined state in the cpu, set up sp and gp to the passed
  * values, and kick the cpu into smp_bootstrap();
  */
-void prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp);
+int prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp);
 
 /*
  *  After we've done initial boot, this function is called to allow the
