Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 13:48:23 +0000 (GMT)
Received: from alnrmhc11.comcast.net ([206.18.177.51]:41626 "EHLO
	alnrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021730AbXCWNsV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 13:48:21 +0000
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (alnrmhc11) with ESMTP
          id <20070323134737b11006bb40e>; Fri, 23 Mar 2007 13:47:38 +0000
Message-ID: <4603DA74.70707@gentoo.org>
Date:	Fri, 23 Mar 2007 09:47:32 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: Building 64 bit kernel on Cobalt
References: <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>	 <cda58cb80703190308k4e57e194u56dca25b063646b6@mail.gmail.com>	 <cda58cb80703190317h80cfd53x4acee55f2c757907@mail.gmail.com>	 <20070322.020756.25910272.anemo@mba.ocn.ne.jp> <cda58cb80703211231u68e2f3b0g3a8a490a35f9d07f@mail.gmail.com>
In-Reply-To: <cda58cb80703211231u68e2f3b0g3a8a490a35f9d07f@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080801030501060603050707"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080801030501060603050707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Franck Bui-Huu wrote:

> Yes it is !
> 
> After writing this I just realised that I was confused by what you said 
> earlier:
> 
>    You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
>    This combination does not work.  Please refer these threads:
> 
> This combo should theoritically work but currently does not. Unlike
> the following one
> 
>    CONFIG_BUILD_ELF64=n and XKPHYS load address.
> 
> which definitely don't work. And I mixed the second case with the first 
> one...
> 
> no other comment ;)


Cobalt's, being just like IP32, should work fine, provided that the 
__pa_page_offset() macro gets set properly.  The thing isn't whether or not 
CKSEG0 works or doesn't work (IMHO, it works just fine), it's just making sure 
that macro gets set properly, and sanely.

These three systems (IP22, IP32, & Cobalt) are the kinds of systems that are 
gonna violate whatever rule that says CONFIG_BUILD_ELF64 && CKSEG0 is invalid. 
This is the nature of MIPS, especially on the SGI platform.  They're also the 
most common types of machines end user/hobbyists are gonna get, so these 
machines need to work.  If it was some obscure mips board only available for 
large sums of <insert currency>, then I figure things would be different.

Can someone review this patch for sanity?  It achieves my desire and lets IP32 
boot using the way I've been told (BUILD_ELF64 + -msym32 + vmlinux.32).  Likely, 
it'll also do the same for Cobalt and IP22 64bit kernels (good luck getting 
those to work right anyways).


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------080801030501060603050707
Content-Type: text/plain;
 name="mips-kconfig-ckseg0-idea.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-kconfig-ckseg0-idea.patch"

diff -Naurp mipslinux/arch/mips/Kconfig mipslinux.ckseg0-a/arch/mips/Kconfig
--- mipslinux/arch/mips/Kconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0-a/arch/mips/Kconfig	2007-03-20 01:38:42.000000000 -0400
@@ -1659,6 +1659,11 @@ config SB1_PASS_2_1_WORKAROUNDS
 	depends on CPU_SB1 && CPU_SB1_PASS_2
 	default y
 
+config SYS_LOADS_IN_CKSEG0
+	bool
+	depends on BUILD_ELF64 && (SGI_IP22 || (SGI_IP32 && (CPU_R5000 || CPU_NEVADA || CPU_RM7000)) || MIPS_COBALT)
+	default y
+
 config 64BIT_PHYS_ADDR
 	bool "Support for 64-bit physical address space"
 	depends on (CPU_R4X00 || CPU_R5000 || CPU_RM7000 || CPU_RM9000 || CPU_R10000 || CPU_SB1 || CPU_MIPS32 || CPU_MIPS64) && 32BIT
diff -Naurp mipslinux/include/asm-mips/page.h mipslinux.ckseg0-a/include/asm-mips/page.h
--- mipslinux/include/asm-mips/page.h	2007-03-17 21:12:31.000000000 -0400
+++ mipslinux.ckseg0-a/include/asm-mips/page.h	2007-03-20 01:37:31.000000000 -0400
@@ -149,7 +149,7 @@ typedef struct { unsigned long pgprot; }
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#if defined(CONFIG_64BIT) && (!defined(CONFIG_BUILD_ELF64) || defined(CONFIG_SYS_LOADS_IN_CKSEG0))
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET

--------------080801030501060603050707--
