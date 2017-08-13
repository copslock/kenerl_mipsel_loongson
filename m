Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:58:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62910 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdHMCzwwa-d6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:55:52 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 86479F41AC3E6;
        Sun, 13 Aug 2017 03:55:44 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:55:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 19/19] MIPS: CPS: Detect CPUs in secondary clusters
Date:   Sat, 12 Aug 2017 19:49:43 -0700
Message-ID: <20170813024943.14989-20-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

As a first step towards supporting multi-cluster systems, detect cores &
VPs in secondary clusters & record their cluster information in the
cpu_data array. The "VP topology" line printed during boot is extended
to display multiple clusters. On a single cluster it shows output like
the following:

  VP topology: {4,4}

This would indicate a system with 2 cores which each contain 4 VPs. We
extend this to cover multiple clusters in a natural way:

  VP topology: {4,4},{2,2}

This would indicate a system with 2 clusters. The first cluster contains
2 cores which each contain 4 VPs. The second cluster contains 2 cores
which each contain 2 VPs.

Actually booting these cores & VPs is left to further patches once other
pieces are in place.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/kernel/smp-cps.c | 80 +++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4b9dcca12e5f..0d9cda6a77de 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -40,44 +40,58 @@ static int __init setup_nothreads(char *s)
 }
 early_param("nothreads", setup_nothreads);
 
-static unsigned core_vpe_count(unsigned core)
+static unsigned core_vpe_count(unsigned int cluster, unsigned core)
 {
 	if (threads_disabled)
 		return 1;
 
-	return mips_cps_numvps(0, core);
+	return mips_cps_numvps(cluster, core);
 }
 
 static void __init cps_smp_setup(void)
 {
-	unsigned int ncores, nvpes, core_vpes;
+	unsigned int nclusters, ncores, nvpes, core_vpes;
 	unsigned long core_entry;
-	int c, v;
+	int cl, c, v;
 
 	/* Detect & record VPE topology */
-	ncores = mips_cps_numcores(0);
+	nvpes = 0;
+	nclusters = mips_cps_numclusters();
 	pr_info("%s topology ", cpu_has_mips_r6 ? "VP" : "VPE");
-	for (c = nvpes = 0; c < ncores; c++) {
-		core_vpes = core_vpe_count(c);
-		pr_cont("%c%u", c ? ',' : '{', core_vpes);
-
-		/* Use the number of VPEs in core 0 for smp_num_siblings */
-		if (!c)
-			smp_num_siblings = core_vpes;
+	for (cl = 0; cl < nclusters; cl++) {
+		if (cl > 0)
+			pr_cont(",");
+		pr_cont("{");
+
+		ncores = mips_cps_numcores(cl);
+		for (c = 0; c < ncores; c++) {
+			core_vpes = core_vpe_count(cl, c);
+
+			if (c > 0)
+				pr_cont(",");
+			pr_cont("%u", core_vpes);
+
+			/* Use the number of VPEs in cluster 0 core 0 for smp_num_siblings */
+			if (!cl && !c)
+				smp_num_siblings = core_vpes;
+
+			for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
+				cpu_set_cluster(&cpu_data[nvpes + v], cl);
+				cpu_set_core(&cpu_data[nvpes + v], c);
+				cpu_set_vpe_id(&cpu_data[nvpes + v], v);
+			}
 
-		for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
-			cpu_set_core(&cpu_data[nvpes + v], c);
-			cpu_set_vpe_id(&cpu_data[nvpes + v], v);
+			nvpes += core_vpes;
 		}
 
-		nvpes += core_vpes;
+		pr_cont("}");
 	}
-	pr_cont("} total %u\n", nvpes);
+	pr_cont(" total %u\n", nvpes);
 
 	/* Indicate present CPUs (CPU being synonymous with VPE) */
 	for (v = 0; v < min_t(unsigned, nvpes, NR_CPUS); v++) {
-		set_cpu_possible(v, true);
-		set_cpu_present(v, true);
+		set_cpu_possible(v, cpu_cluster(&cpu_data[v]) == 0);
+		set_cpu_present(v, cpu_cluster(&cpu_data[v]) == 0);
 		__cpu_number_map[v] = v;
 		__cpu_logical_map[v] = v;
 	}
@@ -109,7 +123,7 @@ static void __init cps_smp_setup(void)
 static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned ncores, core_vpes, c, cca;
-	bool cca_unsuitable;
+	bool cca_unsuitable, cores_limited;
 	u32 *entry_code;
 
 	mips_mt_set_cpuoptions();
@@ -129,19 +143,22 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	}
 
 	/* Warn the user if the CCA prevents multi-core */
-	ncores = mips_cps_numcores(0);
-	if ((cca_unsuitable || cpu_has_dc_aliases) && ncores > 1) {
+	cores_limited = false;
+	if (cca_unsuitable || cpu_has_dc_aliases) {
+		for_each_present_cpu(c) {
+			if (cpus_are_siblings(smp_processor_id(), c))
+				continue;
+
+			set_cpu_present(c, false);
+			cores_limited = true;
+		}
+	}
+	if (cores_limited)
 		pr_warn("Using only one core due to %s%s%s\n",
 			cca_unsuitable ? "unsuitable CCA" : "",
 			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
 			cpu_has_dc_aliases ? "dcache aliasing" : "");
 
-		for_each_present_cpu(c) {
-			if (!cpus_are_siblings(smp_processor_id(), c))
-				set_cpu_present(c, false);
-		}
-	}
-
 	/*
 	 * Patch the start of mips_cps_core_entry to provide:
 	 *
@@ -156,6 +173,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	__sync();
 
 	/* Allocate core boot configuration structs */
+	ncores = mips_cps_numcores(0);
 	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
 					GFP_KERNEL);
 	if (!mips_cps_core_bootcfg) {
@@ -165,7 +183,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 
 	/* Allocate VPE boot configuration structs */
 	for (c = 0; c < ncores; c++) {
-		core_vpes = core_vpe_count(c);
+		core_vpes = core_vpe_count(0, c);
 		mips_cps_core_bootcfg[c].vpe_config = kcalloc(core_vpes,
 				sizeof(*mips_cps_core_bootcfg[c].vpe_config),
 				GFP_KERNEL);
@@ -288,6 +306,10 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 	unsigned int remote;
 	int err;
 
+	/* We don't yet support booting CPUs in other clusters */
+	if (cpu_cluster(&cpu_data[cpu]) != cpu_cluster(&current_cpu_data))
+		return -ENOSYS;
+
 	vpe_cfg->pc = (unsigned long)&smp_bootstrap;
 	vpe_cfg->sp = __KSTK_TOS(idle);
 	vpe_cfg->gp = (unsigned long)task_thread_info(idle);
-- 
2.14.0
