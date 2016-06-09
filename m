Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:21:14 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34883 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041464AbcFIVS6F2CLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:18:58 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7Lt-0005Ls-88; Thu, 09 Jun 2016 21:18:57 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7Lq-0006CD-Hn; Thu, 09 Jun 2016 14:18:54 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W . Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 101/206] MIPS: math-emu: Fix jalr emulation when rd == $0
Date:   Thu,  9 Jun 2016 14:15:10 -0700
Message-Id: <1465507015-23052-102-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53987
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

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
index f0f1b98..2bf9209 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -445,9 +445,11 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
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
 			/* For R6, JR already emulated in jalr_op */
-- 
2.7.4
