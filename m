Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 18:05:17 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:32427 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S869534AbSLFREw>; Fri, 6 Dec 2002 18:04:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB6H2f407596;
	Fri, 6 Dec 2002 18:02:41 +0100
Date: Fri, 6 Dec 2002 18:02:41 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206180241.A7492@linux-mips.org>
References: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl> <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Dec 06, 2002 at 05:45:58PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 06, 2002 at 05:45:58PM +0100, Thiemo Seufer wrote:

> > If we want to preserve the setup cleanly, we
> > probably need yet another ABI model in gcc (especially in the face of the
> > coming changes to get rid of assembly macros), with sign-extended 32-bit
> > pointers for accessing program segments and 64-bit ones for the remaining
> > addresses.
> 
> Do you think this is worth the hassle? N64 offers better flexibility in
> the large memory case at some performance cost, and it's conceptionally
> cleaner.

Absolutely:

[ralf@dea linux-sgi-2.4]$ mips64-linux-size vmlinux
   text    data     bss     dec     hex filename
1978296  317344  156224 2451864  256998 vmlinux
[ralf@dea linux-sgi-2.4]$ mips64-linux-size vmlinux
   text    data     bss     dec     hex filename
1761168  317344  156224 2234736  221970 vmlinux

The first kernel was built as 64-bit ELF using 64-bit pointer and everything
64-bit.  The second kernel was built using the -Wa,-32 trick.  That's over
12% of bloat for full 64-bitiness which brings zero gain.

  Ralf
