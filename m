Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:31:13 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:31516 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1122958AbSIEQbM>; Thu, 5 Sep 2002 18:31:12 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17mzS2-002RxB-00; Thu, 05 Sep 2002 18:25:50 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17mzWt-0006Gv-00; Thu, 05 Sep 2002 18:30:51 +0200
Date: Thu, 5 Sep 2002 18:30:51 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905163051.GT4194@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020905142249.GA15843@nevyn.them.org> <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
>  I see.  But do we need the SGI's traditional n32 in Linux then?  Having
> most experiences in the server world I'd vote for a pure 64-bit setup
> (with an optional ability to execute o32 stuff), but I understand there
> are people who consider it a waste of resources.
> 
>  Therefore, I believe we may choose another way and use an IP32 (if I
> encode it right) data model, where we have 32-bit ints and pointers for
> these who are short on memory, 64-bit longs for the maximum native
> precision (you don't choose long for the type for your favourite "i" loop
> counter unless you really need it)

Following this line of argumentation, there isn't much software which
could benefit from 64 bit longs. :-) And 64 bit long long is available
for such software anyway.

> and an ability to have double-precision
> 128-bit long longs in the distant future (if needed). 

So the linux n64 would be incompatible to SGI's, too? (It would be
weird if the n64 long long was smaller than the n32 one).

>  Any opinions?

It would mean to create two new ABIs, gaining little benefit but
being incompatible from a (C-)programmers POV. And we already have
too many MIPS ABIs.


Thiemo
