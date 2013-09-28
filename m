Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 08:42:33 +0200 (CEST)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:46194 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288Ab3I1GltswUiu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 08:41:49 +0200
Received: by mail-pb0-f43.google.com with SMTP id md4so3426660pbc.2
        for <multiple recipients>; Fri, 27 Sep 2013 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ytcZEjz8kpL1Lcj330JOzJNU7hDQPZ4Uue+O5mpjmtI=;
        b=c6MRLe0os0D00oGH7AnyVBvgu2gf4qpq0NAb2SoFJ3i58zcoCu7ETv8zkcM1WFDXdR
         KlSXEoDUGpFHc75G/C8fTjAeUd4v5rWvV2uy7k6dTVzOklYEHunSrvcu+VPpGLxgzH5/
         mwNivV5d3lOn6bsz5wpr+OweNoVo1MVkjUla+d6PVHKukfTkjdQh2pAyF7H6uzqLbEmv
         BRHq5mNxHmKD5kl2fykcVL56weWvPK+By2hVNab4IjNSEKoNG4T33kZ2Ru8nDoTqeZD1
         s4g1FV1ptcBYdb6twhXqQ1hjVWcHLdhRdC7xs1zUht0lyheJxuQ3Gv88w+oI2ww38b8n
         7ghQ==
X-Received: by 10.68.169.161 with SMTP id af1mr11771675pbc.22.1380350503519;
        Fri, 27 Sep 2013 23:41:43 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id oj6sm17406031pab.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 23:41:42 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V13 02/12] MIPS: Loongson: Add basic Loongson-3 CPU support
Date:   Sat, 28 Sep 2013 14:41:01 +0800
Message-Id: <1380350471-1015-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1380350471-1015-1-git-send-email-chenhc@lemote.com>
References: <1380350471-1015-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38036
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
---
 arch/mips/include/asm/cpu-type.h |    4 +++
 arch/mips/kernel/cpu-probe.c     |   14 +++++++---
 arch/mips/mm/c-r4k.c             |   56 ++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/tlb-r4k.c           |    3 +-
 arch/mips/mm/tlbex.c             |    1 +
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 4a402cc..a591e63 100644
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
index 040b83d..2e7ae38 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -639,17 +639,23 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
-	case PRID_IMP_LOONGSON2:
-		c->cputype = CPU_LOONGSON2;
-		__cpu_name[cpu] = "ICT Loongson-2";
-
+	case PRID_IMP_LOONGSON2: /* Loongson-2/3 have the same PRID_IMP field */
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON2E:
+			c->cputype = CPU_LOONGSON2;
+			__cpu_name[cpu] = "ICT Loongson-2E";
 			set_elf_platform(cpu, "loongson2e");
 			break;
 		case PRID_REV_LOONGSON2F:
+			c->cputype = CPU_LOONGSON2;
+			__cpu_name[cpu] = "ICT Loongson-2F";
 			set_elf_platform(cpu, "loongson2f");
 			break;
+		case PRID_REV_LOONGSON3A:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "ICT Loongson-3A";
+			set_elf_platform(cpu, "loongson3a");
+			break;
 		}
 
 		set_isa(c, MIPS_CPU_ISA_III);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1129a89..305c17b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -348,6 +348,7 @@ static inline void local_r4k___flush_cache_all(void * args)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -992,6 +993,31 @@ static void probe_pcache(void)
 		c->dcache.waybit = 0;
 		break;
 
+	case CPU_LOONGSON3:
+		config1 = read_c0_config1();
+		if ((lsize = ((config1 >> 19) & 7)))
+			c->icache.linesz = 2 << lsize;
+		else
+			c->icache.linesz = lsize;
+		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.ways = 1 + ((config1 >> 16) & 7);
+		icache_size = c->icache.sets *
+					  c->icache.ways *
+					  c->icache.linesz;
+		c->icache.waybit = 0;
+
+		if ((lsize = ((config1 >> 10) & 7)))
+			c->dcache.linesz = 2 << lsize;
+		else
+			c->dcache.linesz = lsize;
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
@@ -1211,6 +1237,32 @@ static void __init loongson2_sc_init(void)
 	c->options |= MIPS_CPU_INCLUSIVE_CACHES;
 }
 
+static void __init loongson3_sc_init(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int config2, lsize;
+
+	config2 = read_c0_config2();
+	if ((lsize = ((config2 >> 4) & 15)))
+		c->scache.linesz = 2 << lsize;
+	else
+		c->scache.linesz = lsize;
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
@@ -1263,6 +1315,10 @@ static void setup_scache(void)
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
index da3b0b9..10ab29e 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -53,13 +53,14 @@ extern void build_tlb_refill_handler(void);
 #endif /* CONFIG_MIPS_MT_SMTC */
 
 /*
- * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
+ * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
  * unfortrunately, itlb is not totally transparent to software.
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
index fffa7fe..cc03dbf 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -579,6 +579,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BMIPS4380:
 	case CPU_BMIPS5000:
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
-- 
1.7.7.3
