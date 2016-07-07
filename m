Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 20:42:06 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:52691 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992417AbcGGSjgU0PLF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 20:39:36 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bLECy-0007u7-U5; Thu, 07 Jul 2016 18:39:33 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bLECw-0004yX-Ph; Thu, 07 Jul 2016 11:39:30 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W . Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 65/99] MIPS: math-emu: Fix jalr emulation when rd == $0
Date:   Thu,  7 Jul 2016 11:38:04 -0700
Message-Id: <1467916718-18638-66-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467916718-18638-1-git-send-email-kamal@canonical.com>
References: <1467916718-18638-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt23 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Paul Burton <paul.burton@imgtec.com>

commit ab4a92e66741b35ca12f8497896bafbe579c28a1 upstream.

When emulating a jalr instruction with rd == $0, the code in
isBranchInstr was incorrectly writing to GPR $0 which should actually
always remain zeroed. This would lead to any further instructions
emulated which use $0 operating on a bogus value until the task is next
context switched, at which point the value of $0 in the task context
would be restored to the correct zero by a store in SAVE_SOME. Fix this
by not writing to rd if it is $0.

Fixes: 102cedc32a6e ("MIPS: microMIPS: Floating point support.")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13160/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/math-emu/cp1emu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 9dfcd7f..862bc86 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -443,9 +443,11 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	case spec_op:
 		switch (insn.r_format.func) {
 		case jalr_op:
-			regs->regs[insn.r_format.rd] =
-				regs->cp0_epc + dec_insn.pc_inc +
-				dec_insn.next_pc_inc;
+			if (insn.r_format.rd != 0) {
+				regs->regs[insn.r_format.rd] =
+					regs->cp0_epc + dec_insn.pc_inc +
+					dec_insn.next_pc_inc;
+			}
 			/* Fall through */
 		case jr_op:
 			*contpc = regs->regs[insn.r_format.rs];
-- 
2.7.4
