Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 19:44:41 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:47388 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1122958AbSIERok>; Thu, 5 Sep 2002 19:44:40 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17n0bF-002Q4d-00; Thu, 05 Sep 2002 19:39:25 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17n0g7-0006LS-00; Thu, 05 Sep 2002 19:44:27 +0200
Date: Thu, 5 Sep 2002 19:44:27 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905174427.GU4194@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020905163051.GT4194@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1020905183617.7444J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905183617.7444J-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> > So the linux n64 would be incompatible to SGI's, too? (It would be
> > weird if the n64 long long was smaller than the n32 one).
> 
>  Why would anyone care?  Do you want to run IRIX binaries on Linux?  And
> at the source level, you have autoconf or <stdint.h> as you can't
> arbitrarily assume any type sizes for any portable code. 

Not everyone uses autoconf, and if you call "long long" a recent
addition then the use of <stdint.h> isn't safe, too.

Using the same data types allows at least to choose the appropriate
typedefs without caring about the underlying OS.

> > It would mean to create two new ABIs, gaining little benefit but
> > being incompatible from a (C-)programmers POV. And we already have
> > too many MIPS ABIs.
> 
>  What programmer's POV?  Does a programmer write a program for MIPS?  No,
> unless he writes a kernel or a libc.  A normal programmer just codes a
> program in C for a *nix-type system and if he wants any portability, he
> needs to follow universal guidelines.

World isn't as perfect as you claim. And for non-broken code it's
nearly irrelevant if the 64 bit integer type is called "long" or
"long long".

About 128 bit integers: Most OS'es use "long long" already for
64 bit integers, which means there will be something like
"quad long" for 128 bit integers (if these are needed).


Thiemo
