Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA15543; Tue, 10 Jun 1997 14:55:09 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA17988 for linux-list; Tue, 10 Jun 1997 14:54:58 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA17984 for <linux@cthulhu.engr.sgi.com>; Tue, 10 Jun 1997 14:54:56 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA29561 for <linux@yon.engr.sgi.com>; Tue, 10 Jun 1997 14:54:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA17907; Tue, 10 Jun 1997 14:54:33 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA11592; Tue, 10 Jun 1997 14:54:13 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from grass (ralf@grass.uni-koblenz.de [141.26.4.65]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id WAA20079; Tue, 10 Jun 1997 22:22:59 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706102022.WAA20079@informatik.uni-koblenz.de>
Received: by grass (SMI-8.6/KO-2.0)
	id WAA04434; Tue, 10 Jun 1997 22:22:56 +0200
Subject: Re: Merge back of the MIPS sources
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Tue, 10 Jun 1997 22:22:55 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, mende@piecomputer.engr.sgi.com,
        ralf@Julia.DE, ariel@sgi.com, linux@yon.engr.sgi.com
In-Reply-To: <199706101748.KAA27937@fir.engr.sgi.com> from "William J. Earl" at Jun 10, 97 10:48:39 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      I don't have the numbers ready to hand, but it was not huge for most
> things, given the hack of running the disk wrong-endian.  CPU overhead
> for non-disk DMA I/O was higher, of course, but there is no extra
> overhead for operations where all the arguments are in registers.
> (An integer in a register is the same, no matter which endian you are.)
> getpid(), for example, is unaffected.  Similarly, read() and write()
> to disk are unaffected.  On the other hand, stat() is a little slower.
> 
>      Note that endian data conversion is not blind byte swapping for
> structures such a stat.  Instead, it is a field-by-field operation,
> since the MIPS reverse-endian mode affects only addressing, not the
> layout of the bytes of, say, an integer in memory.  A 32-bit integer
> will be at a different offset from the base of the structure (4, say,
> instead of 0), but the byte order in memory will be the same.  The
> byte numbering of memory is different, which is how it appears that
> the bytes have been swapped.  The structure conversion routines can
> thus be compiled fairly efficiently, avoiding runtime structure offset
> calculations for the most part (except for arrays embedded in
> structures).
> 
>      If this starts to look worth doing, I can supply more imformation,
> such as examples of how to efficiently convert structures.  

This definately is worth doing.  We have a couple of machines where we
can not configure byteorder of the kernel to big endian like DECstations
or the Acer PICA, essentially a downscaled Magnum with an Indy style L2
cache intended for NT.  If we ever want to give them a chance to run
commercial software, then we need to go biendian.  And we need to implement
it very clean or Linus will never accept the patches.
Luckily the functions get_user() and put_user in <asm/uaccess.h> do
already a large part of the work for us but nevertheless we need to
go through all the code once again.  So maybe this is not something
for now but definately worth doing.

  Ralf
