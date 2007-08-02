Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 00:32:26 +0100 (BST)
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:61617 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022316AbXHBXcW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 00:32:22 +0100
Received: (qmail 51327 invoked from network); 2 Aug 2007 23:32:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Rl0NlrL5UvRhd+j9QIzKUQ2oYGpePVEErAyK0HYoENl/GUoxhmi/nvpJM5E41EyALua4ejheaR+xo4N1saGLQU8n/mdN4LWoS4VDrDOLwP7qCmfErI7DtJa3Pd85J23iibXan6C2cYtZR1aeIYlAtXoSEQ23EXORwgKc6jskExQ=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.247.176 with plain)
  by smtp104.sbc.mail.re2.yahoo.com with SMTP; 2 Aug 2007 23:32:15 -0000
X-YMail-OSG: gC8Yb9MVM1km3wbWHfYWuBKHJjb6YUVOoi_psORs9DhiFeFBjqqMab7riX6JifrPknAt3.ZhKw--
From:	David Brownell <david-b@pacbell.net>
To:	Christoph Hellwig <hch@lst.de>
Subject: Re: Generic clk.h wrappers? [Was: Re: [PATCH 1/3] powerpc clk.h interface for platforms]
Date:	Thu, 2 Aug 2007 16:32:13 -0700
User-Agent: KMail/1.9.6
Cc:	Domen Puncer <domen.puncer@telargo.com>,
	Russell King <rmk@arm.linux.org.uk>, linuxppc-dev@ozlabs.org,
	linux-mips@linux-mips.org
References: <20070711093113.GE4375@moe.telargo.com> <20070801072807.GL4529@moe.telargo.com> <20070801125753.GB27199@lst.de>
In-Reply-To: <20070801125753.GB27199@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708021632.13982.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Wednesday 01 August 2007, Christoph Hellwig wrote:
> On Wed, Aug 01, 2007 at 09:28:07AM +0200, Domen Puncer wrote:
> > > It doesn't make any assumption on struct clk, it's just a
> > > wrapper around functions from clk.h.
> > > Point of this patch was to abstract exported functions, since
> > > arch/powerpc/ can support multiple platfroms in one binary.
> > 
> > So... the thread just ended without any consensus, ACK or whatever.
> > 
> > Choices I see:
> > - have EXPORT_SYMBOL for clk.h functions in ie. lib/clock.c and have
> >   every implemenation fill some global struct.
> > - leave this patch as it is, abstraction only for arch/powerpc/.

That seems the best solution for now, I agree.


> > - or I can just forget about this, and leave it for the next sucker
> >   who will want nicer clock handling in some driver
> 
> It seems like arm really wants this optimized to the last cycle
> and no abstraction inbetween so we're probably stuck with the status
> quo.   I'm pretty sure this will get too messy sooner and later and
> people will clean the mess up, but due to the political issues I
> don't think it's fair to put that burden on you just for submitting
> the powerpc implementation.
> 
> So, please leave the patch as-is.
> 
