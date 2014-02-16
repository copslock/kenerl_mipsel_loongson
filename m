Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2014 09:04:06 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40149 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816642AbaBPIC6FQPX1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Feb 2014 09:02:58 +0100
Received: by mail-pd0-f171.google.com with SMTP id g10so13587136pdj.16
        for <multiple recipients>; Sun, 16 Feb 2014 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eQ4UgofcVPGCcI0qPE8bKh8EtR1JsBvoqrsS6oXfvvE=;
        b=deLL37CCTzVKAUzyNYhHZRc2EBq9MRzrrK/c9+3yH/z8bjAOJORRbPjW0bki/9DeDd
         MqW8mLwZhw2Tv+fVskPOeNINp1H1/4blXVCJWAQT1pH3ADazmZA2Ve/KALiGqPtBkNK2
         RBRU1KwSsBJDTSLP4S90m8OmiC2j0qXd+jVCZV7RHF2WwBCFfhZzwOrxAvP+0KOtrh+P
         4mmBFKASqGULZLttoh2P0+qJqvrdVREPa4Qm+kXr8isvGlC/aXDYh8eF8xbkmL8vNDBe
         ZJL5EkIHi1t6E+DyVt7K1w+CqHJ77N3S0oOac1vpn9ETMNbQUOIOcrPIXih6neO5qm8g
         u6aw==
X-Received: by 10.66.231.104 with SMTP id tf8mr19682775pac.48.1392537771274;
        Sun, 16 Feb 2014 00:02:51 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ei4sm33661111pbb.42.2014.02.16.00.02.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 16 Feb 2014 00:02:50 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V19 03/13] MIPS: Loongson: Add basic Loongson-3 CPU support
Date:   Sun, 16 Feb 2014 16:01:20 +0800
Message-Id: <1392537690-5961-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39314
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
index 61f803b..543420b 100644
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
index 5e92b4d..48650e7 100644
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
index 8fc713f..14987ff 100644
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
@@ -1302,6 +1330,33 @@ static void __init loongson2_sc_init(void)
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
@@ -1354,6 +1409,10 @@ static void setup_scache(void)
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
index ccae9a4..3395493 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -581,6 +581,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BMIPS4380:
 	case CPU_BMIPS5000:
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
-- 
1.7.7.3
