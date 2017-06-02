Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 20:36:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10420 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993359AbdFBSfyb8Bch (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 20:35:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9C18476DB3C0E;
        Fri,  2 Jun 2017 19:35:44 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 19:35:48
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix bnezc/jialc return address calculation
Date:   Fri, 2 Jun 2017 11:35:01 -0700
Message-ID: <20170602183501.18608-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58141
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

The code handling the pop76 opcode (ie. bnezc & jialc instructions) in
__compute_return_epc_for_insn() needs to set the value of $31 in the
jialc case, which is encoded with rs = 0. However its check to
differentiate bnezc (rs != 0) from jialc (rs = 0) was unfortunately
backwards, meaning that if we emulate a bnezc instruction we clobber $31
& if we emulate a jialc instruction it actually behaves like a jic
instruction.

Fix this by inverting the check of rs to match the way the instructions
are actually encoded.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 28d6f93d201d ("MIPS: Emulate the new MIPS R6 BNEZC and JIALC instructions")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.0+
---

 arch/mips/kernel/branch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index b11facd11c9d..f702a459a830 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -804,8 +804,10 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 			break;
 		}
 		/* Compact branch: BNEZC || JIALC */
-		if (insn.i_format.rs)
+		if (!insn.i_format.rs) {
+			/* JIALC: set $31/ra */
 			regs->regs[31] = epc + 4;
+		}
 		regs->cp0_epc += 8;
 		break;
 #endif
-- 
2.13.0
