Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id HAA459062; Mon, 18 Aug 1997 07:40:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA26944 for linux-list; Mon, 18 Aug 1997 07:40:20 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA26913; Mon, 18 Aug 1997 07:40:17 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id KAA13662; Mon, 18 Aug 1997 10:40:07 -0400
Message-ID: <33F85EC7.90279798@cygnus.detroit.sgi.com>
Date: Mon, 18 Aug 1997 10:40:07 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
CC: eak@detroit.sgi.com, miguel@nuclecu.unam.mx,
        jeremyw@motown.detroit.sgi.com, linux@cthulhu.engr.sgi.com,
        linux-progress@cthulhu.engr.sgi.com
Subject: Re: Booting Linux from second disk
References: <199708152251.AAA28505@informatik.uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> > boot -f bootp()labb.detroit:/tftpboot/linux/vmlinux
> > nfsaddrs=169.238.129.18,169.238.129.5
> >
> > labb (tftpboot server=169.238.129.5, linux=169.238.129.18)
> >
> > It boots but as soon as it sees the ethernet driver we get this:
> >
> > eth0: SGI Seeq8003 08:00:69:07:e6:29  (which is our correct MAC addr)_
> > Unable to handle kernel paging request at virtual address 00000008, epc
> > == 880cbc5c, ra == 880cbc3c
> 
> Could you send me the disassembler output of the kernel you've booted?
> Use command like
> 
>   mips-linux-objdump -d vmlinux --start-address=0x880cbb00 --stop-address=0x880cd00
> 
> to produce the dissassembler listing.
> 
>   Ralf

Sorry, I got your message late on Friday. How do I acomplish this on a
system that won't boot?

-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"

Windows 95: n.
    32 bit extensions and a graphical shell for a 16 bit patch to an
    8 bit operating system originally coded for a 4 bit microprocessor,
    written by a 2 bit company that can't stand 1 bit of competition.

    Author unknown.
