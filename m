Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2003 04:43:47 +0000 (GMT)
Received: from crack.them.org ([IPv6:::ffff:65.125.64.184]:61673 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225200AbTCHEnr>;
	Sat, 8 Mar 2003 04:43:47 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18rY4m-0000vZ-00; Sat, 08 Mar 2003 00:44:56 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18rWBQ-0001Dr-00; Fri, 07 Mar 2003 23:43:40 -0500
Date: Fri, 7 Mar 2003 23:43:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jeff Baitis <baitisj@evolution.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel Debugging on the DBAu1500
Message-ID: <20030308044340.GA4675@nevyn.them.org>
References: <20030306185345.W20129@luca.pas.lab> <1047043427.30914.432.camel@zeus.mvista.com> <1047043677.6389.436.camel@zeus.mvista.com> <20030307123637.Y20129@luca.pas.lab> <1047069561.6389.505.camel@zeus.mvista.com> <20030307162733.Z20129@luca.pas.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307162733.Z20129@luca.pas.lab>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2003 at 04:27:33PM -0800, Jeff Baitis wrote:
> Earlier I wrote:
> 
> > > Debugging seems to work great now! Thanks!
> 
> Well, not quite great. I've abandoned the old Monta Vista gdb-5.0 debugger
> since it's been segfaulting.

Wow, that's from a pretty old product...

> I've tried building cross-debuggers from the current gdb release (5.3) and
> from the March 3 CVS snapshot. Both lock up as soon as I 's'tep, just after
> the GDB stub. (./configure --target=mipsel).
> 
> Perhaps someone could suggest a version of GDB that I should be using?

Those should both work correctly; they do here.  Try configuring it for
the right target (mipsel-linux) and seeing if that helps?  I'd be
surprised if it made a difference though.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
