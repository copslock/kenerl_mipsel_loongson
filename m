Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2009 01:57:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16091 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493567AbZIJX5j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Sep 2009 01:57:39 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aa9926c0002>; Thu, 10 Sep 2009 16:57:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Sep 2009 16:57:04 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Sep 2009 16:57:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n8ANv03a002967;
	Thu, 10 Sep 2009 16:57:00 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n8ANv0xN002966;
	Thu, 10 Sep 2009 16:57:00 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: [PATCH 03/10] MIPS: Convert BUG() to use unreachable()
Date:	Thu, 10 Sep 2009 16:56:44 -0700
Message-Id: <1252627011-2933-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AA991C1.1050800@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
X-OriginalArrivalTime: 10 Sep 2009 23:57:04.0813 (UTC) FILETIME=[65BE95D0:01CA3272]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Use the new unreachable() macro instead of while(1);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: ralf@linux-mips.org
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
