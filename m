Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57JSBO08800
	for linux-mips-outgoing; Thu, 7 Jun 2001 12:28:11 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57JSAh08796
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:28:10 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA04848
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:28:09 -0700 (PDT)
	mail_from (drow@nevyn.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 1585Hp-0006Hp-00; Thu, 07 Jun 2001 12:17:41 -0700
Date: Thu, 7 Jun 2001 12:17:41 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010607121741.A24155@nevyn.them.org>
References: <20010606132402.A27901@nevyn.them.org> <Pine.GSO.3.96.1010607123246.4624B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.3.96.1010607123246.4624B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jun 07, 2001 at 12:37:27PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 07, 2001 at 12:37:27PM +0200, Maciej W. Rozycki wrote:
> On Wed, 6 Jun 2001, Daniel Jacobowitz wrote:
> 
> > >  Make sure your kernel is flushing the icache right. 
> > 
> > Hmm, thanks, I'll check.  I don't think that's it, though.
> 
>  This happened to me once.  Otherwise, it looks like gdb doesn't recognize
> a breakpoint for some reason -- possibly it places it at a wrong address. 
> It shouldn't be difficult to debug -- you get information of the address
> the trap happened. 

Wouldn't you hope?  No such luck.

Program received signal SIGTRAP, Trace/breakpoint trap.
[Switching to Thread 1024 (LWP 89)]
0x00000000 in ?? ()

I blame the threads handling, which I'm only about half through
debugging.

> > Nope.  It's based mostly on the same 4.17 patch from David Miller, and
> > some bits from Ralf, all marked as assigned to the FSF (though I'm not
> > sure if that ever actually happened); I'll straighten out copyright
> > once I've got the whole thing done.
> 
>  You need to contact David, then.

Yep, I'm going to do that.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
