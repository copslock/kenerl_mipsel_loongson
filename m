Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PLOHq29449
	for linux-mips-outgoing; Mon, 25 Feb 2002 13:24:17 -0800
Received: from dea.linux-mips.net (a1as07-p84.stg.tli.de [195.252.188.84])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PLOC929446
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 13:24:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1PKNw906584;
	Mon, 25 Feb 2002 21:23:58 +0100
Date: Mon, 25 Feb 2002 21:23:58 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Hartvig Ekner <hartvige@mips.com>
Cc: Johannes Stezenbach <js@convergence.de>, linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020225212358.A4935@dea.linux-mips.net>
References: <20020225193928.A4385@dea.linux-mips.net> <200202251921.UAA27344@copsun18.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202251921.UAA27344@copsun18.mips.com>; from hartvige@mips.com on Mon, Feb 25, 2002 at 08:21:00PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 08:21:00PM +0100, Hartvig Ekner wrote:

> > > BTW: Who is "we"? Do you mean global data optimization is broken
> > > in gcc/binutils or just that no one at SGI is using it?
> > 
> > It's an ECOFF specific optimization that just has been forward ported into
> > the ELF world.  And what does this have to do with SGI anyway?
> 
> I still don't get it. Why would one not use GP optimization with non-shared
> non-PIC code? It certainly is used throughout in the non-Linux MIPS world,
> and on the limited testing I did today it also worked fine. Is there 
> something which is known not to work, or some conflict somewhere which
> prevents the general use of GP?

I thought gcc would would for no good reason plain refuse to use global
pointer optimization with ELF - but I was wrong, just tested it again.
I also noticed that older gcc would emit initialized data to .data with
-G even though small data should go to .sdata.

Won't work by just enabeling for the kernel though.  The kernel has it's
own idea of how to use the $gp register.

  Ralf
