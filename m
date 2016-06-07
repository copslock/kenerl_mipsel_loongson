Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2016 19:49:23 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:51781 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028345AbcFGRtU57GKg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Jun 2016 19:49:20 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5068CADA1;
        Tue,  7 Jun 2016 17:49:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W . Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: math-emu: Fix jalr emulation when rd == $0
Date:   Tue,  7 Jun 2016 19:48:55 +0200
Message-Id: <20160607174916.31952-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160607174916.31952-1-jslaby@suse.cz>
References: <20160607174916.31952-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Paul Burton <paul.burton@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/math-emu/cp1emu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index efe008846ed0..95745858a694 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -670,9 +670,11 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
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
2.8.3
