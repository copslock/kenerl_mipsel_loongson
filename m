Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 12:26:52 +0000 (GMT)
Received: from p508B7BBE.dip.t-dialin.net ([80.139.123.190]:43691 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225268AbSLLM0v>; Thu, 12 Dec 2002 12:26:51 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBCCKMh05834;
	Thu, 12 Dec 2002 13:20:22 +0100
Date: Thu, 12 Dec 2002 13:20:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vivien Chappelier <vivienc@nerim.net>, linux-mips@linux-mips.org,
	Ilya Volynets <ilya@theIlya.com>
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
Message-ID: <20021212132022.A5060@linux-mips.org>
References: <Pine.LNX.4.21.0212120004330.2300-100000@melkor> <1039656676.18587.63.camel@irongate.swansea.linux.org.uk> <20021212033307.C22987@linux-mips.org> <1039697045.21231.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039697045.21231.13.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 12, 2002 at 12:44:05PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 12, 2002 at 12:44:05PM +0000, Alan Cox wrote:

> > The O2 is non-cache coherent.  So with the fairly large write-back second
> > level caches enabled frame buffer write could potencially be delayed
> > indefinately but in any case quite long.  Frame buffers are usually only
> 
> You can flush the frame buffer pages that were touched at the end of an
> operation though

Flushes are very expensive operations, on the order of 16 cycles per
cacheline plus memory delay.  So why using them when just using the right
cache mode does the right thing already.

  Ralf
