Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 11:53:10 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:12297 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224901AbUGUKxG>;
	Wed, 21 Jul 2004 11:53:06 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BnEuT-0002Cz-00; Wed, 21 Jul 2004 12:05:17 +0100
Received: from holborn.mips.com ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BnEi6-00054Q-00; Wed, 21 Jul 2004 11:52:30 +0100
Message-ID: <40FE4AEE.7090109@mips.com>
Date: Wed, 21 Jul 2004 11:52:30 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Roman Mashak <mrv@tusur.ru>
CC: linux-mips@linux-mips.org
Subject: Re: YAMON compiling
References: <002601c46edc$809fe700$cc20bdd3@roman>
In-Reply-To: <002601c46edc$809fe700$cc20bdd3@roman>
Content-Type: multipart/mixed;
 boundary="------------090900020700050409020205"
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.914, required 4, AWL,
	BAYES_00, USER_AGENT_MOZILLA_UA)
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090900020700050409020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Roman Mashak wrote:
> Hello!
> 
> After installing  SDE toolkit onto Linux box I tried to compile the 
> YAMON bootloader source code (version of YAMON is 2.00). Few errors
> arised:
...
> The lines in mips.h that arise these warnings are the following:
> 
> // #define AU1000 0x00030100
> //#define AU1000 0x01030200
> //#define AU1000_2_1 0x00030200
> 

   The original MIPS assembler used '#' as a comment character.  Using 
an ANSI style C preprocessor where preprocessor directives do not need 
to be at the beginning of the line can can cause problems with files 
using this type of comment.  For this reason sde-gcc tells the 
preprocessor to run in "traditional" mode which disables various ANSI 
features.  In particular, the preprocessor in traditional mode does not 
accept '//' style comments.

> #define t1 $9
> #define mem_sdconfiga  0x0840
> #define MEM_SDCONFIGA_DDR   0x9030060A
> #define MEM_SDREFCFG_D_DDR  MEM_SDCONFIGA_DDR
>
> li      t1, MEM_SDREFCFG_D_DDR
> sw      t1, mem_sdconfiga(t0)
> sync
> 
> Compiler thinks  'li t1, MEM_SDREFCFG_D_DDR'  is 'bad expression',  may be
> it guesses MEM_SDREFCFG_D_DDR is not defined correctly?


   If the '#define' was not at the beginning of the line the 
preprocessor in traditional mode will ignore them and the assembler 
would end up treating these lines as comments which would cause this error.

   I've attached a patch that works on a MIPS release of the YAMON-2.00 
sources to override the preprocessor mode for assembler files. See if it 
helps...

	Chris

-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250

--------------090900020700050409020205
Content-Type: text/plain;
 name="yamon-makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="yamon-makefile.patch"

--- bin/makefile.orig	Tue Jul 20 19:49:19 2004
+++ bin/makefile	Tue Jul 20 19:49:49 2004
@@ -288,7 +288,7 @@
 # SDE toolchain does not allow a construct like ".bss", it requires
 # .section bss instead.
 ifeq ($(TOOLCHAIN),sde)
-CC_OPTS_A = $(CC_OPTS) -D_ASSEMBLER_ -D_SDE_
+CC_OPTS_A = $(CC_OPTS) -D_ASSEMBLER_ -D_SDE_ -fno-traditional-cpp
 else
 CC_OPTS_A = $(CC_OPTS) -D_ASSEMBLER_
 endif

--------------090900020700050409020205--
