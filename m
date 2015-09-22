Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:45:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32341 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVSo6M13uP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:44:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 78D25DC84D70A;
        Tue, 22 Sep 2015 19:44:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:44:52 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:44:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 5/6] MIPS: tlbex: avoid placing software PTE bits in Entry* PFN fields
Date:   Tue, 22 Sep 2015 11:42:52 -0700
Message-ID: <1442947373-13345-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
References: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49322
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

Commit 748e787eb6de ("MIPS: Optimize TLB refill for RI/XI
configurations.") stopped explicitly clearing the bits used by software
in PTEs by making use of a rotate instruction that rotates them into the
fill bits of the Entry{Lo,Hi} register. This can only work if there are
actually enough fill bits in the register to cover the software
maintained bits, otherwise we end up writing those bits into the upper
bits of the PFN or PFNX field of the Entry{Lo,Hi} register.

Fix this by detecting the number of fill bits present in the
Entry{Lo,Hi} registers & explicitly clearing the software bits where
necessary.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mm/tlbex.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index bc829fc..6b7cc20 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -311,6 +311,7 @@ static struct uasm_label labels[128];
 static struct uasm_reloc relocs[128];
 
 static int check_for_high_segbits;
+static bool fill_includes_sw_bits;
 
 static unsigned int kscratch_used_mask;
 
@@ -630,8 +631,14 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 							unsigned int reg)
 {
-	if (cpu_has_rixi) {
-		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
+	if (cpu_has_rixi && _PAGE_NO_EXEC) {
+		if (fill_includes_sw_bits) {
+			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
+		} else {
+			UASM_i_SRL(p, reg, reg, ilog2(_PAGE_NO_EXEC));
+			UASM_i_ROTR(p, reg, reg,
+				    ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		}
 	} else {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 		uasm_i_dsrl_safe(p, reg, reg, ilog2(_PAGE_GLOBAL));
@@ -2338,6 +2345,41 @@ static void config_xpa_params(void)
 #endif
 }
 
+static void check_pabits(void)
+{
+	unsigned long entry;
+	unsigned pabits, fillbits;
+
+	if (!cpu_has_rixi || !_PAGE_NO_EXEC) {
+		/*
+		 * We'll only be making use of the fact that we can rotate bits
+		 * into the fill if the CPU supports RIXI, so don't bother
+		 * probing this for CPUs which don't.
+		 */
+		return;
+	}
+
+	write_c0_entrylo0(~0ul);
+	back_to_back_c0_hazard();
+	entry = read_c0_entrylo0();
+
+	/* clear all non-PFN bits */
+	entry &= ~((1 << MIPS_ENTRYLO_PFN_SHIFT) - 1);
+	entry &= ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
+
+	/* find a lower bound on PABITS, and upper bound on fill bits */
+	pabits = fls_long(entry) + 6;
+	fillbits = max_t(int, (int)BITS_PER_LONG - pabits, 0);
+
+	/* minus the RI & XI bits */
+	fillbits -= min_t(unsigned, fillbits, 2);
+
+	if (fillbits >= ilog2(_PAGE_NO_EXEC))
+		fill_includes_sw_bits = true;
+
+	pr_debug("Entry* registers contain %u fill bits\n", fillbits);
+}
+
 void build_tlb_refill_handler(void)
 {
 	/*
@@ -2348,6 +2390,7 @@ void build_tlb_refill_handler(void)
 	static int run_once = 0;
 
 	output_pgtable_bits_defines();
+	check_pabits();
 
 #ifdef CONFIG_64BIT
 	check_for_high_segbits = current_cpu_data.vmbits > (PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
-- 
2.5.3
