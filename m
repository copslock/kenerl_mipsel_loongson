Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KEf5EC028292
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 07:41:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KEf4Qg028291
	for linux-mips-outgoing; Tue, 20 Aug 2002 07:41:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f39.dialo.tiscali.de [62.246.16.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KEesEC028282
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 07:40:58 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7KETxC31273;
	Tue, 20 Aug 2002 16:29:59 +0200
Date: Tue, 20 Aug 2002 16:29:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@oss.sgi.com
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: New binutils for kernel
Message-ID: <20020820162959.A26852@linux-mips.org>
References: <20020819171238.A7457@linux-mips.org> <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Aug 20, 2002 at 04:19:35PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 04:19:35PM +0200, Maciej W. Rozycki wrote:

> On Mon, 19 Aug 2002, Ralf Baechle wrote:
> 
> > >  Are you sure?  I believe the patch effectively forces everyone to use
> > > binutils 2.13 for mips64.  Is it really acceptable now? 
> > 
> > In the past week I ended up more and more kludging around binutils bugs.
> > We need something newer and distributions seem to be all at ~ 2.12 at least.
> 
>  While 2.12 may be OK from the file format point of view, there are
> serious bugs leading to bad code.  So bad the kernel doesn't work.  It's
> really 2.13 that is needed.  I have another less important fix that will
> hopefully go in to 2.13.1 and all gcc versions are broken without yet
> another fix (it bites in mm/mmap.c; not sure if fatally). 
> 
> > So I guess it's time to bite the bullet?
> 
>  Since I'm using 2.13 anyway, it's alike to me.  But it should be
> discussed at the list, IMO.

Yep.  It won't hurt most of us kernel hackers very much but in particular
the distribution people may want to comment.

So any comments?

  Ralf
