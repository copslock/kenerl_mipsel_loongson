Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 09:48:57 +0100 (BST)
Received: from p508B4F3A.dip.t-dialin.net ([IPv6:::ffff:80.139.79.58]:41615
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225241AbTFEIsz>; Thu, 5 Jun 2003 09:48:55 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h558mrbY032697;
	Thu, 5 Jun 2003 01:48:53 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h558mqEj032696;
	Thu, 5 Jun 2003 10:48:52 +0200
Date: Thu, 5 Jun 2003 10:48:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030605084852.GA25712@linux-mips.org>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com> <20030605001232.GA5626@linux-mips.org> <20030604183836.B25414@mvista.com> <16094.64161.12926.645512@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16094.64161.12926.645512@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 09:09:05AM +0100, Dominic Sweetman wrote:

> A naive network synchronisation protocol - analogous to your first
> proposal - would leave clocks differing by a network round-trip time
> or so: but NTP does a lot better.  So in principle you should be able
> to scale NTP to create a clock synchronised within some fraction of
> the time taken by a CPU-to-CPU communication... but compressing the
> essence of the NTP protocol into something which runs fast enough
> might be interesting!
> 
> My 5-minutes-over-breakfast feeling is that you should be able to
> figure out a way to get time right enough; try reading up how NTP
> works and see whether it can be made to work?

Yes, already been thinking about that.  The essence of NTP is a software
implementation of a phase locked loop.  The full NTP protocol is way to
heavy of course but the subset we're talking about would be rather
lightweight.  I'd expect the phase noise to be in the low ppb range,
little problems with unlocking.  And it'll be usable for arbitrary
combinations of clock frequencies.  So an approach to try.

Enjoy your breakfast :-)

  Ralf
