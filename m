Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2007 18:46:32 +0100 (BST)
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:44198 "HELO
	smtp117.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022087AbXF3Rqa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 30 Jun 2007 18:46:30 +0100
Received: (qmail 29655 invoked from network); 30 Jun 2007 17:46:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1k0HfWVsz1I06GNvocBQgJKY7ZpRjF5qe38o5BeJjBjM19TgCiOEGxJmR67/zwLVhQgW4BHzTw5s3yBwxS3QSr3Z7eOoNaKoXA7y4QwtoKYY+jpxhrwKQpMRWaqATO+vDjAySyZgLqfzjNJncE7NMcnof4YwjjUFlolwvtQHaQY=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp117.sbc.mail.sp1.yahoo.com with SMTP; 30 Jun 2007 17:46:22 -0000
X-YMail-OSG: jg5aZysVM1kxlEhWVbex.r5HuwIUr1hcD.PxUhYRrUBZ6_MNxhOHAz.R37NRVkyubUQD6nbqjQ--
From:	David Brownell <david-b@pacbell.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
Date:	Sat, 30 Jun 2007 10:46:20 -0700
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
References: <20070627.222458.27955527.anemo@mba.ocn.ne.jp> <200706300953.20156.david-b@pacbell.net> <20070701.023414.71085498.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070701.023414.71085498.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706301046.20826.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Saturday 30 June 2007, Atsushi Nemoto wrote:
> On Sat, 30 Jun 2007 09:53:19 -0700, David Brownell <david-b@pacbell.net> wrote:
> > > This is a driver for SPI controller built into TXx9 MIPS SoCs.
> > > This driver is derived from arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c.
> > > 
> > > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > > ---
> > > Changes from previous version:
> > 
> > Better, but still not there yet.
> 
> Thanks!  I'll be back with take 3 patch.
> 
> > > +	txx9spi_cs_func(spi, c, 0, 1000000000 / 2 / spi->max_speed_hz);
> > 
> > You still use this confusing A/2/B syntax.  Please
> > rewrite that using one "/" and one "*".  (And there
> > is similar usage elsewhere.)
> 
> The compiler will optimize "1000000000 / 2 / spi->max_speed_hz" into
> "500000000 / spi->max_speed_hz", so it can be treat as one "/", no?

Sure it's deterministic.  But that doesn't prevent me from
needing a double-take to figure what it does ... it's best
to avoid confusing idioms in code.  At the very least, put
parentheses there ...
