Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 13:47:21 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:8899 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224915AbUAUNrU>; Wed, 21 Jan 2004 13:47:20 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 005D24C3D6; Wed, 21 Jan 2004 14:47:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id E300F47A62; Wed, 21 Jan 2004 14:47:17 +0100 (CET)
Date: Wed, 21 Jan 2004 14:47:17 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Pavel Kiryukhin <savl@dev.rtsoft.ru>, linux-mips@linux-mips.org
Subject: Re: __MIPSEL__ in sys32_rt_sigtimedwait
In-Reply-To: <20040120193918.GA2108@nevyn.them.org>
Message-ID: <Pine.LNX.4.55.0401211414040.11137@jurand.ds.pg.gda.pl>
References: <400D6877.1000105@dev.rtsoft.ru> <20040120183157.GB5495@linux-mips.org>
 <20040120193918.GA2108@nevyn.them.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 20 Jan 2004, Daniel Jacobowitz wrote:

> No, I'm pretty sure Pavel's right.
> 
> -#ifdef __MIPSEB__
>     case 1: these.sig[0] = these32.sig[0] | (((long)these32.sig[1]) << 32);
> -#endif
> -#ifdef __MIPSEL__
> -    case 1: these.sig[0] = these32.sig[1] | (((long)these32.sig[0]) << 32);
> -#endif
> 
> Consider a 64-bit sigset.  32-bit userland, 64-bit kernel.  Here's a
> userland sigset with signal 33 set, only, on a little endian target.
> Word 1, least significant bit, right?

 Right, but...

> byte address in memory
> 	1	2	3	4	5	6	7	8
> val	0	0	0	0	0	0	0	1

... this is incorrect -- it would be right for big-endian; word #1, bit #1
for little-endian is:

byte address in memory
	1	2	3	4	5	6	7	8
val	0	0	0	0	1	0	0	0


> Obviously, as a 64-bit integer the sigset looks different.  There it's
> supposed to be 1 << (33 - 1).
> val	0	0	0	1	0	0	0	0

 Again, for little-endian it should actually be:

val	0	0	0	0	1	0	0	0

i.e. the whole operation is actually a no-op, except that the 64-bit
vector is assured to be properly aligned for doubleword accesses.

 As a side note -- that's the reason certain C code portability problems
related to the width of the machine word only get actually discovered when
problematic software is run on a big-endian processor.  I've been hit by
this property once -- I was porting a 16-bit program and it appeared to
run just fine on both a 32-bit (i386) and a 64-bit (Alpha) little-endian
CPU, but when run on a 32-bit big-endian one (SPARC) I discovered a few
more bits to be cleaned up.

> So the correct algorithm to convert a userspace sigset to a kernel
> sigset is to shift the second word left 32 bits, and leave the first
> word right aligned, and or them together.  Which is what using the
> __MIPSEB__ case does.

 But this conclusion is of course right.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
