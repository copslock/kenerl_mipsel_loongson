Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA73087 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Mar 1999 15:10:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA21032
	for linux-list;
	Mon, 8 Mar 1999 15:08:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA74467
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Mar 1999 15:08:21 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA01635
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Mar 1999 15:08:02 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10K989-0027TtC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 9 Mar 1999 00:08:13 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10K983-002OyjC; Tue, 9 Mar 99 00:08 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02855;
	Tue, 9 Mar 1999 00:02:34 +0100
Message-ID: <19990309000234.A2804@alpha.franken.de>
Date: Tue, 9 Mar 1999 00:02:34 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: eedthwo@eede.ericsson.se, linux@cthulhu.engr.sgi.com
Subject: Re: Illegal f_magic number while install-procedure
References: <199903081247.NAA02741@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903081247.NAA02741@sun168.eu>; from Tom Woelfel on Mon, Mar 08, 1999 at 01:47:03PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Mar 08, 1999 at 01:47:03PM +0100, Tom Woelfel wrote:
> Cannot load bootp()/vmlinux
> Illegal f_magic number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC.

your prom is too old to understand ELF files. To solve this problem you
need either a newer prom or an Indy kernel in ECOFF format.

I've successful booted a converted kernel a few minutes ago and will upload
this kernel to

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990226.ecoff.gz

Please try it.

I've created it with a modified elf2ecoff tool from the kernel sources
on the Indy itself (it works only when used on a machine with the same
endian as the kernel). I look into fixing byte ordering problems in elf2ecoff
to allow even cross compiling of kernels on opposite endian machines.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
