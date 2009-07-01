Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:07:12 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491864AbZGARHK
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 19:07:10 +0200
Message-Id: <20090701120939.353587047@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 01/12] MIPS: BCM63XX: Add Broadcom 63xx CPU definitions.
References: <20090701112926.825088732@linux-mips.org>
Content-Disposition: inline; filename=0001.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From:	Maxime Bizon <mbizon@freebox.fr>

Todo: Nothing ever detects CPU_BCM6338 but the code tests for it anyway.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/cpu.h  |    7 +++++++
 arch/mips/kernel/cpu-probe.c |   24 ++++++++++++++++++++++++
 arch/mips/mm/tlbex.c         |    4 ++++
 3 files changed, 35 insertions(+)

--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -113,6 +113,12 @@
 
 #define PRID_IMP_BCM4710	0x4000
 #define PRID_IMP_BCM3302	0x9000
+#define PRID_IMP_BCM6338	0x9000
+#define PRID_IMP_BCM6345	0x8000
+#define PRID_IMP_BCM6348	0x9100
+#define PRID_IMP_BCM4350	0xA000
+#define PRID_REV_BCM6358	0x0010
+#define PRID_REV_BCM6368	0x0030
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_CAVIUM
@@ -210,6 +216,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
+	CPU_BCM6338, CPU_BCM6345, CPU_BCM6348, CPU_BCM6358,
 
 	/*
 	 * MIPS64 class processors
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -159,6 +159,10 @@ void __init check_wait(void)
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BCM3302:
+	case CPU_BCM6338:
+	case CPU_BCM6345:
+	case CPU_BCM6348:
+	case CPU_BCM6358:
 	case CPU_CAVIUM_OCTEON:
 		cpu_wait = r4k_wait;
 		break;
@@ -857,6 +861,7 @@ static inline void cpu_probe_broadcom(st
 	decode_configs(c);
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_BCM3302:
+	 /* same as PRID_IMP_BCM6338 */
 		c->cputype = CPU_BCM3302;
 		__cpu_name[cpu] = "Broadcom BCM3302";
 		break;
@@ -864,6 +869,25 @@ static inline void cpu_probe_broadcom(st
 		c->cputype = CPU_BCM4710;
 		__cpu_name[cpu] = "Broadcom BCM4710";
 		break;
+	case PRID_IMP_BCM6345:
+		c->cputype = CPU_BCM6345;
+		__cpu_name[cpu] = "Broadcom BCM6345";
+		break;
+	case PRID_IMP_BCM6348:
+		c->cputype = CPU_BCM6348;
+		__cpu_name[cpu] = "Broadcom BCM6348";
+		break;
+	case PRID_IMP_BCM4350:
+		switch (c->processor_id & 0xf0) {
+		case PRID_REV_BCM6358:
+			c->cputype = CPU_BCM6358;
+			__cpu_name[cpu] = "Broadcom BCM6358";
+			break;
+		default:
+			c->cputype = CPU_UNKNOWN;
+			break;
+		}
+		break;
 	}
 }
 
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -321,6 +321,10 @@ static void __cpuinit build_tlb_write_en
 	case CPU_BCM3302:
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
+	case CPU_BCM6338:
+	case CPU_BCM6345:
+	case CPU_BCM6348:
+	case CPU_BCM6358:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
