Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56ISw510669
	for linux-mips-outgoing; Wed, 6 Jun 2001 11:28:58 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56ISuh10666
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 11:28:57 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06670
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 11:28:43 -0700 (PDT)
	mail_from (drow@nevyn.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 157hbP-00060j-00; Wed, 06 Jun 2001 11:00:19 -0700
Date: Wed, 6 Jun 2001 11:00:19 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010606110019.A23009@nevyn.them.org>
References: <20010606090816.C21351@lucon.org> <Pine.GSO.3.96.1010606193612.2113E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.3.96.1010606193612.2113E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 06, 2001 at 07:48:24PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 06, 2001 at 07:48:24PM +0200, Maciej W. Rozycki wrote:
> On Wed, 6 Jun 2001, H . J . Lu wrote:
> 
> > There are many changes in gdb, especially in thread and C++ supports.
> > We need those on mips also. I am willing to spend my time. But I need
> > some help. I don't know much about mips :-(.
> 
>  It would be nice to have at least basic C support in mainline. 
> 
> > I'd like to get gdb working first. Do you have time to answer some
> > questions?
> 
>  I often have time to write mails (but I don't have most of my development
> resources here).  Feel free to ask -- I'll try to answer as I can.  I
> haven't been into MIPS/Linux development tools for some time now, since
> they are mostly working for me, so my memory might be vague.  I'm working
> on the kernel mostly these days -- my primary goal is to find out why
> Linux crashes hard when building binutils natively on my DECstation (the
> progress is at a snail speed, unfortunately). 

I've actually spent this week porting the gdb CVS head to MIPS; I've
got it almost entirely working now.  There's one problem with SIGTRAP
that I haven't quite figured out yet, and thread attach isn't quite
working, and there's a kernel bug I've been repeatedly triggering that
I think I just fixed.  I anticipate it all being done in a couple of
days - I'll post here and on the GDB list when I have it in slightly
better shape.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
