Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 11:45:37 +0100 (CET)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60660 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826888AbaCUKpOigbwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2014 11:45:14 +0100
Received: by mail-pb0-f48.google.com with SMTP id md12so2231431pbc.21
        for <multiple recipients>; Fri, 21 Mar 2014 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PG4FS9JEV4LwLJi05zp7T+KrNs+teXKr42RZAxDhGZ0=;
        b=SLmYgYwvbAHTyZeFVjvGy16zIp/NUNpyO3JKE1t452c47vuGp5AmyuthXxAsIDlN+h
         fn+OOFR25qH4scvVv2VH4H94GBdq007sRE/yxUG6NNMcRpHo9jCLWbRfxxDtY7yso5Eq
         AEtCJ0zuP8YgEL+dWvzc5seT6aCmlp8dxep8OU3HWm9p6//CPccC8Ino+JXQgnlSWJTO
         NjsLLS6DJhDviaclGu2Ab4d6Lt8GESx/HmwaL/Jvp0qy4sgWn7FUm4qpIxKW15dz8gU4
         pmfvn7KBBfn0f1GPr5BS26sytOmhAmzH88vDYLq184qNfwCkFE4ZxSWKYps5zfa6QScw
         NpYg==
X-Received: by 10.67.2.34 with SMTP id bl2mr52891037pad.58.1395398708357;
        Fri, 21 Mar 2014 03:45:08 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ac5sm9144592pbc.37.2014.03.21.03.44.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 03:45:07 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V20 02/12] MIPS: Loongson: Add basic Loongson-3 CPU support
Date:   Fri, 21 Mar 2014 18:44:00 +0800
Message-Id: <1395398650-19292-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
References: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39527
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

Basic Loongson-3 CPU support include CPU probing and TLB/cache
initializing.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/include/asm/cpu-type.h |    4 ++
 arch/mips/kernel/cpu-probe.c     |   12 ++++++--
 arch/mips/mm/c-r4k.c             |   59 ++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/tlb-r4k.c           |    5 ++-
 arch/mips/mm/tlbex.c             |    1 +
 5 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 760c9cf..72190613 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -20,6 +20,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON2:
 #endif
 
+#ifdef CONFIG_SYS_HAS_CPU_LOONGSON3
+	case CPU_LOONGSON3:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
 	case CPU_LOONGSON1:
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 34df5af..bd712c9 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -735,16 +735,22 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 64;
 		break;
 	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
-		c->cputype = CPU_LOONGSON2;
-		__cpu_name[cpu] = "ICT Loongson-2";
-
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON2E:
+			c->cputype = CPU_LOONGSON2;
+			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2e");
 			break;
 		case PRID_REV_LOONGSON2F:
+			c->cputype = CPU_LOONGSON2;
+			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2f");
 			break;
+		case PRID_REV_LOONGSON3A:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "ICT Loongson-3";
+			set_elf_platform(cpu, "loongson3a");
+			break;
 		}
 
 		set_isa(c, MIPS_CPU_ISA_III);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3e53f1b..1c74a6a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -398,6 +398,7 @@ static inline void local_r4k___flush_cache_all(void * args)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -1066,6 +1067,33 @@ static void probe_pcache(void)
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_LOONGSON3:
+		config1 = read_c0_config1();
+		lsize = (config1 >> 19) & 7;
+		if (lsize)
+			c->icache.linesz = 2 << lsize;
+		else
+			c->icache.linesz = 0;
+		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.ways = 1 + ((config1 >> 16) & 7);
+		icache_size = c->icache.sets *
+					  c->icache.ways *
+					  c->icache.linesz;
+		c->icache.waybit = 0;
+
+		lsize = (config1 >> 10) & 7;
+		if (lsize)
+			c->dcache.linesz = 2 << lsize;
+		else
+			c->dcache.linesz = 0;
+		c->dcache.sets = 64 << ((config1 >> 13) & 7);
+		c->dcache.ways = 1 + ((config1 >> 7) & 7);
+		dcache_size = c->dcache.sets *
+					  c->dcache.ways *
+					  c->dcache.linesz;
+		c->dcache.waybit = 0;
+		break;
+
 	default:
 		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
@@ -1303,6 +1331,33 @@ static void __init loongson2_sc_init(void)
 	c->options |= MIPS_CPU_INCLUSIVE_CACHES;
 }
 
+static void __init loongson3_sc_init(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int config2, lsize;
+
+	config2 = read_c0_config2();
+	lsize = (config2 >> 4) & 15;
+	if (lsize)
+		c->scache.linesz = 2 << lsize;
+	else
+		c->scache.linesz = 0;
+	c->scache.sets = 64 << ((config2 >> 8) & 15);
+	c->scache.ways = 1 + (config2 & 15);
+
+	scache_size = c->scache.sets *
+				  c->scache.ways *
+				  c->scache.linesz;
+	/* Loongson-3 has 4 cores, 1MB scache for each. scaches are shared */
+	scache_size *= 4;
+	c->scache.waybit = 0;
+	pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
+	       scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
+	if (scache_size)
+		c->options |= MIPS_CPU_INCLUSIVE_CACHES;
+	return;
+}
+
 extern int r5k_sc_init(void);
 extern int rm7k_sc_init(void);
 extern int mips_sc_init(void);
@@ -1355,6 +1410,10 @@ static void setup_scache(void)
 		loongson2_sc_init();
 		return;
 
+	case CPU_LOONGSON3:
+		loongson3_sc_init();
+		return;
+
 	case CPU_XLP:
 		/* don't need to worry about L2, fully coherent */
 		return;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index ae4ca24..eeaf50f 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -48,13 +48,14 @@ extern void build_tlb_refill_handler(void);
 #endif /* CONFIG_MIPS_MT_SMTC */
 
 /*
- * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
- * unfortrunately, itlb is not totally transparent to software.
+ * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
+ * unfortunately, itlb is not totally transparent to software.
  */
 static inline void flush_itlb(void)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 		write_c0_diag(4);
 		break;
 	default:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6e5c9fd..ee88367 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -582,6 +582,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BMIPS4380:
 	case CPU_BMIPS5000:
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
-- 
1.7.7.3
