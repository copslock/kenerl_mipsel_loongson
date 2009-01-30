Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 17:29:41 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:55441 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366216AbZA3R3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jan 2009 17:29:37 +0000
Received: (qmail 16257 invoked from network); 30 Jan 2009 18:29:36 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 30 Jan 2009 18:29:36 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/3] Alchemy: unify CPU model constants.
Date:	Fri, 30 Jan 2009 18:30:09 +0100
Message-Id: <1233336611-6450-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.1.1
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

This patch removes the various CPU_AU1??? model constants in favor of
a single CPU_ALCHEMY one.

All currently existing Alchemy models are identical in terms of cpu
core and cache size/organization.  The parts of the mips kernel which
need to know the exact CPU revision extract it from the c0_prid register
already; and finally nothing else in-tree depends on those any more.

Should a new variant with slightly different "company options" and/or
"processor revision" bits in c0_prid appear, it will be supported
immediately (minus an exact model string in cpuinfo).

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/cpu.h  |    3 +--
 arch/mips/kernel/cpu-probe.c |   21 ++++-----------------
 arch/mips/mm/c-r4k.c         |   17 +++++------------
 arch/mips/mm/tlbex.c         |    8 +-------
 4 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index c018727..3bdc0e3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -209,8 +209,7 @@ enum cpu_type_enum {
 	 * MIPS32 class processors
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
-	CPU_AU1000, CPU_AU1100, CPU_AU1200, CPU_AU1210, CPU_AU1250, CPU_AU1500,
-	CPU_AU1550, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
+	CPU_ALCHEMY, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a7162a4..0f33858 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -182,13 +182,7 @@ void __init check_wait(void)
 	case CPU_TX49XX:
 		cpu_wait = r4k_wait_irqoff;
 		break;
-	case CPU_AU1000:
-	case CPU_AU1100:
-	case CPU_AU1500:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
+	case CPU_ALCHEMY:
 		cpu_wait = au1k_wait;
 		break;
 	case CPU_20KC:
@@ -782,37 +776,30 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_AU1_REV1:
 	case PRID_IMP_AU1_REV2:
+		c->cputype = CPU_ALCHEMY;
 		switch ((c->processor_id >> 24) & 0xff) {
 		case 0:
-			c->cputype = CPU_AU1000;
 			__cpu_name[cpu] = "Au1000";
 			break;
 		case 1:
-			c->cputype = CPU_AU1500;
 			__cpu_name[cpu] = "Au1500";
 			break;
 		case 2:
-			c->cputype = CPU_AU1100;
 			__cpu_name[cpu] = "Au1100";
 			break;
 		case 3:
-			c->cputype = CPU_AU1550;
 			__cpu_name[cpu] = "Au1550";
 			break;
 		case 4:
-			c->cputype = CPU_AU1200;
 			__cpu_name[cpu] = "Au1200";
-			if ((c->processor_id & 0xff) == 2) {
-				c->cputype = CPU_AU1250;
+			if ((c->processor_id & 0xff) == 2)
 				__cpu_name[cpu] = "Au1250";
-			}
 			break;
 		case 5:
-			c->cputype = CPU_AU1210;
 			__cpu_name[cpu] = "Au1210";
 			break;
 		default:
-			panic("Unknown Au Core!");
+			__cpu_name[cpu] = "Au1xxx";
 			break;
 		}
 		break;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6e99665..2f9cded 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1006,13 +1006,7 @@ static void __cpuinit probe_pcache(void)
 		c->icache.flags |= MIPS_CACHE_VTAG;
 		break;
 
-	case CPU_AU1000:
-	case CPU_AU1500:
-	case CPU_AU1100:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
+	case CPU_ALCHEMY:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 	}
@@ -1224,7 +1218,7 @@ void au1x00_fixup_config_od(void)
 	/*
 	 * Au1100 errata actually keeps silence about this bit, so we set it
 	 * just in case for those revisions that require it to be set according
-	 * to arch/mips/au1000/common/cputable.c
+	 * to the (now gone) cpu table.
 	 */
 	case 0x02030200: /* Au1100 AB */
 	case 0x02030201: /* Au1100 BA */
@@ -1294,11 +1288,10 @@ static void __cpuinit coherency_setup(void)
 		break;
 	/*
 	 * We need to catch the early Alchemy SOCs with
-	 * the write-only co_config.od bit and set it back to one...
+	 * the write-only co_config.od bit and set it back to one on:
+	 * Au1000 rev DA, HA, HB;  Au1100 AB, BA, BC, Au1500 AB
 	 */
-	case CPU_AU1000: /* rev. DA, HA, HB */
-	case CPU_AU1100: /* rev. AB, BA, BC ?? */
-	case CPU_AU1500: /* rev. AB */
+	case CPU_ALCHEMY:
 		au1x00_fixup_config_od();
 		break;
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4294203..00ac573 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -292,13 +292,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
-	case CPU_AU1000:
-	case CPU_AU1100:
-	case CPU_AU1500:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
+	case CPU_ALCHEMY:
 	case CPU_PR4450:
 		uasm_i_nop(p);
 		tlbw(p);
-- 
1.6.1.1
