Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 02:39:41 +0000 (GMT)
Received: from p508B7C81.dip.t-dialin.net ([80.139.124.129]:51111 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225260AbSLLCjk>; Thu, 12 Dec 2002 02:39:40 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBC2X7B29165;
	Thu, 12 Dec 2002 03:33:07 +0100
Date: Thu, 12 Dec 2002 03:33:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vivien Chappelier <vivienc@nerim.net>, linux-mips@linux-mips.org,
	Ilya Volynets <ilya@theIlya.com>
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
Message-ID: <20021212033307.C22987@linux-mips.org>
References: <Pine.LNX.4.21.0212120004330.2300-100000@melkor> <1039656676.18587.63.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039656676.18587.63.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 12, 2002 at 01:31:16AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 12, 2002 at 01:31:16AM +0000, Alan Cox wrote:

> On Wed, 2002-12-11 at 23:41, Vivien Chappelier wrote:
> > linear framebuffer (up to 8MB with 64kB granularity). I'm then remapping
> > all those pages to one virtual region obtained from get_vm_area so that
> > 1. caching attributes can be set to cacheable write-through no WA
> 
> Ick. The framebuffer can't handle cached and write barriers ?

The O2 is non-cache coherent.  So with the fairly large write-back second
level caches enabled frame buffer write could potencially be delayed
indefinately but in any case quite long.  Frame buffers are usually only
written to, so the cache mode "uncached accelerated" seems preferable
but only the R10000 provides this mode, so for the R5000 write-though no
write allocation is the next best solution.

  Ralf
