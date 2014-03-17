Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2014 08:41:38 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:41496 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824787AbaCQHl1nhVOx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Mar 2014 08:41:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 78DED2E4CB
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 08:41:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5vTfVoPseFhJ for <linux-mips@linux-mips.org>;
        Mon, 17 Mar 2014 08:41:19 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id CD03A2E4C8
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 08:41:19 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id ADD7C916
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 08:41:19 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id A15E4CEF
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 08:41:19 +0100 (CET)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by seth.se.axis.com (Postfix) with ESMTP id 9F4A73E048;
        Mon, 17 Mar 2014 08:41:19 +0100 (CET)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id 726924205B; Mon, 17 Mar 2014 08:41:19 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org
Cc:     Lars Persson <larper@axis.com>
Subject: [PATCH] MIPS: Fix syscall tracing interface
Date:   Mon, 17 Mar 2014 08:40:21 +0100
Message-Id: <1395042021-6186-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.2.5
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39478
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

The MIPS syscall tracing interface had multiple bugs
that made it completely unusable.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/syscall.h |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 81c8913..8d08b6f 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -39,14 +39,14 @@ static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
 
 #ifdef CONFIG_32BIT
 	case 4: case 5: case 6: case 7:
-		return get_user(*arg, (int *)usp + 4 * n);
+		return get_user(*arg, (int *)usp + n);
 #endif
 
 #ifdef CONFIG_64BIT
 	case 4: case 5: case 6: case 7:
 #ifdef CONFIG_MIPS32_O32
 		if (test_thread_flag(TIF_32BIT_REGS))
-			return get_user(*arg, (int *)usp + 4 * n);
+			return get_user(*arg, (int *)usp + n);
 		else
 #endif
 			*arg = regs->regs[4 + n];
@@ -83,18 +83,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	unsigned long arg;
-	int ret;
-
 	while (n--)
-		ret |= mips_get_syscall_arg(&arg, task, regs, i++);
-
-	/*
-	 * No way to communicate an error because this is a void function.
-	 */
-#if 0
-	return ret;
-#endif
+		mips_get_syscall_arg(args++, task, regs, i++);
 }
 
 extern const unsigned long sys_call_table[];
-- 
1.7.2.5
