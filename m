Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 17:08:44 +0100 (BST)
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:37040 "HELO
	smtp115.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021638AbXGKQIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 17:08:42 +0100
Received: (qmail 41655 invoked from network); 11 Jul 2007 16:08:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=WZAFku+W3BpFkdz6yAl06HX/yHDW+YXhje0nZILEbmQCgzDK2vTDwZUjhbza3wJ1zFsDIq9Gvhs5GEPNLDvyyhH9XYEgGiP+st6peKwhBIw6PX2p4A8obbmGE40wiVlIcsfS14SUCSiTlivhjEsYgUakRj0BHc3YYmrwEowFx98=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp115.sbc.mail.sp1.yahoo.com with SMTP; 11 Jul 2007 16:08:33 -0000
X-YMail-OSG: SmAZxiQVM1kiCRNGkisXdBsa1T5aUEyu7qVqCcWrjRi1SPKUBPeXk7nTnamOwUpbVZAboBTeww--
From:	David Brownell <david-b@pacbell.net>
To:	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Date:	Wed, 11 Jul 2007 08:56:58 -0700
User-Agent: KMail/1.9.6
Cc:	Domen Puncer <domen.puncer@telargo.com>, linuxppc-dev@ozlabs.org,
	Sylvain Munaut <tnt@246tnt.com>, linux-mips@linux-mips.org,
	Russell King <rmk@arm.linux.org.uk>
References: <20070711093113.GE4375@moe.telargo.com> <20070711093220.GF4375@moe.telargo.com> <20070711103640.GB15536@lst.de>
In-Reply-To: <20070711103640.GB15536@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707110856.58463.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Wednesday 11 July 2007, Christoph Hellwig wrote:
> On Wed, Jul 11, 2007 at 11:32:20AM +0200, Domen Puncer wrote:
> > clk interface for arch/powerpc, platforms should fill
> > clk_functions.
> 
> Umm, this is about the fifth almost identical implementation of
> the clk_ functions.  Please, please put it into common code.
> 
> And talk to the mips folks which just got a similar comment from me.

You mean like a lib/clock.c core, rather than an opsvector?

ISTR that allowing custom platform-specific implementations
was intended to be a feature.  But it's also true that some
folks see lack of shared implementation code as a drawback;
so I've CC'd Russell King (who originated the interface for
ARM platforms).

- Dave
