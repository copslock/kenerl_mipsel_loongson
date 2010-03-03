Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 20:08:25 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1324 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492294Ab0CCTH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 20:07:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8eb3940001>; Wed, 03 Mar 2010 11:08:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 11:07:49 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 11:07:48 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o23J7iAd027838;
        Wed, 3 Mar 2010 11:07:44 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o23J7ig2027837;
        Wed, 3 Mar 2010 11:07:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Remove #if 0 code.
Date:   Wed,  3 Mar 2010 11:07:43 -0800
Message-Id: <1267643263-27803-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 03 Mar 2010 19:07:49.0030 (UTC) FILETIME=[D0C4C460:01CABB04]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 4ba3277..a7f8c9d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -246,18 +246,6 @@ static void octeon_halt(void)
 	octeon_kill_core(NULL);
 }
 
-#if 0
-/**
- * Platform time init specifics.
- * Returns
- */
-void __init plat_time_init(void)
-{
-	/* Nothing special here, but we are required to have one */
-}
-
-#endif
-
 /**
  * Handle all the error condition interrupts that might occur.
  *
-- 
1.6.6.1
