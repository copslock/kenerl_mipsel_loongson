Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jun 2004 07:06:32 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:8326 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8224841AbUFUGG1>; Mon, 21 Jun 2004 07:06:27 +0100
Received: from [192.168.1.4] (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc13) with ESMTP
          id <20040621060621016008v3pme>
          (Authid: kumba12345);
          Mon, 21 Jun 2004 06:06:21 +0000
Message-ID: <40D67BBC.4020901@gentoo.org>
Date: Mon, 21 Jun 2004 02:10:04 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] Fix O2/IP32 compile time glitch
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030104080105030204060803"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030104080105030204060803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seems somewhere between 2.6.6 and 2.6.7, something happened that makes 
IP32's build die in drivers/char/rtc.c when trying to reference 
MACEISA_RTC_IRQ.  The attached patch fixes it.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond

--------------030104080105030204060803
Content-Type: text/plain;
 name="mipscvs-2.6.7-maceisa_rtc_irq-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mipscvs-2.6.7-maceisa_rtc_irq-fix.patch"

--- include/asm-mips/mach-ip32/mc146818rtc.h.orig	2004-06-21 00:47:35.931657976 -0400
+++ include/asm-mips/mach-ip32/mc146818rtc.h	2004-06-21 00:47:50.704412176 -0400
@@ -13,6 +13,7 @@
 
 #include <asm/io.h>
 #include <asm/ip32/mace.h>
+#include <asm/ip32/ip32_ints.h>
 
 #define RTC_PORT(x)	(0x70 + (x))
 #define RTC_IRQ		MACEISA_RTC_IRQ

--------------030104080105030204060803--
