Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2003 14:46:59 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:39588 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225444AbTK0Tbb>; Thu, 27 Nov 2003 19:31:31 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D7B964AD81; Thu, 27 Nov 2003 20:31:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B445147B41; Thu, 27 Nov 2003 20:31:18 +0100 (CET)
Date: Thu, 27 Nov 2003 20:31:18 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
In-Reply-To: <20031127173714.GA26143@nevyn.them.org>
Message-ID: <Pine.LNX.4.55.0311272019070.9902@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
 <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl>
 <20031125232439.GE11047@linux-mips.org> <Pine.LNX.4.55.0311260103320.6716@jurand.ds.pg.gda.pl>
 <20031126170228.GA13116@nevyn.them.org> <Pine.LNX.4.55.0311271319470.22529@jurand.ds.pg.gda.pl>
 <20031127173714.GA26143@nevyn.them.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 27 Nov 2003, Daniel Jacobowitz wrote:

> >  After a brief look at the sources I suspect sysdeps/mips/elf/ldsodefs.h
> > overrides sysdeps/unix/sysv/linux/ldsodefs.h -- if that's the case, the
> > bug still exists in the trunk.  I'll work on a fix later, probably
> > tonight.
> 
> _dl_aux_init ought to be called from __libc_start_main in
> sysdeps/generic/libc-start.c.  In current sources I can't see any way
> for that to go wrong on MIPS (but my MIPS board is off right now so I
> haven't tried it)...

 I did a build of 2.2.5 and my suspicion got confirmed -- the exact 
command line to build libc-start.o is as follows:

mipsel-linux-gcc ../sysdeps/generic/libc-start.c -c -O2 -Wall -Winline
-Wstrict-prototypes -Wwrite-strings -pipe -fomit-frame-pointer -g0 -O99
-fomit-frame-pointer -D__USE_STRING_INLINES -I../include -I. -I..
-I../libio -I../sysdeps/mips/elf -I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../sysdeps/pthread
-I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix
-I../linuxthreads/sysdeps/mips -I../sysdeps/unix/sysv/linux/mips
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common
-I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv
-I../sysdeps/unix/mips -I../sysdeps/unix -I../sysdeps/posix
-I../sysdeps/mips/mipsel -I../sysdeps/mips/fpu -I../sysdeps/mips
-I../sysdeps/wordsize-32 -I../sysdeps/ieee754/flt-32
-I../sysdeps/ieee754/dbl-64 -I../sysdeps/ieee754 -I../sysdeps/generic/elf
-I../sysdeps/generic -nostdinc -isystem
/usr/lib/gcc-lib/mipsel-linux/2.95.4/include -isystem
/home/macro/src/redhat/BUILD/glibc-2.2.5/linux/include -D_LIBC_REENTRANT
-include ../include/libc-symbols.h -DPIC -DHAVE_INITFINI -o libc-start.o

i.e. it's sysdeps/mips/elf/ldsodefs.h that gets included as a result of
"#include <ldsodefs.h>", not sysdeps/unix/sysv/linux/ldsodefs.h.  Then
sysdeps/mips/elf/ldsodefs.h uses "#include <sysdeps/generic/ldsodefs.h>"  
in 2.2.5, and "#include_next <ldsodefs.h>" in the trunk, so I'll just 
rebuild 2.2.5 with this change and consider the trunk fixed.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
