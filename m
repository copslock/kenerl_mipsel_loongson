Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 01:02:35 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:59740
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8226196AbULBBCa>; Thu, 2 Dec 2004 01:02:30 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZfMc-0008U8-00; Thu, 02 Dec 2004 02:02:30 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZfMb-0006EA-00; Thu, 02 Dec 2004 02:02:29 +0100
Date: Thu, 2 Dec 2004 02:02:29 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041202010229.GP3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl> <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0412020001340.20966@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0412020001340.20966@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> > I discussed this with Richard Sandiford a while ago, and the conclusion
> > was to implement an explicit --msym32 option for both gcc and gas to
> > improve register scheduling and get rid of the gas hack. So far, nobody
> > came around to actually do the work for it.
> 
>  ... like this, for example.  But if nobody has implemented it yet, then 
> perhaps nobody is really interested in it? ;-)

The old solution works, and kernel developers tend to use old toolchains.

> > seen additional load/store insn creeping in ll/sc loops. I believe
> > there's a large amount of inline assembly code (not necessarily in the
> > kernel) which relies on similiar assumptions.
> 
>  With explicit relocs you have no problem with any instructions appearing 
> inside inline asms unexpectedly.  That is if you use the "R" constraint -- 
> the "m" one never guaranteed that.

But it happened to work, and is in widespread use.


Thiemo
