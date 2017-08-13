Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:55:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20176 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993894AbdHMCxq2KiJ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:53:46 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 45DC366699EDF;
        Sun, 13 Aug 2017 03:53:38 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:53:39 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 12/19] MIPS: Store core & VP IDs in GlobalNumber-style variable
Date:   Sat, 12 Aug 2017 19:49:36 -0700
Message-ID: <20170813024943.14989-13-paul.burton@imgtec.com>
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
X-archive-position: 59508
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

This patch modifies the way we store core & VP IDs such that we store
them in a single 32 bit integer whose format matches that of the MIPSr6
GlobalNumber register. Whereas we have previously stored core & VP IDs
in separate fields, storing them in a single GlobalNumber-like field:

  1) Reduces the size of struct cpuinfo_mips by 4 bytes, and will allow
     it to not grow when cluster support is added.

  2) Gives us a natural place to store cluster number, which matches up
     with what the architecture provides.

  3) Will be useful in the future as a parameter to the MIPSr6 GINVI
     instruction to specify a target CPU whose icache that instruction
     should operate on.

The cpu_set*() accessor functions are moved out of the asm/cpu-info.h
header in order to allow them to use the WARN_ON macro, which is
unusable in asm/cpu-info.h due to include ordering.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cpu-info.h | 39 +++++++++++++--------------------------
 arch/mips/kernel/cpu-probe.c     | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 2b2f97023705..9ae927282b12 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -15,6 +15,8 @@
 #include <linux/cache.h>
 #include <linux/types.h>
 
+#include <asm/mipsregs.h>
+
 /*
  * Descriptor for a cache
  */
@@ -77,16 +79,9 @@ struct cpuinfo_mips {
 	struct cache_desc	tcache; /* Tertiary/split secondary cache */
 	int			srsets; /* Shadow register sets */
 	int			package;/* physical package number */
-	int			core;	/* physical core number */
+	unsigned int		globalnumber;
 #ifdef CONFIG_64BIT
 	int			vmbits; /* Virtual memory size in bits */
-#endif
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-	/*
-	 * There is not necessarily a 1:1 mapping of VPE num to CPU number
-	 * in particular on multi-core systems.
-	 */
-	int			vpe_id;	 /* Virtual Processor number */
 #endif
 	void			*data;	/* Additional data */
 	unsigned int		watch_reg_count;   /* Number that exist */
@@ -146,31 +141,23 @@ struct proc_cpuinfo_notifier_args {
 
 static inline unsigned int cpu_core(struct cpuinfo_mips *cpuinfo)
 {
-	return cpuinfo->core;
-}
-
-static inline void cpu_set_core(struct cpuinfo_mips *cpuinfo,
-				unsigned int core)
-{
-	cpuinfo->core = core;
+	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_CORE) >>
+		MIPS_GLOBALNUMBER_CORE_SHF;
 }
 
 static inline unsigned int cpu_vpe_id(struct cpuinfo_mips *cpuinfo)
 {
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-	return cpuinfo->vpe_id;
-#endif
-	return 0;
-}
+	/* Optimisation for systems where VP(E)s aren't used */
+	if (!IS_ENABLED(CONFIG_MIPS_MT_SMP) && !IS_ENABLED(CONFIG_CPU_MIPSR6))
+		return 0;
 
-static inline void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo,
-				  unsigned int vpe)
-{
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-	cpuinfo->vpe_id = vpe;
-#endif
+	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_VP) >>
+		MIPS_GLOBALNUMBER_VP_SHF;
 }
 
+extern void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core);
+extern void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo, unsigned int vpe);
+
 static inline unsigned long cpu_asid_inc(void)
 {
 	return 1 << CONFIG_MIPS_ASID_SHIFT;
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ed39b8e98bc1..d428e856085c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -2098,3 +2098,25 @@ void cpu_report(void)
 	if (cpu_has_msa)
 		pr_info("MSA revision is: %08x\n", c->msa_id);
 }
+
+void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core)
+{
+	/* Ensure the core number fits in the field */
+	WARN_ON(core > (MIPS_GLOBALNUMBER_CORE >> MIPS_GLOBALNUMBER_CORE_SHF));
+
+	cpuinfo->globalnumber &= ~MIPS_GLOBALNUMBER_CORE;
+	cpuinfo->globalnumber |= core << MIPS_GLOBALNUMBER_CORE_SHF;
+}
+
+void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo, unsigned int vpe)
+{
+	/* Ensure the VP(E) ID fits in the field */
+	WARN_ON(vpe > (MIPS_GLOBALNUMBER_VP >> MIPS_GLOBALNUMBER_VP_SHF));
+
+	/* Ensure we're not using VP(E)s without support */
+	WARN_ON(vpe && !IS_ENABLED(CONFIG_MIPS_MT_SMP) &&
+		!IS_ENABLED(CONFIG_CPU_MIPSR6));
+
+	cpuinfo->globalnumber &= ~MIPS_GLOBALNUMBER_VP;
+	cpuinfo->globalnumber |= vpe << MIPS_GLOBALNUMBER_VP_SHF;
+}
-- 
2.14.0
