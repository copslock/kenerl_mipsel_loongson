Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 20:17:26 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39432 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993374AbcHMSRTvZraD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 20:17:19 +0200
Received: from 92.40.249.202.threembb.co.uk ([92.40.249.202] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYdUk-00050i-LS; Sat, 13 Aug 2016 19:17:18 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYd3f-0002u2-IT; Sat, 13 Aug 2016 18:49:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Date:   Sat, 13 Aug 2016 18:42:51 +0100
Message-ID: <lsq.1471110171.266006049@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 076/305] MIPS: math-emu: Fix jalr emulation when rd == $0
In-Reply-To: <lsq.1471110169.907390585@decadent.org.uk>
X-SA-Exim-Connect-IP: 92.40.249.202
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.37-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/math-emu/cp1emu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -443,9 +443,11 @@ static int isBranchInstr(struct pt_regs
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
