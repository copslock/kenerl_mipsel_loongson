Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARGFJP21032
	for linux-mips-outgoing; Tue, 27 Nov 2001 08:15:19 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fARGFGo21029
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 08:15:16 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fARFFER03027;
	Wed, 28 Nov 2001 02:15:14 +1100
Date: Wed, 28 Nov 2001 02:15:14 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Chris Dearman <chris@algor.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS performance counters
Message-ID: <20011128021514.A2907@dea.linux-mips.net>
References: <3C0399AC.9C5D412C@algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0399AC.9C5D412C@algor.co.uk>; from chris@algor.co.uk on Tue, Nov 27, 2001 at 01:48:28PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 01:48:28PM +0000, Chris Dearman wrote:

>   A few days ago someone (sorry, I deleted the mail...) was asking about
> support for MIPS performance counters.  Some time ago I ported Mikael
> Pettersson's perfctr (http://www.csd.uu.se/~mikpe/linux/perfctr)
> driver to 2.2.12 and used that to profile programs running on an
> RM7000.  This driver has a reasonably generic interface and supports per
> process profiling.
>  Unless anyone can suggest a better starting point I'll have a look at
> putting this into 2.4.14.

Aside a few details I liked the proposal posted by Keith Owens.  I guess
his proposal is however more aimed at 2.5 than at 2.4 so for 2.4 your
proposal is probably a good thing.

  Ralf
