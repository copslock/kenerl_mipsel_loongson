Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2004 11:35:50 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:9988
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224921AbUGZKfp>; Mon, 26 Jul 2004 11:35:45 +0100
Received: from comm1.baslerweb.com (proxy.baslerweb.com [172.16.13.2])
          by proxy.baslerweb.com (Post.Office MTA v3.5.3 release 223
          ID# 0-0U10L2S100V35) with ESMTP id com
          for <linux-mips@linux-mips.org>; Mon, 26 Jul 2004 12:35:16 +0200
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id PLG5MTZ1; Mon, 26 Jul 2004 12:35:42 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: [PATCH] Fix gcc-3.4.x compilation
Date: Mon, 26 Jul 2004 12:37:09 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407261237.09965.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

compilation of the kernel with a 3.4.x compiler does not
work, because that compiler does no longer recognize
the 'accum' register pair specifier. This can easily be
fixed (patch attached). Since the meaning of 'accum'
used to be 'hi' and 'lo', all its uses were clearly
redundant.


--- linux-mips/arch/mips/kernel/time.c	2004-07-26 12:15:25.302897080 +0200
+++ linux-mips-work/arch/mips/kernel/time.c	2004-07-15 14:52:18.000000000 +0200
@@ -278,7 +278,7 @@
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -333,7 +333,7 @@
 	__asm__("multu  %1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -375,7 +375,7 @@
 				: "r" (timerhi), "m" (timerlo),
 				  "r" (tmp), "r" (USECS_PER_JIFFY),
 				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", "accum");
+				: "hi", "lo");
 			cached_quotient = quotient;
 		}
 	}
@@ -389,7 +389,7 @@
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check


-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
