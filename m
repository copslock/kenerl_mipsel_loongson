Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Dec 2009 02:51:32 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:1293 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494089AbZLEBv2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Dec 2009 02:51:28 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b19bbb10001>; Fri, 04 Dec 2009 20:47:29 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 20:51:22 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 17:45:02 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 17:45:02 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nB51ivKH024669;
        Fri, 4 Dec 2009 17:44:57 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nB51iv4b024668;
        Fri, 4 Dec 2009 17:44:57 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/5] MIPS: Convert BUG() to use unreachable()
Date:   Fri,  4 Dec 2009 17:44:52 -0800
Message-Id: <1259977494-24636-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4B19BAD3.1000808@caviumnetworks.com>
References: <4B19BAD3.1000808@caviumnetworks.com>
X-OriginalArrivalTime: 05 Dec 2009 01:45:02.0146 (UTC) FILETIME=[8FA5EA20:01CA754C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Use the new unreachable() macro instead of while(1);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
---
 arch/mips/include/asm/bug.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 6cf29c2..540c98a 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -11,9 +11,7 @@
 static inline void __noreturn BUG(void)
 {
 	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
-	/* Fool GCC into thinking the function doesn't return. */
-	while (1)
-		;
+	unreachable();
 }
 
 #define HAVE_ARCH_BUG
-- 
1.6.2.5
