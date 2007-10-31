Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 21:12:04 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:9873 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S28576631AbXJaVLz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2007 21:11:55 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 31 Oct 2007 14:11:27 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 31 Oct 2007 14:11:26 -0700
Date:	Wed, 31 Oct 2007 14:11:24 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Put cast inside macro instead of all the callers
Message-ID: <20071031141124.185599da@ripper.onstor.net>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2007 21:11:26.0887 (UTC) FILETIME=[99616B70:01C81C02]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

Resend: I tried sending this a couple of days ago but haven't seen it.
Wondering if it got stuck in a spam filter or our lovely exchange
server or something.

Since all the callers of the PHYS_TO_XKPHYS macro call with a constant,
put the cast to LL inside the macro where it really should be rather
than in all the callers.  This makes macros like PHYS_TO_XKSEG_UNCACHED
work without gcc whining.

Hopefully this will apply ok.


Signed-off-by: Andrew Sharp <andy.sharp@onstor.com>
---
 arch/mips/lib/uncached.c     |   12 ++++++------
 include/asm-mips/addrspace.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index 2388f7f..bbca1ea 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -45,9 +45,9 @@ unsigned long __init run_uncached(void *func)
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
 #ifdef CONFIG_64BIT
-	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
-		 (long long)sp < (long long)PHYS_TO_XKPHYS(8LL, 0))
-		usp = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
+	else if ((long long)sp >= (long long)PHYS_TO_XKPHYS(0, 0) &&
+		 (long long)sp < (long long)PHYS_TO_XKPHYS(8, 0))
+		usp = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
 				     XKPHYS_TO_PHYS((long long)sp));
 #endif
 	else {
@@ -57,9 +57,9 @@ unsigned long __init run_uncached(void *func)
 	if (lfunc >= (long)CKSEG0 && lfunc < (long)CKSEG2)
 		ufunc = CKSEG1ADDR(lfunc);
 #ifdef CONFIG_64BIT
-	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0LL, 0) &&
-		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8LL, 0))
-		ufunc = PHYS_TO_XKPHYS((long long)K_CALG_UNCACHED,
+	else if ((long long)lfunc >= (long long)PHYS_TO_XKPHYS(0, 0) &&
+		 (long long)lfunc < (long long)PHYS_TO_XKPHYS(8, 0))
+		ufunc = PHYS_TO_XKPHYS(K_CALG_UNCACHED,
 				       XKPHYS_TO_PHYS((long long)lfunc));
 #endif
 	else {
diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index 964c5ed..1bc23e8 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -127,7 +127,7 @@
 #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
 #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
 #define PHYS_TO_XKPHYS(cm,a)		(_CONST64_(0x8000000000000000) | \
-					 ((cm)<<59) | (a))
+					 (_CONST64_(cm)<<59) | (a))
 
 #if defined (CONFIG_CPU_R4300)						\
     || defined (CONFIG_CPU_R4X00)					\
-- 
1.4.4.4
