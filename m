Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 15:06:41 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:62161 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225262AbTDOOGj>; Tue, 15 Apr 2003 15:06:39 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA15755;
	Tue, 15 Apr 2003 16:07:18 +0200 (MET DST)
Date: Tue, 15 Apr 2003 16:07:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] cp0.config access macros
Message-ID: <Pine.GSO.3.96.1030415155224.13254F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 Cryptic cp0.config accesses using hardcoded numbers are scattered through
the sources.  I propose adding a few definitions to improve readability
and ease grepping the sources.  This is for solely for cp0.config now -- I
fixed all references I had docs handy for.  The next step should probably
be cp0.config1.

 Beside that, the following patch fixes cache size units to be kilobytes
instead of kilobits and fixes the R4000SC erratum #5 trigger. 

 OK?

  Maciej 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030414-c-rxk-6
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/kernel/cpu-probe.c linux-mips-2.4.21-pre4-20030414/arch/mips/kernel/cpu-probe.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/kernel/cpu-probe.c	2003-04-13 02:56:50.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/kernel/cpu-probe.c	2003-04-14 23:44:24.000000000 +0000
@@ -18,7 +18,7 @@ void (*cpu_wait)(void) = NULL;
 static void r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
-	write_c0_conf(cfg | CONF_HALT);
+	write_c0_conf(cfg | R30XX_CONF_HALT);
 }
 
 static void r39xx_wait(void)
@@ -108,7 +108,7 @@ static inline int cpu_has_confreg(void)
 	unsigned long cfg = read_c0_conf();
 
 	size1 = r3k_cache_size(ST0_ISC);
-	write_c0_conf(cfg ^ CONF_AC);
+	write_c0_conf(cfg ^ R30XX_CONF_AC);
 	size2 = r3k_cache_size(ST0_ISC);
 	write_c0_conf(cfg);
 	return size1 != size2;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mm/c-r3k.c linux-mips-2.4.21-pre4-20030414/arch/mips/mm/c-r3k.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mm/c-r3k.c	2003-04-13 02:56:51.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/mm/c-r3k.c	2003-04-14 22:10:06.000000000 +0000
@@ -7,6 +7,7 @@
  * Tx39XX R4k style caches added. HK
  * Copyright (C) 1998, 1999, 2000 Harald Koerfgen
  * Copyright (C) 1998 Gleb Raiko & Vladimir Roganov
+ * Copyright (C) 2001  Maciej W. Rozycki
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -100,7 +101,6 @@ static void __init r3k_probe_cache(void)
 	if (dcache_size)
 		dcache_lsize = r3k_cache_lsize(ST0_ISC);
 
-
 	icache_size = r3k_cache_size(ST0_ISC|ST0_SWC);
 	if (icache_size)
 		icache_lsize = r3k_cache_lsize(ST0_ISC|ST0_SWC);
@@ -339,8 +339,8 @@ void __init ld_mmu_r23000(void)
 
 	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
 
-	printk("Primary instruction cache %dkb, linesize %d bytes\n",
-		(int) (icache_size >> 10), (int) icache_lsize);
-	printk("Primary data cache %dkb, linesize %d bytes\n",
-		(int) (dcache_size >> 10), (int) dcache_lsize);
+	printk("Primary instruction cache %ldkB, linesize %ld bytes.\n",
+		icache_size >> 10, icache_lsize);
+	printk("Primary data cache %ldkB, linesize %ld bytes.\n",
+		dcache_size >> 10, dcache_lsize);
 }
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mm/c-r4k.c linux-mips-2.4.21-pre4-20030414/arch/mips/mm/c-r4k.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mm/c-r4k.c	2003-04-14 02:56:57.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/mm/c-r4k.c	2003-04-15 08:08:38.000000000 +0000
@@ -673,6 +673,7 @@ static void __init probe_pcache(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config = read_c0_config();
+	unsigned int prid = read_c0_prid();
 	unsigned long config1;
 	unsigned int lsize;
 
@@ -681,38 +682,38 @@ static void __init probe_pcache(void)
 	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_NEVADA:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
 		c->icache.waybit = ffs(icache_size/2) - 1;
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit= ffs(dcache_size/2) - 1;
 		break;
 
 	case CPU_R5432:
 	case CPU_R5500:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
 		c->icache.waybit= 0;
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit = 0;
 		break;
 
 	case CPU_TX49XX:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 4;
 		c->icache.waybit= 0;
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 4;
 		c->dcache.waybit = 0;
 		break;
@@ -723,25 +724,25 @@ static void __init probe_pcache(void)
 	case CPU_R4400PC:
 	case CPU_R4400SC:
 	case CPU_R4400MC:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 1;
 		c->icache.waybit = 0; 	/* doesn't matter */
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 1;
 		c->dcache.waybit = 0;	/* does not matter */
 		break;
 
 	case CPU_VR4131:
-		icache_size = 1 << (10 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
 		c->icache.waybit = ffs(icache_size/2) - 1;
 
-		dcache_size = 1 << (10 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit = ffs(dcache_size/2) - 1;
 		break;
@@ -752,19 +753,19 @@ static void __init probe_pcache(void)
 	case CPU_VR4122:
 	case CPU_VR4181:
 	case CPU_VR4181A:
-		icache_size = 1 << (10 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 1;
 		c->icache.waybit = 0; 	/* doesn't matter */
 
-		dcache_size = 1 << (10 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 1;
 		c->dcache.waybit = 0;	/* does not matter */
 		break;
 
 	default:
-		if (!(config & 0x80000000))
+		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
 
 		/*
@@ -803,16 +804,17 @@ static void __init probe_pcache(void)
 	}
 
 	/*
-	 * Processor configuration sanity check for the R4000SC V2.2
-	 * erratum #5.  With pagesizes larger than 32kb there is no possibility
+	 * Processor configuration sanity check for the R4000SC erratum
+	 * #5.  With page sizes larger than 32kB there is no possibility
 	 * to get a VCE exception anymore so we don't care about this
-	 * missconfiguration.  The case is rather theoretical anway; presumably
-	 * no vendor is shipping his hardware in the "bad" configuration.
+	 * misconfiguration.  The case is rather theoretical anyway;
+	 * presumably no vendor is shipping his hardware in the "bad"
+	 * configuration.
 	 */
-	if (PAGE_SIZE <= 0x8000 && read_c0_prid() == 0x0422 &&
-	    (read_c0_config() & CONF_SC) &&
-	     c->icache.linesz != 16)
-		panic("Impropper processor configuration detected");
+	if ((prid & 0xff00) == PRID_IMP_R4000 && (prid & 0xff) < 0x40 &&
+	    !(config & CONF_SC) && c->icache.linesz != 16 &&
+	    PAGE_SIZE <= 0x8000)
+		panic("Improper R4000SC processor configuration detected");
 
 	/* compute a couple of other cache variables */
 	icache_way_size = icache_size / c->icache.ways;
@@ -840,12 +842,12 @@ static void __init probe_pcache(void)
 		break;
 	}
 
-	printk("Primary instruction cache %ldkb, %s, %s, linesize %d bytes\n",
+	printk("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
 	       icache_size >> 10,
 	       cpu_has_vtag_icache ? "virtually tagged" : "physically tagged",
 	       way_string[c->icache.ways], c->icache.linesz);
 
-	printk("Primary data cache %ldkb %s, linesize %d bytes\n",
+	printk("Primary data cache %ldkB %s, linesize %d bytes.\n",
 	       dcache_size >> 10, way_string[c->dcache.ways], c->dcache.linesz);
 }
 
@@ -862,10 +864,10 @@ static int __init probe_scache(void)
 	unsigned int config = read_c0_config();
 	int tmp;
 
-	if ((config >> 17) & 1)
+	if (config & CONF_SC)
 		return 0;
 
-	sc_lsize = 16 << ((config >> 22) & 3);
+	sc_lsize = 16 << ((config & R4K_CONF_SB) >> 22);
 
 	begin = (unsigned long) &stext;
 	begin &= ~((4 * 1024 * 1024) - 1);
@@ -905,7 +907,7 @@ static int __init probe_scache(void)
 	}
 	local_irq_restore(flags);
 	addr -= begin;
-	printk("Secondary cache sized at %ldK, linesize %ld bytes.\n",
+	printk("Secondary cache sized at %ldkB, linesize %ld bytes.\n",
 	       addr >> 10, sc_lsize);
 	scache_size = addr;
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mm/r5k-sc.c linux-mips-2.4.21-pre4-20030414/arch/mips/mm/r5k-sc.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips/mm/r5k-sc.c	2003-03-25 03:56:41.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips/mm/r5k-sc.c	2003-04-15 00:03:28.000000000 +0000
@@ -9,11 +9,11 @@
 
 #include <asm/mipsregs.h>
 #include <asm/bcache.h>
+#include <asm/cacheops.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/mmu_context.h>
-#include <asm/cacheops.h>
 
 /* Secondary cache size in bytes, if present.  */
 static unsigned long scache_size;
@@ -69,7 +69,7 @@ static void r5k_sc_enable(void)
         unsigned long flags;
 
 	local_irq_save(flags);
-	change_c0_config(CONF_SE, CONF_SE);
+	change_c0_config(R5K_CONF_SE, R5K_CONF_SE);
 	blast_r5000_scache();
 	local_irq_restore(flags);
 }
@@ -80,7 +80,7 @@ static void r5k_sc_disable(void)
 
 	local_irq_save(flags);
 	blast_r5000_scache();
-	change_c0_config(CONF_SE, 0);
+	change_c0_config(R5K_CONF_SE, 0);
 	local_irq_restore(flags);
 }
 
@@ -88,12 +88,12 @@ static inline int __init r5k_sc_probe(vo
 {
 	unsigned long config = read_c0_config();
 
-	if(config & CONF_SC)
+	if (config & CONF_SC)
 		return(0);
 
-	scache_size = (512*1024) << ((config >> 20)&3);
+	scache_size = (512 * 1024) << ((config & R5K_CONF_SS) >> 20);
 
-	printk("R5000 SCACHE size %ldK, linesize 32 bytes.\n",
+	printk("R5000 SCACHE size %ldkB, linesize 32 bytes.\n",
 			scache_size >> 10);
 
 	return 1;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/kernel/cpu-probe.c linux-mips-2.4.21-pre4-20030414/arch/mips64/kernel/cpu-probe.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/kernel/cpu-probe.c	2003-04-13 02:56:56.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips64/kernel/cpu-probe.c	2003-04-15 00:00:37.000000000 +0000
@@ -35,7 +35,7 @@ void (*cpu_wait)(void) = NULL;
 static void r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
-	write_c0_conf(cfg | CONF_HALT);
+	write_c0_conf(cfg | R30XX_CONF_HALT);
 }
 
 static void r39xx_wait(void)
@@ -347,7 +347,7 @@ static inline int cpu_has_confreg(void)
 	unsigned long cfg = read_c0_conf();
 
 	size1 = r3k_cache_size(ST0_ISC);
-	write_c0_conf(cfg ^ CONF_AC);
+	write_c0_conf(cfg ^ R30XX_CONF_AC);
 	size2 = r3k_cache_size(ST0_ISC);
 	write_c0_conf(cfg);
 	return size1 != size2;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/mm/c-r4k.c linux-mips-2.4.21-pre4-20030414/arch/mips64/mm/c-r4k.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/mm/c-r4k.c	2003-04-14 02:57:00.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips64/mm/c-r4k.c	2003-04-15 08:08:38.000000000 +0000
@@ -673,6 +673,7 @@ static void __init probe_pcache(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config = read_c0_config();
+	unsigned int prid = read_c0_prid();
 	unsigned long config1;
 	unsigned int lsize;
 
@@ -681,38 +682,38 @@ static void __init probe_pcache(void)
 	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_NEVADA:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
 		c->icache.waybit = ffs(icache_size/2) - 1;
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit= ffs(dcache_size/2) - 1;
 		break;
 
 	case CPU_R5432:
 	case CPU_R5500:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
 		c->icache.waybit= 0;
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit = 0;
 		break;
 
 	case CPU_TX49XX:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 4;
 		c->icache.waybit= 0;
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 4;
 		c->dcache.waybit = 0;
 		break;
@@ -723,25 +724,25 @@ static void __init probe_pcache(void)
 	case CPU_R4400PC:
 	case CPU_R4400SC:
 	case CPU_R4400MC:
-		icache_size = 1 << (12 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 1;
 		c->icache.waybit = 0; 	/* doesn't matter */
 
-		dcache_size = 1 << (12 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 1;
 		c->dcache.waybit = 0;	/* does not matter */
 		break;
 
 	case CPU_VR4131:
-		icache_size = 1 << (10 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
 		c->icache.waybit = ffs(icache_size/2) - 1;
 
-		dcache_size = 1 << (10 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
 		c->dcache.waybit = ffs(dcache_size/2) - 1;
 		break;
@@ -752,19 +753,19 @@ static void __init probe_pcache(void)
 	case CPU_VR4122:
 	case CPU_VR4181:
 	case CPU_VR4181A:
-		icache_size = 1 << (10 + ((config >> 9) & 7));
-		c->icache.linesz = 16 << ((config >> 5) & 1);
+		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 1;
 		c->icache.waybit = 0; 	/* doesn't matter */
 
-		dcache_size = 1 << (10 + ((config >> 6) & 7));
-		c->dcache.linesz = 16 << ((config >> 4) & 1);
+		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 1;
 		c->dcache.waybit = 0;	/* does not matter */
 		break;
 
 	default:
-		if (!(config & 0x80000000))
+		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
 
 		/*
@@ -803,16 +804,17 @@ static void __init probe_pcache(void)
 	}
 
 	/*
-	 * Processor configuration sanity check for the R4000SC V2.2
-	 * erratum #5.  With pagesizes larger than 32kb there is no possibility
+	 * Processor configuration sanity check for the R4000SC erratum
+	 * #5.  With page sizes larger than 32kB there is no possibility
 	 * to get a VCE exception anymore so we don't care about this
-	 * missconfiguration.  The case is rather theoretical anway; presumably
-	 * no vendor is shipping his hardware in the "bad" configuration.
+	 * misconfiguration.  The case is rather theoretical anyway;
+	 * presumably no vendor is shipping his hardware in the "bad"
+	 * configuration.
 	 */
-	if (PAGE_SIZE <= 0x8000 && read_c0_prid() == 0x0422 &&
-	    (read_c0_config() & CONF_SC) &&
-	     c->icache.linesz != 16)
-		panic("Impropper processor configuration detected");
+	if ((prid & 0xff00) == PRID_IMP_R4000 && (prid & 0xff) < 0x40 &&
+	    !(config & CONF_SC) && c->icache.linesz != 16 &&
+	    PAGE_SIZE <= 0x8000)
+		panic("Improper R4000SC processor configuration detected");
 
 	/* compute a couple of other cache variables */
 	icache_way_size = icache_size / c->icache.ways;
@@ -840,12 +842,12 @@ static void __init probe_pcache(void)
 		break;
 	}
 
-	printk("Primary instruction cache %ldkb, %s, %s, linesize %d bytes\n",
+	printk("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
 	       icache_size >> 10,
 	       cpu_has_vtag_icache ? "virtually tagged" : "physically tagged",
 	       way_string[c->icache.ways], c->icache.linesz);
 
-	printk("Primary data cache %ldkb %s, linesize %d bytes\n",
+	printk("Primary data cache %ldkB %s, linesize %d bytes.\n",
 	       dcache_size >> 10, way_string[c->dcache.ways], c->dcache.linesz);
 }
 
@@ -862,10 +864,10 @@ static int __init probe_scache(void)
 	unsigned int config = read_c0_config();
 	int tmp;
 
-	if ((config >> 17) & 1)
+	if (config & CONF_SC)
 		return 0;
 
-	sc_lsize = 16 << ((config >> 22) & 3);
+	sc_lsize = 16 << ((config & R4K_CONF_SB) >> 22);
 
 	begin = (unsigned long) &stext;
 	begin &= ~((4 * 1024 * 1024) - 1);
@@ -905,7 +907,7 @@ static int __init probe_scache(void)
 	}
 	local_irq_restore(flags);
 	addr -= begin;
-	printk("Secondary cache sized at %ldK, linesize %ld bytes.\n",
+	printk("Secondary cache sized at %ldkB, linesize %ld bytes.\n",
 	       addr >> 10, sc_lsize);
 	scache_size = addr;
 
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/mm/r5k-sc.c linux-mips-2.4.21-pre4-20030414/arch/mips64/mm/r5k-sc.c
--- linux-mips-2.4.21-pre4-20030414.macro/arch/mips64/mm/r5k-sc.c	2003-03-25 03:56:43.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/arch/mips64/mm/r5k-sc.c	2003-04-15 00:01:42.000000000 +0000
@@ -69,7 +69,7 @@ static void r5k_sc_enable(void)
         unsigned long flags;
 
 	local_irq_save(flags);
-	change_c0_config(CONF_SE, CONF_SE);
+	change_c0_config(R5K_CONF_SE, R5K_CONF_SE);
 	blast_r5000_scache();
 	local_irq_restore(flags);
 }
@@ -80,7 +80,7 @@ static void r5k_sc_disable(void)
 
 	local_irq_save(flags);
 	blast_r5000_scache();
-	change_c0_config(CONF_SE, 0);
+	change_c0_config(R5K_CONF_SE, 0);
 	local_irq_restore(flags);
 }
 
@@ -88,12 +88,12 @@ static inline int __init r5k_sc_probe(vo
 {
 	unsigned long config = read_c0_config();
 
-	if(config & CONF_SC)
+	if (config & CONF_SC)
 		return(0);
 
-	scache_size = (512*1024) << ((config >> 20)&3);
+	scache_size = (512 * 1024) << ((config & R5K_CONF_SS) >> 20);
 
-	printk("R5000 SCACHE size %ldK, linesize 32 bytes.\n",
+	printk("R5000 SCACHE size %ldkB, linesize 32 bytes.\n",
 			scache_size >> 10);
 
 	return 1;
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips/mipsregs.h linux-mips-2.4.21-pre4-20030414/include/asm-mips/mipsregs.h
--- linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips/mipsregs.h	2003-04-13 21:53:14.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/include/asm-mips/mipsregs.h	2003-04-14 23:29:24.000000000 +0000
@@ -128,7 +128,7 @@
  * E the exception enable
  * S the sticky/flag bit
 */
-#define FPU_CSR_ALL_X 0x0003f000
+#define FPU_CSR_ALL_X   0x0003f000
 #define FPU_CSR_UNI_X   0x00020000
 #define FPU_CSR_INV_X   0x00010000
 #define FPU_CSR_DIV_X   0x00008000
@@ -373,8 +373,9 @@
 #define  CAUSEF_BD		(_ULCAST_(1)   << 31)
 
 /*
- * Bits in the coprozessor 0 config register.
+ * Bits in the coprocessor 0 config register.
  */
+/* Generic bits.  */
 #define CONF_CM_CACHABLE_NO_WA		0
 #define CONF_CM_CACHABLE_WA		1
 #define CONF_CM_UNCACHED		2
@@ -384,22 +385,73 @@
 #define CONF_CM_CACHABLE_CUW		6
 #define CONF_CM_CACHABLE_ACCELERATED	7
 #define CONF_CM_CMASK			7
+#define CONF_BE			(_ULCAST_(1) << 15)
+
+/* Bits common to various processors.  */
 #define CONF_CU			(_ULCAST_(1) <<  3)
 #define CONF_DB			(_ULCAST_(1) <<  4)
 #define CONF_IB			(_ULCAST_(1) <<  5)
-#define CONF_SE			(_ULCAST_(1) << 12)
+#define CONF_DC			(_ULCAST_(7) <<  6)
+#define CONF_IC			(_ULCAST_(7) <<  9)
+#define CONF_EB			(_ULCAST_(1) << 13)
+#define CONF_EM			(_ULCAST_(1) << 14)
+#define CONF_SM			(_ULCAST_(1) << 16)
 #define CONF_SC			(_ULCAST_(1) << 17)
-#define CONF_AC			(_ULCAST_(1) << 23)
-#define CONF_HALT		(_ULCAST_(1) << 25)
+#define CONF_EW			(_ULCAST_(3) << 18)
+#define CONF_EP			(_ULCAST_(15)<< 24)
+#define CONF_EC			(_ULCAST_(7) << 28)
+#define CONF_CM			(_ULCAST_(1) << 31)
+
+/* Bits specific to the R4xx0.  */
+#define R4K_CONF_SW		(_ULCAST_(1) << 20)
+#define R4K_CONF_SS		(_ULCAST_(1) << 21)
+#define R4K_CONF_SB		(_ULCAST_(3) << 22)
+
+/* Bits specific to the R5000.  */
+#define R5K_CONF_SE		(_ULCAST_(1) << 12)
+#define R5K_CONF_SS		(_ULCAST_(3) << 20)
+
+/* Bits specific to the R10000.  */
+#define R10K_CONF_DN		(_ULCAST_(3) <<  3)
+#define R10K_CONF_CT		(_ULCAST_(1) <<  5)
+#define R10K_CONF_PE		(_ULCAST_(1) <<  6)
+#define R10K_CONF_PM		(_ULCAST_(3) <<  7)
+#define R10K_CONF_EC		(_ULCAST_(15)<<  9)
+#define R10K_CONF_SB		(_ULCAST_(1) << 13)
+#define R10K_CONF_SK		(_ULCAST_(1) << 14)
+#define R10K_CONF_SS		(_ULCAST_(7) << 16)
+#define R10K_CONF_SC		(_ULCAST_(7) << 19)
+#define R10K_CONF_DC		(_ULCAST_(7) << 26)
+#define R10K_CONF_IC		(_ULCAST_(7) << 29)
+
+/* Bits specific to the VR41xx.  */
+#define VR41_CONF_CS		(_ULCAST_(1) << 12)
+#define VR41_CONF_M16		(_ULCAST_(1) << 20)
+#define VR41_CONF_AD		(_ULCAST_(1) << 23)
+
+/* Bits specific to the R30xx.  */
+#define R30XX_CONF_FDM		(_ULCAST_(1) << 19)
+#define R30XX_CONF_REV		(_ULCAST_(1) << 22)
+#define R30XX_CONF_AC		(_ULCAST_(1) << 23)
+#define R30XX_CONF_RF		(_ULCAST_(1) << 24)
+#define R30XX_CONF_HALT		(_ULCAST_(1) << 25)
+#define R30XX_CONF_FPINT	(_ULCAST_(7) << 26)
+#define R30XX_CONF_DBR		(_ULCAST_(1) << 29)
+#define R30XX_CONF_SB		(_ULCAST_(1) << 30)
+#define R30XX_CONF_LOCK		(_ULCAST_(1) << 31)
 
-/*
- * Bits in the TX49 coprozessor 0 config register.
- */
+/* Bits specific to the TX49.  */
 #define TX49_CONF_DC		(_ULCAST_(1) << 16)
 #define TX49_CONF_IC		(_ULCAST_(1) << 17)  /* conflict with CONF_SC */
 #define TX49_CONF_HALT		(_ULCAST_(1) << 18)
 #define TX49_CONF_CWFON		(_ULCAST_(1) << 27)
 
+/* Bits specific to the MIPS32/64 PRA.  */
+#define MIPS_CONF_MT		(_ULCAST_(7) <<  7)
+#define MIPS_CONF_AR		(_ULCAST_(7) << 10)
+#define MIPS_CONF_AT		(_ULCAST_(3) << 13)
+#define MIPS_CONF_M		(_ULCAST_(1) << 31)
+
 /*
  * R10000 performance counter definitions.
  *
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips64/mipsregs.h linux-mips-2.4.21-pre4-20030414/include/asm-mips64/mipsregs.h
--- linux-mips-2.4.21-pre4-20030414.macro/include/asm-mips64/mipsregs.h	2003-04-13 18:48:34.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030414/include/asm-mips64/mipsregs.h	2003-04-14 23:29:24.000000000 +0000
@@ -128,7 +128,7 @@
  * E the exception enable
  * S the sticky/flag bit
 */
-#define FPU_CSR_ALL_X 0x0003f000
+#define FPU_CSR_ALL_X   0x0003f000
 #define FPU_CSR_UNI_X   0x00020000
 #define FPU_CSR_INV_X   0x00010000
 #define FPU_CSR_DIV_X   0x00008000
@@ -373,8 +373,9 @@
 #define  CAUSEF_BD		(_ULCAST_(1)   << 31)
 
 /*
- * Bits in the coprozessor 0 config register.
+ * Bits in the coprocessor 0 config register.
  */
+/* Generic bits.  */
 #define CONF_CM_CACHABLE_NO_WA		0
 #define CONF_CM_CACHABLE_WA		1
 #define CONF_CM_UNCACHED		2
@@ -384,22 +385,73 @@
 #define CONF_CM_CACHABLE_CUW		6
 #define CONF_CM_CACHABLE_ACCELERATED	7
 #define CONF_CM_CMASK			7
+#define CONF_BE			(_ULCAST_(1) << 15)
+
+/* Bits common to various processors.  */
 #define CONF_CU			(_ULCAST_(1) <<  3)
 #define CONF_DB			(_ULCAST_(1) <<  4)
 #define CONF_IB			(_ULCAST_(1) <<  5)
-#define CONF_SE			(_ULCAST_(1) << 12)
+#define CONF_DC			(_ULCAST_(7) <<  6)
+#define CONF_IC			(_ULCAST_(7) <<  9)
+#define CONF_EB			(_ULCAST_(1) << 13)
+#define CONF_EM			(_ULCAST_(1) << 14)
+#define CONF_SM			(_ULCAST_(1) << 16)
 #define CONF_SC			(_ULCAST_(1) << 17)
-#define CONF_AC			(_ULCAST_(1) << 23)
-#define CONF_HALT		(_ULCAST_(1) << 25)
+#define CONF_EW			(_ULCAST_(3) << 18)
+#define CONF_EP			(_ULCAST_(15)<< 24)
+#define CONF_EC			(_ULCAST_(7) << 28)
+#define CONF_CM			(_ULCAST_(1) << 31)
+
+/* Bits specific to the R4xx0.  */
+#define R4K_CONF_SW		(_ULCAST_(1) << 20)
+#define R4K_CONF_SS		(_ULCAST_(1) << 21)
+#define R4K_CONF_SB		(_ULCAST_(3) << 22)
+
+/* Bits specific to the R5000.  */
+#define R5K_CONF_SE		(_ULCAST_(1) << 12)
+#define R5K_CONF_SS		(_ULCAST_(3) << 20)
+
+/* Bits specific to the R10000.  */
+#define R10K_CONF_DN		(_ULCAST_(3) <<  3)
+#define R10K_CONF_CT		(_ULCAST_(1) <<  5)
+#define R10K_CONF_PE		(_ULCAST_(1) <<  6)
+#define R10K_CONF_PM		(_ULCAST_(3) <<  7)
+#define R10K_CONF_EC		(_ULCAST_(15)<<  9)
+#define R10K_CONF_SB		(_ULCAST_(1) << 13)
+#define R10K_CONF_SK		(_ULCAST_(1) << 14)
+#define R10K_CONF_SS		(_ULCAST_(7) << 16)
+#define R10K_CONF_SC		(_ULCAST_(7) << 19)
+#define R10K_CONF_DC		(_ULCAST_(7) << 26)
+#define R10K_CONF_IC		(_ULCAST_(7) << 29)
+
+/* Bits specific to the VR41xx.  */
+#define VR41_CONF_CS		(_ULCAST_(1) << 12)
+#define VR41_CONF_M16		(_ULCAST_(1) << 20)
+#define VR41_CONF_AD		(_ULCAST_(1) << 23)
+
+/* Bits specific to the R30xx.  */
+#define R30XX_CONF_FDM		(_ULCAST_(1) << 19)
+#define R30XX_CONF_REV		(_ULCAST_(1) << 22)
+#define R30XX_CONF_AC		(_ULCAST_(1) << 23)
+#define R30XX_CONF_RF		(_ULCAST_(1) << 24)
+#define R30XX_CONF_HALT		(_ULCAST_(1) << 25)
+#define R30XX_CONF_FPINT	(_ULCAST_(7) << 26)
+#define R30XX_CONF_DBR		(_ULCAST_(1) << 29)
+#define R30XX_CONF_SB		(_ULCAST_(1) << 30)
+#define R30XX_CONF_LOCK		(_ULCAST_(1) << 31)
 
-/*
- * Bits in the TX49 coprozessor 0 config register.
- */
+/* Bits specific to the TX49.  */
 #define TX49_CONF_DC		(_ULCAST_(1) << 16)
 #define TX49_CONF_IC		(_ULCAST_(1) << 17)  /* conflict with CONF_SC */
 #define TX49_CONF_HALT		(_ULCAST_(1) << 18)
 #define TX49_CONF_CWFON		(_ULCAST_(1) << 27)
 
+/* Bits specific to the MIPS32/64 PRA.  */
+#define MIPS_CONF_MT		(_ULCAST_(7) <<  7)
+#define MIPS_CONF_AR		(_ULCAST_(7) << 10)
+#define MIPS_CONF_AT		(_ULCAST_(3) << 13)
+#define MIPS_CONF_M		(_ULCAST_(1) << 31)
+
 /*
  * R10000 performance counter definitions.
  *
