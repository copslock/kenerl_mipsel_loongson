Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Dec 2002 00:35:21 +0100 (MET)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:2578
	"EHLO iris1.csv.ica.uni-stuttgart.de") by ralf.linux-mips.org
	with ESMTP id <S870759AbSLFXfH>; Sat, 7 Dec 2002 00:35:07 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18KRyU-0007Ex-00; Sat, 07 Dec 2002 00:33:38 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18KRyT-00065b-00; Sat, 07 Dec 2002 00:33:37 +0100
Date: Sat, 7 Dec 2002 00:33:37 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206233337.GM23743@rembrandt.csv.ica.uni-stuttgart.de>
References: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl> <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de> <20021206180241.A7492@linux-mips.org> <15856.59886.661994.493446@gladsmuir.algor.co.uk> <20021207001731.D12968@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207001731.D12968@linux-mips.org>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Dec 06, 2002 at 06:18:22PM +0000, Dominic Sweetman wrote:
> 
> > > The first kernel was built as 64-bit ELF using 64-bit pointer and everything
> > > 64-bit.  The second kernel was built using the -Wa,-32 trick.  That's over
> > > 12% of bloat for full 64-bitiness which brings zero gain.
> > 
> > Percentages are dangerous things.  This is 220Kbytes of memory, which
> > currently represents an investment of about $0.05.  There may be
> > embedded linux applications which care about 5c cost, but they
> > probably won't use any variety of 64 bits...
> 
> I'd worry less if that was just 220kB of unused memory wasted.  But it's
> actually inflated code, it's wasted i-cache and cycles.  220kB translates
> to alost 7 times the size of today's typical 32kB i-cache.
> 
> Even if Thiemo was right this trick is probably the biggest micro-
> optimization of the decade ...

Even if it was such a big win it would IMHO be better to use N64 and
teach the assembler some optimization for such register loads.
-Wa,--sign-extend-immediates shouldn't be that complicated to implement.


Thiemo
