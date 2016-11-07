Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 16:08:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1190 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991984AbcKGPIZ4ASAw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 16:08:25 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 70C9B2F6DFA27;
        Mon,  7 Nov 2016 15:08:16 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 15:08:19 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
Subject: [PATCH 2/6] MIPS: Prevent unaligned accesses during stack unwinding
Date:   Mon, 7 Nov 2016 15:07:03 +0000
Message-ID: <20161107150707.5079-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107150707.5079-1-paul.burton@imgtec.com>
References: <20161107150707.5079-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55711
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

During stack unwinding we call a number of functions to determine what
type of instruction we're looking at. The union mips_instruction pointer
provided to them may be pointing at a 2 byte, but not 4 byte, aligned
address & we thus cannot directly access the 4 byte wide members of the
union mips_instruction. To avoid this is_ra_save_ins() copies the
required half-words of the microMIPS instruction to a correctly aligned
union mips_instruction on the stack, which it can then access safely.
The is_jump_ins() & is_sp_move_ins() functions do not correctly perform
this temporary copy, and instead attempt to directly dereference 4 byte
fields which may be misaligned and lead to an address exception.

Fix this by copying the instruction halfwords to a temporary union
mips_instruction in get_frame_info() such that we can provide a 4 byte
aligned union mips_instruction to the is_*_ins() functions and they do
not need to deal with misalignment themselves.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.10+
---

 arch/mips/kernel/process.c | 70 +++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c0aa99b..941a881 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -198,8 +198,6 @@ struct mips_frame_info {
 static inline int is_ra_save_ins(union mips_instruction *ip)
 {
 #ifdef CONFIG_CPU_MICROMIPS
-	union mips_instruction mmi;
-
 	/*
 	 * swsp ra,offset
 	 * swm16 reglist,offset(sp)
@@ -209,23 +207,20 @@ static inline int is_ra_save_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is way more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[0])) {
-		mmi.word = (ip->halfword[0] << 16);
-		return (mmi.mm16_r5_format.opcode == mm_swsp16_op &&
-			mmi.mm16_r5_format.rt == 31) ||
-		       (mmi.mm16_m_format.opcode == mm_pool16c_op &&
-			mmi.mm16_m_format.func == mm_swm16_op);
+	if (mm_insn_16bit(ip->halfword[1])) {
+		return (ip->mm16_r5_format.opcode == mm_swsp16_op &&
+			ip->mm16_r5_format.rt == 31) ||
+		       (ip->mm16_m_format.opcode == mm_pool16c_op &&
+			ip->mm16_m_format.func == mm_swm16_op);
 	}
 	else {
-		mmi.halfword[0] = ip->halfword[1];
-		mmi.halfword[1] = ip->halfword[0];
-		return (mmi.mm_m_format.opcode == mm_pool32b_op &&
-			mmi.mm_m_format.rd > 9 &&
-			mmi.mm_m_format.base == 29 &&
-			mmi.mm_m_format.func == mm_swm32_func) ||
-		       (mmi.i_format.opcode == mm_sw32_op &&
-			mmi.i_format.rs == 29 &&
-			mmi.i_format.rt == 31);
+		return (ip->mm_m_format.opcode == mm_pool32b_op &&
+			ip->mm_m_format.rd > 9 &&
+			ip->mm_m_format.base == 29 &&
+			ip->mm_m_format.func == mm_swm32_func) ||
+		       (ip->i_format.opcode == mm_sw32_op &&
+			ip->i_format.rs == 29 &&
+			ip->i_format.rt == 31);
 	}
 #else
 	/* sw / sd $ra, offset($sp) */
@@ -246,12 +241,8 @@ static inline int is_jump_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is kind of more fun...
 	 */
-	union mips_instruction mmi;
-
-	mmi.word = (ip->halfword[0] << 16);
-
-	if ((mmi.mm16_r5_format.opcode == mm_pool16c_op &&
-	    (mmi.mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op) ||
+	if ((ip->mm16_r5_format.opcode == mm_pool16c_op &&
+	    (ip->mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op) ||
 	    ip->j_format.opcode == mm_jal32_op)
 		return 1;
 	if (ip->r_format.opcode != mm_pool32a_op ||
@@ -280,15 +271,13 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is not more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[0])) {
-		union mips_instruction mmi;
-
-		mmi.word = (ip->halfword[0] << 16);
-		return (mmi.mm16_r3_format.opcode == mm_pool16d_op &&
-			mmi.mm16_r3_format.simmediate && mm_addiusp_func) ||
-		       (mmi.mm16_r5_format.opcode == mm_pool16d_op &&
-			mmi.mm16_r5_format.rt == 29);
+	if (mm_insn_16bit(ip->halfword[1])) {
+		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
+			ip->mm16_r3_format.simmediate && mm_addiusp_func) ||
+		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
+			ip->mm16_r5_format.rt == 29);
 	}
+
 	return ip->mm_i_format.opcode == mm_addiu32_op &&
 	       ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29;
 #else
@@ -303,7 +292,8 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 
 static int get_frame_info(struct mips_frame_info *info)
 {
-	union mips_instruction *ip;
+	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
+	union mips_instruction insn, *ip;
 	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
 	unsigned i;
 
@@ -319,11 +309,21 @@ static int get_frame_info(struct mips_frame_info *info)
 	max_insns = min(128U, max_insns);
 
 	for (i = 0; i < max_insns; i++, ip++) {
+		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
+			insn.halfword[0] = 0;
+			insn.halfword[1] = ip->halfword[0];
+		} else if (is_mmips) {
+			insn.halfword[0] = ip->halfword[1];
+			insn.halfword[1] = ip->halfword[0];
+		} else {
+			insn.word = ip->word;
+		}
 
-		if (is_jump_ins(ip))
+		if (is_jump_ins(&insn))
 			break;
+
 		if (!info->frame_size) {
-			if (is_sp_move_ins(ip))
+			if (is_sp_move_ins(&insn))
 			{
 #ifdef CONFIG_CPU_MICROMIPS
 				if (mm_insn_16bit(ip->halfword[0]))
@@ -346,7 +346,7 @@ static int get_frame_info(struct mips_frame_info *info)
 			}
 			continue;
 		}
-		if (info->pc_offset == -1 && is_ra_save_ins(ip)) {
+		if (info->pc_offset == -1 && is_ra_save_ins(&insn)) {
 			info->pc_offset =
 				ip->i_format.simmediate / sizeof(long);
 			break;
-- 
2.10.2
