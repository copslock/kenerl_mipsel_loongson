Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA492189; Mon, 18 Aug 1997 10:30:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA00690 for linux-list; Mon, 18 Aug 1997 10:29:55 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA00650; Mon, 18 Aug 1997 10:29:48 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA26259; Mon, 18 Aug 1997 10:29:44 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id TAA22950; Mon, 18 Aug 1997 19:29:28 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708181729.TAA22950@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA11345; Mon, 18 Aug 1997 19:29:27 +0200
Subject: Re: Booting Linux from second disk
To: eak@detroit.sgi.com
Date: Mon, 18 Aug 1997 19:29:26 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, miguel@nuclecu.unam.mx,
        jeremyw@motown.detroit.sgi.com, linux@cthulhu.engr.sgi.com,
        linux-progress@cthulhu.engr.sgi.com
In-Reply-To: <33F85EC7.90279798@cygnus.detroit.sgi.com> from "Eric Kimminau" at Aug 18, 97 10:40:07 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > > Unable to handle kernel paging request at virtual address 00000008, epc
> > > == 880cbc5c, ra == 880cbc3c
> > 
> > Could you send me the disassembler output of the kernel you've booted?
> > Use command like
> > 
> >   mips-linux-objdump -d vmlinux --start-address=0x880cbb00 --stop-address=0x880cd00
> > 
> > to produce the dissassembler listing.
> > 
> >   Ralf
> 
> Sorry, I got your message late on Friday. How do I acomplish this on a
> system that won't boot?

Use the crossdev tools :-)

  Ralf
