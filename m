Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 11:13:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2945 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992127AbdF2JM7Yst3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 11:12:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6281FB6C3AB79;
        Thu, 29 Jun 2017 10:12:51 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Jun 2017 10:12:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] MIPS: Correct forced syscall errors
Date:   Thu, 29 Jun 2017 10:12:35 +0100
Message-ID: <58b46185258854a99f37ea11efdf55219e479cef.1498727356.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <cover.7467c3bd7867c61afc334e409c93dac28541f5e6.1498727356.git-series.james.hogan@imgtec.com>
References: <cover.7467c3bd7867c61afc334e409c93dac28541f5e6.1498727356.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58893
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

When the system call return value is forced to be an error (for example
due to SECCOMP_RET_ERRNO), syscall_set_return_value() puts the error
code in the return register $v0 and -1 in the error register $a3.

However normally executed system calls put 1 in the error register
rather than -1, so fix syscall_set_return_value() to be consistent with
that.

I don't anticipate that anything would have been broken by this, since
the most natural way to check the error register on MIPS would be a
conditional branch if error register is [not] equal to zero (bnez or
beqz).

Fixes: 1d7bf993e073 ("MIPS: ftrace: Add support for syscall tracepoints.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index d87882513ee3..7c713025b23f 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -85,7 +85,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 {
 	if (error) {
 		regs->regs[2] = -error;
-		regs->regs[7] = -1;
+		regs->regs[7] = 1;
 	} else {
 		regs->regs[2] = val;
 		regs->regs[7] = 0;
-- 
git-series 0.8.10
