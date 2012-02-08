Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2012 13:54:00 +0100 (CET)
Received: from i118-21-156-233.s30.a048.ap.plala.or.jp ([118.21.156.233]:52827
        "EHLO rinabert.homeip.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903687Ab2BHMxx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2012 13:53:53 +0100
Received: from rinabert.homeip.net (localhost [127.0.0.1])
        by rinabert.homeip.net (8.14.5/8.14.5) with ESMTP id q18Crgvi002574;
        Wed, 8 Feb 2012 21:53:43 +0900
Received: (from iida@localhost)
        by rinabert.homeip.net (8.14.5/8.14.5/Submit) id q18CrVXx002567;
        Wed, 8 Feb 2012 21:53:31 +0900
From:   Masanari Iida <standby24x7@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        standby24x7@gmail.com
Subject: [PATCH] [trivial] mips: Fix typo in traps.c
Date:   Wed,  8 Feb 2012 21:53:14 +0900
Message-Id: <1328705594-2533-1-git-send-email-standby24x7@gmail.com>
X-Mailer: git-send-email 1.7.6.5
X-archive-position: 32411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: standby24x7@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6433

Correct spelling "Schedulier" to "Scheduler" in
arch/mips/kernel/traps.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/mips/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cc4a3f1..d79ae54 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1135,7 +1135,7 @@ asmlinkage void do_mt(struct pt_regs *regs)
 		printk(KERN_DEBUG "YIELD Scheduler Exception\n");
 		break;
 	case 5:
-		printk(KERN_DEBUG "Gating Storage Schedulier Exception\n");
+		printk(KERN_DEBUG "Gating Storage Scheduler Exception\n");
 		break;
 	default:
 		printk(KERN_DEBUG "*** UNKNOWN THREAD EXCEPTION %d ***\n",
-- 
1.7.6.5
