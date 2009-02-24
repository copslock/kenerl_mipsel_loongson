Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2009 23:06:33 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:27427 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20808466AbZBXXGb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Feb 2009 23:06:31 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49a47d360000>; Tue, 24 Feb 2009 18:05:27 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Feb 2009 15:04:27 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Feb 2009 15:04:27 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n1ON4NhK024944;
	Tue, 24 Feb 2009 15:04:23 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n1ON4Mcj024942;
	Tue, 24 Feb 2009 15:04:22 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
Date:	Tue, 24 Feb 2009 15:04:22 -0800
Message-Id: <1235516662-24919-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 24 Feb 2009 23:04:27.0674 (UTC) FILETIME=[3E26E7A0:01C996D4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Due to the removal of the 'h' asm constraint in GCC-4.4, we need to
adjust the computation in delay.h

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Tested on 64-bit kernel (Cavium Octeon).

 arch/mips/include/asm/compiler.h |    7 +++++++
 arch/mips/include/asm/delay.h    |   10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

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
index b0bccd2..9be0ba7 100644
--- a/arch/mips/include/asm/delay.h
+++ b/arch/mips/include/asm/delay.h
@@ -62,8 +62,9 @@ static inline void __delay(unsigned long loops)
 
 static inline void __udelay(unsigned long usecs, unsigned long lpj)
 {
+#ifndef GCC_NO_H_CONSTRAINT
 	unsigned long hi, lo;
-
+#endif
 	/*
 	 * The rates of 128 is rounded wrongly by the catchall case
 	 * for 64-bit.  Excessive precission?  Probably ...
@@ -77,6 +78,12 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
 	                           0x80000000ULL) >> 32);
 #endif
 
+#ifdef GCC_NO_H_CONSTRAINT
+	if (sizeof(long) == 4)
+		usecs = ((u64)usecs * lpj) >> 32;
+	else
+		usecs = ((uint128_t)usecs * lpj) >> 64;
+#else
 	if (sizeof(long) == 4)
 		__asm__("multu\t%2, %3"
 		: "=h" (usecs), "=l" (lo)
@@ -92,6 +99,7 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
 		: "=r" (usecs), "=h" (hi), "=l" (lo)
 		: "r" (usecs), "r" (lpj)
 		: GCC_REG_ACCUM);
+#endif
 
 	__delay(usecs);
 }
-- 
1.5.6.6
