Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62IsSRw010233
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 11:54:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62IsSwF010232
	for linux-mips-outgoing; Tue, 2 Jul 2002 11:54:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62IsNRw010212
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 11:54:23 -0700
Received: from [216.254.114.110] (helo=nevyn.them.org)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17PSqk-000640-00; Tue, 02 Jul 2002 13:58:07 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17PSqh-0001me-00; Tue, 02 Jul 2002 14:58:03 -0400
Date: Tue, 2 Jul 2002 14:58:03 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Greg Lindahl <lindahl@keyresearch.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS GOT overflow in gcc 3.2.
Message-ID: <20020702185803.GA6785@nevyn.them.org>
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com> <20020702114843.B1896@wumpus.internal.keyresearch.com> <20020702115525.A16419@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702115525.A16419@lucon.org>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 11:55:25AM -0700, H. J. Lu wrote:
> On Tue, Jul 02, 2002 at 11:48:43AM -0700, Greg Lindahl wrote:
> > > AFAIK it happens to mozilla as well.
> > 
> > On AlphaLinux, we eventually acquired multigot. Many large apps were
> > tripping on this problem; many big C++ programs essentially use
> > whole-program compilation, and many HPC codes link a bazillion large
> > libraries. I don't understand if -fpic or -fPIC are as good of a
> > solution as multigot.
> 
> FYI, it is -Wa,-xgot, not -fPIC. multigot may be better. But it is not
> supported on mips. Until someone adds it, it is not an option.

No, it's the difference between -fpic and -fPIC.  Also not yet
implemented.  I intend to implement multigot in a couple of months if
no one else bothers to first.

You can not link modules with different GOT models together last I
checked, HJ.  That means that if any static code from libgcc is used in
libjava you'll lose badly with -Wa,-xgot.  Ditto libc_nonshared.a.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
