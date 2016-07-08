Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 15:06:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15906 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992815AbcGHNGMBwCIV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 15:06:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 51B45D2086186;
        Fri,  8 Jul 2016 14:06:03 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 14:06:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        David Daney <ddaney@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: tlbex: Avoid duplicated single_insn_swpd
Date:   Fri, 8 Jul 2016 14:05:56 +0100
Message-ID: <1467983156-30230-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The expression "uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)" is
used twice in build_get_pgd_vmalloc64(), one of which is assigned to the
local variable single_insn_swpd. Update the other use to just use
single_insn_swpd instead to remove the duplication.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/tlbex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4004b659ce50..7886cce9ebe2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -888,7 +888,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		}
 	}
 	if (!did_vmalloc_branch) {
-		if (uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)) {
+		if (single_insn_swpd) {
 			uasm_il_b(p, r, label_vmalloc_done);
 			uasm_i_lui(p, ptr, uasm_rel_hi(swpd));
 		} else {
-- 
2.4.10
