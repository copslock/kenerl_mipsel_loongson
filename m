Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA21058; Mon, 9 Jun 1997 11:42:47 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA05082 for linux-list; Mon, 9 Jun 1997 11:42:31 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA05062 for <linux@cthulhu.engr.sgi.com>; Mon, 9 Jun 1997 11:42:29 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA25818 for <linux@yon.engr.sgi.com>; Mon, 9 Jun 1997 11:42:28 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA02169; Mon, 9 Jun 1997 11:42:26 -0700
Date: Mon, 9 Jun 1997 11:42:26 -0700
Message-Id: <199706091842.LAA02169@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@Julia.DE>
Cc: mende@piecomputer.engr.sgi.com (Bob Mende Pie), ariel@sgi.com,
        linux@yon.engr.sgi.com
Subject: Re: Merge back of the MIPS sources
In-Reply-To: <199706061836.UAA18495@kernel.panic.julia.de>
References: <199706061807.LAA01554@piecomputer.engr.sgi.com>
	<199706061836.UAA18495@kernel.panic.julia.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > >    Have you verified that the newest code still works on the other MIPS
 > > based systems?   Also, is it possible to have (linux) binary compatability
 > > between a mips Magnum or Millennium and an Indy?
 > 
 > By principle there is no problem to feed these machines even with IRIX
 > binaries.  Right now the port to these machines assumes that it is running
 > on the machine configured to little endian mode but porting to big endian
 > should be easy.

     Note, however, that running big-endian on the MIPS systems is a bit
of a hack.  They were originally designed to be little-endian-only (a MIPS
management aberration), so running big-endian means that, in general,
I/O DMA has to be byte-swapped by software.  RISCos would preferentially
write file systems on disks in native-endian format, which, if read on 
a different system, would appear to be byte-swapped within each doubleword.
That is, RISCos would skip the byte-swapping on non-removable media, unless
the magic number in the superblock indicated that the disk was initialized
in true big-endian format.  For all other media, RISCos would byte-swap,
but, since those were much lower data rate, the performance impact was
small.
