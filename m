Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA240060 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 08:47:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA10907 for linux-list; Thu, 4 Dec 1997 08:42:13 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA10901 for <linux@engr.sgi.com>; Thu, 4 Dec 1997 08:42:11 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id IAA26085; Thu, 4 Dec 1997 08:42:11 -0800
Date: Thu, 4 Dec 1997 08:42:11 -0800
Message-Id: <199712041642.IAA26085@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: A question about architecture and byte order with RPMs
In-Reply-To: <199712040810.AAA49407@oz.engr.sgi.com>
References: <Pine.LNX.3.95.971204003012.3395M-100000@lager.engsoc.carleton.ca>
	<199712040810.AAA49407@oz.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon writes:
...
 > The disadvantage is complexity and confusion...
 > Once SGI/Linux becomes stable, if gcc 2.8 is out and stable
 > we could try and migrate to supporting n32 (the dynamic linker
 > should support it, and a new set of dynamic libraraies should
 > be built for this)
 > 
 > So on SGI RPM should probably be named:
 > 	mips-<abi>.rpm
 > 
 > where <abi> is one of:
 > 	o32
 > 	n32
 > 	64
 > 
 > Currently SGI/Linux is purely o32 since that is the only ABI
 > gcc 2.7.x knows about.  The downside is that it is less efficient
 > than what it could have been (not utilizing the R4xxx and up
 > processors really well).
...

      There is a further complication.  MIPS R3000-based systems will
only run o32 in the MIPS I subset.  MIPS R6000-based systems will
run o32 in MIPS I or II.  On R4000 and newer systems (including
R4400, R4600, R4700, R5000, R8000, and R10000), o32 can be any of MIPS I,
II, or III, and can be MIPS IV on R5000, R8000, or R10000, although
MIPS III and IV are not officially supported by SGI systems for o32.
n32 and n64 can be either MIPS III or MIPS IV, with MIPS IV supported
only on R5000, R8000, and R10000.  n32 is not really better than o32
for integer programs; it is somewhat better for floating point programs
which need a lot of registers, since it enables the use of all 32 64-bit
floating point registers, instead of the MIPS I-compatible 16 registers.
n64 is the same as n32, except for having 64-bit addresses and long
integers.  Note that all models support "long long" 64-bit integers,
on all versions of the architecture, although they are emulated using
32-bit arithmetic when compiling for MIPS I and II.

     I would recommend that "mips.rpm" be the default o32 built for
MIPS I, perhaps with selected DSOs built both MIPS I and MIPS III or
IV (multiple versions), with the appropriate version linked to the
standard name at installation time, for those DSOs where the
architecture changes make a difference.  That is, one could have
libgl.so being a symbolic link to one of libgl-mips1.so,
libgl-mips3.so, or libgl-mips4.so, with the default (and initial
setting to guarantee booting on all systems) being to link to
libgl-mips1.so.  One might also add extra runtime libraries
(in an optional package) for n32, but the gains are very small
(and the code size larger) for most normal libraries and applications.

     n32 really makes a difference for SPECfp (FORTRAN) programs.  It
rarely makes much difference for integer programs.  On SGI systems,
cc -n32 now often produces better code than cc -o32, but that is because
they are really different compilers, and cc -o32 has had almost no work
done on it for about 5 years.  Both typically produce better code than
gcc, at least at high optimization levels, as measured by SPECint
performance.

     MIPS III does not help o32 programs for the most part, unless they
do a lot of 64-bit (long long) integer arithmetic.  MIPS IV adds some
useful floating point instructions and integer conditional moves.  The
floating point instructions include madd and the like, and those make
a large difference for graphics code and for DSP-like algorithms.
Neither make a major difference to the operating system or libc,
so most o32 libraries might as well be MIPS I, except perhaps for
a few routines such as bcopy, which can be much faster in MIPS III.
