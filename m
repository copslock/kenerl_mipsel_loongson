Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 17:41:30 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2506 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835173Ab3FKPkdHG4AN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 17:40:33 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 11 Jun 2013 08:36:33 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 11 Jun 2013 08:40:12 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 11 Jun 2013 08:40:12 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 13989F2D81; Tue, 11
 Jun 2013 08:40:09 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/4] MIPS: Allow platform specific scratch registers
Date:   Tue, 11 Jun 2013 21:11:35 +0530
Message-ID: <1370965298-29210-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370965298-29210-1-git-send-email-jchandra@broadcom.com>
References: <1370965298-29210-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DA99B8B31W34760061-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

XLR/XLP COP0 scratch is register 22, sel 0-7. Add a function
c0_kscratch() which returns the scratch register for the platform,
and use the return value while generating TLB handlers.

Setup kscratch_mask to 0xf for XLR/XLP since the config4 register
does not exist. This allows the kernel to allocate scratch registers
0-3 if needed.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/kernel/cpu-probe.c |    1 +
 arch/mips/mm/tlbex.c         |   41 ++++++++++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c6568bf..265c97d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -959,6 +959,7 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 		set_isa(c, MIPS_CPU_ISA_M64R1);
 		c->tlbsize = ((read_c0_config1() >> 25) & 0x3f) + 1;
 	}
+	c->kscratch_mask = 0xf;
 }
 
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ce9818e..b2eaa1c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -309,6 +309,17 @@ static int check_for_high_segbits __cpuinitdata;
 
 static unsigned int kscratch_used_mask __cpuinitdata;
 
+static inline int __maybe_unused c0_kscratch(void)
+{
+	switch (current_cpu_type()) {
+	case CPU_XLP:
+	case CPU_XLR:
+		return 22;
+	default:
+		return 31;
+	}
+}
+
 static int __cpuinit allocate_kscratch(void)
 {
 	int r;
@@ -340,7 +351,7 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
 
 	if (scratch_reg > 0) {
 		/* Save in CPU local C0_KScratch? */
-		UASM_i_MTC0(p, 1, 31, scratch_reg);
+		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
 		r.r1 = K0;
 		r.r2 = K1;
 		r.r3 = 1;
@@ -389,7 +400,7 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
 static void __cpuinit build_restore_work_registers(u32 **p)
 {
 	if (scratch_reg > 0) {
-		UASM_i_MFC0(p, 1, 31, scratch_reg);
+		UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 		return;
 	}
 	/* K0 already points to save area, restore $1 and $2  */
@@ -678,7 +689,7 @@ static __cpuinit void build_restore_pagemask(u32 **p,
 			uasm_il_b(p, r, lid);
 		}
 		if (scratch_reg > 0)
-			UASM_i_MFC0(p, 1, 31, scratch_reg);
+			UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 		else
 			UASM_i_LW(p, 1, scratchpad_offset(0), 0);
 	} else {
@@ -821,7 +832,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg != -1) {
 		/* pgd is in pgd_reg */
-		UASM_i_MFC0(p, ptr, 31, pgd_reg);
+		UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 	} else {
 		/*
 		 * &pgd << 11 stored in CONTEXT [23..63].
@@ -934,7 +945,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 		if (mode == refill_scratch) {
 			if (scratch_reg > 0)
-				UASM_i_MFC0(p, 1, 31, scratch_reg);
+				UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 			else
 				UASM_i_LW(p, 1, scratchpad_offset(0), 0);
 		} else {
@@ -1100,7 +1111,7 @@ struct mips_huge_tlb_info {
 static struct mips_huge_tlb_info __cpuinit
 build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 			       struct uasm_reloc **r, unsigned int tmp,
-			       unsigned int ptr, int c0_scratch)
+			       unsigned int ptr, int c0_scratch_reg)
 {
 	struct mips_huge_tlb_info rv;
 	unsigned int even, odd;
@@ -1114,12 +1125,12 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		UASM_i_MFC0(p, tmp, C0_BADVADDR);
 
 		if (pgd_reg != -1)
-			UASM_i_MFC0(p, ptr, 31, pgd_reg);
+			UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 		else
 			UASM_i_MFC0(p, ptr, C0_CONTEXT);
 
-		if (c0_scratch >= 0)
-			UASM_i_MTC0(p, scratch, 31, c0_scratch);
+		if (c0_scratch_reg >= 0)
+			UASM_i_MTC0(p, scratch, c0_kscratch(), c0_scratch_reg);
 		else
 			UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
 
@@ -1134,14 +1145,14 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		}
 	} else {
 		if (pgd_reg != -1)
-			UASM_i_MFC0(p, ptr, 31, pgd_reg);
+			UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 		else
 			UASM_i_MFC0(p, ptr, C0_CONTEXT);
 
 		UASM_i_MFC0(p, tmp, C0_BADVADDR);
 
-		if (c0_scratch >= 0)
-			UASM_i_MTC0(p, scratch, 31, c0_scratch);
+		if (c0_scratch_reg >= 0)
+			UASM_i_MTC0(p, scratch, c0_kscratch(), c0_scratch_reg);
 		else
 			UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
 
@@ -1246,8 +1257,8 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 	}
 	UASM_i_MTC0(p, odd, C0_ENTRYLO1); /* load it */
 
-	if (c0_scratch >= 0) {
-		UASM_i_MFC0(p, scratch, 31, c0_scratch);
+	if (c0_scratch_reg >= 0) {
+		UASM_i_MFC0(p, scratch, c0_kscratch(), c0_scratch_reg);
 		build_tlb_write_entry(p, l, r, tlb_random);
 		uasm_l_leave(l, *p);
 		rv.restore_scratch = 1;
@@ -1494,7 +1505,7 @@ static void __cpuinit build_r4000_setup_pgd(void)
 	} else {
 		/* PGD in c0_KScratch */
 		uasm_i_jr(&p, 31);
-		UASM_i_MTC0(&p, a0, 31, pgd_reg);
+		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
 	}
 	if (p - tlbmiss_handler_setup_pgd_array > ARRAY_SIZE(tlbmiss_handler_setup_pgd_array))
 		panic("tlbmiss_handler_setup_pgd_array space exceeded");
-- 
1.7.9.5
