Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 15:42:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993880AbdCAOlltWe3I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2017 15:41:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A797F5A8C7278;
        Wed,  1 Mar 2017 14:41:32 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 1 Mar 2017 14:41:35 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 3/5] MIPS: Refactor handling of stack pointer in get_frame_info
Date:   Wed, 1 Mar 2017 14:41:18 +0000
Message-ID: <1488379280-2954-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488379280-2954-1-git-send-email-matt.redfearn@imgtec.com>
References: <1488379280-2954-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56944
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

This commit refactors is_sp_move_ins to perform the interpretation of
the immediate as the instruction manipulating the stack pointer is
found. This reduces the amount of indentation required in
get_frame_info, and more closely matches the operation of
is_ra_save_ins.

Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v2:
- Refactor is_sp_move_ins to interpret immediate inline.

 arch/mips/kernel/process.c | 58 ++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 799273d45d21..1113f1f15bc1 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -311,9 +311,11 @@ static inline int is_jump_ins(union mips_instruction *ip)
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
@@ -323,20 +325,37 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	 * microMIPS is not more fun...
 	 */
 	if (mm_insn_16bit(ip->halfword[1])) {
-		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
-			ip->mm16_r3_format.simmediate && mm_addiusp_func) ||
-		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
-			ip->mm16_r5_format.rt == 29);
+		if (ip->mm16_r3_format.opcode == mm_pool16d_op &&
+		    ip->mm16_r3_format.simmediate && mm_addiusp_func) {
+			tmp = (ip->halfword[1] >> 1) & 0x1ff;
+			tmp = (tmp ^ 0x100) - 0x100;
+			*frame_size = -(signed short)(tmp << 2);
+			return 1;
+		}
+		if (ip->mm16_r5_format.opcode == mm_pool16d_op &&
+		    ip->mm16_r5_format.rt == 29) {
+			tmp = (ip->halfword[1] >> 1);
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
@@ -377,28 +396,7 @@ static int get_frame_info(struct mips_frame_info *info)
 			break;
 
 		if (!info->frame_size) {
-			if (is_sp_move_ins(&insn))
-			{
-#ifdef CONFIG_CPU_MICROMIPS
-				if (mm_insn_16bit(ip->halfword[0]))
-				{
-					unsigned short tmp;
-
-					if (ip->halfword[0] & mm_addiusp_func)
-					{
-						tmp = (ip->halfword[0] >> 1) & 0x1ff;
-						tmp = (tmp ^ 0x100) - 0x100;
-						info->frame_size = -(signed short)(tmp << 2);
-					} else {
-						tmp = (ip->halfword[0] >> 1);
-						info->frame_size = -(signed short)(tmp & 0xf);
-					}
-					ip = (void *) &ip->halfword[1];
-					ip--;
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
