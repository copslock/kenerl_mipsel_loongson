Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:53:52 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:10691 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEQxw>; Thu, 5 Sep 2002 18:53:52 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA10131;
	Thu, 5 Sep 2002 18:54:05 +0200 (MET DST)
Date: Thu, 5 Sep 2002 18:54:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905163051.GT4194@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1020905183617.7444J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Thiemo Seufer wrote:

> >  Therefore, I believe we may choose another way and use an IP32 (if I
> > encode it right) data model, where we have 32-bit ints and pointers for
> > these who are short on memory, 64-bit longs for the maximum native
> > precision (you don't choose long for the type for your favourite "i" loop
> > counter unless you really need it)
> 
> Following this line of argumentation, there isn't much software which
> could benefit from 64 bit longs. :-) And 64 bit long long is available
> for such software anyway.

 It's up to a programmer to judge what kind of processing he needs.  For
computing, 64-bit integer arithmetics is indeed useful from time to time
only and 32-bit one often suffices.

> So the linux n64 would be incompatible to SGI's, too? (It would be
> weird if the n64 long long was smaller than the n32 one).

 Why would anyone care?  Do you want to run IRIX binaries on Linux?  And
at the source level, you have autoconf or <stdint.h> as you can't
arbitrarily assume any type sizes for any portable code. 

> It would mean to create two new ABIs, gaining little benefit but
> being incompatible from a (C-)programmers POV. And we already have
> too many MIPS ABIs.

 What programmer's POV?  Does a programmer write a program for MIPS?  No,
unless he writes a kernel or a libc.  A normal programmer just codes a
program in C for a *nix-type system and if he wants any portability, he
needs to follow universal guidelines.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
