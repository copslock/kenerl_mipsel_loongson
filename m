Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA116922; Fri, 15 Aug 1997 15:52:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA20954 for linux-list; Fri, 15 Aug 1997 15:51:43 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA20904; Fri, 15 Aug 1997 15:51:33 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA15899; Fri, 15 Aug 1997 15:51:22 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id AAA28505; Sat, 16 Aug 1997 00:51:06 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708152251.AAA28505@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA05929; Sat, 16 Aug 1997 00:51:03 +0200
Subject: Re: Booting Linux from second disk
To: eak@detroit.sgi.com
Date: Sat, 16 Aug 1997 00:51:02 +0200 (MET DST)
Cc: miguel@nuclecu.unam.mx, jeremyw@motown.detroit.sgi.com,
        linux@cthulhu.engr.sgi.com, linux-progress@cthulhu.engr.sgi.com
In-Reply-To: <33F4B980.A17A25CD@cygnus.detroit.sgi.com> from "Eric Kimminau" at Aug 15, 97 04:18:08 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> boot -f bootp()labb.detroit:/tftpboot/linux/vmlinux
> nfsaddrs=169.238.129.18,169.238.129.5
> 
> labb (tftpboot server=169.238.129.5, linux=169.238.129.18)
> 
> It boots but as soon as it sees the ethernet driver we get this:
> 
> eth0: SGI Seeq8003 08:00:69:07:e6:29  (which is our correct MAC addr)_
> Unable to handle kernel paging request at virtual address 00000008, epc
> == 880cbc5c, ra == 880cbc3c

Could you send me the disassembler output of the kernel you've booted?
Use command like

  mips-linux-objdump -d vmlinux --start-address=0x880cbb00 --stop-address=0x880cd00

to produce the dissassembler listing.

  Ralf
