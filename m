Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 12:42:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56748 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491207Ab0JNKlr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Oct 2010 12:41:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9EAfkWB029680
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2010 11:41:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9EAfkSD029679
        for linux-mips@linux-mips.org; Thu, 14 Oct 2010 11:41:46 +0100
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 14 Oct 2010 11:41:46 +0100
Resent-Message-ID: <20101014104146.GB28911@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from zeniv.linux.org.uk ([195.92.253.2]:46419 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491967Ab0I1Ru1 (ORCPT <rfc822;ralf@linux-mips.org>);
        Tue, 28 Sep 2010 19:50:27 +0200
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
        id 1P0eJv-0006iz-4d; Tue, 28 Sep 2010 17:50:27 +0000
Date:   Tue, 28 Sep 2010 18:50:27 +0100
To:     ralf@linux-mips.org
Subject: [PATCH 2/5] mips: syscall number in in R2, not R0...
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
User-Agent: Heirloom mailx 12.4 7/29/08
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1P0eJv-0006iz-4d@ZenIV.linux.org.uk>
From:   Al Viro <viro@ftp.linux.org.uk>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips


as it is, audit_syscall_entry() and secure_computing() get the
bogus value (0, in fact)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/ptrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c51b95f..c877733 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -536,7 +536,7 @@ asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	/* do the secure computing check first */
 	if (!entryexit)
-		secure_computing(regs->regs[0]);
+		secure_computing(regs->regs[2]);
 
 	if (unlikely(current->audit_context) && entryexit)
 		audit_syscall_exit(AUDITSC_RESULT(regs->regs[2]),
@@ -565,7 +565,7 @@ asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 
 out:
 	if (unlikely(current->audit_context) && !entryexit)
-		audit_syscall_entry(audit_arch(), regs->regs[0],
+		audit_syscall_entry(audit_arch(), regs->regs[2],
 				    regs->regs[4], regs->regs[5],
 				    regs->regs[6], regs->regs[7]);
 }
-- 
1.5.6.5
