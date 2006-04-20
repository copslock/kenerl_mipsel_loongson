Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 01:07:28 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:8874 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133430AbWDTAGw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 01:06:52 +0100
Received: from lagash (88-106-238-34.dynamic.dsl.as9105.com [88.106.238.34])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1C924441E3; Thu, 20 Apr 2006 02:19:29 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FWMt4-0004Jx-Rj; Thu, 20 Apr 2006 01:19:10 +0100
Date:	Thu, 20 Apr 2006 01:19:00 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
Message-ID: <20060420001900.GC30806@networkno.de>
References: <20060417140735.GC28935@networkno.de> <20060418.004718.108120830.anemo@mba.ocn.ne.jp> <20060417162742.GD28935@networkno.de> <20060419.112228.108306767.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419.112228.108306767.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 17 Apr 2006 17:27:42 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > So it is the
> > 
> >       r.r_info   = TO_NATIVE(rela->r_info);
> > 
> > in modpost.c which breaks both SYM and TYPE because it assumes a
> > 64bit integer. The proper solution would be to add a Elf64_Mips_Rela
> > structure (with lots of nearly identical duplicated code), the hack
> > would be to cast r_info to a 32bit integer for mips, before feeding
> > it to TO_NATIVE (which works until somebody asks for the TYPE, then
> > a separate mips64 version becomes inevitable.)
> 
> I'd like to fix in _proper_ way.  Please review.  Thanks.
> 
> 
> 64bit mips has different r_info layout.  This patch fixes modpost
> segfault for 64bit little endian mips kernel.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index cd00e9f..4ce95c6 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -710,7 +710,20 @@ static void check_sec_ref(struct module 
>  			Elf_Rela r;
>  			const char *secname;
>  			r.r_offset = TO_NATIVE(rela->r_offset);
> +#if KERNEL_ELFCLASS == ELFCLASS64
> +			if (hdr->e_machine == EM_MIPS) {
> +				unsigned int r_sym =
> +					ELF64_MIPS_R_SYM(rela->r_info);
> +				unsigned int r_type =
> +					ELF64_MIPS_R_TYPE(rela->r_info);
> +				r.r_info = ELF_R_INFO(TO_NATIVE(r_sym),
> +						      TO_NATIVE(r_type));
[snip]
> +/* The 64-bit MIPS ELF ABI uses an unusual reloc format. */
> +typedef struct
> +{
> +  Elf32_Word    r_sym;		/* Symbol index */
> +  unsigned char r_ssym;		/* Special symbol for 2nd relocation */
> +  unsigned char r_type3;	/* 3rd relocation type */
> +  unsigned char r_type2;	/* 2nd relocation type */
> +  unsigned char r_type1;	/* 1st relocation type */
> +} _Elf64_Mips_R_Info;
[snip]
> +#define ELF64_MIPS_R_TYPE(i) \
> +  (((_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_type1 \
> +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> +		   ).r_info_fields.r_type2 << 8) \
> +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> +		   ).r_info_fields.r_type3 << 16) \
> +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> +		   ).r_info_fields.r_ssym << 24))

Why is it the right thing to combine the type info into a 32bit word?
It will never get used as such for MIPS ELF64. I would have expected
something like:

#define ELF64_MIPS_R_INFO(sym,ssym,t3,t2,t1)		\
{(							\
	_Elf64_Mips_R_Info info = {			\
		.r_sym = sym,				\
		.r_ssym = ssym,				\
		.r_type3 = t3,				\
		.r_type2 = t2,				\
		.r_type1 = t1,				\
	}						\
	(Elf64_Xword)info;				\
)}

without a corresponding ELF64_MIPS_R_TYPE, and then:

	if (hdr->e_ident[EI_CLASS] == ELFCLASS64
	    && hdr->e_machine == EM_MIPS) {
		_Elf64_Mips_R_Info info = (_Elf64_Mips_R_Info)r.r_info;
		r.r_info = ELF64_MIPS_R_INFO(TO_NATIVE(info.r_sym),
					     info.r_ssym, info.r_type3,
					     info.r_type2, info.r_type1);
	}


Thiemo
