Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 14:51:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63241 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011247AbbG0MvCdrp20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 14:51:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CCB837C8E77AB;
        Mon, 27 Jul 2015 13:50:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 13:50:56 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 27 Jul 2015 13:50:56 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: show_stack: Fix stack trace with EVA
Date:   Mon, 27 Jul 2015 13:50:22 +0100
Message-ID: <1438001422-20910-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1438001422-20910-1-git-send-email-james.hogan@imgtec.com>
References: <1438001422-20910-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48434
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

The show_stack() function deals exclusively with kernel contexts, but if
it gets called in user context with EVA enabled, show_stacktrace() will
attempt to access the stack using EVA accesses, which will either read
other user mapped data, or more likely cause an exception which will be
handled by __get_user().

This is easily reproduced using SysRq t to show all task states, which
results in the following stack dump output:

 Stack : (Bad stack address)

Fix by setting the current user access mode to kernel around the call to
show_stacktrace(). This causes __get_user() to use normal loads to read
the kernel stack.

Now we get the correct output, like this:

 Stack : 00000000 80168960 00000000 004a0000 00000000 00000000 8060016c 1f3abd0c
           1f172cd8 8056f09c 7ff1e450 8014fc3c 00000001 806dd0b0 0000001d 00000002
           1f17c6a0 1f17c804 1f17c6a0 8066f6e0 00000000 0000000a 00000000 00000000
           00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000 00000000 0110e800 1f3abd6c 1f17c6a0
           ...

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
---
 arch/mips/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 02484d17fb6f..8ea28e6ab37d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -192,6 +192,7 @@ static void show_stacktrace(struct task_struct *task,
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	struct pt_regs regs;
+	mm_segment_t old_fs = get_fs();
 	if (sp) {
 		regs.regs[29] = (unsigned long)sp;
 		regs.regs[31] = 0;
@@ -210,7 +211,13 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 			prepare_frametrace(&regs);
 		}
 	}
+	/*
+	 * show_stack() deals exclusively with kernel mode, so be sure to access
+	 * the stack in the kernel (not user) address space.
+	 */
+	set_fs(KERNEL_DS);
 	show_stacktrace(task, &regs);
+	set_fs(old_fs);
 }
 
 static void show_code(unsigned int __user *pc)
-- 
2.3.6
