Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KElYEC028599
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:47:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KElYmD028598
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:47:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KElSEC028589
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:47:28 -0700
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17hAKm-0005KB-00; Tue, 20 Aug 2002 09:50:16 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17hALL-0004Xw-00; Tue, 20 Aug 2002 10:50:51 -0400
Date: Tue, 20 Aug 2002 10:50:51 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@oss.sgi.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: New binutils for kernel
Message-ID: <20020820145051.GA17311@nevyn.them.org>
References: <20020819171238.A7457@linux-mips.org> <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl> <20020820162959.A26852@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820162959.A26852@linux-mips.org>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 04:29:59PM +0200, Ralf Baechle wrote:
> On Tue, Aug 20, 2002 at 04:19:35PM +0200, Maciej W. Rozycki wrote:
> 
> > On Mon, 19 Aug 2002, Ralf Baechle wrote:
> > 
> > > >  Are you sure?  I believe the patch effectively forces everyone to use
> > > > binutils 2.13 for mips64.  Is it really acceptable now? 
> > > 
> > > In the past week I ended up more and more kludging around binutils bugs.
> > > We need something newer and distributions seem to be all at ~ 2.12 at least.
> > 
> >  While 2.12 may be OK from the file format point of view, there are
> > serious bugs leading to bad code.  So bad the kernel doesn't work.  It's
> > really 2.13 that is needed.  I have another less important fix that will
> > hopefully go in to 2.13.1 and all gcc versions are broken without yet
> > another fix (it bites in mm/mmap.c; not sure if fatally). 
> > 
> > > So I guess it's time to bite the bullet?
> > 
> >  Since I'm using 2.13 anyway, it's alike to me.  But it should be
> > discussed at the list, IMO.
> 
> Yep.  It won't hurt most of us kernel hackers very much but in particular
> the distribution people may want to comment.
> 
> So any comments?

Well, I think 2.13's a good idea, but it's very new.  I'd say that was
acceptable as long as you're looking at MIPS64 only, not at MIPS32. 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
