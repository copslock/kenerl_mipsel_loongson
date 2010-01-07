Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 23:33:57 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4439 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492290Ab0AGWdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 23:33:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b46614d0003>; Thu, 07 Jan 2010 14:33:49 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 14:33:33 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 14:33:33 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o07MXV3O021689;
        Thu, 7 Jan 2010 14:33:31 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o07MXUSD021687;
        Thu, 7 Jan 2010 14:33:30 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Remove unused macros from barrier.h
Date:   Thu,  7 Jan 2010 14:33:30 -0800
Message-Id: <1262903610-21663-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 07 Jan 2010 22:33:33.0679 (UTC) FILETIME=[720877F0:01CA8FE9]
X-archive-position: 25547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5301

The smp_llsc_rmb() and smp_llsc_wmb() macros are not used in the tree,
remove them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/barrier.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 8e9ac31..91785dc 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -149,7 +149,5 @@
 	do { var = value; smp_mb(); } while (0)
 
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
-#define smp_llsc_rmb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
-#define smp_llsc_wmb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
 
 #endif /* __ASM_BARRIER_H */
-- 
1.6.0.6
