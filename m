Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 17:26:35 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:52149 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225197AbTDCQ0e>; Thu, 3 Apr 2003 17:26:34 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24442;
	Thu, 3 Apr 2003 18:27:03 +0200 (MET DST)
Date: Thu, 3 Apr 2003 18:27:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030403174219.A4276@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030403181029.19058I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 3 Apr 2003, Ralf Baechle wrote:

> >  Hmm, why -- is such a change observable externally in any way?  Of
> > course you can't switch the other way if the s-cache uses a line width of
> > 16 bytes.  Maybe that's the case with the Magnum?
> 
> It's a hardware problem with the memory controller I was told by one of
> it's developpers.  That forced them to run the machine with an different
> line size for D-cache and I-Cache.  There's various revs of the Magnum's
> memory controller and only one of them got all the cases right ...

 Hmm, that's even more interesting -- how can instruction fetches be
distinguished from data reads externally???  Then again, the memory
controller shouldn't be able to observe inter-cache data moves.  Strange.

> Maybe DECstation and other SGI hardware got that better?

 No problem testing, I suppose.

> >  Why?  It isn't that obvious especially as a p-cache miss costs a single
> > cycle only.
> 
> During my recent work on the cache code I found the execution time of
> cache flushing code to be quite a bit higher than previously assumed so
> larger lines would help reducing that also.

 This can be benchmarked -- there may be some gain for p-cache flushes
indeed. 

> > > working truly correct we also should no longer see VCE exceptions on
> > > R4000SC processors - the reason why Indys are still a valuable test tool.
> > 
> >  As are DECstations which use the opposite endianness -- so you can test
> > code both ways.
> 
> A bunch of evaluation boards that support running in the other endianess
> and way exceed the performance of any R4000-based platform.  Just having
> to flip a switch on the board is very handy.

 I was referring to testing cache and VCE code specifically -- you won't
get that from usual evaluation boards.

 Note that with evil /dev/mem maps you should still be able to force VCEs
if needed. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
