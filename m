Received:  by oss.sgi.com id <S42301AbQFSXwq>;
	Mon, 19 Jun 2000 16:52:46 -0700
Received: from [62.180.18.37] ([62.180.18.37]:29188 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S42239AbQFSXwe>;
	Mon, 19 Jun 2000 16:52:34 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403524AbQFSXwY>;
        Tue, 20 Jun 2000 01:52:24 +0200
Date:   Tue, 20 Jun 2000 01:52:24 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Dominic Sweetman <dom@algor.co.uk>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Icache coherency problems for R3400, DS5000/240
Message-ID: <20000620015224.A28725@bacchus.dhis.org>
References: <Pine.GSO.3.96.1000619110632.10348D-100000@delta.ds2.pg.gda.pl> <20000620000455.B27454@bacchus.dhis.org> <200006192346.AAA03494@mudchute.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200006192346.AAA03494@mudchute.algor.co.uk>; from dom@algor.co.uk on Tue, Jun 20, 2000 at 12:46:11AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 20, 2000 at 12:46:11AM +0100, Dominic Sweetman wrote:

> And while I'm here, I'll continue my lonely campaign.  I suggest you
> don't say "flush" because nobody knows whether it means invalidate,
> write-back, or both[1].  Instead, say "invalidate", "writeback", or
> "both".  Even if it means changing St Linus' function names...

Sigh, I tried exactly this and got fire from the 68k fraction because
they considered my naming ambigous.

  Ralf
