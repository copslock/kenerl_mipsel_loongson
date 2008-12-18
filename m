Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 02:33:21 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6674 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207351AbYLRCdT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 02:33:19 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4949b6690006>; Wed, 17 Dec 2008 21:33:13 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 18:24:13 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 18:24:13 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBI2O9Qv019245;
	Wed, 17 Dec 2008 18:24:09 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBI2O82D019243;
	Wed, 17 Dec 2008 18:24:08 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
Date:	Wed, 17 Dec 2008 18:24:08 -0800
Message-Id: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
X-OriginalArrivalTime: 18 Dec 2008 02:24:13.0269 (UTC) FILETIME=[B79ED050:01C960B7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is an incomplete proof of concept that I applied to be able to
build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit case
or the R4000_WAR case.

Comments welcome.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/compiler.h |    7 +++++++
 arch/mips/include/asm/delay.h    |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index 71f5c5c..1f0954d 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -16,4 +16,11 @@
 #define GCC_REG_ACCUM "accum"
 #endif
 
+#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+#define GCC_NO_H_CONSTRAINT
+#ifdef CONFIG_64BIT
+typedef unsigned int uint128_t __attribute__((mode(TI)));
+#endif
+#endif
+
 #endif /* _ASM_COMPILER_H */
diff --git a/arch/mips/include/asm/delay.h b/arch/mips/include/asm/delay.h
index b0bccd2..3e467e8 100644
--- a/arch/mips/include/asm/delay.h
+++ b/arch/mips/include/asm/delay.h
@@ -83,10 +83,14 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
 		: "r" (usecs), "r" (lpj)
 		: GCC_REG_ACCUM);
 	else if (sizeof(long) == 8 && !R4000_WAR)
+#ifdef GCC_NO_H_CONSTRAINT
+		usecs = ((uint128_t)usecs * lpj) >> 64;
+#else
 		__asm__("dmultu\t%2, %3"
 		: "=h" (usecs), "=l" (lo)
 		: "r" (usecs), "r" (lpj)
 		: GCC_REG_ACCUM);
+#endif
 	else if (sizeof(long) == 8 && R4000_WAR)
 		__asm__("dmultu\t%3, %4\n\tmfhi\t%0"
 		: "=r" (usecs), "=h" (hi), "=l" (lo)
-- 
1.5.6.5
