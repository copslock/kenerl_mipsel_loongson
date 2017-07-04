Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 17:33:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64370 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993859AbdGDPdOZYPN7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 17:33:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6FB7715DDA59D;
        Tue,  4 Jul 2017 16:33:04 +0100 (IST)
Received: from [10.20.78.88] (10.20.78.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 4 Jul 2017
 16:33:07 +0100
Date:   Tue, 4 Jul 2017 16:32:56 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Amit Pundir <amit.pundir@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Stable <stable@vger.kernel.org>,
        Yousong Zhou <yszhou4tech@gmail.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH for-3.18 4/5] MIPS: UAPI: Ignore __arch_swab{16,32,64}
 when using MIPS16
In-Reply-To: <1499168664-25980-5-git-send-email-amit.pundir@linaro.org>
Message-ID: <alpine.DEB.2.00.1707041525150.3339@tp.orcam.me.uk>
References: <1499168664-25980-1-git-send-email-amit.pundir@linaro.org> <1499168664-25980-5-git-send-email-amit.pundir@linaro.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.88]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 4 Jul 2017, Amit Pundir wrote:

> From: Yousong Zhou <yszhou4tech@gmail.com>
> 
> commit 71a0a72456b48de972d7ed613b06a22a3aa9057f upstream.
> 
> Some GCC versions (e.g. 4.8.3) can incorrectly inline a function with
> MIPS32 instructions into another function with MIPS16 code [1], causing
> the assembler to genereate incorrect binary code or fail right away
> complaining about unrecognized opcode.
> 
> In the case of __arch_swab{16,32}, when inlined by the compiler with
> flags `-mips32r2 -mips16 -Os', the assembler can fail with the following
> error.
> 
>     {standard input}:79: Error: unrecognized opcode `wsbh $2,$2'
> 
> For performance concerns and to workaround the issue already existing in
> older compilers, just ignore these 2 functions when compiling with
> mips16 enabled.
> 
>  [1] Inlining nomips16 function into mips16 function can result in
>      undefined builtins, https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55777

 The patch is correct, however the description does not match reality.  
There is no GCC bug involved here as: "Some GCC versions (e.g. 4.8.3) can 
incorrectly inline a function [...]" would suggest, and GCC PR 
target/55777 has nothing to do with it.

 Here you have inline functions including an inline asm each with assembly 
instructions that do not have a MIPS16 representation.  Unlike with GCC PR 
target/55777 these functions are *not* marked with 
`__attribute__((nomips16))', so the compiler is free to inline them into 
any code, including MIPS16 code in particular, not being aware that the 
inline asm is incompatible with MIPS16 assembly.  It can't be aware as the 
compiler is not an assembler and it does not interpret the string 
representing assembly code to be produced from an inline asm (beyond 
counting assembly instruction separators).

 Marking these functions with `__attribute__((nomips16))' would instruct 
the compiler to compile these functions as well as any function they get 
inlined into as regular MIPS code, which may or may not be desirable (plus 
*then* you might hit GCC PR target/55777, and IIRC some other bugs in 
older compilers).  So excluding them from MIPS16 code instead seems like a 
reasonable choice.

 OTOH, generic MIPS16 byte-swap code produced is awful, especially 
`swab32' (and `swab64' does not apply as we don't support 64-bit MIPS16 
code under Linux), so perhaps for MIPS16 code these really ought to be 
`__attribute__((nomips16, noinline))' instead, avoiding turning the caller 
into regular MIPS code as well as any old `nomips16' function inlining 
bugs; although the benefit might outweigh the cost if one of these 
functions is called from an otherwise leaf function and spilling registers 
to the stack turns out necessary where it otherwise would not be.

 Finally, for regular MIPS compilations contemporary versions of GCC 
already produce the same assembly as our <uapi/asm/swab.h> provides, e.g. 
from:

$ cat swap.c
unsigned short int swap16(unsigned short int i)
{
	return i << 8 | i >> 8;
}

unsigned int swap32(unsigned int i)
{
	return i << 24 | (i & 0xff00) << 8 | (i & 0xff0000) >> 8 | i >> 24;
}

unsigned long long int swap64(unsigned long long int i)
{
	return (i << 56 | (i & 0xff00LL) << 40 |
		(i & 0xff0000LL) << 24 | (i & 0xff000000LL) << 8 |
		(i & 0xff00000000LL) >> 8 | (i & 0xff0000000000LL) >> 24 |
		(i & 0xff000000000000LL) >> 40 | i >> 56);
}
$ 

you get:

$ gcc -O2 -mabi=64 -march=mips64r2 -c swap.c
$ objdump -d swap.o

swap.o:     file format elf64-tradbigmips


Disassembly of section .text:

0000000000000000 <swap16>:
   0:	7c0410a0 	wsbh	v0,a0
   4:	03e00008 	jr	ra
   8:	3042ffff 	andi	v0,v0,0xffff
   c:	00000000 	nop

0000000000000010 <swap32>:
  10:	7c0410a0 	wsbh	v0,a0
  14:	03e00008 	jr	ra
  18:	00221402 	ror	v0,v0,0x10
  1c:	00000000 	nop

0000000000000020 <swap64>:
  20:	7c0410a4 	dsbh	v0,a0
  24:	03e00008 	jr	ra
  28:	7c021164 	dshd	v0,v0
  2c:	00000000 	nop
$ 

so I think we ought to make all this conditional on GCC being old enough, 
as the compiler is always better suited to make code scheduling decisions 
when there's no inline asm involved.

 FWIW,

  Maciej
