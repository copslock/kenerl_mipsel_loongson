Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2015 15:10:24 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:60573 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013560AbbIDNJ3eqdFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Sep 2015 15:09:29 +0200
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1ZXqkC-0006VA-Mg; Fri, 04 Sep 2015 13:09:28 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 053/130] MIPS: show_stack: Fix stack trace with EVA
Date:   Fri,  4 Sep 2015 14:07:21 +0100
Message-Id: <1441372118-5933-54-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1441372118-5933-1-git-send-email-luis.henriques@canonical.com>
References: <1441372118-5933-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt17 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 1e77863a51698c4319587df34171bd823691a66a upstream.

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
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10778/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a47405caa0b7..027fefba8b96 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -189,6 +189,7 @@ static void show_stacktrace(struct task_struct *task,
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	struct pt_regs regs;
+	mm_segment_t old_fs = get_fs();
 	if (sp) {
 		regs.regs[29] = (unsigned long)sp;
 		regs.regs[31] = 0;
@@ -207,7 +208,13 @@ void show_stack(struct task_struct *task, unsigned long *sp)
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
