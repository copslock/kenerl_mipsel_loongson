Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:59:02 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39869 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903628Ab2DIP6y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:58:54 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGzP-0005yg-99; Mon, 09 Apr 2012 10:58:47 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] Multi-threaded FPU support for SMTC configuration.
Date:   Mon,  9 Apr 2012 10:58:39 -0500
Message-Id: <1333987119-605-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mipsmtregs.h |   15 ++++++-
 arch/mips/include/asm/smtc.h       |    6 +++
 arch/mips/kernel/smp.c             |    4 +-
 arch/mips/kernel/smtc.c            |   84 ++++++++++++++++++++++++++++++------
 4 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index c9420aa..5b3cb85 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -28,6 +28,9 @@
 #define read_c0_vpeconf0()		__read_32bit_c0_register($1, 2)
 #define write_c0_vpeconf0(val)		__write_32bit_c0_register($1, 2, val)
 
+#define read_c0_vpeconf1()		__read_32bit_c0_register($1, 3)
+#define write_c0_vpeconf1(val)		__write_32bit_c0_register($1, 3, val)
+
 #define read_c0_tcstatus()		__read_32bit_c0_register($2, 1)
 #define write_c0_tcstatus(val)		__write_32bit_c0_register($2, 1, val)
 
@@ -48,7 +51,7 @@
 #define CP0_VPECONF0		$1, 2
 #define CP0_VPECONF1		$1, 3
 #define CP0_YQMASK		$1, 4
-#define CP0_VPESCHEDULE	$1, 5
+#define CP0_VPESCHEDULE		$1, 5
 #define CP0_VPESCHEFBK		$1, 6
 #define CP0_TCSTATUS		$2, 1
 #define CP0_TCBIND		$2, 2
@@ -124,6 +127,14 @@
 #define VPECONF0_XTC_SHIFT	21
 #define VPECONF0_XTC		(_ULCAST_(0xff) << VPECONF0_XTC_SHIFT)
 
+/* VPEConf1 fields (per VPE) */
+#define VPECONF1_NCP1_SHIFT	0
+#define VPECONF1_NCP1		(_ULCAST_(0xff) << VPECONF1_NCP1_SHIFT)
+#define VPECONF1_NCP2_SHIFT	10
+#define VPECONF1_NCP2		(_ULCAST_(0xff) << VPECONF1_NCP2_SHIFT)
+#define VPECONF1_NCX_SHIFT	20
+#define VPECONF1_NCX		(_ULCAST_(0xff) << VPECONF1_NCX_SHIFT)
+
 /* TCStatus fields (per TC) */
 #define TCSTATUS_TASID		(_ULCAST_(0xff))
 #define TCSTATUS_IXMT_SHIFT	10
@@ -350,6 +361,8 @@ do {									\
 #define write_vpe_c0_vpecontrol(val)	mttc0(1, 1, val)
 #define read_vpe_c0_vpeconf0()		mftc0(1, 2)
 #define write_vpe_c0_vpeconf0(val)	mttc0(1, 2, val)
+#define read_vpe_c0_vpeconf1()		mftc0(1, 3)
+#define write_vpe_c0_vpeconf1(val)	mttc0(1, 3, val)
 #define read_vpe_c0_count()		mftc0(9, 0)
 #define write_vpe_c0_count(val)		mttc0(9, 0, val)
 #define read_vpe_c0_status()		mftc0(12, 0)
diff --git a/arch/mips/include/asm/smtc.h b/arch/mips/include/asm/smtc.h
index c9736fc..8935426 100644
--- a/arch/mips/include/asm/smtc.h
+++ b/arch/mips/include/asm/smtc.h
@@ -33,6 +33,12 @@ typedef long asiduse;
 #endif
 #endif
 
+/*
+ * VPE Management information
+ */
+
+#define MAX_SMTC_VPES	MAX_SMTC_TLBS	/* FIXME: May not always be true. */
+
 extern asiduse smtc_live_asid[MAX_SMTC_TLBS][MAX_SMTC_ASIDS];
 
 struct mm_struct;
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 9c1cce9..a5bc9ad 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -102,7 +102,9 @@ asmlinkage __cpuinit void start_secondary(void)
 
 #ifdef CONFIG_MIPS_MT_SMTC
 	/* Only do cpu_probe for first TC of CPU */
-	if ((read_c0_tcbind() & TCBIND_CURTC) == 0)
+	if ((read_c0_tcbind() & TCBIND_CURTC) != 0)
+		__cpu_name[smp_processor_id()] = __cpu_name[0];
+	else
 #endif /* CONFIG_MIPS_MT_SMTC */
 	cpu_probe();
 	cpu_report();
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index c4f75bb..12ec8ed 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -86,6 +86,13 @@ struct smtc_ipi_q IPIQ[NR_CPUS];
 static struct smtc_ipi_q freeIPIq;
 
 
+/*
+ * Number of FPU contexts for each VPE
+ */
+
+static int smtc_nconf1[MAX_SMTC_VPES];
+
+
 /* Forward declarations */
 
 void ipi_decode(struct smtc_ipi *);
@@ -174,9 +181,9 @@ static int __init tintq(char *str)
 
 __setup("tintq=", tintq);
 
-static int imstuckcount[2][8];
+static int imstuckcount[MAX_SMTC_VPES][8];
 /* vpemask represents IM/IE bits of per-VPE Status registers, low-to-high */
-static int vpemask[2][8] = {
+static int vpemask[MAX_SMTC_VPES][8] = {
 	{0, 0, 1, 0, 0, 0, 0, 1},
 	{0, 0, 0, 0, 0, 0, 0, 1}
 };
@@ -322,7 +329,7 @@ int __init smtc_build_cpu_map(int start_cpu_slot)
 
 /*
  * Common setup before any secondaries are started
- * Make sure all CPU's are in a sensible state before we boot any of the
+ * Make sure all CPUs are in a sensible state before we boot any of the
  * secondaries.
  *
  * For MIPS MT "SMTC" operation, we set up all TCs, spread as evenly
@@ -331,6 +338,22 @@ int __init smtc_build_cpu_map(int start_cpu_slot)
 
 static void smtc_tc_setup(int vpe, int tc, int cpu)
 {
+	static int cp1contexts[MAX_SMTC_VPES];
+
+	/*
+	 * Make a local copy of the available FPU contexts in order
+	 * to keep track of TCs that can have one.
+	 */
+	if (tc == 1)
+	{
+		/*
+		 * FIXME: Multi-core SMTC hasn't been tested and the
+		 *        maximum number of VPEs may change.
+		 */
+		cp1contexts[0] = smtc_nconf1[0] - 1;
+		cp1contexts[1] = smtc_nconf1[1];
+	}
+
 	settc(tc);
 	write_tc_c0_tchalt(TCHALT_H);
 	mips_ihb();
@@ -340,26 +363,33 @@ static void smtc_tc_setup(int vpe, int tc, int cpu)
 	/*
 	 * TCContext gets an offset from the base of the IPIQ array
 	 * to be used in low-level code to detect the presence of
-	 * an active IPI queue
+	 * an active IPI queue.
 	 */
 	write_tc_c0_tccontext((sizeof(struct smtc_ipi_q) * cpu) << 16);
-	/* Bind tc to vpe */
+
+	/* Bind TC to VPE. */
 	write_tc_c0_tcbind(vpe);
-	/* In general, all TCs should have the same cpu_data indications */
+
+	/* In general, all TCs should have the same cpu_data indications. */
 	memcpy(&cpu_data[cpu], &cpu_data[0], sizeof(struct cpuinfo_mips));
-	/* For 34Kf, start with TC/CPU 0 as sole owner of single FPU context */
-	if (cpu_data[0].cputype == CPU_34K ||
-	    cpu_data[0].cputype == CPU_1004K)
+
+	/* Check to see if there is a FPU context available for this TC. */
+	if (!cp1contexts[vpe])
 		cpu_data[cpu].options &= ~MIPS_CPU_FPU;
+	else
+		cp1contexts[vpe]--;
+
+	/* Store the TC and VPE into the cpu_data structure. */
 	cpu_data[cpu].vpe_id = vpe;
 	cpu_data[cpu].tc_id = tc;
-	/* Multi-core SMTC hasn't been tested, but be prepared */
+
+	/* FIXME: Multi-core SMTC hasn't been tested, but be prepared. */
 	cpu_data[cpu].core = (read_vpe_c0_ebase() >> 1) & 0xff;
 }
 
 /*
- * Tweak to get Count registes in as close a sync as possible.
- * Value seems good for 34K-class cores.
+ * Tweak to get Count registers synced as closely as possible. The
+ * value seems good for 34K-class cores.
  */
 
 #define CP0_SKEW 8
@@ -466,6 +496,24 @@ void smtc_prepare_cpus(int cpus)
 	smtc_configure_tlb();
 
 	for (tc = 0, vpe = 0 ; (vpe < nvpe) && (tc < ntc) ; vpe++) {
+		/* Get number of CP1 contexts for each VPE. */
+		if (tc == 0)
+		{
+			/*
+			 * Do not call settc() for TC0 or the FPU context
+			 * value will be incorrect. Besides, we know that
+			 * we are TC0 anyway.
+			 */
+			smtc_nconf1[0] = ((read_vpe_c0_vpeconf1() &
+				VPECONF1_NCP1) >> VPECONF1_NCP1_SHIFT);
+			if (nvpe == 2)
+			{
+				settc(1);
+				smtc_nconf1[1] = ((read_vpe_c0_vpeconf1() &
+					VPECONF1_NCP1) >> VPECONF1_NCP1_SHIFT);
+				settc(0);
+			}
+		}
 		if (tcpervpe[vpe] == 0)
 			continue;
 		if (vpe != 0)
@@ -479,6 +527,18 @@ void smtc_prepare_cpus(int cpus)
 			 */
 			if (tc != 0) {
 				smtc_tc_setup(vpe, tc, cpu);
+				if (vpe != 0) {
+					/*
+					 * Set MVP bit (possibly again).  Do it
+					 * here to catch CPUs that have no TCs
+					 * bound to the VPE at reset.  In that
+					 * case, a TC must be bound to the VPE
+					 * before we can set VPEControl[MVP]
+					 */
+					write_vpe_c0_vpeconf0(
+						read_vpe_c0_vpeconf0() |
+						VPECONF0_MVP);
+				}
 				cpu++;
 			}
 			printk(" %d", tc);
-- 
1.7.9.6
