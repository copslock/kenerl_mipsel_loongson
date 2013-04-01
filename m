Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Apr 2013 21:16:15 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:18029 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823099Ab3DATQNUERWD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Apr 2013 21:16:13 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH] MIPS: fix ISA level which causes secondary cache init bypassing and more
Date:   Mon, 1 Apr 2013 12:14:28 -0700
Message-ID: <1364843668-17707-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01181__2013_04_01_20_16_07
X-archive-position: 36003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

The commit a96102be70 introduced set_isa() where compatible ISA info is
also set aside from the one gets passed in. It means, for example, 1004K
will have MIPS_CPU_ISA_M32R2/M32R1/II/I flags. This leads to things like
the following inappropriate:

if (c->isa_level == MIPS_CPU_ISA_M32R1 ||
    c->isa_level == MIPS_CPU_ISA_M32R2 ||
    c->isa_level == MIPS_CPU_ISA_M64R1 ||
    c->isa_level == MIPS_CPU_ISA_M64R2)

This patch fixes it.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c |    6 ++----
 arch/mips/kernel/traps.c     |    2 +-
 arch/mips/mm/c-r4k.c         |    6 ++----
 arch/mips/mm/sc-mips.c       |    6 ++----
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d069a19..5fe66a0 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1227,10 +1227,8 @@ __cpuinit void cpu_probe(void)
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
 
-		if (c->isa_level == MIPS_CPU_ISA_M32R1 ||
-		    c->isa_level == MIPS_CPU_ISA_M32R2 ||
-		    c->isa_level == MIPS_CPU_ISA_M64R1 ||
-		    c->isa_level == MIPS_CPU_ISA_M64R2) {
+		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
+				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
 			if (c->fpu_id & MIPS_FPIR_3D)
 				c->ases |= MIPS_ASE_MIPS3D;
 		}
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a200b5b..c3abb88 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1571,7 +1571,7 @@ void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
 #ifdef CONFIG_64BIT
 	status_set |= ST0_FR|ST0_KX|ST0_SX|ST0_UX;
 #endif
-	if (current_cpu_data.isa_level == MIPS_CPU_ISA_IV)
+	if (current_cpu_data.isa_level & MIPS_CPU_ISA_IV)
 		status_set |= ST0_XX;
 	if (cpu_has_dsp)
 		status_set |= ST0_MX;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ecca559..2078915 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1247,10 +1247,8 @@ static void __cpuinit setup_scache(void)
 		return;
 
 	default:
-		if (c->isa_level == MIPS_CPU_ISA_M32R1 ||
-		    c->isa_level == MIPS_CPU_ISA_M32R2 ||
-		    c->isa_level == MIPS_CPU_ISA_M64R1 ||
-		    c->isa_level == MIPS_CPU_ISA_M64R2) {
+		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
+				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
 #ifdef CONFIG_MIPS_CPU_SCACHE
 			if (mips_sc_init ()) {
 				scache_size = c->scache.ways * c->scache.sets * c->scache.linesz;
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 93d937b..df96da7 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -98,10 +98,8 @@ static inline int __init mips_sc_probe(void)
 	c->scache.flags |= MIPS_CACHE_NOT_PRESENT;
 
 	/* Ignore anything but MIPSxx processors */
-	if (c->isa_level != MIPS_CPU_ISA_M32R1 &&
-	    c->isa_level != MIPS_CPU_ISA_M32R2 &&
-	    c->isa_level != MIPS_CPU_ISA_M64R1 &&
-	    c->isa_level != MIPS_CPU_ISA_M64R2)
+	if (!(c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
+			      MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)))
 		return 0;
 
 	/* Does this MIPS32/MIPS64 CPU have a config2 register? */
-- 
1.7.1
