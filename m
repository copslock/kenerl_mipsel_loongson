Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4QMZKh15543
	for linux-mips-outgoing; Sat, 26 May 2001 15:35:20 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4QMZId15540
	for <linux-mips@oss.sgi.com>; Sat, 26 May 2001 15:35:18 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4QMNeD01589;
	Sat, 26 May 2001 19:23:40 -0300
Date: Sat, 26 May 2001 19:23:40 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010526192340.B1415@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010525130531.17652A-100000@delta.ds2.pg.gda.pl> <011801c0e55f$e4d39820$0deca8c0@Ulysses> <20010525144937.A28370@nevyn.them.org> <00c901c0e631$4bcebd80$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00c901c0e631$4bcebd80$0deca8c0@Ulysses>; from kevink@mips.com on Sun, May 27, 2001 at 12:14:43AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, May 27, 2001 at 12:14:43AM +0200, Kevin D. Kissell wrote:

> Fair enough.  It was an offhand remark.  But seriously, what does
> the "R" constraint mean here?  The only documentation I've got
> (http://linux.fh-heilbronn.de/doku/GNU/docs/gcc/gcc_163.html#SEC163)
> says that "Q" through "U" are reserved for use with EXTRA_CONSTRAINT
> in machine-dependent definitions of arbitrary operand types.  When
> and where does it get bound for MIPS gcc, and what is it supposed
> to mean?  If I compile this kind of fragment using a "m" constraint,
> it seems to do the right thing, at least on my archaic native compiler.

Correct, "R" is a machine dependent constraint.  At least when it's working
right it's supposed to expand into offset(reg) where offset is limited
to 16 bits.  That's implemented in gcc/config/gcc/mips/mips.h's
EXTRA_CONSTRAINT macro.  In case of an "R" constraint gcc calls the
simple_memory_operand() function which will return 1 if the memory operand
fits into a single instruction.

  Ralf
