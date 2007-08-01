Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 13:58:06 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:54660 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20021823AbXHAM6E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 13:58:04 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l71CvrA5027401
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Aug 2007 14:57:53 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l71CvrL2027399;
	Wed, 1 Aug 2007 14:57:53 +0200
Date:	Wed, 1 Aug 2007 14:57:53 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Domen Puncer <domen.puncer@telargo.com>
Cc:	Russell King <rmk@arm.linux.org.uk>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h interface for platforms]
Message-ID: <20070801125753.GB27199@lst.de>
References: <20070711093113.GE4375@moe.telargo.com> <200707110856.58463.david-b@pacbell.net> <20070711161633.GA4846@lst.de> <200707111002.55119.david-b@pacbell.net> <20070711203454.GC2301@flint.arm.linux.org.uk> <20070713091203.GE11476@nd47.coderock.org> <20070801072807.GL4529@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070801072807.GL4529@moe.telargo.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Aug 01, 2007 at 09:28:07AM +0200, Domen Puncer wrote:
> > It doesn't make any assumption on struct clk, it's just a
> > wrapper around functions from clk.h.
> > Point of this patch was to abstract exported functions, since
> > arch/powerpc/ can support multiple platfroms in one binary.
> 
> So... the thread just ended without any consensus, ACK or whatever.
> 
> Choices I see:
> - have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
>   every implemenation fill some global struct.
> - leave this patch as it is, abstraction only for arch/powerpc/.
> - or I can just forget about this, and leave it for the next sucker
>   who will want nicer clock handling in some driver

It seems like arm really wants this optimized to the last cycle
and no abstraction inbetween so we're probably stuck with the status
quo.   I'm pretty sure this will get too messy sooner and later and
people will clean the mess up, but due to the political issues I
don't think it's fair to put that burden on you just for submitting
the powerpc implementation.

So, please leave the patch as-is.
