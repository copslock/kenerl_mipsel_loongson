Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 19:20:35 +0100 (MET)
Received: from alg133.algor.co.uk ([IPv6:::ffff:62.254.210.133]:14048 "EHLO
	oalggw.algor.co.uk") by ralf.linux-mips.org with ESMTP
	id <S869812AbSLFSUZ>; Fri, 6 Dec 2002 19:20:25 +0100
Received: from gladsmuir.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gB6IIMW23429;
	Fri, 6 Dec 2002 18:18:27 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15856.59886.661994.493446@gladsmuir.algor.co.uk>
Date: Fri, 6 Dec 2002 18:18:22 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
In-Reply-To: <20021206180241.A7492@linux-mips.org>
References: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de>
	<Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl>
	<20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de>
	<20021206180241.A7492@linux-mips.org>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> Absolutely:
> 
> [ralf@dea linux-sgi-2.4]$ mips64-linux-size vmlinux
>    text    data     bss     dec     hex filename
> 1978296  317344  156224 2451864  256998 vmlinux
> [ralf@dea linux-sgi-2.4]$ mips64-linux-size vmlinux
>    text    data     bss     dec     hex filename
> 1761168  317344  156224 2234736  221970 vmlinux
> 
> The first kernel was built as 64-bit ELF using 64-bit pointer and everything
> 64-bit.  The second kernel was built using the -Wa,-32 trick.  That's over
> 12% of bloat for full 64-bitiness which brings zero gain.

Percentages are dangerous things.  This is 220Kbytes of memory, which
currently represents an investment of about $0.05.  There may be
embedded linux applications which care about 5c cost, but they
probably won't use any variety of 64 bits...
