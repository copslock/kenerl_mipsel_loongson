Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA71031 for <linux-archive@neteng.engr.sgi.com>; Fri, 10 Oct 1997 18:03:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA03539 for linux-list; Fri, 10 Oct 1997 18:01:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA03490 for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 18:01:10 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA02071
	for <linux@cthulhu.engr.sgi.com>; Fri, 10 Oct 1997 18:01:07 -0700
	env-from (ralf@mail2.cobaltmicro.com)
Received: from dull.cobaltmicro.com (dull.cobaltmicro.com [209.19.61.35])
	by dns.cobaltmicro.com (8.8.5/8.8.5) with ESMTP id SAA00551;
	Fri, 10 Oct 1997 18:02:11 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Received: (from ralf@localhost)
	by dull.cobaltmicro.com (8.8.5/8.8.5) id RAA14665;
	Fri, 10 Oct 1997 17:58:48 -0700
Message-Id: <199710110058.RAA14665@dull.cobaltmicro.com>
Subject: Re: make zImage, and initrd...
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Fri, 10 Oct 1997 17:58:48 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.971010192929.364D-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Oct 10, 97 07:41:19 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I'm working on adding the ramdisk and initrd features to the kernel.  It
> compiles, which is pretty good for my first kernel patch.
> 
> But, I have no way to actually test it.  The kernel needs to find the
> offset of the ramdisk in the first 11 bits of one of the boot headers, so
> the kernel needs to be less than 2047k.

Dunno what you're trying to do, but it sounds extremly weired ...

> This wouldn't normally be a problem, but doing a 'make zImage' tells me
> that:
> ./mkboot zImage.tmp zImage
> Input file isn't a little endian ELF file
> make[1]: *** [zImage] Error 1
> 
> What would be required to make mkboot handle zImage, or bzImage?

Don't do it.  mkboot is used for the boxes that use Milo for booting to
convert the ELF executable into an a.out file that Milo accepts.  Milo
again is necessary because the ARC firmware is so incredibly buggy and I
don't want to have more ARC stuff in the kernel than absolutly necessary.

What I suggest instead is to load the ramdisk file using the ARCS
Open, Read, Write, Close and Seek functions from any ARC supported media.
That includes tapes, CDROM, EFS, XFS and even tftp.  Take the information
what file to read from the ARC command line.

> In the meantime, I will try to strip down a kernel to below 2047k.  My
> current one is 2347.

Why limiting the kernel size?  640kb are enough for everybody?

> Any other ideas?

Yes, time to leave for Sushi with Miguel :-)

  Ralf
