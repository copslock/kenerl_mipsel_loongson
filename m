Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KEuFEC029325
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:56:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KEuF70029324
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:56:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f39.dialo.tiscali.de [62.246.16.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KEu1EC029311
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:56:06 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7KEwZl24726;
	Tue, 20 Aug 2002 16:58:35 +0200
Date: Tue, 20 Aug 2002 16:58:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@oss.sgi.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: New binutils for kernel
Message-ID: <20020820165835.B26852@linux-mips.org>
References: <20020819171238.A7457@linux-mips.org> <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl> <20020820162959.A26852@linux-mips.org> <20020820145051.GA17311@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020820145051.GA17311@nevyn.them.org>; from dan@debian.org on Tue, Aug 20, 2002 at 10:50:51AM -0400
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 10:50:51AM -0400, Daniel Jacobowitz wrote:

> > So any comments?
> 
> Well, I think 2.13's a good idea, but it's very new.  I'd say that was
> acceptable as long as you're looking at MIPS64 only, not at MIPS32. 

Such considerations have kept us back at antique levels of binutils.  And
juggling with several different versions for userland, and two kernel
flavours is evil ...

  Ralf
