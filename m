Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:27:30 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993923AbdCJJ1DgcC3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:27:03 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D886749B;
        Fri, 10 Mar 2017 09:26:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 010/167] MIPS: Calculate microMIPS ra properly when unwinding the stack
Date:   Fri, 10 Mar 2017 10:07:33 +0100
Message-Id: <20170310083957.522093981@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083956.767605269@linuxfoundation.org>
References: <20170310083956.767605269@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit bb9bc4689b9c635714fbcd5d335bad9934a7ebfc upstream.

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
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14532/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |   85 +++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 21 deletions(-)

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
@@ -208,25 +208,70 @@ static inline int is_ra_save_ins(union m
 	 * microMIPS is way more fun...
 	 */
 	if (mm_insn_16bit(ip->halfword[1])) {
-		return (ip->mm16_r5_format.opcode == mm_swsp16_op &&
-			ip->mm16_r5_format.rt == 31) ||
-		       (ip->mm16_m_format.opcode == mm_pool16c_op &&
-			ip->mm16_m_format.func == mm_swm16_op);
-	}
-	else {
-		return (ip->mm_m_format.opcode == mm_pool32b_op &&
-			ip->mm_m_format.rd > 9 &&
-			ip->mm_m_format.base == 29 &&
-			ip->mm_m_format.func == mm_swm32_func) ||
-		       (ip->i_format.opcode == mm_sw32_op &&
-			ip->i_format.rs == 29 &&
-			ip->i_format.rt == 31);
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
+	}
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
 
@@ -349,11 +394,9 @@ static int get_frame_info(struct mips_fr
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
