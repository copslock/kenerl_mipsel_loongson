Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 03:52:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15661 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491166Ab0D2BwK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 03:52:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd8e6560000>; Wed, 28 Apr 2010 18:52:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 18:52:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 18:52:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3T1q2rl001969;
        Wed, 28 Apr 2010 18:52:02 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3T1q1RV001968;
        Wed, 28 Apr 2010 18:52:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove leftover declarations.
Date:   Wed, 28 Apr 2010 18:51:59 -0700
Message-Id: <1272505919-1932-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 29 Apr 2010 01:52:06.0650 (UTC) FILETIME=[9291D5A0:01CAE73E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 5121a5b..e981277 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1003,15 +1003,6 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 }
 
 /*
- * TLB load/store/modify handlers.
- *
- * Only the fastpath gets synthesized at runtime, the slowpath for
- * do_page_fault remains normal asm.
- */
-extern void tlb_do_page_fault_0(void);
-extern void tlb_do_page_fault_1(void);
-
-/*
  * 128 instructions for the fastpath handler is generous and should
  * never be exceeded.
  */
-- 
1.6.6.1
