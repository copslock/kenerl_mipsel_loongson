Return-Path: <owner-linux-mips@oss.sgi.com>
Received: from oss.sgi.com (IDENT:root@oss.sgi.com [216.32.174.190])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id DAA05862
	for <geert.uytterhoeven@sonycom.com>; Tue, 24 Oct 2000 03:20:14 +0200 (MET DST)
Received:  by oss.sgi.com id <S553712AbQJXBTh>;
	Mon, 23 Oct 2000 18:19:37 -0700
Received: from u-50.karlsruhe.ipdial.viaginterkom.de ([62.180.19.50]:23300
        "EHLO u-50.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553686AbQJXBTS>; Mon, 23 Oct 2000 18:19:18 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870343AbQJXBS2>;
        Tue, 24 Oct 2000 03:18:28 +0200
Date:   Tue, 24 Oct 2000 03:18:28 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Keith Owens <kaos@melbourne.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: problems with insmod ...
Message-ID: <20001024031828.A2816@bacchus.dhis.org>
References: <39F48742.933941B8@mvista.com> <7690.972340323@ocs3.ocs-net> <20001024024040.D1009@bacchus.dhis.org> <39F4E113.6BC85A5C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F4E113.6BC85A5C@mvista.com>; from jsun@mvista.com on Mon, Oct 23, 2000 at 06:08:35PM -0700
X-Accept-Language: de,en,fr
X-Orcpt: rfc822;linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
X-Keywords:
X-UID: 246
Message-ID: <20001024011828.HrDE97GCwJEtYlEXhjlcZVAnlzqQTMsBmfsAYtzeE_k@z>

On Mon, Oct 23, 2000 at 06:08:35PM -0700, Jun Sun wrote:

> > > Jun Sun <jsun@mvista.com> wrote:
> > > >I tried with 2.3.19, and now I am having problem with out of bound index
> > > >in symbol table.  See the output below.
> > > >
> > > >---------
> > > >sh-2.03# insmod hello.o
> > > >hello.o: local symbol gcc2_compiled. with index 10 exceeds
> > > >local_symtab_size 10
> > > >hello.o: local symbol __gnu_compiled_c with index 11 exceeds
> > > >local_symtab_size 10
> > > >---------
> > >
> > > It is a toolchain bug, I think it is in the assembler.  I have a dim
> > > distant memory from about a month ago that somebody on linux-mips found
> > > the problem.  Ask the toolchain experts.
> > 
> > It's a bug bug in ld, one in BFD and a sillyness in IRIX ELF which the linker
> > uses.  IRIX ELF uses different sorting rules for the symbol table, see
> > mips_elf_sym_is_global in bfd/elf32-mips.c.
> > 
> >  - Bug one: ld generated output should follow the same rules as assembler
> >    generated output.
> >  - Bug two is more a design flaw - why does Linux/MIPS and most other
> >    MIPS ELF configurations use IRIX and not ABI ELF?
> >  - Bug three is that mips_elf_sym_is_global applies these IRIX ELF sorting
> >    rules even to ABI ELF.
> > 
> >   Ralf
> 
> This sounds like a serious problem to me.  So here are the questions : 
> 
> 1) is it fixed in the latest binutils?

No, all binutils ever are affected.

> 2) is it worth fixed for binutil v2.8.1?

Probably not.  I believe modulo some testing current CVS binutils are ready
for more serious use than just binutils fixing.  In any case fixing should
be easy.

  Ralf


--OgqxwSJOaUobr8KG--
