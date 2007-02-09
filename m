Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 15:10:07 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.238]:16010 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038767AbXBIPJg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 15:09:36 +0000
Received: by qb-out-0506.google.com with SMTP id e12so191986qba
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 07:08:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=covEI7rV+DYBPHG6BzgSO4OzyckE74rFFd66JmckX09x2eeXYmX9rsZFtjEXGMCNOUgYLTwAteeQ/FmwrDYe/TisIbwuauBkZyewe6hO7Y7xPgBAzpuFlk9TdK1GVTGzAKrXJ/ZaM6ly/6W6e0j3h+Z9xRLag2ohvyxereM6mBQ=
Received: by 10.64.10.2 with SMTP id 2mr15978026qbj.1171033715214;
        Fri, 09 Feb 2007 07:08:35 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id q13sm3530341qbq.2007.02.09.07.08.33;
        Fri, 09 Feb 2007 07:08:34 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A848323F772; Fri,  9 Feb 2007 16:07:39 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 1/3] signal: avoid useless test in do_signal()
Date:	Fri,  9 Feb 2007 16:07:36 +0100
Message-Id: <11710336594091-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1171033658561-git-send-email-fbuihuu@gmail.com>
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Indeed we can simply clear the flag whatever its value

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 8dfb7b1..464d34b 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -552,10 +552,8 @@ void do_signal(struct pt_regs *regs)
 			 * and will be restored by sigreturn, so we can simply
 			 * clear the TIF_RESTORE_SIGMASK flag.
 			 */
-			if (test_thread_flag(TIF_RESTORE_SIGMASK))
-				clear_thread_flag(TIF_RESTORE_SIGMASK);
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
 		}
-
 		return;
 	}
 
-- 
1.4.4.3.ge6d4
