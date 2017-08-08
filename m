Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:23:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992974AbdHHMW5xOL2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:22:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 75C319653FD53;
        Tue,  8 Aug 2017 13:22:48 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 8 Aug 2017 13:22:51 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 1/6] MIPS: Handle non word sized instructions when examining frame
Date:   Tue, 8 Aug 2017 13:22:30 +0100
Message-ID: <1502194955-18018-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
References: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Commit 34c2f668d0f6b ("MIPS: microMIPS: Add unaligned access support.")
added fairly broken support for handling 16bit microMIPS instructions in
get_frame_info(). It adjusts the instruction pointer by 16bits in the
case of a 16bit sp move instruction, but not any other 16bit
instruction.

Commit b6c7a324df37 ("MIPS: Fix get_frame_info() handling of microMIPS
function size") goes some way to fixing get_frame_info() to iterate over
microMIPS instuctions, but the instruction pointer is still manipulated
using a postincrement, and is of union mips_instruction type. Since the
union is sized to the largest member (a word), but microMIPS
instructions are a mix of halfword and word sizes, the function does not
always iterate correctly, ending up misaligned with the instruction
stream and interpreting it incorrectly.

Since the instruction modifying the stack pointer is usually the first
in the function, that one is usually handled correctly. But the
instruction which saves the return address to the sp is some variable
number of instructions into the frame and is frequently missed due to
not being on a word boundary, leading to incomplete walking of the
stack.

Fix this by incrementing the instruction pointer based on the size of
the previously decoded instruction (& remove the hack introduced by
commit 34c2f668d0f6b ("MIPS: microMIPS: Add unaligned access support.")
which adjusts the instruction pointer in the case of a 16bit sp move
instruction, but not any other).

Fixes: 34c2f668d0f6b ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v3:
- Remove hack which attempted to cope with 16bit instructions

Changes in v2:
- Keep locals in reverse christmas tree order

 arch/mips/kernel/process.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5351e1f3950d..5950ecf469e9 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -348,6 +348,7 @@ static int get_frame_info(struct mips_frame_info *info)
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
 	union mips_instruction insn, *ip, *ip_end;
 	const unsigned int max_insns = 128;
+	unsigned int last_insn_size = 0;
 	unsigned int i;
 
 	info->pc_offset = -1;
@@ -359,15 +360,19 @@ static int get_frame_info(struct mips_frame_info *info)
 
 	ip_end = (void *)ip + info->func_size;
 
-	for (i = 0; i < max_insns && ip < ip_end; i++, ip++) {
+	for (i = 0; i < max_insns && ip < ip_end; i++) {
+		ip = (void *)ip + last_insn_size;
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
 			insn.halfword[0] = 0;
 			insn.halfword[1] = ip->halfword[0];
+			last_insn_size = 2;
 		} else if (is_mmips) {
 			insn.halfword[0] = ip->halfword[1];
 			insn.halfword[1] = ip->halfword[0];
+			last_insn_size = 4;
 		} else {
 			insn.word = ip->word;
+			last_insn_size = 4;
 		}
 
 		if (is_jump_ins(&insn))
@@ -389,8 +394,6 @@ static int get_frame_info(struct mips_frame_info *info)
 						tmp = (ip->halfword[0] >> 1);
 						info->frame_size = -(signed short)(tmp & 0xf);
 					}
-					ip = (void *) &ip->halfword[1];
-					ip--;
 				} else
 #endif
 				info->frame_size = - ip->i_format.simmediate;
-- 
2.7.4
