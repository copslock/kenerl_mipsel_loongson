Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 01:19:14 +0100 (CET)
Received: from mgate.redback.com ([155.53.3.41]:18405 "EHLO mgate.redback.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492422Ab0BBATK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 01:19:10 +0100
X-IronPort-AV: E=Sophos;i="4.49,386,1262592000"; 
   d="scan'208";a="7753395"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 01 Feb 2010 16:19:07 -0800
Received: from localhost (localhost [127.0.0.1])
        by prattle.redback.com (Postfix) with ESMTP id 2A670E3A68A;
        Mon,  1 Feb 2010 16:19:07 -0800 (PST)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06350-09; Mon,  1 Feb 2010 16:19:07 -0800 (PST)
Received: from localhost (rbos-pc-13.lab.redback.com [10.12.11.133])
        by prattle.redback.com (Postfix) with ESMTP id 18DF5E3A687;
        Mon,  1 Feb 2010 16:19:05 -0800 (PST)
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>
Subject: [PATCH v4] Virtual memory size detection for 64 bit MIPS CPUs
Date:   Mon,  1 Feb 2010 16:02:59 -0800
Message-Id: <1265068979-12052-1-git-send-email-guenter.roeck@ericsson.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <prvs=6426729b5=groeck@redback.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

Linux kernel 2.6.32 and later allocates memory from the top of virtual memory
space.

This patch implements virtual memory size detection for 64 bit MIPS CPUs
to avoid resulting crashes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/include/asm/cpu-info.h     |    1 +
 arch/mips/include/asm/pgtable-64.h   |    4 +++-
 arch/mips/kernel/cpu-probe.c         |   12 ++++++++++++
 4 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1f4df64..284eb55 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -209,6 +209,9 @@
 # ifndef cpu_has_64bit_addresses
 # define cpu_has_64bit_addresses	1
 # endif
+# ifndef cpu_vmbits
+# define cpu_vmbits cpu_data[0].vmbits
+# endif
 #endif
 
 #if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 1260443..3c694bc 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -58,6 +58,7 @@ struct cpuinfo_mips {
 	struct cache_desc	tcache;	/* Tertiary/split secondary cache */
 	int			srsets;	/* Shadow register sets */
 	int			core;	/* physical core number */
+	int			vmbits;	/* Virtual memory size in bits */
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
 	/*
 	 * In the MIPS MT "SMTC" model, each TC is considered
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 9cd5089..259ec58 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -110,7 +110,9 @@
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
 	(VMALLOC_START + \
-	 PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
+	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
+	     (1UL<<cpu_vmbits)) - (1UL << 32))
+
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 7a51866..ac9aca1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -282,6 +282,16 @@ static inline int __cpu_has_fpu(void)
 	return ((cpu_get_fpu_id() & 0xff00) != FPIR_IMP_NONE);
 }
 
+static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
+{
+	if (cpu_has_64bits) {
+		write_c0_entryhi(0xfffffffffffff000ULL);
+		back_to_back_c0_hazard();
+		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
+	} else
+		c->vmbits = 32;
+}
+
 #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
 		| MIPS_CPU_COUNTER)
 
@@ -967,6 +977,8 @@ __cpuinit void cpu_probe(void)
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
 	else
 		c->srsets = 1;
+
+	cpu_set_vmbits(c);
 }
 
 __cpuinit void cpu_report(void)
-- 
1.6.0.4
