Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 10:05:28 +0000 (GMT)
Received: from eau.irisa.fr ([IPv6:::ffff:131.254.60.97]:26549 "EHLO
	eau.irisa.fr") by linux-mips.org with ESMTP id <S8226274AbTAMKF1>;
	Mon, 13 Jan 2003 10:05:27 +0000
Received: from irisa.fr (traezhenn.irisa.fr [131.254.41.15])
	by eau.irisa.fr (8.11.4/8.11.4) with ESMTP id h0DA4qi26470;
	Mon, 13 Jan 2003 11:04:52 +0100 (MET)
Message-ID: <3E228F44.8070309@irisa.fr>
Date: Mon, 13 Jan 2003 11:04:52 +0100
From: Vivien Chappelier <vchappel@irisa.fr>
Reply-To: Vivien Chappelier <vivienc@nerim.net>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@linux-mips.org
Subject: [PATCH 2.5] udelay 
Content-Type: multipart/mixed;
 boundary="------------070901080807060908060409"
X-MailScanner: Found to be clean
Return-Path: <vchappel@irisa.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vchappel@irisa.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070901080807060908060409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

         The HZ constant has been changed in 2.5 and this breaks
udelay(). Here is a patch to fix this. Note that the first multiply in
udelay is still optimized out by the compiler if the delay is constant, 
as in current implementation.

Vivien.


--------------070901080807060908060409
Content-Type: text/plain;
 name="linux-mips-udelay.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-mips-udelay.diff"

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

--------------070901080807060908060409--
