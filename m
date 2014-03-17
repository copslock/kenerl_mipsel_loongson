Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2014 12:14:33 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:34582 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822478AbaCQLObnCYag (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2014 12:14:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 6C957180A8
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 12:14:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id NB4U48LQukJo for <linux-mips@linux-mips.org>;
        Mon, 17 Mar 2014 12:14:26 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 0AF7E180A2
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 12:14:26 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id E7DE9DEB
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 12:14:25 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id DBA7197E
        for <linux-mips@linux-mips.org>; Mon, 17 Mar 2014 12:14:25 +0100 (CET)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by seth.se.axis.com (Postfix) with ESMTP id D9DE23E048;
        Mon, 17 Mar 2014 12:14:25 +0100 (CET)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id C46624205B; Mon, 17 Mar 2014 12:14:25 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org
Cc:     Lars Persson <larper@axis.com>
Subject: [PATCH v2] MIPS: Fix syscall tracing interface
Date:   Mon, 17 Mar 2014 12:14:13 +0100
Message-Id: <1395054853-3465-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.2.5
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39481
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

Fix pointer computation for stack-based arguments.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/syscall.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index c71e40a..6c488c8 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -51,14 +51,14 @@ static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
 
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
-- 
1.7.2.5
