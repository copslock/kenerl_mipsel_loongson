Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 10:45:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47170 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042775AbcFQIpTwPX-u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 10:45:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5D8EEB0251A08;
        Fri, 17 Jun 2016 09:45:11 +0100 (IST)
Received: from [192.168.154.116] (192.168.154.116) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Jun
 2016 09:45:13 +0100
Subject: Re: [PATCH] MIPS: tools: Fix relocs tool compiler warnings
To:     Harvey Hunt <harvey.hunt@imgtec.com>, <ralf@linux-mips.org>
References: <20160616153539.10600-1-harvey.hunt@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <5763B898.7040502@imgtec.com>
Date:   Fri, 17 Jun 2016 09:45:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160616153539.10600-1-harvey.hunt@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 16/06/16 16:35, Harvey Hunt wrote:
> When using clang as HOSTCC, the following warnings appear:
>
> In file included from arch/mips/boot/tools/relocs_64.c:27:0:
> arch/mips/boot/tools/relocs.c: In function ‘read_relocs’:
> arch/mips/boot/tools/relocs.c:397:4: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>      ELF_R_SYM(rel->r_info) = elf32_to_cpu(ELF_R_SYM(rel->r_info));
>      ^~~~~~~~~
> arch/mips/boot/tools/relocs.c:397:4: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> arch/mips/boot/tools/relocs.c: In function ‘walk_relocs’:
> arch/mips/boot/tools/relocs.c:491:4: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>      Elf_Sym *sym = &sh_symtab[ELF_R_SYM(rel->r_info)];
>      ^~~~~~~
> arch/mips/boot/tools/relocs.c: In function ‘do_reloc’:
> arch/mips/boot/tools/relocs.c:502:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>    unsigned r_type = ELF_R_TYPE(rel->r_info);
>    ^~~~~~~~
> arch/mips/boot/tools/relocs.c: In function ‘do_reloc_info’:
> arch/mips/boot/tools/relocs.c:641:3: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>     rel_type(ELF_R_TYPE(rel->r_info)),
>     ^~~~~~~~
>
> Fix them by making Elf64_Mips_Rela a union
>
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/boot/tools/relocs_64.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/boot/tools/relocs_64.c b/arch/mips/boot/tools/relocs_64.c
> index b671b5e..06066e6a 100644
> --- a/arch/mips/boot/tools/relocs_64.c
> +++ b/arch/mips/boot/tools/relocs_64.c
> @@ -9,17 +9,20 @@
>   
>   typedef uint8_t Elf64_Byte;
>   
> -typedef struct {
> -	Elf64_Word r_sym;	/* Symbol index.  */
> -	Elf64_Byte r_ssym;	/* Special symbol.  */
> -	Elf64_Byte r_type3;	/* Third relocation.  */
> -	Elf64_Byte r_type2;	/* Second relocation.  */
> -	Elf64_Byte r_type;	/* First relocation.  */
> +typedef union {
> +	struct {
> +		Elf64_Word r_sym;	/* Symbol index.  */
> +		Elf64_Byte r_ssym;	/* Special symbol.  */
> +		Elf64_Byte r_type3;	/* Third relocation.  */
> +		Elf64_Byte r_type2;	/* Second relocation.  */
> +		Elf64_Byte r_type;	/* First relocation.  */
> +	} fields;
> +	Elf64_Xword unused;
>   } Elf64_Mips_Rela;
>   
>   #define ELF_CLASS               ELFCLASS64
> -#define ELF_R_SYM(val)          (((Elf64_Mips_Rela *)(&val))->r_sym)
> -#define ELF_R_TYPE(val)         (((Elf64_Mips_Rela *)(&val))->r_type)
> +#define ELF_R_SYM(val)          (((Elf64_Mips_Rela *)(&val))->fields.r_sym)
> +#define ELF_R_TYPE(val)         (((Elf64_Mips_Rela *)(&val))->fields.r_type)
>   #define ELF_ST_TYPE(o)          ELF64_ST_TYPE(o)
>   #define ELF_ST_BIND(o)          ELF64_ST_BIND(o)
>   #define ELF_ST_VISIBILITY(o)    ELF64_ST_VISIBILITY(o)

Acked-by: Matt Redfearn <matt.redfearn@imgtec.com>
