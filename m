Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 17:41:12 +0100 (CET)
Received: from p508B66C1.dip.t-dialin.net ([80.139.102.193]:15033 "EHLO
	p508B66C1.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKEQlM>; Tue, 5 Nov 2002 17:41:12 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S867025AbSKEQlC>; Tue, 5 Nov 2002 17:41:02 +0100
Date: Tue, 5 Nov 2002 17:41:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: Prefetches in memcpy
Message-ID: <20021105174102.A14909@bacchus.dhis.org>
References: <3DC7CB8B.E2C1D4E5@mips.com> <20021105163806.A24996@bacchus.dhis.org> <00fb01c284e6$5b7bf4f0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00fb01c284e6$5b7bf4f0$10eca8c0@grendel>; from kevink@mips.com on Tue, Nov 05, 2002 at 05:13:48PM +0100
X-Accept-Language: de,en,fr
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Uh...  Maybe missread your mail the first time.  We're also prefechting
the destination area, of course with a different hint.  The question is
what the hints for destination are actually doing, the specs are fairly
vague on that and seem to leave the decission to the implementor.  Do
we really want to try ...

  Ralf
