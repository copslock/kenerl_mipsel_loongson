Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 01:58:48 +0000 (GMT)
Received: from p508B4F93.dip.t-dialin.net ([IPv6:::ffff:80.139.79.147]:24987
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225223AbTBNB6s>; Fri, 14 Feb 2003 01:58:48 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1E1wZq07355;
	Fri, 14 Feb 2003 02:58:35 +0100
Date: Fri, 14 Feb 2003 02:58:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, mg@sgi.com, gnb@sgi.com
Subject: Re: [patch] ip27's _flush_cache_all uninitialized
Message-ID: <20030214025835.A5760@linux-mips.org>
References: <20030213060017.GL8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030213060017.GL8408@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Thu, Feb 13, 2003 at 05:00:17PM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 13, 2003 at 05:00:17PM +1100, Andrew Clausen wrote:

> _flush_cache_all() and ___flush_cache_all() were uninitialized
> (i.e. NULL).  Someone probably assumed (incorrectly) that this
> was ok, since flush_cache_all() doesn't use _flush_cache_all()
> (or so they thought...).
> 
> End result: anything that called flush_cache_all() (a macro)
> tried to call a function at 0x0, and died.  This includes vmalloc().
> 
> I'm not sure what the best solution is, but this makes things work:

And is guaranateed to crawl.  flush_cache_all() is a no-op for the R10k.

  Ralf
