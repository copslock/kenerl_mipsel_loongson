Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:34:32 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225194AbSLWLeb>; Mon, 23 Dec 2002 11:34:31 +0000
Received: from mallaury.noc.nerim.net ([IPv6:::ffff:62.4.17.82]:63499 "EHLO
	mallaury.noc.nerim.net") by ralf.linux-mips.org with ESMTP
	id <S868806AbSLUSM7>; Sat, 21 Dec 2002 19:12:59 +0100
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 0E77A62E22; Sat, 21 Dec 2002 19:11:41 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18Po6A-0000CO-00; Sat, 21 Dec 2002 19:11:42 +0100
Date: Sat, 21 Dec 2002 19:11:40 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@oss.sgi.com>, Ilya Volynets <ilya@theilya.com>
Subject: [PATCH 2.5] udelay
Message-ID: <Pine.LNX.4.21.0212211849290.747-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	The HZ constant has changed in 2.5 and udelay doesn't work
properly anymore. Here's a patch to fix it. I checked the first multiply
is still optimized out during compilation if the delay is constant. It's
for mips64, but mips32 needs it as well.

Vivien.

--- include/asm-mips64/delay.h	2002-12-11 20:44:20.000000000 +0100
+++ include/asm-mips64/delay.h	2002-12-21 18:48:12.000000000 +0100
@@ -41,11 +41,10 @@
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
 	__asm__("dmultu\t%2,%3"
 		:"=h" (usecs), "=l" (lo)
 		:"r" (usecs),"r" (lpj));
