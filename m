Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64Bb0Rw002994
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 04:37:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64Bb079002993
	for linux-mips-outgoing; Thu, 4 Jul 2002 04:37:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.28.123] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64BasRw002984
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 04:36:55 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64BewK27138;
	Thu, 4 Jul 2002 13:40:58 +0200
Date: Thu, 4 Jul 2002 13:40:58 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] Re: [PATCH] r4k icache flushing for mips64 CVS HEAD
Message-ID: <20020704134058.A27135@dea.linux-mips.net>
References: <20020702004542.B32068@dea.linux-mips.net> <Pine.LNX.4.21.0207041328550.1601-200000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207041328550.1601-200000@melkor>; from vivien.chappelier@enst-bretagne.fr on Thu, Jul 04, 2002 at 01:33:15PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 01:33:15PM +0200, Vivien Chappelier wrote:

> > > 	This fixes icache flushing for the r4xx0 processor in the current
> > > (CVS HEAD) 2.5.1 tree. The flush_cache_all function does nothing there,
> > > that's why I moved it to flush_cache_l1.
> > 
> > Not right, I checked in a variation of it ...
> 
> Ok, but you forgot some things. The following patch adds the declaration
> of _flush_cache_all in loadmmu.c and pgtables.h
> 
> I guess 3 patches is enough for today ;) More coming later ;)

Looks right, applied to 2.5 only.

  Ralf
