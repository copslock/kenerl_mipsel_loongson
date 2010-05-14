Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 21:45:26 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11776 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491982Ab0ENTpW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 21:45:22 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4beda8600000>; Fri, 14 May 2010 12:45:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 14 May 2010 12:44:25 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 14 May 2010 12:44:25 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4EJiMFI002258;
        Fri, 14 May 2010 12:44:22 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4EJiJGM002257;
        Fri, 14 May 2010 12:44:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use GCC __builtin_prefetch() to implement prefetch().
Date:   Fri, 14 May 2010 12:44:18 -0700
Message-Id: <1273866258-2223-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 14 May 2010 19:44:25.0210 (UTC) FILETIME=[DB893DA0:01CAF39D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

GCC's __builtin_prefetch() was introduced a long time ago, all
supported GCC versions have it.  Lets do what the big boys up in
linux/prefetch.h do, except we use '1' as the third parameter to
provoke 'PREF 0,...'  and 'PREF 1,...' instead of other prefetch
hints.

This allows for better code generation.  In theory the existing
embedded asm could be optimized, but the compiler has these builtins,
so there is really no point.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/processor.h |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index ab38791..5d33b72 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -344,16 +344,10 @@ unsigned long get_wchan(struct task_struct *p);
 #ifdef CONFIG_CPU_HAS_PREFETCH
 
 #define ARCH_HAS_PREFETCH
+#define prefetch(x) __builtin_prefetch((x), 0, 1)
 
-static inline void prefetch(const void *addr)
-{
-	__asm__ __volatile__(
-	"	.set	mips4		\n"
-	"	pref	%0, (%1)	\n"
-	"	.set	mips0		\n"
-	:
-	: "i" (Pref_Load), "r" (addr));
-}
+#define ARCH_HAS_PREFETCHW
+#define prefetchw(x) __builtin_prefetch((x), 1, 1)
 
 #endif
 
-- 
1.6.6.1
