Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 21:09:16 +0100 (BST)
Received: from p508B62A5.dip.t-dialin.net ([IPv6:::ffff:80.139.98.165]:49831
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTDJUJP>; Thu, 10 Apr 2003 21:09:15 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3AK96b02878;
	Thu, 10 Apr 2003 22:09:06 +0200
Date: Thu, 10 Apr 2003 22:09:06 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Mike Uhler <uhler@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: way selection bit for multi-way cache
Message-ID: <20030410220906.B519@linux-mips.org>
References: <20030410212430.A519@linux-mips.org> <200304101937.h3AJbl211418@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304101937.h3AJbl211418@uhler-linux.mips.com>; from uhler@mips.com on Thu, Apr 10, 2003 at 12:37:47PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 10, 2003 at 12:37:47PM -0700, Mike Uhler wrote:

> > The question came up between Jun and me when revising the way of handling
> > multi-way caches.  There is the MIPS32 / MIPS64 way of selecting the
> > cache way - but that scheme was originally already introduced by the
> > R4600.  The second somewhat less common scheme is using the lowest bits
> > of the address.  That was originally introduced with the R10000 but a
> > few other processors such as the R5432 and the TX49 series are using it
> > as well.  Unfortunately there has been way to much creativity (usually
> > a positive property but ...) among designers so this posting is an
> > attempt to achieve completeness.
> 
> Exactly why we made it a standard in MIPS32 and MIPS64.

Yep, of the existing variations that was certainly the nicest.  Only a
single function had to be taught about multi-way caches and that only
because it's a bit hard to flush caches for another process due to the
TLB translation required for the hit cacheops.  Alternative schemes need
more support by the code.

  Ralf
