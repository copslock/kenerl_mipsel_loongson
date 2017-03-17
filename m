Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2017 10:56:27 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:55319 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993418AbdCQJ4U5d2qY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2017 10:56:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id BCC7E18104;
        Fri, 17 Mar 2017 10:56:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id m4J8VY58gP3W; Fri, 17 Mar 2017 10:56:14 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 1D925181A6;
        Fri, 17 Mar 2017 10:56:14 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1EFA1E07E;
        Fri, 17 Mar 2017 10:56:13 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E70831E05C;
        Fri, 17 Mar 2017 10:56:13 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri, 17 Mar 2017 10:56:13 +0100 (CET)
Received: from lnxlarper1.se.axis.com (lnxlarper1.se.axis.com [10.88.41.2])
        by seth.se.axis.com (Postfix) with ESMTP id DC264E90;
        Fri, 17 Mar 2017 10:56:13 +0100 (CET)
Received: by lnxlarper1.se.axis.com (Postfix, from userid 20456)
        id D74BB800FD; Fri, 17 Mar 2017 10:56:13 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Lars Persson <larper@axis.com>
Subject: [PATCH] MIPS: disable page faults in syscall_get_arguments
Date:   Fri, 17 Mar 2017 10:56:10 +0100
Message-Id: <1489744570-16929-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 2.1.4
X-TM-AS-GCONF: 00
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

We call a sleeping function in MIPS' get_syscall_arguments to read
from the userspace stack. Disable page faults around these calls to
prevent sleep in atomic contexts.

The problem was observed as the following splat with ftrace system
call tracing enabled:

BUG: sleeping function called from invalid context at arch/mips/include/asm/syscall.h:48
in_atomic(): 1, irqs_disabled(): 0, pid: 1389, name: sh
Preemption disabled at:
[<801d31d4>] __fd_install+0x50/0x194
CPU: 2 PID: 1389 Comm: sh Not tainted 4.9.14-axis4-devel #6
Stack : 809d7bfa 0000003b 00000000 00000000 00000000 00000000 800a5438 808c3507
        8e77599c 0000056d 00000002 809c4f44 8fc060e0 8dc07f68 00000005 800a5468
        00000005 80403b30 00000000 00000000 807f5b64 8dc07e0c 8dc07df4 8014a36c
        00000000 8004927c 809d7bf8 00000024 8dc07e0c 00000000 00000002 807eaf58
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        ...
Call Trace:
[<80021a68>] show_stack+0x94/0xb0
[<803f4e38>] dump_stack+0x98/0xd0
[<80074838>] ___might_sleep+0x160/0x1e4
[<801205f8>] ftrace_syscall_enter+0x1c8/0x3ac
[<8001f77c>] syscall_trace_enter+0x18c/0x1f8
[<8002b3f8>] syscall_trace_entry+0x44/0x94

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/syscall.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index d878825..270a6d5 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -104,8 +104,10 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	    (regs->regs[2] == __NR_syscall))
 		i++;
 
+	pagefault_disable();
 	while (n--)
 		ret |= mips_get_syscall_arg(args++, task, regs, i++);
+	pagefault_enable();
 
 	/*
 	 * No way to communicate an error because this is a void function.
-- 
2.1.4
