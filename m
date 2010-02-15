Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 19:34:07 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18438 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492112Ab0BOSeE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 19:34:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7993a20000>; Mon, 15 Feb 2010 10:34:11 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 10:34:00 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 10:34:00 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1FIXw90017879;
        Mon, 15 Feb 2010 10:33:58 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1FIXu0o017878;
        Mon, 15 Feb 2010 10:33:56 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix RIXI patch for au1000 processors.
Date:   Mon, 15 Feb 2010 10:33:21 -0800
Message-Id: <1266258801-17841-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
X-OriginalArrivalTime: 15 Feb 2010 18:34:00.0919 (UTC) FILETIME=[714F9670:01CAAE6D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Several macros need to be defined even though they are only used in
dead code paths.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/pgtable-bits.h |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index a2e646f..e9fe7e9 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -66,7 +66,6 @@
 #define _PAGE_SILENT_WRITE          (1<<10)
 #define _CACHE_UNCACHED             (1<<11)
 #define _CACHE_MASK                 (1<<11)
-#define _PFN_SHIFT                  PAGE_SHIFT
 
 #else /* 'Normal' r4K case */
 /*
@@ -129,10 +128,26 @@
 #define _CACHE_MASK		(7 << _CACHE_SHIFT)
 
 #define _PFN_SHIFT		(PAGE_SHIFT - 12 + _CACHE_SHIFT + 3)
-#define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
 
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR && defined(CONFIG_CPU_MIPS32) */
 
+#ifndef _PFN_SHIFT
+#define _PFN_SHIFT                  PAGE_SHIFT
+#endif
+#define _PFN_MASK		(~((1 << (_PFN_SHIFT)) - 1))
+
+#ifndef _PAGE_NO_READ
+#define _PAGE_NO_READ ({BUG(); 0; })
+#define _PAGE_NO_READ_SHIFT ({BUG(); 0; })
+#endif
+#ifndef _PAGE_NO_EXEC
+#define _PAGE_NO_EXEC ({BUG(); 0; })
+#endif
+#ifndef _PAGE_GLOBAL_SHIFT
+#define _PAGE_GLOBAL_SHIFT ilog2(_PAGE_GLOBAL)
+#endif
+
+
 #ifndef __ASSEMBLY__
 /*
  * pte_to_entrylo converts a page table entry (PTE) into a Mips
@@ -148,9 +163,9 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 		sa = 63 - _PAGE_NO_READ_SHIFT;
 #endif
 		/*
-		 * C has no way to express that this is a DSRL 5
-		 * followed by a ROTR 2.  Luckily in the fast path
-		 * this is done in assembly
+		 * C has no way to express that this is a DSRL
+		 * _PAGE_NO_EXEC_SHIFT followed by a ROTR 2.  Luckily
+		 * in the fast path this is done in assembly
 		 */
 		return (pte_val >> _PAGE_GLOBAL_SHIFT) |
 			((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
-- 
1.6.6
