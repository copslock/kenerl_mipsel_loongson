Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA97129 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 03:09:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA94070
	for linux-list;
	Sun, 12 Jul 1998 03:09:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA08308
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 03:09:15 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de ([193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA01373
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 02:35:57 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yvIXz-0027tAC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 12 Jul 1998 11:35:55 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yvIXs-002Or9C; Sun, 12 Jul 98 11:35 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA00851;
	Sun, 12 Jul 1998 11:29:49 +0200
Message-ID: <19980712112949.25350@alpha.franken.de>
Date: Sun, 12 Jul 1998 11:29:49 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: One good and some bad news
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

first the good news: 

Yesterday XF68_FBDev showed the first ugly gray X11 screen on my 
Olivetti M700. Yeah !

But after killing the X server, I've got a dbe in check_tty_count.

This was the first bad news. To get XF68_FBDev to work, I had to
discover, that the logic with MAP_MASK is broken. When you look in
memory.c in function remap_pte_range(), you will find following:


                mapnr = MAP_NR(__va(phys_addr));
                if (mapnr >= max_mapnr || PageReserved(mem_map+mapnr))
                        set_pte(pte, mk_pte_phys(phys_addr, prot));


These works perfect for addresses in the first 512MB of address space
(MAP_MASK is 0x1fffffff), but it fails when you use 0x40000000 (frame
buffer address of the Olli). My first shot to fix that, was to use
0x7fffffff MAP_MASK, but resulted in a not working kernel, no idea why.
To cludge this problem I've changed the code:

                mapnr = MAP_NR(__va(phys_addr));
                if (mapnr >= max_mapnr || PageReserved(mem_map+mapnr))
                        set_pte(pte, mk_pte_phys(phys_addr, prot));
                if (phys_addr > MAP_MASK)
                        set_pte(pte, mk_pte_phys(__va(phys_addr), prot));

This works, but as this is common Linux code, Linus will never accept
it, even with a #ifdef __mips__ around the second if. While writing this
mail, I got an idea. Would it work, when we change MAP_NR to something like:

#define MAP_NR(addr)    (((addr) > MAP_MASK) ? 0xffffffff : \
			((((unsigned long)(addr)) & MAP_MASK) >> PAGE_SHIFT))

I'll try it later.

Another bad news, I've tried to build egcs. egcs itself build fine, but
when linking the shared library libstdc++, ld bombs out with a signal 6.
As I was still using binutils-2.8.1, I've compiled bintuils-2.9.1.0.4.
But the problem remains the same. I hope to get the gdb fixes from Ralf,
to look at this problem.

Binutils 2.9.1.0.4 seem to work ok, but I get following messages, when
linking programs:

ld: Warning: type of symbol `_fini' changed from 1 to 2 in /usr/lib/crti.o
ld: Warning: type of symbol `_gp_disp' changed from 1 to 3 in /lib/libc.so.6

I guess, it will go way, when I rebuild glibc with the new binutils, but
can someone explain to me, what's the reason for these messages.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
