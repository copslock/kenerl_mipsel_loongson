Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:45:27 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012263AbbHNRnL45Ek1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:43:11 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 974DD8E4;
        Fri, 14 Aug 2015 17:43:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 07/84] MIPS: show_stack: Fix stack trace with EVA
Date:   Fri, 14 Aug 2015 10:41:35 -0700
Message-Id: <20150814174210.436830888@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48905
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

4.1-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/traps.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -192,6 +192,7 @@ static void show_stacktrace(struct task_
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	struct pt_regs regs;
+	mm_segment_t old_fs = get_fs();
 	if (sp) {
 		regs.regs[29] = (unsigned long)sp;
 		regs.regs[31] = 0;
@@ -210,7 +211,13 @@ void show_stack(struct task_struct *task
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
