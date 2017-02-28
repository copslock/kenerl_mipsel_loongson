Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 16:40:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53760 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992267AbdB1PjTkirNK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 16:39:19 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2E27552E1ABFC;
        Tue, 28 Feb 2017 15:39:10 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 28 Feb 2017 15:39:13 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] MIPS: Stacktrace: Fix __usermode() of uninitialised regs
Date:   Tue, 28 Feb 2017 15:37:57 +0000
Message-ID: <1488296279-23057-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com>
References: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Commit 81a76d7119f6 ("MIPS: Avoid using unwind_stack() with usermode")
added a check if the passed regs are from user mode, and perform a raw
backtrace if so.
When WARN() is invoked, __dump_stack calls show_stack()
with NULL task and stack pointers. This leads show_stack to create a
pt_regs struct on the stack, and initialise it via prepare_frametrace().
When show_backtrace() examines the regs, the value of the status
register checked by user_mode() is unpredictable, depending on the
uninitialised content of the stack. This leads to show_backtrace()
sometimes showing raw backtraces instead of correctly walking the kernel
stack.

Fix this by initialising the contents of the saved status register in
prepare_frametrace().

Fixes: 81a76d7119f6 ("MIPS: Avoid using unwind_stack() with usermode")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/include/asm/stacktrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/stacktrace.h b/arch/mips/include/asm/stacktrace.h
index 780ee2c2a2ac..4845945d02a5 100644
--- a/arch/mips/include/asm/stacktrace.h
+++ b/arch/mips/include/asm/stacktrace.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_STACKTRACE_H
 #define _ASM_STACKTRACE_H
 
+#include <asm/asm.h>
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_KALLSYMS
@@ -47,6 +48,8 @@ static __always_inline void prepare_frametrace(struct pt_regs *regs)
 		: "=m" (regs->cp0_epc),
 		"=m" (regs->regs[29]), "=m" (regs->regs[31])
 		: : "memory");
+	/* show_backtrace behaviour depends on user_mode(regs) */
+	regs->cp0_status = read_c0_status();
 }
 
 #endif /* _ASM_STACKTRACE_H */
-- 
2.7.4
