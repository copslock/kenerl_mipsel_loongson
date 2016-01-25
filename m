Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 21:32:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36750 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011442AbcAYUcTB-v8f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2016 21:32:19 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 0A6E8D4A8CE8F;
        Mon, 25 Jan 2016 20:32:07 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 25 Jan 2016 20:32:10 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 25 Jan 2016 20:32:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Milko Leporis <milko.leporis@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix buffer overflow in syscall_get_arguments()
Date:   Mon, 25 Jan 2016 20:32:03 +0000
Message-ID: <1453753923-26620-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Since commit 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls
(o32)"), syscall_get_arguments() attempts to handle o32 indirect syscall
arguments by incrementing both the start argument number and the number
of arguments to fetch. However only the start argument number needs to
be incremented. The number of arguments does not change, they're just
shifted up by one, and in fact the output array is provided by the
caller and is likely only n entries long, so reading more arguments
overflows the output buffer.

In the case of seccomp, this results in it fetching 7 arguments starting
at the 2nd one, which overflows the unsigned long args[6] in
populate_seccomp_data(). This clobbers the $s0 register from
syscall_trace_enter() which __seccomp_phase1_filter() saved onto the
stack, into which syscall_trace_enter() had placed its syscall number
argument. This caused Chromium to crash.

Credit goes to Milko for tracking it down as far as $s0 being clobbered.

Fixes: 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
Reported-by: Milko Leporis <milko.leporis@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15-
---
 arch/mips/include/asm/syscall.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 6499d93ae68d..47bc45a67e9b 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -101,10 +101,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
 	if ((config_enabled(CONFIG_32BIT) ||
 	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
-	    (regs->regs[2] == __NR_syscall)) {
+	    (regs->regs[2] == __NR_syscall))
 		i++;
-		n++;
-	}
 
 	while (n--)
 		ret |= mips_get_syscall_arg(args++, task, regs, i++);
-- 
2.4.10
