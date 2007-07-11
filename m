Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 17:16:56 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:13806 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20021656AbXGKQQy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 17:16:54 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6BGGXNK004941
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Jul 2007 18:16:33 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l6BGGXRF004939;
	Wed, 11 Jul 2007 18:16:33 +0200
Date:	Wed, 11 Jul 2007 18:16:33 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	David Brownell <david-b@pacbell.net>
Cc:	Christoph Hellwig <hch@lst.de>,
	Domen Puncer <domen.puncer@telargo.com>,
	linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tnt.com>,
	linux-mips@linux-mips.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070711161633.GA4846@lst.de>
References: <20070711093113.GE4375@moe.telargo.com> <20070711093220.GF4375@moe.telargo.com> <20070711103640.GB15536@lst.de> <200707110856.58463.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707110856.58463.david-b@pacbell.net>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Jul 11, 2007 at 08:56:58AM -0700, David Brownell wrote:
> > Umm, this is about the fifth almost identical implementation of
> > the clk_ functions.  Please, please put it into common code.
> > 
> > And talk to the mips folks which just got a similar comment from me.
> 
> You mean like a lib/clock.c core, rather than an opsvector?

I mean an ops vector and surrounding wrappers.  Every architecture
is reimplementing their own dispatch table which is rather annoying.

What would a lib/clock.c do?
