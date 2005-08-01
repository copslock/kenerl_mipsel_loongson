Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 07:07:54 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:205.217.158.170]:18139
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8224832AbVHAGHg>; Mon, 1 Aug 2005 07:07:36 +0100
Received: (qmail 14373 invoked from network); 31 Jul 2005 23:10:37 -0700
Received: from c-24-6-216-150.hsd1.ca.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 31 Jul 2005 23:10:37 -0700
Message-ID: <42EDBCDD.6000301@total-knowledge.com>
Date:	Sun, 31 Jul 2005 23:10:37 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Au1000 Compile fix
Content-Type: multipart/mixed;
 boundary="------------090709020608060104020508"
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090709020608060104020508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached patch fixes compile Au1000 with CONFIG_64BIT_PHYS_ADDR enabled
when gcc-3.4.x is used

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com


--------------090709020608060104020508
Content-Type: text/x-patch;
 name="ioremap.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioremap.h.diff"

Index: include/asm-mips/mach-au1x00/ioremap.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-au1x00/ioremap.h,v
retrieving revision 1.2
diff -u -r1.2 ioremap.h
--- include/asm-mips/mach-au1x00/ioremap.h	14 Jul 2005 00:17:06 -0000	1.2
+++ include/asm-mips/mach-au1x00/ioremap.h	1 Aug 2005 04:19:04 -0000
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_64BIT_PHYS_ADDR
-extern inline phys_t __fixup_bigphys_addr(phys_t, phys_t);
+extern phys_t __fixup_bigphys_addr(phys_t, phys_t);
 #else
 static inline phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 {

--------------090709020608060104020508--
