Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 09:34:19 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58713 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817545Ab2KLIdyNDnsh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2012 09:33:54 +0100
Received: by mail-pb0-f49.google.com with SMTP id un15so913511pbc.36
        for <multiple recipients>; Mon, 12 Nov 2012 00:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qFNmRfdMoy8CBq3Nl3co7MyrO1spTYTa2Jm+AXlNld8=;
        b=01fWoMLvfV8AtqzDDFKzyI5bKx/Yti7GaKi8QtlPfoEUnWS5EjcVReOnnT8Ho5IkaW
         vtdW4dxZiTj5F5apTAQ3i89m1pCSiNO4iBXOgD5qad95IGTaMsU+G4fU3UZHbMY8SgLf
         XUvStwm+ZInPaCxWVh34jkNTkjY9CLTkdCK5N5NEPYSXpkJ/PYdwSZkcmGWWMeaHNYuK
         /B6Kv5zvA0Y0SqR0KIc8TkrNXgEDRgZTsw8duOlWIhpHjl7zPGFEXKRhcMtDT16RhruD
         IDnMzEo5ISXoVrzZf0JMidGHVv6CwbYrb8X3bY5aCzhDNDLSB6rBNPNrYBYL7e2wK4qo
         RzkQ==
Received: by 10.68.197.101 with SMTP id it5mr56494145pbc.91.1352709233009;
        Mon, 12 Nov 2012 00:33:53 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id k4sm3967393pax.7.2012.11.12.00.33.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 00:33:52 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V8 02/13] MIPS: Loongson: Add basic Loongson-3 CPU support
Date:   Mon, 12 Nov 2012 16:32:38 +0800
Message-Id: <1352709169-3481-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
References: <1352709169-3481-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34954
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Basic Loongson-3 CPU support include CPU probing and TLB/cache
initializing.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/kernel/cpu-probe.c |   14 +++++++---
 arch/mips/mm/c-r4k.c         |   62 +++++++++++++++++++++++++++++++++++++++++-
 arch/mips/mm/tlb-r4k.c       |    2 +-
 arch/mips/mm/tlbex.c         |    1 +
 4 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cce3782..ee45efd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -773,17 +773,23 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
 
 		c->isa_level = MIPS_CPU_ISA_III;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2b61462..d52ffe4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -971,6 +971,31 @@ static void __cpuinit probe_pcache(void)
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
@@ -1191,6 +1216,34 @@ static void __init loongson2_sc_init(void)
 }
 #endif
 
+#if defined(CONFIG_CPU_LOONGSON3)
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
+#endif
+
 extern int r5k_sc_init(void);
 extern int rm7k_sc_init(void);
 extern int mips_sc_init(void);
@@ -1240,11 +1293,18 @@ static void __cpuinit setup_scache(void)
 #endif
 		return;
 
-#if defined(CONFIG_CPU_LOONGSON2)
 	case CPU_LOONGSON2:
+#if defined(CONFIG_CPU_LOONGSON2)
 		loongson2_sc_init();
+#endif
 		return;
+
+	case CPU_LOONGSON3:
+#if defined(CONFIG_CPU_LOONGSON3)
+		loongson3_sc_init();
 #endif
+		return;
+
 	case CPU_XLP:
 		/* don't need to worry about L2, fully coherent */
 		return;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 4b9b935..6d11c6b 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -50,7 +50,7 @@ extern void build_tlb_refill_handler(void);
 
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-#if defined(CONFIG_CPU_LOONGSON2)
+#if defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_LOONGSON3)
 /*
  * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
  * unfortrunately, itlb is not totally transparent to software.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 2833dcb..2cb4eb6 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -550,6 +550,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BMIPS4380:
 	case CPU_BMIPS5000:
 	case CPU_LOONGSON2:
+	case CPU_LOONGSON3:
 	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
-- 
1.7.7.3
