Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 21:50:05 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:14536 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIETuF>; Thu, 5 Sep 2002 21:50:05 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA12658;
	Thu, 5 Sep 2002 21:50:05 +0200 (MET DST)
Date: Thu, 5 Sep 2002 21:50:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905174427.GU4194@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1020905213559.7444Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Thiemo Seufer wrote:

> > at the source level, you have autoconf or <stdint.h> as you can't
> > arbitrarily assume any type sizes for any portable code. 
> 
> Not everyone uses autoconf, and if you call "long long" a recent
> addition then the use of <stdint.h> isn't safe, too.

 That is not an excuse, sorry.  You need not to use autoconf or <stdint.h>
if you don't want to -- you may use a different tool or simply group all
tweakable settings in config.h and ask a user to edit it manually like
autors of old programs did.

> Using the same data types allows at least to choose the appropriate
> typedefs without caring about the underlying OS.

 It doesn't.  It is unsafe to assume it in general and it's even more
unsafe for MIPS where we have at least three C models and you do not know
in advance which one will a person doing a build choose. 

> >  What programmer's POV?  Does a programmer write a program for MIPS?  No,
> > unless he writes a kernel or a libc.  A normal programmer just codes a
> > program in C for a *nix-type system and if he wants any portability, he
> > needs to follow universal guidelines.
> 
> World isn't as perfect as you claim. And for non-broken code it's
> nearly irrelevant if the 64 bit integer type is called "long" or
> "long long".

 World isn't perfect, but it would be beneficial if at least we tried to
keep it as good as we can.

> About 128 bit integers: Most OS'es use "long long" already for
> 64 bit integers, which means there will be something like
> "quad long" for 128 bit integers (if these are needed).

 We'll see, but I wouldn't bet on it.  Personally, I'd rather see "long
long" to be a double-precision (not necessarily 128-bit) type universally. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
