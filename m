Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA02762; Tue, 10 Jun 1997 10:49:12 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA01498 for linux-list; Tue, 10 Jun 1997 10:48:49 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA01487 for <linux@cthulhu.engr.sgi.com>; Tue, 10 Jun 1997 10:48:47 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA28915 for <linux@yon.engr.sgi.com>; Tue, 10 Jun 1997 10:48:46 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA27937; Tue, 10 Jun 1997 10:48:39 -0700
Date: Tue, 10 Jun 1997 10:48:39 -0700
Message-Id: <199706101748.KAA27937@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: mende@piecomputer.engr.sgi.com, ralf@Julia.DE, ariel@sgi.com,
        linux@yon.engr.sgi.com
Subject: Re: Merge back of the MIPS sources
In-Reply-To: <199706101059.MAA18571@informatik.uni-koblenz.de>
References: <199706091836.LAA02114@fir.engr.sgi.com>
	<199706101059.MAA18571@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > >       If the MIPS system is running big-endian (as under RISCos), it can
 > > be binary-compatible with Indy linux, just as RISCos 5.01 -systype svr4
 > > binaries are binary-compatible with Indy IRIX 5.1 and later systems.
 > > If the MIPS system is running little-endian (as under NT), it cannot
 > > be binary-compatible with Indy linux, without adding bi-endian support
 > > (for running opposite-endian binaries, which is feasible, but messy).
 > > We prototyped bi-endian support in RISCos when before the Magnum
 > > was built, and it worked, but the code was very ugly in the streams
 > > area.  linux would likely be easier, but still a hassle.
 > 
 > Now that the overhead of accessing the userspace from the kernel under
 > Linux is very close to zero I fear that the additional overhead of the
 > byteorder conversion will show up very clearly in benchmarks unless
 > someone comes up with very clever ideas how do this.  Do you have
 > numbers how much the impact on RISC/os performance was?

     I don't have the numbers ready to hand, but it was not huge for most
things, given the hack of running the disk wrong-endian.  CPU overhead
for non-disk DMA I/O was higher, of course, but there is no extra
overhead for operations where all the arguments are in registers.
(An integer in a register is the same, no matter which endian you are.)
getpid(), for example, is unaffected.  Similarly, read() and write()
to disk are unaffected.  On the other hand, stat() is a little slower.

     Note that endian data conversion is not blind byte swapping for
structures such a stat.  Instead, it is a field-by-field operation,
since the MIPS reverse-endian mode affects only addressing, not the
layout of the bytes of, say, an integer in memory.  A 32-bit integer
will be at a different offset from the base of the structure (4, say,
instead of 0), but the byte order in memory will be the same.  The
byte numbering of memory is different, which is how it appears that
the bytes have been swapped.  The structure conversion routines can
thus be compiled fairly efficiently, avoiding runtime structure offset
calculations for the most part (except for arrays embedded in
structures).

     If this starts to look worth doing, I can supply more imformation,
such as examples of how to efficiently convert structures.  
