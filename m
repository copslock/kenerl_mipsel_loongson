Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 02:36:46 +0000 (GMT)
Received: from p508B4F93.dip.t-dialin.net ([IPv6:::ffff:80.139.79.147]:53403
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225233AbTBNCgq>; Fri, 14 Feb 2003 02:36:46 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1E2aal08188;
	Fri, 14 Feb 2003 03:36:36 +0100
Date: Fri, 14 Feb 2003 03:36:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] ip27's _flush_cache_all uninitialized
Message-ID: <20030214033636.A8056@linux-mips.org>
References: <20030213060017.GL8408@pureza.melbourne.sgi.com> <20030214025835.A5760@linux-mips.org> <20030214022118.GM8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030214022118.GM8408@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Fri, Feb 14, 2003 at 01:21:18PM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 14, 2003 at 01:21:18PM +1100, Andrew Clausen wrote:

> On Fri, Feb 14, 2003 at 02:58:35AM +0100, Ralf Baechle wrote:
> > > I'm not sure what the best solution is, but this makes things work:
> > 
> > And is guaranateed to crawl.  flush_cache_all() is a no-op for the R10k.
> 
> Right-o.  But who cares?  Apparently it almost never gets called.
> 
> Also, I couldn't find any documentation on what callers of
> flush_cache_all() expect...

Documentation/cachetlb.txt - but it takes alot of reading between the lines
that is reading of the generic mm code to understand that document.

  Ralf
