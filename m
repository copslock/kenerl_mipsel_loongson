Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA131972; Fri, 15 Aug 1997 22:17:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA22033 for linux-list; Fri, 15 Aug 1997 22:17:38 -0700
Received: from motown.detroit.sgi.com (motown.detroit.sgi.com [169.238.128.3]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA22027; Fri, 15 Aug 1997 22:17:35 -0700
Received: from detroit.sgi.com by motown.detroit.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id BAA24083; Sat, 16 Aug 1997 01:17:29 -0400
Message-ID: <33F5377F.C05C1D42@detroit.sgi.com>
Date: Sat, 16 Aug 1997 01:15:43 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
CC: miguel@nuclecu.unam.mx, jeremyw@motown.detroit.sgi.com,
        linux@cthulhu.engr.sgi.com, linux-progress@cthulhu.engr.sgi.com
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

I will when I get back in the office on Monday, but its the latest
kernel available on ftp.linux:

ftp://ftp.linux.sgi.com/pub/test/vmlinux-970813-jwr.gz




-- 
Eric Kimminau                             System Engineer
eak@detroit.sgi.com                       Silicon Graphics, Inc
Vox:(810) 848-4455                        39001 West 12mile Road
Fax:(810)848-5600                         Farmington, MI 48331-2903
            "I speak my mind and no one else's."
    http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

-----END PGP PUBLIC KEY BLOCK-----
http://bs.mit.edu:11371/pks/lookup?op=vindex&search=Eric+A.+Kimminau&fingerprint=on
