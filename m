Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Dec 2002 00:19:30 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:38828 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S870759AbSLFXTV>; Sat, 7 Dec 2002 00:19:21 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB6NHVD13388;
	Sat, 7 Dec 2002 00:17:31 +0100
Date: Sat, 7 Dec 2002 00:17:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021207001731.D12968@linux-mips.org>
References: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl> <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de> <20021206180241.A7492@linux-mips.org> <15856.59886.661994.493446@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15856.59886.661994.493446@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Fri, Dec 06, 2002 at 06:18:22PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 06, 2002 at 06:18:22PM +0000, Dominic Sweetman wrote:

> > The first kernel was built as 64-bit ELF using 64-bit pointer and everything
> > 64-bit.  The second kernel was built using the -Wa,-32 trick.  That's over
> > 12% of bloat for full 64-bitiness which brings zero gain.
> 
> Percentages are dangerous things.  This is 220Kbytes of memory, which
> currently represents an investment of about $0.05.  There may be
> embedded linux applications which care about 5c cost, but they
> probably won't use any variety of 64 bits...

I'd worry less if that was just 220kB of unused memory wasted.  But it's
actually inflated code, it's wasted i-cache and cycles.  220kB translates
to alost 7 times the size of today's typical 32kB i-cache.

Even if Thiemo was right this trick is probably the biggest micro-
optimization of the decade ...

  Ralf
