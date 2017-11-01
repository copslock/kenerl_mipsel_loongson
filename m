Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 22:20:55 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34991 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993035AbdKAVUrW7v2m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 22:20:47 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id vA1LKBGJ004627;
        Wed, 1 Nov 2017 22:20:11 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 036/139] MIPS: Actually decode JALX in `__compute_return_epc_for_insn'
Date:   Wed,  1 Nov 2017 22:17:36 +0100
Message-Id: <1509571159-4405-37-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1509571159-4405-1-git-send-email-w@1wt.eu>
References: <1509571159-4405-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60637
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

commit a9db101b735a9d49295326ae41f610f6da62b08c upstream.

Complement commit fb6883e5809c ("MIPS: microMIPS: Support handling of
delay slots.") and actually decode the regular MIPS JALX major
instruction opcode, the handling of which has been added with the said
commit for EPC calculation in `__compute_return_epc_for_insn'.

Fixes: fb6883e5809c ("MIPS: microMIPS: Support handling of delay slots.")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org 
Patchwork: https://patchwork.linux-mips.org/patch/16394/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 9250996..63b942f 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -297,6 +297,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	/*
 	 * These are unconditional and in j_format.
 	 */
+	case jalx_op:
 	case jal_op:
 		regs->regs[31] = regs->cp0_epc + 8;
 	case j_op:
-- 
2.8.0.rc2.1.gbe9624a
