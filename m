Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:18:09 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:3344 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226148AbULBAR6>; Thu, 2 Dec 2004 00:17:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 341A8E1C94; Thu,  2 Dec 2004 01:17:51 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18455-04; Thu,  2 Dec 2004 01:17:51 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D3067E1C61; Thu,  2 Dec 2004 01:17:50 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB20I98N013865;
	Thu, 2 Dec 2004 01:18:09 +0100
Date: Thu, 2 Dec 2004 00:17:56 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.58L.0412020001340.20966@blysk.ds.pg.gda.pl>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
 <16813.39660.948092.328493@doms-laptop.algor.co.uk>
 <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl>
 <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Dec 2004, Thiemo Seufer wrote:

> >  What do you mean by "the weird code model" and what failures have you 
> > observed?  I think the bits are worth being done correctly, so I'd like 
> > to know what problems to address.
> 
> I had guessed you already know what i mean. :-)
> 
> Current 64bit MIPS kernels run in (C)KSEG0, and exploit sign-extension
> to optimize symbol loads (2 instead of 6/7 instructions, the same as in
> 32bit kernels). This optimization relies on an assembler macro
> expansion mode which was hacked in gas for exactly this purpose. Gcc
> currently doesn't have something similiar, and would try to do a regular
> 64bit load with explicit relocs.

 Ah *that*.  Well, sorry -- I tend to forget about the hack as I've never
used it.  I think a valid solution is either to use CONFIG_BUILD_ELF64
(now that it is there) or to modify tools to implement it correctly...

> I discussed this with Richard Sandiford a while ago, and the conclusion
> was to implement an explicit --msym32 option for both gcc and gas to
> improve register scheduling and get rid of the gas hack. So far, nobody
> came around to actually do the work for it.

 ... like this, for example.  But if nobody has implemented it yet, then 
perhaps nobody is really interested in it? ;-)

> For the "subtle failures" part, we had some gas failures to handle dla
> because of the changed arguments. For userland (PIC) code, I've also

 I recall this -- I've thought the more or less agreed consensus was to
forbid or at least strongly discourage "dla" and "la" macros expanded
within inline asms and referring to an address operand to be provided by
GCC based on a constraint.

 Otherwise there is still my patch to gas available as an alternative. ;-)

> seen additional load/store insn creeping in ll/sc loops. I believe
> there's a large amount of inline assembly code (not necessarily in the
> kernel) which relies on similiar assumptions.

 With explicit relocs you have no problem with any instructions appearing 
inside inline asms unexpectedly.  That is if you use the "R" constraint -- 
the "m" one never guaranteed that.

  Maciej
