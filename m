Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2002 00:12:41 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:24093 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1122958AbSIEWMk>; Fri, 6 Sep 2002 00:12:40 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17n4mV-002Si8-00; Fri, 06 Sep 2002 00:07:19 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17n4rN-0002nd-00; Fri, 06 Sep 2002 00:12:21 +0200
Date: Fri, 6 Sep 2002 00:12:21 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905221221.GX4194@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020905174427.GU4194@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1020905213559.7444Q-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905213559.7444Q-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> > Using the same data types allows at least to choose the appropriate
> > typedefs without caring about the underlying OS.
> 
>  It doesn't.  It is unsafe to assume it in general and it's even more
> unsafe for MIPS where we have at least three C models and you do not know
> in advance which one will a person doing a build choose. 

It's knowing the ABI vs. ABI + OS (or OS-specific ABI-variant, if you
want to call it different).

> > >  What programmer's POV?  Does a programmer write a program for MIPS?  No,
> > > unless he writes a kernel or a libc.  A normal programmer just codes a
> > > program in C for a *nix-type system and if he wants any portability, he
> > > needs to follow universal guidelines.
> > 
> > World isn't as perfect as you claim. And for non-broken code it's
> > nearly irrelevant if the 64 bit integer type is called "long" or
> > "long long".
> 
>  World isn't perfect, but it would be beneficial if at least we tried to
> keep it as good as we can.

I agree. And I believe in the "least surprise" principle, which means
we shouldn't deviate from widely known conventions without good reason.
I still don't see the advantage of a 64 bit long in n32.


Thiemo
