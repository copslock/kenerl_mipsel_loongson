Received:  by oss.sgi.com id <S553698AbQJXAlS>;
	Mon, 23 Oct 2000 17:41:18 -0700
Received: from u-50.karlsruhe.ipdial.viaginterkom.de ([62.180.19.50]:20228
        "EHLO u-50.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553686AbQJXAk6>; Mon, 23 Oct 2000 17:40:58 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870342AbQJXAkk>;
        Tue, 24 Oct 2000 02:40:40 +0200
Date:   Tue, 24 Oct 2000 02:40:40 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: problems with insmod ...
Message-ID: <20001024024040.D1009@bacchus.dhis.org>
References: <39F48742.933941B8@mvista.com> <7690.972340323@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <7690.972340323@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Tue, Oct 24, 2000 at 09:32:03AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 09:32:03AM +1100, Keith Owens wrote:

> On Mon, 23 Oct 2000 11:45:22 -0700, 
> Jun Sun <jsun@mvista.com> wrote:
> >I tried with 2.3.19, and now I am having problem with out of bound index
> >in symbol table.  See the output below.
> >
> >---------
> >sh-2.03# insmod hello.o
> >hello.o: local symbol gcc2_compiled. with index 10 exceeds
> >local_symtab_size 10
> >hello.o: local symbol __gnu_compiled_c with index 11 exceeds
> >local_symtab_size 10
> >---------
> 
> It is a toolchain bug, I think it is in the assembler.  I have a dim
> distant memory from about a month ago that somebody on linux-mips found
> the problem.  Ask the toolchain experts.

It's a bug bug in ld, one in BFD and a sillyness in IRIX ELF which the linker
uses.  IRIX ELF uses different sorting rules for the symbol table, see
mips_elf_sym_is_global in bfd/elf32-mips.c.

 - Bug one: ld generated output should follow the same rules as assembler
   generated output.
 - Bug two is more a design flaw - why does Linux/MIPS and most other
   MIPS ELF configurations use IRIX and not ABI ELF?
 - Bug three is that mips_elf_sym_is_global applies these IRIX ELF sorting
   rules even to ABI ELF.

  Ralf
