Received:  by oss.sgi.com id <S42377AbQI0XjP>;
	Wed, 27 Sep 2000 16:39:15 -0700
Received: from u-141.karlsruhe.ipdial.viaginterkom.de ([62.180.18.141]:62980
        "EHLO u-141.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42278AbQI0Xiz>; Wed, 27 Sep 2000 16:38:55 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869542AbQI0KeJ>;
        Wed, 27 Sep 2000 12:34:09 +0200
Date:   Wed, 27 Sep 2000 12:34:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     Brady Brown <bbrown@ti.com>, Keith Owens <kaos@melbourne.sgi.com>,
        SGI news group <linux-mips@oss.sgi.com>
Subject: Re: ELF/Modutils problem
Message-ID: <20000927123408.A28950@bacchus.dhis.org>
References: <20000921153631.A1238@bacchus.dhis.org> <1690.969616620@ocs3.ocs-net> <20000922153156.A2677@bacchus.dhis.org> <39CB7978.E222DF8E@ti.com> <20000923230632.A1639@bacchus.dhis.org> <6ovsnqqn4u1.fsf@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <6ovsnqqn4u1.fsf@calypso.engr.sgi.com>; from ulfc@calypso.engr.sgi.com on Sat, Sep 23, 2000 at 03:03:50PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Sep 23, 2000 at 03:03:50PM -0700, Ulf Carlsson wrote:

> > It's the assembler as below text case demonstrates.
> 
> Thanks.  I'll take a look at it.  I remember that I've looked at this
> problem once before.

This piece of gold in bfd/elf32-mips.c seems to be the problem:

/* Determine whether a symbol is global for the purposes of splitting
   the symbol table into global symbols and local symbols.  At least
   on Irix 5, this split must be between section symbols and all other
   symbols.  On most ELF targets the split is between static symbols
   and externally visible symbols.  */

/*ARGSUSED*/
static boolean
mips_elf_sym_is_global (abfd, sym)
     bfd *abfd ATTRIBUTE_UNUSED;
     asymbol *sym;
{
  return (sym->flags & BSF_SECTION_SYM) == 0 ? true : false;
}

So our objects are correct, just IRIX flavoured at this point ...  Now
for a proper fix I think I need somebody who knows IRIX ELF like his
pocket ...

  Ralf
