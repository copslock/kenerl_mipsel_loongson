Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:23:25 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43573 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827334AbaA0UVbPzM5r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:21:31 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 09/58] MIPS: traps: Set correct address limit for breakpoints and traps
Date:   Mon, 27 Jan 2014 20:18:56 +0000
Message-ID: <1390853985-14246-10-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_21_31
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39127
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

When a breakpoint or trap happens when operating in kernel mode but
on users behalf (eg syscall) it is necessary to change the address
limit to KERNEL_DS so any address checking can be bypassed and print
the correct stack trace.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3e5e700..a5a74d6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -862,6 +862,11 @@ asmlinkage void do_bp(struct pt_regs *regs)
 	enum ctx_state prev_state;
 	unsigned long epc;
 	u16 instr[2];
+	mm_segment_t seg;
+
+	seg = get_fs();
+	if (!user_mode(regs))
+		set_fs(KERNEL_DS);
 
 	prev_state = exception_enter();
 	if (get_isa16_mode(regs->cp0_epc)) {
@@ -921,6 +926,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
 	do_trap_or_bp(regs, bcode, "Break");
 
 out:
+	set_fs(seg);
 	exception_exit(prev_state);
 	return;
 
@@ -934,8 +940,13 @@ asmlinkage void do_tr(struct pt_regs *regs)
 	u32 opcode, tcode = 0;
 	enum ctx_state prev_state;
 	u16 instr[2];
+	mm_segment_t seg;
 	unsigned long epc = msk_isa16_mode(exception_epc(regs));
 
+	seg = get_fs();
+	if (!user_mode(regs))
+		set_fs(get_ds());
+
 	prev_state = exception_enter();
 	if (get_isa16_mode(regs->cp0_epc)) {
 		if (__get_user(instr[0], (u16 __user *)(epc + 0)) ||
@@ -956,6 +967,7 @@ asmlinkage void do_tr(struct pt_regs *regs)
 	do_trap_or_bp(regs, tcode, "Trap");
 
 out:
+	set_fs(seg);
 	exception_exit(prev_state);
 	return;
 
-- 
1.8.5.3
