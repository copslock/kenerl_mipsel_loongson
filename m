Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Dec 2002 01:00:52 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:5293 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S870765AbSLGAAk>; Sat, 7 Dec 2002 01:00:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB700Sg14065;
	Sat, 7 Dec 2002 01:00:28 +0100
Date: Sat, 7 Dec 2002 01:00:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021207010028.A13543@linux-mips.org>
References: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl> <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de> <20021206180241.A7492@linux-mips.org> <15856.59886.661994.493446@gladsmuir.algor.co.uk> <20021207001731.D12968@linux-mips.org> <20021206233337.GM23743@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021206233337.GM23743@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Sat, Dec 07, 2002 at 12:33:37AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 07, 2002 at 12:33:37AM +0100, Thiemo Seufer wrote:

> > I'd worry less if that was just 220kB of unused memory wasted.  But it's
> > actually inflated code, it's wasted i-cache and cycles.  220kB translates
> > to alost 7 times the size of today's typical 32kB i-cache.
> > 
> > Even if Thiemo was right this trick is probably the biggest micro-
> > optimization of the decade ...
> 
> Even if it was such a big win it would IMHO be better to use N64 and
> teach the assembler some optimization for such register loads.
> -Wa,--sign-extend-immediates shouldn't be that complicated to implement.

The entire situation will change anyway once gcc no longer emits macro
instructions such as la or dla.

  Ralf
