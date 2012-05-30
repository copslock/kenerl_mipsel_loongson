Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 19:35:32 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8488 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2E3RfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 19:35:24 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fc655fc0001>; Wed, 30 May 2012 10:16:49 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 10:14:50 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 10:14:50 -0700
Message-ID: <4FC65589.2070304@cavium.com>
Date:   Wed, 30 May 2012 10:14:49 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/9] MIPS: Add support for microMIPS instructions.
References: <1337892366-24210-1-git-send-email-sjhill@mips.com> <1337892366-24210-3-git-send-email-sjhill@mips.com>
In-Reply-To: <1337892366-24210-3-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2012 17:14:50.0128 (UTC) FILETIME=[B88BA900:01CD3E87]
X-archive-position: 33485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Several, perhaps pedantic, thoughts...

On 05/24/2012 01:45 PM, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> The MIPS micro-assembler needs to use microMIPS instructions
> when building all of the core exception handlers.
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/include/asm/inst.h     |  882 +++++++++++++++++++++++++++++++++++---
>   arch/mips/include/asm/mipsregs.h |  359 +++++++---------
>   arch/mips/mm/uasm.c              |  173 +++++++-
>   3 files changed, 1133 insertions(+), 281 deletions(-)
>
> diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
> index 7ebfc39..7e8f793 100644
> --- a/arch/mips/include/asm/inst.h
> +++ b/arch/mips/include/asm/inst.h
> @@ -5,8 +5,9 @@
>    * License.  See the file "COPYING" in the main directory of this archive
>    * for more details.
>    *
> - * Copyright (C) 1996, 2000 by Ralf Baechle
> - * Copyright (C) 2006 by Thiemo Seufer
> + * Copyright (C) 1996, 2000  Ralf Baechle
> + * Copyright (C) 2006  Thiemo Seufer

Why did those two line have to change?

> + * Copyright (C) 2011  MIPS Technologies, Inc.
>    */
>   #ifndef _ASM_INST_H
>   #define _ASM_INST_H
> @@ -116,7 +117,7 @@ enum bcop_op {
>   enum cop0_coi_func {
>   	tlbr_op       = 0x01, tlbwi_op      = 0x02,
>   	tlbwr_op      = 0x06, tlbp_op       = 0x08,
> -	rfe_op        = 0x10, eret_op       = 0x18
> +	rfe_op        = 0x10, eret_op       = 0x18,
>   };
>

Formatting cleanups might be better as a separate patch.  When too many 
are mixed with functional changes, it can be confusing.

>   /*
> @@ -261,85 +262,523 @@ struct ma_format {	/* FPU multipy and add format (MIPS IV) */
>   	unsigned int fmt : 2;
>   };
>
> -struct b_format { /* BREAK and SYSCALL */
> +struct b_format {	/* BREAK and SYSCALL */

Again only code layout changes.

>   	unsigned int opcode:6;
>   	unsigned int code:20;
>   	unsigned int func:6;
>   };
>
[...]
>
> -struct j_format {	/* Jump format */
> -	unsigned int target : 26;
> -	unsigned int opcode : 6;
> +struct j_format {		/* Jump format */
> +	unsigned int target:26;
> +	unsigned int opcode:6;
>   };
>
> -struct i_format {	/* Immediate format */
> -	signed int simmediate : 16;
> -	unsigned int rt : 5;
> -	unsigned int rs : 5;
> -	unsigned int opcode : 6;
> +struct i_format {		/* Immediate format */
> +	signed int simmediate:16;
> +	unsigned int rt:5;
> +	unsigned int rs:5;
> +	unsigned int opcode:6;
>   };
>

... again ...

[...]
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 7f87d82..a16d9d0 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
[...]
>
> @@ -626,10 +637,10 @@
>   	unsigned int __res;					\
>   	__asm__ __volatile__(					\
>   	"mfpc\t%0, %1"						\
> -        : "=r" (__res)						\
> +	: "=r" (__res)						\
>   	: "i" (counter));					\
>   								\
> -        __res;							\
> +	__res;							\

... and again ...


>   })
>

[...]

> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -39,9 +39,18 @@ enum fields {
>   #define OP_MASK		0x3f
>   #define OP_SH		26
>   #define RS_MASK		0x1f
> -#define RS_SH		21
>   #define RT_MASK		0x1f
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define RS_SH		16
> +#define RT_SH		21
> +#define SCIMM_MASK	0x3ff
> +#define SCIMM_SH	16
> +#else
> +#define RS_SH		21
>   #define RT_SH		16
> +#define SCIMM_MASK	0xfffff
> +#define SCIMM_SH	6
> +#endif
>   #define RD_MASK		0x1f
>   #define RD_SH		11
>   #define RE_MASK		0x1f
> @@ -54,8 +63,6 @@ enum fields {
>   #define FUNC_SH		0
>   #define SET_MASK	0x7
>   #define SET_SH		0
> -#define SCIMM_MASK	0xfffff
> -#define SCIMM_SH	6
>
>   enum opcode {
>   	insn_invalid,
> @@ -81,6 +88,15 @@ struct insn {
>   };
>
>   /* This macro sets the non-variable bits of an instruction. */
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define M(a, b, c, d, e, f)					\
> +	((a)<<  OP_SH						\
> +	 | (b)<<  RT_SH						\
> +	 | (c)<<  RS_SH						\
> +	 | (d)<<  RD_SH						\
> +	 | (e)<<  RE_SH						\
> +	 | (f)<<  FUNC_SH)
> +#else


This is where things start to get really ugly.

Can we split uasm.c into three parts:

1) common code.
2) MIPS code.
3) uMIPS code.

Then in the Makefile select one of either #2 or #3.


David Daney
