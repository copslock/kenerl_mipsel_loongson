Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:58:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29943 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbdHMCzf3adP6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:55:35 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 629DFABE3C828;
        Sun, 13 Aug 2017 03:55:26 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:55:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 18/19] MIPS: CPS: Cluster support for topology functions
Date:   Sat, 12 Aug 2017 19:49:42 -0700
Message-ID: <20170813024943.14989-19-paul.burton@imgtec.com>
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
X-archive-position: 59514
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

Modify the functions we use to read information about the topology of
the system (the number of cores, VPs & IOCUs that it contains) in order
to take into account multiple clusters, and provide a new function to
determine the number of clusters in the system.

Users of these functions are modified only such that they continue to
build successfully - having them actually handle multiple clusters is
left to further patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h   |  30 ---------
 arch/mips/include/asm/mips-cps.h  | 128 ++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/smp-cps.c        |  15 +----
 arch/mips/mti-malta/malta-setup.c |   2 +-
 arch/mips/pci/pci-malta.c         |   4 +-
 arch/mips/ralink/mt7621.c         |   2 +-
 6 files changed, 135 insertions(+), 46 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 3b82ebb5b35c..f6231b91b724 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -328,36 +328,6 @@ GCR_CX_ACCESSOR_RW(32, 0x030, reset_ext_base)
 #define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA	GENMASK(7, 1)
 #define CM_GCR_Cx_RESET_EXT_BASE_PRESENT	BIT(0)
 
-/**
- * mips_cm_numcores - return the number of cores present in the system
- *
- * Returns the value of the PCORES field of the GCR_CONFIG register plus 1, or
- * zero if no Coherence Manager is present.
- */
-static inline unsigned mips_cm_numcores(void)
-{
-	if (!mips_cm_present())
-		return 0;
-
-	return ((read_gcr_config() & CM_GCR_CONFIG_PCORES)
-		>> __ffs(CM_GCR_CONFIG_PCORES)) + 1;
-}
-
-/**
- * mips_cm_numiocu - return the number of IOCUs present in the system
- *
- * Returns the value of the NUMIOCU field of the GCR_CONFIG register, or zero
- * if no Coherence Manager is present.
- */
-static inline unsigned mips_cm_numiocu(void)
-{
-	if (!mips_cm_present())
-		return 0;
-
-	return (read_gcr_config() & CM_GCR_CONFIG_NUMIOCU)
-		>> __ffs(CM_GCR_CONFIG_NUMIOCU);
-}
-
 /**
  * mips_cm_l2sync - perform an L2-only sync operation
  *
diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index 2ac88ed4b381..2dd737d803e1 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -108,4 +108,132 @@ static inline void clear_##unit##_##name(uint##sz##_t val)		\
 #include <asm/mips-cm.h>
 #include <asm/mips-cpc.h>
 
+/**
+ * mips_cps_numclusters - return the number of clusters present in the system
+ *
+ * Returns the number of clusters in the system.
+ */
+static inline unsigned int mips_cps_numclusters(void)
+{
+	unsigned int num_clusters;
+
+	if (mips_cm_revision() < CM_REV_CM3_5)
+		return 1;
+
+	num_clusters = read_gcr_config() & CM_GCR_CONFIG_NUM_CLUSTERS;
+	num_clusters >>= __ffs(CM_GCR_CONFIG_NUM_CLUSTERS);
+	return num_clusters;
+}
+
+/**
+ * mips_cps_cluster_config - return (GCR|CPC)_CONFIG from a cluster
+ * @cluster: the ID of the cluster whose config we want
+ *
+ * Read the value of GCR_CONFIG (or its CPC_CONFIG mirror) from a @cluster.
+ *
+ * Returns the value of GCR_CONFIG.
+ */
+static inline uint64_t mips_cps_cluster_config(unsigned int cluster)
+{
+	uint64_t config;
+
+	if (mips_cm_revision() < CM_REV_CM3_5) {
+		/*
+		 * Prior to CM 3.5 we don't have the notion of multiple
+		 * clusters so we can trivially read the GCR_CONFIG register
+		 * within this cluster.
+		 */
+		WARN_ON(cluster != 0);
+		config = read_gcr_config();
+	} else {
+		/*
+		 * From CM 3.5 onwards we read the CPC_CONFIG mirror of
+		 * GCR_CONFIG via the redirect region, since the CPC is always
+		 * powered up allowing us not to need to power up the CM.
+		 */
+		mips_cm_lock_other(cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+		config = read_cpc_redir_config();
+		mips_cm_unlock_other();
+	}
+
+	return config;
+}
+
+/**
+ * mips_cps_numcores - return the number of cores present in a cluster
+ * @cluster: the ID of the cluster whose core count we want
+ *
+ * Returns the value of the PCORES field of the GCR_CONFIG register plus 1, or
+ * zero if no Coherence Manager is present.
+ */
+static inline unsigned int mips_cps_numcores(unsigned int cluster)
+{
+	if (!mips_cm_present())
+		return 0;
+
+	/* Add one before masking to handle 0xff indicating no cores */
+	return (mips_cps_cluster_config(cluster) + 1) & CM_GCR_CONFIG_PCORES;
+}
+
+/**
+ * mips_cps_numiocu - return the number of IOCUs present in a cluster
+ * @cluster: the ID of the cluster whose IOCU count we want
+ *
+ * Returns the value of the NUMIOCU field of the GCR_CONFIG register, or zero
+ * if no Coherence Manager is present.
+ */
+static inline unsigned int mips_cps_numiocu(unsigned int cluster)
+{
+	unsigned int num_iocu;
+
+	if (!mips_cm_present())
+		return 0;
+
+	num_iocu = mips_cps_cluster_config(cluster) & CM_GCR_CONFIG_NUMIOCU;
+	num_iocu >>= __ffs(CM_GCR_CONFIG_NUMIOCU);
+	return num_iocu;
+}
+
+/**
+ * mips_cps_numvps - return the number of VPs (threads) supported by a core
+ * @cluster: the ID of the cluster containing the core we want to examine
+ * @core: the ID of the core whose VP count we want
+ *
+ * Returns the number of Virtual Processors (VPs, ie. hardware threads) that
+ * are supported by the given @core in the given @cluster. If the core or the
+ * kernel do not support hardware mutlti-threading this returns 1.
+ */
+static inline unsigned int mips_cps_numvps(unsigned int cluster, unsigned int core)
+{
+	unsigned int cfg;
+
+	if (!mips_cm_present())
+		return 1;
+
+	if ((!IS_ENABLED(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
+		&& (!IS_ENABLED(CONFIG_CPU_MIPSR6) || !cpu_has_vp))
+		return 1;
+
+	mips_cm_lock_other(cluster, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+
+	if (mips_cm_revision() < CM_REV_CM3_5) {
+		/*
+		 * Prior to CM 3.5 we can only have one cluster & don't have
+		 * CPC_Cx_CONFIG, so we read GCR_Cx_CONFIG.
+		 */
+		cfg = read_gcr_co_config();
+	} else {
+		/*
+		 * From CM 3.5 onwards we read CPC_Cx_CONFIG because the CPC is
+		 * always powered, which allows us to not worry about powering
+		 * up the cluster's CM here.
+		 */
+		cfg = read_cpc_co_config();
+	}
+
+	mips_cm_unlock_other();
+
+	return (cfg + 1) & CM_GCR_Cx_CONFIG_PVPE;
+}
+
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 57b331b85e54..4b9dcca12e5f 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -42,19 +42,10 @@ early_param("nothreads", setup_nothreads);
 
 static unsigned core_vpe_count(unsigned core)
 {
-	unsigned cfg;
-
 	if (threads_disabled)
 		return 1;
 
-	if ((!IS_ENABLED(CONFIG_MIPS_MT_SMP) || !cpu_has_mipsmt)
-		&& (!IS_ENABLED(CONFIG_CPU_MIPSR6) || !cpu_has_vp))
-		return 1;
-
-	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
-	cfg = read_gcr_co_config() & CM_GCR_Cx_CONFIG_PVPE;
-	mips_cm_unlock_other();
-	return cfg + 1;
+	return mips_cps_numvps(0, core);
 }
 
 static void __init cps_smp_setup(void)
@@ -64,7 +55,7 @@ static void __init cps_smp_setup(void)
 	int c, v;
 
 	/* Detect & record VPE topology */
-	ncores = mips_cm_numcores();
+	ncores = mips_cps_numcores(0);
 	pr_info("%s topology ", cpu_has_mips_r6 ? "VP" : "VPE");
 	for (c = nvpes = 0; c < ncores; c++) {
 		core_vpes = core_vpe_count(c);
@@ -138,7 +129,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	}
 
 	/* Warn the user if the CCA prevents multi-core */
-	ncores = mips_cm_numcores();
+	ncores = mips_cps_numcores(0);
 	if ((cca_unsuitable || cpu_has_dc_aliases) && ncores > 1) {
 		pr_warn("Using only one core due to %s%s%s\n",
 			cca_unsuitable ? "unsuitable CCA" : "",
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 7f1868888d18..de34adb76157 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -128,7 +128,7 @@ static int __init plat_enable_iocoherency(void)
 				 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
 			pr_info("Enabled Bonito IOBC coherency\n");
 		}
-	} else if (mips_cm_numiocu() != 0) {
+	} else if (mips_cps_numiocu(0) != 0) {
 		/* Nothing special needs to be done to enable coherency */
 		pr_info("CMP IOCU detected\n");
 		cfg = __raw_readl((u32 *)CKSEG1ADDR(ROCIT_CONFIG_GEN0));
diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index de97b8f1c5a8..88e625fb3a47 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -201,7 +201,7 @@ void __init mips_pcibios_init(void)
 		msc_mem_resource.start = start & mask;
 		msc_mem_resource.end = (start & mask) | ~mask;
 		msc_controller.mem_offset = (start & mask) - (map & mask);
-		if (mips_cm_numiocu()) {
+		if (mips_cps_numiocu(0)) {
 			write_gcr_reg0_base(start);
 			write_gcr_reg0_mask(mask |
 					    CM_GCR_REGn_MASK_CMTGT_IOCU0);
@@ -213,7 +213,7 @@ void __init mips_pcibios_init(void)
 		msc_io_resource.end = (map & mask) | ~mask;
 		msc_controller.io_offset = 0;
 		ioport_resource.end = ~mask;
-		if (mips_cm_numiocu()) {
+		if (mips_cps_numiocu(0)) {
 			write_gcr_reg1_base(start);
 			write_gcr_reg1_mask(mask |
 					    CM_GCR_REGn_MASK_CMTGT_IOCU0);
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 9661c50305b5..1b274742077d 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -198,7 +198,7 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	mips_cm_probe();
 	mips_cpc_probe();
 
-	if (mips_cm_numiocu()) {
+	if (mips_cps_numiocu(0)) {
 		/*
 		 * mips_cm_probe() wipes out bootloader
 		 * config for CM regions and we have to configure them
-- 
2.14.0
