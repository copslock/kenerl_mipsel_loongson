Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KEwcEC029473
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:58:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KEwcaM029472
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:58:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KEwXEC029460
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:58:34 -0700
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17hAVd-0005LG-00; Tue, 20 Aug 2002 10:01:29 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17hAWD-00071q-00; Tue, 20 Aug 2002 11:02:05 -0400
Date: Tue, 20 Aug 2002 11:02:05 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@oss.sgi.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: New binutils for kernel
Message-ID: <20020820150204.GA16542@nevyn.them.org>
References: <20020819171238.A7457@linux-mips.org> <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl> <20020820162959.A26852@linux-mips.org> <20020820145051.GA17311@nevyn.them.org> <20020820165835.B26852@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820165835.B26852@linux-mips.org>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 04:58:35PM +0200, Ralf Baechle wrote:
> On Tue, Aug 20, 2002 at 10:50:51AM -0400, Daniel Jacobowitz wrote:
> 
> > > So any comments?
> > 
> > Well, I think 2.13's a good idea, but it's very new.  I'd say that was
> > acceptable as long as you're looking at MIPS64 only, not at MIPS32. 
> 
> Such considerations have kept us back at antique levels of binutils.  And
> juggling with several different versions for userland, and two kernel
> flavours is evil ...

Please keep in mind that 2.13's been out for all of half a month now. 
Almost no one's using it yet for significant development... if you
decide to require it, we can cope, though.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
