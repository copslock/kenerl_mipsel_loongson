Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Sep 2011 03:06:16 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8112 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491189Ab1IQBGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Sep 2011 03:06:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e73f2c80000>; Fri, 16 Sep 2011 18:07:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 16 Sep 2011 18:06:06 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 16 Sep 2011 18:06:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8H165GY000350;
        Fri, 16 Sep 2011 18:06:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8H163QP000349;
        Fri, 16 Sep 2011 18:06:03 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: No branches in delay slots for huge pages in handle_tlbl
Date:   Fri, 16 Sep 2011 18:06:02 -0700
Message-Id: <1316221562-315-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 17 Sep 2011 01:06:06.0888 (UTC) FILETIME=[FAA51280:01CC74D5]
X-archive-position: 31097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8890

For the case PM_DEFAULT_MASK == 0, we were placing a branch in the
delay slot of another branch.  This leads to undefined behavior.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/tlbex.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 46f33c7..e06370f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1962,7 +1962,8 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 			uasm_i_andi(&p, wr.r3, wr.r3, 2);
 			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround2);
 		}
-
+		if (PM_DEFAULT_MASK == 0)
+			uasm_i_nop(&p);
 		/*
 		 * We clobbered C0_PAGEMASK, restore it.  On the other branch
 		 * it is restored in build_huge_tlb_write_entry.
-- 
1.7.2.3
