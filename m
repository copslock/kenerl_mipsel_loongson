Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jan 2003 18:55:17 +0000 (GMT)
Received: from p508B688C.dip.t-dialin.net ([IPv6:::ffff:80.139.104.140]:2951
	"EHLO p508B688C.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225701AbTAKSzQ>; Sat, 11 Jan 2003 18:55:16 +0000
Received: from smtp-101.noc.nerim.net ([IPv6:::ffff:62.4.17.101]:8718 "EHLO
	mallaury.noc.nerim.net") by ralf.linux-mips.org with ESMTP
	id <S869811AbTAKSzO>; Sat, 11 Jan 2003 19:55:14 +0100
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 0855062E1B; Sat, 11 Jan 2003 19:55:02 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18XQmb-0002FI-00; Sat, 11 Jan 2003 19:55:01 +0100
Date: Sat, 11 Jan 2003 19:55:00 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5] udelay
Message-ID: <Pine.LNX.4.21.0301111951300.7511-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	The HZ constant has been changed in 2.5 and this breaks
udelay(). Here is a patch to fix this. Note that the first multiply in
udelay is still optimized out by the compiler if the delay is constant, as
in current implementation.

Vivien.

--- include/asm-mips64/delay.h	2002-12-11 20:44:20.000000000 +0100
+++ include/asm-mips64/delay.h	2003-01-07 20:36:37.000000000 +0100
@@ -41,11 +41,11 @@
 {
 	unsigned long lo;
 
-#if (HZ == 100)
-	usecs *= 0x00068db8bac710cbUL;		/* 2**64 / (1000000 / HZ) */
-#elif (HZ == 128)
-	usecs *= 0x0008637bd05af6c6UL;		/* 2**64 / (1000000 / HZ) */
-#endif
+/* HZ * 2**64 / 1000000 */
+#define __UDELAY_FIXED64_HZ_1000000 (0x8000000000000000UL / (500000 / HZ)) 
+
+	usecs *= __UDELAY_FIXED64_HZ_1000000;
+
 	__asm__("dmultu\t%2,%3"
 		:"=h" (usecs), "=l" (lo)
 		:"r" (usecs),"r" (lpj));
--- include/asm-mips/delay.h	2002-12-11 20:44:18.000000000 +0100
+++ include/asm-mips/delay.h	2003-01-08 19:25:17.000000000 +0100
@@ -40,11 +40,10 @@
 {
 	unsigned long lo;
 
-#if (HZ == 100)
-	usecs *= 0x00068db8;		/* 2**32 / (1000000 / HZ) */
-#elif (HZ == 128)
-	usecs *= 0x0008637b;		/* 2**32 / (1000000 / HZ) */
-#endif
+/* HZ * 2**32 / 1000000 */
+#define __UDELAY_FIXED32_HZ_1000000 (0x80000000UL / (500000 / HZ)) 
+
+	usecs *= __UDELAY_FIXED32_HZ_1000000;
 	__asm__("multu\t%2,%3"
 		:"=h" (usecs), "=l" (lo)
 		:"r" (usecs),"r" (lpj));
