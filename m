Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:25:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4037 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993901AbdHHMXDxCrBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:23:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 824C2E9E4A821;
        Tue,  8 Aug 2017 13:22:59 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 8 Aug 2017 13:23:02 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 5/6] MIPS: Stacktrace: Fix  microMIPS stack unwinding on big endian systems
Date:   Tue, 8 Aug 2017 13:22:34 +0100
Message-ID: <1502194955-18018-6-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 59422
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

The stack unwinding code uses the mips_instuction union to decode the
instructions it finds. That union uses the __BITFIELD_FIELD macro to
reorder depending on endianness. The stack unwinding code always places
16bit instructions in halfword 1 of the union. This makes the union
accesses correct for little endian systems. Similarly, 32bit
instructions are reordered such that they are correct for little endian
systems. This handling leaves unwinding the stack on big endian systems
broken, as the mips_instruction union will then look for the fields in
the wrong halfword.

To fix this, use a logical shift to place the 16bit instruction into the
correct position in the word field of the union. Use the same shifting
to order the 2 halfwords of 32bit instuctions. Then replace accesses to
the halfword with accesses to the shifted word.
In the case of the ADDIUS5 instruction, switch to using the
mm16_r5_format union member to avoid the need for a 16bit shift.

Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>

---

Changes in v3:
New patch to fix big endian systems

Changes in v2: None

 arch/mips/kernel/process.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6fa726b0be01..ba7d5f73c8b0 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -208,7 +208,7 @@ static inline int is_ra_save_ins(union mips_instruction *ip, int *poff)
 	 *
 	 * microMIPS is way more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[1])) {
+	if (mm_insn_16bit(ip->word >> 16)) {
 		switch (ip->mm16_r5_format.opcode) {
 		case mm_swsp16_op:
 			if (ip->mm16_r5_format.rt != 31)
@@ -287,7 +287,7 @@ static inline int is_jump_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is kind of more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[1])) {
+	if (mm_insn_16bit(ip->word >> 16)) {
 		if ((ip->mm16_r5_format.opcode == mm_pool16c_op &&
 		    (ip->mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op))
 			return 1;
@@ -324,7 +324,7 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is not more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[1])) {
+	if (mm_insn_16bit(ip->word >> 16)) {
 		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
 			ip->mm16_r3_format.simmediate & mm_addiusp_func) ||
 		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
@@ -363,12 +363,10 @@ static int get_frame_info(struct mips_frame_info *info)
 	for (i = 0; i < max_insns && ip < ip_end; i++) {
 		ip = (void *)ip + last_insn_size;
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
-			insn.halfword[0] = 0;
-			insn.halfword[1] = ip->halfword[0];
+			insn.word = ip->halfword[0] << 16;
 			last_insn_size = 2;
 		} else if (is_mmips) {
-			insn.halfword[0] = ip->halfword[1];
-			insn.halfword[1] = ip->halfword[0];
+			insn.word = ip->halfword[0] << 16 | ip->halfword[1];
 			last_insn_size = 4;
 		} else {
 			insn.word = ip->word;
@@ -382,7 +380,7 @@ static int get_frame_info(struct mips_frame_info *info)
 			if (is_sp_move_ins(&insn))
 			{
 #ifdef CONFIG_CPU_MICROMIPS
-				if (mm_insn_16bit(ip->halfword[0]))
+				if (mm_insn_16bit(insn.word >> 16))
 				{
 					unsigned short tmp;
 
@@ -395,7 +393,7 @@ static int get_frame_info(struct mips_frame_info *info)
 							tmp ^= 0x100;
 						info->frame_size = -(signed short)(tmp << 2);
 					} else {
-						tmp = (ip->halfword[0] >> 1);
+						tmp = (ip->mm16_r5_format.imm >> 1);
 						info->frame_size = -(signed short)(tmp & 0xf);
 					}
 				} else
-- 
2.7.4
