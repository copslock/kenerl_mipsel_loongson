Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 16:18:01 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:46794 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225316AbTKDQRt>;
	Tue, 4 Nov 2003 16:17:49 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1AH3sD-0000N7-Sk; Tue, 04 Nov 2003 11:17:41 -0500
Date: Tue, 4 Nov 2003 11:17:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: jsun@mvista.com, linux-mips@linux-mips.org,
	binutils@sources.redhat.com, aoliva@redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
Message-ID: <20031104161741.GA302@nevyn.them.org>
Mail-Followup-To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com,
	aoliva@redhat.com
References: <20031029.163201.39178653.nemoto@toshiba-tops.co.jp> <20031029101400.J30683@mvista.com> <20031029181516.GA14443@nevyn.them.org> <20031030.215453.78703232.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030.215453.78703232.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 30, 2003 at 09:54:53PM +0900, Atsushi Nemoto wrote:
> >>>>> On Wed, 29 Oct 2003 13:15:17 -0500, Daniel Jacobowitz <dan@debian.org> said:
> dan> Atsushi-san's program would not even link with a binutils that
> dan> didn't support multiple GOTs; I guess that something is going
> dan> wrong with that support.
> 
> Yes, I guess too.
> 
> dan> I don't suppose you could provide a testcase?
> 
> I wrote a short script to generate a testcase.  Running attached awk
> script create src0.c, src1.c, ..., src3.c.
> 
> $ mips-linux-gcc -c src[0-4].c
> $ mips-linux-gcc -o bigapp src[0-4].o
> 
> This bigapp program compiled with binutils-2.14, gcc-3.3.2, uClibc
> 0.9.21 is corrupted.
> 
> Here is some outputs from readelf:
> 
> $ mips-linux-readelf -S bigapp
> There are 31 section headers, starting at offset 0x36ad78:
> 
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>   [ 1] .interp           PROGBITS        004000f4 0000f4 00000d 00   A  0   0  1
>   [ 2] .reginfo          MIPS_REGINFO    00400104 000104 000018 18   A  0   0  4
>   [ 3] .dynamic          DYNAMIC         0040011c 00011c 0000d8 08   A  6   0  4
>   [ 4] .hash             HASH            004001f4 0001f4 028784 04   A  5   0  4
>   [ 5] .dynsym           DYNSYM          00428978 028978 061c40 10   A  6   1  4
>   [ 6] .dynstr           STRTAB          0048a5b8 08a5b8 041da5 00   A  0   0  1
>   [ 7] .init             PROGBITS        004cc370 0cc370 0000ac 00  AX  0   0  4
>   [ 8] .text             PROGBITS        004cc420 0cc420 1b7d60 00  AX  0   0 16
>   [ 9] .fini             PROGBITS        00684180 284180 00005c 00  AX  0   0  4
>   [10] .rodata           PROGBITS        006841e0 2841e0 000010 00   A  0   0 16
>   [11] .data             PROGBITS        10000000 285000 000010 00  WA  0   0 16
>   [12] .rld_map          PROGBITS        10000010 285010 000004 00  WA  0   0  4
>   [13] .eh_frame         PROGBITS        10000014 285014 000004 00   A  0   0  4
>   [14] .ctors            PROGBITS        10000018 285018 000008 00  WA  0   0  4
>   [15] .dtors            PROGBITS        10000020 285020 000008 00  WA  0   0  4
>   [16] .jcr              PROGBITS        10000028 285028 000004 00  WA  0   0  4
>   [17] .got              PROGBITS        10000030 285030 02245c 04 WAp  0   0 16
>   [18] .sbss             NOBITS          1002248c 2a7490 000000 00 WAp  0   0  1
>   [19] .bss              NOBITS          10022490 2a7490 000020 00  WA  0   0 16
>   [20] .comment          PROGBITS        00000000 2a7490 0000a2 00      0   0  1
>   [21] .debug_aranges    MIPS_DWARF      00000000 2a7538 000020 00      0   0  8
>   [22] .debug_info       MIPS_DWARF      00000000 2a7558 000069 00      0   0  1
>   [23] .debug_abbrev     MIPS_DWARF      00000000 2a75c1 000014 00      0   0  1
>   [24] .debug_line       MIPS_DWARF      00000000 2a75d5 000044 00      0   0  1
>   [25] .pdr              PROGBITS        00000000 2a761c 0c3660 00      0   0  4
>   [26] .rel.dyn          REL             004cc360 0cc360 000010 08   A  5   0 16
>   [27] .mdebug.abi32     PROGBITS        00000000 36ac7c 000000 00      0   0  1
>   [28] .shstrtab         STRTAB          00000000 36ac7c 0000fb 00      0   0  1
>   [29] .symtab           SYMTAB          00000000 36b250 0620a0 10     30  45  4
>   [30] .strtab           STRTAB          00000000 3cd2f0 041ee7 00      0   0  1
> Key to Flags:
>   W (write), A (alloc), X (execute), M (merge), S (strings)
>   I (info), L (link order), G (group), x (unknown)
>   O (extra OS processing required) o (OS specific), p (processor specific)
> $ mips-linux-readelf -r bigapp
> 
> Relocation section '.rel.dyn' at offset 0xcc360 contains 2 entries:
>  Offset     Info    Type            Sym.Value  Sym. Name
> 00000000  00000000 R_MIPS_NONE      
> 1001f4f0  00314703 R_MIPS_REL32      004cc490   getpid
> $ mips-linux-readelf -x 17 bigapp | grep 1001f4f0
>   0x1001f4f0 004cc490 005ea570 00655ba0 0062c9e0 .L...^.p.e[..b..
> $ mips-linux-readelf -s bigapp | grep getpid
>  12615: 004cc490     0 FUNC    GLOBAL DEFAULT  UND getpid
>   4109: 004cc490     0 FUNC    GLOBAL DEFAULT  UND getpid

Now this is very strange.  Please bear with me; I have the bad habit of
starting my email before I've fully figured out the problem...


MIPS, at least MIPS/Linux, has a very odd ELF ABI.  The following isn't
based on documentation, just on my reading of the glibc loader.  The
.got section is relocated implicitly; dynamic relocations aren't even
_used_ normally, in the single-GOT case.

First we have reserved entres; two of them.  Then local got entries;
DT_MIPS_LOCAL_GOTNO of them.  They get the library base added.  Then
global entries.  We start in the dynsym table at DT_MIPS_GOTSYM, and
count up to just under DT_MIPS_SYMTABNO; GOT entries are set to the
address of the referenced symbol.

The loader does not require or expect any dynamic relocations to refer
to the .got section.  It also doesn't seem to care what's there, at
least not for external functions - defined functions and sections are
another matter.  So it doesn't expect the relocation to be there. 


Now, here's the peculiar thing:
drow@nevyn:~/mips-got% readelf -Ds app | sort -n | grep UND
   55 3777: 00000000     0  NOTYPE   WEAK DEFAULT UND __gmon_start__
  768 1005: 00000000     0  NOTYPE   WEAK DEFAULT UND _Jv_RegisterClasses
  5231 8511: 00000000     0    FUNC GLOBAL DEFAULT UND __libc_start_main
  13350 4887: 00000000     0    FUNC GLOBAL DEFAULT UND getpid
  22116 8185: 00000000     0    FUNC GLOBAL DEFAULT UND printf
drow@nevyn:~/mips-got% readelf -Dr app                     

'REL' relocation section at offset 0x4d8700 contains 24 bytes:
 Offset     Info    Type            Sym.Value  Sym. Name
00000000  00000000 R_MIPS_NONE      
1001c53c  00342603 R_MIPS_REL32      00000000   getpid
100196c4  00566403 R_MIPS_REL32      00000000   printf


i.e. there are five undefined symbols, and I'm guessing that the ones
in the first created GOT don't get REL32 relocations emitted.

A little poking in binutils reveals that this is deliberate.  This
comment, from the multigot patch in January:
  /* A pointer to the primary got, i.e., the one that's going to get
     the implicit relocations from DT_MIPS_LOCAL_GOTNO and
     DT_MIPS_GOTSYM.  */
  struct mips_got_info *primary;

There's only one problem - it doesn't work the way that comment
suggests.  got[2] through got[DT_MIPS_LOCAL_GOTNO - 1] are relocated
by l_addr, as local GOT entries.  Then got[DT_MIPS_LOCAL_GOTNO] through
got[DT_MIPS_SYMTABNO - 1] are relocated as global GOT entries.  So
DT_MIPS_SYMTABNO is probably intended to be the number of symbols _used
by the primary GOT_.  Not the total size of .dynsym.


Reading the comments in elfxx-mips.c it looks like this shouldn't
even be happening; the global symbols should end up in the "master
GOT".  And there should be stubs.  But in my tests the stubs don't get
built, and the value in the GOT for getpid points to func0_4663.  And I
can't find code that ought to create them.  So I'm going to have to
punt to Alexandre for details.  A quick potential fix might be changing
DT_MIPS_SYMTABNO.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
