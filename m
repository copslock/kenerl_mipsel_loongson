Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 16:48:22 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:64678 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225315AbUAMQsV>; Tue, 13 Jan 2004 16:48:21 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B05CB4C3BC; Tue, 13 Jan 2004 17:48:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9B8F947831; Tue, 13 Jan 2004 17:48:17 +0100 (CET)
Date: Tue, 13 Jan 2004 17:48:17 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: karthikeyan natarajan <karthik_96cse@yahoo.com>,
	linux-mips@linux-mips.org
Subject: Re: How to configure the cache size in r4000
In-Reply-To: <20040113163543.GA31459@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401131741390.3158@jurand.ds.pg.gda.pl>
References: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
 <Pine.LNX.4.55.0401121345490.21851@jurand.ds.pg.gda.pl>
 <20040113163543.GA31459@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 13 Jan 2004, Ralf Baechle wrote:

> >  You cannot modify the size of the primary caches -- the values are
> > hardwired to the amount of cache available in the processor (8kB+8kB for
> > the original R4000).  However, if you take appropriate precautions, you
> > can alter the line sizes of the caches by modifying appropriate bits of
> > cp0.config.
> 
> On some systems that's a dangerous and won't work due to some issue with
> the memory controller.  That's why Linux supports all possible combinations
> instead of reconfiguring caches.  Of course there's also the hope that
> developers of a system did configure the cache for the optimal performance.

 Plus there are processor errata related to certain values of line sizes.

> If reconfiguring is possible 32-byte D-cache and I-Cache lines are probably
> the optimum for non-tiny systems.  For the L2 cache I'd guess 64 or 128
> byte lines.

 Well, reconfiguring the line size of the L2 cache is system-specific and 
the size is most likely hardwired.

 BTW, the DECstation uses 16-byte lines for the D-cache and the I-Cache
and 32-byte lines for the S-cache.  With the S-cache size at 1MB and up to
480MB of RAM does it qualify as a tiny system? ;-)

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
