Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2012 14:38:14 +0100 (CET)
Received: from i118-21-156-233.s30.a048.ap.plala.or.jp ([118.21.156.233]:53981
        "EHLO rinabert.homeip.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903650Ab2A1NiH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jan 2012 14:38:07 +0100
Received: from rinabert.homeip.net (localhost [127.0.0.1])
        by rinabert.homeip.net (8.14.5/8.14.5) with ESMTP id q0SDbLJL007437;
        Sat, 28 Jan 2012 22:37:21 +0900
Received: (from root@localhost)
        by rinabert.homeip.net (8.14.5/8.14.5/Submit) id q0SDbDuW007436;
        Sat, 28 Jan 2012 22:37:13 +0900
From:   Masanari Iida <standby24x7@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     standby24x7@gmail.com, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH] [trivial] mips: Fix typo in bcm63xx/setup.c
Date:   Sat, 28 Jan 2012 22:36:56 +0900
Message-Id: <1327757816-7401-1-git-send-email-standby24x7@gmail.com>
X-Mailer: git-send-email 1.7.6.5
X-archive-position: 32318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: standby24x7@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Correct spelling "reseting" to "resetting" in
arch/mips/bcm63xx/setup.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/mips/bcm63xx/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index d209f85..356b055 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -33,7 +33,7 @@ static void bcm6348_a1_reboot(void)
 	u32 reg;
 
 	/* soft reset all blocks */
-	printk(KERN_INFO "soft-reseting all blocks ...\n");
+	printk(KERN_INFO "soft-resetting all blocks ...\n");
 	reg = bcm_perf_readl(PERF_SOFTRESET_REG);
 	reg &= ~SOFTRESET_6348_ALL;
 	bcm_perf_writel(reg, PERF_SOFTRESET_REG);
-- 
1.7.6.5
