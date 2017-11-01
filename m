Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 22:22:39 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35108 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993154AbdKAVWbsj8Dm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 22:22:31 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id vA1LKBCY004628;
        Wed, 1 Nov 2017 22:20:11 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 037/139] MIPS: Fix unaligned PC interpretation in `compute_return_epc'
Date:   Wed,  1 Nov 2017 22:17:37 +0100
Message-Id: <1509571159-4405-38-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1509571159-4405-1-git-send-email-w@1wt.eu>
References: <1509571159-4405-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit 11a3799dbeb620bf0400b1fda5cc2c6bea55f20a upstream.

Fix a regression introduced with commit fb6883e5809c ("MIPS: microMIPS:
Support handling of delay slots.") and defer to `__compute_return_epc'
if the ISA bit is set in EPC with non-MIPS16, non-microMIPS hardware,
which will then arrange for a SIGBUS due to an unaligned instruction
reference.  Returning EPC here is never correct as the API defines this
function's result to be either a negative error code on failure or one
of 0 and BRANCH_LIKELY_TAKEN on success.

Fixes: fb6883e5809c ("MIPS: microMIPS: Support handling of delay slots.")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org 
Patchwork: https://patchwork.linux-mips.org/patch/16395/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/branch.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/branch.h b/arch/mips/include/asm/branch.h
index e28a3e0..582d8b6 100644
--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -44,10 +44,7 @@ static inline int compute_return_epc(struct pt_regs *regs)
 			return __microMIPS_compute_return_epc(regs);
 		if (cpu_has_mips16)
 			return __MIPS16e_compute_return_epc(regs);
-		return regs->cp0_epc;
-	}
-
-	if (!delay_slot(regs)) {
+	} else if (!delay_slot(regs)) {
 		regs->cp0_epc += 4;
 		return 0;
 	}
-- 
2.8.0.rc2.1.gbe9624a
