Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:43:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16874 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVSnkh3kyP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:43:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 19777D2FBD983;
        Tue, 22 Sep 2015 19:43:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:43:34 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:43:33 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/6] MIPS: tlbex: stop open-coding build_convert_pte_to_entrylo
Date:   Tue, 22 Sep 2015 11:42:48 -0700
Message-ID: <1442947373-13345-2-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 49318
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

Make use of build_convert_pte_to_entrylo in the RIXI cases within
build_update_entries rather than open-coding it 4 times.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mm/tlbex.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 323d1d3..0dd24b0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1010,13 +1010,13 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 		uasm_i_ld(p, tmp, 0, ptep); /* get even pte */
 		uasm_i_ld(p, ptep, sizeof(pte_t), ptep); /* get odd pte */
 		if (cpu_has_rixi) {
-			UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
+			build_convert_pte_to_entrylo(p, tmp);
 			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-			UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
+			build_convert_pte_to_entrylo(p, ptep);
 		} else {
-			uasm_i_dsrl_safe(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
+			build_convert_pte_to_entrylo(p, tmp);
 			UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-			uasm_i_dsrl_safe(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /* convert to entrylo1 */
+			build_convert_pte_to_entrylo(p, ptep);
 		}
 		UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
@@ -1050,17 +1050,17 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 	if (r45k_bvahwbug())
 		build_tlb_probe_entry(p);
 	if (cpu_has_rixi) {
-		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
+		build_convert_pte_to_entrylo(p, tmp);
 		if (r4k_250MHZhwbug())
 			UASM_i_MTC0(p, 0, C0_ENTRYLO0);
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL));
+		build_convert_pte_to_entrylo(p, ptep);
 	} else {
-		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
+		build_convert_pte_to_entrylo(p, tmp);
 		if (r4k_250MHZhwbug())
 			UASM_i_MTC0(p, 0, C0_ENTRYLO0);
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /* convert to entrylo1 */
+		build_convert_pte_to_entrylo(p, ptep);
 		if (r45k_bvahwbug())
 			uasm_i_mfc0(p, tmp, C0_INDEX);
 	}
-- 
2.5.3
