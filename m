Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:35:24 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:61052 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133794AbWHCHaO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:14 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939695nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H515uSuTIr4+ErLSjYXkPkBr3pMSl34zdUtWwJv6hHDKnPHiH3kN/+PTQUcpEi4FhCx7OY6I36PYGp65cG0uSBs1jSfdIAodIp26JlDlzEQ4a8TcV0jeEri9AO/kYVpLq3X2p02VYUDdGtT99vKbmDqA38o0+j+BroHGyP7Y/RA=
Received: by 10.49.8.1 with SMTP id l1mr3373636nfi;
        Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id a23sm656291nfc.2006.08.03.00.30.13;
        Thu, 03 Aug 2006 00:30:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0951D23F773; Thu,  3 Aug 2006 09:29:21 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 5/7] Simplify dump_stack()
Date:	Thu,  3 Aug 2006 09:29:19 +0200
Message-Id: <11545901613246-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Make dump_stack() code not depend on CONFIG_KALLSYMS.

It also make prepare_frametrace() always inlined to get
less false entries reported by show_raw_backtrace().

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/traps.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 549cbb8..303f008 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -158,7 +158,7 @@ static void show_stacktrace(struct task_
 	show_backtrace(task, regs);
 }
 
-static noinline void prepare_frametrace(struct pt_regs *regs)
+static __always_inline void prepare_frametrace(struct pt_regs *regs)
 {
 	__asm__ __volatile__(
 		"1: la $2, 1b\n\t"
@@ -200,17 +200,15 @@ void show_stack(struct task_struct *task
  */
 void dump_stack(void)
 {
-	unsigned long stack;
+	struct pt_regs regs;
 
-#ifdef CONFIG_KALLSYMS
-	if (!raw_show_trace) {
-		struct pt_regs regs;
-		prepare_frametrace(&regs);
-		show_backtrace(current, &regs);
-		return;
-	}
-#endif
-	show_raw_backtrace(&stack);
+	/*
+	 * Remove any garbage that may be in regs (specially func
+	 * addresses) to avoid show_raw_backtrace() to report them
+	 */
+	memset(&regs, 0, sizeof(regs));
+	prepare_frametrace(&regs);
+	show_backtrace(current, &regs);
 }
 
 EXPORT_SYMBOL(dump_stack);
-- 
1.4.2.rc2
