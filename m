Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 20:19:04 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:23681 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbVBQUSs>; Thu, 17 Feb 2005 20:18:48 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1HKCddV009597;
	Thu, 17 Feb 2005 20:12:39 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1H1Y7hW015558;
	Thu, 17 Feb 2005 01:34:07 GMT
Date:	Thu, 17 Feb 2005 01:34:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, macro@mips.com,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
Message-ID: <20050217013406.GA14909@linux-mips.org>
References: <Pine.LNX.4.61.0501131824350.21179@perivale.mips.com> <87k6qh2e6j.fsf@redhat.com> <Pine.LNX.4.61.0501141956520.21179@perivale.mips.com> <20050122.015040.108744446.anemo@mba.ocn.ne.jp> <Pine.LNX.4.61L.0501211739410.16576@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0501211739410.16576@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 22, 2005 at 02:51:47AM +0000, Maciej W. Rozycki wrote:

> > 1. How about using 'const void *' for outs*()/reads*() ?  This will
> >    remove some compiler warnings too.  Also, it seems 'volatile' for
> >    memory buffer are unneeded.
> > 
> > 2. In *in*()/*out*(), it would be better to call __swizzle_addr*()
> >    AFTER adding mips_io_port_base.  This unifies the meaning of the
> >    argument of __swizzle_addr*() (always virtual address).  Then,
> >    mach-specific __swizzle_addr*() can to every evil thing based on
> >    the argument.
> > 
> > 3. How about Moving generic ioswab*() to mangle-port.h ?  Also how
> >    about passing virtual address to *ioswab*() ?  Then we can provide
> >    mach-specific ioswab*() and can do every evil thing based on its
> >    argument.  It is usefull on machines which have regions with
> >    different endian conversion scheme.
> 
>  Thanks for your insight -- your comments are not lost and I am working on 
> taking them into account.  But meanwhile a confusion around the semantics 
> of these operations arose (there is no documentation on them and some 
> drivers expect some of these functions to swap, while others expect them 
> not to) and changes were made to the tree that invalidated some of the 
> fixes.  That needs to be addressed first and I expect another update to 
> the file.  Here's a patch I'm going to start with.  Functions it adds have 
> been named dma_* to indicate they are meant to preserve memory byte 
> ordering.

Looks good but I don't really like the dma_* name prefix as these functions
really have nothing to do with DMA - in fact they're the opposite.

  Ralf
