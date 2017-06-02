Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:40:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22220 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993957AbdFBWkLMJDU3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:40:11 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id 1E87F13E72AEF;
        Fri,  2 Jun 2017 23:40:00 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:40:04
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 5/6] MIPS: tlbex: Use ErrorEPC as scratch when KScratch isn't available
Date:   Fri, 2 Jun 2017 15:38:05 -0700
Message-ID: <20170602223806.5078-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602223806.5078-1-paul.burton@imgtec.com>
References: <20170602223806.5078-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58169
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

The TLB exception handlers currently attempt to use a KScratch register
if one is available, and otherwise fall back to calculating a
CPU-specific pointer to a memory area & saving 2 register values into
it. This has a few downsides:

  - Performing stores, and later loads, is relatively slow.

  - Keeping the pointer to the save area around means k1 is unavailable
    for use in the body of the exception handler, resulting in the need
    to save & restore $2 as well as $1.

  - The need to use different sets of work registers adds a layer of
    abstraction (struct work_registers) to the code that we would
    otherwise not need.

This patch changes this such that when KScratch registers aren't
implemented we use the coprocessor 0 ErrorEPC register as scratch
instead. The only downside to this is that we will need to ensure that
TLB exceptions don't occur whilst handling error exceptions, or at least
before the handlers for such exceptions have read the ErrorEPC register.
As the kernel always runs unmapped, or using a wired TLB entry for
certain SGI ip27 configurations, this constraint is currently always
satisfied. In the future should the kernel become mapped we will need to
cover exception handling code with a wired entry anyway such that TLB
exception handlers don't themselves trigger TLB exceptions, so the
constraint should be satisfied there too.

If we were ever to handle cache exceptions in a way that allowed us to
continue running (in contrast to our current approach of die()ing) then
it would be possible for a cache exception to be processed during the
handling of a TLB exception which we then return to. If done naively
this would be bad, but problems could be avoided if the cache exception
handler took into account that we were running a TLB exception handler &
returned to the code at EPC or the start of the TLB exception handler
instead of the address in ErrorEPC, causing the TLB exception handler to
re-run & avoiding it seeing a clobbered ErrorEPC value.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/tlbex.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 5aadc69c8ce3..22e0281e81cc 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -63,13 +63,6 @@ struct work_registers {
 	int r3;
 };
 
-struct tlb_reg_save {
-	unsigned long a;
-	unsigned long b;
-} ____cacheline_aligned_in_smp;
-
-static struct tlb_reg_save handler_reg_save[NR_CPUS];
-
 static inline int r45k_bvahwbug(void)
 {
 	/* XXX: We should probe for the presence of this bug, but we don't. */
@@ -290,6 +283,7 @@ static inline void dump_handler(const char *symbol, const u32 *handler, int coun
 #define C0_ENTRYHI	10, 0
 #define C0_EPC		14, 0
 #define C0_XCONTEXT	20, 0
+#define C0_ERROREPC	30, 0
 
 #ifdef CONFIG_64BIT
 # define GET_CONTEXT(buf, reg) UASM_i_MFC0(buf, reg, C0_XCONTEXT)
@@ -353,47 +347,25 @@ static struct work_registers build_get_work_registers(u32 **p)
 {
 	struct work_registers r;
 
-	if (scratch_reg >= 0) {
-		/* Save in CPU local C0_KScratch? */
+	/* Save in CPU local C0_KScratch? */
+	if (scratch_reg >= 0)
 		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
-		r.r1 = K0;
-		r.r2 = K1;
-		r.r3 = 1;
-		return r;
-	}
-
-	if (num_possible_cpus() > 1) {
-		/* Get smp_processor_id */
-		UASM_i_CPUID_MFC0(p, K0, SMP_CPUID_REG);
-		UASM_i_SRL_SAFE(p, K0, K0, SMP_CPUID_REGSHIFT);
+	else
+		UASM_i_MTC0(p, 1, C0_ERROREPC);
 
-		/* handler_reg_save index in K0 */
-		UASM_i_SLL(p, K0, K0, ilog2(sizeof(struct tlb_reg_save)));
+	r.r1 = K0;
+	r.r2 = K1;
+	r.r3 = 1;
 
-		UASM_i_LA(p, K1, (long)&handler_reg_save);
-		UASM_i_ADDU(p, K0, K0, K1);
-	} else {
-		UASM_i_LA(p, K0, (long)&handler_reg_save);
-	}
-	/* K0 now points to save area, save $1 and $2  */
-	UASM_i_SW(p, 1, offsetof(struct tlb_reg_save, a), K0);
-	UASM_i_SW(p, 2, offsetof(struct tlb_reg_save, b), K0);
-
-	r.r1 = K1;
-	r.r2 = 1;
-	r.r3 = 2;
 	return r;
 }
 
 static void build_restore_work_registers(u32 **p)
 {
-	if (scratch_reg >= 0) {
+	if (scratch_reg >= 0)
 		UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
-		return;
-	}
-	/* K0 already points to save area, restore $1 and $2  */
-	UASM_i_LW(p, 1, offsetof(struct tlb_reg_save, a), K0);
-	UASM_i_LW(p, 2, offsetof(struct tlb_reg_save, b), K0);
+	else
+		UASM_i_MFC0(p, 1, C0_ERROREPC);
 }
 
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
-- 
2.13.0
