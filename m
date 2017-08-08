Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:25:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40565 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994856AbdHHMXLq0CDm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:23:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 51FAB3F308A4A;
        Tue,  8 Aug 2017 13:23:02 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 8 Aug 2017 13:23:05 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 6/6] MIPS: Refactor handling of stack pointer in get_frame_info
Date:   Tue, 8 Aug 2017 13:22:35 +0100
Message-ID: <1502194955-18018-7-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 59424
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

Commit 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
added handling of microMIPS instructions to manipulate the stack
pointer. The code that was added violates code style rules with long
lines caused by lots of nested conditionals.

The added code interprets (inline) any known stack pointer manipulation
instruction to find the stack frame size. Handling the microMIPS cases
added quite a bit of complication to this function.

Refactor is_sp_move_ins to perform the interpretation of the immediate
as the instruction manipulating the stack pointer is found. This reduces
the amount of indentation required in get_frame_info, and more closely
matches the operation of is_ra_save_ins.

Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v3: None
Changes in v2:
- Refactor is_sp_move_ins to interpret immediate inline.

 arch/mips/kernel/process.c | 61 +++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index ba7d5f73c8b0..26e2cdcd0057 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -313,9 +313,11 @@ static inline int is_jump_ins(union mips_instruction *ip)
 #endif
 }
 
-static inline int is_sp_move_ins(union mips_instruction *ip)
+static inline int is_sp_move_ins(union mips_instruction *ip, int *frame_size)
 {
 #ifdef CONFIG_CPU_MICROMIPS
+	unsigned short tmp;
+
 	/*
 	 * addiusp -imm
 	 * addius5 sp,-imm
@@ -325,20 +327,39 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	 * microMIPS is not more fun...
 	 */
 	if (mm_insn_16bit(ip->word >> 16)) {
-		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
-			ip->mm16_r3_format.simmediate & mm_addiusp_func) ||
-		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
-			ip->mm16_r5_format.rt == 29);
+		if (ip->mm16_r3_format.opcode == mm_pool16d_op &&
+		    ip->mm16_r3_format.simmediate & mm_addiusp_func) {
+			tmp = ip->mm_b0_format.simmediate >> 1;
+			tmp = ((tmp & 0x1ff) ^ 0x100) - 0x100;
+			if ((tmp + 2) < 4) /* 0x0,0x1,0x1fe,0x1ff are special */
+				tmp ^= 0x100;
+			*frame_size = -(signed short)(tmp << 2);
+			return 1;
+		}
+		if (ip->mm16_r5_format.opcode == mm_pool16d_op &&
+		    ip->mm16_r5_format.rt == 29) {
+			tmp = ip->mm16_r5_format.imm >> 1;
+			*frame_size = -(signed short)(tmp & 0xf);
+			return 1;
+		}
+		return 0;
 	}
 
-	return ip->mm_i_format.opcode == mm_addiu32_op &&
-	       ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29;
+	if (ip->mm_i_format.opcode == mm_addiu32_op &&
+	    ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29) {
+		*frame_size = -ip->i_format.simmediate;
+		return 1;
+	}
 #else
 	/* addiu/daddiu sp,sp,-imm */
 	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
 		return 0;
-	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
+
+	if (ip->i_format.opcode == addiu_op ||
+	    ip->i_format.opcode == daddiu_op) {
+		*frame_size = -ip->i_format.simmediate;
 		return 1;
+	}
 #endif
 	return 0;
 }
@@ -377,29 +398,7 @@ static int get_frame_info(struct mips_frame_info *info)
 			break;
 
 		if (!info->frame_size) {
-			if (is_sp_move_ins(&insn))
-			{
-#ifdef CONFIG_CPU_MICROMIPS
-				if (mm_insn_16bit(insn.word >> 16))
-				{
-					unsigned short tmp;
-
-					if (ip->mm16_r3_format.simmediate & mm_addiusp_func)
-					{
-						tmp = ip->mm_b0_format.simmediate >> 1;
-						tmp = ((tmp & 0x1ff) ^ 0x100) - 0x100;
-						/* 0x0,0x1,0x1fe,0x1ff are special */
-						if ((tmp + 2) < 4)
-							tmp ^= 0x100;
-						info->frame_size = -(signed short)(tmp << 2);
-					} else {
-						tmp = (ip->mm16_r5_format.imm >> 1);
-						info->frame_size = -(signed short)(tmp & 0xf);
-					}
-				} else
-#endif
-				info->frame_size = - ip->i_format.simmediate;
-			}
+			is_sp_move_ins(&insn, &info->frame_size);
 			continue;
 		}
 		if (info->pc_offset == -1 &&
-- 
2.7.4
