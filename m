Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 17:29:45 +0100 (CET)
Received: from p508B66C1.dip.t-dialin.net ([80.139.102.193]:12473 "EHLO
	p508B66C1.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKEQ3p>; Tue, 5 Nov 2002 17:29:45 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S867025AbSKEQ3f>; Tue, 5 Nov 2002 17:29:35 +0100
Date: Tue, 5 Nov 2002 17:29:35 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: Prefetches in memcpy
Message-ID: <20021105172935.A14721@bacchus.dhis.org>
References: <3DC7CB8B.E2C1D4E5@mips.com> <20021105163806.A24996@bacchus.dhis.org> <00fb01c284e6$5b7bf4f0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00fb01c284e6$5b7bf4f0$10eca8c0@grendel>; from kevink@mips.com on Tue, Nov 05, 2002 at 05:13:48PM +0100
X-Accept-Language: de,en,fr
Return-Path: <ralf@uni-koblenz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@uni-koblenz.de
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 05:13:48PM +0100, Kevin D. Kissell wrote:

> >  - Avoid prefetching beyond the end of the copy area in memcpy and memmove.
> >  - Introduce a second variant of memcpy that never does prefetching.  This
> >    one will be safe to use in KSEG1 / uncached XKPHYS also and will be used
> >    for memcpy_fromio, memcpy_toio and friends.
> 
> Assuming we had a version that prefetched exactly to the end
> of the source memory block and no further, why would we need
> the second variant?

Because the source of memcpy_fromio and the destination of memcpy_toio are
some I/O address, typically something like a shared memory region on a
network card, which is accessed uncached.  The uncached address region
might be mapped in KSEG2/KSEG3 or accessed through an uncached region of
XKPHYS or KSEG1 where as I recall your statment the effect of prefetch
instructions is undefined.

  Ralf
