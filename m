Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA34543 for <linux-archive@neteng.engr.sgi.com>; Sun, 9 Aug 1998 06:35:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA42957
	for linux-list;
	Sun, 9 Aug 1998 06:34:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA16426
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 9 Aug 1998 06:34:55 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA26091
	for <linux@cthulhu.engr.sgi.com>; Sun, 9 Aug 1998 06:34:51 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z5VcX-0027wCC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 9 Aug 1998 15:34:49 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z5VcP-002OmBC; Sun, 9 Aug 98 15:34 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id PAA01603;
	Sun, 9 Aug 1998 15:27:15 +0200
Message-ID: <19980809152715.19085@alpha.franken.de>
Date: Sun, 9 Aug 1998 15:27:15 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: binutils 2.9.1.0.4 considered harmful
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

look what gas from binutils-2.9.1.0.4 produces, when building _eh.o
(libgcc.a).

RELOCATION RECORDS FOR [.eh_frame]:
OFFSET   TYPE              VALUE 
0000001c R_MIPS_32         .text
00000038 R_MIPS_32         .text
00000054 R_MIPS_32         .text
00000074 R_MIPS_32         .text
00000084 R_MIPS_32         .text
00000094 R_MIPS_32         .text
000000e4 R_MIPS_32         .text
00000134 R_MIPS_32         .text
00000144 R_MIPS_32         .text
00000160 R_MIPS_32         .text
0000017c R_MIPS_32         .text
00000198 R_MIPS_32         .text

000001b5 R_MIPS_32         .text
     ^^^

This bug is most likely responsible for my problems with libstdc++ on
my little endian box (SIGBUS in ld.so.1, when a program is linked against
libstc++). On the Indy I've build egcs with patched binutils 2.8.1 and there 
libstdc++ works, while on my Olli it doesn't (build with binutils 2.9.1.0.4).
Right now I'm rebuilding egcs to see, whether all of my libcstdc++ problems
are gone.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
