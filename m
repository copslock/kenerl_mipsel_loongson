Received:  by oss.sgi.com id <S42287AbQFTMxZ>;
	Tue, 20 Jun 2000 05:53:25 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:60887 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42229AbQFTMxO>;
	Tue, 20 Jun 2000 05:53:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA26033;
	Tue, 20 Jun 2000 14:50:06 +0200 (MET DST)
Date:   Tue, 20 Jun 2000 14:50:05 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Dominic Sweetman <dom@algor.co.uk>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Icache coherency problems for R3400, DS5000/240
In-Reply-To: <200006192346.AAA03494@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1000620143959.25502C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 20 Jun 2000, Dominic Sweetman wrote:

> Yes, the original R3000 chip could be wired to produce the appearance
> of multi-word lines in its I-cache, and some derivative CPUs were built
> that way.  Four was popular - I don't think anyone did 8.

 DEC docs claim the cache subsystem of KN03 is configured with single-word
lines for the icache, but upon an icache fill the MB ASIC fills four
lines.

> And while I'm here, I'll continue my lonely campaign.  I suggest you
> don't say "flush" because nobody knows whether it means invalidate,
> write-back, or both[1].  Instead, say "invalidate", "writeback", or
> "both".  Even if it means changing St Linus' function names...

 OK, by "flush" I always meant "invalidate" (see also ia32's invd and
wbinvd instructions -- the first one causes an external flush cycle and
the other one an external writeback cycle and then a flush cycle -- that's
Intel's original naming).  On the other hand, "invalidate" is surely not
more ambiguous than "flush", so feel free to continue your campaign... 
;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
