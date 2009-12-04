Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 02:44:08 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:14882 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494402AbZLDBoE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 02:44:04 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b1868790000>; Thu, 03 Dec 2009 20:40:09 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 3 Dec 2009 20:44:00 -0500
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 3 Dec 2009 17:43:58 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nB41htE2015112;
        Thu, 3 Dec 2009 17:43:56 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nB41hsOn015110;
        Thu, 3 Dec 2009 17:43:54 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Cleanup forgotten label_module_alloc in tlbex.c
Date:   Thu,  3 Dec 2009 17:43:54 -0800
Message-Id: <1259891034-15086-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 04 Dec 2009 01:43:58.0737 (UTC) FILETIME=[3F70B810:01CA7483]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

commit e0cc87f59490d7d62a8ab2a76498dc8a2b64927a left
label_module_alloc unused.  Remove it now.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 571f92f..3d6f48a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -73,9 +73,6 @@ static int __cpuinit m4kc_tlbp_war(void)
 enum label_id {
 	label_second_part = 1,
 	label_leave,
-#ifdef MODULE_START
-	label_module_alloc,
-#endif
 	label_vmalloc,
 	label_vmalloc_done,
 	label_tlbw_hazard,
@@ -92,9 +89,6 @@ enum label_id {
 
 UASM_L_LA(_second_part)
 UASM_L_LA(_leave)
-#ifdef MODULE_START
-UASM_L_LA(_module_alloc)
-#endif
 UASM_L_LA(_vmalloc)
 UASM_L_LA(_vmalloc_done)
 UASM_L_LA(_tlbw_hazard)
@@ -821,8 +815,6 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	} else {
 #if defined(CONFIG_HUGETLB_PAGE)
 		const enum label_id ls = label_tlb_huge_update;
-#elif defined(MODULE_START)
-		const enum label_id ls = label_module_alloc;
 #else
 		const enum label_id ls = label_vmalloc;
 #endif
-- 
1.6.0.6
