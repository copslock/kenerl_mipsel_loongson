Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 11:14:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31366 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992675AbdF2JNAg23BW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 11:13:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8B45666AD4AFA;
        Thu, 29 Jun 2017 10:12:52 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Jun 2017 10:12:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] MIPS: Traced negative syscalls should return -ENOSYS
Date:   Thu, 29 Jun 2017 10:12:36 +0100
Message-ID: <4f9a8ba0f34ea6b363d79f7942a59746f897f35e.1498727356.git-series.james.hogan@imgtec.com>
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
X-archive-position: 58894
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

If a negative system call number is used when system call tracing is
enabled, syscall_trace_enter() will return that negative system call
number without having written the return value and error flag into the
pt_regs.

The caller then treats it as a cancelled system call and assumes that
the return value and error flag are already written, leaving the
negative system call number in the return register ($v0), and the 4th
system call argument in the error register ($a3).

Add a special case to detect this at the end of syscall_trace_enter(),
to set the return value to error -ENOSYS when this happens.

Fixes: d218af78492a ("MIPS: scall: Always run the seccomp syscall filters")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/ptrace.c | 7 +++++++
 1 file changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 8e2ea86dc23e..6dd13641a418 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -894,6 +894,13 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 
 	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
 			    regs->regs[6], regs->regs[7]);
+
+	/*
+	 * Negative syscall numbers are mistaken for rejected syscalls, but
+	 * won't have had the return value set appropriately, so we do so now.
+	 */
+	if (syscall < 0)
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
 	return syscall;
 }
 
-- 
git-series 0.8.10
