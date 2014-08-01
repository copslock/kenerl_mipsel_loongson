Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2014 11:23:11 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54952 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816417AbaHAJXGwbwDL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2014 11:23:06 +0200
Received: by mail-pd0-f182.google.com with SMTP id fp1so5202916pdb.41
        for <multiple recipients>; Fri, 01 Aug 2014 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=XFnsE6+ij1LYsN2JUV0CvyR4b3oEg6+/CfQzCYFxOmU=;
        b=JzFidrac4GgI32stsXltGCeLrBgS+WKTkJK227kuOt+Lduom4cMkI1MMg/WqwY/hes
         tjPP0o7NJ4J4s11EvYc+lxFWtieLmxIv76O14ohpDnX0IxA29PCyXmANb4GUVw8JqBlj
         gFb8autrM/s+xje2d6a8Mfi+D6E6p1Di0hiVjX1CnhjNFcaAKW/RPRh8UQTo0Clfl1V3
         CMpPEq1Fngo446VQMX+qRUmtxzDdVt3WKnVk+dJYLiHJieFlSdsvXuT/HcQHnBY09KEt
         SyNTk3LkN/C3SKbsSymY3aGHLb25vurwGGHICJGIa473pf8xcnvyGkD3PzuWgf3IuulJ
         R/Fw==
X-Received: by 10.70.102.102 with SMTP id fn6mr4393262pdb.100.1406884979889;
        Fri, 01 Aug 2014 02:22:59 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id l3sm8050279pbq.8.2014.08.01.02.22.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 02:22:59 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Jayachandran C." <jchandra@broadcom.com>
Subject: [PATCH V4] MIPS: Support CPU topology files in sysfs
Date:   Fri,  1 Aug 2014 17:21:22 +0800
Message-Id: <1406884882-423-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patch is prepared for Loongson's NUMA support, it offer meaningful
sysfs files such as physical_package_id, core_id, core_siblings and
thread_siblings in /sys/devices/system/cpu/cpu?/topology.

V4: Fix macros redefinition problems for Netlogic.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: Jayachandran C. <jchandra@broadcom.com>
---
 arch/mips/include/asm/cpu-info.h |    1 +
 arch/mips/include/asm/smp.h      |    1 +
 arch/mips/include/asm/topology.h |   13 +++++++++++++
 arch/mips/kernel/proc.c          |    1 +
 arch/mips/kernel/smp.c           |   26 +++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 780cff9..d5f42c1 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -61,6 +61,7 @@ struct cpuinfo_mips {
 	struct cache_desc	scache; /* Secondary cache */
 	struct cache_desc	tcache; /* Tertiary/split secondary cache */
 	int			srsets; /* Shadow register sets */
+	int			package;/* physical package number */
 	int			core;	/* physical core number */
 #ifdef CONFIG_64BIT
 	int			vmbits; /* Virtual memory size in bits */
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index b037334..eacf865 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -22,6 +22,7 @@
 
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
+extern cpumask_t cpu_core_map[];
 
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 20ea485..2a0f04b 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -10,4 +10,17 @@
 
 #include <topology.h>
 
+#ifndef topology_physical_package_id
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
+#endif
+#ifndef topology_core_id
+#define topology_core_id(cpu)			(cpu_data[cpu].core)
+#endif
+#ifndef topology_core_cpumask
+#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
+#endif
+#ifndef topology_thread_cpumask
+#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
+#endif
+
 #endif /* __ASM_TOPOLOGY_H */
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 1ed1b5a..097fc8d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -124,6 +124,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
 		      hweight8(cpu_data[n].kscratch_mask));
+	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
 
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 9bad52e..c94c4e9 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -59,9 +59,16 @@ EXPORT_SYMBOL(smp_num_siblings);
 cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_sibling_map);
 
+/* representing the core map of multi-core chips of each logical CPU */
+cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(cpu_core_map);
+
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
+/* representing cpus for which core maps can be computed */
+static cpumask_t cpu_core_setup_map;
+
 cpumask_t cpu_coherent_mask;
 
 static inline void set_cpu_sibling_map(int cpu)
@@ -72,7 +79,8 @@ static inline void set_cpu_sibling_map(int cpu)
 
 	if (smp_num_siblings > 1) {
 		for_each_cpu_mask(i, cpu_sibling_setup_map) {
-			if (cpu_data[cpu].core == cpu_data[i].core) {
+			if (cpu_data[cpu].package == cpu_data[i].package &&
+				    cpu_data[cpu].core == cpu_data[i].core) {
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
 			}
@@ -81,6 +89,20 @@ static inline void set_cpu_sibling_map(int cpu)
 		cpu_set(cpu, cpu_sibling_map[cpu]);
 }
 
+static inline void set_cpu_core_map(int cpu)
+{
+	int i;
+
+	cpu_set(cpu, cpu_core_setup_map);
+
+	for_each_cpu_mask(i, cpu_core_setup_map) {
+		if (cpu_data[cpu].package == cpu_data[i].package) {
+			cpu_set(i, cpu_core_map[cpu]);
+			cpu_set(cpu, cpu_core_map[i]);
+		}
+	}
+}
+
 struct plat_smp_ops *mp_ops;
 EXPORT_SYMBOL(mp_ops);
 
@@ -122,6 +144,7 @@ asmlinkage void start_secondary(void)
 	set_cpu_online(cpu, true);
 
 	set_cpu_sibling_map(cpu);
+	set_cpu_core_map(cpu);
 
 	cpu_set(cpu, cpu_callin_map);
 
@@ -175,6 +198,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	current_thread_info()->cpu = 0;
 	mp_ops->prepare_cpus(max_cpus);
 	set_cpu_sibling_map(0);
+	set_cpu_core_map(0);
 #ifndef CONFIG_HOTPLUG_CPU
 	init_cpu_present(cpu_possible_mask);
 #endif
-- 
1.7.7.3
