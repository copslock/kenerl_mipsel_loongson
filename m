Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PLnjN14331
	for linux-mips-outgoing; Fri, 25 May 2001 14:49:45 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PLniF14328
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 14:49:44 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 153PSj-0007No-00; Fri, 25 May 2001 14:49:37 -0700
Date: Fri, 25 May 2001 14:49:37 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Message-ID: <20010525144937.A28370@nevyn.them.org>
References: <Pine.GSO.3.96.1010525130531.17652A-100000@delta.ds2.pg.gda.pl> <011801c0e55f$e4d39820$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <011801c0e55f$e4d39820$0deca8c0@Ulysses>; from kevink@mips.com on Fri, May 25, 2001 at 11:15:48PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 25, 2001 at 11:15:48PM +0200, Kevin D. Kissell wrote:
> >  The following program cannot be compiled with gcc 2.95.3, because the
> > offset is out of range (I consider it a bug in gcc -- it should allocate
> > and load a temporary register itself and pass it appropriately as %0,
> 
> I think gcc can be forgiven for not allocating a temporary,
> given the ".set noat"...

Except, of course, gcc doesn't even know the set noat is there.  It
doesn't parse the interior of asm() statements.

> 
> > matching the "R" constraint; still it's better than generating bad code):
> >
> > int main(void)
> > {
> > int *p;
> >
> > asm volatile(".set push\n\t"
> >   ".set noat\n\t"
> > "lw $0,%0\n\t"
> > ".set pop"
> > :
> > : "R" (p[0x10000]));
> >
> > return 0;
> > }
> 
> 
> 

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
