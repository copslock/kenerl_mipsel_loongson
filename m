Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57Jq5j12353
	for linux-mips-outgoing; Thu, 7 Jun 2001 12:52:05 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57Jq4h12342
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:52:04 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA03816
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:51:59 -0700 (PDT)
	mail_from (drow@nevyn.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 1585fE-0006d6-00; Thu, 07 Jun 2001 12:41:52 -0700
Date: Thu, 7 Jun 2001 12:41:52 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010607124152.A25474@nevyn.them.org>
References: <20010607121741.A24155@nevyn.them.org> <Pine.GSO.3.96.1010607213008.16852F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.3.96.1010607213008.16852F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jun 07, 2001 at 09:35:57PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 07, 2001 at 09:35:57PM +0200, Maciej W. Rozycki wrote:
> On Thu, 7 Jun 2001, Daniel Jacobowitz wrote:
> 
> > >  This happened to me once.  Otherwise, it looks like gdb doesn't recognize
> > > a breakpoint for some reason -- possibly it places it at a wrong address. 
> > > It shouldn't be difficult to debug -- you get information of the address
> > > the trap happened. 
> > 
> > Wouldn't you hope?  No such luck.
> > 
> > Program received signal SIGTRAP, Trace/breakpoint trap.
> > [Switching to Thread 1024 (LWP 89)]
> > 0x00000000 in ?? ()
> 
>  Then patch your kernel to display the address.  It's trivial.  See
> do_bp() in arch/mips/kernel/traps.c. 

Good idea.  Thanks.

> > I blame the threads handling, which I'm only about half through
> > debugging.
> 
>  Ah, threads...  They might be completely non-fuctional on MIPS/Linux. 
> I've never run threaded programs on MIPS/Linux, but such trivial users as
> ls appear to work.

They work, with a couple of kernel patches and a couple of library
patches.  I'm sorting through them right now.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
