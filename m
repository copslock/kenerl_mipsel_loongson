Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 17:11:20 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:59033 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133547AbWDTQLL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 17:11:11 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id CEAD7441B4; Thu, 20 Apr 2006 18:23:53 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FWbw7-0004r3-IB; Thu, 20 Apr 2006 17:23:19 +0100
Date:	Thu, 20 Apr 2006 17:23:19 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
Message-ID: <20060420162319.GD10665@networkno.de>
References: <20060417162742.GD28935@networkno.de> <20060419.112228.108306767.anemo@mba.ocn.ne.jp> <20060420001900.GC30806@networkno.de> <20060421.010237.25910405.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421.010237.25910405.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 20 Apr 2006 01:19:00 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > > +#define ELF64_MIPS_R_TYPE(i) \
> > > +  (((_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_type1 \
> > > +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> > > +		   ).r_info_fields.r_type2 << 8) \
> > > +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> > > +		   ).r_info_fields.r_type3 << 16) \
> > > +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> > > +		   ).r_info_fields.r_ssym << 24))
> > 
> > Why is it the right thing to combine the type info into a 32bit word?
> 
> Well, I just take ELF64_MIPS_R_TYPE() from glibc source.

It is not more useful in glibc. :-)  Any use of the TYPE data will have
to take the MIPS64 specifics in account, and thus split it up again
into single characters.

> > It will never get used as such for MIPS ELF64. I would have expected
> > something like:
> > 
> > #define ELF64_MIPS_R_INFO(sym,ssym,t3,t2,t1)		\
> > {(							\
> > 	_Elf64_Mips_R_Info info = {			\
> > 		.r_sym = sym,				\
> > 		.r_ssym = ssym,				\
> > 		.r_type3 = t3,				\
> > 		.r_type2 = t2,				\
> > 		.r_type1 = t1,				\
> > 	}						\
> > 	(Elf64_Xword)info;				\
> > )}
> > 
> > without a corresponding ELF64_MIPS_R_TYPE, and then:
> > 
> > 	if (hdr->e_ident[EI_CLASS] == ELFCLASS64
> > 	    && hdr->e_machine == EM_MIPS) {
> > 		_Elf64_Mips_R_Info info = (_Elf64_Mips_R_Info)r.r_info;
> > 		r.r_info = ELF64_MIPS_R_INFO(TO_NATIVE(info.r_sym),
> > 					     info.r_ssym, info.r_type3,
> > 					     info.r_type2, info.r_type1);
> > 	}
> 
> Sorry, I can not see what you mean ... it just does byte-swap only
> r_sym part, doesn't it?  It is not enough because a position of r_sym
> in MIPS ELF64 r_info is different from standard ELF64 r_info.

But it does so for a _Elf64_Mips_R_Info struct, which already keeps
the position of its r_sym field endianness independent.


Thiemo
