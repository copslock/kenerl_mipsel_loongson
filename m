Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 19:33:53 +0100 (BST)
Received: from sccrmhc15.comcast.net ([63.240.77.85]:47596 "EHLO
	sccrmhc15.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022740AbXCYSdv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Mar 2007 19:33:51 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (sccrmhc15) with ESMTP
          id <20070325183307015009ngvhe>; Sun, 25 Mar 2007 18:33:08 +0000
Message-ID: <4606C063.1030802@gentoo.org>
Date:	Sun, 25 Mar 2007 14:33:07 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <46062400.8080307@gentoo.org>	<20070326.011000.75185255.anemo@mba.ocn.ne.jp>	<4606AA74.3070907@gentoo.org> <20070326.020705.63742150.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070326.020705.63742150.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sun, 25 Mar 2007 12:59:32 -0400, Kumba <kumba@gentoo.org> wrote:
>>> So I think Franck's approach, which enables -msym32 and defines
>>> KBUILD_64BIT_SYM32 automatically if load-y was CKSEG0, is better.  Are
>>> there any problem with his patchset?
>> I missed the other two additions to this patch, which is probably why it didn't 
>> work :)  Taken as a whole, they also boot my O2 now.
> 
> Thanks, good news!
> 
> And Ralf's number shows that we can use -msym32 even for IP27.
> Another good news.

Actually, I just realized I didn't rehash my dhcpd, so it booted the wrong 
kernel.  A kernel built with this patchset won't boot without the following 
change in include/asm-mips/stackframe.h:

--- include/asm-mips/stackframe.h.orig	2007-03-25 14:22:04.000000000 -0400
+++ include/asm-mips/stackframe.h	2007-03-25 14:22:21.000000000 -0400
@@ -70,7 +70,7 @@
  #else
  		MFC0	k0, CP0_CONTEXT
  #endif
-#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+#if defined(CONFIG_32BIT) || !defined(KBUILD_64BIT_SYM32)
  		lui	k1, %hi(kernelsp)
  #else
  		lui	k1, %highest(kernelsp)
@@ -95,7 +95,7 @@
  		.endm
  #else
  		.macro	get_saved_sp	/* Uniprocessor variation */
-#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+#if defined(CONFIG_32BIT) || !defined(KBUILD_64BIT_SYM32)
  		lui	k1, %hi(kernelsp)
  #else
  		lui	k1, %highest(kernelsp)




You'll just get a silent hang after ARCS jumps into the kernel.  My guess is 
these systems need the extra asm commands.  Perhaps the use of CONFIG_32BIT is 
incorrect?

Maybe we should use the older form instead, with appropriate change?

--- include/asm-mips/stackframe.h.orig	2007-03-25 14:22:04.000000000 -0400
+++ include/asm-mips/stackframe.h.2	2007-03-25 14:30:01.000000000 -0400
@@ -70,14 +70,14 @@
  #else
  		MFC0	k0, CP0_CONTEXT
  #endif
-#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
-		lui	k1, %hi(kernelsp)
-#else
+#if defined(CONFIG_64BIT) || defined(KBUILD_64BIT_SYM32)
  		lui	k1, %highest(kernelsp)
  		daddiu	k1, %higher(kernelsp)
  		dsll	k1, 16
  		daddiu	k1, %hi(kernelsp)
  		dsll	k1, 16
+#else
+		lui	k1, %hi(kernelsp)
  #endif
  		LONG_SRL	k0, PTEBASE_SHIFT
  		LONG_ADDU	k1, k0
@@ -95,14 +95,14 @@
  		.endm
  #else
  		.macro	get_saved_sp	/* Uniprocessor variation */
-#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
-		lui	k1, %hi(kernelsp)
-#else
+#if defined(CONFIG_64BIT) || defined(KBUILD_64BIT_SYM32)
  		lui	k1, %highest(kernelsp)
  		daddiu	k1, %higher(kernelsp)
  		dsll	k1, k1, 16
  		daddiu	k1, %hi(kernelsp)
  		dsll	k1, k1, 16
+#else
+		lui	k1, %hi(kernelsp)
  #endif
  		LONG_L	k1, %lo(kernelsp)(k1)
  		.endm



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
