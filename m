Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 18:03:12 +0100 (BST)
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:42574 "HELO
	smtp121.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021593AbXGKRDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 18:03:10 +0100
Received: (qmail 62903 invoked from network); 11 Jul 2007 17:02:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=BMX09YzSGWviLxI8GxosP/ZOq37W02sp6pnfYELvZ+IDjyCQCu41S+zjFh5ijGw+uZwNqcXrbFfybO/OO172YQV+H39Sa3koss1GrI4mtrvl3hVZ1rGpP9yhTHfaqO8vUP5gJQpzLSB30PaqYC0Bn8lpQw/a2dB666H+TI7e6hk=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp121.sbc.mail.sp1.yahoo.com with SMTP; 11 Jul 2007 17:02:57 -0000
X-YMail-OSG: x4_PibIVM1k9XKIOI3L2pja.uhCmzL5FbsJTe3jx.4yMCSsxs1dUwtuO1qzKsFCe.vVcc_sNPw--
From:	David Brownell <david-b@pacbell.net>
To:	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Date:	Wed, 11 Jul 2007 10:02:54 -0700
User-Agent: KMail/1.9.6
Cc:	Domen Puncer <domen.puncer@telargo.com>, linuxppc-dev@ozlabs.org,
	Sylvain Munaut <tnt@246tnt.com>, linux-mips@linux-mips.org,
	Russell King <rmk@arm.linux.org.uk>
References: <20070711093113.GE4375@moe.telargo.com> <200707110856.58463.david-b@pacbell.net> <20070711161633.GA4846@lst.de>
In-Reply-To: <20070711161633.GA4846@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707111002.55119.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Wednesday 11 July 2007, Christoph Hellwig wrote:
> On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > > Umm, this is about the fifth almost identical implementation of
> > > the clk_ functions.  Please, please put it into common code.
> > > 
> > > And talk to the mips folks which just got a similar comment from me.
> > 
> > You mean like a lib/clock.c core, rather than an opsvector?
> 
> I mean an ops vector and surrounding wrappers.  Every architecture
> is reimplementing their own dispatch table which is rather annoying.

ARM doesn't.  :)

But then, nobody expects one kernel to support more than one
vendor's ARM chips; or usually, more than one generation of
that vendor's chips.  So any dispatch table is specific to
a given platform, and tuned to its quirks.  Not much to share
between OMAP and AT91, for example, except in some cases maybe
an arm926ejs block.


> What would a lib/clock.c do?

Some folk have suggested defining a core "struct clk {...}" with
some of the basics -- refcount, parent, maybe enough to support
the clk_get() lookup or even more -- so that the more obvious
stuff doesn't need constant re-implementation, and so that new
implementations become easier.  Platforms would wrap that with
whatever extensions they need.

I've not seen a solid proposal for such a thing, and it's not
clear to me how that would play with with older code (e.g. any
of the ARM implementations).

And I'm sure there are other suggestions ... I was mostly just
wondering just what you were suggesting.

- Dave
