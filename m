Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 06:41:31 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:60563 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225006AbUKNGkx>; Sun, 14 Nov 2004 06:40:53 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc11) with ESMTP
          id <20041114064052011006s5lme>; Sun, 14 Nov 2004 06:40:52 +0000
Message-ID: <4196FE87.5050606@gentoo.org>
Date: Sun, 14 Nov 2004 01:43:19 -0500
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: R52x0 -> RM52xx
Content-Type: multipart/mixed;
 boundary="------------060204080708080103040305"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060204080708080103040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a minor cosmetic patch for 2.6 that just changes menuconfig to 
show the RM52xx CPU by the name it's known by on Systems that use it (Cobalt 
(RM5231), O2 RM5200).

It's a really minor thing, but afaict, it doesn't look to be incorrect.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond

--------------060204080708080103040305
Content-Type: text/plain;
 name="misc-2.6-kconfig-tweak"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6-kconfig-tweak"

--- arch/mips/Kconfig.orig	2004-11-13 19:55:05.647515448 -0500
+++ arch/mips/Kconfig	2004-11-13 19:55:50.313725152 -0500
@@ -1183,9 +1183,9 @@ config CPU_R6000
 	  processors are extremly rare and the support for them is incomplete.
 
 config CPU_NEVADA
-	bool "R52xx"
+	bool "RM52xx"
 	help
-	  MIPS Technologies R52x0-series ("Nevada") processors.
+	  MIPS Technologies RM52xx-series ("Nevada") processors.
 
 config CPU_R8000
 	bool "R8000"

--------------060204080708080103040305--
