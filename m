Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 22:41:26 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:49382 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28573739AbXKZWkR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 22:40:17 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Iwmch-0006QN-04; Mon, 26 Nov 2007 23:40:15 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id C7CB3C2B26; Mon, 26 Nov 2007 23:39:48 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Date:	Sun, 25 Nov 2007 11:28:03 +0100
Subject: [PATCH] fix warning when using PHYS_TO_XKSEG_xx()
Message-Id: <20071126223948.C7CB3C2B26@solo.franken.de>
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

use CONST64 cast in PHYS_TO_XPHYS macro to avoid warning about shifts
longer than the target type.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/lib/uncached.c     |    8 ++++----
 include/asm-mips/addrspace.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index 58d14f4..b59b770 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -46,8 +46,8 @@ unsigned long __init run_uncached(void *func)
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
 #ifdef CONFIG_64BIT
-	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
-		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
+	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
+		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
 		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
 				     XKPHYS_TO_PHYS((long long)sp));
 #endif
@@ -58,8 +58,8 @@ unsigned long __init run_uncached(void *func)
 	if (lfunc >= (long)CKSEG0 && lfunc < (long)CKSEG2)
 		ufunc = CKSEG1ADDR(lfunc);
 #ifdef CONFIG_64BIT
-	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
-		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8LL, 0))
+	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0, 0) &&
+		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8, 0))
 		ufunc = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
 				       XKPHYS_TO_PHYS((long long)lfunc));
 #endif
diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index 0bb7a93..9002d66 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -127,7 +127,7 @@
 #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE, (p))
 #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
 #define PHYS_TO_XKPHYS(cm, a)		(_CONST64_(0x8000000000000000) | \
-					 ((cm)<<59) | (a))
+					 (_CONST64_(cm)<<59) | (a))
 
 /*
  * The ultimate limited of the 64-bit MIPS architecture:  2 bits for selecting
-- 
1.4.4.4
