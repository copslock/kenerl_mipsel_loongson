Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 07:42:43 +0100 (BST)
Received: from [IPv6:::ffff:202.54.110.230] ([IPv6:::ffff:202.54.110.230]:31251
	"EHLO ngate.noida.hcltech.com") by linux-mips.org with ESMTP
	id <S8225073AbTDAGmj>; Tue, 1 Apr 2003 07:42:39 +0100
Received: from exch-01.noida.hcltech.com (exch-01 [204.160.254.29])
	by ngate.noida.hcltech.com (8.9.3/8.9.3) with ESMTP id MAA00363
	for <linux-mips@linux-mips.org>; Tue, 1 Apr 2003 12:07:52 +0530
Received: by exch-01.noida.hcltech.com with Internet Mail Service (5.5.2656.59)
	id <HPYVLFH5>; Tue, 1 Apr 2003 12:05:20 +0530
Message-ID: <E04CF3F88ACBD5119EFE00508BBB2121086ED859@exch-01.noida.hcltech.com>
From: "Neeraj  Garg, Noida" <ngarg@noida.hcltech.com>
To: linux-mips@linux-mips.org
Subject: Linux-MIPS compilation
Date: Tue, 1 Apr 2003 12:05:18 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ngarg@noida.hcltech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ngarg@noida.hcltech.com
Precedence: bulk
X-list: linux-mips

Hi all,
I am trying to compile linux kernel version 2.4.19 and 2.4.20 for a MIPS
processor. GNU Compiler and linker version is 2.95.4.

-----------------
Compilation: 
------------------
Using compilation options:
mips-linux-gcc -D__KERNEL__ -D__linux__ -D_MIPS_SZLONG=32
-I/usr/emb_linux/linux-2.4.20/include -D__linux__ -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I
/usr/emb_linux/linux-2.4.20/include/asm/gcc -G 0 -mno-abicalls -fno-pic
-pipe -g -mcpu=r4600 -mips2 -Wa,--trap  -DUTS_MACHINE='"mips"'

I have got a tons of warnings named as:
{standard input}: Assembler messages:
{standard input}:784: Warning: Macro instruction expanded into multiple
instructions
{standard input}:784: Warning: No .cprestore pseudo-op used in PIC code

Can anybody help out to remove these warnings?

----------------------
Linking
-------------------
Using linking options:
mips-linux-ld -G 0 -static  -T arch/mips/ld.script

I have got a tons of error messages named as:
relocation truncated to fit: R_MIPS_PC16 cache_parity_error
relocation truncated to fit: R_MIPS_PC16 no symbol
relocation truncated to fit: R_MIPS_PC16 no symbol

I would be obliged if somebody can explain how GNU linker is taking
R_MIPS_PC16 as relocation type and what is the remedy to remove these error
messages?

Thanks and regds,
-neeraj


----------------------------------------------------------------------
Neeraj Kumar Garg            
Member Technical Staff

HCL Technologies Ltd.
A-5, Sector 24                Work: 91-11-91-2411502 Ext 2560
Noida UP - 201301             Fax:  91-11-91-2440155
India
----------------------------------------------------------------------
