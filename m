Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:06:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35560 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027124AbcDUNGBWrN-j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:06:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 1BF3F57D83C42;
        Thu, 21 Apr 2016 14:05:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:05:55 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:05:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 02/11] MIPS: Fix BC1{EQ,NE}Z return offset calculation
Date:   Thu, 21 Apr 2016 14:04:46 +0100
Message-ID: <1461243895-30371-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
References: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53157
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

The conditions for branching when emulating the BC1EQZ & BC1NEZ
instructions were backwards, leading to each of those instructions being
treated as the other. Fix this by reversing the conditions, and clear up
the code a little for readability & checkpatch.

Fixes: c8a34581ec09 ("MIPS: Emulate the BC1{EQ,NE}Z FPU instructions")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---

 arch/mips/kernel/branch.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index d8f9b35..ceca6cc 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -688,21 +688,9 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			}
 			lose_fpu(1);    /* Save FPU state for the emulator. */
 			reg = insn.i_format.rt;
-			bit = 0;
-			switch (insn.i_format.rs) {
-			case bc1eqz_op:
-				/* Test bit 0 */
-				if (get_fpr32(&current->thread.fpu.fpr[reg], 0)
-				    & 0x1)
-					bit = 1;
-				break;
-			case bc1nez_op:
-				/* Test bit 0 */
-				if (!(get_fpr32(&current->thread.fpu.fpr[reg], 0)
-				      & 0x1))
-					bit = 1;
-				break;
-			}
+			bit = get_fpr32(&current->thread.fpu.fpr[reg], 0) & 0x1;
+			if (insn.i_format.rs == bc1eqz_op)
+				bit = !bit;
 			own_fpu(1);
 			if (bit)
 				epc = epc + 4 +
-- 
2.8.0
