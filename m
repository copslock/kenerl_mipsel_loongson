Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 02:21:27 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:25810 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225205AbTBNCV0>;
	Fri, 14 Feb 2003 02:21:26 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1E1ShKp003443;
	Thu, 13 Feb 2003 17:28:44 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA05334; Fri, 14 Feb 2003 13:21:21 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1E2LI8G011436;
	Fri, 14 Feb 2003 13:21:19 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1E2LIkT011434;
	Fri, 14 Feb 2003 13:21:18 +1100
Date: Fri, 14 Feb 2003 13:21:18 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] ip27's _flush_cache_all uninitialized
Message-ID: <20030214022118.GM8408@pureza.melbourne.sgi.com>
References: <20030213060017.GL8408@pureza.melbourne.sgi.com> <20030214025835.A5760@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214025835.A5760@linux-mips.org>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 14, 2003 at 02:58:35AM +0100, Ralf Baechle wrote:
> > I'm not sure what the best solution is, but this makes things work:
> 
> And is guaranateed to crawl.  flush_cache_all() is a no-op for the R10k.

Right-o.  But who cares?  Apparently it almost never gets called.

Also, I couldn't find any documentation on what callers of
flush_cache_all() expect...

Cheers,
Andrew
