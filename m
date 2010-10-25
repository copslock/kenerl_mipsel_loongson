Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 20:17:41 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:33590 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061Ab0JYSRh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 20:17:37 +0200
Received: by gyg13 with SMTP id 13so2506268gyg.36
        for <multiple recipients>; Mon, 25 Oct 2010 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=onTN4r3jWARq4zSMXt+Sr+D5Rg5u7qssSFcpMnGZ7Ds=;
        b=WKb8cEik0PzDj2cmRuxLIhu/sV8yYHhPCj7Dl3N1wDBngxsz8axxvtlBLm0lAOJWuw
         Fq6q5D/bFJX8kCh4S1MQ/gshiKEpuh6FYUUENeEy05MUSwIySwndSUuswTi6YO1bwtGk
         T7lTWHCspKSdUrKEkD2c6zvMQVFVGqapJRhlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=E3tRdUKk8M5ETJt/RMNY03mK5/4TvOOvar+/f9CxQB95EL7UW2n1vpBV9KOXLKXvRJ
         RBfY4BJTWYz7PX5dwGLq4dE6WhozBgdCBIUvrZMLzM1lu8vi4YFGezd1ZkFUxXoJoEub
         RwXwZWGlYo27NZe0ruOP/9jXlX3lvirm4Qiyk=
MIME-Version: 1.0
Received: by 10.216.27.9 with SMTP id d9mr3410789wea.61.1288030649949; Mon, 25
 Oct 2010 11:17:29 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Mon, 25 Oct 2010 11:17:29 -0700 (PDT)
In-Reply-To: <4CC5B474.9050503@bitwagon.com>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
        <4CC49A99.1080601@bitwagon.com>
        <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
        <4CC5B474.9050503@bitwagon.com>
Date:   Tue, 26 Oct 2010 02:17:29 +0800
Message-ID: <AANLkTin=ym_e8009pHkn+7jtXG1toiKb1O3TS4FNQu3U@mail.gmail.com>
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     John Reiser <jreiser@bitwagon.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/26/10, John Reiser <jreiser@bitwagon.com> wrote:
> Here's a second try [discard the first] for handling MIPS64 in
> recordmcount.[ch].

Just tested the 64bit kernel, it works well.

Will test the 64bit module and the 32bit kernel and module tomorrow If
time allowed.

BTW, seems this patch can not be applied directly, suggest you
generate it by "git format" automatically ;-)

Thanks & Regards,
Wu Zhangjin

>
> Signed-off-by: John Reiser <jreiser@BitWagon.com
>
> diff --git a/recordmcount.c b/recordmcount.c
> index 7f7f718..7337ee8 100644
> --- a/recordmcount.c
> +++ b/recordmcount.c
> @@ -212,11 +212,48 @@ is_mcounted_section_name(char const *const txtname)
>  		0 == strcmp(".text.unlikely", txtname);
>  }
>
> +
>  /* 32 bit and 64 bit are very similar */
>  #include "recordmcount.h"
>  #define RECORD_MCOUNT_64
>  #include "recordmcount.h"
>
> +/* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
> + *
> http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
> + * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela)
> [p.40]
> + * to imply the order of the members; the spec does not say so.
> + *	typedef unsigned char Elf64_Byte;
> + * fails on MIPS64 because their <elf.h> already has it!
> + */
> +typedef unsigned char myElf64_byte;
> +typedef struct {
> +	Elf64_Addr    r_offset;               /* Address */
> +	struct {
> +		Elf64_Word r_sym;
> +		myElf64_byte r_ssym;  /* Special sym: gp-relative, etc. */
> +		myElf64_byte r_type3;
> +		myElf64_byte r_type2;
> +		myElf64_byte r_type;
> +	} r_info;
> +	Elf64_Sxword  r_addend;               /* Addend */
> +} MIPS64_Rela;
> +
> +static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
> +{
> +	return w(((MIPS64_Rela const *)rp)->r_info.r_sym);
> +}
> +
> +static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
> +{
> +	MIPS64_Rela *const m64rp = (MIPS64_Rela *)rp;
> +	m64rp->r_info.r_sym = w(sym);
> +	m64rp->r_info.r_ssym = 0;
> +	m64rp->r_info.r_type3 = 0;
> +	m64rp->r_info.r_type2 = 0;
> +	m64rp->r_info.r_type = type;
> +}
> +
> +
>  static void
>  do_file(char const *const fname)
>  {
> @@ -268,6 +305,7 @@ do_file(char const *const fname)
>  	case EM_386:	 reltype = R_386_32;                   break;
>  	case EM_ARM:	 reltype = R_ARM_ABS32;                break;
>  	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
> +	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
>  	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
>  	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
>  	case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
> @@ -291,6 +329,8 @@ do_file(char const *const fname)
>  		}
>  		if (EM_S390 == w2(ehdr->e_machine))
>  			reltype = R_390_32;
> +		if (EM_MIPS == w2(ehdr->e_machine))
> +			reltype = R_MIPS_32;
>  		do32(ehdr, fname, reltype);
>  	} break;
>  	case ELFCLASS64: {
> @@ -303,6 +343,11 @@ do_file(char const *const fname)
>  		}
>  		if (EM_S390 == w2(ghdr->e_machine))
>  			reltype = R_390_64;
> +		if (EM_MIPS == w2(ghdr->e_machine)) {
> +			reltype = R_MIPS_64;
> +			Elf64_r_sym = MIPS64_r_sym;
> +			Elf64_r_info = MIPS64_r_info;
> +		}
>  		do64(ghdr, fname, reltype);
>  	} break;
>  	}  /* end switch */
> diff --git a/recordmcount.h b/recordmcount.h
> index 7f39d09..190fd18 100644
> --- a/recordmcount.h
> +++ b/recordmcount.h
> @@ -31,8 +31,12 @@
>  #undef Elf_Rela
>  #undef Elf_Sym
>  #undef ELF_R_SYM
> +#undef Elf_r_sym
>  #undef ELF_R_INFO
> +#undef Elf_r_info
>  #undef ELF_ST_BIND
> +#undef fn_ELF_R_SYM
> +#undef fn_ELF_R_INFO
>  #undef uint_t
>  #undef _w
>  #undef _align
> @@ -52,8 +56,12 @@
>  # define Elf_Rela		Elf64_Rela
>  # define Elf_Sym		Elf64_Sym
>  # define ELF_R_SYM		ELF64_R_SYM
> +# define Elf_r_sym		Elf64_r_sym
>  # define ELF_R_INFO		ELF64_R_INFO
> +# define Elf_r_info		Elf64_r_info
>  # define ELF_ST_BIND		ELF64_ST_BIND
> +# define fn_ELF_R_SYM		fn_ELF64_R_SYM
> +# define fn_ELF_R_INFO		fn_ELF64_R_INFO
>  # define uint_t			uint64_t
>  # define _w			w8
>  # define _align			7u
> @@ -72,14 +80,32 @@
>  # define Elf_Rela		Elf32_Rela
>  # define Elf_Sym		Elf32_Sym
>  # define ELF_R_SYM		ELF32_R_SYM
> +# define Elf_r_sym		Elf32_r_sym
>  # define ELF_R_INFO		ELF32_R_INFO
> +# define Elf_r_info		Elf32_r_info
>  # define ELF_ST_BIND		ELF32_ST_BIND
> +# define fn_ELF_R_SYM		fn_ELF32_R_SYM
> +# define fn_ELF_R_INFO		fn_ELF32_R_INFO
>  # define uint_t			uint32_t
>  # define _w			w
>  # define _align			3u
>  # define _size			4
>  #endif
>
> +/* Functions and pointers that 64-bit EM_MIPS can override. */
> +static uint_t fn_ELF_R_SYM(Elf_Rel const *rp)
> +{
> +	return ELF_R_SYM(_w(rp->r_info));
> +}
> +static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
> +
> +static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
> +{
> +	rp->r_info = ELF_R_INFO(sym, type);
> +}
> +static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) =
> fn_ELF_R_INFO;
> +
> +
>  /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations.
> */
>  static void append_func(Elf_Ehdr *const ehdr,
>  			Elf_Shdr *const shstr,
> @@ -197,22 +223,22 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
>  	for (t = nrel; t; --t) {
>  		if (!mcountsym) {
>  			Elf_Sym const *const symp =
> -				&sym0[ELF_R_SYM(_w(relp->r_info))];
> +				&sym0[Elf_r_sym(relp)];
>  			char const *symname = &str0[w(symp->st_name)];
>   			if ('.' == symname[0])
>  				++symname;  /* ppc64 hack */
>  			if (0 == strcmp((('_' == gpfx) ? "_mcount" : "mcount"),
>  					symname))
> -				mcountsym = ELF_R_SYM(_w(relp->r_info));
> +				mcountsym = Elf_r_sym(relp);
>  		}
>
> -		if (mcountsym == ELF_R_SYM(_w(relp->r_info))) {
> +		if (mcountsym == Elf_r_sym(relp)) {
>  			uint_t const addend = _w(_w(relp->r_offset) - recval);
>   			mrelp->r_offset = _w(offbase
>  				+ ((void *)mlocp - (void *)mloc0));
> -			mrelp->r_info = _w(ELF_R_INFO(recsym, reltype));
> +			Elf_r_info(mrelp, recsym, reltype);
>  			if (sizeof(Elf_Rela) == rel_entsize) {
>  				((Elf_Rela *)mrelp)->r_addend = addend;
>  				*mlocp++ = 0;
>
> --
> John Reiser, jreiser@BitWagon.com
>
>
