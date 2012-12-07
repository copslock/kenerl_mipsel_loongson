Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 08:50:18 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:58369 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817667Ab2LGHuQ2J4HG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 08:50:16 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so126014lag.36
        for <multiple recipients>; Thu, 06 Dec 2012 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OmVDLNuljPaxFnEcCIvlZiRwCgPMwcGpWOgGLQ4/p8Y=;
        b=kKnfilgWtCg2XROoRyQm1AjKof3SY07oyjZUMU9kfssQ5sg2EJwx7CtLj9ru140aMA
         K1IJE75Odey+Cch80J9G9+p2eLeaHYcfKMwqiflm8u+wvA7qBCpzZ2FMGCVXug3PqM+K
         H/ZRerG+M52SADVKJdobc76EJF9XXdIS7aH+nITunj6KmxLNAOqSJAhjuz0/cZ1QbIr6
         4K8QcYuQ5pG40j/dUlw1pt3rkOmK3v5dbJEEHalqjchBs/URR3+arOUX1F84590yMWMQ
         gdUr68OQCNVkn7lqBDVzrJjGkDwecXZGzdxr6+5ZHr5WFyETyPNemi6bhgEllDOqQUR0
         n93w==
MIME-Version: 1.0
Received: by 10.112.47.233 with SMTP id g9mr2181270lbn.11.1354866610679; Thu,
 06 Dec 2012 23:50:10 -0800 (PST)
Received: by 10.114.20.137 with HTTP; Thu, 6 Dec 2012 23:50:10 -0800 (PST)
In-Reply-To: <1354856737-28678-2-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
        <1354856737-28678-2-git-send-email-sjhill@mips.com>
Date:   Thu, 6 Dec 2012 23:50:10 -0800
Message-ID: <CAJiQ=7BKXMbRZqwxPnFqFS3nUuGr819zQbuhbAspOZvpCYpnFw@mail.gmail.com>
Subject: Re: [PATCH v99,01/13] MIPS: microMIPS: Add support for microMIPS instructions.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Dec 6, 2012 at 9:05 PM, Steven J. Hill <sjhill@mips.com> wrote:
> @@ -267,6 +268,225 @@ struct b_format { /* BREAK and SYSCALL */
>  	unsigned int func:6;
>  };
>
> +struct fb_format {	/* FPU branch format */
> +	unsigned int opcode:6;
> +	unsigned int bc:5;
> +	unsigned int cc:3;
> +	unsigned int flag:2;
> +	unsigned int simmediate:16;
> +};

Some random thoughts/nitpicks on this section:

The microMIPS patch nearly quadruples the number of instruction
formats in the mips_instruction union, so it might be worth
considering questions like:

1) Is this the optimal way to represent this information, or have we
reached a point where it is worth adding more complex "infrastructure"
that would support a more compact instruction definition format?

2) Is there a better way to handle the LE/BE bitfield problem, than to
duplicate each of the 28+ structs?

On the nitpick front:

3) After "struct NAME_format {", are tabs or spaces used to offset the
comment?  Seems like a mix.  (The original code isn't entirely
consistent either, but this could be an opportunity to tidy it up.)

4) Spaces around ':' in e.g. "opcode:6" would be more consistent with
"most" of the other entries in inst.h

5) Should "FPU multipy" be "FPU multiply"?

6) The names of the special MIPS16e structs (rr, jal, i64, ri*) are a
little terse and may create a conflict someday.  If you don't want to
use "INSTR_format" for specific instruction names, you could use
something like "INSTR_instr" instead.

> +struct jal {
> +	unsigned int opcode:5;
> +	unsigned int x:1;
> +	unsigned int imm20_16:5;
> +	signed int imm25_21:5;
> +	/* unsigned int    imm20_15:0;  here is only first 16bits in first HW */

I'm assuming this meant to say: "there are only 16 bits in the first halfword"?

It might be clearer to just leave a comment like:

+	signed int imm25_21:5;
+	/* the subsequent [or previous] halfword contains imm15_0 */

> +/*
> + * This functions returns 1 if the microMIPS instr is a 16 bit instr.

Suggest "This function returns"

> + * Otherwise return 0.
> + */
> +#define MIPS_ISA_MODE   01
> +#define is16mode(regs)  (regs->cp0_epc & MIPS_ISA_MODE)
> +
> +static inline int mm_is16bit(u16 instr)

Does the comment refer to the is16mode() macro, or to mm_is16bit()?

Does is16mode(), which tests EPC during exception handling, belong in
the uasm header file?

You might want to indicate that the value passed into mm_is16bit() is
either a complete 16-bit MM (microMIPS) instruction, or the most
significant halfword of a 32-bit MM instruction.  i.e. it isn't
necessarily a complete instruction

> +	{ insn_bltzl, 0, 0 },
> +	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
> +	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
> +	{ insn_daddu, 0, 0 },
> +	{ insn_daddiu, 0, 0 },
> +	{ insn_dmfc0, 0, 0 },

Do the "{ insn_X, 0, 0 }" entries indicate that these instructions
(which were defined in MIPS mode) are unsupported in MM mode?

> +static inline __uasminit u32 build_bimm(s32 arg)
> +{
> +	if(arg > 0xffff || arg < -0x10000)

"if(" triggers a checkpatch violation (there are a few others too).

> +		printk(KERN_WARNING "Micro-assembler field overflow\n");

Consider pr_warning()

> +static inline __uasminit u32 build_jimm(u32 arg)
> +{
> +	if ((arg & ~(JIMM_MASK << 1)) - 1)
> +		printk(KERN_WARNING "Micro-assembler field overflow\n");

This expression evaluates to -1 (i.e. print a warning) for small
values of arg, like 0 or 4.

Would something like this work?

arg >>= 1;
if (arg & ~JIMM_MASK)
	pr_warning("Micro-assembler field overflow\n");
return arg & JIMM_MASK;

> +/*
> + * The order of opcode arguments is implicitly left to right,
> + * starting with RS and ending with FUNC or IMM.
> + */
> +static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)

There are a lot of similarities between the MM and MIPS versions of
these functions.  Likewise for build_bimm() and build_jimm(), which
only differ because the shifts/ranges are not the same.  Is there a
way to make better reuse of the code?

> +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> +	**buf = ((op & 0xffff) << 16) | (op >> 16);
> +#else
> +	**buf = op;
> +#endif

If the MM instruction stream can consist of either 16-bit or 32-bit
instructions, shouldn't this be a "u16 **" pointer?

And if it is, does that make the LE/BE test unnecessary?

> diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
> new file mode 100644
> index 0000000..e86334b
> --- /dev/null
> +++ b/arch/mips/mm/uasm-mips.c

It would be good to have a separate commit that JUST splits uasm.c out
into uasm-mips.c (no other changes).  The commit message would ideally
explain the rationale.

> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> + */

Suggest leaving the original uasm.c authors' copyright info in the
uasm-mips.c header.

> +#ifdef CONFIG_CPU_MICROMIPS
> +#define RS_SH		16
> +#define RT_SH		21
> +#define SCIMM_MASK	0x3ff
> +#define SCIMM_SH	16

Can these be defined in a single place?

> -	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
> +	if (arg & ~RS_MASK)
> +		printk(KERN_WARNING "Micro-assembler RS field overflow\n");

Since this looks unrelated to MM support, it might be best to put it
in a separate commit.  What is the benefit of changing WARN() to
printk()?

Also, if printk() absolutely must be used, it might make sense to
consolidate the uasm warning prints into a single non-inlined
function, so that if somebody sees an overflow message and wants to
debug the problem, they can set one breakpoint instead of 10+
breakpoints.  WARN() may have helped indicate the source of the
failure but printk() won't.

> -	WARN(arg & ~RT_MASK, KERN_WARNING "Micro-assembler field overflow\n");
> +	if (arg & ~RT_MASK)
> +		printk(KERN_WARNING "Micro-assembler RT field overflow\n");

FWIW, using a unique string for each error case means the compiler can
no longer point all of these printk's to a single copy of the same
string...

> +#ifdef CONFIG_CPU_MICROMIPS
> +#include "uasm-micromips.c"
> +#else
> +#include "uasm-mips.c"
> +#endif

There's an awful lot of potential reuse between these two
configurations and I'm not sure if it makes sense to split them this
way.

If possible it would be good if we didn't have to enable
CONFIG_CPU_MICROMIPS to know that the MM code compiles.
