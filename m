Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 16:24:53 +0100 (BST)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:64697 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8224931AbUIWPYt>; Thu, 23 Sep 2004 16:24:49 +0100
Received: (qmail 6355 invoked from network); 23 Sep 2004 15:08:50 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.199)
  by mail.dev.rtsoft.ru with SMTP; 23 Sep 2004 15:08:50 -0000
Message-ID: <4152EABF.1020007@dev.rtsoft.ru>
Date: Thu, 23 Sep 2004 19:24:47 +0400
From: Pavel Kiryukhin <savl@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Pavel Kiryukhin <savl@dev.rtsoft.ru>
Subject: __stq_u parameter
Content-Type: multipart/mixed;
 boundary="------------070607060309060102000009"
Return-Path: <savl@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savl@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070607060309060102000009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry,
 does this make sense for 2.4.x kernels?
----
Regards,
Pavel Kiryukhin

--------------070607060309060102000009
Content-Type: text/plain;
 name="unaligned.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unaligned.diff"

--- linux/include/asm-mips/unaligned.h_org	2004-09-23 15:54:37.000000000 +0400
+++ linux/include/asm-mips/unaligned.h	2004-09-23 18:32:48.000000000 +0400
@@ -61,7 +61,7 @@
 /*
  * Store doubleword ununaligned.
  */
-static inline void __stq_u(unsigned long __val, unsigned long long * __addr)
+static inline void __stq_u(unsigned long long __val, unsigned long long * __addr)
 {
 	__asm__("usw\t%1, %0\n\t"
 		"usw\t%D1, 4+%0"

--------------070607060309060102000009--
