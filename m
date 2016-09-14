Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2016 12:01:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11184 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992240AbcINKB2id1Ad (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2016 12:01:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7CB8F6F2B581F;
        Wed, 14 Sep 2016 11:01:09 +0100 (IST)
Received: from localhost (10.100.200.175) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 14 Sep
 2016 11:01:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/2] MIPS: pm-cps: Generate idle state entry code when CPUs are onlined
Date:   Wed, 14 Sep 2016 11:00:27 +0100
Message-ID: <20160914100027.20945-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160914100027.20945-1-paul.burton@imgtec.com>
References: <20160914100027.20945-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55139
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

The MIPS Coherent Processing System (CPS) power management code has
previously generated code used to enter low power idle states once
during boot for all CPUs. This has the drawback that if a CPU is present
in the system but not being used (for example due to the maxcpus kernel
parameter) then we encounter problems due to not having probed that CPU
for information about its type & properties. The result of this is that
we generate entry code which is both unused, potentially entirely
invalid & likely to be unsuitable for the CPU in question anyway.

Avoid this by generating idle state entry code only when a CPU is
brought online. This way we only ever generate code for CPUs that we
know we've probed the properties of, and that will actually be used.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/kernel/pm-cps.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 5b31a94..522a466 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -8,6 +8,7 @@
  * option) any later version.
  */
 
+#include <linux/cpuhotplug.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
@@ -70,8 +71,8 @@ static DEFINE_PER_CPU_ALIGNED(atomic_t, pm_barrier);
 DEFINE_PER_CPU_ALIGNED(struct mips_static_suspend_state, cps_cpu_state);
 
 /* A somewhat arbitrary number of labels & relocs for uasm */
-static struct uasm_label labels[32] __initdata;
-static struct uasm_reloc relocs[32] __initdata;
+static struct uasm_label labels[32];
+static struct uasm_reloc relocs[32];
 
 /* CPU dependant sync types */
 static unsigned stype_intervention;
@@ -198,10 +199,10 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	return 0;
 }
 
-static void __init cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
-					 struct uasm_reloc **pr,
-					 const struct cache_desc *cache,
-					 unsigned op, int lbl)
+static void cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
+				  struct uasm_reloc **pr,
+				  const struct cache_desc *cache,
+				  unsigned op, int lbl)
 {
 	unsigned cache_size = cache->ways << cache->waybit;
 	unsigned i;
@@ -242,10 +243,10 @@ static void __init cps_gen_cache_routine(u32 **pp, struct uasm_label **pl,
 	uasm_i_nop(pp);
 }
 
-static int __init cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
-				    struct uasm_reloc **pr,
-				    const struct cpuinfo_mips *cpu_info,
-				    int lbl)
+static int cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
+			     struct uasm_reloc **pr,
+			     const struct cpuinfo_mips *cpu_info,
+			     int lbl)
 {
 	unsigned i, fsb_size = 8;
 	unsigned num_loads = (fsb_size * 3) / 2;
@@ -340,9 +341,9 @@ static int __init cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 	return 0;
 }
 
-static void __init cps_gen_set_top_bit(u32 **pp, struct uasm_label **pl,
-				       struct uasm_reloc **pr,
-				       unsigned r_addr, int lbl)
+static void cps_gen_set_top_bit(u32 **pp, struct uasm_label **pl,
+				struct uasm_reloc **pr,
+				unsigned r_addr, int lbl)
 {
 	uasm_i_lui(pp, t0, uasm_rel_hi(0x80000000));
 	uasm_build_label(pl, *pp, lbl);
@@ -353,7 +354,7 @@ static void __init cps_gen_set_top_bit(u32 **pp, struct uasm_label **pl,
 	uasm_i_nop(pp);
 }
 
-static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
+static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 {
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
@@ -628,7 +629,7 @@ out_err:
 	return NULL;
 }
 
-static int __init cps_gen_core_entries(unsigned cpu)
+static int cps_pm_online_cpu(unsigned int cpu)
 {
 	enum cps_pm_state state;
 	unsigned core = cpu_data[cpu].core;
@@ -670,9 +671,6 @@ static int __init cps_gen_core_entries(unsigned cpu)
 
 static int __init cps_pm_init(void)
 {
-	unsigned cpu;
-	int err;
-
 	/* Detect appropriate sync types for the system */
 	switch (current_cpu_data.cputype) {
 	case CPU_INTERAPTIV:
@@ -692,7 +690,7 @@ static int __init cps_pm_init(void)
 	/* A CM is required for all non-coherent states */
 	if (!mips_cm_present()) {
 		pr_warn("pm-cps: no CM, non-coherent states unavailable\n");
-		goto out;
+		return 0;
 	}
 
 	/*
@@ -722,12 +720,7 @@ static int __init cps_pm_init(void)
 		pr_warn("pm-cps: no CPC, clock & power gating unavailable\n");
 	}
 
-	for_each_present_cpu(cpu) {
-		err = cps_gen_core_entries(cpu);
-		if (err)
-			return err;
-	}
-out:
-	return 0;
+	return cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "AP_PM_CPS_CPU_ONLINE",
+				 cps_pm_online_cpu, NULL);
 }
 arch_initcall(cps_pm_init);
-- 
2.9.3
