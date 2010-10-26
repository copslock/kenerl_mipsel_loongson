Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 23:21:28 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:62252 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab0JZVVX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Oct 2010 23:21:23 +0200
Received: by wwb39 with SMTP id 39so4282038wwb.24
        for <multiple recipients>; Tue, 26 Oct 2010 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6lMWP5Im/f6BIAQZacciDHuYuhQzA39HRTpMfikINEQ=;
        b=LqdiDwMO5Netn+AbxdOMyl5PwsDwZXdHsrkkMVvobRZuPBPiVR3YraT0sytQMdWmm1
         yP714mK/kscQ95LQmo52u3/2zWZdLZJujYtRQO8F29/MK8AxN2Mz02zfmnTrB1vtNvHr
         U+7LuQHLcnmzrDlDsZwtuthkPWTkxnLLujdZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O75J+FIRIbxTHgfSk8ics7bJ97ZwNGgu75NQZHIYwDm3UE+dS3DlyIMpHsMiEYhS7i
         gACcLJdyPpVTbVAPByUF2w/seOvIUAeNk2WsYnsSm3/1z5I+yA9R82zt8IYcFo6TZVrA
         URW6EyxctyFFs00AfM4sFmGVp+qLTqkwD9oRA=
MIME-Version: 1.0
Received: by 10.216.158.140 with SMTP id q12mr3251wek.14.1288128077062; Tue,
 26 Oct 2010 14:21:17 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Tue, 26 Oct 2010 14:21:17 -0700 (PDT)
In-Reply-To: <4CC5B474.9050503@bitwagon.com>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
        <4CC49A99.1080601@bitwagon.com>
        <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
        <4CC5B474.9050503@bitwagon.com>
Date:   Wed, 27 Oct 2010 05:21:17 +0800
Message-ID: <AANLkTikhKZgR1XTEaMOQRVtBRxuwyWL0oxKQg3MhpYsR@mail.gmail.com>
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     John Reiser <jreiser@bitwagon.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, John & Steve

I just tested this patch and another patch of mine for the module
support on 32bit and 64bit MIPS, all of them works, so, it is time to
send the whole patchset out.

To john:

Your patch is perfect except the little feedback about type punning
from Maciej, I have fixed it in my local copy.

To add the full C version of recordmcount support for MIPS, we also
need to select the HAVE_C_RECORDMCOUNT in arch/mips/Kconfig and add my
patch for the module support. So, Can I send out the whole
patchset(including yours with your signed-off-by: and my tested-by:)?

Regards,
Wu Zhangjin

On Tue, Oct 26, 2010 at 12:46 AM, John Reiser <jreiser@bitwagon.com> wrote:
> Here's a second try [discard the first] for handling MIPS64 in recordmcount.[ch].
>
> Signed-off-by: John Reiser <jreiser@BitWagon.com
>
> diff --git a/recordmcount.c b/recordmcount.c
> index 7f7f718..7337ee8 100644
> --- a/recordmcount.c
> +++ b/recordmcount.c
> @@ -212,11 +212,48 @@ is_mcounted_section_name(char const *const txtname)
>                0 == strcmp(".text.unlikely", txtname);
>  }
>
> +
>  /* 32 bit and 64 bit are very similar */
>  #include "recordmcount.h"
>  #define RECORD_MCOUNT_64
>  #include "recordmcount.h"
>
> +/* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
> + * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
> + * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.40]
> + * to imply the order of the members; the spec does not say so.
> + *     typedef unsigned char Elf64_Byte;
> + * fails on MIPS64 because their <elf.h> already has it!
> + */
> +typedef unsigned char myElf64_byte;
> +typedef struct {
> +       Elf64_Addr    r_offset;               /* Address */
> +       struct {
> +               Elf64_Word r_sym;
> +               myElf64_byte r_ssym;  /* Special sym: gp-relative, etc. */
> +               myElf64_byte r_type3;
> +               myElf64_byte r_type2;
> +               myElf64_byte r_type;
> +       } r_info;
> +       Elf64_Sxword  r_addend;               /* Addend */
> +} MIPS64_Rela;
> +
> +static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
> +{
> +       return w(((MIPS64_Rela const *)rp)->r_info.r_sym);
> +}
> +
> +static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
> +{
> +       MIPS64_Rela *const m64rp = (MIPS64_Rela *)rp;
> +       m64rp->r_info.r_sym = w(sym);
> +       m64rp->r_info.r_ssym = 0;
> +       m64rp->r_info.r_type3 = 0;
> +       m64rp->r_info.r_type2 = 0;
> +       m64rp->r_info.r_type = type;
> +}
> +
> +
>  static void
>  do_file(char const *const fname)
>  {
> @@ -268,6 +305,7 @@ do_file(char const *const fname)
>        case EM_386:     reltype = R_386_32;                   break;
>        case EM_ARM:     reltype = R_ARM_ABS32;                break;
>        case EM_IA_64:   reltype = R_IA64_IMM64;   gpfx = '_'; break;
> +       case EM_MIPS:    /* reltype: e_class    */ gpfx = '_'; break;
>        case EM_PPC:     reltype = R_PPC_ADDR32;   gpfx = '_'; break;
>        case EM_PPC64:   reltype = R_PPC64_ADDR64; gpfx = '_'; break;
>        case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
> @@ -291,6 +329,8 @@ do_file(char const *const fname)
>                }
>                if (EM_S390 == w2(ehdr->e_machine))
>                        reltype = R_390_32;
> +               if (EM_MIPS == w2(ehdr->e_machine))
> +                       reltype = R_MIPS_32;
>                do32(ehdr, fname, reltype);
>        } break;
>        case ELFCLASS64: {
> @@ -303,6 +343,11 @@ do_file(char const *const fname)
>                }
>                if (EM_S390 == w2(ghdr->e_machine))
>                        reltype = R_390_64;
> +               if (EM_MIPS == w2(ghdr->e_machine)) {
> +                       reltype = R_MIPS_64;
> +                       Elf64_r_sym = MIPS64_r_sym;
> +                       Elf64_r_info = MIPS64_r_info;
> +               }
>                do64(ghdr, fname, reltype);
>        } break;
>        }  /* end switch */
> diff --git a/recordmcount.h b/recordmcount.h
> index 7f39d09..190fd18 100644
> --- a/recordmcount.h
> +++ b/recordmcount.h
> @@ -31,8 +31,12 @@
>  #undef Elf_Rela
>  #undef Elf_Sym
>  #undef ELF_R_SYM
> +#undef Elf_r_sym
>  #undef ELF_R_INFO
> +#undef Elf_r_info
>  #undef ELF_ST_BIND
> +#undef fn_ELF_R_SYM
> +#undef fn_ELF_R_INFO
>  #undef uint_t
>  #undef _w
>  #undef _align
> @@ -52,8 +56,12 @@
>  # define Elf_Rela              Elf64_Rela
>  # define Elf_Sym               Elf64_Sym
>  # define ELF_R_SYM             ELF64_R_SYM
> +# define Elf_r_sym             Elf64_r_sym
>  # define ELF_R_INFO            ELF64_R_INFO
> +# define Elf_r_info            Elf64_r_info
>  # define ELF_ST_BIND           ELF64_ST_BIND
> +# define fn_ELF_R_SYM          fn_ELF64_R_SYM
> +# define fn_ELF_R_INFO         fn_ELF64_R_INFO
>  # define uint_t                        uint64_t
>  # define _w                    w8
>  # define _align                        7u
> @@ -72,14 +80,32 @@
>  # define Elf_Rela              Elf32_Rela
>  # define Elf_Sym               Elf32_Sym
>  # define ELF_R_SYM             ELF32_R_SYM
> +# define Elf_r_sym             Elf32_r_sym
>  # define ELF_R_INFO            ELF32_R_INFO
> +# define Elf_r_info            Elf32_r_info
>  # define ELF_ST_BIND           ELF32_ST_BIND
> +# define fn_ELF_R_SYM          fn_ELF32_R_SYM
> +# define fn_ELF_R_INFO         fn_ELF32_R_INFO
>  # define uint_t                        uint32_t
>  # define _w                    w
>  # define _align                        3u
>  # define _size                 4
>  #endif
>
> +/* Functions and pointers that 64-bit EM_MIPS can override. */
> +static uint_t fn_ELF_R_SYM(Elf_Rel const *rp)
> +{
> +       return ELF_R_SYM(_w(rp->r_info));
> +}
> +static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
> +
> +static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
> +{
> +       rp->r_info = ELF_R_INFO(sym, type);
> +}
> +static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
> +
> +
>  /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
>  static void append_func(Elf_Ehdr *const ehdr,
>                        Elf_Shdr *const shstr,
> @@ -197,22 +223,22 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
>        for (t = nrel; t; --t) {
>                if (!mcountsym) {
>                        Elf_Sym const *const symp =
> -                               &sym0[ELF_R_SYM(_w(relp->r_info))];
> +                               &sym0[Elf_r_sym(relp)];
>                        char const *symname = &str0[w(symp->st_name)];
>                        if ('.' == symname[0])
>                                ++symname;  /* ppc64 hack */
>                        if (0 == strcmp((('_' == gpfx) ? "_mcount" : "mcount"),
>                                        symname))
> -                               mcountsym = ELF_R_SYM(_w(relp->r_info));
> +                               mcountsym = Elf_r_sym(relp);
>                }
>
> -               if (mcountsym == ELF_R_SYM(_w(relp->r_info))) {
> +               if (mcountsym == Elf_r_sym(relp)) {
>                        uint_t const addend = _w(_w(relp->r_offset) - recval);
>                        mrelp->r_offset = _w(offbase
>                                + ((void *)mlocp - (void *)mloc0));
> -                       mrelp->r_info = _w(ELF_R_INFO(recsym, reltype));
> +                       Elf_r_info(mrelp, recsym, reltype);
>                        if (sizeof(Elf_Rela) == rel_entsize) {
>                                ((Elf_Rela *)mrelp)->r_addend = addend;
>                                *mlocp++ = 0;
>
> --
> John Reiser, jreiser@BitWagon.com
>
>
