Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MDNNd30584
	for linux-mips-outgoing; Thu, 22 Mar 2001 05:23:23 -0800
Received: from chmls20.mediaone.net (chmls20.mediaone.net [24.147.1.156])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MDNJM30581
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 05:23:19 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls20.mediaone.net (8.11.1/8.11.1) with SMTP id f2MDNAk23663;
	Thu, 22 Mar 2001 08:23:14 -0500 (EST)
From: "Jay Carlson" <nop@nop.com>
To: <linux-mips@oss.sgi.com>, <linuxce-devel@linuxce.org>
Subject: snow, a statically linked shared library MIPS ABI
Date: Thu, 22 Mar 2001 08:23:13 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNAEHDCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

OK, I've been sitting on this for a while and I haven't been pushing hard on
a release lately, so I think it's time for me to point you folks at the
back-to-the-stone-age library system I've been working on.

Warning: if you don't build distros from scratch, you won't find this
interesting.  If your devices-of-interest have big cache with wide, fast
memory, you won't see

>From the README:

----
This is snow, a collection of hacks to build absolute-linked shared
libraries for mipsel-linux systems.  It's inspired (if that's the
word) by the way Linux built shared libraries back in the libc2-4 era.

Motivation

For various reasons, position-independent code produced by the GNU
toolchain for MIPS targets is not very dense.  On desktop systems,
this is acceptable; on embedded systems, notably handheld Linux
devices, it's a real problem.  Unfortunately, PIC is an all-or-nothing
proposition, given the current MIPS toolchain: all parts of a program,
including the main executable, must be built as PIC for intercall to
work.  Therefore, in order to use non-PIC code anywhere, we need to
rebuild shared libraries, startup code, and main programs.

Without position-independent code, the ELF shared library strategy
doesn't work.

Plan

Instead, we can build shared library images located at fixed locations
in memory, with the location configured at library creation time.
Stub libraries are generated that hold the absolute addresses of
functions and data within the library image; programs (and other
libraries) link with the stubs.

[...]
----

Typical code density improvement is in the 20-40% range; file sizes are
reduced slightly more.  For example, bash 1.x went from 800k to 400k.
Although I haven't benchmarked it, executable startup seems dramatically
faster on the embedded devices I play with.

There can be significant execution speed boosts too.  It's been a while
since I did time trials, but I think I remember that dhrystone and squeak
are like 50-90% faster.   These numbers are from the TX3912 and Vr4181; on a
cobalt, dhrystone was only like 15% faster.  And the nature of the code is
important: the native Byte benchmark showed only minimal improvements.

Source at ftp://ftp.place.org/pub/nop/linuxce/snow-1.0.1.tar.gz ; a
toolchain builder is at
ftp://ftp.place.org/pub/nop/linuxce/pyramid-builder-1.0.3.tar.gz .

Shane Nay at Agenda Computing ( www.agendacomputing.com ) has done some
extensive work on distro building based on snow.
ftp://ftp.agendacomputing.com/pub/dev/ contains snapshots of the work he's
been doing; it includes source for much of the Agenda VR3 distribution
adapted to snow.  Agenda released a test rom image that demonstrates that
libc, X, fltk, bash, etc are functional (and fast!); for non-Agenda users,
this is interesting because it proves snow is a viable distro base.

The biggest item on the snow to-do list is the implementation of jump tables
and fixed data positioning to allow forward binary compatibility of library
versions.  (As with the old a.out libraries, this compatibility will require
work on the part of the library builder.)  Jump tables themselves are easy
to build; fixed data positioning seems easiest to implement
with -fdata-sections from gcc 2.9x.

Choice of library address ranges is an open problem.  If all code lives
below the 256M mark (as it does now) calls use direct addressing with jal
and j.  But that 256M gets sucked up real fast if it can only be allocated
aligned on 256k boundaries (because of the ABI mmap requirements, right?)
and we try to enforce global uniqueness of library space allocation.
Allowing library code anywhere in the address space requires either
per-callpoint 4-instruction "la $at,printf; jalr $at" or yet another layer
of stubs linked into each client space.

I'm looking for use/testing/contributions from embedded Linux people.  If
you'd like to take the code off my hands, that'd be cool too.

Jay
