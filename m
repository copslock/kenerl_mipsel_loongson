Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OIwARw005340
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 11:58:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OIwAnj005339
	for linux-mips-outgoing; Wed, 24 Jul 2002 11:58:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f151.dialo.tiscali.de [62.246.19.151])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OIvvRw005329
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 11:58:04 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6OIwhs22735;
	Wed, 24 Jul 2002 20:58:43 +0200
Date: Wed, 24 Jul 2002 20:58:43 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Krishna Kondaka <krishna@Sanera.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: kernel BUG at slab.c:1073!
Message-ID: <20020724205843.A22500@dea.linux-mips.net>
References: <200207241834.g6OIYDi28110@icarus.sanera.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207241834.g6OIYDi28110@icarus.sanera.net>; from krishna@Sanera.net on Wed, Jul 24, 2002 at 11:34:13AM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.9 required=5.0 tests=IN_REP_TO,PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 24, 2002 at 11:34:13AM -0700, Krishna Kondaka wrote:

> slab.c : line 1072-1073 is        
> 
> if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
>                 BUG();
> 
> The driver being loaded is a small proprietary driver. The init routine of
> the driver is doing kmalloc() with GFP_KERNEL as the second argument. I know
> that I can fix my driver to use GFP_ATOMIC if running in interrupt context.
> 
> My question is why is the "insmod" command running in interrupt context?

Simple answer: it isn't, normally.  You should try to figure out who was
calling kmalloc or the slab allocator; knowing the function will probably
already solve the miracle.  All the addresses in the call trace that are
in the range from 0xc0000000 and above are potencially modules addresses,
so they're worth some closer examination.

Aside, I urgently recommend an upgrade to a newer kernel.  2.4.9 is lacking
more than half a year worth of bug fixes.  That can ruin your whole day ...

  Ralf
