Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TMjNnC003691
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 15:45:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TMjNwS003690
	for linux-mips-outgoing; Wed, 29 May 2002 15:45:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TMjDnC003687
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 15:45:19 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4TMkOH02431;
	Wed, 29 May 2002 15:46:24 -0700
Date: Wed, 29 May 2002 15:46:24 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Justin Carlson <justinca@cs.cmu.edu>, linux-mips@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
Message-ID: <20020529154624.A2409@dea.linux-mips.net>
References: <20020529143305.D888@dea.linux-mips.net> <Pine.GSO.3.96.1020529234323.17584P-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020529234323.17584P-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, May 29, 2002 at 11:46:58PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 11:46:58PM +0200, Maciej W. Rozycki wrote:

> > >  I converted a few flush_cache_all() invocations to __flush_cache_all() 
> > > where appropriate late last year, but the function is a bit older.  I
> > > think you might dig the linux-kernel list archives for a discussion on the
> > > semantics of flush_cache_all() (it's a nop for many MIPS CPUs) and
> > > friends.  The short description in Documentation/cachetlb.txt is a bit
> > > insufficient, I'm afraid. 
> > 
> > I don't like that function very much; it's sort of a shotgun approach
> > to flushing caches in a part of the kernel that's not too performance
> > relevant.  The whole interface sucks, should be replaced by something
> > more finegrained.
> 
>  Well, I suspect the API might be somewhat influenced by SPARC's oddities. 
> ;-) 

Historically that's certainly true.

As a general complaint about the style of interfaces of the cache stuff -
they're too low level.  Frequently we just don't know enough about the
situation to optimize the flush operation.

  Ralf
