Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 20:24:43 +0100 (BST)
Received: from p508B62A5.dip.t-dialin.net ([IPv6:::ffff:80.139.98.165]:7079
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTDJTYm>; Thu, 10 Apr 2003 20:24:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3AJOUk01954;
	Thu, 10 Apr 2003 21:24:30 +0200
Date: Thu, 10 Apr 2003 21:24:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Mike Uhler <uhler@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: way selection bit for multi-way cache
Message-ID: <20030410212430.A519@linux-mips.org>
References: <20030410110527.E9002@mvista.com> <200304101850.h3AIorK11089@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304101850.h3AIorK11089@uhler-linux.mips.com>; from uhler@mips.com on Thu, Apr 10, 2003 at 11:50:53AM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 10, 2003 at 11:50:53AM -0700, Mike Uhler wrote:

> I can't comment on anything but MIPS32 and MIPS64 CPUs, but the
> MIPS32 and MIPS64 standard is to use the bits above the index field
> to specify the way.  See the figure entitled "Usage of Address Fields
> to Select Index and Way" in the CACHE instruction description of the
> MIPS32 and MIPS64 Architecture for Programmer's manuals.

The question came up between Jun and me when revising the way of handling
multi-way caches.  There is the MIPS32 / MIPS64 way of selecting the
cache way - but that scheme was originally already introduced by the
R4600.  The second somewhat less common scheme is using the lowest bits
of the address.  That was originally introduced with the R10000 but a
few other processors such as the R5432 and the TX49 series are using it
as well.  Unfortunately there has been way to much creativity (usually
a positive property but ...) among designers so this posting is an
attempt to achieve completeness.

  Ralf
