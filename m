Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 17:15:50 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:49562 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133621AbWDQQPm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 17:15:42 +0100
Received: from lagash (88-106-238-34.dynamic.dsl.as9105.com [88.106.238.34])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id F1D32449AF; Mon, 17 Apr 2006 18:28:06 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FVWZs-0005S9-Cs; Mon, 17 Apr 2006 17:27:52 +0100
Date:	Mon, 17 Apr 2006 17:27:42 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
Message-ID: <20060417162742.GD28935@networkno.de>
References: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp> <20060417125332.GB28935@networkno.de> <20060417140735.GC28935@networkno.de> <20060418.004718.108120830.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418.004718.108120830.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 17 Apr 2006 15:07:35 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > I should have read more carefully. The ELF_R_SYM seems to be correct, if
> > this patch makes it work fo you then the toolchain you use creates broken
> > (word-swapped ?) relocation entries for mips64el.
> 
> Looking at following codes in glibc source
> (sysdeps/mips/elf/ldsodefs.h), I thought r_info on 64bit mips needs
> special handling.  Is not this structure used for 64bit kernel
> modules?
> 
> typedef struct
> {
>   Elf32_Word    r_sym;		/* Symbol index */
>   unsigned char r_ssym;		/* Special symbol for 2nd relocation */
>   unsigned char r_type3;	/* 3rd relocation type */
>   unsigned char r_type2;	/* 2nd relocation type */
>   unsigned char r_type1;	/* 1st relocation type */
> } _Elf64_Mips_R_Info;


Hm, binutils uses generically 64bit quantities:

#define ELF32_R_SYM(i)		((i) >> 8)
#define ELF32_R_TYPE(i)		((i) & 0xff)
#define ELF32_R_INFO(s,t)	(((s) << 8) + ((t) & 0xff))

#define ELF64_R_SYM(i)		((i) >> 32)
#define ELF64_R_TYPE(i)		((i) & 0xffffffff)
#define ELF64_R_INFO(s,t)	(((bfd_vma) (s) << 31 << 1) + (bfd_vma) (t))


But for MIPS64 the same as glibc:

typedef struct
{
  /* Address of relocation.  */
  unsigned char r_offset[8];
  /* Symbol index.  */
  unsigned char r_sym[4];
  /* Special symbol.  */
  unsigned char r_ssym[1];
  /* Third relocation.  */
  unsigned char r_type3[1];
  /* Second relocation.  */
  unsigned char r_type2[1];
  /* First relocation.  */
  unsigned char r_type[1];
  /* Addend.  */
  unsigned char r_addend[8];
} Elf64_Mips_External_Rela;

/* MIPS ELF 64 relocation info access macros.  */
#define ELF64_MIPS_R_SSYM(i) (((i) >> 24) & 0xff)
#define ELF64_MIPS_R_TYPE3(i) (((i) >> 16) & 0xff)
#define ELF64_MIPS_R_TYPE2(i) (((i) >> 8) & 0xff)
#define ELF64_MIPS_R_TYPE(i) ((i) & 0xff)


So it is the

      r.r_info   = TO_NATIVE(rela->r_info);

in modpost.c which breaks both SYM and TYPE because it assumes a
64bit integer. The proper solution would be to add a Elf64_Mips_Rela
structure (with lots of nearly identical duplicated code), the hack
would be to cast r_info to a 32bit integer for mips, before feeding
it to TO_NATIVE (which works until somebody asks for the TYPE, then
a separate mips64 version becomes inevitable.)


Thiemo
