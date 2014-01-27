Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:30:44 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43619 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870552AbaA0UYDxGxUq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 31/58] MIPS: kernel: unaligned: Handle unaligned accesses for EVA
Date:   Mon, 27 Jan 2014 20:19:18 +0000
Message-ID: <1390853985-14246-32-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_59
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Handle unaligned accesses when we access userspace memory
EVA mode.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/unaligned.c | 86 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 5ec8f00..2b35172 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -431,7 +431,9 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	unsigned long origpc;
 	unsigned long orig31;
 	void __user *fault_addr = NULL;
-
+#ifdef	CONFIG_EVA
+	mm_segment_t seg;
+#endif
 	origpc = (unsigned long)pc;
 	orig31 = regs->regs[31];
 
@@ -476,6 +478,88 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		 * The remaining opcodes are the ones that are really of
 		 * interest.
 		 */
+#ifdef CONFIG_EVA
+	case spec3_op:
+		/*
+		 * we can land here only from kernel accessing user memory,
+		 * so we need to "switch" the address limit to user space, so
+		 * address check can work properly.
+		 */
+		seg = get_fs();
+		set_fs(USER_DS);
+		switch (insn.spec3_format.func) {
+		case lhe_op:
+			if (!access_ok(VERIFY_READ, addr, 2)) {
+				set_fs(seg);
+				goto sigbus;
+			}
+			LoadHW(addr, value, res);
+			if (res) {
+				set_fs(seg);
+				goto fault;
+			}
+			compute_return_epc(regs);
+			regs->regs[insn.spec3_format.rt] = value;
+			break;
+		case lwe_op:
+			if (!access_ok(VERIFY_READ, addr, 4)) {
+				set_fs(seg);
+				goto sigbus;
+			}
+				LoadW(addr, value, res);
+			if (res) {
+				set_fs(seg);
+				goto fault;
+			}
+			compute_return_epc(regs);
+			regs->regs[insn.spec3_format.rt] = value;
+			break;
+		case lhue_op:
+			if (!access_ok(VERIFY_READ, addr, 2)) {
+				set_fs(seg);
+				goto sigbus;
+			}
+			LoadHWU(addr, value, res);
+			if (res) {
+				set_fs(seg);
+				goto fault;
+			}
+			compute_return_epc(regs);
+			regs->regs[insn.spec3_format.rt] = value;
+			break;
+		case she_op:
+			if (!access_ok(VERIFY_WRITE, addr, 2)) {
+				set_fs(seg);
+				goto sigbus;
+			}
+			compute_return_epc(regs);
+			value = regs->regs[insn.spec3_format.rt];
+			StoreHW(addr, value, res);
+			if (res) {
+				set_fs(seg);
+				goto fault;
+			}
+			break;
+		case swe_op:
+			if (!access_ok(VERIFY_WRITE, addr, 4)) {
+				set_fs(seg);
+				goto sigbus;
+			}
+			compute_return_epc(regs);
+			value = regs->regs[insn.spec3_format.rt];
+			StoreW(addr, value, res);
+			if (res) {
+				set_fs(seg);
+				goto fault;
+			}
+			break;
+		default:
+			set_fs(seg);
+			goto sigill;
+		}
+		set_fs(seg);
+		break;
+#endif
 	case lh_op:
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
-- 
1.8.5.3
