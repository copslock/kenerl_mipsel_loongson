Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 01:04:04 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50465 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993946AbdFGXDvg2oem (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 01:03:51 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v57N1Pvf000375;
        Thu, 8 Jun 2017 01:01:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 143/250] MIPS: Prevent unaligned accesses during stack unwinding
Date:   Thu,  8 Jun 2017 00:58:49 +0200
Message-Id: <1496876436-32402-144-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1496876436-32402-1-git-send-email-w@1wt.eu>
References: <1496876436-32402-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58296
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

From: Paul Burton <paul.burton@imgtec.com>

commit a3552dace7d1d0cabf573e88fc3025cb90c4a601 upstream.

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
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14529/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/process.c | 70 +++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 11468a0..71110b9 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -217,8 +217,6 @@ struct mips_frame_info {
 static inline int is_ra_save_ins(union mips_instruction *ip)
 {
 #ifdef CONFIG_CPU_MICROMIPS
-	union mips_instruction mmi;
-
 	/*
 	 * swsp ra,offset
 	 * swm16 reglist,offset(sp)
@@ -228,23 +226,20 @@ static inline int is_ra_save_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is way more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[0])) {
-		mmi.word = (ip->halfword[0] << 16);
-		return ((mmi.mm16_r5_format.opcode == mm_swsp16_op &&
-			 mmi.mm16_r5_format.rt == 31) ||
-			(mmi.mm16_m_format.opcode == mm_pool16c_op &&
-			 mmi.mm16_m_format.func == mm_swm16_op));
+	if (mm_insn_16bit(ip->halfword[1])) {
+		return (ip->mm16_r5_format.opcode == mm_swsp16_op &&
+			ip->mm16_r5_format.rt == 31) ||
+		       (ip->mm16_m_format.opcode == mm_pool16c_op &&
+			ip->mm16_m_format.func == mm_swm16_op);
 	}
 	else {
-		mmi.halfword[0] = ip->halfword[1];
-		mmi.halfword[1] = ip->halfword[0];
-		return ((mmi.mm_m_format.opcode == mm_pool32b_op &&
-			 mmi.mm_m_format.rd > 9 &&
-			 mmi.mm_m_format.base == 29 &&
-			 mmi.mm_m_format.func == mm_swm32_func) ||
-			(mmi.i_format.opcode == mm_sw32_op &&
-			 mmi.i_format.rs == 29 &&
-			 mmi.i_format.rt == 31));
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
@@ -265,12 +260,8 @@ static inline int is_jump_ins(union mips_instruction *ip)
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
@@ -299,15 +290,13 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is not more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[0])) {
-		union mips_instruction mmi;
-
-		mmi.word = (ip->halfword[0] << 16);
-		return ((mmi.mm16_r3_format.opcode == mm_pool16d_op &&
-			 mmi.mm16_r3_format.simmediate && mm_addiusp_func) ||
-			(mmi.mm16_r5_format.opcode == mm_pool16d_op &&
-			 mmi.mm16_r5_format.rt == 29));
+	if (mm_insn_16bit(ip->halfword[1])) {
+		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
+			ip->mm16_r3_format.simmediate && mm_addiusp_func) ||
+		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
+			ip->mm16_r5_format.rt == 29);
 	}
+
 	return (ip->mm_i_format.opcode == mm_addiu32_op &&
 		 ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29);
 #else
@@ -322,7 +311,8 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 
 static int get_frame_info(struct mips_frame_info *info)
 {
-	union mips_instruction *ip;
+	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
+	union mips_instruction insn, *ip;
 	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
 	unsigned i;
 
@@ -338,11 +328,21 @@ static int get_frame_info(struct mips_frame_info *info)
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
@@ -365,7 +365,7 @@ static int get_frame_info(struct mips_frame_info *info)
 			}
 			continue;
 		}
-		if (info->pc_offset == -1 && is_ra_save_ins(ip)) {
+		if (info->pc_offset == -1 && is_ra_save_ins(&insn)) {
 			info->pc_offset =
 				ip->i_format.simmediate / sizeof(long);
 			break;
-- 
2.8.0.rc2.1.gbe9624a
