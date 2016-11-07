Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 16:09:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5094 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992009AbcKGPJYyNxuw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 16:09:24 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9246C2A306360;
        Mon,  7 Nov 2016 15:09:15 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 15:09:18 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
Subject: [PATCH 5/6] MIPS: Calculate microMIPS ra properly when unwinding the stack
Date:   Mon, 7 Nov 2016 15:07:06 +0000
Message-ID: <20161107150707.5079-6-paul.burton@imgtec.com>
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
X-archive-position: 55714
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

get_frame_info() calculates the offset of the return address within a
stack frame simply by dividing a the bottom 16 bits of the instruction,
treated as a signed integer, by the size of a long. Whilst this works
for MIPS32 & MIPS64 ISAs where the sw or sd instructions are used, it's
incorrect for microMIPS where encodings differ. The result is that we
typically completely fail to unwind the stack on microMIPS.

Fix this by adjusting is_ra_save_ins() to calculate the return address
offset, and take into account the various different encodings there in
the same place as we consider whether an instruction is storing the
ra/$31 register.

With this we are now able to unwind the stack for kernels targetting the
microMIPS ISA, for example we can produce:

    Call Trace:
    [<80109e1f>] show_stack+0x63/0x7c
    [<8011ea17>] __warn+0x9b/0xac
    [<8011ea45>] warn_slowpath_fmt+0x1d/0x20
    [<8013fe53>] register_console+0x43/0x314
    [<8067c58d>] of_setup_earlycon+0x1dd/0x1ec
    [<8067f63f>] early_init_dt_scan_chosen_stdout+0xe7/0xf8
    [<8066c115>] do_early_param+0x75/0xac
    [<801302f9>] parse_args+0x1dd/0x308
    [<8066c459>] parse_early_options+0x25/0x28
    [<8066c48b>] parse_early_param+0x2f/0x38
    [<8066e8cf>] setup_arch+0x113/0x488
    [<8066c4f3>] start_kernel+0x57/0x328
    ---[ end trace 0000000000000000 ]---

Whereas previously we only produced:

    Call Trace:
    [<80109e1f>] show_stack+0x63/0x7c
    ---[ end trace 0000000000000000 ]---

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.10+
---

 arch/mips/kernel/process.c | 83 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 298dc33..39c946f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -195,7 +195,7 @@ struct mips_frame_info {
 #define J_TARGET(pc,target)	\
 		(((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
 
-static inline int is_ra_save_ins(union mips_instruction *ip)
+static inline int is_ra_save_ins(union mips_instruction *ip, int *poff)
 {
 #ifdef CONFIG_CPU_MICROMIPS
 	/*
@@ -208,25 +208,70 @@ static inline int is_ra_save_ins(union mips_instruction *ip)
 	 * microMIPS is way more fun...
 	 */
 	if (mm_insn_16bit(ip->halfword[1])) {
-		return (ip->mm16_r5_format.opcode == mm_swsp16_op &&
-			ip->mm16_r5_format.rt == 31) ||
-		       (ip->mm16_m_format.opcode == mm_pool16c_op &&
-			ip->mm16_m_format.func == mm_swm16_op);
+		switch (ip->mm16_r5_format.opcode) {
+		case mm_swsp16_op:
+			if (ip->mm16_r5_format.rt != 31)
+				return 0;
+
+			*poff = ip->mm16_r5_format.simmediate;
+			*poff = (*poff << 2) / sizeof(ulong);
+			return 1;
+
+		case mm_pool16c_op:
+			switch (ip->mm16_m_format.func) {
+			case mm_swm16_op:
+				*poff = ip->mm16_m_format.imm;
+				*poff += 1 + ip->mm16_m_format.rlist;
+				*poff = (*poff << 2) / sizeof(ulong);
+				return 1;
+
+			default:
+				return 0;
+			}
+
+		default:
+			return 0;
+		}
 	}
-	else {
-		return (ip->mm_m_format.opcode == mm_pool32b_op &&
-			ip->mm_m_format.rd > 9 &&
-			ip->mm_m_format.base == 29 &&
-			ip->mm_m_format.func == mm_swm32_func) ||
-		       (ip->i_format.opcode == mm_sw32_op &&
-			ip->i_format.rs == 29 &&
-			ip->i_format.rt == 31);
+
+	switch (ip->i_format.opcode) {
+	case mm_sw32_op:
+		if (ip->i_format.rs != 29)
+			return 0;
+		if (ip->i_format.rt != 31)
+			return 0;
+
+		*poff = ip->i_format.simmediate / sizeof(ulong);
+		return 1;
+
+	case mm_pool32b_op:
+		switch (ip->mm_m_format.func) {
+		case mm_swm32_func:
+			if (ip->mm_m_format.rd < 0x10)
+				return 0;
+			if (ip->mm_m_format.base != 29)
+				return 0;
+
+			*poff = ip->mm_m_format.simmediate;
+			*poff += (ip->mm_m_format.rd & 0xf) * sizeof(u32);
+			*poff /= sizeof(ulong);
+			return 1;
+		default:
+			return 0;
+		}
+
+	default:
+		return 0;
 	}
 #else
 	/* sw / sd $ra, offset($sp) */
-	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&
-		ip->i_format.rs == 29 &&
-		ip->i_format.rt == 31;
+	if ((ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&
+		ip->i_format.rs == 29 && ip->i_format.rt == 31) {
+		*poff = ip->i_format.simmediate / sizeof(ulong);
+		return 1;
+	}
+
+	return 0;
 #endif
 }
 
@@ -349,11 +394,9 @@ static int get_frame_info(struct mips_frame_info *info)
 			}
 			continue;
 		}
-		if (info->pc_offset == -1 && is_ra_save_ins(&insn)) {
-			info->pc_offset =
-				ip->i_format.simmediate / sizeof(long);
+		if (info->pc_offset == -1 &&
+		    is_ra_save_ins(&insn, &info->pc_offset))
 			break;
-		}
 	}
 	if (info->frame_size && info->pc_offset >= 0) /* nested */
 		return 0;
-- 
2.10.2
