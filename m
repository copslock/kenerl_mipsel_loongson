Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BMvvRw025758
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 15:57:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BMvvPa025757
	for linux-mips-outgoing; Thu, 11 Jul 2002 15:57:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BMveRw025748;
	Thu, 11 Jul 2002 15:57:43 -0700
Received: from gladsmuir.algor.co.uk (root@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g6BN1vv09749;
	Fri, 12 Jul 2002 00:01:58 +0100 (BST)
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15662.3715.334923.669657@gladsmuir.algor.co.uk>
Date: Fri, 12 Jul 2002 00:02:27 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@oss.sgi.com>, "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   Carsten Langgaard <carstenl@mips.com>,
   Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <Pine.GSO.3.96.1020711185642.7876I-100000@delta.ds2.pg.gda.pl>
References: <20020711131247.A11700@dea.linux-mips.net>
	<Pine.GSO.3.96.1020711185642.7876I-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>  Well, docs state only the cache that acts as the D-cache gets isolated
> and the one that acts as the I-cache always functions normally (and the
> real D-cache has all the logic needed to pretend it's an I-cache
> successfully).  Thus running from an uncached space is not needed.  I
> haven't checked it explicitly, but the flushing functions would fail
> (hang) quite soon otherwise and they don't.

I wrote the IDT software manual (I later used bits of it as the basis
of parts of "See MIPS Run".) Of course, every word of it is true.  I
can't comment on IDT's hardware manuals, though in my experience they
were somewhat better than the average.

Algorithmics produced cached routines to manipulate R3000-style caches
and they work reliably; what's more, the hardware specs say they
should.

Yes, it seems a bit strange to run with 'isolated'; but 'isolated'
really only stops loads and stores from reading/writing at the bus
interface.  It's use in cache functions was an accident; the original
R2000 caches did not support partial-word writes and could be
invalidated just by writing a byte to them.  When this was discovered
to be unacceptable, the 'isolated' bit (intended for diagnostics) was
pressed into service.

It is extraordinarily inefficient to run invalidate or writeback
routines uncached.  It will add perhaps 4-10 instruction fetches
(external memory reads) for each cache line invalidated; that's
probably double the memory overhead of the DMA operation which
necessitated the invalidation. That's something production-quality
code shouldn't do.

PS: my standard appeal.  When you say you 'flush' a cache do you mean
invalidate, write-back, or both?  If (as I suspect) not all of you
mean the same thing, should you not instead speak of 'invalidate' and
'writeback'... sloppy language surely leads to sloppy programming?

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
