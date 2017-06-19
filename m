Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:58:08 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58922 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993910AbdFSPuZT3e0H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id D50F01A45F9;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id B05C01A4670;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 4/8] MIPS: unaligned: Add DSP lwx & lhx missaligned access support
Date:   Mon, 19 Jun 2017 17:50:11 +0200
Message-Id: <1497887415-13825-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Add handling of missaligned access for DSP load instructions
lwx & lhx.

Since DSP instructions share SPECIAL3 opcode with other non-DSP
instructions, necessary logic was inserted for distinguishing
between instructions with SPECIAL3 opcode. For that purpose,
the instruction format for DSP instructions is added to
arch/mips/include/uapi/asm/inst.h.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
---
 arch/mips/include/uapi/asm/inst.h |  11 +++
 arch/mips/kernel/unaligned.c      | 174 ++++++++++++++++++++++----------------
 2 files changed, 111 insertions(+), 74 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b5e46ae..302ad9a 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -755,6 +755,16 @@ struct msa_mi10_format {		/* MSA MI10 */
 	;))))))
 };
 
+struct dsp_format {		/* SPEC3 DSP format instructions */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int base : 5,
+	__BITFIELD_FIELD(unsigned int index : 5,
+	__BITFIELD_FIELD(unsigned int rd : 5,
+	__BITFIELD_FIELD(unsigned int op : 5,
+	__BITFIELD_FIELD(unsigned int func : 6,
+	;))))))
+};
+
 struct spec3_format {   /* SPEC3 */
 	__BITFIELD_FIELD(unsigned int opcode:6,
 	__BITFIELD_FIELD(unsigned int rs:5,
@@ -1046,6 +1056,7 @@ union mips_instruction {
 	struct b_format b_format;
 	struct ps_format ps_format;
 	struct v_format v_format;
+	struct dsp_format dsp_format;
 	struct spec3_format spec3_format;
 	struct fb_format fb_format;
 	struct fp0_format fp0_format;
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index f806ee5..67946bb 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -939,88 +939,114 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		 * The remaining opcodes are the ones that are really of
 		 * interest.
 		 */
-#ifdef CONFIG_EVA
 	case spec3_op:
-		/*
-		 * we can land here only from kernel accessing user memory,
-		 * so we need to "switch" the address limit to user space, so
-		 * address check can work properly.
-		 */
-		seg = get_fs();
-		set_fs(USER_DS);
-		switch (insn.spec3_format.func) {
-		case lhe_op:
-			if (!access_ok(VERIFY_READ, addr, 2)) {
-				set_fs(seg);
-				goto sigbus;
-			}
-			LoadHWE(addr, value, res);
-			if (res) {
-				set_fs(seg);
-				goto fault;
-			}
-			compute_return_epc(regs);
-			regs->regs[insn.spec3_format.rt] = value;
-			break;
-		case lwe_op:
-			if (!access_ok(VERIFY_READ, addr, 4)) {
-				set_fs(seg);
-				goto sigbus;
+		if (insn.dsp_format.func == lx_op) {
+			switch (insn.dsp_format.op) {
+			case lwx_op:
+				if (!access_ok(VERIFY_READ, addr, 4))
+					goto sigbus;
+				LoadW(addr, value, res);
+				if (res)
+					goto fault;
+				compute_return_epc(regs);
+				regs->regs[insn.dsp_format.rd] = value;
+				break;
+			case lhx_op:
+				if (!access_ok(VERIFY_READ, addr, 2))
+					goto sigbus;
+				LoadHW(addr, value, res);
+				if (res)
+					goto fault;
+				compute_return_epc(regs);
+				regs->regs[insn.dsp_format.rd] = value;
+				break;
+			default:
+				goto sigill;
 			}
+		}
+#ifdef CONFIG_EVA
+		else {
+			/*
+			 * we can land here only from kernel accessing user
+			 * memory, so we need to "switch" the address limit to
+			 * user space, so that address check can work properly.
+			 */
+			seg = get_fs();
+			set_fs(USER_DS);
+			switch (insn.spec3_format.func) {
+			case lhe_op:
+				if (!access_ok(VERIFY_READ, addr, 2)) {
+					set_fs(seg);
+					goto sigbus;
+				}
+				LoadHWE(addr, value, res);
+				if (res) {
+					set_fs(seg);
+					goto fault;
+				}
+				compute_return_epc(regs);
+				regs->regs[insn.spec3_format.rt] = value;
+				break;
+			case lwe_op:
+				if (!access_ok(VERIFY_READ, addr, 4)) {
+					set_fs(seg);
+					goto sigbus;
+				}
 				LoadWE(addr, value, res);
-			if (res) {
-				set_fs(seg);
-				goto fault;
-			}
-			compute_return_epc(regs);
-			regs->regs[insn.spec3_format.rt] = value;
-			break;
-		case lhue_op:
-			if (!access_ok(VERIFY_READ, addr, 2)) {
-				set_fs(seg);
-				goto sigbus;
-			}
-			LoadHWUE(addr, value, res);
-			if (res) {
-				set_fs(seg);
-				goto fault;
-			}
-			compute_return_epc(regs);
-			regs->regs[insn.spec3_format.rt] = value;
-			break;
-		case she_op:
-			if (!access_ok(VERIFY_WRITE, addr, 2)) {
-				set_fs(seg);
-				goto sigbus;
-			}
-			compute_return_epc(regs);
-			value = regs->regs[insn.spec3_format.rt];
-			StoreHWE(addr, value, res);
-			if (res) {
-				set_fs(seg);
-				goto fault;
-			}
-			break;
-		case swe_op:
-			if (!access_ok(VERIFY_WRITE, addr, 4)) {
-				set_fs(seg);
-				goto sigbus;
-			}
-			compute_return_epc(regs);
-			value = regs->regs[insn.spec3_format.rt];
-			StoreWE(addr, value, res);
-			if (res) {
+				if (res) {
+					set_fs(seg);
+					goto fault;
+				}
+				compute_return_epc(regs);
+				regs->regs[insn.spec3_format.rt] = value;
+				break;
+			case lhue_op:
+				if (!access_ok(VERIFY_READ, addr, 2)) {
+					set_fs(seg);
+					goto sigbus;
+				}
+				LoadHWUE(addr, value, res);
+				if (res) {
+					set_fs(seg);
+					goto fault;
+				}
+				compute_return_epc(regs);
+				regs->regs[insn.spec3_format.rt] = value;
+				break;
+			case she_op:
+				if (!access_ok(VERIFY_WRITE, addr, 2)) {
+					set_fs(seg);
+					goto sigbus;
+				}
+				compute_return_epc(regs);
+				value = regs->regs[insn.spec3_format.rt];
+				StoreHWE(addr, value, res);
+				if (res) {
+					set_fs(seg);
+					goto fault;
+				}
+				break;
+			case swe_op:
+				if (!access_ok(VERIFY_WRITE, addr, 4)) {
+					set_fs(seg);
+					goto sigbus;
+				}
+				compute_return_epc(regs);
+				value = regs->regs[insn.spec3_format.rt];
+				StoreWE(addr, value, res);
+				if (res) {
+					set_fs(seg);
+					goto fault;
+				}
+				break;
+			default:
 				set_fs(seg);
-				goto fault;
+				goto sigill;
 			}
-			break;
-		default:
 			set_fs(seg);
-			goto sigill;
 		}
-		set_fs(seg);
-		break;
 #endif
+		break;
 	case lh_op:
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
-- 
2.7.4
