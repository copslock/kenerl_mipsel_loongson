Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KF8NEC029901
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 08:08:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KF8NnT029900
	for linux-mips-outgoing; Tue, 20 Aug 2002 08:08:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KF8GEC029790
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 08:08:16 -0700
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17hAeq-0005Ma-00; Tue, 20 Aug 2002 10:11:00 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17hAfP-0006Qf-00; Tue, 20 Aug 2002 11:11:35 -0400
Date: Tue, 20 Aug 2002 11:11:35 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@oss.sgi.com
Subject: Re: New binutils for kernel
Message-ID: <20020820151135.GA23807@nevyn.them.org>
References: <20020820165835.B26852@linux-mips.org> <Pine.GSO.3.96.1020820170025.8700L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020820170025.8700L-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 05:08:20PM +0200, Maciej W. Rozycki wrote:
> On Tue, 20 Aug 2002, Ralf Baechle wrote:
> 
> > > Well, I think 2.13's a good idea, but it's very new.  I'd say that was
> > > acceptable as long as you're looking at MIPS64 only, not at MIPS32. 
> > 
> > Such considerations have kept us back at antique levels of binutils.  And
> > juggling with several different versions for userland, and two kernel
> > flavours is evil ...
> 
>  Any version since 2.11, possibly older, should work just fine for 32-bit
> MIPS.  I don't think there are any significant interface changes between
> 2.11 and 2.13, so if 2.13 works then 2.11 will not bail out either.  Thus
> there is no need to force 2.13 for 32-bit MIPS, but I think it is
> acceptable to stop caring about versions older than 2.11 in the nearby
> future.

Sure.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
