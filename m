Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2014 12:13:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2279 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007356AbaK0LNboyNie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2014 12:13:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3FE8B6423DCCF;
        Thu, 27 Nov 2014 11:13:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 27 Nov 2014 11:13:25 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 27 Nov 2014 11:13:25 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <stable@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: mm: tlbex: Fix potential HTW race on TLBL/M/S handlers
Date:   Thu, 27 Nov 2014 11:13:08 +0000
Message-ID: <1417086788-15654-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

There is a potential race when probing the TLB in TLBL/M/S exception
handlers for a matching entry. Between the time we hit a TLBL/S/M
exception and the time we get to execute the TLBP instruction, the
HTW may have killed the TLB entry we are interested in hence the TLB
probe may fail. However, in the existing handlers, we never checked the
status of the TLBP (ie check the result in the C0/Index register). We
fix this by adding such a check when the core implements the HTW. If
we couldn't find a matching entry, we return back and try again.

Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/tlbex.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 7994368f96c4..3978a3d81366 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1872,8 +1872,16 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	uasm_l_smp_pgtable_change(l, *p);
 #endif
 	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
-	if (!m4kc_tlbp_war())
+	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
+		if (cpu_has_htw) {
+			/* race condition happens, leaving */
+			uasm_i_ehb(p);
+			uasm_i_mfc0(p, wr.r3, C0_INDEX);
+			uasm_il_bltz(p, r, wr.r3, label_leave);
+			uasm_i_nop(p);
+		}
+	}
 	return wr;
 }
 
-- 
2.1.3
