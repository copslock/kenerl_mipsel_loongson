Received:  by oss.sgi.com id <S553716AbQJXBHS>;
	Mon, 23 Oct 2000 18:07:18 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:57840 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553679AbQJXBHL>;
	Mon, 23 Oct 2000 18:07:11 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9O15f302417;
	Mon, 23 Oct 2000 18:05:41 -0700
Message-ID: <39F4E113.6BC85A5C@mvista.com>
Date:   Mon, 23 Oct 2000 18:08:35 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Keith Owens <kaos@melbourne.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: problems with insmod ...
References: <39F48742.933941B8@mvista.com> <7690.972340323@ocs3.ocs-net> <20001024024040.D1009@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Tue, Oct 24, 2000 at 09:32:03AM +1100, Keith Owens wrote:
> 
> > On Mon, 23 Oct 2000 11:45:22 -0700,
> > Jun Sun <jsun@mvista.com> wrote:
> > >I tried with 2.3.19, and now I am having problem with out of bound index
> > >in symbol table.  See the output below.
> > >
> > >---------
> > >sh-2.03# insmod hello.o
> > >hello.o: local symbol gcc2_compiled. with index 10 exceeds
> > >local_symtab_size 10
> > >hello.o: local symbol __gnu_compiled_c with index 11 exceeds
> > >local_symtab_size 10
> > >---------
> >
> > It is a toolchain bug, I think it is in the assembler.  I have a dim
> > distant memory from about a month ago that somebody on linux-mips found
> > the problem.  Ask the toolchain experts.
> 
> It's a bug bug in ld, one in BFD and a sillyness in IRIX ELF which the linker
> uses.  IRIX ELF uses different sorting rules for the symbol table, see
> mips_elf_sym_is_global in bfd/elf32-mips.c.
> 
>  - Bug one: ld generated output should follow the same rules as assembler
>    generated output.
>  - Bug two is more a design flaw - why does Linux/MIPS and most other
>    MIPS ELF configurations use IRIX and not ABI ELF?
>  - Bug three is that mips_elf_sym_is_global applies these IRIX ELF sorting
>    rules even to ABI ELF.
> 
>   Ralf

This sounds like a serious problem to me.  So here are the questions : 

1) is it fixed in the latest binutils?
2) is it worth fixed for binutil v2.8.1?

I might be able to fix this problem, but I surely need some fill-ins.

Jun
