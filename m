Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 22:29:08 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:56494 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903407Ab2IEU2O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 22:28:14 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1T9MCm-0004QI-0x; Wed, 05 Sep 2012 15:28:08 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 2/4] MIPS: Remove kernel_uses_smartmips_rixi use from arch/mips/mm.
Date:   Wed,  5 Sep 2012 15:27:56 -0500
Message-Id: <1346876878-25965-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346876878-25965-1-git-send-email-sjhill@mips.com>
References: <1346876878-25965-1-git-send-email-sjhill@mips.com>
X-archive-position: 34420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Remove usage of the 'kernel_uses_smartmips_rixi' macro from all files
in the 'arch/mips/mm' subsystem.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/cache.c   |    2 +-
 arch/mips/mm/fault.c   |    4 +++-
 arch/mips/mm/tlb-r4k.c |    7 +++++--
 arch/mips/mm/tlbex.c   |   14 +++++++-------
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index ff910a1..b478c51 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -183,7 +183,7 @@ EXPORT_SYMBOL(_page_cachable_default);
 
 static inline void setup_protection_map(void)
 {
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		protection_map[0]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
 		protection_map[1]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC);
 		protection_map[2]  = __pgprot(_page_cachable_default | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index c14f6df..153aeee 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -114,7 +114,7 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (kernel_uses_smartmips_rixi) {
+		if (cpu_has_xi) {
 			if (address == regs->cp0_epc && !(vma->vm_flags & VM_EXEC)) {
 #if 0
 				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] XI violation\n",
@@ -125,6 +125,8 @@ good_area:
 #endif
 				goto bad_area;
 			}
+		}
+		else if (cpu_has_ri) {
 			if (!(vma->vm_flags & VM_READ)) {
 #if 0
 				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n",
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d2572cb..df894f8 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -401,12 +401,15 @@ void __cpuinit tlb_init(void)
 	    current_cpu_type() == CPU_R14000)
 		write_c0_framemask(0);
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
+		u32 pg;
+
 		/*
 		 * Enable the no read, no exec bits, and enable large virtual
 		 * address.
 		 */
-		u32 pg = PG_RIE | PG_XIE;
+		pg = (cpu_has_ri ? PG_RIE : 0);
+		pg |= (cpu_has_xi ? PG_XIE : 0);
 #ifdef CONFIG_64BIT
 		pg |= PG_ELPA;
 #endif
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e565d45..90c86ee 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -601,7 +601,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 								  unsigned int reg)
 {
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		UASM_i_SRL(p, reg, reg, ilog2(_PAGE_NO_EXEC));
 		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
 	} else {
@@ -1021,7 +1021,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	if (cpu_has_64bits) {
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
-		if (kernel_uses_smartmips_rixi) {
+		if (cpu_has_ri | cpu_has_xi) {
 			UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
 			UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
 			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
@@ -1048,7 +1048,7 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 	UASM_i_LW(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
 		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
 		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
@@ -1214,7 +1214,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		UASM_i_LW(p, even, 0, ptr); /* get even pte */
 		UASM_i_LW(p, odd, sizeof(pte_t), ptr); /* get odd pte */
 	}
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_NO_EXEC));
 		uasm_i_dsrl_safe(p, odd, odd, ilog2(_PAGE_NO_EXEC));
 		uasm_i_drotr(p, even, even,
@@ -1576,7 +1576,7 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 {
 	int t = scratch >= 0 ? scratch : pte;
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		if (use_bbit_insns()) {
 			uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
 			uasm_i_nop(p);
@@ -1906,7 +1906,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
@@ -1960,7 +1960,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
 
-	if (kernel_uses_smartmips_rixi) {
+	if (cpu_has_ri | cpu_has_xi) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
-- 
1.7.9.5
