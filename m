Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2018 21:48:12 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:33008 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994077AbeEXTsD4x00G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 May 2018 21:48:03 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 7CDF348FF0;
        Thu, 24 May 2018 21:47:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id ZtFNsv3YA1Nz; Thu, 24 May 2018 21:47:56 +0200 (CEST)
Subject: Re: [PATCH 1/7] MIPS: Add helpers for assembler macro instructions
To:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org
Cc:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
 <b13de64d5dfd644423f5804a3c70d722c9d33105.1511349998.git-series.jhogan@kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <9d356868-f520-91ea-f117-ac3f7c3ddda0@hauke-m.de>
Date:   Thu, 24 May 2018 21:47:46 +0200
MIME-Version: 1.0
In-Reply-To: <b13de64d5dfd644423f5804a3c70d722c9d33105.1511349998.git-series.jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Hi James,

On 11/22/2017 12:30 PM, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> Implement a parse_r assembler macro in asm/mipsregs.h to parse a
> register in $n form, and a few C macros for defining assembler macro
> instructions. These can be used to more transparently support older
> binutils versions which don't support for example the msa, virt, xpa, or
> crc instructions.
> 
> In particular they overcome the difficulty of turning a register name in
> $n form into an instruction encoding suitable for giving to .word /
> .hword, which is particularly problematic when needed from inline
> assembly where the compiler is responsible for register allocation.
> Traditionally this had required the use of $at and an extra MOV
> instruction, but for CRC instructions with multiple GP register operands
> that approach becomes more difficult.
> 
> Three assembler macro creation helpers are added:
> 
>  - _ASM_MACRO_0(OP, ENC)
>    This is to define an assembler macro for an instruction which has no
>    operands, for example the VZ TLBGR instruction.
> 
>  - _ASM_MACRO_2R(OP, R1, R2, ENC)
>    This is to define an assembler macro for an instruction which has 2
>    register operands, for example the CFCMSA instruction.
> 
>  - _ASM_MACRO_3R(OP, R1, R2, R3, ENC)
>    This is to define an assembler macro for an instruction which has 3
>    register operands, for example the crc32 instructions.
> 
>  - _ASM_MACRO_2R_1S(OP, R1, R2, SEL3, ENC)
>    This is to define an assembler macro for a Cop0 move instruction,
>    with 2 register operands and an optional register select operand
>    which defaults to 0, for example the VZ MFGC0 instruction.
> 
> Suggested-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Marcin Nowakowski <marcin.nowakowski@mips.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/mipsregs.h | 83 +++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 6b1f1ad0542c..972698557b4b 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1181,6 +1181,89 @@ static inline int mm_insn_16bit(u16 insn)
>  #endif
>  
>  /*
> + * parse_r var, r - Helper assembler macro for parsing register names.
> + *
> + * This converts the register name in $n form provided in \r to the
> + * corresponding register number, which is assigned to the variable \var. It is
> + * needed to allow explicit encoding of instructions in inline assembly where
> + * registers are chosen by the compiler in $n form, allowing us to avoid using
> + * fixed register numbers.
> + *
> + * It also allows newer instructions (not implemented by the assembler) to be
> + * transparently implemented using assembler macros, instead of needing separate
> + * cases depending on toolchain support.
> + *
> + * Simple usage example:
> + * __asm__ __volatile__("parse_r __rt, %0\n\t"
> + *			".insn\n\t"
> + *			"# di    %0\n\t"
> + *			".word   (0x41606000 | (__rt << 16))"
> + *			: "=r" (status);
> + */
> +
> +/* Match an individual register number and assign to \var */
> +#define _IFC_REG(n)				\
> +	".ifc	\\r, $" #n "\n\t"		\
> +	"\\var	= " #n "\n\t"			\
> +	".endif\n\t"
> +
> +__asm__(".macro	parse_r var r\n\t"
> +	"\\var	= -1\n\t"
> +	_IFC_REG(0)  _IFC_REG(1)  _IFC_REG(2)  _IFC_REG(3)
> +	_IFC_REG(4)  _IFC_REG(5)  _IFC_REG(6)  _IFC_REG(7)
> +	_IFC_REG(8)  _IFC_REG(9)  _IFC_REG(10) _IFC_REG(11)
> +	_IFC_REG(12) _IFC_REG(13) _IFC_REG(14) _IFC_REG(15)
> +	_IFC_REG(16) _IFC_REG(17) _IFC_REG(18) _IFC_REG(19)
> +	_IFC_REG(20) _IFC_REG(21) _IFC_REG(22) _IFC_REG(23)
> +	_IFC_REG(24) _IFC_REG(25) _IFC_REG(26) _IFC_REG(27)
> +	_IFC_REG(28) _IFC_REG(29) _IFC_REG(30) _IFC_REG(31)
> +	".iflt	\\var\n\t"
> +	".error	\"Unable to parse register name \\r\"\n\t"
> +	".endif\n\t"
> +	".endm");

This parse_r __asm__ macro causes problems when compiling the kernel
with Link time optimization (LTO) and I do not know how to fix this.

I am getting many errors complaining about parser_r being redefined
while linking the kernel, this looks like this:
./ccPboPK5.s:96693: Error: Macro `parse_r' was already defined

When using LTO the compiler puts all the objects together in the link
time and the parse_r macro is defined in the global scope of all files
which include this header file. All these definitions are then
conflicting. An option to solve this is to put this into a function in
the header file and other would be to move this into a source file.
Functions which are defined multiple times are probably getting removed
automatically.

Isn't this an extended ASM statement? The GCC documentation says this:
Note that extended asm statements must be inside a function. Only basic
asm may be outside functions (see Basic Asm). Functions declared with
the naked attribute also require basic asm (see Function Attributes).
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

I am not very familiar with asm code included in c code.

I plan to debug the LTO kernel further and will probably send some
initial patches which are fixing some problems soon, but not the general
LTO build support.

Hauke
