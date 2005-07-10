Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 08:52:00 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:18185 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226444AbVGKHvl>; Mon, 11 Jul 2005 08:51:41 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6B7qTMj002065;
	Mon, 11 Jul 2005 08:52:30 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6ANEKqT020991;
	Mon, 11 Jul 2005 00:14:20 +0100
Date:	Mon, 11 Jul 2005 00:14:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alex Gonzalez <linux-mips@packetvision.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Benchmarking RM9000
Message-ID: <20050710231419.GA28518@linux-mips.org>
References: <20050708091711Z8226352-3678+1954@linux-mips.org> <20050708120238.GA2816@linux-mips.org> <1120825549.28569.949.camel@euskadi.packetvision> <20050708130131.GC2816@linux-mips.org> <1120833749.28569.965.camel@euskadi.packetvision>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120833749.28569.965.camel@euskadi.packetvision>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 08, 2005 at 03:42:29PM +0100, Alex Gonzalez wrote:

> The performance of our video application is well below our expectations.
> We are still doing some profiling work on it, but we are also looking at
> other possibilities.
> 
> What other benchmarking tool would you recommend?
> 
> Currently it's a NFS mounted system, but even if we could use a block
> device the access speed wouldn't be more than 1.5 Mbps, so that is a
> limitation for the benchmark.

As a shot into the dark ...

Make sure you exploit the RM9000's write-gathering capabilities when
writing into the frame buffer.  If the frame buffer happens to be on
a PCI device you're probably performing uncached writes which will
slow down the thing to a crawl.

  Ralf
