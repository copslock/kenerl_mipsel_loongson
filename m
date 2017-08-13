Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:56:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37636 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993909AbdHMCylPDXN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:54:41 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B839CDAF01D5E;
        Sun, 13 Aug 2017 03:54:32 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:54:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 15/19] MIPS: CM: Add cluster & block args to mips_cm_lock_other()
Date:   Sat, 12 Aug 2017 19:49:39 -0700
Message-ID: <20170813024943.14989-16-paul.burton@imgtec.com>
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
X-archive-position: 59511
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

With CM >= 3.5 we have the notion of multiple clusters & can access
their CM, CPC & GIC registers via the apporpriate redirect/other
register blocks. In order to allow for this introduce cluster & block
arguments to mips_cm_lock_other() which configures the redirect/other
region to point at the appropriate cluster, core, VP & register block.

Since we now have 4 arguments to mips_cm_lock_other() & a common use is
likely to be to target the cluster, core & VP corresponding to a
particular Linux CPU number we also add a new mips_cm_lock_other_cpu()
helper function which handles that without the caller needing to
manually pull out the cluster, core & VP numbers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h | 45 ++++++++++++++++++++++++++++++++---------
 arch/mips/kernel/mips-cm.c      | 19 ++++++++++++++---
 arch/mips/kernel/smp-cps.c      | 10 ++++-----
 arch/mips/kernel/smp.c          |  2 +-
 4 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 6cfc0cc265d7..d42cc8e76dc2 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -437,29 +437,56 @@ static inline unsigned int mips_cm_vp_id(unsigned int cpu)
 #ifdef CONFIG_MIPS_CM
 
 /**
- * mips_cm_lock_other - lock access to another core
+ * mips_cm_lock_other - lock access to redirect/other region
+ * @cluster: the other cluster to be accessed
  * @core: the other core to be accessed
  * @vp: the VP within the other core to be accessed
+ * @block: the register block to be accessed
  *
- * Call before operating upon a core via the 'other' register region in
- * order to prevent the region being moved during access. Must be followed
- * by a call to mips_cm_unlock_other.
+ * Configure the redirect/other region for the local core/VP (depending upon
+ * the CM revision) to target the specified @cluster, @core, @vp & register
+ * @block. Must be called before using the redirect/other region, and followed
+ * by a call to mips_cm_unlock_other() when access to the redirect/other region
+ * is complete.
+ *
+ * This function acquires a spinlock such that code between it &
+ * mips_cm_unlock_other() calls cannot be pre-empted by anything which may
+ * reconfigure the redirect/other region, and cannot be interfered with by
+ * another VP in the core. As such calls to this function should not be nested.
  */
-extern void mips_cm_lock_other(unsigned int core, unsigned int vp);
+extern void mips_cm_lock_other(unsigned int cluster, unsigned int core,
+			       unsigned int vp, unsigned int block);
 
 /**
- * mips_cm_unlock_other - unlock access to another core
+ * mips_cm_unlock_other - unlock access to redirect/other region
  *
- * Call after operating upon another core via the 'other' register region.
- * Must be called after mips_cm_lock_other.
+ * Must be called after mips_cm_lock_other() once all required access to the
+ * redirect/other region has been completed.
  */
 extern void mips_cm_unlock_other(void);
 
 #else /* !CONFIG_MIPS_CM */
 
-static inline void mips_cm_lock_other(unsigned int core, unsigned int vp) { }
+static inline void mips_cm_lock_other(unsigned int cluster, unsigned int core,
+				      unsigned int vp, unsigned int block) { }
 static inline void mips_cm_unlock_other(void) { }
 
 #endif /* !CONFIG_MIPS_CM */
 
+/**
+ * mips_cm_lock_other_cpu - lock access to redirect/other region
+ * @cpu: the other CPU whose register we want to access
+ *
+ * Configure the redirect/other region for the local core/VP (depending upon
+ * the CM revision) to target the specified @cpu & register @block. This is
+ * equivalent to calling mips_cm_lock_other() but accepts a Linux CPU number
+ * for convenience.
+ */
+static inline void mips_cm_lock_other_cpu(unsigned int cpu, unsigned int block)
+{
+	struct cpuinfo_mips *d = &cpu_data[cpu];
+
+	mips_cm_lock_other(cpu_cluster(d), cpu_core(d), cpu_vpe_id(d), block);
+}
+
 #endif /* __MIPS_ASM_MIPS_CM_H__ */
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 64ad8d0a6986..602c6ec9c01d 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -257,17 +257,28 @@ int mips_cm_probe(void)
 	return 0;
 }
 
-void mips_cm_lock_other(unsigned int core, unsigned int vp)
+void mips_cm_lock_other(unsigned int cluster, unsigned int core,
+			unsigned int vp, unsigned int block)
 {
-	unsigned curr_core;
+	unsigned int curr_core, cm_rev;
 	u32 val;
 
+	cm_rev = mips_cm_revision();
 	preempt_disable();
 
-	if (mips_cm_revision() >= CM_REV_CM3) {
+	if (cm_rev >= CM_REV_CM3) {
 		val = core << __ffs(CM3_GCR_Cx_OTHER_CORE);
 		val |= vp << __ffs(CM3_GCR_Cx_OTHER_VP);
 
+		if (cm_rev >= CM_REV_CM3_5) {
+			val |= CM_GCR_Cx_OTHER_CLUSTER_EN;
+			val |= cluster << __ffs(CM_GCR_Cx_OTHER_CLUSTER);
+			val |= block << __ffs(CM_GCR_Cx_OTHER_BLOCK);
+		} else {
+			WARN_ON(cluster != 0);
+			WARN_ON(block != CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+		}
+
 		/*
 		 * We need to disable interrupts in SMP systems in order to
 		 * ensure that we don't interrupt the caller with code which
@@ -280,7 +291,9 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 		spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
 				  *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
+		WARN_ON(cluster != 0);
 		WARN_ON(vp != 0);
+		WARN_ON(block != CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 		/*
 		 * We only have a GCR_CL_OTHER per core in systems with
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 8cc508809466..7aac84ffc2af 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -52,7 +52,7 @@ static unsigned core_vpe_count(unsigned core)
 		&& (!IS_ENABLED(CONFIG_CPU_MIPSR6) || !cpu_has_vp))
 		return 1;
 
-	mips_cm_lock_other(core, 0);
+	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 	cfg = read_gcr_co_config() & CM_GCR_Cx_CONFIG_PVPE;
 	mips_cm_unlock_other();
 	return cfg + 1;
@@ -214,7 +214,7 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	unsigned timeout;
 
 	/* Select the appropriate core */
-	mips_cm_lock_other(core, 0);
+	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 	/* Set its reset vector */
 	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
@@ -313,7 +313,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 	}
 
 	if (cpu_has_vp) {
-		mips_cm_lock_other(core, vpe_id);
+		mips_cm_lock_other(0, core, vpe_id, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
 		write_gcr_co_reset_base(core_entry);
 		mips_cm_unlock_other();
@@ -518,7 +518,7 @@ static void cps_cpu_die(unsigned int cpu)
 		 */
 		fail_time = ktime_add_ms(ktime_get(), 2000);
 		do {
-			mips_cm_lock_other(core, 0);
+			mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 			mips_cpc_lock_other(core);
 			stat = read_cpc_co_stat_conf();
 			stat &= CPC_Cx_STAT_CONF_SEQSTATE;
@@ -562,7 +562,7 @@ static void cps_cpu_die(unsigned int cpu)
 			panic("Failed to call remote sibling CPU\n");
 	} else if (cpu_has_vp) {
 		do {
-			mips_cm_lock_other(core, vpe_id);
+			mips_cm_lock_other(0, core, vpe_id, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 			stat = read_cpc_co_vp_running();
 			mips_cm_unlock_other();
 		} while (stat & (1 << vpe_id));
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 4cc43892b959..6248a5a3ec9e 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -190,7 +190,7 @@ void mips_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 			core = cpu_core(&cpu_data[cpu]);
 
 			while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
-				mips_cm_lock_other(core, 0);
+				mips_cm_lock_other_cpu(cpu, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 				mips_cpc_lock_other(core);
 				write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
 				mips_cpc_unlock_other();
-- 
2.14.0
