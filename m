Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62IsxRw010391
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 11:54:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62Isx24010390
	for linux-mips-outgoing; Tue, 2 Jul 2002 11:54:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62IstRw010364
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 11:54:55 -0700
Received: from [216.254.114.110] (helo=nevyn.them.org)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17PSrP-000649-00; Tue, 02 Jul 2002 13:58:48 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17PSrR-0001mi-00; Tue, 02 Jul 2002 14:58:49 -0400
Date: Tue, 2 Jul 2002 14:58:48 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Eric Christopher <echristo@redhat.com>, bkoz@redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: Kernel ll/sc emulation?
Message-ID: <20020702185848.GB6785@nevyn.them.org>
References: <1025548213.1438.7.camel@ghostwheel.cygnus.com> <20020701122313.35d7dd56.bkoz@redhat.com> <1025562305.28484.1.camel@ghostwheel.cygnus.com> <20020701153438.A31602@lucon.org> <1025568244.30577.16.camel@ghostwheel.cygnus.com> <20020701182418.A1600@lucon.org> <1025574335.30581.44.camel@ghostwheel.cygnus.com> <20020701185158.A2134@lucon.org> <1025574717.30577.48.camel@ghostwheel.cygnus.com> <20020701192415.A2617@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020701192415.A2617@lucon.org>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 01, 2002 at 07:24:15PM -0700, H. J. Lu wrote:
> On Mon, Jul 01, 2002 at 06:51:57PM -0700, Eric Christopher wrote:
> > 
> > > What do you meant by "it'll be emulated if it fails"? I didn't see any
> > > ll/sc emulation in the Linux mips kernel. If you use ll/sc on CPU which
> > > doesn't implement ll/sc, your binary will just dump core.
> > 
> > The kernel should trap and emulate the instruction at that point, at
> > least as far as I've been told.
> > 
> 
> That is a news to me. I couldn't find it anywhere in the Linux mips
> kernel. Could someone point me to the right place in the Linux mips
> kernel source tree?

Early 2.4; after 2.4.2 but before 2.4.9 or so.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
