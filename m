Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2004 00:42:51 +0100 (BST)
Received: from ispmxmta06-srv.alltel.net ([IPv6:::ffff:166.102.165.167]:53164
	"EHLO ispmxmta06-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225263AbUDLXmu>; Tue, 13 Apr 2004 00:42:50 +0100
Received: from lahoo.priv ([162.39.1.206]) by ispmxmta06-srv.alltel.net
          with ESMTP
          id <20040412234237.FFXL22068.ispmxmta06-srv.alltel.net@lahoo.priv>
          for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 18:42:37 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BDAqU-0006kp-00
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 19:28:06 -0400
Message-ID: <03f301c420e7$d8de2d70$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: <linux-mips@linux-mips.org>
References: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl> <20040412231309.GA702@linux-mips.org>
Subject: [PATCH] gcc 3.4 drops "accum" clobber, replace with "hi" in time.c
Date: Mon, 12 Apr 2004 19:42:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips

This 2.4 patch look OK?

Regards,
Brad

diff -u -r1.1.1.1 time.c
--- arch/mips/kernel/time.c     10 Nov 2003 21:06:52 -0000      1.1.1.1
+++ arch/mips/kernel/time.c     12 Apr 2004 23:41:38 -0000
@@ -242,7 +242,7 @@
        __asm__("multu  %1,%2"
                : "=h" (res)
                : "r" (count), "r" (sll32_usecs_per_cycle)
-               : "lo", "accum");
+               : "lo", "hi");

        /*
         * Due to possible jiffies inconsistencies, we need to check
@@ -297,7 +297,7 @@
        __asm__("multu  %1,%2"
                : "=h" (res)
                : "r" (count), "r" (quotient)
-               : "lo", "accum");
+               : "lo", "hi");

        /*
         * Due to possible jiffies inconsistencies, we need to check
@@ -339,7 +339,7 @@
                                : "r" (timerhi), "m" (timerlo),
                                  "r" (tmp), "r" (USECS_PER_JIFFY),
                                  "r" (USECS_PER_JIFFY_FRAC)
-                               : "hi", "lo", "accum");
+                               : "hi", "lo", "hi");
                        cached_quotient = quotient;
                }
        }
@@ -353,7 +353,7 @@
        __asm__("multu  %1,%2"
                : "=h" (res)
                : "r" (count), "r" (quotient)
-               : "lo", "accum");
+               : "lo", "hi");

        /*
         * Due to possible jiffies inconsistencies, we need to check
