Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA56252 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 19:54:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA28792
	for linux-list;
	Thu, 15 Oct 1998 19:54:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA85670
	for <linux@engr.sgi.com>;
	Thu, 15 Oct 1998 19:54:21 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA01904
	for <linux@engr.sgi.com>; Thu, 15 Oct 1998 19:54:20 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id EAA24451
	for <linux@engr.sgi.com>; Fri, 16 Oct 1998 04:54:16 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id WAA03513;
	Thu, 15 Oct 1998 22:21:02 +0200
Message-ID: <19981015222100.E2079@uni-koblenz.de>
Date: Thu, 15 Oct 1998 22:21:00 +0200
From: ralf@uni-koblenz.de
To: Vladimir Roganov <roganov@niisi.msk.ru>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu
Subject: Re: get_mmu_context()
References: <19981013215927.A2692@uni-koblenz.de> <3625D799.7D923FA9@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <3625D799.7D923FA9@niisi.msk.ru>; from Vladimir Roganov on Thu, Oct 15, 1998 at 03:08:09PM +0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> It does not add performance I can see.

Your code is actually a bit shorter, so I'll mix something based on your
version and my code patching thing.  It must be good, Rik sent me fan
email ;-)

The performance hit will come into the game as soon as one tries to
build a generic kernel for both R3000 and R4000.  The R3000 PID and the
R4000 ASID mechanism are slightly different and the simple approach
to fix that is to use global variables.  Which affects both your version
and the current version.

Which I want to avoid because in worst case that means we'll have to eat
a latency of over 1400ns per cache line to fetch from memory.  This number
is measured on a R4000SC with 100Mhz.  That is enough to show up right
away on the context switch times which now look fairly nice as long as we
don't have to swallow cache faults.

(Let me dig out a cite from somebody ``Some systems seem to think a system
call without a cache miss is a day without sunshine.  :-)'')

Talking about cache faults & context switching times.  Especially on the
R4000 with it's 8kb direct mapped cache _every_ context switch will
result in cache misses which explain the fairly lousy context switch times
on R4000.  R4400 isn't much better.  For the case when we have the perfect
most cache friendly layout we can switch between two processes without
taking page faults.

Things got worse when we switched to 8kb, 8kb aligned, stacks as delivered
by __get_free_pages(1,...).  It's somewhat better on R4600 and R5000 which
have set associative caches but still they could need some optimization.
Also R3000 with it's typically 2 x 64kb per cache direct mapped caches will
looks relativly better in that aspect.

> So, I don't understand why idea of using all free upper bits as asid
> extension is bad  -- same time it increases security it allows to
> increment
> version automatically when asid overflow occurs.

No.  It gives us a view bits more, but way not enough.  The mmu context code
we have has been copied almost unmodified from the Alpha which from EV5 on
also supports ASNs.  The big difference between the Alpha and the MIPS
implementation is that on the Alpha the type ``unsigned long'' which is
used for counting ASN and ASN version number has 64 bit.  Assuming UP and
the worst case which is 2^7 ASNs they still have 2^57 versions before a
version overflow will happen.  In other words, assuming 1,000,000 context
switches per second they still have almost 600,000 years before an ASN
collission may occur.

The MIPS implementation does worse, especially for the R3000 where waste the
lowest 6 bits which effectivly truncates our ASID (or PID) to 26 bits.
Assuming just 100,000 context switches we'll wrap around after just a bit
more than 11 minutes.  I think we can do more than 100,000 context switches
per second on a reasonable R3000 system.

A possible actual solution could be to extend the ASID / PID counter to
64 bit.  This adds some overhead which I'd get rid of if possible at all.
Ideas for that wanted.

Btw, is any of the R3000 machines stable enough to run lmbench?  I'm
interested to get results, best the raw result file from
lmbench/results/mips-linux/.  Reminds me to run lmbench on my RS3230.

  Ralf
