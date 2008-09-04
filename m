Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2008 22:05:48 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:8401 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S36919627AbYIDVFq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2008 22:05:46 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KbM1R-0001JT-00; Thu, 04 Sep 2008 23:05:45 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 0FD1ADE3B6; Thu,  4 Sep 2008 23:05:45 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP22: Fix detection of second HPC3 on Challenge S
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080904210545.0FD1ADE3B6@solo.franken.de>
Date:	Thu,  4 Sep 2008 23:05:45 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

The second HPC3 coulde be found only on Guiness systems (Challenge-S),
but not on fullhouse (Indigo2) systems.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip22/ip22-platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index 9bbb90b..deddbf0 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -150,7 +150,7 @@ static int __init sgiseeq_devinit(void)
 		return res;
 
 	/* Second HPC is missing? */
-	if (!ip22_is_fullhouse() ||
+	if (ip22_is_fullhouse() ||
 	    get_dbe(tmp, (unsigned int *)&hpc3c1->pbdma[1]))
 		return 0;
 
