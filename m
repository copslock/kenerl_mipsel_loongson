Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 09:40:13 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38366 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20023822AbXHCIkL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 09:40:11 +0100
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1IGsdv-0001EP-3a; Fri, 03 Aug 2007 09:36:19 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.62)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1IGsds-0004MU-UU; Fri, 03 Aug 2007 09:36:17 +0100
Date:	Fri, 3 Aug 2007 09:36:16 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	David Brownell <david-b@pacbell.net>
Cc:	Christoph Hellwig <hch@lst.de>,
	Domen Puncer <domen.puncer@telargo.com>,
	linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org
Subject: Re: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h interface for platforms]
Message-ID: <20070803083616.GA14516@flint.arm.linux.org.uk>
References: <20070711093113.GE4375@moe.telargo.com> <20070801072807.GL4529@moe.telargo.com> <20070801125753.GB27199@lst.de> <200708021632.13982.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200708021632.13982.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 04:32:13PM -0700, David Brownell wrote:
> On Wednesday 01 August 2007, Christoph Hellwig wrote:
> > On Wed, Aug 01, 2007 at 09:28:07AM +0200, Domen Puncer wrote:
> > > > It doesn't make any assumption on struct clk, it's just a
> > > > wrapper around functions from clk.h.
> > > > Point of this patch was to abstract exported functions, since
> > > > arch/powerpc/ can support multiple platfroms in one binary.
> > > 
> > > So... the thread just ended without any consensus, ACK or whatever.
> > > 
> > > Choices I see:
> > > - have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
> > >   every implemenation fill some global struct.
> > > - leave this patch as it is, abstraction only for arch/powerpc/.
> 
> That seems the best solution for now, I agree.

I've not been avoiding replying further to this thread in spite, it's
just that I've not had any time what so ever to look at this further.
It's very low priority for me at the moment, so it's getting zero time,
and will continue to be in that state for at least the next month and
a bit.  Sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
