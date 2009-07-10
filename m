Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 11:07:06 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35236 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491987AbZGJJGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 11:06:51 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A96js3024475
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 02:06:45 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 02:06:44 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A96ier021861;
	Fri, 10 Jul 2009 02:06:44 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH] Add missing memory barriers for correct operation of
	amon_cpu_start
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 02:06:38 -0700
Message-ID: <20090710090637.26302.42976.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 09:06:44.0802 (UTC) FILETIME=[BF534A20:01CA013D]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman (chris@mips.com)
---

 arch/mips/mti-malta/malta-amon.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index df9e526..469d9b0 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -70,11 +70,12 @@ void amon_cpu_start(int cpu,
 	launch->sp = sp;
 	launch->a0 = a0;
 
-	/* Make sure target sees parameters before the go bit */
-	smp_mb();
-
+	smp_wmb();              /* Target must see parameters before go */
 	launch->flags |= LAUNCH_FGO;
+	smp_wmb();              /* Target must see go before we poll  */
+
 	while ((launch->flags & LAUNCH_FGONE) == 0)
 		;
+	smp_rmb();      /* Target will be updating flags soon */
 	pr_debug("launch: cpu%d gone!\n", cpu);
 }
