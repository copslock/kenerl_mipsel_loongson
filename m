Received:  by oss.sgi.com id <S42300AbQFSXr0>;
	Mon, 19 Jun 2000 16:47:26 -0700
Received: from kenton.algor.co.uk ([193.117.190.25]:36289 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S42239AbQFSXrR>;
	Mon, 19 Jun 2000 16:47:17 -0700
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [193.117.190.19])
	by kenton.algor.co.uk (8.8.8/8.8.8) with ESMTP id AAA03429;
	Tue, 20 Jun 2000 00:46:12 +0100 (GMT/BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id AAA03494;
	Tue, 20 Jun 2000 00:46:11 +0100 (BST)
Date:   Tue, 20 Jun 2000 00:46:11 +0100 (BST)
Message-Id: <200006192346.AAA03494@mudchute.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Icache coherency problems for R3400, DS5000/240
In-Reply-To: <20000620000455.B27454@bacchus.dhis.org>
References: <Pine.GSO.3.96.1000619110632.10348D-100000@delta.ds2.pg.gda.pl>
	<20000620000455.B27454@bacchus.dhis.org>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> > ... Second, it changes the assumption of the icache line size to a
> > single word -- apparently, at least R3400 of DS5000/240 has an
> > icache with such a layout (DEC docs confirm it, indeed).

Yes, the original R3000 chip could be wired to produce the appearance
of multi-word lines in its I-cache, and some derivative CPUs were built
that way.  Four was popular - I don't think anyone did 8.

> > Besides obvious bugfixes, it introduces two significant changes.
> > First, flush_icache_page() now performs what the name suggests,
> > i.e. flushes the instruction cache.

And while I'm here, I'll continue my lonely campaign.  I suggest you
don't say "flush" because nobody knows whether it means invalidate,
write-back, or both[1].  Instead, say "invalidate", "writeback", or
"both".  Even if it means changing St Linus' function names...

[1] well in this case we do, because this is an I-cache and R3000s
    only had write-through caches anyway.  But you weren't going to
    stop there, were you?

Dominic
Algorithmics Ltd
dom@algor.co.uk
