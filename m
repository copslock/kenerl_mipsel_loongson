Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 03:24:53 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:18921 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8229591AbVCYDYh>; Fri, 25 Mar 2005 03:24:37 +0000
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc11) with ESMTP
          id <2005032503242801100lpuc7e>; Fri, 25 Mar 2005 03:24:28 +0000
Message-ID: <4243848D.3030201@gentoo.org>
Date:	Thu, 24 Mar 2005 22:25:01 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Set CONFIG_SECCOMP default to 'n'
Content-Type: multipart/mixed;
 boundary="------------090703020702080105040900"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090703020702080105040900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


As I recently learned, CONFIG_SECCOMP's default value is "y", and this can 
cause the build to fail until the remaining bits of this feature are 
committed.  The attached patch changes the default to "n".


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond

--------------090703020702080105040900
Content-Type: text/plain;
 name="misc-2.6.12-seccomp-no-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.12-seccomp-no-default.patch"

--- arch/mips/Kconfig.orig	2005-03-21 14:31:08.757419840 -0500
+++ arch/mips/Kconfig	2005-03-21 14:31:20.955565440 -0500
@@ -1422,7 +1422,7 @@ config BINFMT_ELF32
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS && BROKEN
-	default y
+	default n
 	help
 	  This kernel feature is useful for number crunching applications
 	  that may need to compute untrusted bytecode during their

--------------090703020702080105040900--
