Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 17:40:37 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2655 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835167Ab3FKPk3IiIi0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 17:40:29 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 11 Jun 2013 08:31:12 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 11 Jun 2013 08:40:12 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 11 Jun 2013 08:40:12 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id A9E90F2D78; Tue, 11
 Jun 2013 08:40:11 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/4] MIPS: Fixup check for invalid scratch register
Date:   Tue, 11 Jun 2013 21:11:36 +0530
Message-ID: <1370965298-29210-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370965298-29210-1-git-send-email-jchandra@broadcom.com>
References: <1370965298-29210-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DA99D4A2L831448135-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36831
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

The invalid value for scratch register is -1, so update the checks of
the form (scratch_reg > 0) to be (scratch_reg >= 0).  This will fix
the case in Netlogic XLP where the scratch_reg can be 0.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/mm/tlbex.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b2eaa1c..4a6817c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -349,7 +349,7 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
 	int smp_processor_id_sel;
 	int smp_processor_id_shift;
 
-	if (scratch_reg > 0) {
+	if (scratch_reg >= 0) {
 		/* Save in CPU local C0_KScratch? */
 		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
 		r.r1 = K0;
@@ -399,7 +399,7 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
 
 static void __cpuinit build_restore_work_registers(u32 **p)
 {
-	if (scratch_reg > 0) {
+	if (scratch_reg >= 0) {
 		UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 		return;
 	}
@@ -688,7 +688,7 @@ static __cpuinit void build_restore_pagemask(u32 **p,
 			uasm_i_mtc0(p, 0, C0_PAGEMASK);
 			uasm_il_b(p, r, lid);
 		}
-		if (scratch_reg > 0)
+		if (scratch_reg >= 0)
 			UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 		else
 			UASM_i_LW(p, 1, scratchpad_offset(0), 0);
@@ -944,7 +944,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		uasm_i_jr(p, ptr);
 
 		if (mode == refill_scratch) {
-			if (scratch_reg > 0)
+			if (scratch_reg >= 0)
 				UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
 			else
 				UASM_i_LW(p, 1, scratchpad_offset(0), 0);
@@ -1301,7 +1301,7 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
-	if ((scratch_reg > 0 || scratchpad_available()) && use_bbit_insns()) {
+	if ((scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
 		vmalloc_mode = refill_scratch;
-- 
1.7.9.5
