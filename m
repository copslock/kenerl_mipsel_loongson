Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2011 16:17:18 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:39470 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490984Ab1AWPRP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Jan 2011 16:17:15 +0100
Received: from localhost6.localdomain6 (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id p0NFH0iN023086;
        Sun, 23 Jan 2011 16:17:00 +0100
Message-Id: <20110123143837.128260362@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sun, 23 Jan 2011 15:17:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch 3/9] mips: Replace deprecated spinlock initialization
References: <20110123143631.392446736@linutronix.de>
Content-Disposition: inline;
        filename=mips-replace-deprecated-spinlock-initialization.patch
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

SPIN_LOCK_UNLOCK is deprecated. Use the lockdep capable variant
instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/vpe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/mips/kernel/vpe.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/vpe.c
+++ linux-2.6/arch/mips/kernel/vpe.c
@@ -148,9 +148,9 @@ struct {
 	spinlock_t tc_list_lock;
 	struct list_head tc_list;	/* Thread contexts */
 } vpecontrol = {
-	.vpe_list_lock	= SPIN_LOCK_UNLOCKED,
+	.vpe_list_lock	= __SPIN_LOCK_UNLOCKED(vpe_list_lock),
 	.vpe_list	= LIST_HEAD_INIT(vpecontrol.vpe_list),
-	.tc_list_lock	= SPIN_LOCK_UNLOCKED,
+	.tc_list_lock	= __SPIN_LOCK_UNLOCKED(tc_list_lock),
 	.tc_list	= LIST_HEAD_INIT(vpecontrol.tc_list)
 };
 
