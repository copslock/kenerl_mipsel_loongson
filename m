Received:  by oss.sgi.com id <S42327AbQFTNpz>;
	Tue, 20 Jun 2000 06:45:55 -0700
Received: from kenton.algor.co.uk ([193.117.190.25]:42432 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S42229AbQFTNpu>;
	Tue, 20 Jun 2000 06:45:50 -0700
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [193.117.190.19])
	by kenton.algor.co.uk (8.8.8/8.8.8) with ESMTP id OAA01492;
	Tue, 20 Jun 2000 14:45:46 +0100 (GMT/BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id OAA08976;
	Tue, 20 Jun 2000 14:45:46 +0100 (BST)
Date:   Tue, 20 Jun 2000 14:45:46 +0100 (BST)
Message-Id: <200006201345.OAA08976@mudchute.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Dominic Sweetman <dom@algor.co.uk>,
        Ralf Baechle <ralf@oss.sgi.com>,
        Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Icache coherency problems for R3400, DS5000/240
In-Reply-To: <Pine.GSO.3.96.1000620143959.25502C-100000@delta.ds2.pg.gda.pl>
References: <200006192346.AAA03494@mudchute.algor.co.uk>
	<Pine.GSO.3.96.1000620143959.25502C-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Maciej W. Rozycki (macro@ds2.pg.gda.pl) writes:

> > Yes, the original R3000 chip could be wired to produce the appearance
> > of multi-word lines in its I-cache, and some derivative CPUs were built
> > that way.  Four was popular - I don't think anyone did 8.
> 
>  DEC docs claim the cache subsystem of KN03 is configured with single-word
> lines for the icache, but upon an icache fill the MB ASIC fills four
> lines.

Ah, I'm suffering from muddy memory syndrome.  

You're quite correct: on the R3000 cache every word had a tag, but an
I-cache refill could be setup to fill several of them at once -
implicitly storing the same tag in each position.  I believe it was in
theory possible to gently remove the two lowest tag addresses, use a
smaller tag memory, and have a genuine four-data per tag I-cache.  It
would have behaved very strangely while swapped for
diagnostics/maintenance.

>  OK, by "flush" I always meant "invalidate" (see also ia32's invd and
> wbinvd instructions -- the first one causes an external flush
> cycle...

I should have realised that Linux ab-usages usually refer to x86
technology.  Thanks for that.
