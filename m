Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 23:03:48 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:39770
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8226049AbULAXDg>; Wed, 1 Dec 2004 23:03:36 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZdVV-00078r-00; Thu, 02 Dec 2004 00:03:33 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZdVU-0005mf-00; Thu, 02 Dec 2004 00:03:32 +0100
Date: Thu, 2 Dec 2004 00:03:32 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 1 Dec 2004, Thiemo Seufer wrote:
> 
> > The compiler was improved with PIC code in mind. The kernel is
> > non-PIC, and can't allow explicit relocs by the compiler because
> > of the weird code model used for 64bit kernels. This led to some
> > degradation and even subtle failures for inline assembly code which
> > relies on assumptions about earlier compiler's behaviour.
> 
>  What do you mean by "the weird code model" and what failures have you 
> observed?  I think the bits are worth being done correctly, so I'd like 
> to know what problems to address.

I had guessed you already know what i mean. :-)

Current 64bit MIPS kernels run in (C)KSEG0, and exploit sign-extension
to optimize symbol loads (2 instead of 6/7 instructions, the same as in
32bit kernels). This optimization relies on an assembler macro
expansion mode which was hacked in gas for exactly this purpose. Gcc
currently doesn't have something similiar, and would try to do a regular
64bit load with explicit relocs.

I discussed this with Richard Sandiford a while ago, and the conclusion
was to implement an explicit --msym32 option for both gcc and gas to
improve register scheduling and get rid of the gas hack. So far, nobody
came around to actually do the work for it.

For the "subtle failures" part, we had some gas failures to handle dla
because of the changed arguments. For userland (PIC) code, I've also
seen additional load/store insn creeping in ll/sc loops. I believe
there's a large amount of inline assembly code (not necessarily in the
kernel) which relies on similiar assumptions.


Thiemo
