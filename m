Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA06394 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 14:09:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA54330
	for linux-list;
	Sun, 12 Jul 1998 14:08:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA89426
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 14:08:36 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA24239
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 14:08:35 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-07.uni-koblenz.de [141.26.249.7])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA04754
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 23:08:16 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA17825;
	Sun, 12 Jul 1998 19:01:36 +0200
Message-ID: <19980712190135.R10756@uni-koblenz.de>
Date: Sun, 12 Jul 1998 19:01:35 +0200
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: One good and some bad news
References: <19980712112949.25350@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980712112949.25350@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Jul 12, 1998 at 11:29:49AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 12, 1998 at 11:29:49AM +0200, Thomas Bogendoerfer wrote:

> first the good news: 
> 
> Yesterday XF68_FBDev showed the first ugly gray X11 screen on my 
> Olivetti M700. Yeah !

Does this mean the X Server which I've built is running without
changes?

> But after killing the X server, I've got a dbe in check_tty_count.

DBE has a nasty property, it can be delayed until some write access
is written back from cache to memory.  The EPC then often points to
completly useless addresses.

> This was the first bad news. To get XF68_FBDev to work, I had to
> discover, that the logic with MAP_MASK is broken. When you look in
> memory.c in function remap_pte_range(), you will find following:
> 
> 
>                 mapnr = MAP_NR(__va(phys_addr));
>                 if (mapnr >= max_mapnr || PageReserved(mem_map+mapnr))
>                         set_pte(pte, mk_pte_phys(phys_addr, prot));
> 
> 
> These works perfect for addresses in the first 512MB of address space
> (MAP_MASK is 0x1fffffff), but it fails when you use 0x40000000 (frame
> buffer address of the Olli). My first shot to fix that, was to use
> 0x7fffffff MAP_MASK, but resulted in a not working kernel, no idea why.

Some places in the kernel also pass uncached addresses to MAP_NR().  In
order to make that work right I decieded back in '94 to mask out everything
but the bits that might be set in the physical address corrosponding to a
KSEG0 address.

Fix: try to track down the places that pass something else than a KSEG0
address for RAM, convert the addresses to KSEG0.  Eleminate the entire
MAP_MASK thing.  Change __va() such that it can deals properly with
addresses >= 512mb.

The Olli case is somewhat special because the designers had the gorgeuous
idea of placing some peripherals outside the lowest 4gb therefore more
fun with EISA mappings for example ahead ...

> To cludge this problem I've changed the code:
> 
>                 mapnr = MAP_NR(__va(phys_addr));
>                 if (mapnr >= max_mapnr || PageReserved(mem_map+mapnr))
>                         set_pte(pte, mk_pte_phys(phys_addr, prot));
>                 if (phys_addr > MAP_MASK)
>                         set_pte(pte, mk_pte_phys(__va(phys_addr), prot));
> 
> This works, but as this is common Linux code, Linus will never accept
> it, even with a #ifdef __mips__ around the second if. While writing this
> mail, I got an idea. Would it work, when we change MAP_NR to something like:
> 
> #define MAP_NR(addr)    (((addr) > MAP_MASK) ? 0xffffffff : \
> 			((((unsigned long)(addr)) & MAP_MASK) >> PAGE_SHIFT))
> 
> I'll try it later.

Which is basically my suggestion from above.  I'd just prefer to see the
fix in __va.

> Another bad news, I've tried to build egcs. egcs itself build fine, but
> when linking the shared library libstdc++, ld bombs out with a signal 6.
> As I was still using binutils-2.8.1, I've compiled bintuils-2.9.1.0.4.
> But the problem remains the same. I hope to get the gdb fixes from Ralf,
> to look at this problem.
> 
> Binutils 2.9.1.0.4 seem to work ok, but I get following messages, when
> linking programs:
> 
> ld: Warning: type of symbol `_fini' changed from 1 to 2 in /usr/lib/crti.o

That's data object -> code object.

> ld: Warning: type of symbol `_gp_disp' changed from 1 to 3 in /lib/libc.so.6

And this is a data object -> section symbol.

These type of warning messae often indicate serious trouble.

> I guess, it will go way, when I rebuild glibc with the new binutils, but
> can someone explain to me, what's the reason for these messages.

In ELF every symbol has a type and a size.  If linker encounters conflicting
definitions, it will issue warnings.

Note that the symbol _gp_disp is absolute black magic used for MIPS PIC code.
References against it are automatically generated by the assembler and
resolved by the linker.  It's never defined or referenced in normal source
code.  I'm therefore somewhat worried.

  Ralf
